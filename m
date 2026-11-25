Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795633454;
	b=bsTa+10lAIi7kVjUS4SuML6wMFhEpGHojDNMIe4fglUaFMMs+c14H0zVkmRhljp2JfpS
	 FxuZaQ+mUvnrEpkzk+bbvj7jFuxlW2dLGwIgbF2MfDoWDpKMrBojadQRT2GziER9Qed0S
	 fKX+DzJqnJ+mbhskAuEahu5I5JaHRFaXB9TyY1qDg8+vxCMR3NJBPYHpiDgaYHDeQ6hEP
	 lMLjfYaTgNHvkXFf6Fwc1QgmdRi10NvYRrFZJNew6TC5776unRR6DAOAzau4TpBFrbjoQ
	 xKeL4dT181BjtGHjc7GODRmxC/xx4hOH4rkUgyevcMzP7akbl0GFYljbdRJess04VRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633454;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=d6wAQhHs/v80eB+VGYA7EJ7a9f6veMMm8edlI2gyiT8=;
	b=13HoFBX7f/3NNOESNxKGQ8wpcfRlocu7R6cpCMWT6qnVwuqxB4WSMNWXs49tXvQDZh8j
	 96xQjslghIr8F53VLwTlnRqACnpGcjESswT0ap9wEvbRZxUPuua4jEK1FzX6IVrQm9gaj
	 qe+7xzlc+oPZS6+X3E+mgEAbljfZkPxjv3sWvSG8ac8cx4GaR5sGwfSKTfSUdvIPzZAuL
	 YP22AA8HY3/j11OuQ/vray7yGTa6MOcwu/MC3XYYSs2rOM3ZpYQZyinBr3IY8e6NJ4skf
	 kwFNAnscz1xpRViwobr4xn6QcVpIPPDQPc60aFz3BWdxCfCOTpgREW7pwwyTz6FNZSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="p/yiNL2h";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.39
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D304606A31E;
	Wed, 25 Nov 2026 19:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D304606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p/yiNL2h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmfOTpOvs/hrQdts5n06uNfzySHYfd+4YOLAdpFAYYuO6x5HiourW6/QclTcVJKCq8dMba6f2oRlCy9isjh7/dNmefRyDW0T564HiPQAoATauk74a0QVssLa8bNXriAQoukC6GbznbfHSukQNvUmQ53gvL3XiAdiKoz6106gtEvXmdjdopA5wbRmerHFfuOQbDX5prBJ8q1XTPVIne44+acBeGsM20teWnKbpKzqU27/L+MzxdG/vDUC0rbJtKZEHGr+uQT9/rek8SnOL23mG9pXoqC2ttno8ohu9mBGGY0bqxfqLU6f5iNNOMd4SnFhyKeEQQbBNc+V9S7PMbSRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6wAQhHs/v80eB+VGYA7EJ7a9f6veMMm8edlI2gyiT8=;
 b=FYSK+B69qYwmmkDqhE8dbIZM+CkWajwENCH8E7EfVbPDQ0F1GZ5S/hjEvArGLsKEZo2KRAA550kBOrsbrPWLiS6NOcBrPiVHJkf5Rt0gC3Cfm0e1DIXlqDNqI1Svr1oABZtmeE5yeBIq5d+fkOjROE1PGNQnfJGPPH+TnnCLGfkhbUlvFv9GmQhtJNWjiNf/0ZaS9R78nKUq3s+E5s3bSE19KtbsKUH/H4yJATkET94i1TPYn8Lshka6E6H8C7LeSrBgrLhqIKydGQj7WqUl5CVxwtj/CImIpzGYmG84m/tTSaOvuvCBugt270bJUmweaHgr9T5+SM83R+rWiFTzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6wAQhHs/v80eB+VGYA7EJ7a9f6veMMm8edlI2gyiT8=;
 b=p/yiNL2hQiWCmgYUKuviAATZE0e1nxKMQv6HcGM4jisQDgHHqBTI5C9glrPMvhuv6d8iZGOXIl5tvlwSUWNaWHSNDlZcAcMvftn9gvxY8vGjyK4f6MqlbxttJfhOaAz1DzoBNDWReMxSTzhzoI5urqNtUuiKl5MUkJbw/sDKiZm3K/xvP88ndsYeHhrF4JU7WzcwmjLsL/ofaE25ePMo7MOCOgvgJAR0aiMmDe/qcxP9RJpqHQaQMyA3X3felbSEv07Esn4aj08eXgCi+uxMmdZqKfYCZZH9c4Ub20cxb/NihfgTZXvMmo0at2nDdoe371s0rZLr4wzRddoKtiuz5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 19:04:11 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 19:04:11 +0000
Date: Wed, 25 Nov 2026 21:04:03 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <hangbin.liu@linux.dev>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ipv4: route: fix use-after-free in
 ipv4_confirm_neigh()
Message-ID: <20261125190403.GA466528@shredder>
References: <20261123133000.2.n0ps1edzz@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123133000.2.n0ps1edzz@gmail.com>
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9407:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 12aed7f6-701e-4a42-9ad9-08df4b26e3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|261021121427099003|10067099003|261102123227099003|11063799006|56012099006|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NuNmQOVuJ9iImkB3RWRMMCJiz0EVS0JjqSZGmQPkxIMmrnhuiKwNvc3FPKF8+bPCSRpoEj/siITgNC+D7avKt2dGNM9UpIPZ73FHL+/9xsamimk26caciPV2YaJRR0JfO8B1zMXFnM+Dn1hbsqklqwbiIVatdv+tVgkOCHB7+hDLiy5XWYX4FTUy9KpzbQ3ZXOAqi5mTTKi+UGXJN8Ge+4UOuBrVZD0f5XFc+Mz6zJp8UY2hEZ/Q7GV731boHviGH82EditKsVg3wX3VcXmJN3pC5F0Jn1h6upfOa6PqapAkkZ3v8GbU0B8VgTxI9iwLeqV8zCggjS/NCCSveDs56Hy9N+NiqINWvG1dQsh3Nz2VBEoeCOVi095cLYCKDvKKQlxrzWV1LRbTipRR8ilRUHr9ZYy8UFNfkJl7WcBeQjPF/8UeWmVtpBEIEMArKRT+7nUHiG5NxPUzwNoqfMknoOzrpX8yu65xPNMd+3MaE2QAbY9e7/Pe4hBWi9tf/nYsLpUSXLhed7UOs4YfoViwVkMcJISXfeHBXD34Kcr7VU6+HcrLi9ppsUImAjs9RLabmkpYzCkF/vp7M0Zs/swt/is6YUnono+xNFTP/Dm+LaTkPz/+m/dhC5Cxj0A+ZhiPJKtP3aVbHPZmBHNVQIbTvQ3LoPnuKxKAYCCTJP1FzR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(261021121427099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EQa+6LGvW1oTMuLW8cKWmhy17z5EoV6+QRjG1w1AiqVv/4smZKMpymlhwlNs?=
 =?us-ascii?Q?wtP3bUrtKob8cEY31btSoPbwVe2ZwZEZLadUbK9aqm8EklJBm35W58FZRyNF?=
 =?us-ascii?Q?CxXqp9/QaEIqeeJa0XjyIfuiqZmIU089Y2hiMeBoV7lCGXEngCQRW3kPWi6u?=
 =?us-ascii?Q?NFDzOPTarq5ugdw/5OppPR9QB1kp5Qt+UD/OyKzUWFEufDDtW/KbvAlSvLg4?=
 =?us-ascii?Q?YqhBr2YAI9uYEDAsVgVWmYOuDFJgbUrVjuJp57YAkvSCgX4DvzCdK3wKY7zm?=
 =?us-ascii?Q?Wnj0aLAAiBV+SBRZcTRivp1XztmPaWH5t9YQl8OLuuQbmFAC0QQkTzyxSHbW?=
 =?us-ascii?Q?bK7YLhPcCWqYOpb8DmQCYWuWQ6DOoPsuxoLhQMop6PBvS5th9Ft6+4gVkhNL?=
 =?us-ascii?Q?eD+kFF61BBYB9dgvDA1grIka+GLaWrESfiYzKY0+Oj1shcnMb8JfEqA3qqQo?=
 =?us-ascii?Q?4Rn5jCxbzFQFlcod2viTE2RWe5LxCW0SZZFET7q0p4AydVF1xgQyLQdm+jcv?=
 =?us-ascii?Q?EMuJzbTB5o63zq1uaoaO8psMpDKKqW3SJ+zdKBjdTkevjBnDnYkb0fPodvO1?=
 =?us-ascii?Q?VVNQ2fnt9UgtZIubZHGhO3UVZQOV+Uo+YOzREkrgBG1BCYD3En3hHDmjJhFA?=
 =?us-ascii?Q?7O+H/GVq6OJ9PR72Yo3SM2zVjOoj0z+dB0EDH9oXRCbYxHNkqNmk6vjWR+70?=
 =?us-ascii?Q?PL9ilbKRUFzLpBj4gGeR3/3RDNP+8AWTYpRiIOGsr/Gsa5o5kUpT5mvybIuA?=
 =?us-ascii?Q?CaK4ilfV26yGgLBIZwyKHXLnv34/HginlGO6DQSvChWO3hXod9/vZrwEYC3O?=
 =?us-ascii?Q?IMWq1bGliS0RLv9VcBCTrUDN/b86glEH4m/Aa6ESDYmdLx7SCCcf5fpdLukB?=
 =?us-ascii?Q?EH8IUNRj/CCC52QXpBj3V3x1sdTCqydKo3Jg/rpfi37HMLIJr7RtawPqQyb2?=
 =?us-ascii?Q?msyiCWVSQ3SrX8yOuGqfmXgghSmQQYN9igSzeXnW4zepHxZNRCi4lK+NAw0a?=
 =?us-ascii?Q?Gtx3ygZ9h4ZM+DMabYxdylH1+rtsNik5pls5aFNrZpUFQcaNE17GtBVrWQ7X?=
 =?us-ascii?Q?DMIka3aOac5tQW6KNXm9XIB7U7295H+CnHyCoeY3mpWGCOBwsBs6khnKkzj+?=
 =?us-ascii?Q?YFTHddDYtxQUdxNJfRK0a9bXqWzElCzJgjvwr+VLV8JkuwbZgTN3nSfwaQTU?=
 =?us-ascii?Q?Iwz7sWioUWXVdhQktr6oa8ZXWPX1tiWyRsG1rzPvbTWr2PBuEKwHOZmoRK4P?=
 =?us-ascii?Q?Dl33DfFWX2YcJeTwz8UuXc8M7xhXj7oBa4cGH/WstlhzqDqTVe6xeAmUImME?=
 =?us-ascii?Q?9XDiE5uFkF26mEEV+0JJePhphyCtf5CFe+Hkt2tYtkqBkT8NYQb14aEw54Xg?=
 =?us-ascii?Q?McepZBGptrqN5t6bSS6gym/D9xQOqAJHu7zGQk4eq4dJSFIcnEmxnoYVcKCz?=
 =?us-ascii?Q?fQZVCVeaLktb84XGcB73R2l/0RTnHzbpnw8MPRXd0MIjAMDs7gjdlSrVGNUK?=
 =?us-ascii?Q?Bf5NV6aSgMvFn2gl09sZozuvx01pPu6+3cFkSkJhUsndZAFLMTMqdH3XJDVT?=
 =?us-ascii?Q?qm2svEyRSdxYq9JDAV8qyrDJarriyYuFLOAYuLuA1Q6z6/0mwt0WUV6vIXta?=
 =?us-ascii?Q?JZ99RDEwBlwsg+jYVZiuW6OEm7s3ZCuSI7vIbuYsen1PrEQcC1IydZycsGin?=
 =?us-ascii?Q?AAP5n/s9Rcnpv40OfA+M4dHh97ouzslhXho2KBTn3Hbb1aUN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aed7f6-701e-4a42-9ad9-08df4b26e3b3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 19:04:11.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmaLPJcUaijSLsjH00BDyCqg5PFFwxt/v247SwE+gGGsPj2LMm9ENMocUO5scXozAI3aYMIrXccQPHcDVDwkfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

On Mon, Nov 23, 2026 at 01:30:00PM +0800, Zhou Qiuyue wrote:
> 
> ipv4_confirm_neigh() loads dst->dev with dst_dev() and hands the
> resulting net_device to the neighbour lookup.  The load is outside any
> RCU read-side section: __ipv4_confirm_neigh() does take rcu_read_lock(),
> but only after the pointer has been read, which is too late to protect
> it.  The load is only a READ_ONCE(); it does not pin the device.
> udp_sendmsg(), raw_sendmsg() and ping_v4_sendmsg() reach
> dst_confirm_neigh() when sendmsg() is issued with MSG_CONFIRM and
> MSG_PROBE, without holding RCU or a net_device reference.
> 
> The first stale field read is dev_net(dev) in arp_table(), reached from
> the neighbour lookup.  Route teardown drops the reference the dst held on
> the device: dst_dev_put() does it for dsts removed from the fib tree, and
> rt_flush_dev() does it for uncached routes.  Both replace dst->dev with
> blackhole_netdev, so a reader that loaded the old pointer just before the
> replacement can dereference a freed net_device.
> 
> Take rcu_read_lock(), load the device with dst_dev_rcu(), and keep the
> section through the gateway dispatch and __ipv4_confirm_neigh().

[...]

> Fixes: 95c47f9cf5e0 ("ipv4: call dst_dev_put() properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>

Should be posted together with the IPv6 patches:

https://lore.kernel.org/netdev/20261125190113.GA421469@shredder/

pw-bot: cr
