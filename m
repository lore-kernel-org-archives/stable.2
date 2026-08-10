Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB82C08BB;
	Mon, 10 Aug 2026 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376900; cv=fail; b=VviiWM/eBL17n+A23dsqeKP32l5VL/s7q1/jq2sn7+oxAeUFQ12korZml6NGH7JICFMsU9v1qMfdUln3ELRQMH8RcSvssAHacMUpT5dGO3mbGwRJ7YeqmISr4qbRw/KHrFKoF9sizZoKz89iEQVpl8IssmRfj5ZWTccLpPAPDP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376900; c=relaxed/simple;
	bh=pCcMWJN4yZGFfQLa3CDkbV20uoInam5M3YsGpATU7Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E1AfGWNxHDHcEA5JUvIcoRkVF9fDJd2QjFqiB70HBh6PZpuKdPdzHDdE3pjSRIS1986+tyZg2vimbQOlIpnL9CIRUmn6PfWmkeJsiA8NUUxMuQ2seFg2Nka9uYAfnrHHmax+kLyWRyUhKJQEQIN9OogaqlrGwMoRoiE3bq5zAv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WIhkMkWK; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WIhkMkWK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVudfNg5BJVPubqKvARVhl/OeN5WoJZsPTFylk0PgAVA9c1GRJ7ojcHvIdJsQKRkdu35u/z/Uw5vDQCvarIcUmtH+NB2fdVIvYnaZx1LMlmR7kJQM4w27Ao88XTD6p1qgwxoP3mAUDq0DR4xEmrSujkRgLllmzsVUMHe2SBNUfmagMtYRiqQLdEJ+QEk7J/fkiSRChTAznzxwgkCI4g/S99K9vo2pjiWq7k/gLluHP95by+5dtUYMcHlUA/Su+KoEDBeIJHHEqvb4FM9JGRKF3Gfb5Kuw6+zpLE+2/GpSELCUCiQ3tFe8GzWqMtMg4jKXqtibvrZuSi8mkW7PLUhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8IwWYu6QbRfRz20CeeyXJl+OBKrEVp9Hxd5BJ+SFS4=;
 b=HAZ2+cgGJKtIkapsSuTVf5sR2QezxEZWiie1jOv4HSiH/ZHbVptVz6OnSAUlnNnigtqz9MgKHQ5VS/18evd/f7/GZ26gWUQbmi3ftYCY3Ce9L+pzw+r40Ilb9WeNS0qz2eIwRrPmLX6g29UwK7ICNy7iqtG0UDy7Pctt59h/1ds/nLFs7rVJ//RRkLFXLCDk9T0OVM0Xj2zBBXJqn5eMjY/t+qsfBAngvVlhe02l/nSZRraPsZCXvegkMgyFNgk+nyDGUryAlWH5OpG76MBEolOU8wbOB9o9jxjY5I4OVdUqsTk2VT9YEllIW5RMN/ZBv7bSvPytO5OdP0chiUiSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8IwWYu6QbRfRz20CeeyXJl+OBKrEVp9Hxd5BJ+SFS4=;
 b=WIhkMkWKktvfgI+kCiDgNmMpbKZD7gWocN/kjrOohbYf4JeqpIF8dtWxvDnDv4PdXfMgnwyEK1nGYr4I/rp3VWzf6rwq10Vz3dntA129O71lLAojHcwS/K36uFtD36IX7inSz/RNC19j4a75eIYuS8dX+7rGUHhARKq28vEI6YbGCY9ekYX8wxIm7YkICcttXEuqmt49sxhYdSD13+PrH9sopDzF6ZpRnOStwpMR5/KHo0CtzQPA6JumxwERv+IGjKPcA74qI73lWeuxmP0HNVOJY4BjoDz74gholEjAwYcZJTPHDwb8y1gdTj0GJ3fDH/J2uTDq7acaJJyyCUQscw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:48:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:48:11 +0000
Date: Mon, 10 Aug 2026 18:48:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Lee <david.lee@trailofbits.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] vxlan: keep the last remote linked during FDB
 flush
Message-ID: <20260810154802.GA2803521@shredder>
References: <20260810144115.821654-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810144115.821654-1-david.lee@trailofbits.com>
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd9079a-0b7d-4920-8f6c-08def6f6c823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	b+n4zc0w9hlxSuXAWyztZ7WpfC9HBWgQ0dVjXFK1X6tT5+Xhq9Uja8R7eVHvPcrS6sufZT56yyG9OBuhJggfP2rUupNajpZ4INn3nteu+BRKMQH3m1VJkD1THVknkPz427iUhQXlexpYQ/RmXDwc67ii32AYkfrNd5Fc0VgmSljSlRRS18dlM3Vy9Pck3Z1bDA8UFq9+JT2uY8XHdduOk9qs2O2QvGvygvvReuJN5eyZxu3yif6YAEcNcZIEZNs6v2h7FOr1ErN9LbxEZsXa8a4FQV21AM3NBVLGmOrARdH4WI6CzhmlrwPmo9dk+2bmAUQFVOabQYcfXc/u5fxauv11Taccdj83kCiuz+PtaDxP05BqQF04Qn18CJGz32k+kWOYmhtjxmK8D02DtTOen+QjJwvrUWj9i0Ml8LXXHnWRGC4aZNH3sLxHlH6chNVO23CcZ2vnW6sTYflE4dA4CMJJD8BsflYLDiuLKZ7XmP6lZmwbTDmlby5XZtl6QSlrjM/2p0wurgJxazoC1GYfQ43rRA2jq38H9BItuWdpfGU4cbXeCusWIjm7YOGIHiDOgxmzP9q47EVf6XBCj80n1Ez8hjO5j0H/c6+H5LjHqUA3JCkbswZP5x0XTXua34p1F1SB3aonyPfDuh8Zf1mXJbyEZDIK5KpohNR17KQX+GY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLwwjNYahlg4Bw4iJDl/Icap6V8DAJ2HtPOdCA04+ll9kW4q7PWBUNTbSpRd?=
 =?us-ascii?Q?LDaJHILPgx65mh7dSpX7Vd8YVbYuhqzMMNr7/SqLyfls6kLKuRUhrLUvkoc9?=
 =?us-ascii?Q?CWuttk1MfJj+oybkKQ4wVixJ03OgICsRLkMTgxlphGtoMSu8LLY//9ySI5P/?=
 =?us-ascii?Q?fCowyKZEAd/np7Hm3yCDXv5u98RC3GtXAyV41U488s7+Vrmpk9mQ7iq5FUCF?=
 =?us-ascii?Q?Z0QFNzuQEY9FhYfP8EpRzcZ6hGGp07BrsP9DKF1GXXATIge0AL0EvGjJ1lCy?=
 =?us-ascii?Q?Q94iorAfidLY3P1dIV6R5LdRS9DfPbR/yDMiwT1H0YmqOarIkCOko7Q/eIgq?=
 =?us-ascii?Q?H1FOM7Rx1skL6ra6weRQT2EQ7fqFUCHHlF9wW4anzRwLJIoh8HHO7lwQ60ef?=
 =?us-ascii?Q?F85S7K/Vwc2R6nLbjoQsQhFYpBz0aWRJ8XaTosMg7N4TcTI03UQZVlPe1ec2?=
 =?us-ascii?Q?BW/ZGKPDYBviJhANHB45hC2Jp7MBjKWDeUJC3ZVfyNHjSB13a4jASx83+Oz5?=
 =?us-ascii?Q?lf5GBiuY93LC5elbKn5yzrtOdmtt8GlS7Dfh4UNGCARdr6TpP8sWToXZRjM+?=
 =?us-ascii?Q?0IkFD8Ql9yIGq+hBQcei/1pfNzyvXBot+8/AlhUpMrTv1KDDq/WgFI6OG0VM?=
 =?us-ascii?Q?MAW9sP39zWDAWcvK1XtapZN+FHzQsGRTuVKnKs9/l46hYvgIgjaPynBIq71C?=
 =?us-ascii?Q?bJDczc1eDXvxCCz48yEtezMWZw810W/lsS5NwEzU6kowlSpozJK+tZlljIV/?=
 =?us-ascii?Q?I0Svw5JciIGro+NqCMF3iC2tc+DUiGlrNDeY/myWuOgVGvgVFIR55auFCJGZ?=
 =?us-ascii?Q?WuUrDV9y4dSwiEx0afOKqUIF0nWxsaH96gE3MQC3iBKlPxadAOWNB4csb51e?=
 =?us-ascii?Q?Q2QtfEzQiRb19oSkdA9AnIH2svd8VyYxE3TzSq3FKboGLZFQMcHOEYqtG0nH?=
 =?us-ascii?Q?t2999kbm90eh0gYE9B1KZvvjdF7Lsgzrs66H2x2RslMOMP4h+IB8O57mehhJ?=
 =?us-ascii?Q?Q25KYXAfFyNfYjnEapxSSZVnVynMGumk7sjg7ywmev5X4doqJmIT+WgzBcRw?=
 =?us-ascii?Q?QzujeCtiNGyA2qRGdAthh01Y6y/IFS34mkt9xZkLZEsYzW7a6ZPfuynmc2YG?=
 =?us-ascii?Q?UUB8O3NTvxTcdBzIca9HYEATLBjPDtJc5mxpNNKvJ+mbWb0ifjzCxKUj1VJX?=
 =?us-ascii?Q?wUWgyMUhJNiHoQG3IBQUGDET/pPWjhEsxh4GTh/JNoeEZBaAaIGxos7uFS2j?=
 =?us-ascii?Q?lef3JWfcWvIZeVTSHBjQk5OwxoCve3JI6aXuXzHBnxKcAyVuVDR/hmbQfzKZ?=
 =?us-ascii?Q?SVNHEb6wYM8NxrRyN/G/2ULtDLlPedflw6jBiFA8yxo9T6pcAfyeMM/tlLlK?=
 =?us-ascii?Q?10bVZ0cgxjckee7QKCuSAABeCOl8Gl/vy+5HPqYEeAOoxl2LvVnl87WljqJk?=
 =?us-ascii?Q?tMY3J7ZAafvg7+y6nAk6HIcnFXV+tJ1S567LkJKxMLINwPIxwq58oSXMdUXS?=
 =?us-ascii?Q?x9StEgCUfeSakXwK9omoyo9cB/tbnYw+IF7TCxdScn+Xw4V0tqYdM1vgun7Y?=
 =?us-ascii?Q?ErerAgCZF89SVxRkvdftkzhvmfum5q/MYDdCtLYmbPMW+HyIHO4aKyqGiMHv?=
 =?us-ascii?Q?t85UqqS+65LcfpStl0VrHIZUG9gT2a1gg98gMSmzbWQDrEOTmZbXYvdqwvNY?=
 =?us-ascii?Q?KH8s+7zY4ChcssXesSZWUAxk/fmh5q1Pn4I86XyaiRWKAfWt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd9079a-0b7d-4920-8f6c-08def6f6c823
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:48:11.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGg65mQmWkexZIJy3xtERrv1zSt9ByDsAauRvEBsBEXjYqB9kulmr/ZbgtIW7L2JluIujLcotYxO9WxUOp4t/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793

On Mon, Aug 10, 2026 at 02:41:14PM +0000, David Lee wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> A non-nexthop FDB entry is expected to have at least one remote while it
> remains reachable through the FDB hash table. A filtered bulk flush
> violates this invariant when every remote matches: It unlinks the last
> remote in vxlan_fdb_dst_destroy() and only afterwards tells vxlan_flush()
> to destroy the parent FDB entry.
> 
> An RCU reader can find the parent during this interval.
> first_remote_rcu() then applies list_entry_rcu() to the empty list head,
> producing an invalid remote pointer that the receive learning path can
> read from and write to.
> 
> When a matching remote is the sole remaining remote, leave it linked and
> ask the caller to destroy the entire FDB entry. vxlan_fdb_destroy() keeps
> the remote attached while sending the deletion notification and removing
> the parent from the lookup structures.
> 
> Fixes: c499fccb71cb ("vxlan: vxlan_core: Support FDB flushing by destination VNI")
> Cc: stable@vger.kernel.org
> Suggested-by: Ido Schimmel <idosch@nvidia.com>

This tag is not really appropriate here since I didn't suggest the fix,
but only a small cleanup. Anyway, not a big deal.

> Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Co-developed-by: David Lee <david.lee@trailofbits.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
