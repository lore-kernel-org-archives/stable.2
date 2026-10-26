Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793022180;
	b=QP/HM6G1moGM+vcywHvEtdj4knH7KbArGWhwENdLog9mNFUA1J/joaAIa9EM1dAvdoFu
	 6BRwUfC+4sdSWmO5g6OopouwVCfcAvxot50gxwFI9SZv/slL64/HOw9D7imr2LZGMejYw
	 tjnBSfVjhHxLLW91aWxlHGzArpwXidtOqBafQxFm7Qfm7N7lS2WQQP4XQXvlD0+qjK4iX
	 /C5cJk7wNaipwEIOmcn54dV8v86tvScXeHrgaRZbE9x5UyCokja7gKPW/OIHNX7BLBJOV
	 NaNY9Dh/NNb3vK7FCHSh7MsJrbtJBByFMZei71ItWXKhc8tPNobuqKP1ZKEDiy0cqMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022180;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=ar2lwiGJ8k/e4txz4I+44bjUWQ0ztjY4dCSE5R+sQZM=;
	b=mfXExOl67tgus6i7KP5UJazKDTzjQsEd+vnqyvYvxjIw/grq60v0CqHa0AtHEAaWyuKJ
	 3W9CMzA6U4AWKJ2OpUWY07kqxGBTgw59t4YGVoGS6M8oz/1R5DA6SnbsMdCWSV2vBXDTc
	 yR4kM5YtAyccppAePr8+wgd5LNeibEiA0RwkSSRdf/5gKpw/JdNQet6ZY1crIpvdVzpjC
	 Ih/MGdmVoqY6I/p3O37QzMUuT4ilFt67yXTrpVcRAJRJKpyoHxl2JYtNPa5CGhfAa4+bc
	 7mxGQdZOsElL4S9E7WmuFMSG+DsfHlxCs+aQi18me+B8MzTPcTxvOKzzT0U0CGS2urw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BOE8zUtS;
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE0606A31A;
	Mon, 26 Oct 2026 13:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DBE0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BOE8zUtS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793022178; x=1824558178;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rVapdmY+ucaYlzfCXm1RDVtMn7PfZrCNyykan+Tlc5Y=;
  b=BOE8zUtScwZwjtL8896jdM35/OqjW+Lf7kA3LehXO0o+U/wq3/7+ECrx
   C2cEwd2kNJdUbkrFoLgw7t8CbOnawU1uiR9NsaVDyUxS27kxS/9QPHrkq
   ja5y5PITbjQdVJyUQVNgtVYuzIuLIsbdK7LzF949+dD8Qhffm4IhSd8Xa
   1i7WmxneGB5DnErEmv2dlFdARCSfB3Esmr3FqLrvdujX/MvqAnPtM9Pdd
   b+KPKqwxn83WIiDSYLKyZuu2RjYMbUYdYLNRosTBYb4Rt+EBh7eXmCAop
   rtHwQ8OzR0ZywqslF56C2mE0cpevrNPyV6lyj8pJT+SsJu7yz6LjhK6nz
   w==;
X-CSE-ConnectionGUID: jbBdBUhjRIWhjJflAixtCg==
X-CSE-MsgGUID: rfNorV3zSOyXDnOKLmip4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1694444"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1694444"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:42:58 -0700
X-CSE-ConnectionGUID: AjU9slh8RJ+QeekNSxC+xQ==
X-CSE-MsgGUID: EyjdbrpyRwOiSYltlN9PxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4177565"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:42:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 06:42:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 06:42:57 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 06:42:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvrg4kQPo+Of5tRFkQuBJMbhAn5quwvCAgoV8dhX8zTxHcGFTFjM3JeOgXfwuIRAczxvz2ydUvPKBXZ3murxhVw6yLr1XUBUV1VzB3uWHh05vaidntqRU1Ih3+7qssNH3D5CTe+gZU4+RH9j9T7NWy7SzCCV69w7lTm/5cBDGkirZc/21Py0KEQKnovCnzXuDqC76e3RH7im9WC43nlEd+5NTr2gPD7QBn2aiojHei4Dt1gDPDy40l43ImEKEkEIT+kX5XRl1+Gb+ElfTe0I76QedIrDc9duT+FTn1xEU+NeAvtUloalp4UEAXZ4l5/8YTXp7AFsgvmiB9CRrjN6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar2lwiGJ8k/e4txz4I+44bjUWQ0ztjY4dCSE5R+sQZM=;
 b=UcUnLGFnc3lVRpCACk5KxouXP2Z4oYepZRrQSkrOsHGwuo67FTpwzmQiyIS5amP7llxQyJhKGjzMDNxuVx6xnRJUgK6kYpvsiTJU5zX3cwsz1YWYofj13TBCRXVd46w8t6S2MToyVE6JFkSKVTsN8b4eB0va3zaVMIoqXkY9b55/P2AquMn5Cb5QhiQlzkSWrtaPdN1g6d0ia+RW5Iu9okvEitRY58VREm9AzJZYJGRtzD5vD1A+KmlP3n9n9FPzxdB8sRzhoWzCjSLA06B7DwDHS6IkWZHYI5FYJN4k0jVzeQbszd6NWYSH8RLqQdYJMz6zmqT7xrWqmosVJKiTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by CH3PR11MB7763.namprd11.prod.outlook.com
 (2603:10b6:610:145::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:42:54 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 13:42:54 +0000
Date: Mon, 26 Oct 2026 14:42:44 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Eric Dumazet <edumazet@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
	<willemb@google.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] ixgbe: reserve TX timestamp after skb preparation
Message-ID: <at9Y1H+aZ1CI5Prp@boxer>
References: <20261026082035.335770-1-edumazet@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261026082035.335770-1-edumazet@kernel.org>
X-ClientProxiedBy: VIVP296CA0068.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35a::11) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|CH3PR11MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3fe58b-a205-4efa-9fa5-08df33670991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|261022105027099003|261009223027099003|261021121427099003|261021123027099003|261022075727099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: utkMFzKP7MkTEEqyNPnDAhuEdkfLmxUks1pUSis44RRG8bn/juyCvAdiTpQBf5kaX5nI2MUPL+A4IaBqAzwETj20QoeK4QLAMu9lDhQ5f0mTpFpXdSRZOdwavNqxNvh+xaxzovvErWGr7KVjhlhmvq6GZdGAFLJieOgFzTjEc//fYY4nmzK6U7qdpbb7f6tNjRF5QFdHdkudtzYD34uyIFLOy0qhEZ1vFHezxRAWhiz50ogynuVnPCOQ3ugNL6HAnSZFPlyMya4WyjNh/JLdXKo6ugV9Hn4whHMRFb+f8YWasuhu4+uhjhzp3nbOClzS/+f6XyqcvQ+VwKAgCgVQs8ORh42nSjFm2UaddCJ/zqteCQdCE/ahTYpUdxWtOJ9fluK2iGX/YonxkmgtJ3VeqbYXYFiTD0hAH0419qOd2xg2y+1CWaCac3yAZOxvJKb68VmdG3TbpHTknQL6BviuBIgbUryDr9JlGUSHFjGyxNUxep2FVqAhHpT9wy0xW02BKLIsbfBTuqNXLunAyIFi5REG0OyAxJI/2XzEl/uIwMkySpgHegiB/91RjI9dYYy308Y2LUVWx7zfW1go2w7XfCjgJzUTEETFocOIb7Ys6PDOarArSMV9Z8Kb0osWvFY1sb8Kyiktq1soJ/OueBVqy8w9eavkSxxNeX2toE9lvYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zzB1Y9sPiG0m/07ZHvT7+doSgoXbDRwm7ZsEtEovHnRgEZ7iwF59afEzuMT?=
 =?us-ascii?Q?hNqw8wTwjWz5OpjTv1sVqu2ZmOh1Ja4WUMgjDJ6TSNCdXfsIzC5ObMR6/v6o?=
 =?us-ascii?Q?A2WXD9JHZ0TNXDZ28C8xkb4fk8nsSScoGiin+oIQyp04xiQsYPsPDv0GLC9s?=
 =?us-ascii?Q?stRuZGD1Yu+N9OmXZWAtinYUxogdRMpcWEz+iwziQv69Hz+zO2kdkmcBxs+x?=
 =?us-ascii?Q?bF/8nS1oQWglL+URZEk9iTwVXwmtBmbSjY2Ub3dcl4U60bqpYFpyDkarVIC1?=
 =?us-ascii?Q?kItzH5bbDsd0LPUtZSkFphQcuO+RZ0eQZRtxF9G6/h+VJDwESaHu4cNGrhAX?=
 =?us-ascii?Q?SRt9TxfBVp/W4J8nABl4uQZuz3MHX/+SnNuLJdKEWfc3D0UO2cOZs/sErFtM?=
 =?us-ascii?Q?Qt7gPURVrjkFBvpKr56a6mns01ORAL93ydB3xQ3GDvvPzpGwro04rTkELIEC?=
 =?us-ascii?Q?4it84v+dSnTEdlz5R1xOqWwaFBopEby6a83FlnKDrW80nY0ft68G4OfSFRmE?=
 =?us-ascii?Q?FSDy2B7Nh67bOSzfIds4Eyhz2N/NZxtNmq4Mh/1qzF+zAChzhvjeXAf+oL98?=
 =?us-ascii?Q?aI/ZPauf+/65umWz0kJ+vWZcoh8UxEZB9TkH5mUsTaZRRRBdubLoLLAgJD0h?=
 =?us-ascii?Q?GJ24XrAtNDyDwSEE6TmwXb++ZmppHKnnPbToyEjwvDH3Q6q3/cg1ybfsR5al?=
 =?us-ascii?Q?372MmoP04gww0LQCPG6NC4q24eNwh3O//ssywBlByeYw/5LFnzNM3CSxD3p8?=
 =?us-ascii?Q?U0XPnanF/g0qloB2cL2QPFCFOZvzLV4N+7PEHJFTJjmpPIMCyjqKtij3GO1H?=
 =?us-ascii?Q?7OJYKSS4LwWxkhY8MDz1d2eWQW5na3AjOkleLCJJvR7ftY+7OhEzwSO4ODz+?=
 =?us-ascii?Q?iwwBy33BopPhAwMM54gJ2+S2vy/kkzB81q+x3iCs/3tOlK4mtFZTZNWAmsR5?=
 =?us-ascii?Q?mDlmb5EdeQ/u4YU75iG8y96nnAka6QKV0OrgcxI/uijsh55/qhT2UX7smAqu?=
 =?us-ascii?Q?8Wy1/SB/qH3NI6pVSn2T2VQZPnwkO9CqbVwhLsQXICKq4DTyY45B9a7E7Yit?=
 =?us-ascii?Q?WFM0ygCUzysbzjEHf9Rpt66PXD8s32DBwAJLhJq6aUoqTpZjcnI0BRBFYZI9?=
 =?us-ascii?Q?2cA23GaKAM3mxZi4LrBAaAARcABmp3BnOg/oQxEWGb+tsxin9LzLeHAn+/q1?=
 =?us-ascii?Q?D1BW01QFY3wdo4p5Ty/qQNR9Cs9jcnlexaNUm3cSSzI47GzDp2J/fPtdIDz3?=
 =?us-ascii?Q?Fg21Ri36FsPlp3BVboq1I4fruGBfLNV3n6r5tWWZWdIu64Rz6yzW20te3BqH?=
 =?us-ascii?Q?AyE64e0ABDTwfHUEUvsdH3EbuEMkDI2WZoyyD6NOfHjRc9TnG3/dQjl92W2v?=
 =?us-ascii?Q?UuXO3PZOxlYmL7ONDWzAgwfMPYgWBe/CykqQ4EZPdLRgLxnXeDBG4FIYtiVm?=
 =?us-ascii?Q?8KmFFeN5BWPrmGX/XYmWBSJ5eLY42nlSCWuqnx2e5VFYAbBnMS0ARqBEYRtJ?=
 =?us-ascii?Q?FBuJo6KBszGI0ytRgq8wC2UcjhDXoKRypxyuk7AOA4PRsfxsC0CeT0lg724a?=
 =?us-ascii?Q?tanGU/NqRTrRjZuHydlEHgsfah4e7y1gBlqKdxL8E2AYIEScb3AdyI/+8PXi?=
 =?us-ascii?Q?rd4LbQYrRoE0jeGniqHBKaNA6bLYki+Rjt2rY5/7g7aZ9p1qPJ2kRA8Fo73J?=
 =?us-ascii?Q?2qqN4N0ntfgXinkk1qras9T7z5R2pZDBIz8kXxQtDynnsyJak7NfBFL8ONuW?=
 =?us-ascii?Q?W7edsR4S0o0QPD65LD7Y5FgQksFt3Eo=3D?=
X-Exchange-RoutingPolicyChecked: WfxlcO+O4hw9V7PWyN70ujq/B/tQdRVm8WXr9Qbll2uO22T9R94Hb11Fl7eTKZMZMGbGe73YftVzpkUiNE01UsAInWZEa3rRrbahSnFAV9DVQU+LsvcIiKNV0lWcO90xveZpSMn/Gu6lTQXtp6hlhZj7cUpJpLVzPbltcz4lScMXr9iv4UQoT+o6WlUvHL+TvSD8HHp9NQNLPh4EEiiL2YMsCjt5J8MATujGfCayBi71Pii0pmAQxs1iBhQawMNcpqxx91viXwGI+vajC9hrsvpT0eoCJAv73laZvdVTIdN52shDFEFaBQ7Ei3WHQhtHRqWDfboVxruXXX4yqqTZBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3fe58b-a205-4efa-9fa5-08df33670991
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:42:54.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7w+dZcHXfFz9nctXAsEZZgOF+ejtgbspVwSrb71ScGRMd3TRTfaynaiJndf+7uiJVVnqQkLfVzRHhH9y/BcYmSP4gguzWwblKSlI44i/f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7763
X-OriginatorOrg: intel.com

On Mon, Oct 26, 2026 at 09:20:35AM +0100, Eric Dumazet wrote:
> ixgbe_xmit_frame_ring() takes an extra skb reference with skb_get()
> for the pending TX timestamp before preparing the skb for transmit.
> Several of the following steps may need to reallocate the skb head:
> 
> - ixgbe_tso() calls skb_cow_head(), which reaches pskb_expand_head()
>   when the header is cloned (e.g. a packet tap holds a clone).
> - ixgbe_tx_csum() falls back to skb_checksum_help() for unsupported
>   checksum offsets, which can call pskb_expand_head() through
>   skb_ensure_writable().
> - With DCB and a software VLAN tag, skb_cow_head() is called to
>   rewrite the VLAN priority.
> 
> pskb_expand_head() used to BUG() on shared skbs. Since commit
> c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
> pskb_expand_head()") it returns -EINVAL instead, so these packets
> are dropped (TSO, DCB) or sent with an unfinished checksum
> (skb_checksum_help() errors are ignored by ixgbe_tx_csum()).
> 
> Reserve the TX timestamp right before ixgbe_tx_map(), after all skb
> preparation, as i40e and ice already do. The timestamp request
> remains covered on the FCoE path, and the cleanup on ixgbe_tx_map()
> failure is unchanged.
> 
> Fixes: 891dc0821d20 ("ixgbe: Add ptp work item to poll for the Tx timestamp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 40 +++++++++++--------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index f91856498eb2d9e0e4173153c8c00bc2248bb708..b9496f0bee1312499f28c2f3c24fcff9a1e66e0d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9444,23 +9444,6 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>  	}
>  	protocol = vlan_get_protocol(skb);
>  
> -	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
> -	    adapter->ptp_clock) {
> -		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
> -		    !test_and_set_bit_lock(__IXGBE_PTP_TX_IN_PROGRESS,
> -					   &adapter->state)) {
> -			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> -			tx_flags |= IXGBE_TX_FLAGS_TSTAMP;
> -
> -			/* schedule check for Tx timestamp */
> -			adapter->ptp_tx_skb = skb_get(skb);
> -			adapter->ptp_tx_start = jiffies;
> -			schedule_work(&adapter->ptp_tx_work);
> -		} else {
> -			adapter->tx_hwtstamp_skipped++;
> -		}
> -	}
> -
>  #ifdef CONFIG_PCI_IOV
>  	/*
>  	 * Use the l2switch_enable flag - would be false if the DMA
> @@ -9525,6 +9508,29 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>  #ifdef IXGBE_FCOE
>  xmit_fcoe:
>  #endif /* IXGBE_FCOE */
> +	/* Reserve the Tx timestamp only after all skb preparation:
> +	 * skb_get() makes the skb shared, and pskb_expand_head()
> +	 * (reached from skb_cow_head() or skb_checksum_help())
> +	 * refuses shared skbs.
> +	 */
> +	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
> +	    adapter->ptp_clock) {
> +		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
> +		    !test_and_set_bit_lock(__IXGBE_PTP_TX_IN_PROGRESS,
> +					   &adapter->state)) {
> +			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +			tx_flags |= IXGBE_TX_FLAGS_TSTAMP;
> +			first->tx_flags |= IXGBE_TX_FLAGS_TSTAMP;
> +
> +			/* schedule check for Tx timestamp */
> +			adapter->ptp_tx_skb = skb_get(skb);
> +			adapter->ptp_tx_start = jiffies;
> +			schedule_work(&adapter->ptp_tx_work);
> +		} else {
> +			adapter->tx_hwtstamp_skipped++;
> +		}
> +	}
> +
>  	if (ixgbe_tx_map(tx_ring, first, hdr_len))
>  		goto cleanup_tx_timestamp;
>  
> -- 
> 2.53.0
> 
> 
