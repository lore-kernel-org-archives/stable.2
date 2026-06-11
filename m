Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012000.outbound.protection.outlook.com [40.107.200.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C718AE2;
	Thu, 11 Jun 2026 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158645; cv=fail; b=Ftt0Gwmzl1nlL9rPa8LBWVGuQF6rJXuHJk2ULoy+KL8XGLoLM/sJ1TPzXdrUQj/rDoIENlm+9aP3ZHuyjh4tX3PbYQf3FP8gNS3XSglIlk7WRs7s7Z0RlaRDJ3AqbizfCrhHuyypReyP5wBicwpNLh38Q3AHqpW7tcpmehbnbwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158645; c=relaxed/simple;
	bh=lkfR27Z5OModmUIQS4oh1kZ0xt7a9hkUF4U0hBEWSkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aK8/kDhufaTEptXXgYb5V28CGAPdoNtWDRHgqT9Gf/Nuob1DvZnQyX+Y1aOfHSEgMoXhOZq2o+Tz6Nr3VC1p2BSWcpWOP4SaYi8j1cphfI8H/1O5E3yvfMdIDsQqDEuodlq++1sztdw6MMWId3H3QQ442YjEcf+8YVeNkZmLh0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OGAukuFv; arc=fail smtp.client-ip=40.107.200.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OGAukuFv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geqgbIChXvU87y++28V6gqU5qJjpPi8HMGaxA0crxNi2H+tVAeTdxfO3bw6WIyX0qnuV72E3gkNwnuZNTCsHI4f6HpGB2S3B7Er4WqeWiLhL+c/d8LEN2daM3ROnHNJgJT1Fbqmo4Ubh+oYvvNnklOkJVJGJgEbMb/tSs6T1lnSlQByH6ZueWjT9qheuSyIK62EiREf6CTyvMgtE2s+uOxEr4AaPiSvvk6+z6r5jeViid1pbsOqcRZTGJ/JeLVqkGnzzLATITOFqvCyw/xn4XBw/dEigRewZRAQC5PIfmvICV07/9UDRa2T3T2ofCAEJL4GrARAy2WTHw7EfjTBo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah46KO0dxjX3sMsjI6NdQn52GBo4yzPjU176tuYaamo=;
 b=eoE/Lbkq7KonhMjyGf3Xfgnw9NDhnQgJL27FR9Ckuf/n2GbXQu5bo6Zx7Ae06Sh/ED4cJqR/l8sGlfFaa522wWQsjh72Dtp9cWmOEWRtRa5CfZVhmXwLO9+nNXUGV9WJ+t/YG12CoCW5i614czSq8ZNQRrVmwrmWMqW4sQ/wkA0p9bLubuLkNyQGn81h0eNW+TEhMt1aq0lE4fyE3Oth4NQM7kLWkipqr6yJCzD/o59N5BHlnk472Q86DbV4nIxkCZjdOvRRX2z36rew7eD/k7fVwrcoZc+MNugPa1e9GnRe4u2ETGc5fZAeePAozGTr0ejPty3E6gCf4PSS1O2yYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah46KO0dxjX3sMsjI6NdQn52GBo4yzPjU176tuYaamo=;
 b=OGAukuFvw4DtdWaWZIyxc+ymr3B+szGZLOA2N6O6lT2VSUaAQQJvm554MMKqIGJ5ea4h10ISX96c5iei8iO+XpMMhOejKAMDv3/PW6VmmnmbD6iuWlRJBgpgR8Ms2iMGaIt8aFho1TTNbuvPv/Ji1ZMenVMVQnTLYWnCifhAaljtFZ2OpM82kqXbEsNFptj3Bld9VPjtK21riFT74LHkTIuJCYiofzJK/6pfIlYF6z3vItsDjSNqATJ5/Gn2ZaKRg9gTjgK2IQHPX29fWRzJIm3kMu0sfyTBRaRKWrbtwAEbm4z3Or+LoLqtGjzVz6Va0aYRbR1FmK47UzfW8P/VQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 06:17:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 06:17:18 +0000
Date: Thu, 11 Jun 2026 09:17:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: petrm@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()
Message-ID: <20260611061708.GA836457@shredder>
References: <20260609083709.209743-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609083709.209743-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: FR4P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8c9ad5-de1f-497d-c608-08dec78116f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	m5rV4OkuJPemm7x0x91+7QwLzae6ZXWTdSVEkUnjXz1ajbGVC+hq/W41k5lMKKMzmxzCrw4rQaz3jVF+PX0DOadoDnY86gG0IE6/5FqR7KjV4lP5pHWfJwjNfUHYhoDXoZQEqF0zoxYKnYplxL4lEMVezTk+oF72iBSEEHTJFOZKupL1p1banB1sdXdigxDaQ4+jhp+xOfWS6ks10Bh06Cohpl7C+YkJbf2B+hq6GtghewYj2maRHdaolkuIabwKULgOpp2XpHQAmVvFtvY2FWjk73vsbZgSC1+B2G3uLjD9HUveM/olUIaxUOGG9Q9FFnln7kgUY7TTu+sStWw95QK9CYXBKxkSqyWW1PmkIYmHAMyyG4rxmR/G58HDZFjSpsFtcBaA88n6w5cbnfRGFcFxBIB/H+KDYGCJgTWI9uwkXJRjp3dVA6DD1171OtM71usLQo7rx88Zhx6h7toGwimyIBpIkB2oYxO6YiBcjZNu/jS+ubj4baXnyN2W3GMd/eCdeunfaTQeNE7QPiLZRV7YMPclrTn8Z5+j5oZa+dKGWIEJpcCjZItEL7khzpfu5eloKSUpsPhMW2RN2UbGCDMNIviFKTknK+mSU3A/HHHS+UGoDrWFikdbqVUa/N1IVDTYiE4YulZgvO1CFvX/osgxOdtmBbAha+cPnk+S8y88ZKGTqB8jCz6trK+PAcrYaLMygHIbq5KMVco7UtchUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yRA4afP5TXEbYR1Zfvej+ViCG0gfqq5MPAHhrzVZ1Uuuz6d8Gi6Af2/si1E3?=
 =?us-ascii?Q?sJhqGg+E7ghn9IkKXcOwNCaA3zQ6vRo8hd5T6IzgTrHdiXhqHlGdIXvBeMLr?=
 =?us-ascii?Q?iS1NFGsTmr1LKsBx13dBb4rlUHyWJ7xDe0xmXSMk5zT4uItqvQ2eJbJTFNHP?=
 =?us-ascii?Q?8R2RHFkRy2sJps4GG5bwoC/qZn1dJY3w4IouIMfkRmsFQMjonkOZNNHiAnVF?=
 =?us-ascii?Q?p6qXYiivyo+l7k0LcK84IUCwVivVQOqOJ5xTV8Jwk+jSMZNwmWsD4LZJ1s2W?=
 =?us-ascii?Q?tZOKr9PPt8tHK5av5uh9c8vChJ+6L3IJNIqAN23VFPdNfKg1xaNKGVYDukI6?=
 =?us-ascii?Q?4qGEDxe/rHjiXDFBNBItrwhPPxrqY08e9UP3/cJU3v9Zz7VUsFfrUaqDtd85?=
 =?us-ascii?Q?uJ3t39rhejwrH53oWUOzDvoJZY17ceMLx/GNSMRdf1/gf/o1YrHJfU3h2hlM?=
 =?us-ascii?Q?YuLdqbLxQk4Ii0bOIV/Ia1yH00HS7UsexgsODISaha3HZrbFtUrOigvkJUFA?=
 =?us-ascii?Q?1sY/PLj91iBwbbA2DIpt3lLe1epxyhQJe+msBUys5N/Yw8iWHBOzjM2S71AI?=
 =?us-ascii?Q?+ygWn+oaMAHxxl07iGBmjsfBjjUddwc6RkFeMl8IMD4k0H+oRbVKLxDhmnQ6?=
 =?us-ascii?Q?2M0SJuM+DhheWHFcCQBIU1QXnO+65T1/hmMT+VxQuqDJN0aPJj2kQ6kqAjWz?=
 =?us-ascii?Q?VWpev1/Lew/DbBOGQp7/vh7LH687OUZpqNS/EisMX1lPNmhkZrc8ekcaEvzn?=
 =?us-ascii?Q?v0vSZFrd4zjYk1zEX33zCELR18FeR3GVB+g1O0BKFB5XC8SUHyPZOJcWqkmt?=
 =?us-ascii?Q?YrmHlgsy9FmO9OSwpzXUwiUbpzqrmML41uMN4apksGeP+Mcw/yK7HqQQoNo+?=
 =?us-ascii?Q?5AuMzCBnBvSj16Bsj8QtR1GtYwWKhxdFU9dpvsINBGleTmBAW0lEUqLIBUKK?=
 =?us-ascii?Q?EdRihkJTYTaNWfpqe9c9eB1oz8qgJa1ftTJ3Ytrt3X0MkrjTauJXIxe8+t5+?=
 =?us-ascii?Q?7dDp4S7laqPu6Cz+4K/SW1nH0LWjgPaBRmMnZIQ4XO//WcFT5j2Elq0J5t/Q?=
 =?us-ascii?Q?BRzG6IDu4hLuZcT1PYiawpOwiNVnJ9V6kcFFGDYyUWXnLya092bCM5MSkmxk?=
 =?us-ascii?Q?yhGRCF9HYGBAujJqLVtWTpiU5SDL+NP5cZT2mXGeb+EW4xxZDndl8YUin45K?=
 =?us-ascii?Q?JP3hAvOe85THZUS/Kycy7/5OCcTaQHO2M5Cs4otEnwW5y2cBxZfkUYRTjHiX?=
 =?us-ascii?Q?8TDUKgBhzPSDTE9oFoBJpRSyZb2cdXWalCdg0uin8jcLItN7jRLe7fPy7lW0?=
 =?us-ascii?Q?7y+usQN3QpF50iJT2+Jf88zKWUHaGdB1gmdEAkpQmDTaUXpdCgj3kocF5kU7?=
 =?us-ascii?Q?gvykIBh9+3K9hjDwXgmXjHddqBPEQfNYv8eMoMKLCrPfX0IxPOzpA1S2nX9W?=
 =?us-ascii?Q?w3iktLtYie146nmi+HhMX6UQ+OcG1o3h3w7eP5Nl33T60DxQN1/gI/lqRftf?=
 =?us-ascii?Q?r/gx/zEmtncXc5TaNNl7ukOS3L4MN5Y8XLlqZ4Gg888OS3LdV+LVKQas5ERS?=
 =?us-ascii?Q?/4ICoAV0FiU52yrbM3b4j60QimzJ7JzMbjg/nMfQdN/59oS3UrbkRvr3pJ6o?=
 =?us-ascii?Q?adbA85CLHQZv4Hh1ev3FXgcudbs2GvTkzt2Scc9D1mql1s2hDhr71/RvMWVW?=
 =?us-ascii?Q?t7XQYOY3ufiuBxaoWMAPrga7V9pyXIaJjJi8Dj5LcQf6OlvC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8c9ad5-de1f-497d-c608-08dec78116f3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:17:18.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkVsGHtHBAo3tlbHc3f5/u7kTBiOKK3bbGD4QEaH+vLR7VI71IEONXP73ra+AytebG+BVTEfFcMmXRLeZfqQyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052

Subject prefix should be "[PATCH net]". See:

https://docs.kernel.org/process/maintainer-netdev.html

On Tue, Jun 09, 2026 at 08:37:09AM +0000, Wentao Liang wrote:
> When mlxsw_sp_port_lag_index_get() fails, mlxsw_sp_port_lag_join()
> returns an error without releasing the lag reference obtained by
> the earlier mlxsw_sp_lag_get().  All other error paths in the
> function jump to the cleanup label that ends with
> mlxsw_sp_lag_put(), so this is a single missed release.
> 
> Fix the leak by replacing the bare 'return err' with a goto to the
> existing error cleanup label, which will drop the reference safely.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0d65fc13042f ("mlxsw: spectrum: Implement LAG port join/leave")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

For net:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> index 3a65420fa1ad..fed708c17332 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> @@ -4360,7 +4360,7 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
>  	lag_id = lag->lag_id;
>  	err = mlxsw_sp_port_lag_index_get(mlxsw_sp, lag_id, &port_index);
>  	if (err)
> -		return err;
> +		goto err_lag_uppers_bridge_join;

Convention in this code is to create a separate label, but it's not
worth another version

>  
>  	err = mlxsw_sp_lag_uppers_bridge_join(mlxsw_sp_port, lag_dev,
>  					      extack);
> -- 
> 2.34.1
> 
