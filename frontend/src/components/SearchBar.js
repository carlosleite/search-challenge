import { GOOGLE_ENGINE, BING_ENGINE } from '../lib/constants';
import React, { useState } from 'react';
import useReduxDispatch from '../actions';
import searchIcon from '../assets/icon-search.svg';

function SearchBar() {
  const { fetchResultsForState } = useReduxDispatch();
  const [engine, changeEngine] = useState('');
  const [text, changeText] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    fetchResultsForState({ engine, text });
  };

  return (
    <header className="search-app__header">
      <form onSubmit={(e) => handleSubmit(e)}>
        <select onChange={(e) => changeEngine(e.target.value)}>
          <option value="all">Both Engines</option>
          <option value={GOOGLE_ENGINE}>Google</option>
          <option value={BING_ENGINE}>Bing</option>
        </select>
        <input placeholder="Type your search..."
               value={text}
               onChange={(e) => changeText(e.target.value)} />
        <button type="submit">
          <img src={searchIcon} alt="Search icon" />
        </button>
      </form>
    </header>
  );
}

export default SearchBar;
