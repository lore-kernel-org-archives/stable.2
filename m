Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1A41B8F8;
	Wed, 15 Jul 2026 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107524; cv=fail; b=UfvTf1pqxT/3houirhAGlV4vr9+rn2HXZl4ifH8BFnQ9PCxNKp44WzlFKi+eIA4Z/i/ifT+X/PwswXYEKSUnpIHN56ofQ2AkA+5Ni9Tl1IsHPNJ0yLKzEwPfVeoUGDbVJRZifRrNiBEsLHRGD4AkjfMwCRdU2wK4766ZrXdgIcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107524; c=relaxed/simple;
	bh=1ftMLHcgdu40t2dT5EBJUawzshjYbwgGgNweCi0eoiY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Y/SlSU9+FfPqqeSuFkp5AuD+2y/ZeHgq8MFkLdR7fYh1huAZiergdFzMhnLzlsy/sFcv/eA11GzY/RVzGmZPem+H9ASyfPVONivxkrDU8BsiJr056U8wGnRW4mxgxVfVJBBF8EgDwlLESpn0bGoiWrjmoWuRxUz9ySs0wd39otE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QoS8wWUw; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QoS8wWUw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Key8WD97jQzXY63zLEnjc0oyiwtNmw6Z+NrMMhHa6PMcAgj77yO8yQidqOwLh75PVvLyYSlQmgFRpMLE2F0pU3dgZ+H89KPtx2JsbObj1+bUwSemg+Rg7p1gVYo0oI5FCqLWkZv4PooNblHsrFChkUGb0pMHNdxfyf8N/1eDyeCWJX/HEd+XvIyUujqDlQak2Ok4TeoFX2quwPhEOsvDr1IyBEvYKrut2cW/o/r/NcKnMAEXRvwStfsvdi/s18lyLeLibhQg7WedgEYMDAv8Pd14Xv/eJU6wCwLSlgHodUhoWKIQXY3NX4/RX0AawIP/SwKx+72eSbG/RgZZT4gq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2TODJaKmygQdCXKEp9X7DAUn/oYRAzxYLAt90zSJLY=;
 b=LzvWA8rZ2UXfyblnCxX8yQtdYCOr3yWVOdYUg9Cp4ZMZ2IlcGEHWYEp3BlcApA2o8QOKND2TPRI1u8Dl18xIh7kPDy5a19G6wLa5e4PAiFAoY8Evk92AfxqBWMHmoLXhTtBQ0MAHQPO3AwmLzgAePNlN0PRxZHZ+LUf0W7RnMAA4JCWz+fnb19nrq7ZSsdoESZ9id0nS38PfEbuXTHfjk5vH1JxkkVVM4u7MVwQZAKoTHcJkR1kdyG4hB3nHXelrK+FnOTxX34zdMb0oSOM7kJ/l/0kIevLUZiE6hkJdQkC5b1vBX+Is7Cah45FuIoolbZOtm9gxkQXX5msV+IgtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=0sec.ai smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2TODJaKmygQdCXKEp9X7DAUn/oYRAzxYLAt90zSJLY=;
 b=QoS8wWUw0tNrp3OvK5nZ/85AmGaiam7ERvLFTCtZ6/RYpOBxnjF0MjlkysHgoTVBTkSV+ZR9hoKEAhy7Q6RowOYLfUSWzwboqtEzqOdqp2cT/yXZpUbEGM+xyNQy/ZUwbKu+mdMnsUKjhVg/JcRK2Gyfm+x1tMxFxFjhY3JxrgU=
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 09:25:19 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::62) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 09:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 09:25:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 04:25:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 04:25:18 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 04:25:17 -0500
Message-ID: <51d621de-1829-4411-28de-58646117fef9@amd.com>
Date: Wed, 15 Jul 2026 02:25:17 -0700
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
From: Lizhi Hou <lizhi.hou@amd.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>, Min Ma <mamin506@gmail.com>, Oded Gabbay
	<ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260713173030.87541-1-doruk@0sec.ai>
 <20260713173030.87541-2-doruk@0sec.ai>
 <a1dd222e-10e5-4746-264e-0d3705692bf6@amd.com>
In-Reply-To: <a1dd222e-10e5-4746-264e-0d3705692bf6@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e25aac-660b-4faf-db66-08dee252fcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|6133799003|11063799006|4143699003|56012099006|3023799007|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XUCrItrjJedrMm9MHnX3McrwrvRRj/0oztX7Ksse2doqSSZuiuuS5q46IkWa7IUrY28O6gCqZc1gttOYVO2cZoub2USiFndA4VJG+LZCn2XZ72+cJTrOQW7z/y0+dC2cGDT6/e3TeSlvzy1HpjfgCF5ad2/rDHw2pQ1Td3nL8h4GmFB4dprjHCNvW0n6nNcW0xw6ko+thHRQPeDiIxK+02h3yJraMf2f963sWLMNjPuSaoIgvbD1Et+gWIAns3a7VF2i2pWcH/4wErvcUEZr8BGOn6YSOCiCdV/j0jqY8hJ3/YqDcLIbVaIQGsdgntr21T7ezuvXXwiiWz8g8iwBHAf/R0RQowEzyuwEdFwh0BbXnUaZQ6dCKThYv3u0CPGAsUI0gVGrzMjNdPKvM9c26pHl7HqKBbyrmF6Xfnkc2oGHvXO2kn2DY96oxc0Xow4RUavPmQlpcj/ngNa9CJojsuIbp5CiXDtRmYT2+sybjnrM0Xg7/xH8NwXA0ODTckfb2+HmExj22rMFErjQ+IWURZabscxv58R4LuoOUIVnKGBnH4Kuv2tW5QlY0srtS5sjeGWdHGrsECqiSg57PrA9vEpllzTnQIx9lw660OyDDXzEAWfYT3vs1AkRLMH1MJUDC/gHxpI4lKDTvngyAM79ZA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(11063799006)(4143699003)(56012099006)(3023799007)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yd9zPmK3qX8v0t56Abd9GUmOgnsm3msOWhrIbGSY7gNhnP6A5BxKF/PsIJEttlAyH7bSy3TrwZgKdEKPkMCeIlLSff7onYlf4ITaLxLUFam84tB3uHZY1c2CDAgYuknM0ccBEL1ApdkirkrsVN/gpjoC9rZ8ThEExKMP0HZANAKPgKqPRx1MScPZ/9x8x702EyeyNXcnRdky5D8FSoRrfdrJIA4aj+9DzWhDZwgpLS2nSO83MXcePOBdpQ9e+bIMWdSuevsd5oItoI1PnZ+JWYiG1G0qK2FUTHMqPZq6+ORXXvJwxEjYOPYz15D7P8EDws2IECymTSs9/U2xeIEas8sDZj0UCLCEqOu2ByvfyLer7io6uQM8BAy0H1VJ8PCtEgJTOOapcowJXVRDeO+iBbL6aEyVOKshW0oIQDXm8PEikeOCNTLrsved69Em9JMS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:25:18.7355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e25aac-660b-4faf-db66-08dee252fcb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

Applied to drm-misc-fixes

On 7/14/26 17:58, Lizhi Hou wrote:
>
> On 7/13/26 10:30, Doruk Tan Ozturk wrote:
>> amdxdna_drm_submit_execbuf() passes the user-supplied command BO handle
>> straight into amdxdna_cmd_submit() with drv_cmd == NULL. When the handle
>> is AMDXDNA_INVALID_BO_HANDLE (0), the block that fetches job->cmd_bo is
>> skipped, leaving it NULL, and no check rejects it on the user path (the
>> !job->cmd_bo guard lives inside the != INVALID branch).
>>
>> The job is then armed and pushed to the DRM scheduler.
>> aie2_sched_job_run() takes the drv_cmd == NULL path and calls
>> amdxdna_cmd_set_state(job->cmd_bo) -> amdxdna_gem_vmap(NULL) ->
>> to_gobj(NULL)->dev, a NULL pointer dereference in the drm_sched worker.
>> A process with access to the accel node on a system with a probed AMD 
>> NPU
>> can trigger a kernel oops with a single AMDXDNA_EXEC_CMD ioctl
>> (cmd_handles = 0).
>>
>> Only internal driver commands (SYNC_DEBUG_BO / ATTACH_DEBUG_BO)
>> legitimately pass AMDXDNA_INVALID_BO_HANDLE, and they always set 
>> drv_cmd.
>> Reject the invalid handle for user submissions (drv_cmd == NULL) at the
>> submit choke point so every user path is covered.
>>
>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>> Cc: stable@vger.kernel.org
>> Found by 0sec automated security-research tooling (https://0sec.ai).
>> Assisted-by: 0sec:claude-opus-4-8
>> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>> ---
>>   drivers/accel/amdxdna/amdxdna_ctx.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index 8f8df9d04ec5..a5c8c2c4de6d 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -603,6 +603,16 @@ int amdxdna_cmd_submit(struct amdxdna_client 
>> *client,
>>               ret = -EINVAL;
>>               goto free_job;
>>           }
>> +    } else if (!drv_cmd) {
>> +        /*
>> +         * Only internal driver commands (drv_cmd != NULL) may omit a
>> +         * command BO. A user command submission with the invalid 
>> handle
>> +         * would leave job->cmd_bo NULL and later fault when the 
>> scheduler
>> +         * dereferences it in amdxdna_cmd_set_state().
>> +         */
>> +        XDNA_DBG(xdna, "Command BO handle required for user 
>> submission");
>> +        ret = -EINVAL;
>> +        goto free_job;
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>>       }
>>         ret = amdxdna_arg_bos_lookup(client, job, arg_bo_hdls, 
>> arg_bo_cnt);
