import { RESULTS_LOADED, LOAD_RESULTS } from '../lib/constants';

const initialState = {
  results: [],
  fetchingResults: false,
  errorFetching: false
};

const rootReducer = (state = initialState, action) => {
  switch (action.type) {
    case LOAD_RESULTS:
      return {
        ...state,
        results: [],
        errorFetching: false,
        fetchingResults: true
      }
    case RESULTS_LOADED:
      return {
        ...state,
        errorFetching: !action.data.success,
        results: action.data.results,
        fetchingResults: false
      }
    default:
      return state;
  }
};

export default rootReducer;