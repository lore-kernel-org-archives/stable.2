Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2503BC687;
	Sat, 10 Oct 2026 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610015; cv=fail; b=ons33H7NJQTr4sPNoiwYAk7EmUy5MtoSPZ+BvWzHcB0fREY7el2B5u+fZ1WDzd6NckaaLurYF2E3uMa8wE01znqoeQR2RMOsoOw4NmvjLUYUTTxGimzd5E7xjRc1WS6U4QpHkfeih2pidKuWr2slA17pgPkByjNrUX9/Vqh8pgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610015; c=relaxed/simple;
	bh=1goldK8kV5P0B6jiu+02+PIMhjx2lcAZ+/r8X9mvwu0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFj5omg5TV8ffOgW0P9gfKKIphdzJHExMZjPTro0WfLHUNs3tiJtMvt18HDXMWMoW5b00Fd0zm5Np+RZ6u/YuQW5A46Z8gj9lpVHHbjsEzoycFz3/iVWHxVUndqGZ9YIAi6kxijEMu4CQoWxgrZ8Vwg9N89BfJfvHJxbT2IkA+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZxZ1BnvF; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZxZ1BnvF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jhjyy+zPQArqdKWNA5zevz15O6F2QIg2inpQQX24hUhZ/BbpysT6uzsVnmZ6SaJgWJsPSgPxK4WED/fx91VDDB0KOdvmy+kUfy3VU9UJp4OhM9JqI1+lEbgq4Q9NPE02fnRvossl1FM0/y4HCMDDS/CD14mNm5lS893hsoJRPY1QaBp0pO6AjI8YD28otzxVR8DDgLzk7I+SFlwYnBBCnAD77Qm0GW5/xRH2WXjFpmkZsX9OAF/PbOGzEsEBrIJLLJwINFx+o1d0grpejOjnYi+CUIWI8i7q9E+pJYljoHFHRI2zzISpZan5kvQw0xGroSGoQbHqGY3wZZ0TYUIDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eF5h7r1Ne+8Fa4YaprA4tr5Oh1DbZb8eL+7txFXNk8=;
 b=eJh6UU9Jgik+20Veo7+8vh3LpvnAh0Bmq0QSCUCz3+je0xQvRPN7Oobj/Y9hTTn29XBWGvbpTNrKe79Eo+QnrB9zBpd2VsTlKPQhM0RQrmDHlVLaiWozlsoCZ7lNT/rpKOwlERAStGLDhYze/+WNqEPR2VYOLx7NlXjSN7VqkHkX7DeZJM81uOrip+IqCKW3G+W4HfnyWb0oUKzv+/5oauYyBYAsrlNbGf2Qza7sCwLL7RgwhMfgE8zUBKXM1jjmXI4pnYBnOsRAvP7EoLMm6wSOHJH/dJyoiGdtVHP/lmIe0At212NiaphYZBfPa/3WZzDrcnnV0AHFetDHEBk+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=readmodwrite.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eF5h7r1Ne+8Fa4YaprA4tr5Oh1DbZb8eL+7txFXNk8=;
 b=ZxZ1BnvFGq1r9W2F4hZd4t9Ijz95TeAtL1bg3ALArmmm476bM6ZwXCNrDRYm4h5VVwUJTG8fYakR7VyNgpXW0QrviSBN+2x39AH/O93yoRsE9XsQlXxmBglA0RV5psr3w3Dy9jTp0sLWsysKGxFzDBuazRQhhA4LBdcdPJ3/7r4=
Received: from CH0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:76::26)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Sat, 10 Oct
 2026 05:23:52 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::54) by CH0PR04CA0021.outlook.office365.com
 (2603:10b6:610:76::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sat, 10
 Oct 2026 05:23:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 10 Oct 2026 05:23:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 10 Oct
 2026 00:23:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 10 Oct
 2026 00:23:47 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sat, 10 Oct 2026 00:23:43 -0500
Date: Sat, 10 Oct 2026 05:23:39 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Matt Fleming <matt@readmodwrite.com>
CC: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>, Baoquan He
	<bhe@redhat.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <kernel-team@cloudflare.com>, Matt Fleming
	<mfleming@cloudflare.com>
Subject: Re: [PATCH 1/2] iommu/amd: Program device table when kdump reuse
 fails
Message-ID: <lbwkxwguxaoq3utgmqkre2x4bsv22tvuvrwwdbhhhrwznht2dw@6rbtm3bwlydl>
References: <20261002133143.3628181-1-matt@readmodwrite.com>
 <20261002133143.3628181-2-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261002133143.3628181-2-matt@readmodwrite.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff0c8ec-4b3b-42f1-788a-08df268eac2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|22082099003|10067099003|11063799006|18002099003|56012099006|6133799003|261009223027099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	FTP1Oq+0stMLJpOIH7D7FAkX3rsuEr2qK3RMzo70tN8MypJXQiqba0tbitYcDwb6nh8HZSR5oLl5dlcH9bQivzaDnAU/DT51dvu7r9JNScLhtLwq0FbuRs3S39ZWMixmZHL6Whnlb87JxwkBgKL0ivBez2VFwIHYlNKG+xwS2DyxrQ00HdHqlnVMennZq24gYP9Z9+q17TM/GiT2Gy9VGoN4uCx6it5Y8plV3fT1q3bFU12zGlLqRPfU+tcAQONCM13ticaDh7PAPBVGhMzd0vcAXOBzC4XfLItCJ9r2yoK+oqW8BgHwmx4/xbreg+WUdMXDDlG75pRm6LHwTVuAzgYdLbyJGDWky/rPQPCGetTCB8N14P4oTniomdpbQLZfJVrj4J1uQPVKPV9Ye+3MJV+VKYbg3w/+/JObLcrCfRoYaaJ6s5MciG5wdA5blegg3Hkl77rLZH3qjJP0lUfBbBLp1ZSikQ0HwzQqg5IFkUnnOaE0aSiXVJj0pHQSFM67ATYETuHFpU7kPyEc41ce1IOyTUoZnud1Ju7lOyUGwD1LI/9Q0CRReTZPUSG5kqYgxqTACQTRgKkENZVuJowlBORP6t4R/6a9hRVSHzn4MCx4kAkJzY1h0yesLBCxN5n3yznww25WiZFhP9w1WW3RHVhXY0P00M3WflZJ58m8As8DdvZEgDi2hTLI1mvrOOQPeoWr1FQUulUlMpxWFz1COA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(22082099003)(10067099003)(11063799006)(18002099003)(56012099006)(6133799003)(261009223027099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y/vPBvKNccQBYbUVsZy9W9+6HWX+aqdcVglEqzrmLaEa4ITqDm2v9MD7iFwT4lBMrEnTlrcIT3ijW4ofHl/+1R1P8hkHYifyefTxF92O5C5Salc+JbJEYZpResf7W13nZp+S9IKUUYh72HaECelFs0v2HpCtkwXTKP8C6JW1kcsvk5rNNWamTrQjQr/mIWwFIDxenm8R1LPwqcyvqyNxNe6UaAGNVLVhN6Z6l9vNhpR7xSZr9KBYqJyUp3nDLYJy3rrU7HvuoLnhD5N6CBsaPDVm5lXBKWgwKApHA7Ag4P7C867kME+yNQZCJTBr1+5XkwUQKB4i6UWdRhkeEP0pHIEwaJQkIsBXElvIA/ukrFg2dXNaXIhFmDqEJoeEO4qraNm6TI0rIygB6EEvHIQR2wRu7+YLKrgeGPh6Wll7ROfHPUEm3fjEj0cq3+nIeG3j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 05:23:52.5208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff0c8ec-4b3b-42f1-788a-08df268eac2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731

On Fri, Oct 02, 2026 at 02:31:42PM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> Commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump") made
> iommu_set_device_table() return early in every kdump kernel. That is
> needed when the previous kernel's device table is reused: the base
> register already points at it, and on SNP-enabled systems the register
> is locked.
> 
> But if reuse isn't possible, early_enable_iommus() falls back to the
> freshly allocated table and calls early_enable_iommu(). Because of the
> early return, that table is never written to the base register. The
> IOMMU keeps using whatever table the register pointed at before, while
> the driver writes entries into the new one.
> 
> Only skip the write when the previous kernel's table was reused.
> 
> Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
> Cc: stable@vger.kernel.org

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>  drivers/iommu/amd/init.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c07c3a01b978..0572e1a674f0 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -409,7 +409,13 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
>  
>  	BUG_ON(iommu->mmio_base == NULL);
>  
> -	if (is_kdump_kernel())
> +	/*
> +	 * A kdump kernel that reuses the previous kernel's device table must
> +	 * leave the base register alone. It already points at that table, and
> +	 * with SNP enabled the register is locked. If reuse failed, program
> +	 * the freshly allocated table like a normal boot.
> +	 */
> +	if (iommu->pci_seg->old_dev_tbl_cpy)
>  		return;
>  
>  	entry = iommu_virt_to_phys(dev_table);
> -- 
> 2.43.0
> 
