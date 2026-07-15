Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FBB41DE18;
	Wed, 15 Jul 2026 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107566; cv=fail; b=i6RlKBocqrNO8wxWIbt445i6GS9tVc9pA+NzsBf64/+vIQlhRw22Q+k5ib3Kccx9H3/OTZyhqUyofUBlYdmZh8PBNCJKrZ9DSfGYzz0wIEsgz5/7KEWCN9QMiXTs/Cl77Co6CVsDqDjHXNUkli/UF8181I2J0NfYxOGZENjEeK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107566; c=relaxed/simple;
	bh=ePyfJL0QyffFUBPXscGKv9HB7nf/PzUN/UPGTRND9FU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=gbtl+e5CxWG+ZqmvGrBZUo2dywoaeWbeMga9Lo/CAcoXzaJrzxn9XT1go8Qhs9+3YrVy2wytm+Cw5eebPRiCqGdoH36ki8F+5Xdk9YnoVcE/1lpibgrQdb7plbBwNg/GINLNd06ZZeewgc3ca1nmX6fOusbW8cuofN4v2YDQW7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UdGwwmgK; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UdGwwmgK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7ma6nrFProuf+M7lpS+kqh/zyN6bscVD2xyMJT7fXVk88KKwsPZDLMhG2ler4WYyp11cHW63Hyz752vaVszCCKyuwDLubktOeo9iq0Ncp3DuuNYqO2YT3ulf250PubBNM/WPQSItVe7YpltKo6J5CtAEzJY7vbRR/7U7rSS3fyx5KQ1kecqCiybCJi6Lj9f0+KaJyXmPsth41j67DRWhphvzAJvDtp8It8dzL2MG0F3yNYjneYTmiomv7lvSLe2SrFpCLjfXoZWXxzBAmIuALrX6IT9wBHesEsyRYTRyjMxcpR3XFqn1UcHtUWHSZ0FUhn9jTCqO4VMAIgkupcGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVSRtB5nHUt8h5/eCL6gXbZV/QcQg1fOB4LrbXKcfm4=;
 b=Cr7VVJwneTJrKjtRtgPKx8A5lR3UW7EXM9lgjNlMAC5diR8wwD/mky5v3vwFKgrizc7IhFvjWfkG9zPXMaXQYUVYRkqm38kiCf0TvOjtStpUGi+MC21bLxaC93/HMAK5xPfoe9SnU3lz7k5QllR/NQY0Ze6HudhdRdM44f3Utt9cqbXblm4lbHVekNxYmX03ZaBtmxQIX/t5JxEtuR1NDMTlH3il2ddHdQe2nRX1wjLE0oYXY4bCwFihWSZdd00SkaO/JKzpctf/h0Ag+KZnR9ZpDMbm/EM8Ya1X7dXrhSYhmHJLq0C7QuWLAr/erMAetvVYB5x8c8YkuIvkI+tDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=0sec.ai smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVSRtB5nHUt8h5/eCL6gXbZV/QcQg1fOB4LrbXKcfm4=;
 b=UdGwwmgKh4V6lqckHE0XMN64sn3E4f/ZFZ9LEd2eRj0/+vwcpAruf9I0dHCswCtHEIkVGlqDOgfIQrVslOj+jxQivdflOc+Y6ekKgdLm4xriaV0JeIDVOyqLvEy6W6vpFkkYaUJ0pQY0j5oplTCdUjCeTwOT5BcEniT6fMy0Lb8=
Received: from DS7PR07CA0013.namprd07.prod.outlook.com (2603:10b6:5:3af::19)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 09:25:59 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3af:cafe::7c) by DS7PR07CA0013.outlook.office365.com
 (2603:10b6:5:3af::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend
 Transport; Wed, 15 Jul 2026 09:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 09:25:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 04:25:58 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 04:25:57 -0500
Message-ID: <c2c57689-ee6d-99cd-2d96-da95f2876a60@amd.com>
Date: Wed, 15 Jul 2026 02:25:57 -0700
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
From: Lizhi Hou <lizhi.hou@amd.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>, Min Ma <mamin506@gmail.com>, Oded Gabbay
	<ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260713173030.87541-1-doruk@0sec.ai>
 <20260713173030.87541-3-doruk@0sec.ai>
 <78c05949-61a8-9737-3642-289c8921e2d7@amd.com>
In-Reply-To: <78c05949-61a8-9737-3642-289c8921e2d7@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f402be6-56de-4953-1b94-08dee2531482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|22082099003|4143699003|56012099006|11063799006|5023799004|13003099007;
X-Microsoft-Antispam-Message-Info:
	I+T9TWpD51ABnUD9oak79AqANr0849VBCimW/DSgHaM0jLcXOtOrtfgKFpungeyRxpyM6oG0fpLPsx0drSjYcDK0Ct0LRFEwa5MRMfpjehTr3bZz2KNZSqyB/rgk7q3GLydNjNpPbacw5XSIMtTeeEwDRR+y+EwydFl76AS8cAq1y+NyRgwVBfTAoNhbkdO/2wpjKNgk95W8olsOklgqyut+2j6tnwB6eTgtUvqgOTh8709YNv8YxOy6yDqydKxmeroqQXs5aImLS67f4Khbj+fc83aJbzmIb/VMEQlOdGgI39cq0AWdvtaWbxZtGqIIvRbXG/nF5j/I+I0kV/as1utGhrBtgVzPZUiPrvYYMcrcDekPn2m+TvVfL3bgoTMHZVZH9Dw6Yb977WZN71Ncoop0jbjv8qwlBrdzH1c8RwG3Z2xdjAnKs3rDC5PKaPDgaluFLY+H33vY8/2lgF9ZKOPRI+VPXza8Pp3hMOzYaP0gO/Uru3U9Xu68MrEQ3ZbFwkfllMaWcQklq5B+NQfDGfSggRgA+pF74iKNdEA9xzMVW+NvjXlnbRljw15tsqDDc37mDlKVSa3uGIIGXARselGaXoxZYn0+rWxPKm9+EiblHJ08QhUMFxO6NXvDdw+aBhds0xhWU7/QLF4OUdZ0gA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(5023799004)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NVptMmi8aYjzwZekL9MVBnCmY4PEnagbNgqTYynI49kCD1Zcqji0xvevItkfl6iTj6jlZT5qdhhGQRlhxbRFRrZLIgeUgfagl0uLq4gXeOFNsQNwubWgh5dhYbLGocurtU8Z2h6z8WFr/xUdp3fMpFB0ago1VvKsW0s43H3mOQtSNzKQQHHoe7egBiLD59HQR2zdSNZ/bo8qT3GevAeAUpk3EaIGOUoVfMRcddKv5/61MsjEl2Md5OVINl3S75FcB3X4BsBceWAiiiP5unHcf4ryZ89kzUHdoKKCg4KM/AAQRqsQwkhkrNsyUQ+UmRKUAUu8L46grwsl4ZYXirXqxnEUySnPDxi3p59dZPZdvu/oS6UZ/2VVfVIpwexDPJaxSS/iiCxUgXXqpw2pfUkzb8EFXSrSaYncd6MsNorf/udsVTxOIuXdqf1pvVa6YNZQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:25:58.6879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f402be6-56de-4953-1b94-08dee2531482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240

Applied to drm-misc-fixes

On 7/14/26 18:00, Lizhi Hou wrote:
>
> On 7/13/26 10:30, Doruk Tan Ozturk wrote:
>> amdxdna_cmd_submit() calls xdna->dev_info->ops->cmd_submit()
>> unconditionally, but only aie2_dev_ops defines that callback.
>> aie4_vf_ops (the AIE4 SR-IOV virtual function) does not, so a user
>> AMDXDNA_EXEC_CMD ioctl on an AIE4 device reaches a NULL function-pointer
>> call and oopses the kernel. AIE4 submits work through a mapped user 
>> queue
>> and doorbell, not this ioctl path.
>>
>> Reject the submission early with -EOPNOTSUPP when the device provides no
>> cmd_submit op, so the shared EXEC ioctl is a clean no-op on such 
>> devices.
>>
>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>> Cc: stable@vger.kernel.org
>> Found by 0sec automated security-research tooling (https://0sec.ai).
>> Assisted-by: 0sec:claude-opus-4-8
>> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>> ---
>>   drivers/accel/amdxdna/amdxdna_ctx.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index a5c8c2c4de6d..bdbd3db12a6c 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -590,6 +590,10 @@ int amdxdna_cmd_submit(struct amdxdna_client 
>> *client,
>>       int ret, idx;
>>         XDNA_DBG(xdna, "Command BO hdl %d, Arg BO count %d", 
>> cmd_bo_hdl, arg_bo_cnt);
>> +
>> +    if (!xdna->dev_info->ops->cmd_submit)
>> +        return -EOPNOTSUPP;
>> +
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>>       job = kzalloc_flex(*job, bos, arg_bo_cnt);
>>       if (!job)
>>           return -ENOMEM;
