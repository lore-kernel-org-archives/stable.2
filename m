Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479D118BC3D;
	Wed,  1 Jul 2026 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912110; cv=fail; b=CF7w4LpEQ+PcXNw1BGZ06mmSx5WZjGQdEEQ+snPK6L2NDG5H7uoATNEZh4u7F6L1wpxmd4Lxp7IDe5C8hBkUq/5DtBD0/O/vHjAQaS/gV9uYXtvXfRjcm5daGKm6h8ifY6AXLr/An4JcTb9OTG257LWGhwRBvd3nMplDAOtdFNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912110; c=relaxed/simple;
	bh=WbYpYCZmG/2S78sJLsLIA+/djVDUmZK5XHW4LfvAN1I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JHhLebUSyE+bfc4OjlPHCnAgGK9qtKYaxXlTRGbbiz9aiWSIlvows6Q15BiUVKnJRQ7HUniD9F6dPjvgqjXgF2ygQHCCrteIy5Ss1PQ9p80KR1WnJ+qkFOGJhm1+KTzmtXf7CHjhMED8wZFD32u7/6Ylr9jx88nrOyxOGh3ENb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlOcZ/ll; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlOcZ/ll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782912108; x=1814448108;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WbYpYCZmG/2S78sJLsLIA+/djVDUmZK5XHW4LfvAN1I=;
  b=FlOcZ/llbokidvz8f9gh4sDOgNtN11fybMemVXGInoanzxT86aaDSm+L
   Kp1llui/fJKFBWwizfPftZuqD+1/WZI+hFPr5D/mJWELrX90Mj751HHGS
   CObajvw4tfLOBLTjgtx4pc+ICrn3IpA9irAz0B9fmlPY0SMCWSJ8SAqow
   E8KPlA9ZlBrtFT52gLoNwzYtb56HUnOGEmdx+j9WaJzJwy30uRQnpmgkG
   KNjDJxyFeB526heBZwHPAxj/rfbP+6Gyo1v1HOi+JxII4eXIyFMj5QOw6
   R1yFWr1r01wI9Bi1/YLY0OA3KR6DbaQ4I2TbvBm0jRHJJNjad1x1qFKUm
   A==;
X-CSE-ConnectionGUID: 32ivA9cxSzuMHI2HKu/m2g==
X-CSE-MsgGUID: UsMDiHB1StuSioILY2AaVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94296309"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="94296309"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 06:21:47 -0700
X-CSE-ConnectionGUID: U+DrHObgQdGCLKBDTlXzUw==
X-CSE-MsgGUID: AL8mxK7lS+6EpnAVg36xlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="276871811"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 06:21:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 06:21:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 06:21:47 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 06:21:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTnW69g17xjod70SAKyDq3DcWUwWRPCzoy+scJXXD+t0YfBngNV2TSAOzn/Dm5WddopFdPgdnX2+olyUfcNFQA40YashFuEEzyXuhuBg3EDHLEbXxEhRWCIpa1NJT4vGkGrUlDogZXubx5bIgQYPfLc+HdwW+Q8MDuG+6peBWZicXaf4BnblyAi1xpt44Kn8lFxVE0n48pn2AErkLBaSHqzPV6Dabq49nncPrdRYKwr9bFD2X3R0BZbz1I5zWA6fGm1w1w4HyVjcGa1iA/Z38De0a0O+BSGdns/ivJp63s/SAj4v2PTjiM2Ps6Kfh0S1uGKaWSp6GNFR+hIsGOK+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jeKrAmdNmyX91APIL9FQvSO2ABgySTWsf/OP7CoPAc=;
 b=S8oAvBy7UyyVEoeU1DN4bVTbP227XhTwKCWXugP8ZNpFdDqiyb9+u9sLpxIeEPLR43ga+ozTa3SNbk68RkApMzNB8r8RUH8yntYajja4192cTe2hShzcB8oCMDeT5kwjArtGncTc7VrACLY5sLDyo0jRz5tpN9vaV6XemjNH2rKLnm2N+XRqtEM0uYkfgteLzjnz5Ok5qOALKmn8waLEGV4/ytkZMy3mr1/c7zJLwQhz/da7+/7/qyClxE+nu4TLa7G5nkEkGVPM/sY6kDKfSwbtrQJXX7SGnFAurmSadV0gx6HESnHXMPJ3Vdq+w2Fr1Q142EeNIJ3JVZTnDOSo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 1 Jul 2026 13:21:41 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 13:21:41 +0000
Date: Wed, 1 Jul 2026 15:21:33 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
CC: <netdev@vger.kernel.org>, <joshwash@google.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<sdf@fomichev.me>, <willemb@google.com>, <jordanrhee@google.com>,
	<nktgrg@google.com>, <maolson@google.com>, <jacob.e.keller@intel.com>,
	<thostet@google.com>, <csully@google.com>, <bcf@google.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Eddie Phillips
	<eddiephillips@google.com>
Subject: Re: [PATCH net] gve: fix Rx queue stall on alloc failure
Message-ID: <akUUXT6UwTTD2yOs@boxer>
References: <20260701005341.3699161-1-hramamurthy@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701005341.3699161-1-hramamurthy@google.com>
X-ClientProxiedBy: VIXP296CA0017.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36c::13) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|DS0PR11MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: b40e03cc-33af-4003-d3ea-08ded773b055
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: u+dGe1NEFtdu7cvyvnJ6HmeZvfhgUfdDMdtTeoADp+qAeosKrOo0fMr8DlaU1fr+YeLsKQRJ+vCViQp6ulS33gWPrWWBz/5jYBOTOrwm2OzUiGDXkFusyu9TyvBgZlWOKF/nCPjNQsYrLIsxridxpyrEiFV9UK+EldRyeGDjepGNuIXAvbkbvqBy+uVAiTYf7/qSaoEjtVeoOoxT4qKNHp7YpzcBBNr/SVpfxZK8zHTbHok9qPFrq1THOgx5K/WWKnig/2/I86UuNOq3y7vjJjgDemRB0EvbPYTJdfZkBIgho44SGDSDdxFkTpanCERJibMqK9Oj0GJgsqKAsqHVSJwP+mGvWL81QY1QB6WJyqha+kikr7hFqQ6ANdidoEEU1WLGMCJUCuc5i/Gi7CXMFGUCUifDqMZ25eYlqQ+ph7trFWS0qI30YTUrW227RL4Y3JXOzbLwFwDQs2jE5Cyc6liVqbWQ/yn3EtX/MWEd8gMd+1TNCM3Vi+ObCeGZCZ7tamJAkawP+3f0z2bpswar81qbBYAec3HkI+Dx7DS6K9Zy1YyBRld51wM82ZBS+yg0kDOGklQZq1Mg7qE4bmcnNM6ZLM+oU3yfagYUZ+uTd8SzYwzW51HQfkbYt8iaZRtttmaADHJceqCGdM/Od8lEyEOixs0GrmX98Vo8eTyZFHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RD7og5tUvwHi37lJnM045z5yRd7eCF6dCA0v2KiOsu+6qxVHO3SWulcR/U+l?=
 =?us-ascii?Q?pMEMj+ybT+2x8eLPkzKHOh/KWQgMHbC06z5JclCTAzmZcwHtRBhpNKo/ctz4?=
 =?us-ascii?Q?cDRw/mqEZWs7VBOO06uegPTgScSypFS/A0Ye1Mc/8FwFi3fu69ObkiDI709h?=
 =?us-ascii?Q?o3fpoEAMlP+nefAzeebFBM0ZV9tpSJTQSKmZDKbHeiSkhI8BxS8yGi/hJ53C?=
 =?us-ascii?Q?syre7FXuxqBLcflXh47nw+zPvY6pVdIguANb485GgZZS8iiyXhqkFXemmrgK?=
 =?us-ascii?Q?8Y9O8aUqvzaby9D5nxP/5m6osKGxP42CTiQgJ20ZKirwMNPHfdhfHDnKmTcM?=
 =?us-ascii?Q?aKEyxzWRhzhNsXLOsMhGDYZkrD3QVpM7hEH116Yvm3JSRahol1sVnz1y1DbP?=
 =?us-ascii?Q?7h+KNrmpAJ5VAEWryUDUu6FE8AXLzumXIoDk5WtqfhoSRJNbU93nHkRBPrsT?=
 =?us-ascii?Q?WX93YkHYXzA5LIAmiREBfCgvmMQ80O1oRDSD09tM9t8UlbeXUEFfzl8KCaHf?=
 =?us-ascii?Q?NbkAi5mLWMBHRwt+NuKN4ZesKMOnAtHVHppkNTsgNx/BiwoM6TAyFwpzk0LU?=
 =?us-ascii?Q?IIGFNOZMgGN8mg27wrEFTU9QivzfCE0Ghz0ezCJNjsgBjp3FpXQLVyRqaSF7?=
 =?us-ascii?Q?YUJ7gbg4l3r4KVeN0lSDxRgB1rhoqyJMIFDrgSmU6z0xVPTSTirE5Xnugx7F?=
 =?us-ascii?Q?pxz9RV5R09qj9pN+1Q/zS5XMgKHgzmlk54F/c0jRwYg6K+So6292nktp9hHx?=
 =?us-ascii?Q?FSVYVrOoktK9EJKuiw7JZAkG/yRiq2fRSPyyNfBdukJC9ZgXnmzGnnq+pnrs?=
 =?us-ascii?Q?Fumlp1JoER1M7XAjItikZ7Rj4/WcvKiS4w5HwYBD3eJASn1Kh3yIR8aXTRJL?=
 =?us-ascii?Q?5AmInXiQcnKL+smgz1SXxs5E0VDw7ED1jfy9x4uJHyO8ozytjI6oZMWABC8W?=
 =?us-ascii?Q?+60f/VzdOUjFfl6gVHFylkF3r5HxO7i0J4S4lDNKnOiKqIXOeD6JB2+3FlZw?=
 =?us-ascii?Q?Ehx9fBdc+QwlCLvxZYEesBb+bHQEU0eURNXCJB84X8sGT5FymPmCdemh8CKO?=
 =?us-ascii?Q?yCjYEytLcvRfghemc6sM2GExFE0nmfyUv6UBcjIlObBHOxUaqZmPmj4fM4qD?=
 =?us-ascii?Q?m/rwtrUEMNGBB/5UMXlwWjflTDQbyFHWjL9Dq0yJk8LvRq9LdDM+KyEBOdg4?=
 =?us-ascii?Q?TY25MgHkyBw7wstnBHLmSxdtAl5RBoeMAgyUbvfVYrLmQ3JVU2BDKY2RmxxS?=
 =?us-ascii?Q?64FSdoCudMVWK/2sGVqmSQlqukD1YwOiteakODffxyHi5C5utyGN85uqc8ZW?=
 =?us-ascii?Q?d/xzW0GaqcXwnVbDu0j005nlzdoyGf5bvGJNL0Ymgu3OfKNDSjBY2eQlJ4Le?=
 =?us-ascii?Q?87UQ8eah7NQBVNv2rjg8vbffNtyTzhAwt5K6CULD0E0xx7T8OVoAoB63OZjd?=
 =?us-ascii?Q?OcDG2IND/KKcPOhEx/M6cYk97HX6C14SV4Kq/pQi45MN2qPbU1dZrbaXoYl0?=
 =?us-ascii?Q?OTKRORFweMdYjzjaSnuT/g3BPYQGUCOHfHhoCeK8wKX87LzbYBAUawjMoVep?=
 =?us-ascii?Q?uQ2+s8IkmrRxP9awnnFJfexUf2TMUYWqVIL5rMhiMpC/vyitJ7goOAMMdI7o?=
 =?us-ascii?Q?Pwd37gmapi/Ppl/a5JNLjpTA5iBI3ID9WTAL8UmDBVjkVykn872pMHHQIqvc?=
 =?us-ascii?Q?XkwR0MAOuPVBqz9lLKOoLtTG840IKM+m6hkqMtxnJ/7pVtObJ4u3u6L1UBvY?=
 =?us-ascii?Q?gu9sxv+Hqvm+LpoOD3m1ySs3Ql1kulc=3D?=
X-Exchange-RoutingPolicyChecked: UFkDZghu6ZM5I/Q16NBXZ2Gq6I+pdIKpEM0beIAz7PPo+kaeNrQWi2mqAY+xlDohXKkdnWOSxwXp8C1wicdK7atQFLRQvKXP41sEDSqq+EuhdtHoSyMqa20ADJ9Y+WVshdtZUyqd5fxabXZ1uHEYusPptN5DWZVpwTz+//RUv1dDeQS0Kr/Y5M8nwRYBSzMEAjA1k0nKnftKJODvr7NvGmDeymoE0sxcNLs2gNWVjvEQ1Bb2bp/A/4lt/i4+6plDHOTMZNdcxiDdpvtmE3HdA1bi+bMhQNXEGRckUF+8aP5KInUywtnBhXTs7KwTPSWRk16WP7qNIVt2xVpFUeVPhw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b40e03cc-33af-4003-d3ea-08ded773b055
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 13:21:41.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbX4MKE+vuyUwvzj0TwBanYqbm+Wm7moPvTFkqfM6dzvSPBi3GE/ae48Qr84MdknETaPymi9GRf7pYTOLa2rnah3PwTvqKvZ0spUxbZPKrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com

On Wed, Jul 01, 2026 at 12:53:41AM +0000, Harshitha Ramamurthy wrote:
> From: Eddie Phillips <eddiephillips@google.com>
> 
> When the system is under extreme memory pressure, page allocations can
> fail during the Rx buffer refill loop. If the number of buffers posted
> to hardware falls below a critical low threshold and the refill loop
> exits due to allocation failures, the queue can stall:
> 
> 1. The device drops incoming packets because there are no descriptors.
> 2. Since no packets are processed, no Rx completions are generated.
> 3. Because no completions occur, NAPI is never scheduled, preventing
>    the refill loop from running again even after memory is freed.
> 
> This results in a permanent queue stall.
> 
> Resolve this by introducing a starvation recovery timer for each Rx queue.
> If the number of buffers posted to hardware falls below a critical low
> threshold, start a timer to periodically reschedule NAPI. Once NAPI runs
> and successfully refills the queue above the threshold, the timer is
> not rescheduled.
> 
> Also add a new ethtool statistic "rx_critical_low_bufs" to track the
> number of times the starvation recovery timer is triggered.

I think this deserves to be pulled out of the timer logic?

Two questions tho:
- couldn't you detect this case within napi poll loop?
- if not, does it have to be per-q timer? wouldn't one global per pf timer
  satisfy your needs?

> 
> Cc: stable@vger.kernel.org
> Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Eddie Phillips <eddiephillips@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h         |  4 ++++
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 14 +++++++++++++-
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 2f7bd330..8378bef2 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -13,6 +13,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/pci.h>
> +#include <linux/timer.h>
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/u64_stats_sync.h>
>  #include <net/page_pool/helpers.h>
> @@ -41,6 +42,7 @@
>  
>  /* Interval to schedule a stats report update, 20000ms. */
>  #define GVE_STATS_REPORT_TIMER_PERIOD	20000
> +#define GVE_RX_NAPI_RESCHED_MS 20 /* msecs */
>  
>  /* Numbers of NIC tx/rx stats in stats report. */
>  #define NIC_TX_STATS_REPORT_NUM	0
> @@ -318,6 +320,7 @@ struct gve_rx_ring {
>  	u64 rx_copied_pkt; /* free-running total number of copied packets */
>  	u64 rx_skb_alloc_fail; /* free-running count of skb alloc fails */
>  	u64 rx_buf_alloc_fail; /* free-running count of buffer alloc fails */
> +	u64 rx_critical_low_bufs; /* count of critical low buffer events */
>  	u64 rx_desc_err_dropped_pkt; /* free-running count of packets dropped by descriptor error */
>  	/* free-running count of unsplit packets due to header buffer overflow or hdr_len is 0 */
>  	u64 rx_hsplit_unsplit_pkt;
> @@ -334,6 +337,7 @@ struct gve_rx_ring {
>  	struct gve_queue_resources *q_resources; /* head and tail pointer idx */
>  	dma_addr_t q_resources_bus; /* dma address for the queue resources */
>  	struct u64_stats_sync statss; /* sync stats for 32bit archs */
> +	struct timer_list starvation_timer; /* for queue starvation recovery */
>  
>  	struct gve_rx_ctx ctx; /* Info for packet currently being processed in this ring. */
>  
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index a0e0472b..71b6efbf 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -46,6 +46,7 @@ static const char gve_gstrings_main_stats[][ETH_GSTRING_LEN] = {
>  	"rx_hsplit_unsplit_pkt",
>  	"interface_up_cnt", "interface_down_cnt", "reset_cnt",
>  	"page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt",
> +	"rx_critical_low_bufs",
>  };
>  
>  static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
> @@ -58,6 +59,7 @@ static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
>  	"rx_xdp_aborted[%u]", "rx_xdp_drop[%u]", "rx_xdp_pass[%u]",
>  	"rx_xdp_tx[%u]", "rx_xdp_redirect[%u]",
>  	"rx_xdp_tx_errors[%u]", "rx_xdp_redirect_errors[%u]", "rx_xdp_alloc_fails[%u]",
> +	"rx_critical_low_bufs[%u]",
>  };
>  
>  static const char gve_gstrings_tx_stats[][ETH_GSTRING_LEN] = {
> @@ -151,12 +153,14 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  {
>  	u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hsplit_bytes,
>  		tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
> +		tmp_rx_critical_low_bufs,
>  		tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pkt,
>  		tmp_tx_pkts, tmp_tx_bytes,
>  		tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
>  	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
>  		rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
> -		tx_dropped, xdp_tx_errors, xdp_redirect_errors;
> +		rx_critical_low_bufs, tx_dropped, xdp_tx_errors,
> +		xdp_redirect_errors;
>  	int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
>  	int stats_idx, stats_region_len, nic_stats_len;
>  	struct stats *report_stats;
> @@ -197,6 +201,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  
>  	for (rx_pkts = 0, rx_bytes = 0, rx_hsplit_pkt = 0,
>  	     rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
> +	     rx_critical_low_bufs = 0,
>  	     rx_desc_err_dropped_pkt = 0, rx_hsplit_unsplit_pkt = 0,
>  	     xdp_tx_errors = 0, xdp_redirect_errors = 0,
>  	     ring = 0;
> @@ -212,6 +217,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  				tmp_rx_bytes = rx->rbytes;
>  				tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
>  				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
> +				tmp_rx_critical_low_bufs =
> +					rx->rx_critical_low_bufs;
>  				tmp_rx_desc_err_dropped_pkt =
>  					rx->rx_desc_err_dropped_pkt;
>  				tmp_rx_hsplit_unsplit_pkt =
> @@ -226,6 +233,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  			rx_bytes += tmp_rx_bytes;
>  			rx_skb_alloc_fail += tmp_rx_skb_alloc_fail;
>  			rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
> +			rx_critical_low_bufs += tmp_rx_critical_low_bufs;
>  			rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
>  			rx_hsplit_unsplit_pkt += tmp_rx_hsplit_unsplit_pkt;
>  			xdp_tx_errors += tmp_xdp_tx_errors;
> @@ -269,6 +277,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  	data[i++] = priv->page_alloc_fail;
>  	data[i++] = priv->dma_mapping_error;
>  	data[i++] = priv->stats_report_trigger_cnt;
> +	data[i++] = rx_critical_low_bufs;
>  	i = GVE_MAIN_STATS_LEN;
>  
>  	rx_base_stats_idx = 0;
> @@ -337,6 +346,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  				tmp_rx_hsplit_bytes = rx->rx_hsplit_bytes;
>  				tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
>  				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
> +				tmp_rx_critical_low_bufs =
> +					rx->rx_critical_low_bufs;
>  				tmp_rx_desc_err_dropped_pkt =
>  					rx->rx_desc_err_dropped_pkt;
>  				tmp_xdp_tx_errors = rx->xdp_tx_errors;
> @@ -381,6 +392,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
>  						       start));
>  			i += GVE_XDP_ACTIONS + 3; /* XDP rx counters */
> +			data[i++] = tmp_rx_critical_low_bufs;
>  		}
>  	} else {
>  		i += priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index 02cba280..303db4fa 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -18,6 +18,16 @@
>  #include <net/tcp.h>
>  #include <net/xdp_sock_drv.h>
>  
> +static void gve_rx_starvation_timer(struct timer_list *t)
> +{
> +	struct gve_rx_ring *rx = timer_container_of(rx, t, starvation_timer);
> +	struct gve_priv *priv = rx->gve;
> +	struct gve_notify_block *block;
> +
> +	block = &priv->ntfy_blocks[rx->ntfy_id];
> +	napi_schedule(&block->napi);
> +}
> +
>  static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
>  {
>  	struct device *hdev = &priv->pdev->dev;
> @@ -120,6 +130,7 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
>  
>  	if (rx->dqo.page_pool)
>  		page_pool_disable_direct_recycling(rx->dqo.page_pool);
> +	timer_delete_sync(&rx->starvation_timer);
>  	gve_remove_napi(priv, ntfy_idx);
>  	gve_rx_remove_from_block(priv, idx);
>  	gve_rx_reset_ring_dqo(priv, idx);
> @@ -136,6 +147,8 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
>  	u32 qpl_id;
>  	int i;
>  
> +	timer_shutdown_sync(&rx->starvation_timer);
> +
>  	completion_queue_slots = rx->dqo.complq.mask + 1;
>  	buffer_queue_slots = rx->dqo.bufq.mask + 1;
>  
> @@ -232,6 +245,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
>  	rx->gve = priv;
>  	rx->q_num = idx;
>  	rx->packet_buffer_size = cfg->packet_buffer_size;
> +	timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0);
>  
>  	if (cfg->xdp) {
>  		rx->packet_buffer_truesize = GVE_XDP_RX_BUFFER_SIZE_DQO;
> @@ -365,6 +379,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
>  	struct gve_rx_compl_queue_dqo *complq = &rx->dqo.complq;
>  	struct gve_rx_buf_queue_dqo *bufq = &rx->dqo.bufq;
>  	struct gve_priv *priv = rx->gve;
> +	u32 num_bufs_avail_to_hw;
>  	u32 num_avail_slots;
>  	u32 num_full_slots;
>  	u32 num_posted = 0;
> @@ -400,6 +415,23 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
>  	}
>  
>  	rx->fill_cnt += num_posted;
> +
> +	/* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> +	 * visible to the hardware, and no doorbell was written, the hardware
> +	 * is in danger of starving and cannot trigger interrupts. Start the
> +	 * timer to periodically reschedule NAPI and recover from starvation.
> +	 */
> +	num_bufs_avail_to_hw =
> +		((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> +		 bufq->head) & bufq->mask;
> +
> +	if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
> +		u64_stats_update_begin(&rx->statss);
> +		rx->rx_critical_low_bufs++;
> +		u64_stats_update_end(&rx->statss);
> +		mod_timer(&rx->starvation_timer,
> +			  jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_MS));
> +	}
>  }
>  
>  static void gve_rx_skb_csum(struct sk_buff *skb,
> -- 
> 2.55.0.rc2.803.g1fd1e6609c-goog
> 
> 
