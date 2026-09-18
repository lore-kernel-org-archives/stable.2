Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB92E612E;
	Fri, 18 Sep 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721058; cv=fail; b=CB0nFZQlrEJcSGefj7+qYJtNAXTyKzP7UsNYKhXiqtTQvY2b/OjxvqM2kZFQt4J0lWEUwpUzZ9gnmfbN9bg8vZUM7FQy65MzJuwwA/+AYNBwtuQBFWYYixnlAw1TarAPuZ6Ft95fMVvoog6G3Fx1zg9b46Onhhy+EfbFVZbb/ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721058; c=relaxed/simple;
	bh=P7UFKyKrCT+s/ZmZvE6wTxRiAnD23PwwdSSvHE/ygSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lJ90NyBoVoPTfT2zyN9rhxXtSwhQ8OnhIShiSSF++t2bnNApGrB60o6gAteNiWHkM3pXHLspIk7QwdZPLRU2p49bRMIFe0QX/yFKLbGw+ImEdcC3q/z/zI+wAG7zX9hlbQuznZB55VZ2XiNl2M1O8fOVCZzPbLlRgyWeFn7Gd/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W4uWiEsD; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W4uWiEsD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thQeWAIH6zH3D4JbrDiC3TyovbvDC93ZFNQ512b3Lq9J5R5RRoFGCi4ZKCHUlTyFpCP3BpXj6jjx8k/XtBgpOLdNgd1o3qxtNpWx6z7rjUgatIZ4VNsWHP/E2ZK3b+Ctw22Q70cArkdOwHhpK1XLwc97C4bIuNaTGNiNN6tCDOx0FBkeK9uqvxq5PithvmfT0veVO6wg0GWizv6OYUBGZGVz6dxXgWiPJiumiYlltpFLa1lYAok32sB58fG6CdMTRVNKiymq69+Fk9yaevH3+bw2UL7ruhZM4tkK/UiGVVs3ZF0tdXa7UP5fiw7CJ7LmNXubGCEN3XRVn3oYanUBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IslPIjK9tlfDlBGWHkEF+/58qN2CSPKOZMus+bFazJM=;
 b=ypexAciBFEYKF72judnO/+5IUMkGUrlg5ews3HPn7YCQrr8Yhm53/fzXc0oZ1BsJ32nXDIE5Ze6GGc8s+i0FUTmlDK7IQb1jB2PuttSiFY78aKAv8Z+pIxxid2zS1og0en9tyDgy/GzoYNK5hnVcY96PbyorhIWZLcxrXABMZCRD4CW5Vswe24GGoOmtbez+wZbVymhxi0WAgFTQ2MKG3uLzyHLDVtwnFIEfQ3BcZmJbens0d6WubrsMireA+TOn7ld2cZciLzMYgKuN14GvKs2mh11xOUm0FD1WnaepsB3x1Oz2qRxzIfZs8ySZCFsZPsCiaWimfSbe9FhrY7016Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=uniontech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IslPIjK9tlfDlBGWHkEF+/58qN2CSPKOZMus+bFazJM=;
 b=W4uWiEsDUD6Uh0PwVl61mTCs4NmnqR+LYonhd+gP1sTbV6e8jveW4I/IP/xTkfXx9MZmkUG1uTaSlbcsIMQQZQzytLWP27wUXEg13EqOz9Ri9aTGwbLZkeuy5X7i+lH/zivYztP6e+RJQGuNe0icBOiTjTEIIKnOvphGs7lowG4=
Received: from PH3PEPF000040A1.namprd05.prod.outlook.com (2603:10b6:518:1::52)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:44:07 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2a01:111:f403:f90f::1) by PH3PEPF000040A1.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8 via Frontend Transport; Fri, 18
 Sep 2026 08:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 08:44:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 03:44:04 -0500
Received: from [10.136.41.131] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 18 Sep 2026 03:44:01 -0500
Message-ID: <c3eb86bd-70a6-4bb2-8eff-b2a3c0817514@amd.com>
Date: Fri, 18 Sep 2026 14:13:56 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Skip auto_sel write when it
 already matches the mode
To: Wentao Guan <guanwentao@uniontech.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<ray.huang@amd.com>, <ronforever@outlook.com>, <scardracs@disroot.org>,
	<stable@vger.kernel.org>, <superm1@kernel.org>
References: <748cb8d6-174c-4cad-98bc-ebb985e2eced@amd.com>
 <20260918070814.59582-1-guanwentao@uniontech.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260918070814.59582-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 587a407c-0bd9-4388-4b8e-08df1561001f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|32650700020|23010399003|1800799024|376014|56012099006|11063799006|4143699003|5023799004|10067099003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hO6Or1fTUbt5vSSDxYE9HSnXE+m7MfaG4d9R8ob9VatxLKZMp3EYCGFq05CES80ghuT/pQKhrtUTekczqw/ye7+uPG/is7AcKMbnrRdxe9qdHB9oLvTLkJnRjpMGL2HonQtosEejRAUr2kKdkSZf5+91oBKfeDufqxNXDIp6S2K8wJo+cKXC89VCAokgUq0w2Wp/I7miYYcnJqlnnDKMoRT2ZLasAZGKJUkgzoLk5nx+RvlhGgg093N1I1ZbxsYdHDiCaGe4jnVNPc7Lf2oLhCQGtUuPOE8Wo8qQhEBk2A7+0fUjCt95Kdc4ZsXbb+/d96uxtkW1Oz0yd9e5IUWcpYeFDUrlhEFx2D8JMw8GiXIH0GUmuIEO9RIqVtnjBAksPpDsCOAKGb/E2JSIwd8ENAou8WSGC6Glxri/+0vCNyLC4hWz5j1L73grNTYodqcHEX/vc5iWsLKHeNJIAwpkYvy8Cy9xhT5tH/yhwOdFgFAhZEKpVAagEucM/Lt+gRtuxw2aKoHTT12VVZ6UqB49jxQKESg4xmPIaQjrVHxuNzhf4090W0MqPp2XaeRyVVchsI0Q6QwqR0qq1fqKDk8zTTdW0N/+4Nvml7tZw9oWIKoDc+ekuQAuQhHefW5GDSUML+vbOx2Sqg3sU5bTG6PUCmGKfgzghpJq4V6UFJcRlFQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(32650700020)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cg6ZSY6gyE1Q41rp8Mb6pJVnVwz8x4Hu7Jz6BWs6Sp+W5ea+WgypnthOlTYeZV/Y2B+XgcemfcMAWD9HlZvRWy8wV550C7iHZVBbNXDwTOQ1lNTxHSYX9+TPMEfzClo0mL23jJ360YjEV4aoX7/W0z2RpIptHcDReI0pc6Y2EVMonmtJEVnWbidoQayu0QrA0bs5sOAZZVXEhJJXwj+iL+7VZ/2HNQt6ONe12J+pvebzYL6zh0FDq8lDfUuk1UUBLblS9WooHzRgsu8NJC0xMKFw2kCkJOQpge//sJNXA8EFe4mD5lasuOyY6ZDFakmhf2XDr6WmBqRoCBmOuNQb8JJW/s1PL38hzIFSTh/AcVfkrOyar9rpP4FSKveDpfw3Acjrc6ZOGM5lvSSr0aaVTWqrdzqwVKMYDYjGVECgVXNM+iAXRqGIWWJLZj0MrKuA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:44:06.7303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587a407c-0bd9-4388-4b8e-08df1561001f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395

Hello Wentao,

On 9/18/2026 12:38 PM, Wentao Guan wrote:
> Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
> mode on shared memory systems"), shmem_init_perf() programs
> AUTONOMOUS_SELECTION_ENABLE unconditionally, including in active mode.
> 
> Platforms that exclusively support autonomous selection report this field
> as an Integer of 1, as required by the ACPI specification, instead of as a
> register descriptor.  cppc_get_reg_val() reads such a field back
> successfully, but cppc_set_reg_val() rejects the write with -EOPNOTSUPP
> because the entry is not an ACPI_TYPE_BUFFER.
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
> Skip the write when the register already holds the value the requested mode
> needs.  Active and guided mode are fixed on these platforms, which report
> auto_sel as 1, while passive mode still fails to load on a platform that
> cannot disable autonomous selection, exactly as it did before the
> offending commit.
> 
> Fixes: 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems")
> Cc: stable@vger.kernel.org
> Tested-by: LFRon <ronforever@outlook.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

You can flip that to:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

You did all the hard work to find, debug, and test it!

> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
> changelog v2:
> Accecpt and tested the K Prateek Nayak reviews.
> v1 link:
> https://lore.kernel.org/stable/20260918054808.48999-1-guanwentao@uniontech.com/#R
> ---
> ---
>  drivers/cpufreq/amd-pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 3a6b4b224a66d..91ec44f9fbb96 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -535,6 +535,9 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>  		return 0;
>  	}
>  
> +	if ((cppc_state != AMD_PSTATE_PASSIVE) == auto_sel)
> +		return 0;
> +
>  	ret = cppc_set_auto_sel(cpudata->cpu,
>  			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);

nit. Now that we arrive here only to flip the autosel value,
you can just do:

    cppc_set_auto_sel(cpudata->cpu, !auto_sel)

... and remove that ternary op.

-- 
Thanks and Regards,
Prateek

