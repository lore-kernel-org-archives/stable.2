Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71639CCE3;
	Thu, 17 Sep 2026 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685089; cv=fail; b=azD6u9b0Qoqe5vZv/6TxrX2xx5yqJADcNZuXSlN7oTSpoYcLSju0ckBW6xWYv10j/x149zNryLqrvGhf0A+KN/Y1xc+5pz7ZIY5ihpCOhY4WXR8peIcMy92JykbPRijxFI99BCJjGYCjTPrOEah7d1ag8SurxgMWUN6raxVXVeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685089; c=relaxed/simple;
	bh=TreEN0cO4OKKqJAGvTcdDJD4qSA6Pv2C/GcoBFumF0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jCa8v7IWdVpYilk6qE6GEhaeVbmTzpZyjaOk54q+RTzyU8sXt8ul56QlX0aYw0RRDEje3aQnmEggLZQ2vKaKs5KtcGAv0Eoe7E90DtkD4BRFhydiiDl9QU9lrbrkVraJiqd2CsD6UqQ/d2jh2t+F64mLZrOFKqcCmG3sZCcUzHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PvYN+bQ9; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PvYN+bQ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU8BcMUgsUfXlcMHVwjbCxypADpfcD1YNJ/iC/UY0VVRAPaGrgEp+QyzcRo5FZF4f9f8kZy/DM40XyjOprsODIFGe+W/mFtqq6fQ2C5xmJsGQzaEJl+Chc4ECg3LJDlfqHgNfPuythvWwWqyJMzo3mplzuBSMUcj81gWK4IQiFKWMnl7AscRj5TYPDtSoEM2ZpXuFhMeFbBtxZbzsukkPa9qXHOhiJa2fBB2tGpSE0k2Vw0LHZAu/7p6qPKMxGoB9bjd9BMuUmK+eIapStG+FwKv2jBZSnHUvrQpBU4xd3rzAUVORFraRJK0iO5qE7r363EOJ4T1cHBpv8TAHosx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7DCooW3ePhN66Ia9ccbSNaOaJ7OWSTl3aFd5aTZDlY=;
 b=SJ1JtEtqqI1BCD/40LMYt0X9RIbaPf0RQaHrzCtjpOsEgX4KsepgYYSJyXaD0wxPbpddZPx5k8sDaBbvEfYW4c74xvuoI/vWwMl89QGSi6kUiNyIsQC2wSi7nkoFCMPIKVWI7qefC8FhCrvzQOOW5ebQAqFNpAd1Cm+eXgS4PDMSLM/Sb1VCGtQilWtXdu5QYURpeiK5Xpt7C6EQAmnCqNCE5TkBKvs+Ax9Hspe6AB26XDi0W1TQmsK8G/X6e+8qLINRiyaHMsCvjeCLQzib+NzTdCrQ98O8tELACZwBYWRUMSIIWDtEdDWzdx5XgTY4dOpKKCZypvnTU/gzdePFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7DCooW3ePhN66Ia9ccbSNaOaJ7OWSTl3aFd5aTZDlY=;
 b=PvYN+bQ9tc/ubhaYAipjw8iteTiQITDdBpJkmHjMR9xXk/S7rJKYXqP3934pdwwFCh0u6HJ2psKAj+Oxs4oWxDK0CF2m7vzFe8rpbYY4vYIN2/qDGn84MY86nvKUR7mifZ1jmav1PeNZiYOS9++a7B2fIbbRQuZmxrACMNOxr7+V0SsvW3hCs0PWUasMn/tifri6XoTSQbdGDWJxKJlZWZIEo3lwyrX0o0jVWk623kthhO52z35e2UnnJ9DyqQvTRCtxBm4Pod4UhwM7/VkhMbW4bmTqb7voJZmH8sEyfuXrdmPr4R3Js71SbLOzYCQ6KrkdEVv3aGHCmvxkE5oRbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by DSVPR12MB999307.namprd12.prod.outlook.com (2603:10b6:8:41a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 22:44:43 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 22:44:43 +0000
Message-ID: <61d42916-a391-4b98-a6fc-84175127c2e2@nvidia.com>
Date: Fri, 18 Sep 2026 08:44:35 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/nouveau/uvmm: reject replace across page sizes
To: moonafterrain@outlook.com, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrew Morton <akpm@linux-foundation.org>, Mary Guillemard <mary@mary.zone>,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
 James Jones <jajones@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
 <20260817-nouveau-fixes-v1-2-f518d0c735f3@outlook.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260817-nouveau-fixes-v1-2-f518d0c735f3@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|DSVPR12MB999307:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5cd6cd-3cd3-4434-8f55-08df150d4439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|56012099006|4143699003|11063799006|6133799003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sVNra5q5pioEcgvW7+EOEGdqQoFjaNEdTV0OiVCwf+rkm/GXeH2tfkYRTXh48+VwkK6sH0lh58sCUJexJWuUFNig852OQLxO84Xt6iqFLJ3nrzLYxhVWfQMfj0DbwNPx4wQ4X5PggY0vXGMFXsl2vAipFz2wEOaXB4BE+j78lLv6jgZgC1Il3PfXmQRo7Ih/1ob4B0z/1lZX0++RdcF7mlyxgX8F1Hx2SzQkapIaPMCuQoHwETxWH9d0KcELW+NACyycd86cnq1AFn0T/kgjauL01JvRpKhtLga8TnOh09ZSmgvvxQejcLf08daU8AJyMgt2IU1PJucr1VPPT0AE1wSPpzpdFH3NdwD9oXdsSUcHfGC39+tGr9jbQIF714KTj5mEoG1+TpCDDznTL7GxSU2wrZ5jUCmsKJefZ0gkHuZkpx7AEwPdAJYNUcMRglzWhINojz2jySsupxGbgY/QflHR4mJCElCVIBWPU8h7uDI/dGpsKETavBPdTuny3Te+JUnyQOdtFCWXBfnH2yblZ1SNTfEUsnS6DGLQT930metWctirDjAHQ51Gn20OJlOeWpOZgXBonR7VBVdU+yOMy+nCFA1GHQK0q1EWMpnyWPBcwuStbDAFLU2VAFSAGAamLGnb32KnloYTk7+9g91kUu9m0/XEgrie8cADo60gtoxDicFDiHwQzzdAqQ+u4qkbtM1uU/Sa7yxFN0dB61l5uA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTFzRUJxMzZleVVlK2pBYjI5dUFPU09HeHVzM2hvU0RIZmZRelpEczhPWkJM?=
 =?utf-8?B?TkFya05FMDRBNmhXWHl3T05hQnl5cGQ0VzJMK2J5bTlLYVJxQWp6WEdteXVx?=
 =?utf-8?B?YXBaSUdqNCs4RjkwZ3cwK2FxdHQwckdIRnhMenZ6YkZRSitwRHNlMU1xaWpQ?=
 =?utf-8?B?cXRBNDI4UGJxVVdYbk4yUlhZazJtMG9sQzEzSFFBUEo1VUZHWUdUVXNEbUJG?=
 =?utf-8?B?dUk3eTUyTHVyMTJRSVhOWkJVSzBqNENOaXBVTDRLNnJqVHFORGFVdTdxNGg3?=
 =?utf-8?B?bVB5b3V3UDVNU3N4Yi9uaUxjL3FQRktPSDd6M3BFNVR2ZmJTTkVLNC8wNUtj?=
 =?utf-8?B?b1FwU3BXblJuVUR6dG5LQmdjN0JBVmg1a2NaVzZUcVJITHJ3VGlkeHFyMmFU?=
 =?utf-8?B?emdVb2JQTlc1MkE5NUhuVTIybEwyRzNYQzR5MFErcW1ZYk85OGJ4bjVGWXRp?=
 =?utf-8?B?L2xpaDRObkhFZjB1bnBHVnphZ3RKWVhRckNjZkFFek8vQktHa1FMZVU3ZWgr?=
 =?utf-8?B?NFlwdWlGcWI3ODRwTm1vb0RtNmY0MTlicjV5cXNZYXZ3TFk4R3oyQVhvYVNH?=
 =?utf-8?B?RmtjeHVOWUJPdWU2bHc5enNwbmFmMW9IaTJRMUlUN0lteUd1a1RQOXU2Zlow?=
 =?utf-8?B?cTlCQ0NaUWZOWitNSlpvUW1peGg2TWhpZ2hPcG5FSWx3TFEyT2xNWGtaQXdP?=
 =?utf-8?B?RFhoa1RWVFZ3dUlEcEp5bi9MdVhaQjRNOUF5ejhkUFBwamhWSDFqWU9EVDh0?=
 =?utf-8?B?bEQ2RXJYWVFSZDc2K1dQMWNhU1c0RExOdXRJcXlNUnE1Mno5aEVjeld3M25I?=
 =?utf-8?B?MG45Zk1uMWJrOWg4czNtVWt4NWJMdzZQK0RkVUg5b3RaVFhsa3lRY2hlM1NL?=
 =?utf-8?B?VnlxZ1VBbm50aWVuTzFVTUJIaWFkTkF2YXp4OWpPdjBjV051Q2ZEbXdXTVp5?=
 =?utf-8?B?QnFjeitTcEFKNEpmOVVJV2wyTHhMR0Q4cDZkdmJzWnA5ckpBdGlHWEZMeitL?=
 =?utf-8?B?amkzVGFUUEszMnF5eUhqL01sQzZFcDFmbi9yYWJuTWdWOURiT0h0SEI0c21S?=
 =?utf-8?B?M3lSTys1bVlZUzN2MWt5RkhJVm9tTGZXMTBYQmFkbzgreEtpZXplVFd5bGoz?=
 =?utf-8?B?UTdoU0dQZmFRVUtrK2pjc3orSVpEMzRjWEdnSisvL1dORFlGbVlJMmw5WXVk?=
 =?utf-8?B?NkFid1Y5NXYvT0JOQU1kM3BnUlFNN1h4MGhRRTJXMkxiNkZ2WWEwUVRZYlY5?=
 =?utf-8?B?dkZKSFBUMzZsS1B4alBzTTMvTGhGT05Ma1V0V0ZpTUdDVExJNTVxeDMrQk9l?=
 =?utf-8?B?U2dNaUNlU3JwbGU3bnE4dFlaODc3amJjNkZ4VDdsY0RZN3Eydm0vQkJRREtX?=
 =?utf-8?B?cnIzR0pxMU1PMFBOcmt0T3lxU0dDU0lDaktVR3h3MVZDMHl2R250eDhDRGY5?=
 =?utf-8?B?cTI5Q21iRTNhSXdScGFXbVpxRkNyTXNtdnpTNEZ6aFFiUlBqYmE3TXM3OGY2?=
 =?utf-8?B?QTdZcXlIYVhSd1p0dkFlYTQ3SW5QRjlVcXhodHZNSnlDU2xqeFpXWTJZQjl3?=
 =?utf-8?B?YmJWR1N4ZnRXSWRDTkorYis0aFIrcXdOUllTVFZxSWM0ampXSEFJMW96VkV3?=
 =?utf-8?B?T1lYYTU4cHRmT0ZndlQ4T3p5aXNkZGp0Skx3ejBSaVZ1b3V5SzV2ZjBVRmZy?=
 =?utf-8?B?eWVCSHRRQVhFVjFvU3lwRmtjbVlibTg4SG5hN0RBK1dXTTVqWllJSXNJc2Vr?=
 =?utf-8?B?eFpYenJ5elNBSWJqeHI4NjVrSktEdU0wNk1NSmQxcFNJbTVxUExIYmNNZFVW?=
 =?utf-8?B?Ykh2cmltVFhZSVRKY0IxL1dFOUZoTXJvWGtDQjNZMFlDZEQrTzJzeXNHVFow?=
 =?utf-8?B?Sk1YZ2NkZGJTd2VIb1NiK1lMTVhqYVd2WGtRN2xaVDhMNVlieG42aHQxbXVD?=
 =?utf-8?B?ejA2bnpENGptMUNrN1pkL0R2VlVNL0c2d1U4bkdVTGN5M28yRDU3WnpsdnBV?=
 =?utf-8?B?QXZWZmxTM3doQk42VVR6OVhYKzEvc2ZCRVRQOHNVVndCcW5rcjVmeElZN0Fu?=
 =?utf-8?B?NTBScW9nSm5iZWxQUUNzUHNXZmZrSzFPTmYyeTRDQTdCTHowOVUrSUlqaTkw?=
 =?utf-8?B?TjRBMGtXd254b0RBenJLR2pYQnlIQlRxYjBRS2ZmbllrellDS1Raam12OU41?=
 =?utf-8?B?YXlEUFdEbmwrV0N1dHo0dGswb01TUkNoTFdCMEg2enFwMnZQOTV0YTBHZWcz?=
 =?utf-8?B?ekRUdUl2c1JkYkdjRTdLYnFSUmxtTDQyK3V6a0w2RmhJVlI1clUzeUpZQU5y?=
 =?utf-8?B?ekRJbFp3SmR1WVBlNm1aOHdBYk9mVm5mdjVMdkdQVXJPTnl3QnlWUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5cd6cd-3cd3-4434-8f55-08df150d4439
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 22:44:43.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLfvD418WUW2joFPOWpzs39sW48IJQ5oAA7c91uF/yAnd0nFTHA6lrerrmp1rYo71Na8tZ2vTtA9mJDdx19dEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999307

On 8/17/26 4:50 PM, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> A new mapping takes over the page tables of the mappings it replaces.
> nouveau_uvmm_sm_prepare() only acquires page tables for the range no
> existing mapping covers, and the map path frees the replaced mappings
> without putting their references. That is only valid while all of them
> use the same page size, which select_page_shift() no longer guarantees.
> 
> Rebinding a GART BO over a 2MiB VRAM BO therefore leaves the new mapping
> owning page tables built for a different page size, and it then maps at a
> size that was never referenced over that range. Since raw map does not
> allocate, nvkm_vmm_iter() can walk down to a NULL leaf and dereference
> it. The remainders of a split have the same problem: op_map_prepare()
> recomputes a page size with select_page_shift() while the remainder keeps
> the parent's page tables, so a parent that was itself downgraded can leave
> a remainder that re-aligns to a larger size. This happens on the unmap
> path too.
> 
> Reject the bind, and make split remainders inherit the page size of the
> mapping they are split from.
> 
> Fixes: c488a94e7e14 ("drm/nouveau/uvmm: Allow larger pages")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5

We are moving to Assisted-by: LLM

> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index f5e4756b4de4..6404c54d097c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -85,6 +85,8 @@ struct uvmm_map_args {
>  	u64 addr;
>  	u64 range;
>  	u8 kind;
> +	/* Page size to give the new mapping, or 0 to derive it from the op. */
> +	u8 page_shift;
>  };
>  
>  static int
> @@ -655,7 +657,8 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
>  
>  	uvma->region = args->region;
>  	uvma->kind = args->kind;
> -	uvma->page_shift = select_page_shift(uvmm, op);
> +	uvma->page_shift = args->page_shift ? args->page_shift :
> +			   select_page_shift(uvmm, op);
>  
>  	drm_gpuva_map(&uvmm->base, &uvma->va, op);
>  
> @@ -684,8 +687,20 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
>  	struct drm_gpuva_op *op;
>  	u64 vmm_get_start = args ? args->addr : 0;
>  	u64 vmm_get_end = args ? args->addr + args->range : 0;
> +	u8 map_page_shift = 0;
>  	int ret;
>  
> +	/* A new mapping takes over the page tables of the mappings it replaces,
> +	 * so every one of them has to be using its page size. The new mapping
> +	 * is the last op drm_gpuvm_sm_map_ops_create() emits.
> +	 */
> +	if (args) {
> +		struct drm_gpuva_op *last = drm_gpuva_last_op(ops);
> +
> +		if (last->op == DRM_GPUVA_OP_MAP)
> +			map_page_shift = select_page_shift(uvmm, &last->map);
> +	}
> +
>  	drm_gpuva_for_each_op(op, ops) {
>  		switch (op->op) {
>  		case DRM_GPUVA_OP_MAP: {
> @@ -713,11 +728,22 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
>  			struct uvmm_map_args remap_args = {
>  				.kind = uvma_from_va(va)->kind,
>  				.region = uvma_from_va(va)->region,
> +				/* The remainders of the split keep the page
> +				 * tables of the mapping they are split from,
> +				 * so they must keep its page size too.
> +				 */
> +				.page_shift = uvma_from_va(va)->page_shift,
>  			};
>  			u64 ustart = va->va.addr;
>  			u64 urange = va->va.range;
>  			u64 uend = ustart + urange;
>  
> +			if (map_page_shift &&
> +			    uvma_from_va(va)->page_shift != map_page_shift) {
> +				ret = -EINVAL;
> +				goto unwind;
> +			}
> +
>  			op_unmap_prepare(r->unmap);
>  
>  			if (r->prev) {
> @@ -756,6 +782,11 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
>  			u64 uend = ustart + urange;
>  			u8 page_shift = uvma_from_va(va)->page_shift;
>  
> +			if (map_page_shift && page_shift != map_page_shift) {
> +				ret = -EINVAL;
> +				goto unwind;
> +			}
> +
>  			op_unmap_prepare(u);
>  
>  			if (!args)
> 

Just wondering how this was tested/caught?

Thanks,
Balbir
