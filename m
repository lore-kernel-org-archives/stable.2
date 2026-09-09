Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E83822A6;
	Wed,  9 Sep 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942029; cv=fail; b=aTBJjY34l9UmcDyOAFRZOUmsKlPjI1XS46ZuzHFh3fIGBJlBs0F8OmKyRrLmY8Hf1G9qE/K1gXNjanmWKKMpsBUC5qagDTYwMQI18ourGsF1smKxI15nYU7cSLy9tBmL5tr6wWRiHlO0Yxzln4BBmEoy8x8/xrnC9PabQW3FFMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942029; c=relaxed/simple;
	bh=NIAx4Ahbrm5Ar4c9LtId/kiYPvDt1ttg9Z/hNHog7EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AzONAZdCXW3mBh22bM8+SWvWjW8PxtB9ud0q2LcnEw4WcmnlC40i+HV8a88hoj9UOsUx+69fy+8yin5QhvxChNUOsdkU9zntq7QfHlkZOAIb2jKr2wPNeYnqfj3WkhJ7G3pYKUU4w682rEXBKkNfd024g+WEag2yeQCgrC0vYF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S7Z3BZT5; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S7Z3BZT5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0OYGqDy+XpgRvFqcxbaHTvMEsOpyPMh64fCOcL48NLNTNFLkXBIX10k3Y4EHW0E0vPPPovUK6lHenNLGeke3upyxXNqCCF7YXqnY3c9TmGiLwpgdP2MLWOiblTCD9myYndKx6y0mYp4LOD8b3LxjWuc0zZUrwBW9KZG8rmZzd5LhjWVZzRK6Q/C3/4qfu3vYcalgyvb88pMvcJs68/K+fb/PNoi+TOXPi7EUqA1TpZj63X0KiVbD73HvSf6v7dv9QO4D+P/nq6btuZEDvCwbGjjINFIBIN5ym7YDVzGVTFwAcf7yWtliC6Y0fKSdrzUJEVUyK/tr7r3DinbiCpPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvTr2lZC9aNuQfWSMu3rHXhCR/dxLQtXb+YUK80WKq0=;
 b=DKUKVs6GM49uEB6QTt4AYMfmiYgGkHkGToBoCOC/7bHDjF/TTCASQfhZdo6EppY+ZMFEiJ2pRNKTiPH2+0A7h8dbgpoXD+lwINgJfLeoOqCK8VSTHouCZodLaE/oEd/p+k0y03PqeJyv0PP7dfyrFWAJKVVGAemjRv/3lHf3oFIKaysI4gFqbfyQ9Vt3UkYWrIMvQjYmCrvKsOqIc/WJV/Izcxurw+xiVTaTa+203B37Zm+OIZIXn7nSmD36GonhcK1cUpYKnuxyVJJPGIe4DerGsM+Q6MMdv9oDG+IGE9Aps9PgyY6johrVuwPo+FhdU890iG8rKqBMUclylFf5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvTr2lZC9aNuQfWSMu3rHXhCR/dxLQtXb+YUK80WKq0=;
 b=S7Z3BZT50johzzKgTQLX0zjcbN/S9fu5yJj5ltS1FDRqVfMbHXTOFNJWby0mvFM/CnSDu3H7LjXLVibuRZJdJaPub6NI2YAK9eCc0udrVKy8X5gxtu7WVmXkAw/jVZzLmXTSeT9vWiRoateR45vdR3qJyy9caPGs9cPEJFqt+T98gi6Cih8UUrRI2AKjlKd1RqN0NLXi2A31BgrYLH4Cv4pytAej4uuJnrXQuMoRIuDBTpIh2iIZYpoTDWlm9XtCFvVj0Xotcar5LA8A1+3yA6A826+uECjPfCHcamTp4tk3Qcfkoubbp0LKq6qzgQDWx+jTbZxTjYjL2vgU9LZ3xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 9 Sep
 2026 08:20:25 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 08:20:19 +0000
Date: Wed, 9 Sep 2026 11:20:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vega <vega@nebusec.ai>, Luxing Yin <root@tr0jan.top>
Subject: Re: [PATCH net 1/1] ipv6: fix fib6 walker UAF on seq stop
Message-ID: <20260909082008.GA1258831@shredder>
References: <cover.1788837093.git.zihanx@nebusec.ai>
 <89699735763f6c297584d7c2ff106239cc1e8ce0.1788837093.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89699735763f6c297584d7c2ff106239cc1e8ce0.1788837093.git.zihanx@nebusec.ai>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 45718e45-c1c4-4d34-b712-08df0e4b2f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|10067099003|4143699003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6DpaEydaZsDETHHjoAcd1SMi4Qg09l77zSsjUK6kLdQ3NJQSmgBoiW2GIPAUAT6md7ZCAM/mwOc2gIw5fRrxcIWey+2y12IifvkNnAkmzd7ppjftopRwqD2Wm9BZibQ/s9YIDQT9WQMwXbdG8UC1RMDlDK9r8vQ50BZkFCYcN5cpvgiI7w2Xjn1ypovqtSpAWE7nyMjjuV+AL59S1zfZlAleY7wMHSMm0BCic/weIIqDmuqS0nia7lIf242sifMki+XNl0Mk0LQiAtbeW1ju2DLeafVpNJRe0Ru1DZuNwLJdljdPnsuQRBvS6WN0lO2AMDLwyGICPWiwJ/pwsnc0RTLEglVCFr8eXy+/JZKkc04StTfx1jlfTXB8OoDuQk+6AarcUD0XX/fSAIPh+8YC/m57TyRsITTX+dmtTsGasXBGBkgwSw2GadOxJ4qwBmdxBfyTCFkgWnwfnU4crEIevcTrhIKBnhrZooGaZPabCev5mRK74EK++hSnQ0mtbk3zNawFR1EtD1gdrCMvOtP2hRg4L6hEKPNohiKYswP2n60/ozA9epiKLlp5zNVlqS+DUaFA/7HQoFohgR5H5j4Spg/j9HLCas0UvyMq+cHZ8DuC3MsDHStQoKRGVABUIHfAleVsfF/v8yc/C5fViHVuHXp1fOKUZgghypAl1bJRKOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DU9IcuhOizJ6YIKbEo1e4im+1n+P5KxcOGkhaD00A2XOuHaWgjvn8s0R6kJ9?=
 =?us-ascii?Q?CTqg8+7kFN3rMaGI7uFNPDp8GGrVqS79a06vx/NSkGHgcES62IwWaeseMlLh?=
 =?us-ascii?Q?vmay0kV/3aWA+5+IzjWrLj4rFK89HUxnmmNKhWi817y+M/KHu/yiaEUulvSB?=
 =?us-ascii?Q?OIWiMwxCkThyhko9SBsoMXgyvPsy+PyuI3c5GLMtRRRTKPKrEFa1hpEH7ZDQ?=
 =?us-ascii?Q?paiLE8ZMGUoQoyL1STlKxLKtJKrdOPLLBtDoLEB9oMUq+VASUaIDGocCr5BE?=
 =?us-ascii?Q?mvbULAkkXvMqnaiB22ozagPw17FWVgQOtjBVyYPCZOxCSWmpcg0OVuHsmFCq?=
 =?us-ascii?Q?PlaY+0gjVicBVyV1nqfFlHXKpR7NSW2MRfE1lWrEFcOX94UzzkltGoTl7A5y?=
 =?us-ascii?Q?D5aqXQISdHPIyLOJti+9OqRg+Ipii1dRKEq+FA+5ZNslqAyGEAQM/59cIhIm?=
 =?us-ascii?Q?6Lb+OqnUa9F70ZFael5WS2R2SVwme/t9raLkU8jfVsKhnm80K0zqEgJ+PSk0?=
 =?us-ascii?Q?ZLb95Awge6puFcfqvqqLc8mbOzc5Xth+mY61O+avDPQ8TCDqtvIEEO3DMltq?=
 =?us-ascii?Q?tAsxaM3+9P7fmzwUlKkUVhgzQHqyb6r/FjHPsP3QDVy36tE6ElipIL5sWYKH?=
 =?us-ascii?Q?41WbHLmo0q4dk1EQzE0EfqJp7BpllxbQPNH+HwWPdG7DrWaOX5+119+lOPuY?=
 =?us-ascii?Q?mcwwJeKFeILSjdK3kjOKByU2x9RzMQHDunghqQxPkEPGURuaE/7r4l5i3fFt?=
 =?us-ascii?Q?pZq2HHGisgiTyyB1yVeokjEslnxsBT6rHHAjKlMRc9S+HbdLSuRFeqncJwRT?=
 =?us-ascii?Q?S6zSEUf9ByLlodzIaR0WFa9EzBLTC9j+6DjT3JLpMuxmIa0KGu5VarFIh3go?=
 =?us-ascii?Q?aP7bL3NT+wc3WBcKzjxwKNI/+tik2el8XueyhCSquGGyK/66C22t+kCTPhNp?=
 =?us-ascii?Q?5nc15cCn+7IGcOjNeKXlRLgdO3zyHQ9/fEcsP0+LKpsntwFRCZeoF4jFzrp9?=
 =?us-ascii?Q?TL9nLJ02hJYs313lbN4mmUB5hWtPngxi7FL3o13Y3E/TvFnHzUp+sd/hoS6M?=
 =?us-ascii?Q?FFeNQDyFib/XhBbLckRnrCwuZU32tRA3GARJzL72Fsm0Ws9QzJXh22IzPl5P?=
 =?us-ascii?Q?T9GILiL98y7u/A3ExQ86SmZSM5KEx/PDvwXwVuFWVLTcGGcMvwaaECAIZT6t?=
 =?us-ascii?Q?m3ufNyhdrP5rIDOY+KxW49zu1oh7okyBXOoBlgWbsNS1HoIPfmHa8WfHoxUF?=
 =?us-ascii?Q?cI1JNrV9UmlHGPoNSnjBm9npgwrQxrhMZ10qkz1yUIudokLlexKdfgymZtAS?=
 =?us-ascii?Q?RlR3+lz92lbPkEADOtQFHLOGmU59ONgvCcVGm+LG1PAHRzdtcGmpOV8DBRYH?=
 =?us-ascii?Q?8GdgHumEMLhmk7hXLD8O4sONDak+Z3gDGgOHj+PYgThKgAbvl78bfJiSMStS?=
 =?us-ascii?Q?lqmRHgM/BlpQHyfRO9ygXy3vmKFilEZiADAzu9JadwM+AOOZqe/Jz4g4f3/F?=
 =?us-ascii?Q?Kz0TC26MfnfAyEqd8lewlOJVvXJlGJunsZj/P/1qVZj3k7hGhVNkmViV67Ze?=
 =?us-ascii?Q?uzOdEtQDy+NrPx9e37yBLTsRg8Pru8lC+flN1XAcT/GhmUxLO7PHXlDMUZsA?=
 =?us-ascii?Q?m4vq6K1VjWwkMzXWbPW7Yky/5IBts9AApnSh8CEqUf2ObTucUDu3ElPKVeNl?=
 =?us-ascii?Q?9OFxeK/tqV9jTYYW493A8H8IbjsSuDNza0AlxI/7AwbRX35K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45718e45-c1c4-4d34-b712-08df0e4b2f6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 08:20:19.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcGpv5X7CEi2Lwzwb4wayIn7ylu5y4NI8odgYtLIDQy7NyLBGLtAKMaEDgJYza5sfVD8qy1m5q5vkS6jZVI1Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148

On Tue, Sep 08, 2026 at 07:42:56AM +0000, Zihan Xi wrote:
> ipv6_route_iter_active() treats a walker in FWS_U at the table root as
> already unlinked. fib6_del_route() can move a still-linked walker into
> that same state when the current leaf is the last route at the root,
> so ipv6_route_native_seq_stop() skips fib6_walker_unlink(). The seq
> private object can then be freed while it remains on
> net->ipv6.fib6_walkers. A later route deletion walks the dangling list
> and uses the freed walker.
> 
> Use the list head as membership state and reinitialize it when
> unlinking. Keep the existing w->node check so a never-started iterator
> with a zeroed private object is not treated as linked.
> 
> The same stop helper is used by /proc/net/ipv6_route and by the BPF
> ipv6_route iterator. The BPF show path only widens the race.
> 
> Fixes: 8d2ca1d7b5c3 ("ipv6: avoid high order memory allocations for /proc/net/ipv6_route")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Co-developed-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
