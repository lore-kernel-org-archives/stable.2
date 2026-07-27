Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97A3C3F70;
	Mon, 27 Jul 2026 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179237; cv=fail; b=vCR/Lrc0FBE0uAEox+QQGpIEeFq3dFxQexDCTqjUUW0kfsWcovtAFkbxxvMk25pEetTfNYgkHm5Wp/hJUoYVMu9euPU0x8afpQKy9MP09dI0Rk2aiaaz9chcPTs8UdINsplSqy3yxfBGwBPBy7oETDIfoj6Mcy1/L3D6kpVoYcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179237; c=relaxed/simple;
	bh=XzfHsDlFDizKY5GiPtrbRueZloTTlKD0sljouej+wNc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aPGubZ2As/mYF2SIruZ9aEnD0zzVM+6e9EsfuxkKhtCKezo9VP/WxVIYeW4CyLbLwq3pAQULSja9qxKCvgkkj2y768spp9OI0wdeQOK+c6cdwWj9AcZ8QG/qkvzbaFP5KtgtUthQuGbigOakoWW3pfllf7psorQv8uG/F9hV4ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDF17CoP; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDF17CoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785179236; x=1816715236;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XzfHsDlFDizKY5GiPtrbRueZloTTlKD0sljouej+wNc=;
  b=YDF17CoPYpmu8/npr74wTW2l260yN8/LALRFlVQ0gsQbUkMP9reDY17W
   MHjUodl1xqpwpK6TMXqHZEnn8cEbbpgF/Ygd0bCkMhGcQNcqiXaAMVOCT
   Z3ay9Eax6cGiIYMNv+5T4KzYEru4EQaL2CcFcASpLzVPqwjbVcwOaTguQ
   IUrk/xqhUf7ClfwEzDkSH08hiJiKaUPk+t5GdJv6n15NeSnUqm2aKsLdD
   pSUhle5RaUlBX30bDGFG6i0dOogPPI4Y6RALOY6+0AEfes4HCE9UKGXdL
   /J2vQMjTHrpz8RR1LxIBjJZqZZsJ9VmIhvuul5XO1NuFvlUyvcyk0ajx2
   w==;
X-CSE-ConnectionGUID: OBbagKUYSAKhDSBwV0RHsw==
X-CSE-MsgGUID: C00hNFMJT9ip6SOmwNLQBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85606176"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85606176"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:07:15 -0700
X-CSE-ConnectionGUID: VMZ5H7kLSAe6LP5XSSwbYg==
X-CSE-MsgGUID: 4cgwGvgNRw6JRIQnT339bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="263799009"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:07:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 12:07:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 12:07:14 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 12:07:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzYGjQ8wqB8vVHoNyv0ggMMxB4v2o4dVb7CLjEUu1o/YjIYZLIobdSU87P2vVk5yGEkRGkizj8KRi04ojPmXEgpJntOSbXNg/W/5NpRDGl+K7hqw20gOP9jNw8hCz3a8NL/uMeIjdI55RcaUCnMLaWgoZdjg1ekSyY134Bj/0zYcSlWqTbo111S0vTfomWYwapmZojlWUEw1qR2t/nb8kqXHNjLBa0818P052uDGp2v5LT7PiE4qSdHAaGmtsF8yKyJsLdbzUulys4vDd+/UIkMxgSxQXS3LXRAEBj2Vv6QpiwyvbNIwzz+jnvTrDCdrMpCi1E9/e8tdA0xgJOfS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xOrPbXDz/2LNiC/hLj5oP1RuYAlWs2WvcW1ZgmDdSY=;
 b=ypAWjEpo2EH9X/EKoF46wEb0K3mLt5MekHmkw7OB+1B6SgVtKgHSQxCXtMvU9f/72ieaFAX15Df2EAorF55Q0crAvKK8ZhKXRZ47ZvHFg+tKLwIfNlYaE5XR54nZhw9fA8QE+KqpCKAidTKysISCADhJDgEG634dZPs1eWh05F/LmvgA8wUURJvUndo92im7+1lPSKvfSNxkcm/stV7QTsxgsYaW+zBXmCNJjug1Kd5hJBf10ZRHSa2+5icPQZb0VzOcDPVlYYqMEi7uOOOIbAKhpg7bmJ9OC2SpceCV++rL1Y+IXrOSU4jZHiFGllJ7evnR57Kq42+F7EVI4sa9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:07:10 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 19:07:09 +0000
Date: Mon, 27 Jul 2026 21:06:58 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <stable@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <lorenzo@kernel.org>,
	<toke@redhat.com>, <matt@readmodwrite.com>
Subject: Re: [PATCH net 1/2] net: fix skb length accounting after generic XDP
 frag adjustment
Message-ID: <amesUgTjM+4WvTkJ@boxer>
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-2-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260727032535.13469-2-sun.jian.kdev@gmail.com>
X-ClientProxiedBy: DU2PR04CA0172.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::27) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb033e0-1f05-4f27-ebc4-08deec124222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|56012099006|10067099003|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7DbOSA6PQqNvKcKPScz9c/hNN2SIha6hZydkw5R5w9S1swc5/iVnrC0O5GNNb/zMSIiVfN+gubUQN65ss6prfIg7IF+OdVt9fc8wHeawzbmUh9Cenvm7Q34bxTI8N3wYMrXjIynKGzycd8JbNDXodsLQCanummJDaP9WtSXbzEF9uhBiPnBWD9aw8Owa/dV7Xbm+kVdD1JCtkvq4lUoegJN0pxrqgJwblACJgGo2byTeIXUeg6X5hoqgR7DNJSZDL/H4pCQLGFYNQ+2h9OHGbdm4DMYRtAmBAx0mtMJX5UzTVB3NSgjua0VcFxwFWaN1f2UHVG+n5WDykWtw0ZV3lSVdF72LjC1Dedn8TyTFZGZvU9OpMxH1bJxs1UCcdHrTJ1Vp17Z0eZevvBuJwZiBGX2ynedA274+UxFE5fYyZDkYkqkw8R3220r5vwdUnKR1MGnkAeIdKbQJFqhBJikOOhIOkHOiITieHwtw3EeMppFaevJXvYS3QJ8UpQuC3LDHl7vBLEaqE194z16GpdDaKDozeRmWuk7lOKPlXM65kLNWPOwKJKG8Nln/b6D/L4VKbXH4mu+ueNXFrcdfx4qF/ZR0U1jI0rv1Pn3zppbPRCfvrOZu1R6l0F7p61xrpFpU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gt3bu/iQgmktt2e5qFYxuWFLNnDAQmteEf9r1+PrQkGXsBTrFhTLCQVZuUs7?=
 =?us-ascii?Q?ItY24hIT4M4Pa4ScRWEeLJPRa5dI0Z51ISW1xfOGFy40h2pVsjBoaWktQU6b?=
 =?us-ascii?Q?CI8eW8M2by1O1royMMZNBwUXkhAFvMh8BNgcPes30ln+T/cLiD5Bp4lIASnM?=
 =?us-ascii?Q?YFvLk2/nFoMu9NpKalThHNIN4z3I8u+TgU3o9QpQI8Wqb5a5PxgEXaCUl1NJ?=
 =?us-ascii?Q?jHdVWcVaBQ8yVxn9vueXByjlUJMyR8Bs282g7RY3cWTsTOSEJUrtERpFSl4v?=
 =?us-ascii?Q?6I0L/NqDhwp047nB/xPEl7qaG10NKB70RPdyEZFmxKA0RU69eM9zSIAsK7N/?=
 =?us-ascii?Q?qzOoM2oexZWyhYm1Ub4ioQWoFvvo03YOXQtOBtmyKDqVXz5aiL6t2p45H2Pt?=
 =?us-ascii?Q?zpHhhZuQvsXk8ZjDqZPXSp9W3hLxkNremex5Y/KzYsNU42e2wdpc8BLAXEuS?=
 =?us-ascii?Q?KrKjaDFHYLS7luvI3h8UdC4UHo4ysNYdbnykNt3xvqt3VZ1bdVQSBWgbabJQ?=
 =?us-ascii?Q?dak8Ulm6hY/UbRwjT85csuQlTYk4CSL7cogH3vREqmj8Ldq9xM8FgPTfgCm0?=
 =?us-ascii?Q?yDCkazpAZuty3FJ9unnt/pz/f4ig3ul59VsVb7Jr7edFV2CSqDaMkPm0Y4M/?=
 =?us-ascii?Q?2iLYk+j8+lV/9T+NfWkq1sCmLrjyQXMXMTmXeGLZEaz/JaSAdFN5+PnP9Qcv?=
 =?us-ascii?Q?Tpj0VLKOP4Ai4tZmHGN8vev7esmahslvu2U9+YAPNzvFENu/t6YLhXhJ1PVe?=
 =?us-ascii?Q?PvjiOQiXvVUBlks9S8ZlUlfcjmBYgnrmeqPz3gwl6DcnPolws0ZxcpAHUBl/?=
 =?us-ascii?Q?ld/RQ6IjLvYsvvSawEDbSyZask92OvIpHtbJGAKhXn0cH/r5fdqwMuLwRNkQ?=
 =?us-ascii?Q?UGB35TXLw2s5rebJhb+W0IirK/vxXfRDRGOu1g7l0FzuB5v9ob73IhduufkN?=
 =?us-ascii?Q?I5KW5J87XaHjTwo6YppeSjUSOh7BX2nxiN0iEe2zuFkniMymDLivuneEVBO5?=
 =?us-ascii?Q?tSsxoRo6YyhgvF4MCfz5QfTPEtZzbVZ3ZuKQRnvGVbgd2AfZm5JnEbRVECDy?=
 =?us-ascii?Q?8doHjhxFionQHbTgQJ9bUFWBdea5Jv+oPtwYC2ie9Woj2tRPKA73DqL+YggO?=
 =?us-ascii?Q?aFQQT6NH++dfje2sotz01Q541Xi/6XS0I5pcgqDfdt/1mDy/K/rRc2y/GOvX?=
 =?us-ascii?Q?8t8oIpjEmMQR0KEcp+/VQPXCLZ22LMWNBOtlgcs84t0UbWLlTW+yWwEGVtsj?=
 =?us-ascii?Q?UkOU9zPUJkloky08G4MtAX+SgKKRX3zBl17tWL8++r+ssKTw+pbhnU3wSru8?=
 =?us-ascii?Q?P3wKPO3wmBz88DMFYA9rIKCga756GymzJo5tQF8aJS3TfstRqyN5baz31K6o?=
 =?us-ascii?Q?+W8k7z0mWt7YQRKPU8RsmXCKIMmwiPr94dFCUFDm0NvH6/0zas4F/Q4rauDM?=
 =?us-ascii?Q?CrMzSEPA0x5vggs5bV6jPmTEfKPTP8rp/WW6iWvCQ10ICvO2+pV+suAhCSgD?=
 =?us-ascii?Q?bdiQQNHJhEZ84orKl11XhZfxm8F53RSyxmixIkRX7UVNA/KB/rzLXDD7/e49?=
 =?us-ascii?Q?/ej4uoDIIvmoG7aLbANI0SLbLtZLAWlrkC7OR3AWw3ybmg+LK1tlr2h+XLCI?=
 =?us-ascii?Q?h7Dzl/0Q2i71epRy7TiPQvgbxxRGlHQuQj/klo2mhMCBjGJRU1ewg2alPsVc?=
 =?us-ascii?Q?O6kHlF3FrOtjBEQMLnCECE/QQKMJ9+HT6fZjwsUoPbkTvFo6Bnk2zIbIn+bO?=
 =?us-ascii?Q?/mtFzTXnU/9HGGiIOnLYjD5hqBObRsc=3D?=
X-Exchange-RoutingPolicyChecked: ankzg6b7uFouSKJrKCnM3s+SxzeQay8rmhN01dUU02bA1bH/za+NvSABgK6N/PrkGAAb8N3Z1iq+PABMYxflqoSjSoOEBCBxxCMmMCF6VDbkKs2W5mRAJU4ZEARUmU3ISeSo3MGwPNVVCgNFgPb6c58HDkyMP+lJ25AXhTkoxb+iaiZtITeBjNWNwtUcHgZiQKue8uiYoECwBoannsUM1FZPwIasFs1+AFhyWS6w9XZEmYcfXV2s0rzHiVG5q3mqUCI5/COeI3c4/q9qLE+KLcL+tiXy7Te4QjtWVITK6azGLEuCHNi06efhvznUKp65S3EH2bKQV9Lx7n3IcZgRhQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb033e0-1f05-4f27-ebc4-08deec124222
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:07:09.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1teHp0Z7A5PFGXHFrpCm+HvBcXhPrNIsKpzGxS8b6uEBMmuNQLdqPXS5+/kDLqujf7owzrSkd44P+UJIrzfHDPDDG+bPLZY6mzLu//kAKDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com

On Sun, Jul 26, 2026 at 08:25:34PM -0700, Sun Jian wrote:
> Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
> XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copies
> xdp_frags_size back to skb->data_len but leaves skb->len containing the
> old fragment contribution.
> 
> After a fragment shrink, this makes skb_headlen() larger than the actual
> linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> copied 1024 bytes past the actual linear tail to userspace, starting at
> struct skb_shared_info. The copied bytes included the affected skb's
> nr_frags, xdp_frags_size and a kernel pointer from
> skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> amount and truncated at the end.
> 
> Subtract the old data_len before replacing it and add the new data_len
> afterwards, keeping skb->len and skb->data_len synchronized.
> 
> A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
> 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> corrupted payloads. After the fix, all 10 runs matched the expected
> payload exactly.
> 
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.org
> Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  net/core/dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5933c5dab09e..94204702cb02 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5517,12 +5517,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	}
>  
>  	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
>  	 */
> +	skb->len -= skb->data_len;
>  	if (xdp_buff_has_frags(xdp))
>  		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
>  	else
>  		skb->data_len = 0;
> +	skb->len += skb->data_len;

hm that reads a bit weird to me. maybe we could follow the existing
semantics and reuse @off ? that would be a nicer way to update ::len only
by a delta.

if we would stick with existing approach i would appreciate comment being
more elaborative, where we could explain that it is simpler to wipe out
data_len altogether from len and then just add it back.

>  
>  	/* check if XDP changed eth hdr such SKB needs update */
>  	eth = (struct ethhdr *)xdp->data;
> -- 
> 2.43.0
> 
