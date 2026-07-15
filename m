Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9F26ED37;
	Wed, 15 Jul 2026 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077150; cv=fail; b=nW2PE7bdbU0in6WlpLgExoxaJyb7hBGxxlMX0BqsycbFtWpRsv/nlm0MHaVXBISJcwuOK9ccooXoCttmKbTtsRrlR/7qCHZUWY1EJTJG1d77MaKWJ4g7e38UUzXV5n2Ypiw9XDu3Bafq1zWDI/QTc06T3NdIkxxJK19Z3IeAsu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077150; c=relaxed/simple;
	bh=Rf4JLSGGXxa6rKHs0bpLFqtI4TBGBS40PwiLQA/PLow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GGCcN2N+1Sl/gBcNuzHjvJXa8lmwZ18reWk/h4fjDvREWnHtwIo8u66xh0qxzgLPZD9W/Vi6dr1S+FnXPHvAvWRn0W7vLMtOfoZmYUEY+1GypWXVd2SzhLh0EFTXC6R9oBuIjD2gR6hmyAP07lRgwrN3gf40EsOJiI1IfQKiFi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L14nMAX+; arc=fail smtp.client-ip=40.107.200.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L14nMAX+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfufqIZIMBzqA5p67baj+ffSsRbp+KizmXkNRErEbMoPTPhOBq3AZ7gRMH4BTKqLsFLDcnoPdkVew+ECxdXUoLNpUdYiFLx2HPQo/It6OnqOIy7BZ/GvS/eOn2sta31fvx3ycrJ/X5qp0WMYs6PjnCJ3FkfK3zhH4wmbwq+psH0fkBJLo3AM4bFkMTAp+gDe46j01nllJgz7Hn78ToyEwQ6zq31hBYxp+r4B5cwoMkygOteFLadE8N+dB3+C8JqxbX9UcLQ5R2Nhvy2j0c1ree9Lq2DYseWVB6b/FKPMW7hSeWWcv2N1j2pb/HAxAitifvR+8FyRkXhC7TxQnHHZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL4QRcUvuMDuowkGKuS4W+H2+FEZSHtB8rw8jDOTkj0=;
 b=EyJxBQkNbAvrGhIXZ16Z52yRWurEV/hKMeeSvyAX9KOc4i7zxTFzbOmHpzZGLEI6AcpM7GpHxQ622a4zY82jNyvth3mPULL1a/knl5ufRdc+9PB//8Ln3cN40XRWYpj5NaZCLZvvkH8tOUVEfJ7u/R6ZPxN/uqUM5rX5e6VPUdrck5SMwcMVKbtQpx4S9yqme3ucWELhjlZU/FYepstTSj4Adw5+hKTzPGRWCed/zahTowfhcgVUmhGqC+bGs9CF6vytIperwKj8fSM2jFmcnGbF+zOUYPhKUdEPeMc2HfLzExQxRHPWPhunX5I3aAZLV2+BLN3MVxUFe3ds3kk+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=0sec.ai smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL4QRcUvuMDuowkGKuS4W+H2+FEZSHtB8rw8jDOTkj0=;
 b=L14nMAX+J5k2aDNL1C/5elAwB6n1fVHiatJYCxJFWE6K2IGgmwFdwpTg2KmPHwIJdoq3WGbDmG6R+9zKB2uxP2j1rKWyGfQPgzkeSva4YvY6XZRzgjqKeQ6xdKrI0iMBJjZ+Kp3mo0wrqM4QkqENKGnwVxTyFD+qeMr+qlHwlQA=
Received: from BY1P220CA0049.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::15)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 00:58:59 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:59e:cafe::71) by BY1P220CA0049.outlook.office365.com
 (2603:10b6:a03:59e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 00:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 00:58:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 19:58:58 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 19:58:57 -0500
Message-ID: <a1dd222e-10e5-4746-264e-0d3705692bf6@amd.com>
Date: Tue, 14 Jul 2026 17:58:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] accel/amdxdna: reject user command submission without
 a command BO
Content-Language: en-US
To: Doruk Tan Ozturk <doruk@0sec.ai>, Min Ma <mamin506@gmail.com>, Oded Gabbay
	<ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260713173030.87541-1-doruk@0sec.ai>
 <20260713173030.87541-2-doruk@0sec.ai>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260713173030.87541-2-doruk@0sec.ai>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b335bd-9073-4acd-3c5c-08dee20c40ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|13003099007|18002099003|22082099003|3023799007|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xkWPcCm4NAkhgNoSV4g9R6cdcKpDENyCChcugTIwoAPGttXbkg1Mi26c+Udb6kQRyxG964+dxfjqj+ldN9GQqrmVISp7Ku/DMRtpT24hD0yalGjZDVkUschaizopUZ0w46rtv9FPcfBQHOAhC7OjYZY/fExqKrm6R+BnzwlNaFSu90c2HP9Ikx3qClmmBNuczr47WFZfOD0aiCvuo69oC5B9KiFYotjjmVvWx8KdXZ2ySbeSndSVQi0PwPoeumxpDAKdygn0YUhcrYHKvsVe9HOuF5GW83zmIspUFN/NykEIoaZc4GKOOyqpY6NkOKt9o/FCswomsYyVUv266Vgq0DXutvLfCrZgLCfw9ioionggFabHDOZqfXTwzaOtFFcHfT8jH5+UIqurP8bIidapuwqEsMENZQGJV9ZVQoe9qsq+FBtocX8yhQPloBRQiwbhnDT/jKOO2kI1xj1UmrPXP5jqCzfy14lgnjxDP1YjT0Km+TkO5d/UhYpoH8yGqyOILf0XTUY4uYVVvyjz5I/1Z0kbPQsM04frXrW0DqKtoef4Llt2dsK0waEMuKumKjBeKddvdklPacAVLk3tXZovns3RGUtQXq9gOKzVNQBtY0HN66iKCaclmMGvGAARPbOe896H8ZllaBoexqVcNSCNBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(13003099007)(18002099003)(22082099003)(3023799007)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ja+KAlhzKSf66I4+pdPGvTH20NYMiEAaBGulNZl2jd+OKPtCkNELf43vQIU6MR1kTVkbyKOCjTrpP0zl/kM7aSpLC5qIfpocNsc2nd1chCjusrEjCglR0Kl7BsXZk00j2hI0Iz/dv/FpOlFwliXJ0iBOwV1T+R76DTRqhLAeg8fMLqFjvX7M+vW+57TA9zqKFkDOw7SX2NjubQZ10v9K+pIhnBltsLpUODd0iK0TkB4Ic8cKEHsM+ZulyQXFUWNI9dCYYJ4thEvKHaEW87hTGNEtzn/O2ra7fUwi503xrE/SGk4Bw2Gy4bjd8HZUAm7rQ01r+eBuiD+0hpxIA75tJcyCyoh13Sj9SwrBxrnK2xy0aYjEkcrrKOQWzZvFsyXEhKmC69bRSJDMk7Xt5jKw497L7To3E4CYT9x8KXtg+hZi7JoJoAaHCD1yJRBh/1Ye
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 00:58:58.8618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b335bd-9073-4acd-3c5c-08dee20c40ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729


On 7/13/26 10:30, Doruk Tan Ozturk wrote:
> amdxdna_drm_submit_execbuf() passes the user-supplied command BO handle
> straight into amdxdna_cmd_submit() with drv_cmd == NULL. When the handle
> is AMDXDNA_INVALID_BO_HANDLE (0), the block that fetches job->cmd_bo is
> skipped, leaving it NULL, and no check rejects it on the user path (the
> !job->cmd_bo guard lives inside the != INVALID branch).
>
> The job is then armed and pushed to the DRM scheduler.
> aie2_sched_job_run() takes the drv_cmd == NULL path and calls
> amdxdna_cmd_set_state(job->cmd_bo) -> amdxdna_gem_vmap(NULL) ->
> to_gobj(NULL)->dev, a NULL pointer dereference in the drm_sched worker.
> A process with access to the accel node on a system with a probed AMD NPU
> can trigger a kernel oops with a single AMDXDNA_EXEC_CMD ioctl
> (cmd_handles = 0).
>
> Only internal driver commands (SYNC_DEBUG_BO / ATTACH_DEBUG_BO)
> legitimately pass AMDXDNA_INVALID_BO_HANDLE, and they always set drv_cmd.
> Reject the invalid handle for user submissions (drv_cmd == NULL) at the
> submit choke point so every user path is covered.
>
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Cc: stable@vger.kernel.org
> Found by 0sec automated security-research tooling (https://0sec.ai).
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 8f8df9d04ec5..a5c8c2c4de6d 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -603,6 +603,16 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
>   			ret = -EINVAL;
>   			goto free_job;
>   		}
> +	} else if (!drv_cmd) {
> +		/*
> +		 * Only internal driver commands (drv_cmd != NULL) may omit a
> +		 * command BO. A user command submission with the invalid handle
> +		 * would leave job->cmd_bo NULL and later fault when the scheduler
> +		 * dereferences it in amdxdna_cmd_set_state().
> +		 */
> +		XDNA_DBG(xdna, "Command BO handle required for user submission");
> +		ret = -EINVAL;
> +		goto free_job;
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	}
>   
>   	ret = amdxdna_arg_bos_lookup(client, job, arg_bo_hdls, arg_bo_cnt);
