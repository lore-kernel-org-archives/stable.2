Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794328924;
	b=D+O4bVrM7n7rQMfh3icsp84dOkP7LywD00TPdR+37HeHjZrG0OO9f+6FnV/qyHVGLCl0
	 oMDuRO47+PiaU+ZTcoSMx0j9ELP8z8QP9d1dLQS1PyLrYfc/m6Iu7TA04o0w+Qs9YwInB
	 WvnAVkxx8irxuNrmm7N0XmHlLsuG7bfJzt+EvKxORNwEG9BQEKr7JYGO7iBFT7Imi+5nT
	 /0SXf7atInxuNoRhLdDU+sIioLSbN+/UpQgnchiFW4owt8FkB59CPLwHxP94X1NoQ5Smj
	 se3r1Y6tvSL2cG4QzlbVM7qlsYH/2q7/808knobRrVR3YI+uCg4mN43UsUYQ6mfRRTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328924;
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
	bh=ZsSkMa0Wn9xZDt/vgQ9lJAmyns5JF+3b2FCVI1MX5XQ=;
	b=fPA4PcfFKZ5uXYNS/8vMxEAdG5GftuQ5jaeegcv/Tv1PS+v/5l3vz2i2nyA1Mnf7fQK8
	 9uOadnqQJJ3y36otmCskMzWAz1eFE5hP1w/zYAhQPVrTYBT326HVP0hgo3wUbDbNX/3+4
	 qU7cAY/a81oAfoIzpYGinWOKml1ViazD5VKRuVbSMn9pL1PVrGWMMVSam9J4jpBN9Ei5y
	 wg3KXMRrAxZwlvr5cxHP2U5yLx3BCh0O82AfN4rv5DbTOkR+xRE5Mte6CwYnKw1HLBWc4
	 XEqtAsd00rGxH6JJXJI59ZKgfT7+qapqEWJzyPU6pM1dQqmIbZyNKUWKKSRxHKR90AA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y98QKlWd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.21
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BAE606A889
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11BAE606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y98QKlWd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQYVP6xOFp22p5cuiLQzRblMD51a3BgTq0Y1xbwAlsrY8jDGamp5589koK04vi5atBaiQJB0k2HJskwyrSJrvkQBWdDoU0yeP6bp+DznhmPUM1SW7aqVQD4ePM645pPBvJGJG/rnM1a4P72CVJV59N5acbP+2aHrDoWkGFVikP36pBVnhSxsKr9KH6hlzj9OL1hQL8Cl9bqOWWNV/ENL98S8S0J0CBxtihiyMWGXRdGga4+xVWxn0E3nXqxU590cMHo1brHkOwyt821pKxRxU+v+CIQlH+JjeIJO9VTduaOJjB3wnAyeaC35LyccTwVZ7tcGWNo0zICemXAcSQwF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsSkMa0Wn9xZDt/vgQ9lJAmyns5JF+3b2FCVI1MX5XQ=;
 b=BwE9gK5brl0e5Owme6Ztr8mwBoOyZkrSUzs72u9voG+vf7QNMGWCEzLpw0cObAvyRvAPNRlYuburdO+nMs72Iu7PNPML6ghj3muFO/jBrm/MiBOSNmi3KAWRQBHR7DgF6C7qhYg1dRyFbNdqpuIvcaCaSZPNVvTx70JRa2AmNfhk8DC2ObeXUD3/xLhncKYMuwpT7b7zn3kY6KNFIX9aam9JQv7wEMYeXKDP2hhyh/y0kZ9KrpgZCfxomFN9jHXzeqLFWmytYhHDshAQ0XFRS2kVM21hEV7zikNudQUQqU9YE9lUKMG1tt1Zk9wCHCHxkrA++N7VC3BaUqZcQF+m0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsSkMa0Wn9xZDt/vgQ9lJAmyns5JF+3b2FCVI1MX5XQ=;
 b=Y98QKlWdjzPk0PNKDbMZ0leAxsNZZHMEu66kfkZlTAH5oO7JEhpJmH0auvofDuOSI6gjh/OIxLwDL5js70RoeUysSboIw81cCSPZoeETbTD984W7GILJFjlep6UcZ2javbzaYUxIplhG2SAI+Nm/p385mnuu2V5km6zRwfvQXcNtS0gweQ/T4Lok2otvcO35atMDLxfZap2orJRl6n7Pgo7kNO2mPAofeb+A+ZbK5KxtFZqG+yV/PKpY6goaz0JYbs4MpM/gB1J0TgbouM+KLbS3pqXCymM3o7HyOMveyVwq8uBdnIJQkwoCS3KyHnCPVDknCo8QKuXuXkl+GbEWrg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 16:41:59 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 16:41:57 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.18.y] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
Date: Tue, 10 Nov 2026 18:41:16 +0200
Message-ID: <20261110164116.2285331-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109200343-failed-6.18-7308ef8b4a67@kernel.org>
References: <20261109200343-failed-6.18-7308ef8b4a67@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 942239b9-5f98-4e81-9afa-08df3f49890c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|6133799003|10067099003|11063799006|261028144727099003|261026121527099003|261102123227099003|261021123027099003|261021121427099003|56012099006|261022105027099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	gESkmr7lonPdwfnEu7aBY26CeYIU5RQ55ON8r5W3B3HHWArCFnPASJ5YZqO5QhnaiZviSHvC9zpvvaMzv7eC5hVZGWBh5/HqU8OTbpV3hvq0x7Q5x+AOm/rr61YIglgtZZHwNocx17jIpuhAtbzrNCAQzLVpHCaBiyWPLfcsuDahs9cahMivfeJD67DizEa2LZ1DaO9yZc/El7M7WitX2ew3c4lob29SIPaKKXT7TF3YFMvjIZFAg8h6JFzSRYXlwXBLxHl7oMei7R3/VBIAnEdOidm5QYyNAaKZGd5vsymoPINfWls7tMDqTHfw/gkN3Fiv5zKeQlW5/2+M9kZzMp1Hdk0bP86IuB69BHS0SCRy1F6lCwClymM6frohNPnodcm/FuaTPdlHLvgvSh/hjSBVqnLVxI13EbIkbW7of13yXgUg2D8kYWHb6NJfDe0yeHFAK7W6IqqnV97ehY3s6KCZ4pFjQ+iyM1pxvytqXQiig39ghCQyZqjJSFbhzGzkwRbhz2LBQgnBNUoEc65lKHVqPmPSktlXmHh97+SMo4Z4cj00dT6ioif1NvXyDIaa87DpHlJjCe+hcivNeHYHxbt4XfLbYaTC2JKg3sdHvuHIlnchWJLJF/7lGRDvhSjU/3bgTu4tIqpwwBio8gZ2O4/Abp7x+zw28rb2FeA/np4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261021123027099003)(261021121427099003)(56012099006)(261022105027099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5kvv+P3YUvwem+Cqts8kHubhn7m5rVEQ0XBUUbZKDDt4w1AXYKSKlliy2GFD?=
 =?us-ascii?Q?18vl3ZAPsUy39Ol1TO0lVjOiotdnrDMn5ibKLCs8vawiYoCcHRTq7rw9O0Ol?=
 =?us-ascii?Q?jBWDRMVHOcE5NdzjXCEFxYaskk4DjE3HT6pVi4lYMq6kcP78+FUGqmwnk+GM?=
 =?us-ascii?Q?lxYVkUIrlTGsHf8kbaidvQ9sTcUliA75JsyUgDOF2Kjhr7+dvZ5fzZf7GOBX?=
 =?us-ascii?Q?eA7ekz5LPFKKOUpYUBvvW4s1Wo8OR3NmtGJAyOM7zbjIIf/NZ8o4vTymHZQ0?=
 =?us-ascii?Q?UqvAXPl1P30vOwG0hYSLTJaFBobPsieZ19qSbQ2SUIOXd71xFGWa9nZQ7Dac?=
 =?us-ascii?Q?nJDk6gFPLrb+x9jaRjPlOlwITvHxhb1JwjVgORBRLaMA4dk+wtttK/8k8aEp?=
 =?us-ascii?Q?8MnMl9EI5fXn8KHtjVAabNyUs4yCuiLUBFj7GrVkQwuG/IArl3/hsRvRAd7B?=
 =?us-ascii?Q?k9/7SPiy875GdinrkVMt8kIf4BBH819i87FjyUPjOJSVbf+9iWPUJL+XSd/M?=
 =?us-ascii?Q?3EaEN6+79IVrLHik5dUcq6pLMWR8oUYRrWhxURCE7Gsz46v1Ija5kRRGoRY+?=
 =?us-ascii?Q?K5hpoC9JdL39sD6ojacahsic2wQYLHzhTEVMeg7DbJ4VtfCUQXs6fhOldWxc?=
 =?us-ascii?Q?n1MBi/KMogVucPbCCzgTOPbgf+6rWhI2qQ7b5GSFvxhV911h6yVaZx8jSs0T?=
 =?us-ascii?Q?J94MdZA2Dc2AHTbFIBjbDqZdAPFga+j2nH5CEJrbDs0waSMO73gfoWDhda8J?=
 =?us-ascii?Q?EoA8JU8OfzwWfi02GTx8rnTG92gIhn223HXLbEZGSOPvKdqrn22l6Z5J/MxX?=
 =?us-ascii?Q?vQVYAbER0rYsKMRdzWFbIr/OxOc4Q39O0oxQKNy6p84jGEaYVn8NlDVlnntZ?=
 =?us-ascii?Q?52sDBmc2C+VMp3JQXeJFn7nC3r73/lHWIYayCeYYPr6Mi1Hxr5x6QDJzP0DG?=
 =?us-ascii?Q?ka0RrSwMssgd3zqDY7wfAJOGTnyDVzAjXbHXzTXAHMdgfjNcll+yEYZHVBPl?=
 =?us-ascii?Q?1EKB/N+GMWkgN9wdoplwnSc7NDUW6U3AOQqCuogFx11BfweVJ2SqydtHCQ61?=
 =?us-ascii?Q?d8qxFnBw1kSYDXjD8cNtL7GxQoNKHCABFpX+/EH+TS7C/Ie5bMOfxfIsLoWT?=
 =?us-ascii?Q?rr7DVa6zMSxaJFjjqKB6vGyOw0uLuulVQ20szYturnHuCYMO0r3jhvQtYEik?=
 =?us-ascii?Q?10w12lR1o/QckYk6opShwxqHuVw+13lcI1YtB0oj26h3UHWnvW4sLMSnVOlf?=
 =?us-ascii?Q?WWcncbfp+OOUDl23PzlX3fxHsTT+YhZGJqO8RD70zvtSjrgnxQLQpGwQ0DcM?=
 =?us-ascii?Q?8eg0zCA9zHlVYirItjejeLOLq2BoIebJUzNOiyodO5eOG33IRS6H6XnBIDbI?=
 =?us-ascii?Q?b51VuDHzjxlINb370lKXi8GIOiWgiQXX3TJOiA/zyfbutXj9ShfjRiaPvDny?=
 =?us-ascii?Q?G7L5RFEFPS4DSJuZ+0USEAg9kbNRYo9l54SccBmnUDBvjzFMtgDXy29YHgtK?=
 =?us-ascii?Q?dZaihWOqxs3gZripm+8Ea1F3iNN2sHmPxdReu5mec/rqe+HZqId2Hu6hYaLv?=
 =?us-ascii?Q?aQTqZABQpM4RAqQtfUTJo2UAIEF9DA0echgbwFi+si1O4eT7VWGeIUwbTAfo?=
 =?us-ascii?Q?CYIu9Ne0vWbBkyptF3t7vWfbV6hVumb1tE/eG06okNabzLQJomZHSZimBaYY?=
 =?us-ascii?Q?yY6BPSEByffL5hlsZ3KYrJgsR8mnVCBRvzFs69LDPOcm542zkK/OFwS4wNzc?=
 =?us-ascii?Q?6CSyozajcQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942239b9-5f98-4e81-9afa-08df3f49890c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:41:57.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qes0FGJISORF90wwPq9wLs4qHPwomoAWnkBagPXVUzS/AGHr/qa+NBbhw9plYLj7iRabtICIRQhPwU47cWK34Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519

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
[ idosch: fixed a small conflict in vxlan_fdb_add() and vxlan_cleanup() ]
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c              | 14 ++------
 tools/testing/selftests/net/fib_nexthops.sh | 40 ++++++++++++++-------
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 580fdec50bd5..090d50b16381 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -997,12 +997,6 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
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
@@ -1264,11 +1258,6 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
-		return -EINVAL;
-	}
-
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
@@ -2889,6 +2878,9 @@ static void vxlan_cleanup(struct timer_list *t)
 		if (f->flags & NTF_EXT_LEARNED)
 			continue;
 
+		if (rcu_access_pointer(f->nh))
+			continue;
+
 		timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
 		if (time_before_eq(timeout, jiffies)) {
 			spin_lock(&vxlan->hash_lock);
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 7e450fb9d65b..db65dd4abd3f 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -423,6 +423,14 @@ stop_ip_monitor()
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
@@ -527,14 +535,18 @@ ipv6_fdb_grp_fcnal()
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
@@ -641,14 +653,18 @@ ipv4_fdb_grp_fcnal()
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

