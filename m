Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5A284B3B;
	Wed, 15 Jul 2026 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077223; cv=fail; b=L7llo+qlFWwRyJW+UxEeCuLE7pW8z28W/lWjbwmFaO0HAuZeBYAFA1NA8cMTT7gSXwO10P+PwKcDNisQnxbeaL3gbI0fOPX7XERv8hqrgBfhwujWYNrced9KpKudOuT6hn/qIX3BCQFiFVyE0dYobQJQ1fvS5pTP2KgkMPWTAfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077223; c=relaxed/simple;
	bh=vgAM5nqzllnaBD9U7bAo1VetGydhZFfRvy76Ktzc+1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hE+JFmlWVWGZhS2zZMVYQsezEliLCKapA+bl7BzYBPRoJwMAIBdEk7oP3jmPylKBi1jMePjJQa9CbKi4Yzb7GXHNca53/Mshkp1JMCjsgbr0exubESUU/xEX7jmyz4eyTGUWeo7VJbr1PeXY6Pz5Txl5TRYm8IQ7vvv93WSio/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uJlBcLNI; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJlBcLNI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaE/S6KTgsdv4xU2mWa15aU6zgBOkuquNBJaAGf1UiqcpO93gD/l8LDxKSi2xwv2KY9SX47XOPyV+/R4Am+LoG1ohUPTIBzKhblbS5qIiz5xmjPDvZxzKDrGGI8U9QEAkgCo4Da/hI5WDNCnlTmXP83FzI3YGXhg1a09jhD6zKyo7skJPI7TYUGqUeAufAyPyH+C+l+Uy7ioGUqgGVuJmN/0GQ6VL0yZ/1ZMaKc6hvkuzTXKRgk8nkXy+d0KiHROL9uZbs8Hc+WawG0V3oHr6NEM53SlrKbgQ3aD6JU9u4CuT8tGue32z/0L8vtuFsCOAdPdZd0G7MwiRVxMvstmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VGfb/r7ywOmk1AUoiJlYmyiKH3p1CoxToWQPZqAwmI=;
 b=ZZnMEKoAOcVuOs2YbOfFx5JzkRRRDAB6U7OD586VMLdb3Dq3fakoY1haJuKCboiRs5x6xBDQxmod92LFBsuGmMawqOiletFTeVVK+Zxtdb+7xTmhhUP0PgX8+YQr9cCIZIAYg0JunyQcczi/9jxo/XlXdwM9nhg4QKT8JTLksFNkQsGIPKEUiAXQhJvC5Gk/gQBOaA6ft6Kj3+iq5LlNwDnz63AB8RgT6i8saTMw6LzmyLLQMr41AU/F0RKBadFIleLl+6zes1T4d5da52gnCuwUnz38qpCkfYS2AjlwCKoae5QF0NzxvkdM3mihOcDkZEfiE8XpVmHMtggzVjE/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=0sec.ai smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VGfb/r7ywOmk1AUoiJlYmyiKH3p1CoxToWQPZqAwmI=;
 b=uJlBcLNIIR6oWlpIFXyB9wIgJbqqBX+OKSsSrNc9WSFZ8jrwrJSj9GQHP/ZMTddlIKVw/gLedkXDnXW5+izTTDWiXH3uv5S2PXc/FoCnrO57/ErLPXQm443MJwSFBsDsZAHhJplI/FcT7vHdzQWwvmylRtqIS5HYlL4n7i9iEEM=
Received: from SJ0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:a03:3a0::26)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Wed, 15 Jul
 2026 01:00:14 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::30) by SJ0PR03CA0261.outlook.office365.com
 (2603:10b6:a03:3a0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 01:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 01:00:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 20:00:09 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 20:00:08 -0500
Message-ID: <78c05949-61a8-9737-3642-289c8921e2d7@amd.com>
Date: Tue, 14 Jul 2026 18:00:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] accel/amdxdna: reject command submission on devices
 without a submit op
Content-Language: en-US
To: Doruk Tan Ozturk <doruk@0sec.ai>, Min Ma <mamin506@gmail.com>, Oded Gabbay
	<ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260713173030.87541-1-doruk@0sec.ai>
 <20260713173030.87541-3-doruk@0sec.ai>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260713173030.87541-3-doruk@0sec.ai>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 53912e7d-b6ee-46f1-7882-08dee20c6d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|13003099007|5023799004|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JOzxYjlCGfwbPOW1W3doPQWCUBvJkZ+8RiljEj8Oi6EnLQScPsR5ETURCBiujFb57yO9cFMnufxba9KqMnjZ5kkumoFcG87VniUps1CxlIPs6qjhYebsBfZEwtGLM7iVOXlOasguZIvKSSrwmFsPaZSeDixjPpM4jIzrAi6iFrXsrxAzx7XknakwG3xVQG2oY23PXmiifgkoiPzSZYe1oU9rtfgLMnZQgEMGhqAtMzu2eul5rm3Dqa2M1zheqY+w00MeveKbQoAag1v7sS7DBNu8YdFtYeHfZkzVaVRAYL1uIfcv24uhAJ260vX5sZe+ncIIneQJ37MwKXeYd6OgGRNUKc9juXJa5UEq/ZTby0mtdA5xLy0eH35fVl+BU54EnnUunSKgAUr3yVMpigbUnyhsxzzkL6Q7yXWOoqBfZ1Myjm3wGTuRVCHCH3dU1G9qhtgRGY09+ZjnDtL7K/GelgN4OrDdBbbN7tWE3NRRr+EsQs4XeXYX696RzL6cuH9pxvYsqpBMRqTzYA2lCIgBY8qZEBe7zCdNyGrsA+oDCw54BhcsgnQMQsiia//xs/PHRMb/d//Er2HgUe/Y5sLdEIu/AIFzueIJTiVUm1ObatPYPF1gFvXjrJ1Kmx5ErvQHidhLsRmVvdDO1H5MkZzotw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(13003099007)(5023799004)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D9fnkFcTycK8+xVhwenxdnU22NoX3K0SJJMippVxpgsC+sQcupPAuRjx8tDbLC87Ajs3gHzsHGu5IdthrqCuptrMK9gfWQ0BbNlF/RkCn0hQS76aVSIhOTO6whL6w5DdFqRLFlbv5vMYSKqYb8vJhovrr/+WF1Fp0KjH0KbZLAB3IcRN+i2yT/nMIkwdQ61CVQx+HaN2pu881UpcyS/TX2L2B+fKByqODuO5Na8d2DqhYchoshsFS1oOZDiRi1ilcSE0lFNkTzU2WuLEVqIErg+CDdbc/C6JLf3wH8hXFe93aWHDobld4GRVH78cKJxW67slCJDMmswozJZoovMXXl2eYR1dBcDZHvQ7DhHF36YUehwUA+GUfuDC3ZTO43nKkVXTBpnhGXL/r86FE1PkWypq9vTuWSyVOqL+V8eahrLYL6SATbwYxjgPL7ZkR2WN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:00:13.6908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53912e7d-b6ee-46f1-7882-08dee20c6d83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575


On 7/13/26 10:30, Doruk Tan Ozturk wrote:
> amdxdna_cmd_submit() calls xdna->dev_info->ops->cmd_submit()
> unconditionally, but only aie2_dev_ops defines that callback.
> aie4_vf_ops (the AIE4 SR-IOV virtual function) does not, so a user
> AMDXDNA_EXEC_CMD ioctl on an AIE4 device reaches a NULL function-pointer
> call and oopses the kernel. AIE4 submits work through a mapped user queue
> and doorbell, not this ioctl path.
>
> Reject the submission early with -EOPNOTSUPP when the device provides no
> cmd_submit op, so the shared EXEC ioctl is a clean no-op on such devices.
>
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Cc: stable@vger.kernel.org
> Found by 0sec automated security-research tooling (https://0sec.ai).
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index a5c8c2c4de6d..bdbd3db12a6c 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -590,6 +590,10 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
>   	int ret, idx;
>   
>   	XDNA_DBG(xdna, "Command BO hdl %d, Arg BO count %d", cmd_bo_hdl, arg_bo_cnt);
> +
> +	if (!xdna->dev_info->ops->cmd_submit)
> +		return -EOPNOTSUPP;
> +
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	job = kzalloc_flex(*job, bos, arg_bo_cnt);
>   	if (!job)
>   		return -ENOMEM;
