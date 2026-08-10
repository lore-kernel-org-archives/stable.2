Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4A377AAE;
	Mon, 10 Aug 2026 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343396; cv=fail; b=dcTMA8Z8fEG/1FmBWgzxGxY2C+ffA96PDOb67LCYyjaKrJsi4nhVimZXAbFuG2PQM2GjnNSL60AeJCQCZ8+155tD8gej4OFPuDs39iGGOpozGtOsHH4mAXohxMA2pJBB0PSmeLMOgfZ46opq+VUOaCwC/htDZkQH5WsKX0GiLjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343396; c=relaxed/simple;
	bh=hQwEyp6YLJtsZMg/7eqPa1OA3PFGDBScYCY2mEYnOBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pbAoM0DjPvu4DjbljD5nS4d+sB1snL0y9FsQh+pXStYLznJoKYZxu35pnwm4D4RsL+9L+6KuONiVmDhW8meSpFIYr93joDNff30h/nLguWEteIaO6qTys9ooKREWpJY+nRfCR8ekpA2ZCJHNDhJd55EJsejbZn7Q2n72wGnx0fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKo6+IL2; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKo6+IL2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786343394; x=1817879394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hQwEyp6YLJtsZMg/7eqPa1OA3PFGDBScYCY2mEYnOBY=;
  b=OKo6+IL2VXMXcxM3ZUhAn1njRKMn3UM9LIwH6fv3XxvR7tpo8oyGY6Al
   KaP+jE8ryVKrjm2iT2sNJhIVDEx+Fb7+kgofFJbKq04pSCk95iPe7GzuB
   tiYTOH60COeVUCIZTiIEfr0GLfdr6zQ+aGsi6RijUqm3//hqFbbK58U6C
   TegogoWFq0JxOrhxMCwaRo1WjInrY2dbPhZXUlPDvQ+nul9DpnMhwJdb8
   cVyLnKDRKdvIwtkzMEsYCc+MHMRN7XnrkiU5RxKm/J5wktothix4PqG5g
   kFj7RUBww5es4S/xRLbC9ieR1zv0jILFy8FxDzkz9pIdxIAb3A0irGerx
   Q==;
X-CSE-ConnectionGUID: PM2RrMF7QiaqHC4CavHoyA==
X-CSE-MsgGUID: sv0LtJYvRjGx5r37I05AdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="85967519"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="85967519"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 23:29:38 -0700
X-CSE-ConnectionGUID: 2L0voFo+SWeMLmXKN7dGYA==
X-CSE-MsgGUID: Aim7QVpMTNWGqIEXmQe9UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="262433398"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 23:29:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 23:29:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 23:29:33 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 23:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag4xIKSE7YvknbbNaPAjkIe/Qfbo2MMOqjzZ/EI/H0FrZap8p2SbYszPp5Db7iRaBiv5/BxSL2mdvbKQJNzuFkT8fvq+SqbpAJcLuceTmyYNat7lEJjYcnFXDbdwOCO+A2WxdgoeRtacPwTXqWzDeEle2+fvweUThylCcM+Nz6HoUFIahIYi+avnN99SB7Yf8UgFoR9iI65LBgOEiAIre4CpL5IMMMiDIOFCrNwqSsQdph1xGfH5JNAQxFm7w2bnG6p26Az8wYkxLX8EU4XA5j2nrPfcnt0pQT9TTBf+zN/CFR4MkQMqk/gg9ZMsYjVy4b/2JgIvxu8KjvLh5BuelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzJ/HnR/oDfzB5sdw131chrrrAtxdJ0jkdO9LDeI1i4=;
 b=rCXyITu6hRmJkAsB/13sj8Vgc/pJlBECNCCtdaq/wOnZojy4WcRpR2+EROy0dxZMQQqGPuWk2Opo4zrke08FQ7DeRHU0GdthXlHS6pkPz0lInnh45GzTk63VzD2dSC9zCXPOmIpCwhldwAAVBn3a/9qTsi+yXXcMduBxkwvTHUDOHCm6W4MiO4YwzB6QvqkNa9D3rsRF+trsxpjTFz/6J+ORybDqgM05LELsfbbfKeSrpiQ402LrB+cKSB0eu96cGVaWgCs6kTZE9/7nDbIKvdK29Hlrt+fpEODccDfmJwyGL8fzHhC6kMlHjC7qFcZSdpO7fY35BsBamnKDJfWI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:29:30 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:29:30 +0000
From: "Xu, Even" <even.xu@intel.com>
To: HyeongJun An <sammiee5311@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	"Sun, Xinpeng" <xinpeng.sun@intel.com>
CC: Benjamin Tissoires <bentiss@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Sashiko AI <sashiko-bot@kernel.org>
Subject: RE: [PATCH v3] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT
 response to the caller buffer
Thread-Topic: [PATCH v3] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT
 response to the caller buffer
Thread-Index: AQHdJbPN7zrv318gHkSzMHzoEcGWBbaW1xwQ
Date: Mon, 10 Aug 2026 06:29:30 +0000
Message-ID: <IA1PR11MB6098C6AAD23AC33281FFD6D6F4DE2@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260806142321.3383353-1-sammiee5311@gmail.com>
 <20260806145619.3386809-1-sammiee5311@gmail.com>
In-Reply-To: <20260806145619.3386809-1-sammiee5311@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH8PR11MB7989:EE_
x-ms-office365-filtering-correlation-id: 62a03dfb-451b-4c23-7bd2-08def6a8bc0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|56012099006|11063799006|3023799007|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info: 28iBhNMN4d6l9hsveGBf0hfbbl12TZPKAUasaTFXFvB3gWaNQATCjsSJmeuG0D0/SIY+/WU4lSvPWDaNDVpVDBiJdBTgoDou0wkOfGkZCGG4q5BmyvPFndiehD3EX7NOJ0b2PuuXYEpoT7HsdMer3M2HLBVfKgLfqhxjgwxISzIy6bwBjaPic43IhpSksF2OAW3/9R67gfm6xy/7ksBr07zx0KTR6yV1Wx98RGQ1vy20RVVD/RK60bWRDl1oulkL41lJ32syfluYOn0TpKWKvy86ehjoir1RIjxspgStQebP7CnN85uQbrToKRS/oio60GNFR35bYt1OwIGn4Kjm3aR3YxJtweBY+Zo//GEzhvobsmBf83aPUXVrUcLEGAw9KNP4imkYHZ4w18woqQnWkq+elg9K90e4hm0bt0zfNEDqTBlu8fFxI9NAtDzdCHjDP5cViaIHzy9sd1S5rw8M9iF8BFi6C//G3vQcPKSSnfPRS+iUm/17Xt28XZFgBvMnlIfEmFoYGTC4/OP1vy8und46SclAP6Xqk5fATkzrVFicg+1Ninmeb9MG5T3TGcI+qlhZ8dXFoQN5E0v8UB03xJrW4lmImz94Dd82ZrBhdFb7Fgoygx0Ye4SSpwnjkXZK97w8LDajq4XedNnrYkX893wdGQTNT9IGd0dcZaIiVG+AmThsUk1q6U1E83J3ahPqMpdesG5doSFT61UwDBLF5ipZFlGElbOAdXa1f0kIAEw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(38070700021)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pi/jka+2r6X0ABzywxRxsy55Tz/Qq9OtWU0nnn6SBryQNGXyQpZ4q82G2lzA?=
 =?us-ascii?Q?mYJ6gaqNRU25zRyHC3bEB87oyCMkE0h9lifMi6OmBCdypsdJB5mONZmFSK7G?=
 =?us-ascii?Q?jmKFr6oXgrSdH+IWEEjzDpUBULI8eFb7AGFIavktxbNJwjVjZZlrwzZs6/lK?=
 =?us-ascii?Q?SL2qj/dSHLzmp2YGSHhetGiHWfkGHG55noyhJxudh9OjTpjqa3EtvcX1qhSg?=
 =?us-ascii?Q?Zb2xn3ToCU4bMZbF8MDMY362XzZsgrFb5HGTLSGqz1qVv5wL9miNb8xbjFzu?=
 =?us-ascii?Q?fnX/zu8wRXiRypGICyoBvRRB6niyn5HA0VbdSVd0AuI5IGbGgLB3N5KkjBd7?=
 =?us-ascii?Q?QMWp+DEX1xaY/0cq+ren9yeDVqCnpHtDgvdcXXso/ALuwff4AnwOdJbz1s52?=
 =?us-ascii?Q?ABiHYHmeRtugP/dJHfRqmlaBBMHk4bxGt6p7si3ve8gJ4uoSHLSdg30gvOl9?=
 =?us-ascii?Q?1ZJ3bvNzW+u7ZgJtK0zuW52OuqkgLS50y2HyfRydtWQza8z1CSwQsj5UhJnq?=
 =?us-ascii?Q?UYdnQLipS4y4lBDAsiZIxahwJCawfcRI/swabcPxWb6qXVJQPf2SnikETUUt?=
 =?us-ascii?Q?AeouUteEatppXZ6vvPrboKR4Gs3fWaFqfxd+feZ+3dboCxsdtewzSzBs1JJv?=
 =?us-ascii?Q?HC6u9C01jbSrpDCQir6k00BywFQSVgvsBg/EYxRwbSPtY66dxagR7JtUiacj?=
 =?us-ascii?Q?y6oOBjWvFAWTxGHbIbGfRt5BA1m8LtsPh9vzr5uRt5F6tDrpcT0kYneFT7eg?=
 =?us-ascii?Q?bsz7Tm3rOM1yshks6sKFRZlQyb2Je64MvO2nzy3HXHVcZbRMaTkj9SXcS+ef?=
 =?us-ascii?Q?tN2NYddZORfORTHlQfn++m+3jzJauYgGAbHfs7I2gLxyYGcmov1CBmC4lzG8?=
 =?us-ascii?Q?4i+Kd6xDPpuTos8GIu5NiUvv5szkMzYOuV5fQFLXWrHQh2HPOMrWcDplUAle?=
 =?us-ascii?Q?E/6o/aeSEh+zATDNqP0mw3YLygZOuCKrdMfq2z6/xL9SdgbK2kljRpKA7UVZ?=
 =?us-ascii?Q?LIQv2zMzmBul8lqtRJZt1GS/jYjvti5zeKJvTMHx4WC9G1kHHAUXRvGjCjcC?=
 =?us-ascii?Q?JhgbJJ7NDdFhUQbtChfJ9GT7NTrQL/z3jOMcoMwBE2UJ73bs5UcdygywVLwR?=
 =?us-ascii?Q?Thtj/CFA9TKEnARd7COwIz8duSb7av3Kts2UbmxgjfEuDXY3mjQVI2iaTq79?=
 =?us-ascii?Q?bBBY+x93Fcw+8t86us74WItIuRmfw8zsaYKhV4HVIDNxUr+XXXzd0nuk2GnS?=
 =?us-ascii?Q?/Po7y8N5YzlSNq+zLplQmrwUgs+Qli2Y4e3qleIwvA9WfudxcQuuwKFvwxVz?=
 =?us-ascii?Q?bDzeAbRqgv4uAbqzWsKvXAeTX/ic6ac4v2IjFfSTq+ZK1iSSUPb8xbcQwSRs?=
 =?us-ascii?Q?6SsbUI7gjtayDl38rN6SI1vLidNpemPp60hMHy70fDJ2bqPa6KH1t8TDkcEW?=
 =?us-ascii?Q?FVBxJy7kTwalDuupt1FdHvAdPN/pCiZDJ3rGZi+DZY563w/apijTpOWibGFU?=
 =?us-ascii?Q?WrZFyZWvteHw5N6DLwj1jC+uXgufkyutJ5a5Za7SC4INV1xTwSY4O3x/KWrg?=
 =?us-ascii?Q?UZWUescsxGp3HESpAIU6+dM6k4oFDaJCX2oBtYKrFxIDi1k0+GYRseeExnP/?=
 =?us-ascii?Q?b/0wYpPj8nol0LQ0nlyheQRlo+Oek/gtv6BsArSkQvO9fnvowrJUDZlPOM+H?=
 =?us-ascii?Q?PNxyb+ZRayzSxmpaLbWP6TS1gC6SWMSV0J34vgAzEz+D/6Fn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ty7gCe1WUYEF4vd7toV2za50HEqcNOuIjbn4wh/F7un1vGLSLA0sPK6WGn8nmuALJUdgrFcyTJ76sN9guBWGlyivRqTcTUZ8kA+zZmtuBv086Xhdfom5EvTGKKNiA7DLaMD26ZX9NLM5B6/JlMzGN13ixc3QL2lstXU4ZVJmAUwAOT7UiGcOr9IMw40xQ2mxZeZogoG1NkG4FZXfh428ULysDObFgWYrplUzzfIP/WoacBolp+Z83WfhnCJ/v7dDF6WRCZmn/xrO3oe5FkCRsnB8yfm41dcFpiVStNA9odmZ8Qil4p/8NRX/3AbxTkRV7eGpsY+Pna/nR6pFAgHt6A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a03dfb-451b-4c23-7bd2-08def6a8bc0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 06:29:30.2127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16quwqUniYQ5OyOpjKSJvgm9ZDOxy6vqTVAUF9wLd+rZ6fGWeZvDWlADayKqOyFR/OdUJ4+anLYHteZhVBW1LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7989
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: HyeongJun An <sammiee5311@gmail.com>
> Sent: Thursday, August 6, 2026 10:56 PM
> To: Jiri Kosina <jikos@kernel.org>; Xu, Even <even.xu@intel.com>; Sun, Xi=
npeng
> <xinpeng.sun@intel.com>
> Cc: Benjamin Tissoires <bentiss@kernel.org>; linux-input@vger.kernel.org;=
 linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; HyeongJun An
> <sammiee5311@gmail.com>; Sashiko AI <sashiko-bot@kernel.org>
> Subject: [PATCH v3] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT
> response to the caller buffer
>=20
> quickspi_hid_raw_request() receives the caller's buffer length in len, bu=
t
> quickspi_get_report() never sees it and copies the whole device-supplied
> response into buf regardless:
>=20
>     memcpy(buf, qsdev->report_buf, qsdev->report_len);
>=20
> qsdev->report_len comes from the input report the touch controller
> qsdev->returns,
> while buf is sized to whatever the caller asked hidraw for through
> HIDIOCGFEATURE or HIDIOCGINPUT.  A response larger than that overflows bu=
f
> with device-controlled content.
>=20
> The intel-quicki2c sibling already passes the caller length down to
> quicki2c_get_report() and validates the response against it before the co=
py.  Do
> the same here.
>=20
> Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC Qu=
ickSPI
> driver")
> Suggested-by: Sashiko AI <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> ---
> v3: added READ_ONCE() around the qsdev->report_len read the v2 bound uses=
 -
>     quickspi_handle_input_data() writes this field from IRQ context with =
no
>     locking, so per kernel convention for a lockless shared read it needs
>     READ_ONCE() regardless of how many times the value is used afterward.
>     Raised by the Sashiko AI review of v2.  No other change.
>=20
> v2: fixed a Time-of-Check-to-Time-of-Use race the Sashiko AI review of v1
>     pointed out - the new bound read qsdev->report_len once for the check
>     and again for the memcpy, so a concurrent update between the two coul=
d
>     have overflowed buf with the checked-against-a-smaller-value length.
>     Read it once into a local and use that for both.
>=20
> v1: https://lore.kernel.org/all/20260806133838.3378362-1-
> sammiee5311@gmail.com/
>=20
>  .../intel-thc-hid/intel-quickspi/quickspi-hid.c  |  2 +-
>  .../intel-quickspi/quickspi-protocol.c           | 16 +++++++++++++---
>  .../intel-quickspi/quickspi-protocol.h           |  2 +-
>  3 files changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> index 91d5807b4a83..a60a0a7f16aa 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> @@ -61,7 +61,7 @@ static int quickspi_hid_raw_request(struct hid_device *=
hid,
>=20
>  	switch (reqtype) {
>  	case HID_REQ_GET_REPORT:
> -		ret =3D quickspi_get_report(qsdev, rtype, reportnum, buf);
> +		ret =3D quickspi_get_report(qsdev, rtype, reportnum, buf, len);
>  		break;
>  	case HID_REQ_SET_REPORT:
>  		ret =3D quickspi_set_report(qsdev, rtype, reportnum, buf, len); diff -
> -git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index cb19057f1191..9dacfdf7aff6 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> @@ -342,10 +342,12 @@ int reset_tic(struct quickspi_device *qsdev)  }
>=20
>  int quickspi_get_report(struct quickspi_device *qsdev,
> -			u8 report_type, unsigned int report_id, void *buf)
> +			u8 report_type, unsigned int report_id, void *buf,
> +			u32 buf_len)
>  {
>  	int rep_type;
>  	int ret;
> +	u32 report_len;
>=20
>  	if (report_type =3D=3D HID_INPUT_REPORT) {
>  		rep_type =3D GET_INPUT_REPORT;
> @@ -372,9 +374,17 @@ int quickspi_get_report(struct quickspi_device *qsde=
v,
>  	}
>  	qsdev->get_report_cmpl =3D false;
>=20
> -	memcpy(buf, qsdev->report_buf, qsdev->report_len);
> +	/* quickspi_handle_input_data() updates this from IRQ context. */
> +	report_len =3D READ_ONCE(qsdev->report_len);
> +	if (report_len > buf_len) {
> +		dev_err_once(qsdev->dev, "Get report response too big, %u
> vs %u\n",
> +			     report_len, buf_len);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(buf, qsdev->report_buf, report_len);
>=20
> -	return qsdev->report_len;
> +	return report_len;
>  }
>=20
>  int quickspi_set_report(struct quickspi_device *qsdev, diff --git
> a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h b/drivers/=
hid/intel-
> thc-hid/intel-quickspi/quickspi-protocol.h
> index 775e29c1ed13..8a2338bee808 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
> @@ -12,7 +12,7 @@ struct quickspi_device;
>=20
>  void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_l=
en);
> int quickspi_get_report(struct quickspi_device *qsdev, u8 report_type,
> -			unsigned int report_id, void *buf);
> +			unsigned int report_id, void *buf, u32 buf_len);
>  int quickspi_set_report(struct quickspi_device *qsdev, u8 report_type,
>  			unsigned int report_id, void *buf, u32 buf_len);  int
> quickspi_get_report_descriptor(struct quickspi_device *qsdev);

Thanks for the patch!
This is a good error handling for unexpected big receive buffer.

Reviewed-by: Even Xu <even.xu@intel.com>

> --
> 2.43.0

