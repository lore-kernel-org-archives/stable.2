Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793610225;
	b=WSc4u8NRKRJPB9tFiD8uXVCRGlwe9j7gh6T0Jh7DDTf8xEkNkhnfcibzNklMAY1TuF2C
	 7BxAx8/OtaZ2rWVs1J5zhQzgbAUePRnzvAkplo/wfIfDGk5Ad0o+VAhpPK3pZ/gVClSJL
	 /fiLjk1e/PS1uODL2pJWOgfby4t+48HvQ7WAyTD01UeO4VWHEUiYyl9Xsnc7VzbW69PG+
	 Qz/YyevNYRPdZ7RtKrTPbQzgvLPL84eOIy9i0r/IWxrGlE13soVRWkOBWSc9uRAqXO/Ab
	 7emVA2bKyAD3QZ45lY2OsSRC7IdZCF+CMZ2SIBSK56SpmIUEV9SPFJDl9P0ALtJerpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610225;
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
	bh=CIQUc8TV2VSKWd6WDRwUyM4Y6Sb8hDxkW9XfW/fg2to=;
	b=uLApAFdTvoHrnMZgzNzk64HiVMZXnX0O/g4KJItJ5LXLeGfkp/vjHgh/dnTJl4IrGK19
	 fap5QbXsHwhAO15JLBKIKnjddF0gIy8g3DwZI80JZNJqdFhrcjF6GodyJusArXo2JsGT/
	 aciKm481xc4dZfdb8MqlVcKGX1k3ZCl6UgyZNb2OmUU8ZigKnYn+/x3Enff/6/Y/RGuAp
	 /6+cKap7tmdcs5PzGJlgmyYOwQgmrv9E9LMmDEtfxNe6fViUPqPayPtRto+LsLPY2O+xc
	 DJ5vY5rKYrYy//d6Xuk/g+9nFgNKDmX/DLVZkuarAD8Nx9D4S5joZoKfiuGbX6s+jTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CVnZomWx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.32
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F316606A324;
	Mon,  2 Nov 2026 09:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F316606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CVnZomWx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6RfAFdXMaDeN2Wxouoifti0kgPSTo9gzYsBnHVEUnh9Jxg4nBvSWVBbCn3L/NNbdIbyYWczWf/MBZGKxUEh+nFt0rl+K0WqfQZa3b0zqm9DhTe9s9P0DPKycIdElVolfho8a+Tu6lEN6nQQx9i8r/efp32yzfH59Q0RNpai4LuexLU0QKKsge6hAzFq/2gCDuSqReSuZxbRospTx6ne/6Bu7eiVuJKwki5uYpq3teXR8zLy7Nq3WQF+NqNYbAQBC7hd8SPHd0x3IL9tInntvVEdcvQhRYYJ7Ta7xzeBhQm8eiFKUbV54uUIoUOFTBShoV6FZeiWF74VawuyLNPUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIQUc8TV2VSKWd6WDRwUyM4Y6Sb8hDxkW9XfW/fg2to=;
 b=PX3Huatx+Ux1XZ5oRjJTy49wjyoIlgVJjcG3xnIeNmyUVWZF8Q5kZ3nA/muwp+KS88CxG5WZmZW9lxlsX/3ePMf2C7zFqT1Mt1S4b/MwDJ1mYXbNoSSMQRa2hFqH27LsPmVvfK6xPc/Wybt0JhOL8YoWD0yZUOIEiRo+ioTzuWzIoR3MlQH6f2X3hpWhnJtZBiAgw5E2Ubfjj9ds+dFFUmTU5B3I6FYTFojoaPkvwPct6xg2m9aVg2t6Dio3H77yB7j3gJMve58qzyINd66s7yDsLTiPmrBFHhsfqQK0UHD/AlStvKqJQ5G4cuz0v70x1NCsC2XiveN9EBkUNxayTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIQUc8TV2VSKWd6WDRwUyM4Y6Sb8hDxkW9XfW/fg2to=;
 b=CVnZomWx/fgKtjKAKqF/KDfnotzRR3ZNEXc3ugbqiuvS7Dcwd6Q2tPMeTdEulISTnjVy0+Tb8Ke56jiVP7IcKZ9MKIlY2sKaALvjhDUEeyahKN8tRcA6D2o40Wr8c5k7ryxgSnU0RA378Tf3sDk5rxYSpD5J5MxMhTcyB4swsn5WR2ap6pKUXHR8fzlnh/au/3ncC0L/39xU4S5n+KgwWHr4VxdjxisgDbFtlsd5f05jtgvffZ2V+tsu+2XHlSDHprJ69BUUQKhQsXvlEkGoAg+Vb0i9FFBUVx7Qnw7avckVxk/lxX8kS96c8FBLqNBc6fmoWaV6uLdaVZdwjGZYCQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 09:03:41 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Mon, 2 Nov 2026
 09:03:41 +0000
Date: Mon, 2 Nov 2026 11:03:32 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2 net] inet: frags: limit the truesize of a reassembly
 queue
Message-ID: <20261102090332.GA807674@shredder>
References: <20261030081225.2575462-1-edumazet@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030081225.2575462-1-edumazet@kernel.org>
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: e45417e1-6e2b-48ee-5cba-08df38c030bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	iUkbshZm86u5fMXbJjzoOn8zShqgjOm1TljlKfPNSBl70iJCbMDsBPN38TalzYrQUM1Ism5SsfrWBNWtabVYgpMfcZtbklkEcVXEgim5P/ULy+DGf2tlVaa7q7t5u+2nBqD/5dqtnJ3PJToGJm6yChGDxDQtdspl/B0+kf61s9+DyEcGM68wSFsQHnzP6hxoFgWECJyx9IbJ7c0IqDHLs98hDszHhQRNPRLN8ftnrHkzCG0f7wG2cgZ2s5+qltZIxkLM+Pl6lbzYbLBsx3PBFwna8jzUunlY4I1adTfKRPTtJ7dAVuEVGk9Xhc78kiyxhW41D0j5GJELfBdavJ38Kf3nEKLycrQPYqoGfq5usTRL2yyIwDFuoR4lkKHR6fSAL8L23JVau0gV0WDoIA0Y88aCDRZKMnyWbsspIQZgkk9oMC7q0RfzGZaZN+SjjUrylKR3Qj7I0Jdh3QIyFf2dHCweTpdvpfO6R0bVCJcjeyh6oQ02NFXpzmzB7rgT5vigPKk5OKTLPV4kokWqmNumzagSHYXQtOoG3zO1fuD1a5tDXK6YXJpzAbSk2gqen5DMO6A56S1Tbqd/FCuOHm/C4GmwOZiq/9kWFBr8pybA24yEhq2HSygQzO25CBlr5wB7pnw33qeHxTvzoxdrt9EWX8ILwXmWQc7nnKgGAiHVV4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnSgFvZ+lCvfMkhhuFiRdT6L2f1A8jOagu/MFFPtaR5pNCEE2t2787tPpZ9q?=
 =?us-ascii?Q?OEUJNTrH2UsfcjAvFVdR/NiJX4Zx+E+GMWN6kC1h6+DokEJ/6ne8qp8ij2fb?=
 =?us-ascii?Q?6fWW0CEyIqIWYDGe5N4RZKsw/AvN2wGmYV5vEX8frGA5FW44cDZXxfANtYhz?=
 =?us-ascii?Q?bYjMfdI5k3JS4ZReNY6HBwi572PqPlM3RbR5/NpqI98nWI2VqX96ug4ufpMu?=
 =?us-ascii?Q?MYdjc2g+9jnIFuPgwwhLKd/cXQZg1n0H743GPSYRHWwSVRjgMO8LrZnSJxH/?=
 =?us-ascii?Q?HRX8GRafMOf0k8KeU/6VjNYNhg8fCSRo1Hx1IDI2goUyuIh+ZXe5cIfC7mqP?=
 =?us-ascii?Q?cghQURX8QImpsUkuFbiuc+/SpI5wTSpDqSxEPAnk6xELxSdZQpOdOkNTGZ31?=
 =?us-ascii?Q?t9YekGuQVDTowOyuDzy3K5TCDQ+VvT3abBzQyjCg8/ERXYAK4PHqosG07Kzu?=
 =?us-ascii?Q?WWdsy0hpDJ15y2s0nbNkX08DNWZYGCagc83llVdhoWQ8hWdO30ctk2B6WuWb?=
 =?us-ascii?Q?jsngipcQzqenVPbjMIn/PeNxILc8VCtiLcon9r2uY6Mwy2RVIeK2+u2M2FZd?=
 =?us-ascii?Q?eUVsmifwMC6JRW0x4qywdVWYlI/ReJh5Njbnv+pHKjSc7oe3jXSuLwvLp5cK?=
 =?us-ascii?Q?8ZrAVfPtHRwoTEwePei9LgG0MGMzVPAZhj7cJDzaYXHRgU4T0468HoPExy0j?=
 =?us-ascii?Q?3GH/VcT0VAx+Aj1zTjxyYcV48JCMJ6Ed2x7uatlzrYxHnsaw/FXXBGAJVTmm?=
 =?us-ascii?Q?Zud8Zud31oI9IElE85a+Pfl+RKAwzoxeHYBDqxi6ncZBaNnqKLytXgZHzih6?=
 =?us-ascii?Q?/N9bRCxQHeoceZsGbF+iIMe9ugCv86jtE4I+EBI/LH2rbJxZkbux7l2veMSY?=
 =?us-ascii?Q?bGtvGthwRxAjZl47i5wbYx6D8iehUiNbum3JwZfPWftB/WhfzJW02FTnXJfD?=
 =?us-ascii?Q?DZ0ntiIz4azMg3QaPggbvwS1MAgQQZ3vMGzAuZrFjfOInpumUcZTTQJQi9pY?=
 =?us-ascii?Q?7NpTxpp65pZKO2ox0DrS5US9DLzsj+0rU7nBh91QEXg7j/qKMjUGArJRd9tt?=
 =?us-ascii?Q?ESJeTQNbbMkuhKpGIEnsoi+KP2+Ql9Unyd3/VM5oIs/f/ZuBGAKxgVEgrD99?=
 =?us-ascii?Q?wuy9TTTIIZTR0N9YNyHZ5idlW/5xZewdaQM4K5Act1kVl7wnRPQ8gcwrPnNN?=
 =?us-ascii?Q?ktIov9+IKv9ZAtpLJE6zWhNMIi0Y9eMSlLj1eGlPAX7tT/gdPxhkls+nTITA?=
 =?us-ascii?Q?vPxvWhGKcK1+aRrd+zjreKWREkO93JOAvySrajKZz5mO/3nDc004DtWhTjeZ?=
 =?us-ascii?Q?Z1vE+gxD1ho+C85+YSTtL6GPgDUAmkkOkIl02u5fpFzuklfjE5oGxU/Hxvw1?=
 =?us-ascii?Q?WybwPqCPGg8LFW1dtC6UvJ5O4Bgue479xLZuudAiBjDCZSBh/vmndq/f37UC?=
 =?us-ascii?Q?Jsr3pVUyu74At19lDvixEp8rvJ8i+8XPJWLuBiuHlaw0Er3iWReA8XHl3PAj?=
 =?us-ascii?Q?G61ZpFXzrmD4rctF8Pg2y0pO/nD9t7uxriLJVi/S2EnrJX9rlTM373MB6enS?=
 =?us-ascii?Q?pinnOSTEi7r/rt+pVbXRMKVSRddTGwoBNKVyuYc97XpFai+IuOyxH4Jx/OHS?=
 =?us-ascii?Q?j2Mjxqj8GUymd5EwCEdRfwlH212fcFfS6pb36euaqHkOUXbCj5TjBqvh0YU7?=
 =?us-ascii?Q?z3YrzSYF4fAVG2gsvfEr4L9eDaVoWFyEckSmHScp6OgwB5Gy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45417e1-6e2b-48ee-5cba-08df38c030bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:03:41.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlmkV9Wmt9g3WjltCnzE+H7r1BKSKAFH/vY4OOMZERaEUIn3BN3kz63XWZdd0DzpS67UwBtz5knMDcD2lmUZxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403

On Fri, Oct 30, 2026 at 09:12:25AM +0100, Eric Dumazet wrote:
> The truesize of fragments in a reassembly queue is only bounded by
> the per netns ipfrag_high_thresh sysctl, which has no upper limit.
> 
> inet_frag_reasm_finish() sums the truesize of all fragments in an int.
> If this sum reaches 2^32, it wraps, and the final sk_wmem_alloc
> adjustment of the socket owning the reassembled skb can cancel its own
> reference, leading to a use-after-free of this socket.
> 
> This can be triggered from an unprivileged user/network namespace,
> raising ipfrag_high_thresh and using padded TUN packets, which keep
> a large truesize after being trimmed by ip_rcv_core().
> 
> Track the sum of the truesize of fragments in each queue, and refuse
> a fragment that would make it bigger than INT_MAX / 2. Callers kill
> the queue on this error. This bound is far above the needs of
> legitimate traffic.
> 
> Fixes: 18685451fc4e ("inet: inet_defrag: prevent sk release while still in use")
> Cc: stable@vger.kernel.org
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Cc: Florian Westphal <fw@strlen.de>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
