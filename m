Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DB3EE1E4;
	Fri, 10 Jul 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678464; cv=fail; b=oPOS5r2OWwxWxS6ztcVxHvSHWFL4A4dthJNQZ3ZtNVUlCqU6k1jomt0BCeRpFjJ9J+nBTYu8Xo/vMPGxdbWaMQu/JTj21OXxXCBD2r9ngdVADY0XeQZqUB5c9iPLRYYp8ZnIV6PgNOeT3efn5t8B08XzCruuNGVmEf7pKf0NpSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678464; c=relaxed/simple;
	bh=mZfaTEAJkd71hxCbn90F60k0vJd41EPRKst7YaRFkLA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g6Z2ulY91KKehkFFKOkK/nsNMRObYIvVgSP91ZpAk5zQdqXGbBYXOIti1JJJC7YUQvyyDVq5H+rskrKb6751Qw3l2FPy5U0uI4GpXugbAGOOLHEZhu0pfSSOHCdVEQbWXtfMZndDq6TrBQ5Xpf/P3NFvfI6/1mwW80biggJV9ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+pm6T0D; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+pm6T0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783678462; x=1815214462;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mZfaTEAJkd71hxCbn90F60k0vJd41EPRKst7YaRFkLA=;
  b=N+pm6T0DBOO7n53Qmk4wCR+sL9jcx7jU81igK1euHhYHp7vpOIso4sj6
   KOfvXzGEjNOUCLJksiUEEzTxEpP5k5qbuC9BkEe702xvx/Dfwj6IERlaL
   uuTrYsDAwnAmYpnUrYyIW51LbScs/5U8X8Rhg027NYBB4jkC4LNVBJ6Gb
   tc9Bn2s3qIIloDFcO0m93g7OBXUonYBY5avVIB99wVYZUbNe7+ZY39J35
   914lHmzl9IJ7VlxfdJXMtUXBPjft0grg4qvkVUt2dg8QUN09Hi/KAyFI8
   aV2L5+5c23oU90WhKMZV9QdwZzeuStrgJbXFMDfEbbnpAer92mzSlmU2x
   w==;
X-CSE-ConnectionGUID: VBFU0jG6QaGlBr+t+uPUGw==
X-CSE-MsgGUID: 94y3R0OnQtSfo0JeVauUvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84397224"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84397224"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:14:18 -0700
X-CSE-ConnectionGUID: ZGynSUzJSkKc1lB4XYeg8w==
X-CSE-MsgGUID: fCzgq6qlTLOtsRQTmfhDCw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:14:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:14:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 03:14:17 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.56)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:14:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgPlWT3BPE4DM81uj4uGXSBI8V7wMAcsKeXT/4TdnuC9BLpP9GFgk0ewfwNkg9OrMMj0ua/+F6+kDL+mOEh8rLojdtTjbAoRvRRVM6QeFejPlIhHvgQKdDWMjIEhzt5ZP+YnPTyP1HaUJU4NbzzRBOhiyajwNSPMpsrgqEO000BQ7ml3sTVGODzsWT4Ky8ugmufTmvxQ8ENXeknZQNN9rXbp5/9gQddZWfgZxhDAr1GMpndGJK0fG1ra53W65kjDnVsykKQJPJkJvKPaoCIRb0vWytZeocTlWHt7FsCh2CfuWEbfd4Mrv/kDT0HHRFD+4EirrdIyWbco9xLP6hnHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW+QBsw/IgtTNOmMSi/2lbymQFMkXwbcfG7YUQPhaE0=;
 b=JaxyunMUNvuQwv6RpXfJ104qbLnr5ECQUo0k5Eg/tM5ODUA3kWUFmCHQh2/gZPi4FoPp0z8RZAPTJ4PoFNNIPJlFHWyxe2IJULrvNp8UcRh4pdQbdepsN7UH+BaZnZbdXizXcMFGHVIG89s1z0PDHtkzteu5f4vvHvErNp1w89ITCwhYCtTTwfRf4oWWLlZW8Yto9zRSk0QHV5qFJHmRp/bEMq9fI4v/V5vPmEZQgafiureo8c4gGwp6sSNUWAuHd+Wc5FPt3kKFLcHdxS8Z5OTAOg8j91IuMt6xLAO/6O06kLI8vuyMJGWbdColtOQ1q4jLFvhn0bW0VL6nXaaJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 PH0PR11MB9704.namprd11.prod.outlook.com (2603:10b6:510:399::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 10:14:12 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 10:14:12 +0000
Date: Fri, 10 Jul 2026 12:13:59 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
CC: <netdev@vger.kernel.org>, <joshwash@google.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>, <jordanrhee@google.com>,
	<nktgrg@google.com>, <maolson@google.com>, <thostet@google.com>,
	<csully@google.com>, <bcf@google.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Eddie Phillips <eddiephillips@google.com>
Subject: Re: [PATCH net v2] gve: fix Rx queue stall on alloc failure
Message-ID: <alDF5//N4cP2sCYK@boxer>
References: <20260709211906.3322883-1-hramamurthy@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709211906.3322883-1-hramamurthy@google.com>
X-ClientProxiedBy: WA2P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::13) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|PH0PR11MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: e70fd952-8cfc-4f22-5e83-08dede6bfce8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: fTKO3i6ER02075fSr+JrHJRp1mQjdVvW0d43j+iuV9NkuNWOS4gPeI+fBbH+nHUw8FxJyTGbLPDHsG89xyVhfbjvnr9Z3jciOZw4Ktjf+S9PVjbUOgfPY+l75xzOBd6h2sVqRwAFETBK3o8ic8bkyIJ1A0moSJLcRXQ2YV0T7CXuoE8/TivBxIzHvV+FsKKOJ9R1CvfMJzJrve9bjgexveJDi4bNufiZqEsjAnsSBhqUKhbGTb8dpsU5xSwmWueSuLy24CJpMX7J6wU21viCi+/jXnJ0Vw+NTk4oM9brua+28KRDq0VTD3o96Xtkb6c2uFOmeQvLexGhFsC+goGZ2NURRz9bU3iUo6XqdDxQ49iaoFUg8hCYU4dGrAR+YU6/1saRTjrI5b3IE5PXoD7WKKsi6RE4G6y3WqLg36sEBNRQdsaov4aJ3itF0xHRblUGOjBmqwLZIKbQsTwEUI9o0YvyKldHXoMLwd9bRXwxZkrZsj0mRT0rKgOYgr5esb+IqNXD9SZtjwvTLOye+177RNAzi3m2aQGXiF+FbT7FRJPKmNfPchzB8nfZLG6wP4vuxo3IunxrkL+85HRc2hwRKzb9Lw0IwCYRW+vfhcEz06HX74de4gdzNeK/g5Lmz13yyOt+Ket3OUUTnwJb0gUBtRTlfecM8QgWVXs4BmBdM9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I3F8qUwSHdvJvSiEIKMrNiezog9Km510HIVS0uHtgO9fxOjua1Q/F5Xxmrri?=
 =?us-ascii?Q?vzkVtdsYrZGivQaY2/CZX3Aj0Wm1D3tQmi0C+7y0ecvmiZVb72jJZwnbdCds?=
 =?us-ascii?Q?Z/vXCvoeLEx+3A8Ow1K5TbytnYVTrheR9kmTIPumZ4Vpbqryt69wNJbcYVM/?=
 =?us-ascii?Q?N0WMOagC/pIs4PFEwzrxK7hqw3H5vmZwh0c3Oigb8SaetSmmmFIKWjELdxIR?=
 =?us-ascii?Q?zTrKPpodLd8Sdbm9JIOiR7q2RZ0mlt7f9kEcWU6L3gEEia1nmyhUtMzQK39l?=
 =?us-ascii?Q?gRInYU3a4W8jKFqM7M5yRkgdoG2rOoc08J5/YtvhlFWLNX2g9DAVOjNSMPo0?=
 =?us-ascii?Q?W0M4wDxRvK0YoLp4x/s3Z1xpYQkP9WqiUUAirSreS0Z/Gdn3NHafgIwilV8r?=
 =?us-ascii?Q?EppKlKluEQtYRvz+z+SC6cFyVLLyNAg/tEm64kiKVjUII2AVpBI7E3WSTpRV?=
 =?us-ascii?Q?bKcC6QE6YfGfGBEs9aOFybLXIN+LlNn9ZzVlSmudX7L65tJRYRQElxZMvoty?=
 =?us-ascii?Q?rG5LGS3RnYBTh6lD5hnGSOhlh19NmSkvofqVMZvVw3vPQ2XAoH0NjPfI39I4?=
 =?us-ascii?Q?CAVn7woZfeOIM4DvJnO8+7+kEq6UX+6M2kDYShPqygmKqNYt1caG/9CcGqHK?=
 =?us-ascii?Q?dm6dppLq3GDMCB9F/RCtPzhxAjJoOHQVrNph/V4RkS2hNIkXj7Xv+w1oNtoU?=
 =?us-ascii?Q?fSqw08UIcNEyv6vKCKklUexuoCEMrBXnDUKS6EVZgqx1/0RvTJNMPHVWyeRO?=
 =?us-ascii?Q?VVb62kYPPtK2w40vVwNg8MilFaG5+GTaF0AaVBP5XHB48LjBJxR2aD+bZbd+?=
 =?us-ascii?Q?DuOoUqCuaD43gwLpCnm/NIwCaM51Ays+WLcwE1CQSz/6dHszHyeM38pn1zRF?=
 =?us-ascii?Q?072URNNTtML0y6Ozd6wDJeJpxO1Wh/5oCf55a6BTIIk3Q9nrxBRYx59JSllA?=
 =?us-ascii?Q?zr4ohEbYYXgtD9CMQfIc4zYcWKhcyDroRHsRIVZmJp9kWvSMwRLjEUun2sjI?=
 =?us-ascii?Q?hTCuaSbKfCoYpsO9b5lVX0VQnEx026BDCS9WHPQJKh4SN57khpRRCLhf8WlO?=
 =?us-ascii?Q?6O8Mh0R8ADKYksHBC3Jtf8Jn9mCmyWY0JhCVVIIQYYjQAUFNMC5r7TZsJuJG?=
 =?us-ascii?Q?Avsc5LCBnVi0EGca9ZspoN+V6iBZkqWETo58ajTwd9JoGdM5fxn7+pzyFinr?=
 =?us-ascii?Q?6AODBRyxAWxxIOan0LvWjckUTHO70kxZnpGnEiOcSv2zxcZzsdC1YK8/gbVE?=
 =?us-ascii?Q?qHfxJwRTPWc3M1Hg9Js9NqQJnd25grHczlxN+BiF9nh1/CJLylxO5XwJ9Q+Y?=
 =?us-ascii?Q?vfUmriLVDiZH+7Hi0O2+CnIy+i+phvQkauVFo4MWopnkNdZcJyUwzizkGils?=
 =?us-ascii?Q?pt59Nmav9hyD2uZSQlzjo7MQw34FX6WV5xpRi3yy6LDbcwWQqr4VdIsdun1+?=
 =?us-ascii?Q?IsvjPkX/A1gASJkBmX5eDD5gpCLrnCMwpUO0uvACnAAIVYbf3BaH4/Ja7H22?=
 =?us-ascii?Q?z72kdbwzAIySctv8hNUdGWbzm4szx/3RSVxH4oj+kuHBRXcXbFBgF17/V3N8?=
 =?us-ascii?Q?DTeWKe2XxyufgkcNQBNYcIAPhw5fzCpMP8T9HQXftrTTbfbKqqH3FAwCntDS?=
 =?us-ascii?Q?m73x7wwKDk/uCw33sahKbrSOae41K4xX8NApGqGjrkoWIhqCU+whS+zsCwIm?=
 =?us-ascii?Q?sUBP7anS9ZL1jBAdKwpi4r+aKIYI/739URRXOwvoe77k2bgnR0ewhq59l0J1?=
 =?us-ascii?Q?KPLVZOqh+79/1jVUEVj0DxAyNEeJfKY=3D?=
X-Exchange-RoutingPolicyChecked: UyhrOpA+Soa6j0nngFXWLdMT/TNVPVPJQSfTeX9frgeARbPmW7s6vudH25lNH20k47ACjIU3MW9lf7gtO2pNUdPAfAwMCVCjc6HEDTKSciiwIrfifZ8PNO/T4Avopum6cU2GAgqbdI6wTEYSrwV1CzXoPqHy/3A0KGAowz1pT1O69DQ76eoonKgmfNaeEwzg+OeK2jMydNoNM8i9xa1bMIo3u1Gtc/b6XytCHTiHdqIZ5VLPjCfaXakFZ6XPWI/B7uzi3Gif0yzabFvNLp2HKqJBGdngPRI8Vqu7kd5FqwD8bAeUxKSGABxMEPpJlSmhIOrlAVevvpbTOmNEJQ9AWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e70fd952-8cfc-4f22-5e83-08dede6bfce8
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:14:11.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8GV0Zl6UTsJOHk5IT1brkfZoNp4D94c1ldO2u+Ne+OyA9vWBMTuBgkdbO6OV0PDN55NB459ICePmq919J5H6XP9oZ16OiEYdvFa5hPCV3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9704
X-OriginatorOrg: intel.com

On Thu, Jul 09, 2026 at 09:19:06PM +0000, Harshitha Ramamurthy wrote:
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
> The threshold is set to 32 because a single maximum-sized Receive Segment
> Coalescing (RSC) packet can consume up to 19 descriptors in the Rx path.
> Lower thresholds (such as 8 or 16) would be insufficient to process a
> complete maximum-sized RSC packet, risking packet drops or unexpected
> hardware behavior under memory pressure. Setting the threshold to 32
> guarantees a safe margin to handle at least one full RSC packet.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Eddie Phillips <eddiephillips@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v2:
> - Link to v1: https://lore.kernel.org/netdev/20260701005341.3699161-1-hramamurthy@google.com/
> - Relocated the starvation timer to the end of gve_rx_ring to avoid polluting
> hotpath cachelines
> - Decoupled timer lifecycle from allocation cycles by moving initialization
> and shutdown to start/stop pathways instead of setup/remove pathways.
> - Added explicit rationale for the 32-descriptor threshold
> (GVE_RX_BUF_THRESH_DQO) ensuring it is safe for maximum-sized RSC packets.
> - Removed addition of a stat tracking critical low buffer events
> 
>  drivers/net/ethernet/google/gve/gve.h        |  3 +++
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 

[...]

>  	rx->fill_cnt += num_posted;
> +
> +	/* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> +	 * visible to the hardware, the hardware is in danger of starving
> +	 * and cannot trigger interrupts.
> +	 *
> +	 * We use a threshold of 32 because a single maximum-sized RSC
> +	 * packet can consume up to 19 descriptors in the Rx path. Lower
> +	 * thresholds (e.g., 8 or 16) would be unsafe as they could cause
> +	 * the device to drop/stall on a maximum-sized RSC packet.
> +	 *
> +	 * Start the timer to periodically reschedule NAPI and recover.
> +	 */
> +	num_bufs_avail_to_hw =
> +		((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> +		 bufq->head) & bufq->mask;
> +
> +	if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
> +		mod_timer(&rx->starvation_timer,
> +			  jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_MS));
> +	}

nit: redundant braces

>  }
>  
>  static void gve_rx_skb_csum(struct sk_buff *skb,
> -- 
> 2.55.0.795.g602f6c329a-goog
> 
