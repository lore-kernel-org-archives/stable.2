Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3453355055
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132398; cv=fail; b=Ag60cV4/4H1z8Zqta4P+LBmDD2b1hEKcHm2O1a6jRbF35CJU59xFm4AOmlo9aVPJltK8jQp71sBhyrel5Sp8b7PCdAdQ3g1UsMBLFm/7IcaVX30wJNAvXv9kDJDa0iB7sBRQ/DqGLcctGfMUXHolROceU5Rp9VDyqCGE2+8zsfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132398; c=relaxed/simple;
	bh=1W8eT9VDdy7aN31VYGYCKpkQWBjxMyKaKVn9t5emKno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g3NPqNypaaPUZiFJE0n1H+2S60YzarBuw4bVmX6va0aIVACaYqcU4bCAAbSZtfIx2nGHubmhdo1k2hHNGOV6DrEjUYM2GekvFJpdFh0hsjGkGkjAmBUa8kPqnzZvjOGWrmvBZwZfc/ZV/l9Jx9SnysUo4Ng4LCtOi3qL0x4w+y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F99hqADA; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F99hqADA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786132396; x=1817668396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1W8eT9VDdy7aN31VYGYCKpkQWBjxMyKaKVn9t5emKno=;
  b=F99hqADASjRHjchdZ8T7e8XWI7S4/6/DcGFO26AggWdto9l7GS69X5Al
   lVMGjLshhYM8FcdrO2y4CBndelKL7eCBXVgJ2e646T+EUT1XgWooiOt0F
   Jjm0A0xKK1ZWqymMWJCyGXfZfNoj8WzD07v1OOp8g2PGH0+SBhdgLGjde
   VwJmwdKQEq8i2fi4rUVEx0Y8DaLVAnokcy/5AutPJJLQ0hRTj+QTAxZAU
   nzQQLWvvCMHQldMgwePSlATjpRZ7d9cp04O7axk2YZ7CzN7JiU2bq5NFM
   BRWF3XesEF3hc/sO96SeIsezfWnASPChD2C+HX/5VoFfgQMuBxaujSVzt
   w==;
X-CSE-ConnectionGUID: HblfAqBqQiajkkpOZBOqjA==
X-CSE-MsgGUID: EfSwL+kdQ9y1/QDofHUGGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86759179"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86759179"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 12:53:16 -0700
X-CSE-ConnectionGUID: ioeJck+HS6+vTdQgFsHwTg==
X-CSE-MsgGUID: W9ijRrz4Qu+CR6JLxDhs+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="258175568"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 12:53:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 12:53:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 12:53:14 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 12:53:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0s1ZCcNa9xiKB1Ky7xiwY93I4Le/mRGcMraDnK+EsCGkAufmPS5YcSd5NRBPWrcGSJvmH9YtJOSl/71eziZFY3hqOycKU/Gc8GwqzoqChLueSOIaJIxyBF5/axb37qZG+sgAvFAtIVYGKjDdd7x7uKL3Qna49F1OHm9H/4gLWAxzyc80rvi3M7dvC/0WqsvuAE3UkR75FO81gLxrQThEaDWcNyQnSLDzXfj5AekTek/zS4CsWKFJBpQojMJtSwgOtQwSdnWoe5m+jXdO39VqQ+RhDAy0GBGJV8ChcfcPzTKQdVwtYH48zv5dtUGOuHvFIApWieleJ3Q0IbZEoA3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W8eT9VDdy7aN31VYGYCKpkQWBjxMyKaKVn9t5emKno=;
 b=cRX8dztvpZOCK/gFs6U57P+oTSEE6sGIGXuV/bygmwGJuqby7KiqXTPY0GFaeii9keDeGFn2rmJQUyIEB6eAMCyyvCSmxac5nN//Wdsysj5nIkfNFnHu3QTVXQr2KLSi/awiM+Yviw8cOk5Z1qVJPjiC+NZdgKXpSMghV3ni08pWUBlKzWNUmGYr86jvlcwX5RjocvqRcUMNbuz5PedNAzKGrqpJ2EJTT45O+5LiUDkhW2kQIa9qdGxsSY5TdRinkCQ0u/tQcUpp6gaVOmQzaMpSwYzt1a6PsY5/mdIVXphYvuUkz4vW9QmqwWobl5RyalWSuyI2ItIkYflIW2/Gaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9)
 by IA3PR11MB9350.namprd11.prod.outlook.com (2603:10b6:208:574::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 19:53:12 +0000
Received: from CY5PR11MB6320.namprd11.prod.outlook.com
 ([fe80::9cd7:94d5:90f:4d76]) by CY5PR11MB6320.namprd11.prod.outlook.com
 ([fe80::9cd7:94d5:90f:4d76%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 19:53:12 +0000
From: "Summers, Stuart" <stuart.summers@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Brost,
 Matthew" <matthew.brost@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Order ring writes before ring tail updates
Thread-Topic: [PATCH] drm/xe: Order ring writes before ring tail updates
Thread-Index: AQHdJpCtxPQ7NSczpUCOMAyjYTL8MLaS/5sA
Date: Fri, 7 Aug 2026 19:53:11 +0000
Message-ID: <be58d682a654c8d0d85dcd3890c9823879a762a6.camel@intel.com>
References: <20260807171716.140475-1-matthew.brost@intel.com>
In-Reply-To: <20260807171716.140475-1-matthew.brost@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6320:EE_|IA3PR11MB9350:EE_
x-ms-office365-filtering-correlation-id: 579ebcff-59ba-4aa0-8cab-08def4bd8326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: MNaAhpvJ6lAwn9lpXLaKQWUQmnoxr+UOFtpUXUdCVKRGwimfQu3bZcymEtBpppj95XUB7BSD58EOEHoProm6CuTlxPVYms8QbnRpxrYdudC4l/QtBBxX1LbCUUXDz6Msnb6SaUX3WcEuwRwyV4KYuYrHljfQxKizC0gMR2oeosp/CmB9zjsnmSYSfW1VojfSPoHhenOq+HmJjegJ26WgaQ988Oq9p3meI6v0y2i0YQ5xMNduk3Wn+BDLAFe8XwxYvf/jx7KGfqMtxtw2K82+hi2VD8dZ0z+NGHEc2f3vEuAUq5EU6LxVrh8C/+aP8N+9nNM6MgrVhcsI5vvvltGVMqWfm5ePVsyLGNYUhreumyH6HHKzyIaTyDXWsMDQXf4hwYvYO2i1nkmNd4V85Zz0ff5qyfoJyW+H0dK2nPWWruOQEu/dhdw7iOc8SCQyho9AotbJe23dzx0w1zIfXQV1xZx8lfrTZNiKWfDjjZyFsBbSMqPOtn5wZvdG4OOB+BpHY0Pb/3r9zaD0dwnucfEGxbm8Wu6yOHPdIUVbbYTG0LEmjCyLcBtaejT+IaQx/ADfjdWidgfYebQVKlcFX7CG4UePpyHQpX0p4yZDx1Y9uhvK3MZ/w/rx9jjDONsyRir6lNTMqpFs9gUrN0bzpNCoE8XLFfuHUqkMZr3MRrNqPdy+2S+M5PqiXxs63y0r1hZi2Hi9lswOY0Gigwda2kycwLpoyWSM/27/WSjJNcWP2tQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWRreUJHWDQwYnI3N1QyemFIWkxqMlhubGltb1N3ejMzc0M3bDJ4UXU1dDJS?=
 =?utf-8?B?cmVsaW5FS3JPc1VSTkpoMUNRZWd6OHp2L2tUbGpmNHQvc2lxRktZTnJ2VWNm?=
 =?utf-8?B?L3VOblF4SFJoSDJKVVpBcWVzZ1pzQ1FsYWRLRjRXRi9FNXlSLzZFQUhIdnd6?=
 =?utf-8?B?Ym9Sc2tVZGNYNGEwTytsYWtnajlhcWhDZlNod0QrenZ5WTA0Z1llSXRBQ1Ev?=
 =?utf-8?B?VmVnYjk5NmtyNSt0SXJ4Tm5zeWlBL1R4TXd4T0xkN2xjN0pFMVhJZUNSb0xh?=
 =?utf-8?B?blVYdFJuVDFJalMzNnpQYWVGbDc2Z09KQzJjZ2Y5TnJVZ0dycVF3MlBMdk9a?=
 =?utf-8?B?VGJ3dm5tY2RncHZsZVhCT3JSUk1oL1BFdDZJdkRxRjN4WFUrNUhPM2ZQV3Jq?=
 =?utf-8?B?UVdzb1ZyakYyTFJ3NTB3aGk3R0NDczlOYkRFMGJCbkpWSGxTYk02NWUya3h1?=
 =?utf-8?B?NDN1N2VRODIzdnVkMlNib0poUTd3VDZFS3hjWVhMemJMdVZMcGRYV09BSlVS?=
 =?utf-8?B?NDl5SUE0QzRpV1dLMDVhcUN0Y0EreUF4SkpTSTBNbFVqdkNZWGhrOE9LZTls?=
 =?utf-8?B?SDJpTFJOclJaWHNwTm85RmZocFNCcGhkZkk1b3ZEUzJVVWdxWG9RZm5ZbjhB?=
 =?utf-8?B?UzdwWUZ3L1BHd2JzbXpCVzJKYld3c2JaeGlVSHM3S1lOaHAyd3Y1N3Y0K3Jx?=
 =?utf-8?B?Tk9hbytWaXpYOWpyRTBITUxDa1YzUGkwYW9xa2RpMXl4SGFxQ1JJUlJGaTFj?=
 =?utf-8?B?U1M1d1RUMThyNWFUeEswZ2lvQ0dqK0ppSW40d3ZHUzdPbmRTWG42MTJTczI3?=
 =?utf-8?B?VTJaNDluR29pdDNVRE5LUEdwVkhHQ1JNaG1ZUlVIZDNsRTJEcStsT09rNnA3?=
 =?utf-8?B?SFFDTktkU25Xa1gzcnMxVE1EbElaYmRTSkRBVm45VEVob3kxb1d6WWNRVUIz?=
 =?utf-8?B?M3QwMVVNSEh0RGpLY1hBaXNaRG5wNWRueFRFMi9pWEZRM05DcU9hK0Y3c1N4?=
 =?utf-8?B?c3JPZkdFMGNHNnQxSUl3aVRzenB5Zk4yTGxTQkRQTXZWUWNYeWYrdG5pK3gr?=
 =?utf-8?B?M042T1ZDanpVMmtYOGlsVTgxOEQvSjQyZS9QSXpvNmZDUml2aStrK3hiYzJo?=
 =?utf-8?B?bGdWVjlBV2hWYjlDcFFpVDgxUHVFNnhrM0NSWmxpRXRHOXNHcFg1RkxsTXor?=
 =?utf-8?B?TE9zckNiRzlVOXpCbTQwVW9WL0RnQkhTNXN3WGNQL0QvYUxvZHlCekxkV3JW?=
 =?utf-8?B?RzFXUWhQaW1WWlF3V1dFM0RzTjlIL0MvREJraVFMNW9LOEpEejdNRzk5eVcv?=
 =?utf-8?B?UDNpdGxZUUtLdkpVYmVmcGNtUGEwWjdrZWtIeHF3Mk8xWFNCOVN5S2o5Y3Zp?=
 =?utf-8?B?LzZMUzNVWmtsTW5UL1A2L3JiUXQ0Nk1WM2xWcXJSeE5xTFd3S210VkJycG5L?=
 =?utf-8?B?R1IxSFFIK0Y1UXhkdStKVnkwSTQ2dzdaOFZhd0VDQ2xDTklNNjFEeGo5V080?=
 =?utf-8?B?Q1gyQmlNaDRzMVZuUlBXQ25YWU5FanJ1cURPZ05LQzlUcEtwN3NxVm80UHM5?=
 =?utf-8?B?eUlOMDJLZWpFQnhBNWpGT0RGSXpwNzFLMlVtQlR5SlVDZm13S0huV1JIZW1Z?=
 =?utf-8?B?NmsvZlhuOW04aTF2b2tNcmVoWHN5bWExcXhEdVcyMmxKWkM3QlNPb3FMVXYv?=
 =?utf-8?B?ckZFUmN1UnFxUnoyS3dEZzE1RitlU2JaeVBySW5vQlcwbFBrS2RyamlvL1JE?=
 =?utf-8?B?a2MwbnU5OFVZditZWmswVzBLcnBOUTFzVXBic0RFMzRVaGpFK2dONGVoeVc4?=
 =?utf-8?B?TlQrSS9Wc29LM1Y4WjVPek8yYzB5L01RVjVnSlJpZDJaUTZIRkdaSE5NeVBD?=
 =?utf-8?B?cVpqUGpvMi9TeXhXYkM1ejl3UWpqK2ptMGNSOVdsc3NqTEJHU1VnWFUwcE13?=
 =?utf-8?B?ZDlCeHBNSGhRc3JBODdrUzk2aU9zaWNDcXh3dG1wNWM3OU84c0wzc0hkQzlL?=
 =?utf-8?B?SHhTdXM3WUJHeWc2dUxCYllzcUw2N1FPVnBtMG1BYWZMMEM3MXJQOUVpRkdB?=
 =?utf-8?B?blEzcElTeVViczM5RnhzQmE4M2pjVFVFdXB1U0RVQ3BRNjY5cTJySDRua3pJ?=
 =?utf-8?B?bzcyakJSYzVsMTVndURQZnB6Y1RkZDF6UnNDWHhjU1F5YTdNcUZlWXkrV0NX?=
 =?utf-8?B?dHVrcUN6ZWVvTlRXRnRGeVhTVEhOVitrRkgyMlpZODFFZWpQcERBZVRoeTd6?=
 =?utf-8?B?WmRxQlc0S1VJcTExeEt6N2tJUkk0b0pYb0VrTmtkSWZyV29hVHZSanJha1Rl?=
 =?utf-8?B?YU5wb2tKcDNYSnZwVGxzY3JqOVlIS09sU1h1UlZjbVJYTUM2dEpSUFp6bjJp?=
 =?utf-8?Q?nUTIxpl8lALNCnQU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E49673369DE3FF47BAAEB6F0D9BDE344@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jIK7jF4jjBOy3ylgEj/VWY9e2G18s8Qk8pN+xaOrMtjdaRU9FaxxaUhfzXhBxmXfp0Hd2gQK3LT84qzv8y5m23OQVMqs6plYF7h0+eWkGeyHMWrre3V6sDX+enURTxXWkeQc0OrFZySSLVuPw/ME5OPFfnpSc9+GglPaF1FlsWod7SKflpaN+92BGgKOrvtPZFd1hX9ArcuYuhhA04bFRH/tpOznjGJYmbzfSU/zCRMT8yfPuYHCDdle93IrEGT2XKx3WIk4TbiYyRSenTIdDZTgwIjdwIrLZRr+wK+KIe3LTJEeAOiOW5posTX/ttQ+vw+oOQJxYwgk1YcdVCQKkg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579ebcff-59ba-4aa0-8cab-08def4bd8326
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 19:53:11.8488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5w70mkn0wwNA8JT3cwHWDVjg9FCHyknlxO29dYZIY++nwK4h1kTDM95HQ2+gI6QgKDkG1x+pZKwFWU5+0ytRYh5O6UEOnbJLuNfA4+HsxOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9350
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTA3IGF0IDEwOjE3IC0wNzAwLCBNYXR0aGV3IEJyb3N0IHdyb3RlOg0K
PiBUaGUgcmluZyBidWZmZXIgYW5kIHRoZSBMUkMgY29udGV4dCBpbWFnZSBhcmUgYm90aCBtYXBw
ZWQgV0MsIHNvIHRoZQ0KPiByaW5nDQo+IHRhaWwgdXBkYXRlIGNhbiBiZWNvbWUgdmlzaWJsZSB0
byB0aGUgZGV2aWNlIGJlZm9yZSB0aGUgcmluZyBjb250ZW50cw0KPiBpdA0KPiBpcyBtZWFudCB0
byBwdWJsaXNoLg0KPiANCj4gVGhlIEd1QyBDVCBzZW5kIGRvZXMgY29udGFpbiBhbiB4ZV9kZXZp
Y2Vfd21iKCksIHNvIHNlbmRpbmcgdGhlIEgyRw0KPiB3b3VsZA0KPiBmbHVzaCB0aGUgcmluZyBj
b250ZW50cy4gVGhlIHByb2JsZW0gaXMgdGhhdCBpdCBjb21lcyB0b28gbGF0ZToNCj4geGVfbHJj
X3NldF9yaW5nX3RhaWwoKSBwdWJsaXNoZXMgdGhlIHRhaWwgYmVmb3JlIHRoZSBIMkcgaXMgc2Vu
dCwgYW5kDQo+IHRoZQ0KPiBkZXZpY2Ugc2FtcGxlcyB0aGUgdGFpbCBmcm9tIHRoZSBjb250ZXh0
IGltYWdlIGluZGVwZW5kZW50bHkgb2YgaXQsDQo+IGVpdGhlcg0KPiBhdCBjb250ZXh0IHN3aXRj
aC1pbiBvciB3aGlsZSB0aGUgY29udGV4dCBpcyBhbHJlYWR5IHJlc2lkZW50LiBBDQo+IHN1Ym1p
dHRlcg0KPiB3aGljaCBpcyBpbnRlcnJ1cHRlZCBiZXR3ZWVuIHVwZGF0aW5nIHRoZSB0YWlsIGFu
ZCBzZW5kaW5nIGl0cyBIMkcNCj4gdGhlcmVmb3JlIGxlYXZlcyB0aGUgZGV2aWNlIGZyZWUgdG8g
b2JzZXJ2ZSB0aGUgbmV3IHRhaWwgd2hpbGUgdGhlDQo+IHJpbmcNCj4gY29udGVudHMgYmVoaW5k
IGl0IGFyZSBub3QgeWV0IHZpc2libGU6DQo+IA0KPiDCoCAxLiBUaHJlYWQgQSBlbWl0cyBhIGpv
YiBpbnRvIHRoZSByaW5nLCBzZXRzIHRoZSB0YWlsIHRvIFRfQSBhbmQNCj4gc2VuZHMNCj4gwqDC
oMKgwqAgdGhlIEgyRywgd2hpY2ggZmx1c2hlcyBBJ3MgcmluZyBjb250ZW50cy4gVGhlIEd1QyBz
dGFydHMNCj4gc2NoZWR1bGluZw0KPiDCoMKgwqDCoCB0aGUgY29udGV4dCBpbiwgYnV0IGl0IGlz
IG5vdCBleGVjdXRpbmcgeWV0Lg0KPiDCoCAyLiBUaHJlYWQgQiBlbWl0cyBhIGpvYiBpbnRvIHJp
bmdbVF9BLi5UX0JdLiBUaG9zZSB3cml0ZXMgYXJlIG5vdA0KPiB5ZXQNCj4gwqDCoMKgwqAgdmlz
aWJsZSB0byB0aGUgZGV2aWNlLg0KPiDCoCAzLiBUaHJlYWQgQiB1cGRhdGVzIHRoZSByaW5nIHRh
aWwgdG8gVF9CLiBUaGF0IHdyaXRlIHRhcmdldHMgYQ0KPiDCoMKgwqDCoCBkaWZmZXJlbnQgcGFn
ZSBhbmQgYmVjb21lcyB2aXNpYmxlIGZpcnN0Lg0KPiDCoCA0LiBUaHJlYWQgQiBpcyBpbnRlcnJ1
cHRlZCBiZWZvcmUgaXQgc2VuZHMgaXRzIEgyRywgc28gdGhlIGZsdXNoDQo+IHdoaWNoDQo+IMKg
wqDCoMKgIHdvdWxkIGhhdmUgcHVibGlzaGVkIHJpbmdbVF9BLi5UX0JdIGhhcyBub3QgaGFwcGVu
ZWQgeWV0Lg0KPiDCoCA1LiBUaGUgY29udGV4dCBpcyBzd2l0Y2hlZCBpbiBhbmQgc2FtcGxlcyB0
aGUgcmluZyB0YWlsIGZyb20gdGhlDQo+IMKgwqDCoMKgIGNvbnRleHQgaW1hZ2UsIHBpY2tpbmcg
dXAgVF9CIHJhdGhlciB0aGFuIFRfQS4NCj4gwqAgNi4gVGhlIEdQVSBleGVjdXRlcyBBJ3Mgam9i
LCBhZHZhbmNlcyBIRUFEIHRvIFRfQSwgYW5kIGNvbnRpbnVlcyBvbg0KPiB0bw0KPiDCoMKgwqDC
oCByaW5nW1RfQS4uVF9CXSwgd2hpY2ggc3RpbGwgaG9sZHMgdGhlIHByZXZpb3VzIHdyYXAncyBj
b250ZW50cywNCj4gc28NCj4gwqDCoMKgwqAgdGhlIENTIHBhcnNlcyBzdGFsZSBjb21tYW5kcy4N
Cj4gDQo+IFRoZSByZXN1bHQgaXMgY29tbWFuZCBzdHJlYW0gY29ycnVwdGlvbiwgd2hpY2ggdHlw
aWNhbGx5IG1hbmlmZXN0cyBhcw0KPiBhDQo+IGhhbmcgb3IgYSBzcHVyaW91cyBwYWdlZmF1bHQg
cmF0aGVyIHRoYW4gYW55dGhpbmcgdGhhdCBwb2ludHMgYmFjayBhdA0KPiB0aGUNCj4gc3VibWlz
c2lvbiBwYXRoLg0KPiANCj4gS2VybmVsIGpvYnMgYXJlIGJ5IGZhciB0aGUgbW9zdCBsaWtlbHkg
dG8gaGl0IHRoaXMuIEtlcm5lbCBxdWV1ZXMNCj4gc3VjaCBhcw0KPiB0aGUgbWlncmF0aW9uIHF1
ZXVlIGFyZSBzaGFyZWQgYW5kIGNhbiBiZSBkcml2ZW4gYnkgbWFueSB0aHJlYWRzDQo+IGNvbmN1
cnJlbnRseSwgcHJvZHVjaW5nIGJhY2stdG8tYmFjayBzdWJtaXNzaW9ucyBvbiBhbiBMUkMgd2hp
Y2ggaXMNCj4gYWxyZWFkeSBleGVjdXRpbmcuIFVzZXIgcXVldWVzIGFyZSB0eXBpY2FsbHkgdGll
ZCB0byBhIHNpbmdsZQ0KPiBzdWJtaXR0aW5nDQo+IHRocmVhZCwgc28gdGhlIHNhbWUgaW50ZXJs
ZWF2aW5nIGlzIG11Y2ggaGFyZGVyIHRvIHByb2R1Y2UuDQo+IA0KPiBBZGQgYW4geGVfZGV2aWNl
X3dtYigpIGF0IHRoZSBlbmQgb2YgeGVfbHJjX3dyaXRlX3JpbmcoKSBzbyB0aGF0IGl0DQo+IGNv
dmVycw0KPiBldmVyeSByaW5nIHRhaWwgcHVibGljYXRpb24gc2l0ZSwgYW5kIHNvIHRoZSBpbnZh
cmlhbnQgaXMgbG9jYWw6IG9uY2UNCj4geGVfbHJjX3dyaXRlX3JpbmcoKSByZXR1cm5zLCB0aGUg
cmluZyBjb250ZW50cyBhcmUgdmlzaWJsZSB0byB0aGUNCj4gZGV2aWNlLg0KPiANCj4gRml4ZXM6
IGRkMDhlYmY2YzM1MiAoImRybS94ZTogSW50cm9kdWNlIGEgbmV3IERSTSBkcml2ZXIgZm9yIElu
dGVsDQo+IEdQVXMiKQ0KPiBDbG9zZXM6DQo+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9y
Zy9kcm0veGUva2VybmVsLy0vd29ya19pdGVtcy84NjUxDQo+IENsb3NlczoNCj4gaHR0cHM6Ly9n
aXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwvLS93b3JrX2l0ZW1zLzc4MTANCj4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBCcm9z
dCA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+DQo+IEFzc2lzdGVkLWJ5OiBHaXRIdWJfQ29waWxv
dDpjbGF1ZGUtb3B1cy01DQoNCkFuZCB0aGlzIGdldHMgZXZlbiBtb3JlIGxpa2VseSB3aXRoIG11
bHRpIHF1ZXVlIGxpdGUgcmVzdG9yZSB3aGVyZSB3ZQ0KZG9uJ3QgZXZlbiBib3VuY2Ugb3V0IG9m
IHRoZSBDUy4uLg0KDQpZZWFoIGdvb2QgY2F0Y2ggaGVyZSENClJldmlld2VkLWJ5OiBTdHVhcnQg
U3VtbWVycyA8c3R1YXJ0LnN1bW1lcnNAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMv
Z3B1L2RybS94ZS94ZV9scmMuYyB8IDcgKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfbHJj
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfbHJjLmMNCj4gaW5kZXggMDFkMDg3ZTgyMjA1
Li5hMzMyYzExNDIwZmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9scmMu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfbHJjLmMNCj4gQEAgLTE4NTEsNiArMTg1
MSwxMyBAQCB2b2lkIHhlX2xyY193cml0ZV9yaW5nKHN0cnVjdCB4ZV9scmMgKmxyYywNCj4gY29u
c3Qgdm9pZCAqZGF0YSwgc2l6ZV90IHNpemUpDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgX194ZV9scmNfd3JpdGVfcmluZyhscmMsIHJpbmcsICZub29wLCBzaXplb2Yo
bm9vcCkpOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoC8qDQo+
ICvCoMKgwqDCoMKgwqDCoCAqIFRoZSByaW5nIGFuZCB0aGUgTFJDIGNvbnRleHQgaW1hZ2UgYXJl
IGJvdGggV0MsIHNvIHRoZQ0KPiByaW5nIHRhaWwNCj4gK8KgwqDCoMKgwqDCoMKgICogdXBkYXRl
IHdoaWNoIHB1Ymxpc2hlcyB0aGVzZSB3cml0ZXMgY2FuIGJlY29tZSB2aXNpYmxlIHRvDQo+IHRo
ZSBkZXZpY2UNCj4gK8KgwqDCoMKgwqDCoMKgICogZmlyc3QuIEVuc3VyZSB0aGUgcmluZyBjb250
ZW50cyBhcmUgdmlzaWJsZSBiZWZvcmUNCj4gcmV0dXJuaW5nLg0KPiArwqDCoMKgwqDCoMKgwqAg
Ki8NCj4gK8KgwqDCoMKgwqDCoMKgeGVfZGV2aWNlX3dtYih4ZSk7DQo+IMKgfQ0KPiDCoA0KPiDC
oHU2NCB4ZV9scmNfZGVzY3JpcHRvcihzdHJ1Y3QgeGVfbHJjICpscmMpDQoNCg==
