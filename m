Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273450;
	b=iPYuxCV0FcZS5ouUxZiBIE2J1HwFf+m1HEfkAYaf63T5ap+O4GVF21KUn4XhKDxBB1bv
	 PAAixDBTqoZmlta8DiLCBKltuVY/M2syRGi7gmkBPUTHETd9IRYMc6sTr0nfA4f199GaR
	 DpV2Ca1TOIv74OHrqmVzvxCnY7zVOnNZ1KWWmb16S6Bf9xAg4hFdhlWmecFSFICMHOFhR
	 VEriRPAYKtJLypQMpwJKW3+0HGgkyWNzzSVR4hdcoG+2tcjVbVRHmegFvJra81kcYfRs4
	 0wC+LEQ5zjrDIuzTRm49rSPuxT9R5ji3ob7pVUEBHFxqZaiTtyQpAT/Q50u+m1YMbhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273450;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Organization:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=+t9rxXJX+eW5KxsyfZehOOaXuzeaLOZgBmMrYeV/Zmc=;
	b=DU+PBHdUagaGdwqBuJnefdqhzqsIpCY5rFrnSD7C63Los9o6eX97KpbfmidobkUB7bLx
	 B5G9lIhULJdvhkP5r+ct2iPSP0+wPuxhLOoXgFILUytSSyfrUeLpPGMDYX693IoZH3Cgn
	 EXUttMSo2Vp0t1zItrkRDtW40r0oeyk/u0+MlhAo9b1AQWZxpvkn/tiOo8o3yjfGaLxdS
	 qdfeU8mzIGWM/BtHvrA4KxbRCHMAhFXMDFvLbjbm1uGt5/seim88pWhChtuqOa4jLD/wg
	 XkQLXhCc2Ac+n1H/EYIAFsboF/12y14oBNjkWJGxNB/r4VWiIUVjAe4jUZ57PQ8Vopw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HyXZvdjw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A3606A31F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB7A3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HyXZvdjw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793273450; x=1824809450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kljwcBTWIhpJdOfVUrwoLJ6q2esf8GffPAjAgTFvVnI=;
  b=HyXZvdjwplblD5opGCVA8Wh44yhMX35sMRF13vJKHeHr2K1iVI9NrohF
   v1CTUmy91Qhe22UEZLVk23Tu8y08r41ToemQOkznjv6/jLm+rsVNHnL+m
   ocESwYjh7GjNXLOpBZ5dsueJKsVNl6nIzrg9cwBLCZmjzXCWh/KZKtZFU
   O21nRqa7YFTqBycCWPNO+TN1gctFr7aeybublr92h8+n+W8eRda8I6bXP
   4A/K+puw1/aW82ptHPKB19VQ8KhkmPxdplxJbxG9wZCL7z4Psmf/gzUGL
   Z0xfy7f0irh4NBsNp40QFGJOyr8qvwKuk6+8J0IwGM4bBDITtW4bpkD8T
   g==;
X-CSE-ConnectionGUID: ZfJPZ6bjR36ngyk/2uCpKQ==
X-CSE-MsgGUID: ytidxkCtRGyl3IDvYnUrFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2047302"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2047302"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:47 -0700
X-CSE-ConnectionGUID: 9U8MnLxkSZOVjTLkcC0Q5Q==
X-CSE-MsgGUID: NYztOZqPSOenz1McOBUgxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5026904"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 04:30:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYlO/nNclKCYxp8EKXKQ6BWZ+DtrEyRB6ya9ac3LVWXqXumPgW1jRpWcZbPf9mUlIj55tcMKWhFwS9c0CvSylWzj7rZomPwZ2TVnR0A5SJ74lZMCsHAn0GXXEdH9DK4PWhwSrL0ja/1V7v1aQNn8lAiAlUKGDFi98WXyzT5xq49kvyvYsb/oxyL8vevz1YLl6Qhb2XrAekjisx07RqV7XTVOh1htcH9sQCsxMlTH2akeVggcNv4jwESBj4TcSsq3piUCPbOUpjNG2Z1qSI0Zx+a9PxhRVWXuO/JVR3j8K/lrh6Hva1deQntYgsLPod42+IBOvBb9/w3+vwqCjrZ87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t9rxXJX+eW5KxsyfZehOOaXuzeaLOZgBmMrYeV/Zmc=;
 b=t/sXtilhyeyCzB9diPIokEVS1QXEo7tLyY0e6neE5R7YC5LGBbyDsy2qpxRDfML2NLRToeHpCVZ3QcVfhferk5ipa2EkEDOm756Qnr0T82D9kNX9R7GMPYa9SOLtIUqhMhhERvN3Mx4lKL0BPN6KE35r3R9P6rX5LX6cp1GT5phFPLTDlRtkXL1ORfUNBtMSaoFbym2CZDgbWkjJ5oSFO7OhVqd9rAlHG6uem+o3YOqcMRYSB3C2oHyDMByWz1uvj9A+etHQRW8OM3v9kOKSvJD98/OirGHs9lzd7SXcZK5ZF96CfnU1BAhxuvIMouU0CpIA/7ZIn4JO5kAIFgENZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DSWPR11MB9823.namprd11.prod.outlook.com (2603:10b6:8:4e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:30:33 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 11:30:33 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 6/6] drm/i915/ptl+: Fix TypeC detection for eDP on port B
Date: Thu, 29 Oct 2026 13:30:17 +0200
Message-ID: <20261029113017.618286-7-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20261029113017.618286-1-imre.deak@intel.com>
References: <20261029113017.618286-1-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC22.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::119) To IA3PR11MB9273.namprd11.prod.outlook.com
 (2603:10b6:208:573::17)
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
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|DSWPR11MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e08aba-54f3-427f-df45-08df35b00b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|5023799004|56012099006|11063799006|261009223027099003|261022075727099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DWmGH3tRox4q31/vGgokrH1CGqct7UR2cS7rDX1eW6jDZmvP1R6UauYGG3celHadEhHFyjm5ORCtrnik4/MJD7pzaujSIHECIoDWE/ziQqoIZaTkwsuguTB89j48u3Oi0nMh37HQJWzhEoChjQLjhbf3Y83XaO4aIVQGzkiuGfz28zj9iYXllNdBicEO7zBJdVjmwHOMuBsf5VfxS7T/yRn+HJMBahKaULoLxDgVbh6dNlDUl1ykVS1zRV5PrAnLbCAhYH2JGrmzZB1agq8pDRzJOAfJw1Z0NdhKBF5jLi3gRoSFbxjZy4QF8whhlbneztEtDz+myDIrviNylQUNP58/OXcaBVKxo5gB+HizTIqg/RJ0SEORW8kA7IGapG5qmfScPjGsle7udiDQC0Y/Q+XM9620oZJQS/9wDVk+/TAHUOsy6zKGBk9huDygWUd0tOIGUX/ERKB/woX8NT52vbgaEqR8SfCEBERGYJIU1Yi/Tko1GzUrwtl+cRpgU41Yu4zN1wPEfqbmEmqTru/tf/u2nMzud6bvxRFxvFIiP5oc2lvdedduy+9FJVby08NOqLIjYkHgkRDBVBn1YaVqKg56m9q7/5MYnz4jSrJUXIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(5023799004)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMVEGaUjY0a8l9YOXbrVnxto+5xDgp+1fPyBBf1wo8MpsT/hL4eWJVlmFiWz?=
 =?us-ascii?Q?V9BOuf0yF6Btjrqc2qaQwG29tggY2RS/WOFoL2OkxAfmYLI8jVUjY0SOaaOO?=
 =?us-ascii?Q?P+IK7/50+Lcd7obtelF6AFlZfj6L0G2r9y0YSx2GXinSMASRkejzdsJYoYmK?=
 =?us-ascii?Q?F19jY4KNYv4PaWZ909SSozgPFIMxdlRdnsHEjdO5Yl4u+RzYicJsYbtlWwrB?=
 =?us-ascii?Q?EHgzldpFGzxi+fxz0hWz8++QXVGE1jvofrbR3zHaRpTWQ+Ab5a8WzcozSmDs?=
 =?us-ascii?Q?KNKrdvi4rNv8sCvZh+KIYgdqq886ERmKN5pgjaOXBd3AlYs/2po0n1/6J29j?=
 =?us-ascii?Q?stOUvE3/7jPzODrSJpoInh3opDpna/WVrIDNBVGt3/qUHzpV8nLmU7BlD+VV?=
 =?us-ascii?Q?VGOZTm3GC/xZ5p+tyPL/uQ7tIFyBEJ/z40OVrLMKxM0tlUwENIl6OINJPaCg?=
 =?us-ascii?Q?jLr0/ob3VLdQP3xLPokvAu0McZ5Stgq6VFA1vPm1MnZ7TnVkYynKZGAZ/vdl?=
 =?us-ascii?Q?l5wYHMFbkUCPMLSoiofehxecfVsV2A3IC0tewCpWhktBMjwB9SJJ6xXgqMsP?=
 =?us-ascii?Q?u0UD2LLOwp/Pu73fLn5PkNI1ZebD2i3mazV920v+jzek7CiIklr63JBst9Mq?=
 =?us-ascii?Q?CLCgo+SGbx4pTWbZAFsjmmtX70LExSmGcUglKYHUT4pkNc1cPr7O0mTMQDFW?=
 =?us-ascii?Q?VqmfGoG4Bt/QmS8r9hzJQhCBMaPLGR1bSTDkQtT5E31r+YZTvC86Q29PRMgC?=
 =?us-ascii?Q?FOOZOkbXcKOHeNdZNm8VtEmWps3oAF2Na6OFzP2UgDm/PEkOoztKclBpp+Wf?=
 =?us-ascii?Q?Hx8BoEOdxgZOUX+RVCKWMZGsyC3nB2QkeGM4Wcy/KDyYy5bDytHgnLMmI58Z?=
 =?us-ascii?Q?yjM7tvf5ffWOuyr/lqNlqyietS6Ly2dD4wMCcnRKF4d4EaBavh98QzaX7qy+?=
 =?us-ascii?Q?J5aSsrDDCN98kFFMsYd7C7e2dPTy5QRe9qzL4uLVhK1tcyNX1MwWHozGzoKF?=
 =?us-ascii?Q?DrEX/eTu/XXOWdK+Ue7pgvIM+bDiUNFEzEtMhGUiwmH/ighnFRu0kAsfJXn0?=
 =?us-ascii?Q?24qYozb/m/FI0D0NTEU9pjZ83EnZM7vzZaZIKBo6Cn/E15mggbR2DrgudIPe?=
 =?us-ascii?Q?/tzh6fPl4RTio+PDXp134tjuiCVYMV0qfbgJ8XmbS/f7DnMVr5/oo6on+XdX?=
 =?us-ascii?Q?xCoua527orEUa/0O8HiQOI3dvGZXbl4xMwqQeS4yizR4NS31hyJdXmEiVGlr?=
 =?us-ascii?Q?Ts8Hva7HDu60anCjtbrUsGJeeqZZALSV49Wxl7nocc9BSbGRzY0+iUtjKPtO?=
 =?us-ascii?Q?DjEgu+Ze5j0U/YYBxcEu+OHaV7d7b8UdI3KDltCN13iEJm/7ysad3DVeRDBL?=
 =?us-ascii?Q?raGRYEuICNZlt94OEUToq8dAq10BzCwdiLhsa29khslBzf7byTHtElzUvpl0?=
 =?us-ascii?Q?ZPWSeHUSRodaLJdPn7sZAH6m/7rueKm+06llbg7MLgnXo3DVNVNNJFfNRfD5?=
 =?us-ascii?Q?8slu3h5fp1s3stXpBZ2W3LhVy4biMs/JsInj1ua/dLS4nVUS+pw9zkjUYBo3?=
 =?us-ascii?Q?SV6jyIgLJp+p6tQ/JP3xPEsoI13CPPuXd5ZL3ggyR2lEBoBmP7IaV26gi+Vc?=
 =?us-ascii?Q?YY+FlXInp20m4Hhfz3TkdAXvfFrzH7Fgr7XlTGslG1t3ffel5o1zGFaWQeTj?=
 =?us-ascii?Q?tQyMvR1RSIM17YSOqANr1oWYwcDXFkipjJSYATBYK5qp10w/e+icEiH6s//B?=
 =?us-ascii?Q?JXmBd9wvGg=3D=3D?=
X-Exchange-RoutingPolicyChecked: NesgVZkHjDrQaNbe80guiuHtmu9wSB3XvRrl8zIplnwz6iicVx6eZ/75NoklJu6xnzsNRvovyVVF3diK/hiCramXosG+IL4Ev+KB58vO7BMVqyq0bwEt92F2k4sBnc/+HVc5GmKdZcBvI8K6vrjhVs5GGgWIoTSfBIUk03M5+sOfwHZB9koRiJmb6KWMstnS4ahFx8UsZobnsEcWOhNAtk3dnzVqbpXnYO5OZAVxy3woq9E8I1YBI4CKDJLU88aee4PelPmejFv/gMkktmcztMQanh6CO5Dpx1BcF5FXCI16DxFEYk3eSFVZyb9ggVhohYq4wGe4kh2PCCtuBElacw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e08aba-54f3-427f-df45-08df35b00b80
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:30:33.6597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBi4apaLm+ouLD4x5GbUybAqku6D9GzNOO4In7GzhHSx4PuEzq6RrOSoFjZ5iIwrCdEyHRvogwJWl4DLWn2CAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9823
X-OriginatorOrg: intel.com

On PTL+ platforms with eDP on TypeC, port B's DDI is connected to a C20
TypeC PHY. Identify PHY B as TypeC and map port B to TC_PORT_1 when eDP
TypeC support is enabled.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/9196
CC: stable@vger.kernel.org # 6.14+
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 5e40487e9ab06..10af12846e730 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1904,6 +1904,11 @@ bool intel_phy_is_combo(struct intel_display *display, enum phy phy)
 		return false;
 }
 
+static bool intel_phy_is_edp_on_tc(struct intel_display *display, enum phy phy)
+{
+	return DISPLAY_RUNTIME_INFO(display)->edp_typec_support && phy == PHY_B;
+}
+
 /*
  * This function returns true if the DDI port respective to the PHY enumeration
  * is a Type-C capable port.
@@ -1924,6 +1929,9 @@ bool intel_phy_is_tc(struct intel_display *display, enum phy phy)
 	if (display->platform.dgfx)
 		return false;
 
+	if (intel_phy_is_edp_on_tc(display, phy))
+		return true;
+
 	if (DISPLAY_VER(display) >= 13)
 		return phy >= PHY_F && phy <= PHY_I;
 	else if (display->platform.tigerlake)
@@ -1974,6 +1982,9 @@ enum phy intel_port_to_phy(struct intel_display *display, enum port port)
  */
 enum tc_port intel_port_to_tc(struct intel_display *display, enum port port)
 {
+	if (intel_phy_is_edp_on_tc(display, intel_port_to_phy(display, port)))
+		return TC_PORT_1;
+
 	if (DISPLAY_VER(display) >= 12)
 		return TC_PORT_1 + port - PORT_TC1;
 	else
-- 
2.49.1

