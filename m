Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64145198C;
	Fri, 18 Sep 2026 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709623; cv=fail; b=fG0PVLDHYZWFo79Jv5IsDTCJ2YP57WQ2OCfikqHeB3JnDGi9aQLTmH0pSLjcSUAhccsItimIfuB5GmyTqASE5l0RglFdu8kwgf31Gv11NRk4sA045Y5bb2tmD8EUDEhDMO3I2RU3VjHcACsOaiQrT9nV2Qvk9G123uwQDB+aep4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709623; c=relaxed/simple;
	bh=hhT+va5RYLbGzyQvlv3dkCarHsDGYBt7tOuyVjx8IH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o2T6ZQwQO9HdA/qjO8ynC1COHfHvJIEHy7BiXolJ5HIaY0zHhIdIrqbM9w5e4dLiA/SxMVysKhSAcWUGVh+YCibywOdwGBqi2c0xjJfhGrCWfZbpBMSto0QD3Ojn46L0u9fG7pzX/OgmGR++SVtp8eN1IrTi2ci067B9hs0nyL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tojXxHIa; arc=fail smtp.client-ip=52.101.43.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tojXxHIa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRq5UIfEYIrys5wTZ0pVqczZ7G07OF/4G0yP/iV0mzXtX9AuMWQxutz/GXp8dtoNpc438zkZB5NXmKWQ6IVZc7rnYjnXCjetOd5GM4WjnL1blOKSjeKgjGgeeEbmJYlBMGQtuSEflfCVzuodsSEtwlVRfTmb0TMN24yvlsCljwRyA9cs3sasAIIJdIoVMhDN5xjZoDlf/xhcadIF51c2VLjdnyisnJjyU2xnC2Unn+++x1ljK5Zzj/x38XUKgfBgsvhFF32XWRyCC2f4MCfUj7lcXA+SK6geLmWyyJnv2+kT7KQluAyWjbA4uABZPepHyQ5M92TAQ+LGk4uFxmb98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHXmWbtSXhfALPJrlduvJiaVz0lxEIOLT0p+Iu56pjc=;
 b=kIZcXZSVu1407+gmJugyNvnfjlosNSYV/7tm2RnrWaut7ED9ySmaQ1NVXnej4vlIKsL2BSEEhkbwzGWgQsRWdHTlDNll1Wf+odOvodFpr7fUI4zjahmMsLuZg4L6jIezUXU7qs01xFiYAH8YNYGHcqinwNbu4wYV3GUYUOA4SzaWtO+PIr4N4kPpVCsK8nWWPjVlkE/SXaQldazUu6uQ0UH69DCLP6ZPHnJkv1WB7ptz4ND6/G9e90swARvrPYf7gcZoB6RqGYinRu/Iy79p79a4XZoquYLcwab/mONZ8neAB8XpMsQ7h9+i02H4xxn287msb5xEIbTXYnQF9amVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=uniontech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHXmWbtSXhfALPJrlduvJiaVz0lxEIOLT0p+Iu56pjc=;
 b=tojXxHIatO0JKUF5VWU3o+A3yBSBkgSKeCsNmocPKeNPKZf3LiaGic5oiJsSyLOwOeBmi/fzmx9YggaRrxljFx1wlHOMrUqDx0p2yzLoC1g9WQaC8qr1HwTAGaiC31VqwJ1TbnyhPyE58qsLm7XwvbtLdrZnfxiUGChjGN4khh4=
Received: from CH0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:610:119::7)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 05:33:39 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::77) by CH0PR03CA0373.outlook.office365.com
 (2603:10b6:610:119::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 05:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 05:33:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 00:33:38 -0500
Received: from [10.136.41.131] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 18 Sep 2026 00:33:36 -0500
Message-ID: <748cb8d6-174c-4cad-98bc-ebb985e2eced@amd.com>
Date: Fri, 18 Sep 2026 11:03:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Do not fail init when auto_sel cannot
 be written
To: Wentao Guan <guanwentao@uniontech.com>, <superm1@kernel.org>
CC: <ray.huang@amd.com>, <scardracs@disroot.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, LFRon
	<ronforever@outlook.com>
References: <20260918044215.41400-1-guanwentao@uniontech.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260918044215.41400-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d646fc9-ecae-415b-4322-08df15466497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|32650700020|1800799024|23010399003|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a0q8svRk0sgz60qTRu6x8vqPJgpSR2rMyiB5+3qk2qmvqZ37Gpc8NAFEdvFHzBvUt5fd7wmAQa/3Shv/DwgofpwUAuIUCeYq578w4HStLsHVLSLPyGz/HOCulnBtnE3oMD9+qS5h0LO1CkamXPpz72OooCxYQN5cMpOlp+FACznGliXqAC6BbTXIYIUCp+QcqZOob2f4Q3ks6rL8GdIKgWjMfltzC5SLbwWtGMH+OmCoGLweb+U6HZ5/oNkKbOqOdSDi6f9LEcwKJif31E50wfFnsLgSiO9eTpExD64QLsWNt4ff1c8t8lQQorW3WV/Q4ASlVz3m51iWTdRAW9qBTVwobFb/A5HKkJm6xyviYbWsuwOWVZOMn0bVL9gXP/HOkxtc5dfVKIsVcsX6mCojKwzcSlaXIqfwmiW081+uypY/PEPwE4qedfHoabk35s2mOsErTTg0P6RBsXNhAy2yOXx8CCFJCtP05aQLqsKD+7A56D2NuvJpOU2yUE6BcrCx4ebzD4uDV+oXVl/dBFubTGpbzw/lbqA2isRKK9ldBvgdifcyVjZ/gbUxsKyusnMUmJqXy8zOOTxrQLTw9R49BS8KksfMzg0sAlnW1UNkCKoF03JzfvgI4AVSC4ORJQ/nxC6mymGH0ea2kAS2xFwIReYLCQcWSZT09qBciGcP6FJ6v3oKleeo8AzO5+qH+3plMqsBk9h+/pxeZI2ewd/qCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(32650700020)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zju+8VSWTIWIpXaFzXEx7JG39ESw0iBmGZlMcCJXluFlASUqUdcvPPytW45UCIRpIM2jI7uErPz+FVfBflE76Wsf62rctSYZh15mp9UYvPj2o1H6xkSnGhMKlgiBVPDdZjjK5/EaBXAMi346TpHmDiYkBloCV9IPa3OZ6W6GOkXTY6P64MVFzv5CSLWKz/b8FZxNiibDDjU7CF5qEyXLnPteBCT12/fVB3EFNexal7fonCVTJ3FXKEFQE7RSUsrS1Op9HDBiJf6T2EFGDdLvN9Fr/yiijKiJ2z9CNhJboYxlmvGSW/oGHOZRuxe23+ryl9I/vHxrAUv3zqRjLHly0jdaZh6OQb43z/5utE7JSZ6YmL46iL+h/ydLwK3bmZ/FqXjmHsqjffX1BDTTXZ0ur9k2Z4sbtfXUtREpgPgBLPv6omfMxJnNpnYJN9CytQuZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 05:33:38.8804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d646fc9-ecae-415b-4322-08df15466497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558

Hello Wentao,

On 9/18/2026 10:12 AM, Wentao Guan wrote:
> Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
> mode on shared memory systems"), shmem_init_perf() programs
> AUTONOMOUS_SELECTION_ENABLE unconditionally, including in active mode.
> 
> On platforms implementing CPPC v2 and below, _CPC reports Autonomous
> Selection Enable as a plain integer rather than as a register descriptor.
> Such a field is a read-only capability flag: cppc_get_reg_val() reads it
> back successfully (the firmware reports it as enabled), while
> cppc_set_reg_val() rejects the write with -EOPNOTSUPP because the entry is
> not an ACPI_TYPE_BUFFER.

Ah! So it is one of those platforms that fall into:

    Platforms that exclusively support Autonomous Selection must populate
    this field as an Integer with a value of 1.

as per the ACPI spec.

> 
> shmem_init_perf() propagates that error, so every amd_pstate_epp_cpu_init()
> fails, cpufreq_register_driver() ends up with an empty policy list and
> returns -ENODEV, and amd-pstate refuses to load at all:
> 
>   amd_pstate: failed to set auto_sel, ret: -95
>   amd_pstate: Failed to initialize CPU 0: -95
>   ...
>   amd_pstate: failed to register with return -19
> 
> Failing to write auto_sel is not fatal: the register is either already
> enabled, as reported by the cppc_get_auto_sel() call right above, or not
> writable at all, and active mode worked in both cases before the offending
> commit.  Downgrade the failure to a warning and let initialization
> continue, matching how the cppc_get_auto_sel() failure is handled.

Can't we just skip cppc_set_auto_sel() if the auto_sel is already at
the desired value? Something like:

  (Completely untested)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d4ff8b228f86..ed540da818ef 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -524,6 +524,9 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 		return 0;
 	}
 
+	if ((cppc_state != AMD_PSTATE_PASSIVE) == auto_sel)
+		return 0;
+
 	ret = cppc_set_auto_sel(cpudata->cpu,
 			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
 
---

That way we fail for passive mode switch which will operate under
incorrectly assumptions since these platform only supports autonomous
modes.

Thoughts?

> 
> Fixes: 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems")
> Cc: stable@vger.kernel.org
> Tested-by: LFRon <ronforever@outlook.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 80d99ba1902c9..3657c5cccd4d8 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -538,5 +538,5 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>         if (ret)
>                 pr_warn("failed to set auto_sel, ret: %d\n", ret);
> 
> -       return ret;
> +       return 0;
>  }

-- 
Thanks and Regards,
Prateek

