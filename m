Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABC519905;
	Fri, 18 Sep 2026 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754948; cv=fail; b=fzGXlDr2ePahakHq/FIO/qdVujDtuuwd3G4ehx67JK15A7Az9eQz22w8AamDbIt/plYqPO5Y6QuAV553KcrK93i3Nu3Ez86yIg0SaNQiMD+juuFLz83dYLmZOCR8wRWw43Pt5n6kzeZdpl7qzb3zX6rMNTQoExSR0OZQXHAS/5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754948; c=relaxed/simple;
	bh=HzpIzenAX7CNaBEqYdky39pqaTon3FH5HvOUIR+4CzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WjSCc8uQtzihIIjEsUBsBdZKs2J49isobzx11wJMl5n6EHKu6JqnApSAxNpHrxJDOG9+ERAu8TJask0OTEdId9+dZ4hOctFh1jPVUQCdZNWAE9097U95UeW+f/fMBs2FDVCfiE4AiBp/DwKz8vCatrKc5fDSPekJzMXqu40TjVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ixj5bkQo; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ixj5bkQo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJxbTzlxGfTjZR6bG3MYa7IuBq8M1524DckJpSb0932W3vPUxXfXNNEOscQ3z35AkOxktRhbxGKMuUzOyOM0coC+dDPPI7ruPMr0QOrXIvXQS9FUcI27NrEmfgCHcx5iAMw8jPdtvE/T2O7bsriIGudPj1vWvaO+oCk541UkiryuEDe3eRexyAMv94hBua3Tbp4bzcj1xrn+PTmaYH4mnFKZXlsGOF65iXIj4UFugme+Pu1LDwPFdEPdBSBHBrt7hFJzgiMaxNYdka/ek8iBtQrEriUipTMZJXfdSJ4XAXKZRkvzhKM/YTsZIq1sLAWWdZKDPxo9EIga9AU47mJJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddG3RTP/bSnQN7AKIWy4wCF6mKnjjbqAUmtagm1hGBo=;
 b=emLHPk4rTaG+eHf5oZO+sdjWG3FBZAx37TaajsjBmvyEXei3g2m5xDZtaF3dB1SMOvxm/toK5nEfI27McHRS9CzWmqaa710rwviVRiAJtyzArC2U2D0hyL0aKjnEdZW3IHLmsGu/doUswT7AHKIsfnMkYXKLpFi79OtGwNBwdgrPKVtb/lLJB1D4dZEummV2sxM8BiSkA/pnDHKhZWkCxTlAKi8OfP6pEyIIIQNuu9SckfNroUIv14KaSMp49nRzHTPJBio/qZr/oE2gkWO3aCWiIc7mzh/+8Usg95I/9469CSerVs9cLS2Mc6NNix/OhMJIhAORUaUDFfe5ZPaj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddG3RTP/bSnQN7AKIWy4wCF6mKnjjbqAUmtagm1hGBo=;
 b=ixj5bkQoIM9qbAJ+EePAm10K5cRhFrhgTG17dCeqBsQTfGyl7QIGBYR2gIi6zXpBGsiTdR0WXsWt6BhMtggKHSGuHY3KUDqIJ9XcnvySvuoCA9BUNKacGPus7IRMJTqPx7DoU+0tfMOl9rUdMhXDzaYDiFhvxXHyxPzLBVTr3sc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 18:08:57 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%3]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 18:08:57 +0000
Message-ID: <18a8b7ee-d588-48be-bfe4-0b79309e3339@amd.com>
Date: Fri, 18 Sep 2026 12:08:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Preserve eDP mode on initial ASSR
 failure
To: Arthur Heymans <arthur@aheymans.xyz>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 michael.mityushkin@amd.com, nicholas.kazlauskas@amd.com,
 qingqing.zhuo@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Zhang, George" <George.Zhang@amd.com>
References: <20260912151137.3913987-1-arthur@aheymans.xyz>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260912151137.3913987-1-arthur@aheymans.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8ef721-8615-402e-1462-08df15afe867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YY1HkPNCNaKASMRMUYi+Q4dpHEpJkrmwnWh6uUqO9jXz1gkUHZ5u3ZQkPpZ4+y/3HnGr20IXlbaggIi192eIij27PeRGFVZBB3sqtCjwhtbwlUuQ4I6OytoQ7swSwUCcnMnTX+lr2AZbr/wZ9DjNGfOo6vHecf98Fdhd+x1j9M57b+OrDLCCYMCIyEvC1sUFmrKLujAv60KOAKLCyvVN8p6m6PNHPnPBmEso/CCkBJOIkp4p/HpuS0ydLohrXLwn2m6BSckvi/jrvvMJE4pP0S7IlWOb9ipUh/lCNhhWJ3Tv0bQ0k7kjrz+br7NGQVTpDHhZjceIzUzAy7foPpHTUe0Bx0uqL1/PTSEb4K2MNw0zlRNwBRCemmnR3okjroxNREIDbcCGWyNiB76DDtZs9JBihWEsdnVRAWNmjqKf5LOr8i67bqOQgsHfFxBtgJkAxjHwbrxl928t2ImJnf/hW0o9HTXEThhuVW4DPBKYOCoPvfdW41c7hNNxzWlwdbsf/JD8GhdHrzy8AODSmFwIqd9byMqC+fV4a+Yd4nBXVZBSYBfg1V7N2AkfEib0kICgrvg2a6dYA7PaEcfqc9KhMtL03tfLHHCyLZAGjQ+vggYWZuJzH/fMQQU48f9hdeoO7Vh6G1ackTNLK6CtyFBu92Asel7eas90AnHqmka0z90=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWNuQTJDZE1YQ1FHczVLZnNLTkpuTGJsclQxZmpESTNVU0M5WGV4UVppQlF1?=
 =?utf-8?B?SWRIckJuWE4yLzVDd2RPRDByUlBxV3h1Mlc4ckxwSGo0NUFSWTIzNmpEOEd5?=
 =?utf-8?B?L3d3aVFicE5UcExrMXIwT3Q0MWlkNU10Q1o4anVreklDdFVNVFdtdWhVRWp0?=
 =?utf-8?B?MzlXYllNZTliaWlWdldwbCtBMGRMaWdINWMraktPWG81RDhVT3Y2d3BHTUdn?=
 =?utf-8?B?dXlNQ29BUmdmUVpqaTZSUjduTk1HdlRBYWtoalNSQnZGb3hZRE1jVFVYWUNX?=
 =?utf-8?B?ejJiR2FlYkhxNWtyeDEzQjVGQU1KZ2Yxem9EZ1ZQZVNtNGxzcXZzTDV0T3N0?=
 =?utf-8?B?NDg5MnlnQnJOTGNWZkxiNDBoajJBMEU5TGp5NGFJNXJUdTVleHRFdS9yT0Jn?=
 =?utf-8?B?SWZUakJIcUE0ZnVkUXlrRTFVem8xQldSNE9ITDdpemZmYkRHd0hlWlhZSkNT?=
 =?utf-8?B?S1dTZHJWazFidDZ2MXNrMnhrcWdDYm9vdm94TkZtMmtyWS93NHdkTDVzNHRX?=
 =?utf-8?B?VTJ2cC96VDFrbzRNQ0dKVDl6YW01YkVlTllPbmUzbzZFUUJUUDFaT1FncGRO?=
 =?utf-8?B?c2lNVU8vQ3FiaVNHbmlidmhvRXFsSHpVVzlJYWRvcmFmemVCWFlWaU5FUjBD?=
 =?utf-8?B?NGlRRkIwMXYzZUdFRUdrNTlKTGtXKzBhQ0hWN0hXNy82QXhrTE1oZ1RDRzJk?=
 =?utf-8?B?eXhuMmo4bllFU1pocUhOWmsycUc1bTkxNUJBMllJandsUnVIWWljdG5aaS91?=
 =?utf-8?B?MHlwMU1rTllOZlhoVTlTYTBsUVdpNTducjZlbStwN1RLQnJIT0pLcDAwWi91?=
 =?utf-8?B?QlorYmNVSFlTWE9XN0U2ZHBZaXhPb2Nwa3hCMmhwSVNrc0xLeDRwcHBjN2Fq?=
 =?utf-8?B?M2xnbnpUVFI2ZzY0QUtmd2lzSFFYWUNzbWNCT29rdXNxZVo4b3dBenZodG1B?=
 =?utf-8?B?WExHNFlCS09NRjNLR1ZOQjlHYTlhNkU4T2I5NzhGbkhjYUFCL1FWT1dMRm9W?=
 =?utf-8?B?TWNXVWNIdG8wYnhXMEd1Ym5tVVR0dzdxR0U4eUF3VFExM1BINjFVUVh0bzY3?=
 =?utf-8?B?NE14Z0dZRDJxZnZKZmR2YWtvNVpHVlF0ZFpiSFdPZERDT2wyZHp1NndOYnVt?=
 =?utf-8?B?OGlSK1pOYlZubUVPVDRIWU01L0JpMGdHSUZzcXArMHI1aGwySHVDUWFmQUlt?=
 =?utf-8?B?V2hUaG5jTEVGOUl4cjNUVjl0WWVhRUVPVXBJQ0gwYWNNOG1qVVpRWDQyalVv?=
 =?utf-8?B?dGQ2MGQraHk5YlNNWWd4U1hSNGFvYlZ2ck5SOGNPNllPMGR0MmhZQjk4Sk13?=
 =?utf-8?B?cHdCUjQvV0wxVVJYVUV0L2JWUkd0QjM1UE93R29DSmZ6KzREQkVGTnYydnI5?=
 =?utf-8?B?N01VV0lKQ2grMDJmdDQ3YWlENUJZblhpK0orQVAyRHBSRitwbGJ6Tm1tbEFJ?=
 =?utf-8?B?Q2d3US8zbnViZS8vcVBUd3A5TXNYQUtVSVArQTY0NlhiN1hNbjhja0hDckhM?=
 =?utf-8?B?WGtlWG00czlaSGNBSzAvMFNacHMyd2xlSklXU2NZTnh2RzJBRUdtQ1ZnbXpU?=
 =?utf-8?B?TUY3S2I4K3hiaWMvK0NxdTdnUGIxWXMvWnVkczdIbzF0SEFYYm12YzJwbytJ?=
 =?utf-8?B?MjVzVmlhNENMUlFtd1J6U3VYbXl4UmJVa0hub3BlZDhiRnF4bmJrSzZsa0dt?=
 =?utf-8?B?bUNQUUJkSmJXeVZVblBSQXAySFhFWTdZUjdXaXZnWGJ5NUtFKzlWQ1dsYTVr?=
 =?utf-8?B?ZlBvYTNnVXZRYUlwSTlrdXc3YytkSm14K3BaQ3BxRnVXWHRjaUlwazVzY3ZC?=
 =?utf-8?B?RU9tU0pKSFoyb3dFUGZqOW9hVmhjTi9tVHlrZ2RnZGVvWmg3c0ZsVE5mUlFD?=
 =?utf-8?B?NVIvWkZ1RmQ0ZGNQNk5Sa3N0SmlZRFRKc0NQeUZjTlBZeUt1bXUrK3EwZ2Fz?=
 =?utf-8?B?dS80RFMyTml4Y0NNWVBhNVB4K3grbkp3aVQ1dlpNN2VZTFBBM0EwMXpuRFVJ?=
 =?utf-8?B?OTNKS2lZa3pkQmNhbWs4dTlkU1NnaGtYb3ZwLzc5TjR5dEY1RlBONTdLMDkx?=
 =?utf-8?B?a3lKVEF5d29LMnkvM0RKeEN2VWRFNW5EbTQ4akRFNkF5Y2RjOWgvZk1BRUNj?=
 =?utf-8?B?Vi9FQUk4OVRTblFzUkNXbDVsUmowYUJvYWFpZEhKMG90ekZ1NTdINGlRcWRE?=
 =?utf-8?B?VmdKMWhyRW1uTzg0ek1aMjROYzROQ2NRd2ZHcGNkMUQ1T00wQ0EzRUs5cytK?=
 =?utf-8?B?UjlNVmkvVHFpWHREM0JWK2NEb3NnMlMzdnJrWVhHTjRSQU9yTElKZkJJUU5M?=
 =?utf-8?Q?7tWn2wZMhzeKsi7vIK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8ef721-8615-402e-1462-08df15afe867
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 18:08:57.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVVfWpJLv5FM0+u4T7Fg+DYxZNgeCoOJvHxvHhw7uZLcGCi+zsPYJxA+/RdJzNMXjBrnGfbBCPssDEA+NQSoEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 9/12/26 09:11, Arthur Heymans wrote:
> [Some people who received this message don't often get email from arthur@aheymans.xyz. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Commit 56d8ce9d8c17 ("drm/amd/display: Apply correct panel mode when
> reinitializing hardware") made ASSR failure fall back to the default panel
> mode unless eDP mode had previously been applied.
> 
> However, dc_link is zero-initialized and DP_PANEL_MODE_DEFAULT is zero.
> Before the first call to dp_set_panel_mode(), panel_mode therefore looks
> like a previously applied default mode. If ASSR setup fails during the
> first link training attempt, the driver incorrectly trains the eDP link
> using the default scrambling mode.
> 
> On a Google Vilboz Chromebook running self-built coreboot firmware and
> PSP verstage, this leaves the panel mostly black with corrupted output
> along the top edge.
> 
> Track whether panel_mode has actually been initialized, and only consult
> the saved mode after it has been applied. This retains the recovery
> behavior while preserving eDP mode during initial link training.
> 
> Fixes: 56d8ce9d8c17 ("drm/amd/display: Apply correct panel mode when reinitializing hardware")
> Cc: stable@vger.kernel.org # v6.4+
> Assisted-by: Pi:gpt-5.6-sol
> Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
> ---
>   drivers/gpu/drm/amd/display/dc/dc.h                           | 1 +
>   .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 4ecd5699ac5e..0db55a73da0c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1912,6 +1912,7 @@ struct dc_scratch_space {
>          struct ddc_service *ddc;
> 
>          enum dp_panel_mode panel_mode;
> +       bool panel_mode_initialized;
>          bool aux_mode;
> 
>          /* Private to DC core */
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> index 9883216dcc9d..cd90576bc6f0 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> @@ -93,6 +93,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
>          }
> 
>          link->panel_mode = panel_mode;
> +       link->panel_mode_initialized = true;
>          DC_LOG_DETECTION_DP_CAPS("%d eDP panel mode supported: %d, enabled: %d\n",
>                                   link->link_index,
>                                   link->dpcd_caps.panel_mode_edp,
> @@ -1300,7 +1301,8 @@ void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
> 
>                  result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
> 
> -               if (!result && link->panel_mode != DP_PANEL_MODE_EDP)
> +               if (!result && link->panel_mode_initialized &&
> +                   link->panel_mode != DP_PANEL_MODE_EDP)
>                          *panel_mode = DP_PANEL_MODE_DEFAULT;
>          }
>   }
> --
> 2.55.0

