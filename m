Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792609076;
	b=BrwL3PJ3zk8Wc6135ykf+lNqkhlMAIcvbC4H7BilGHruHYWcnNyw+1lQ7LQAuuViY2ex
	 Irqwp/DZzGZOfZeyxcimsHQnEyctG/w1WcKuZMHEq4tOYYVaDFx8JiP5c5QWqJYbfj4e2
	 6vEuOWQQ6wE2rxNmfNHbfElGH+i2X9kovM6RLZuhai4st/YW5ETLlik+v1gz5vSIcnE/p
	 AXjK/lA+xig73CtCBB7B4TssSu+gfxWRwA8KtrkCIQ1Whl+mZRsvngd8zwLyPEsl1ghcV
	 OZaYLwaF9i96edszyhd8gmJ+ZM/NMrhI4Gb5pVb/T4TfFem+C4u1vU6RO7l1SaDLoAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609076;
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
	bh=t4Bx2Gf8ABTE7uIW4DpoKW3pt1AqsoA1UGHODkRyES0=;
	b=XhaKxEZdaX/C7mMyUuu4ei8kRFw49H+4RVHxwWcWP3noVtMP/HfUMybgwEbwdzsgz+EN
	 /SeW2wR+3w5q8In5wTMcyyaGvNh2DUFHGlvrfN3yhYBjN7GGtInlY8AB6eAibGXvELO3L
	 pAPBkCCs+RGxgLmWK9LMbgpsN1cwKISaAgn8LtOnWHh4S8gkbp6NAZcepGgLFYPTm8wBt
	 0Ks0aR68KWC+cIFoH9DiT6u57/DcGVJ6H46Zajrk390XZyVysXptAQXpXj54z+Sy8C1SV
	 iojuINOpc086jTHjHXMohGUIcOPs89SxVUb11sraVDyVz+tJ5DiaUu3uL+JE/RsqJdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fafxOR5p;
	arc=fail smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731ED606A325;
	Wed, 21 Oct 2026 18:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 731ED606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fafxOR5p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792609074; x=1824145074;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UrgewqVMrgxf3uRDYrR8jqwmWSq5Z2NVijNy6HT5pu4=;
  b=fafxOR5pe81Ho2G3utJ14t+sGIRWnp6eUb0K770eMWLevNo1s5+NO43K
   flHWwej85Hwojg2qGagSLCEpAlesQqBk/52WoqLN7N3cVwiAbI3js6fZr
   klbwsFrkpSq3zDBtZ6R68sf3NNfHlLYm1MzNP5dXYRcOZGxsmpE2K0AXx
   yU7QUhzH5yrMDeHPtoupxKnob64Wk1/Or2gLN2/74suRPx4Lw3RdX7WZe
   tK1tkn611xB1Ai+ypo5DckCycerhqfzSCSbpC2OSD1FXVsCcnDX2sJZuC
   4/dRn3OA//qGIYjSpXXNH1qOrDOHK1GmVVYqdpUzJM3uMnoIUMO6Zb3N7
   w==;
X-CSE-ConnectionGUID: zeZ3JZImR16mgOMd683zCw==
X-CSE-MsgGUID: KGpbWTRcQpmMu7SrFlWnNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1336807"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1336807"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 11:57:54 -0700
X-CSE-ConnectionGUID: VLBhgZaeRm2z0eT/eDkbcw==
X-CSE-MsgGUID: oKBLeGFrSQmmqc4DYxGCHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3562823"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 11:57:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 11:57:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 11:57:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 11:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUn+ejKyQac6XypVkbe2Ww90lFMSVf+9LEsHAjhv+sh5bAMj7H6uWH1IimRvyferTAUAhOmVi+WIV140S2uWhQO4EWh/xr1Hy3oae8V1gRSmOgigLXi4ubloQPNWWqp2Icu4VUYB/GXqy+4MCH+Vwe5v1rvb9gz1OxvN5qsrcNR0bbSBFp3SrqBf9ygKmnJUT/qJOJSqOUWqc0F6o4eybveaE06BZhBUdPNap3my1ccef+yBHKnIA2swpfCADOM8AnTe0XqceR+Vhy2NJfn9tnOJ8s5P4Xd7cQxkVHoFfrEQGQYL4UcAXjbIpMO13rbbOZl0gEv6AUZy54J6RpRf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4Bx2Gf8ABTE7uIW4DpoKW3pt1AqsoA1UGHODkRyES0=;
 b=DEj1ic4CZy9qfgiR5OlFj8eS7Y6VEZGJYn2/uajTeyLtzeSKk6CYtYnpKoF/G5vzeAI92Tiejx6ChiS+8B8yW4MpWzZzaH/WFQeiLzrpj/KC0N6VACREvlk6J+7H7y08dHH+wgORXqCct4D5pqP4ipnETpYRRNY2/H0SB8bYy0jWZ/Y4mUKjk2h+3NxcqmF25tgQktBz21D/PLUgWg3iDVbXICpnwAJohJWXy6rg90RuS+4HVqltr8woiNKaEfTth+B5sj9uo5UYLnPPKf9/EYiwmep5JMKRmhQgqDqQ+1DOvF93QP6vK+h8FwsA67IZk7PynUE7K7NfCEdQkCLxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SN7PR11MB7438.namprd11.prod.outlook.com (2603:10b6:806:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 18:57:51 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 18:57:50 +0000
Date: Wed, 21 Oct 2026 11:57:48 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <karim.sabar@utexas.edu>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Use kvmalloc for the VMA ops page-table update
 array
Message-ID: <atkLLH47Zd6vMX3B@gsse-cloud1.jf.intel.com>
References: <6ad8027c.7f7fe2b9.10c6e4.4073@mx.google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ad8027c.7f7fe2b9.10c6e4.4073@mx.google.com>
X-ClientProxiedBy: MW4PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:303:6a::23) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
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
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SN7PR11MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: bf65563f-79cc-4516-dfb4-08df2fa53420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|261021121427099003|261021123027099003|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 4PGsZaDUFE3+hdYwj+N0tf+tSgf/qQeQhil3tjq+dStqVZydmxrgMt4TOQtNmzK/EnAAbFIfpo8iT1c1S+MevVipI4HlUdTOgV0WfRZNdq5a10J4STLmWPQWShkGSvZkclbJKmXEagWsZc5chhcIcAbOzhWBgu4j8hZqD64xhT50B+wb+gKbSbrR+aEipR6HCi/e3UomkwnYfIKD2VNEXZfKDAmk9djejMJvzAuYh6mkdKqFWw84xJt3r83GOGYGZbhzz2JzsUEbgLAfmbHeuId0NctFsQW+E5srQLv0asD/j4h5AbOsbAnGTSkrxkiide5OcM5Fw9WM35nTysMmR8lNwVZH8sgKlftwu7DyoUhYYC3eNulPM4w2WrMlBx5e1ZHYkDgQ3A2r0VjSj5JeUoCm8O+TitnbNNz3jMiNnL7KCgEOBKewyESMm/sfgnNYyZauYNVrH/kZCTpDEvzYxvlXrRtNRUeIF4/7PC2YCyGWyg0agW418n4lWFOsd7ABRd5VgZB/4tEChE/qVOIXZ+0TTeMKxhqUfOhf2AaPuctpT+M9cYGDIFyyVV5RxEQPf4Xc+Wai3lKlWu7bxDE+GxDzprIrqGTdNA5/Qk8aEvuyZ9hfPzvQbarlgW/UFcnAw2EXtsXG61Vv7dU/tmXE5P4LUwTk/RIVy9PBbHQgJHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(261021121427099003)(261021123027099003)(261009223027099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aNzILbEODSBzDYtnYpKLbEaGZDw3JqOFs/pUSbh/nuMH1AMFH6ZmuoTcrzr2?=
 =?us-ascii?Q?qh9SqgeU8bKesHaBZ3ZOJlLXJ31CHqXRxzbQONmaBUOx2gcTWXivyK7q+fpa?=
 =?us-ascii?Q?LRBobxsx6EiJLfmMfsr21Ld+jrSvZ6WNz6Ep52jDumbaP+9clBwxAUeLCYl9?=
 =?us-ascii?Q?JYCsP6/6UypGkJpliwa1+h7WVnlmkm0yrkgVm/qdaySiRCv+IIivT3R4yjv4?=
 =?us-ascii?Q?dBf7wbPQv5rgdDoleNJAmxpkpw4hUUkRlQqIgEjXwaLb39UeuBmyhzRcIuQH?=
 =?us-ascii?Q?bBP5/L4DieGisXlXh+8btQ02w949roTM4tDvxT66f13fG3yFhLkoebrJFUFU?=
 =?us-ascii?Q?511NC96D68tXMYs3lJnMvbWx1CHkN9Eq7EywuyEfDCWgBW899C2Im18V69mc?=
 =?us-ascii?Q?wDP0jVWiFMT3q63m2LXGvvhEV5ygQrMnZlh1Tejy8HWxIqn6Q6JMwzeah6cC?=
 =?us-ascii?Q?ZZPngFruYB2gQljSayKfPdHijVHQowMjOZ+PB7huYsJN+Wk1849+MDfAFmxy?=
 =?us-ascii?Q?G59vHgiCCLmX53TIkap7aswouEQKdxvxmn0nQiGBLZStXMU2+fNwMII39/Rj?=
 =?us-ascii?Q?/KkMCW8I/VgBAmAG1W5X33qUkT6k5qdA3XI7ZGabPMpkaOhmFpxwNCWK53pd?=
 =?us-ascii?Q?v0YCl1pDcVFkZWxUTvlsTqcMDbK/xFUah807KOhY8LKj+ECbBLYqaymqcM89?=
 =?us-ascii?Q?Uv6bd7LX20n98bT8vpplBmtX8LvG6VfF1aRuQlYFfRNyD9GiTUiCGZ7MiS2L?=
 =?us-ascii?Q?Gmh858ao9UBpuVQ1+BvX9RZUJ2W4kCj1j3ydOcKWi0DBiHcHnV/TLT/HeNAW?=
 =?us-ascii?Q?ZT/tAJIYBp71fwjNEDQp754p0qaHLJDVzrpk7bw1QMapmM+imKW5cv0ozEHF?=
 =?us-ascii?Q?DaKJjiWdaIFnL4aMSOJ2TgrYn9kwAc3NH9qPmUXWlF0LmtLNGV21z4nFldC1?=
 =?us-ascii?Q?LcwdZaoKW3gVpD/Z0/kzDvO+9qndpQutMswUN1SoAawnhcNmJMKt4NJodnyo?=
 =?us-ascii?Q?/U4GXqMoikY41m43uXXC7w4hg2FCjQ1jD9WLn3X6zfCEf7IFiR0Ur2BwHmeN?=
 =?us-ascii?Q?I54t5Sc/fHqKGnPDS3WzISLwAd1wrSYS3G6HJV+cRv1sTs4oWmu7llg1VSkP?=
 =?us-ascii?Q?SWvYz2u3E+DRcE4Wnpn6ToBg8TiOMHRDAyyjx3Ixhkktf0cPm90yiN/EB3RS?=
 =?us-ascii?Q?s00p9dfxBc5xDtCUX/03+7hgnauIDjRFyVjYwNAWNTdNlKU7qjPnxqBLiCe0?=
 =?us-ascii?Q?wewRnas+ZtTxuAU5ric+yGiUCHXCA27alQAKbmSFVLJcd4om205AwPX23Ykz?=
 =?us-ascii?Q?gyRFjsxZVn1quFhNtTFI+Vg7KSM3OHBpjP1O9V7LCXELB6KrwmOiw64HPGon?=
 =?us-ascii?Q?kdMC1P4G5lfcck+MTXOpUi3y0NAQnoqh8nD07Rb6Fu0GBOezB2UHwc1VLKpy?=
 =?us-ascii?Q?k+seR1uxForyYqnFDNZZUYnGekVXLR5wGZhWd1ruWs0+/ckhlfW657FJOUa7?=
 =?us-ascii?Q?6Ogvk9lhtbXkyldTsLRo6hEO+1V5+68p+geue9GjBl4U+/ImTvsV7gZirf0p?=
 =?us-ascii?Q?FT0p5tanuLNUgzjPPSMGcYFjdbt5z9flLBS+He83hrcaOujMNTztYqFJnM0W?=
 =?us-ascii?Q?SkragDS4O15O1o8OECSbRJHwEyBscpq1wle14NWBA+9NpN4O6ujL68Q1vSpQ?=
 =?us-ascii?Q?wofqEEpWMrXkw1h43JJyuAnLO9RVHGOLYSSQXXJJj0CLIkIr1ZPM6Y68OsSU?=
 =?us-ascii?Q?tPxYIhHvkQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: D0iAQmSiOFGliL8F4KX9QL131ug4hG4TiNgimaf/sQtNZ248g/kdv4rQqFp5/HyFwG5706T1bIXblYFlUNANyjccWt0wTTi4FLESFEc2JmxYmyfbwXJtpirXQGzyu0WZo5QCnH9vbTlRtstlYtUnlV4AwssEBAJbZdn7g5c8h3s7uTKUEg6AdAOnLfwNhHOMS60U9hc9lvAKWTHAtqYakk67dDgkm/rHQy/X4WaKOAp/xPUpbaZ2EKlXeMaEMvl7i4R5Uv96VdB8d4eSGapyz6D5hpOF+kZ9zEjzenUl2S8AICAJliO4JOKCcVxGh0ojPtAtsshref3M4TlGZMQFpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf65563f-79cc-4516-dfb4-08df2fa53420
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 18:57:50.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6OJS7esCYJ3LdnJqr5fDIWiSoZAtAa8nxbzJC2KW3BKxLUCWVQtMlzlPA8MTCcZlN0xL7Od8I0IoaqDHCzFug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7438
X-OriginatorOrg: intel.com

On Tue, Oct 20, 2026 at 07:08:27PM -0500, karim.sabar@utexas.edu wrote:
> From: Karim Sabar <karim.sabar@utexas.edu>
> 

Thanks for the patch. I do see the problem in the old code.
Unfortunately, we will not be able to pull this into drm-xe-next or
drm-xe-fixes, as 7.3 is already out and 0e33330f1238 is included in our
7.4 PR. As a result, this would need to go directly to stable.

There is also a risk that predates the series containing 0e33330f1238.
If the bind has to run on the GPU, you can still get -ENOBUFS later in
the bind pipeline if the bind is too large to fit into the
migration-layer BB. If that occurs, the proper fix may actually be in
xe_vm_validate_rebind(). If xe_vm_rebind() fails with -ENOBUFS or
-ENOMEM, we could call a new function, such as xe_vm_rebind_iterative(),
which would run each VMA requiring a rebind in its own job. This is
effectively what Mesa does in userspace when a bind operation returns
-ENOBUFS.

We could probably still pull that approach into drm-xe-fixes + have
naturally backport to stable, and it may ultimately be the better
solution.

Let me know what you think. I can give this an RB, but I'd like to hold
off until we've settled on the solution we want to pursue here.

Matt

> Big games die after every s2idle resume on flat-CCS iGPUs. The exec
> ioctl keeps returning -ENOMEM even with 11-16 GB of RAM free.
> 
> On suspend xe_bo_evict_all_user() evicts every user BO in XE_PL_TT on
> these parts. On resume the first exec rebinds every VMA in one go and
> xe_vma_ops_alloc() kmallocs one 384-byte op per VMA as a single array.
> Final Fantasy VII Rebirth has about 33,500 VMAs which means a 12.9 MB
> array. It's over the 4 MB KMALLOC_MAX_SIZE and can never succeed.
> __GFP_NOWARN keeps it out of dmesg.
> 
> Data from a Panther Lake handheld (SteamOS kernel 7.2.7), kretprobes
> after resume:
>   xe_vma_ops_alloc  -ENOMEM on 63 of 63 attempts
>   xe_vm_rebind      -ENOMEM on 63 of 63 attempts
>   BO validate, TTM populate, PT prepare  never failed
> 
> The array is only used by the CPU and doesn't need to be contiguous.
> This switches it to kvmalloc and kvfree.
> 
> With the same change applied as a module on that kernel, the game
> survives every sleep I tried with zero ENOMEM. The biggest array was
> 30,753 ops (11.8 MB).
> 
> drm-xe-next already does this through commit 0e33330f1238 ("drm/xe: Add
> struct xe_pt_job_ops"), but that's part of a big series that won't go
> to stable.
> 
> I tracked this down and tested it on my own device. I used an AI
> assistant to help with the debugging, i.e the kprobe tracing and
> reading through the xe code. I ran every test, picked the fix and
> reviewed the change myself.
> 
> What I couldn't do: this is build-tested on drm-xe-fixes but only
> run-tested on the SteamOS 7.2.7 kernel through an equivalent module,
> not on a mainline kernel.
> 
> Fixes: 2e524668c440 ("drm/xe: Add xe_vm_pgtable_update_op to xe_vma_ops")
> Cc: stable@vger.kernel.org # v6.11+
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Karim Sabar <karim.sabar@utexas.edu>
> ---
> Downstream SteamOS report with the same data: https://github.com/ValveSoftware/SteamOS/issues/2962
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 99e42bd29..5caef443b 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -703,9 +703,9 @@ static int xe_vma_ops_alloc(struct xe_vma_ops *vops, bool array_of_binds)
>  			continue;
>  
>  		vops->pt_update_ops[i].ops =
> -			kmalloc_objs(*vops->pt_update_ops[i].ops,
> -				     vops->pt_update_ops[i].num_ops,
> -				     GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> +			kvmalloc_objs(*vops->pt_update_ops[i].ops,
> +				      vops->pt_update_ops[i].num_ops,
> +				      GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>  		if (!vops->pt_update_ops[i].ops)
>  			return array_of_binds ? -ENOBUFS : -ENOMEM;
>  	}
> @@ -742,7 +742,7 @@ static void xe_vma_ops_fini(struct xe_vma_ops *vops)
>  	xe_vma_svm_prefetch_ops_fini(vops);
>  
>  	for (i = 0; i < XE_MAX_TILES_PER_DEVICE; ++i)
> -		kfree(vops->pt_update_ops[i].ops);
> +		kvfree(vops->pt_update_ops[i].ops);
>  }
>  
>  static void xe_vma_ops_incr_pt_update_ops(struct xe_vma_ops *vops, u8 tile_mask, int inc_val)
> 
> ---
> base-commit: d2ce8fcd778ee6d92748c92d23a56d4416c29d86
> change-id: 20261020-xe-kvmalloc-vma-ops-2637ebf81cfd
> 
> Best regards,
> --  
> Karim Sabar <karim.sabar@utexas.edu>
> 
