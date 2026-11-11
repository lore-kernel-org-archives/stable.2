Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794384763;
	b=FFn4VOKbQlUoZABhMrf2MNL+UtVPYkdXtX1lWPdLjhrypcZEE99R9LSZgSEdJUc7MJnU
	 EwYQKYXlsDSLnqT8N8D8/Lyv09Vyrda+0XK2YlZh3B2cZDsbBrWfrusO5IDErGHCPwQ5L
	 IErJ/LVFbHnLQwCNPIECvNG/ZidpVjFWF4G9EW0EdZNi8yOXZMBb1Ykej3RMh3zZq4Cdh
	 UtGSB2iztQveoDJc/vxwBGuTiwKs6q4e4qI3hHKQOPhwjY4prm3+3aomTyDWN6XnBt07e
	 bMaauTP65vIhe7l6aztnaB0hMpvULzv8bhbfLRuwUBrUY2q4akGgDnW+wXdvzl9xr2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384763;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/vZB5XdxeB4EY+soJGayWU7FAog2ncss+mnGtuOg1Rg=;
	b=Xaz733SU5eujAuFpkM+CPwGFJscOTIUxHVBoh9L7OE/LeyfpzDOewYwVByj+J2TbPtA4
	 P8ju/P+tGUCnrJqWo2aTAu0gzlMPNJsebonGTEYilfCU2ZinOm3VxFUSlmfxLSKps8pEx
	 CK61L1E/opJbPdKWwrA4W1JYym8DdCSyev8uwi7HDfR4/tjMo7RJS44F57BiFDmLArW5f
	 A2vtyMkS5wQrYmSMlviwC8Lxv3k7EZ8ZMqMAHyjdhz6qxjSOKjEHx8PHUQkVIDBkz66F/
	 8d6U/lifeKS6S2pUk+jT6OGokHjWpKEKjlPd87+MiOvJQMuxhSfT1se+7LPJOweev5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=H1SRbmcI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.47
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535EF606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 535EF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=H1SRbmcI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/zpfQZvyxK3ueK15dsUUhNoybQRK+gXAoErxluarHauv4eg0GseJGM8hdKu+ESrwAZweP8XtBKiG4AzYnsg/0lVY2Rygbb5sA81bPUSAkEWHVLmx5Tyfc5zTJT1BeISYhWZWrDEg0BpPCCL0Lgc2z+D73CiTE2LbR6xCKJkp6aaRGdBePeURASxKGYzD1emSh/DhGEGqLTm6M876vUSbVUoqqfxp+TkeCC61c52wbw0PswTUwVyB6AVwf0FhKnjmHe8S/fbvX5PNMksmVvlQ09qTX6A5A5u+SWP3gLgpqL/7CSQWVa5AQd11fwVynMnrMlGOXGZukMn8lzuxHQZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vZB5XdxeB4EY+soJGayWU7FAog2ncss+mnGtuOg1Rg=;
 b=hEjBUX5rj8d+OPychIiPEQXZ33296Dn8tZBNBItFOAAM0gnJ6fWMxHu/StAwTKivp2RP8ysnYTy3OvLcJt5ybt+VW5E5Q3Ol6Wzgo2QBZdg3XqF2lRHQlGYZdWMMdTgXVvBNWkqm/wPnG6Ebs65wZn/EbhFoVlfVubu1JS+ovWE4uw1ylQ/cNNb/1k6FGwQJL+/QYac2bAU+g8v5Lqm5VsYZ5F5/Kw7go97MJ6oE4TLL7X1IxKZhqmviWizH0Nt4ccvkw9HG1AV2lzLcZzwqUEaFEZkKAAH9FlN/bKyVBrE+mj4ONY1k+Q6wf11K7aPMVoZZpEodwbhhGOuUygNzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vZB5XdxeB4EY+soJGayWU7FAog2ncss+mnGtuOg1Rg=;
 b=H1SRbmcIDZYDBY396ZSLTUHoSS4yI1LJeVdCd4y6DszcLXU4G3+9Xx9Pd0d7WVhgbl4L4hOqcT7u2nfNwof4k308IT2OLXZVxX1ETK5+tw85TS+rTFL4wuvccqB21c3EECSQhJTABn3h/LAmGHiKkvp8L+k55hZedRVhd6y2LOA=
Received: from DS7P220CA0099.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::18) by
 CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Wed, 11 Nov 2026 08:12:07 +0000
Received: from DSM2EPF00000011.namprd02.prod.outlook.com
 (2603:10b6:8:25d:cafe::7e) by DS7P220CA0099.outlook.office365.com
 (2603:10b6:8:25d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Wed, 11
 Nov 2026 08:12:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DSM2EPF00000011.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:12:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:12:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:12:05 -0600
Received: from [192.168.1.149] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 02:12:03 -0600
Message-ID: <23bf3075-2cea-4daf-b38f-418844878815@amd.com>
Date: Wed, 11 Nov 2026 13:41:57 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] iommu/amd: Skip non-IVMD entries when
 parsing IVRS memory definitions" failed to apply to 5.15-stable tree
To: Sasha Levin <sashal@kernel.org>, <vasant.hegde@amd.com>,
	<joerg.roedel@amd.com>
CC: <stable@vger.kernel.org>
References: <20261109202457-failed-5.15-e62df37e0eff@kernel.org>
Content-Language: en-US
From: "Jindal, Akshay" <Akshay.Jindal@amd.com>
In-Reply-To: <20261109202457-failed-5.15-e62df37e0eff@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSM2EPF00000011:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e017466-85eb-4729-dbcc-08df3fcb7a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|22082099003|18002099003|6133799003|3023799007|13003099007|11063799006|56012099006|10067099003|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261022113327099003|261021123027099003|261022075727099003|261022105027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	6QThxS6RNL3g/Mm77QTfOOXm/niyzwiYnSX5bJO9u2DBpL8EYjetQIJfK+NNtU9bxuycc5swljaCTgzhcO31n/zoCztI4B+72ZFI8AQU4Qdnqd/+zA8/XLRfJtmj5d8uFPyYzZWUQhrG7KbkTZswD5uGHnrWOEUZpJ+l6muqKSvTJDbOkmmTyZVje0PPJwfMvh+Em4IyukE8cHJ+luvM26CG94X8QS5nrKTGTpHb+mhSduDxixsW5xD3tv5aPNnf3JImZM4qZ1s42tM3uSR300Nw0xZYJu+cQ1/69UJTMRe5kL7m1jJzBDgib02FPF4czhJX9frjp64PdzV1UYMRGGfils6WoH7EcB4qQ5qFgF7NUHc1qxYWESc9Nb79xPFtSSTqf9z7FMl2hw4+YQjmUxSKywQCB+0lHQawQm5UIMDyV2GSkWXCUDBsLTIaAgJnouAV3apsehJQuw9QsyMEzKxms2+A6WjBdXGi+QB/C9/SezbWm4C3pXwqIXB1lp1jge1izbRx/cx0iYAb1/FeqdaTizuIW4s/ns4mfraF/reEIetZ93RnEeU1h8J6bvF0bjYdN18/y15qXTRIGaZinO3yS1h33h6kGQvcwqHV5b7/qLr7hcFuNCs5CzPLdBF3ADTiJJWwxP5jshCccnLk2/qTQ2JQUEJMBSXZ2aTbU1c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(13003099007)(11063799006)(56012099006)(10067099003)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261022113327099003)(261021123027099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5/2IEhmwPWi7FtutxSsIh/Na4uS3QESxm9wK+3zI4ovop8ePVt1csS15pgNTX6CELfIt/Ij8i+Ds2KCP3dnnZ/LHal4/KdImCwdcyBB4meK8g/tcJ8voJGW7lWWtWj1vKaeXaETT2M9fy3DNZ5fMbiGexZD92Ac7g7HCQ4iO0n7TIGl30sJkdQBgE2GiAO26pGQFU2hw8nC/3Sj7w8nrtv2Bh4lbngE8CjhuRW8xGzWl94shcBzFnfCsVCSDgCnHu3wyNgr5vGGSMkmRdZk1lXPUx0m2s/nLYCIOpVEitV/L1CYy+/236DTNLpRNTBQBtCqJU7GyVs/9TokId8spOT+GApxBwTejgnMPwsydlnZfyGmgLjoG4xCz0sp5l1jwgwmM3k18Un54PqkW+WxSz0s5HCjjNA1NVkAIfXrIE4FSMWcvHNewKfE2P/qbHZAE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:12:07.4923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e017466-85eb-4729-dbcc-08df3fcb7a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DSM2EPF00000011.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870

Will send the patch.

Thanks,
Akshay

On 10-11-2026 06:54, Sasha Levin wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x e62df37e0eff4d670e78bbd415be2c1675883c15
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202457-failed-5.15-e62df37e0eff@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'
> 
> Thanks,
> Sasha
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From e62df37e0eff4d670e78bbd415be2c1675883c15 Mon Sep 17 00:00:00 2001
> From: Akshay Jindal <Akshay.Jindal@amd.com>
> Date: Thu, 5 Nov 2026 16:32:17 +0000
> Subject: [PATCH] iommu/amd: Skip non-IVMD entries when parsing IVRS memory
>  definitions
> 
> init_memory_definitions() walks every top-level subtable including the
> IVHD blocks (type 0x10/0x11/0x40) in the IVRS ACPI table. It interprets
> each one as a 'struct ivmd_header', solely on m->flags, without first
> checking that the subtable's type actually is one of the IVMD types
> (ACPI_IVMD_TYPE, ACPI_IVMD_TYPE_ALL, ACPI_IVMD_TYPE_RANGE).
> 
>     if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
>             init_unity_map_range(m, table);
> 
> IVMD_FLAG_UNITY_MAP (0x01) occupies the same bit position as the IVHD
> flags field's HtTunEn bit. Unlike real hardware, QEMU's AMD IOMMU
> emulation sets HtTunEn unconditionally (flags=0xD1 for type 0x10,
> 0x11 for type 0x11), so every QEMU-emitted IVHD block is misidentified
> as a unity-map/exclusion-range IVMD entry, which subsequently results
> in the creation of a bogus pci segment. Eg:
> 
>     AMD-Vi: PCI segment : 0x4000, last bdf : 0x0000
> 
> Fix by checking the subtable's type before treating it as IVMD.
> 
> Fixes: be2a022c0dd0 ("x86, AMD IOMMU: add functions to parse IOMMU memory mapping requirements for devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akshay Jindal <Akshay.Jindal@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  drivers/iommu/amd/init.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 78c7079dec9d6..3dd4ff145e552 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2776,6 +2776,15 @@ static int __init init_unity_map_range(struct ivmd_header *m,
>         return 0;
>  }
> 
> +static bool ivrs_block_type_ivmd(u8 type)
> +{
> +       if (type == ACPI_IVMD_TYPE ||
> +           type == ACPI_IVMD_TYPE_ALL ||
> +           type == ACPI_IVMD_TYPE_RANGE)
> +               return true;
> +       return false;
> +}
> +
>  /* iterates over all memory definitions we find in the ACPI table */
>  static int __init init_memory_definitions(struct acpi_table_header *table)
>  {
> @@ -2787,10 +2796,11 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
> 
>         while (p < end) {
>                 m = (struct ivmd_header *)p;
> +               p += m->length;
> +               if (!ivrs_block_type_ivmd(m->type))
> +                       continue;
>                 if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
>                         init_unity_map_range(m, table);
> -
> -               p += m->length;
>         }
> 
>         return 0;
> --
> 2.53.0
> 
> 
> 
> 
