Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7C3CC7CD;
	Sun, 20 Sep 2026 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885193; cv=fail; b=r316uPAelhEozgMFjM24VcC12pN4wy6mm+26Z67C8xwY8A4z/BeWWG9FWe1qW0tFe4Yd3N0nAVRQ8jJ8/3kFIW993/8jA4aBIhMjzYt7TOe9elOgi6n14Ikim/mxUEZrEL4d02ElouIz/GA2gfb3ol7n3MEMlTb7PafiOXRdHRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885193; c=relaxed/simple;
	bh=Q84gCvcY4NWxnQeMbOZPidNYLQg0/dXdU92jpEn8qIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=slmdJCGCUzxKtLf5d0BoNJaSD2lsEdiu4CbjnbK1WUydEcGKHbFr/LBm1L5VP03WopJzsLixiV4BuTJ8Ze23sdBP/M7DnknmRt8hjt7lovXdHvkqmyUyNQCLeZWgWl0eeinBuAPBMXDwgW7IWiKHDafWxlFYn+z12j9C1niS8Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rik53mLr; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rik53mLr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAobbDmkelKAGKW0GtqcBLXjhWc5yGT9HN6fKfqZk0NVgOqkENkiFClcBOZOc4h/+1SQxAxR/8SdqfrXV9BTvZH8oub7LK96M1rR9J8Y9m/vBn+viwFtbWu9nGuWpXQzLWs2tiiCFe7ZeOj463wQvQ4jBBwNYlmFLamzoghw2ZQ4ZTzGmZlscTKqmjbyoeuglwA2Cst39t4ujxXAeIR5AR25CXvPOdTNQO+zOYzz+WN0EBEd8jwl0dFHlaiaomcjB4SJZVyhAqa/JDcO2sOjjElpzSccR1syHzQ94aTTKN3KjfEB91vZU2gBl9ntlMB3yqSG87jZhbf/sPAc6P0KrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0t8gQI+nihb0rGzGvIDUsD1AN0vldU0N6Iqo/BX0GY=;
 b=OpqcpFv2hrZa/nOVNHPKj9slYd6kWGvVj7p71qoA0Jmd+W4nMC2sjccPGLCnyHXEa0UTDXQxQ7oiHTTPJLanJ6fHOXqIx/nVFVhrB+fBwEPLV0IE4/uaatLlTf8lKQLBLvo3iW90TLenbWoCVD8u2n4wsYrj9x6wVwXaqUazrl/6ThZpQLTYEtGrdlJbhnuGrzSnnbhTlxqZI06h/ysdt8hmediMvOcDbzZggs6LPN/jaxjgfFkGL1e/74hu30bK+frNhhFQiimrNKkv5jripowGd1lUHLqbWVuFi+QESl+EFtFDlvuacs10xzntZVYSAjIVijEODP0kLCf2NiKxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0t8gQI+nihb0rGzGvIDUsD1AN0vldU0N6Iqo/BX0GY=;
 b=rik53mLrc8w3u9CuhUlgGNpXRQ+Vp+hCEGMGU4pxzvtZTqdueUk4dj/hT9PIuhgQZGG8E5SonWv33fEMe/LI9X2Pyf60an2y17t8nbNv6xeqRPX3MhAUsj4J/EFBuikXAKVCYK4vBhOwExVFQm+okZ8Hj94KzaFfljBKo8l2pKYRgQd5LbaeC6pr7kykvqjyj4OzKFebc7Mp/8A3JoHs/ye1gDhBfpIhxa+E1Bzk+l/zW3u2jtBfri9e4pbVL2yhhrjBwe6bmRuf/4FIzeyF72YH2JdWmOkDPHmw60sqLy3H/L+bMc2oCseVcvC54radSxcezZDWB7/rEqDLH6zbGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 06:19:48 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 06:19:48 +0000
Date: Sun, 20 Sep 2026 09:19:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] mlxsw: spectrum_flower: Fix port range register leak
Message-ID: <20260920061937.GA1766881@shredder>
References: <20260917113236.2149095-1-vulab@iscas.ac.cn>
 <87pkyawm2j.fsf@pmachata.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pkyawm2j.fsf@pmachata.org>
X-ClientProxiedBy: FR4P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: de09a8ea-df3c-4611-0e84-08df16df2bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|3023799007|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bJLQh0oFis+HwIjuabErIIxpddN42DP9fRfSPlxDHj/KrGnCNOjrWB7SR8ydEP1Tnlc9Y/fNOPkr0PU71dK5DokWO8P9DYKX/aWP8iUg1IW+u7G8zxUcJf6qKAa23JcAfxwly8MyrFrRdAGjog8dcW6VCDzngWC6INXQGGjHiTgmsuKbE6Uzr2RI96zkRLmHARvx9yCpTj6r515x2PbwN1jziJybLQZ25aJ3xl3rshiuemSbN9OMRMKicWMLHi6HsQ7+RVu71rQKYzYZuzIszHSkAPZVekj5tYVIXzcww8AO/GdweNL6ByfqvB31HjcXW0re1uXYc9JcPtMlZvAt4LtNTwwwKLsEdFWQ4tqu5C4tOcE2vjeBuiViu+HSjWOQa0JIw+LuzBKtEjO234Xr7ViJJegXI1BvBYIZByaNmCWQLSbYTHMOOo34cePHzePFc2FS3eYIvMftITU7gDFsf2Zpl1XSERxZYCNZ7YpPwXujVu4JeAf3GubMGaLUjgbpt5vplRIXN9SWHiU83IWY0ll8B0QTFoR1oBpugyOWHRA9BJ20k/zYL0jSCXFJkcCH58N2yJCu11EW+F1p62I6pJHAjFB5b1yntFNWQw9sBnEByavYo257a3ZpX2kdX5ieKd4vxlqpMyfZI1CyUtelQkg/kMtOhgweVmwi6pi9bP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zU/heLijBPFFg3OhnKr99QTRfOxydXk+8hcGSfulWj0IV73BnOtbdqCeGwKu?=
 =?us-ascii?Q?iVo7LAXPUGpHr7NqTsmKQtbFerH9e6aI5RFkFDhhWQG/+WDjids4cYibfOxE?=
 =?us-ascii?Q?ieIenyVkX/8MsMnC8TJZoJpkkSt5gdpAIix4apgMSXZpjUMxm3Z6nX5aXfv7?=
 =?us-ascii?Q?YdL/xMImPoKOFvspRkaczyCQlrmL91Zyw72DCwIG8/Vf6yH3aA5IYYCYy31I?=
 =?us-ascii?Q?UGPZXMTFjuspLiq8aiVaoNBlqC3ZxdYXUTFqKgHKjrvKoFm9xaBvUHDKIDkr?=
 =?us-ascii?Q?QFxKeMF8CGbLuN8E3zcHN+0Kx2UQ3hVEiVt63uhh0hlgNwtLWH8/BixQLlqo?=
 =?us-ascii?Q?4/M/EuiPvAYLBEtc/PzxCDowGNKbJq04hrRQLMPtJsAdvICwA8071r94KV2s?=
 =?us-ascii?Q?keyrfz66aYDIXVeLUQEpHSIuQ/H7lUS6R9xAE98aGreTA/A4gZbVoftt8Upg?=
 =?us-ascii?Q?mAEoh07lgjuRipsIjJUqe/cLu56zxsyrr2xmCNeI2uqx0EN1Gy/NaYYpka11?=
 =?us-ascii?Q?/BQocWxLOuXW7fl1B+Hwx8m+h8tSKPuWFZcdkhPYZ2NOSq3puUitCJl5TNyh?=
 =?us-ascii?Q?9L1LAcEv3iyxJtHjMbvtrR4+arPl9TaEHazBYViGWzgiJ/SMxJ05HgYtXgBa?=
 =?us-ascii?Q?8UAT7udm+lSQYMsOjmfLS5O1K6G5gp3ccZCVLoTC+xtAXOO/op9oJ+0DUQ7G?=
 =?us-ascii?Q?KLUBfZGRS0+ESyXGRjR8HrGvL08+KkqTFyH5sqgiz8d9QqU34Ja44FqtKtOn?=
 =?us-ascii?Q?G7tRpO4flKUVG9pn48L6ynWy0Ns2l83mmVtYaboCEeJGEttJMsxY8bmO+nS4?=
 =?us-ascii?Q?DJcmPyqy4tiRKAoJRnh0C3MbMMX7Ml11jOEHTSGmy+WIOy5KPb8+xQlCdMIk?=
 =?us-ascii?Q?P05Hq84i1SJu4g5az9UpoJeysxn7SGlx2xCXzpu+eRktuIwNsRxQooIJMR5z?=
 =?us-ascii?Q?R0uLTZl9/Yv8kKb7PVW2faQHpVRWSsn9UjZw+clkxzpgPazfro4ilGAFS8m4?=
 =?us-ascii?Q?q228KWurGiWBntNCcI6JpCqqiLk9SP6pNgAKDg6LXBzO/aCbtAUeIAWy5Gd9?=
 =?us-ascii?Q?xEe0fxysT2yecQmO0PUQUWTTMxqGVIDvgLnkycA9JdkrRcqRD2LRBMYY8L08?=
 =?us-ascii?Q?1xQMdNewlniqGZrz0Iy30be84oamEaKB0hvum3pfUvSbwm/uqSU/ty6ktfD9?=
 =?us-ascii?Q?TA69SYi7GnEDl03RJMNfrYzKposhzYbGEvlZdd0Lmn+WMj2EcN9WxPNLnN1A?=
 =?us-ascii?Q?xWOlw4Jve60HsTQimm7DoyjcxYNbjltXv9TYC/L5iahKcmCdLWMTKP3aFV18?=
 =?us-ascii?Q?VTLENLWcVXzAYJtkUJa5r6Hn+fB7lUUSO2gCdGJthec0I16xmKoLvT87qVzL?=
 =?us-ascii?Q?m8Kk4h1OrCAGi0Lv8dWIYqQg9iHl7nOUzsdQRdxxo4ea8sljFrll+M0+4Ehj?=
 =?us-ascii?Q?CiXLINW268fh0SQcK2lBOXFYSGDzs2+6ES/d5CcLa7Vswq/u/rlnSf2KUdCO?=
 =?us-ascii?Q?P4NQa8iFzoIBPkk5Tz+fjMy4rpJJ0GU5FhSZSPvHoeYAVub3Q1gCsQILvASY?=
 =?us-ascii?Q?smPxu/48kC8wEb1OfndF2xkymhuMDzMzGThOXO/0VCzzCPmXCg59GuPmGUKl?=
 =?us-ascii?Q?vbKbmmUD62XfwrXjMI9fG7Yk4lgw6XPkqIf1yL4xfEmj8q9s/SnzLQOAPRMx?=
 =?us-ascii?Q?Xj8T/8jh263ghm/feS3pLFIbQBL7c8/XBXONhpbgv+kzPBIm2XP0ynel75wu?=
 =?us-ascii?Q?DbVwsNoOXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de09a8ea-df3c-4611-0e84-08df16df2bf9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 06:19:48.4309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFKsyJSnsIfw/4sx3LFL+Cu24Y8wdVYQw1p46VwDq04r6YdufFwxqsoXb2sQrybD7o3n1id5Vc7wQ6vRMzMHww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503

On Fri, Sep 18, 2026 at 06:39:32PM +0200, Petr Machata wrote:
> Wentao Liang <vulab@iscas.ac.cn> writes:
> 
> > mlxsw_sp_flower_parse_ports_range() acquires the source port range
> > register before the destination one.  If the destination lookup then
> > fails, the source register reference is left behind in a partially
> > filled rule info, and callers that pass a stack allocated rule info
> > never release it.  Release the source register before returning the
> > error so that the reference is not leaked.
> 
> I think this is fixing the wrong issue in fact.
> 
> This does fix something, namely the issue of trying to add a new tc
> chain filter with both src_port and dst_port ranges in a situation where
> only one resource is left. Before the fix, we end up with full resource
> allocation even as the offload fails, because the register for the
> src_port range is not released. After the fix, the src_port register is
> correctly released.
> 
> But look:
> 
> # tc qdisc add dev swp1 ingress
> # tc chain add dev swp1 ingress chain 90 protocol ip flower ip_proto udp src_port 100-9000 dst_port 200-9000
> # devlink -j resource show pci/0000:06:00.0  | jq '.resources.[][] | select(.name == "port_range_registers") | .occ'
> 2
> # tc chain del dev swp1 ingress chain 90
> # devlink -j resource show pci/0000:06:00.0  | jq '.resources.[][] | select(.name == "port_range_registers") | .occ'
> 2
> 
> So it's much more broken than just this cleanup path edge case.
> (Notably, 'tc filter' cleans up properly, it is really just 'tc
> template' that triggers it.)
> 
> I.e. let's not have this.
> 
> 
> I think this is the fix that we need, and it fixes the cleanup path
> issue as well.
> 
> modified   drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> @@ -862,14 +862,24 @@ int mlxsw_sp_flower_tmplt_create(struct mlxsw_sp *mlxsw_sp,
>  	memset(&rulei, 0, sizeof(rulei));
>  	err = mlxsw_sp_flower_parse(mlxsw_sp, block, &rulei, f);
>  	if (err)
> -		return err;
> +		goto out;
> +
>  	ruleset = mlxsw_sp_acl_ruleset_get(mlxsw_sp, block,
>  					   f->common.chain_index,
>  					   MLXSW_SP_ACL_PROFILE_FLOWER,
>  					   &rulei.values.elusage);
>  
>  	/* keep the reference to the ruleset */
> -	return PTR_ERR_OR_ZERO(ruleset);
> +	err = PTR_ERR_OR_ZERO(ruleset);
> +
> +out:
> +	if (rulei.src_port_range_reg_valid)
> +		mlxsw_sp_port_range_reg_put(mlxsw_sp,
> +					    rulei.src_port_range_reg_index);
> +	if (rulei.dst_port_range_reg_valid)
> +		mlxsw_sp_port_range_reg_put(mlxsw_sp,
> +					    rulei.dst_port_range_reg_index);
> +	return err;
>  }
>  
>  void mlxsw_sp_flower_tmplt_destroy(struct mlxsw_sp *mlxsw_sp,
> 
> The template parser just needs to figure out which keys are used (the
> rulei.values.elusage), it doesn't need to allocate any registers, but it
> neglects to make the appropriate cleanups.
> 
> I'll test the above fix some more and send it sometime next week.

The above diff still makes it likely that we will miss similar cleanup in the
future. It's better if both cleanup paths call the same function. Something
like:

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index b03ff9e044f9..48c199bb9e25 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -989,6 +989,8 @@ void mlxsw_sp_acl_ruleset_prio_get(struct mlxsw_sp_acl_ruleset *ruleset,
 struct mlxsw_sp_acl_rule_info *
 mlxsw_sp_acl_rulei_create(struct mlxsw_sp_acl *acl,
 			  struct mlxsw_afa_block *afa_block);
+void mlxsw_sp_acl_rulei_fini(struct mlxsw_sp *mlxsw_sp,
+			     struct mlxsw_sp_acl_rule_info *rulei);
 void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
 				struct mlxsw_sp_acl_rule_info *rulei);
 int mlxsw_sp_acl_rulei_commit(struct mlxsw_sp_acl_rule_info *rulei);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
index cb232accb296..af287b18deee 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -340,8 +340,8 @@ mlxsw_sp_acl_rulei_create(struct mlxsw_sp_acl *acl,
 	return ERR_PTR(err);
 }
 
-void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
-				struct mlxsw_sp_acl_rule_info *rulei)
+void mlxsw_sp_acl_rulei_fini(struct mlxsw_sp *mlxsw_sp,
+			     struct mlxsw_sp_acl_rule_info *rulei)
 {
 	if (rulei->action_created)
 		mlxsw_afa_block_destroy(rulei->act_block);
@@ -351,6 +351,12 @@ void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
 	if (rulei->dst_port_range_reg_valid)
 		mlxsw_sp_port_range_reg_put(mlxsw_sp,
 					    rulei->dst_port_range_reg_index);
+}
+
+void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
+				struct mlxsw_sp_acl_rule_info *rulei)
+{
+	mlxsw_sp_acl_rulei_fini(mlxsw_sp, rulei);
 	kfree(rulei);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 353fd9ca89a6..3532c4bc7e56 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -862,14 +862,17 @@ int mlxsw_sp_flower_tmplt_create(struct mlxsw_sp *mlxsw_sp,
 	memset(&rulei, 0, sizeof(rulei));
 	err = mlxsw_sp_flower_parse(mlxsw_sp, block, &rulei, f);
 	if (err)
-		return err;
+		goto out;
 	ruleset = mlxsw_sp_acl_ruleset_get(mlxsw_sp, block,
 					   f->common.chain_index,
 					   MLXSW_SP_ACL_PROFILE_FLOWER,
 					   &rulei.values.elusage);
+	err = PTR_ERR_OR_ZERO(ruleset);
 
 	/* keep the reference to the ruleset */
-	return PTR_ERR_OR_ZERO(ruleset);
+out:
+	mlxsw_sp_acl_rulei_fini(mlxsw_sp, &rulei);
+	return err;
 }
 
 void mlxsw_sp_flower_tmplt_destroy(struct mlxsw_sp *mlxsw_sp,

