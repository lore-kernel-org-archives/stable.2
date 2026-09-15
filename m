Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544137DAA9;
	Tue, 15 Sep 2026 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486040; cv=fail; b=th98LGAO3cprMdic56u7NnabYj/QVsg11pt1sKpcqVyIG/PZAHPMPdQMrDhXXc5E+0eaqMZxVapsc4itLEqzl0aiPyKfQjFbP7/8quqOZygd5/qB7b6L/13P5k7gjJIeM+8Zg3S0Cp340ZZygfzl4knfNmYsVlYD7Vz+eZ4uOzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486040; c=relaxed/simple;
	bh=Yin4FILHf/Aie+tgxPdtchPQXFd6oGKhSbo7km3NjFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sl4hpHD3dJU9Tr1+oUlwlEOr4K/XKHzFsRoF5fpjcWpCjBAfdK8qnKoF00NoYcg1hVGA43EnHAI51qQPvpIF+PmtH1yRMaxtt3YWEazqKtpHrqqSXr2J9KmnrgDXRRtpjwlKOCWVS1upDpjI30LsKcvveXLaDK3YbTKnLxgYobk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z6Z3ecvn; arc=fail smtp.client-ip=52.101.52.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z6Z3ecvn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZkCMgkYVTNd+yhmz7p8b+nW8G4Qqk09G+h2aM3M5M83sDhgrv7NMv3xja4MMfp/+ZubRzVe5nOUWBbHt5EU52h0hSePuMfRXnWhyl0cWvZtEZT1BiN9YNzPRtlfFOmhRnuscpbYKbPeOdPy0NDUObMq3bYEJy4uTqRnx6KksI46GHeVYZ5gi3TNxQv1WN0vgsRRQAt0+ftwd9YwyRR+WE3WPW03ziCZIbojeTRTxu+1ZtInIWmc61EllTHnhorW+uWfZ42Nhx2qHMzByolcA2kg8TM+jldCEDBmvbiBTeSaXR+plHFD1W3cmGxxzt9O7PiyXeeAsup/VeBB3s8V+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP9+Dbd0DZx2XJ+VuxJ9/kD75nWyP+A4oRwHBEkpl7g=;
 b=y7GU2XziS53KFkm46up2gnHmZaE6HMq7c5Fw5ph0Z2Tg38PAlIQbmfMrJR+c87nggN5fxbZmMgG7Oy3n9xihTJUl1uQqghDR5zG0s0WJpGsmzA/S8R6SyFf1QU0xrFnwBmmfXzorZ0BY0BKn8hXL5MQoMzcIHpYOvwcK341/vj6caBX0tbj3Epcyl5zfYSkKwzoCalkbtWxiyNCx6Od2HY1o0eUAqcrpQFLO1Trwk4zb6/VebDMYsy0D7M2o5Z945hvJOvQ1MmhXT10p2yrH1Fh77xmkkd0Bn0vBbij23xeim/r+kLAS2cNJlJlpp7IlghXqQEEJ3AQSjwMsKo9KAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP9+Dbd0DZx2XJ+VuxJ9/kD75nWyP+A4oRwHBEkpl7g=;
 b=Z6Z3ecvn8GrN17kFGPt0GohpDB8IXngSsP5l7wP9f9ZfAmsdCTz1OQ/t7163sqPNMUGfnpAnZaL3Fz9/EsUSKaMz31U7iHNQPRvoteR+Xdp0HFtJzLjANZ25CJA2tsRgdBKJLpe3nRUn4QXjboSMQaF4vWwl2OM0rDO8c1nER9yppLIjRihMHnmVAEC57kZ82gvC4LEGNYewL6rUkMmyHLqZMqK7FFtuMOmhMlK6hT9K2EXXUP+kc674WyMfq+OdZUrVYP8wwKAtl3UhT8/Vsi20lvEvORJP68tpFUqpNql71k5ztEliUaktR5vGS0MpKtzg68nJkF/GV93OZUhPKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 15:27:14 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 15:27:12 +0000
Date: Tue, 15 Sep 2026 18:27:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: markdamirkan@gmail.com
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] ipv6: rpl: fix loop detection for separated
 local addresses
Message-ID: <20260915152701.GA723831@shredder>
References: <20260911-sympwn-rpl-send-v1-0-1753993bb584@gmail.com>
 <20260911-sympwn-rpl-send-v1-1-1753993bb584@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-sympwn-rpl-send-v1-1-1753993bb584@gmail.com>
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3a95e0-8f17-4e6f-fe71-08df133dd097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ru66fVvZ1GRjwLsSBCza2IGmCFISO4xkIRzu0ISISG16A7hp6jqrehRNW5wRcpBUI3PSEn4aVMu9MG/2O5GP6EQnVzyITcZUbEr+TrMT0t0LBTOYTqgj4FNfxb/Aw9mqQZ7SYco0yjZiUhyHtxc87ZE5EsXZO2oOlHLoCWeSg/pMyXtWC0mCGn8zvnYkxYCSHhsypZA5KzOxF2H7LVn1GVCZUKnt2zKjkSXwmp8AA93PL9t7nJfJDjBTFJmaOiWS1pERJtr0WJy9WsiPYMqHJdVbytMLFb1BU6OFxha1kpv4qKVPvbf/2eN2N7jwpE6R9+wqtrMSKpty0Y0QI0eidW4oNjI3/viWpLOHAyHnGIEb84l7RxVDdjvx53+YHwTQecK7tMv8t0JtrfKbuxzt7hVKC4QZhyxP4OIFDUv46qQmnRFi8/3/tEaFa1IuS9glwU3TXCwSTclziRLQGx/+CjCFL+m+375gQOTktvze5JGuWYsLMOenG8aB/TYTUTqBw4BIjrpTVASEVpLWJeqM0nz6xW9BGnzl/An9sMwsLoZBjlQKhEkRR/09FZYp/Is6oVCnKrw8CTWGGHbAFIBZvPnn0u/feMWNFBMLYSpDbrlq39OTlHWdldgU2esIY2vi1pBLG0fmONK0FYXssRNA31LHLemCkAXY0brJxeMN0Tg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ypBAYqJvLUkZS5yVsd/Ng5rSYh+HHNHZMes6TXGyMjf3rcQGjhcMv56SL5gS?=
 =?us-ascii?Q?CAynP5QctuCIcu4jbMuoAegCm10WkQeoFGdmwkQxiKUW12HZihTOi7HS18Mc?=
 =?us-ascii?Q?Q2MrXOXxTZvWcUW2UlZzuBY/EUNFPP2SbmJzYlm7jsZVgTopF7Yko6G4Mxf7?=
 =?us-ascii?Q?g6DBLmkr3BfUMZAQHVRa875+BVCnNcUM99GkB8OLOKUv62Seb+yEVoLvJAWc?=
 =?us-ascii?Q?e/0wMMwIxnYCbYWbLKq+wAehKaXAlHwAUhVz0Q+4FuLXnM+RINKzjfqbV/6y?=
 =?us-ascii?Q?DmgFnUlhMskGgnXLoxbF+Jx62yXj0AMcRV1t7UVarrOpfFue5zO6w7WCTaVt?=
 =?us-ascii?Q?NAb/IC4ifKpq37R9KB4Gw5douuQgeI4L7i9luJfTXNQvavp3y/TVr0dLMh8f?=
 =?us-ascii?Q?9wyDqY8/Ehl0eKA/7NhWXCrKL8lxgHO3IH3Rvi44AZj+TqTWsAai6JcG5Cb8?=
 =?us-ascii?Q?hbRd6iF5VR6cF9rlSx8yWmTcfbjb7m1s8Lq+5sM8SyWd/hRVBb6+V4yPxp07?=
 =?us-ascii?Q?swEb3RBle0/4Ds/lvf9bmtQ4wPiZbJE5RhR89xu4bzZ1PvvHHZM3hrc7+GO5?=
 =?us-ascii?Q?lggqaboAi6cb0qWA4j72xi/gRD+ZtcizZO6vSrXTmEsFvLbNuCrTw0FF38m7?=
 =?us-ascii?Q?N97r61nbroklHzZZwpHGcJLJ8o7AuYFLkS/iLx9112JhczFtZnGool3zWzyk?=
 =?us-ascii?Q?6OcFKslwVum6OhKkvMekxXv+PZdOKoYVqbuhd/4z7qvq3Cb3gF2akRJ46YlQ?=
 =?us-ascii?Q?Lq31sZV7j3J8bZiSA0xRpKR38jywwvlLd8lMB4gnDsSdg3v1NH6Oyeg7NyIx?=
 =?us-ascii?Q?dHysCn8LcQ+r67BtBXIkC89ageVSaO+eO/mj3xx42VUl+O+4WHALGmR1dCsn?=
 =?us-ascii?Q?2YH1fEiJT+9UUlSmHtYI+Vz2KtsB7SSp7Nwv7DbAq2XAzLpyZ903gDgB9fm/?=
 =?us-ascii?Q?VFyVb7CX1eS+mKE6yqiTGy2KGQ206FZA/SUt2aPc3WUY14UWYIChh4BPheKu?=
 =?us-ascii?Q?qk9mB2/iyQPJFNzmTdmc0gA+645tMcy2HZTemYMJrggvnj6WKC8sjaDjlgFQ?=
 =?us-ascii?Q?uaDjmvnL9eJvcOgHJlMMIc8CKiWGhHWjIoxj3jNbZdlVD04Tsa44aSj6BSyx?=
 =?us-ascii?Q?W4AngHP9KlxSMalZ5yGbzxQg1hkp+II8tK+oHt6eOJg8173zbWwIA5SzlDdl?=
 =?us-ascii?Q?e7CDTbChIbqzSye9+FgqNsM48JeZOEBKH0jv93x4H3uhfKwNNVN12qRtcJ/P?=
 =?us-ascii?Q?33ZAKkp8xPYBb89F+jUfmd/ooR6Pw3hBn2W7q9u4HK5e7yTxpdRqoDA3urSo?=
 =?us-ascii?Q?CVQ/fShrT9zPp5MqHslEvhNYvhfITIhXlGtRW57/Y4YwuqBWwjQJlKkV1KmR?=
 =?us-ascii?Q?p8Kkke2lMuEGlvXrKbvr9FJKTGqFcopkGVw+EiYuQant0drZVkiPz7+gmkJL?=
 =?us-ascii?Q?5skfBq6MJnnG+TrJiinE/pV35NM2SjFtnypjW6olf5eMsU871qQphrBisFP0?=
 =?us-ascii?Q?m8czhZG1zl9yOlMeEfQ8kHXRbRDU0EvKvXxVmxvXLfGof/jQob0ub9PMdJnq?=
 =?us-ascii?Q?YOCnrafS3ZDEnbnfwrIQz9APN80BJm5nEz17dz0EjH6b0Asi00qVSp1N/0vl?=
 =?us-ascii?Q?hizWw+C2EnF8deoSxN/uPYWVY0SgHbC09QnIK0Y6zD+GreC7YZkE9TR2uS66?=
 =?us-ascii?Q?HWgYrI988Mn+8IpGMDVSXr8/bCoKeuAMXvKjQj07vuUhVB0LJjwN6pPCrdXU?=
 =?us-ascii?Q?8X/KuQNtHQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3a95e0-8f17-4e6f-fe71-08df133dd097
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:27:12.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFlt34gZx8uMHhTM/2rqFqZexNyq5NhWaPLj+1RPOZpIY0mGQ0E+t7ex3bQVxJtJx5tINUZhnud1sGR2gXeOug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

On Fri, Sep 11, 2026 at 04:11:21PM -0700, Mark Amirkan via B4 Relay wrote:
> From: Mark Amirkan <markdamirkan@gmail.com>
> 
> RFC 6554 requires an RPL router to drop a packet when two or more
> addresses assigned to the router are separated in the SRH by an address
> not assigned to it.
> 
> ipv6_chk_rpl_srh_loop() checks found > 1 before counting the current
> local address. For the shortest invalid sequence -- local, non-local,
> local -- found is 1 at the second local address and the SRH is accepted.
> 
> Check whether a local address was seen before the separation instead.
> The receive path calls this helper before forwarding an RPL SRH, and
> RFC 6554 requires the check to mitigate bandwidth-exhaustion attacks.
> 
> Fixes: f37c60593634 ("addrconf: add functionality to check on rpl requirements")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
> Assisted-by: Symbolic

Code looks fine, but your SoB should be the last tag. Also, if
"Symbolic" is an LLM, then please use:

Assisted-by: LLM

See:

https://docs.kernel.org/next/process/coding-assistants.html#attribution
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=816d9992d9ed434ec52cfbd63080d518e535a41b
