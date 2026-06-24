Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E914188596;
	Wed, 24 Jun 2026 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271997; cv=fail; b=tHQ/DlhFWEazMEpMwPjnUm7NvYZjpePLIbzbo/0xARqpwo69u0cIyUN1cBNwEs5L9siUZ/KXM4XMb7CmvpXfkV28yI3t+jzXkl20jWfXOuRqFQm2o3XVVXGPfaDLpBNxw0D3Y50hCAO3hm0Q5tOMSaFYAWmHUfiJS2AL4n+kX88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271997; c=relaxed/simple;
	bh=ZwkwvK402sI86TqaK24ZP3DxDhDZlqcO6TANZiqej+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WSTi7DGLrPsbEIWx3rhQvVkR8eLokEYuKts1WZ44Os/4KrSiJmq4mdO7rOxNJ4R83FjymDq7JLP+YVWQUaB/L7LDIB/C1QR1difnDa7QNTFMEG7ax9RCO9o4rSYPa8sP2GuGajJardGDaSHkmXcW2fkNSxjqa35oEP7UQgE71UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Db03q150; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Db03q150"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782271995; x=1813807995;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZwkwvK402sI86TqaK24ZP3DxDhDZlqcO6TANZiqej+w=;
  b=Db03q150BIfbkrKYklv6z2TvpfE7mHLr6/Aj9G0cyCz7U3c1ni8t0EVa
   Dmk9JuFEaWwVPrH4ACWsckhlEW/WzhWcBciKCrXvwEMmxM0lwCvVYQCFI
   1DTqgDAEQ0InYcgg88gVBsLO9Rr9fer219CN+d6INEvGfCWg5BWRhCrvh
   bn2FHWd2Tv0EtEpv61ZT7i8WbuZimSpdxib1rhu3fU3ZgvhffhWgw9C6Z
   YXDlarJvG0KweVE2qztKudbR3H7l2E3sdnT8OqNGTFlny4kklhA8xoxU/
   mxdX1hfIXaaXdWKuorhWPUunREP0GdPSvlEdXNpKLTg6OqKpKV+ylD2OY
   A==;
X-CSE-ConnectionGUID: 3PRC4tlfQAWBfNX7/yhBfQ==
X-CSE-MsgGUID: a6dashzqR3CeBu8MiEENdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="86859721"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="86859721"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 20:33:14 -0700
X-CSE-ConnectionGUID: d8FevGsDR2uDx4HG6PBr7g==
X-CSE-MsgGUID: hMljJy3DTzm/oEV6dc1b4g==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 20:33:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 20:33:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 20:33:13 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 20:33:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWkxksdw+X6rMymwVrFIVkuI50pI0dKDESQmhPRpQK9meNBdY/5a6NWBITT5p0wCbIvO0+MuLkYz69Sg5hVMMC2uR/TwffQHvjV5QkTe4c/ybskbP7b1tuYGHHktBmMPbtSH24u1ik3Xg5urstUdyEnGX2fGOq3KxywzPqJKWd8DPD0cStz/AbyTbTKyRjKY1XGYJnLrigtn7mgLPZ1kysH3bD52BG6gUn2rc+QrYCKKfkG/i3tizu3yBKSczmlZRFu0votcXreSQc8ValqtrGrfmrFzz/aXrx/khPRgZuw3CdcAiJFiw25vffo8zAdAfdgj93FXXRBXir7PmoUirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqXn2XP8W0CyD1mitGjDeOOTKSY1C+q1f9RA8FJzQsw=;
 b=sY/ZTClcwYu7OyBEogi6u+P3Ysx20eK7tJCLkrWXz7FIchpzLPwBxYrBgcLHGSE4kqfpcg6SiUlr8GgIYb5LNoPildahf2t5zHVTlFgFQWkq1rVsTPtNZ53lqUA1Ntj9uzop+e0CFrlmTcYSVuIMbvvMgkcM54FoqcK9V8oLaXlZimPbvY8ufW2v6EuKXMy9OK4nYzcPqzUlLzqCX0qQi5HMX69e7T1XeIsQFRdQPSuGGq9r1nK1do1V8uBSj89/Kep02wGDQAemUSukqG/b+mWUX8hhHsJKV+lFPLTbwX3jz7L/9lE5x737DZxxouYb4dmFDJ0GwfAd1csij0unfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 03:33:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0139.009; Wed, 24 Jun 2026
 03:33:03 +0000
Date: Tue, 23 Jun 2026 20:32:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <vishal.l.verma@intel.com>, <flavien@nus.edu.sg>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mce: Make the MCE notifier per-region
Message-ID: <ajtP6wcs1OXaRhwY@aschofie-mobl2.lan>
References: <20260616224912.2567474-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260616224912.2567474-1-dave.jiang@intel.com>
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a89914-2dea-4298-616b-08ded1a14bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: VmtR1skNxCYhsUrjvLdKwXE987dAoIVIw/E9iwMC+oXlOkiDdIGartBtql71jP0jnW0kKZ+KjePSlu/QBrVxHeAXW7NNWf/024jxSzxADwtS+CoJ7s1ZDr+8nYjB+G9m1a9dVR3zwuM2CIYGb0xYcvv8EO5MqwYxm62Nz9H0NMqvGBd/P11J1XMtXrkOAwyGvraP2dvMBSGbAXccVXA5+y1coQ9c60TlvYGFKsm0mIXiGVpaIvAqDEb2iX0/zz0DcQ7yyWUuOgpG2yJUuZmqFEbOA7xBQaybMgRsno45yskBfgQqfgYexn6KupdEs74CMtDRgSbI09EU7zZVdKvD+1N/lInxunTue9kZ7VSkERI9Yg84w3G37VOrEOT7dw1I9dZfGBzYOM/ijGEK+ilkZQ7Z/J0ZrWTTCBMNBXqKf1ycOaUDTs/H4riawMfkszVOo3wf/rn2Bba3KQH1oa0UOv5tTCwfvdYgI0pfwvlg7QmqX771IiWI5ggbsqDaNhB+pO/iuQoZEJwYN2HRB/0AVZMTQDTAE0klVYPd26UdJjn0BDVCEnNUA2sovpcM/w/zKmNsFBy1i3a4qeCD8PhJc2OrfHBCYh4I6WVZWvOKzMB/SowyvMbWfkhgYZNtCZMEp2yZIR5+cDqQwIJefNOO4OQnSYZATsATA0IwHn5YpVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amt8tnd7rAKTYdeBVi4SrqJ/m11P11i9Tq1VbPP3yw4HbjjQ/QkAdI+fPPEe?=
 =?us-ascii?Q?pjy3ge0ySBIWzLz0YDINuJasnr3zGn7dT+okdIc41uylhurrXOuzCIemIPVr?=
 =?us-ascii?Q?YnvJh/L2BWReFS45wOr1sPvGjDw9NfgaJAgdN4m6QUxn/P+6XmEWJLBopQ4n?=
 =?us-ascii?Q?lTngxOjGD69GMboZc1rP39WPCZSf7tOlp4G9Ls72739JgJW9mURmO0FKxiCc?=
 =?us-ascii?Q?s+QD4PIQWpgirFn4ygehRKX75GqkESQw9Hie8daqXn/1hTeH4QFxX3HB8/t3?=
 =?us-ascii?Q?y/i34oumQGd1EgEocV5m4g+wtX8qbSW38CzkbHLrlfEA2WdzK7AfzTz21UMw?=
 =?us-ascii?Q?9ylGQPBuBrQAfNpecevWqVRjEeIXrf8/bTYPCV828Pm3Se/x0SIqhJ1oHOsb?=
 =?us-ascii?Q?3V1julh5FvJ5ONKs9AwU+WgRQ9UDSHjVkz9OJoQcSqphCymuwlnUxz0eAFTO?=
 =?us-ascii?Q?KQvTWcvugFTlGCL+k4osZdg4X8DFTcdG87La1CUp+8B4lLZgw0sSG74oWkmo?=
 =?us-ascii?Q?EX1Ec1G8x+MKGStH9tDfwpRX7VYAXLp44xcYrtXt6yIsTStwK2JkULSZmRXf?=
 =?us-ascii?Q?bt8tM8PcIhLU342iDBY4JNpVDTId7SdOcA/anN2TCXhomNBpbUt7LFKmyyiy?=
 =?us-ascii?Q?3OrioaRHSYTax0HSRuB47VUTaP7zdOzXuPc5ARz3tGpJ4f26Xf+/kBXpj8Fu?=
 =?us-ascii?Q?CW1ngdl4mQDi8k0F2sX7RY6/kQ93NRRSNHiEmv4l4whogD9URSD+450AtGIj?=
 =?us-ascii?Q?TPnFo+GCP51ePJ4vfW+8Pvc0q9O3+/SH7DodwV8m9N2syfz1mpwgrjBq5TMD?=
 =?us-ascii?Q?yoPBVw83L3gIxrNZWMJ0vPGyGhz9ddEl+dEokVy55mmTt2BgrNWZT+Q16L5Z?=
 =?us-ascii?Q?kscFNyUsElj14i+wzjSGZADkJSktVR+RDTb4UhN1TDAA/ueCNoVY+Bp3QoqX?=
 =?us-ascii?Q?DliiTEmaasqTRnEO12xTGXuawMis0qIsbYr2PRwXh5RW1Pmt6CbuZSAtIUbe?=
 =?us-ascii?Q?7Z3GG9HDKRP2VKn7m/kEbsFaHGgLa4b11IEZ5Wb7KdD1SiYJnCY0v44pGwmy?=
 =?us-ascii?Q?v/O+kMXoXSyrJNWH8wc37XLrupSwd/yxEpeNsbLhelhD957sab8z4920LW92?=
 =?us-ascii?Q?XGTmNubn0y+MEKcdSucrPKe2uD0clkjn/itk7HuIdNu3+UnWJTYZPLWaUA07?=
 =?us-ascii?Q?H4mQ0b80j2Yx+dcCd4cTTc5pmOEiAJZKWbQyl4XUL7rVDJrfzBsZtD1li+eK?=
 =?us-ascii?Q?m4wnvVHs4J3YdgYjJcl3U4XrUun8zRizU7eqsMA0Vg4TBfkw7doQCpWthw5+?=
 =?us-ascii?Q?rOSxtR7F7rkHyT0xMEutPgjV8D2CP6xBiMvOEPHpkBNIWiVoIZ58EiHxWN9r?=
 =?us-ascii?Q?J1JZ22bhSqsOQmFFbSLVxDjASBKxhaadyFl/QnFD+Zfg/21bo629Wr3vfQsX?=
 =?us-ascii?Q?9P02u5p/1pAnQAO4JDAAwTVeMsKcbtkMXlNsvsJFLPC3Cre+KZIkGn/OwUbC?=
 =?us-ascii?Q?XO+q+KNCY94+Era6au//R4tmJYz7Tg5/R6bNSeJqJV4X4if5ePnJIH0Yod9O?=
 =?us-ascii?Q?djgGxd+O4IhbXQ7AgAtKsQtZItc8JTvIbr51Yxx3zW/Yxhv0UpTbCNtddChg?=
 =?us-ascii?Q?VgW10O/CJSyjAElGD3pwNAHdcReVJt9fAJOxjBBpYZf0LaLNa10CnSxgKy49?=
 =?us-ascii?Q?RjCNUum9LOq5nCSyd+71NZzHOwhMVyP/D40zSwotkiJVVmnYtTYThAF4V+J6?=
 =?us-ascii?Q?HLntXXP1oAD9I3mbM4wlvaIuSdcaAdE=3D?=
X-Exchange-RoutingPolicyChecked: K+YY9YBiLvxl69/Ow4O7WPMeTMbKTmOtt3vq+r8IHXfvExHPKfzEsSpgf3FYDUBqJZ6PFFWQxakmq9Ow9kRqWeOIe/LP3ZDR9R4JdTI0r+16lFfN9+YI7J99XjFufkG17wsrIDqRAOrC8QrLrRjJCQLhrlcQ/6itRlKbSdOX9E7Gt3uWcki55s53p3zRqJqXfZWgTDnbrt6NFmSRKrgyoT/pr0QgWpLxDwJpGs3fU/qdJj+iWv2igmflgGhQJisZAYCwkDl/UfNJktP1mpM06MjKrC+xS1sZIH8cIx3EDtGn9gWX9X5R0mLV5b8KuW5SXXg2fJKtT2V3yurFsTyDXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a89914-2dea-4298-616b-08ded1a14bfd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 03:33:03.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzjtd3ZPTC1+bpNFZxEKLfOUR92aKSAynX9a6fF2JVWB9JOEXWg2XPZtKU0PFtK7nf6tzbBvUqfKCTNuOmmt8Qkkvu+bROgc9MFPmaxfhk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com

On Tue, Jun 16, 2026 at 03:49:11PM -0700, Dave Jiang wrote:
> Flavien Solt reported lifetime issues with the CXL MCE notifier, which
> can lead to NULL dereferences and use-after-free in the MCE handler.
> The notifier was registered per memory device and stored in 'struct
> cxl_memdev_state', even though it only needs the region state (the
> region's SPA range and its extended linear cache size).
> 
> Instead of keeping the memory device and endpoint alive, the correct fix
> is to move the notifier into 'struct cxl_region' and register it from
> cxl_region_probe() as it should be a per-region notifier. Setup the
> registration to only happen for regions that have an extended linear
> cache as that is the only current usage.
> 
> Remove cxl_port_get_spa_cache_alias() as it is now dead code.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

