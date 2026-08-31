Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B53B14CE;
	Mon, 31 Aug 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174422; cv=fail; b=FjZY1HGJmdVTrOlgXxiNHmNdjVqHTvacOf5YsnCn1gAX4VQ3p6N4qOfXu6wRf+mjx3p+ReV6h4gXyACxsB4szqK67SKF6YrGGm1nwHvdQjsuknpYhPXMhap3udULR4lydywSzRg2YLYzAutETStCUaSZACSF7IjymPTEXGu5iAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174422; c=relaxed/simple;
	bh=NknlPhbuBD3l+3GHvDBRaonYX1IC7usUDqJXPtSy6HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bfQrE49bVx7tDlC3NZVzIzv+tX/p7Lf3cfVXdzw7G5TiDsbYjcmdQNXZ0KGFsUB+3DO8ZQuZJIbPIg8pbf4ljP0LDRfNKSWyHUn1XsXdo2LiEmD7/FKR8uTmw6QjH9z5BYM89hiQfv+Ppr6+XYBCsfna0t8yFuDdLDYjNGI4H6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aoaea9Kd; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aoaea9Kd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMgdAlYcP0ZzhEU0ckpO5z3RDYfLrc1Vra8ASC3mffyxruewoLe2jTHTaodCZJ7ciiJvD5fp32ZWknq2u82/rstBa92VCxTWY/SUddtA+DhPM+FD6zfK0VYpmJwft+DQDZkNx/zM/hMLqGf0YvCIIVUJXO2NzIz4efGuX6C9SpDOC5uUsxsKWmTFwHvXDuMsjitUGBI2JUhwT8qGD8qbxStcYAGXSo9GYz57Q/nsKTnHMiGdwSb8xT4LyZHRZAMOwDUr4jrrtiL2CsuGSaFkyfqouwBmVfLxXbkOPpwwfA0RvumN5QtItOiS8ete8h5mKvI0tSZOqotUgHzrd5iG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94TldNeMmEuWmjKt2/LhugFGgxirPJsL2MwCJnO+GIE=;
 b=d5JEGx5O+QoV9w0w/Gbf6g30WBbgU0v9IzuIqJ4kFKFuyeXj3IY5+dB4OOM8zkUr3A9yAQQZb8VWOIrs4EjsI9arDndVWEuKMjj01TFoX4LviIGO9H4m5Rv7BJbXwpdr0Lx3U88VJaMrEiMtt+H4kx2KNTjO8hK3KhuljRalv997XlnEnFKtJgx6eXKYeWKMAqfj4THa/vzJg8EuicR7IdydpFUzrjwOPK30PmeCIcKKNgzzjd73KMc0L6KET6Mk1KqsDFRKyJwmKLlyRnDUYfwcslSUnpclfQb+WB/lvWCPCG70VOqzuKxe2cctsGxbH5AegP+J0l09ml5XLqsSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94TldNeMmEuWmjKt2/LhugFGgxirPJsL2MwCJnO+GIE=;
 b=Aoaea9KdDxNDCgm6JdQqtljmd6v37vzc2t+lCDY5SV1qBW4TzIsKqRxLqkGukey74sh7d8aSYijH0b2/pm5SbxSA+E6S0IN+k1AgtwRD0BbefrU1T0/G2xQTSWpbIix55Tlpk4ysOUkaYU6qDGo8qtUZWccF5EA0jXjWcr8RXsw+dEZlZtBfeAwCW1La52Wy9yf6SUw8qfDAdu7DFJli21YCQNZXkpB2QHgEmTGG8L2IwwZPc+wqSVXeFfB8I6Il7pSup5eZU4dpAidPSCBpXQscBwx8hg95y8R5r7SkL8O5wEfvCbbTubtoCUv9JEXgdSxNCEqCVtIPyuWe2kPpJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:06:58 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:06:56 +0000
Date: Mon, 31 Aug 2026 14:06:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Patrick McHardy <kaber@trash.net>,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Subject: Re: [PATCH net 1/1] ipv4: fib: avoid quadratic table ID lookup
Message-ID: <20260831110647.GA3202627@shredder>
References: <cover.1787982246.git.zihanx@nebusec.ai>
 <0a00492a13038b268c1e0a219c138d07cfab92b3.1787982246.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a00492a13038b268c1e0a219c138d07cfab92b3.1787982246.git.zihanx@nebusec.ai>
X-ClientProxiedBy: FR4P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a5985d-139a-455f-221c-08df074ff8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|56012099006|6133799003|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9MFyhKxr76srEGdBfs6y51sNMXy97hQRqrVu5JWZOh4uenGW2o34mdxl7VIojHDT4/vpWMEbr+A1Xf2b4eC2j1p5dzw3Fm7KwsKdbCf47UPUPRjBdfiq70A+F7ROuRL+FkEjpFx9I6W73EZeOXTpCdNHqs0iiGbZMql64IJiioSMP9cfqiPeAC3/WvCuJhsFLq2PTYrVXIo+1Vtk8ZAOTcvtIvAT5jg43Vz/d2S7su+Hx95SlmLbv19tnbK0JDSkJPLE/6RPF8UGtqV9YledGqEm+JL6d4PlUhLhginZjll8at+Xr9t2sKJP/eQ+ls39efZNUIOAt8AIqfB3LhV4AeREdN9PZeglv0BWEM8xEl0rUdaZgGiaUPXGGIArSvTRaSF6YmmieWLMiuUOXFr3irpb0XjEalOWg7yF4wu8sBqjVWRoHnU1gto+Gj+2sk56AS7O50kqSKVcXEyynFhjBeZinTRAkMKmkEXVxQ3ssJL0m25bJSeOTeW7iEIbHVRPqW4gxwZC9pQo8Yx/GwX7RrsDYYVbxblfQbjIPunvvEKvoexyZvENKwdiTB+6gTMWlpaAPY0YIRl+6sZhdd6NmmsAbrmdBpYjOgEpFHS4lADWvkHUeyxYFV9W5ObaR8smG4vmUfg1DLosdUcG2YmVgibycoRDFuOtGldPKcUARsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcIaSWuJowD6AIl6CZ8P4ppvdGOsJ15YbKeiov9CtlxLWdH+vLHzn7KqqV28?=
 =?us-ascii?Q?/1dx+mJE3UlN5OJcYaxQjXPt+Zzlo+S92KJPu/fFPhcbyMnCZVzGOHJ0VN/I?=
 =?us-ascii?Q?3TzVk0WJJ+SzD8Zc/bYUJxfjpPf4qa/eOTz36R6NWW9bqtgqUuVvwjz026yZ?=
 =?us-ascii?Q?litQj2G7BTNZTUnv7eAnT5eDmXNRlRq1WIvoh4QLbH20mbgljaKOdVSQCUzr?=
 =?us-ascii?Q?XJhxV0sBnbfr7R+Hb23gwwg/MY5UZtX+P2bg7UzOZbWsUYKp5x6AQo1luG0r?=
 =?us-ascii?Q?7WOafoNLcuTLSo4WerL7M3AV9zeVuoVTJJkNcr7NGoAszCsdoMOUxLmJ43Xo?=
 =?us-ascii?Q?9EPhWiwLbcdLG3nk6ZwQy4bwVYzaWN6HH9S+d0DBQb/DnjXfa3j7Lp/l/e+q?=
 =?us-ascii?Q?pZJ7qMVJdIkhV3VbElBsRuLVJ4ksHIiW3qTUjKxsFPb7bGXjWE7A9/FtBSUJ?=
 =?us-ascii?Q?+tpjQ5E7vkg6Mk/ByocjHow5Xg8BE3gZXy8F/wnLG/3660lneLiviZoQQg8N?=
 =?us-ascii?Q?QZ4dPqq8WukxzUZPNY2E7vdX4jEsPNWTf3hXtEmny7xMoDR7ie2NNgVWfhFT?=
 =?us-ascii?Q?OzkmCXPapZmImfQvV5c8rPIB/wjJ5+oP1kKGtRsxYrxMj0zXXp1T9KLNuNJ/?=
 =?us-ascii?Q?nsUX1Wq+D4xvdK6z9v3fuFMSAc9sfD6l1nSpMPh1lPNxWfxKd406PaN7TDsj?=
 =?us-ascii?Q?iCO/2TiFmZ39tNiPAsC7c26YqIHFTTPqIDgbO2TQuXDNMVNUNjYeWNecwVxO?=
 =?us-ascii?Q?Otmg1mLgPatMC0EolHLESO9xmnSVJrezTgHPGKq4tq2iiCs/BoDd1W/mlHKz?=
 =?us-ascii?Q?yjL4JaiVSr5cqGFGGiSJCSB4vOhjnsEM+ZxZ/87XgVg1YeHoFEOaD/JAvKLO?=
 =?us-ascii?Q?W6n903Ge+MA+/1EOP2H9R4TjHqmzDEDywnc5oMpoSHcE2j1n+4pyiMjAxXV8?=
 =?us-ascii?Q?BGBCryhVzUi/8jzPwCm+WlcOLJRM/gEDxw3Qitfv16ZBSVEPlKQ7B92e87yI?=
 =?us-ascii?Q?Ip+f8EzNQWPm4hM5KgvlDhI0iueZ6j5S09ecpsqVXppIfab/Gun+DYbqB6zZ?=
 =?us-ascii?Q?odJRs2baUOwglKRwl6hLXysgi6n8CxU3913h6g5G5LbPGP3yLigU3GTianyq?=
 =?us-ascii?Q?bpiut+K7yAH+tB301bZp3ueS7JUq356WNVpC999tcMcS11eVCPQ0nAqFyQDq?=
 =?us-ascii?Q?nqMIkg+poqFCnY0ToKGG1NM+AFkPRAQT/lhikiYQ2pI8187VKq8Rt+pbHlwr?=
 =?us-ascii?Q?yPuQ8RH/IeY9abUHvkhzVdlQTqtFYTJmA6bH3cvvwz4Ca4yvNBn05hyRxb8i?=
 =?us-ascii?Q?TyU2kpmbeCLyDSeGXnKx37P111hkr5KLFVHJeQ0fwRtrco/YAhQZAdmXbHnD?=
 =?us-ascii?Q?t/I57oAB3teDPxhGZEnzFD42YEJ2TtWMAXiQskmx0hcj8dxWsHb6U6DpLNtk?=
 =?us-ascii?Q?UBdloZb4v5YsEbmQwTz4W5Lx6rFPthI7e91ELXZL3ygszgNV22Y7mCwb5seo?=
 =?us-ascii?Q?dz6Bo6fu7+058SzGubwKhQKOYWx83SpiTXjcZgsSl2SMH0BI+6D6Oq/WsCYb?=
 =?us-ascii?Q?uLFr2cdytNNbAg1JSfIjftBcX79kVRxOFRD2xiIhbZiJ6Nogl7QCqWJ4Jk2z?=
 =?us-ascii?Q?JffBvMMNbl3xc1cPz0VVDeGK46f+yEiZHKqR232q38YoWtjtPlY8MzGS86Ao?=
 =?us-ascii?Q?a3fz4XHaRWyJzs0WP1Z1TLduYcJXeycWQaPaP09KZ8Yd3Eh+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a5985d-139a-455f-221c-08df074ff8a1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:06:56.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoWH9Z/yesE6wPpzA30IdyXYwLX6y44H6JwzqevGaPFhp0F85SZVasAKEWbOhT91p+FGrYp5HUEvKCxbJGXBxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805

On Sat, Aug 29, 2026 at 06:24:57AM +0000, Zihan Xi wrote:
> fib_empty_table() probes every table ID from 1 until it finds a free
> one.  Since IPv4 tables are stored in a 256-bucket hash table, a dense
> set of IDs makes the probes repeatedly walk growing hash chains while
> RTNL is held.
> 
> Count the existing tables once and use a bitmap for the bounded range
> that can contain the first free ID.  This keeps table-ID selection
> linear in the number of tables instead of quadratic, without changing
> the lowest-free-ID behavior.

TBH, I wasn't even aware of this "table 0" functionality and I'm quite
certain it's unused nowadays:

1. IPv4 specific:

# ip -6 rule add from 2001:db8:1::1 table 0
Error: Invalid table.

2. Not documented in ip-rule man page:

"
table TABLEID
       the routing table identifier to lookup if the rule selector
       matches. It is also possible to use lookup instead of table.
"

3. No kernel selftests despite ip-rule having good coverage.

4. Quirky. Requires dumping the rules or listening to netlink
notifications to discover the allocated table ID.

So, for now, I suggest bounding the maximum table ID that can be
automatically allocated. Something like [1]. I will add a deprecation
warning in net-next.

FTR, I did consider storing the tables in something like xarray, but:

1. We would still need to keep the hash table given the analysis Jakub
shared in commit 759ab1edb56c ("net: store netdevs in an xarray").
Xarray only starts being worthwhile at around 1k tables and most
deployments never reach this number.

2. It requires adding per-netns xarray for a functionality that is
unlikely to be used today.

[1]
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 4edb0dca7be8..2e8629df34bb 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -214,6 +214,8 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 	return 1;
 }
 
+#define FIB_MAX_AUTO_TABLE_ID	4096
+
 static struct fib_table *fib_empty_table(struct net *net)
 {
 	u32 id = 1;
@@ -222,7 +224,7 @@ static struct fib_table *fib_empty_table(struct net *net)
 		if (!fib_get_table(net, id))
 			return fib_new_table(net, id);
 
-		if (id++ == RT_TABLE_MAX)
+		if (id++ == FIB_MAX_AUTO_TABLE_ID)
 			break;
 	}
 	return NULL;

