Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B135C6BE;
	Mon, 21 Sep 2026 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977022; cv=fail; b=OV1NI9brcOQutz5O5hTXq/soTkxnh5lZ9UkiLfoWYTsvMItEcfhP4eIGFo+mio7S2CTu47nYBmJ4FhZqZZgjlW67e/QDsXJZlfpC3Dj6kYhHd3x3bmDbHUAyK7z0szVJuu0G+c08LQxijOlflgXAfBG8A4/B2Y86D9K6VdrDCPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977022; c=relaxed/simple;
	bh=g401RsDDGnYxZccx6mDYm8wUMZ2oTyXAC+sBWyNHTHI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XEHxx4zjd84SPbPcY/sjyy0CJmkuZdTZvCU5a4utSz9n/OWbatCOnybyunVAFCMh/l1xqS9GhQp0TDYQ2B6Lda3DmWc9a7wW0enszvq2WwOryQtVSkC8w++8Jx+CyerLXjVFcIqpuMHJ13B1KHAQvN5U75zplmHCBjxsxxQ21FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CVouVcO6; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CVouVcO6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8+FP8nDfRvACQeoD9xhhjEy0boUU7Y25f0dmb9YgjJXcnKLn7fkk945lOPGoGa2Np45ge4TjDK0V77W82/JX0zglLsFr3zrk56+cyCCQt5kTRrrcqoeXAXvDPUM0GCZJ1H7e3ovnJUB2irF36oe7hti1FfC6UQ0C84FO/8LWolrZO1Gsaa5GZUu6rYosWdaRDkr3I9eD84ofKQCc6bDClPPgbDLcVDaxy785hAkIBA6wkrT7HhaLtsnq9x2hh5cnTMbXeun+RE0Z9VUYOQwUMtRcRSueueIZSpM4O492yCrnRXqtfmoxfqNgy7SsAvssBqtDp++n5DNiy8D10YXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfDiUPFJEwk2jJg293Tn1GH6W+aCsvQa+BW0ABI9xl4=;
 b=pGaJU2COtUncM9GxHXbqgzLkX5C672ktZefeb5O1deODxVaFFWWV4SfJHqAU+N7E4KyuBK6LWd4y0VoH1Z2IspWrvoYp6T9iErIC5t8kLt3xOlnSm/TllCyEevC12pDQkVYYYmKTFKL3AtYJgDq2OeMs+IwKBt3Fquc0YtqbVbotS9wnGViQhvI1LzibGFhmJuQUmCsezMw76+3DTZPdRGx9JriocherIBjQyvDJcIuqG9Zk7F/Z13GvIUYyIcbDxW8Ibx+/BPCyb3PxD5c0ZkXtAviI5znAujH/rxL5oxsNqJPWV1BjbhfT3nzU/XGdYv/MleNNU3k52Ng3CahXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfDiUPFJEwk2jJg293Tn1GH6W+aCsvQa+BW0ABI9xl4=;
 b=CVouVcO6L7Bex3C4abh3p/rWmVoJ3nvWZrM3gVmnHVAX91ND6+2uiU4qZ/cKXYtBJshLqLRJhRJL0oIApvL0cd1RSEDF94UJiF37yN8udUWDhnYyKqB3KEF2Q8srgFfQBC97nx9f0GWr5SMVW3RugJystdLbQd6ZEEG7exxGs0NG6RioJgBdVXBNDIALpV6E+54Lb854mjvJqFsV0md9qUwh7TEmLNS06/HRx4tiYc5M28L3VE0e/cI8xza2bC4haTqqSQ/xgPCOl6DuKiFt+n3RhVqwiAxKC1+/psvA4DDfhgp6GIXc74vplAuPbCBJ5oYBNAVHmhVuFqUhFhudSA==
Received: from CH0P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::24)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:50:17 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::8b) by CH0P221CA0038.outlook.office365.com
 (2603:10b6:610:11d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Mon,
 21 Sep 2026 07:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:50:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 00:50:06 -0700
Received: from tuxedo (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 00:50:01 -0700
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, Wentao Liang <vulab@iscas.ac.cn>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] mlxsw: spectrum_flower: Fix port range register leak
In-Reply-To: <20260920061937.GA1766881@shredder> (Ido Schimmel's message of
	"Sun, 20 Sep 2026 09:19:37 +0300")
References: <20260917113236.2149095-1-vulab@iscas.ac.cn>
	<87pkyawm2j.fsf@pmachata.org> <20260920061937.GA1766881@shredder>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Mon, 21 Sep 2026 09:49:57 +0200
Message-ID: <87ecenvyai.fsf@pmachata.org>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: bb57eb58-9c5e-4bf4-7e7f-08df17b4fa5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WNvTiHAsNefjCZNgms7JJyueP4+tWLsgKR0ZdQFJCZffY9iGXoFeoIZQZYkmJoDrex2aAwTbJP+7+UUADl+ZDedC0xZftZkf4+2zKaV3cahUFBP46G1dsrdvihiMawMma0cyuZNDEmcDWX3wgrakTcmVQ2yq9BBLQXjgbpN5Z0Ha9h2Qgs2LafTWeOpkTo8xlC2umfPR2p3fjTCcguvXR+bpmLL+4mFbFjc3RblhrrqAYKOfi7oqC8yffXExlw80h1nzaItNh2BDyJVwDTGt3COFvt8nr0mM0OkDGgikCH8X0GkXnZAJMduS2jkCNWZpq2+LT76OEwDrHOG4Uol3CXRbsXEIEEgj+pR5kgVe64TSRwT5uQLXB7Y9cchFK3Pv5OFPi+r2n5G+phXvbtw8Ceh0DvPNAR/M6neh+ik4bTAsbVRYhSqLZ41m/MmEyI0O8WSFbh+1upE//3T0ItqBtVyd/fVFuFu8+lU/qtOZnPKEEK+dsEWC0FJ8+PLSxoi0xwnqxDlBuRUqKP5D2o21D8IsXkNOCumP9Uam36L8fproDS63pMCLxF21qmcnodohol/uKDqqt2QbseYuKdbTvU5tXKwzP5ZXWukXpRs3UohoVytxoPSS3SlhCi+uEZc9RHs51DDaNJH1O7lWzGU7jWrqINQ7mQJYm7UGcRwMH7r7TF25h5UlkTXMp9rTc6a9uErAxjzAZgyZAD6ncJ3jnQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O0WAYPXC9ltAHcmie3hcpeXv56ZSOo/3kTEPaV277vusl0sD9qpmK8a4xYxYJJr66FY4GU0CcotGSkD/TkSMCLExoC85eiR/PchtD4uLwB8PCs//t/e5UIsL5CNZWljY3rp89Dr/tx/kVbyKIn8VhR0T8KUz8Crc5k/cMNWMuTKuqRzAAVYbWNQ7cD+OqKDHtxig272+E6sOwgUv8Tjsvzt2kp/H0D7XUD6xXFGN48Q2JyZ2TKv1keRBfTTR5ZKRpo1YjdUQ1FrNFm+3g3kxlj8A/OdxyvabzWonlL6haagVnNw2EXuPtIrsRG5bfbrtnDJ7XjHRfoaFg/7/wH8Gxi/gX8KT627bOKjTPHn6+o7Um0j6VQDOVY1w8WK+/wfJXWWFpHryBrgnmhkDrgib9jtItVzG1IxLmijGTzhIPJwZ0TXlr/qOI9XZQCFBx7rm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:50:17.0233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb57eb58-9c5e-4bf4-7e7f-08df17b4fa5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533

Ido Schimmel <idosch@nvidia.com> writes:

> On Fri, Sep 18, 2026 at 06:39:32PM +0200, Petr Machata wrote:
>> Wentao Liang <vulab@iscas.ac.cn> writes:
>> 
>> > mlxsw_sp_flower_parse_ports_range() acquires the source port range
>> > register before the destination one.  If the destination lookup then
>> > fails, the source register reference is left behind in a partially
>> > filled rule info, and callers that pass a stack allocated rule info
>> > never release it.  Release the source register before returning the
>> > error so that the reference is not leaked.
>> 
>> I think this is fixing the wrong issue in fact.
>> 
>> This does fix something, namely the issue of trying to add a new tc
>> chain filter with both src_port and dst_port ranges in a situation where
>> only one resource is left. Before the fix, we end up with full resource
>> allocation even as the offload fails, because the register for the
>> src_port range is not released. After the fix, the src_port register is
>> correctly released.
>> 
>> But look:
>> 
>> # tc qdisc add dev swp1 ingress
>> # tc chain add dev swp1 ingress chain 90 protocol ip flower ip_proto udp src_port 100-9000 dst_port 200-9000
>> # devlink -j resource show pci/0000:06:00.0  | jq '.resources.[][] | select(.name == "port_range_registers") | .occ'
>> 2
>> # tc chain del dev swp1 ingress chain 90
>> # devlink -j resource show pci/0000:06:00.0  | jq '.resources.[][] | select(.name == "port_range_registers") | .occ'
>> 2
>> 
>> So it's much more broken than just this cleanup path edge case.
>> (Notably, 'tc filter' cleans up properly, it is really just 'tc
>> template' that triggers it.)
>> 
>> I.e. let's not have this.
>> 
>> 
>> I think this is the fix that we need, and it fixes the cleanup path
>> issue as well.
>> 
>> modified   drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
>> @@ -862,14 +862,24 @@ int mlxsw_sp_flower_tmplt_create(struct mlxsw_sp *mlxsw_sp,
>>  	memset(&rulei, 0, sizeof(rulei));
>>  	err = mlxsw_sp_flower_parse(mlxsw_sp, block, &rulei, f);
>>  	if (err)
>> -		return err;
>> +		goto out;
>> +
>>  	ruleset = mlxsw_sp_acl_ruleset_get(mlxsw_sp, block,
>>  					   f->common.chain_index,
>>  					   MLXSW_SP_ACL_PROFILE_FLOWER,
>>  					   &rulei.values.elusage);
>>  
>>  	/* keep the reference to the ruleset */
>> -	return PTR_ERR_OR_ZERO(ruleset);
>> +	err = PTR_ERR_OR_ZERO(ruleset);
>> +
>> +out:
>> +	if (rulei.src_port_range_reg_valid)
>> +		mlxsw_sp_port_range_reg_put(mlxsw_sp,
>> +					    rulei.src_port_range_reg_index);
>> +	if (rulei.dst_port_range_reg_valid)
>> +		mlxsw_sp_port_range_reg_put(mlxsw_sp,
>> +					    rulei.dst_port_range_reg_index);
>> +	return err;
>>  }
>>  
>>  void mlxsw_sp_flower_tmplt_destroy(struct mlxsw_sp *mlxsw_sp,
>> 
>> The template parser just needs to figure out which keys are used (the
>> rulei.values.elusage), it doesn't need to allocate any registers, but it
>> neglects to make the appropriate cleanups.
>> 
>> I'll test the above fix some more and send it sometime next week.
>
> The above diff still makes it likely that we will miss similar cleanup in the
> future. It's better if both cleanup paths call the same function. Something
> like:

The fix I posted follows the current `tc filter` cleanup approach in
that the cleanup is outsourced to the caller. What you posted is
obviously cleaner and not as messy of a patch as I was afraid, what with
the new function, so I'll go with it.

>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
> index b03ff9e044f9..48c199bb9e25 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
> @@ -989,6 +989,8 @@ void mlxsw_sp_acl_ruleset_prio_get(struct mlxsw_sp_acl_ruleset *ruleset,
>  struct mlxsw_sp_acl_rule_info *
>  mlxsw_sp_acl_rulei_create(struct mlxsw_sp_acl *acl,
>  			  struct mlxsw_afa_block *afa_block);
> +void mlxsw_sp_acl_rulei_fini(struct mlxsw_sp *mlxsw_sp,
> +			     struct mlxsw_sp_acl_rule_info *rulei);
>  void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
>  				struct mlxsw_sp_acl_rule_info *rulei);
>  int mlxsw_sp_acl_rulei_commit(struct mlxsw_sp_acl_rule_info *rulei);
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
> index cb232accb296..af287b18deee 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
> @@ -340,8 +340,8 @@ mlxsw_sp_acl_rulei_create(struct mlxsw_sp_acl *acl,
>  	return ERR_PTR(err);
>  }
>  
> -void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
> -				struct mlxsw_sp_acl_rule_info *rulei)
> +void mlxsw_sp_acl_rulei_fini(struct mlxsw_sp *mlxsw_sp,
> +			     struct mlxsw_sp_acl_rule_info *rulei)
>  {
>  	if (rulei->action_created)
>  		mlxsw_afa_block_destroy(rulei->act_block);
> @@ -351,6 +351,12 @@ void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
>  	if (rulei->dst_port_range_reg_valid)
>  		mlxsw_sp_port_range_reg_put(mlxsw_sp,
>  					    rulei->dst_port_range_reg_index);
> +}
> +
> +void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
> +				struct mlxsw_sp_acl_rule_info *rulei)
> +{
> +	mlxsw_sp_acl_rulei_fini(mlxsw_sp, rulei);
>  	kfree(rulei);
>  }
>  
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> index 353fd9ca89a6..3532c4bc7e56 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> @@ -862,14 +862,17 @@ int mlxsw_sp_flower_tmplt_create(struct mlxsw_sp *mlxsw_sp,
>  	memset(&rulei, 0, sizeof(rulei));
>  	err = mlxsw_sp_flower_parse(mlxsw_sp, block, &rulei, f);
>  	if (err)
> -		return err;
> +		goto out;
>  	ruleset = mlxsw_sp_acl_ruleset_get(mlxsw_sp, block,
>  					   f->common.chain_index,
>  					   MLXSW_SP_ACL_PROFILE_FLOWER,
>  					   &rulei.values.elusage);
> +	err = PTR_ERR_OR_ZERO(ruleset);
>  
>  	/* keep the reference to the ruleset */
> -	return PTR_ERR_OR_ZERO(ruleset);
> +out:
> +	mlxsw_sp_acl_rulei_fini(mlxsw_sp, &rulei);
> +	return err;
>  }
>  
>  void mlxsw_sp_flower_tmplt_destroy(struct mlxsw_sp *mlxsw_sp,
