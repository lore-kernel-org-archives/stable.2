Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793367548;
	b=Jm/XLDz5iUbGn+WR9CBI23tbFFiHILEIIvvX/IjwFl3XYzKYttKswpYR6kimJW/aAC+u
	 WkDh3WoAxE4Tqp5l1fZb4vFBwiW77dhzWeZX63ERJX8cVM57LsNWNtWUqjnx+QAwwcwha
	 UcKuv22iDi55dbMe/dyj6K26ey1F7jay2ZEP6VwXHld6slC38fu2j3olyHTRPCqAnHaQ2
	 i1cuMHOlg4xUnVnXFC91tCP1WlAjY9jjm7SWJJRfP5MIzlIJZtnmRpX5zS0xY1fP2f3bA
	 qfZm1ptRF/ZKrOs7DhosiB7HEulste2zbcT4SA0tI1Oga1CFrVU3hglJyilmy53YukA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367548;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=EPQ786uPXnZ/yoCP4nHRQ+QlloKNSVjZ9DlwbyZw39k=;
	b=tc++W7N/C7wYr/PAI3SFoKyauBO8cXKtNdGUpp/yYGXFekBPGH0nlZ7RB3hh8n06RWnL
	 US4AtEMW6r3dn9L4GcgeeffA1rTXdQ0qZsZgoF6tr9B9+zFYyslpRiZ1jlSY/HJMqA8E8
	 nnI1vnPtLDt+lGKqoLjNJss7L+X3GMWuld7nxHDhX0688XHErK+5hFJmBQfhGcbkvWX2p
	 qMpKJuaR1CSgRvkSRuLzK3qi1TDimP9aeV0OowrPIkGAqamTDGAS22Bsiu1okpdSlTWUS
	 UOnV8+r0pEHhv7XiC21o91iklXpn5zsdMN+YtMcqJO6QUCmh53hpEac04gAwOJ9yOlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XimYXtC0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.47
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD2606A31C;
	Fri, 30 Oct 2026 13:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DDD2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XimYXtC0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/sRHm9ewEHQsgJXIcIf/X5qM/je5tvdAJWXR5R1CfDs0HoWyUGDO9vU+WCqtqNkT3DZ4K1l1CjzhK/P9CFyC6SsjVLAppCVIC2Tb5ZngvkzyYTGF0Q3DK1p/0mDaTJnp/Sxz56x2W94Wsns/Y6+fCVTabvhl/jutlmxvlUzQiNtsqG4zNnpU+dR5KYt4FZdlgyhEc1SzHMhNhBjjIV7NzlvI5awrVWfYt0qpgh28oebhhfh9BEH7WRRA1thbv2kkkHtkrADybS6MQI9AhU8cMzMiN3MvtJMjLSgQX8HS2Gd5/O+Xxiy5wMzZ8uxACoY/ilIydjxjBgDbCPH9ef1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPQ786uPXnZ/yoCP4nHRQ+QlloKNSVjZ9DlwbyZw39k=;
 b=qjU5JwTp7FEUBy0cbFW9MVtv6ClMy2igtAgpg6Ay8rzx6ovp6XDmwHHTtZaZ928B0wnmCjDPbIpJg0ALsyZKyySd5FzqQ53/9ozESlHuCmC/PC2pJWz1TD1k4GJpzfuHCtUnJCVym1ji1i0tfupLaHe+h6FMpEgvjoctCyGxO3V7du9G/NI/c+zCuaIx+d/ZmmqUz7fABlR+dw4CAHHcc6CQZLCOb6LoOyXPtDPtkF1gcCop8u4nY2mtoLBKsInuGNBkzm2mq1hn3H8BcnnIf2gHvj6v2OIG6FLp+07WUkxTmp9DNg9iUVeAvkJdTnd9EDa97aMSCcr4iZ4I4b1Y0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPQ786uPXnZ/yoCP4nHRQ+QlloKNSVjZ9DlwbyZw39k=;
 b=XimYXtC0wzRYNL9V21bjQqY1Y7Bd/MAJ2QTpiL/mcyl/NzbmVZfHxK02fuNSyKlHU55UjEmZhgqTTY7z8gPwfDgT5Rh5NONSTQn4wP/UB2Bvg37hAiYeb8gAo75MlFQtorQxd6W9ifncLGGO0Idk2fB2YpXKoHH3bbJKdROKqI3qAm9vaSnK4NwRGrO57aQSGQmHMgn49u7Qoy3dWUjuGV92tGCICBifjsogAbuezeD5mJeA+79nsJMWlTOjGaxsseCgDEW+qqY7vR5CIY1h4hL7J6Ovh2tmpvziSVOot02LmPaLo6rLo4chXxcaWRhhRdB9xEQoJ+8s+Q8tt+3NjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 13:39:02 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 13:39:01 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	dsahern@kernel.org,
	sf@techfak.net,
	Ido Schimmel <idosch@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
Date: Fri, 30 Oct 2026 15:37:50 +0200
Message-ID: <20261030133750.28668-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca619d8-d5c2-42d3-0891-08df368b2871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|10067099003|18002099003|56012099006|11063799006|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	IJ+BRzzjxbj/Kj4DL35B4VA3zel1JwVan10kzbft/05j2VoEH/3LCMjUkbbFDJADyb3dV0Blty3bXSDeGDA8cPaYFHxAe7zGK2FGuWfgSnqgWxmREnuP8RLWB5mJunE130WXy4uevAa2ZuBOe/o6T/PihfJkHiN08ThREUsR5p4qmRWPZxA4+a7GeF9oNBOGplVPTtcIyOFK/bnyi9WARVfVeEiU0wkDf8nV7ObNmseNrT1uMpVBBKVdXnma5Og9mjsnN8QwpxIqhSFdtCJARQWp4923zbduMmL94mjKs7FSK0YR1CPXmIhNX61Y8WUpN4zJRc8GSXq2eHEfbAGLdRpsKG8q47RSepfxYzGPz648FDOY4OGpN4Wkt95R2oTsM0Rr6r6fD9UnoSR6Wc8MGjeKAoYmEuLZv7z7xsRYHZ4IZpJuYobs0m8BrT315Gw2m84avlNiXa+zeeWURKJmq2XW6MI8DqVAXVFztioXU1DelhJlTw/lwB5IXsSOXEyBbjbq/BLBbKLnz5IwFbHN41mbHfpg1OzAlyTrqzu2SLT0o9clo+UWjJ5n6z6QxVsdmvZXxaVP9PPqEbHZ4FmHrjX5d6Ox7iROntr69h5AH6iVFABLoSsfyoy1mir/9U9uZft73/SK3u1PqCg8KghuN5/dcCSwQLLExjmB7uF+c3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(10067099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PJpTn7kU1L0qUi5l2yE2vZPznOvGi5j1Q8wZNGZv0BrfP5jgHdGR3sNEiiv?=
 =?us-ascii?Q?CpaIDGCyRUSKrKL9niUVtdIbTD+muOfHHCQfHP9M7SvpqvsE7H0qtewcQWCt?=
 =?us-ascii?Q?TWyCcfW5Obfq9VYOl6u76m+eYgpwh+jfe9sYmnATaztZmZjAdpj9BQCypo6u?=
 =?us-ascii?Q?pO7+OqUbwc7Of/FMtaHGfuQjb2abmX20aYlzwHEs9CY+cSJJTnQDiuBUvlYS?=
 =?us-ascii?Q?tVqTyoXityBFvud7EM8ZWCdLqVHaeDEXUSyc3vJb9LNmTSTxsOZHwcx3njLa?=
 =?us-ascii?Q?TRyvctE+1SD4k4792CkWv3SNAaI6U3pwXxMwCHW3DYWw2lXYRP/heyrVDoII?=
 =?us-ascii?Q?Wwq00QiqmCZm56UFptOppq7YDlhjEuGr/LLVJxsmX3WqnNmA8xQqjBDMnsuR?=
 =?us-ascii?Q?/GYAiszaiW9MNcHPMSAqNAtOkqSpl3r3EBaJ0ZFu1gIAygz6cRPad2frpg7A?=
 =?us-ascii?Q?2DxoMnundYyVMJHffCtXjfiZ0qTmpNfUwyx9uO6POgKSX7Fp9++M93IBVyeV?=
 =?us-ascii?Q?8j1c2kIZVmYvtp2aymDqIoUqztLANhhzKDnQi/YFVKuEaCVmNLWt32zJkIbh?=
 =?us-ascii?Q?2oMRND8xtBX2lS/eiW1nUF7UWCNUdevwLInpYgEQY9+GFXGcHQ9GyFjQSy26?=
 =?us-ascii?Q?99ytL7eGoO9G/72cqLi1MGSe3lo+t5Tz6Sr4QkYtIdGaHY8S4CB56yW4UnDc?=
 =?us-ascii?Q?IhdxXmSd//az3db2Jeb89E9iAVC20JKCck2l4JhnTJzcTTFNghGFKjtVkRmA?=
 =?us-ascii?Q?FpXw1T9YccfxkqK2PNd/3+dXfQSMGjdJ+1Py/K3AfDRysC2Lt2Ok24rpNAkc?=
 =?us-ascii?Q?oWlyFdrbD+LHhNFcTPQ/23A+bJJIvEGsZFU0mJmlApMgnLymb6kQGQEBmnY4?=
 =?us-ascii?Q?phDaYaPTU1JXzpAxcq0/eM8MB0fNvoRgZ+yEnCnuoFY+8xXj4Pg95CHJ+zTD?=
 =?us-ascii?Q?fkQueNfNN4JrzI6uJFA3eMaMys7Se4OyrI/9qZzShhns1fr7QoChWYEr8aj4?=
 =?us-ascii?Q?9BRhtdlfVZ0TaF9ZOCvURyEAlJzcvciq8rrWGaOqji/tcL/d9kpSA0RuQHwU?=
 =?us-ascii?Q?8s0zgzOxX14O9n2jJBAedk2/J/LhAscWmMuDFKogYTf/HUKqecfpzpQ2e/Iv?=
 =?us-ascii?Q?eoRfTvTzRWVC00YIstwk+sSD7Z8rBOEmv04Djn0mRk55H9EDIk2D/OR+MU/N?=
 =?us-ascii?Q?WFYbmOoCZDjnHBJnPI51Ua4WZ3V+xYjrobcwUbzgkhNEM5usFO+QQbLlangx?=
 =?us-ascii?Q?khGrlu43GNV8/0nahl9YgQhOoX1LEds67RHoZPCYO0zdc+Q03gi7CXgDHHCd?=
 =?us-ascii?Q?dIYRE10ws5i+DcoyFkdNw07lmM4KTnrQxl+dtFP+xNPadjB+GuLoXJRTKrVF?=
 =?us-ascii?Q?BGDIsBeriNkFBTignOJyq7DnTZZoSun71a9Cbi/zo4Y2BtE7ECxSmuSUxVp5?=
 =?us-ascii?Q?tAdu8AumwqUxEN5MDJvrsF7uuXcg8+TOc4Yssaj+fvATsbbFOjV0UEczoJQ8?=
 =?us-ascii?Q?F3mR2VwVty637zs/kHGlb4KyVkCvJn/ZobX+l3383v6p0W8Mu5S8nqDym+jF?=
 =?us-ascii?Q?QVQZNSBe2aInRifPGzpM17p3OPAWLEOw4et0lEoXC/iPQzcys9cNbNphCoEa?=
 =?us-ascii?Q?LdND3CjxF5UW5CLo9mCTn0cbupIRIROyPdr7Lh4q9uv6rZPzeoRmQzkIctM1?=
 =?us-ascii?Q?xgHPvraaZ9AU866SJwjPdiLWHs/ANkQUeAz9YOzpv4bBOLcr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca619d8-d5c2-42d3-0891-08df368b2871
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 13:39:01.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiBfxorno3HqhUwf6nWM/CFE0NyxPm/zqDk00DOIzy/PobyRv1mygtfqmePHPjVSmehLQzX7WJaQwPqxMna6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899

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
---
 drivers/net/vxlan/vxlan_core.c              | 14 ++------
 tools/testing/selftests/net/fib_nexthops.sh | 40 ++++++++++++++-------
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 223539099778..d11028b37472 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1005,12 +1005,6 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
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
@@ -1274,11 +1268,6 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
-		return -EINVAL;
-	}
-
 	cfg = rtnl_dereference(vxlan->cfg);
 	if (cfg->remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
@@ -2947,6 +2936,9 @@ static void vxlan_cleanup(struct timer_list *t)
 		if (f->flags & NTF_EXT_LEARNED)
 			continue;
 
+		if (rcu_access_pointer(f->nh))
+			continue;
+
 		timeout = READ_ONCE(f->updated) + cfg->age_interval * HZ;
 		if (time_before_eq(timeout, jiffies)) {
 			spin_lock(&vxlan->hash_lock);
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 431d7bed7622..adbec51917eb 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -425,6 +425,14 @@ stop_ip_monitor()
 	return $rc
 }
 
+fdb_entry_aged()
+{
+	local mac=$1
+	local dev=$2
+
+	! $BRIDGE fdb get to $mac dev $dev self &> /dev/null
+}
+
 check_nexthop_fdb_support()
 {
 	$IP nexthop help 2>&1 | grep -q fdb
@@ -538,14 +546,18 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Fdb mac add with nexthop group and static state"
 
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
-	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+	log_test $? 0 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self dynamic extern_learn"
+	log_test $? 0 "Fdb mac add with nexthop group and extern_learn"
 
-	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
-	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
-	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+	run_cmd "$IP link set dev vx10 up type vxlan ageing 1"
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:18 dev vx10 dst 2001:db8:91::11 self dynamic"
+	slowwait 20 fdb_entry_aged 02:02:00:00:00:18 vx10
+	log_test $? 0 "Fdb mac without nexthop group aged out"
 
-	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
-	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+	run_cmd "$BRIDGE fdb get to 02:02:00:00:00:16 dev vx10 self"
+	log_test $? 0 "Fdb mac with nexthop group not aged out"
 
 	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 66"
 	log_test $? 2 "Route add with fdb nexthop"
@@ -688,14 +700,18 @@ ipv4_fdb_grp_fcnal()
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
+	slowwait 20 fdb_entry_aged 02:02:00:00:00:18 vx10
+	log_test $? 0 "Fdb mac without nexthop group aged out"
 
-	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
-	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+	run_cmd "$BRIDGE fdb get to 02:02:00:00:00:16 dev vx10 self"
+	log_test $? 0 "Fdb mac with nexthop group not aged out"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
-- 
2.56.0

