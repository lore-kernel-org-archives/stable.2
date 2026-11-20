Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203565;
	b=zSV6DwBDEglu3PB4JQNYDc5SRNRKpTDdaf4wOSFM1SC2QEorxI4sMzWJudc4Mb0vrGD2
	 I3jw3LHPGc5SaI7nZpHYImKDtCn2AeYWFvWSF2mp/ZNEHuF7Z9ZrH6aTZ0La6UL4S80lY
	 265jVZSTfKQ14flI+UMckYnVG+wLdA2iL65bQ9403/CDFJw0/6Mn9n+D6POGs3yEPQ+dP
	 b4Vb+pOCOx/uT3sMXNbBwx/6r4BKHWv0MP/BX+Q4zMduFRoZFdoJ7syVhPwyEorETgsHz
	 rUPZZaJQNRk6gK3nBEXq4jrM3ECEx+BREQn4O+6g2Qurs2i6j4xLM2MOYpZMR+ZhlDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203565;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=5+UyzqvattFPBKixMc5DKiQN+B4NXHINUW8NTyNw7HY=;
	b=iPyL7EpTHnpu0Z2xv8sN2784oOECuUSrljeoelYqeTykn3euguIZUez9zPE8ldhNnSlM
	 fkGkfNAD8wQv8LobBpJ5PsUMcYQpSIc4szigHn7ba9exEKUsDfQn4AceMvUAC30ZlhiJS
	 ZVDu3iF4E2RfGl0I9IPDCsL3xcf130me/HYxplJTTZF/xYzD+WcIXVRYtABxqcsMWP71a
	 3oTxv1BzZ4nyG5gv7m7LA5yTGOjmeDhG719zrsq1OkqQqha7kq1BQ3YvhMKd0/Vb5cZXF
	 Zi1/mrVZ1VDsEuS/fq/JPh+v1CgeIKH5x8bPtEU84adOIvXOyYa9lUd3rVGRfYaQVAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+4GG2lb;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ebUq6D6F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297BA606A6C5;
	Fri, 20 Nov 2026 19:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 297BA606A6C5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+4GG2lb;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ebUq6D6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795203561; x=1826739561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4EOaF6OPwknYaOYOqVcuk00cLewl8s/frEbMqRXKPe4=;
  b=L+4GG2lbRuO/d0joYEuE+GWuQ83DzY1D9MX4Mi2G0s8XuHP4aM7L8aFF
   o+6st7njmrsHgMfvcaVFECm50bs3FlQmSmbwJ9jYanamYvfDPlCHWUsr3
   e03TOM1X1rJ9Jh5x56V96SOsijGbHDrPKz4mzOeU5qfOXHnlt+ShImOgX
   zdfj1r8AVhy+QaU7xC/DZIUx7MBPgs+nvV2VOA3Y4tGHjvUdKM1ljwjEc
   vdGr0PsosBMZc1KDgW/757VuunNAWM+ScPI+T1jZhGwU9Bat3bt7Yh88o
   himoSxGwqpKLvLn2kkFYe7hUFcAk9DXMJ/ryKd2FDWRuCm48pLM8fccQJ
   A==;
X-CSE-ConnectionGUID: u3LnG6B5QTCMoL4eTUXCzw==
X-CSE-MsgGUID: EINlz16LTVKFmUfBlXJe8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4190512"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4190512"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 11:39:21 -0800
X-CSE-ConnectionGUID: AoPFjjO6T7Kt0/jszL4vKA==
X-CSE-MsgGUID: lVkGefacROyNMzF3BzkqKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10766763"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 11:39:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 11:39:19 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 11:39:19 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 11:39:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3clmvZ4y4FfQXgHiUh3GAe1hJlapO+93SAutVCKrlNV6v2gNypNmRvDUCPrDfuIjfSJWLda5lAR98oHpJ5w208KxQovGobKnVsfniIHIIl56W/3GRYLdVcqP6FHUfskhesljSlUC8ueTfgvL2wR/LRF/kBccQQwA4uy9Y7pTB0m7hy/BSlcnMdpaBZay6nsuxPsPoDiYtOh2kWLNqbyarvUVxqBSeALWTrvE660QJrbcyenpZHnsPCJJ4Q3ENwxwBwbjhVePfr2QMi5B6+64jrtU0XgKrVS2wgmOSamPaiwC+X8OpyeJeQrBr2NPcEN+z1i8745jy3caPry4KGdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+UyzqvattFPBKixMc5DKiQN+B4NXHINUW8NTyNw7HY=;
 b=C35uQge2pYeW2v9Fb5h9qGeWPm4kH/yLmC1gmYlwDx6CExMZjiCcmDqbK0UeWhPZTbcQolmLvWdcteNZCxc6V2vfXVM9B9JtS+2fV/Upy1U869HLhCjiM5qeFNKYkl+d9bGuY7BkeunLNHjxcxbDwhnal4ShwBPlMi9AjAqIR/i/2f6kbKLmLymYngvXCFPloQ3q6BSptmpIWNXLJ63UKFg9nLLunIkoo/JlCxhH/y2hVBkm0/++Guv4YzOucB9bC7GSUO51nKdxJHplV5EeMTtNH1Cjyi9rvzJ5i06XfPmsELIG/1AA2EoMFVjSqHzhcjEnONiUpia3g8ySBlUQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+UyzqvattFPBKixMc5DKiQN+B4NXHINUW8NTyNw7HY=;
 b=ebUq6D6FBs8SmNS/sl3rTEatbhO3kpy7o9LByxs2wuoP9Pp6/KCGZ/OAfSaYDnF5Dsx6IA9aQ8jOhIyYDrMQfvZkzt5GNRJELu/KpDelyRfo39KF1DrQ3mfzBIDjwVFao6NUaHPJ+Zjd3EWywbm3G+ILdYgDU9h4q2pES17FI3E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DM3PPF2DEFDE2DF.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:39:15 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:39:15 +0000
Date: Fri, 20 Nov 2026 20:39:09 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <magnus.karlsson@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <alobakin@pm.me>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <stable@vger.kernel.org>, James Sawyer
	<jamessawyer@outlook.com>,
	<syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com>
Subject: Re: [PATCH net v4] xsk: set network header on skb at generic transmit
Message-ID: <awCh3QpbrfyZqPsH@boxer>
References: <20261120073917.63158-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120073917.63158-1-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DUZPR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::18) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DM3PPF2DEFDE2DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 385b18f0-7134-4a62-48a4-08df473df5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|11063799006|10067099003|56012099006|18002099003|22082099003|261009223027099003|6133799003|4133799003;
X-Microsoft-Antispam-Message-Info: UzE6kO4ZFYt0mQNTwSUPWWvc/KwNgK7ZOb7X7Nzo+HeaXZlK9r46iSwsJw0U9GNeUwA3qZgxjUNnMc1HoLeGG+NeJw8xVVjTcKMuMjgYKq2K90/NHAe9sQSC4SoOwvJXn3c1SFD6ABLxpy1HPnaPyqzE2XU7ks9G5WMQMnrBPKTr8qCTHd5m7q/WhYgTRePA/kehr/+mMbHENlRWlWKspoPpI+iXfvwr931nFO0lAQBRgUXtOnSMkVNSrXFDN8WWD+9JovLQgS+oxT8B7d6JpCMinrlsq1ehbggcD37Lu42U0nxQl2mBprdYQldWbJGwm+po28rkn7nBkhI0p9MRmuadn3L2GGgTnkWCI7YZHGmnEL4kAgxiSoCjlLcelBbSc/A2Nxq/cqR+tm5wiWybhTKygH3BIwvxOr/XYXdN9R4ZvodLr8lm195UOe0tLA9DqWkhHzlsUcofQd0AOzoMussCz9/hCFyzv0AeHx8gyc5ACivVmNyONPLkMO91WkJXL39GZhJVLPxSDxyzu3uRPMOQRuG1U9/UL8Rp0l2uT1sbwUGSYY5Cwo9VLgMPUTDJahKGVKc9a5PKcYVPMC+EvmH9L+PQD/OpkorPI/Ydz539+myVPdGh29gt0cfCVMds
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(261009223027099003)(6133799003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z/ZiLqGEOmZ9dc6W0cPGXQ5DLRcBezjaG7Bjx4dxtOQBBo3Ep4HNK3Z9fXzy?=
 =?us-ascii?Q?PaR7PlRaxhqgdzRnQHVfyiuLN1rmkCXosDoO9QaZ4RKcLN2Wj6QFCGhoBANo?=
 =?us-ascii?Q?V4V6x5Y0UJy3UB+3TRUs9jp0srH1Uc7orPvWZh3R1mLRD0AmjwTrnrsnkXxv?=
 =?us-ascii?Q?B1y/x88jGOEYue97HVRDKdqHgfhbQVae4gDsuE06RuX22cixOI6buJzP6Dq7?=
 =?us-ascii?Q?M1JTHQmEvGS+gTMJ/UqMAHnz41GfTh4ZZTaGzcO3P5sTpwcV8nrRdN90KDau?=
 =?us-ascii?Q?Jhq/UUYiRyOVXAAgxQgiBBx1kZXKKld872FRk3grF4VJH12p67/v86aUoo8F?=
 =?us-ascii?Q?BMEOFvk+rzrU7TSx1CtCgRiRI0jxMmuWCQGxwApoT6So32FjZCmBhGOyswmB?=
 =?us-ascii?Q?xDCjJf1JKIGdP4lAmaP6KEZnLn//Yddo/tNHYJJ/xj3wtSTC9OH9otug1du2?=
 =?us-ascii?Q?4YzS8mAp+ZOEC1D9IRCwzH87vD8fZpLD5BGWkH9tAnwHzvZWX++CVM2T60lc?=
 =?us-ascii?Q?+GEEZ/5EciDU7LIQgJhY3kgV5X/o8AvgaJSqwCxFZpa3PwJZQ+afqArS6AwA?=
 =?us-ascii?Q?BnFiJ3PB5IU7h5tp/4xdVpVuRB8RnY6nP7oNbdBpvDXxDYByVfA1wgNjrJFk?=
 =?us-ascii?Q?b1UZ2c/zgqBLn8ZYlK8ov48fYRok6jSDVSWxGtOpkCDYGGPm4Lb19fluRHet?=
 =?us-ascii?Q?D28Us5IBW7bTSRfADGseZ9mcEEi4gksoMVzo5ah9rimtcUJhocDgsmRcou0l?=
 =?us-ascii?Q?sWh6BGfYMw8l/W4oPxQsh2XTrp1y9bTMjRJn56O6clc7MosSQTM8RfRiqjQC?=
 =?us-ascii?Q?534hTagNvz9jl5LXW9miZAfiKZ1BynfLUWqu7C5QyEBBj1UKZDw2sTNiUOPf?=
 =?us-ascii?Q?ZOoG0NpFD7ixTGQR6hLk/oWAs+BRXuUUg84epNxjseGUWRxQJpt1Z/ObMcpu?=
 =?us-ascii?Q?sxmV1GqvoMZKS4PXRDFukry/gGYZu//0SMVFBtLGuEbY4DeYmT6mYcgANxZO?=
 =?us-ascii?Q?ew2OuJV0uzlHH4XKVxPpnfyLc5XzRD6XamkkXSv9ZA3k2tcHqhSZ5QlbONGb?=
 =?us-ascii?Q?uOxhX4w7AbezrHa8O24mAwczZFHgOMcyiUPzq5rFWaiyaEf0gkzgTiKn2p0h?=
 =?us-ascii?Q?mBWa57qjV3KrSvgYS3mcfdI+yF8nqboRe037jHju6vfENWm5UKqhno5tO0sn?=
 =?us-ascii?Q?sk7Xa0G9HFYUxBjF8SWK2D1q2WIWmNIrF2y6Zn2D3SPW4j0tE6bkLHuPdfQ3?=
 =?us-ascii?Q?eunLU8Gwb2ppgwcoiU49YGCVrxICd2adcELZ4w+KN2vMZxHPej064FSqRiRU?=
 =?us-ascii?Q?LOKJ0BW6C9MCTDJzyCGR1r9Rno+rO0IF+y7PzyCRDkhp0pfOKVZ+Ny6CMLE0?=
 =?us-ascii?Q?kzj9peh+hI9a95EiJcjWDFUP1rMap1RkUTCE2pfVOKBoOPtp3qCVpduLofAw?=
 =?us-ascii?Q?t5LyJ7dMN3CRE2U5e7IIlmC90bM+k6PdgVKcD2lqidqc7SKwlZPC0Cvud+T0?=
 =?us-ascii?Q?etmheOUV0iHTLqJ+X4G1GjYvroeu9nh9Xf41bHzZ0F413Af/Zbrx8Fs1TZps?=
 =?us-ascii?Q?yci+GRjkH7ntHS5pC2THy94cDsKtD+hTX24yJ9e1OsRjWuCUkPS6Pamqac6E?=
 =?us-ascii?Q?S3o3WGxwYtnyjX0aVfpN+7PUj5K1hgeZwQasoHQyj/WMO4OZJx+qz6zjNZ0c?=
 =?us-ascii?Q?DmHsnMVpNnjP3vyzpwAKtBnuPuGcne9h96I3xwiSmOoSVsGsYBZ20LwNBGDk?=
 =?us-ascii?Q?Y8W6ufqDQcZTHmT+HewMBjMQrvsYpI4=3D?=
X-Exchange-RoutingPolicyChecked: JqTwLSLP/jAGJ1N6+NIdRnn+3OTwzw6EHxGB+snR3/wZN8r2LNiJOm4h1H5PQfD3K41Ms94qcKCHWlrc7sEi4/Ww6MJXnCDG2ffq8szIyd8Jy4veMwGfCWzHF5z7oaUO48tYt0lGSSia0xYaloXWTWDUj7bcFgtVk/fRTKurHHALTw6zaJlbnUM5mu+Gl3v3HeWRzRG6s+mjwGGx0RM4NwnH/ueu0mrOrp2gZ/p4kpodhbZo1F8FZWGC9ogk7kcGupp7dEo6+MCTV17TYeVR3SS73e7WIs3JymB0AAJ8ivEXTdPVbbcW46LY4cTxMdalRoKEBAWvZ6xzvVMM2GpG7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 385b18f0-7134-4a62-48a4-08df473df5f2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:39:15.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig8MpVHRRttzhtFgldJr5h58E4VWwDkR7t4o2t5xT8aecPIRWemNekKCbFJ03mcvx/RzUBTeJNN4hmqxbntSkuLpIsAD3PWnQV6ffB/320E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2DEFDE2DF
X-OriginatorOrg: intel.com

On Fri, Nov 20, 2026 at 03:39:17PM +0800, Jason Xing wrote:
> When constructing an skb in the XSK generic transmit path, neither
> xsk_build_skb() nor xsk_build_skb_zerocopy() calls
> skb_reset_network_header(). After __finalize_skb_around(), the
> network_header offset defaults to 0 (pointing to skb->head). The
> subsequent skb_reserve(skb, hr) moves skb->data forward by hr bytes,
> but leaves network_header still at 0. This makes skb_network_offset()
> return a negative value (-hr).
> 
> When such an skb reaches a tunnel driver like ipgre_xmit(), the call
> chain pskb_inet_may_pull() -> pskb_network_may_pull_reason() computes:
> 
>     pskb_may_pull_reason(skb, skb_network_offset(skb) + nhlen)
> 
> The negative int from skb_network_offset() is implicitly promoted to
> unsigned int, wrapping around to a huge value. This triggers the
> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason().
> 
> Call trace from syzkaller:
>   ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
>   __netdev_start_xmit include/linux/netdevice.h:5400
>   netdev_start_xmit include/linux/netdevice.h:5409
>   __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
>   __xsk_generic_xmit net/xdp/xsk.c:1079
>   xsk_generic_xmit+0x277a/0x40a0 net/xdp/xsk.c:1120
> 
> Reset the network header so skb_network_offset() is valid (0). For the
> non-CHECKSUM_PARTIAL case, unlike AF_PACKET, AF_XDP does not need to
> locate the real L2/L3 boundary: an AF_XDP frame is always a complete,
> opaque blob from userspace. So resetting the network header is enough
> to restore the invariant and avoid the crash.
> 
> Note this is not sufficient for CHECKSUM_PARTIAL skbs, where drivers
> derive the L2/L3 split from the header offsets for checksum offload;
> that will be handled separately after this patch.
> 
> Fixes: 3914d88f7608 ("xsk: Respect device's headroom and tailroom on generic xmit path")
> Cc: stable@vger.kernel.org
> Reported-by: James Sawyer <jamessawyer@outlook.com>
> Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> V4
> Link: https://lore.kernel.org/all/20260902121028.74092-1-kerneljasonxing@gmail.com/
> 1. use the one-liner change to fix non csum case at a minimum. As for
>    csum, since the blamed commit is different, I plan to cook a patch to
>    fix that[1].
> 2. revise the commit message accordingly.
> 3. add James reported-by tag since he spotted this and sent this in
>    private.
> [1]: https://lore.kernel.org/all/CAL+tcoB8f7H1ptcEk1iVH065AcUNPEL2V1gKoJacwr3zndfPWA@mail.gmail.com/
> 
> V3
> Link: https://lore.kernel.org/all/20260901083325.3445-1-kerneljasonxing@gmail.com/
> 1. remove the misleading description about af_packet
> 
> V2
> Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@gmail.com/
> 1. add more clarification about why we don't probe the header like packet at
> the end of the commit message (Jakub)
> ---
>  net/xdp/xsk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f22f9a2cdbbe..52d538160e0a 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -948,6 +948,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
>  {
>  	int err;
>  
> +	skb_reset_network_header(skb);
> +
>  	err = xsk_skb_destructor_set_addr(skb, addr);
>  	if (unlikely(err))
>  		return err;
> -- 
> 2.43.7
> 
