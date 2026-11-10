Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794331163;
	b=e0FSE9/19sFfzPfNyWxrzKS7moBhmxNnO5TYGDxyjIO9wESBe4UooczK8wKM9+bU0Ffo
	 7Kj8ODSu37DAGgdkxXkdi33K4ypH1/s5OB3uqK/rQN/CwPdf8tecwa092BeDZvpaHOFRx
	 8/6obJGAHeHDwxZH4rkHEDDev+eOzDdf+CrlPeQgzmpZOdYdkv8egxOwl5jIUx0S+2mWl
	 voUS+PbHW8dZS54KNtdR+v9VFcMO2hg6MauwTRRxrmx/Ky5MkYNRyqx/MxSg/SbLfV0r+
	 G/1ZnuQklHMBppu02eGY77awu6QPfaR2E/3CCWOQc6v4GDtsSbfV6JsYtiGZkdrhKTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331163;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WJ3bSF6K4GMX6h0VfqEUG8DbA3IhkMZ0dE8F0xk/4ns=;
	b=2wx4M+86Xv4/ebdyjmR1YxP1V7IWBvC6zw1+OtwZVtK1PRKhlTXAtH00xGhCBTff9YOS
	 QUl33Oometd8L25Bwv/PPhTtfNOTrRb0O6AqhN8WeX59HhHw0NaqIJktK8Y9GRIAW33mW
	 t6KtXgdfTsx1Ao8f64LX0oFkuJUUkMiKEYLpzy7krvTT827sWRk5AKYUgZDBIHnlUZ5vU
	 sGhxFL3rA6SHhYbj3I3Ankv4BwDaMtX4c4GxQFOUdkRN4H4sry76XkPohX3VLY7YDLnjI
	 SIMPJo4AzSdpoeYCnl8slFGDFZ7cyvKio/sPKIpekvX8oRXmZmq9eKwWbXAXMxiFofg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L4t5QS+q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.12
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B5606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D8B5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L4t5QS+q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mmmt4Nu5h5Ioanf4gKDGk88ff4gYTS+ahSPDGquW0qgRWGaHtQkWC7P41nmaT8o0pNJEETXVvJvIJuAGi3t+WyC4emzK1/m+LaERbUFLpn2QhRzmjAYhuPmMhdei1H2/6opSEbe013+dyCJwFt7hGvIFqWC6v2NyWRILBpPx47oBTC5OgSTZWR/ZFKERPX4PUwajStneZDbvox1HkBX4nSi5Sw/Q8k5wjcTTq74XOWKdEGBjFjkFo45CsKaTTK1ufazJw82fKtGeBtTNr/Kj7vQlsETxfYE/mxSngf7UA+IxP+k1fV7FBZrHdyBCW3lbpO/vXkjnrLQzraCO+SqhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ3bSF6K4GMX6h0VfqEUG8DbA3IhkMZ0dE8F0xk/4ns=;
 b=iz4hWTdJLJzpDxM9sjyIqyvU9ISN/l9xqCAyejD9iAPo8HVlyPKFsWSwcHowLFcP5dfQsRHPgjpWg+D02t2CSJQ162g9TezFy6mivHxgDRwdEDHeaBtolYiUIIIKh6+ocRx2et5py9xNFTQMU/P4LeQTsizyZpQvaoJmcpXgbUEEJLDhaGlkFhLWyjXlKD+LhkNvoH1ur1L27IXlxqUdNVbx+Cmp2GyU24pXfH5eUSAfeGkOa1diwHUvHA6NXcFUKf6TBd6afM+16pZO4njzUkEM5hbKppdKlBBXyJkA6QNZokaC+czfvZkoQvm7jKcd6/UqTmgXpZrU6SwhJJGZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ3bSF6K4GMX6h0VfqEUG8DbA3IhkMZ0dE8F0xk/4ns=;
 b=L4t5QS+qWMNgtNlHC9hyXUBALEQuGde79j17ah3pnnxSdxL9pf83YC3YLrMuVe/RzuzJiUCQUyoUx/9rnk+dc6OgsP0Yl3yIDi8U+jF/vrXTHDsugRkyqDFzbdprowMYk8XJ9jY9LtLnodGgsjaOtsLdzGcDyQHmCcoPiJVBaMFtntai5TxcuErG2a45y0uobXQbo3jOM3eG3l+hjZ9wYfuK3xCeC5nf1Q70sim2UDcWrU2NKybj/ncxC8qFJHQynnysO2n1Fe6PlPTSsDY0xZUUvPZCtAlgNHRRTyXvy2ON+JHzBgjf7X3al7SH34wYOtN1qchXzqUwTPp5PEUq7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:19:19 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 17:19:18 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
Date: Tue, 10 Nov 2026 19:19:06 +0200
Message-ID: <20261110171906.2335056-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109202638-failed-5.10-7308ef8b4a67@kernel.org>
References: <20261109202638-failed-5.10-7308ef8b4a67@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: a824daa9-6ffa-4b60-5b8d-08df3f4ec0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|261009223027099003|10067099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261028144727099003|261021121427099003|261102123227099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LZqmMWuiLxh9CR9wJyyXdK0lhh6NVt/+Vp4CvRLPlJ4Y7bkrl5M1VOmcr1pitizi5bxCwsSmDMS2dqyNlErkzhtfdeBYpjtKaZ4xnGZ36Iw1ZbzV96a0ZLHrsGTC8IytrwEREef6iVVIsaSmwASSRktZXL8gE5+JzR1vc3jPEcJJuabFNvLgy2cTs7FY7D9+A36t5542dBy3NG59+DK+9Kf5sjB4Wd2w3FKRIDJjXy5LW5LyERFhhoFKUUfZC29gEfB5quaYJ2b2Xg23ONBT50thznekCUDikmGupeYBCZjvHiDTmOxm1ngAmLilGd1wLclw5C9u599qEFPPiv+UGuEAM9R6Sn872/lZCV0BwFQcGkeeOpbwsUKqDRJdPFkDb6a84TlGxCH5YqRBsetz2IRg5ZUXIVd4tfy0o86A/hpduT4fEDkzebVNP+jvRz1dLV6jz4oe2hgRfem6U0y+oZ0qHB6Q0jDFVPbBtfYXsVZKXcFpfpHQYXTVhLWw8afOBokAbzn5PaxCfUKV2mLbsx1u9GgWV1/oRfKjlOkNwRVzokPH0PgYURPocyXZAC2FCiLvZhtGoI8gjCisUrP14MpK0Asirtt7z5SvbRFakMTSFRxLYT+FYOZJfUxttss6Ga8LhpgY6R5Ou9NS68a2p93NQ6slC7Ae+/f4yr9mX70=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(261009223027099003)(10067099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261028144727099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xkt5CmqhzRtfMryXmNNY4XmvHhJzVcYwgdmOvqavITlEP7187QuSlP0i8+7d?=
 =?us-ascii?Q?lzMWLBBU/b3uCkIxQxxWubRy1C6a28vXUvaY2Q5r/x5d8EcYf4eZIfUorsTK?=
 =?us-ascii?Q?SSKafFJcog4cupdvK8s24h+b5WhcvG68QqeXfgl3Kue4+d9Y//7QiefwxbfR?=
 =?us-ascii?Q?xu4NIKo53XYhOd9HmqGNhO1ydYKaFWrI7/pkQleRevXybmoukXNChIozd/sL?=
 =?us-ascii?Q?tEEgsEF/usmesaS0qxLCVLvUhBNIXJkMnDzB5fVSLaF/h4xZoiHVkXnDbp9I?=
 =?us-ascii?Q?WxH+k8hSsyZ9Zsn+OGAwnVRRYdfBnAlOJE1i16m+8u9iPWjKmebCmYd2YSSK?=
 =?us-ascii?Q?CcAJVLMQeBNe90tUoCuZYsi2w8ayc925Qj4sdoOqL9cK9ukIs+pdYBT3LYx9?=
 =?us-ascii?Q?wv2APXWBOwsUDisTe0ehD+Sw8InqpdN1Zs+BDLWC6FcxRDqaf3z0XtsA79uF?=
 =?us-ascii?Q?bVacE9mmikF6IzB5yAYSPzqe8WcfINTqzpUWMWzRnbSg+Qo74FLbRwSYWDvw?=
 =?us-ascii?Q?a7zvCwtQgocRWjU57Za5TGhRdPQSyNU2YSU6CVbqf6AGAnea9FIbZ1+1EwqH?=
 =?us-ascii?Q?BAhi80kC7MAL7FrQL4pf8aT3eKF0jJjbb+tBCNEteOYY0tanvf9gZBmRQkZH?=
 =?us-ascii?Q?cJd2OlhUExFnBzLS11hIWjnwwgk8MTWovuY0+nXaUXRlQcpSihQ6aNCmvAsZ?=
 =?us-ascii?Q?1ye5TVy+O+ItgMwN0lvBTkFuHRek9ISXoOqh+W3ZKBqhA3nfa5zMjrUzDjop?=
 =?us-ascii?Q?R1004JipTWW2OifV6E55MHQkyFEcQoIZBQf0HTWWVabN8PUwj9nSxNPAdOF0?=
 =?us-ascii?Q?2+X/cV3ZctaIR10yGXvo5qTB6zWIu7spNXVpNgxvDM0cPC25AWdlZUMAucSj?=
 =?us-ascii?Q?yyBYjm+f+LZ8w1uRzHLU5cbeWS7IuRnH3SB/K0wMAk8dwUsw/lLxENF0tIf9?=
 =?us-ascii?Q?ydX5fqlwOt8Kh/mqyzaCyJI45DpWPOalMWmctkxdIaRgkIRVVy89YV2Ava+L?=
 =?us-ascii?Q?lO8kWBFEZYgPxtlpx6a9+gF96R9idWvjslM3163lBvEz0Ae5lVeEM6ZBaS5U?=
 =?us-ascii?Q?72Iln/nAUeg6efZUhdhi0E28GmUVnyCAHItxaQlyIWz4iueL36l1x8WAVIrj?=
 =?us-ascii?Q?dg8Ycauz/Cc8GQ/prtxdEhz0KgoKgb3W8rg33/CUeEda4odGf/9dUvVZ+0A0?=
 =?us-ascii?Q?3hL9EO4J8l0MmFaSqlB1hhS1iwd9Mur6ZBcOULWwt5HfL2WUDlvVugAK8+r4?=
 =?us-ascii?Q?vSYUWP+xVeLq1pMXO01pbJ9ZSMx+ev4DTIjGbF8IKntoTpjzunBTv8JpXcqh?=
 =?us-ascii?Q?i5PvAl8VmA7MerPS7v+jjBEGOJPGpaldoMjf3DYVEbwhOBusfGGgaeAJylyu?=
 =?us-ascii?Q?rxny0HOrmOfhs1yvQyndCJn4dIvgJ3e5Oc2iK0VnyjptTGnjWpEV3W8cmNKV?=
 =?us-ascii?Q?oBauc34YCqb7T4HeOYfDVXUC3AIsZsWKyjeBSxqBoLkx3WFS1LnBZ/vcotv5?=
 =?us-ascii?Q?BM4+Sa5hrmkQrNPi7+MP7afH+eSbsWASUVNeVaAZf57GUGBpRxjGSWz7p6FN?=
 =?us-ascii?Q?srle/QEoEVmFzFd/D5dF3sPkbYupeCz/bv5to6uzyvpa4ecysEEgU+8PXhqz?=
 =?us-ascii?Q?h8MwON50OpqWV3zF1nRz/VGaMWCCA4wPG3EMOtkI9w+mb1I5D6MGj70fqQTW?=
 =?us-ascii?Q?jkG2xxTl3OecvGMBOVJQs9oryucHHdMbJn2T66PlHnWxrHf5d1WT4ZLE5E4c?=
 =?us-ascii?Q?EThji1+vMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a824daa9-6ffa-4b60-5b8d-08df3f4ec0d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:19:18.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmHMMFdvaEVFVg9nSikMRIZYhHOPlEQi06GS4nEVNNAoRkThBlUBi5ghuJ/a8KYIBkRRkTJh6QBqZraRS4+80w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947

[ Upstream commit 7308ef8b4a6779a39f68d053c19b53a5c584a663 ]

Commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a
nexthop id") started rejecting FDB entries that point to FDB nexthops
unless they are configured as "permanent" or "static". The intent was to
prevent such entries from being aged out by vxlan_cleanup(), which runs
without RTNL and can therefore race with other VXLAN devices that modify
the same per-nexthop FDB list.

However, FRR installs remote MACs that are behind a multihomed Ethernet
Segment (EVPN-MH) as dynamic FDB entries that point to an FDB nexthop
group. Since the above commit, these entries are rejected and traffic
towards the corresponding MACs is flooded to all the remote VTEPs.

These entries are also marked as externally learned ("extern_learn")
and are therefore skipped by vxlan_cleanup(), but exempting externally
learned entries from the checks is not enough: vxlan_cleanup() reads
the state and flags of an entry without the hash lock, so an entry that
is concurrently changed from dynamic and externally learned to static
can still be aged out.

Instead, remove the checks added by the above commit and make
vxlan_cleanup() skip FDB entries that point to FDB nexthops. Such
entries can only be configured from user space, cannot be learned and
cannot roam, so there is no reason to age them out. The nexthop pointer
of an FDB entry is set before the entry is linked and is only cleared
after it was unlinked and an RCU grace period has passed, so it can be
checked without the hash lock.

Adjust the test cases added by the above commit and add a test case
that checks that dynamic FDB entries that point to FDB nexthops are not
aged out. Without the fix:

 # ./fib_nexthops.sh -t "ipv4_fdb_grp_fcnal ipv6_fdb_grp_fcnal"

 IPv4 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [FAIL]
 TEST: Fdb mac add with nexthop group and extern_learn               [FAIL]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [FAIL]
 [...]

 IPv6 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [FAIL]
 TEST: Fdb mac add with nexthop group and extern_learn               [FAIL]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [FAIL]
 [...]

 Tests passed:  44
 Tests failed:   6
 Tests skipped:  0

With the fix:

 # ./fib_nexthops.sh -t "ipv4_fdb_grp_fcnal ipv6_fdb_grp_fcnal"

 IPv4 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [ OK ]
 TEST: Fdb mac add with nexthop group and extern_learn               [ OK ]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [ OK ]
 [...]

 IPv6 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [ OK ]
 TEST: Fdb mac add with nexthop group and extern_learn               [ OK ]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [ OK ]
 [...]

 Tests passed:  50
 Tests failed:   0
 Tests skipped:  0

Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Fixes: 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a nexthop id")
Cc: stable@vger.kernel.org
Reported-by: Sascha Frey <sf@techfak.net>
Closes: https://lore.kernel.org/netdev/20261028142928.GA8406@techfak.de/
Tested-by: Sascha Frey <sf@techfak.net>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20261030133750.28668-1-idosch@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ idosch: fixed a small conflict in vxlan_fdb_add(), adjusted the
  vxlan_cleanup() hunk to the per-bucket FDB iteration in this tree and
  open-coded the wait in fdb_entry_aged() since slowwait() is not
  available to fib_nexthops.sh in this tree ]
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c              | 14 ++-----
 tools/testing/selftests/net/fib_nexthops.sh | 46 +++++++++++++++------
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f10bbdc1b826..7c2b826f01aa 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1069,12 +1069,6 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 	}
 
-	if (rcu_access_pointer(f->nh) &&
-	    !(state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "Cannot make a nexthop fdb dynamic");
-		return -EOPNOTSUPP;
-	}
-
 	/* Do not allow an externally learned entry to take over an entry added
 	 * by the user.
 	 */
@@ -1327,11 +1321,6 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
-		return -EINVAL;
-	}
-
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
@@ -3030,6 +3019,9 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
+			if (rcu_access_pointer(f->nh))
+				continue;
+
 			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index bd9448be9dfe..54d9be192bff 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -335,6 +335,20 @@ stop_ip_monitor()
 	return $rc
 }
 
+fdb_entry_aged()
+{
+	local mac=$1
+	local dev=$2
+	local i
+
+	for i in $(seq 20); do
+		$BRIDGE fdb get to $mac dev $dev self &> /dev/null || return 0
+		sleep 1
+	done
+
+	return 1
+}
+
 check_nexthop_fdb_support()
 {
 	$IP nexthop help 2>&1 | grep -q fdb
@@ -410,14 +424,18 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Fdb mac add with nexthop group and static state"
 
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
-	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+	log_test $? 0 "Fdb mac add with nexthop group and dynamic state"
 
-	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
-	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
-	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self dynamic extern_learn"
+	log_test $? 0 "Fdb mac add with nexthop group and extern_learn"
 
-	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
-	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+	run_cmd "$IP link set dev vx10 up type vxlan ageing 1"
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:18 dev vx10 dst 2001:db8:91::11 self dynamic"
+	fdb_entry_aged 02:02:00:00:00:18 vx10
+	log_test $? 0 "Fdb mac without nexthop group aged out"
+
+	run_cmd "$BRIDGE fdb get to 02:02:00:00:00:16 dev vx10 self"
+	log_test $? 0 "Fdb mac with nexthop group not aged out"
 
 	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 66"
 	log_test $? 2 "Route add with fdb nexthop"
@@ -504,14 +522,18 @@ ipv4_fdb_grp_fcnal()
 	log_test $? 0 "Fdb mac add with nexthop group and static state"
 
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
-	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+	log_test $? 0 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self dynamic extern_learn"
+	log_test $? 0 "Fdb mac add with nexthop group and extern_learn"
 
-	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
-	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
-	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+	run_cmd "$IP link set dev vx10 up type vxlan ageing 1"
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:18 dev vx10 dst 10.0.0.3 self dynamic"
+	fdb_entry_aged 02:02:00:00:00:18 vx10
+	log_test $? 0 "Fdb mac without nexthop group aged out"
 
-	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
-	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+	run_cmd "$BRIDGE fdb get to 02:02:00:00:00:16 dev vx10 self"
+	log_test $? 0 "Fdb mac with nexthop group not aged out"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
-- 
2.56.0

