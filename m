Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F33A1A35;
	Fri, 16 Oct 2026 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133073; cv=fail; b=gFln+F+VRzy8XV0V0XkzJbAXdbJvBJg/qUuG4LB6SDg6VLyAEyvxNxhCWR5jv3M25QbgMhVcvyb3O8Vzo6nIgPvR7NWJYWR3LuolqPp4z3rJjEcQ7mj9ctIKTVmnnChip8iSqmy53aFSUp8IIPKatQWWpJ9pM9tFOoJDgK760AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133073; c=relaxed/simple;
	bh=EWAlRzlKsXvf8kubfa61ZnqFA0FzEv9J80AuAKKQPmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i+D96RI7MWr3uh9Togx8Cf1Tt9oY5CS51wr44egwY7bUQTwmG0RxHTscAcEi1zaXcodr6yOPdO79irqbM8z9uRcz20EfYmS3NWw1FtryPGc2xJpywBItUXfqRdZf+21oLE09i7mnahwTv273LzIMxTTGZtcIymNTtn2GFYJLoLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZdaOUPx8; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZdaOUPx8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR2g6ehp/WZmYG0kgv3yBD2Nq9ZCCPG35RpBGwIzGm6xD/7uifAx3rkhixvgZhYqHPORkJXKgAdVok1l+oAlFISlr0pPaHZ3khBpEP+E8nr75QJxtQkxpH/7YnR9Ha3TeaTQ0knRxeiEyH1S9iIWHuQUZD0quXtH2KWtXIc1A1rW/ONAVeERUTcUVWN18v3AY8S3gGOClyH+Rm5fGW0tI2i6BnX6lYSjtekmzc5LZtxKy3AH1MX+cOtb92AGvbpn2mySw7g8JKh8aZhv9t4AAiagz/prvrS9k5TFSrTVPRPRulMez8a0Uc5a+Aa8KXZiDBo+JfR/6aHNVVOBYEIZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXTApvlaRFpKhF36SitWIK+1yfuhvtIJEytrRj2nIJc=;
 b=fhKk8FZcPUTvSzU91TKLc0RZzI8SlNnHCfRKcg6Qrmb+Dqc/bM/PbiN7vKyR8suNYme8hz2s9CK4xrUahBVDZjk93acrIOhLD397+XDF7D7y2xeuPoyQXB56sbxEg0/NJK7SxXnT6YOnfDv+THZdY0i3XHIfRM2UZetT2Hu+JQKlFknBTTpGltqKcyMLGR+bOJpYUm8C/Pdpz0vgb4Fcg6YfAad/LvldNb0BM/cYUQ4/vz+MQ+EVtPx9Mmozc8gt0ykOgMnxROv2dc1YsYtG5aiehGDcFkkAq4qnAuz1IdINWskpLpD8zBFHxeABI5gLKXFNese7N7RCfQ6wgFnLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=uniontech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXTApvlaRFpKhF36SitWIK+1yfuhvtIJEytrRj2nIJc=;
 b=ZdaOUPx8E2qASED+e++uD4YDtpjJI2rP54SedhQ1eKEDUSN2PIt2xPNOiVFEz6RdLQ26LeO91MxS3sYRFjPt2qY37iznCMBj+UF4gxtH3h+yYiTOm5lZBbrUyTxOgLK/4KcR8TKtroUZFF3JOYKb2awdekTmDubxvPdzY3/42ug=
Received: from BN0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:408:142::8)
 by SJ2PR12MB8010.namprd12.prod.outlook.com (2603:10b6:a03:4c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 06:44:28 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::72) by BN0PR08CA0020.outlook.office365.com
 (2603:10b6:408:142::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 06:44:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 06:44:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 01:44:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 01:44:20 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 01:44:18 -0500
Message-ID: <5469c745-7b9e-4a71-8d04-8716c5af840e@amd.com>
Date: Fri, 16 Oct 2026 12:14:17 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Skip auto_sel write when it
 already matches the mode
To: Wentao Guan <guanwentao@uniontech.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<ray.huang@amd.com>, <ronforever@outlook.com>, <scardracs@disroot.org>,
	<stable@vger.kernel.org>, <superm1@kernel.org>
References: <20260918090909.86544-1-guanwentao@uniontech.com>
 <20261016055136.286138-1-guanwentao@uniontech.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261016055136.286138-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|SJ2PR12MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0adb05-7601-4713-c091-08df2b50ec55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|32650700020|1800799024|23010399003|18002099003|10067099003|22082099003|13003099007|5023799004|11063799006|4143699003|261009223027099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	U/SrjC54huzfNhqSAuyhczE+n9tuEBnX4cDCe7PknyPn5Jr9u6OeFLw7MkAIeHZRmaKGVGVFrJYLnHwfQP6tcTacS/HaEPZzO3m/qO1LX7wzcZXDzZPygfW2vlwtDPAr0vddSYU5P9zCh4KTID5MUkQuwHaZcsiMV6AsWbigWj0SF5H40brns0Yk4miv9F8UDI3g9SUyxTDx8dHHqr6mV7qZgLSVWHHfMVCbbhNTvs3+LclMi3orN/NtS0ovGuR/z6zM0lJNxoMqjVSDVjSngZ7B/ihoRgaIVjSJ1I4tilM+YoX4Jf3hI3r1WOf8SVXlLPRQdMTm1HUQ2uzRtjx2hA0dIY6OpnbiHJpk/so392N/zy4JBD3KXHC9eI7LfJKKIJhhf+mlGUddIOvJmzOSFa7otae0ZjW2AKTzJig+IXShKbNP+3RL+BAztHwA90gOq5fYV7kY39EdwakK+fKu9GLm7iWT/j41g0ArRHcmVz81Wk2UDU9RjpDasfx/XgRNfPXbgXzibTkVV8PZMU4nSHeRHYDfKBjMg7IgCipEFZbHEfJAu5HRrNmvRDJVBuYRQpTRsvMY0Vnqo9EKXJJDyjzmE7sPku0G4iT7SuxmrgCEFXJfEykIQNo5NssXD9CLcJGrc3OXd+0nYhSlmSFkkN9Cogm3DoT2EvEZlRsB7IA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(32650700020)(1800799024)(23010399003)(18002099003)(10067099003)(22082099003)(13003099007)(5023799004)(11063799006)(4143699003)(261009223027099003)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	He0iErNnaJ8HsFmb9iVFbz0G1XXfvSUk4l5a7iNECSBkjrIvKSkUzToeT/ObN5sDS3Ymx0DxGOZAL1RKFXYZ8QNqqBI4Z2EP2scSZ0iLx9i+4Kov5ntDKij8PYc1gJDmJNxty1W6HzIqYWZBHWD+vHDJj0QtGsqR7RmHgj/8DhSQNX3akezads1n/GGAsxeu6GDEMxg/PIMKb6Is7xTGQGrTD2Vd5vxYI/9dLHyK+8lhrKrtCsMXA5LZx+RC+dsKx1nNq1Ptm8IP3u3ZcEl53feYI6RYBki+I02DoMZVWnT2MpmZrmF7Z6MVSYlwmmY4kwYhiH2zcBFHZlTFTGFm2typi8XYLPOsz0ICH6iPxoyzEW2IvjAZPYxKVMriVDkT8WtpXLCCO4jpyu+EDrp4u9cu9Kp/LbGPWxd2SLlRd2gB9dl7ywwnDxI3INBuGD2T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:44:27.1889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0adb05-7601-4713-c091-08df2b50ec55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8010

Hello Wentao,

On 10/16/2026 11:21 AM, Wentao Guan wrote:
> Hi,
> 
>> Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
>> mode on shared memory systems"), shmem_init_perf() programs
>> AUTONOMOUS_SELECTION_ENABLE unconditionally, including in active mode.
>>
>> Platforms that exclusively support autonomous selection report this field
>> as an Integer of 1, as required by the ACPI specification, instead of as a
>> register descriptor.  cppc_get_reg_val() reads such a field back
>> successfully, but cppc_set_reg_val() rejects the write with -EOPNOTSUPP
>> because the entry is not an ACPI_TYPE_BUFFER.
>>
>> shmem_init_perf() propagates that error, so every amd_pstate_epp_cpu_init()
>> fails, cpufreq_register_driver() ends up with an empty policy list and
>> returns -ENODEV, and amd-pstate refuses to load at all:
>>
>>   amd_pstate: failed to set auto_sel, ret: -95
>>   amd_pstate: Failed to initialize CPU 0: -95
>>   ...
>>   amd_pstate: failed to register with return -19
>>
>> Skip the write when the register already holds the value the requested mode
>> needs.  Active and guided mode are fixed on these platforms, which report
>> auto_sel as 1, while passive mode still fails to load on a platform that
>> cannot disable autonomous selection, exactly as it did before the
>> offending commit.
>>
>> Fixes: 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Tested-by: LFRon <ronforever@outlook.com>
>> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
>> ---
>> changelog v3:
>> Include the K Prateek Nayak reviews to remove that ternary op base on current
>> condition now have.
>>
>> v2 link:
>> https://lore.kernel.org/stable/c3eb86bd-70a6-4bb2-8eff-b2a3c0817514@amd.com/#R
>> changelog v2:
>> Accecpt and tested the K Prateek Nayak reviews.
>> v1 link:
>> https://lore.kernel.org/stable/20260918054808.48999-1-guanwentao@uniontech.com/#R
>> ---
>> ---
>> drivers/cpufreq/amd-pstate.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 80d99ba1902c9..2d1f5292d1738 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -532,8 +532,10 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>>  		return 0;
>>  	}
>>
>> -	ret = cppc_set_auto_sel(cpudata->cpu,
>> -			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
>> +	if ((cppc_state != AMD_PSTATE_PASSIVE) == auto_sel)
>> +		return 0;
>> +
>> +	ret = cppc_set_auto_sel(cpudata->cpu, !auto_sel);
>>
>>  	if (ret)
>>  		pr_warn("failed to set auto_sel, ret: %d\n", ret);
>> --
>> 2.30.2
> 
> Ping? Nearly a month passed, anything update?

On a similar issue here
https://lore.kernel.org/all/851316da-2cfa-4a22-947c-1838532d05cf@amd.com/
Mario had recently pointed out that this might be a BIOS issue on
systems that may have MSR interface but running an old BIOS that does
not advertise the CPUID bit.

Could you please share your system details here and check if you are
running the latest BIOS from your vendor?

-- 
Thanks and Regards,
Prateek

