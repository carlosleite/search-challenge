import { useSelector } from 'react-redux'

const useReduxState = () => {
  const results = useSelector((state) => state.results);
  const fetchingResults = useSelector((state) => state.fetchingResults);
  const errorFetching = useSelector((state) => state.errorFetching);

  return { results, fetchingResults, errorFetching };
}

export default useReduxState;