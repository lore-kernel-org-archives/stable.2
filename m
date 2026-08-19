Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95853C199C;
	Wed, 19 Aug 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153484; cv=fail; b=Ae7hPEzaWQ+y+O2Q7LcigmObwHhsA4TZ5GZwI8ys9jtHZaDmL6cwf1fYBBRUYrogmZ5gfteRF7nLJp56WKi4+gV/1srjQLHnkLDv8zisEwoMC7AXCujckUd22dUwFfD2ghGMzb1lAPRm4yLEyJOF6wMk1bp2qh8aRYr5MsWk5sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153484; c=relaxed/simple;
	bh=Rp9xPQR2SD6ZdwpGGgqDdviirCeQsNj02WwhTsH7I1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CAZv38ABA40AgE70GwlH3wMyBraR4DOSUaSwWCwAajdxgcOFxn6wAEZf+agTpP2pBrcCqHoINxhAGboOE2+X2PxLC8UY/IVhQhs+W0xmeZpCmU7guB8LYc1yZmSx+93B+NLjZGxc9ByBbocwM86yV8CRUj027C7LArLgtSWc1P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJmTqkXY; arc=fail smtp.client-ip=52.101.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJmTqkXY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y783Xnl2S6CELvTj6pDMeoIr9jknLrKVy45YWIzv5WczoyVXZ0IhjU114zPLJWFQAsZPmqQN1Sa1Xi71QMdnlZWgussCHDE9FbNvV6pW1U+OKft1u5wO+4sxufsuQEEdYgrxF72lG8yYUd2koeKTKcA+zdqinOZzCB7LOXfyfuFaHKaVaJ9xEEsrd4zssseakuZ7bWh19/bCw3bwDD4glc3ArUMRuRId0TsZ7jNLROzafjqDfyumI6sS4qx2568QisMP6i4PDRfrvkCRBxRy8ZmQqItBp3ERpg4q2a4rS/XtYoGfOMDrOUlLUhtF6fS96xV2foaixecKxhzvGrWvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUz6egqlRNJcKzjL0VAlywc8nilTKKvAcJCVANICp2Q=;
 b=wEgo6AsjXRxaAxCcvPr7d+jFR986Rszlkq4SNsQfeZK/j+hT6Cjwg71dmeJaJTUMgCL7aw8+MRoh7pn8Smnp25CBdjqC5DVlg+dB84dEgv/0qDfwpfPZSVnMjY/BvL2QiHd1RqUnYxZRWHaS4thyta5XlD4SADoftMO1Fisa7+XBZIQFp2WXqLhDbo93AUOADYccKIXhUMWRUQg6vIZW9uvviIQaGftP9zgwGkAAMk8ydwBJI6pMhOfduZlgSR+X+HXJ3Yb8JRo0PrqruS37owRxxbAIO9KkDSQCCAkjWD2Gwu0pb30JUhShH6ROeEXjjLiZzox+fvii0pl5GXOgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUz6egqlRNJcKzjL0VAlywc8nilTKKvAcJCVANICp2Q=;
 b=bJmTqkXY85ojJ0iMM6dYIS+DVX7UnUxvQrBku63HDi6/WqKVYaA55t/FkKJznXOFp5fuGXnbPV8bUzNmzMWcuIxSmtDTX5NQh6wnxgGNc9mdSb5zz0Idh0B88CJH5yByixjH/frx9HIu8lIqvGX3vjDZ0LVBWqfWTBEbmsx3hn97lA/sP2Bhk3GJkKTJnBmzUsxZixuGwxdWkL+zY+MJY7ogpZm/7cazprZkcZUIJ1SZ99ZLSRSfH1j7CUem46emcCjmt0U8QHpuKXbkV71mXzHJ/1CYF22je52PDZY144OS3lXB3sG4L2Hsy3ZlZBCBILsWaqYEtOHdf1MbjdVBtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:31:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:31:19 +0000
Date: Wed, 19 Aug 2026 18:31:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, horms@kernel.org, davem@davemloft.net,
	pch@ordbogen.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Subject: Re: [PATCH net 1/1] ipv4: Fix fib_rebalance() divide-by-zero race
Message-ID: <20260819153109.GB1248049@shredder>
References: <cover.1786812660.git.zihanx@nebusec.ai>
 <2080e22819c552b0d186563eda255a44c68404f7.1786812660.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2080e22819c552b0d186563eda255a44c68404f7.1786812660.git.zihanx@nebusec.ai>
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f91d931-bc25-4bbb-a946-08defe06ea8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wj26zIMGmurYrK7Bn5b4STVLewD4CLq5XZvQb68B53Pl6chY0/Niugqce9LT5GVS2GxegX9DoSICTlZIJ/ah9PkLjmqKtGyxAETXhdc5OlxYpywdSECBXY88kfCp8twRjAH+SU73Ne6EiAm1rhIZuGrrn3sFCIYiWh5xoJ6EphGqvEM0dT0IMR/MpYcCGQoHsgcIWGLFIV6HFGEHIrMptUKO/NVOc3d+Kd174Nci0DEa7Gt3fm2s3sjklwY45jc0jvQEwpfi64ajPVSL7avuQd2ksHCLeQC2OIOTi8QqmTteW/rwdvPj5ER6yx4UEIgWt3WtQcKMcicWRO6v35RyiUEdMlqEI8h9gqLpwwg/L+cKn3rJiZe7UJfUtXBlaPFksJheAFRuLYtOkHF9cLSbV0eN6a8diTZmSlJw1PnLsovKnnMqm9fjhLc8a/OH3FaVs1LdXjuz4YCPfoAEJOLU5U6rWEFNFj5YxIfhQtgCH5Obpw3z1mvpWFOyDqtj/JTj8v+IHh79T+FchSPfMxs66iUVXcRBQM64U1OMOWfbPtQphDApH3Z3bwHtf8MEZo0dIIRwssMH+Y3+DZPDzBy5duy6FkZGGxqBU4bIj+mUbUQgWisDbLej8TUMJOrd9R8Bs84HoH2nIMswGGAhqGYngne4Um+MqJ72ysVrPoYZ+No=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rCw9B70wK1TQNHOsDrxiR8Wa3FsmILh12Q32yHbCKUL5Vll2Jn7deO7DGS1k?=
 =?us-ascii?Q?eOPXNYhICfdIp6yQGNkOMTkxJqSSgZ6ptys+jDLO+xkoKPNAhseJgmh04SuW?=
 =?us-ascii?Q?SUUZPOAnd1G79lY93Co2lFaec5nIy9qtIO3uxkpqkdS+pUPm+EJZVALlQPVU?=
 =?us-ascii?Q?ckUcpRLRTJDQvMWWHQqk4E960EW5puupxdprq68or2gsHmhO4TzluBrsf0Hq?=
 =?us-ascii?Q?sJxA83vddJYacKKNADjiDQ1mZn8ni0EgJX2XImprmqpdECuVNTAWGjHOqsgu?=
 =?us-ascii?Q?hfkwldijAoewcBs2WltEKXIUjXr+N8RoucjltsnQpcR/6feiSqPSvV4MJIPx?=
 =?us-ascii?Q?gue7BjKrT7qec7ccPV+8DLrnsEU+N259Po0VKXy+AHOwi2Z+iwt9OakgF0pT?=
 =?us-ascii?Q?O5QujZ66Ow16puhPS0HO+oKa+IQrgwACGmwJSqH7imXgIU8Gl4HFxAdWXZo4?=
 =?us-ascii?Q?Xx/osg/ZiFDMbvY8lARiounR6sbxacx84+Sc7fwhChLiUO0EVtq9Acx0ckdV?=
 =?us-ascii?Q?xWX9syWKYZ8vBHOHv+7dW6ZkpnesrxAvymQJPibF81hE9HcWxb87s2ogyTts?=
 =?us-ascii?Q?/NDN7DJX8UWCCM0nsjiB/EGQZZiddWVPyPFYvgJx8Mc6pwkj5/Zee88Pn8zM?=
 =?us-ascii?Q?z1nBWZxwU1iYLWfW6fBAgjgIQbhGlW0paqisL2XgbI1MQ63mJUo+63w3JAy2?=
 =?us-ascii?Q?0GrhV+YhBo5HwpKh5OdihtoAcyQFSIdtPaHw/ec4iCD+BDpEfkNIFWDuGihP?=
 =?us-ascii?Q?eWvKsrrilBGdL3/2re8/2Yeh8DwLK/HTC59YA9FIoVYHa4on+uLse+hsuaPS?=
 =?us-ascii?Q?nqO9PwcTeamDCvpBxiYIx6NXHW8XoS/6urk81i1zOEVfnefs+Pe5BQPjxGW/?=
 =?us-ascii?Q?pYF42vTwsNC0JBldy4aXGv0HmLGP+EP3NWhTRKSPefbx0t1NVIhUM4zfXGWU?=
 =?us-ascii?Q?FjB7urdxt71fdCer7L6TrCC1jQi8Pyb/e/0RlL2e7OGu1pczejrp15AN2Hq4?=
 =?us-ascii?Q?3F+3oUw2Jx6JMwvKe7XWhJT/gMQpn6xCTuNhpGMLYCJdxrPzIpnoQlew+SF6?=
 =?us-ascii?Q?H/JYhiwSjNZyQVWfIAMaYquz3dalG1SyoEHJuoREDfApgeWemaEakBRX+ujz?=
 =?us-ascii?Q?TUdAsWaW2zPzd0x+WxO8FuPzsoAD2LyPPk3ABrRfH/fzO2ho6UIjckFrkDye?=
 =?us-ascii?Q?KDPLBClreiqDb70+snOOU5ZU3N7oM+DLzF+qXPIfSse4IMEUg3opiyzzB7/2?=
 =?us-ascii?Q?1Kdwow1DiFwSQXA2T19CuF1hDia8wkMZKlqXXU1sny7rwqt5XTXlZuP/nJu4?=
 =?us-ascii?Q?sOYHX7fFmy13VJygAj5Hs6BHwyFpUZSuZ3zU1qvdZCErfmRgq0RenhMauVxB?=
 =?us-ascii?Q?P+OjLiitphYOwA6stNAKzO4gEZwGZG2NuuAxlrToKLVZSkVSyn2al7zdvQH+?=
 =?us-ascii?Q?w0TeXhzK5kVG27OxnMAFNO7b3eK0inpxppIPo1KCn/uW4m+AfsCkYAi7H5li?=
 =?us-ascii?Q?+QZsrGYAXuV2qzB8GiRs1bgF6jRNz+0ZWDmsA0ijLiVO+Lg/LnDY6M0FrWqP?=
 =?us-ascii?Q?UB7wJWOuVesmdKeucAN0xpeOw9yx6R4CH/ptnIUBpTUoFBydgiNGgdBCH9sE?=
 =?us-ascii?Q?dOBHq5dKiiuFxapyDSy15yuQ2QV81IanI/AzoISrKKpKnqBqZ/6sUPamcAUW?=
 =?us-ascii?Q?fpoGb5E+EmD0dP5oqlmuiYrwXayZc7ixOD3TKuwoDZyZSoRB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f91d931-bc25-4bbb-a946-08defe06ea8d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:31:19.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lm3X8DOVic7Rwh2Ie7KBwAeecQwizB01qXib0b5To2bVI0VWvC4eg3boHVslNfdm3leWVx/pnMKCsY9N5Zjl5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

On Mon, Aug 17, 2026 at 01:12:10PM +0000, Zihan Xi wrote:
> fib_rebalance() reads ignore_routes_with_linkdown while summing active
> nexthop weights and then reads it again while calculating each upper
> bound. Sysctl writes are not serialized by RTNL. If all nexthops are
> link-down, a concurrent 1-to-0 change can leave total at zero and make
> the second pass divide by zero.
> 
> Route insertion and link-state updates call fib_rebalance() under RTNL,
> and netlink devconf changes are already protected by RTNL. Make the
> sysctl handler take the per-net RTNL lock before changing
> ignore_routes_with_linkdown. This gives both passes a stable policy view
> without adding work to route lookup or rebalance paths.
> 
> Fixes: 0e884c78ee19 ("ipv4: L3 hash-based multipath")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

I think that this is a better direction:

https://lore.kernel.org/netdev/20260817013237.2797-1-blbllhy@gmail.com/

Instead of taking RTNL, make it consistent with IPv6 and mark all the
nexthops as dead (upper_bound = -1) when total==0, as the first pass
indicated. Something like [1].

It's true that it can lead to incorrect upper bounds if a concurrent
1-to-0 change didn't result in total==0: during the second pass we will
account for nexthops that we skipped in the first pass.

It's not very interesting. This sysctl was never meant to be configured
on the fly and the kernel doesn't rebalance nexthop groups when it is
toggled.

Let's wait for the IPv6 patch to be applied so that you could reference
it in the commit message.

[1]
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 0483519b7fb0..7a362f2e2c2b 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -874,7 +874,7 @@ static void fib_rebalance(struct fib_info *fi)
 	change_nexthops(fi) {
 		int upper_bound;
 
-		if (nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
+		if (!total || nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
 			upper_bound = -1;
 		} else if (ip_ignore_linkdown(nexthop_nh->fib_nh_dev) &&
 			   nexthop_nh->fib_nh_flags & RTNH_F_LINKDOWN) {
