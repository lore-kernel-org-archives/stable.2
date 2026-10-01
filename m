Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC883E3160;
	Thu,  1 Oct 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869610; cv=fail; b=OfnjneqCl2ObQiuW/cv4nfxDD6gLwiJRrz3m6BiYtMid5rn1PfKn+yJYcp8t28xfjbU1SyNtXtelIqH2NFb0vZcPuIVRMIyUgYV//KYi0nTL2swUMQQBuS3Q4WQXVvno5LUTgXIa60qplULKKfOHrhXj+AOKY9uXzMy90pQzXAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869610; c=relaxed/simple;
	bh=fyIVbscrC7qR9sKCjxFCz4RHDjyDMSDD4I33v3lm6WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m59bzya/KfGYBj4gggoviwNmo3aBh/UQSc+rlcRJDMU2wu3G5RoywWkoyADjVy5tS0/2SBgFxX3HkjYCkcM2uPRaGnlXKggKB5MySd0fS8NQtY2V5bV3ZHMOkYFoeSKEcF13Y/VF2yXqC5vIxbEOX6EOvJzbq0MpSDS1Tum89fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VYcyois8; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VYcyois8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fivApsa3IJ8DHNmwvLV045RFl6QhzUAOfy1CYXOb8bB1iwfB8G5XgcpgZTzvgr4LJwRdQ2vaFTSIHhbAa5wJUapYItagfpRqJvyWlp424HCtgrsimFExBRsC1tT8P5R3lZc1wc6SmRG1v8BiNjtlqyDvpnU4K+PQenwcaJYMDaIIVGZucjjXGL2CjlIZWfyP14EGtn8HnYxolBxwjWTRJmyclW0jRgB98+PflGibHf1Vj1C9qBexUUYCihnPybMB+07XS+6ONfUh17/KdzEXKaMVea/1rC1C0SnHm1veBXreBP6P7Y6O//BaBqPZe4/HfJ4FHZms6SRbZYKUa0EaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZE2PUNFRVyzaApTwpbnfW+XFZNcFULKxCjLJAFboDA=;
 b=savlGAyVjD0l4RVyoK27i477fR1dUWF4HRqcv524bMsoFCRNsYmM5MoAWCcLli4d8Qjzau92j0PdONWCbwBohO6TvFQFkc81OUDM43sXAymIA7JPJxX5jM/0hiK9+O1yjI2t+cvBWrXPkMuUqSc44ccYc/joxhkQaPcKmgXZ6IRNJmRo10GS9F/JupLox7iholJoltnNmHwVMbsNhlfgRyY1TE2dseyAHu4hEM85ZKEMVNNeJbYG9Up3g6LM+QNdnwo7nxUsBQ1ah9I+5syWoprawTqwSk6r+tjaiIQC2gyVMi0UEIHxZvG9nA88OlWfS/Nly2w4EMtjwX5LVcoYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZE2PUNFRVyzaApTwpbnfW+XFZNcFULKxCjLJAFboDA=;
 b=VYcyois818mjT3Jzh1iF8MTF6qyh9ul53dd6bsKIoV5Yk7JqEILIxDR19YSNn8TIijZlHk4lBd2j6CWHRZuUcC0LxvhChU05Ypi72OYgLvABfPWTVwXr8tM7sq1umVbSYgq8JmnK++2Y5nNZe7Lqt48XRjcTN9NelIImSja87cEC5oKiqsmzEJcXaEW5Fe5EujdHJ5pKYPam+pwmu+H1vnDexqBwmGE215WZgsxX8aPQ7XPR87TDnO6JmW/JBix60JtC8MUjPzVmqIQ0TR35r30lX4PoEXiLdGdd3bbwlr6w4cMSFejP/d0Dfheh9eMI5d4E2i/ngZ0ssSXka7zUVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 15:46:40 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 15:46:40 +0000
Date: Thu, 1 Oct 2026 18:46:29 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: hengyul@cs.unc.edu
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] ipv6: route: do not validate nexthop of routes
 promoted to reject routes
Message-ID: <20261001154629.GA1611116@shredder>
References: <20260930152229.1453929-1-hengyul@cs.unc.edu>
 <20260930152229.1453929-2-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930152229.1453929-2-hengyul@cs.unc.edu>
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e733a6-8d5c-457f-fee2-08df1fd32f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rISqRmiODy9Ue6S+46LcqRIl86g1L8OFq41TPNo5ZVX4d/4IFASxGmeneNeI7cgGopRhdbS2jdicYZ8Lcb8Hg0PhjKhlVUkzAgo0rGwknBqYUbe2PUyA8OgWKw4e1c11XKZ8/6apYUGuJ01g+zqREM7eOkhLQtsCFi1snXaE0smVUoxbDI9e5E75YR50xwrOtUa5Daflks02huE8ChwHzY/DhD4Z2fgbQtvYlJJRLiTXTsHrrh+NmuU//qtqjBbCXpR2b3yN1dDUJwwahLbJjTxaH6AzcGYqDfimwtH3ZBR/SmufzWQRHBsApq9Kgphnsow4d4Ikjnhv30XxLnhjfMPxHBy0ZWmBKsMLb34y0Jb8b7LQD/jwYWpNrGUlKpYq5Wj3fofJhu4Zqt5LASw62ODq3tC/pmSS4CZGNsjI7LNAxqyU9KSpg7AldQM22c2fxG6EM1KpOdymPaGFgpDhab5BxOLIytwNIzg9oPYhEXDkzTf4rsrDyRxBfokGIXvlJQv3KcN+uV0VP66nTHvljAgJk5n8aYJzlzYKUJsFn8XfCra+uPfqokPGU52cYKuPmwa0+31TarGHfZKpdW/AMnfb9T5ikk57kzE791XtnfCI+NlE4vBxzA7g9eKQwwYwlAi3uqan/P5I1PafooPknpss3aZVgFBJ6d07rur90u0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K20Fil5viMISn9GmWQC4419yK9ERf5m9QF4jrxx6z/svGsC01e012m1WEtUP?=
 =?us-ascii?Q?meqwTkedGjESzgQo3pFSQSKNuzZdW0X3NHSm1IXjCIclO2r1sU3Qn5rVlneq?=
 =?us-ascii?Q?QGkV1mLkPSJH9sLP6Lu3OlxNZ9fQ2PUKRMalqK/95v+oIcPb7Lr7H5hgUl4q?=
 =?us-ascii?Q?UMM9+dAGfYePj479rKmqucYhOzbakKU5PykkSjNj7jssUys3H5xnYgOBd4UF?=
 =?us-ascii?Q?iPTz2KfwlFWeHK8O1CXr8cOaOrswRJmrEyd0zYV14DfPW6136RhyEnuXO1kN?=
 =?us-ascii?Q?kBuRK6zkQMiuXwadcBteu3Y0UjXQDHPk7dbJoTm1i4DTQtlXUhXWnDZ8H7aS?=
 =?us-ascii?Q?lxTntBi+xNhxIMBdnvwONtxwCNj+Ebq5qxgQaSt479PdAtpXgVtXGX6L6L7J?=
 =?us-ascii?Q?npsP2kzbyZgS1DGVPmlvEaFgrnmZPsZh7XXz9f0oen0SwtcmWtk3JFrH9Cra?=
 =?us-ascii?Q?RG6y67aXhnJIB5RqhrxFwi3x6vPflh8big6GVTCpdNcIzJ/4k0tVAElbomEk?=
 =?us-ascii?Q?k1ZSWLOQcebLLe0gvnqrGx+lJi5ZBGAqmTVfTZJpLi3Zd82H+ixATDgN8Xu0?=
 =?us-ascii?Q?gAVfgYyHOAb9OkOc/HZbNY/qAPq9Afr82e7W80MaCWZHRzHM0mGtvAhxo6S0?=
 =?us-ascii?Q?87xoUv8+2jx/fMRgFm3PJGkK/AvHHmIADZQg/gvA13AIR6uFeAs+iilD7a/o?=
 =?us-ascii?Q?L3MZqt36zwtU89+Ee2SSh//IhHz0Vs8uGPca+mllkiygTDKzx02yXlXEzE8W?=
 =?us-ascii?Q?RUlEytVRKsIbwy/VsNAvTD/W1wuqSczVzpJN+K+t+0u7swN5a9FHPeg+YMoP?=
 =?us-ascii?Q?AHrhcRemSawFsu4JJZotGt9uuyxu7xQwVuPwiyaKqTGYMlzQUIdxNzFD+f8r?=
 =?us-ascii?Q?g7uj86IhQaZTfwL49/05FdNucEg91ag/H7wEGa8kJJopgA/YnDtFClmeAxpx?=
 =?us-ascii?Q?4mRnxzwXXmDt5CG/eaDGEIgyX1aayjwdmRnWMgW7OVj6k0wst5AOOkyF0K3+?=
 =?us-ascii?Q?7ss3YvS9z8Ae0nab7uSFrMhjztPVeqR7hby6dcVMPRaoHHpZHl6erVh9fCyK?=
 =?us-ascii?Q?ns9RxFGwk02nyZofTsXptZlcsxRXM/FPqPzlGPEt+FSq2hwrZy5t8W6gpDrU?=
 =?us-ascii?Q?LWEtNoc3PjBrRNMp5yKO12+RXq+04AMTefla/ZF0c0QPqAboVvTi/8IYMQxf?=
 =?us-ascii?Q?7vFKgrxLAWOo7Eb5YJ1ZDVp713u/oMTqv3Jk2uJhWQtT6l4tg3qOz2REU4pG?=
 =?us-ascii?Q?O8DC44NLEHZxOJFO06phm0Gy2bbgRiqdApzGH1KRlNcxdm05yjE9pjwzK2KN?=
 =?us-ascii?Q?OMI09qbudgg+2GB371bi2fkXJKtOH61FZKHErZi/ogb/vjdkK35E3d6tuPWy?=
 =?us-ascii?Q?aeTVgC6RAEI0Av8LUWuvMdG1AWTiZhl7lZ1ls0K6u/rQlfPvJlWtjT02ngcn?=
 =?us-ascii?Q?Kos/lonBjCVF7XjVOfkB08TyfYVxmGWlxGo8b+clkBYcfV25yXktP9MYQc95?=
 =?us-ascii?Q?Vii86FtCQYoAiHHzvKBCt8yrMK7lSArIb7y0Ad0kCYISJ6Wl0gHAz7Dg2zlg?=
 =?us-ascii?Q?kPJvTao7mAgG2uorbAPIUXEaFDptdgY07goENC46AJyTSHJ8pKgP+QHMx/M6?=
 =?us-ascii?Q?bGhVFAJzo07fNmmDejZfMCbe6jrxkn1V37NxVeCt8IGrBxYB/Lpr2nbHV4Is?=
 =?us-ascii?Q?VUdiwAdq4H+bWSSOxbfLCTgVOSRujNwwRuxh8g7K7fC8AOYpZP4UCw+I/a8R?=
 =?us-ascii?Q?cdkFCRC8bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e733a6-8d5c-457f-fee2-08df1fd32f2d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:46:40.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzAIwMWxtiO/ovSdTPzaryMonTkW0JZO+cTkgCg2y2aCsq7H13ctpFMLZtpb9mEuBw3yFhkb9nt6zYGaFUnRjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806

On Wed, Sep 30, 2026 at 11:22:28AM -0400, hengyul@cs.unc.edu wrote:
> From: Hengyu Liang <hengyul@cs.unc.edu>
> 
> ip6_route_info_create_nh() promotes routes that use the loopback device
> as their nexthop device to reject routes, except for local and anycast
> routes and routes to the loopback address, as true routes via the
> loopback device would result in kernel looping.
> 
> Before commit 21ec92774d15 ("net: ipv6: fix panic when IPv4 route
> references loopback IPv6 nexthop"), fib6_nh_init() also treated these
> routes as reject routes, so it neither validated their gateway nor
> checked the state of the loopback device. That commit restricted the
> check in fib6_nh_init() to explicit reject routes to fix IPv6 nexthop
> objects that use the loopback device. As a side effect, the nexthop of a
> route via the loopback device is now validated like the nexthop of a
> regular route before the route is promoted to a reject route, and adding
> such a route fails in cases that used to work:
> 
>   # ip link set dev lo down
>   # ip -6 route add 2001:db8::/32 dev lo
>   Error: Nexthop device is not up.

Consistent with IPv4 and expected:

# ip link set dev lo down
# ip route add 192.0.2.0/24 dev lo
Error: Device for nexthop is not up.

>   # ip link set dev lo up
>   # ip -6 route add 2001:db8::/32 via 2001:db8:1::1 dev lo
>   RTNETLINK answers: No route to host
>   # ip -6 route add default via ::ffff:192.0.2.1 dev lo
>   RTNETLINK answers: No route to host

Likewise:

# ip link set dev lo up
# ip route add 192.0.2.0/24 via 198.51.100.1 dev lo
Error: Nexthop has invalid gateway.

>   # sysctl -qw net.ipv6.conf.lo.disable_ipv6=1
>   # ip -6 route add 2001:db8::/32 dev lo
>   Error: IPv6 is disabled on nexthop device.

Inapplicable, but expected.

I don't understand what motivated this series.
