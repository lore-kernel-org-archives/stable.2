Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABF171B1;
	Sun,  2 Aug 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680903; cv=fail; b=N+6OCZmzQgyenaJWLU7bDceKQFn5CEGDbjkUjacuR59iL82dsqvwlGgSOOHpUL6dCxzTTDzNhT3rHy2MJI0AeSBjR7HIZggL8urvYVxW6lTi8MIrO8WWi/LUnqnrZy/dMrC1FsySHGv1elgCfetOLR9PtpzFvfQiKCDRDX32i+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680903; c=relaxed/simple;
	bh=3W/qGpOKo76ENBMDLQbqYmJ+MOeYDWB2Gq4l3+C8Lec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UOmojPK4+FO2Fqe+6ArHbFzlvGfz05jI1LbtIFvxCfVYc1ZKUM39T9uIPPuNtzfBmpFVlXxbw291w7b6ZO4vNPa4NnuJHu/Zy4pBlzjNP1SAzwU+dh83QIfmn/eJju4c0S5XlrAcZ/AXNVmpujhVd59OajYX0puZokaMUpg4aag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ia+IU61f; arc=fail smtp.client-ip=40.93.194.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ia+IU61f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plZ9Eg2BnKggKURVA6Im483uyytcUCTao73D33egvBmi7tI7ekNhuGs7u+DgcOlTDREZQBnbk5iYScQ95elGcK7JVa3qfj1zipqVxlLUb1iAPE5l//k6P6mQVqJaF3kvIHf8Z+WWsDAr+PPCMjgd36Rv2jCuTlmC27/cseLvlRTDi0CujbXUN3cdY136FGuc2wvQDX+HvntmGgJvdvts3aptMJDa3cI3osyEiwqBN9/gTl7eeRcJ1WpM2ntB3IkV3GLZI8G1hW49LKLnl/mliHL+VmaWwFZ2/2rVdLXjKUHPqneNhR+Oz9WVFtEC+peOII3nFFTb84VkZhX1WvA7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PprW4qhZnPsamDu+8s/2SFMwhB3fP5kEX7bs4Z4DVk=;
 b=NjV2YuzuJfGjaG8Hni0JoNVqfNSdU0Vm3E3dqUREJ1L1PCcMDhDOjjuDrXnnKk+67NYntsdxVa8MzCB3sRW3wyyZeshBA3t2HZYpIb3qwgvJmpG4wV8tRtBQmInuU/2nT2r/wVPjueHVKEjADIJYLpXbC3lSpjkNW6gz4rrgJeryQ+IpsBzyg5x11cUes0CVtRigScjL3SjgqYJWvpfbmQT8wpFu3yFIkaVUbbN5hhEJKVfDVKHxGYxCTOiHn5LfKzGgHwoC7r9Gns08fxboctsv2yiqrORRDG7CKbC9Z8vwcgFMwJDWhZp678ycCItc5W3eNB+GpON1BS0Lw2pKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PprW4qhZnPsamDu+8s/2SFMwhB3fP5kEX7bs4Z4DVk=;
 b=Ia+IU61fdiGcFGPNDoo+jVw8T1nHvm6N9Rko6u89lyDtppccDq91kqyYyS7TJv0Z+0Kp3utbrdncOWLDE+pPmb+zp/7ekuBfNUpsat7YBRVLJ3GYR/DoXXEWE7+Hj0n3U3HUiWv7LgWs3EkSZK8uvWGj8IY/feOqulDRHPPNrjhQSAN/mVrcit0zOZt/WPNuVU+K75eHtG4kyZmJ6Jiv7hs2Vo/ryT2ycOzML6Ph3hhFZca6qJj0QWSW9jHfsOEi24AVQ3Tef+Y0AC8qAYVDdF/OmGXYZyt5qLkhYiXKceUoNGAqf+heWmudGmqDeOrgNO8P4vcoj2eaj4nK1psqQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 14:28:18 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 14:28:18 +0000
Date: Sun, 2 Aug 2026 17:28:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangyx22@mails.tsinghua.edu.cn,
	wangao@seu.edu.cn, fengxw06@126.com, qli01@tsinghua.edu.cn,
	xuke@tsinghua.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH net] nexthop: account nexthop allocations to memcg
Message-ID: <20260802142809.GA377770@shredder>
References: <20260728060112.30367-1-zhaoyz24@mails.tsinghua.edu.cn>
 <20260730003902.4166545-1-kuba@kernel.org>
 <85095CE8-F0E1-450A-8D9D-A991D28333D6@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85095CE8-F0E1-450A-8D9D-A991D28333D6@mails.tsinghua.edu.cn>
X-ClientProxiedBy: FR0P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: a114002d-b1c2-41c7-fed8-08def0a24be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|5023799004|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CwfKt4XlkFuetXe7lMbcQ1FzI20vNXHVRa+JWiHk7zQOAT6lL/k0Ro0bBOH5kST/kITSR+nX75cvarcxldnlLpwy/WOwWnxciCYHSPOZURdGanpofecSYU+GRgZ5dvmgtqnH8c/bm6r0FRdBFsz5UaDlQ0Fg/RInJSVjRttYcSyie9I443aX24u0Wo70WWqFcJJM5g8fk8lDybvvb9bN/oo445YAdake1x6cWiEU7EeKR92q53AmV3Bk9/jcQCt8tZfvFRZOvmr1etRzvfX8wjYkFrXxB2q5fjFmITXrRouu9kXw9zRfwKaiaopZalUCsLn3iRTSta/rwjzXIE6+NXBvVSU9+Vdev5Iy9xWMqEfjK9YSSzfteNoHfrJxVSvJ4tOnqu7ZONJLLpMjMjVCEiyHiKY/RXvu1PFgRuQzr/gCuWMcEjzEnWwpMP5k/9CXmEgQYSeZPnzJ+VfO0zXy4cPnURzAZjmnP3iPByaQD5MA2w1k1zGjXL0OhQYaEbaevbXY9hd1DkGRlPP2ptmWQrrQi8UhNw/ZHeR7pbyvDgIk6TeDIJcHh7aNkCWvoJaWr7zPxAhp3z71IdAlzAYgRt3D2KqrkweN02QSj1QoJ/XHOfF6rvx6lXAOsZ98Ay3jF97oPIWdiimJfaA3yTCvZz1HDR3ZMfqpQDgC/tKkOo4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VGu8cpt7e7nZdJ8cNJOT9Rs/DsDaF0hLgHq+zunC/YO6Fkqht+c0N0ekupNH?=
 =?us-ascii?Q?MZtTG4QBD4WjDdWcPTK9y/aSoEgjXfotfRRaK9d4Bue+8wOlzKPkkDEmIl9k?=
 =?us-ascii?Q?i1qIH3+AONVsdOKH50t3lmJSLK3tB3YxUqNLGKaUFRL1ZWqP2p4W7eLaobGC?=
 =?us-ascii?Q?9o1wZ4sZpcg0zwLGVtXdXjb41JBR22nOMn4K6AuT1XVY8e1ULF+0fZuqwpKx?=
 =?us-ascii?Q?c91M1PuuFUNHVdxrcLPbUqvpu/gkRcCeM60XnBysKoV1UjC4ibMcl2l3W0qL?=
 =?us-ascii?Q?7C2UBM4cnRPv2VZFw/tbxXUG20OHE0td0cts29dlXF/gdtstz7/2Eh7VRM6i?=
 =?us-ascii?Q?7FT+GAtBHnQUaY9Di+kzmueMzR/L91hkz5VV7K/ZRSt55Jrz/TcTtL2dgaTn?=
 =?us-ascii?Q?mhETRKYfTWd5fFZvqnnzwR7kbfwM04KgIIClSrnCxD+FmlC0xZrQg1ekwWoJ?=
 =?us-ascii?Q?NBlCJa+qFun6TgfNY5yBiQCSWa4IN4QNY9x0UIhV/n2Ef3eD+NCke6GWb23T?=
 =?us-ascii?Q?mTTtRTEboIzFHV791SKv/NQ9soJCIdAjqsPJ6jwbVWL16TcR6yhKpgVV61rB?=
 =?us-ascii?Q?4fgZixWgbIc5jxNZXbpLEW62+f1TpGq1tex0BJ49dipnQLZtTQOa2GlIIwsj?=
 =?us-ascii?Q?aFUAvpXPxgbLpEb+T+C4jULMOBKtTy2OGQW+A63YByYA2lcPiGUh3LvzphkB?=
 =?us-ascii?Q?UYafFEr+q+/0pZPgQJUm8acRWkX9pUBgAhoHLYNsNiJQO3q612Z7+RLoly2k?=
 =?us-ascii?Q?qG2DmJq/GwjKK8moZ0zOiN7JS7/JXlj1jDbajqyDzDMt8HbHPaOaaRV4leCR?=
 =?us-ascii?Q?TV6jibA8Yz3ZOUc8StLTm/9YaJSRe00vP/jq2HLC//Q0jasJQkD/1Wyrcea3?=
 =?us-ascii?Q?Y64ubZdQIoSEnpVXYBIL4MJOf80b2bmFYLtuYocGbwAv0VcSk3oyoNvcT4o+?=
 =?us-ascii?Q?Nopq3CxdO7s0z0z+p8R48JHoiFBb36X/7OZ8DHW/UkQTaksvyfV6faSy6U7B?=
 =?us-ascii?Q?y2TVZrZskOQj931E6pxiW0qOnX4m8TgN6dROPnMbYkMJiDYyCAmQoCb4UH6p?=
 =?us-ascii?Q?XimuWyJcBP4WJ5V5K/YU/GyT5FsuvEH8zseBouP8QycLeGkbxj++swIgRQqv?=
 =?us-ascii?Q?Zw1CizzjQpCzea+0NEOprfM0t03pnxqPS4J9+hVXrHlRxUOsRaqu2H9z2HYs?=
 =?us-ascii?Q?OPZsDKoUTi5TtdXlSFGZjtlgjBACGuxOzEDCPK5vp04K1A9hRn8UvQplNw/h?=
 =?us-ascii?Q?rL/2PXE0/3OlI8qo+QhakvxzdhpH/jeiZPNGVpv0+W94nBHvyRq6IsbIRXls?=
 =?us-ascii?Q?N2wcUpoVzFzTFW+WMb3mkS9mHoarhjIslnDIQ6pqT0+8/G11mf+Kym4WSHfE?=
 =?us-ascii?Q?ySK5uRYJSm+Z+CMPff/pb/WiKrYXqXfJmvExiqv4VFfSEqhUttWA5VrDNDIg?=
 =?us-ascii?Q?dhs7ETRlCuTPbuEw8w+aKEMucbmUYfAOcdADc4IpPBM36gz2rkkO906uXUN9?=
 =?us-ascii?Q?3Fcnb+9Xle6E/3PB/cDSqHlX9dXFORhUHdRdwfMZAZnlitbJTllYxd+vkVMY?=
 =?us-ascii?Q?w+F9VDXFYSI1DfplK5UozbsomemD2yxVVrHMwKxnvZDZcQG+9v4bJdcXAL1m?=
 =?us-ascii?Q?m2F8p1inllj75D4+HSwZTTtazYbHswa3KB4eJEPKHwqxg2awmQrWch+F3oa6?=
 =?us-ascii?Q?xQe3Q3DJoHYE1GEW7iT78Dr4ZG6wUT4sZ2PJdOTJxeAhG4Qa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a114002d-b1c2-41c7-fed8-08def0a24be1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 14:28:18.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9j4RzW1AJiKkI+yqNOTC8hLXUdKQyEnG0IqyvXNBSDL/F7pmDFsKzJgpxL8Xp+p1YfTFoyr3yfZZdlt7l+59Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223

On Sat, Aug 01, 2026 at 03:13:46PM +0800, Yizhou Zhao wrote:
> Hi Jakub,
> 
> Thank you for both reviews. This is the reply for the second review.
> 
> > On Jul 30, 2026, at 08:39, Jakub Kicinski <kuba@kernel.org> wrote:
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > --- Patch [1]: [PATCH net] nexthop: account nexthop allocations to memcg ---
> > commit 1014ad1eb712722973916d53a1c5348624a80550
> > Author: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> > 
> > nexthop: account nexthop allocations to memcg
> > 
> > This adds GFP_KERNEL_ACCOUNT / __GFP_ACCOUNT to the nexthop creation path
> > allocations (struct nexthop, struct nh_info, group storage, resilient
> > bucket table, per-group stats) and to the transient resilient-table
> > notifier buffer in nh_notifier_res_table_info_init().  The stated goal is
> > to make memory.max constrain nexthop creation by a CAP_NET_ADMIN task in
> > a container.
> > 
> > A couple of questions below about the notifier-table hunk and about the
> > tags.
> > 
> >> nexthop: account nexthop allocations to memcg
> >> 
> >> Fixes: ab84be7e54fc ("net: Initial nexthop code")
> >> Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
> >> Cc: stable@vger.kernel.org
> > 
> > [Severity: Low]
> > Are the Fixes: tags and the stable Cc appropriate here?  Switching
> > allocations to GFP_KERNEL_ACCOUNT does not fix an incorrect result, it
> > changes the success/failure profile of an existing uAPI operation.
> > 
> > After a stable backport, RTM_NEWNEXTHOP can start returning -ENOMEM
> > inside a memory.max-constrained cgroup on kernels where it previously
> > succeeded, which looks like a functional change for routing daemons
> > running in containers.
> > 
> > The operation still requires CAP_NET_ADMIN in the netns owner's user
> > namespace, so no privilege boundary is being closed - only accounting
> > accuracy changes.  Would net-next without the Fixes:/Cc: stable tags be a
> > better target, with the transient notifier hunk split out?
> 
> I agree that the fix changes the point at which RTM_NEWNEXTHOP can fail
> under memory.max. However, I view that failure as the intended enforcement
> of memory.max: the current uncharged allocations let a cgroup retain kernel
> memory outside its configured hard limit.
> 
> For that reason, I had considered this a bug fix suitable for net, and
> possibly stable once the patches are properly split and validated. Do you
> prefer net-next because of the breadth and regression risk of the allocation
> changes, rather than the -ENOMEM behavior itself? I will follow your
> guidance on the target and tags.

The patch does not fix a regression (accounting nexthop objects never
worked) and does not fix a crash, so I vote for net-next. Also, similar
patches were applied to net-next in the past and without a Fixes tag:

425b9c7f51c9 ("memcg: accounting for objects allocated for new netdevice")
5d26cff5bdbe ("net: account alternate interface name memory")
6126891c6d4f ("memcg: enable accounting for IP address and routing-related objects")
