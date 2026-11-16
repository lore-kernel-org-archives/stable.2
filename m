Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794819617;
	b=pl6ZhRsL2PVwUHxJi2xRSXQ1y7TJpNLbBFt1uz+lFlv33tIy9NiTjHudT+QwgjOCLkG2
	 M81BJ4ykwbPSpzByBxMSDMk9j/cWcN/8ugac9aWeiQHtMKvNAJ2Rk2NQMezxKNNiIIjPm
	 Q4k9kWimhkYpkWJ1WdT6osr6QJs1urtf0SXodwj1Jb8sY6X07epAE0j6wxeAAwVN8WU7k
	 YyT89z48Ld4QvUujnZDEevB9h8FFkEmrXprf66bb92b/IpGQQqxmbIcV+RCgh7e0YmfNL
	 lDXovQWfYJAXUVbnPHQ/LGVIBy1nRO9zEmJVVQLQNaxuAkwofKzQjBy4HcN8tbGqdnw==
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
	bh=AfcJRO2/WGqwzHp4uWwg0C7zPYVe38EKk3qMx3CK0ok=;
	b=3CUJqDIcLyHTXcFeSnN7chjQMetCmyIHKjpFgLZlhsK7wmWLeihTb3sBQy5s5DdVcsV4
	 h5uKL86bfyjRyS93oKB3eoZvLXCzMaWLZfoWIAaF2AYHkpOx9/ExSw9ZW7gQgEfxev6JN
	 jM0q6t0t69MVaYaT8GL6nH3cUJoiBeHEJSEDulooNwgiztnGGs4gMpuoDWrezl7Wp1OiT
	 B4m+OAnDbmAVkpzlYa7hQNnHGSHP+KsH8mQizU7JXhv5nSoxhnXCSftEaX7f+kNrEd7WN
	 6c+OeM8D2Jtiawm1YqseOZVhZYceSwkYCXr9S6uCBTIEPfviXdFmMPbb/7K3B0i8oIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B0kX2NDd;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="Nsluvz/+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8A606A88C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85C8A606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B0kX2NDd;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Nsluvz/+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794819617; x=1826355617;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B0KwZw/AmwxFkXpS/fos76ma1FgNUmfmNZ3lS6+/cvk=;
  b=B0kX2NDdwFUUvnamQyE+bHUkrEQwd8oeiq45RtBdW5yiHesW37endzV+
   0MK97XYez2umZHI8z5lMTJoePQFZyFyL8pcv0J/d1fGoOhNd2NCi2O54Q
   Lor4jPgecGL7Z+2DDmKyiPC1B0ZhvNZyvaf9Ngnga1fyfEyfH4remQMoW
   hqz/iGaJ4YLsUX8HvU0KB6YDafnr91CQyDi5ZsFpi3y5brGALT0I/o27T
   +BMQAfUaCvtePtRDbZhEUgS+CqSaaUlqtj2snZOX58bcCLnnli1kSIGca
   1D1G5P949DegnW0UmdIUPyCZO+ujhXNDIGN5RDawVmCLMEdA6PQ6xZ6rD
   w==;
X-CSE-ConnectionGUID: zN3ZH1IvQwKcDqkj8ApwmA==
X-CSE-MsgGUID: gZmMEfP/TfGOv39LiGMVTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3560888"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3560888"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:00:17 -0800
X-CSE-ConnectionGUID: t05fG8X9TSqbf/l4VPBzsw==
X-CSE-MsgGUID: DSLo3z1eQYSImCj8q3nGyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="11275042"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:00:17 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 01:00:16 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 01:00:16 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 01:00:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1ZFcKNPEYVVIoprVjVuCDQCsI0RadoAFEb3NPmfHRIuIKGMT8g3djD3413xu5FdMwWScMdhUO7hsr9zCtElNdYiBkm28Xe46EIte2e5MCINKnqTwJuckdOAy74CIs+pOM+1H5JoBJUnuCX1gKvRx8rSrfdPKkwcRXpmywbWd+i4VaJtY1iAmXFUQti8jgQLLQ9BhT5bC2meeIaTxn9aWXyNzw7DHqkUBvUbgiUp/VbqsP0CSGMR14cpkAkr5QKw3+QLtR+SIL+H/CNFgUZkuzO7Adupku8PnVe7yes8uH8Gdmn5UKQQfLYQp5dSFtNN8XB4iNTKtGaqVAUkJ7vdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfcJRO2/WGqwzHp4uWwg0C7zPYVe38EKk3qMx3CK0ok=;
 b=KQnYDOEumvLfiKPLJS+DA6ZuvxwPzjae7ZpbNrCpFfOj3kZXdcTwDzFuqBMGewTOmRhJ8kmK2m8iyPmfYVrT5ZgH1l9IqRGWme7NdECyra6b+j1i68M392eVseZkWKgScLekVotyqEiYAaq6I0hC4ILZx7GpHRZHUe4TF9sw2Ag8a9xc2gTfTzgTYTcKsZhO+5oz6DiGBhUNaTJmuP730lkYHUHEubCSes3SxqZBjV9T+KXPILqTpye/yf2u/DjAT3Aq4PGCaTbg2Fsb60TAbJ+EoBAk0p3e5r4vkxaM4Aq75S6AU97hVHEhI13hhbRAmz32e+32jtzCv822TsxyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfcJRO2/WGqwzHp4uWwg0C7zPYVe38EKk3qMx3CK0ok=;
 b=Nsluvz/+BxcXLxecOw0FZ0ZATMMejSQM/I9X30yFA9sC4q3B23X+GQ7c3BZSf2ayb1wQSZq2/D5eOBgepDVeOAmqQdlxmpwgzg7dWa+1vqWHYFZx+qZTaAukAgeIX8cRjVUXpWB8hpMDUDnbjHj6sLC3puKevZHMmKFZ2J0h/Mk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by DS4PPF6F32BC4DA.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:59:47 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:59:47 +0000
Date: Mon, 16 Nov 2026 08:59:37 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<suraj.kandpal@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] drm/i915/dsc: Fix the helper range_bpg_offset()
Message-ID: <rp6bsjvjb74hzkjzt4f7heu6kfq3q4ja5dr3zqw5qcxgrwfudf@yifr7g26q5p4>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20261016101713.230013-3-ankit.k.nautiyal@intel.com>
 <20261114070114.3308451-1-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261114070114.3308451-1-ankit.k.nautiyal@intel.com>
X-ClientProxiedBy: WA1PEPF00005B8E.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::62f) To EAYPR11MB115281.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 4bde8275-18f6-4cf7-412e-08df43bff74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: JbBxRUdrvYl8HeHDlMm7FqGvrr4FjhqlJJPJQwwFpU1Igz2KJsoMtIrljMfadK0fP3n0u3agIk0+4zkRqedelNP3oncse9GP3QhuDHIgvvf5digs0eAzgiymQjCEB7/4Jhxgx6sNkAwMrdLqf8EAQKNwdwEvL3YvgLzYdd9a+JF965RenUqWz3Y5AhZdmajpBqzrxIBfc0FYKA5oRSzl2CUU+q+NjEFK985N46xxNDqT9/tNTy+5jP5Fnm2um53RqqEr0rC87q1v+lYKYwe5jfTQ/6bCbosl+OD96hYEiTbv1lfon/P63GPtezmn7LVvU6h7mdCXkOBEc2ds3iUqHOW2D8e+qWD+F+zuSdtPfsYysdaSgrhmav6ug650MFXxVnaDbnCwnlNK579bgHSRCxY2jPtYSMetgnbBn8ML8rF0EoEd4oUBFthBveNS0/BO0Q2jG7xwqOqDuTBL2ks5aY4UGWlWbU+62oFfavpnd1fW9+yKfc1Vw/HUFS/7C9xtrb0xWVAFwcvQY0oBmrH8nbQdbwgh7hDiGMZt2wdmSTpF1u2pPUsmX6/ANQ534ZsXj9Tnk6qxXiReqjJcEa1xkEuyJBiV+73UEjpJHBvzQYtKXzO2Juq0lpFah9OlPNNq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR11MB115281.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXRjck42NjNTY3JISjVyVzNlSnFUQjlLMzV1TXpnZ0cvTnRpelIvZ3NyUWl2?=
 =?utf-8?B?ZlR5M2plODN1aW9reVp6VlZLc0xVcU11Y25IcGxrRnhMZWEyWmhvZ1Y0ZjFI?=
 =?utf-8?B?Y0ZSWFQ4M1RlVFl2RFBaZUNTQkNHalIrWDRCVjUvMThQMmRTRDJCMHpMQS81?=
 =?utf-8?B?NVVoK2FYUldsaklUKytoOUFaekRKcGk4UzJsdEtvQVBlVFJwWmlVSlhGRUMv?=
 =?utf-8?B?U0lxTHBXd0pKTitULzIwVFZXZjNqKzF4Q3dpWnNuVGNDSXpJazZvdzBSNjdK?=
 =?utf-8?B?RG9UR0ZtRUNJQXRvdkdEeURydVZib2cxK21vbmZyclFyU1FmZ2tDRHljM2Q2?=
 =?utf-8?B?SmhWenBPbXVQaWhFUWRnTU5zSW4wVzVZR3lpbjl2akJaaFpHVHVqZmxGWDR1?=
 =?utf-8?B?czJDSkVNTTB5WWFBSGZCYUd1VzJQaWNSYy9kMUxLMFdFL0J1QWxRZElkQUtJ?=
 =?utf-8?B?c3pOUEVLczk2QVQ1YTJTd2JBZlAxa3htMnZSaTlxTEZteWw3SUlZSVNOR0xP?=
 =?utf-8?B?a1AwTUcycFpNdXI2ZDQrQ0c5bHQxOTVOY0dIenpCSzFzcXpLaHY2NDk0K2ps?=
 =?utf-8?B?QjF5aGlZSGI2eHJMTjgxTVBXSjJuNXlYK3Q1ZTgzUGtxYllIQzJnb0Vmb1BI?=
 =?utf-8?B?Nnc5UWdLanEwWE1VcFdMeGs5d2tjQkRLcCtKWWZobG4wZnRrMG1wMG4zWUZF?=
 =?utf-8?B?WGllN2JHTi81MFJFalZ4WkF6ZmJLVExXcUo1Uk1BYWZER3dOVzM5YS9ZdjlE?=
 =?utf-8?B?dXc1TDdlUEQ0WlRLL1VlVVVDaElHTU8zREtLN2lXeFFoMUxEZFE2dXg2VUZz?=
 =?utf-8?B?MjRTQjhUNys3WEd1N1lUa0s3ZDIxRUtHS25BVWlBcUxPRUt4STZJMGRkdDFU?=
 =?utf-8?B?ZTlXRnl1dmRUWVhLTkRYSzVaeE1XK2dDSCttMkFMNlpTUU1NTVQvc1BjS1lj?=
 =?utf-8?B?Uk11ejZzUmlLdzcybDBRalh5YnlzbTBjYUc5a2xPWTRTaExaWDJ5bTNia3Vw?=
 =?utf-8?B?UlhmWEFlTTlFUmpDcWt0REVWLzJ4VnBUNnZHanBxZXc5LzZNRngyVnJGbjZQ?=
 =?utf-8?B?V3dYN3FsLzdVeGtXREo5NHpWSTBxSW1yT0N2Y1NPWHVRaEtHcGFXUU11Rm44?=
 =?utf-8?B?QmhnZUpxRHpEaGJFUjNpaElFdGRjYTRRR1RMYnYveUtXY0RGMCtxTUZDNzJO?=
 =?utf-8?B?RVVpYWcrZzFuOUZOL0pnenJNUDR5Z2ZCTEhOaGt6UTlmQmoxV2NlN2hPZit5?=
 =?utf-8?B?ejcwV1EwL0tuYXhhZFI4b3Z4c3N5QmFJT3AwZllTYk94NW8vMU1FNGdtN21Q?=
 =?utf-8?B?SFg0dnRmOVlUOTlHb0k0ZjVQdXZuWGxtckVueG41cjBSb09YOEpHYjF3V2Nz?=
 =?utf-8?B?MXQ3RlJsaFZNb3Y5eGU0d3FSckppQUk0ZElyY2dCQkF0a2NaVWVXTmxNVXU5?=
 =?utf-8?B?UkhCZEkwQzdwSXVSMkd3clRDMVpQTHlZNGk0YndzLzVKU1J1bHZ3V3k2bXFV?=
 =?utf-8?B?ZFYwZWpFdE1pRkY5ZTFDVm1YL2pwUVFYL1lWWVUwNEhCeFQxN2RwVUQ0eEkx?=
 =?utf-8?B?ZU1vcmVPZkNmWlc3SWVCMFZaQ2l3cFIwdXBvQ2dGeityWVczOFRuZCtqa01E?=
 =?utf-8?B?ajBBMGYxR0U0Sm5SRE5nNzZOcGtnck1TZksxZXJabFplcCtCMUlPYlV6bDBv?=
 =?utf-8?B?Z3lVandSQVp2MWV1bHZLYndDT3IyQ0h1R0N0OGNBK3NMb3hka1o1RnlLUWgw?=
 =?utf-8?B?ck54ZHUwb3JFNGRhTlJXak92bU9zUmI5TW9CR21DZDdTUnhXTE9Fb2NvMzJ2?=
 =?utf-8?B?cmhYZlJZcGd1TTh0YVllYTl6eWhkUklUSlR1SW80d25vVGdvZjdCRWc3ZmtR?=
 =?utf-8?B?bW1rT0NkM25RSmluSDlMU3M2Z0krYXpnOGlLUW9lRVlXTjkwaFZJMEk3Q1Vv?=
 =?utf-8?B?UkdjdFQ3Ukhra2N6dEZyT0hpS0k1WkxIckhPcXVNblU1OWIwYnljQldYcThx?=
 =?utf-8?B?b25kS1RITnpoNHRMY0UyU3k0eWJKNE5aT3FTZVE4K3NGYVZOUE1LUmpaYkVE?=
 =?utf-8?B?em8zVG5PSkxTU3VLWXA3RWo1RWgvRldHakZrVTZCNnVkNDI2Ymt5YU1wNWRJ?=
 =?utf-8?B?M1JZWlhFQ0FVWjQvR2w0VFIyUzBBNUpYVUhqMXpWellhWlVSRkhhUHNsaWFH?=
 =?utf-8?B?QjdXSkZCcWF1T3oyYzRudUR6QjNBSERBTWFGOGVmbVpwRGc2ZFBwT2FYbmRC?=
 =?utf-8?B?VWJwcjZUODBtVzVhSlZxT0dlNGNNTzZKZjZXT0RHTEtxM2dyM2pjZFRldHVQ?=
 =?utf-8?B?OGxQVVZqV2grQ2FsMWIzenFXYm9rdEtnR3YzYlRUVUZqSm8raFVyV3RlYXEz?=
 =?utf-8?Q?4oRPNcMtNPvZmhO8=3D?=
X-Exchange-RoutingPolicyChecked: cVw2p3KyKr+p7rSpdKeftyZy/Lzu3CuQD11kABq9kY7lAmpq4tqGYOrSCUb04qFJSFAy8+t+bxs80kSo0769dbvIbviG/3Yndt1Lpfr8pxT8NYQUXqJj4ORqdVwIX1qJOv6wO07a7JZDo72iHxWpAIRSf/2SyyOZDNvhKcqmx/9xx8qLk1Y55aPrV+712C4an+ucgro80wRbM/P9otCQWtWiMYEaYKKW1lUTO6lqS+QC4OgCG6Dzl1DYAXEJz9ERDJQZ9gHsm5s4PznS9fu1bJOA5J/iaX20K1GPrJLZlBZFG56Il5sPHZ8D4O9dGqhYQZ8FYqXSOwc870Mwpub2IA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bde8275-18f6-4cf7-412e-08df43bff74b
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:59:47.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiWWPsAZR0zA9jl1VaA3RndyhWWvRPJYFDlh3/fsp3ElXhphL/xuiQeAkSbIkHZXUKKzA9zl8/OaqtjZ91G4beGZ/ALBcrHcMQZUcOZk+gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6F32BC4DA
X-OriginatorOrg: intel.com

Hi Ankit,

On 2026-11-14 at 12:31:14 +0530, Ankit Nautiyal wrote:
> The helper used to compute range_bpg_offset() uses an incorrect divisor,
> causing the interpolation to occur in the reverse direction. This can
> result in incorrect DSC parameters and visual corruption on some panels.
> 
> Correct the divisor used by the helper.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9247
> Fixes: 3abe2824e1af ("drm/i915/dsc: Use helper to calculate range_bpg_offset")
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: Krzysztof Karas <krzysztof.karas@intel.com>
> Cc: <stable@vger.kernel.org> # v6.15+
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_vdsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
> index a6556a6e45b7..7a6452557a0c 100644
> --- a/drivers/gpu/drm/i915/display/intel_vdsc.c
> +++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
> @@ -122,7 +122,7 @@ static int
>  get_range_bpg_offset(int bpp_low, int offset_low, int bpp_high, int offset_high, int bpp)
>  {
>  	return offset_low + DIV_ROUND_UP((offset_high - offset_low) * (bpp - bpp_low),
> -					 (bpp_low - bpp_high));
> +					 (bpp_high - bpp_low));
This change looks sane:
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>

This patch should probably include Suggested-by: Ivan Aslamov
(+ his email if possible), with his permission, as he is the one
that suggested this fix and posted it in the GitLab issue.

>  }
>  
>  /*
> -- 
> 2.50.1
> 

-- 
Best Regards,
Krzysztof
