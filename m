Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CBE3AFB19;
	Fri, 25 Sep 2026 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323641; cv=fail; b=rZOj7FLLv4Vl30qWIe3EBLrS2voHAg0917Qj4seVdec3EwT9VZ+XYa385nO0KvaLmpa6CKzEaQRJHX7zI1nAU5rB7a0FIUz27xNdXsnF9bc6pJH4l4q3lloDLsEpAGWwjNZkceeQ+3vLfCetc5S9TURD8CMBYyfPgN2VxV/GRU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323641; c=relaxed/simple;
	bh=kuKluRmt7ivFLhjiFJfeUMUrLl+5ugU52zygA/5Z2mo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OoQh+ruV9wepAnnbd4cQ6qShATv4N4HrZvEtts4hHXmRUW5tVpX5ONYXbnXHEI3ViOhqIJSuq8hJXrVlD7IUmZC3RJfNTYKe+U9SmAfHjnHV8MAZsX7llPwmPqiMZEIvgrM6cpmPxnr0uB3mfwIL5EH/6LhKdBw57F8tchm/dyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KFfoubN+; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KFfoubN+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=du//csdSv6hp5nkkgMXG/i5SHYAC0RMpmIoAPacfg4RWipSSXrEYoOZh+aksfOIYIcNtrBH/bp05L0Aj/e05KpWAPTZLlfq7jLXAFfVKKLcFLmzEIgfpjjZMhTej/DMIm0nAig9+XLjlqqtqyLJWkVXbkkm/SoYlk1At4S5U+5weOBTe+yZGmA4KwR5wCRGStGnB5Ect3EGqh00/UMazLvgcCBX9L8BwQ+V5pDzq7qC3lSP7RWgtxc9oIcxyKP2G0HvzqvTdPpIWEh3lFCkntVY+uQJ+Bvngk9uaQpiQiZJ/RZiK+N5okVKKO4FdteP91TVRkhWdOLLtHChlIJy2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsjWijD3QNyw2ucvtCPwmvMVceBQLCl5MFegrI/dsMA=;
 b=os6qwJEyiPWOIGEuox8R39L41ARRts+L1Mrb2p8kcV3qyzzi45ScfyQUlBs4TtT0yUCLQYOM6ncc4oACA/yomG/Cc+rqCa1ZcXqrE8AeJRZbrw3jDNZP4u1QT/kl+HJqQL5V71ndjmk0R7Dxn1sz/21F952ewCPFkHbKSYJo1+IDnPaVAisjuN/To9N4wTQkxKZ7d+8oRXRsXaHn/ZoymIVzxze6SPmqCK4lFDjMnyV26NxyayQzW5t9DvofBvw3wAuOtcrs58Rft4rd80nHGk85pGMsyq3JooleEJ9mzEnxv6dxJVd8P9ZBP5+vkSJP9pDWpEnrNy4GgyrfBciSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsjWijD3QNyw2ucvtCPwmvMVceBQLCl5MFegrI/dsMA=;
 b=KFfoubN+vEtwjfrdOTZraArmk2CKWZwEc5d9YBNaW1KBqs0q3O0+dcuFjmzHpk86q92/Hh53ynW9Phvorv+FwDDn7VR1PXAUXeE2x+heON0Dj5TFatThcbZJaxllr72kP1dGN3YgJYVLyOIOkfDyCzh0Rf/qA6eUWQ8/oqxIweM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Fri, 25 Sep
 2026 08:07:16 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 08:07:15 +0000
Message-ID: <611b8e7a-b434-40c0-8f0e-4978208bb01f@amd.com>
Date: Fri, 25 Sep 2026 13:35:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
To: Fan Wu <fanwu01@zju.edu.cn>, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Syed.SabaKareem@amd.com,
 stable@vger.kernel.org, Song Li <songl@zju.edu.cn>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>
References: <20260923092640.502145-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20260923092640.502145-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::21) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ff7eac-cf82-4035-0b02-08df1adc02e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rC8U/cQhmoPJpjxTaUUxhaSNxe2gMiJBheAfkkLTredcOX3XLMc9E4iDRs9N1cI964ZE4xekVpybt7AZDXXxRNj54MFxgTmvhh2W9+PmueQew4URClgjum8pWHlmHbUuaDm/aPfdFLxA5ZDXoIBOBGrslKDlWoOkh6bkeLmOHtPliAYqlndj9+5lWczMmOueEIfoJ+VhOTrNa9o/fm7wRPKMfvks3L5DvB8l7DFvyO/KX7Hal9CYpyyYPUJgHqOcuGSopIjHBL4O/4Cp6G4CWFhiEM0NgwS7iMTy4tQ8fW2oNXglY1SUF4tCmMv5qzUahW8P2DpqHkKlntZQQu/h4UpqwlyQyxns4DD/ISZlDEIvURYSSlQbQspujC9XUJVDtcXjb6eXICm7KJT4MHeK9BCn0/HMJspAODEW1nKPkFyD2QuskxdSoWxVZz5LHOFXc3ru8H5AzAb1gvqrZQjIqCPLsPEbiWadMWDTdamYhhDkZAk4IVKsmS97DNKjV56ueUsBo/u5NpUtahNK4qWpnikcMY0WKT5KMDZXCWGjaGIUHoKt1Q5UR3Y71Qq6bluvzr76q+C4nRhBX+xZlssprhSjwQ80JXmd8DJjYjAA2o/nQ/xmQRiMrnKVyPmNis8hrrzA5DSKPNreSBWC6RBR++3o5ZTHZH4S0wQ7ygVERdU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2NNTXRQVEVJS1JBTDJBV1pWK1lzZzRTYjd6a1RqRDNmVHBMWEZRdTlpUVdx?=
 =?utf-8?B?dWtxTi9oZ0REUW1KbGlHRU1vaG1Dc2JSWnpHc2l1eVR4eHRVeFJ0WlVzUmcw?=
 =?utf-8?B?VStrWVB2WmNMc2k1dHgzTjVEM2ljZ1ZBTHFYSmVEMVF5UFdOVlQzMDZBVzkr?=
 =?utf-8?B?cVMyaWwxV0sxaDE3WVEzKzJnMkxFeG9hTWpRK2x5T3ZOS01XL1NtTFBlQzhD?=
 =?utf-8?B?K1FOc0tScnlOUk5LTkl0UUZpMmROcWhuQmFPV1cya2dpTTVzUXMzNHZKekE4?=
 =?utf-8?B?ZlNhaWlRWjZnWlNIbkVUMG1kYXpLSmhVU1hWTjhyOEZIMEd4bTYzUVNoMEJV?=
 =?utf-8?B?MCt1dTB2bDNUaXZjWWdURzZpNnlpdXdYSkZUK3M5OU5kYkppeElZRnFyZm8z?=
 =?utf-8?B?NjhScVlBMThQa28yeW5uamdBUUpzb2d6a21mbDlrSHFweURSMk92WFNhTnps?=
 =?utf-8?B?MHBjTDNHbkNKaGJOU1Buc1huYUZFaFkwK2NBYndSUTB1NHkzM3phQld2ZlJI?=
 =?utf-8?B?SEhHNVNzOVF4a0RXRlNhSEV3ZldROVRObEttQVVsVVhoTmd4ekttZm9HU1ZS?=
 =?utf-8?B?S2l3dGtTdGl4ZlBERy9yRFNOVkhTUDY4Y3ZCNHl5WHgwNkJJQy9lRmpoS08y?=
 =?utf-8?B?bWRZRG1DUUFxNWJSbWMzM09kVHl2VDVvU01EUGZMVlFzY1JtSDJvU1RJYnQ5?=
 =?utf-8?B?R0lKOEVGQlo4aGlNYVU0MllORk1rNDhCdVNZTTU4U3FOZjhYcENURjhETEMr?=
 =?utf-8?B?RmpOVFp2a0RrOHNKb3VDL2xwZ2dhZVVicVJRTG1Lb0tiRXpDanNYS0lKdEYx?=
 =?utf-8?B?eGlIbUcwRTYrSDNlQUJ1dmo4djBjSG0wZkhxTUNCN0JZVmRWMmRvcVJ5UnN4?=
 =?utf-8?B?VjBicm5pZmpCVUhONVRaTGtzcHlvZUN1MVFxYWpuK0dTSEpTaE83c0FVVTBK?=
 =?utf-8?B?dE0vUzlkM2hjM0toY1c4SURrMVhwOC9KeTIvREVZcU1lY1BqTUVPQW5wWXVY?=
 =?utf-8?B?VG1KTVJZQlBKK2N1Umg5S1NqY2w3bWRCZ2dMMTd6b0lsdWFjWGNjc2E4Nmg5?=
 =?utf-8?B?dE9wRW5xNWZRSG5UZ3hkNVd0bWdUc1k4QlpnV0E0by9ScmcwRTIrK2R2OEdF?=
 =?utf-8?B?OGpoZkpNdVBNYWlyUlVkWFNQTXB5cHkzVmQxYVZmOHlxWW9CbWFta0VSbUVP?=
 =?utf-8?B?dEgvNy8zV01RNmlScHp5bDhJQm0zZkFPdENyRERod1IvTnZPOVpBckYxOTdm?=
 =?utf-8?B?aDhkcDRwbTFubjQ0UHBla012T1F1THhJWTJqUFlqdWxBUTJLTC85TCtVU0Ja?=
 =?utf-8?B?aHZnYU83TlozWjhaUTE1QXJPQXFUVEF5b2x2cHg1VWpTZFdIenFKTG5OaEYz?=
 =?utf-8?B?UVpvMk9LVU8xVkZOSzhNMjF6SnFRT1IrQlJzeFIvZkxnK3MrMEc0Q1YydVl4?=
 =?utf-8?B?MU9ZZGVHbFdSMXJUYXBncFRRYU83eFE2OGlTcHlpN202S01aMjRlZG5ocXVx?=
 =?utf-8?B?eHQyTm0vcnEwbTFtSVdmSTU4VmYxS2I0L3hNS0MxRE1SS2pWZkpnOWpJZ3pO?=
 =?utf-8?B?Tlo0ZGtKWmNNZVZhQ2tWN3lIVWdIeG1oRGtXbDRQek1uRGRFY085WlcxU05s?=
 =?utf-8?B?S2xaK0F6UlVlYmxqcEcvc0p1TXpORGZJanRRQkhWcG5BZTVhUGRQSHc5Vm5x?=
 =?utf-8?B?a0xtbFU4ajJCa3VLV21rOVQ2aVB3dUMrbTYyTVRER1NHVDJDMmFWbWlpTFUv?=
 =?utf-8?B?MTZzZHZ0WkFpZm9qTUwwVXR2bUxGQWJPbnd5bDFHVjZCTWVTRTBOR2RTSkNq?=
 =?utf-8?B?SklYVWdhNFY5aWhubVIxWlk4T3lDeG5ONVh0U29XN3ZWaTh2emJ1QjB2VWJo?=
 =?utf-8?B?OTJaS2NLUHUwUURmYm00Nkk0U01LbXJBZ2YxWkZYSG1kMFNBViswdEdlOEJj?=
 =?utf-8?B?UVQ4UXVxSm9XbTBQMVBVajJGdTJqUUFYU2FRdFlFdWY5MXM4a05YK0owNHVi?=
 =?utf-8?B?RisrbHpwUHI2L3R5NTVrMW9hRmNsZ3gvWmVJQU1qc2M2ZDZ4ME9TN1dPdDVY?=
 =?utf-8?B?cXRZeWZXd3hqemN1UXAwYUY3cXBNVUJoS2tMSHdkQVZPc2J2VktjcVFHLzZ4?=
 =?utf-8?B?RHQ0QU0vTU42RjJqVlVhdENqeGp6Y1E2RDMzNnZ6MVZ6c0ttY2lOZnBqN25t?=
 =?utf-8?B?R0lSSUZtVGV6NWNpWmhiSDFmODN1cjRhclJOVVlUcVQycHlhN0p2Uk1sMDQ1?=
 =?utf-8?B?UnVQVTRHcFhLaXZ6UUNrU3RoK2JVenMyUnBQTi9rV2ZTS1FsRlhvWEQzaStv?=
 =?utf-8?B?WURjOEZFamN0T1JOOE5tSTJLRlJCTW5rTGNvVGJrbTgvR3J2dWpJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ff7eac-cf82-4035-0b02-08df1adc02e2
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 08:07:15.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVeRb+yb/E+zqznk5vXt3iRBzlh+z/Z7Deo2bLocPr/FhWrlw8dPlsenYN71FImgraPnuGhVtX16pdZGkU/LWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167



On 9/23/26 14:56, Fan Wu wrote:
> The ACP threaded interrupt handler dereferences the SoundWire and PDM
> child platform devices, but snd_acp63_remove() unregisters them while
> the interrupt is still registered: devm_request_threaded_irq() ties its
> release to devres cleanup, which runs only after the remove callback
> returns. A completion in this window is a use-after-free.
>
> Fix this by masking the ACP interrupt sources and calling devm_free_irq()
> before the first child device is unregistered. The interrupt line is
> shared, and acp_hw_deinit() clears the sources only after the children
> are gone, which would leave the line raised with no handler left to
> ack it. The window predates the tagged refactor, which only reshaped
> the dereferences.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: eaf825037d6d ("ASoC: amd: ps: refactor acp child platform device creation code")
> Cc: stable@vger.kernel.org
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>   sound/soc/amd/ps/pci-ps.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 729f9aa..01ee697 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -738,6 +738,12 @@ static void snd_acp63_remove(struct pci_dev *pci)
>   	int ret;
>   
>   	adata = pci_get_drvdata(pci);
> +	/* Mask the interrupt sources before freeing the shared IRQ. */
> +	writel(ACP_EXT_INTR_STAT_CLEAR_MASK,
> +	       adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
> +	writel(0, adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
> +	writel(0, adata->acp63_base + ACP_EXTERNAL_INTR_ENB);
++ The fix open-codes the register offsets (ACP_EXTERNAL_INTR_STAT, 
ACP_EXTERNAL_INTR_CNTL, ACP_EXTERNAL_INTR_ENB) directly in 
snd_acp63_remove(). Future platforms may have different interrupt 
control register offsets, which would require changes in this remove 
path as well. Consider adding a disable_interrupts callback to struct 
acp_hw_ops and invoking it here instead. This keeps the remove path 
platform-agnostic and the interrupt masking logic co-located with its 
platform-specific counterpart in ps-common.c.
> +	devm_free_irq(&pci->dev, pci->irq, adata);
>   	if (adata->sdw) {
>   		amd_sdw_exit(adata);
>   		platform_device_unregister(adata->sdw_dma_dev);

