Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8C4A7CAE;
	Wed, 30 Sep 2026 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811326; cv=fail; b=i0VCjRItK9/Odhe8CEW2OUQEkSKhCF6dIo0hNH0gBhWpcocQD5+GNCKOl3RJuL0y4BEJxLzg7KoiUaBzFG1Cc1kbQJqufI7c52kmEX3Pdh/HfGIbuiYpck7pLgMPVer6k+9EpECJ/NBANxSTCB7aLy605diCeVW6GyFFjVlfO9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811326; c=relaxed/simple;
	bh=2uGihHt+5ZRmW7gpoQJGDf4ECHaESM75RN4SS9jwGek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uYljXrjzu3MN3TRcNeeJGxAXBcMUvnNCjL/Ol+XoKo6XlHQCBk47VZDDD3hMpM/kKHJa0PY3JTFcaQ1t48VkwuOo8rd4aMfOMJ1nyBifgLcqxaPXIN9SIMqVcvtB7hJ7VwHZCQbdzuFeqv02swvwGsxizvjMXPu2f77ujqdEtS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=12QLVXCL; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="12QLVXCL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azIMNs0vctmlhQ2iR2uCeCgd5wDINHSXvlxYLko36CnsfcE6ubEhHqTJwfPEAEzvTf4Zox5nIgn/QNQfqBmJwZDQHv12GqvmqYHvdhIOZz93b0zR1m7q9wh8ldM/LvCCTv4XQ2X5ozY2fI65LMvnayDZ9vKqQHzLbv0vj2i/E/1qJl5E+ZAT10PUBJyIBIyPI9fwNZXC9aLrKNmLWSKSiJWfmRuYZ4a4bO0Biy/vMFB6/IeUGlcEXx5e+73BWQAhrktwZNMWMJfdx6uB6CtEXvZE6gt2xx3v1UNd2ynpfPAGnhQ0JepfPFVqaueDPhwClTWbeePZJ9RD6TDuo5ziKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX0CwCfZePqou392Yd+vbu253MOxvWssCu3dp7EzcWE=;
 b=JehSEduhYYTqVqI41prPbz5nwCaA1sGb1k2I50LH13x5ggT75RP+Scm7jV8ljvgpj4QKQhvxfyHHPRnL9OH56QIVFwTDbWzYVl9vKvmYuhnQHYhVEnS2Fpn5pEjKX6gCE9zMurhGVe3ma6jdmw6Ybcw/04y5STX/2f3QH0D68UWM4E65V+VXBX2jlmG9yXcU3DPSu/UoYdXtMrPb5VIV/r6o6tT0wlxvzHqYlyP9lMjHlnu/WyEOLQ+tGTtx8xUiHUl4DuhTNdOs2wm4Ju/mekUUyKDjl78G2Hbsw/FE4DCHP5FSCmz2qGIZrzAx63BJBhZqcRs7IxF/4ZpdHGP4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX0CwCfZePqou392Yd+vbu253MOxvWssCu3dp7EzcWE=;
 b=12QLVXCLegvW2qGyRaQQlrKV5EYPfjZep1kg0w5vxnK+mzvgSC0U0ETXigfJ5FRtZIpBhK3dyLO/mQE2yef2XDCCkEzKRNNCnxfBp4dThGGEvshELYN5WAJknDOt37wJL3vrTjbOjuIY6TBGLK9ljnjOmH5bcwPfJYQS9KZebWE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 23:35:21 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%4]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 23:35:20 +0000
Message-ID: <88191821-4e3a-4ec7-b5f6-87ba21786acc@amd.com>
Date: Thu, 1 Oct 2026 05:03:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: amd: ps: fix snd_acp63_remove() teardown
 ordering
To: Fan Wu <fanwu01@zju.edu.cn>, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Syed.SabaKareem@amd.com,
 stable@vger.kernel.org, songl@zju.edu.cn,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
References: <20260929061349.3879-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20260929061349.3879-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::7) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cba491-bf8e-499a-3f64-08df1f4b7dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Kr8PSXCIKn30hfPmCSBzQLwBLnit4Km4QArv5Eymnlg3Wn7fMHafA0aMRmZomsPgGdEe6E1eWG4W77Y2kYG/UGmX4s0QtcSObhgaTTYnTW1RFSv/IthS6qH2y85BGyqT11chrq6Wm3PeHpMVhDkmWmMH2f3cl/M8wrODwyduoiafPW1R/5YclE2VbstEBjVfx/P7Xr6jA14z1TsmfRncRvipb+109XnUy/A+hsdaV7nozQeG4wS0WlfmyJWklvOBfT3uC0Vj/SfTfp1WWFmM3zWNo9rPOnAVjL7c/acqjMrHgkUMcAQiAjHe3mowY+IQyVYiqfBxfC0ZHIXxzAwqkt8O7eazIMOXnQneL3sBKs3FQ0H98K/W5lWZ73X33tAjWJVj8JvrfWd53n9jdaRlsUVr8rnKi6yN6cpbDgx5/dcrig8VwHczU2UvaGNm4J4YLuJly78Y/TAMH+l0jOCCdy57tUTc+Edjr5/qj//wzVKUZZ63lu5UKN7hY3NwOQig4uTw8VFmLeDDctXLvaVrnX+4mYmuC8KWYCYwaCM7vaPfJreit1Fp1Ap6E/Qf5u7mfizbPlf36k1vMkOYDQDoalWd4/t7VXWxSNX4iWQbOuxIbulgSRKt7mg7sZJUB+sG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGszTGZPNkRrcGtUcE1zOU4rTFJNblNENDkzbHJ6S1I4MndhbzE1ak90Q3Z0?=
 =?utf-8?B?eW1makpWM3Y1dHdtNXJSN2xZUmdscmI5Tk9RUmtmdVZDRGF0cVFQUkVVdHJs?=
 =?utf-8?B?eTBsYkpvT2NUTGNOV0ZtZFEzYyt0M2JwSnpBTmg1SS96NjI2WDRUQWtxYzdQ?=
 =?utf-8?B?bGRjTmpJTVhjYXNKdFZub3VLVE9vODN0SW9Xd0RVUE9iMFBtVnlRak5KdDdO?=
 =?utf-8?B?czRSWlJudS96RWZQNWFwUDdCWkxyVFVpNjFjZWlWeVdJZm5Kd2kyYzV5ZE5X?=
 =?utf-8?B?VE5mN2daMU8yMm1UdWY0SEF0bjV5bTdFeXVxeGpocGMvbmJrUzNpcHV3cVhu?=
 =?utf-8?B?SXFuYUlxdlpDaGVHZjl1Y3ZuN2poN2xMQ3pMYlBCYldYRTY3dUpEUVNKZStG?=
 =?utf-8?B?QTd6QUs2dnNPclkzcGZGcHN2YjRCTWdHTFNDVzFCOWV4QTE2dkRDVmVCNG9w?=
 =?utf-8?B?T3VLcVZ4MStEYU8rdGtkdThuNlBrNldEZ3B3WUtBSTRGcUhKR0dYYzZrNmRV?=
 =?utf-8?B?bWdDemw2UEY1enhHWGxuY25ubERSdGx1NlJkWmY0OXVsbUJYclRCYlpFTVQ4?=
 =?utf-8?B?S0dncmV5bnI2WUh1cXFudTU0OGZCR1lvOEFWWHFvTTlTWjk2TWQzWlJiRGI0?=
 =?utf-8?B?ZE42T204S3I3UEYyVnQ2TzZESTg2cDBKc0ZsY2tnbjJCM2ZmS24yT0RqbUN4?=
 =?utf-8?B?QmRDVlE3eHVHT1h4akVBVElZNnZDL0hHNk5QWjZ4Z29wU29NaTE0eVhick5J?=
 =?utf-8?B?OWo3NVFiT0VmSXBSVnBhd1NHdldiL3BUSFBFTC9UcVJJaUQrYTFZRmR1M2t0?=
 =?utf-8?B?cEFOVmFJNHFrTDJIQVFCRWZNVFBCazNGUzBvN3MxdnUzK1l1bmxYNlJJbE5O?=
 =?utf-8?B?YkVlUE1YaTZuOEtxSkpoK1h2bHE2R2Irak8zbVNEaUVDeEU0dTBXbTJsbmt3?=
 =?utf-8?B?ZGh6cDJaZUxmbm1kT25XbmI2bURkLzQ5QkJ0SmJGZGR2V1c3Z1RodFlOQ2ox?=
 =?utf-8?B?b0xoLzdmV3lSbHFURGdiM0R0NG1KYW5mK1NLSUpuWnJXTnhJMVVFVFEzaUNB?=
 =?utf-8?B?bittaXRCQlBmWktwSTNuMHhrMmEvcUFIRWRwS25mb3krRG9XY3Q5aUlzQWRL?=
 =?utf-8?B?STN4YlNLN1VwNmJ0eGpXZzVOaysralYrVnRURXJwNkdXSVpyR2ZTc094LzEv?=
 =?utf-8?B?QTU2QXhQZ2hnTFBhdllhMkNQSkVPVDlnRDdpOE5FcFRHY0ZZSXA4dC9FeVJE?=
 =?utf-8?B?RlhxQmt4MVp2NjEyblBKYWZFVTFhak5lSFQrTWpzWTkrM1BRV25UK1k1M1ZD?=
 =?utf-8?B?aW51TXRrbWd4aXhLQVVGV0crVTMvL3FtM2FJODErLzluUUFIZmR4UVlXWlZa?=
 =?utf-8?B?US9oemc5M1ZUTExGMEgwdll2MU45eUI4SVVLU2Nrc3c5YkhsVnFkT0FtZS9I?=
 =?utf-8?B?NjdGbFNiUmlHSlBYL1NuYjdtVUxESmZFNUQ2UHBmVS81dFhRbVFyU1RFZHZi?=
 =?utf-8?B?TjMvYUhoU241QU5JcXV2bHVPcnd6eEJUaGZuQVMxOHdscGtUMVVBTUNNZ2Uy?=
 =?utf-8?B?WU43Wi9TQ3Z6cUNsdk5COTVKNy9jSm4rS3ZlWXdEalk5TVRNVkg0UW1VTkg0?=
 =?utf-8?B?K2hxUHBZNzZYNUlsMVRZTUYyS0dGSVNHZnB2cjRQRFZYWnFtT2JwMzVLazcw?=
 =?utf-8?B?ZFdCU25sa21za2pQcEVWK1pMbE9zVkdmUU4yN3JPZjlPVGVHcUVHZkdqcjNu?=
 =?utf-8?B?djNRbDRzS1RxakIwaWNNME1veHorcGtqRnZJTmtLV3ZkU2pQZDBrb094eGFU?=
 =?utf-8?B?Q3VpMGQ3a0wzenMwOStPRWt6cjRqR2FLRC9TWG0zZFZuNUZVWFl5Q2x4Z3RY?=
 =?utf-8?B?Y09FbjU2TzluRGJobVNJZWp4SHRuRmhQSFh4SEw4QkRSMVo1VE0rNjkzUmY5?=
 =?utf-8?B?ckZORnRham9ZMGM2S0dwWGU0ZWlBa0NuK0RlV0ZLdXlMeHZzWnJCZlQzbC9E?=
 =?utf-8?B?SmVvVjBMait6c0p0VTU1MzRhbEVUYjJra2RucUZ3OTdCRXY1emdJY3EzWmpP?=
 =?utf-8?B?clpPSWJxNStqMXpCN3BYNEp3SkZYeGVQaUNoZmxOUGdqMUo5OFBReHpwcTcr?=
 =?utf-8?B?RlhZN09LVlZxVHA3cDhTc2ZKMDVaajBvYWxRc2hPaE1FYnFvS1Z4cDRqNWRF?=
 =?utf-8?B?MkovekpwTlZBNDhzdXJMM0pWMnBQNldKTlRWZHVkM09CY1I3Qitoa1NiR255?=
 =?utf-8?B?UllXcGZqYzBGVmdxM1FHUHN4YUs4R1hDSjFCRFdNYm5WSkY2UG9qY1Vzb2Ra?=
 =?utf-8?B?Y3VCVkxJTGNhQ0NJZ0FHVEJHbm80cDIxempCek9mVnFLSEdkbHkzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cba491-bf8e-499a-3f64-08df1f4b7dda
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:35:20.7545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkGIKfK5OrutFCJptnM5EJere5ktCustU8rOa+F336IrVfN/8BaQGa69gSfgvWP4CbjRc5sPq53VOwJoElCjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348

On 29/09/26 11:43, Fan Wu wrote:
> [Some people who received this message don't often get email from fanwu01@zju.edu.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The ACP IRQ handlers dereference the SoundWire, SoundWire DMA, and PDM
> child platform devices, but snd_acp63_remove() unregisters them while
> the interrupt is still held by devres, which frees it only after remove
> returns. An interrupt in this window is a use-after-free.
>
> Mask the ACP interrupt sources and call devm_free_irq() before the
> first child device is unregistered. The masking goes through the new
> acp_hw_ops->disable_interrupts callback, keeping the remove path
> platform-agnostic. The interrupt line is shared, and acp_hw_deinit()
> clears the sources only after the children are gone, which would
> leave the line raised with no handler left to ack it. The window
> predates the tagged refactor, which only reshaped the dereferences.
>
> devm_free_irq() waits for in-flight handlers, but not for work the
> hardirq has already queued: acp63_irq_handler() schedules
> amd_sdw_irq_thread on the SoundWire manager. Draining that work in
> the manager's remove path is a soundwire-side change and follows
> separately.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: eaf825037d6d ("ASoC: amd: ps: refactor acp child platform device creation code")
> Cc: stable@vger.kernel.org
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>
> Link to v1: https://lore.kernel.org/linux-sound/20260923092640.502145-1-fanwu01@zju.edu.cn/
>
> - mask ACP interrupt sources via the new acp_hw_ops->disable_interrupts
>   callback instead of open-coding the register writes in
>   snd_acp63_remove(), as suggested by Vijendar Mukunda.
>
>  sound/soc/amd/ps/acp63.h     | 8 ++++++++
>  sound/soc/amd/ps/pci-ps.c    | 2 ++
>  sound/soc/amd/ps/ps-common.c | 2 ++
>  3 files changed, 12 insertions(+)
>
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index 62cb6bef1..d0cfbd4da 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -294,6 +294,7 @@ struct acp63_dev_data;
>   * struct acp_hw_ops - ACP PCI driver platform specific ops
>   * @acp_init: ACP initialization
>   * @acp_deinit: ACP de-initialization
> + * @disable_interrupts: disable ACP interrupt sources
>   * @acp_get_config: function to read the acp pin configuration
>   * @acp_sdw_dma_irq_thread: ACP SoundWire DMA interrupt thread
>   * acp_suspend: ACP system level suspend callback
> @@ -304,6 +305,7 @@ struct acp63_dev_data;
>  struct acp_hw_ops {
>         int (*acp_init)(void __iomem *acp_base, struct device *dev);
>         int (*acp_deinit)(void __iomem *acp_base, struct device *dev);
> +       void (*disable_interrupts)(void __iomem *acp_base);
>         void (*acp_get_config)(struct pci_dev *pci, struct acp63_dev_data *acp_data);
>         void (*acp_sdw_dma_irq_thread)(struct acp63_dev_data *acp_data);
>         int (*acp_suspend)(struct device *dev);
> @@ -397,6 +399,12 @@ static inline int acp_hw_deinit(struct acp63_dev_data *adata, struct device *dev
>         return -EOPNOTSUPP;
>  }
>
> +static inline void acp_hw_disable_interrupts(struct acp63_dev_data *adata)
> +{
> +       if (adata && adata->hw_ops && adata->hw_ops->disable_interrupts)
> +               ACP_HW_OPS(adata, disable_interrupts)(adata->acp63_base);
> +}
> +
>  static inline void acp_hw_get_config(struct pci_dev *pci, struct acp63_dev_data *adata)
>  {
>         if (adata && adata->hw_ops && adata->hw_ops->acp_get_config)
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 729f9aaba..b604db494 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -738,6 +738,8 @@ static void snd_acp63_remove(struct pci_dev *pci)
>         int ret;
>
>         adata = pci_get_drvdata(pci);
> +       acp_hw_disable_interrupts(adata);
> +       devm_free_irq(&pci->dev, pci->irq, adata);
>         if (adata->sdw) {
>                 amd_sdw_exit(adata);
>                 platform_device_unregister(adata->sdw_dma_dev);
> diff --git a/sound/soc/amd/ps/ps-common.c b/sound/soc/amd/ps/ps-common.c
> index 7b4966b75..ea71cdf19 100644
> --- a/sound/soc/amd/ps/ps-common.c
> +++ b/sound/soc/amd/ps/ps-common.c
> @@ -248,6 +248,7 @@ void acp63_hw_init_ops(struct acp_hw_ops *hw_ops)
>  {
>         hw_ops->acp_init = acp63_init;
>         hw_ops->acp_deinit = acp63_deinit;
> +       hw_ops->disable_interrupts = acp63_disable_interrupts;
>         hw_ops->acp_get_config = acp63_get_config;
>         hw_ops->acp_sdw_dma_irq_thread = acp63_sdw_dma_irq_thread;
>         hw_ops->acp_suspend = snd_acp63_suspend;
> @@ -484,6 +485,7 @@ void acp70_hw_init_ops(struct acp_hw_ops *hw_ops)
>  {
>         hw_ops->acp_init = acp70_init;
>         hw_ops->acp_deinit = acp70_deinit;
> +       hw_ops->disable_interrupts = acp70_disable_interrupts;
>         hw_ops->acp_get_config = acp70_get_config;
>         hw_ops->acp_sdw_dma_irq_thread = acp70_sdw_dma_irq_thread;
>         hw_ops->acp_suspend = snd_acp70_suspend;
> --
> 2.34.1

