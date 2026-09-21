Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694545D921;
	Mon, 21 Sep 2026 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981869; cv=fail; b=hJOyf24j25TDzoEyJpbkHnxW6bRwE6rAvfHW3J0YPNE5rng6YfguAmUB2UAYXyFPAaIpWfRGcZeTDWm2GEb9kHPVRceTuhuDxAVRs0DHzrXjziNx+lRWkCAkbo2iJt8zFYXrHawh1NqY4kIJ5C18Lgc7sAhd+qZGJOAm39gvlt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981869; c=relaxed/simple;
	bh=pj5rpSIfGyxDj4/KfNumzVrCh3csApT78RdlPBD43bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aCS4j74DzzX687M9HSiv5H3kfu0J+VcHJVoxkMLgiVg88w/igK+dLSRPVzAYYBON7JW3DVqQvt1gScViEpydqkc9VEAmkvLbq1AWU9s97lKWAky7kd5+ysChDYB40ZJMVMdlx31TSRnUju77SZAVYM5ly9pcaVocW9PC5dwv6Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HF+VfObP; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HF+VfObP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dve0/2CIowFCTX36RM9ZIJqUkE7NFPWakXNsjPLD3HrduOMSRErj70zUqiM/PuX3mVKgvI+gUdwEVu8RXgLKlNfaLK5TVMuekjF5J7AFHhHeXdE3pc9F/h++6bBrdZqiRTm7htXbeIvHVQBqNvRrj6sxDR9UieB8ZJnQERknAB6lGhp+1WAvKBFt5z0TsfarwxVOkm42XBav1VUELOtN2XhEr+z90u8jr0VbMYjGkc2TvTCKNvOhThnWQBxmdjZyfFYlWeN3MdCSkQwd+Ng40/Gd9V7i2l7vdD+W1eL+7vlKzSkPvcsbQZJWKfQ9oYAYm4nVjNp/589VHrCYb7BIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP5JQjvcuf2hP/BVAX/JQ0vVNIxT/i0/1orSGILjqPQ=;
 b=IqhnMatuxAlQ8rgChKTGm7dPV12+QeTp2VLHciiDzN6L6zFQM4a6LPH5bZwvtfNB5W4oebyE0xZ3RTCEttE21+L5Xvq2BSVcoJL0LwUh1DCGW2322gqUNlNdUpB52HpLF/IZDqXCrss9GQMjASgWI911VJADEynLHq/96/EpDLJcW9vfWanK5W9sjchLnwUezQrv60BTA/C689XZ2ronew7/gj/NrtLNfvOXiHiJgJwwZYM716A2bFD3sAFD94OzXNHwbV+blEnetixYti146Jhy8d7DAKB3XVEPGSqqwzrJlFG+R0cM/IqrEcUi1LmZYE73wzj2Cu4Nlrn8D8jbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP5JQjvcuf2hP/BVAX/JQ0vVNIxT/i0/1orSGILjqPQ=;
 b=HF+VfObPm3VdoFUXDppz7UGaLC1/KQJN1pehiDoaGTwD4+rYfvaZVFJw5JR7IapV/KrLv3dk4zwdKQhCeZbRnjNpuroWTE8BtS8gtrCk5tbtwfTJyuzRca3Ql7oXqfliDO5WTDI+l9I4DQl5ZosyazydmgHHF7pSJxPCHAdXjD5maOtR4gw6jhuyv8tHwAuoHX0ve0+YoUrTPTMbr36uA1w9VW9LPNVWa0KKhpyo0L6u5CbjNKpDLGkPKNX6qrRYho8Zi+plYDNM2eO74DK8Uhcd8D4e5FaN5vYahdezGUV6pwJ+skWerr2rIvLoyYTCC9QcQ9BfYLjmLZmFkYLlZw==
Received: from DUZPR01CA0220.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::8) by DU0PR10MB7167.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:44d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:11:03 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::4) by DUZPR01CA0220.outlook.office365.com
 (2603:10a6:10:4b4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 09:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 09:11:02 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 21 Sep
 2026 11:16:50 +0200
Received: from [10.130.78.67] (10.130.78.67) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 21 Sep
 2026 11:11:01 +0200
Message-ID: <8084b7c9-2c59-40e7-bff9-09140372ecd1@foss.st.com>
Date: Mon, 21 Sep 2026 11:11:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] media: i2c: st-mipid02: Add missing
 v4l2_subdev_cleanup() call
To: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>,
	<sakari.ailus@linux.intel.com>, <laurent.pinchart@ideasonboard.com>,
	<mchehab@kernel.org>, <mani@kernel.org>, <michael.riesch@collabora.com>,
	<jacopo.mondi@ideasonboard.com>, <nicholas@rothemail.net>,
	<sylvain.petinot@foss.st.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <cover.1788940469.git.chubuchnyi@gmail.com>
 <12ac971583eaf4775a0242a58a6ed0a1fd08cdb3.1788940469.git.chubuchnyi@gmail.com>
Content-Language: en-GB
From: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <12ac971583eaf4775a0242a58a6ed0a1fd08cdb3.1788940469.git.chubuchnyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E4:EE_|DU0PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f1a514-b211-4dee-f127-08df17c0422a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|23010399003|82310400026|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RSmSRHG49czEhZD/KVMDrScOMbVUrxi00PVZTbLFuNZ/agsZhR2s/0KVSx76R2TtiPr32IViCfvcs8v5DV8zDSaYYrIMMqbMEMWoELl7hcR80gUIFa4NhgBD44jFat9HZNImXkFGu3bTQPn47sM02as6SzbPUTrIF4UXVB3YBZCQSamiMkdIm1Sihw4wE69DVimDspRkfdkdnQZsowy/5Hje08SV6fwPRqyi/Cu94vyVZWYcs5tTwR7v/2TFveyKtwxkNQ+XwxGvpCuAlTFSHWrB/4XT1fCw3IE1Gnn8nRtg7fcox5C+wRrrkp6X7s5gx9PhaVkx5+jdFczcjKVH3nFkDQUdxE2X6Qx4aSjwnRgwAtFarJfkXwSiohnB2rKhp1hteCy+wvzk82KllIsSctcaheTM/qqHuW45jsIOYN7d44/k/wKWch6Ul5Gh0v2GZbw97N+9ENzTcLOA+EONv0HYYSSmZq5EluZoRcGNve1TWdo5wiA2xZdrBvImt878dfzvopGmfD49a30xjb1Yv/MFqCJtmY4WG0E1VKEgIAKSFTOhZKcJJmFKxnUCE0yeFgBMR+W1rBAVobG01qQ4tbJRmcSPCDjExD/rNFvboldMtVts21A2Zmatiqkv05tiaDzN96mp205izhrrNUvW0Jv63UQiFXTYlwyB59gXto019kNcnMYlwIdLsJM1Q1aGJg14x+aYAtLNxgh6pMT8og==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(23010399003)(82310400026)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a7A2gRaemMLN+7bnU6aObu8vxU6rB0FQ6a7iO3sdhP/Lfg33ID9t0/dC0Q929afwaQhgY8M1laBlxVGyMfbdQ8BEKn32bhY0Yw+tC99JI6yLls2V64x6hoF89M4koCS4X50U5drvdGKa4T5IBmXAjQjclZdnhmiH7eX+1yqZv0qplrpqH7aoTSJhph+O08qXMlt4odDqIdPXDwBqiJY7qcsi5mPvsTHs6GWu7Xk1oexz6vZQyxnXi1qat/GxyihD8lIdsj0gsfH0JVkQ4B4WrKRZLDoHU0O9elceGGBgZC20DrGbtKBFJYM3SUsNOXmhbtpB6Pr+6BS+ZE+Ozlc567Z/Vjh6/Q9eJkE1JdGcZfuD8RsrU/UGRWu7+1OcVQ9Y77ZwI+7NA2gH8Qc1G2Y5YQApym1/5AbP6JVyASxsll/arx5WRgM8HWqWA91AwyAS
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 09:11:02.0029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f1a514-b211-4dee-f127-08df17c0422a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7167

Hi,

Thanks, LGTM.

Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

Le 09/09/2026 à 10:02, Aleksandr Chubuchnyi a écrit :
> The subdev active state allocated by v4l2_subdev_init_finalize() is leaked
> on unbind. The driver has no common cleanup helper, so update both sites.
> 
> Fixes: 04d170b288b3 ("media: i2c: st-mipid02: use active state to store pad formats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>
> ---
>  drivers/media/i2c/st-mipid02.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index 4675181af..b2f275129 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -919,6 +919,7 @@ static int mipid02_probe(struct i2c_client *client)
>  power_off:
>  	mipid02_set_power_off(&client->dev);
>  entity_cleanup:
> +	v4l2_subdev_cleanup(&bridge->sd);
>  	media_entity_cleanup(&bridge->sd.entity);
>  
>  	return ret;
> @@ -937,6 +938,7 @@ static void mipid02_remove(struct i2c_client *client)
>  	if (!pm_runtime_status_suspended(&client->dev))
>  		mipid02_set_power_off(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> +	v4l2_subdev_cleanup(&bridge->sd);
>  	media_entity_cleanup(&bridge->sd.entity);
>  }
>  

-- 
Regards,
Benjamin

