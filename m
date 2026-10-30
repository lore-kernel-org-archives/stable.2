Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793373402;
	b=VNGj7h5mT8PRDt45z6ytS3fY3sr2xweqPwOp26MsIOj/xnfa8bAXRYNt6QCw+VH9sfme
	 tyBjxztZ8xbUlxOboQlIO9l+65PYG6t/snjIeCAvhVGVBDucZV81jk6LMXGqJ7/Jmhp/L
	 dGCK4yJX4QAXZamwYNHa9pW93HxIoJdxqaOJsA8hBzL6wLHvYyt+XMOskfHxEW2TTRWUZ
	 3H34OH1cx/lqhDutRWhRAEx8KuI+ZyUOKvMNBw049rOyWoLbJnEqyZJpWki5AtN9Tap9A
	 WTu9mpLpibXEfWiM7Fx/PlsXhWZTUKYL20KWIr6uj7s0VXWRJZ4q6O3v6gXVfQxjHMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373402;
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
	bh=qzCJMTUBINmSEu3oRmunHpTwoUl8UzbEwXY/5Mw14L4=;
	b=1UcDwHBkoBNp8mRgv0ZB7evRhs4qVmiRyLxkG7jiwfsV0IrWNauWroSwK3IpvKzXBt+U
	 I/0JXszdesEt8UP/daR9skhF/wy0mRDIdqXBaZquzTx+m6qlm9ycvdLXY3K/yVLBeem7O
	 Umr+fw9ytC8UUaISONKcgepcJ7IrcqYfo+ohvxaqf6vRx5D9Cc58i4+lL8zMrbQtgN4wg
	 GU2ytcT5og0BNyXICr0SLSXXbzJiWjKNUIGrn29eiXMYbJH4SKOWmSu+cTcMGbjHq2dW0
	 yfoDh2bfhkSjvqsZ86PxFv/QZ3u+3TbJARxRjf4thwcLhibORaR180RkpXFM7b9kiFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OkjEzQqs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.64
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9B606A31D;
	Fri, 30 Oct 2026 15:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF9B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OkjEzQqs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDLBwsnWY3rrCSk3LEc/3ljrsZW3W43VUk2d9RehR2mveYLbF+7UNGao5AoZvRnwg8m+26m9w0NTC3ccYNL/Lh352mLS0Pt4PzHeenottuD5kN+IwEyQ0pBV4qcyKLceWxRueF3rknj7C3UUEBn4TWUNq5c9XzcGFojEdFUjLm9HsrzakNxJ4eOrUT98vVeyLrnnYUQmMbJWe0B3KS4QBQ8z8MJIZIeAEq/G3CxlKtFw6WeTrU1pqNEq+j3v4OkppX1bNybd/feRhG7kvpelcHz62pHbpFczktrsO6muZOoonKZKQkl2X/rTHAyDnb2sV81Ok+88cuAO+fG78taihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzCJMTUBINmSEu3oRmunHpTwoUl8UzbEwXY/5Mw14L4=;
 b=wWa8R9JZPrf3q8ILg3WSpTwbZ/nvucy+o/4+KMc/hWTn6UvQbYskfKFpOO4E+KeKBOP0Em3fsY7U7kA72BHZCtPo5DDJCVy0qkOhvLZVoSjG7yNb0PwiUAqTKsJAHbMh4HuBWTBUqIeC7ep20i4E0G5KuBTBfBzN+sUkJR5rgupgYEZxHuyGc67KScbnLKb7zfns2grMdyETCTpo4VhQlydE9PovPCHLGlffcHwCDqtO3cQEOlI8ByEKrRdDCIFn3J/6+qNMIZtYm+o9FyKtOYDDcelRgNQOLpUFH+R5vo9EJ1wLgN6zfZu5a5ecY309NzaMict/w9UNynNfVEnRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzCJMTUBINmSEu3oRmunHpTwoUl8UzbEwXY/5Mw14L4=;
 b=OkjEzQqseKfPx8vJ6cQ90//JF4jzeaNKa6k3Ufrj/2+yPPD66NgLmKC+C7pd5D4qMHECZ7Xi07GBh66lOn8PBiWutLmRZERExO7hHK+iNGWTfzBHUy844p/gdh4GZ0n5WbcF/eeESMcr5T4d6a2LvgL6kHRW8v4ulsCo4J8HFoRsVM6ahzR2Sxq8VHhvV3ATjgw+nHzjCLoG8snUBDHH+UZb3QLvlVLADgsIziLltBSWlJtmzYNAhbZ3zATVjy4eJxhbaEe69DesLGicv2699L8J220k23SJDyQNtWhAGAmMe7qVNlS6lx/VZPQSspwFc8Z0knVJQhHts4LDtbZb7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA3PR12MB062244.namprd12.prod.outlook.com (2603:10b6:208:711::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:16:39 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 15:16:39 +0000
Date: Fri, 30 Oct 2026 17:16:29 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kuniyu@google.com, xeb@mail.ru,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net] ip6_gre: fix changelink conflict checks for L2
 tunnels
Message-ID: <20261030151629.GA85001@shredder>
References: <20261028115710.27806-1-yanxia@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028115710.27806-1-yanxia@cmss.chinamobile.com>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA3PR12MB062244:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c94fe9-782d-4d6a-c209-08df3698cbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|56012099006|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Rm0otVqeCo4xdTeOw9pl7Ox1hN59joSCdhyNDKO+L20fKiIYCpYtAanc5RO4uHowHxGH1oFISTZs5WmNdSD1se765vaE5AQNPxTM4Xb1v+cpjD5xfazYXtPB+0fXueGhL+vrfZTP0wJcVMK7eOZQ6mgDr50E7WQL1UVASIInqoParehcRdm0c3jy6xQaveXubzA1cG6Q8HVRyHUaMBaidMup74R8GAJbhEBEV64EHrLC1s+lmhbezu5S0STP+TF1gura7bkqycVbG4BFvr0K7vTTbh4H39gqSqSGduhLTfLPYiYZbGCcPYUY5WBLgBIhGv5WjcqivKLuqzpxSqwFq3ekuHwFc9DXABCHXb09dHtta4tnOSz3o4A/bOR5K22zGT0gEAiEjMtQhjYxbw/52glNF0p4zLmxv9XFKySYLIu5T40NopFtKviSkl9i8m0BFVyMLh0Mj73soV1t0L/y6fRWW4K+HzAPTjBFmpk+GkAZ1pF2W0pQjybUuJfHMoonu0Yi7ZnTcuFqQW+plp3+giurYyHQNaIIUwvm9IGrV5n9Ihd/LO3rwUJ2trx5qBauuoLoKpVWiWHOn7+kHh4A0gUSgASldpGltCJdAg0O3tGVJqwN4sT9WQTfN6TPz8Oq3Hrv7Qd/FB5zmnqP8oNuMOwJgtf+a1jQwRP0L6THVJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkKdsWafkOOHXzyIgQj7dqgMRD3EUtrlNMTQafEgY+j8+BqPSMZLLUzrFZQG?=
 =?us-ascii?Q?qI6uRcv2AcYHNep/vcJ+3FsWeoAN2HMw8TUeXnlCymrEZEMm8SxLOjWUnW0D?=
 =?us-ascii?Q?s1fvJfhApdV/IR6SBAbIfG69y+IQJZVW9qB1LX8A/DhzzGhWLDKkAqZhAZRg?=
 =?us-ascii?Q?a/qV3AKBSIfiHj5XPF3CKGWEvg0mqxgFT3H62UM1/w6F1Y8ScBBkdUR+F2O1?=
 =?us-ascii?Q?vo6WLgBIvFM2qk57LHr9wbtTMn+1QHw2qlzcd+vTKSG3uqqfxIXJf4eFJGXu?=
 =?us-ascii?Q?qXRq36AJdeB2e8sxf4CGb1J8NmjmhZpIJLahh2c/EXliZhYFju7Srn5bug0j?=
 =?us-ascii?Q?0q+9s7j4K1Dr6Jycfr9IhggWEHTt/bagzJqWQa67aIxRSRxj24G2whvs6giz?=
 =?us-ascii?Q?YdarCBN5j4qhRlE5wlA2g2522RbFhiHkwilwFI5mT1hct2pkUZ7mCfxwlH99?=
 =?us-ascii?Q?srnucmcwm+a9jAcmV69REmU9W4IE4CV+6PUiF9RUqJyQYwvlgwDKykDPuR8o?=
 =?us-ascii?Q?NovNmr6807+P/ACDkoClqtfooyHs2e/FU+xBSJmI5mjzPpvMqpKGmwLe4cOR?=
 =?us-ascii?Q?DCSTfV8GlWSXDtyBPj4qJYSUkL11UDP9UxkLLanfogl0iXYiW+yz6fsrfla4?=
 =?us-ascii?Q?pks6DJ/sbbd8G19OKYnShzpIA6ZAnWnjhW418LRqRCsQ9Pyb3MdcjfD08k2b?=
 =?us-ascii?Q?xgG7Lm+4xRu8cICt3ej/VYAnrVNaTgoE/4mKngWilI4Jdbl2+N0n4JofKVre?=
 =?us-ascii?Q?mjdFGidGUeZFSG96Q1EfKWyg6vZi2TkoI54RsDjBMT9tNXcdq8OJeEeudGQY?=
 =?us-ascii?Q?11h6nqSwqDIdWFIvqdyJXKZjIg9jQLKChZUpJGHRUxul9K2MOn4I18HBI9hS?=
 =?us-ascii?Q?74L3H9Yd9idUMBa8486hHnOtbmDb6dGUAmu/U1ShfSyMViNOzTMH7CuxHHR5?=
 =?us-ascii?Q?7ClZw4InKDL2D6Eh/zckGCUVMNIkfgCbXRVl46tDK37zE2lupO4SEW1nXl9q?=
 =?us-ascii?Q?2X08YKq65C/4EgZm9EHG5oOhzIpnzlYJOJXHCP5Kl3TUhY+ceUmeZVrC3ijw?=
 =?us-ascii?Q?CshXNwYugZYWIZt5Perr93UeUkFw34cf1kdmP/L0yTaezdK7Dbj6Dfjy54jE?=
 =?us-ascii?Q?qPSrqYHIGNSl1Ngb58nbrFbQE/AgspRUx02CXOuvVBjVrJ3WQTygPaFt0Ukj?=
 =?us-ascii?Q?6ZeZZ+mll+PgmxYGXx7guTqxE5Kdpg1j/bfumwiN0KyqHdSZJGiWDrixHxoU?=
 =?us-ascii?Q?cpLx2ViWgaq9g+JfknfIVlzY9IknvWuk+OPAn22Q81O4asjKke953MaUXy7w?=
 =?us-ascii?Q?s4aREJjRdVAwmJDLiKPBNwLnQjf+ztvS9r857qrINmZJ9Ck4J0sTV4Agifxg?=
 =?us-ascii?Q?PXME2rOdSnqlrVA0A7ITTfLPFQ/qzS5da2zuhgnt1CcelKB4LzFfau5gcJQD?=
 =?us-ascii?Q?wUDgNbgxJsHkNvCxR5qp+TTz5FwGBmQuIZ3yEJi8D/0KmuDwwCitUrd/u1UW?=
 =?us-ascii?Q?ubAMwX5s/fYCLSXzJWlpsZm4lw6UyrS1A+f2aoROUMBAdA7xfWAV8XUDkGmk?=
 =?us-ascii?Q?ySWAxHlqKJJnbur0KNB6CHPn8D0ls8Tbad2Le7JVzPiwk9vJtvgDGKbtwOC6?=
 =?us-ascii?Q?OigrbfIzPOEcTREhyLHTestAgbTXz9/CzVdK1pEySlEjU/Q1RarCnHmgXCx5?=
 =?us-ascii?Q?nYDjeNDtdp6PjGo1b3HcA11d+mQerPjxH5ODXw7DXYoJLVn1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c94fe9-782d-4d6a-c209-08df3698cbaa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:16:39.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lx5JvK/o2bOXnAeyrsC0cTNPhOMtbHVLmO5C5KTN3Uea3ZPg2DKYvK/9zb+669ctP46tQTUI/fNuoINDbNAjfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB062244

On Wed, Oct 28, 2026 at 07:57:10PM +0800, Xia Yan wrote:
> ip6gre_changelink_common() calls ip6gre_tunnel_locate(), which only
> looks for ARPHRD_IP6GRE devices. The same changelink helper also handles
> ip6gretap and ip6erspan devices.
> 
> This lets an L2 tunnel change its parameters to match another L2 tunnel,
> since the duplicate check looks for an L3 device instead. Incoming
> packets can then be delivered to the wrong interface. An L3 tunnel with
> matching parameters can also make a valid L2 update fail with EEXIST.
> 
> Use ip6gre_tunnel_find() with dev->type, as the newlink paths do.
> 
> Found while comparing the duplicate checks in newlink and changelink.
> Confirmed with ip link commands. For example, with an IPv6 underlay
> named under already configured:
> 
>   ip link add tap1 type ip6gretap local fd26:106::1 \
>       remote fd26:106::2 key 100 dev under
>   ip link add tap2 type ip6gretap local fd26:106::1 \
>       remote fd26:106::2 key 200 dev under
>   ip link set tap1 up
>   ip link set tap2 up
>   ip link set tap2 type ip6gretap key 100
> 
> Before the fix, the last command succeeds and received frames move from
> tap1 to tap2. After the fix, it fails with EEXIST and tap2 is unchanged.
> 
> Tested with standalone namespace tests in UML, with three runs each for
> ip6gretap and ip6erspan, and with L3 GRE IPv4/IPv6 traffic and normal
> tunnel updates. Full x86_64 W=1 builds with adjusted configurations
> completed before and after with no new diagnostics.
> 
> Fixes: c12b395a4664 ("gre: Support GRE over IPv6")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Diff looks OK, but this is not a regression [1][2][3]. Broken since 2012
and nobody complained. Please remove the Fixes and stable tags and
target net-next when it re-opens [4].

[1] https://lore.kernel.org/netdev/CAHk-=wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com/
[2] https://lkml.org/lkml/2018/6/24/113
[3] https://lwn.net/Articles/1074171/
[4] https://netdev.bots.linux.dev/net-next.html
