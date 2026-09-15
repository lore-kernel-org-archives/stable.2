Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEEC40F8F8;
	Tue, 15 Sep 2026 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490205; cv=fail; b=ThyJeGzA61QGvxonXntn5WR6ADmjsYzrAIw1jC6dxsiW91U5jfjs7wSLJVjMOr9j4Rgbb+nr/bHIkn9IVgqv58TPCNDr530MoSKX/XU735BIizVGNqAmJHAMJB0YvorH5LGYjqqeNwJZqvsgf8OoxVhuooApymZpjN6w+HvtifI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490205; c=relaxed/simple;
	bh=cbas84s6WZf1JEIVd1/GVLdi4sMrlB8h1Oy77vvy4Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nui+63Hwhx7alyFqDC9G8IlAOp0BiYKmzyMrD8eF7HwlzBkPZCnjsvj40WltqALN3Tnjfk7kX4y89bKierYjnZzib4cJrCHN2zErzEPllOsinCGoPRp54OET+q5lvxbPn2qz3s/Yfwce/Idn8VBtMHBg6XEBQI6EHrs1FT/6nzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oyg/LvzH; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oyg/LvzH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DR+h1OwFcRreUPXHgWr1GT0mer1FiwdAzA3cAyWWpBu4f3sj93NmjEKyoSPgIkHwHqsiwG5hwkikd6w/+GCPfizYhvq61wg/n4B0F285bqjksp1zildZvZ36w3n8hRckUsuo7+VJ7ZbQhhd5S6fpS7wN9RieQvQAGu7QMuKEyp9zh6sNG1Urdt+BaKs3vGp0WbHyCXkBgBMefyoU6WSVBNch8Ds2BR2XpOzpJ14iBHAuTx4pG3ysZTzM8vSNm/4katodCR2AcbTz82L5nla8cH5WnP/BxjJLBuVcgYc73ulOQzb31+2GQ5eeL+7qFr2D88tr4tUMJpWG5W9bNml8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLmNN5RCOQ+yVJ3Dx87p9vxHxyDAoBc+eq4UvUdyagk=;
 b=PGrJN05dT2tBG0WXJHgFP/DNBi1yLOJHmFlvzcjLJkc0j6W1GEJiwKl0dVmxMcTpbWdctmVy5c8fd4y2HMUD0RqeEEROfWfFyXW/tw4YUdN2IWfXDRpplfkm+m9nFIAoGRD4U46jcPmDkmLdjtUP/rycHRtGKtUd5Sa+7y3duuf48CL2bKE0VnA2TCKHT0uK06KcXXt8Ji7k0FxAsBvwRpuRFl+0qTnEQovwYqjPbaHhlwoXXXKa/mCLr5I8SXXZ751DCaMCA/rikfN4A8ZlQzKVG1yw0YP+EdM3otXmK5fZ+5nH+wcUhgopAPB+QcwBQ+Ub4f0EHoO4lCbbfcb22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLmNN5RCOQ+yVJ3Dx87p9vxHxyDAoBc+eq4UvUdyagk=;
 b=Oyg/LvzHgND1ikMtdYB3ULExBtXrU0gipBm48MNsKmQpiTGMWQppLmx9MT8Iy2tJxZvZtKy95xRvayQgum/txJJj3mwMy08tDqCR50AhVL65Jp/d+q8kui6uFYtZPZBF/Esq1yNr8eebrxDCO/XonZ5MOMtoHsi3wmop49Ox/EE=
Received: from MW4PR04CA0127.namprd04.prod.outlook.com (2603:10b6:303:84::12)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:36:34 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::73) by MW4PR04CA0127.outlook.office365.com
 (2603:10b6:303:84::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 16:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:36:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 11:36:33 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 11:36:33 -0500
Message-ID: <e9fd6957-306b-a649-0352-1beabb91c60a@amd.com>
Date: Tue, 15 Sep 2026 09:36:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] accel/amdxdna: clear the mailbox channel pointer
 when starting it fails
Content-Language: en-US
To: Eva Crystal <0xiviel@gmail.com>, <min.ma@amd.com>, Min Ma
	<mamin506@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <cover.1789334558.git.0xiviel@gmail.com>
 <2fcf0eca215090dbbd95cb86e1bf5076056d3818.1789334558.git.0xiviel@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <2fcf0eca215090dbbd95cb86e1bf5076056d3818.1789334558.git.0xiviel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ff1a93-9216-49ea-8881-08df1347815a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0v/UCIR2XNMqr8IFt3OTob5TJ1g48/c3H18SliASbr+7gxe4sFdkq6SWTR0ifzYDBYCIorhPhgxJxbwnrRLnLXKzT4D+CFGLuous5SiOMG54jL8qRWd9HvKTNk1Jx9f89jyjI7r6UZlUgkvCQw/R9hUxQJUu623z0FXR44bVnI7XWaUXIcz0jlK9Xilrfcbb6H0PAXMzWkkwK/pKVJ8FARBWkxCzFqdFJxuHD19THFRO/4G+F6O1RvVD3s/ok+WAkEoEFhQ2+8Fd3YMl7CcpTPt49Yupvne3tKRwY+6c5g7PDp0ROGd0hD5gjgsN3rOMZh4eDOTeEN9y7+rCS+FmisjDyN3MesoRiP3cHu+029KuZdmRcdEMKxpk1+d+JCFkiw4UP/LJ43IBJ+4aPku4jld3o/6oeKZS96wNuj5wJMi/PfVu8NIUxqbo/vvHl5z4Q0zW4N9erne4XQO0vlvV8N7oprKgolG9Bfn0oANR5z/zf34hL4YggwVwuSpdIKoJVpAGJf40RQlFZGb9cTGgodp20g2/E73c59NFiEYaaRJw8qT5KGcVNG93QfQEkhjhL2qPW4Zl7WoEvEcwfVIyKziIEKFBtVh+6Uhlg0r+YiCmL4UbVM1MXcwQH8XGoIYNGJJtSA2oSu3UbosR3pt0w44mtLuN/yfrQikMWKc+RTsDQ3g3M4Ujzl/h3stCyTd7SK7ja6APcWBK+f46sKPlDQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mVFcH9rnvJhihppdHnaN8BnUrNBUc0K9rL7DjHY+cQcdHd7/TuGvh2yz3el1Fg3DO7DUbZX88ZZfezCiOeVW9iSSLPOr08s1orPnUsxTfO8wiN3PsVRCaJGFpqDNfw1QBFZuFTkQdJlWhM4rz4PEju7kc0k38DwmtWjwJ4YwxySZEiHnnjDRR7OmZV/1eXNwssUSvW6zJPgsI3DYAWx2mKYpgeNOmGvvJU9z/S37j9b3WAfRyXNcafQeLxxs818slLuzTZB5Ch3a5kehxpI2grwCt2fnPqEQyL7Cud93tN87milEi2n3kqEvuTyDJCYnjC4Cy1IZgWZKL2FIgbFx4ee5ul+6lmyuypRb1nvWk8lfWNoFh7OKVEyKGdsAZbwnz08PsOlvSO0my2Me+LBscqcJVDao+7kwnkyCXrJ6fgUbVZk9XLZqt4ec1geQGMq9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:36:34.2367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ff1a93-9216-49ea-8881-08df1347815a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620


On 9/13/26 14:31, Eva Crystal wrote:
> aie2_create_context() allocates a mailbox channel, starts it, and on a
> failed start frees it again:
>
> 	hwctx->priv->mbox_chann = xdna_mailbox_alloc_channel(ndev->mbox);
> 	...
> 	ret = xdna_mailbox_start_channel(hwctx->priv->mbox_chann, ...);
> 	if (ret)
> 		goto free_channel;
> 	...
> free_channel:
> 	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);
>
> hwctx->priv->mbox_chann keeps pointing at the freed channel. That
> pointer is the driver's own test for whether a hardware context has a
> usable channel: aie2_destroy_context() returns early on NULL,
> aie2_sched_job_run() refuses to run a job on NULL, and the message
> helpers return -ENODEV on NULL. A stale pointer passes all of them.
>
> It matters on the restart path. aie2_hwctx_restart() calls
> aie2_create_context() again on a hardware context that is already live,
> after aie2_hwctx_stop() has torn its channel down, and the context
> survives a failure there: aie2_sched_job_timedout() discards the return
> value entirely, and aie2_hwctx_resume() only propagates it. What is
> left is a live hardware context holding a freed channel, and every
> later user of it takes the non-NULL branch:
>
>    - the next job submitted reaches xdna_mailbox_send_msg() on the freed
>      channel, via the !mbox_chann guard in aie2_sched_job_run(),
>    - a second command timeout reaches aie2_hwctx_stop() ->
>      aie2_destroy_context(),
>    - closing the device reaches aie2_hwctx_fini() ->
>      aie2_release_resource() -> xrs_release_resource() ->
>      aie2_xrs_unload() -> aie2_destroy_context(),
>
> and aie2_destroy_context() then calls xdna_mailbox_stop_channel()
> followed by xdna_mailbox_free_channel() on memory that was already
> freed: a use-after-free, and a second free of the same channel.
>
> The AIE4 management channel already does this correctly -
> aie4_mailbox_start() clears ndev->aie.mgmt_chann right after freeing
> it. Do the same here.
>
> The create path itself is not affected: when aie2_xrs_load() fails,
> xrs_allocate_resource() removes the solver node without calling
> ->unload, and aie2_hwctx_init() frees hwctx->priv, so the stale pointer
> never outlives the structure holding it.
>
> Starting a channel can fail today without this patch: the ring buffer
> sizes firmware reports are rejected unless both are powers of two, and
> request_irq() can fail.
>
> Fixes: d5b8b0347fa8 ("accel/amdxdna: Split mailbox channel create function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eva Crystal <0xiviel@gmail.com>
> ---
>   drivers/accel/amdxdna/aie2_message.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index b4c49259a1a2..f658760c3d48 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -277,6 +277,7 @@ int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwct
>   
>   free_channel:
>   	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);
> +	hwctx->priv->mbox_chann = NULL;
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   del_ctx_req:
>   	aie2_destroy_context_req(ndev, hwctx->fw_ctx_id);
>   	return ret;
