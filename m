Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DBA25A357;
	Wed,  1 Jul 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915693; cv=fail; b=p6+BIOhR6yRHarU8SjtkpBykXYf50g5Ga4hN3RPyLpoJ6kWTQhZ4/gVPZllsPVlVCjzXEtN+5Fkgxp2ga2YvTzcdkjUz156qSBLLwoYLXWOFv/Xsq61OFLO8AynRujdwV3BHHtbmf3qWArS5bYyifGwkWCld12kbt9rcOZkADVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915693; c=relaxed/simple;
	bh=hHi9DyZ7aTZg0LvXUCp33PxqJjL3ZDmTyVvyqCZu/4w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EiLuHIszBiwbAmkRs9FLZRiNXZpmJc2O+6rocVfIdytnQAB29LrHKQIMm9edEJqEyvWyn2N2iWd1nW5XD3vmlyVS4D+bzHa8YXeqS1LDnQvKDHVPxEDXM8sAsnRit5HPiOa8ibg/9V1xuOJawZkRTGoJSetiVxMyE3mCpYaidBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhWOJgkg; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhWOJgkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782915692; x=1814451692;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hHi9DyZ7aTZg0LvXUCp33PxqJjL3ZDmTyVvyqCZu/4w=;
  b=PhWOJgkg4+B15vflSfp6RkA+F7f6Gisuw1sW/jSDUiXJ5hgJprNUQhK+
   7ZY4CMEy27vuRsQpY4A7JWkbeb2vftbHIIdh50KlQUS+RflhVGK9Rzoua
   54VE6O3ibAXGQPFda0iR6wOZNo3MAN4/YYgJjHs4P6ToUtY33OBKDQNLD
   2210irM3gxg7FYpxFskpiCtshVlmA7u3L0ORsFovFbP0URI942M343Oo0
   NuI/ERtwJeZ+ROYQ1JZqMJXw6cVc/xE7VJ45Y1eVc3QT3oEe3wOYh+par
   rvF0fHqqtaYbA3UeH4x1YaTr/b4amUjaBFpscP4n0j8qZzxHZXAr5QHUj
   Q==;
X-CSE-ConnectionGUID: a/PyYtSvR2CoHSVy9PIScw==
X-CSE-MsgGUID: bwmbEwHeQBqzMiZMEyAGTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82766486"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="82766486"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 07:21:32 -0700
X-CSE-ConnectionGUID: ZMAB8bzBQtmwt1KDNevijA==
X-CSE-MsgGUID: gJvKetGISe+3ScoEe2D+CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="249212889"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 07:21:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 07:21:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 07:21:30 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 07:21:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlZ6koHGZmt4tR4hLMbABy0KfEpWfZRP1zxDm1ecwOedJchOVk/1RaxSZGafyc+Sd5tPXkH9aqljrngofjJ6P5KlDkJV1zNc+v9n9Locwp/o8bUolL9BZ7sNIOCn5nbHMBXJjWgxAx6aEKRCHB+nZNiWIzrzifZkaB7AKftHj132OuzWr5LPNIFkVaPhwK50ZVVSCdacEngJrGpCKscDKG3FEqsb1DNDCRqU/WGS5TBmjnMFKtZzckQs9+4o4OjixbdZ/0wDPPkRKzWVpy6bVClxSe3bCn8tUsU3XPHfUmCxfi4bTIe73yxfPX3husKAhIWyC2AB4fVv3yAy7ENuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01oGtQtFOQgpzaiCjg5eh8TFHCY30LI86etE6L9gQYg=;
 b=APeVE6/kskou0HDRyBaIwLG8YZSYiZTokp+QDF4uYWPfHd/NnIZbN4aglzkzbNj+ShAeumTi1C4WnIVyymzPIL2tDfS9qxb+U42enArPUe2N70TJL54R8vwCvNPxtlTN9b7YssBQFdX2exylgpOZ+ZoOj+PVaNSLR2iOvO7k/XvhrC0qKZRegb90K3nHlzpRB46gXksifJgJn7Nmtruut+niOuD/uWYErO5/TVO++XtTFSVj0rLoitcKor1tGW9hTlQ1p0Jokdk9y67QkbYhkfLN9BRDjtgFcxrLT+9aJQOQNFiWAGCNR6YaW5GeybzJGJ7ejlNxOLqoYehltqxh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 BY1PR11MB8054.namprd11.prod.outlook.com (2603:10b6:a03:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 14:21:25 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 14:21:25 +0000
Date: Wed, 1 Jul 2026 16:20:58 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
CC: <skalluru@marvell.com>, <manishc@marvell.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <horms@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] bnx2x: fix null pointer dereference in
 bnx2x_free_mem_bp()
Message-ID: <akUiSulQJ76q3CWj@boxer>
References: <20260701065030.381836-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701065030.381836-1-nihaal@cse.iitm.ac.in>
X-ClientProxiedBy: VIUP296CA0059.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::16) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|BY1PR11MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b812cf-da81-43d1-34d5-08ded77bfe71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: udCU3uL2L6+RM4HXlZbPjQZfED5NgeGOcHGy6MyGq3aCiKoDQ16hvO+Q20AM0RWOy/OaSn1tvEjCCbDTbTVBSeBA67GwB/2SKdKvIVdHIcoaB8GbkcWIbKeqkIBS2kCUUYy+jgS8edfZnO2a+lDj0t9j4U4EKB0sdwZ7eQKuglG9Jm7TuIiWDMttr5z3Hulc+FJVGbzEJYfn5pdIPYGxDfrF9fgdSX2Lk+Of2fvs/vdpAtg3B7Ft+mEAEex1qwU0+AoAcbDCZcTS/8oyBi2+do4OPX2iDZzNy1elfO4r0rjaYNrj3cxlIAPo+bOYIGOZDl9Fn2FjH90g3MAo3Z4zDPzO5vEdsmJAZOYaApW+sjUUcKUZAlPFl2EwZBuouFDV0MDWq0KS4jaGYyOoSY+u6k1DkB0D0yGAVQtjT4GYanGrPzEA10S08XxXPA8IPyxLD2UU9jdjmSy23+/wAIq+KM9pq7L0NhuwHcuza5WwBIwgajv9nZAoNNVvM1IHa4QB6pAZGkSmPu9eCn5lLgQeso+PuxnwQrq3MlG66rR/2zTJS+dE41pWZBSZQ9gIBwR7Y55BbE819wrGn51zLukvdOysEpw4XIIIOPKYEQubm/uR/MczJrz0zpYV7Gyyy3/o66YAHYdKeRHNMtZO2u6MkRaIqIGEtPv0s3JoceT+Qzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uHV8WrJuxVKgnqRdqigkAOE+qk0+AArXCzZeXhWFg+7pwNbHlDxdlQj9+E9K?=
 =?us-ascii?Q?mX+FoVQ1DFaPuY8Hzo8D8TQ1aswomfKw1dMwRlIXGeQ1v2x8Wk0/9bF0n10o?=
 =?us-ascii?Q?N8Zi3NHWNN9o5+N+J9PCUFGeYpUlZ/zMlgTVJ9fdB4XG5hYcklKpLwjZwETT?=
 =?us-ascii?Q?ez/ew+emeFgaeg/OC1Gguop160dw4uY1L8pmwBM21AnQE7DMjhzOKNUvy+XI?=
 =?us-ascii?Q?3O+lVkjprXaVZ9Jmhju/1hC6Qm/SWXRp6ok1126JnfDkRI5lkLgnhaPxfXSK?=
 =?us-ascii?Q?8i4wLfpqjBvy8OVKCTpBaQsztLdFa3lbnYI6fIvP+gfsFvAlOdLWrzn6EdER?=
 =?us-ascii?Q?FlmrEpkjYiMXAj8buyukX+QiC3r7H8f1PQQZKW1VtWeZB2k0KN6wiDuLQvCj?=
 =?us-ascii?Q?IjwJOVs8dBKGbEpwvjLscrNw3PlnUcgazFhrYHHCIkh96KgS9FzAFafLVtcX?=
 =?us-ascii?Q?ty9yv+rgXAgPilHVLbWWHLECSvbMj69tgU1fXCQ8XIGWl38tE7hC4WHE5VVL?=
 =?us-ascii?Q?5nl2arQfk04nOTH0OdJBjrynWFYD7EOeMBMRqiFwNyXcI6vL1nLqLw5iuriS?=
 =?us-ascii?Q?d5JJeyTwXgZxOAcBLhaXkJwIAhs1jxY7sxr5jI1N9SVtTsO8TdHxC7r4THrH?=
 =?us-ascii?Q?suM6anrq1sd4iOer90CPTuLOmfvnYHCgEpNwXThjfpHmcp90I9Mfg3F5EW4k?=
 =?us-ascii?Q?inqnrFQ6sLhERXBx8jXMRvNI7O/5FQfJqlGCrjcU8aqyDFUpg5i3SsErcNBe?=
 =?us-ascii?Q?T+TbrF55jKZuhsq6kY7nAodo3c00VRoA81PmSsNAgnAl6HIDt/y6kwyMUdNj?=
 =?us-ascii?Q?F575FNyiywpDQVqDSrgWRtPEktL5v70Ed7fGO36Y4EgaD9lWNr3A+/lbB1ng?=
 =?us-ascii?Q?AO1Lrg+xjcJmvBugFzZEqx7OKCOo5P1+wK9hsdAmdAYCcWPsk4vVF/xBJhKx?=
 =?us-ascii?Q?9obK56tbIzqSfHjTF6IOEIqlxMQXs/i/NqkM4y95YVp+BAOmPQtuh2A0ADIM?=
 =?us-ascii?Q?qq0fATk4+D52CG/khVlQFgqMBAzDRdBwbUMCRwFEdGt8xKspyZGnmIa1qA5T?=
 =?us-ascii?Q?Dr6N7S+71rMZb/lVTwrb56UJdCJ1Pa+UW5z46VAd7PDZJDjBb0W6gYSN4vWk?=
 =?us-ascii?Q?zg9q3tTZz8bIScqelxFgq3MqhMvmIbzmwBLfFKiBYVexBNrNmYCnPmavNx+l?=
 =?us-ascii?Q?oUD3QNjDx9ERCAyRKPU2iT0LFQudvEZP8EescS6hAge8fSV9MswovBVlb3jP?=
 =?us-ascii?Q?dpikKLFLy2MMmowR4+Vs4yPBtY3sCB0GhEk3aCEVHZEGxkv9DoXfDuk6SpEf?=
 =?us-ascii?Q?t/d+WVkplxRX3SvOKFRpl1211sXYL90D5wjp798r2VZa+KTsESKKibGmHFrt?=
 =?us-ascii?Q?oHGF9t3MRkmoMe9+YYgNWHrMD2T+3NaBFwPE8knsCDVOXDJHAXHuGX6Ntx9K?=
 =?us-ascii?Q?R453aJJ//7X5kBmTt4DZkv6raGwpMXmfGcGZ26C9q/ISeDBLFfxiyR/PxqKP?=
 =?us-ascii?Q?wxlP63hQNLKhv+6yO+TMhxOSGTzrKlXFEg7ZLjUAK1BFCnU7xa3oEHolE+wK?=
 =?us-ascii?Q?37cnyuEAEvdC+rPeDK31oA9dBKJ9R+a0YopxpFG+RNf7onN2+UMOQXb+936r?=
 =?us-ascii?Q?eF7J2P46qnISIMw9XOferZHes789BTh73ay5AeOt+kj6ham73fdaIZwf6kPu?=
 =?us-ascii?Q?a3hTVEtTLXeArNuftvDRabzQ3dHdkCBiUpXaE1432lnRlAih9hHAsXAziJLq?=
 =?us-ascii?Q?crYDUEMapRswpsD/Mr0L1SdzAqDZbIY=3D?=
X-Exchange-RoutingPolicyChecked: sOLV7id03Ib0TUvUEIXaoX4gPnQkZmKzsQ4NShe5VPz61yTE31tJsnadF3QRereNWBTiqDRPPpaB/5I05hf/kTNY+j3S4yxzgeo/48JsxYvucS/TiWuQcaDlMHrZtNax02uxrON7Ebo6nJ/BKBs1NEZruVIUEqu2m93YuRMgCN/zcuVKMRn8V/mU2RvUOdgaAa63uYsElaw2aEdxSKFQVrA3QTBI1XJE3MKcpi1YrJu8fsLQfEyh7X7ARuGXHMJ8SAWnd7GuPmwNl7RUmy653au86L2Anz5PqIz5RzXfNqNI/Jilvz2oKrYyLaQHat0tQcruedjEnXLXXWMHO9tQ4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b812cf-da81-43d1-34d5-08ded77bfe71
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 14:21:25.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rn5G/7rYKRQEuXnwHAvvYd+m+jEWLsgdUA6LHMshUKTW3RG3XKtCBI3nYdbqod0oImoF38bXPz3RaJYsFu5ByppbNDRdh+uB+rutKYEbEzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8054
X-OriginatorOrg: intel.com

On Wed, Jul 01, 2026 at 12:20:26PM +0530, Abdun Nihaal wrote:
> In one of the error path in bnx2x_alloc_mem_bp(), bnx2x_free_mem_bp()
> may be called with bp->fp uninitialized. And so, there could be a null
> pointer dereference in bnx2x_free_mem_bp(). Fix that by adding a null
> check before the only dereference of bp->fp in the function.
> 
> The issue was reported by Sashiko AI review.
> 
> Fixes: c3146eb676e7 ("bnx2x: Correct memory preparation and release")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only.
> Thanks to Simon Horman for pointing out the Sashiko review.

Should we include Reported-by tag given to Sashiko? I did that in my last
changes, I guess it would be good to track the amount of things fixed that
originated from Sashiko review.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> index 5b2640bd31c3..25ee45cb7f3f 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> @@ -4712,8 +4712,9 @@ void bnx2x_free_mem_bp(struct bnx2x *bp)
>  {
>  	int i;
>  
> -	for (i = 0; i < bp->fp_array_size; i++)
> -		kfree(bp->fp[i].tpa_info);
> +	if (bp->fp)
> +		for (i = 0; i < bp->fp_array_size; i++)
> +			kfree(bp->fp[i].tpa_info);
>  	kfree(bp->fp);
>  	kfree(bp->sp_objs);
>  	kfree(bp->fp_stats);
> -- 
> 2.43.0
> 
> 
