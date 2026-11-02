Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616502;
	b=1Aj3nM5ekL6wamv4H5IkOzvY+hf6oF79Nd3j0hXokBiHOxlyo+6buJfksWMSfpP84Ue7
	 H5d2S79vx4UOjA92YTOD/DQWbFkHTbXXKuUiKIoxuEHMsNFzcRyEDPNaJpNZv4J0IvXSH
	 qau/8EOmHb+9A4MoOtpUTyU2ESHUGCPSGgwHwA/vC6JVPfgMQukLD0Fp4NHpTX0Jah/ss
	 q5fCh9Y+LFg5BOPN7/YdQ9gxYuqUHnyEkTat2Hw3PqTvbzUMNJCqJt6tcgn6ZQAhzhP28
	 RNp8rc9d+PGdVgrZ9CkgFKnoVzlb65tdlZHJ3mTJl8D4YWkUk5QCkpBjTXX09SkW0bQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616502;
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
	bh=lmC8/eYUz+ZJJIv7kFN94H6qGa/9/ms+uXSKUd9IQoU=;
	b=EnXtdOM2Xh6Mq15LF7hQHkd/iFpkZz26ZRpYY34ebpam5UQYgSKBsyY24eHrxG18/36G
	 79RAycvppoqqHi6Im6pqQ69UY4glhhHiWzZhCmkzUMlKasNOfur7RQa8s9DUnLdh59myp
	 MDmTZm8Wgv7IOK5pqXWGpcPJIIT/wh3QFIveAHUXIq4h/s99aF13awlpk+Zbq1QJn+Z+b
	 uymC1oaBm29DZXvD+W8yS7B7/DvGwjYURsTnZJDK+DwogP+Sm656ZhhdgQIjb4jiwL7DY
	 1AcYwX2pCgvqZNVkJ8Mp+DirxgtmRPBvyU+hAD/2CjhLPIBbm7y3MPQ159rM3BkOeUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fHaqWd5a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6D606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBE6D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fHaqWd5a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616502; x=1825152502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lmC8/eYUz+ZJJIv7kFN94H6qGa/9/ms+uXSKUd9IQoU=;
  b=fHaqWd5aTb2OHvjciQ71AmEZiBekUx6aD++XZlKEqcD+GrYlaKpy8YCw
   T+AcZoE+8SVi2VzoU0c3wUQsGspzullvtsQcZfl/qARS6uOZE4m0PLwu3
   YAh7NUYp1EILITuBHKmHU2apECvFjF0cjIxBMmnTfbpOef0wFdiY2ny1y
   al8rS/pPVkJXdDrDhRw7s6l9MLl2G+ClchDWAmM8/dXyPt3eG+E+7vvnc
   HT0MU+aSsWBRzqBw4yzbUavCd4GXlfqydSB9kWuDZCqGzPYgxx/xTwSez
   5PTQMWZkV91REEBPGgGnEuQeXHKSj58BFDPipllh7rDrzjopscoT7z4tG
   Q==;
X-CSE-ConnectionGUID: /PUPBFrcQk+3+xNPyVvwig==
X-CSE-MsgGUID: R4RgUKchSu+F5VD4R/18Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305300"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305300"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:48:21 -0800
X-CSE-ConnectionGUID: Uqmvs6fkSAWPTjB6sFm0pA==
X-CSE-MsgGUID: 706+QU2TS2igMdxBtHHWOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5944161"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:48:21 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:48:20 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:48:20 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:48:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPvJQrX8HXPYpXQ+9KhMucAgceeHRuZ5oyq9CRfUs9LHsZtEqSmUT903TaKm2U3UeTHvTwK4TAmOnbDzSLsEULTTzuAnFl0RthfXyWN4dNMy67QTKBnA/1pu2viX/ZVCJM5fy4bqLquj9o8rBRbWZYXIzqKouIIUsr/mRtSBHRS8L5oiQ2NMiANfeFcU//RdbisalN2/KE68KJc09vLcNz7kTsTbxFLTLZCE//ZavHdFEv81pm4cdGdjgM/nVVQWsVfPGAclmZLTFuu7tdsHOewpLAKF50Jm35uuRjRWjjuXkT1Oynjl6NBlKYjMDrjoEmmndkBygN7Km/CIpMMpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmC8/eYUz+ZJJIv7kFN94H6qGa/9/ms+uXSKUd9IQoU=;
 b=iF1h9Gp5itG/6/fZfGjzDK93NCyH73Y8iWX5Dz6FDYSbZNOf/QE8gefvOZo1hQzVRcdQKdh4BSeWHKxqpk17tjPAVHdw5zb/USXhdu+sxA+MwrCWitaJtEIs8GC34ztR5KNZJ1oTsSW4pguWoNQeie85w6F2FguU+p4Ec+v2HnihQmKUss0ITUsAZHqr7okn0qGGp+up7vcELn+yjRXpDezKy8zFEvLz8jD7QwFkfYrB29MnLc7mxLCzEnKGxOCwc8TZVqulXUNOpN4r6a/tGrqpqNr/k6QK3hUtUkT+nh80jK8IRIqdVrqKsyUcEePdQiNMT1ueiFQsDcDcMRcwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by CO1PR11MB5106.namprd11.prod.outlook.com
 (2603:10b6:303:93::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:48:17 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:48:17 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Deak, Imre" <imre.deak@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/6] drm/i915/dp_aux: Take the TypeC port lock after the
 PPS lock
Thread-Topic: [PATCH 1/6] drm/i915/dp_aux: Take the TypeC port lock after the
 PPS lock
Thread-Index: AQHdZ5kD9+1it9NCpEC5qw9CU4U0ArcaoA2A
Date: Mon, 2 Nov 2026 10:48:17 +0000
Message-ID: <DS4PPF69154114F90C4A65464CFE9C13EDCEF6A2@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20261029113017.618286-1-imre.deak@intel.com>
 <20261029113017.618286-2-imre.deak@intel.com>
In-Reply-To: <20261029113017.618286-2-imre.deak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|CO1PR11MB5106:EE_
x-ms-office365-filtering-correlation-id: 689277b1-520f-451f-99c0-08df38cecd70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|11063799006|4143699003|56012099006|261009221227099003|261009223027099003|261028144727099003|261021123027099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: DS5qz5ID3Bq9v8dNNt2GfimPwAv3D4cFkE3dxu2DFYwer5mDWiwDk1F8alGln5dNFYlWzfSoJ7q9m4e8ISncYEOIz81+6uDYifIEjIuMr9zzpIIkI2AtTilGairrfBFR54gyxkwygauI4qE8aiCfwsnnEcdzJsqLC82HMkkS4uk3vvkLGXk+A36Z4S9GkcVARkJfSaqkbcszG+ZqGTEI1DSVNWN1ah5hl5hebDUKZ3bFmNg/kVIQ7uLbF0ZS1g1eB5w04KntzjZnLJtK23St7BBLbNyvhkUjU/7sgqNBC9x7LS4otOVsT3kD2VESLylbixXdWQAcV9dJY0AoDwxf/L9oxW42f4UUCWguw0kMnyWHuTMg1CebjwpUOzMNhvdq/f7+N5IC/eQRFz9/rXzW8S0H9kO1p8qXuGJe+KgNUfiudE2aQfoeRR9E0fSITlZE0hKwfXJLUsbpCaq7IuY4yStxCt7LnAR9bK9rJe04gZlfvfJx/k3iZcO9sS9jDPfTN7LzKKXfV/jE/iqf0Ly6TQsfXq3Hkk0ND19gQ+T1O5hPeGXJgRQ9N31d1EaGKi2vUBDf2HNG9Zp8DbW27FrjraCvBfrNbGOyDLsMvLqVDl3z/XPN4ihVrdSg2Ob2ec+EPuSwfncLJ+iibgC+3I20nBG6PUj/1iYf5LB9tLpkRhdSk6g346VJKu4088s1dvzs5JWt/PY2CSaVGy7Iz8bdg1LYuWktj0TyruccXqGsGLE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(261009221227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWlLNHZGUzZuS2FkS1RFNlRjRXJFUVBPTWZEV2hVQ3F0Q0U1bnpkU3c1Q3dJ?=
 =?utf-8?B?TS9KRElwWWtMd0ZXMlh4VktwTVl6Z1NSNTBsS3V4OGtkWkRBVzdJYVlxZlA0?=
 =?utf-8?B?UENLcmFnaFQwU0lGTTAyVGQ4UkhHMHpxK3ZYejQxNDA3Z1hheFcvb1hUbDln?=
 =?utf-8?B?bUtGcnNkcm1HWjVHSXoraExMUXdISm5nZWhTTDNSRUpyc1V0N2ZTemk0VUlV?=
 =?utf-8?B?M3ZDZE13VHZ1REVacXBDOENkNHowUUVDTWFkN1ZFQlptZkgrMC9UMzFvbVFm?=
 =?utf-8?B?Q0hXaHdEdmE1V1MrdHRFT1ZXZThEVEVuQW5vRVZNNXdHMUtyZ2pOOGVEaGhF?=
 =?utf-8?B?dklVWHZIYkN1dXB3Ylh1OEc4OUtVcXVveXJubjJ5SjBuVHk4ZG5RRzl4b0pY?=
 =?utf-8?B?QVNaNmxiVE80MmZiTFJOUGx3T1VPREVPbUJiSW80US9qNnp1NGdpdnpORmtj?=
 =?utf-8?B?aEFGTzRJdXBIRE4rODZ6SnpYVUpaaldFL29nSCt2bWh5YTNOT0RIc0Vna3JN?=
 =?utf-8?B?SUtlTVY1dlVtRVRuYUNrZUgwSEZ1R21LVlovQU42UHh6UVBzNzYrdk9OOGdT?=
 =?utf-8?B?UWcxSDNKQUhXUjdZWDlSeXkrMytUYTRrMEhvNVpTZzdlMDh2U2lNYkdkWWpO?=
 =?utf-8?B?OVd2NkMzZG9hV0hEQlNCMndqR2RpNmF0NFF5Y0JZTkxzOTNScDIzODZnNFVQ?=
 =?utf-8?B?Yi90V2hXZHh5cHNhY0E2Qm9zejk2UEI3Nks5WkJjZW5WV3dkYmRDRDZFRFlS?=
 =?utf-8?B?UkRTYkRnM1ZRZFJpb3hUSW0vLzh2Z1lyeG4wUCtwTTZNeGM2UW1POVFKM2xZ?=
 =?utf-8?B?L2Z6SlpoZG9xSTkrMUFwZ0phMFFnM3NJVXYyRUljRWNSOERXTTdMQnRlMGQw?=
 =?utf-8?B?QTRBeUx1Rm1oK0hDTVZSMzZIVGlTR3BCc3p4SzhNK2ViMklQaXArbHZSeXZH?=
 =?utf-8?B?WlZabXF6RnVoaGo0bVRHb2w3VEtxZGswckdHZVoyQ2R3VHcrT0pUZ2R3cWRk?=
 =?utf-8?B?UDBMeEtwQllKVXR2UG9hR1g3M3g1RXhtQTRrNDIyR05teXA4eE8zMjRJa1lH?=
 =?utf-8?B?NmFQUHkwM1JYeFg2MkVKVk9nOUNTYkplTS8ydVlxdVdLR2VXOUdQVm9lQlJk?=
 =?utf-8?B?RGdDR1drN2w3dnVnRUtqUG1BZm54bThBSmNVK1N3bloxQThQYTVWRW1YYTlW?=
 =?utf-8?B?QkYyc2toK2I4WVNHbUZwcnA5SHhzMFZsQy9Nb2pjSnBZdHFNY1VBYnh5THJ1?=
 =?utf-8?B?Y2FnRk9nUnBtSnd4clRsRFBscmhGak8rRThNbDJxNmRkcjhoV2tLdWlXUFll?=
 =?utf-8?B?ZXRQNW9KTFFJRlZGcWFQTEF3MWZUTmYzMzEwaWNtdy9JbUROMHh0VStYYTFS?=
 =?utf-8?B?L3JoeENzazdIeUd4UUYwRm9mOTM1OTUva2F1V0J0VVZmeXVIYzg2bXBXcHVw?=
 =?utf-8?B?YXRTb05EdGljRnFJTDFWZThWcEh1MmxqZEtoY2xnQWlBTzVGRHhGNDhsaWpt?=
 =?utf-8?B?NUdzb2VlTlF5dDJkVG1YUTRja0ZmZXVBc0lOK3ljMlgxWGc1dmZsSlRQRHh1?=
 =?utf-8?B?UlQ2Y01TU1N2T1RCaWV1RHduV3NrcVpDSDFJYm9LNllVQnM0MWxmUjlzVE4x?=
 =?utf-8?B?eHhOS3VVcXJWNlMrUXBkYStxMTU0UlZPeitHOVdkN3FrL2NCOUtBamZEbGZY?=
 =?utf-8?B?ZmdlZHVRSCs5Q3VaMlFadU1zREoyZEhvTHdEL2p5dk1JdGplS1hWWU80WmJS?=
 =?utf-8?B?Qk54U05Qd3ZPbS9mczE3bFZ3elBKeDhYeThiNTArZERGelM4Njl0QVlQMmc3?=
 =?utf-8?B?TTdHUXB1a1RMUWhUVjVFZjJEaURtZzc5S3czWHRJOTN6Y29ROGw0dUxEUXBY?=
 =?utf-8?B?ZlBRNlU1dlUzcFJZTDBrSFRiUWs0ekpEc0l4NUlEVU9RdDg2ZlBULzA0MzBr?=
 =?utf-8?B?aDZHYWdPVmFla2djL3huUUlDR2V0UXpQdTRtV3RPbmlpcWovdlJHVDFpamVF?=
 =?utf-8?B?b2ZpNWo0YUhZb2FJWTZ1MU9hK2Nic1Q1dnNMVCtlZHhKZDA2WU9uRE1pb3FQ?=
 =?utf-8?B?WktieVR4RTZuUjhtamg2UWJqYlJSUHJyRWo1T2NxZkw0TmFIbG00M0VxbmZo?=
 =?utf-8?B?cXpCakhac2hBYmk5VXJaR09KMGNsbDN3ejlWTXZrSTlLUlFBMVBFUlpnWjZR?=
 =?utf-8?B?YUtJTklLUXAyOTB6YjVDa2JicUNGYXhzd3JQTGJwZFBOVjJtNk44VmZwb2xh?=
 =?utf-8?B?eHNYcFl2Z2NBc0dKdzBQY1pkUFhTelhvRTNiVUtQZDA1VXVDaE00RDNyYmhU?=
 =?utf-8?B?cjFXWGRveTBVNGtPcGhRUHIrNWtKTFJ2ZENQZUZXTCtrSURvVVlBdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3p6WjO6a4BvDlvxNNJq1DIzdpE+k7zssowhugP3g9BRdHBHK+3nwCykb66G/Tynvyjc519joDlA5PSzdZotDe6guuW4N22mwH+a1va/xt0wboQfaKy2RjUK07ablIjLX2nxo/u5Gwh2RFl4rX/Gu8t52mx/Zac7mb7lqklk2c/rvVs3LrDmnV25dvHgwLUj8JDf5a/nKrGEdaoPHeUBI+nWrlTJXTbNN4d93QTiuk+zRXCyOtr8h/qfYfzTsyLmzYr5uxqwvoRKZ/Kiqxn8sSr7n8+0/tS4xbiCRkQF9QXObae/ExiRqyNYHyJGLDI/eEYH1ZQl1QuV/DEboW1lP7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689277b1-520f-451f-99c0-08df38cecd70
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:48:17.0605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zTNuwfxTaIoWXTLw4vQcidyEulPBVckax50XtFGKkSSdSV0MMO54MCdj1v6rnrPVI1+aTijUpYqjUBREgLsCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC14ZSA8aW50ZWwteGUt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBJbXJlIERlYWsNCj4g
U2VudDogVGh1cnNkYXksIDI5IE9jdG9iZXIgMjAyNiAxMy4zMA0KPiBUbzogaW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCAxLzZdIGRybS9pOTE1
L2RwX2F1eDogVGFrZSB0aGUgVHlwZUMgcG9ydCBsb2NrIGFmdGVyIHRoZSBQUFMgbG9jaw0KPiAN
Cj4gQW4gdXBjb21pbmcgY2hhbmdlIHdpbGwgbmVlZCB0byBhY3F1aXJlIGEgVHlwZUMgcG9ydCBs
aW5rIHJlZmVyZW5jZQ0KPiBhbG9uZyB3aXRoIGFuIEFVWCBwb3dlciBkb21haW4gcmVmZXJlbmNl
IHdoZW4gZW5hYmxpbmcgUFBTIFZERCBmb3IgdGhlDQo+IHBvcnQgZHVyaW5nIGFuIEFVWCB0cmFu
c2Zlci4gQWNxdWlyaW5nIHRoZSBsaW5rIHJlZmVyZW5jZSByZXF1aXJlcw0KPiBob2xkaW5nIHRo
ZSBUeXBlQyBwb3J0IGxvY2suDQo+IA0KPiBUbyBhbGxvdyB0aGUgUFBTIFZERCBjb2RlIHRvIHRh
a2UgdGhpcyBsb2NrIGl0c2VsZiwgYWNxdWlyZSB0aGUgVHlwZUMNCj4gcG9ydCBsb2NrIGluIHRo
ZSBBVVggdHJhbnNmZXIgZnVuY3Rpb24gb25seSBhZnRlciBsb2NraW5nIFBQUyBhbmQNCj4gZW5h
YmxpbmcgVkRELg0KPiANCj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2LjE0Kw0KPiBT
aWduZWQtb2ZmLWJ5OiBJbXJlIERlYWsgPGltcmUuZGVha0BpbnRlbC5jb20+DQoNClJldmlld2Vk
LWJ5OiBNaWthIEthaG9sYSA8bWlrYS5rYWhvbGFAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcF9hdXguYyB8IDM5ICsrKysrKysrKyst
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDIwIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfZHBfYXV4LmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwX2F1
eC5jDQo+IGluZGV4IDM5NDMyNmQxN2UwZGEuLjYzYmQ3MmU1MzdlYzMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHBfYXV4LmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcF9hdXguYw0KPiBAQCAtMjY5LDIyICsy
NjksNiBAQCBpbnRlbF9kcF9hdXhfeGZlcihzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwLA0KPiAg
CWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGNoX2RhdGEpOyBpKyspDQo+ICAJCWNoX2RhdGFb
aV0gPSBpbnRlbF9kcC0+YXV4X2NoX2RhdGFfcmVnKGludGVsX2RwLCBpKTsNCj4gDQo+IC0JaW50
ZWxfZGlnaXRhbF9wb3J0X2xvY2soZW5jb2Rlcik7DQo+IC0JLyoNCj4gLQkgKiBBYm9ydCB0cmFu
c2ZlcnMgb24gYSBkaXNjb25uZWN0ZWQgcG9ydCBhcyByZXF1aXJlZCBieQ0KPiAtCSAqIERQIDEu
NGEgbGluayBDVFMgNC4yLjEuNSwgYWxzbyBhdm9pZGluZyB0aGUgbG9uZyBBVVgNCj4gLQkgKiB0
aW1lb3V0cyB0aGF0IHdvdWxkIG90aGVyd2lzZSBoYXBwZW4uDQo+IC0JICovDQo+IC0JaWYgKCFp
bnRlbF9kcF9pc19lZHAoaW50ZWxfZHApICYmDQo+IC0JICAgICFpbnRlbF9kaWdpdGFsX3BvcnRf
Y29ubmVjdGVkX2xvY2tlZCgmZGlnX3BvcnQtPmJhc2UpKSB7DQo+IC0JCXJldCA9IC1FTlhJTzsN
Cj4gLQkJZ290byBvdXRfdW5sb2NrOw0KPiAtCX0NCj4gLQ0KPiAtCWF1eF9kb21haW4gPSBpbnRl
bF9hdXhfcG93ZXJfZG9tYWluKGRpZ19wb3J0KTsNCj4gLQ0KPiAtCWF1eF93YWtlcmVmID0gaW50
ZWxfZGlzcGxheV9wb3dlcl9nZXQoZGlzcGxheSwgYXV4X2RvbWFpbik7DQo+IC0NCj4gIAkvKg0K
PiAgCSAqIFRoZSBQUFMgc3RhdGUgbmVlZHMgdG8gYmUgbG9ja2VkIGZvcjoNCj4gIAkgKiAtIGVE
UCBvbiBhbGwgcGxhdGZvcm1zLCBzaW5jZSBBVVggdHJhbnNmZXJzIG9uIGVEUCBuZWVkIFZERCBw
b3dlcg0KPiBAQCAtMzA3LDYgKzI5MSwyMSBAQCBpbnRlbF9kcF9hdXhfeGZlcihzdHJ1Y3QgaW50
ZWxfZHAgKmludGVsX2RwLA0KPiAgCSAqLw0KPiAgCXZkZCA9IGludGVsX3Bwc192ZGRfb25fdW5s
b2NrZWQoaW50ZWxfZHApOw0KPiANCj4gKwlpbnRlbF9kaWdpdGFsX3BvcnRfbG9jayhlbmNvZGVy
KTsNCj4gKwkvKg0KPiArCSAqIEFib3J0IHRyYW5zZmVycyBvbiBhIGRpc2Nvbm5lY3RlZCBwb3J0
IGFzIHJlcXVpcmVkIGJ5DQo+ICsJICogRFAgMS40YSBsaW5rIENUUyA0LjIuMS41LCBhbHNvIGF2
b2lkaW5nIHRoZSBsb25nIEFVWA0KPiArCSAqIHRpbWVvdXRzIHRoYXQgd291bGQgb3RoZXJ3aXNl
IGhhcHBlbi4NCj4gKwkgKi8NCj4gKwlpZiAoIWludGVsX2RwX2lzX2VkcChpbnRlbF9kcCkgJiYN
Cj4gKwkgICAgIWludGVsX2RpZ2l0YWxfcG9ydF9jb25uZWN0ZWRfbG9ja2VkKCZkaWdfcG9ydC0+
YmFzZSkpIHsNCj4gKwkJcmV0ID0gLUVOWElPOw0KPiArCQlnb3RvIG91dF91bmxvY2s7DQo+ICsJ
fQ0KPiArDQo+ICsJYXV4X2RvbWFpbiA9IGludGVsX2F1eF9wb3dlcl9kb21haW4oZGlnX3BvcnQp
Ow0KPiArCWF1eF93YWtlcmVmID0gaW50ZWxfZGlzcGxheV9wb3dlcl9nZXQoZGlzcGxheSwgYXV4
X2RvbWFpbik7DQo+ICsNCj4gIAkvKg0KPiAgCSAqIGRwIGF1eCBpcyBleHRyZW1lbHkgc2Vuc2l0
aXZlIHRvIGlycSBsYXRlbmN5LCBoZW5jZSByZXF1ZXN0IHRoZQ0KPiAgCSAqIGxvd2VzdCBwb3Nz
aWJsZSB3YWtldXAgbGF0ZW5jeSBhbmQgc28gcHJldmVudCB0aGUgY3B1IGZyb20gZ29pbmcgaW50
bw0KPiBAQCAtNDUwLDE2ICs0NDksMTYgQEAgaW50ZWxfZHBfYXV4X3hmZXIoc3RydWN0IGludGVs
X2RwICppbnRlbF9kcCwNCj4gIG91dDoNCj4gIAljcHVfbGF0ZW5jeV9xb3NfdXBkYXRlX3JlcXVl
c3QoJmludGVsX2RwLT5wbV9xb3MsIFBNX1FPU19ERUZBVUxUX1ZBTFVFKTsNCj4gDQo+ICsJaW50
ZWxfZGlzcGxheV9wb3dlcl9wdXRfYXN5bmMoZGlzcGxheSwgYXV4X2RvbWFpbiwgYXV4X3dha2Vy
ZWYpOw0KPiArb3V0X3VubG9jazoNCj4gKwlpbnRlbF9kaWdpdGFsX3BvcnRfdW5sb2NrKGVuY29k
ZXIpOw0KPiArDQo+ICAJaWYgKHZkZCkNCj4gIAkJaW50ZWxfcHBzX3ZkZF9vZmZfdW5sb2NrZWQo
aW50ZWxfZHAsIGZhbHNlKTsNCj4gDQo+ICAJaWYgKHBwc193YWtlcmVmKQ0KPiAgCQlpbnRlbF9w
cHNfdW5sb2NrKGludGVsX2RwLCBwcHNfd2FrZXJlZik7DQo+IA0KPiAtCWludGVsX2Rpc3BsYXlf
cG93ZXJfcHV0X2FzeW5jKGRpc3BsYXksIGF1eF9kb21haW4sIGF1eF93YWtlcmVmKTsNCj4gLW91
dF91bmxvY2s6DQo+IC0JaW50ZWxfZGlnaXRhbF9wb3J0X3VubG9jayhlbmNvZGVyKTsNCj4gLQ0K
PiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiAtLQ0KPiAyLjQ5LjENCg0K
