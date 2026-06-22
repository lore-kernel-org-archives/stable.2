Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118E379C57;
	Mon, 22 Jun 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134691; cv=fail; b=Nvwy0vw/NcB0gio+pftxbic+xLA7peeClLIDcxj+bXe/Uu99MFCHfLQCxEoltl/YREc2kionjbSZDGRWZpOmYI722FkVe0+sv7ni9ndtQRez1TEOzYoge2QY304Asxjnso16OY2I8zZm4Bt/6XFGnRlCZ27kGUssbLIZA6Bw7Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134691; c=relaxed/simple;
	bh=7njEvVlv5BCQG5G0tHk/WqPOD4iBYf2cmW5MG/wpk0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CacBtt13Cwk0mJl8E+jUX5+bHYJPKlyTu5nqM1+P4XIU5WE/0MF7mZgv2EE8N/LbDZsHZ3GP1fzVeIQgw/EXXrcU0RJFjBlBvNXO0yX18vb0OqgmtHotRbjNfJKYYNypN8iM1Ij6D48wSLyjGumRclF4KCfBXO7ob+STPb4Z/Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rxsgRj0U; arc=fail smtp.client-ip=52.101.57.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rxsgRj0U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWfOfVgwVCjTkFCYcxoaNiZDZWsPr9ilD+3ZAEtw4HkYnfGps7GhTEhe6K5xXH1eGhZeE+qf6gaRhBtYTS2ro7w8F73IgfbqSJJw9yTdVwJlubWZ8Sjry0Nl0AQkGME6Zox1FMhAic8t1T13VxQQmkEEqptBq/1vWiS927i2QR611llnmKBaNOiMymh930ViEvK5OQocwCEWYw8GR92wcuTx1GJbik7DBb6429IjbsH7qR2w9bOFv2ZOw5zyMzvm83a3NnHooBds5biitIWyZYR/QCVqboveQRDt6LhbVWZOaSi8yrYOZFpxfa5jfZEhUAEgktdkPvlP/ZOim3Mh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rUXEZgcq9Y2E/3aP9SFG9L0DowPvlknkAD3D4G0Ef0=;
 b=GIyZQfqrQCqXbd7VttROwv2sr9xZ3b1t5+wAAmd8fav0hpRtPyVt6fj4iL100APbuOQIEzGPI8LcmGsmQT6h//d5wFRy+ugs16ci6h/Z8vQOdzOdbWr8x9lusGdY54+xzUiFRszpKczm1RZdNWQshhzK67sMDulQ2Ojv88YzZy0ToH/fGEjPDsKN+IqICsr0S9ozywdKgMEKrSGegLDvklHdaIiIPkkn0ij29SZlmp9cZHtyqvkH6J6w4RLYKl+2p66DhaYLPfAxtI9SZlPELGCYAUD8z1Y9QmunSTCEF2gA3N2bu4m4BzD1/L73I47DBJX5f4ZWfB3RltIr1UhJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rUXEZgcq9Y2E/3aP9SFG9L0DowPvlknkAD3D4G0Ef0=;
 b=rxsgRj0UYfvp+o3kSoUF9DoPRvEbl7GnVtpPs28gmQ+8n4Fn7GRnsCCUecPGEGktHWWnpGmTMB0STh++mzmagpelA7Jb6sAs9Yn1JpG+4XOrmc3Fwa7mAIufLmoxTrcVHRZh5+1Dv0uKFNod/TGWoey2NNcajD6T4emorv02Nkomb3ijFMBvEpIYQlC3bEA1vWZdMXwzzC8aRG5vd2rgryzSfRCpW6RojqdHpHwq64h43yEZ3zS+QLZUQT5X1OIIe8OnlCqxTQTJyzE8h1ABkZkYSv7w9Vm6q38KzgvaUXRDuClusXsEa4MCr+DFZJ7A86rME/bqpQIYqvMySQu4AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 13:24:44 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 13:24:44 +0000
Message-ID: <169ef7cc-e1fe-46d6-95ca-0f3514e806c0@nvidia.com>
Date: Mon, 22 Jun 2026 14:24:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: tegra-xudc: drain EP pipeline before
 dma_unmap
To: Vishal Kumar <vishalmimani008@gmail.com>, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260606024011.1160110-1-vishalmimani008@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260606024011.1160110-1-vishalmimani008@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: e2694c70-b1c0-40e7-2f7f-08ded0619fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10070799003|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fWWolRiyBuNlAIkMFEmKIp2th7yoOCVN1CJsannU4Bcld4ZDhB4YY10/1Qg6RyEt0gLetNL/2nQEwikh9R9lF4IV1CJr+1HpDnyGOKymdRwMQ/4/mQEeYTvGonEfn+vYbC7oEFIORCqEqpxOUTs1mJqN6ALmAHji025p7n4JVYQ5GqJoWbT1eVcmeGiJSrSdcBhIb0TOdfF4fXiYkZ1wrc+kxS++sMpTC+MKomR69gy7HBBOFzyeidGAjNaDpvbYp/Ssa2zJ17+iLJ9UcsN0mlgGBS8uhrEmdkFWsJj2uCUr8hU5QY2iTBg8Qih+nPGFPyxiQdfYyveBNMEhPs5sKFkwW0DoPchtEi7kmpxI5GyHZQwHrTDX+717XlPaZHUUC/ZzGXFCXGTt4GJjx+8TfqR2HPH3MSlU/Sw2Rl/+CN1DthMXTUw1i5h1H1/2IdZZ6IRmlvZ8ROiolJyCO55jaLFsUTFdfJwBvZ0JeYoD4p6jE+oNRuk8i2lvF53Xu3pKoxLN35yKKcuSTcbqp2EOwKclySxo6TcKGNiEuwNNEsoSgMZoWfZPOc956TEzHsTfSY+ScQ9866JWFkkvcXGzhIzJ7HDjKWx34wT/9PgOf+QZFZuQpSfyfJvNztwTnnbNyt2Zza4IB8v83aJoVZyUT6K/r+EyKOP3+UncE2iy3J4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10070799003)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWd4K25GSTFqVm5idHF3Sk9KWmdKRWxnYUVuUjBCTU5iMFFxaWVzUEJHL0VC?=
 =?utf-8?B?N1I1bkFWTjh6NFVPRGtQbi95WlFaMDNrV0xpWi9rcmtZL1ZBQ3J5ZTdwZWxi?=
 =?utf-8?B?U2lYem4zN1BySktBREp0T2lteFQxeFIwWVJzMUNiUUN4bmJISG1YTkJ0dnpK?=
 =?utf-8?B?bjlBbk9vZWthTEFCRDhjZ0xqbkFVcGo2U3FZNHl3TlZtU0VtVDVXa2daQ1BO?=
 =?utf-8?B?TmZTeFNpUkI3aGd6TVZjcXlYdU9zZkZRYTVpVVJXZVM4Tk90UitEK1l0VEJo?=
 =?utf-8?B?VGZXOTFGamgxaVdnT1hPMEFiR2ZUN0FpYk1veDlqRDBWcEVyWVNEVEhZRDQ3?=
 =?utf-8?B?cHEwR3VZcVYwMTJFamxwWFNSL3VJSjNUUHVDVVFjZjZ4a1loa1hFaTNhWEtB?=
 =?utf-8?B?NXRvZ2FUUng4RHV0OWRHaXQvTFZvN0RTYTN2Mzg3UWpWemVTYSswT2Jadkkz?=
 =?utf-8?B?TlpZS0wycHNtZXZoZTh1K0J4eG5ic2Z2UC9xYlNkVHJ4dmVkNEpuZU9lMzR0?=
 =?utf-8?B?Uml2bHdQK2ttdXlKaHpoRWFNQzJnbDR1WFk0MlV6eUV5ckdYUTl5Q1hJck1n?=
 =?utf-8?B?YW12WjljZHcxdlZBVWVaYjJza1p2S1ErSDZKS096dVZ2a0NwR1RZKzlkQWx3?=
 =?utf-8?B?cVcwajhqZXVENUxHNU0zb251bytiZnVxcDZqYStwTU1iZHBuZTcxTDd6alBF?=
 =?utf-8?B?VU5JRTFob1lZcDR0cmMwWm1oeTY1VFhvQWFiaTNPN1lnekdZNnllNWZuRk9O?=
 =?utf-8?B?ZGVSZzM0d1dEQWR1VVI4VFh1a2FxMVhvUXFsMkFBbkZJOVQ5dEtUbWhWa0w5?=
 =?utf-8?B?cmtOWG5aS0pQU3hKQ1VXaFFIa2dWZGJkU3ZndGwvOXZ6UjZWeFFVMjhtMmhl?=
 =?utf-8?B?clB6cGlDQVViQ1YrMk4wS2pFNkNhZ2MwL1UyV21ESit1T09hbFNCMGFIcXZ6?=
 =?utf-8?B?MmlWUnJYaUh1OTRhSE9icURKZFJiRlEwY0F2U0x6SWJYWGgvYmN3TGZZZVNI?=
 =?utf-8?B?SWl5a2R0TVZVUE83N25uYWxGb0xXb0RSRUV0b2kxOTBnSHVVclM4WitJRnkr?=
 =?utf-8?B?b2pQcVdwMDhCN2R6UHExMWtleitOYjJOZkZUbjJzOXY0bThQczF6OVA1OFhw?=
 =?utf-8?B?NGRHblZOekhzM2JaVU95NjJ0RDNYVDVJck5Wd0lJUkpwdVJsT3J0TzA2MWhY?=
 =?utf-8?B?emRaUWc5aktHdzBoczY1OEUzOEkzc3VrSWVadHpEQnlJNDcvb2JYU0U5ZTk4?=
 =?utf-8?B?S3JXMjJDME1ZejFEU1orMytzN1A0dG15Umt6RVdyS3Fra0hYOC9JRTdGWWd3?=
 =?utf-8?B?T0p4V0pEM1phUEdMbzlYVU5qQ1RqR2FtOFBvMnM1SW1XbjVUR2xGTWs0UDJu?=
 =?utf-8?B?dmRBa1hiQ2VsK0FlTlRtTzNUQTNqRWFqQUdsMTdQZkhIakR6MEhOV0Fxdmwv?=
 =?utf-8?B?TkJjenhwY2pEV1ZCWlR0cmVxSjQ4WnR3WUliL2M1RkdPVFN1MFA2TE8yR1JB?=
 =?utf-8?B?aEhyNVFQeHRsRkRWanBWOHBCUjR0YlVXV09CYmhUUUx6eEF3Si8wWkNtcjFr?=
 =?utf-8?B?UGFjeTMyWTA3NGIvaU1xQW5jaGpJNC9ESVJ1U2p1R1ZQaDlGU05nYUlydkVp?=
 =?utf-8?B?T2RIK0RMZDJLUFdMeGJENENRVkJwYUJqVHI4ckZWRzZVeDB4UVlwbGdpQ25W?=
 =?utf-8?B?VFJCc215dFZXRnJqVmJPMDhPdmJ6VWEzTjlDcVA1bTFaclNxYlpwRFFnSE9U?=
 =?utf-8?B?dTBNV3BodGZqWDN2VWU3WVByQSs0N1dGajBBRC9kaG5RSHcyZWVIMmUvbkZu?=
 =?utf-8?B?Q2E3Y3NCQmVURHRhaXpsSGd0NHN6OVlOMksyNm4rSFBMc1F5MkNKV2NGR0Fi?=
 =?utf-8?B?ZnpoNkVxcjNHdnhpQU9saENhazdQT2xuUkdhWUowM2lxZ2syaTJqRFdVQmdk?=
 =?utf-8?B?dy9DU1hKYzdtamRvVUVXSHFDMGd0clEzTHJzVTF0R1ZuTWEzNzQvamdpalBt?=
 =?utf-8?B?aHFJK2xRRWNaVHpaQUFJcmJOWld3Nk16Wi81K2lwK1FHdGVzWnVYQW1YYStz?=
 =?utf-8?B?TnhFZk02dGhWcGk2SllxQmNTNk5xcEZ3cjBMZmRGRlRoaEZyZFBNN2xzUEJl?=
 =?utf-8?B?T2F0akR3UHZ2VkxoNVFsSVpOdGVYRm1qcEZCOHJRN0dxWGYzb3NSODFFUTMv?=
 =?utf-8?B?ZzdGMm1vQ0VyU2ZZbWpxUzZRQlIyNy9oU1VkdW9CN2dGa2hoeHVlUkVWVzhX?=
 =?utf-8?B?c1NyTkQ2U0ZCYndndkwrTjl3R25SaEdGdXREU3hMdlhPZVJmeGZjb3NVNk9t?=
 =?utf-8?B?QlJnZCtpalEvMG1tcG95NGpxWkg5aUlXY2wycUQ1Z0RZL05rWTNyN1FFZ3Vz?=
 =?utf-8?Q?PYVcwPIXkFlevmBAwIMafGTcixXJ+Us0PoKm+oJRSOiYy?=
X-MS-Exchange-AntiSpam-MessageData-1: vFw2Tm0mO0E4iQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2694c70-b1c0-40e7-2f7f-08ded0619fd8
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 13:24:44.7555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5n87VpZyA5cxB3JgnvmEOsGgfKX1Ci5Ix6o6ixBwyEONEbbOTlfd8h16bLP6YPilhf2ahVWLe0Pny3KGGWzBrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739



On 06/06/2026 03:40, Vishal Kumar wrote:
> On Tegra186/194/234 the XUDC posts a transfer-completion event when the
> DMA write is dispatched to the AXI interconnect, before the store is
> committed to memory.  Under SMMU strict mode dma_unmap() synchronously
> invalidates the IOVA TLB entry.  An in-flight AXI write to the
> just-unmapped IOVA triggers a translation fault (fsr=0x402) that
> permanently wedges the bulk-OUT endpoint.
> 
> Observed on Tegra234 (Jetson Orin Nano) at ~170 MB/s USB-NCM transfers:
> 
>    arm-smmu 8000000.iommu: Unhandled context fault: fsr=0x402,
>      iova=0xfffb5000, cbfrsynra=0x100f, cb=3
>    tegra-mc 2c00000.memory-controller: EMEM address decode error
> 
> cbfrsynra=0x100f identifies XUDC (StreamID 0x0f per DT), cb=3 is iommu
> group 4 (3550000.usb).  fsr=0x402 is a translation fault on a DMA write.
> 
> Fix: poll EP_THREAD_ACTIVE before calling usb_gadget_unmap_request() for
> non-control endpoints.  EP_THREAD_ACTIVE clearing is the hardware's
> guarantee that the endpoint sequencer is idle and all AXI transactions
> have completed, so the subsequent TLB invalidation cannot race an
> in-flight write.
> 
> Also change ep_wait_for_inactive() to return the readl_poll_timeout()
> status so callers can detect a timeout.  On timeout in the completion
> path, skip dma_unmap() to avoid the translation fault and force
> req->usb_req.status = -EIO so the gadget driver does not treat the
> transfer as successful or requeue the still-mapped buffer.  On timeout
> in the dequeue path, emit a warning.
> 
> Fixes: 49d6f3dd4abe ("usb: gadget: add tegra xusb device mode driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vishal Kumar <vishalmimani008@gmail.com>
> ---
>   drivers/usb/gadget/udc/tegra-xudc.c | 47 ++++++++++++++++++++++------
>   1 file changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
> index 0b63b8c0a..3f18beddf 100644
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -1023,9 +1023,9 @@ static void ep_wait_for_stopped(struct tegra_xudc *xudc, unsigned int ep)
>   	xudc_writel(xudc, BIT(ep), EP_STOPPED);
>   }
>   
> -static void ep_wait_for_inactive(struct tegra_xudc *xudc, unsigned int ep)
> +static int ep_wait_for_inactive(struct tegra_xudc *xudc, unsigned int ep)
>   {
> -	xudc_readl_poll(xudc, EP_THREAD_ACTIVE, BIT(ep), 0);
> +	return xudc_readl_poll(xudc, EP_THREAD_ACTIVE, BIT(ep), 0);
>   }
>   
>   static void tegra_xudc_req_done(struct tegra_xudc_ep *ep,
> @@ -1046,8 +1046,39 @@ static void tegra_xudc_req_done(struct tegra_xudc_ep *ep,
>   					 (xudc->setup_state ==
>   					  DATA_STAGE_XFER));
>   	} else {
> -		usb_gadget_unmap_request(&xudc->gadget, &req->usb_req,
> -					 usb_endpoint_dir_in(ep->desc));
> +		/*
> +		 * Drain the endpoint DMA pipeline before unmapping.
> +		 *
> +		 * Under SMMU strict mode dma_unmap() synchronously
> +		 * invalidates the IOVA TLB entry.  On Tegra186/194/234 the
> +		 * XUDC appears to post the completion event when the DMA
> +		 * write is dispatched to the AXI interconnect, before the
> +		 * store is committed to memory.  A subsequent dma_unmap()
> +		 * can remove the IOVA translation while the write is still
> +		 * in-flight, triggering a translation fault (fsr=0x402) that
> +		 * permanently wedges the bulk endpoint.
> +		 *
> +		 * Wait for EP_THREAD_ACTIVE to clear (endpoint sequencer
> +		 * idle).  On timeout skip the unmap to avoid the SMMU fault;
> +		 * the DMA mapping leaks but the hardware is already in an
> +		 * unrecoverable state.
> +		 */
> +		if (!WARN_ONCE(ep_wait_for_inactive(xudc, ep->index),
> +			       "ep%u: DMA drain timed out; skipping dma_unmap\n",
> +			       ep->index)) {
> +			/* Read-back completes the poll barrier; EP_THREAD_ACTIVE=0 guarantees DMA is idle. */
> +			xudc_readl(xudc, EP_THREAD_ACTIVE);

The ep_wait_for_inactive() is reading the EP_THREAD_ACTIVE and so this 
would appear to be redundant.

> +			usb_gadget_unmap_request(&xudc->gadget, &req->usb_req,
> +						 usb_endpoint_dir_in(ep->desc));
> +		} else {
> +			/*
> +			 * Timeout: mapping is intentionally leaked to avoid the
> +			 * SMMU fault.  Force -EIO so the gadget driver does not
> +			 * treat this as a successful transfer and reuse the
> +			 * still-mapped buffer.
> +			 */
> +			req->usb_req.status = -EIO;

The above is confusing. Wouldn't it be simpler to have ...

  if (WARN_ONCE(ep_wait_for_inactive())) {
      req->usb_req.status = -EIO;
  } else {
      xudc_readl(xudc, EP_THREAD_ACTIVE);
      usb_gadget_unmap_request(...);
  }

Furthermore, it seems that if this now fails then we don't unmap the 
buffer, but we still give back the request afterwards anyway.

> +		}
>   	}
>   
>   	spin_unlock(&xudc->lock);
> @@ -1443,10 +1474,12 @@ __tegra_xudc_ep_dequeue(struct tegra_xudc_ep *ep,
>   		return 0;
>   	}
>   
> -	/* Halt DMA for this endpiont. */
> +	/* Halt DMA for this endpoint. */
>   	if (ep_ctx_read_state(ep->context) == EP_STATE_RUNNING) {
>   		ep_pause(xudc, ep->index);
> -		ep_wait_for_inactive(xudc, ep->index);
> +		if (ep_wait_for_inactive(xudc, ep->index))
> +			dev_warn(xudc->dev, "ep%u: DMA drain timed out during dequeue\n",
> +				 ep->index);

Maybe it is better to put the warning in the ep_wait_for_inactive() 
function.

>   	}
>   
>   	deq_trb = trb_phys_to_virt(ep, ep_ctx_read_deq_ptr(ep->context));
> 
> 2.39.0

-- 
nvpublic

