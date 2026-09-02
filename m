Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C931A6803
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788326404; cv=fail; b=RgCD5+W60tVNpKe9RHAQLOba3+R6L2xWdKDxLukBvkyyLiFNvkEiFMfH4G6iEBqfV+BqwQbqAc9SE7ZfJxSFuL4Es/lKhrZXRgIGtHEGWGZApVOcMViDxB+4Le1MybElkVgpoz9YzYCMPwJ7A81m7onMgvl6ynZABTJPTA4L3Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788326404; c=relaxed/simple;
	bh=F+Q+3cLV2UZXN+PqCZ6hnLr69mXJMYI1NOVFLGAe/ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nY1rozzOTPa7eMFyj4JYR0o5oZSGvJWjpCXYURGIyLq93lETeUpQnOmNoYbjb7l8+sUxhiYlnjb3rXD+wxSxTCkPpckhsRsLLkZGmqG1IlCSYcwWaWcfDgaatX9JN1MDNfFU9u2W1UTw+Nuzc8aFN3m2vkiZfFDnBZJSQZT5r4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ou6W6+DT; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ou6W6+DT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788326401; x=1819862401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F+Q+3cLV2UZXN+PqCZ6hnLr69mXJMYI1NOVFLGAe/ug=;
  b=Ou6W6+DT9UEt/94E2nFsLBf24oGTCQVOwgQCiP5LIwry6xNBYEpZY9Kd
   RxoWBiiTMCz559ApFKe+DiVU/x5LEz+vEdnYNe+H2YAFQZHAKk/sOhDGa
   DFwRX43bV1pVVq4fYs0z3NXErufwJGCQZ1nsv2116/83t6NHxXb04HKJ9
   OGUMt7bDJuqMkY5EnKyZkL47QGWTuXpwtPGP0eQKTggnOj70ioAl2p5Xm
   RkfHiQv35YHNScky4rmGoVnf6Inu0DPliL9iUMcE7uwJjnT7bsiHAUoqr
   DQ3NTV591+fHjA23rBKQG8HZdxrb41ev6reWQQKto0ZotHzLLsoIRwpzm
   w==;
X-CSE-ConnectionGUID: kCkJJ8xlRKCvn1UGUpBXMg==
X-CSE-MsgGUID: y59fFB9TTLqzncsXm0sZ6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88621948"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88621948"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 22:20:00 -0700
X-CSE-ConnectionGUID: V3/958BmQ1GitvByOs/a4A==
X-CSE-MsgGUID: gE1Ex+UqRmmjW3WAeqxXZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="273492088"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 22:20:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:19:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 22:19:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:19:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGwUoA5//9AHGvpLiDiy4cRSYh+MAeMZEIsnOUXxAupQlDmHS8TyVE/cLTPKpo7MgTPUwxgPnChvl1ORkUPgkac1I4l/Nsq+NCzMTDv4LUfBcd7TU5NDFcIySUwtFsOBDDWavy2/aiw4td8kWyIe/eUmuHjedVxJD53f8BqUoJ/BzurrlKsMecKezD3vhLzALKAFF2VW3MKtZblO5w8c/Z6mm2eiG8ENemsvU9HYLMZtqbfFY8dR32m7OcuprgcECk4emZGyiH+YjEBUd5X3P19aGHTxq5i628uuQxDKzFQSXNDaumJ+LhfrsQeK/r6YprKUpauwdOep6Gxm/HI67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+Q+3cLV2UZXN+PqCZ6hnLr69mXJMYI1NOVFLGAe/ug=;
 b=s2/UFuDiDaNxdOa3xne1R8uu1hDul7ZjwGr458ms0pbi9gpe70wXeDeWhGR+Bdz3IFZqDzhoQSlOcYbPEjitJrre8RwyxOVPKtwyGMbfXmBrpzUzbkNsTm2moGcIfZODe6sQ77tF4GSoF0+pggH46qcGntHMnyl9E3rKup4z7ZrLNQs6rJcRCY4OgCCvCkdXc/L7QTHRIpjIleO3ohJYMt24/aeDLPSTkK9xo7FvT3U1RYUSGUBbdeacIw0GHaX1ZcNa1mLfVLP3L/IrKL0JeGg8SPoc/sgqEJRcYcddiEP7OC6qIXScRk2aHDFDXHPVVeLqYfzuTQgJsq3IAWTv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 PH4PPF3D73251BC.namprd11.prod.outlook.com (2603:10b6:518:1::e65) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:19:57 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:19:57 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Nautiyal, Ankit K"
	<ankit.k.nautiyal@intel.com>
Subject: Re: [PATCH] drm/i915/alpm: Fix swapped wake lines in LOBF late config
Thread-Topic: [PATCH] drm/i915/alpm: Fix swapped wake lines in LOBF late
 config
Thread-Index: AQHdNFqltaGod/zjOE+TrCEn667Y3La6zKwA
Date: Wed, 2 Sep 2026 05:19:57 +0000
Message-ID: <302d556a0ec9801f8d61c8dc18d010a9f16860d5.camel@intel.com>
References: <20260825055239.3455987-1-animesh.manna@intel.com>
In-Reply-To: <20260825055239.3455987-1-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|PH4PPF3D73251BC:EE_
x-ms-office365-filtering-correlation-id: e0b8fcb8-7bc3-45a7-233e-08df08b1d43d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: xycl+n6EZ97YNyIjudBoeRZGezOkAetiOD7/3tyYveaYIQSpXhColQknGFFeToP6bILLgQiWEr6ZGAGm784Qi4VvTJ7UcxYtg47H+iKPpCgO7SDseS66rxWh3srIJ1106MQY3WJOpgM6D3ziYTdfDPQQHlnVJnka+N6qNbczodZL+TvMIjqBwcE/n0OI0ehk4ida1mFxc3G5l9hz6bHmEgJLo1qUPRrsTgd99/q5/hwJ9HuvzptG/dnOhqEeVaintzlgAfc6g7Gpd7yXGb2+kVeVWZqsvaGGWF/naw/gx/UhZK1tnRxzpDO5DjXtYoOD1O8rZXk/7Dq5VwVSb3NWxlu/S7uN0MhkZMu/lCO1e5Q8kKEUzWlYo2ap/yPNSaTvpC4NKtYw6gaaLYP/lpWVwph2Ah5n+vxqUaobptQmFOQ6huVTl8qMjEHKMmDGZNvXx3A+RXIc/JHImM0jfwA+GKQ2nus30Jr9E17poWf4sJyiLARU988mbKopm4UPn3DuVo3+/Qf2KdFPvSR/EVdS0ltr2RZ0XfzwHVbmKbYdeTbEALZdUiBW6a95iN+vx1RCqbK1toeQw41Ot5OHvA8cjQ42NyxJQCA7KLb1GJRVfgujmZ0p8/2QEDsG2L99bMYMkBjFk/knXQZYXx9jbxaPWeWFh2lzXOmFw3vkhoyX1kuHDY0unZ4i+bkOyajLYZlsm9bnfRpXIPXmmybbyDBXVzhxPhL1N7ggyKUjIEUFN/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6019.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWVtUUtaUS9qdlE1ZTkzNG5vdlk5VG9weGhOYlBoR3FUTHZHbWFIUy81RlIr?=
 =?utf-8?B?QTlGNXdpaEpQL2hoUHhKd2VZR3VNYko0NURoL3E0L245YnFuSzNBMzBUQUE0?=
 =?utf-8?B?aUN6a25RRVRxT3JjS0gxZ3lMV0dKSTNGZ0hEUDlvc0sxeVRWR202ak5RNHZB?=
 =?utf-8?B?MGczWXQrRXV6OHFDUFNJRjR4ZDhjd3U1N3liUjRUM2VkN1ZEU3dSNE1aeC80?=
 =?utf-8?B?UmxjT2VUamxrLzZIbUY1bFRDODl2bE16VTA3c2dZdDJ1R2w5L0dWbzFYZnVp?=
 =?utf-8?B?cVYwdzE1cWs3WmNkUnRTZ2NCM0ZGUjBtNDcyaWhqekxsTnhIaGxzelVhSkVp?=
 =?utf-8?B?YlkrWFp1K2c3OEpjVzlEVTVZdlZHNXozY2JwTTFhRjZHdXg2Vk5DVlZPRkxa?=
 =?utf-8?B?VENyeDRXelcxTHVtTkx3L2UybWJwTUhkMUs4Mk9lTXdDQ3FHMEhua1dEQVpn?=
 =?utf-8?B?OUd6czM2TnFGVkoybWhzcHRHemFxYlNhK3N3dTFTOW5UeFh5SnI0VEl6c3V1?=
 =?utf-8?B?UVhtTUlKLzVUbzlhQWw0T1hoSkxyVVZlazhwbjgzY1FFZFlNNkMwWHFDd1Yz?=
 =?utf-8?B?K2Q2UXR3UlhPZWJRc0xkRXRxWXI0WlEvWDU4WjUwUk94bWpNOW9hYjdML01C?=
 =?utf-8?B?eThCZzc3eDBoYWZrYmMrTHBmWXBnNUVhQ1ZxNTIrV3pPTTJyayswNFc4aVJn?=
 =?utf-8?B?M2xaMUZocndFYkRJWTRFMVd3a0dBdGxoZ1hsd0NHYzdERHhOb2pOemhDZTNU?=
 =?utf-8?B?TUdpQitRRkkvbTBmNDRxTW9ieUNmVmtaOWFQU3RLLzdxclN3aUJBQ3VXUm9G?=
 =?utf-8?B?eGtPcXZBVkNrS3djYVNpR3JsT3B4Vk5KQ0JGcFJQMVdIMXlKL1FjMVRTZHNu?=
 =?utf-8?B?TmNITHQxT2hGa3dadjEzR1R5YXFobTBJeDNpUllyQXB1aFdzUThUemdZMEZL?=
 =?utf-8?B?Qm9mTnd4MkU2Qno2bmRDYjdLY2dnR3dOVjBsYllmTytObW1ER080UlFMOGwx?=
 =?utf-8?B?dlNRcFBtR09wQ1ptTDRxSnloRlczVFljYTV3aU9NREJiYm82STRoSGp6UzJH?=
 =?utf-8?B?WVlUcHRVSm5jOEJ1WldHeHN3anUzZWJuUTJYVVMxbE5IVS9aQ0I0NjRTSXlu?=
 =?utf-8?B?cGdJbUlmWTdUMUJqS0RFdW5NVjdlWWh1Z29GYjg0THRQYjFPemNTTnllUE9v?=
 =?utf-8?B?NTg4eGtBMnRzTDZEeFIxNTluSmhoSHBCYWxZOVZoaGtoN1ozZ2dHMHN3U0ZM?=
 =?utf-8?B?SlUyTktQcGVRSis5dFBzaEE0b1k0YzVtSWIyL2R1NjJQSGpQUmd4NHF5Qkly?=
 =?utf-8?B?em9uSTVxSWxJR3hrd2xURWQ0bFVKQzhiclBESUhKRUpId3UweExpRzhjUm5O?=
 =?utf-8?B?OUVpUE95YXlqN29uWGVJMDUyZndIYk9xS1pNVklpVnY5L3UwRVNrK2pybDA4?=
 =?utf-8?B?U1FhdUxoRmw4d0lmUWI1UFE5enpYZUlwMmdrK3hZcXdxMmJLMUxQZnp3TnhP?=
 =?utf-8?B?K3htNGtJa2ZOU2hGa1BmV2NKRkpFMllHSzVlN2UvVVlBMlF3Rmd0OGNTZkRC?=
 =?utf-8?B?aGdKS3JvL1MyS2dxK21vVHN4NXo1TGVrTHdJbVA1c2p1eWJmTHNOYWxpZWJN?=
 =?utf-8?B?SG03RVlLciszY01Qc0tLY29RZzVKYlowS2VKZjBFUFJFVElRUHJicll1VmZ1?=
 =?utf-8?B?Umh4NWRadHBRdi9INUx4anY5Z0dDYW9OSUdwTFhoajFsSXpjNnFaZkZVYWVG?=
 =?utf-8?B?WnJ4VDdBVGJ2QTk4RytLeWYwVnZqV1Z0TTVQTkxKd3Rham01enB5a0FDeU5H?=
 =?utf-8?B?dnVSSnY0TFNtRjE1NjRyQTdjM2Zibk11QWhtSG5uSnFOdnIyUnE2UGF2MTNy?=
 =?utf-8?B?dXJDUXIwbFRTc0dTanU5cnhQUXJPY2VseXBkUGRZcW01UWVCVDBMZDZwWFM2?=
 =?utf-8?B?RHFRbS9xdnJtbDFoRTBwL3UwbTMrTVRqS002b2MvS1F4c0hBZ2FvTHhDRUJ5?=
 =?utf-8?B?R2NjYUZUSk9CQlJ0NzBYcGtWYlgvUjdheXlscVEyZ1ZaRWgvMVFCTVdyZGtV?=
 =?utf-8?B?bm9YNlB1UVppV1BuK0o2OXh4MUxUZ3h5N2VGTGdZK0JScVhvMUFlbUdNUmRu?=
 =?utf-8?B?eUNhUmVXN0NKOVRjVnhhYkhJM2o0djUwM3dMNE5BRDZyQ21ZOUpqTk1RYW5s?=
 =?utf-8?B?WGZ4ZUNWMTlMSVlpUDBBQ2p6WXFjMVhNajNDekxVTmI4UmgwczhZcVlIVWVD?=
 =?utf-8?B?YkhiQjU5aU5VLzJtTEFVRHB5MkFlbGFhM1dZYUNmTk02YTlwbzhGYmp0U0pw?=
 =?utf-8?B?Z0tNSE9OK2RQRTBKajJlSi92UWVoQjVzTU41YTR3Nng3QW9WYzFpUXBGcVpa?=
 =?utf-8?Q?skZEk4vF+/oCWuA4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83312DA2B3BA944B887C9FF52CB232C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dYmwXha7pI0dj7kw7Af3magVIJZeJietX2qnDoYey0JL07TPLSIOQf3nRoPCst461sMqbsP12jjT1HlJiM4/7ManYzrw8GoBG/l6r9s9dCBUFwMhcwETnLqEUts+CuTewvC/xv5r89ol0vxQUv6M1mSrXfAadQGRak9KlStYQw7PWM9KKHq69dZMX25Afc4U7cvhljpmP0YWz4isKrowswr3EFCQB5KcvrgWMuM39TQNextOxNWscvkD2VvBx/tInVSn0fnNM1R9xVs2Z/PxoOl/oKu5Gdyi63f3Y9da7s0TNSzFDqBj8EPhGtEy6fEXFuk54fCKqHO/TiDGbGmOlQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b8fcb8-7bc3-45a7-233e-08df08b1d43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 05:19:57.2556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQ9blchQtktsxi8FdNSmGRuGEV7ywkBJYrsKkQf8Lak0nICQ/ZzLFe9BdP3qU9gABCkF4OnkAuEFkZ4DbdxZ/EqXmXMlW8JcetlNdsyxKbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH4PPF3D73251BC
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTI1IGF0IDExOjIyICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBpbnRlbF9hbHBtX2xvYmZfY29tcHV0ZV9jb25maWdfbGF0ZSgpIHNlbGVjdGVkIHRoZSBtYWlu
LWxpbmsgd2FrZQ0KPiB0aW1lDQo+IHdpdGggdGhlIHR3byBjYXNlcyBpbnZlcnRlZDogd2hlbiBh
dXgtbGVzcyB3YWtlIHdhcyBzdXBwb3J0ZWQgaXQgdXNlZA0KPiB0aGUNCj4gYXV4LXdha2UgaW9f
d2FrZV9saW5lcywgYW5kIG90aGVyd2lzZSB0aGUgYXV4X2xlc3Nfd2FrZV9saW5lcy4gVGhpcw0K
PiBpcyB0aGUNCj4gb3Bwb3NpdGUgb2YgdGhlIG1hcHBpbmcgdXNlZCBpbiBpbnRlbF9wc3JfY29t
cHV0ZV9jb25maWdfbGF0ZSgpIGFuZA0KPiBvZiB0aGUNCj4gdW5kZXJseWluZyBtZWFuaW5nIG9m
IHRoZSB0d28gdmFsdWVzLg0KPiANCj4gQXMgYSByZXN1bHQgdGhlIExPQkYgZW5hYmxlIGRlY2lz
aW9uIChzY2wgKyBndWFyZGJhbmQgPg0KPiBmaXJzdF9zZHBfcG9zaXRpb24NCj4gKyB3YWtldGlt
ZV9pbl9saW5lcykgd2FzIGNvbXB1dGVkIGFnYWluc3QgdGhlIHdyb25nIHdha2UgdGltZSwgc28N
Cj4gTE9CRg0KPiBjb3VsZCBiZSBlbmFibGVkIG9yIHJlamVjdGVkIGluY29ycmVjdGx5Lg0KPiAN
Cj4gVXNlIGF1eF9sZXNzX3dha2VfbGluZXMgd2hlbiBhdXgtbGVzcyB3YWtlIGlzIHN1cHBvcnRl
ZCBhbmQNCj4gaW9fd2FrZV9saW5lcw0KPiBvdGhlcndpc2UsIG1hdGNoaW5nIHRoZSBQU1IgcGF0
aC4NCj4gDQo+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4N
Cj4gQ2M6IEFua2l0IE5hdXRpeWFsIDxhbmtpdC5rLm5hdXRpeWFsQGludGVsLmNvbQ0KPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBGaXhlczogOTA5MGZhNDRhNmQ0NSAoImRybS9pOTE1
L2FscG06IENvbXB1dGUgTE9CRiBsYXRlIGFmdGVyDQo+IGd1YXJkYmFuZCBpcyBhbHJlYWR5IGRl
dGVybWluZWQiKQ0KPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTQtOA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVsLmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiAt
LS0NCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYyB8IDQgKyst
LQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBt
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBpbmRl
eCBmMTM4Mzc2NGI3MDIuLjU1OWZlNmQxNGMwMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5
MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gQEAgLTMxNCw5ICszMTQsOSBAQCB2b2lkIGludGVs
X2FscG1fbG9iZl9jb21wdXRlX2NvbmZpZ19sYXRlKHN0cnVjdA0KPiBpbnRlbF9kcCAqaW50ZWxf
ZHAsDQo+IMKgCSAqLw0KPiDCoAlmaXJzdF9zZHBfcG9zaXRpb24gPSBhZGp1c3RlZF9tb2RlLT5j
cnRjX3Z0b3RhbCAtDQo+IGFkanVzdGVkX21vZGUtPmNydGNfdnN5bmNfc3RhcnQ7DQo+IMKgCWlm
IChpbnRlbF9hbHBtX2F1eF9sZXNzX3dha2Vfc3VwcG9ydGVkKGludGVsX2RwKSkNCj4gLQkJd2Fr
ZXRpbWVfaW5fbGluZXMgPSBjcnRjX3N0YXRlLQ0KPiA+YWxwbV9zdGF0ZS5pb193YWtlX2xpbmVz
Ow0KPiAtCWVsc2UNCj4gwqAJCXdha2V0aW1lX2luX2xpbmVzID0gY3J0Y19zdGF0ZS0NCj4gPmFs
cG1fc3RhdGUuYXV4X2xlc3Nfd2FrZV9saW5lczsNCj4gKwllbHNlDQo+ICsJCXdha2V0aW1lX2lu
X2xpbmVzID0gY3J0Y19zdGF0ZS0NCj4gPmFscG1fc3RhdGUuaW9fd2FrZV9saW5lczsNCj4gwqAN
Cj4gwqAJY3J0Y19zdGF0ZS0+aGFzX2xvYmYgPSAoY3J0Y19zdGF0ZS0+c2V0X2NvbnRleHRfbGF0
ZW5jeSArDQo+IGNydGNfc3RhdGUtPnZyci5ndWFyZGJhbmQpID4NCj4gwqAJCQnCoMKgwqDCoMKg
wqAgKGZpcnN0X3NkcF9wb3NpdGlvbiArDQo+IHdha2V0aW1lX2luX2xpbmVzKTsNCg0K
