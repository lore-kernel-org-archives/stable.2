Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460903A5456;
	Tue, 25 Aug 2026 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631753; cv=fail; b=R8wv7ns5RgyM/k7dbE1A8sgnUEwG4qcyKZEuGhU/0hPDvKSvTYTCA6PRD3BAW0ueE+apFyWvybNnKtMFbFsTzIlgsjD2uCU3Q/Fp3OOd7Wjk4WFXdeCRFVZ/4QpM9i3PXZMAXAOh/3LDv25i98ov8DcbRDVJG6jX7EQisln98T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631753; c=relaxed/simple;
	bh=mk1MG7waA2lGn3tit8PaFcz+zel6fPgL8foD07CYqWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VnM8UtNDroxM6jHsxjCOZjTChs3qMhVg9pCR3/Nwmp4FAKH3TbA6Ug11v9go0uGmJuy6IGnOrxt44IxiXf+hZZfP/+GdN8x+QSTQwYXxEzvM9j1Oacg/kcrDAXmsMM+Coqt6TAIK0g8syvg+CwOEnt/P1IH0gQWUoog7EXGDGfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Itf66Ej6; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Itf66Ej6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVpIbh9xU4XrIWsG2KwgyVRXvCl74R4bE5CV/NYF5rawOuHBC5vr9GNgjI+h8FyoDKYpo69fFFc6RghWhdei/7qg4+ZqFCSoECxB0Ur6pceXF+1Q/fSnefUK557/KJKGZUV4BndPRY/I2JaQzTeiCy0BQCGif5KSaDqLsjANm6J4OPEU500ZzJ6u2MjiYY8weejZWfwEMLnaX5Zic7tx5Yk9/k7uUa8HEjS77bp7HTPWH1afT2ZrduZAMbbEpwLZE+JGaDxMcsqoxDeXZsFk7KeoQ0FmePxa92gDA+wAlkBKnl1HIv5xoQ3f8+jYm9SPVb51zhOFGYj/OazbURFO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5AlrA+0ftlKlJkE8Q7L41s1BR6Db2eJfx/ENO1ZcEk=;
 b=TPjCQwgvhUu7qD99kwzVAiSymEU2Wky+gRiNq2FoE07ugteSqzNyOJQCyDmsAa2EAsn0dBOVZ/5zNWSt3cFDct490PuYhmVJuRcTuhsdvYqnGhJDOuWndFtOyHWcP9zFBoJkN5sPZ8XBQo7YclGEgQUUiYOn0OVnYdsGBsXvAiSHt6zy37wbU3yo+QyAa2bmWoaYnaQ2mdQcFzqVxN7aW+6y8Ll87Mjqhw3Ac9I9ff0pc3MXjD524//OOs+UqPVNTwnV/4CbJRqqD9PJiPH1SMwO3PEIk1RDJSw2kuupuz+6/NCQkTGfZJCTAOUfdNFDKaOjEYp41AnQxiCb8PiXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5AlrA+0ftlKlJkE8Q7L41s1BR6Db2eJfx/ENO1ZcEk=;
 b=Itf66Ej6kKUhqMv+3p/uGBabzCrOv5iRb/Qq6WxQCOYEBTCOvGa2pQsd7k3DRj2ssEkMmJW3hHTKPq4Jk5nBVSjjGLEhJF15qmbs4R4mnSoB1qFsHfclRdlsEH0qbGEZg6bQ8exML2OGIddAhEUAUeI+sf4E2Zf9uVvjr81M0ag=
Received: from SA1P222CA0060.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::10)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:22:28 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::8b) by SA1P222CA0060.outlook.office365.com
 (2603:10b6:806:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 04:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 04:22:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 19:04:50 -0500
Received: from [192.168.19.2] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 19:04:49 -0500
Message-ID: <cda2faad-441c-4c4c-a848-72b63901c40f@amd.com>
Date: Mon, 24 Aug 2026 20:02:51 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, Penny Zheng
	<penny.zheng@amd.com>, <stable@vger.kernel.org>
References: <20260814214255.83127-1-jason.andryuk@amd.com>
 <20260814214255.83127-2-jason.andryuk@amd.com>
 <49f2616d-e37c-4420-9d8c-81f978386ce6@amd.com>
 <20260824210411.GA1500179@yaz-khff2.amd.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260824210411.GA1500179@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 1249e7c8-39fa-447a-8041-08df02607925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|4143699003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	EZN5FQbeDKpsZwCvJFg8KBtTWUPiuPSj7ByDnuCZHCx3vlnZGvlTrb49baDd6+ksfGs6ifRS742Iye0UOe4pWhM7QaswwrtfJGh+xjIcPFf1qzHr1ToGcldfimvX9A7UvQz7RC5W8IbnrkK18Iz/eOd4KoblE2OJUR/MoyLNiLDpsWOjE0fkXFphlPYjffxrHxOMgYQmYy1SH+Bn7NKOYmkbzbE8NR5Sy2793D9YhEAUsKB1CicyxrN4KiiPsxrHtcbglJXYKcfz7UGiTpQB5dD38g31+t31zjuXzN98WDmU562CdLOVYwxBjd7EJiDQn4ZIrUxxFrsViiXFxjEbB+rEl8/o3lrGZ1aDLA7zJzPd/RrH5QjcxnWqam8EEAqSUELBri9u3lO0ylcmHGSAek7nsHuIwPD4xRFVV890qOP2ZnekTecJCuIJN050gb8RYumqlgj/I8pmRioPXxIWWub/qOWcNsOhli58p9PAa4CeirZLLxzkwxEH1k0YzVLUbUOZb8LICOFAr7aaLqKm2cmWPI10nWl5qaOD37GmphqtY1vBtfP5i5AoPdy/Nj86jYzGqPsVdPrf3tOmVyggnYgyKS3CneASRCkR0iY0PVgl6+YUbjAgEExMi1HrYnx938Ojt69Os3apiMIDvBTNO5jJxwBCwu3bHAYySaa+qkPZoWpj2pNwXNzKD2XbG/9EXAHENyvHXKHPFDXYzuHwVg==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CAvFTqBtnu0Zd6TgvArwSCCayFRIA8BlZBET3Vx67T6bjlJ9XoD9o870pZuSEsoEvr7V3JLMiOCy508bLilj1+8ZnFa1o7r8ZI4N7mitlIPfJWd7KUKpJbrhipJhy5+mQhP1ku5EX3HTQlJpd8Vuu/x1pokS4m3qk7kVKVbVaaidJGEdggSvSnyWrWtIXU4st09eg1h7BJHcCkUKsNnvh+GATORO0385ny71nBwEwB9iggaBCkoxE0IgLuvBqiBfmxdIIpT1CE/r+RIw7erpBz446h3GQRwHgJVf/VkjRJ1Ec9TyllN+qEdW7OTZXhCbnGLZnx7xhPDv0e6TivxKrRHygeGEh1722Mi153diJqDHNot2zPr6ChiFirVbMkviYUdRQSEbAVKAmw30jAE+WQK4B/sPMmPbXNyApJVs7+Gj9Jr7MGOPB3ew8zlZs3Do
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 04:22:28.1581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1249e7c8-39fa-447a-8041-08df02607925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129

On 2026-08-24 17:04, Yazen Ghannam wrote:
> On Mon, Aug 24, 2026 at 04:05:40PM -0400, Jason Andryuk wrote:
>> Hi,
>>
>> On 2026-08-14 17:42, Jason Andryuk wrote:
>>> On a virtualized system, the number of nodes does not have a
>>> relationship to the number of roots.  A Xen PVH dom0 can calculate
>>> roots_per_node as 0, which crashes with a divide by zero in:
>>>
>>>       if (count++ % roots_per_node)
>>>
>>> The issue is seen with Xen, but it could affect other systems.
>>>
>>> Change roots_per_node == 0 to 1 to allow the system to boot.  Print a
>>> warning when this is performed for non-virtualized systems.
>>>
>>> Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
>>> Cc: stable@vger.kernel.org
>>> Suggested-by: Borislav Petkov <bp@alien8.de>
>>> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
>>
>> Any feedback here?
>>
>> Thanks,
>> Jason
>>
>>> ---
>>> v2:
>>> Print as a warning instead of error
>>> Use "!" instead of "== 0".
>>>
>>> X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
>>> ---
>>>    arch/x86/kernel/amd_node.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
>>> index 0be01725a2a4..c3e214925d9c 100644
>>> --- a/arch/x86/kernel/amd_node.c
>>> +++ b/arch/x86/kernel/amd_node.c
>>> @@ -287,6 +287,11 @@ static int __init amd_smn_init(void)
>>>    		return -ENOMEM;
>>>    	roots_per_node = num_roots / num_nodes;
>>> +	if (!roots_per_node) {
>>> +		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
>>> +			pr_warn(FW_BUG "Error detecting roots per node.");
>>> +		roots_per_node = 1;
>>> +	}
> 
> Minor nit: add a newline after the closing brace.

There is an existing newline that is preserved here in the original 
posting.  It seems when I replied in Thunderbird the context here was 
corrupted.

>>>    	count = 0;
>>>    	node = 0;
>>
> 
> Overall, looks good to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Thank you.

Jason
