{
  id: 'machine',
  initial: 'warten_auf_artist',
  states: {
    warten_auf_artist: {
      on: {
        DECLINE: 'kaufanfrage_ablehnen',
      },
    },
    kaufanfrage_ablehnen: {
      type: 'parallel',
      states: {
        internal: {
          initial: 'kaufanfrage_stornieren',
          states: {
            kaufanfrage_stornieren: {
              on: {
                DB_DONE: 'kaufanfrage_storniert',
              },
            },
            kaufanfrage_storniert: { type: 'final' },
          },
        },
        external: {
          initial: 'artwork_aus_shop_nehmen',
          states: {
            artwork_aus_shop_nehmen: {
              on: {
                HTTP_DONE: 'artwork_nicht_mehr_in_shop',
              },
            },
            artwork_nicht_mehr_in_shop: { type: 'final' },
          },
        },
      },
      onDone: 'kaufanfrage_abgelehnt',
    },
    kaufanfrage_abgelehnt: {},
  }
}
