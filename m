Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B9417362;
	Tue, 11 Aug 2026 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483449; cv=fail; b=u9rzRfn+MqQK1TKs+BesKD4zWNcmaOUcHCF1EHOerZ2OwgtuwmLcGKyAJccQAMWUwJLbhXXOD/hatLre9ZxIHCXZmagSHeNPGXzcnVNWwVPRFadQ9KTTX7DNncJ/+u2legrE7RXiZN/sRqRQOP7v4NGFjitOMm2tZG1B1uUaR1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483449; c=relaxed/simple;
	bh=udfbd5bgkyZZUwcp2W2evG4bIg0p6jt0KKxUQq/u6tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GgT4sk9t/QS8YIRyAa5pRCYAcRrulSIhshBnEGYhhD2+aPojdu0JBx4Thh3fxGHzqtj69BEMSVjKa4/2b6s18EK71/kQJZveUFwd7pdQpOiABKZzuaMHWbZgTXo0AoTGcR5o9W0fHY4wWRJJ/BwmKaCEvvrzhkrwLXE+P4x/Vrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ztKoyNev; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ztKoyNev"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIPGB9U1I+at8eYNKC1qYECvwQY7ySmurpYTzWAjBmDsjmy0iyledJgt+5a29MkKI3+wLKrcYr/T9m67LiwX+kOdsKZSCwXT0h+bxrmzo+dh90FiTAjRZbIq5HMETqEznoyJbgp+CgzEw1rcAoPRgSVgi1rLXRDqN15gWlVOru2At1m353SI4DKL5XrygWxq4yeLZ7yuDpPrYTSdiVyE2ASsTqDVxFaPDnY7pBbybd/QB4I17uIwbN7Q1FaWnujWXxxv6RwhTIe8yeHKsonYhdIp40/S/u/fVLWGTqH4cUdgxlzTx0WfddJlJNOh1CxUdJ2t/gjngLiJN8Z1F9Zt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEMB7qSxOL8CJBFit25egJMfDaOde2O0q4bxEKgCA8s=;
 b=I1Zjh/5QAdEejN7nPBGlwjEErxDYhyLLOehYYti9lLORz+O2PQmrwCjHCAjxrtpRa1cs3WoD227f8z1Drnc63XM8qv9hewTfBqGhj61yCON7K3nnpZx/r2czwEpF8aOGzvWQxoX1BLWD9XB0oXKl6InRLYh96NmJ4VSVnrLPhtqFvqzKEwFYfSEQh/WkMAqlrQ3RSQ/30edhhWcKwlYt5IdbgQmBSKM6orbe3h+ictIji9d+G+rdXfuf9f7SBDGXQzp32XvnUiBryFa4U89KFfHqY/iV966EocRiCEzXIbmJtFu3H0wk/kRh2kk4kVS75zEw5JID9nhJEaLjSRgD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEMB7qSxOL8CJBFit25egJMfDaOde2O0q4bxEKgCA8s=;
 b=ztKoyNevFBqGQY5idNhX9pR7vmLTmguAq2DkGxeL3Pm70NHTOXUi4FrQhgOijKHZSHmpGl+lbCHbJ2v1ywWwuDcc/J0vYzfEZ4knAdTmUnKSGJIbKlzMjp6kH3S/Nz794LrtvUU4NSaEGmw/C3ZLAvIH4N0ZYR+chEGs17GYb5w=
Received: from PH7P221CA0078.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::9)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 21:23:58 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::22) by PH7P221CA0078.outlook.office365.com
 (2603:10b6:510:328::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 21:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 21:23:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 16:23:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 16:23:54 -0500
Received: from [172.20.244.139] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 11 Aug 2026 16:23:53 -0500
Message-ID: <36a2840c-c91e-410c-809c-aff768dddbf2@amd.com>
Date: Tue, 11 Aug 2026 17:23:47 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
To: David Laight <david.laight.linux@gmail.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
CC: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, Penny Zheng
	<penny.zheng@amd.com>, <stable@vger.kernel.org>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-3-jason.andryuk@amd.com>
 <20260810144706.GC57095@yaz-khff2.amd.com> <20260811092107.37ef648b@pumpkin>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260811092107.37ef648b@pumpkin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5ac8b2-eaeb-4850-7974-08def7eed90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ssoKiEXu2LRyzLn+5zEZo6t0L2IqQRldkJvWV4pnjwwqWeJX5d7sC42ScoptOJUCv1DGwOeA37zCH3iqcr/zy8XO/GqDgo+SyxpFaYBc5e+tkk6d9So6ILa/veEpsfSaEXCtUCSJ5nMGtpVuQtZkmw5ui7pdha2cYW+O36/WVerHyYd2FfCMva5+R7hIqd+PbBUYcV0BBxgRnu+OI9D3FuDDXq4huze4o9xUWzZIvvMKpnSYaV+Q22Wbp9JvKtwiEUr6RiMC639QX+qaG/SU1nCn1ja2w8JiuqYLKvu7NjIeV74SPZUzdXpFqk4ISBvY5zC7SPHBeH5MhdeuRC9+1hFw4K9crtsSOnuxIy6o7OFZax/O40E940zgxoYh8rR2eZWeqoHAac888sC02LCvmJBbYTdGjtWulAXqB00czNwT6gpqFtH+ujyfyOsAoTA2t9ZvLaQgbQK311QrrAr4lxxM8CRwFj3BLneLxwwD0JYdaPlhPS0Na9qPU1EOonsFM1ZoEkjA+hf1p1Y9VPW/T9yaPEz/TFNB388BkTypzkVewW7J9ro5HwubqVKAma/FZRUc6W0PlYTBLlkAg45rIACGG/BlT0Zink9P74GKxAiMnCXxNq7tdVfDGuU7QbLMicA4xssB4+XMX6jzCCoI+M5J27WVH4bcVt98j0RrNItpt3aOi3ziNQzjek/UTtceESWPs4gEWBXUd5aHiR5mEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GDj2KAk3XXd1k5ENmUJJQm1I7LEYOvaHyA8wZYvrxnnA12xMsq3QKdfwXrkSAZyHJCvOQcXxIqreV8QCHtVC/KAzPPCqyelC7OPUxqczjHse6Ycx2L8VRHYzcHUO9bvMFe4J5M21tjmecSxUrOj1ffj9g9p8Qhld/wiH5xPd9S+NUGs8pEkSzdaPcCYHuYM3QEBR7Gq6T+T2amaqd5vRb8imfVUlu2ZP1JZ2orKMA0YS42+TBJtai3qpV+J8rmCmvJj9mftJqIfdXIsa85lnYks5k/wQaS8Q3Bzm/+REefKCTvAezxEqTUh02LEwh8mxkUzZfuZwn09yacuLAIoF6I/SwpqIvSVsCHeJjXXw1sTX1gJ13y/XlH0+kj2KZXb6qUjDwSK37P6HrlJL0dQxzPu60859h6nQNGxtNoW9408hZ+ASd6/vV/wNhFwH+q19
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 21:23:54.8010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5ac8b2-eaeb-4850-7974-08def7eed90b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140

On 2026-08-11 04:21, David Laight wrote:
> On Mon, 10 Aug 2026 10:47:06 -0400
> Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> 
>> On Thu, Aug 06, 2026 at 12:01:57PM -0400, Jason Andryuk wrote:
>>> On a virtualized system, the number of nodes does not have a
>>> relationship to the number of roots.  A Xen PVH dom0 can calculate
>>> roots_per_node as 0, which crashes with a divide by zero in:
>>>
>>>      if (count++ % roots_per_node)
>>>
>>> On a virtualized system, default the value to 1.  The issue is seen with
>>> Xen, but it could affect other systems.
>>>
>>> Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
>>
>> I agree with the idea with some minor feedback below.
>>
>>> ---
>>> X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
>>> ---
>>>   arch/x86/kernel/amd_node.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
>>> index ea553267e5fa..c5025e5291b6 100644
>>> --- a/arch/x86/kernel/amd_node.c
>>> +++ b/arch/x86/kernel/amd_node.c
>>> @@ -286,6 +286,11 @@ static int __init amd_smn_init(void)
>>>   		return -ENOMEM;
>>>   
>>>   	roots_per_node = num_roots / num_nodes;
>>> +	if (roots_per_node == 0) {
>>
>> Can be '!roots_per_node'.
>>
>>> +		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
>>> +			pr_err(FW_BUG "Error detecting roots per node.\n");
>>> +		roots_per_node = 1;
>>> +	}
>>
>> I don't think this is necessarily a Firmware bug.
>>
>> Likewise, it can be a 'warning' rather than 'error'. I interpret 'error'
>> as something known to be incorrect. This was my position before on this
>> topic. But the various contrary reports changed my mind (even if they
>> come from virtualization).
>>
>> Furthermore, I think 'warning' is more appropriate. It says "We found
>> something unexpected. We're letting you (the user) know about it. And
>> we'll mitigate it to avoid an error."
>>
>> Anyways, I just wanted to write out some thoughts since this topic has
>> come up a few times.
>>
>> Possible rework for the above change:
>>
>> 	if (!roots_per_node && !cpu_feature_enabled(X86_FEATURE_HYPERVISOR)
>> 		pr_warn("Expected at least 1 root per AMD node.\n");
>>
>> 	roots_per_node = max(roots_per_node, 1);
> 
> I'd not add the max(), just;
> 	if (!roots_per_node) {
> 		roots_per_node = 1;
> 		if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR)
> 			pr_warn("Expected at least 1 root per AMD node.\n");
> 	}

I prefer this because it puts the special handing inside the check. 
David, you dropped ! from X86_FEATURE_HYPERVISOR - did you mean that? 
The intent was to only warn if real hardware doesn't match the expectation.

Really, I just want to get this fixed.

Thanks,
Jason
