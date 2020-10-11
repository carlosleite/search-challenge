import { RESULTS_LOADED, LOAD_RESULTS } from '../lib/constants';
import { useDispatch } from 'react-redux';
import { get } from 'axios';

const API_URL = process.env.REACT_APP_API_URL;

export const fetchResults = (params) => (dispatch) => {
  dispatch(loadResults());
  get(`${API_URL}/search`, { params: params })
    .then((response) => {
      dispatch(resultsLoaded({ success: true, results: response.data.results }));
    })
    .catch((error) => {
      console.error(error);
      dispatch(resultsLoaded({ success: false, results: [] }));
    });
};

export const loadResults = () => ({ type: LOAD_RESULTS });

export const resultsLoaded = (data) => {
  return {
    type: RESULTS_LOADED,
    data
  }
};

const useReduxDispatch = () => {
  const dispatch = useDispatch();

  const resultsLoadedToReduxState = (results) => {
    dispatch(resultsLoaded(results));
  };

  const fetchResultsForState = (params) => {
    dispatch(fetchResults(params));
  };

  return { resultsLoadedToReduxState, fetchResultsForState };
};

export default useReduxDispatch;