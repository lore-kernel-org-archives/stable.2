Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273447;
	b=0Qv6K876O0X6cvuFdRjiADU8zIyirmJwuQ11fG/aBeBUxXVHdTqjtA0wlaiLj5yPBDtH
	 fQEbJVgosg4BI2P5UhjpoQXRxnxs3fWXQrvs7bcOlVG1b7dnr7ffRGTnt/g8d773BcJyO
	 dVdTO5c0cSzIk/yLV2+RXP902jvlBjRxQELxmN9xXQn0ekY613o9wdC6N6WhmjnXHXczX
	 uoAOutxj3zSpuutwjRe0FHS9GM5vz0uOm2LAOghIxok66jvsM2VF+PDjP78SBoHN3M5zR
	 LcOUmBYwZOZ7N6dG0eVodoruxgwyy5SS/jaSlzDMCyDKs+4ZRl4OMcv3UOr4RHlycHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273447;
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
	bh=yaGBTFLSdDnInwos5LloIWkiincvckkB8TXJX2SCvCU=;
	b=xxs3m/q6tNt3Wh+e5rOfyLR5Cvj1at32Gpmorr9SaYYUXaCauzsaIqsYF6n2CZ1aBzwW
	 Z3sgcINWVpaX21eJbC9RaR2xuFdU3z9i17fRWyIfiX8E691p2yNJOG4G/hfC3V+iPbGOC
	 CD/pMiB+oPOOZ+alUh2i6WlH+NxgYf+C0QWMsjmAUa9MgllyG9S6S3RCFmkh/r9OXbEmd
	 goin++iMf8Dx6g9ZRsU0xbypBvtZ/bOQZNa/g0yNns6m552W2+9GW2B4yj3HYgQEIQ6Pm
	 +dhbBxencKt8a/YLSIBpJMnN+CDcF6MdzsKVxDR98oWgPM0xwLRCkKgYbM1q9vxX0vQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=niMiVwH7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E20606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1E20606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=niMiVwH7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793273446; x=1824809446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TK2GtH5Q8Fj62BThNx1uCG1Ty6DC4uCktiBLeQRRHyQ=;
  b=niMiVwH7PG36ioVi+WaWJfUQobj0Cm8Jx65YaQ/xxeHPc4MtV1l2q9KY
   TBlgOHvZ/Jp9Pg0xrDnLNK1zSIv0Ii0U+2WR0+rGY9x1Te58Ygl7wxpPR
   qxAbLiqQm8LL9tGufJdhZ/smh0hd63dbc7Y0ygVFOGHZPFFgiyDXYOHGw
   ac1hOQ6D8ovk7ks+VFNBqOLARFg4Rf8GxfKs3qqlSDzIWaQwQ18d2IJLR
   t+2u6nhJUInfG3qh9ltrpBVIrwH8f0o/62Zd5b77VTW7Jt7HexLzuFJsu
   72x43UWxyFYGLZ+N5surs8EYLl/I3Dsk/qXMSgxblKvac+1ULWk5p29uV
   Q==;
X-CSE-ConnectionGUID: AMRSDwiTTF2AHu23faJ+qg==
X-CSE-MsgGUID: d6f1BnPoTPq7rn66iZN0Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2047295"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2047295"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:45 -0700
X-CSE-ConnectionGUID: Ak89kYXKRXWfxW5DK8ywAQ==
X-CSE-MsgGUID: s6DiIVPYQimICDy7dLWaeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5026893"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 04:30:44 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fniSNH6dCDHwW9Ej7gBe19Tstyol6pTd0TTW19jIjLpMpYm72QLGnF62NvwN0yKW3UzHlHS9xWFPFajzlHOjTViLKYhhGOsQ369jxNVIFAJDwv0KwTKT2Ycx0GeTxrhfWbzDXztWAJy3TGvAx6FAxkFMX35Ko2cc10hK8yRHtOGr8d+s8xsYm3e3D1pKBXnLWMQR9e4qVA/VoxuH0z7WWoOeF/3h/oe7dyBSB3PydYQVkT1Pfvs5u6zQNe4NAzgWejRjWlMi90bGgK3w3LcDW33CK3vEsXU1y75VCq+haxCWmhhm6DrIFvb1CceQ5R6Kcwsuo3bVZES3qUfi2/xV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaGBTFLSdDnInwos5LloIWkiincvckkB8TXJX2SCvCU=;
 b=KK4jEpOU78HbTbHS7WNThng2tUSPq2RhwQA81ZuxSWT51z0mRAu6ZE6a9iP70mBSbWvCtHpk2sQdMeoaxx0K0tYgPHZ3cRHDnUN+I2vWj9Nzrjt/d/1SucsRe+5yHZ8Ro0tPRSA8jLAx0KnM86AqVox17M/fnOhvRhPanR1gSo9lIBsQhb4noSKFWbptOnAvEnRePAlzrCSbXiRfo3Rj0v111Ftewx6Oz2EAGzvDrsGwNTev/l445POAGBaPLdvldZv2kw9HqactP7yTH7o1aVmVYTs1IwizecW6PCzlHkd9ecgNDb127QekhJ6Fqd7W7hBJTNXXNw71SKxlSNG+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DSWPR11MB9823.namprd11.prod.outlook.com (2603:10b6:8:4e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:30:26 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 11:30:26 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 2/6] drm/i915/pps: Hold a TypeC link reference for PPS VDD
Date: Thu, 29 Oct 2026 13:30:13 +0200
Message-ID: <20261029113017.618286-3-imre.deak@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6059ecc-c902-4950-91b1-08df35b00760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|56012099006|11063799006|261009223027099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5GMo/al/uja+VcSkyaNU7WGB/yjoro8n+HDOwD7R6y94gTozdBNX/PLPeXM4oT/T99SIEG/dyhK9XQb7r1eEHVIpp1FPTJAP/+vUgBLdTMol4vsqIIkN5QIT+oX+PpIhTk7ZbrjA3BHVsiRB63YT+sJEr7BDSy0o7zK/BpMRT4vN5Ds0LFOsZr6Op839HVE0Cnt3+XFFMN1K23vs4gsAl6ypLUmwxF8U673N2ntyJj/8Mv2njbUiTYhIo+8I+35Dem0BW1ymJWclNxCMrqY2tzD8mTffZDNDZnCqiVubqBoc5xOgxPJyXc0pxH2GbJhVyvmAMoxS9ckTRZm8mrRbTW5Awuj3GcK9dz5vnTOBDDu6fwJS6m9UBHSxdcS615Vp0y1E8ufEaA/Le4CLwfoxu2HCuPuhy+z/3n49c8MzZdZd18yb/VdCeqpKmXne8cXfKqUuzDa2oGtk9nFz4/k///IRMQ+AAWvk6VdRJoa8WOoBJnBdmd99ylqAAJmlp3ZkRp4Lib5mMtnMWY9XxgrzYBK1u4tV5RNPRIvXqxQAfCNv52HX66L0gxmdPIhZF447H7NEKB4TFk4p5cJf8B8zDojablqgv+cc1a+TWciHdIab1ancscM1AYA35LRASOQSsEPFkqbza3jyfrGnjo/xuQ4lIdyvkYdkFMKxWw5UMp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n0jRSzOncxPVpoUO9YBWwOXWCqp5xYQhWsgk7tuVT9SjgjCNPnoT4vZVjHgN?=
 =?us-ascii?Q?75yMT6Fw845rWbixj/ywtonRdaGXQOCCmcQMSa9jmvaijIOfY8j8uyggNjLO?=
 =?us-ascii?Q?tc5FqjiiDdbc12NDJrk059OTb4PwEwnt1yAToxIQNBp2Y8603dtFCrcGXQRw?=
 =?us-ascii?Q?keChE664XpYo6MzVA7+O1sWGFF0HGLiYoo7m5o+JeaKSZ2LWW3b9J+dxHpT2?=
 =?us-ascii?Q?D0CSWFZwQZ2zEJZUXem0nB2k0hOJAJ6iP25LZo4DvOkVCkMJ7aIVx1hA992z?=
 =?us-ascii?Q?l37Bk3YhPPTZdijoIUoeC3nrphNBt647+p+r5G+Rri9p4t5r1McWPX162bYs?=
 =?us-ascii?Q?0NpIMU3fFa1cVfyX/5AwFG/q0E/Da5qpaUTT4EDARQQ7OX5z3lNPDV5JeV0G?=
 =?us-ascii?Q?mgew1YhfkHcGouEjb4nxcSbQ2+yAuoNNf0UpZMeEjK/ND7bH0/uvUrgdxcF6?=
 =?us-ascii?Q?odfelgTEdm5kMOKjQq535ah5Ex1qKXbtjfI0LWVKZtLauOBFHgkgxjoeS9sa?=
 =?us-ascii?Q?usVcFLRQ9Ql/9QHm9/JYydr5hUF/JNY5bNpD+N2mXIJ/h2g2wQMzkcefsX1A?=
 =?us-ascii?Q?eqRhcyF2LKgwpoSehCYFbtE5q5TBwWljFqscDD+GysEA6eeZMWKJaLBy4Par?=
 =?us-ascii?Q?920LA/5CvmrUp1MwE7Q1CcNZtdwobLD1Pab7mWmaz2TzvINDICBwePxtwM7C?=
 =?us-ascii?Q?ef3PjjFzaQTVv2AQvJ0iy2TuMjCFnidT+kFVu0Uqsm7p7O1NcKwbf+TkqGW5?=
 =?us-ascii?Q?RuvpzOCbSLnHpl2ztK5tRYGuvBPvdC0TvGE9nYYs4Otk0pfuE66rCZbruZx4?=
 =?us-ascii?Q?WGTmng92OiEhYp6voi//fW4DBUyO2PYbD2wL4/umea7j9tu5pf/dknCpUTe+?=
 =?us-ascii?Q?+ouojPsiAYBDu5fiuA0OKXkQegEQ4E5RegqPismbN+PrEPpBA9nhZ2JWFRMR?=
 =?us-ascii?Q?BLYU3qwlQ7ejADSYWuwbyiIr1mJ72yQbaUTKhQ0wX5HQq/voN1YlQMmjF5kz?=
 =?us-ascii?Q?HUgSXtnL1h+sQ11rEU7ifIzcbNWV/Mu0s7t7BMwv5Tjy70HVjmHywE233JOl?=
 =?us-ascii?Q?c84Rh4nZ2uUdZj0lMu35V40R4lktpe+eIdzIAWg9jvzx2QXx6eNkWh+r4cEY?=
 =?us-ascii?Q?OKwKvdQHIE4SSvKCZGzeY0BgAok1Fn2h3xYeTsyxv0/44pVVCEU3rZBbCYmQ?=
 =?us-ascii?Q?f4WFtr9QRu/w6djMv+QHFbxDBNxKL6ola+WXdYOAcB8ZNzvtWzXLESoEPCYk?=
 =?us-ascii?Q?oi6oT5NH3kXMANfWVm1YJw5s2GmCokb97/2yhxE6s6CPJhDDfcp8rSFuth17?=
 =?us-ascii?Q?L5kQNazrh9XTTLLOwPgmMX7Dcvqvw16vQK+b5AsFztHrXMRk6B2EI53B12Y3?=
 =?us-ascii?Q?nKLA/4tAn6IDyHp1y+xia5p9YJVOSIK7NMVhjGLsR+6JC7sBC3seROIFRZDH?=
 =?us-ascii?Q?HC+XX3vw9Du0xXzwBmdMCkFA7A6JhSAETMDxorCqs917ZwCPcwabXaeIUcGC?=
 =?us-ascii?Q?MBSkJF8HVKKjBp2TRWpgO6pA0HdAFFRFIOUWITYXOWKXgyqkvjv+wn1+dMQ7?=
 =?us-ascii?Q?Z3fqOjtcrRGEpvYyQe/qo0PPIuSGGGR6vcQT2kBmUM+0YdT9lqxFYNnZV1xs?=
 =?us-ascii?Q?yH2LOwVvDDSka26do2rnmeimeGGqD4i+HDFl73g5P8Mn2l5otNs6Cisb2rpH?=
 =?us-ascii?Q?ErlAv5k8WM7YeHcqtWFB6YgGfaNC0sGCHi/dPWvy3N4fTXlmOTUmSa7gZgns?=
 =?us-ascii?Q?7qc6KWWfww=3D=3D?=
X-Exchange-RoutingPolicyChecked: eUP/NxbZjH3Ud+0zF5wzi9km7mKA1a4vlEjmkB068/KRC3LIEPvCHsilEFSvf8YalIqQN9FgUjtkTnbYjnrohkUQXXMhNMjXEDBqSP9qBsDnwhUm6Skt30gAZPa0dCoFNr9KbQfrILIqxaD5f28TD3dGrvSJ4Su77F6LV0JUKa9QBInSDx2ywI98sWk+SdD/pKhtM68pxjbLCI4fcvOUuxnWAZBJ/PV9jA+TPLnpGeY/EVf6od6+Xqv6lw7lrV7oT6RBdSYsf7ppiQCDRuO4H7elwzPsTqamxqYkStjUa8+Sb0g/Pe3qBdJ+O5mqb/7mywbpv3cktIjtZH062CbZuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6059ecc-c902-4950-91b1-08df35b00760
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:30:26.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22wZugEnkcaWrbmJgcOKMabZug6pKCA1UYmot2ic1aGrSx+yFUEU+aPggL8hs8LYKbkUN2bKLWnFg/TqVOTu1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9823
X-OriginatorOrg: intel.com

On TypeC ports, the AUX power domain reference held for PPS VDD requires
the TypeC mode to remain unchanged. Hold a TypeC link reference for the
lifetime of the PPS VDD power reference.

This prepares for an upcoming change that will use the TypeC port type
for eDP on TypeC ports. Allow the additional PPS link reference when
sanitizing the TypeC mode.

CC: stable@vger.kernel.org # 6.14+
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_pps.c | 14 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_tc.c  |  9 +++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_pps.c b/drivers/gpu/drm/i915/display/intel_pps.c
index d4c98b150fa2b..8f1bfe4340971 100644
--- a/drivers/gpu/drm/i915/display/intel_pps.c
+++ b/drivers/gpu/drm/i915/display/intel_pps.c
@@ -23,6 +23,7 @@
 #include "intel_pps.h"
 #include "intel_pps_regs.h"
 #include "intel_quirks.h"
+#include "intel_tc.h"
 
 static void vlv_steal_power_sequencer(struct intel_display *display,
 				      enum pipe pipe);
@@ -758,6 +759,9 @@ bool intel_pps_vdd_on_unlocked(struct intel_dp *intel_dp)
 	if (edp_have_panel_vdd(intel_dp))
 		return need_to_disable;
 
+	if (intel_encoder_is_tc(&dig_port->base))
+		intel_tc_port_get_link(dig_port, 1);
+
 	drm_WARN_ON(display->drm, intel_dp->pps.vdd_wakeref);
 	intel_dp->pps.vdd_wakeref = intel_display_power_get(display,
 							    intel_aux_power_domain(dig_port));
@@ -864,6 +868,9 @@ static void intel_pps_vdd_off_sync_unlocked(struct intel_dp *intel_dp)
 	intel_display_power_put(display,
 				intel_aux_power_domain(dig_port),
 				fetch_and_zero(&intel_dp->pps.vdd_wakeref));
+
+	if (intel_encoder_is_tc(&dig_port->base))
+		intel_tc_port_put_link(dig_port);
 }
 
 void intel_pps_vdd_off_sync(struct intel_dp *intel_dp)
@@ -1066,6 +1073,9 @@ void intel_pps_off_unlocked(struct intel_dp *intel_dp)
 	intel_display_power_put(display,
 				intel_aux_power_domain(dig_port),
 				fetch_and_zero(&intel_dp->pps.vdd_wakeref));
+
+	if (intel_encoder_is_tc(&dig_port->base))
+		intel_tc_port_put_link(dig_port);
 }
 
 void intel_pps_off(struct intel_dp *intel_dp)
@@ -1334,6 +1344,10 @@ static void pps_vdd_init(struct intel_dp *intel_dp)
 		    "[ENCODER:%d:%s] %s VDD left on by BIOS, adjusting state tracking\n",
 		    dig_port->base.base.base.id, dig_port->base.base.name,
 		    pps_name(intel_dp));
+
+	if (intel_encoder_is_tc(&dig_port->base))
+		intel_tc_port_get_link(dig_port, 1);
+
 	drm_WARN_ON(display->drm, intel_dp->pps.vdd_wakeref);
 	intel_dp->pps.vdd_wakeref = intel_display_power_get(display,
 							    intel_aux_power_domain(dig_port));
diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index f2d86b29c4154..f878494bcb388 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -1669,7 +1669,7 @@ void intel_tc_port_sanitize_mode(struct intel_digital_port *dig_port,
 
 	mutex_lock(&tc->lock);
 
-	drm_WARN_ON(display->drm, tc->link_refcount != 1);
+	drm_WARN_ON(display->drm, tc->link_refcount < 1);
 	if (!tc_port_has_active_streams(tc, crtc_state)) {
 		/*
 		 * TBT-alt is the default mode in any case the PHY ownership is not
@@ -1683,7 +1683,12 @@ void intel_tc_port_sanitize_mode(struct intel_digital_port *dig_port,
 				    "Port %s: PHY left in %s mode on disabled port, disconnecting it\n",
 				    tc->port_name,
 				    tc_port_mode_name(tc->init_mode));
-		tc_phy_disconnect(tc);
+		/*
+		 * A link reference taken during a preceding (eDP) connector initialization will be
+		 * dropped later, also disconnecting the PHY.
+		 */
+		if (tc->link_refcount == 1)
+			tc_phy_disconnect(tc);
 		__intel_tc_port_put_link(tc);
 	}
 
-- 
2.49.1

