import { GOOGLE_ENGINE, BING_ENGINE } from '../lib/constants';
import React from 'react';
import googleLogo from '../assets/logo-google.svg';
import bingLogo from '../assets/logo-bing.svg';
import useReduxState from '../selectors';

function SearchResults() {

  const { results, fetchingResults, errorFetching } = useReduxState();

  const engineLogo = (engine) => {
    if (engine === GOOGLE_ENGINE) {
      return googleLogo;
    } else if (engine === BING_ENGINE) {
      return bingLogo;
    }
  }

  if (fetchingResults) {
    return <div className="loader"></div>;
  }

  if (errorFetching) {
    return <div className="error"><h3>There was an error on loading the results</h3></div>;
  }

  return (
    <section className="search-app__results">
      <ul>
        {results.map((result, index) => (
          <li key={index}>
            <a href={result.url} target="_blank" rel="noopener noreferrer">
              <img src={engineLogo(result.engine)} alt="Engine logo" />
              <div className="search-app__result-info">
                <h3>{result.title}</h3>
                <p>{result.description}</p>
              </div>
            </a>
          </li>
        ))}
      </ul>
    </section>
  );
}

export default SearchResults;
