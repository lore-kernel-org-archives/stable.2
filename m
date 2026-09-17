Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344554EDCC3;
	Thu, 17 Sep 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676718; cv=fail; b=kXM3Pir1N/Z22yNVOodbl9jWuYNl6VoVTNcuS4sZxwi4Qi0TQwD4d6Oh6Xm5Br+R6qZHDtl7nRFMq7enGzpDVMYg7Ri/IJUpIhnEzWMbbrSe5yMNCeGZOmpmgc6yKuwhzlc0rYNydJRECPFrZOh+3g5DOU0wxQreC9DJSf2OPuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676718; c=relaxed/simple;
	bh=KLg4frHuMIJB9Anozke/pLTdCec2LE5JKBdWOKDKcms=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=j84vaE64LoIi2Nc/CGiJWGk5NZPPKevuZoTTOfhFjujh3t88FSfjuokNVDMRcVTxIDgn4eLtBXMOVswRbOASDq8EfGVPLIVzKRrJqebXKqEVTU7f/f0kbVp1qVn1gV5VITNNbGspkJWxadpQ57VAOJNypfEkcz9jsQvit/ztYsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aRGKxuBI; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aRGKxuBI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSDcdNJqr8o9U2AZyGruviZpUkZeOl7VTzmRZj1cDbMUIV++Hpfyj/cNdAKv4KO2UppgVa/O2J9caUA8Mn2WKnqCvzM9TUsxrbjoXz858RV9+W4lMY7o8H+cTG9ZwGJgLmY7yO73OhIIr1LRD7YwrikVgnUr6gy2UZ6c5gUSlHEYIxvmFHMwk076r4WZPRi8JiS5JQ/Ko+yX2EvakSADSTNys1u4/4b+B1hyYg/fqbKOGxIGqf4hCEgQdW1bfRN2xiYb/H8PHLh3pQp5xz6+4rVYBPaSRv3LxZeXFbNw+dZGfBqWoL671SYRt2fwyEhgDCnz7+nPOrNvzfnxttsBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suYWBYdIpXhcf2ZgFMeqayRMChXy+6OctjmXk4HO/Gw=;
 b=SqBQcX8FpA7duZVzRNwVqo31wQ9PtSrkjb6QI+IzNq+PkMGiMMAOzb6y/YNKyKOIu5r7iILMthMmoJiijNeQaqGNNtjVJYuaXjHcEG34KwRbmIjZ+WcN+pkXZKtcwTjW/dtHVvEvNThqCpOK/+bJSDHQTYbdAtvN5aDnFO1JLNoZuYc3q64FmrsnnNwUiVf7JIA6C7j3uwjiF3Z1C8KrSPBRAm3HWySqW4BB6nc+RvcqDSmvP0lMnf8XFL952Jhev0bgoH4iFl/a3q9tUzDNFWOw2ihBbhLWcWNcyWeLnLIMkjSdFZp2q7Y7vPb8DlecpV93lM0sjkmjLoFg16q3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suYWBYdIpXhcf2ZgFMeqayRMChXy+6OctjmXk4HO/Gw=;
 b=aRGKxuBIM83SUZNapMaE3cePO4XHIdoOtwh9GEhJyTziK1orBQPDU9Z4jOiZ8fk6alYHhk6LFgFTgJnx3leUCiUA5QmGR1LoS84WtkC6yxjFbTq0pgDlnPCd7GUTd3H+n/rNShtJTt0LVvapz+rOrqWsXfd96Uc/6Naj5eTmCbk=
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Thu, 17 Sep
 2026 20:23:55 +0000
Received: from MWH0EPF000C618F.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::2b) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 20:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618F.mail.protection.outlook.com (10.167.249.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 20:23:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 15:23:54 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 15:23:54 -0500
Message-ID: <81bcf2ab-cfcd-3e2a-ca91-671e72d93bb8@amd.com>
Date: Thu, 17 Sep 2026 13:23:49 -0700
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
From: Lizhi Hou <lizhi.hou@amd.com>
To: Eva Crystal <0xiviel@gmail.com>, <min.ma@amd.com>, Min Ma
	<mamin506@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <cover.1789334558.git.0xiviel@gmail.com>
 <2fcf0eca215090dbbd95cb86e1bf5076056d3818.1789334558.git.0xiviel@gmail.com>
 <e9fd6957-306b-a649-0352-1beabb91c60a@amd.com>
In-Reply-To: <e9fd6957-306b-a649-0352-1beabb91c60a@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618F:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: b719a433-dd4d-4237-73a8-08df14f998d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	PYokYou/iQ6dlyxFfvklv2+XvVLZDfdjWUchgz8vV1xO6au8P01GSfE9Xnxqr6kq7G5m4yMLkayhIjaXhkCwe0NpyDwg/lDNgJFdLdeU76TOdFp3qilPRxCxCjTb1Uwgm9ZdVH9QDk9LuI9j+SbT/3idGvlt3GZyEGZAZz99KbL26wN8kLmqOyoPX/ufTQi8VKSSIlA/kE603hSj8IGBAy+wo0Keir5eu4bBXKB9jyHsueUw11QZxScL2H1k/IJDJX5AvnWvP33teIolTCqdcewf9Sx45kSpNK3NaH6jaGOrzASr9xqT1pFQ5mutirXOo2jYH89Jf2wpm7/HUaY1U86lR0L8Z8RY/tyKFJZpj7L40YY/WKXyVttWiACoznsAD1iOZX+Ev31Z9G1IQKYx1/jC2cOK9MZyynozL0LCANb8fPwr/95kWJuqvRZORy4X2gq79pFd6Vvsw5BnqBMx7+7t+yZGvt0tsILPrCFDzTfmW3HHhnfYWe9IAN7FmV15B/Xdq8cN+GaPqPbDWA3mPGXTBfQEMlNdCgBqGBsSj16iuAyJWpr0GOHBq9eZ3qxRGvFNyPk7iP9WmbdU5LN9yPPWEIsCcbYhoNskkOzPZTE5e+sBWNm0Ps4sqUoBt9nXhNnNTSRgO193t7v4mAzQ8A29ngMKzBgthu1y18kYsAgOnScDHuHlq4qmSrmh/cTvRpi1FFQX6AbxT8TyJHTd4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lZCQbWFhgn/dsU3ij2Ot0rQ7xdRJl/CAyUha3uJD1jnCTaaBGdxu2gtfyFy/rQ15FoXTmYHiwm1DaDVYpfba3mV2yCbQovQ49uY/Rxko3hfQ8gk0HvmEhi3Gz4ZRwoF2bYY53mHf6WNt7/U+0gz5V9C8W3PFQCnHxyCgWm/MF8DHX1OjNBzR1DcFMcoC02onBSmzV58yYIoL6joO6YO4QlfBaY6fFfxETsgWuzP9pJe930YPq8AUH1r1MK2NTU3xfNfqP+egO0WI36c/kZmIp84XRq0Ind4FMlEcevtGUY9g/Y3R6hPX8JOl2PmR56Fh5OnorxFgsLJwOsvfJw0bRMo5kYu49D3jlI3QhZ5UCQvFnZ6XYxiabz4l075QghXIbzQe+ubZ313UBWylT4tH4XLBFH1/ffUro8Kp2JOsrjvNxJtDFlaKtlb5m/8ntPkd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 20:23:55.2459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b719a433-dd4d-4237-73a8-08df14f998d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

Applied to drm-misc-next

On 9/15/26 09:36, Lizhi Hou wrote:
>
> On 9/13/26 14:31, Eva Crystal wrote:
>> aie2_create_context() allocates a mailbox channel, starts it, and on a
>> failed start frees it again:
>>
>>     hwctx->priv->mbox_chann = xdna_mailbox_alloc_channel(ndev->mbox);
>>     ...
>>     ret = xdna_mailbox_start_channel(hwctx->priv->mbox_chann, ...);
>>     if (ret)
>>         goto free_channel;
>>     ...
>> free_channel:
>>     xdna_mailbox_free_channel(hwctx->priv->mbox_chann);
>>
>> hwctx->priv->mbox_chann keeps pointing at the freed channel. That
>> pointer is the driver's own test for whether a hardware context has a
>> usable channel: aie2_destroy_context() returns early on NULL,
>> aie2_sched_job_run() refuses to run a job on NULL, and the message
>> helpers return -ENODEV on NULL. A stale pointer passes all of them.
>>
>> It matters on the restart path. aie2_hwctx_restart() calls
>> aie2_create_context() again on a hardware context that is already live,
>> after aie2_hwctx_stop() has torn its channel down, and the context
>> survives a failure there: aie2_sched_job_timedout() discards the return
>> value entirely, and aie2_hwctx_resume() only propagates it. What is
>> left is a live hardware context holding a freed channel, and every
>> later user of it takes the non-NULL branch:
>>
>>    - the next job submitted reaches xdna_mailbox_send_msg() on the freed
>>      channel, via the !mbox_chann guard in aie2_sched_job_run(),
>>    - a second command timeout reaches aie2_hwctx_stop() ->
>>      aie2_destroy_context(),
>>    - closing the device reaches aie2_hwctx_fini() ->
>>      aie2_release_resource() -> xrs_release_resource() ->
>>      aie2_xrs_unload() -> aie2_destroy_context(),
>>
>> and aie2_destroy_context() then calls xdna_mailbox_stop_channel()
>> followed by xdna_mailbox_free_channel() on memory that was already
>> freed: a use-after-free, and a second free of the same channel.
>>
>> The AIE4 management channel already does this correctly -
>> aie4_mailbox_start() clears ndev->aie.mgmt_chann right after freeing
>> it. Do the same here.
>>
>> The create path itself is not affected: when aie2_xrs_load() fails,
>> xrs_allocate_resource() removes the solver node without calling
>> ->unload, and aie2_hwctx_init() frees hwctx->priv, so the stale pointer
>> never outlives the structure holding it.
>>
>> Starting a channel can fail today without this patch: the ring buffer
>> sizes firmware reports are rejected unless both are powers of two, and
>> request_irq() can fail.
>>
>> Fixes: d5b8b0347fa8 ("accel/amdxdna: Split mailbox channel create 
>> function")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Eva Crystal <0xiviel@gmail.com>
>> ---
>>   drivers/accel/amdxdna/aie2_message.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index b4c49259a1a2..f658760c3d48 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -277,6 +277,7 @@ int aie2_create_context(struct amdxdna_dev_hdl 
>> *ndev, struct amdxdna_hwctx *hwct
>>     free_channel:
>>       xdna_mailbox_free_channel(hwctx->priv->mbox_chann);
>> +    hwctx->priv->mbox_chann = NULL;
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>>   del_ctx_req:
>>       aie2_destroy_context_req(ndev, hwctx->fw_ctx_id);
>>       return ret;
