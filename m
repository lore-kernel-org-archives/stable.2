Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B65850EBE6;
	Fri, 18 Sep 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749615; cv=fail; b=MoGU/AUcakR+7oGm5P3esGNxuEkxXweYdgNk2rj7DDefMy/fzdzqP5HTygGZ0RLRCIWuK+epVjxVd1kiFJJzE6w6kQ/O0j7070yuUrqAstw6fOqKHsXr6W7vLyYYCOgLgGSUauRVIKOcQPAq1rpod1yMf1TpmRnY/1W5FtAe4CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749615; c=relaxed/simple;
	bh=s05+1eA7Jp/WCw3CLdye5o6GrNjvGaScisApD5nU6Ug=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMEaMJZrpKL2+WVxYdW1tDQSbINHwkOx6Kx48CFMgS9lkwxL01UWt9Dg0OG+qt9Lbeq8lJuvLtUsjx6icptTNms/iug8MDKYNAV4IGJIkSX9Ri7bhCQaR5UtnD4/P0sF5HFtGZS+/mpK0JwZ5xmE7dFSHLONPFI1CsEZMFE8vKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MJlJUtpc; arc=fail smtp.client-ip=40.93.196.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MJlJUtpc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X607xOM3P7fRZNfDBbLkEkgLpuEtsyi+wdXNu39yDkc6/GvDnjWhq46tw/0sE//pdSC1T//gB6IQp3+14zrDJLTMV6r3JgkvqoalgKvKtQdRYmR8rt3lPeLObyqsr6pfxUAKbE4v3AkYibqvt0T9i3kO7+g1yDQYxZtUDf6yKjQgext14N7x2biCfbjWORcK4b9qX/RiwkgeqPooewC7EQo/ZmQmqG2CLFj+G5Ti4QrGtJQJKj5XIFzzSfsXvrbO4lNwW03SeFec2HFNQqIcsnIxoJNNrIam6qnCJwbvfMPGpCrpf8fI7xIzuMn9vGhJGeSTRIyI7fe0ZFe8SLmueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNb9wH1onmBaewpoHesqOYaCFR72oQrV+R3Fbe4Unz0=;
 b=U0TyzMJvyC/PhD5xQfK0IWGZ0/3PhITM06E1mlG+BcHmH4jXK+2pw4EOwcYAgVKndhS+wGazmWFMRi8voEVTBKilaCujUhGbTQjH1TL1Wf6likLE3u6yubplcVWO3Z1tbsPCaHxNvzj7VyjNOr6UVNF5Yl9Zf6L10cIJm9kfy+dP7ncb0vKIYmzB7g9edjAISdyFyowOvBbsAHQofB4vBmxWyrbkL12MtOBMKxTDHyeHEebEJPdncDKNy/FavmXBB4ljuUqQr+nlvFtZKuECwYpN2Dq5z5pBh7rJs2pnPPf6cz3JZ27yXbHOk5uaxikpJAbQHymRG4Zmfchc9C9enQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNb9wH1onmBaewpoHesqOYaCFR72oQrV+R3Fbe4Unz0=;
 b=MJlJUtpcArlh4M5u17m5W3QgUXTBXoCqQeOjnn8QaYB5bvlMBuNxqP38w0iaxiMvQ4Egijo0sNKnbe7TgzH3tPBrzKf3wokxOapB6gJZmbUiJC3h9FDkaOVW0c8wGRqpuZ4cG4xgH1BT9d5Ni67vsFZHFHex94shHDDzuYZIPMTQYjfvMEn6jIJhZtZKv+SW/40gI2kdQsrQ7ojMnrMNNWbfQhwTgLvsO2+Q73uoyvkSRDVkB00oPzBRUkefekjUaQmwOGCh/yIlmS47KabPwDg/QQbZp48CYUy1QhjXxppQMDbaibVNqh/G8Uk2NgoI64uef4vdlfqfES64CF/afA==
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 16:40:09 +0000
Received: from BN3PEPF00022BC2.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::10) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Fri,
 18 Sep 2026 16:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BC2.mail.protection.outlook.com (10.167.248.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 16:40:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:39:43 -0700
Received: from tuxedo (10.126.230.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:39:37 -0700
From: Petr Machata <petrm@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<idosch@nvidia.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <petrm@nvidia.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] mlxsw: spectrum_flower: Fix port range register leak
In-Reply-To: <20260917113236.2149095-1-vulab@iscas.ac.cn> (Wentao Liang's
	message of "Thu, 17 Sep 2026 11:32:36 +0000")
References: <20260917113236.2149095-1-vulab@iscas.ac.cn>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Fri, 18 Sep 2026 18:39:32 +0200
Message-ID: <87pkyawm2j.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC2:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb786a0-3001-4066-10f0-08df15a380db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ql+bBZLzb4NYs6zFYqgu/ReFry1ch1cz1Ejlz0o1ocpbY16xG0n8jgSNOBRiIdwMFjASQnLJ8hyAriuUWjPMAGRX6jUtQAH0EzV5qBOBpMoQ77rgKBF8M1iRQXwz9xTRscRoCGrXwgOPFxervudske2WuA+xJFnuGjiFcMuxKA0x9w5CHhcojsZoQbuKJgyNPkZIryDQChcPOhXW15wf0NAElBaFjj/1mGBNYHZ8+p76shO2i08TZDHvQokx1XaXuHvCD8fO6BgvfQVyHCv0Yn3riIvNwxwH3ch3hoj5yeGRCl4q881P20z/qmJSs+/X0GDnWcG7FJvrKVqtaEffpmzEz2sDdnHHBX3M97f1+5ZxxEqYt2IRhtAqasds6OZqJRYKZWrj2k6sw9GZCWHiVGaIS4aTM7EsjRrCgBbPnBgAeGGJY6RVsV8IW66D8ScREKTQeKPHk/J+rEjcOS3ZdKS4szKzU6zwP39h6dZ9tzBrs7dvmFKHDeO2/LdQehW9TNftx4JlU9ikabVJpVl7n3c0XuZ8Vx30KaiE0lxqOcKhPN+3vajBlHI9FIwBQMVfckhIlQqYRBlQMRwLvr+6PPKkdqVYLg5vCUJ0LAObba6yxcigSHYnlMkLAj0UTJk8OtGyuVJXu7VIggJmy+oMJy3jgA28CBprMzARVhncuIte5sroYk0D6VM0LyILYPxLnJggmsbeodlseQx3oXKhag==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RSXn3EowF7uzkFd4ci6x+9ZbV0G3lxjjAcZvZEK1KjkH4VsicyM9gJ37+Wf2stJOsYkDU08qj3hCUS68pVINSyAWX3c+8MmZycH5ik+OrJDFXo5BT4xZP/v3+692ZPyb+ZTcY/c5EohdYduMUzk6ZR4LxZUYaJ1NPGP3+FBkoWwLhbcOi8rE8qJeO5TBBMdPmeKLRYYGpBhC9b4ssAEqJGma2a4wJXA3cdzxaXcefVvFHDyOHf1EsbQguiMQ+MVYegok+QogkPhSonNrDEfFv5XjuLD9UxTzVDdwM08J2nDuBw7/Ak7y6cqPo42DwBT87K+uj2Ho/7LoLodx1xKDUmzFkDuImZRuTipy5TAu9nyZAIoSudIdusv6dYpftFb74Xy3Rn6Ipo0ss6JeoZEo5MXXJdJCy9g6Y6sWMyIoL3qGn/aLhTXSjpUMJHyzpjLK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 16:40:09.3240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb786a0-3001-4066-10f0-08df15a380db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890

Wentao Liang <vulab@iscas.ac.cn> writes:

> mlxsw_sp_flower_parse_ports_range() acquires the source port range
> register before the destination one.  If the destination lookup then
> fails, the source register reference is left behind in a partially
> filled rule info, and callers that pass a stack allocated rule info
> never release it.  Release the source register before returning the
> error so that the reference is not leaked.

I think this is fixing the wrong issue in fact.

This does fix something, namely the issue of trying to add a new tc
chain filter with both src_port and dst_port ranges in a situation where
only one resource is left. Before the fix, we end up with full resource
allocation even as the offload fails, because the register for the
src_port range is not released. After the fix, the src_port register is
correctly released.

But look:

# tc qdisc add dev swp1 ingress
# tc chain add dev swp1 ingress chain 90 protocol ip flower ip_proto udp src_port 100-9000 dst_port 200-9000
# devlink -j resource show pci/0000:06:00.0  | jq '.resources.[][] | select(.name == "port_range_registers") | .occ'
2
# tc chain del dev swp1 ingress chain 90
# devlink -j resource show pci/0000:06:00.0  | jq '.resources.[][] | select(.name == "port_range_registers") | .occ'
2

So it's much more broken than just this cleanup path edge case.
(Notably, 'tc filter' cleans up properly, it is really just 'tc
template' that triggers it.)

I.e. let's not have this.


I think this is the fix that we need, and it fixes the cleanup path
issue as well.

modified   drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -862,14 +862,24 @@ int mlxsw_sp_flower_tmplt_create(struct mlxsw_sp *mlxsw_sp,
 	memset(&rulei, 0, sizeof(rulei));
 	err = mlxsw_sp_flower_parse(mlxsw_sp, block, &rulei, f);
 	if (err)
-		return err;
+		goto out;
+
 	ruleset = mlxsw_sp_acl_ruleset_get(mlxsw_sp, block,
 					   f->common.chain_index,
 					   MLXSW_SP_ACL_PROFILE_FLOWER,
 					   &rulei.values.elusage);
 
 	/* keep the reference to the ruleset */
-	return PTR_ERR_OR_ZERO(ruleset);
+	err = PTR_ERR_OR_ZERO(ruleset);
+
+out:
+	if (rulei.src_port_range_reg_valid)
+		mlxsw_sp_port_range_reg_put(mlxsw_sp,
+					    rulei.src_port_range_reg_index);
+	if (rulei.dst_port_range_reg_valid)
+		mlxsw_sp_port_range_reg_put(mlxsw_sp,
+					    rulei.dst_port_range_reg_index);
+	return err;
 }
 
 void mlxsw_sp_flower_tmplt_destroy(struct mlxsw_sp *mlxsw_sp,

The template parser just needs to figure out which keys are used (the
rulei.values.elusage), it doesn't need to allocate any registers, but it
neglects to make the appropriate cleanups.

I'll test the above fix some more and send it sometime next week.

> Fixes: fe22f7410527 ("mlxsw: spectrum_flower: Add ability to match on port ranges")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> index 353fd9ca89a6..4cad6c46b07e 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> @@ -486,8 +486,14 @@ mlxsw_sp_flower_parse_ports_range(struct mlxsw_sp *mlxsw_sp,
>  
>  		err = mlxsw_sp_port_range_reg_get(mlxsw_sp, &range,
>  						  f->common.extack, &prr_index);
> -		if (err)
> +		if (err) {
> +			if (rulei->src_port_range_reg_valid) {
> +				mlxsw_sp_port_range_reg_put(mlxsw_sp,
> +							    rulei->src_port_range_reg_index);
> +				rulei->src_port_range_reg_valid = false;
> +			}
>  			return err;
> +		}
>  
>  		rulei->dst_port_range_reg_index = prr_index;
>  		rulei->dst_port_range_reg_valid = true;
