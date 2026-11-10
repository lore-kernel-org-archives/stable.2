Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794330866;
	b=y6jUuoyTbZoHOLyyS4kH1QApYuXgeqZsttLQqSpTdyDXexAaOKo0T+CJuuJqEHW8l2/O
	 TKclb8Lkgn7xh4fOyC5MTOMSMXpbiwUq2bQYxeNFGgEE2tl2syEl6GGcVOA2HerTQvkh0
	 9cLPvnyGDJMqyJ8J+UgkjF9QkBcM6h6n1lKmkUK5CAO+z0vHSab8lW4IW4HWEG+g2cPsq
	 DQ7NF80QOLg9AbTTeFKxrLpdu/EEl3lG3UovyL3mJI4kWwdbfmxyYo401jpkDDgXaD3D1
	 ZfJ0kfOetCIKN54f1ygpX0p04ENWR2zABoFVf4lWjgFxX2kxxnDb9BGPnfgBeGIHMJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330866;
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
	bh=+4bBFJf3kn1opNV58YDP2qNvWkUWkFDdXwsu7kSR4P4=;
	b=ET0RqtAurnNv0QimMXh4WmMnYk9ndGdMZIid9Cr9sGl9csjulk3aLjYV9jxltFAlYfsG
	 n2jTJzHLIjy2p8YnJ0jL61E/r8FB2V7q9xz8WVHTm0dJgQ9NCoFaWjOEIy5ryGeckvCNc
	 swW/gRW1f3zcLBMCWtL5vesmE1CLNFGHA6OezC4H3+ED06fVNzRgRetP8yvnGr2R0/VmY
	 vNJdFeoFdu/pVGy9kvU7ENt8Dhyqp802cOeljiaaZtXa6Cut1zEfbUE2t0PybGmFGyHpl
	 Gl1ZlvFeDEKcbxUF2ujpT6Krj/VSXmTsGFyUKGogfYr6J08hNB8kVHNycXZ/WqgrM+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VR016agS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.54
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32429606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32429606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VR016agS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQycooBLWdj9MZhmX8nyfkKTG9KluIVnZAIKOnvN1gF7fdQwCZTquFXOmfOphrpTToQPImMMRPj7FndU18bbIaxOBDMlfb1/hiW5VXLk+MkSD1zg3JyKqS/Bel5VkNzb2p+Iw7M3POU0uf1Zbf/SH8g/AttAy2fctJXRiqQrijQHnUKL/QE0XekeekTIxayHbnlhPiiSAzcH0aKun0npU586qXiqeQ0wVkbF7FA0b20udErAuIwhNi0NGNUjmheya7wv61mgI62TwUv2k3VKgJw+0MCtVB/vF+OGnDeB43PhnDzvW72G4atwmMYDUieuOpK2tmlo4hIDuFTdd25GDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4bBFJf3kn1opNV58YDP2qNvWkUWkFDdXwsu7kSR4P4=;
 b=TMVBonib7ItEGpvEukgfYGHAVTW5qtAbT3P0b0TPn34lQ9uff/d7HPJUt6eRodW7QWk4UjShN6eYItgDnJBedfW74MnAejonAzZdDBW9pbwRIIc3bYG6CjmAgmki20FMPpVq5kWjJM55xtUwaMsn0TIIpQdPZxiY2MwQ+1B/zjCR5J6J0aTYiF6z/8kYHdeN+PlnuSgPbUVtr9gU6bn/W9czBTskJzYoa36bf5N3jZXy0Iqy12pJ/yX89iq7QyRxvncvpbfqqVydueyJTPOAfZO4J794B58tV44qP2HN54RJyUtjrNeIaSCYLQqdeoVLBcPpv8OBD5TAs2sWY6dM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4bBFJf3kn1opNV58YDP2qNvWkUWkFDdXwsu7kSR4P4=;
 b=VR016agSv531nRqgM2v0tbGBHhIBfBd0bfhdU2KT8KuRnfvcikel8rc3nnHHvpPbMLE1e3RNPzf4rL8jQEwuDfEzWqJ4+OPtlO9kt0+3CQLP07wLFcldgaAsabF6UkmTPokP+HgiMLzQrvu8eZ0Dx9bKH1ZAPj9Ak7Xrywk3QyW0QpwF+hYdu0yiHo2o6hNMk8pvDeAUdWkYn/mp5kPccN+vvyeQYKozzlWIEeqb+J3aK6fZzMknInEVVHpCc5PqfcydmNIXD1aTKBZFMBe2lXqvr/LdO+qM4tCJI72qtNz8DIbxaOzejMK4DAekpP/vmtNb3Ktus5Dl64S7iE0Nhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 17:14:17 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 17:14:11 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
Date: Tue, 10 Nov 2026 19:13:59 +0200
Message-ID: <20261110171359.2326335-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109202145-failed-5.15-7308ef8b4a67@kernel.org>
References: <20261109202145-failed-5.15-7308ef8b4a67@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::6) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a8c8c0-01aa-4419-6b2b-08df3f4e0984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|261026121527099003|261021123027099003|261028144727099003|261021121427099003|261009223027099003|261026140227099003|261022105027099003|11063799006|56012099006|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	lF6EaOdcJBPzoHe4M/X3W2XJ3mhrb4VGX9JiGMJzkkftBv/Y6CPOSTAN5nGdu2XN7acbZGpLpSBLREIsupwP6OUPd1rTFgbwNDPpGq6dpt5NJnyJVo3VkKHcvYMR8DRFdPhDFvpDS07MlrOpMb3H5BJHB6NW5QCDAx9+zzqDBmC2PVXYSclbUN8AKYqzF4UkOypG5ZGe8NgvJXfJ6zlPQWOftYKl9u1RECgNRWVzhODvWGxvWesEya+1y/MeLns24omyDOLloDR9vDYSNcLgiRu4bq6cU5hOvtR7i30gdRn6FeXnGlEda72F/QZGgUJEfm5mlbB6qg3IE8y2O6s9HnA5Je+kB7lVITJ7uzwsYh9dat33DFic5KMyArgV1TKFO3kFLdrUjxgAfcDQyTAidchSWddd92aV20B+NYHxZgeYYRtt+Ip3CiWYHQdF6LsZCKFn1L75dzh80rCfusQmnO5vePiuk8857rWEedhxxY2hSlwiafNQdOwv2DJga6UdlyVrK+Yx1kz8KiKycjUOT+NF4x5AUc33pT6vjJMDQ1Xu7JHlhHwZqqVg2I/heHLe+xu3APkgK7iqwO0Gejsd5h/RKw126ZxhcM32FyrTd1zFcmZCmE6OKez/peENL7/HB85v00IFp/hL+mvu/ba+BhJY6GkFwe+k+KkCw88QdAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(261026121527099003)(261021123027099003)(261028144727099003)(261021121427099003)(261009223027099003)(261026140227099003)(261022105027099003)(11063799006)(56012099006)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ExGi3EYrFlq0fn8OsMgQ83T4Zbfh26zg8ULb57QL+VEQ7C6bbBdt9fKJEshz?=
 =?us-ascii?Q?tU8+t3qqvYGY8vHBJXQy0Qf3CLxhPAow80OinfsIHO9opQ4Jpoiv7DAhDvtq?=
 =?us-ascii?Q?F0AI72x+z0AlcgQwJea0y+5CryvYGF2SZ7ECEPUlg/IROW3qchzaPQq+/bNE?=
 =?us-ascii?Q?8WuoCtXp86ylcAKCPfteZEEKTdI/cNgVtF2zdqECl/BzenwZMa6Ub6vjrNQD?=
 =?us-ascii?Q?rWAE9f6qs+Nw11SFcN5gDm/7CaQwk8YPONZxMOcEPcpxWkNn1N9bWfCl73T5?=
 =?us-ascii?Q?wRtN3mTpurJkkiJxyVNUdtelW9pZ/jQeFVztHTcBA9oNM0SeQVJNBvbyAFOp?=
 =?us-ascii?Q?apvZiH9EpcheKRcQwGIotHVZ0yvNYmt8EhAIKcrLqYM3uFOPs065eaSzlWW+?=
 =?us-ascii?Q?opn5lhU6a4g0VEOkeDepaWUgI8GLFIu5zIeSYDXXdGWeRJtyEEDLsD5NQ+gE?=
 =?us-ascii?Q?UkjVSfN8Hb7nZmdCxbqtl/lULNeikHu3CrRJldzq6kWz4tNFvRb8DCS+IA8X?=
 =?us-ascii?Q?cF9ZrdywB11IyO7yFIH+ziGiq+Xu8MTQixJaL/B82N2PJY3uTG4DnP8aS4dv?=
 =?us-ascii?Q?zP2ja14uagHMg8Jk9T0VjZ+aUDMNEgoho53IsuAxCihttly+YWaJek54k9Zq?=
 =?us-ascii?Q?Viv3MQfe6n6HOYwBoRGsSeGpAZxadX2GXo2XvVlzZ2+4RyeFi6iOVhbxVrZj?=
 =?us-ascii?Q?5ZvJexa1tJ+JVELiN+ZqBeNu3Q4NwZwlJdtXuazCy6SDKF166Wr3V9z2GvXT?=
 =?us-ascii?Q?tydNSdvACMxFFh4gEGibf4g5oG7lbm57Jp7Hy6NhHvHY+mHR6MtkZ4fNx388?=
 =?us-ascii?Q?SYYf4KkG71XtTKbhTMSriC9n9PgcBcg1Sx4I6wY6Qtpj33DM8xQjaEJHMoOH?=
 =?us-ascii?Q?atI9ZkL+H/HSrgqcRiAgCQd/naIRJIs+ekz6DcNA0xAlnJlvoBithCvvRDs7?=
 =?us-ascii?Q?x4nfM2ruHr7oXRmvrT8e5cHPw4HfGTtiCu2FWA0O9yMU5eZd4N+jw5pUGUgd?=
 =?us-ascii?Q?bloAJZcyinLlJBlgIpgyzPgPDbIzNX+yBlyJWiF0ZKTbc0MqgG69XNQ/+mwc?=
 =?us-ascii?Q?bImYALGLnsKj/JN61dbiTo4+Ks65gmkFdTpPIBfAB3gJKipoMbeSM8ZcKagl?=
 =?us-ascii?Q?6PBq1kLTgHwg8LbL63pxY54zefMQmVAmD+7KRBEBZ29axtKcPucN6hp5cnE1?=
 =?us-ascii?Q?VjM/szosZr1ElDukavMzTUc0mSYxDK/WisXuKKgXzifSI17A8fpxd0lVeupW?=
 =?us-ascii?Q?1KIuCL6R7OYJl9MZczM2ZVgX+cKTZcKMqUE9fa8Il5xm9qkRQQqcD0fF7fnR?=
 =?us-ascii?Q?fvGVBuXOStW/w5E7SpfwqRXgDnOslj4IIkUxNst86trU93rxnNjtvFIPyqM1?=
 =?us-ascii?Q?PQfxWxs2ixvwC5sEzhosiCOxfw57EfwvvlKJGS2P+izlU4TuYP0Mvpa2Rtiy?=
 =?us-ascii?Q?2hQhDxEuSHQCP0gMFLhcD2tQd3AkNCNDA4b4U7B9oKYQV/yjMtQNhQwESVZ5?=
 =?us-ascii?Q?GIo6rf13Kf3z3atEmNW2Rtfb6wjwujAvMfSqLTCu6Y/dy9IONaM4rlofflTW?=
 =?us-ascii?Q?vK5nYw5k1jAi9y7DlxCutRRcCD7+VKHo5AEBUyu6iqV1x9AYHfgcmkn+2P45?=
 =?us-ascii?Q?uItcHSyiY/rHoZ7pYRWZTg4VxGAgUUeYfp1mzbacEKU2X+o84q2+cDJVCGkA?=
 =?us-ascii?Q?lboNQ2IfCv2bxDdndLCaNXHJjExT4Ya3xkfbO4qNvDw9WPR8Rg7m1HG/Fgoc?=
 =?us-ascii?Q?0Sz52+jY/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a8c8c0-01aa-4419-6b2b-08df3f4e0984
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:14:11.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ67VmaS66k3QTRLnjuwmDeIDSyVExVsLwnRYULfFup55NmfXxRTQ1NNgbbXJXCFKhqKv2baJmtsPz+IbC7ZRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738

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
index 162a329be447..ee002e790b28 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1070,12 +1070,6 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
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
@@ -1328,11 +1322,6 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
-		return -EINVAL;
-	}
-
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
@@ -3031,6 +3020,9 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
+			if (rcu_access_pointer(f->nh))
+				continue;
+
 			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 68183d840e2f..4d40f6e76eb0 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -396,6 +396,20 @@ stop_ip_monitor()
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
@@ -480,14 +494,18 @@ ipv6_fdb_grp_fcnal()
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
@@ -574,14 +592,18 @@ ipv4_fdb_grp_fcnal()
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

