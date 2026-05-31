Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B73783BB;
	Sun, 31 May 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780225663; cv=fail; b=bVGQJVg8cdiqpE2Nsetgw+3F06/TFTsceFWkl2M6lRWUGtfWV6REnyzXXbwq6MIsOLa2yvRnF409x7Ye6svtB4olBLycsewGFatrFEfZ3rGLlV1WQz3euplZluFDSj7BshgZm3EZO1ZkTokGwm5mxMzxQcmapkdF+V0vDV+hHwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780225663; c=relaxed/simple;
	bh=kn4qRmn4/D/KWUXkQl+wk2LO+qXJ8nkHX957FyH1Jqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DmznnMzHSra3dr4EDkhUnmjXb90EzVhveqJ8yVdwcKPQn/qRrrfgBHVO/5oivmGs3W9oSfpIifIkWjfMZKBsRvzA0h0Ob9giAJPb9qF9IKGqWZw6P1vUm7zHGbIl79wShWkSReONaQ5i75Z7jAgPTe0DvC9uOXUxRB1GDws1Z1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jjzeQrC2; arc=fail smtp.client-ip=40.107.209.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jjzeQrC2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urckQwRW7arUF9VSUkRU706qQu0g7tMWto94DKS8dHsvXgmlHS6KfxGP/jlgPQXlVZaU71pZ2c4+GCt8DLODneONihdVN/+s/0o8CVxfuCuyHitbbpLNqSOE0oKotnbqBu8Hs+pT8tOwkUNnsZuScm/T8yLqaJjXacIjIkqrj9ebNoig5JSEd4L4OAtVLvOl/g0g++rqTQXLFRqB5mh9v20jNTHnx7xcxzFss+Ha8WCcv8Cxjxxrb31qsYFr7n7e8FScVr9u4fPU7yS9Y2dCCAB5mVUWnpgVaYgbUez2LDKORSYr/ERCFFDCgMprW8UzRiJqp0bFb8b5VprcZNHtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nW7DyxWrSrmAnt6la52HtFrrpBDmkGj9eWyPzQA6lJI=;
 b=pD90qiItgWwxBWjRFLDqWxCbD4AoQE8EBBy8yItsV32iPUooNcTEHtEOuo4D8jG88TvZYfaS/i5Ncf0f/ZAFpm5QFWtywOJVbkStoi0pm8HffQQgqjNkJROvPhIoVW7xA1eHWHm24ZgLvXx3WRvGlo7jEvh7goQ03YWMrdddGbWcTxwThYprXhx1r0yLUdJTiNiIauLQUengDwQWdD1XezxSRu+Uyh0T1S83IBN/kA24Q48pvShikIIh+Iw1J3InMQDAm2U0NNhKwlFxYJhazux0YRp1UjEyqxIIif/kBMlXB+2/gro+VX90hSp29+61OQOeAWtJ0g7dQ87RXEpNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW7DyxWrSrmAnt6la52HtFrrpBDmkGj9eWyPzQA6lJI=;
 b=jjzeQrC2sFLb6zBbp/Ht39SQA8j4rLYZxUmW8XlQzWGRto8jLhyu5J7yvuWIWP005G8eQFUdhQHydzEXVZKrW7oohiH2vWul0XS1Jhmar8rRqII9ePaYZ3ZB6JJaDDTGqYziBuj+0t2UAZWt2DiFOfHT77Uq8JS+citLhacADz3Fs8+LL6JAdITCjOOS066YY9Seo4Pof7oq78svY9bYBW3iXqJFoo3KN/H2a5OyKe3iYmxc/AicauttJ4r5INcUiV1wHkRs9mB/EjAKSHQAl7av39ex7px92VmEZ+vDv9I00m67REzUUh2HdpyT30aJrZLn6/Nm9vCxZlZEpmyYIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 11:07:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 11:07:35 +0000
Date: Sun, 31 May 2026 14:07:26 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] netdevsim: fib: fix use-after-free of FIB data
 via debugfs
Message-ID: <20260531110726.GA179107@shredder>
References: <20260529135718.1804031-1-yzjaurora@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529135718.1804031-1-yzjaurora@gmail.com>
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e247bc-b12a-459f-056a-08debf04d183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kz8dxxScXOk8XMK3RbuJS2tnCR9kHua2/vZp9vQPAgpgMbAm/HJZwcZzGD53H6UC0o1ZD3GwCLioz2bosHvofIty/RB73TrVMGQNPQs7RzUNcB7Ou49JblDnioACxmi+CakS5JNUhE21rEQF2xj060ybfYyfMf6srqkucgm7H5gRVUEbnaZgwewIPK+czJdkWBTuCkwcX9idcF4i7UiPtOLEDs/fk6VJUS/7osphCEccvAn3KZScslX2sgEVG0dM1S+3zxcoLd2yN8/Sny6Vgq2hN6Q/br/w8/mHAiv1vHrENfY5QT6cNNwPRQlhrcUP74UCO3l3V3rGkNJKncbJznhh6fnrCWJH4XZIV3c0bkXA6POoYYUT406XBwePUFWSaVOTx7qc42dv2GMmzF0WXLL2zpokcv5ScIlSB019RxvqIosSxCeNJWwphDuUmCLyoId/iwk2trZ4AjNYT1kxJfPmVle2cjstrE3ZG1ic3S0gqoBcUcvssTRt9EOJ5nXRxCVj4J5DdcALe3UXOO3inAy/oFhjx7N1lYx4hyjDUOs6wzdqfHaYrVqN4dziy4BO2hu80I+E4TI9hjwTpWhJrkEvkOpP9qPiX8GU+GL/aeJs9GhNQP1RETl8OJ51mXwzOmDAjWNwaf0NDyFwOhTudigrNOXkf8g1XZPuwCX6/U2RQR6vTcgIeeqZBu6+Gfr+ne/sCzHZj3oxdEJv8lVk6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nBaW9FnWxX48Cq1fnh+TjgvNMJEPsKSlCTJJrtnidbBSgbmkF1WQh8jBImxi?=
 =?us-ascii?Q?tBWitw7aKj7X904k4uAwSkmMFGYdwOzN8WseZON9h0qo+waxc12GtsBBJnJX?=
 =?us-ascii?Q?OvIfMeVDmF6Ouqi6u1Ui8EWwdtAaMkK3T79yfIxlwQX638vLNiq/sPZ1YGMG?=
 =?us-ascii?Q?ux8hzl3loqcfEkfppKMKk3bn4JMaje3AjHSUN4w9N6MUUmKr3IlpEPXkEUyA?=
 =?us-ascii?Q?5YxFq6W9SBizG6ZX8oZelN1nle8z6XAeI0ZXbWpLq2EyjKl3Dg09+mWeDmKv?=
 =?us-ascii?Q?0oh7i6+H0hbSfwsJCNypJOdaNVelkpi5Wemk2CJ1iT9tyHBpm/GgeCjSmRTS?=
 =?us-ascii?Q?r8ePh4wbCbkAHrfl13/IhWEJToJDc4YC/yfvtK4EuJnZlCfscJvSkk56lXkm?=
 =?us-ascii?Q?e5ApMeqGFThprbsnfjIiJfv0Kn6VYWBtPvF8b3I/L7fDqTCJNgZebM+81wcK?=
 =?us-ascii?Q?aeFq0sA9/G2Jht0yzbzIVrcGQCtso6KouqvlGclEnoueWyG71AozMf+G+hl+?=
 =?us-ascii?Q?7UEteBctbI1w05QIcV7Lpb355VJeXwnUtYNVmhix79eNTTj2FfMam1U2WA7k?=
 =?us-ascii?Q?NNKXYkD/aSeXY5ky2dqhUeTlY7obz/zzz6aR+tMJHZhgzh/Dc7qdDeypHcsJ?=
 =?us-ascii?Q?0VrI0DS1//ftqIwFkrlHLb5ld7gvNxUT4DYva0gfhhF5QRTdIZuB5j6wEy8i?=
 =?us-ascii?Q?gpZmf/Y9ap3enfXf9gRvBSFbaPF3TeyMQtvMxDf1hrJVR8mQoijecLe3Ox4F?=
 =?us-ascii?Q?oEvmYFq+cdYfhfueA71WrSkFMweBAYlAJoyXc+kVyIkEuICerLUGHcKr6hhP?=
 =?us-ascii?Q?fc7XPxZIlioEs2YEQ5QVzn445bQ0YDhXNPf8Yj1VtfCr2JYJeWSOJ2xw5G9S?=
 =?us-ascii?Q?QDFXtq++felX35KZRxC8Uhi0jfFNzqvby6mqWe1eYO9ttq2iPzXozR7jejGM?=
 =?us-ascii?Q?iQWhNSrv3DTOB3/PwlUQnl888q998y1O3nCcXkc1DBeMSNH+Ec0nmgCsSwx0?=
 =?us-ascii?Q?qyNTxw1EvhqJOun87FSHLwOzhASEBpQKcarL80i/0PF2LYf/lnymoIOPFw9C?=
 =?us-ascii?Q?2YOPAedtYjJjCtD2fSWM0I7cgFd/1YkcUaCKDXj3BB//iieedQLitWswdgzq?=
 =?us-ascii?Q?YY6+heoBwmTzT1PPoNjxBUS4pUf6vAAhf88Xz/Z3DO6ujzTxyteevgiPOUsa?=
 =?us-ascii?Q?VG6IioQbEvXgFodmiwfwcYXPSxGJno6pJvqOF9hLLJ4Gabsn2DWjHsqt9ByR?=
 =?us-ascii?Q?4NlnsORYyE2CD6WS/eT+tZRYhMJOluI1uyXy9b67w4Te6xhPF18i7FVx8RM5?=
 =?us-ascii?Q?D9u7lA8+nFQvJCRKuu6AhV9PQZid8FoGdi4AvPFvZPif+x77RcvKlVoJ5iX7?=
 =?us-ascii?Q?1T7iQ6VV+HPYznzKsLwaYWbSSwe/Bz2rOaltKZwElGX46CDiUNEzTlIj6Ywu?=
 =?us-ascii?Q?lUVv6UVrzm77o8cIF8pHsDRsnupiufE6QzOJIYLIuecK0yVXDWNRvU5wPMVT?=
 =?us-ascii?Q?t58YtD1DexjsG8fhFZ/4DxkriK+9jhw7vZceaNSc9ngqCGHp0DJDu9XsAQub?=
 =?us-ascii?Q?eY65eICZR8QOeRY3u0sECqF3Yj2q06zOpffFx8M0/OTAf98e/Q4P3EyX517a?=
 =?us-ascii?Q?an/LBU6nKJfZy9ybwzDboI2fjz/tliDb8A1Qw60CMK6Al3de8WbB5XdatBFh?=
 =?us-ascii?Q?Xsf83TSBeHmvfbVO3H07pNuwtX3MYjx1bPT/x7VI4XxgdUJX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e247bc-b12a-459f-056a-08debf04d183
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:07:35.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7hqEAa3/Qh8BN6K67TEx132CEabmObdvU+EIEaoxwa8+eab7eulgaQwW1nOPZHWFAr2Al1Vs6S59EFQfLttSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

On Fri, May 29, 2026 at 06:57:17AM -0700, Zijing Yin wrote:
> netdevsim: fib: fix use-after-free of FIB data via debugfs
> 
> Writing to the netdevsim debugfs file
> "netdevsim/netdevsimN/fib/nexthop_bucket_activity" enters
> nsim_nexthop_bucket_activity_write(), which looks up a nexthop in
> data->nexthop_ht under rtnl_lock(). If a network namespace teardown,
> devlink reload or device deletion runs concurrently, nsim_fib_destroy()
> frees that rhashtable (and the surrounding nsim_fib_data) while the
> write is still in flight, leading to a slab-use-after-free:

[...]

> The freed 1k object is the bucket table of data->nexthop_ht. Shortly
> after, the dangling table is dereferenced again and the machine also
> takes a GPF in __rht_bucket_nested() from the same call site.
> 
> The root cause is a lifetime mismatch: the debugfs files reference
> nsim_fib_data (the writer dereferences data->nexthop_ht), but the
> interface is not bracketed around the lifetime of that data.
> nsim_fib_destroy() freed both rhashtables and only removed the debugfs
> directory afterwards, and nsim_fib_create() created the debugfs files
> before the rhashtables were initialized and, on the error path, freed
> them before removing the files. debugfs keeps the file itself alive
> across a ->write() via debugfs_file_get()/debugfs_file_put()
> (fs/debugfs/file.c), but it does not keep data->nexthop_ht alive, so the
> in-flight writer dereferenced freed memory. rtnl_lock() in the writer
> does not help, because the teardown path does not take rtnl around
> rhashtable_free_and_destroy().
> 
> Fix it by bracketing the debugfs interface around the data it exposes,
> keeping nsim_fib_create() and nsim_fib_destroy() symmetric:
> 
>  - In nsim_fib_destroy(), tear down the debugfs files before the data
>    structures they reference. debugfs_remove_recursive() drops the
>    initial active-user reference and then waits for every in-flight
>    ->write() to drop its reference before returning, and rejects new
>    opens (__debugfs_file_removed(), fs/debugfs/inode.c). Once it returns,
>    no debugfs accessor can reach the FIB data, so the rhashtables and
>    nsim_fib_data can be destroyed safely. This also covers the bool knobs
>    in the same directory, which store pointers into the same
>    nsim_fib_data, and the final kfree(data).
> 
>  - In nsim_fib_create(), create the debugfs files after the rhashtables
>    and notifiers are set up. This closes the same race on the
>    error-unwind path, where a concurrent writer could otherwise observe a
>    half-constructed instance or a table that the unwind has already
>    freed. (With only the destroy-side change, a writer racing the create
>    window instead dereferences an uninitialized data->nexthop_ht.)
> 
> This is reproducible by racing, in a loop, writes to
> /sys/kernel/debug/netdevsim/netdevsimN/fib/nexthop_bucket_activity
> against a teardown of the same netdevsim instance -- a devlink reload
> ("devlink dev reload netdevsim/netdevsimN"), destroying the network
> namespace it lives in, or "echo N > /sys/bus/netdevsim/del_device". It
> was found with syzkaller; a syzkaller reproducer is available. A
> standalone C reproducer does not trigger it reliably because the race
> needs the netns-teardown/reload path.
> 
> Fixes: c6385c0b67c5 ("netdevsim: Allow reporting activity on nexthop buckets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijing Yin <yzjaurora@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
