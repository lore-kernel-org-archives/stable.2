Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794329367;
	b=GfTGJm3xCtaOZ9/OlfLCm2hdb2shjFVvrVipmRxAtDzvryRO7PYP5kreu6ZgqzPyEhvk
	 IcnGAUft/7ADgpnmj9Ev2Gkto2ARra+HIiYKlwpdGrQbNnbI6C40UQRrOCQknwXHBomZb
	 YmX2/slHo6I55CXJBd/mLxgRdPe4HR5GB/wBB5oQAylfpXtYnM2Mlfx4rVh7qKwBzIkcN
	 /LdKD/DDcIafBXqK4H6eBRoRZcgBIRXnhmxLVVIfa7M0OXJ4OdR43XY0e+TTYLyBXhPr+
	 X+3IL/Yb7KJrB25Vzo++2KYjgHickzgutDy5qmqpv04jAAIxmom1e8G3AD4xY9pFZJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329367;
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
	bh=VYaVtKD0mUIAPyDMYl0szJiu41Dt8UwEYg2LOc5mCi8=;
	b=RTPB2y/2a2Dn90MQGcvaK6kRXE+mCL+KdxXiOlMaJ114XjG1zIfslqA8f+TowZEwTPvH
	 /+8NQNH5NOws4hyyKJgOkhyDER0/j2k1hmp0dmOsg6zirk9kLxphruxGrKKDKuxup42Jb
	 hzr1GdVum6FVhgyGTCxImDC/ko3Ey2Sajk6qT6actzYV6ruPEhW5+LYVD/oIOXV7OLlvP
	 lfKhypX06YCWHzuRpNsaCTSfBn8dP/hZclGg/UMCmgW9egNy1Xy/1sy4Ue86tl1sUAHOb
	 EURbpyV/erHTByydjB2twAnir1AOzaU+XSqP7OZZ7VieusFr7ICue+u96KKqt4DOaZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RP3VzN2x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.69
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB645606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB645606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RP3VzN2x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPdMUd/kqircZ3TheqgOVtBzVs2dP2yph37zLYKUIG/RFzZ/lrWawLA3w82TLLd+g1/oxEKmx4icwIY7jwkjqjkEsY5bvzvn9YyZkFwpZjiWXw6W7wSzbl30ZQALyhfFjyWghNAV1Zq6qzFgM0uVytb9WgDD1bR70ryoNZ5SalqekclbZppIXywD1ZEmlfAgikeId+Qswu096BtIHsCA4+n6PkzU9At4LY5p7+ULiowwnfXc4Ql2F94jfgS7NVMI0lnkE95/nqBj4l2mzTk40urqzB7DU2douh0r1ukrES+1nTrpRnnGIuZoGV2/ddMS68cSeGOBZw5rNOnrbxM+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYaVtKD0mUIAPyDMYl0szJiu41Dt8UwEYg2LOc5mCi8=;
 b=lA3jMZbkIN75ruoEXq7vYxRw4jJo5am/j2SLrK4BetY5uxTLCLpmVJsQPSsYHUfS/nWQ9C6lWlSmXFcC4kOawdwhyVBv5YB9ibOklvfOX7oyIBmOJRvmz/N0otc/UkDLWXXqoqGUaQZWQiNxU0C6oRb47tWKDcUSMMW8xau7CK24kjo3bBEPboF+vX5jxE+unCKUhefFggDK6JNm+/1fjfGLgpyp7EPkt0/lODnOnb1m8DJMZ4vn/oq4Tx4sTZx2K1YNG0hzkafuDhGm1duQb47KE1BS/RdOpk3xvHoqM0wEXwE4xUven2kAQSRjyQiAVIUhdoxvxyT1tq9O5DzIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYaVtKD0mUIAPyDMYl0szJiu41Dt8UwEYg2LOc5mCi8=;
 b=RP3VzN2xmbdA/V0xQ6K7cTYNKOcOTusIX/I2NgBwt1PeGFdvhOfgs0tckPhfQaWed7H/rxECOaZwFWCWOYzQ5iGhDQAjE6BlkcYTlOJZyGYYmqxzEQ3sI0ERB5tiaGFL6Jl3QtRDZGE0i4UKY7pfM/k6pBxud8P8nZMA5fJr1pAasPQSzr/ejitiJSU42q/lT8H/vFNKl/yxbWV721u3KpGyVQVkykpGOKYs2e0srRi/DqGENMavSR77EYI2srm/HpKk5FpTVJTEBqr3ZKdEX9fMttrki7XTz5JVlPpl16l8uUKKF8eH8HyrvzkTvK1x8+AhZ1SJMalALW5Hck2Gcg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by FT1PR12MB100801.namprd12.prod.outlook.com (2603:10b6:170:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 16:49:24 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 16:49:24 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12.y] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
Date: Tue, 10 Nov 2026 18:49:04 +0200
Message-ID: <20261110164904.2294593-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109200730-failed-6.12-7308ef8b4a67@kernel.org>
References: <20261109200730-failed-6.12-7308ef8b4a67@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|FT1PR12MB100801:EE_
X-MS-Office365-Filtering-Correlation-Id: e2052af1-6538-4e62-d116-08df3f4a9334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261026140227099003|261026121527099003|261021123027099003|261028144727099003|261009223027099003|261021121427099003|261022105027099003|10067099003|261102123227099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	44J4yfCb1fpCBwxXof1cmHnnF0+tixqMI1bJWK86cfa1hzg/Cvb9BKdkcTSCwr9SOKEy6z4fQ8LAp/hANX+ltg5jxtHVZinbKDYjatReisk6Y6gujonAdWS+vBev3zo/qDCtx/nALj8pfa46Um69UD0Dzi6u5p9iF87bkAmmymTjxlUumgm2x+mVcUweeOsFacituRtOp0P/aK7p+0z6tVdRuIHqfyhi/KKZEFJ3rG7y+dhFQ+M7E/77CJm+5rQxWYySDzXLy5aQChlrwSpGndiBiCrxw5O1/JoD81A8zl6dyS88rcnqlGUeNJuKHzb1Ifyy1KbBEDnNuS4pp6h8kRy3i0RUd4uYVXsHpeBiu3AxP41YprjoobljuKXQ51qaYW+2QNrvvWjwvGxNk4J4/+K5sJmfWM2UtQec12lAAbqbKzQ/kwLtC48dao8lU+McbnbHdL1V/A2m8sCwd/DPnyIvqvBMPeEmNYX/NOpqBfU3iM978wm7HlXuw1vnXsJFuDPleaGxR5eJ1XtTrrcvB4SRoUVZnRqFKuygpppAYDi1REZsz3hDO2vZn3/yr6e7tgylBnsZYI8J7y5P7rX6VpCHQ5vt/lj1W+9F23za5R9hBklB4zN2lMgsmqK0DzQEqtms0H6HchYO2zAftHSy0T+KxjSsO/SZIFzfuOD0uw0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(261026121527099003)(261021123027099003)(261028144727099003)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X66lXrLWUltduhwpU1qTAEUrSXQYuvYKCWqouEgRpuyi98a7t0mZ8ejEyeAB?=
 =?us-ascii?Q?pztcs1PL7tWxY6UmpCE6WRX0lHdswFBLgZJTIHrCQ94DdwUvdOL14zNFTAtw?=
 =?us-ascii?Q?71m11ez15qaDwxP6bXHMNo+JeieR8l1Esq2Tg35X8fZNaoE7+OHMAOETDuh3?=
 =?us-ascii?Q?WPnNpOkXliuYtWSVjOfDrPQdwv5mGHHyKsuf6FB7agT0CRCOkl4AnPoet3vG?=
 =?us-ascii?Q?dhkY3SgzQduHdSm2KricBTYLawm0P1UfCfG8zRvR86ga+y9dRwiXudaPQNHz?=
 =?us-ascii?Q?0jWYY39GlxJnkSZ4snz15k+PScTRzx1XRtvU51RnKHcdorfvg70CCLP4fIMz?=
 =?us-ascii?Q?+9gG7PmlBC6MgkdOWuWZNcTzwgDm40Hp48g4jP1pcTioZCrmMtjc66CYJ8Hg?=
 =?us-ascii?Q?9g5XTGVdgc9DCRg/dbzDCekdPwWpzHZG6i57W1XUnD32LF9q/abUOeFZQy8h?=
 =?us-ascii?Q?0UmL3bLQmDuLmqj9At7x07T+1WoyK0MdgzbDZeGrkVAkEsIbphG+2B/G8C8R?=
 =?us-ascii?Q?nNvBgweMy36SkhbHKR5vNBKKYkcryW2xzjMgPZJjOoYEYOTN8t9rPTAiqMB3?=
 =?us-ascii?Q?FVMvTZwVxQZL8eEDKkkvLPH5JOkIB/J3VmuDg7XZfDhrLGhE730lGtEt16mv?=
 =?us-ascii?Q?JdtU9TEOjPc6a13msI6FBTtnRY79Ag6S4cJNQoBTU89kjGYlCzVNdjT36D3h?=
 =?us-ascii?Q?0NBXJa50Ga2XifAaNpRTBW6JPHT/3fynu85tcvdQCQ126XVtEHIebB8YNZF/?=
 =?us-ascii?Q?/MXa8JaMmFJhF5NOY3nMzHky6vsQr5cvrCtUceXjfCenGBzTKjq2C7qRACaq?=
 =?us-ascii?Q?UPFJyf/0/OLFBAKU0vYmdk/pvcgYF34CQgoyPefKFof0Uk+UBq0o8x4lygMF?=
 =?us-ascii?Q?JvJfjLQeXUR4cUKp+7Q7LSPcxukz/zfk6gHAg96V0euyQltCltCUfGKdCvyF?=
 =?us-ascii?Q?bB+x0EDTKPvO38RrgZxEh/RXaZi86H/vKd6q31Cc0N7l3iqZFcbMVTQEW84Q?=
 =?us-ascii?Q?3/T1rP9i0jVoRxwhnC42Ty+ftyi0lBzFBQkJ8Bg3TA0/Sn/ZrooyPATxrs3f?=
 =?us-ascii?Q?9dTh/4ouMKZkTaEzCWlQqJ/Uze+g/w7dZVPGClTUP+Cci6eIFsgFSSDNUf3M?=
 =?us-ascii?Q?u+UreD/e5j7Ojn73h9F+Jt5K862Fvq49tRKja2UqRcPFSjsVWBXmNWGTFPhl?=
 =?us-ascii?Q?r0ygTcW7yg/+kY09f+VZOqAB2JNBO9boKh21PxpZANDBT64Sb5H7W4TGJf1t?=
 =?us-ascii?Q?kLJk3yg+MbQCR5WQRrO9bfTsBN2GTyVB0lUmh2JB7FF1NMqS0gxASJpsbpjA?=
 =?us-ascii?Q?O9sATNglB843tVOO88kwfKvkMdj3pbT28+/ttd7nKaj/kcg/O8XIKLPDIhdp?=
 =?us-ascii?Q?usWRoRcrTUQl1ldatDQ7AwgcQyppc4Xx3hdNcfSzKNJXQ/FXTN/wDM1CN2Cz?=
 =?us-ascii?Q?ORD2fKP6ZA7Jm/wbsz1Me8iKIRFSl3xk01ro++431erub0464Nb0ZCQ7iAfJ?=
 =?us-ascii?Q?ggLhjktyB2jA0yvZ5a3lyfkEKKdX6G+loUU/35tYKddpVjimrWBXqIVLXD8o?=
 =?us-ascii?Q?wdmcG38yJslTli3UQuAS9jXnbjWdSzeQt7E83FvC9Etejcuz9Nbhnjzprcow?=
 =?us-ascii?Q?ZL/8HsBHULBwYX/4ktDQzGXOPpz3tKQODHYFBW64i+Bl3RQ4GN0bN73qTFOt?=
 =?us-ascii?Q?VfFR2g45jezeJhdjFQ2Ck2H4qxn/mtRY6l0cIiiPjSJJplfgFjFqj7/77EC2?=
 =?us-ascii?Q?Fk25t+zFkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2052af1-6538-4e62-d116-08df3f4a9334
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:49:24.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTm6S+MhCFwDQr3693OJul/NpSi/8WwgHjvO0bsH/NaMyk1Nr3CXczQFFoIWB5WUm7KiOjy8yUI1jQnKudlZbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB100801

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
[ idosch: fixed a small conflict in vxlan_fdb_add() and adjusted the
  vxlan_cleanup() hunk to the per-bucket FDB iteration in this tree ]
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c              | 14 ++------
 tools/testing/selftests/net/fib_nexthops.sh | 40 ++++++++++++++-------
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index e70a0b657570..caba78398d92 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1006,12 +1006,6 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
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
@@ -1279,11 +1273,6 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
-		return -EINVAL;
-	}
-
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
@@ -2896,6 +2885,9 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
+			if (rcu_access_pointer(f->nh))
+				continue;
+
 			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 25a4ad02ac16..3a9d3d8419d4 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -421,6 +421,14 @@ stop_ip_monitor()
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
@@ -505,14 +513,18 @@ ipv6_fdb_grp_fcnal()
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
@@ -599,14 +611,18 @@ ipv4_fdb_grp_fcnal()
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

