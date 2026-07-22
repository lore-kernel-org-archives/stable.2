Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED51374186
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704415; cv=fail; b=H/GlvWi3Y/4WtHa7rGeoWmJHhxz3rKdYeq/wLdOiUsB4GU/FDwitPhgJkCdFA0beHOvkhsa+ybLvzOQvZx5GFC49iYBYHLs+tYFr29PKBc8VluL+AHGzx3/CAPBumZvwceghO/kFzL0y0U/hIi6jL48Ch5k6MPTyTDDBfTPWZRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704415; c=relaxed/simple;
	bh=jZLyEtrsK8ETRbo0iFPkLWk3igkr9PhmfzfOLPG06Q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Edcs9sZQmjUoaivI7uJZNxUSd9YH7BJCUEhw1XPdmNFZ6lJpiC4b21ihUqrJOZ6+ez5aP6sEIuWiBv1LSu/r9O7KVERaoaT8bpPdFD/K+6ta+OOTOLNBD5haOa3MwXz4kiNXbRZDNPCpw1LRnsKqd7lnyG3Tx+CsWUuR9XyB6OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+YbcJCI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+YbcJCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784704412; x=1816240412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jZLyEtrsK8ETRbo0iFPkLWk3igkr9PhmfzfOLPG06Q0=;
  b=V+YbcJCI7NB2La7sVSpXIWBfxRFGWHugj7j8emHkmq3tnXfBwAy/hkNX
   FI5TDkWFotmhRO6Pn0T0zysrhn1R3K3ID157bK9g00jEduaX1vNIljzQd
   67ueFXOT2OtBYAqSGfH14p7eaqIe0P3iu/33+8qWLGS3G4LLLxmChw9ti
   LiVvg3+iDy/DjIV7pZOJfS0DSURqeZJLMcjJ3XuBcXRRi6BLk2TNlvYV8
   JtFtw9BDknFMsD8nw6PyR2YE5xf2Lm7T0aMd7K+MmW749RW2tugFrQMBy
   fgnHuB61dYUMLcswy/Tmy+/eCbnQe3yHLtjkJe1H4bn8dyhbVRy+u2qWL
   g==;
X-CSE-ConnectionGUID: 4EuAAeTtTxOH9jEVXPyGRg==
X-CSE-MsgGUID: g+T2jDJ4TYuehWU5kgQb3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85093599"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85093599"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 00:13:32 -0700
X-CSE-ConnectionGUID: xfnTMkrxT5GuIh6Kg9kcSQ==
X-CSE-MsgGUID: IeMY/XKUQaOn+EX+j1Ujrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="254105731"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 00:13:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 00:13:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 00:13:31 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 00:13:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUvGdgwxb67GK0AoQPDDOMBEW6NHjfoteS8uQG9rjXQ/Q4SnvJ1/b3u6wtmgVgTwUOELaB3TbrUIKsK+648+5yaHRbiBelQdSGAwAq6AihLtb9r+JPevcZobt3plpZegzSAVzjHBTUxNo/KEaZI2a2BRuncrpVuQrYPG+SyAoqLD8Xv+9IsrTxmYO8PbmEkH0wBxEf3RVYZkj0KhS5K/gNELWvdifCr4c+XBqgjgFCBc6zI9tJjPjuOvZzXDgfIwLZ0Pel+FFN1mbkHmnTNKPIUqohq7bH1CrP3r+6v8Pb1P/lM7CboPqzhJ/x2XS0v0O/xqVnhD4kMtiZGUZmp9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZLyEtrsK8ETRbo0iFPkLWk3igkr9PhmfzfOLPG06Q0=;
 b=YDeu8cqFJcol/JYyxLnd3iEoLLUZ/mLdu7o4eSsUZyXDFWKRkS43jgx1ckh7XFqRMFUioYSovahVEhvJV8takF4o1YUSp9mcZFxRklY3jwVvQ+wugzdRhWJsXMAQH+XSGOll4JPfEjXzhQGEB3Rk+65VOatD87FfgZWbPd0UmSQ6LXOWc+bzmZZbbrSUbsWDzxz2zEvEvdrzBjEEYjjm/J/sy2yWgxt66Im1D20klecb+FADGrC2D88uPwcCBMlYf6MHZ55rGnf0s5jghB08j/c+ukEWUs3ToNf059pG4juCHZA0uTJPtCNpeDhpT6LnALlByf4RBEMOAqNGIG7Ehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by CH3PR11MB7251.namprd11.prod.outlook.com
 (2603:10b6:610:147::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 07:13:26 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:13:26 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] drm/i915/cdclk: Avoid spurious cdclk sanitization on
 PTL+
Thread-Topic: [PATCH 1/2] drm/i915/cdclk: Avoid spurious cdclk sanitization on
 PTL+
Thread-Index: AQHdFgXedVcXo9YO6UmmtKvjptKX/bZ5JwLw
Date: Wed, 22 Jul 2026 07:13:26 +0000
Message-ID: <DS4PPFE901A304FA356B3B457196D4A9B49E3C12@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260717155107.17801-1-ville.syrjala@linux.intel.com>
In-Reply-To: <20260717155107.17801-1-ville.syrjala@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|CH3PR11MB7251:EE_
x-ms-office365-filtering-correlation-id: 0e4da8f5-e8e2-4244-92c4-08dee7c0b97f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: cuVgdWqSBGlzjYIOhe+0eHP0rS97/lVv8Qdnq4jTe1QW8JSzmxF2lnckKgSzy41F+glqyy64irPnzwf99K/wTtaUbscxcTH6ZuIpe9mGOkoLT9z3KtdATo7pMfgVX5VQGgKmt6BTiocRHhvzlDzl8AT4WtYXoeIABJFNvWLmzPChYAUVS/o9KaHN5Bzg9hRhM4pNmqCh0cP7uH0Gbzd/IhD8nmQWjagWrPRfIdjwYnA2HncgylbF15BT5TdtybHn5ttdcXPFTcHrOO0pzRc+Ej8gPhuea4eRITycmC1hfEdJNArtZjlVT0pTx+8dmFNHc0sYkZlT513bZXKTZXUthtefunOLaMcih5gwLCJLm738hOwM2wqnJTzHJnV4Mg8xnX0lw5yn8S4rM11/VmvKSwRFkXcUX3m19J9XFMdlThtijuHk0h/dInVaD9G53UrmqTwZ474gsSPbOntStAnWy/Hiuvim2iH00uQPKT0ZnP7mHDJkPzai1/04oEPCsF0UCBONvpJsFxgTeIMqSAhWD02W84pykbu/4szJVAM3H6cPKgR2lEmDGKYRmuMon8ct8iOgimXfWKGqDQ0p/63kzcpDdCsw4JmuPWe2mgcqJUBv3DqqUl/B9f6LrQav1xVnnMSCmyGzPK5tJltTa46cZWI3uZOADQwMg6qD9e/B1R8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1VNRUpiSFMrZ0dnSmU2Y0Y1aDB1VUIrM2E2dmVVNlBxOEI0bnd5V0d4eEc0?=
 =?utf-8?B?a2haU0U5cEYvcWp4N2ZrcWNnVnlqb3BHc25BUkJqamFHdFliYmpOelRNcXpR?=
 =?utf-8?B?VHgrdCtGbi8vdjNaTys1TzZ1cHZQTUhkZ1hwL3R5R0FaWDh1d0RNMjRVWkJI?=
 =?utf-8?B?K1drRTRhSjNRTDNVYXJZR0lLZTYrbWwrK1E4TjRzSVI5eVo1SUNEQ1pkQmhZ?=
 =?utf-8?B?VEcvRVEzQWVqaCs0Vy9DMlVLalo0VEJlSWdHdTQxNTFvQS9KSkUzTm1yUk1G?=
 =?utf-8?B?NWZkVFFNU1ZwQmdVU21JbmJ0anVCZHplVkEyRnQ2M3NiTWhQbXlheXUrRHRk?=
 =?utf-8?B?Tk1CUmdWc1J4czMwbWVZeDg2UU1FZCsyd2xQMnM4bTlZVFdzR0VEeWNTemp5?=
 =?utf-8?B?MitCVzFhOXg2Nkd1L1dVOGVLYnVLS05xK0lOUFpwR1F6VXBOL09DeEZJZmx3?=
 =?utf-8?B?WDVITzI5S2pRNzl3RUFlYVUzeHlRS042dmIzSFNWaUZZOUQyWkVnRXJ4WWV2?=
 =?utf-8?B?aUZMVjdFazhPMjllZ0t2RHh5ZXAxWERvVENPYUFCMHh4L3dSMmVKZE15UTNK?=
 =?utf-8?B?Zll0Q0JYQ2RkNExNZUMzUFBLaEJmdDA3SGFEOVlJdFJOUENwQXhNTEhwc2c0?=
 =?utf-8?B?bkp3cmV2SjNJNWJFS214UGN0blBKNGJlaktCWXROV2QxSDVNN0Q1eWxMN1A3?=
 =?utf-8?B?cktrQ3JSRDl5RHBnbHp0R3hJdVNHOGovNWpqbTFodGhzenp6Z0hDOVJPRGlt?=
 =?utf-8?B?SjBUVHNyWkI3MkYwOWZvS1dKVWRFYXZDbld3WjRTQXRYYldNa1JyTjdxS0ow?=
 =?utf-8?B?c1pXbWVBT1FjMkx1ckd6SUxKbldlejNDc0Zpb1lZK0lUcGxXVW1VczBCcngw?=
 =?utf-8?B?Wi8wZ2Y5NFVGTWtOL3V6bUNOTXJSaUZPRG8vd3llRHBWVEdLTlNVeURrMjkx?=
 =?utf-8?B?cFJBQ2V5VWxiVENiYWcwbDVoUUJTa3VJNlpnZ25vZFROdzZ1Q1JPaUJTb29l?=
 =?utf-8?B?RkZpMEVWOEhGc3MvbHNhSGt4dktCS1dTMTFtQTkvdjRYR1FXeVUxT0JsLzYw?=
 =?utf-8?B?UHFqN2RwRHQza0RRakRkbHZ5UHptdFg0S1RtdDJ0VVZJT1VGWFVOTXlRcitj?=
 =?utf-8?B?clBvVkxaL3NKTFRKNEJubWdWSVVWQmJmODdPN2NpTmlXWVQ1Y1R5Sk5lZ3k2?=
 =?utf-8?B?a3A3MTVzRGxvMGp3YWVpblByZ0dXTGNScXVRanBTMDFsaDJGNytFYXFaZFlO?=
 =?utf-8?B?aTZBbUF1MTNCWnV3ZnphWVZkTUZVaUt3WjJKbDJNUmYwMjE5TUc4UWJUa1Qy?=
 =?utf-8?B?MjluRjN5Z0hYQ0c3OFdUR1RJcTh4MDVqREd3b1g1ZlkxUDl5SDZERzlON3dO?=
 =?utf-8?B?NkJaRWY5aWxVQmloZHNuRHR2YWJncU5ONjRQbjJ1TTBBMytoN1IreEtzYWNO?=
 =?utf-8?B?SkVXMWtPUXFTYW9HRGx2L2owenpnSFpZeFZ2MXZiNDBmRzlyb2plOWpoNTZ2?=
 =?utf-8?B?cXpFcFRXZm1kME9pYUJ6UzVLTW05ejYwWnl1eStlTEZQZ2h3VlIvWXREbWdt?=
 =?utf-8?B?VDN6R2VRYU9BU3hJV0M1b3ovOE05czJOVlRQT2NyOXN2ME0wWjlZNllOS1Nh?=
 =?utf-8?B?dGZDTVRRMks2Vi9DMXZDL1ZFM3dhMktIVTFDWVlPSFo3cEFPWG9keFZDS0RY?=
 =?utf-8?B?MENQZ1pCMDZNeHExZGtKTFNpSXJJZUx5TEhRRzlKU1B2c1FNNWZnbEJNUjhV?=
 =?utf-8?B?RmhwNVdMVHZKUHFOWE03NGdKcHJncnI2QU9TTzlqTlZVYm5BdThxeEM1T2lx?=
 =?utf-8?B?WDBFR0dtWDJjMlV0RFAvczRpSGsvVW9uTGtJZW11bEFycFQwNGhGUWJXQnIw?=
 =?utf-8?B?dG5nREJSV2xFZWt5ZjZ2WW1KVXk2QU43cHdQOS9LK2YxZE5KR3JyYlpUaWdk?=
 =?utf-8?B?cWhLMUI3L0d2V21OSWpsTWtQTDRES3NLN0MzTGMwQUZmUHp0aEZKYU5kc295?=
 =?utf-8?B?RjM5YlI4cWsrWmt4NVlGV2JJTTZMSHFTVnBpSUpYaEJ2cllpZ1Y3OEg4SVJ5?=
 =?utf-8?B?Vkx2Ri9xWTU1ZTdLTmp2UExva0RuUVBoZVNlS2JXQk15Smt3NUZPM3lzN1h6?=
 =?utf-8?B?S1h6b0tLTjNHdzdiL3BhTVRpQVgvM2xieDY4cVEyME9FbDZFQ2duOU1FR2dl?=
 =?utf-8?B?Z3BFY083b2c2TDM1cG5kRkIyRXFlRTIvVnR1SlZNd2RxSURtMzFxZ1Bqc0wv?=
 =?utf-8?B?RVdKa2hGcHdRdGNuTUx1WGRSQW15NzFlVUc3Q0E3c3RBdVVicmRjRzFQbkZ6?=
 =?utf-8?B?c0h3TlNSQWJqc3lLZmdRZWR2bktydEZCd0R2U1NDWjZPR0pwVm1pQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B0erzM+PDRbHpYCQ8Df7U5knsgQI4/nSjEQ5/YgZh1P5m4HdY7a0vxry1fTan/0WHO2tpf0l+5eebLwNn+n6Bjpg6cPzzCGnBtHUgW8HPryezESmDMVB5TOUz6jxSNTuMjOx0rjZpmZs/dvSt7gjYId+LUZ8wjuOPsZv7Hr9WlI+hw74KBmjfEvwM+oEf9pTC986OdBPMpE5qntkiOY2NI/C+zgQ6adyTg4JNL4c2MAqsd3bsDMve/Vk9ZYxij8PjugL5cbMV1JTA4BHLsplmVt7qMQjDY6MQXPN+EQUFQius5zb00YDjuF+O/ABoQaax1I8isn3z/UR3JKEPrdvwg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4da8f5-e8e2-4244-92c4-08dee7c0b97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 07:13:26.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8R47sQBN2mFJuI9KZMdtdMPN7cM2jyzYL+Hf+v19npVvrtep/IlobKSH6SoHmoR1A5vV8nTvNGWM5+IowYjLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7251
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0vaTkxNS9jZGNsazogQXZvaWQgc3B1cmlvdXMgY2Rj
bGsgc2FuaXRpemF0aW9uIG9uIFBUTCsNCj4gDQo+IEZyb206IFZpbGxlIFN5cmrDpGzDpCA8dmls
bGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+DQo+IA0KPiBBcHBhcmVudGx5IFBUTCsgbm8gbG9u
Z2VyIGhhcyB0aGUgY2QyeCBwaXBlIHNlbGVjdCBmaWVsZCBpbiBDRENMS19DVEwuIFRha2UNCj4g
dGhhdCBpbnRvIGFjY291bnQgZHVyaW5nIENEQ0xLIHNhbml0aXphdGlvbi4NCj4gDQo+IFRoaXMg
Y3VycmVudGx5IHRyaWdnZXJzIGEgc3B1cmlvdXMgQ0RDTEsgc2FuaXRpemF0aW9uIGR1cmluZyBk
cml2ZXIgbG9hZCBvbiBQVEwrDQo+IHdoaWNoIHdpbGwgY2F1c2VzIGEgdmlzaWJsZSBnbGl0Y2gg
b24gYWxsIGFjdGl2ZSBkaXNwbGF5cy4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwv
LS93b3JrX2l0ZW1zLzg1NTANCj4gRml4ZXM6IDNmOWRlNjZmOGFjYiAoImRybS9pOTE1L2NkY2xr
OiBGaXggdXAgQ0RDTEtfRlJFUV9ERUNJTUFMIHdpdGhvdXQgYQ0KPiBmdWxsIFBMTCByZS1lbmFi
bGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGlu
dXguaW50ZWwuY29tPg0KDQpMR1RNLA0KUmV2aWV3ZWQtYnk6IFN1cmFqIEthbmRwYWwgPHN1cmFq
LmthbmRwYWxAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9jZGNsay5jIHwgNiArKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jZGNsay5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9jZGNsay5jDQo+IGluZGV4IGE1M2Q4ODcyNzE3Ny4uOWU1ZTE1YjBjNGQx
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2NkY2xr
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jZGNsay5jDQo+
IEBAIC0yMzgxLDggKzIzODEsMTAgQEAgc3RhdGljIHZvaWQgYnh0X3Nhbml0aXplX2NkY2xrKHN0
cnVjdCBpbnRlbF9kaXNwbGF5DQo+ICpkaXNwbGF5KQ0KPiAgCSAqIGRpdmlkZXJzIGJvdGggc3lu
Y2luZyB0byBhbiBhY3RpdmUgcGlwZSwgb3IgYXN5bmNocm9ub3VzbHkNCj4gIAkgKiAoUElQRV9O
T05FKS4NCj4gIAkgKi8NCj4gLQljZGN0bCAmPSB+Ynh0X2NkY2xrX2NkMnhfcGlwZV9tYXNrKGRp
c3BsYXkpOw0KPiAtCWNkY3RsIHw9IGJ4dF9jZGNsa19jZDJ4X3BpcGUoZGlzcGxheSwgSU5WQUxJ
RF9QSVBFKTsNCj4gKwlpZiAoRElTUExBWV9WRVIoZGlzcGxheSkgPCAzMCkgew0KPiArCQljZGN0
bCAmPSB+Ynh0X2NkY2xrX2NkMnhfcGlwZV9tYXNrKGRpc3BsYXkpOw0KPiArCQljZGN0bCB8PSBi
eHRfY2RjbGtfY2QyeF9waXBlKGRpc3BsYXksIElOVkFMSURfUElQRSk7DQo+ICsJfQ0KPiANCj4g
IAlpZiAoY2RjdGwgIT0gZXhwZWN0ZWQpIHsNCj4gIAkJaWYgKERJU1BMQVlfVkVSKGRpc3BsYXkp
IDwgMjApIHsNCj4gLS0NCj4gMi41NC4wDQoNCg==
