Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793206607;
	b=XMKEanUi5KLryfCLSkm7Lr1XqTuhmt6gkV/aoouH+g/D56UxBG2B9HsuRHRBSC2hboGN
	 OyuvQFb/OhNHXAAgIFt3DXboDOJ9RlUM+00PoYjjQ13/vkEoK0m+tyQfXA9DgAIEJEDWn
	 E/JWIElSdbxymj8yGy/kR6qAW9kIp/Dwvv9zWsBjDWOubkN0J39akNi3nez26eTZS/Av0
	 puCPl6CZicH8M22A7uIZKjphPkMZA5dzlpQDksGlAceUgvJQ+l8pYOVa+W50VXCkpcGWJ
	 bwVtfZt2dAFEH0oxr6F/CCYeELgHzfoy9yFOHp+ZT5FZtwD4q3kBpo/7QCXZRNX5wHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206607;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=TrQsZ6Uccu+EjKrnIN0FWynhBd+f8Q3L2em/UDv+QoA=;
	b=A0GVcSNuxPhbvA5Xww2U0xvnjProrjAE+0izZCOXSd98WCl1tehOGDVMI/IZZIjBdyv2
	 tpqkbEJFzPmOj4OoBqeCiSi5Hq0BFmO4KG2IvoemnUpstDb0Tf/VEw8EEJkRXc5aqHtNg
	 pVyKyqkAtX1k++I8gsoCIZeW12o/sSs8ZC9J0AsbiIrr/YjRPP17NUNECn78Yyd0S/nYp
	 jMjA9yZV5tXWSVIICKIQPTu6AL8cyap+yGAG2huFUUqI6W01gwt9H18rt0w4LbUx4E6tj
	 3jSqUQgH4RrAl+UHNTsPqSMQA43/o+b6E+w07561KqSS2bsdjE2l19NiIzw+yhQWO7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XbvLqawS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5D606A32D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC5D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XbvLqawS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793206605; x=1824742605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hPREUhghbXJH57a8w1wfTBzw2t9ZRl6CD6yylGSjJeE=;
  b=XbvLqawSURcP/6bQIx7AHuLL5zAJdso7CGVLtCFUXmQ8x2qv5tg9vcv0
   ydqk3seyTdCKwnZi6xkVIjLRp6bEdxYfeAc/yF6wuV9s9Km/Z7+3RLDVc
   CbuyYTBEV6NZp/RZMmZkH4RJ4+Lh9Et1eHGH6+vZOTJYobsGt5dxSItq9
   MX8F4gnsDqb8klakbM/kMfMSylcjbTdseyJ7OevnNEWVmW5u3kRc/0KoD
   fF5UAqsdfFCAOW1U4T7ly9NdaNj6sCuhUkQRJ1tHcsyAHtXRA5Idp3WAD
   0auhU19fDwQMNETpi0RSryWaNF+NQDGFjjQ3YcHFW2CapYheiEILdpYd9
   A==;
X-CSE-ConnectionGUID: 6ko6MRdUSHu9VY61Tbltjw==
X-CSE-MsgGUID: 1WCLCtyLRXWy707Dtle7DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1827199"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1827199"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 09:56:45 -0700
X-CSE-ConnectionGUID: bx4PCaOkRWS40VKP/rTEVQ==
X-CSE-MsgGUID: UTgswiXdTXKYQym4RV+V3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420081"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 09:56:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 09:56:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 09:56:44 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 09:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JadhQrJtk9XB6ODYlwbs4PVnggXkWPDWlD50uv9NXTblcI36o4K1+KqnpKTPa7r10fVN9JGLI8QUpHfmvKP2xqIEqFnyCT0MAuqqeeIN4+kDN5woRsef26GofVFABfvHS0KS97vINKaEORJSDt9yaX41fI2lZuvkWSeMagT5Ob86gEmBGcxn93CTN4hhovRXKDg2Moee9L9cu0yl3g32mGrxzrHWB09NG6QXS38rTrBesyhk6xz6ReeZVZfDWAl0lvFF7vIPa4Sqv6nOquZg1YQnfGEDHWTTDnhHAFltYrtRrBUNybSs/U2V/48RofboN6b4X9aJ5pw5TO7UxkSRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrQsZ6Uccu+EjKrnIN0FWynhBd+f8Q3L2em/UDv+QoA=;
 b=j6mcdO25wOHEXdnk5cre0U083Mnd3bgM8rLldf/IQY881qtPOFTmHUqPZ2hFROEUpiucVwr5nN6e5iAWP4vUjcTz7xQjvcSaHkLb929YuDHSh4g2thgFZMBnnXH+mIcY1GcdMnU96MqCDg/fzO0arnkfuQ0es9H1cBFHcydmQ0vb9rJtm48sxYwJm92m7R7Dunu8LLgFTHU/cson8vPPSE9VdlYkdcowMx7Ww+0D6OPpvnibhv0wL3npbd+HBI/gbL1aRaXecZOqgQopkhD0Beh4fLLxkE4vlQEaQgPvL7VNwEw7h3lWrLJIz2GkHOZfgXf8F124pPMH+MWsyZKB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12)
 by DM4PR11MB7375.namprd11.prod.outlook.com (2603:10b6:8:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 16:56:42 +0000
Received: from SA1PR11MB8253.namprd11.prod.outlook.com
 ([fe80::b584:d8d0:f097:14e0]) by SA1PR11MB8253.namprd11.prod.outlook.com
 ([fe80::b584:d8d0:f097:14e0%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 16:56:42 +0000
From: "Srinivas, Vidya" <vidya.srinivas@intel.com>
To: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Shankar, Uma"
	<uma.shankar@intel.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "Lin, Charlton" <charlton.lin@intel.com>
Subject: RE: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
Thread-Topic: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
Thread-Index: AQHdZqv2N/K1IP074U+vOvCtUeUWMbcTHQ9wgAAPbGA=
Date: Wed, 28 Oct 2026 16:56:41 +0000
Message-ID: <SA1PR11MB8253CA1A1FFED38A44FE2F80896F2@SA1PR11MB8253.namprd11.prod.outlook.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-3-vidya.srinivas@intel.com>
 <SA1PR11MB82535FFAA9B82BF346F899CD896F2@SA1PR11MB8253.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB82535FFAA9B82BF346F899CD896F2@SA1PR11MB8253.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8253:EE_|DM4PR11MB7375:EE_
x-ms-office365-filtering-correlation-id: b7fabfa5-dfc4-4c81-4507-08df351470ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|261026121527099003|10067099003|56012099006|11063799006|38070700021|261022075727099003|261009223027099003|261021121427099003|261021123027099003|261022105027099003|4143699003|261028144727099003|261026140227099003;
x-microsoft-antispam-message-info: kBgnBFHzYWQ1rmxUd6MwHVZaVdoDOlJDpYJ1S0v2OmDRKjqEfWd7iZwlUHkuWaqKjfaWhFmYJzX6mH/HEQ7rdU3dyzC2JAnw3WeUBaX+lz769YMOHojyIreLv4e2hpQLAdWmcbJV5w1AqNBmIiZ2Oilc9w5tHldJZmdMoCBFNskcpp6f1IZka739Slcax+FM/I6S/EM4Rwrk9md+NsLhyiwUDk70vNI3AJ399vm7bSeh+hJqruuJmzRrc8bcfqnfasrGdMJcRxmFP2jGc/7OQ4NYljzgv9TI/DAenZ1Ib8e28p6JuGckPLUgtM734OV9mZpTXjKRGN3G5CI/linlUcrb4KREj17JY/Br5YebKbwAJ9uQqBn2M2H1F6LjYYIr93nA3nlUpUbynNfy8L5s4Brkvfwwe61Rpfg2lo/qmwIVS+9MscJadFOPFIWz8/GcDO7BnYEB9rL3P2wWdjLRxHzPGQZBdNR4AjX0Vp3bU5rJmYUw2mYA/UiDA96Bo/XzviS+gYeyhlyWya/j5jWDYQLzIv4sAipE2l4/4Yo17KsQGcfG6bY3u4xz92QpRhHehidNpobgdm73HO0L+5q3Jm5BypLBPJUMz+B8wcPA47FlxZZBPqF4z1Qt0TVQeCaCa6ah8aMuNcUBe55dTeE+c1AkXe1Nhww5jIaYnrw7RGgIM0SmwxRlyPylTz+V92GPtQ9VYM2mli8GcbMx/JWn3R60Nz9um7Bumn9v5/Dlq2A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8253.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(261026121527099003)(10067099003)(56012099006)(11063799006)(38070700021)(261022075727099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(4143699003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZIotz5MCieriY3ocgUqmD0DGhki8VbE73Hz+wFHj3EqEjfP4rtZg6G84L7LR?=
 =?us-ascii?Q?cs6xkn/c0tpfUOFEXN4XOWwb3/KOJO4Y22lJH9/Q10IeQzX6aaWjMiJ8JTYO?=
 =?us-ascii?Q?bxWnQAP4rEFMfimrl3z4DAnYm+04Cla0usJNvGLoW/LrNo+LjQItXe1RbU9f?=
 =?us-ascii?Q?2dWL0TaAnppQEWQZIwW2rL/y+1b92PiDaAECSIyaSyOyRb/27MUTHOloYkdY?=
 =?us-ascii?Q?BTv6LcWDH9cdUg4Wf9K/D1pZDFtnOd682sikUXLa7jrjO4L3RClTaf3+gUzP?=
 =?us-ascii?Q?ljidM6dUDwR55quHOyBboPxYaE/bh/OeIxorNFmUzMWe04Ol5bwvCjarLwHJ?=
 =?us-ascii?Q?vPAmfj1TCQj24pUHbGYXVs7iWCw4m0AnZzTkC5Y1J7pQ1unNLqQdiEYAvHVV?=
 =?us-ascii?Q?UK8aRlEHQwxvRT0mKrkdSI1e2a/n/kN/9MkIWHRbftDNhXhREJ4GnOqCd/TR?=
 =?us-ascii?Q?BOUje/ArRY6PYL24bdtL386ihxiYU5XUFqTD+KTMxjHgv33khHBvig2tI3n8?=
 =?us-ascii?Q?AGrGiEkne+b6cTdYkKcvZqc+f3p5l3wgSDHEWf37s3o7/57MFlXx8yJDN6wJ?=
 =?us-ascii?Q?cqaeaT67NXfew4HLAfPCLQE43cbdz0cki+r3g8ZAJGfEv5vIiWKbwhZymYHT?=
 =?us-ascii?Q?NC3b6Wt5yoZYhitnexWZrZxNe5jpj4/MZvoPrWUUA5Z8D1VrGv+GIG+o+BM1?=
 =?us-ascii?Q?UqnQMscby31P/1TIkmijjPzY/TxVoNWmGlI4286US4gSxHgShQF1LT/hEVBg?=
 =?us-ascii?Q?PPBAIZDaEScLaywK8fFNmIWvS3xUID8psZgn/xY3l+JqGfQ5GpW3l8Bg7kgW?=
 =?us-ascii?Q?qV53DlSiFynr0M3PWgIPn9STptdnePSIeZeAmve8q7ePoCrdEF4F/Ad0F2vT?=
 =?us-ascii?Q?iTg5pTXhZ1vr0oqNPqXN97Nj8LKPQzde0S2sGy55jXeg/AfFUz/kZ9RVx6/f?=
 =?us-ascii?Q?UhCUgT7YwcXBEu/nQrfJLnClcEYOqE9+Gu6wgTbAt6+Mk4F6cIO84mesS2xP?=
 =?us-ascii?Q?r555VreFj8KlE1XZsiyXR5vgGW0zl/INi6HsRkBVi62ZBRzjuOIuBgw2VJep?=
 =?us-ascii?Q?3gX/fb8xKb2be9GvTBe4wP65/2yLEh3uSUHwgBbrHZjU0Q+fQHXcwaLN43lc?=
 =?us-ascii?Q?9yXzgvG/fds1UF2o5hwVJPe0T/37tOX3Q6XXAWblioTSjUNU9zTRVxjz77FL?=
 =?us-ascii?Q?XFjddx2afiWRS7mscAaS/uyhc53kmB6rcftg9tBkoRbzJeC++NyQT1b6Dcqm?=
 =?us-ascii?Q?XCd4CB0IGXWMZVLcS/47srJb0PoQ5T5N++QXhGwyWvpP2GUkOk6EiM856zym?=
 =?us-ascii?Q?/R+ebvvjR549Tp4vBlSpfWNtRTU1o/O9QpDaNliCuL2RrMIpgVWZJIJWgFqK?=
 =?us-ascii?Q?+bWed+gS82+Wvh7/TgRH7kY3MuGw5Dm8aKTUMmgvJJiQ2dAdaSd1+3/TzD37?=
 =?us-ascii?Q?eAI1i6Lx7H4dphzTJc1/5vt0yI+LkwteAHlLiWfy8o2k6MI6RK/bsOIMFTUw?=
 =?us-ascii?Q?j5+dz9hRNP1edQe/Lr+qSLdXJEs/kO9Sd0pSlOTKkrvTSncr0QwVobu7vyRR?=
 =?us-ascii?Q?QenDp395g9aUP6ywse2R+b/gB9VpOKbBBtrcuFZgb+RCAVkOPUhRXTPPFH/l?=
 =?us-ascii?Q?t2VVOedLjJ/MY4sLgKeER6g4zMM8UUOHBCd2zc4syZD0stUhD41Aod7BOZ+L?=
 =?us-ascii?Q?Ogz8F8TbE2BtQuIcVtJUdkULDCqn+06fpSd2sObIRjHe7CNRj4sYod0yn0gQ?=
 =?us-ascii?Q?LTYM3mylNQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uRQeovzzweYkZxkHowWNvQxDNQWmF+YRrjGXh3l8BN8+hUg7zLDUvW10feU46wm0RWAMsQygAGxD5CBLGAawWvNvNLbVRFbJznxDy0RncOVureHThg7gdu7Y5deWHmZvDAeET5JI3pyFmOQ2XCzwGns0iafPy+JWjq1S+DIe88FprfEd8V1AzXL8JZMZwDVOm/WThgh0PKWXF2tiDFaEGVElG699RHla0+b1eXxwJRZ4HnMe37No3HVyOqP/gTSKBV6VNNAuVaYNsYSuNcnUC5ZDxHSh6giZ/DGDDD9x+KhBXtInFEMt158o0wQI3LMGxtfARQ3H1FLRu8kyEXMpyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8253.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fabfa5-dfc4-4c81-4507-08df351470ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 16:56:41.9634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lczdZAM9vNGYzvEoxp/90xTJqSJ5AIfCGHF3zP2tDgxvF75cnv0ucEiIVMhxT+enkZeKztDAzvELWnqeai5BQIyLIxbHv/3AgqmFBb+EIAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7375
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Srinivas, Vidya
> Sent: 28 October 2026 21:29
> To: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar, Uma
> <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Lin, Charlton
> <Charlton.Lin@intel.com>
> Subject: RE: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
>=20
>=20
>=20
> > -----Original Message-----
> > From: Srinivas, Vidya <vidya.srinivas@intel.com>
> > Sent: 28 October 2026 12:34
> > To: intel-gfx@lists.freedesktop.org
> > Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar,
> > Uma <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Srinivas,
> > Vidya <vidya.srinivas@intel.com>; Lin, Charlton
> > <charlton.lin@intel.com>
> > Subject: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
> >
> > Pipe joining is not supported in the WCL display configuration.
> > Report no joiner support on WCL so that modes which would require
> > joining are rejected, matching the 4k 60Hz maximum resolution
> > documented for the platform.
> >
> > v2: Rebase onto latest upstream
> > v3: Fix up the commit message
> > v4: Split the scaler and joiner changes into separate patches (Jani)
>=20
> Thanks Jani and Chaitanya. Adding fixes tag:
>=20
> Fixes: 632633d095b6 ("drm/i915/wcl: Add display device info")
>=20

  Sorry, since pipe auto-discovery via DFSM was already
  effective when 30.02 was enabled, the joiner was wrongly allowed from
  f8e1c3e07db1 onwards. Updating fixes tag:
=20
  Fixes: f8e1c3e07db1 ("drm/i915/xe3lpd: Add support for display version 30=
.02")

> >
> > Bspec: 74286
> > Cc: stable@vger.kernel.org
> > Suggested-by: Charlton Lin <charlton.lin@intel.com>
> > Reviewed-by: Uma Shankar <uma.shankar@intel.com>
> > Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> > b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 00e02e019d25..ef164a797618 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -485,9 +485,9 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
> >  			return false;
> >  	}
> >
> > -	return DISPLAY_VER(display) >=3D 12 ||
> > +	return ((DISPLAY_VER(display) >=3D 12 && DISPLAY_VERx100(display) !=
=3D
> > +3002) ||
> >  		(DISPLAY_VER(display) =3D=3D 11 &&
> > -		 encoder->port !=3D PORT_A);
> > +		 encoder->port !=3D PORT_A));
> >  }
> >
> >  static int dg2_max_source_rate(struct intel_dp *intel_dp)
> > --
> > 2.45.2

