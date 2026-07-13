Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900636404D;
	Mon, 13 Jul 2026 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937924; cv=fail; b=VDwfHhxTIiJFubCkveJP8ZAX+lFcPSO/iuFPs8NpcxGlh4BiKPfN0FlEe2eg/H08fsD0hTYZvRm094bjMEqlKNS2O0tEzIxollu+d9V2FLUSdZMb8UqEtccGYmIKT11DX1MPD1OQXvbZNsFtMfPDrL10zk5YLkzx36vbW66Cw9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937924; c=relaxed/simple;
	bh=QbzxBv7z+5TUg6dAldTE20a26xfHZBdEZ6EFDvYZhqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X05uiQ2zmbHUa217pFdLb1PrYcdrV2ERj7VTANQEhpdIXVYkddhAMSDrrQlOA/g7Dqr7PA8rdaPlXQX6E3I3YQ2GOaME3YLMJPb8KE9ckQ8dvwbrUuaZqm6wgtBIhMZPIzns12ef8EhldKSlRGwsuWhAThbIF83qOXJ570OGiss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iRcKa5Uo; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iRcKa5Uo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWm2oTxs92k57OVn2h1rkkoL1gGF+yxQYkEmsBw6NYEe4Tzt/XC6/UJKxEdV7YddAXillczP3VHD6GaPhEHf5UMa4E+v29Oubt/G5FqUquxCvbYOdCwA6YvA4bIu1lOtXRIJVXLHzVblv4oiNx6y5nz21CGCBaBkSXEhk/qKPTCpMx2bO7NqMxbhkrDgIFVtYGEMGOtqbIhUimtk0tw3J692cnueEb7BlkzIVAqEBg+5UHX2oiRSjNtgKtMyi3gjJR0QzRblfOzw9oXvj/BNqgs+poZVG+sZJcUWAcHxxPm0EFFTe/1nlP848uiCOhGz3M5VgIvGh33Isxb9nzeJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqrfvCLkQFsAZx+AIjJfNSAF0d+wmM90O/Kh88mJGZQ=;
 b=kXWd719WQaauP0Ib1d/TQsvzr1z5qvqeVfGzqnTsUsGYw76wkTpY9XNQgOfIuiSUTe9VbV/WLmpFm2wuHHXXtzRnYQW+1oJzIgfTkQTISzYGoHLNEEokjs21eUOTUTas4kawAj7BHi3jrfMxLDoC4eBohvrL+LIsZVE2kwM7RjW6yRenzBUtlKtvyfKE6IKS0y45e6wvASeYsGJKqHXP2cB5hYV5njwUV3g3vqc4gV3HylkWBgG7DMYmnTDuq49UVx/XWsJuIX7kV7YeIB5yPnTQTXPSaxRg8mWi83lO348LnOzfX7e+I3ENtfuVgmzz8seqHoanFW3d3huBkVZT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqrfvCLkQFsAZx+AIjJfNSAF0d+wmM90O/Kh88mJGZQ=;
 b=iRcKa5UowOj9UV9uOyyUlzPwAiV+DIEkNTFDwtIkH0/EkKU9bPjHMYMFQzal2lBCYRygOyVHJU4ZC/GYarp0JWbrzbbHXW6/wpx3oQH33YAaZYuqrmEZeaNu6WSYo4aOAJB7weHowTvFr/oozD7Jlc92bLI/SRjnartQKzhIqYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 10:18:38 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:18:38 +0000
Message-ID: <029eb9a1-b767-4738-8e91-74fed66657b6@amd.com>
Date: Mon, 13 Jul 2026 15:48:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-quadspi: Fix indirect write timeout when DMA
 read mode is enabled
To: Srikanth Boyapally <srikanth.boyapally@amd.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, git@amd.com
References: <20260708045148.2993313-1-srikanth.boyapally@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260708045148.2993313-1-srikanth.boyapally@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::14) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 5becff5a-72b5-4eb1-2922-08dee0c81a87
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	JRNfzGilFQ4byShiHhgU7gs4a6igrzsIdOgx+ifuIzmHckgNsi1KWjyb344EkDTRjQu1FjcIudLEzAmo6z2Pqq/bCWV+c1Lsqi5KEWbWER5Apj6URfRmakvZU/WbZBiJUb+QZ8+uDCwEFyXhvVI9VWBFjNb9Mb2VjxmyuVvFNkmFvSdiR/4ZfHW/YUtFV0SYO/6SSmy3GJOQq+i9RedEntNDT7G5Hr877yfCLHp9ka66jNH9o02//eo/XxL/zO5KuogCZoeAw+AgPzPZyLzR1Ih2uRydX6IBkArAr6S6nZSTAjy+F/03V1NpPBkx2icLF2/U6M6qpEAdKPkWu/ANUzn85eH1bg8kJ8Hj61WwCwgvv0s6g5u0afPepBDoawJlCTjxwIcQwWjBuUwwDqgWVhShuVn7+Fyn77Y9bg65ZpqU4+1CndWClb6vggP0LzM+lZPh8chfVGcLQyrkogGwyRTqgKMRrb5/ZXdZDlXEDA3R9V5G4uNPnXQR0iMFrTOO06NOFHjC3+jcNiozmhXlHZsgesFQjb8uU3GEoZv+/zInC7RA0o+phBGjBrwSUC7bJvSglQ1UmZNM7Dp0JZ2dqpMPe/vvrjOD+ueY0NEnHmf79uFcPl+5X7cqtkC9UqCXfnuuhOaXAuJ6nrAx1bV0v7aET9f9mO81Ewi86NfnkwQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW45MHN1Mk12ekNKL0dYSGhzN0JyV2E1Y0Z5bGlMZHpnSWpDMzI4am9SOWY0?=
 =?utf-8?B?SVdHdEZxcE1KeFp5bkNQWjd1RnV4OTY3WStyekhLQ2s4c0pGRUpjb0NuUVMx?=
 =?utf-8?B?U3E1SFhvSHZNQWNvKzBDLzFpcDQ3TkZ0Zy9NNmFFZkFoT1RoSjFDZVFiVTJW?=
 =?utf-8?B?c2VBUXNMbGhyQXRQbXpuQjVoZGVzZjdIN3J4ZkhPYnpyM2dLY0lyUzU3d1FC?=
 =?utf-8?B?SnN0UlpNWW1aNnh0RkhzdCtITnN1QXlFMFFNcUlpTThuZzVPR0ZPQTIyeHlP?=
 =?utf-8?B?czJMKzE5TFBkOWF4MXdlVlB3Z1VqU1BtelFiSWt4Q2VZRFljS0plaFl3VlZN?=
 =?utf-8?B?UERmOFQ0NU1XSjlzdkNOcmd1VFQvU3kyYjF2cnBPMkZLTml1UzNvbFZHUjZl?=
 =?utf-8?B?YkVsdEgwQm95NitISEh2amxkWVdMdk1ZQ1gxeHJHMVlJd0lZd1dGSytpNDJU?=
 =?utf-8?B?N1NxZ1pJaHd1MEFjakdDeEdIbUYzNjlmRFE3S3ZwSjVxTkZpZHdlQUw1YU80?=
 =?utf-8?B?cCt6S1VzNytMS05SWlF1Vk05U3NIcTJXM0xQS2cwYjJRb0J3ZTZOTFRqSWRl?=
 =?utf-8?B?WjF3WXhFd29sNGlPeUVGdlR3Yi9ka3JKM21OVFJoSHlUOG1wanNUWkNDQjhD?=
 =?utf-8?B?cC9HNDZWQS8vSEZyM0k4Tk5KcmpuWUdnY1FKZVMrTVc4cHliWGhwRDJGR1hO?=
 =?utf-8?B?TWRCQTdMZk4rWEJyU0tTc1Qrdm5aTURqa2NyZC92eXBrSmFXM2w0Zis3cDlW?=
 =?utf-8?B?SFFwSnpBR1B5OURLdDhaT1kraEcwVDJoUGdPbGUxTkF5b3hia2pIMVJrRnJR?=
 =?utf-8?B?NVVXMndyYjZDeHdpd3FFbk1PV1Y2REFVcnBHZ044dDZ6RmdyUFlKZndrZmhJ?=
 =?utf-8?B?RGhpcjNRTTdCVVdscEQzVkxucmkvR290clZkS3ZtMTB1cnFxNmRvWU85MWF3?=
 =?utf-8?B?VTdlbENMemJvNTVGbDhUd3VwWjZXT3JyeTlRNVVvUG5VaExrbitaQ2hib1lM?=
 =?utf-8?B?VmpCeW5mSWxtdHhmVFhORkxQdFVTOURmT0RyMEJ3RW8yb2Z3RWh1VnMrVDZW?=
 =?utf-8?B?bEtJaUFYamlSOXYwaXk2SkQwMEpTVGNDTVdoYlZqRE82TjZFRk52alAwYjUy?=
 =?utf-8?B?eDhNbGJVOWppOHhRYWcyc0JiTGc4dDN0eC9KdjVhb0JkMWZxR0h0WUFaME5j?=
 =?utf-8?B?WW0wcWpHNHJCWjNUL1NVVDBVdmwwSUZiczhqTHdoNFFEM2s3dXZTbUsrUzk3?=
 =?utf-8?B?WXhBUFQrYnMwQmxQYmIvUStCSmxNM3JMMUgxbXVHeW9vNW5BOUVUQXptSW5H?=
 =?utf-8?B?VVNabHpSOStza0gwYTFFeXNOeGZNZDBMNjhJeE9jMmlybWhvelQxOGsybWQy?=
 =?utf-8?B?dmhUMWZDcVBnN3I1L2E0RkwyMkYxTzlEM1RTTmdpbkV2YUlxSHN0VlRrU1Bz?=
 =?utf-8?B?d0M0MTgyMmdUODAwVER1TnBQb05pdHlPNGNLazdhaHkwYkFwUWpWNzRnUjRX?=
 =?utf-8?B?ZStOSnk4bEN3bG94S2YwR1NRQTlHQVFlbjVvbjB2N1VCcGNZWDJFN0xvdEkr?=
 =?utf-8?B?Q1V1Z1dncGNCV0paOHdPditWVDNEZnFFM1Q4Q0RwTXIvOVRuQXRGd3Y5TEo4?=
 =?utf-8?B?UzhLR0JQeGppN29lZzUyc2RrOFBtb3RMbXFUdEVwUGRGbWgzeFVmbythb05t?=
 =?utf-8?B?Qy81MHQ2U21vV2FCd2NhQktFQm1Wc3FHVFRBOU1SMG0xRE9pNWtPZXBBdVVw?=
 =?utf-8?B?R1BueEl1eWxxWnFEK0R3Ymtia0p0NHdHbnRnYmhYVXZLYkZIaC9EeVluOXM5?=
 =?utf-8?B?VmRDSnV3RWJOMk1JYStNVS9tOUhVckw2WGJkWGoyb3pMSDkyS3hCT2ZjeGJs?=
 =?utf-8?B?VEIraU9sUXVValQ4OTVpSGN0Ynk0OFplMjBIUGp5Q2NEdGtweVNCWUlWMTJW?=
 =?utf-8?B?MzdtWkxkaHJPOU9JSGR2YUdQN01GdUVDckVwSU5Ia2lNa09ORjNsazBRQmFX?=
 =?utf-8?B?MlBpNTVJZ3c1NEI3SnhCT1J0TStncTBWa3Urc2VQVTN1Z05uRzVIWU1PY0Fx?=
 =?utf-8?B?c0Fpbk1HcFRjaVdoSWl6azUxZnlzVFZmMzU5K0xRZDNEeHVJZitHSDk0b0ti?=
 =?utf-8?B?VVBXMHBCTWNuWkJzRHZCMjhXKzFOUDFYVkI3b2ppMUhGVnNkV1F5bWg3WHRG?=
 =?utf-8?B?R2lSQ0VEWWRMbjJKemVSVDlSanE0czJIZVJsSnpHYVAxOTVYN2ZnV2xSdmk3?=
 =?utf-8?B?dC9OdkJ2OXVTUHV1eXhSREhaZXpNL3dOYUNZbFpkczN4cEovTG4yd0xIbFVu?=
 =?utf-8?B?UGs3REJCVHFQNSt1Mnp4bmZ1ZHZQZWxyYWN5QTl1di9FaXUzVnhCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5becff5a-72b5-4eb1-2922-08dee0c81a87
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:18:37.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMMYtppTyj5iG1HZsRV0naBSTH11DZGQgXWYxe38R5FTEFJ9CBhBxy3AKFruHHp/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352

> When use_dma_read is enabled, the IRQ handler unconditionally overwrites
> irq_status with the return value of get_dma_status(). For write operations,
> DMA status returns 0 since no DMA read is in progress, causing irq_status
> to become 0. The subsequent completion signal is never triggered and the
> write operation times out with -ETIMEDOUT:
> 
>    cadence-qspi f1010000.spi: Indirect write timeout
>    spi-nor spi0.1: operation failed with -110
> 
> Fix this by separating the DMA completion path from the write interrupt
> path. If get_dma_status() indicates DMA read completion, signal completion
> and return immediately. Otherwise, preserve the original irq_status so that
> write completion interrupts are correctly recognized and signalled.
> 
> Fixes: aac733a96636 ("spi: cadence-qspi: Fix style and improve readability")
> Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>   drivers/spi/spi-cadence-quadspi.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 65aff2e70265..89873f8b3f21 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -382,12 +382,16 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
>   	/* Clear interrupt */
>   	writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
>   
> -	if (cqspi->use_dma_read && ddata && ddata->get_dma_status)
> -		irq_status = ddata->get_dma_status(cqspi);
> -	else if (cqspi->slow_sram)
> +	if (cqspi->use_dma_read && ddata && ddata->get_dma_status) {
> +		if (ddata->get_dma_status(cqspi)) {
> +			complete(&cqspi->transfer_complete);
> +			return IRQ_HANDLED;
> +		}
> +	} else if (cqspi->slow_sram) {
>   		irq_status &= CQSPI_IRQ_MASK_RD_SLOW_SRAM | CQSPI_IRQ_MASK_WR;
> -	else
> +	} else {
>   		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
> +	}
>   
>   	if (irq_status)
>   		complete(&cqspi->transfer_complete);

