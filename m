Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DCD48C8CB;
	Wed, 29 Jul 2026 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331572; cv=fail; b=M7MQqMHtPOqsKMbGBSS2ui4RyU6vWKNLNRdVbL5fKI5R14EDk1Rg4lSG4ZZSMjb+BE5vPRwYf//oYM5VXQukqzGckWPt2iIVgTU+U6dIK/F3rS/UqB23nWIVUfXqCAFpXxNxuCnkZxsWX+kscLPdXmR5WOVTiKabeDz8YDAaP6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331572; c=relaxed/simple;
	bh=MJ+j3YQnl17oIk0nq2Mm76w89KQ3TkJ3tSlN1fIRCP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qkOg8hbqIu/x4p0b+8E2XStpm/cnXM89Tp6EBWxa4VmDVmywOnRD2prfiTH+3Jb1CHol/A5LMqmbPaISCN+A46XYpdf75Kw9yT58go6GY7FVdY0VARVwPwh5rdmpFhEIVzGbsLB3YyMWhDMhUjxbzwnyWI46ONZiGK65tIDqGoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MYW8uZCJ; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MYW8uZCJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7Rg3nzeeO7VqmDGwwRQcoCxYKSGg8AU+u/QJ3TQJtwoVI0nwJUs7/rrKFrYVQoKCL9Gz45FIaqB8Bc8AOHlWe3QI4ZsxLngJWB1wqy6hUJgvNTQZn+H/ZM/Kg9Ne79hZTF+mR37/VGRGd50dp8ZrDhaL3OUnpRl3u07DhkozQ+z0Z6r3b4D/EZ8YYB6ZEopRaNPAexyCylolqdeAjoFNMrgtjnhVjkRxSkz15ZqU9otuk8Gin3GQnKANojFbt/GJy6L2L4oOk+LlhehSnkV+Ck0nmY5lO+YFNKsp8scRU7Da6I7PFgwevKpoGiJfHIWIn7cU03xWicdqBlHo5a0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4QNYRyd1QIN4g66zx3yplAxuFVLcrGNrFPQujpwaU0=;
 b=sbtPO7NJSfamoIKwzSEt84w4YV4JJxkYZbruCk+S9U7HeKT0ls+YuVDM/zOLJYuUF5qvOhZTDo25hCxLogoutn8YTtbLBvZA1WHTtAcLFgFogGlQGqSF/EnfsAdUJwfLptCV6riGog6I9yaiOGtNubvqMaaMp4d6ExHrMc/aAGUngK43AB4sJ3mb226A62qHORwKP8NfoAdgnTlz9q1B9fAh7tgMDiSNz+NYGWUL/JIPsYr7Q8XrrQtMW7i94aKP3O/dkqT+rZHDRAgyQnXQRxA6TKyIchngGzQGCoVrZr1BQ3UJiEo3DNcgCxobcNwEt3ZRwRXhG1BinnE1Fg7K8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4QNYRyd1QIN4g66zx3yplAxuFVLcrGNrFPQujpwaU0=;
 b=MYW8uZCJhtGK3i4i8AlEoTqOUqHUVYxaFJtSZUseR1CoCS5NyP3qXtAcWPoWnU3ByaVPFCKxrLlzAYxNYCHU5cQYOL2OB2K1zgBTEC18xRdINAZyZ3f3veVZH6aL/oShSbm6RTjt/c1dVQoJxn31o9uEIdBdwbG1JRtzpjN1RrPUAgJJqA7J8u6ZMC9pTV76K8030m5jvmsTfPLoWbyFDtG+5LkKvIepj0snY19lMPv1dEIUivW+HpJlJv3s0JYi6V19oPeJ2jze2ZE0cHwtKX5CEGiHZZbTt0LPRTW6/sNTA/+3qWWNF7u+GTEPLeKmoenweOLpM5WoyRQmWu+K7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 13:26:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 13:26:07 +0000
Date: Wed, 29 Jul 2026 16:25:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuejie Shi <syjcnss@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: fix Route Information option length validation
Message-ID: <20260729132558.GA1397538@shredder>
References: <20260729034806.58923-1-syjcnss@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729034806.58923-1-syjcnss@gmail.com>
X-ClientProxiedBy: FR4P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b4c4ed-869e-4562-c5c4-08deed74f2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fFbvXQXfuZC/2RlHr3+qDfIWoofwRZDBvboMXFE6UQSq4kpSTIIs/yrtt9cmeY7pf/HXpek5V20uEfoa9ouqQBX/xI/kuYh/OTG2vXN4TNgzSG+XzPBZKtfXQLt4gUs9FFNnSx0zUzBzhkp/MdoPtplk68CkEHtzo1Q0l8uBhaVIg6l3kgyGjcbeFd36aFiALl7CNnM1iHipHXcFdipX6rWash0bviDicNYa0FuFnLE9ZugRWk/ZkQo5cSZ02rxO7XLPTB3mAoiRZJymHKAgWMBmhctKVkN8zVJbGUpj3yUp74N5ZOvRcXtZfkahkkZ92zjYb5docdaNFsWmIxboDji3Qke7JdIjoBkJtjPW/3UipBFYiO9VWIcBHa7LWpuzkOBeA3iGGe6OeToLgWit/6vjiDF8kmbXiJQInhXzs8Fsy/ClMN+xZHQZ4uJJ8qTO7TU3bwUNRvTtIw/mgB1YZ3yd4JT7DjDFCEw4w/xARfC5Coz5+x+icdVJayXpPUf4MPmgAcDuW20yuw7qTRsIRcMbenExbtYu5/tvXn8A7MmmVWBwcbQYQO2vVOOJ5LmKXCIBnXbagnXUIF96j0/mbj9jzVHprzpB7nIXGgsjchkf17/6OwsUG/96jgHh++zNQYc9bGcVBZKFrtkITgkNglFmafQNRSHOYtgAnq5mxZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TIZz2+jmHbn5AQQL8N13OROGbs2hhUuiG8TOPZvGQhzjX4JM3GhBx0oTnRU5?=
 =?us-ascii?Q?Q7BQPvFu942UOjUjZR7SpYZkUgNS16LHlqrE9D+9isBQ21OvwwZ6tST+sh7J?=
 =?us-ascii?Q?kIM5Gri6DUVMOBxdBLq9hnroT20o28He4mNIOlJ5wsxLXNBsplLuozr/Py4Y?=
 =?us-ascii?Q?Xs79xFsfgM8id+kUjO5LFynCrtg4A1LNB5UzBz+c9Y4BIc0KrpXsXaWc4TLO?=
 =?us-ascii?Q?PBcVLPBlK8GtYEWDW28T4Gu0rLSSm1MJpeNxi8Hk8LtVtLZhNeCeF6W7dXUZ?=
 =?us-ascii?Q?jxgV+I8A0V80MZxrUf46+26HLDDuOFVc2yj1UowF/Lz9crtBDG8S476Dg583?=
 =?us-ascii?Q?B5PInmd+qTvtLs9/W6TBVUp8umn8UVozvxwc86TU6mCCaqdm245wE7HlUZiU?=
 =?us-ascii?Q?u1wi3wNIrLQkoo1cgsIudopNdJ1TGsChHYGkGm2DgV+mtmMKf6chuLN5jHQK?=
 =?us-ascii?Q?9Y4eu5x23gCZhOnK6H8v+i2y6Cd4LXUMYen3E+1RpGLeYKghVJvZWtdTqKoa?=
 =?us-ascii?Q?iBGtEORTGRWgMmck3R528w4M4CqEa8o9VBcvxZV3Kw039ytY/UB3ozPYWU7G?=
 =?us-ascii?Q?2XiMC19SU+4nYDw9St1KKwweGyASOMbgY8V0asenbamtodgI6+0q8ot7XEZp?=
 =?us-ascii?Q?7TXqByAZQqBiawHUam5DQAcurqExsgcMV5E1GEpQgNmf7FDbjkrgZcKL8NXW?=
 =?us-ascii?Q?O531Gj5c2FYSMvAuwcnOzc6pxjrCvrZHBkkrVPVgXe1OrZAXTsMrtGH7tpJQ?=
 =?us-ascii?Q?5rk0WLpeLl8JA803N9orNAqg0uqT5J23kQ7sf7JXtswuqdmUV3VVIUN9varX?=
 =?us-ascii?Q?dbIAdsN50mVCnl09Djy9oBth7du1WxW7zqRLSzGspI2M2oHED0nug6V6U70j?=
 =?us-ascii?Q?qB+DrjSIfLaob0xLXkuM+Vn9eY+ubct1NasT5u+DZAouyDs3WLDeomLqKZf1?=
 =?us-ascii?Q?4vHkO29HEc2e3RZStV1DZIajsk23VupkwcC7uY2zlV+DxRCWFGJjw6DCyTk5?=
 =?us-ascii?Q?5gun5qqKIEsS/J5wpcAuQOtk1it/NtcxQW10gvsau3wktkmQq9l8FlOf9Qvg?=
 =?us-ascii?Q?Jgp5NF4NhjSt2Y7Usq5aI0l0F/OxJvWntogWC+hBClNP5sZe/sVNvijQNG2w?=
 =?us-ascii?Q?59E0pgVxCOA+G64BnzQLolRUmjCLtDnDsFZqaIFukhqwiEzHXmHv/w2n4YD9?=
 =?us-ascii?Q?Bx+Q4eJpdgyParor2CimCGQ27mSqM+YkOAtxK/dfcd6eA4TTGqPJseZlz3FC?=
 =?us-ascii?Q?sr0TKsKFnrqacz2Ihx1rcxzrbdmVk2ROqgifuR/9UQm3RPsmJXi7wzzfUa0X?=
 =?us-ascii?Q?RDJTYvRGY1BfiKZqGK2WqxnaLsykWGOCC9v2pC6hNjV7rbHMBXDJGdwrXEya?=
 =?us-ascii?Q?ZPSeBM2i3bEtwX29j+3msKPJJBH31gkUuzw5RiCbj6G6yUIfzF3YzJ8uNpAa?=
 =?us-ascii?Q?fOTFrDCzUPJrIepsOiL4IDtr3HTwigPL55KZDVdNBy86rLX8sNLu5hyVmvY1?=
 =?us-ascii?Q?XXEeqDKaw+6Z4Z3aqi56KeNP9xGUX6ifCgBUJNV04vcDaXSqC8LKruW7PfUN?=
 =?us-ascii?Q?qYU6xPgpKFgbCun6C7rbZLfFEj/DUJ0hVYonNCNMW9uYAnh/UAFbSu6CbYpp?=
 =?us-ascii?Q?ioR898zDTdRUZF19P5ZZ4NrFwmlNHKu1mPO+BegER2Sq+ENCwvMHF6qhisYt?=
 =?us-ascii?Q?El9nr/+24YI3d4nToVXO0rmREOnUG51yo7jOZnvNbHPWYlU6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b4c4ed-869e-4562-c5c4-08deed74f2ac
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 13:26:07.8794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqvnzhzxkHUOSkybxEuUw/2tLPqIRlyirfBaDl+P/xZhwTI7Lzk0t/2hf0sYZY3RKJSylWjhep0OUSJ2mXvyvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

On Wed, Jul 29, 2026 at 11:47:19AM +0800, Yuejie Shi wrote:
> rt6_route_rcv() validates the Route Information option (RFC 4191) length
> against the prefix length, but both checks are off by one.
> 
> rinfo->length is the ND option length in units of 8 octets and it
> *includes* the 8-byte option header, so an option carrying N bytes of
> prefix has length == 1 + N/8.  RFC 4191 section 2.3 requires length 3
> when Prefix Length is greater than 64, and 2 or 3 when it is greater
> than 0.  The code accepts length >= 2 and length >= 1 respectively.
> 
> ipv6_addr_prefix() then copies prefix_len/8 bytes out of rinfo->prefix,
> so a Router Advertisement with (prefix_len=128, length=2) or
> (prefix_len=64, length=1) makes the kernel read up to 8 bytes past the
> end of the option.  Those bytes end up in the prefix of the route that
> gets installed, so they are visible to userspace:
> 
>   # RA with a Route Information option (prefix_len=128, length=2)
>   # followed by a source link-layer address option, 01 01 de ad be ef ca fe
>   $ ip -6 route show
>   2001:db8:dead:beef:101:dead:beef:cafe via fe80::1234 dev veth0 proto ra
>                      ^^^^^^^^^^^^^^^^^^ the next option, read out of bounds
> 
> When the Route Information option is the last one in the packet, those
> eight bytes come from the skb tail room instead.
> 
> Reject the option lengths RFC 4191 does not allow.
> 
> Fixes: 70ceb4f53929 ("[IPV6]: ROUTE: Add experimental support for Route Information Option in RA (RFC4191).")
> Cc: stable@vger.kernel.org
> 

Unnecessary blank line

> Signed-off-by: Yuejie Shi <syjcnss@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
