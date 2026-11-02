Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616605;
	b=wjSoxNwtjnmlPldchfeGL+iDwTfLSL6Rxr7YClUhqmvj0CVIIhMV53FtHXyrdRTby4uk
	 wFYyCzVoiKOpAwGCu5XGa9q30sWtqz/Y5ofbXQfhWaxKgsxb6CGr11BjgregOymeEkawb
	 1YIJUA5BFzwWWN8z51WhcShCcGLVA3tOyqhEzTOdd55S9hn60T+LIgrRJjl1+Ly7sXN7f
	 kaUNtAKqYMOYRY3LGD1TNIrYLEyas3DYNAqm9UaLdb5SzEln01BtBk2Gk5L4jyB8/RT2g
	 Shx99trckyJ+zKtl5gORu+xIDGjSKcxJU9ZsoSMCEzD9TPwWT5wRBRztgAh85ypeATw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616605;
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
	bh=tqAHL5TWpS5NxzFyhOD8iGGSp8EHv3eqZUZrjIZ1wq4=;
	b=y0No14JCQMhqU28ZTOQ4smfURpQEaqTpVmo49MJOoABd8JB32o4lDfTK2h/p/t4HBzbo
	 jfX0NTSsHVu8/DefE0xuqNBPmJdC9iDEQIM7oJcUyLuxKHC28uElKGnZMHbRfF6JihQIg
	 jsDQdJoI7w1mxkLDXxh8ZihQ+YcHmHSNLMHoLouy1whQWMaylSCsbBeciXZvAPEHMfv/1
	 b+W5HDVzSh8tD0bEXNbtyZmgs2BLgdVCx9pu131h91/hMhAWCFzjKPNc5CNnVuL+oITk6
	 SnRzDKip8CCAnHixYd8EZb3dYUBwkvd4AOoJ84k8b/Cd1qrrDV54uXY1HA5bCOluTgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WDAs8kxU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384A606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A384A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WDAs8kxU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616604; x=1825152604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tqAHL5TWpS5NxzFyhOD8iGGSp8EHv3eqZUZrjIZ1wq4=;
  b=WDAs8kxUJxkzGPp0tB2UPLHMjE8wp1GLnKabol3Ztdl4tiO8KN/Gmvxk
   wbfZIbYxYk5fLtGdJ2bXAkRjZHw3WaeqwHDGNBdIZq2ZtULCmDiJqduok
   zlk0Um/C1CR8S5BY3KfIzU+taPrT/0yugASRaDdeyO6ypzlvQF6HtApJQ
   ZMziuBUHRHk/adB6CU0gNky5eQ8H/hzbBp1r0cxTTxgK7MJND5jPzCsgL
   NtnQQCjYCnADb+7FxdK+tF2gJMmFN9MHDhxBAu6j6q7n4i11eLu4UjwIK
   UJX4i1TCHeOhRj9b5Ek7VRlAj0F/CwLfW/2L3BmOCm0mZ3Zm8mpvf8VoR
   Q==;
X-CSE-ConnectionGUID: K34bu6hTS/e/Xmz+pqYSRA==
X-CSE-MsgGUID: v5FgULRoSzGxPTbWSfoIsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305539"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305539"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:50:04 -0800
X-CSE-ConnectionGUID: cAQFExGdQoOyjMM7uqKpHA==
X-CSE-MsgGUID: TOxr6RCCTQa3vBAETHGvgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5944390"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:50:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:50:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:50:03 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:49:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKbgYXrKyyzx8o+0GziAnH5wIyrH5LHz69+uEA/Apiqd43FRwTIB/xwOzESV2qzi9XreL9/24vCsOvqRU6gNLsVt7CNiJonLm2gNXeLNGyv1m5BHzPS0iQbKDNmFXIuFz37ZpUgDi6BNvFMYsxLM2Rq12tPhe8nJMllIQT/+XO/MFr6Otg2PfADMI7cw96MR1gdBTaApbReJJ8I0Yd/OZR0aeqd4MXDklf0xvJ8UrTOUczzTmCBPzMdNG7FBaW8SITxWLNGZ3o2/Hb3jZ7fhrk3/6RJ+Knx3RK7XiPRc6zesjKCUzHO0ixWLVbcKYWXFxLBOyzZK+sbRvVefDVXBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqAHL5TWpS5NxzFyhOD8iGGSp8EHv3eqZUZrjIZ1wq4=;
 b=Cj51GHvgvHl6wX4HxiYrralFSNbTX3wMugSt3yoSRreEchnd/2XxYOLvSzD7syNHOBtbCq1ofH7iS8FixuUtus98JnsK2pWR1ZDDlm7yyPXk1qk+RlTvlnBFC8iQJ3jJJdhQ+d2ba1eec/TLWeUyrx4ePX+TyHU18p2yMfHfp7JQMobazudoSQ73HPzETPxdmyD/AB02GqsHGPCtzmlDh2haXLQMs3NiuHFZkBF/jyYvWsk+Tls1gS4rA9LI34UT/VuY+lSxZWawLO4bGPdQSnpJuLv6wFy4bBJOOoi1tahLcoMEd0x8HsOr+aljWy/X8aI981EHgfHqySpGmw3+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by CO1PR11MB5106.namprd11.prod.outlook.com
 (2603:10b6:303:93::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:49:35 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:49:35 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Deak, Imre" <imre.deak@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/6] drm/i915/pps: Hold a TypeC link reference for PPS VDD
Thread-Topic: [PATCH 2/6] drm/i915/pps: Hold a TypeC link reference for PPS
 VDD
Thread-Index: AQHdZ5kBEvs0SUz6OEijmfkT9RXI+7caoGfw
Date: Mon, 2 Nov 2026 10:49:34 +0000
Message-ID: <DS4PPF69154114F14DCD066ADEEE24605EFEF6A2@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20261029113017.618286-1-imre.deak@intel.com>
 <20261029113017.618286-3-imre.deak@intel.com>
In-Reply-To: <20261029113017.618286-3-imre.deak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|CO1PR11MB5106:EE_
x-ms-office365-filtering-correlation-id: 99009e06-144f-4d31-dbb4-08df38cefbdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261021123027099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: 0hvnNL38ERY6lOA7E6Z3NxfyI4wuSzL9JOXMRKC443IF5uUIzVx2t76cisvFv6FI59Sp1DiySCoRg2WIH5VbvjKkYyUhdFTKW7oJnLEs6n92EChyCyh/iKTKzCtsVuO5LM1Kv+gUsyovvojqUqM3PgNaKnAH7Uz3L9gHKQlmeYSqqCkhBL5Hxx8MQwcz5GPf+AnmEU9CG7POlXEWYrc/URsMTzQYAVzc1IOTHHpyY5hWN7Neasuvhbzb6pmMRAR/1baI+qh0+Rvyt/eV0RVLoeR4N7iHkmgXpQ6Y+V1tFbxwioe4hpp4/KcxQXM/6WAxKiaisj6oejVx0ZAxsICq5PZ3G9JwIcNzn3w0TyneZMmYcQywMg/nQzdXpabqzug+6Wj1BD1IIzTfMAPvKmM8jfxXi0/95kxZ8Ez+BjCxIEj3OTUSRFfMNAN7JgBMvqoWozTb9YzLLa7t+2CwyiE6+4ckmxTqSZLKUrMwTHoVad9quSc5FIhtJW+TzTivNEld3n0+SYqRbEEn051kwlybxKzWeFdNycQd6iFOW5ZWxTVu8hf+nHdc2Ovnj3srdF0/07CDLQPV7DzR/VP1uT2eOnSRQnsrjimvm3NCvv18kvrQEiI8NGNcVStLFl6hEnxxqaxcOCcHlhVF3CYErD9F9tBcTZCi9K9n75/LBwiIIj4iEHMAWZAtTmjtp/5mk/lvJcZL0zBQ3caWdRJhG6XctS3YeIF/6CKR05qqwtl14xQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzlUdVJlUXUyUnVoaFZtQnVUMTJ5ckd0MytkRW5LclVOOU5lbUZTZmEvdmZY?=
 =?utf-8?B?b20rY05YT24zSE9oVEFROUJpMWpYZG1LWVpJZ0lzeVBvdDB4YjUxV3RqdFFF?=
 =?utf-8?B?ZlFpL2wvMGJvRnp0UEdlUGxvNHRrOVpYdE1uRDF5V1hVVCs2MUx3WjB4cERL?=
 =?utf-8?B?VlZhL0o1MjF1L1kyTUxualBweVNITktwWmpha1Jld0VuRTlvUFNIMjFqSkNx?=
 =?utf-8?B?VEtISWt6a3FUbjByN0JEUWg1LzA3aks3QkZiUDc0Yyt4WU4zRWxTUVBKQjk2?=
 =?utf-8?B?M3JRSWVaaCtYV0JCUTduZXVCcTc2SFRZWGN4QW0vc1F1OXlWNWxNa21TZ2NS?=
 =?utf-8?B?VVRzNFpnQmlLdUdZNWN2a3grVXJsdUdIb3QxYmhZbGVjWTdPWlF4bVlCalBE?=
 =?utf-8?B?N1pZTEE0c1JDTlhnc1BKTXBXbXNXVjNmV1JSOU1qVWoxMnpyUTBGM3FHdEph?=
 =?utf-8?B?bDZlZ0NMOUM3Qlc4VnRQekR3eDdZMEw2SU81ZXZxVU1tV0Jlb095dzdqWmFp?=
 =?utf-8?B?ZHFucTZsSTVUUVZuVnowVlZ1ZnFqNWlkd1VIR1c5VHNuYUVDNXcyalp4em9u?=
 =?utf-8?B?ZzJrU3M2anRid3J0UHUwdXJjWEhMUEpLL2ZVc1ZuUGYvWGJzMHBNaHB2QnJ1?=
 =?utf-8?B?b0xna2x6Zi9TUDY5Nm9PL1cwdjRWczgrWmc3WkRpRVlQUEF2aDVROGZQTjVQ?=
 =?utf-8?B?VWFQZ1NlT2VPdlBVQXBIWjJMTjVGc3hScVVzL3owWG1vU3BVUkNRL1lvZEFC?=
 =?utf-8?B?NUMxU2I2WjhmSisxUXpQaEl0Zi81NVNFZmdETTlOU1F2NXpDcjE3YVkxNDNh?=
 =?utf-8?B?R2hFQTh6eVc3elN4a1pubFBBTFYxTjA5Q2F2WkJVQzlLZXVjYW5lVmY3c01V?=
 =?utf-8?B?NXMwT1hXMzB0TEZ0SWVsMldnTnorb0ZHTFh5WDZNamdRVU11QXRzdkJzU0hJ?=
 =?utf-8?B?aUdxaGVocGFCK1ZhbXFTMlZOZnhUa3hwSUJOUERkOCtEQWx0QWV2QTB6RmJL?=
 =?utf-8?B?d2FZajFMNHVadXZ0TGJuMUF4WUVOalRtUEMyUzRKcVk3dEVFT3VmZjgxTFFB?=
 =?utf-8?B?Qm1HbC82QXVmTnJkbDVwbGVPV2doV2cxcTBPWWMyeUkyY1htOXV4eU4xY3RO?=
 =?utf-8?B?THk4RThZZmxwSFZ6clZ6R0JCcnVjZWwzMFdBRk9MSGRJSzZFTmZUcUQ3Ly9E?=
 =?utf-8?B?Z09hZUgvcHYzZmMzSnNVY0pUczlLeGZiMTh2T2tqNmNCNVJjZ05zeXBwSnVp?=
 =?utf-8?B?WU9vc3cxOG9HZzRUaWN2NGlNWS9zd1ZVY1NuV0VJQkxpUTZKUTJMc0ZjMjVm?=
 =?utf-8?B?NFk3NWJWUVVLbm9YNyt3L0JkNHE3RnJyN1BxU1RBOFV6RjBOWmRid3RWMHRK?=
 =?utf-8?B?UDRrelhSc01DTXE0L29TR096MmxkaHdNZ2pjZlJkMktNbHlXL1F6YWpudEU0?=
 =?utf-8?B?N2ZNNkxMbjRHT3B6UVJvL0hVOExPQ3d3Ym1uOW5zYVpvcXM2MDR5OEVYZjl2?=
 =?utf-8?B?ODlTOWRZZHorMjVleWdPaE4vcVVCb1h5Nm5vVUg4YS9XLzRPYnpueFRZOXlw?=
 =?utf-8?B?bEd6K0RQTjFNVjdVcEtMbXN2SjNVT2kxTlNuS3hyRE10aDM1SDUwMFRHcEpV?=
 =?utf-8?B?SktGdWd0TTVaV3JFci8xR2gwNzRJMlJWK1EzNW1qcU1xdHJ0ZDBIZlFCa0Jl?=
 =?utf-8?B?MWcrZTNxTzY3enpSM1VTT21wWE9PUXVPQ3RLdENMaG9abkRIaGNyOEpJZENs?=
 =?utf-8?B?VCtWYmM5QWRxeEczelV5aEVNZ1ByWTZ6cWZSbWdrV1VKck1NanFRNk0zLzJK?=
 =?utf-8?B?a3ZiYys5eTdwbGRYdHVpSkJxc09kaHlEeS9EY3VGVmFvY3RidHlTOWxBaFhG?=
 =?utf-8?B?eEh0Q1NleE9qMjl4VTFQamhpREdDK3p4QlhITlZmaUh6WE9WTTFOUnlzdWNo?=
 =?utf-8?B?d3hiRDVyeS90SjVjLzkzeEtlcGo3bmlROFNJTFZ0ekcrYXFTVTVYWjIxNzAv?=
 =?utf-8?B?NEZITEtINE81Z3MrM01xb0J0UXRnM3VIQ1RRUWkxSVlNMUR6Z01ieHdGUFNU?=
 =?utf-8?B?QmFMUVNSNUZRYTU5eGYxY2xsaWxrcm1kMVFwNzlmY004UzdvYno3VzBxT29w?=
 =?utf-8?B?cFQxZTJxYkxnMWNzZ2Fma2t3NTAwRXRnSDMvaDlzL09xQmI5eUVwNjY2bFE0?=
 =?utf-8?B?ZzIxNFFDcmN5aEhFdFY2TkNueTU0ZDg0bnB4OUtmejB0WEhEdy84L0xzSmt6?=
 =?utf-8?B?d28xcDNyM1IzVkh3UG82UWpmb0NycWtRZzBRYlh3ZE9lWHVPM1g5eDVicU1D?=
 =?utf-8?B?UkkveVJuTEM4T3dNclBqOWtOVERWRDRLaXJBYmhTblpzaW5FN0dIUT09?=
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
X-Exchange-RoutingPolicyChecked: nSgHNDKOP8Ha5TkvytV+En3ytvwF7KsrTk85Lvu4pxBD2ivrT/TuGuHkcDoB52Gm2LaDpVH3ndQ5PpFTPwczP536ynTqc0glSbVhVKiuOiNH9Cwkmtc3/eIL/NsVAY7ztHqcw0SZWH/VJl+mbzE4oAjiaPRQYk+Rb+d6DKloqXYP3viRgZukKAtCsu7UnfJ4uRZaS8RJQeOEoQE5NRngu6YJpfuXLXFbZ2Ws4ZC9/hWzT1iIOLIAjYQT9vxmnZGnAnL7g85HI9m86NvNEB735mMMYa47Bw/6xs2mNiXmF99tch7srUp9jNcyoohJ1fUWegwUr5g3POkHZjXp8jBv4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99009e06-144f-4d31-dbb4-08df38cefbdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:49:34.9567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0XL2W/riWr5++hPJp8u1BFP1XnRDqHKQIz9IjCknqkyngbPdM5JC3xj/+h8AIXtD2mzRo2OxA9mVLqt6NJQwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC14ZSA8aW50ZWwteGUt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBJbXJlIERlYWsNCj4g
U2VudDogVGh1cnNkYXksIDI5IE9jdG9iZXIgMjAyNiAxMy4zMA0KPiBUbzogaW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCAyLzZdIGRybS9pOTE1
L3BwczogSG9sZCBhIFR5cGVDIGxpbmsgcmVmZXJlbmNlIGZvciBQUFMgVkREDQo+IA0KPiBPbiBU
eXBlQyBwb3J0cywgdGhlIEFVWCBwb3dlciBkb21haW4gcmVmZXJlbmNlIGhlbGQgZm9yIFBQUyBW
REQgcmVxdWlyZXMNCj4gdGhlIFR5cGVDIG1vZGUgdG8gcmVtYWluIHVuY2hhbmdlZC4gSG9sZCBh
IFR5cGVDIGxpbmsgcmVmZXJlbmNlIGZvciB0aGUNCj4gbGlmZXRpbWUgb2YgdGhlIFBQUyBWREQg
cG93ZXIgcmVmZXJlbmNlLg0KPiANCj4gVGhpcyBwcmVwYXJlcyBmb3IgYW4gdXBjb21pbmcgY2hh
bmdlIHRoYXQgd2lsbCB1c2UgdGhlIFR5cGVDIHBvcnQgdHlwZQ0KPiBmb3IgZURQIG9uIFR5cGVD
IHBvcnRzLiBBbGxvdyB0aGUgYWRkaXRpb25hbCBQUFMgbGluayByZWZlcmVuY2Ugd2hlbg0KPiBz
YW5pdGl6aW5nIHRoZSBUeXBlQyBtb2RlLg0KPiANCj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcgIyA2LjE0Kw0KPiBTaWduZWQtb2ZmLWJ5OiBJbXJlIERlYWsgPGltcmUuZGVha0BpbnRlbC5j
b20+DQoNClJldmlld2VkLWJ5OiBNaWthIEthaG9sYSA8bWlrYS5rYWhvbGFAaW50ZWwuY29tPg0K
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wcHMuYyB8IDE0
ICsrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Rj
LmMgIHwgIDkgKysrKysrKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9wcHMuYyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
cHBzLmMNCj4gaW5kZXggZDRjOThiMTUwZmEyYi4uOGYxYmZlNDM0MDk3MSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wcHMuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bwcy5jDQo+IEBAIC0yMyw2ICsyMyw3IEBA
DQo+ICAjaW5jbHVkZSAiaW50ZWxfcHBzLmgiDQo+ICAjaW5jbHVkZSAiaW50ZWxfcHBzX3JlZ3Mu
aCINCj4gICNpbmNsdWRlICJpbnRlbF9xdWlya3MuaCINCj4gKyNpbmNsdWRlICJpbnRlbF90Yy5o
Ig0KPiANCj4gIHN0YXRpYyB2b2lkIHZsdl9zdGVhbF9wb3dlcl9zZXF1ZW5jZXIoc3RydWN0IGlu
dGVsX2Rpc3BsYXkgKmRpc3BsYXksDQo+ICAJCQkJICAgICAgZW51bSBwaXBlIHBpcGUpOw0KPiBA
QCAtNzU4LDYgKzc1OSw5IEBAIGJvb2wgaW50ZWxfcHBzX3ZkZF9vbl91bmxvY2tlZChzdHJ1Y3Qg
aW50ZWxfZHAgKmludGVsX2RwKQ0KPiAgCWlmIChlZHBfaGF2ZV9wYW5lbF92ZGQoaW50ZWxfZHAp
KQ0KPiAgCQlyZXR1cm4gbmVlZF90b19kaXNhYmxlOw0KPiANCj4gKwlpZiAoaW50ZWxfZW5jb2Rl
cl9pc190YygmZGlnX3BvcnQtPmJhc2UpKQ0KPiArCQlpbnRlbF90Y19wb3J0X2dldF9saW5rKGRp
Z19wb3J0LCAxKTsNCj4gKw0KPiAgCWRybV9XQVJOX09OKGRpc3BsYXktPmRybSwgaW50ZWxfZHAt
PnBwcy52ZGRfd2FrZXJlZik7DQo+ICAJaW50ZWxfZHAtPnBwcy52ZGRfd2FrZXJlZiA9IGludGVs
X2Rpc3BsYXlfcG93ZXJfZ2V0KGRpc3BsYXksDQo+ICAJCQkJCQkJICAgIGludGVsX2F1eF9wb3dl
cl9kb21haW4oZGlnX3BvcnQpKTsNCj4gQEAgLTg2NCw2ICs4NjgsOSBAQCBzdGF0aWMgdm9pZCBp
bnRlbF9wcHNfdmRkX29mZl9zeW5jX3VubG9ja2VkKHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHAp
DQo+ICAJaW50ZWxfZGlzcGxheV9wb3dlcl9wdXQoZGlzcGxheSwNCj4gIAkJCQlpbnRlbF9hdXhf
cG93ZXJfZG9tYWluKGRpZ19wb3J0KSwNCj4gIAkJCQlmZXRjaF9hbmRfemVybygmaW50ZWxfZHAt
PnBwcy52ZGRfd2FrZXJlZikpOw0KPiArDQo+ICsJaWYgKGludGVsX2VuY29kZXJfaXNfdGMoJmRp
Z19wb3J0LT5iYXNlKSkNCj4gKwkJaW50ZWxfdGNfcG9ydF9wdXRfbGluayhkaWdfcG9ydCk7DQo+
ICB9DQo+IA0KPiAgdm9pZCBpbnRlbF9wcHNfdmRkX29mZl9zeW5jKHN0cnVjdCBpbnRlbF9kcCAq
aW50ZWxfZHApDQo+IEBAIC0xMDY2LDYgKzEwNzMsOSBAQCB2b2lkIGludGVsX3Bwc19vZmZfdW5s
b2NrZWQoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCkNCj4gIAlpbnRlbF9kaXNwbGF5X3Bvd2Vy
X3B1dChkaXNwbGF5LA0KPiAgCQkJCWludGVsX2F1eF9wb3dlcl9kb21haW4oZGlnX3BvcnQpLA0K
PiAgCQkJCWZldGNoX2FuZF96ZXJvKCZpbnRlbF9kcC0+cHBzLnZkZF93YWtlcmVmKSk7DQo+ICsN
Cj4gKwlpZiAoaW50ZWxfZW5jb2Rlcl9pc190YygmZGlnX3BvcnQtPmJhc2UpKQ0KPiArCQlpbnRl
bF90Y19wb3J0X3B1dF9saW5rKGRpZ19wb3J0KTsNCj4gIH0NCj4gDQo+ICB2b2lkIGludGVsX3Bw
c19vZmYoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCkNCj4gQEAgLTEzMzQsNiArMTM0NCwxMCBA
QCBzdGF0aWMgdm9pZCBwcHNfdmRkX2luaXQoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCkNCj4g
IAkJICAgICJbRU5DT0RFUjolZDolc10gJXMgVkREIGxlZnQgb24gYnkgQklPUywgYWRqdXN0aW5n
IHN0YXRlIHRyYWNraW5nXG4iLA0KPiAgCQkgICAgZGlnX3BvcnQtPmJhc2UuYmFzZS5iYXNlLmlk
LCBkaWdfcG9ydC0+YmFzZS5iYXNlLm5hbWUsDQo+ICAJCSAgICBwcHNfbmFtZShpbnRlbF9kcCkp
Ow0KPiArDQo+ICsJaWYgKGludGVsX2VuY29kZXJfaXNfdGMoJmRpZ19wb3J0LT5iYXNlKSkNCj4g
KwkJaW50ZWxfdGNfcG9ydF9nZXRfbGluayhkaWdfcG9ydCwgMSk7DQo+ICsNCj4gIAlkcm1fV0FS
Tl9PTihkaXNwbGF5LT5kcm0sIGludGVsX2RwLT5wcHMudmRkX3dha2VyZWYpOw0KPiAgCWludGVs
X2RwLT5wcHMudmRkX3dha2VyZWYgPSBpbnRlbF9kaXNwbGF5X3Bvd2VyX2dldChkaXNwbGF5LA0K
PiAgCQkJCQkJCSAgICBpbnRlbF9hdXhfcG93ZXJfZG9tYWluKGRpZ19wb3J0KSk7DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3RjLmMgYi9kcml2ZXJz
L2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3RjLmMNCj4gaW5kZXggZjJkODZiMjljNDE1NC4u
Zjg3ODQ5NGJjYjM4OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF90Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
dGMuYw0KPiBAQCAtMTY2OSw3ICsxNjY5LDcgQEAgdm9pZCBpbnRlbF90Y19wb3J0X3Nhbml0aXpl
X21vZGUoc3RydWN0IGludGVsX2RpZ2l0YWxfcG9ydCAqZGlnX3BvcnQsDQo+IA0KPiAgCW11dGV4
X2xvY2soJnRjLT5sb2NrKTsNCj4gDQo+IC0JZHJtX1dBUk5fT04oZGlzcGxheS0+ZHJtLCB0Yy0+
bGlua19yZWZjb3VudCAhPSAxKTsNCj4gKwlkcm1fV0FSTl9PTihkaXNwbGF5LT5kcm0sIHRjLT5s
aW5rX3JlZmNvdW50IDwgMSk7DQo+ICAJaWYgKCF0Y19wb3J0X2hhc19hY3RpdmVfc3RyZWFtcyh0
YywgY3J0Y19zdGF0ZSkpIHsNCj4gIAkJLyoNCj4gIAkJICogVEJULWFsdCBpcyB0aGUgZGVmYXVs
dCBtb2RlIGluIGFueSBjYXNlIHRoZSBQSFkgb3duZXJzaGlwIGlzIG5vdA0KPiBAQCAtMTY4Myw3
ICsxNjgzLDEyIEBAIHZvaWQgaW50ZWxfdGNfcG9ydF9zYW5pdGl6ZV9tb2RlKHN0cnVjdCBpbnRl
bF9kaWdpdGFsX3BvcnQgKmRpZ19wb3J0LA0KPiAgCQkJCSAgICAiUG9ydCAlczogUEhZIGxlZnQg
aW4gJXMgbW9kZSBvbiBkaXNhYmxlZCBwb3J0LCBkaXNjb25uZWN0aW5nIGl0XG4iLA0KPiAgCQkJ
CSAgICB0Yy0+cG9ydF9uYW1lLA0KPiAgCQkJCSAgICB0Y19wb3J0X21vZGVfbmFtZSh0Yy0+aW5p
dF9tb2RlKSk7DQo+IC0JCXRjX3BoeV9kaXNjb25uZWN0KHRjKTsNCj4gKwkJLyoNCj4gKwkJICog
QSBsaW5rIHJlZmVyZW5jZSB0YWtlbiBkdXJpbmcgYSBwcmVjZWRpbmcgKGVEUCkgY29ubmVjdG9y
IGluaXRpYWxpemF0aW9uIHdpbGwgYmUNCj4gKwkJICogZHJvcHBlZCBsYXRlciwgYWxzbyBkaXNj
b25uZWN0aW5nIHRoZSBQSFkuDQo+ICsJCSAqLw0KPiArCQlpZiAodGMtPmxpbmtfcmVmY291bnQg
PT0gMSkNCj4gKwkJCXRjX3BoeV9kaXNjb25uZWN0KHRjKTsNCj4gIAkJX19pbnRlbF90Y19wb3J0
X3B1dF9saW5rKHRjKTsNCj4gIAl9DQo+IA0KPiAtLQ0KPiAyLjQ5LjENCg0K
