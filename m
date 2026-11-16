Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794819617;
	b=jnLfGD8naZ7lfk/N63DIV8KfCa15J9b1miuaJGIHpUrOwk1E1dlt1EJZ31SAKuJlC+T7
	 AbrAs2owqBKFxofyKKIpxqgUs3PSGHNgLjtaTiMYbezy+st+idcaCyAb4CNsMS4MzANub
	 EWU5olk6L5Pv9ZpRe1uiDUh2XIT1rqu46efZ43YrOqX0a6UjgKjcq7/ly2AGh/Rcmnqro
	 h7jtZXvEBtdHuc/2HMdRXO1SFOd7z8EARj1e1gSo1nVh1EdAepPI2XYgpFYY0P0UXInvG
	 IResngf0TJCvCSSne21fSBnbEw7PBhHzmL4Q2hbZno7HI0zRnfB5Zvyti3yMumZ63lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819617;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:"Organization:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=W18iCXE0dqse/66oGTsnf8uk6Axf+8Sajpka0d27OPw=;
	b=V/kiQRWSfa2lOf9m2PBMG0ckTRFSmnvi05H+58o/1UUpMBGRmXMTcPKxYKy1CZPkqbdn
	 BQg1QI8b1Gs6sLemy3sfMomn18mbciI3XbNdw6/rBAzp/pw+LSbwOgN1MS9Bzdlh9t9hz
	 n+dUwbgvFovHwc1WqL+ECuAiP2A9TS8EQPmmWEmhBeSON8443RjursyOwdeOOPaj+LakN
	 /VFCcvhR9bRy+gignHiOthu4isiG97t4zX13NhDmonTvy8AS5NIvd505WOijki9ykVs9F
	 M0LDkMz6ilc7gpKiHalUIf7tuEjVRMjC1Qtq6HaaMB56b8joU3lNiyLN3QraTpleI/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UXGHJ0Fl;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jh9lk1Sl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BFA606A889
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2BFA606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UXGHJ0Fl;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jh9lk1Sl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794819617; x=1826355617;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cUO2PSJ4mXbnAmMxHxmkaBoTkyuW+491JNTnIKbL4FM=;
  b=UXGHJ0FlUgstdInKog42HKj9pGPzHvEfjmXi/p2YfAI+L3+tWcUHPoXH
   Kf/0WOQiTuDtTEJMgwdaxmW4a1s+ZT3otdU8gUiPyBmdEOZKP0fXCDG3d
   MW6hTqrHgwzFjMj27Ud8TxNtUYzhvT6c+0jE8r/mgfwOH9eWas2lTWEqZ
   Lt0uRir2EtHHN4S4Nq6ttf+aeGfMxf/6dg91gThfKnyLOSHTsT4pjfjg0
   AVK8JLLfYuDdZ97EqHMQjepxHuLH1ix0XLS0sWBMIz53+F/Ul4pMwicQE
   4Xwxub9vty8hlWJ8+cHuBGDgbNuWByJMEOlssdakHQECHJ8PvJ5Osu9Ly
   w==;
X-CSE-ConnectionGUID: MAIgjlbsTuGlrZyzvx7rFg==
X-CSE-MsgGUID: U0+BqLfxRamYThPGgsIRUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3560885"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3560885"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:00:16 -0800
X-CSE-ConnectionGUID: Eluzfj6XRDG015aGmF7K8A==
X-CSE-MsgGUID: KxS8BQY8S8Gv+EHdnnz+NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="11275041"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:00:17 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 01:00:16 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 01:00:16 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 01:00:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j24UkPZO8MSSvWCViQwftdo3o0sZaGPPcMDJqcHpAWj+tT6J9MJWoPZR9NyJwJFUShBblDCdD0IVwy0RFIa1DYQOdwuVOYqbytf+LXq+ni/T+uqdd9XUoLQL1eIigGc7MhxZ9O6JsqoJrOwjZcG1Gmzxcp/o4cfG075CVPXP5VN50ijk+5o3d1giQNfYT7AO9GDwVMnwYPbv/mLiYdlfbnyP1wE315HAJ/PYu2+j4ZK2GOAl20sT8Ap/9tmaogizFy3SNF2Nzw5pd2Z1kzhFoV2HijCR0FLXXHmiq6sFTPW5MJHFv4aI6FT5mGNQvkh5oabVd3Yc/HhWlYAJxEdAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W18iCXE0dqse/66oGTsnf8uk6Axf+8Sajpka0d27OPw=;
 b=HCEHnVX3xRzCE8XlRYQ8y+wVjGYq3FMR1EQKkDQ1ppCEjiupCEk/iW3LW9vh255ifrx7aVnE48koshJTYQPNGljRwHCji+YF4sgjx80RvH8wgE5k+eUaGCIXJ0+Kqtco3R4fLyfAVBMToUksrSjB2bXx2mnwhFgeLqd754/0aPflSoG62jkGlKiNCUxzES6+PpAoGaflID9bSHQn/YX9XPutSihaeifEhH0LkcDm9nyjfRqwjSH2JjwoZIo2W+BxXbRKMCkzAdGzqfO87ExFzeaEAdGq9UbKDZJOPpN0iJGlR2XoeNFhC1NWtBN7iTenaEBPJ0DcPYGhlG13NYuyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W18iCXE0dqse/66oGTsnf8uk6Axf+8Sajpka0d27OPw=;
 b=jh9lk1SlpfRBgoFqkuH/djHPJNA4a445bWFFHPLR132AYGsMTnTuXWWXluk/CybiMoA5Dsi8KfVyBBKcrjMZ0rroY0LNp6YNNFAkxmlSRBV/B1ShVj1wxexCD1pkEVnvStvt1q1UAdyuVLyyKd/FXwG6zbDM8Ycu2xEEMShcj4E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by DS4PPF6F32BC4DA.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:58:48 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:58:48 +0000
Date: Mon, 16 Nov 2026 08:58:38 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<suraj.kandpal@intel.com>, Sui Jingfeng <suijingfeng@loongson.cn>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] drm/i915/dsc: Fix QP table index calculation for
 bpp selection
Message-ID: <3v6cjnwk7pb6tyxc2vct7a7gtst6dbfbcr5w7ugbvqzvfdj7wz@kehqvxzwthnb>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20261016101713.230013-2-ankit.k.nautiyal@intel.com>
 <20261025124720.953439-1-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025124720.953439-1-ankit.k.nautiyal@intel.com>
X-ClientProxiedBy: WA1PEPF00005B7A.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::616) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|DS4PPF6F32BC4DA:EE_
X-MS-Office365-Filtering-Correlation-Id: d196b655-c559-4ca6-3f8a-08df43bfd3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: plVIzx8A6NCXFEgLnXrLXX69CfJxwHnY6zB2tVx+zE1f67lpOSqCMt7OlWzDJ8Fpqxl+nr0FpLam6BtT2lC0+TI7Rj0rJYqxFiIs/UoBzrw8iuoKHadXzeJiHT8wHEzdHrzrgafmf9PeSrCK9DaNL/RGFjZWIE/hs7pperVDP8mIPvhu1LifWHMxQfFN1kd7g58c9xV1wA7kUlqgckw2NyXwNIN7GG5p7548VmVJLZcz/hMNJAveiA5Fi15y3viMimZD48zat2zr6HSAdRY8whwEVLNztPpmHMRD+TebYxqWbKsVi4BU/FvsMqw+aII7Xw8PaFHNDt36QXqt1GSeJcWDe4a1wy8L31DSIk4h3jJQzIDl2yzZFbSeFBQfNVZxo4z3vpTy7vGuGTYifXFCC3WqCX8IB19p6fDx6W1AUEYlRoPHz/HsPM8bek+FINJR2ZxzhYWvhXsHBSsMT69/i+G4ljlXVEQmbHfSZX6/pgTRfIA1e8rFoNbFX34bBCt7M1hVCdwvNXnQyWeB/XlZi6wZmbJAanpdAISb02nQiQL2NKfGGLV4H0391mGyv7Zm089N2HO0qfkhmxev0cYjjekrDO6/iQY7RcDamG/oj8WXgGBTOYGZcosL75kGKL4xDD7fhR3W2SPuSsh0Out4DbnBiKeaP6woiY2+b1eB6dU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR11MB115281.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRsNVdFcHlqcmJhUTkvTDZqeFp3TEdJbHRxc2VxM2J1SGs5d3hxOFZ0Mndy?=
 =?utf-8?B?ZHZOOXRjbHVleFlhdXBLRlh2bEtoUE1FUk9rcGltWmFqWHIzMFJIWnhIa0JH?=
 =?utf-8?B?SUluS0dkYWZzSE8wQ2VwMjhLY2V5dHRjeithMERvTjliT05hV1drNVhlb29q?=
 =?utf-8?B?bG1LMlo5alplNi9DYno1UzFsV2w0a0t0UzZ3UGloT094OGcvcW9qNWhQOTJT?=
 =?utf-8?B?QUR4RXVFQk9GTWp0cWtlNEN1STN2WW5XVjg3VXFaMnJkd1poN3c5M3JwNFdI?=
 =?utf-8?B?YlJPV1hOemo4a3FXU0tEK1hodGhpZ091d2VjTkVtelcyQkxZWnFXeDhpODE1?=
 =?utf-8?B?U05uVzBTM1Fra2g2OUp4Sy9QS3NIM1ZpbEJJMjg3WjRobUExNzN6S29Gdk1E?=
 =?utf-8?B?YXprWnpqN3RnVjBnSGdIS29CTlVtamJxTytTL1pDMWRrdHVDUW5MVWF2V2ts?=
 =?utf-8?B?ZHNOTWNHS2UzZ093cDB2SzdsODZ4Q1ZDQnlHaC81VVpaclo2RVpObjF3LzJE?=
 =?utf-8?B?RFRzMzdQMExmZXJjMDc3dXREYXRrd1FnZUJhL3d6WXJmZ0tyUGdSMkVVTWZN?=
 =?utf-8?B?THoxWk80ZXlIUGZTSGdqaTlDdkMrV1RoZjFsNjFlMHBIem5nZU1KaGwyalM5?=
 =?utf-8?B?eVJyZ213ck14U3Z0Y2RuMVFNZVMxbDVMaVVtUi9SVDgyaUNXcmJBbEp3N1Zm?=
 =?utf-8?B?ODl3RzNiQkJsMHFQMHRja0ZyZGRpc2hzYTRhQzRlR1lYbWR6NEs3MTJjTXVH?=
 =?utf-8?B?cC9MdkFUZTdMYmRMS0V5U0xPdVhKSWJhcnUzQUJuZjkzUUtjdVVzL2dOTXhi?=
 =?utf-8?B?UktkVjh5SnVKcnJ6Szg0M0xXYW4vdS9jMnhyc0h6ek8rY2I3cC9sMWNvL2ln?=
 =?utf-8?B?ZC9VUzY1Q1ZuOHZtQ0FibHFBVWYrLzE4a0VHeCtjRmdxbzMwbEJhbkp2QnFp?=
 =?utf-8?B?VjYrKzlFelNtZVozaWxZMXU1aXJKdG5paVRmQzNjd0FoQnhQaDd0OVV6aVR1?=
 =?utf-8?B?eW5tZ2dnRTNESVBwM3V5YWY3ekFBcWNQSkFJa0FPZWZzTWlkbkp3eUdXNEtG?=
 =?utf-8?B?RDdzRnYxNldzdllZdHYvWVN5bWRWbmpTMTlNNTZPc0lDdk1TbUE2Z2I2V09a?=
 =?utf-8?B?NktnT3dLNzR4bFFtWS9hQjh5RUxuSnFFMERoS0Z2bCtQbVhyZVFVYVdoQ3Rm?=
 =?utf-8?B?azJFSTFuenZqYmhEUjFhbUs2WWYwKzduY1R6UWM3UERoR1c3Z002TFF3aTQ5?=
 =?utf-8?B?QjU3eFVqMTZvZ1crRDE5aC9VY1NRTENZMWxGaTdpQ3JrZXdzYlpRM1AzWkUv?=
 =?utf-8?B?di9ERXR2TXhaL0N3aW9OcTFvV21FSnAySzhySUY5bmRTN3VLU1VURVJERU1r?=
 =?utf-8?B?Tm5GOEhEaW1mWlAzRS9nODlDd05LQWNhcFd2UGdwOERvRE5DeGlzZUVjMk12?=
 =?utf-8?B?cGFyTHM3Rzd2aHZQcXVkblJ6cWFLbmNIc0llVlZScElqWFNtNm5XTHFYNlBI?=
 =?utf-8?B?SHpuWmxBM3ZrbkRsNEwzUDh3bWlCNmRhZ0ZtNUpLdFd4eVRqNE1nN1M0RkxK?=
 =?utf-8?B?cWRKZWlaL21FVXk1SDRFR2FabWlLaFRlRUlZOCs4UlM1Z1I3M0hHaVJjOVB5?=
 =?utf-8?B?SDNuMUg2c29pN0Z5RTJPaGVZM3hXWUxJeDRnS2xJVjFsRXdWOGVJUHVGOGUw?=
 =?utf-8?B?VGJ5NjlMU3ZhMEo2b3ZBekNzRkpzalYrK1NsdVBvUy9Uc1c3MThoVTB0ZVZH?=
 =?utf-8?B?MmJjL1ZvSHBDR0hkOWdYOGhyL2xkQWh5TlR4amZzaC9qM3BXdGRIVGhBZUJN?=
 =?utf-8?B?QmZwQ3RDZm5lM2pqMFU0WllYQkVITlVSMURyQnIzSG9TankrT2FPaGpLTGpV?=
 =?utf-8?B?RzVObktJdUpBM0VEeUI2eUYvcU5pOUpRODFCWFV5S01Ed0pBNzZuTzlpblRv?=
 =?utf-8?B?bzAwUkpjVlVYWlc3NFFMRVAycFhoSGxtNzR5Q3p0TWE1b0FsbVpIMlhaT1Rm?=
 =?utf-8?B?bFhCQUhhMHVsUFBmR1VMNEVQT3I2QlV2WWZMMjlKeXlTcEhqbDZDUk9ueDF5?=
 =?utf-8?B?cnRLSDdaSnZBcGlqMnBtZUtMTUNobWtEbjhyNlNFM0JKazVoK1d1THoraUVI?=
 =?utf-8?B?VDgxQUpJdytONjR0U2IvRDRkSG9XTjYvNUdNOWo2WjBUVExXUWhTb2EwQVpS?=
 =?utf-8?B?WkNxY0lmbG0yQXNQdE5vak5PdEJkRlByMzJKQXJHS1lESXE4TU9OblNDRXQw?=
 =?utf-8?B?eGZKOU1lUzU2cy8xN0g4UVh0YXFCTDNhWW9Yc3RHeVRleHdKNldIajJIZlhh?=
 =?utf-8?B?VlU2eFI4VnVPVE1wYmNtVlQ2clZrWTltMVpZcmxSQyt3MlIzMnBBWW9aOG82?=
 =?utf-8?Q?KPvljk3fqidBFosg=3D?=
X-Exchange-RoutingPolicyChecked: 3Nl5vvfzK4JoTRwjxeicFqzOIwcW4UqiRW7mbOj2D6Fp595irv2fw8XZHPNtFrTrH9+9BW9SmuVbvmQFKglvV+S7G6ZIbpNsj0VFLo/dA45QFAirn6ypCGNCVSkCWTFIXwRJcoX4bFg+hnw0ov1bL18xkrcx3oDRMDkGLMAgTzM5bkTyAryjxJdTqzS1hkNJTm7dYNWV7xf0UqJkpUwxAXsMx8Fk3f2I0zt1cOlsTKgPR42YFkKMsgpodyqHO/RY8eKR35m5GgcozH5Ix6jL1lt/sM0iK3QNHyiCGi9ZZh2JRR5+Eo+LFR7ugBG4cjBe9PdTc8fTXx6nbhetb5G3AA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d196b655-c559-4ca6-3f8a-08df43bfd3e0
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:58:48.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBpWATIV2lMnnYF9GwNEJroUbOuLGxVSgxyTy50hy06iqkoIM/b+JJB+U6Y2wAZp+MHtc5GZX8zizAghZH0chIiprd71hvLU6AG7temptKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6F32BC4DA
X-OriginatorOrg: intel.com

Hi Ankit,

On 2026-10-25 at 18:17:20 +0530, Ankit Nautiyal wrote:
> The QP table rows increment in steps of 0.5 bpp, meaning each integer
> bpp step corresponds to 2 rows in the table. While refactoring the index
> calculation to support fractional bpp, the multiplier of 2 was dropped for
> the integer bpp portion.
> 
> Also, the check for a fractional bpp of 0.5 or more compared
> fractional_bits against 5000 which was a leftover threshold from an earlier
> decimal-scaled (*10000) version of the change.
> 
> Restore the missing factor of 2 in the integer part of the bpp calculation,
> and compare fractional_bits against 8 (0.5 in Q4 format, i.e. 8/16) instead
> of 5000, to correctly align the QP selection with the table layout.
> 
> Also fix a typo in the native_420 comment: the second bpp sub-range was
> written as 4.5 to 4.8375 instead of 4.5 to 4.9375, inconsistent with the
> 9.875 value it maps to.
> 
> v2:
>  - Fix fractional_bits threshold. (Sashiko)
>  - Fix typo in native_420 comment (4.8375 -> 4.9375).
> 
> Fixes: 2df50cb46a4c ("drm/i915/dsc/mtl: Add support for fractional bpp")
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: Sui Jingfeng <suijingfeng@loongson.cn>
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_vdsc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
> index 8f06c3a4d56d..a6556a6e45b7 100644
> --- a/drivers/gpu/drm/i915/display/intel_vdsc.c
> +++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
> @@ -211,7 +211,7 @@ calculate_rc_params(struct drm_dsc_config *vdsc_cfg)
>  		 * For 420 format since bits_per_pixel (bpp) is set to target bpp * 2,
>  		 * QP table values for target bpp 4.0 to 4.4375 (rounded to 4.0) are
>  		 * actually for bpp 8 to 8.875 (rounded to 4.0 * 2 i.e 8).
> -		 * Similarly values for target bpp 4.5 to 4.8375 (rounded to 4.5)
> +		 * Similarly values for target bpp 4.5 to 4.9375 (rounded to 4.5)
>  		 * are for bpp 9 to 9.875 (rounded to 4.5 * 2 i.e 9), and so on.
>  		 */
>  		bpp_i  = bpp - 8;
> @@ -239,7 +239,7 @@ calculate_rc_params(struct drm_dsc_config *vdsc_cfg)
>  				range_bpg_offset & DSC_RANGE_BPG_OFFSET_MASK;
>  		}
>  	} else {
> -		/* fractional bpp part * 10000 (for precision up to 4 decimal places) */
> +		/* fractional bpp part, in Q4 format */
>  		int fractional_bits = fxp_q4_to_frac(vdsc_cfg->bits_per_pixel);
>  
>  		static const s8 ofs_und6[] = {
> @@ -259,9 +259,9 @@ calculate_rc_params(struct drm_dsc_config *vdsc_cfg)
>  		 * QP table rows have values in increment of 0.5.
>  		 * So 6.0 bpp to 6.4375 will have index 0, 6.5 to 6.9375 will have index 1,
>  		 * and so on.
> -		 * 0.5 fractional part with 4 decimal precision becomes 5000
> +		 * 0.5 in Q4 fractional format is 8 (i.e. 8/16)
>  		 */
> -		bpp_i  = ((bpp - 6) + (fractional_bits < 5000 ? 0 : 1));
> +		bpp_i  = (2 * (bpp - 6) + (fractional_bits < 8 ? 0 : 1));
This is OK, but this code was suggested by GitLab issue reporter
(Ivan Aslamov, see the second patch in this series), so he
should be credited, with his permission, for this part.
Suggested-by tag would probably be appropriate to use here.
Could you check with him if he agrees?

Apart from that:
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>

>  
>  		for (buf_i = 0; buf_i < DSC_NUM_BUF_RANGES; buf_i++) {
>  			u8 range_bpg_offset;
> -- 
> 2.50.1
> 

-- 
Best Regards,
Krzysztof
