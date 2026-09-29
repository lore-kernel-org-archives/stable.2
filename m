Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480923E51E4;
	Tue, 29 Sep 2026 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699790; cv=fail; b=M4chsfR3WgpzUHObKS5RAmI0KGfN/WlqxehlKep+GOhrxXLV/dQbPo8tQDWV3jdI3cBEYPNtkukUm4QrXJOAUD4w+xIkQkOuaQzyKcqEqjJu2A5rF+xIsGg3n0mBtmcbscGGAteuaYSmNsLgbc2e3zfIl7SX7iuL6nyTg3MgZIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699790; c=relaxed/simple;
	bh=TEEtM6X9M7bQN/WsmbE0dXvk0sAHCc/1AlnNpPv6TKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cB9pQs/2Sy7I3xeLFghU99/jAWWPLnTDreS3VLmIifGPzEOCPxwOEp5BRGZMXNcLEa7RzUn4mYEP0TlO8imHrMgAfR5LoFQtvE8727NvObt9VsexP7BsRurtCVZrC+h2i/3or4aCJQ2tbIjE6zqM59rE9H3mbbGvhHZHkVbYx6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CTwfnz+7; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CTwfnz+7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkKF2/Be6n2ccUk+Tp/eAihIO2NBgFyun61+th/5HzIphRjdYwPH0jGW7bgCNXBrHogeahaf7q/9u1n8WG172SaPd4lnzWuc57Ac6v7i0vYHaYt/mt/qwQsn1Qh7kQ2ZtQgzD8O+QrgSpqdmMEiL1Ww0x/teQTywhgT2RjaNumSWsEaCMPxsxTuUaSHMkGsY7LvbfkNTNvQZ67OwsfDJMwuaaYfhJA06nfI36hulGi/ucwPBDYqMqhZVua04a1fJkySMmpejIfJ01HPOEAwHKuINn/4c1NZyRdfa9DbJHup1QpTRBzs25f/feQ5KQhGZI6B7TsA4h31N7gpfqmDjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VWHZaqYM6zRruPUI51ZS0FKaFdS3Dkcq3Dk4RgjWt8=;
 b=VTb0c3chHNEdau6HrHdVHt4uY5MSHl6+Fx3B/BVumpczegtuxzlaqrDHLw/FWQ5iXdWGlP5MBU0+O0Rd7odpOOyFciZF0VGAsEu/oQuexO4Mp+UkZoybr9bvexKiFZyyJ6Zhqdbw9oacpTsIaJH242jGW37mE9aa8pQ8EiS0CMmSzPe+oNWC1XaWzCreWlB++Xyw80PUIYMcz/xlFByPj5NuiJFcfvb1/wDvQCFi0un8oKjrwSbsamRZ3fX8TPHCRqjNLV2UIW4JZ+ex2hZljxSzGkCcbx8jg34JaC04w0ADWYtqoYtku/a5mE3t70eebX9fLdN8MZ7GNeLNzo55zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VWHZaqYM6zRruPUI51ZS0FKaFdS3Dkcq3Dk4RgjWt8=;
 b=CTwfnz+7k4Tj4L66e6Mmi0EUmekGM+tBHXDXQvUD7b1FF2oYvBkrA4WxN2t72yN6nQC2VmhXG/XpUq3tpYr3CRIUWcc3ka5EcToyxPynuj8NgqUYX9HyIRPWy3QNXjGozDvYqlsCCq/0S+pmiiwrjjLXKRNdaO1rs88pUSq8nKxRCtjQ1+9u4qOFPUCvAGtAGgGqgfdGHcIvayyvmLvw01WLZEXFvEsyVfT8yblnJfR1XCOwagYPmm5nsdEu3k5LqI4mPe2wqbz35daCR76/kfyhCnon11FBJR4DgPFo/pLWkMVrkmVvwqWZumH7OkQzPSCIj7sfQ6embB+NPPRhXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 16:36:26 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 16:36:25 +0000
Date: Tue, 29 Sep 2026 19:36:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
	Wei Wang <weiwan@google.com>, Hangbin Liu <hangbin.liu@linux.dev>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv4: Fix device use-after-free in ip_mc_output()
Message-ID: <20260929163614.GA905623@shredder>
References: <20260928162534.2122207-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928162534.2122207-1-nicoyip.dev@gmail.com>
X-ClientProxiedBy: FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::12) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c7fdbf-b5ce-45c1-61a0-08df1e47cd8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|11063799006|56012099006|3023799007|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hQXBmDIfKNsc1lNrUxmU2UZ8fC3DtFhqH7sZi/e1tocGiNYzubsJpY3Py5IVafERwvtYZxwFDWtOcRgvyXjuQwkfwFRIDrUz/ugQYGdVOACefE8Z/0M3yGb6bTJ5HDd9w3aDHfQ8xYqTTd4nyC0x6UJMvbC/SP5Ua+qba57jMMsdQONmxxAxYr8n3oUqpBBbVKOAFUTmgF5fcl15trGicCWuthVoF+xE+SaY8BWoDc9fya5Owp5kJanO46mByCYPrSPf8kaH7zb7MWmxpNlDaLqhG5jmEF1J2ieXZ6q4AfK9nJut5Zvx7nZukZy9fLEyKRD5TRik+FYVzQAog774wICHul2Fw7amNipbqfGBHnVpVw/FGSE737r6WG01lGrBbS4Uyj2Jt+LU3UXDhWjZN6R3hGTg12CP0hhUOrrDihw9giyFxgCbjbYeacjt+4dHHlPcaRVth6/P8sSVIwOOACHvhaoktJlASixBJAFdGAapdmup44qBb7kE+anITkiPFUBHGBMy5NqH5bkcdlTHAnsnmSEElNejM5q+T0YCdJ9/etLDOTxPeaWZby5BkYDBmsKwSDmU219PJNINUgDbV/EIrYv1BBmJDro2WgIj7mOmI9+TXkjgByVtig1PNO1D+JtqgWjzaSRugz94aqPGfAY/BFcW24RFCxGSUDDrr7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zNZR01vbqMJX9M3oFQRoe8GitQ8B+GBXijjos8CJKuIwQ5kihn4ZXQw+NZPu?=
 =?us-ascii?Q?JZRCAa/0CDAOmPQHMIvve/MOgPDmwrm5KsDYArO+fZMN8HjGb/n95le9K7Jx?=
 =?us-ascii?Q?jwguFBH2hwrpho05dcLeHbl+Iu5F/EoX9rNHoLD0gn2LHRexm0tB04iMcv7w?=
 =?us-ascii?Q?fh35xs6w2SLuSZXIF15cuKY9lxjkMtE8wKXyKZVfRSunqd0GciJ8D2bYXJA+?=
 =?us-ascii?Q?BY8WL5+CDNvRtGXrWg3D2WecP5YAdXPuDw0qephv+qKoKM6y8hFleP8KP888?=
 =?us-ascii?Q?xCr3czxK4M8kCxNOGDb4UdFu16OgaeixQ5O7KLwFlfbEQKAFyUaT7Iq1jXc7?=
 =?us-ascii?Q?Rw8ZZSpf//2/fF0Zqd0wTImxtjyyABZtVlWpcY0YYyxB0XzPFrjt87NZLaE1?=
 =?us-ascii?Q?DfA9Sms9XkX4GknXYG9+3NlSriHmsupKfGdlLkkDaFUaWz2Kv8o2aPSSfw4c?=
 =?us-ascii?Q?5Fbvkhz9BXkE47joYF9K/cBYFV22pmOf1qM3RX1Fd77yFDoHcDrMV+fq0Y5y?=
 =?us-ascii?Q?f24iu3Qs6u4d0gZt6VTA9/5VZcdx88UfP37iWNnWIjmTmjIXyXLxeXl6BNOj?=
 =?us-ascii?Q?zNURXCwAhpBI6O6iyj8lojIVEAq6BUS3g6rWjnxrQUMUWRav+w7zddQvtUcp?=
 =?us-ascii?Q?0eM0YKTifut5TchtZflMAjE6a57MdqbI/zpt2Kc2NeDl0S5HfvBdwRvCn9n9?=
 =?us-ascii?Q?Spd3WL/HZ7tG377nIJkxSg3Rt7IK4BaJYkcmoTFbSHVbChnWrQg1ScvQ3gQJ?=
 =?us-ascii?Q?IcNPBjz2QESNh0iOL3EvAuhyk2fBcSJOvCFCIEskxc4pxc7jGMJG8+mylkdE?=
 =?us-ascii?Q?lA7m2Zj5iaoF6xg050ZryaQH9V1nrkHCYvyrK8h9d2pXBtYf336QkK0ouu6n?=
 =?us-ascii?Q?to1MOFb0oIthd1rtmwNqt1UDg2iC5Lu3om4dzkAZQnr/CqDvpQ6CfmjyIheT?=
 =?us-ascii?Q?eT9URFpm81aQLdl1a9wz1/cZsO7I7dUHv+VEgpDxAY2z0oy9YJCEgF/7B5gB?=
 =?us-ascii?Q?t0PAYRUUNVne7oWDgqY+Ia2YZL1UbqTj7kjbO+cD07TD2FrJUUUb8sG5hQD+?=
 =?us-ascii?Q?VrqncQzSkVeG3pu176uYk0OATXv0ec5rgWozGFhnIP55zPPOsqnd5mg8WQRB?=
 =?us-ascii?Q?8+jFx4QGs5VEM+b/dO7a/DbhzFTD7rU4xzPCat5Nw3mHn568xERJATAYoetM?=
 =?us-ascii?Q?pY6YFLPehdWpUtCeZ0/qt3sOHp2JaKSpvYfdfS2gXll0CTNxnGpRyOS0BLpK?=
 =?us-ascii?Q?PKfGdy56Y9D8dMqfzjmd4Luhr3RmMOClCiyfnZKNn67+LYJXRiZzzwo1FBzi?=
 =?us-ascii?Q?wrRAe2MBDLhab6QPzEwECQCuxHMSfhBynm0M4CNCx0kr4bBT2HVlysapQo4Q?=
 =?us-ascii?Q?gIGU4hr3Eo8bDing++KW2OeObmCV50lWYjznbtKtlN6SNjNzf95vX17HteXu?=
 =?us-ascii?Q?fFYCIzIqHlTZ6TBhKeK8qQ0qxXuvEbOoHywTk6tdMb27y1wr13BVJj2RfzIL?=
 =?us-ascii?Q?dIATBAZIawx6J+9CHJfnWBwOI7SC3kOm7ICVJ6/puWFaEhjOo2yEBf9ibPrf?=
 =?us-ascii?Q?289wTmly1/Ib+VTEnLTTVgNAIx177yti4zzQ41DuxH15W2fZwp1A2TtXKSAl?=
 =?us-ascii?Q?c01BqhHauGfHgKXJyxQp+rGz0TTYSu6dQOENfEraGZZmiPUTHrTfKNuVepbJ?=
 =?us-ascii?Q?5yV4ULCkc8oFkpqQLyflTrwsRh5ED5naElVQQr1FBUD9SivT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c7fdbf-b5ce-45c1-61a0-08df1e47cd8f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:36:25.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3kqvOrRWbBdahPHDlRc6dGAJ/bTvcmRyrykT+Fy6VMrUDgiwgTvOQmIvZ7X9HJqkOR1MNpJjJjBmB5WA6SFIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177

On Tue, Sep 29, 2026 at 12:25:34AM +0800, Chengfeng Ye wrote:
> ip_mc_output() reads rt->dst.dev and stores it in skb->dev without RCU
> protection.  dst_dev_put() can concurrently replace the destination device

It can also be rt_flush_dev(), if the dst entry is uncached.

> and release the old device after an RCU grace period, leaving the multicast

The reference release is immediate, only the free happens after a GP.

> output path with a stale skb->dev.
> 
> The stale device can be dereferenced by the post-routing path.  In
> particular, a socket using IP_PMTUDISC_PROBE reaches ip_skb_dst_mtu() from
> ip_finish_output() and reads the freed device's MTU.

ip_skb_dst_mtu() reads the device from the dst entry, not from skb->dev.

> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in ip_skb_dst_mtu+0x634/0x740
>   Read of size 4 at addr ffff88810921c038 by task poc/98
>   Call Trace:
>    ip_skb_dst_mtu+0x634/0x740
>    __ip_finish_output.part.0+0x22/0x2c0
>    ip_mc_output+0x287/0x930
>    ip_send_skb+0x11d/0x150
>    udp_send_skb+0x63e/0xdf0
>    udp_sendmsg+0x1235/0x1da0
>    __sys_sendto+0x32c/0x3a0
> 
>   Freed by task 99:
>    kfree+0x131/0x3c0
>    device_release+0xc8/0x240
>    kobject_put+0x14d/0x280
>    netdev_run_todo+0x4cb/0xc70
>    rtnl_dellink+0x362/0xa90
> 
> Protect the whole multicast output path with an RCU read-side critical
> section, as ip_output() already does.  Load the destination device through
> skb_dst_dev_rcu() and keep it protected through the post-routing hooks and
> ip_finish_output().
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v2:
> - Protect the whole ip_mc_output() path instead of only the MTU read.
> - Load the destination device with skb_dst_dev_rcu(), matching ip_output().
> - Use the commit that made dst device replacement RCU-protected as Fixes.
> 
> Link: https://lore.kernel.org/r/20260927071051.3693368-1-nicoyip.dev@gmail.com/ [v1]
> 
>  net/ipv4/ip_output.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

The diff itself looks fine.

FTR, I'm aware of the discussion that wants an RCU critical section in
ip_local_out(), but:

1. Adding one in ip_mc_output() is consistent with other output
functions: ip_output(), ip6_output(), ip_mr_output(), ip6_mr_output(),
etc.

2. This patch doesn't affect the fast path, unlike an RCU critical
section in ip_local_out() [1].

3. Patching ip_local_out() doesn't cover all the process context callers
of dst_output() either.

And yes, I'm aware that more places suffer from this "problem". I opened
an internal ticket after seeing [2]. I will get to it eventually and
will target it at net-next since these UAFs are not very realistic as
evident from [2].

[1] https://lore.kernel.org/netdev/85c6016d-fb15-4c61-aab9-61448911f934@redhat.com/
[2] https://lore.kernel.org/netdev/20260819164528.3761320-1-jjy600901@snu.ac.kr/
