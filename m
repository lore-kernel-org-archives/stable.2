Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC2357A25;
	Mon, 31 Aug 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158691; cv=fail; b=IAhr6nWAVgKdX8wCTe9ZvnD0Kn9gOrnWHL1oMSt9HxGF3kY6fq/HAifHaWoeBKuCbxHC5DN+oFkzZ8ojn2dkSyFuwn5X1XIKmcmq3aLzDE0yWsm0ge6zzbvW+FVxrJHkx8YMDr7tje8m+YAnaI7Eox/GA9Pf7R6dsPV5u1hL7TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158691; c=relaxed/simple;
	bh=UQSUsaMjIjebaFOkXAX2byO4GLpgyjGwfACZz4pkr2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NMTYMqW+PZCltar9Ab3K6lavl3higLhLwVyXtU08YHbZxVu2ZJ4buTGwj9ojN0mI8i0R/s5YYWGd2G7QsYxrNRTYYqA0DxVbyArOfIqkv2/NX0j+eETt+dGap7edZRZO27HleKykECjK0MdJbyIoCeNyUg2RSWu1+4Rlkh/76+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dVEqT+4q; arc=fail smtp.client-ip=40.107.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dVEqT+4q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFGSJ/CRIHq6oCqTmZmwtu9kXLmdJ1Zp1yAXNLSFfDiuChI7BLG6otMfBgC+J1ucCGl7MW+EsJIjx5IteQm53qaosCMn7jzek7iUu7cqODnat/+s0WgX6UyBZrTHGTSkkuGnQZMsvSXoqH1E7d73Jt7/F2VhRTlwTb0NyiJUaQowBQrzZ3ZEFrPuNnkEw0ETE8MxfJzP6GBpY4tZyD/fXF6L2eMqJcmFaAEgUhvTMUAXQzps7ngxwT2tMKliiHO+p5IqFQZyqPNmvz04DNaH4qxwnSa3eSDEtEai1nwzfSjlauv1klwxtd1SVQEZhibrbtbcRkGfSqc1abiNyuLrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxd5pE2c/oAqCwIfBMrJCJxnrAtQLwmYrjpNxNKwPh0=;
 b=H3MXBIJwKJPkoDUncNxaexuHeIdw7SI+jrWmuFrGRAUBzLwe25+uhWn+m6Xprl7bjAGbg2rlrFJbs9wE/Z6ExlWmfCOY68pIAmI4Dhlyfuys4YKfMs2ME8aGiIhosVV5kDfdiMxsce76N6I2y/PXJI6KB0MTuQCXqHZq8WB+7sZzOndNVaqsQMmNtLS812KMapnbjVZ0Djulg6pGeCiyVXBmo6XQ2BrX1/0Hf2aOoCjfQWhNW1lV2TSCn3ea06CzuYRToP5/EuBCCzeGrITkB17qauEEPt40gR6kYFGcHbntuW60glNymd0Zg2Ncl3575oYrw22/kUXGYLRHNoe2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxd5pE2c/oAqCwIfBMrJCJxnrAtQLwmYrjpNxNKwPh0=;
 b=dVEqT+4qtePJP9byQhc0S1sCXQItm/uAOBgU++xOfLANMSNhEzheZ697M0Ku8vAP284m8a/qyUFwsPD79sbk2M3L6iQbipRBVnQffC0XTI2JhY8om4QqEz77qTL5wcYVkcdJDlDI8QCucYB1f+Fcae/5CK1/zak+NemIdZum4FRQ2ZgsdT1jyRV00KeGxH6EqzbuG30UkA1WB6CqndB3eRt+JoY3LVBRLO7sRJr5g1FnQYZjeR6qIr/2T94860BXdm0RM/83edOPJ+dDQEZ9S4dNDy+kIYbncfG4yPQwymogs0wOkhRMTqdmauNLybrFQLRy9jzRW5CQ8an/lzzNqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 06:44:47 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 06:44:47 +0000
Date: Mon, 31 Aug 2026 09:44:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, aksecurity@gmail.com,
	noam.caspi@mail.huji.ac.il, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/4] ipv4: udp: Create exceptions before socket
 matching
Message-ID: <20260831064437.GA3079008@shredder>
References: <20260828192344.2596928-1-idosch@nvidia.com>
 <20260828192344.2596928-3-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828192344.2596928-3-idosch@nvidia.com>
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: ce94184d-11ab-4ac7-d28a-08df072b5906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|366016|376014|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EThw4za5cmc51cs8wHhiUFKVOeA3bgYItuw0HoJPRAm8Z9y8QohiPH4UqdsdQ/E7F4lq0zyObD77d1m1ytvtnoTuQl35hagkFWbN43kbdf6/cTcj5M0ZoKIO8/mH9Bb0tvnyagtFeSvEkPyBPy6WVEF1UzTAjgKiuNHGqLpe5xNEilkUuQdaddkwHd2d1+/A/GnQoJDQXoKyDAVFm6vHay9sQdRpo36KB8eBzSqW/b+ovzIJo+NS2ilD6++pJRt5mKJ7qfxusR1mORYaaRQR501KkMgQnbkV/DXAdt0/wQZFV32rnIUKw+vKg1UAWCRcZD6pRvfMt3VSQSpBrCjJw/mRQ0rT1k2a4jfm0I+9hLdVQOAK859M6EMoc8iQ8hmjymtFX3DNBGzOJr299/ieeinFeRg+OY+woQxN9lLJkOoC1KEHIWYUPHCjtdusyHm9ffBz0HsKO2/yKd8ImT40AcL7ez6zLQYpfZmcFhYEnVuD51ZOWclX3sMN/6gWJUQEKxELK/EvR6zFpUUUQ8oE0jGPAzmHmWfDxwWAm+9FzoHUhIVbxBr9Z0tBnh0NqJwstLHh/ikZeQqMVNAcJJsM+IsCura6FEi8DsThlks94XMtjTiUMxe4wkU0dnQp7qp4uNOKT+fAiSQWVL34i4EBFCjceG8dugZwNCZDEAqKpHc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJkcIRn0PTse5PTEFnMy0QzjIZh1fAPxvH3wSqB8mh+SDzncBy3h9SOKlGxK?=
 =?us-ascii?Q?J+ZlNjWedV1mCqtLSAduh+hAVPkb7XsPS6TkmEjnjUdeo9GgdBjadmM7QH70?=
 =?us-ascii?Q?T4veXBwfjyC1oUyoeu7kFtPo4g/Q71MUvNzM52CS1TkX06xSKc5RT8vqyOUC?=
 =?us-ascii?Q?Ntr0mHPEBkAIrjJyaL0STSZI486hbHhX22nBH+W5BnqOOO1O7UtDoyOFoif/?=
 =?us-ascii?Q?cpCAsGcd5rUgrt11y8ePcbuZzROMbVMPefEeYNNHZ55Ax9/JWboYtwIkkbeA?=
 =?us-ascii?Q?IvcrTBKCIwkXscE3Gu+s6s5rlnes+wKW81LpKGMVUahZ5iyp8emCGbSlo/rk?=
 =?us-ascii?Q?sDXHCTJytJJsXuXhGLU7fABMP5JdJRxIL+eUkP8yymy/vX03mEexmIYRHP/9?=
 =?us-ascii?Q?IALHWv07oJRi/Nk92L2wrFVOJNLaFUqcBBqIvcxd33wC69fbhJ0DcWku9Uuf?=
 =?us-ascii?Q?odGyAqnav8B1Jzm/LKAAofUQ6/7kAD0/WjGBaJmgBmVMMTTK7uVJoxQxYc7S?=
 =?us-ascii?Q?Wk4pOgcqgHF702ek5px0N+fi1EQMxZ97Sbc6yISoLmIc2wdxMIVmnsQ08Hcc?=
 =?us-ascii?Q?4VG3Ss10PGlVUEYrOfJmkU/92qSbXOLLRwnx4coOaqHnX9TtdGoWoKcFhPp+?=
 =?us-ascii?Q?eTpKArhGwS55ycWXlFoaOr5rhAg+8aQR8uWvu5H0eGB4yzntJEJmGd8ScYiD?=
 =?us-ascii?Q?47RWGrfd2hkze0CrdaGB0uHSMwjCz4aISSBUhUJD6Hh1S2xVOxWkHT1vDln8?=
 =?us-ascii?Q?2lzUcXgkI27pnebw6reKSQDu+fBgmlV5pRTu+cKd4YbIcUru1/H1sdqzuxJM?=
 =?us-ascii?Q?2C8eJYVQPcTcbOdR/XE1lKUtVNua67lfG/0j/vOG87+V3+2RpQcHpEiR7Zm+?=
 =?us-ascii?Q?e3PExFz2JU/eVRvKAFAH7ZbHnU4pw+5w/q2bUnFSH1HfB0QA4l1MryymeJCB?=
 =?us-ascii?Q?YqRGGQsysBs91r96BFBeEJbpxM+mcU65Kflk7dF1OsaMRAJgGrTF4gY3x8hD?=
 =?us-ascii?Q?sp3le3R/C3dzE68ajvz3BWRIpH6K2Pm8Q3xegJuOW6RXyGPb2us6iBKHREq4?=
 =?us-ascii?Q?mkG2Ikkwm+tTA7v+gY4MInm2TCAx1h8XgpHnc/5R4QiDYd3iPgmhatIm01NS?=
 =?us-ascii?Q?Hhsrv1fq7inhVi6uiygMkM6+X5MkfAseMvAJvnue/Ntpb8L66pCOdSdUfLA1?=
 =?us-ascii?Q?Aoiwa0YA+kHU3rLTZ60fhx8jLESaoOsy0x9yWBYZSW0SXXoPb6J5GASWWh4d?=
 =?us-ascii?Q?UBgybgjhE2mW+e+Q4K/gEwRF+7QgH0pFqCN1Ox69VFbqyPkeGEOaE8lRkzkA?=
 =?us-ascii?Q?6QqLt5+rZU1JuScjXdOViRXA4pz2asNybl1JUVvovjAQbw9EkAYYSK5SNiMU?=
 =?us-ascii?Q?PXE8l+3wtnijoX9H/drpvvz5AAngg0U6ifbvbDWTIFH2oOVekYypv9Qotr7R?=
 =?us-ascii?Q?YycAZGKvLEqMo+5LBAq2Oo4BSectBuMZcY+V+AIQhzFWNBZJQbOW1K5ZfIzg?=
 =?us-ascii?Q?C++PgRlBU2seTjbUTB4CSL5o0WyqkdDpYRcg3UcPhNH05CQGDpdw994GkeTo?=
 =?us-ascii?Q?sx5pYkQ5hvX6tcPcI7i3s1DX6YpHJkN2hddI3uv8CgLcX5tyODa3Rea7UH4S?=
 =?us-ascii?Q?cMNb3IU9/6VGhLLVWsqvdgnw0yaf7O2eiioV+z3IoI+6c5ty5zA8ruLgmocR?=
 =?us-ascii?Q?lbBmZ3/qkV6oDn+Z4tM02shwEiJ795Ei3EKXGTBKl+gVbdjm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce94184d-11ab-4ac7-d28a-08df072b5906
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 06:44:46.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqNzNCmJxKw1u2R8RguCBMjy2C5Bc2FAFqailTZz465FgLar51IprLGHh4fh3Qa7fD1ur2UCb8REkmO9ZQnHBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696

On Fri, Aug 28, 2026 at 10:23:42PM +0300, Ido Schimmel wrote:
> Currently, when ICMP Fragmentation Needed and Redirect Message packets
> are locally delivered and quote a UDP packet, a FIB nexthop exception
> (FNHE) is only created if the kernel can match the UDP packet to an
> existing socket.
> 
> This behavior allows off-path attackers to conduct a side-channel attack
> on the FNHE cache in order to discover the ephemeral port used by a
> connected UDP socket.
> 
> Commit 6457378fe796 ("ipv4: use siphash instead of Jenkins in
> fnhe_hashfun()") and commit 67d6d681e15b ("ipv4: make exception cache
> less predictible") tried to mitigate such attacks by making it harder
> for attackers to discover hash collisions in the FNHE cache and by
> randomizing the number of exceptions a hash bucket can hold,
> respectively. Unfortunately, both of the mitigations can be bypassed.
> 
> Instead, mitigate such attacks by always creating a FNHE, even before
> trying to find a matching socket. Do that by calling ipv4_update_pmtu()
> and ipv4_redirect(), the helpers used when the quoted packet did not
> originate from a socket.
> 
> This means that guesses (right or wrong) from an off-path attacker will
> always result in a FNHE being created or updated in the cache that the
> attacker can observe.
> 
> Pass an oif of 0, in a similar fashion to icmp_err(). This is also the
> oif used by the socket path for sockets that are not bound to a device.
> 
> Note that this does not allow attackers to create FNHEs that they could
> not create before, as both helpers can already be reached with little to
> no validation. For example, by sending an ICMP error that quotes an ICMP
> Echo Reply or one that quotes a UDP source port that matches a wildcard
> socket.
> 
> Also note that in the good case (matched socket) the above scheme comes
> at the cost of an extra route lookup, as the no socket helpers perform
> their own lookup before the one performed by ipv4_sk_update_pmtu() /
> ipv4_sk_redirect(). When the two resolve to different nexthops, it also
> results in two exceptions being created for the same destination IP. One
> in the FNHE cache of the nexthop resolved by the no socket helpers and
> another in the FNHE cache of the nexthop used by the socket.

tl;dr - I don't think anything needs to change here following the
Sashiko feedback [1].

"Does the hard-coded oif of 0 leave the oracle intact for device-bound,
VRF-bound and policy-routed sockets?"

No. An attacker needs to be able to populate the exception cache of the
nexthop used by the socket. If this cache is not reachable via the
no-socket helpers (e.g., because the socket is VRF bound), then the side
channel doesn't exist.

"This isn't a bug, but the new call runs before any socket is known, so the
per-socket opt-out that ipv4_sk_update_pmtu() honours is bypassed:

[...]

For a socket that set IP_PMTUDISC_INTERFACE or IP_PMTUDISC_OMIT, an ICMP
Frag Needed quoting its traffic previously created no PMTU state; now an
exception is installed on the nexthop resolved from the quoted packet.

The socket itself is unaffected, since ip_skb_dst_mtu() returns
min(dst_dev(dst)->mtu, IP_MAX_MTU) when ip_sk_use_pmtu(sk) is false, and
the same socket-less creation is already remotely reachable through
icmp_err() -> ipv4_update_pmtu(skb, net, info, 0, IPPROTO_ICMP). The
selftest patch in this series also asserts this as the intended behaviour
("a socket which disabled PMTU discovery using IP{,V6}_PMTUDISC_OMIT gets
the same exception as the other cases").

Could a sentence be added to the changelog noting that the per-socket
IP_PMTUDISC_INTERFACE / IP_PMTUDISC_OMIT opt-out no longer suppresses
exception creation?"

I don't see a reason to mention this. Exceptions are per-destination
constructs and they could have been created for destinations used by
IP_PMTUDISC_OMIT sockets even before this patch.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828192344.2596928-1-idosch%40nvidia.com
