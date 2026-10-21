Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792578389;
	b=c0zSLIu1WG02Nrjk1mhj6EwvyNww1eXbB04vJtIyXLVLB9AnezeAcqL6dqSzcGpqlzw4
	 Sgsmex+vcEoIs/xUhd8Ifmz1T62uZnecYm+MJpx0jOm3nWO7bA1vOZaKAbUruiEBuNq0l
	 UXhPCVYOZmRWA0hGVMuAulR10HHSFjVsX1GQgdIlE85Yp1Wihx4BrrBiwpIyGkqifbgdx
	 LIzzehY8Aa9rnkfHxidAUEMsfSx/pzA3Dbudr9AINkQhjAm+9+DZEzsMFzbTDytmjHTtd
	 K5RtXCepLCNEwFh2q3WDkp7n7IG918b0/T6mcnnfiFZYHam2oPuque3DJ4m1Zx/AluQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578389;
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
	bh=37khzORTcGvuIU86cexVxhangll/dY5I50ZEUw/15eE=;
	b=vHXwogOL+oto37KzZ4dFQvqHSJvx4BUQARTDRdjQTP3pTuw74zdnVnoIK4w2XwmvXr3f
	 Uux6t2rq7a4qzpkcmQiOeQXWet8+HxcMsqRLCs59scnASvUmZNOWM8kqkkWRg6NPgvpHY
	 7xm+mW37ugHdSxYYF4ch6MtLFHxXctCmWJapq0+NxBW/S52fgN2A2Kwtmji6v2oqPUQ+y
	 udYqi0vSjQAbk1YlvrRqOEb1hWguu8B4ThYW5LweMyAO2k8KvV9/JI3ZBA7Q0kFEzc+gS
	 aK8dkCSKDuojNmBTh57IRid2b1Wis/6TXBOw/ccgMoMPo80/wlap4KLeqMPmeSrL9ZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="OAvGjDQ/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.2
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD9606A32F;
	Wed, 21 Oct 2026 10:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ABD9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OAvGjDQ/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcIc0UNRxJXpabEnIzQaC++V2Zdn+QEX6NTJbDo3MBaQL1nKI9y6vb9TiIw1HustrB63+foYZiN6SPxORJLyzQwtp/jRrN7x6ShQwmC0wdQkWxjqCTjebQJw6EQrsSdo0mh1hiFmLhV/K/Ssp14TdVicBMkyNhZJmAoRClH27YulTWpiQuCQJCKdAMMr8sCJ5ajAstK/NEI+IXCFHEJbrxvO5LODsp4zzdr58Vx/b7bVNbRcKN5/hoCYOhKirvAiG3lUGIj7lywzCLLasSGsA6NJSfoNkx6M2fPY39hIKZb4eEUMdKDgbtQkRoWrJmu2/Xj5vfzRv1J/LFCP9MIolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37khzORTcGvuIU86cexVxhangll/dY5I50ZEUw/15eE=;
 b=woywUeMCr+j08HWwfC9Fc2eWE5RP/B8cfMSUQ27BiUYI2gGunezBE6luVMm/lajakMwdDISMQZTFGgaAC2v3fC2TCY9Zem47BmBUMJK2SzKFhf1BCWuV7JeBmhlRn69GanGq6h+CaXB2oCr1s4ycI4bGeRgPlcQ+C8eHLS0fJIgneg0BJD+evRfkzXwi3n0rqDcZrcGER2icfBljGpmI4O0rRHawE79Cvlh9IaQtrUwO+Y4pAoJInfWSjbFuDvzv+Da5tSJIRDPZclLa6TWYqeEvK361PQH0U2zbi6deTupfaRLhxodH7hKddCdIIj08ZxuvwqjSV+3iGSDkoetoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37khzORTcGvuIU86cexVxhangll/dY5I50ZEUw/15eE=;
 b=OAvGjDQ/7jcr8HL4yIlsVqnK4P6mP5DODTSTemBH4HPhrGSwny3Pw4+TS3LzJPyzqTCWb5r8WVek0FnVqo33FM/X0hAxn++QeXqVVZLrNrx8brpE9bVKEOnVIV+8rDwiDdaksdp6TVXoSjdpCPiTquqUN0O+e5Z5+RP7hUGUyWtl4yr6393d/r4HrY5nMZ2unyFNwU4UrouEfqC4Z5a3ql6o5PsYUehVyZw8YTyhRDj+RCvpeLKsSAMIriysER7YKN68g9dw/9vQI05VPtcHof2nBI9tf91SqjGnOX37BBCCuTzsDAs2BSfESQDBqYgHNYhHfrvhhYpikY18bAEhKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 10:26:24 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 10:26:24 +0000
Date: Wed, 21 Oct 2026 13:26:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Ferruh Yigit <ferruh.yigit@amd.com>,
	Antoine Tenart <atenart@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Seungwon Bae <qotmddnjs@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] vxlan: reject adding a remote to a nexthop fdb
 entry
Message-ID: <20261021102614.GA3351287@shredder>
References: <20261020034531.1420194-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020034531.1420194-1-bsdhenrymartin@gmail.com>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc0b53b-19e0-4777-2fa6-08df2f5dc1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	d3wTZKz8SdXVqPtNerueC/FVuwWyb4t4Q6xM0T8uBOgHxrFOb7rV6aClOeeLJPNawE5uBHByLVykMwzvKEofInm315PEx/WnoyG1nLHdrthkkTiRjqMdtINUO7enehuBvXlukYxCYLoUEv0+aIKHiT+tzPHfeJDZZOCJNld7mBBjnCcxQGsVIDPyivyw1OherV1VVvPlc50aPZ/uZfebwbmWNrEnHoo5AZClO5V6+JIPed8QE+Z9IBr8sbh528ggeTgjs59EV9RsvbZ3MxFG8RSc10Ek38JDDakm7ckeQhK+WEEbY+U0i3fth87lRD78YaiDupd2EUH0NNonZ3Y9iwlYLDlQRE3LlOhZU44Ll9hBLuxk/TE8LwLJwAegbzjwxfvSEhyKtZKrx5rheu1Frfuy5ixCAJiVSl+UGB9POjtwyEIqw3DZMClVSWSVQXv4Fo/3oY6mEOFy2bIL0rvWuZP5hjs6rB9oKdUgNlxGfBXTTN74pwHOIGYktBqkllh12G222I+Rk0VKrY2QIFfLlD5OsH6YfF5wEL0MjgwhyuYXA/KpSglUCY2KY6pmatuqXk8849+EbVu6jqmVb9P1mvIXEwNUFDm0G6bOyHb3bj2MuJqWR8vEdaqkvEDDlOlZGebfndfaFzrfrYnAMGeCVYEvLQzAcxbunqR63yt/sH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/x4ZeMSAjZ67f6+Fs6IvJGkLDcLPFYs48kUnV2pLbqrUfj/wiQjlGTtgckmX?=
 =?us-ascii?Q?me6bKiEFUjQnEI61WNJhb3maxKghcLa5KIYi1uQIkJBkmbCDp9AQZDZHTg7f?=
 =?us-ascii?Q?N0DLK3Csl4TVyB3o5ln0Bt1SZMJPtaHnpwtjKI2RVL46yM5llklAHVzwI3KW?=
 =?us-ascii?Q?x4nuogUC5kRHyH0nZpnml492ygu2p4VGkYs498ZL3mUT5TmmYchUb3r7Jwea?=
 =?us-ascii?Q?2HPxKMPTbJmTz/r9qMOcb48ELt3uezyo3K/ydUlct2zTcPJpibBvHL9kEhNv?=
 =?us-ascii?Q?UF1V/4aRNDr1wrO3/e811n4y0ej1+JPwyaCQxfzyXx2M1aYRVX5YCbk1k5dy?=
 =?us-ascii?Q?h711wVazawTCPvBb2gWyWPzWI9SSKVCE92nLanc0HLCPmCZe/H6yVZKXxsOs?=
 =?us-ascii?Q?RihxVCMSWqDcU+NmoBpz0GgiCoHRa/c6hg9AxXxZQ/awoehEjZaAy9pUgCel?=
 =?us-ascii?Q?PoIo6315ESPEfIIueEeps7aFjnODH0uR3uhAdky8p6P8Oqca9XRHd2TuVsyr?=
 =?us-ascii?Q?+4+0xH4bKjBzbirNv4JIU5+RDr7OpRdsEmYLOkS89ag5sao4QKjOissUEzxE?=
 =?us-ascii?Q?F7FbgDFSCeHUdVgM4P54o/QTDEcJvuZ58hSJW/Q1KBLqLCpgeGsQ5j8kAVm0?=
 =?us-ascii?Q?+39qYuIc/LgMJMM9ExGF+xiXHTAO+MFH6Rl1HeDNHLuFftNe+iLM/lS6YGtM?=
 =?us-ascii?Q?Cx5v72FkRUNrI6wegTk4JGleSAHD3eNDGP1BbTdIQz9b/imWXkQG/RA5iGvt?=
 =?us-ascii?Q?oCBzWdQqB6d72Pjldu7Vg4/p9c3fk7ZBg0HUy0CsAGa4ShLKAEbYfrUy7gng?=
 =?us-ascii?Q?5crBwte2N0mLdbY3vwToOkAwiSJqPbJKsuyIg/ctnxqtYlIDljrcRJ5emeTi?=
 =?us-ascii?Q?xpvrIkpl3akNkRflq0bZE7tRZlujWb/IdoEotBJBR9eGITrsgS6pd2kboXrA?=
 =?us-ascii?Q?VQz7pHNYVFqPuU19vALSbUtZeAvh7KIE1pyzIq/E/FcxDycO6biWSHWg1jtD?=
 =?us-ascii?Q?vbDMJ3WkfQojXF9gOTqV13lo8E50Kp6tskoSPpqkOhysv9GvoklTnzJq25+Q?=
 =?us-ascii?Q?L0Y6pY1DgZXPRv0UedlLKdcuWNvGaeZcVINdLmPbu1Hnuy8oYJSfngz4M7Pe?=
 =?us-ascii?Q?6HZuFeZ/9h6stUoavUTOGkDmrW9x3p6utR+DjWXDP+c2y3pEcbj5BxMvjQUh?=
 =?us-ascii?Q?uhR8n1jKiPCKs5ODBrPJzqrCgaZ94OAfGNr3rNg+8YGIXdUo3pfgaNrW8GRK?=
 =?us-ascii?Q?vxvLd+xAd01OIidUDPbL5d3I5H8pQITzNzm7W+8ieVn1dgjiYPBQGTqNIW4c?=
 =?us-ascii?Q?Kweh3FkNO5m8bDgAmp75elsqp6q6yZEuBmRq8FP/lIS1R8LFAMh3esW/+nHA?=
 =?us-ascii?Q?GWgGtZw4qbhi6s854AcCn1ZAsC+p3zt4Tm25Zkc98fZD7PFk66rrEX7X2FB7?=
 =?us-ascii?Q?vJurKIPWatx2ZoZky3/YTlsiZTodeB63J2aaZjWk2wLfEgvrQQVUJ+EsrqbQ?=
 =?us-ascii?Q?yGdyMBSNO2p5n94nmiJLUI0MS7l+PP7Ia27nDsFVD94FKIaCFStATkjCjTk8?=
 =?us-ascii?Q?6nUwC51o6lLFGngBGvbqqw0s84PGGFCP7cdR1jrF0Tcm7fQU3ykH+ETuSSZ9?=
 =?us-ascii?Q?jYzXxNrzuvgXAo+HxVsLirERDUDAyWky1/Y4ElTCIPLhQtKIVv33stTNQiXe?=
 =?us-ascii?Q?htWVFk730/U9PfZk9uzsxIUy/CzXOWmiTp7ma/wnIPg2dpgf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc0b53b-19e0-4777-2fa6-08df2f5dc1d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:26:24.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dj3zEM1pKiJYhwEtmvaIjle2cTzopl/LScS1mRoQv+XulbrjaB9qGZ6wwH6jpmhNnbM8onJqM4xwtInqrngF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344

On Tue, Oct 20, 2026 at 11:45:31AM +0800, Henry Martin wrote:
> FDB entries backed by a nexthop group must not carry a remote
> destination list.  vxlan_fdb_update_existing() currently appends a
> remote via vxlan_fdb_append() on an NLM_F_APPEND request with a
> multicast or zero MAC even when the entry is backed by a nexthop,
> breaking that invariant through three different callers:
> 
> - "bridge fdb append" with a dst on a nexthop entry;
> - "ip link set dev vx0 type vxlan remote <ip>" (vxlan_changelink());
> - "bridge vni add/change ... group <mcast>" on a vnifilter device
>   (vxlan_update_default_fdb_entry()).
> 
> All three reach the append block with nhid == 0 and a PERMANENT
> state, so they pass the earlier nexthop checks.
> 
> Reject the combination at the top of vxlan_fdb_update_existing(),
> next to the existing nexthop guards, so a refused request has no
> side effects: placing the check in the append block instead would
> return -EOPNOTSUPP only after the entry state and flags have been
> rewritten, skipping both the notification pass and the err_notify
> rollback.
> 
> Note the resulting behavior change for the two rtnetlink callers:
> operations that previously succeeded while silently attaching an
> unused remote to a nexthop entry now fail with extack
> "Cannot add a remote to a nexthop fdb entry".
> 
> This issue was discovered by Tencent CodeBuddy Security.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

I agree that it doesn't make sense to append a remote to an FDB entry
that points to a nexthop, but what are the consequences of allowing it?
Does this patch fix a crash / memory leak? If so, the commit message
should describe it. Otherwise, this looks like net-next material
(currently closed).

Also, please add a test case in fib_nexthops.sh, in a similar fashion to
commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a
nexthop id").
