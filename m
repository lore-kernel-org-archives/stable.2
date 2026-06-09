Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA44B8DC7;
	Tue,  9 Jun 2026 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025039; cv=fail; b=sGEA4hokOx3pvJJwjw06SUdqDiLt1LzrCpTHM6GTH+Uz1/AaWy4c22qvSP+t+IvwpUpCQWhJ+bjsvarbYm3D8rFFBgxECAaGw5mYLKqs5sGj22IsLk2aeUYnt4fA8ExuReaEwkNMRUoPzXBGM5ZB6zGP7/3LCXGQOL7XfyzO9R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025039; c=relaxed/simple;
	bh=mVxoHD88OblmxQGsQIY96LpvuL5oXYIEkLnB6AEQmi0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SGi7FEcEzWD6aQZF6VQ1UAbeaLhvBcdM61wxvEZQ+QIyDF1Wjub9QE1H9pQeV2cxz7WNqIQy9CHQ4Q/lea4T5EWous975rKg0RC+7Oig+txyxv6QJCU4TJTN0XSrdo20dc7aVatyhtOP3TwNWGJT0ljRlxl+kj2j6cEvg9wSze8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lF16KEzn; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lF16KEzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781025036; x=1812561036;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mVxoHD88OblmxQGsQIY96LpvuL5oXYIEkLnB6AEQmi0=;
  b=lF16KEznslUONkqfmkH4MpXmCmbcys1OLf01r4HPyYiYnY+VICTAOfTf
   ff9z9KL9hUJRVnY1AueHupUA1mYwaVIRcHKTh662CXfGHzctOFkeoht5X
   PYU93aHyE2ijzlgIKNbtVOpBXNfyr83tcTGMMZ270oz/V9cfZM9zaAQKT
   EiFEP3z1iKZGWOJIBlr2CBtr8KcOXGhSN7lYEpFuLDosi/nHlTQ5L23ay
   YTfID1JqT/PDN2Akeni76QhntWm5+NvEHnYfDve6AAH/fu1sRsswXKM6X
   z8/pq3j26FSQMEPPVdTAvmr52VBtzUcQSykXr+Gw0lXXusLKWudmGtB3F
   A==;
X-CSE-ConnectionGUID: zrhl2zhTSjy8EU8zHaW31Q==
X-CSE-MsgGUID: fEHY76N/SoiQkrFgGDNM7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85643978"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="85643978"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:10:35 -0700
X-CSE-ConnectionGUID: eKyccvv+SQCdIaBvXLAwCA==
X-CSE-MsgGUID: 9vBl9OepTuqjnvg15leZ6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="242954095"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:10:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 10:10:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 10:10:33 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 10:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lE4qSqgC1+OfipHd+bb0yWjWW/fslxyqblUdkYX7lkk/1kINOllnGfeV2RkZ+NLaxvMszgXQoSz6nhViBR8eZuyj5AllS+gYf3LveYmweH2aBSXBz3jg7S0ROb+DCC4CisdI9D/r290hkW4+zfdqWNUybdRZV2kawC8xSQLrKDpd9ArrfigZnhA9sOwMdcvylQMT7XD4LgpXOnhLKIgEejOGBZTPPqt9dr2AkTacbImBOTqNfl6mq7WQqFKdY+OWproPXBB9lMNj/dv9P0ELwdmuhqTBriZNZ5J6zRKkQ4kocUh+xQzvPnWJ13GupgzGPvnUtXkfaZc89SJnDqdPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REMFs7X6EICJFc/P5kuP87FhlHwSaX8j7EGX651vBt0=;
 b=VSHCK+cKN6P4J1LJCAq2biVfZPdFoNZKenJqJ5x5QRNhRHd2fdxPaRNGPZyUb2N4fDO3koxuMFvhjEpEn+rOefgD85w7ZQr2efwGA1YfV10Ru5QOeKX0r5qZqP8LhOB5amKHT0h9L3NAW4skpHTX5+BkknvFnOS1nCEhAeawFQ7tTl97OOXIyHHVdXZrOhGtfnaOXg2ruURys6XwDWawx4ZWewWKUCwQkeaHbDFIhbf/snm2DTnE13Jx61JsvsU0ZIgFRPw/7ToqaysC4VqioApfEndHmAeuU4S2JGbljCrODNpATEpQ6AciKLeNlQGF72S4ZIy4/D8qEhuHs6Q46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 17:10:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 17:10:29 +0000
Date: Tue, 9 Jun 2026 10:10:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<ming.li@zohomail.com>, <rrichter@amd.com>, <Benjamin.Cheatham@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <stable@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH] cxl/ras: Fix match_memdev_by_parent() pointer type
 mismatch
Message-ID: <aihI9XAslh04a2T_@aschofie-mobl2.lan>
References: <20260608224319.587614-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260608224319.587614-1-terry.bowman@amd.com>
X-ClientProxiedBy: BY3PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:217::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e58a3a-fc22-4f81-1a8b-08dec64a01bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|11063799006|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: o6HVkb3YgJu7ia3rg5BtBOerGfTNj5HLH1+LgO59wEEv+Xw/cvy49gU8PPVthXWwHDwneSJztj+0D1lsjz9rigxf2+XcTkcsFaA/klU0/iGC2lP9yBAYeHQpBA9LhRhosuStdT/tdER/lSC15zpHWPbKGHyhZsntbKeBIkopcGTVorpjQIlS+dJ/77mpcgcBc/Hqma/br3sxeX0Hg8t0QYQnD4tJjf0AoNB9G/ck29qxNbgNHNAEBPHo9epd6nluiyEhcAeXFl2DDA6cOsCeOfbDZxJjp9LwzUvm1SfFTvu+GfD3AlvpEASX95tkL3MFrresdrtfV7kQXcU4+K3+wxdeOcHw7cTaO1kM27lTGZj7XpHOcNAS2sXvJZ+PQphQ2Un55gggW8mPyGMuDm/g+nswCaBJUoT0JTdvQvOqcK+oPdNFlRlbRi0+0VlVZFz1e8MQsUKoii4jyp6ISAu7Vwmw+tUAUD1AVkMPD9Oa3Gp/SwQGdnSGqTEfLqJrXJ6tKbrQwSEKCyyQ5NZq4ZRvmgkSY4JuKpxueNkO/AgWnx7jViNuLrgK00YZe41b68/iyQ9Du4EWELkDoV8XyxZu2xmd/VaJA63Y33+e/etwNuYi9R1m0lFoJR1y0LS+ZWqBaHjbwg8X5U0KgWy4sZgW8RV1sY0y+22CQ1oyZMamOz5jJC1FwHBAY8zVS8MPVpmJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(11063799006)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jvtIEv/58CJm6FuW/qqteOTRbfksX7kh8j0VMey1s3j3OrFRTWGJc+5cBLoX?=
 =?us-ascii?Q?XVmgIBsvWSJU0lam67tXkTzbr5Akvw62H2eWy2Pv7aQk+n1Q6Uo5rwlQHJMZ?=
 =?us-ascii?Q?+jLkb0rhKsu6UX62nFbvLWbcWdkMwiYIzpD5/RcFPhwnWbPyMKRGpnFMvRys?=
 =?us-ascii?Q?I223gyCKcrr9FQEw1Du5H4AdTvvYtfno/cUrgB35LP2s4vc8NNMcTvKzU022?=
 =?us-ascii?Q?beCdE8fd0pRj6+HrQyAMt4iKa9aAEkSc9zkbKFZbCn2uvLwmCfgM9D6/RFgw?=
 =?us-ascii?Q?aa44ZPy4qiqPTCTywUTOWqeoKF0h2udxpBcF//eWnBk7hOwgyX6j2BnQMz9I?=
 =?us-ascii?Q?pzmTMGnyzRCJXlu4gzRzDcZAvgHrSBOARcsmxA5R6vR7nbcoJcFhu0kAJd8Z?=
 =?us-ascii?Q?ZmNqzFNf9BObWM5OcWyALDFqOCRgckvoisHrpkdYZ5XCzVbjKFet8TsewjsU?=
 =?us-ascii?Q?CUfVkEzVQccVDXKR954NMdspBLyzXclPq6Zc64sMxUkCdqs6sOx2X6opZ1Nf?=
 =?us-ascii?Q?zMyMJSEG8mlkrCl6urUgzYID2/5mTte3pbtQb+YRDsUuMYqgd1IElpEaDaVN?=
 =?us-ascii?Q?ISPQFL56lzk/bSIIC4zxhcOGHMYrx65/FjZbks4HJqWZC1/QMCsWVaW/Qs8w?=
 =?us-ascii?Q?G2f48XuBHm1oEjFVIvaGk5kYqkstk+QAxKf9c895ns5bWdDfpWq7TlLXROla?=
 =?us-ascii?Q?mh6O2By0f/Wp4llFkwqkQIX6aAXYoSEImsT6K6luHvvLfnVpgPQRhIlsChgv?=
 =?us-ascii?Q?nsvXNOL7uLXVXAddyChC5tkiubd/L3FLftZNTsmAmds7OdRJf93uo6ir0Y3A?=
 =?us-ascii?Q?XOwqaw5kp0Rh81RWyViepmBxwzcyAkpZo3CWh01jzjoOEnpOqGNSZg5hT4mt?=
 =?us-ascii?Q?tOEzOrnsJXkUH98HBDEYnRUiWl3tc0TnGiX/t0CwfDLRuynQyNWOaUr9Qe8a?=
 =?us-ascii?Q?1+SJY3Q4OO7WLq449BdFGWXPICZR98fFfWS05btSfiRhDmz+jZ/6p/aKuiOT?=
 =?us-ascii?Q?a68IBI0mPkS0QNPkRqnutw9VOvj/PRhm5+x1+2mVNAWZIkE/Z6saahK4DKKm?=
 =?us-ascii?Q?CS4bt3WciPH9DUGRoyI7zFEyG6qSRfWwi4/rfM8vIoUlp2fuB1gRJOloiPhc?=
 =?us-ascii?Q?8sGesDNMYR55lrpH0HR67/V8ZnPqOY8d5FeT/hXuvRsrd63GKHEimyvsQYEq?=
 =?us-ascii?Q?nGrJ4MEeSrRNZCAWwu0EVr6FHEjKPYFriw3jQLeTgOjMLXN345wDItKJjwKo?=
 =?us-ascii?Q?FRlvc7vl/TlyyByK8OjHGPD5tfx6mTsvad156mut8erdpAVCtzLByB35J6EN?=
 =?us-ascii?Q?EWGNv4LeuTUDG5H5hJZA0FKJ++BB1ErcnliHkEdyHex4VvKb4oFVOwrDgahO?=
 =?us-ascii?Q?Lbq4vaS7T1quVyCnKQAg0X7j0dC1c8SQmLvQOX7ANh3ELPDF4vIesF6qFffb?=
 =?us-ascii?Q?hcdxVf/BY82YNeECCKtG3zhjpHVPTQ5BrOtyzwD9G0QXHwoBzHWlhGEjpUXZ?=
 =?us-ascii?Q?wPMdfIxaBC8Q5mGVMAtcAD90qCdOCUURTgDNKl08HdMJYI1SJKwRZF3+/sEr?=
 =?us-ascii?Q?bEH+WGJOSXdoCb5L7oOP8QyUKdpCH5ICfBKTbHM+cc5FCfj+2s33q/4GfyA8?=
 =?us-ascii?Q?ygG22ab/+YyvTSpjhEhApVj7H12qa0vua6PPvuVsYkGxesWqzW/csKsCwJjt?=
 =?us-ascii?Q?9fA5WieMLfG810voAcRU4GZVELJtab19FjWphIh31keX8XeojwBAS5Xs80Aj?=
 =?us-ascii?Q?OD0GKiBZhEdfRJzJoiPgfg5vhX3LuSU=3D?=
X-Exchange-RoutingPolicyChecked: aVpAAhW+pJy9xeOGhN6BHJo8vhuGMPgKdc85OSjDyXCt2UI0BB4UVaAS/j3vWaZ4Xoy1b2rL7tmANTaWfw9wu/oi43r197qpLffxpJp4f0qwK8jnGFMUuTh23GfxL4WhFSiNUQ8TFgYuerAxrVfTng/zdVhhKcgXHaCsEVojkB3FO6+Ldkl9eZ6/GIvxMRDyJouShx1OuHLOd40Of8yCcVsadfCRDsopof+xngCQjyhpGL6XOeJKs43K5PS+Zj5BH0IaHZpfTsv2HHYgwsoL2dJ05MP719hP2VnasR8brPYHqI4BP9Y8Z41LCVzatxT31LTTNzpvz6Ayuynl0481eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e58a3a-fc22-4f81-1a8b-08dec64a01bb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 17:10:29.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QeGQfOGc/WzGa1EbIcCZjw2Xd/nI/0b0P1zH/o2ox/SJwEMypkYrtfAqI834m914VeBv9SU7zmYbpXc4Md5gA802qBYz3/Sk3N6sqdC9UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
X-OriginatorOrg: intel.com

On Mon, Jun 08, 2026 at 05:43:19PM -0500, Terry Bowman wrote:
> bus_find_device() passes its data argument directly to the match
> function as a const void *. match_memdev_by_parent() compares
> dev->parent against this pointer:
> 
>     dev->parent == uport
> 
> cxlmd->dev.parent is set in cxl_memdev_alloc() as:
> 
>     dev->parent = cxlds->dev;  /* cxlds->dev == &pdev->dev */
> 
> So cxlmd->dev.parent holds a struct device * pointing to &pdev->dev.
> However, bus_find_device() is called with pdev (struct pci_dev *)
> rather than &pdev->dev (struct device *). Since struct pci_dev does
> not begin with struct device, the two pointer values differ, causing
> the comparison to always evaluate false.
> 
> As a result, cxl_cper_handle_prot_err() silently drops every CPER
> error report for CXL endpoint devices -- bus_find_device() always
> returns NULL and the function returns early without emitting any
> kernel trace event.
> 
> Fix by passing &pdev->dev instead of pdev.
> 
> Fixes: 3c70ec71abda ("cxl/ras: Fix CPER handler device confusion")
> Reported-by: Sashiko <sashiko@linuxfoundation.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Hi Terry,

The commit log is burying the lead- no endpoint errors reported.

There is no need for the full struct layout analysis in the
changelog. The important part in the functional regression
and the pointer mismatch as root cause.

Please reframe the commit message along the lines of background,
problem, cause, fix, and validation. Something like-

    CXL endpoint CPER protocol errors are processed by ...

    Following commit 3c70ec71abda, endpoint CPER protocol errors are
    silently dropped and no trace events are emitted. This happens
    because bus_find_device() is called with the wrong pointer type,
    so the memdev parent match never succeeds.

    Fix it by ...


How do we know it works now?

-- Alison




> ---
>  drivers/cxl/core/ras.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 006c6ffc2f56..7ec2dab152a7 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -94,8 +94,7 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  	if (!pdev->dev.driver)
>  		return;
>  
> -	struct device *mem_dev __free(put_device) = bus_find_device(
> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> +	struct device *mem_dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_memdev_by_parent);
>  	if (!mem_dev)
>  		return;
>  
> -- 
> 2.34.1
> 
