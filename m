Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795579132;
	b=BvYnratbGDFnHcHchVBAExqCqHmg/6TZgL6AVYIZZfnnZbG3I789xPtGTxXfE3i7ac+z
	 lJHSGXZg/4c9TQP+A5P7mAbm/+sR6j0Ol4c/zImIwb8mchs7bTjc2Ski+RugDJgJHpkh/
	 TMCDnAhz3NQZo37Xb5OvP5lOuBOeEJ3ynXQ/2do3UJICCFmrZ7v+T5TN3FXILLJZM+bhg
	 KdWf/rARADpSiLEBT8n58VE0kE/2fGA64CLggSkfvGKuwW7szyROtbU+XWNH7WIwZ7Tng
	 uNEO1KHOKj8FIUp329/W3gGYiayah5FpmOJLQq/oCT2bRKS4QmnxWVtX78atxORB9WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579132;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=C4MVGdq8JfMu8dlt4/F2t6vJ9Id5rIDGxRcQZQZ11NM=;
	b=y5UgJt/LTmFQ1mlMcV1+U6vvgnWU9JGTbefgIpyOSy+Ne4bRvwoxD/wfp7rnQwlXjAU0
	 sGp19BzKxXGNrT64wUoCbvAegZcDaBnd5GteScz9wHxjyN0kjYMj9kG4Kyb38kqwQeVrj
	 Rw4nuUTtGhbjcY5QsgF28GTCFI2J8BajVJuj6AHIEdJY4tyvf1KP+hFhKs6NvgLqGxDYh
	 Php+vOwuCZo+1lFKZZXDfMfO1inuPWMrlQG+ckRyKU/hF2yQNOHyV8i1P/mJzyhlkwnOY
	 Fe/+C3gasYxNe4Hff9+oXbTRqnTD94gBE9dhphaPAd0RQACZ9kmJGAkloAn0rIQoTlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="hcvPhL/R";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=NTZCwPtc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21C606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D21C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hcvPhL/R;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=NTZCwPtc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795579132; x=1827115132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C4MVGdq8JfMu8dlt4/F2t6vJ9Id5rIDGxRcQZQZ11NM=;
  b=hcvPhL/RaVOBvySX0N8AeoVF8Ly3GZ+TE1E/svOZgPKL5sT0NsxE/AmP
   vDsKWXPZoag8tbAw5SKR3p3P5AELtDycos30KF9NoOLmvxh8wETSnm8Pd
   FHhOLXIjoH/FkZBn73SNLobGmtzOy4cN+Fr5bzAkyHJjXdOVmOIaIRs/s
   G0eruv5dtahQDW+riHjhoi9JBaKOpM0IpbPUp2oLJPYJEoi4G+5ZzuBJA
   Mx/Kygu5VWt3W5lxVJPqcRMZ3lR8vYjXrHiiYAv2Mhc3vmcmrfyT47JWj
   TL/gBVKVTMr7EY+6q+wvYLyyUI6vofl2q31BUWSH/fjdsPO0m+wvhCuO6
   w==;
X-CSE-ConnectionGUID: 93fRElNvSC6sWXnQgqv6jw==
X-CSE-MsgGUID: dYn13mjpR2GHfII0Bv0GJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4344609"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4344609"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:58:51 -0800
X-CSE-ConnectionGUID: KmXp4c+4Rc6WfuRByK88Ew==
X-CSE-MsgGUID: vsBHEe3iQBqqNOQ5s7S2Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11956413"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:58:50 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:58:49 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 19:58:49 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:58:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdeEenw9yJLtDMrk1qXsOmfzF31YIweKTLRZK/MjO0lHrfBRQsIut2lXG2LWeT2RUofR9IaNT1M34tLVg2KsKyRVN2gVPfymlQPxII9aH8FhynI4PvYlqYYdwXhVrkRqy+2HwPUkiXb/ybFJwOLl7cxi5Erq2dE7FYdK2pG4BUJq+ZmL6uUjDzYOps17R/zgqCM2hyPzD/YDkjDtTaSLKLHGFAa6bv3jrxYovf5hCT5DKPxLlfGmTAiVoIzFIW1avm0WqJVvYDNpYNiBc89PL7k3HXd38Z3zdZNRIx+F3dTOlwhCvcSOR4WbUWJKXKvqbEzIuqEfH3pMI0+7WHSQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4MVGdq8JfMu8dlt4/F2t6vJ9Id5rIDGxRcQZQZ11NM=;
 b=SkB8y2Io3jvwM/t0COMXVjaZHTx6fABdbb0G4fOH3CfvluSszBR7sQpi0XLuLZWSQhmEC9993nFbwwf+BGIwl5MiSyS5VMFkeAtKuOcg3bw6GNvViP4251eu5UuVM3DopAy/6V0of1uThilDW1Nl0UMK59YuspaAKqDZvyBGUavUQLUz/JA4jObU6h13hYdMF0w2uDPFN9cAFNy8uj9hlg2WqK0fLXq7AkyMtxTE638skijTtQ2ACRePLgMvoWTvlmJPavSi+3ZsX0Nv+KFIJCVMYpy9pSW394WpLSrPvA+6TXusMB4Uy9r6IPAaZARB/CiD+YYTH5aEFnvu/Nrb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4MVGdq8JfMu8dlt4/F2t6vJ9Id5rIDGxRcQZQZ11NM=;
 b=NTZCwPtcppSZEd72IKE0+l4b+9k1FgxicZGqHD+Xgb7g0CSUzTVYiD6p31di1MyNHD73Ph0yRFRSDeZJqH/9b98yABsgkSokTE+Npr7+YGQS1BaZNSsGjvOsLABsb/MchQf61c7hsHlD3Hq3auQwlH/nT7TgG7sKZ8BKQBmCojA=
Received: from IA3PR11MB9325.namprd11.prod.outlook.com (2603:10b6:208:571::13)
 by LVXPR11MB9753.namprd11.prod.outlook.com (2603:10b6:408:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 03:56:46 +0000
Received: from IA3PR11MB9325.namprd11.prod.outlook.com
 ([fe80::51e4:9ff6:bdf6:869e]) by IA3PR11MB9325.namprd11.prod.outlook.com
 ([fe80::51e4:9ff6:bdf6:869e%6]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 03:56:46 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Kahola, Mika" <mika.kahola@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "Deak, Imre" <imre.deak@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/pps: Don't steal VDD from another eDP port
 sharing the PPS
Thread-Topic: [PATCH] drm/i915/pps: Don't steal VDD from another eDP port
 sharing the PPS
Thread-Index: AQHdewgraAg1QWMNtECT9zUXVb7v0Lc9JDmAgAEHaJA=
Date: Wed, 25 Nov 2026 03:56:46 +0000
Message-ID: <IA3PR11MB9325C8C1B034B718BA3B1816E3432@IA3PR11MB9325.namprd11.prod.outlook.com>
References: <20261123050422.3130438-1-suraj.kandpal@intel.com>
 <MW4PR11MB65706BB25E1F163EA791D0FDEF442@MW4PR11MB6570.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB65706BB25E1F163EA791D0FDEF442@MW4PR11MB6570.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9325:EE_|LVXPR11MB9753:EE_
x-ms-office365-filtering-correlation-id: a9c69632-5d92-48f7-0e3f-08df4aa82041
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|261009223027099003|3023799007|261021121427099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|38070700021|261022075727099003|261028144727099003|56012099006|4143699003|10067099003|11063799006;
x-microsoft-antispam-message-info: 6bGNC9/BpGhbjbdMBn83kEQR7hsfNNP1tGhJE+q8uzcKMWGU/QlWyEhQR0f4geFEvjguo3jD4BBI6gMzus/ictD8l0tR5AOyysf324BpD1p2W8D2WJGYX05ebcsB9CQ/bFzSSQkvkGkWDT4Csow9ky6GFZe38Hs+L0Ikwg7JWIdsMPktZmshwqMYfRgSY1m0Rf4vV+0Ov95Ugs182Wu98fRKpDNRW+COJni4w2TCGXqvttf3Ro3Ds6dsxwvAnXGp/ifbmobW47wIdE8eGBvsiHE30OMevxstQvZQMEVPIG7b2oI94O338l6HOfYVH8MxZJN3UXwJkrl4bcQijspBBk6N38pQtGF/Ppg8OJTPBF2fENRzx2MQ/h87M2ELc8iK3jayks3uW9nZmvClt3LZ1qvk1o/ADBfyL6vv/G0im5IXpE8aU5GUtnVJ5hYqqgzaw10YA89WFIrxVZmzMLxMQko36MQtU/Mfl4nJa0/Il7rPeYKCDB6YAnJpob8i7F37dkVsE/dz7AJ/DaEkoooT031s6fXnGY2vXHWd7SuiNzN+mgL/1+89fuQouTSDLyVAN0lp3fHLbHOWvoRSNyNm3WZoL8rLshTwwtHbirsCCWpI6jEWxn3VF0+piaOTsDyEYkNWbQj/OxJHC1gDEpZpzZZiZVGcBzWr8VcKMwy6cVI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(3023799007)(261021121427099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(38070700021)(261022075727099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFVQSDhiS2RZWHFiUUNKWW9UcXRkWktOQVZHVjJYcmpCb09zbGNqTjdpOGNV?=
 =?utf-8?B?NEZTNkFpN1hBa2NER2xvaTIybHhtUnc0U1hiUzRENHdmclhscm1NY2E5cGRW?=
 =?utf-8?B?aXhPd3ZMaVk4RHh0T2srV0dTZWI3YjYxSHB5Tk5MdlMrZWRUVFVyQ3MwT0w2?=
 =?utf-8?B?RFR5aGpLR2xDa3NyRUU0YThXWWJoYzVreHVHVlFhMXp5L0IrbElWNXl4UFhC?=
 =?utf-8?B?Rnlmc3l2U3hFcGlDTTNxam11RmR0K0k3NDBKbHlITC9vRFpOVnA5Q0MrTXVY?=
 =?utf-8?B?YmZBb2xXdUNrOHhIeVNKYklmZjJaMm53bDBOZjcyeTdNZG9FaHlFd0pXSlBD?=
 =?utf-8?B?aWY1dmFxb3pNcXN1UTJXRGhIR29sZHJYVHp2Qjg4SkIyZEk3UE5JQllPeUNl?=
 =?utf-8?B?eUEzU0hLbXE4UmxGbUpLcTBGUTRhZW84WGdWYU54V0FIM1F4L2RUd29zR0JT?=
 =?utf-8?B?c3l2NDhMd2VFR05vVGJwUlNIQ2UrUVVyNmpzeHkyaERING1HU21qbHF3eWRU?=
 =?utf-8?B?STR5UEpHNTBRL1VhemVwMk5xa3pHN3pPOHpjbDB6aTlVYldZdVgyK2p2YkRR?=
 =?utf-8?B?WVhxT2ZqQUZ2VjZ2M2RBOHRhaEpYYWpISlE3ekNBUms0N2FybER2REE1S0xE?=
 =?utf-8?B?R1Vvb3RETEdwWC91Y2o2YktMa3ZBYVExR1ZTbllBMTltYjVMVXI5N3IrNWdj?=
 =?utf-8?B?MXc0Nk1jUlllRUhPVFB1b0JjMm5VbGpheml6cHNYcjRyeGxGT3cxZU5qSE93?=
 =?utf-8?B?T1kwYlVrcnhTV25WNSt5UzF3S0NHZzhzT25RaWcxNVZORlpEV25JSmRaOUZl?=
 =?utf-8?B?VkdPSlhHYXp2dW80SXFwL2gvTW1NM3YyWHdqcWdyZ0hyU1B0UUorVEs0emZN?=
 =?utf-8?B?TjNZdUNSeDRMdzhTcXZmWVhBNE5RUUtWZHE3RFVpUGw1UU9iR2VPeGlwSTdE?=
 =?utf-8?B?a3M5UHhmSW9heW5lUHR6eTUzM1BUUHk5QWN5UlQ0ZHNHME0vZGFsbGswMUZ4?=
 =?utf-8?B?MTBiQ2dua3FnMlBLeXFLSkRQWnRWa0l0YjFiQnBUQkNPdllWL3lOeWMrQi9J?=
 =?utf-8?B?SFpJS1J3dWxxRDRyMVdjSVVzVlhENHQzRUxDYmhIZSt6aHlkMTBhZnNtcmh5?=
 =?utf-8?B?YWIvdXc3azNmM21GQng0aGx5OGhzQ01sMTBTeFFGUTRoWUh3NTNGVmlsK3dN?=
 =?utf-8?B?MlFjMWlPc3VtSWNSekFMRlpEZGlmUzIzOTNyY3hyeWV4dFk0bk1kSFM4cEdw?=
 =?utf-8?B?UFZsZEhyUWV5N1NOUXJuVnZOTEpqK3BxTStMeXhlV3dxemd2RmR5WVdva3Vp?=
 =?utf-8?B?ZFcxUVBEQnA0bDBkM0o1WThTTXFDek5qNU1mRVZrU09XT2Nxb1lacDMyQ2NC?=
 =?utf-8?B?RjB6Q2VSUnlRbERROVZNSCt1QWlTRTZvWldzRWEzV2tuUFo5NVprbk1vWHZx?=
 =?utf-8?B?eDdOSFlBNFhHZGcvVnJNU1RWT0FyRlQwdWE5L2s1M1FJcnVLUW12RlF5c20w?=
 =?utf-8?B?VDJ0RXVKVVlMMzZSdkNHNk5Ca3k2QUNpblB3RFZ0Rm4yY2ZaUzNPTkg1dFRO?=
 =?utf-8?B?SHZLZXN2NGlSQTNnNjNjR0oyUHFLVU9qaGsydUdKMnljUndCTFlpdGV2T013?=
 =?utf-8?B?YnprU3BQNjhocW9WTGdxeUdvSEN0OU9KbHdRRGx6RElCcGJaRzhJb0FyYXJL?=
 =?utf-8?B?ZzZ6L0pzNGhsNExvODB1TEJzcGoyM1VpaXV1U3B1d0xEQXY3VHR6dmJmVlVR?=
 =?utf-8?B?TTVYWW9QenFuVVNDVnpla2wzZlBZdjF6a24vTmRpRnY0Z3o4MkxzdHNKZEVT?=
 =?utf-8?B?WEtRL3BhMkFTL1FqeG5ka1ZwQzhORlZaSXBiUXRHMXhxalVGRHJGS0FVS0tJ?=
 =?utf-8?B?YVNJMVRNZFlBbEVYemxMSGpDMnJwN1d5QkxiYU5lalNKTXVGbjlTOFlGOW9y?=
 =?utf-8?B?WStlUUxrckFiNlpieUQ5OEhqc1B0OTFXRmhTWW83Tkh1cUtDVGtSTHR3Rmc5?=
 =?utf-8?B?SFkxY2ptYy9pZ0NUM0RuTVpqWFN1aXpmS3Y2ZVVaNnhHYnNrUEFubWpicjAx?=
 =?utf-8?B?YTQ0TkhlUTNnM25sWHNwbmdSdmpFOFE2UHY0RW5XaDdkQ1lzN3drL0hPUDQw?=
 =?utf-8?B?UzV3SXZ3d3NIellSMll3dFpGK3U2VnR4ZjBpN3krYWZpL2VINDM1cHFMdlVy?=
 =?utf-8?B?L1RKOTBJQjRFbExJVC9GM2wvQWh5U0lLNUNKSVVJeHdQZ29jVXBIY2ZxTFFi?=
 =?utf-8?B?OU9GK1FJYk4ydHZ6ZThWaG9lOU1sdkl0b0Yya25kTzIrY0NZV1VWTXc1WC8v?=
 =?utf-8?B?QUo3bXBlOUlMRUlFNnhCM21nS2d1K1N2U2gxVTlHL2MvWFhJSWJ1UT09?=
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
X-Exchange-RoutingPolicyChecked: iACavt3gdfzG08yh6QwT3aC8KBz/JJ80M6mvD3RvsZmCDCLQJOmSWuebxDuQ66EqlQX1J+Mamj3RulHRLPgFWUHDmeIpa2p+XZUo2w9mJpyDlMCABQkjVFS/JTcsSp1byMxlCaOfkCoLlUy0vMkk7GqJsnOy0oQajcxzTBDa7LCoQgcYFJOMxVSnkod43inXOGsFwHEKLOBdQlkbi4sZCQq8uZh7noUIkHfWLEzHXlTMiGjAUU+r6EYvTV+TKM++1o4fsh62z8d2CVarE7LzuxvUKF0ndCnuzi3rxfuhH6TqbOwh908/PtdtNtAGKF4VoVlRIZUElkjcF1WSBiai7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c69632-5d92-48f7-0e3f-08df4aa82041
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:56:46.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjmdLWQ4smQsgEv1e6flXNj1BENyVqJE99FAT27sErnJdi51EFTifyO2BxT7XCBbiOXJJfXxhrQQioNQsJ7mkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9753
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2Fob2xhLCBNaWthIDxt
aWthLmthaG9sYUBpbnRlbC5jb20+DQo+IFNlbnQ6IDI0IE5vdmVtYmVyIDIwMjYgMTc6NDMNCj4g
VG86IEthbmRwYWwsIFN1cmFqIDxzdXJhai5rYW5kcGFsQGludGVsLmNvbT47IGludGVsLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7DQo+IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBDYzogRGVhaywgSW1yZSA8aW1yZS5kZWFrQGludGVsLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2k5MTUvcHBzOiBEb24ndCBzdGVhbCBW
REQgZnJvbSBhbm90aGVyIGVEUCBwb3J0DQo+IHNoYXJpbmcgdGhlIFBQUw0KPiANCj4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEthbmRwYWwsIFN1cmFqIDxzdXJhai5r
YW5kcGFsQGludGVsLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIDIzIE5vdmVtYmVyIDIwMjYgNy4w
NA0KPiA+IFRvOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBpbnRlbC14ZUBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gPiBDYzogRGVhaywgSW1yZSA8aW1yZS5kZWFrQGludGVsLmNv
bT47IEthaG9sYSwgTWlrYQ0KPiA+IDxtaWthLmthaG9sYUBpbnRlbC5jb20+OyBLYW5kcGFsLCBT
dXJhaiA8c3VyYWoua2FuZHBhbEBpbnRlbC5jb20+Ow0KPiA+IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9pOTE1L3BwczogRG9uJ3Qgc3RlYWwgVkREIGZy
b20gYW5vdGhlciBlRFAgcG9ydA0KPiA+IHNoYXJpbmcgdGhlIFBQUw0KPiA+DQo+ID4gU29tZSBW
QlRzIGRlY2xhcmUgYW4gdW5wb3B1bGF0ZWQgZURQIHBvcnQgbmV4dCB0byB0aGUgcmVhbCBwYW5l
bCBhbmQNCj4gPiBhc3NpZ24gYm90aCB0aGUgc2FtZSBQUFMuIFRoZSBnaG9zdCBwb3J0IGFkb3B0
cyB0aGUgVkREIGJpdCB0aGUgcmVhbA0KPiA+IHBvcnQgdHVybmVkIG9uLCBhbmQgd2hlbiBpdHMg
RFBDRCByZWFkIGZhaWxzIGl0IGNsZWFycyBFRFBfRk9SQ0VfVkREDQo+ID4gdW5kZXJuZWF0aCB0
aGUgcmVhbCBwb3J0LiBUaGUgcmVhbCBwb3J0J3MgVkREIHJlZmVyZW5jZSBpcyB0aGVuIG5ldmVy
DQo+ID4gcmVsZWFzZWQsIGxlYWtpbmcgYW4gQVVYIHBvd2VyIGRvbWFpbiByZWZlcmVuY2UgYW5k
IGEgcnVudGltZSBQTQ0KPiA+IHdha2Vsb2NrOg0KPiA+DQo+ID4gICBkcm1fV0FSTl9PTihpbnRl
bF9kcC0+cHBzLnZkZF93YWtlcmVmKQ0KPiA+ICAgaTkxNSByYXctd2FrZXJlZnM9MSB3YWtlbG9j
a3M9MSBvbiBjbGVhbnVwDQo+ID4NCj4gPiBEb24ndCBhZG9wdCBvciB0dXJuIG9mZiBWREQgb3du
ZWQgYnkgYW5vdGhlciBlRFAgcG9ydCBvbiB0aGUgc2FtZSBQUFMuDQo+ID4NCj4gPiBDbG9zZXM6
DQo+ID4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9pOTE1L2tlcm5lbC8tL3dv
cmtfaXRlbXMvMTcyMzINCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjE1Kw0K
PiANCj4gSXMgdGhlcmUgYSBwYXRjaCB3aGljaCBpcyBmaXhlZCBieSB0aGlzIHBhdGNoPyBUaGlz
IHBhdGNoIGNvdWxkIGJlbmVmaXQgb2YgaGF2aW5nDQo+IEZpeGVzIHRhZyBhcyB3ZWxsLg0KPiAN
Cg0KSSB0cmllZCB0byBmaW5kIGEgc2luZ2xlIHBhdGNoIHRoYXQgY2F1c2VkIHRoaXMgaXNzdWUg
YnV0IGNvdWxkbuKAmXQgcGluIHBvaW50IGFueSBvbmUgb3IgdHdvIHBhdGNoZXMgdGhhdCBtYXkg
aGF2ZSBjYXVzZWQgdGhpcyBpc3N1ZQ0KDQpSZWdhcmRzLA0KU3VyYWogS2FuZHBhbA0KDQo+IE90
aGVyd2lzZSBMR1RNLA0KPiANCj4gUmV2aWV3ZWQtYnk6IE1pa2EgS2Fob2xhIDxtaWthLmthaG9s
YUBpbnRlbC5jb20+DQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFN1cmFqIEthbmRwYWwgPHN1cmFq
LmthbmRwYWxAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX3Bwcy5jIHwgMzUNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bwcy5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bwcy5jDQo+ID4gaW5kZXggNDQyYjAwNDkxYTg4
Li42NTNiOGJmN2VjNmQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9wcHMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfcHBzLmMNCj4gPiBAQCAtNTcwLDYgKzU3MCwzMCBAQCBzdGF0aWMgYm9vbCBlZHBfaGF2
ZV9wYW5lbF92ZGQoc3RydWN0IGludGVsX2RwDQo+ICppbnRlbF9kcCkNCj4gPiAgCXJldHVybiBp
bnRlbF9kZV9yZWFkKGRpc3BsYXksIF9wcF9jdHJsX3JlZyhpbnRlbF9kcCkpICYNCj4gPiBFRFBf
Rk9SQ0VfVkREOyAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBib29sIHBwc192ZGRfb3duZWRfYnlfb3Ro
ZXJfcG9ydChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKSB7DQo+ID4gKwlzdHJ1Y3QgaW50ZWxf
ZGlzcGxheSAqZGlzcGxheSA9IHRvX2ludGVsX2Rpc3BsYXkoaW50ZWxfZHApOw0KPiA+ICsJc3Ry
dWN0IGludGVsX2VuY29kZXIgKmVuY29kZXI7DQo+ID4gKw0KPiA+ICsJbG9ja2RlcF9hc3NlcnRf
aGVsZCgmZGlzcGxheS0+cHBzLm11dGV4KTsNCj4gPiArDQo+ID4gKwlpZiAoZGlzcGxheS0+cGxh
dGZvcm0udmFsbGV5dmlldyB8fCBkaXNwbGF5LT5wbGF0Zm9ybS5jaGVycnl2aWV3KQ0KPiA+ICsJ
CXJldHVybiBmYWxzZTsNCj4gPiArDQo+ID4gKwlmb3JfZWFjaF9pbnRlbF9kcChkaXNwbGF5LT5k
cm0sIGVuY29kZXIpIHsNCj4gPiArCQlzdHJ1Y3QgaW50ZWxfZHAgKmRwID0gZW5jX3RvX2ludGVs
X2RwKGVuY29kZXIpOw0KPiA+ICsNCj4gPiArCQlpZiAoZHAgPT0gaW50ZWxfZHAgfHwgZW5jb2Rl
ci0+dHlwZSAhPSBJTlRFTF9PVVRQVVRfRURQKQ0KPiA+ICsJCQljb250aW51ZTsNCj4gPiArDQo+
ID4gKwkJaWYgKGRwLT5wcHMucHBzX2lkeCA9PSBpbnRlbF9kcC0+cHBzLnBwc19pZHggJiYNCj4g
PiArCQkgICAgZHAtPnBwcy52ZGRfd2FrZXJlZikNCj4gPiArCQkJcmV0dXJuIHRydWU7DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGZhbHNlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICB2b2lk
IGludGVsX3Bwc19jaGVja19wb3dlcl91bmxvY2tlZChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2Rw
KSAgew0KPiA+ICAJc3RydWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkgPSB0b19pbnRlbF9kaXNw
bGF5KGludGVsX2RwKTsgQEANCj4gPiAtODM5LDYgKzg2Myw5IEBAIHN0YXRpYyB2b2lkIGludGVs
X3Bwc192ZGRfb2ZmX3N5bmNfdW5sb2NrZWQoc3RydWN0DQo+IGludGVsX2RwICppbnRlbF9kcCkN
Cj4gPiAgCWlmICghZWRwX2hhdmVfcGFuZWxfdmRkKGludGVsX2RwKSkNCj4gPiAgCQlyZXR1cm47
DQo+ID4NCj4gPiArCWlmICghaW50ZWxfZHAtPnBwcy52ZGRfd2FrZXJlZiAmJg0KPiBwcHNfdmRk
X293bmVkX2J5X290aGVyX3BvcnQoaW50ZWxfZHApKQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+
ID4gIAlkcm1fZGJnX2ttcyhkaXNwbGF5LT5kcm0sICJbRU5DT0RFUjolZDolc10gJXMgdHVybmlu
ZyBWREQNCj4gb2ZmXG4iLA0KPiA+ICAJCSAgICBkaWdfcG9ydC0+YmFzZS5iYXNlLmJhc2UuaWQs
IGRpZ19wb3J0LT5iYXNlLmJhc2UubmFtZSwNCj4gPiAgCQkgICAgcHBzX25hbWUoaW50ZWxfZHAp
KTsNCj4gPiBAQCAtMTMzNCw2ICsxMzYxLDE0IEBAIHN0YXRpYyB2b2lkIHBwc192ZGRfaW5pdChz
dHJ1Y3QgaW50ZWxfZHANCj4gKmludGVsX2RwKQ0KPiA+ICAJaWYgKCFlZHBfaGF2ZV9wYW5lbF92
ZGQoaW50ZWxfZHApKQ0KPiA+ICAJCXJldHVybjsNCj4gPg0KPiA+ICsJaWYgKHBwc192ZGRfb3du
ZWRfYnlfb3RoZXJfcG9ydChpbnRlbF9kcCkpIHsNCj4gPiArCQlkcm1fZGJnX2ttcyhkaXNwbGF5
LT5kcm0sDQo+ID4gKwkJCSAgICAiW0VOQ09ERVI6JWQ6JXNdICVzIFZERCBvd25lZCBieSBhbm90
aGVyIGVEUA0KPiBwb3J0LCBub3QgYWRvcHRpbmcgaXRcbiIsDQo+ID4gKwkJCSAgICBkaWdfcG9y
dC0+YmFzZS5iYXNlLmJhc2UuaWQsIGRpZ19wb3J0LQ0KPiA+YmFzZS5iYXNlLm5hbWUsDQo+ID4g
KwkJCSAgICBwcHNfbmFtZShpbnRlbF9kcCkpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4g
PiArDQo+ID4gIAkvKg0KPiA+ICAJICogVGhlIFZERCBiaXQgbmVlZHMgYSBwb3dlciBkb21haW4g
cmVmZXJlbmNlLCBzbyBpZiB0aGUgYml0IGlzDQo+ID4gIAkgKiBhbHJlYWR5IGVuYWJsZWQgd2hl
biB3ZSBib290IG9yIHJlc3VtZSwgZ3JhYiB0aGlzIHJlZmVyZW5jZSBhbmQNCj4gPiAtLQ0KPiA+
IDIuMzQuMQ0KDQo=
