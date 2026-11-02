Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793604843;
	b=XXI9A17Z3/vPwCw1ILt5x2sSqOAYYd3KMYFZQFvjpG3Eb7SsJJ5IC5Ha/2rNxSHlaVmj
	 ntbXX88TElmr0A2JnysCM4bebaSfiZ0l8DOadds+fsBZTfUk5XtRqhE5VbyJd6/B8pDv2
	 Wf7eP3qC9/eQGsINUGxZxvvm2VXaf2m6St+kPzjzRfH4U9adMtv7sXiXfPoAFY0nxsIRu
	 OThtAL2jDqiAdAhZ9AHPVwwBRwdyyKDGSWET9/7bTunxqwVBvHd2SAl77x6vXZKOrq6hB
	 O5vL2L9kLws2/2Xe3YBs84xXXDbmgsCQnUQXW7Kydel7wX00XoNmps4I98N0Dk3FFsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604843;
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
	bh=6fSnqTvYzbwizhskQVeYnh3ptDK0pQWgg0bHBbxuwpM=;
	b=S0qMowpWfeEa9386DRd7CUiDsICYUS0XiwY5ASX/Egn9f3ZHmJ4gru/YS/ebgri1oNUG
	 rsdCkHklQzptCK7OyvcW2Wg4yVg351njsd+uThB8cLY0uZ47CZel0Ngqj2y8uiDBMGfgm
	 D+MW0oJXoBX29DHJ41s7xLmhFwCG9GftcOqkBqjqfFGvPQMmGXM2p9BSrqZWVtGQzqUj1
	 M/j7Mwbw1Zod4Fdwt59lFt0TaJavd+vuKEHSZmaYTKjem+4kqhmOHqKyrEPTXecKo8Xn/
	 dvz5bCkEfh/jheWrQ6ZSTay9ct4oOLG3IJkpSoCgFLhxPHEk9a6+Ht96ELm5AsuqyMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kgwakDC+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.34
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC00606A326;
	Mon,  2 Nov 2026 07:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC00606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kgwakDC+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB7yyhRNdGrL+LcZKKvTr7sXPVL5LnhITsXWCAQ7Foj3L7HqHjZkdDK7AEJC9lJiNqLb4xfsBoLLdm5bzYOznQj0HOeJdefmEnKLwlyB4RO3gPXo4vSUlKyX9uK5BcN21srp1y8qi0IbaWsQnZoBUxsONXF+7XFrE3qr7HOpPvi2OlGhcZb4qyWynBeriYwcxrClk7iKYu/MqmzKDtgzE0oN1idi+ORrdYmhW+S/QGXvAh0D5IWP+i1yM3kyBv5HHHAuvlYXr9e77M5swg3Z12dNR7Gu7Fz2WQXNyypoARnFnCFRStxoWhN40dmJLWBxIpeqX/NBp6PSPwdavkI++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fSnqTvYzbwizhskQVeYnh3ptDK0pQWgg0bHBbxuwpM=;
 b=DQ5V6qf727c2JylSwKDDsOGL2j2+WM6neF3irgumCOHmlvb2euAa7mSZDOSp65VMKYKkaRm/vC0iifDXUbNpLnfvXo/qeMl7Qp9PwZ0k8Z5DAkA+LAUf5qMC80Ywp5DnNXb66QorP8c/u/jJIPkchRdu7qRCJPjwzGds8nlbQ6rz22Rs8xRSOcs5OG3GoeYK9d2i/14xkNzXnKwwv7xiAs6/8C1Go2BGVnO6dK7GQ+CnsKpdlfu7p4RSDy5YCPXuP7EwTjTIl6Vu6LwRsca8w4NAd3rtMUXz/ZwRsV5zNHjzu6jJ3CZ32hIoSFHhFrmOL2o1Fsu+eA+Iaqhmo1YTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fSnqTvYzbwizhskQVeYnh3ptDK0pQWgg0bHBbxuwpM=;
 b=kgwakDC+I2UpNtOfKhtKEoWVHvjaxDJxSLQ0HSuQ7ENElTa+SsghWJZuvJPE1iwh4GPhel6cKytLNMB9w8pGShOZ1jz93qtpc8qbxyVz5bqrjtt4co8t/yhAbWcqjYXQzNHg25Z/cEWnVwDkBxqdco03qOXQizESFqyBZoTznhL+O+RaEMPeU13uMDtyqeeW7NGv3qml5dQeegcIO+/boVfQQkwcDOdWUWaW1JK4GV1dqDfm+Ix5BZvMdLWb/hqtDWmmrRxY/+cleBpKMnRNN2/ebMI824RgFi2UQMefAmV14yfVq8LoqUgGZE5rEWBKiOOaZo4oPdlnAFRQpd0t8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:33:57 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Mon, 2 Nov 2026
 07:33:57 +0000
Date: Mon, 2 Nov 2026 09:33:47 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ben Greear <greearb@candelatech.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com
Subject: Re: [PATCH net v2] ipv6: fix fib6 walker UAF on NLM_F_REPLACE
Message-ID: <20261102073347.GA765417@shredder>
References: <20261028160018.73299-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028160018.73299-1-cenzhang@linux.microsoft.com>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e58660e-0b0b-4ad8-b829-08df38b3a789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	scWJg1QqpjApkopFiU5C0zqQ0tMEMUwLgAL/1C1jlxzIkHbqx0n5T0keBTcrjf74DF8kCm0PHGTZoVXbT0W29K9qUE4hJ/udHJ4zCz9ofJzKlv3h4burtQOgW0rMAlobUiDKAkFduEdYl9Jp5+iec3I4ZCOpPgIEqY0wkdZScIYij28cLfi6GbTJoizUWM6NySFpgu95sP5Db45v42S7WQzzUQjOxA6NtapFlSvVDRPk9zgtNFPLZZxetsJxoquLlCV+dhLhVed4KfDOCAYlqd6XxK8aBTlMRZeLLRQHZtS+O1pXOeRVa9u6zAoK0WIP1k2s58uetfL7edSO6T5GBHgyMQ81Yzt9KcfOD1cYhuIHlijB4ANJ6kWtzY3s2HlqRgiqqZ0SPENDyVXTmRWJmlW6ZFGH1KdXNpfkD0wnhz1jkHPnGC+6HHeILNxO8BYSQgPlGvyaQ/wBxAJ83Xkz2euuPQDBdQRHQVR+wP4SFS9FDsV7nY4IZSMUAJUc08G8VzIElNevfGoVPN6wjetkuTfKWiegVZcJiyQx1kCJTIlmtgdE9GqLnrw8hRt79ChgvgxQ8AwYApNWz11hHqoWuxdwqZQfPCAE5VUGkYPf0tSJQ+xaLxJCMck3eVmNHZ8O6cwfdkS7WekVdolEew3rQ5Hy2zc55uqAaWlR/jWz4Mg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U439p3N3r4WoOjbNiBqUeeKKAspZQzimJAA26GJALC3qM73HJF/iPI3hotzO?=
 =?us-ascii?Q?08Fwzw23g1Evn3zy0qx9Wr0+KmIhzZoCL/Ar7mqFLzbzx6yxXbhGIiG0yQL1?=
 =?us-ascii?Q?ugn168qkgTWQVSbWaVSLizIhwcRDT/lvWajlNFYOhUat4OT38xeMP/bxCyUz?=
 =?us-ascii?Q?p8NdUDcgXTqtWRJ4fsULO/V8HHz83CSGxpAt//GAhp812dC0i/AeikSf3ZLV?=
 =?us-ascii?Q?SkyjmzkZ58NIDxmLkiQOALDnoAwgve5t3CNghDwsE5r668rGLRZ24LkRn047?=
 =?us-ascii?Q?VK/PYhYcSjL+SfSKToAqkwMkrGqnCHxlgBJziQJYLqnmU7Xnwca8xiSyRaFp?=
 =?us-ascii?Q?Yk0+HSeCy5EjbMUCN+kxNnOeL4FDBLXtV71OviNwTag0Fmh6GxX2FYP8dQIP?=
 =?us-ascii?Q?zcY0mBWzxXsbK0VGE/CfSuVWntGeI0FlQZpRxe+7BnQoswtaecS7+vC3V7vb?=
 =?us-ascii?Q?qoi8fRj+z6Uvwx5cCZLvyhqfI0bBU4+zO3cn5Mmjq0x1kvjaK+/8irDKCIQp?=
 =?us-ascii?Q?onirhaTZRNPX4YrDMrvClZCxOMPn0QHaav0zmVoHlOZIYBA4FJ+We+k9d6V2?=
 =?us-ascii?Q?qAMXvef/wpx7wDbuKZyRC+LlEgbtY/QQFVjJuVHQrl7jEbOH4gDP5cD6iAKn?=
 =?us-ascii?Q?LiqmExT27RXmlWviEZU+DOXyCk55LDieDtsydIe60VXMC5FAmqirX7ep2GPv?=
 =?us-ascii?Q?NmV524rfbg4amJLj+wxUtivQgJJ12E+az5Mes1wDfUpRYJ/aE2HmoWOVFR8W?=
 =?us-ascii?Q?5R6Iyfed80TR5eV6r4KQamk7CBf9pHFxzSGGyOBq7BiNiq6XE+Yg8FFp/YXD?=
 =?us-ascii?Q?p9w/ezqxn1Q2gSK0Ihy86qMjVrMlgkEAICP7j42TIX6zbrCVceSDovjOLk8c?=
 =?us-ascii?Q?rVarDJAovSs1stQcPDARzsndU6+JNrBd4ukrdYG7SDluDGsLXMdqowfJBleK?=
 =?us-ascii?Q?q5BC9MT8hyNjcc+wJy+l3hNafMyLqWrfhKtQyfvb/0DiQ1t3egKErzeGn84Z?=
 =?us-ascii?Q?8jN/k5OvONm2ajlo3TdrtPYs5An4v/9RqCNTuadZ/+I81DHPx8swkcgcJQR6?=
 =?us-ascii?Q?WwNDScmpu/bb9T61NVb7IGLdIA1pwQK8d0tFHBDL0z/qGc52nhrTsswEjj3H?=
 =?us-ascii?Q?yFQqRRzRGe95te3OoagVJ3RmT+begelhUMljVZROSkgaea/ibTt8j9KIZzEs?=
 =?us-ascii?Q?yt9V6/Lkg8ymw+MmnvO1VJJ36IRX1Tg6mbyKzsgKvyzFgXGhD4a9hSFSHNr8?=
 =?us-ascii?Q?MQ04Pzwt5hlXvyuurtKwsRJ57b9/YkVpAW8JeO/Nx/7tQGqOEv7Ks+R6ZuoG?=
 =?us-ascii?Q?oP71vGmtjqfPer+kOTT7KBViWfIJN56Cn9kcIKoBwoelJdcFoIfZbxIWyLlu?=
 =?us-ascii?Q?SPXKrPLdC1O2azf7jxT9hauce1+nz7BdMWwcF9eG7Mx7R88+H8FNGmJ1ZB7E?=
 =?us-ascii?Q?SdF2lfZ8CGN36bmFCjPBsHPFjjAPbclD2TIZ9pQRsFPPdOFdTjD8cX/2SHjX?=
 =?us-ascii?Q?HZZEIkHapj74PGGXCAkgjVEgeW9uCR4RGLLOvWqCZUhtfsIonzAgusPRb5+U?=
 =?us-ascii?Q?c7RIg7f+U2f4UKh3jMt5hnyE11QA5L/N17V/tZ+QZp+BlYJac0sfTR/GQGpy?=
 =?us-ascii?Q?edJUGquAQiOESY2FdjDejzvBYumwRF/3RU5UPgb8fKryR3rhzcZNEy+7JsXL?=
 =?us-ascii?Q?alBJkSqfoscY7YkMJKAFnODGz7cbY4zD2vico91AY9EQOjej?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e58660e-0b0b-4ad8-b829-08df38b3a789
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:33:57.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOTYCHKTUJBXViS4X0WMnaYyuRXveTdCL4UW1CLxq8BHZqO3b3Wp7JeCizp+FGLlt6etmmaIJoKAXnnLtZxsKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346

On Wed, Oct 28, 2026 at 12:00:18PM -0400, Cen Zhang (Microsoft) wrote:
> fib6_walker uses w->leaf to remember the next fib6_info to dump, so an
> RTM_GETROUTE dump can continue there on the next recvmsg().  This
> assumes that whoever removes a route from the tree also updates the
> walkers pointing at it.  fib6_del_route() does: it moves w->leaf to
> the next route.  The NLM_F_REPLACE branch of fib6_add_rt2node() does
> not: it removes the old route, fib6_add() frees it, and w->leaf keeps
> pointing at the freed object.
> 
> The fn_sernum version check in fib6_dump_table() normally protects
> against resuming on a stale w->leaf, but it can be bypassed:
> ip6_link_failure() resets fn_sernum to -1 when the default route
> fails, which an unprivileged user in a user+net namespace can cause:
> 
>   1) link failure            fn_sernum = -1
>   2) dump pauses on route R
>   3) replace R               fn_sernum changed, R freed
>   4) link failure            fn_sernum = -1
>   5) dump resumes            -1 == -1, reads freed R  <- UAF
> 
>   BUG: KASAN: slab-use-after-free in rt6_fill_node+0x1c22/0x2cd0
>   Read of size 4 at addr ff11000011fa0064 by task poc/101
>    rt6_fill_node <- rt6_dump_route
> 
> Fix by adjusting walkers separately for replacement and deletion.
> For replacement, add fib6_walkers_replace_leaf() points w->leaf
> at the new route. For deletion and ECMP sibling removal,
> fib6_walkers_skip_rt() calls fib6_walkers_replace_leaf() with the
> next route. Reset w->skip_in_node when updating w->leaf, and set
> w->state to FWS_U when no next route remains.
> 
> Fixes: 4a287eba2de3 ("IPv6 routing, NLM_F_* flag support: REPLACE and EXCL flags support, warn about missing CREATE flag")
> Cc: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
