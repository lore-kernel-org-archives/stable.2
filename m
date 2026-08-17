Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910113B2D04;
	Mon, 17 Aug 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956543; cv=fail; b=lNzZZz3K/NJHOeGMfNLfWhh84VD4Y/9eAUvWFo9F4ja8cEMfCFa0mMPh7a+9mfeBMQlCSeYABIjXXArkx7QWHRY0kdz1cs92lAT14auv2H+Ebk6W7wjhaYHZPZFMWyeSwDXh2+fP+iaKNYFJ+yf56Ns/rRZXR2pt9RV1Amby6Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956543; c=relaxed/simple;
	bh=jKUFHKtOkzB/gZwPRTqvM0gk/D8EWFNCJR4NVlUgGPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JX5/nY6Uw5b8pkxIX0MZHbJt+Mu2A4q8y+zJB/O/WnwzTfNhMk2Tlf0IUR8eaIfr2miW1pYcldD09bbaa3zZmsrXh3ZC4d98mHz4SEsSCUUAzlWG+SL3vtr887FO3ZVIadZpWSVBOAcNRh1rBDiznNE2VbEn206trp8+9Weu0zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IbdgjWd5; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IbdgjWd5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsQw/nd1cTzNyg95caLaVzZ5s3I4xQQI0Ni7P9S1w+YiacTHEaFybc07O6IJvYLSzPa8nNuFBfjNCyALaogc3y/WnONZGwpRIRif2h1eLDxqwoNMlys8TbPi3vuHjZLDB6kywbGj2wR5mVyTObU8fyK7w74/wV9vJqtOd7zHVqWJ0FMyuR8aVZ/4Oc0lc7MWH+MgUMkniJHG4DHYAL8ZrCu0ArfLDlnMV1hUDR5Vv/pjGsk00w2eSY+VLqfh4OirHLjsH0QI7eRYbDJNyI2Mnr4xoxdL9gjhHCEi4haMoLZqNdMlcZJvsu0FmDkl9HYkv+EX30guvgHefKhBxq8edQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ASS+SXtXKIDAXMrlP2pncbBXOSFROTnbFsmkoG2ad0=;
 b=mrgwuMDL5WazZuUE3ohvRYUe5cI0Kl0blkX2ix7q0kanTZpZLbaLtZAsXGzYPRbcsQBY8TuZeM4gqR3RNaPdExoSBOVjWSII+kEr6Tc/2U1MGbXrpf91Wqnv2zl+zCfiyJcGOaARdU8r5W1LvakmsWp0+oL3Q5Do5pvQVrFsPMRIaqqsy97zpI1yDS+BQy1ceoU60bCVXD9vVQQU+Q9IAO7rtOf2QNWlG5fkEBYw5dyb7vdk7PavcxH/uUf9NJViz4CrMlD4UCgN/gKPLQuWiMuXbFL7jHPOtnDtvwMvkyyMJeatc4h0St0BCmdVbCgSmpKpqUaE/LBdxU26hsfxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ASS+SXtXKIDAXMrlP2pncbBXOSFROTnbFsmkoG2ad0=;
 b=IbdgjWd5xQwZMGgcmHFwTGJ5Ju6TIOvRvBG1ABO7+5JEbYC1pxQdXXw0znono0DsADWUcbc0MKS+X5hJjgOi3YBrWGUp0Rudx2o/XXy7VrJsmB85BinrzoaSV2IZrNbF3tVWlN3QG1Zb1j5l7eF5ZSrqgkp2Ki7Pg7CVjrjIYFvjedKFVKGABSSYG0oyIQYoLaUtXW6+nNAYXBYZcNJKQb6YprLBLSHiqE5LHLMhxP9e9au/JuZzsm0bDR/B80tJG+VVEDsgxOPOxC/aSvpcECMnHJ+3u+IBEkIBfK/sJq3Rd9Hqo7vcTNeuzoIxPiK5y+Du/TCHieqEpllhF+5x+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 08:48:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 08:48:58 +0000
Date: Mon, 17 Aug 2026 11:48:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: use RCU iterator to dump route exceptions
Message-ID: <20260817084849.GA283708@shredder>
References: <20260815084651.69477-1-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815084651.69477-1-sigefriedhyy@gmail.com>
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: bebaf046-0951-43f9-7c75-08defc3c60f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ADCEuhkH78P15uKIarD2QJclKTce/6HVwIE+DNYaQmI0hp92yLEZ+TU/JUxEXTxfjWEL22KmEduu1cqFH2tpw7EaVqRRDAtiZ8VbhHiu5tEHKBIbiefcr8tulEBKLxWko0DcZoLm6RmHkO1WCh2q7/KAP/6tJxMeGePnjQBJIQj/wZtEU9bzF2UvEbpTH0hJtZQlmmD8KREPTZJq3RyqBfm6N0idPjN1e0JY2IkaabLElssmQpEN4C/UWCMvKYT4K0WMTXYEXaDmEwTpQyQj0qK4JgY0dG8XVNOeTXnvCR/iSQxMSmrCk1nYGEn53oiD9/B4lxb5b49u0BPPCkL9ung7lutm52BPtCnvuRUWK0C5zAEUq4BBBpexdOwoi34Xb9Npd/LJQhurncQscg5EgxsyVggF7nalMc8BnEd38q1azqvgvVXkP24m2+H3GqOYv75shCrrCYprgwcpKfCLafq4/gp6nlg490PnGgcYe/d2vxTHI9lMAZqPeYfKJOhMPhQtrEFOQZvNhFM02KLfaYD2Mf4pBdyJDLCAg/qyauQd/jxbtkeG5XZBXL/utL6ruqr7mvxO/5j8K8D9vK8hWTlS0JaUKs4gOmb9gNuWQRgI+WqDclJ6HpyrTdHQ5ShUf4NGl/6ggp+DbJ6pxtUbSEtKHPW9CciqkXNhJyAvhro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8PiwttZmqIuVjL5uksLMLDIJ3MB8A0NjQem1I+QK1Nexfpt0H6UVxK+CYUiH?=
 =?us-ascii?Q?3YoqXfjWLsDB+v7xHP/vNXV+X6zZ+cG7prRjl9VCHx2eUXRCljL2WKEapSsZ?=
 =?us-ascii?Q?O3MdmI6garINUb/eukFPceOUQTQLcS/ek+oEIt/OMuYqKGfMWPb+GBYyn487?=
 =?us-ascii?Q?PvwOaNE3tD1cJmB6UZbYjmZ06Q+U490yS4aRevF6sZpUPgv7swlOP0UsNqkl?=
 =?us-ascii?Q?PUmh2eQxNks3a3FRJanfZh65DFbUYf8EtbL5aPdKQa8K0Iml8Fdj8fkc6MX3?=
 =?us-ascii?Q?Dzi2RxmJ3qF6YLOma6fZE7dzDc/aJ2kfevFL6P8nNGH/xWUtyLTG9wEW3rK1?=
 =?us-ascii?Q?Ml90z5dwFbkTVRM06lGW1/2VmdmZISzYG2f5lDLqp9Sr2N6o9Er0gft+pF/Q?=
 =?us-ascii?Q?g+5lek+CMxbo6kqfAkAn6TjFV6CzaCXWNTmRQBpt5HdryKg1i0yedrQn3EvX?=
 =?us-ascii?Q?/bor92nkQxD8BWJtIus/rG7My56ciXSpLJF/AN/TiYpNvf3a6JNP3PTZJihV?=
 =?us-ascii?Q?iBnFIB8wdKq6YcBHJ1pZsPKtWadd+iHmrs/mKgwyYidEoFG30T1dMoqRrkk+?=
 =?us-ascii?Q?iDUokzjmrDUfKFNRcJiHYhPC0VrvSeMPXU5WWnVjsJhCgIcI/Z069X6iRCW7?=
 =?us-ascii?Q?tYF1VkDg7GpmU9sl76du5F33/2a2LWeBEwVdNpAblJdMXD89uqrcXEIV9kwO?=
 =?us-ascii?Q?mDrsaxiq8C/Xs9nUmQikod9zcufH3umGfQGvZLbHDvoX8qSrzf7BPVUKaHBe?=
 =?us-ascii?Q?cpY6CmzQPAXBDu93orPb966FbciBHGScI7td0u0f7kflco3uI+NzHF29uytM?=
 =?us-ascii?Q?G4KAogZ0+/Z05hKvMZZ2GisrHBOb/1O7imLIBfcdQ37UNQlaOcGi8C6I/BwP?=
 =?us-ascii?Q?bfSKm684L7rHOMx3M5QNfMguratpIFJ5s3Jv7exaiW+hA7r5ZPNY2yhh/c8C?=
 =?us-ascii?Q?HnWkBhDjdZYpON1Ie1+QXht8+gufE2MKKZIevc2e1SK8Z7MU9oDCCxNsX06u?=
 =?us-ascii?Q?yVKxxIBu1B0cDP+Jm43EEsGg7WVlDPG6nCVb+Wiwh3sbTgSfsI6jh5vvhqPT?=
 =?us-ascii?Q?UStXGcMEasUzWZi7EpDOmPA14bCUUJ101dYHBm2kjx5nScmlpA7ksxJ4c+YX?=
 =?us-ascii?Q?9UJ5AkG1xftpNe6wSc95OiRt7OmpIuVpWMibxtyeW9/2KytgqsQftS95lD+S?=
 =?us-ascii?Q?fKynyOhBB9TXX7ECS4din7UjrIC7Xu820XpNNpEuAnrYulCeCNNDDnurE9/q?=
 =?us-ascii?Q?6GdOa9ervRFxPxNeMUFXxnf2snpcIP1T1/OfIG5CVGzLW1yGSTqzGS/K6b4v?=
 =?us-ascii?Q?RDKVXKgKWLRy8FGJSLpAcToCKKFpD7aBDmEa5iyoXmrlqZHholnAhdD9BLor?=
 =?us-ascii?Q?p63PRjQ1m80webuPWOJVzUD5mujaYYcQgjStlA1FQaHOvqtpLkFW9KHv6YbA?=
 =?us-ascii?Q?rXZ7CJaGj7ujjD0MX+GoYrn0Q154gZzMBZB+sjpo53Ke80IXBtLmXpHhMa/S?=
 =?us-ascii?Q?wOmE/6iVHmBFx8OxWTGrKZt1eBV7AfKTUWrX+7yj0ZPlr30AbIJT8qNtk5FU?=
 =?us-ascii?Q?5y2fi2ibf0gUR16meCAFXjsUaH84GNVdL9gMCXyj+KRK9H/dh0tnRSB22Ngs?=
 =?us-ascii?Q?hLrOBO1B/hu6lBRLzfIo9I34AuXSU9+SIIUwCVemFPHYIcf8Or0kO2wgdFhd?=
 =?us-ascii?Q?By+476Qv6L6aPR6VVwgwid7Y98pYnfFDbRICjTptuDKWWGsb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebaf046-0951-43f9-7c75-08defc3c60f2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:48:58.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8nBh0U6XKUJW6KTcLPXWMMe1cu8dyNCvNoabWInR9MAvtaR+Ywb+v+ijzU5euPxneLm1ZmrB5hmm+9DhRetbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067

On Sat, Aug 15, 2026 at 05:46:51PM +0900, Yuyang Huang wrote:
> rt6_nh_dump_exceptions() uses hlist_for_each_entry() to iterate over
> RCU-protected exception lists. The caller holds rcu_read_lock(), but does
> not hold rt6_exception_lock, so rt6_insert_exception() can concurrently
> add an entry with hlist_add_head_rcu().

[...]

> Use hlist_for_each_entry_rcu() to safely iterate over the exception list.
> 
> Fixes: 1e47b4837f3b ("ipv6: Dump route exceptions if requested")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

I don't think this deserves a stable tag as it only silences a KCSAN
splat, but it's trivial to backport, so OK.
