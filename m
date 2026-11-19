Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795066738;
	b=QA5yQjoZR4pQrtVrC7h5i7QW/p7o7so/q2p287LVrAjIOYW/eEzTFBCTW4awJmdoDSgD
	 8wXPJ9W6Lb4B3JUnt975NgLNelwEMcC726t+6Ty4hnbMTV9zDvFFgiYnZjCO3w2HwesjE
	 yQWUVOYulViNJkdjq6HswvgAKBXGUomWF2VEohpJQftqWXAkZczhRrnDTE23vIf9FO9wd
	 pH/3/+w2zxC0FYZcoYBhGl7YWKVB7B3Lxup9ZYKJEL8iSGErpR2oupXhkMCZNsLgJuITu
	 FSgNZEQkG3ojOcanaw4XXa81KHHCP+HmQl8EmGmksLv7IySnjY9MDv3Gjp6/5h4292g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066738;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kcKaUxQvxPFuqo5bK8jwEn+I9F8nJq4UHxe2jr5Cj68=;
	b=1XckzoHbB/FwcIg+bG8YjqHCRO0Hhr9UnN10RhJHMs+t0kyCbwvcTuhaDp7KC+ZR+T0a
	 GoX26yyMhnwj+Ca1HHj5rklveoRdW+obUn3g7Z3KpkjA4JPb1MAME5YLuyhT5TpvVzgLJ
	 wJLADP0kHvpyvnXMQcgEDdng67uHLvHUgiQq4vqaBiOlXaNSTzaue4JcqehKsuhqECy2+
	 JoUPY/ujkJ5GNyV7xu91t6Ekx7x6w7AxdOXr6dzCY9SMqokX/qlBvYHVGhguTehX8Pg7K
	 lRrrJtouuoQ/3NHVkxK5O7xL+MJ5y1QNtzs4hQOsoueMGw6QcsIehSPB1bkdBLJ65SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bWPvuhAu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.45
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406AF606A325;
	Thu, 19 Nov 2026 05:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 406AF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bWPvuhAu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rtnqp6xmCO1Rn16D6Vxg1k7HM6Doq7rFpOoou7Ez3IJBUXDB6Zeh2A6GfGFpAph+kxZjDZVu2YHp5F0JoH9qi1CQIjJcqesTi2do6Sz8XYI5dqpLrZsGrZmA+GgwZqIxThsgAvP8H39jLtgRj4z+dxXGbIYBya9mOftYBYY4XpPNqrtmvIGZ5H7MDkpA4sXS/i4L0FFkMraDoZGLf1YEUAhfi4h7Zlj5c1zn5nmMPVmkREmRsHUISa5jwxYsSwG1HRKNIoShtAL+2LOAo/p2osLtsL2vlZ1EJaZ9hxwtLsncjRmxyp6A5BRSboMi8SnXzMLCz38ub2QmWEhNAPcnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcKaUxQvxPFuqo5bK8jwEn+I9F8nJq4UHxe2jr5Cj68=;
 b=UoAhlrChsey3olkz3+jPpJR1LmDFiZjVwRJb7RUEZZJ7j6/aI+BUasUJUrjTAAxqEdDtpIk2/emY+zPP5wFgf+T31G5xTO6B3xbU6Kx//3ZuN/mma92mk8n5DcQ0UK6GKd3pVP7kasI3i0Zsmbwc7xtaE/KlNWnFMj9bgmSXtL5uKzaWVUprHEnSj0ZxLoKGhLRabsQlcGZfUUcXa3kK2dKQWSA5wge2oEtsM0paReD3/2eh0a2sZT7MwTrUsZf48A1CdaNHeT/4C3dsK18Ysa8aSlz/mKCDWeySD0Y4kwRZ5u5GgBv9CoXP39Ma3zST3AhgJzjgoZz6W3ekVcw3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcKaUxQvxPFuqo5bK8jwEn+I9F8nJq4UHxe2jr5Cj68=;
 b=bWPvuhAupB2CjqQTpCoRE+eBBkbMZZQGFFcZXFDqkaMibxAgNcuIG3ZZjf/9pZMGeGl19Z0JF0oDi+5gkOpe+tDvwxONfR7U4l9zDqDSlSeSTPrmkvL8AZ540B8TSANQbJH3zdwIv7b+s8gdv3rdKqmTI9FFoz8NA2Wc4OuT7I0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Thu, 19 Nov 2026 05:38:55 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 05:38:55 +0000
Message-ID: <3618947d-c367-4838-9319-556bd974d4a0@amd.com>
Date: Thu, 19 Nov 2026 11:08:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] dmaengine: ptdma: Unmap descriptor in
 pt_do_cleanup()
To: Lee Jones <lee@kernel.org>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Gary R Hook <gary.hook@amd.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-5-lee@kernel.org>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20261117163809.622249-5-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0045.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::11) To DS0PR12MB6559.namprd12.prod.outlook.com
 (2603:10b6:8:d1::6)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6559:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 729afa6b-81da-4b88-259e-08df45ff66b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|11063799006|56012099006|4143699003|261026121527099003|261102123227099003|10067099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	QeHRh4IMR/gNarO6E8LiMg4Qw3YE1/ToZZ90U6z++5domkDnsdIts8LtBXVBZ5TtGuiCw5TI19hoQhnK1IVfZByLfd/HAoGF5oFjkGgr5X2snuKf6x+GR8zr0fUYbsEoDXgBW+gSTuXGGW7KCpDyee8lnKuJ80u5KPkspruE7wzGWCKy8i28quhA7e3yo8cu7I/ZZD5SCNZDU/i+xvlDZPOzgmeY3u0uBiJt9hyi7i9O0cMMkEMeCMzXueBBEpX5jwiks2mf/pU1ulnGyQCWS5AY/FMttjvPLn/dQepfLEu+zBg5p/QtOq4g9e/QgtguuZ2KXtp/XeSVikdHN4BqsBaydktJxPxd8f0O/WUxjOJhvAfl7m8WNk86rIRtlTw7s7pnYlOgyKHyjOUk9K/aaTdifo9vLfR2tftBhaSTftIPv8nsbMm4HW33uyZeE5X37LkARMtYvW3vjVGsLPEx3w3gq9ZNIC1kqqyZH7s2wQlRTVtCSEqlGY70lTEvUkFwdBVQf/4Spp205JM0FyW09JuJ5K5QzDJYedXhnpmo2VixU7Cm4+pLEBh39i5iTu1C+4y+2AsDmpDxzY6uhEpU4o/1PSWQTIzvayx1y2XmxKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261102123227099003)(10067099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejRpczlqVnZEemxvUkxDaEcwSmo4VjZoYkwyTVlPS1IrQjlTOWxLNVZvS01R?=
 =?utf-8?B?eDY2ZFpVWFRIVnhaSWtDb3lBY1IxZTJlWlZyYklhTlZQQTJyRkxEcHJJRmdw?=
 =?utf-8?B?TUU5TU9EbEE0N29rNnVUUmJIUVlTUGZ2Z0VSZ2pUSjV3RjdvaExYb24ySmdq?=
 =?utf-8?B?WDJ1dDN1a1d4dGJSdlp1ZjNEQlJPRWlVblFtd25GS0U1b2toQUFDbE5JSlJh?=
 =?utf-8?B?R1ZMTlVwT28wVTFsdmplK0JiQUVHNk1NTUZMVUI2eDhsRHZOM2pEL0RYSlFj?=
 =?utf-8?B?Y2xHTnZFaXlqWW1tZUQ2SGUvQ2owQmRMc20rZ2g1cGRKQW1iTVljVjdMRnlv?=
 =?utf-8?B?YThhKzlkTGNheE1VNTZybk91R1JaZGFlZ25mYysxWGFhL29CSVRIREU0M0Vs?=
 =?utf-8?B?TWt6STlyWGFUYzZyL3lONlZvTHlWU2FlK3lPRmRlK1NZTTJ5emhjVm9pZHZV?=
 =?utf-8?B?c0E1b25WSWxMbjVEQS9IY3p3YVprN0JTTnNNK2NaeXhjbFdFZ2NONGJNeW0r?=
 =?utf-8?B?M2lKMEQ5VDJSZkpHQmQ5QjdBZ0o0TFJqR280MHUraEJiQW9mV2dKOGcySVNs?=
 =?utf-8?B?S2NaVlNIOTFiODhzOHNlam42aVVXVE1zVENWVzJsRnlSWUVuMUxUVHN4M0Fn?=
 =?utf-8?B?VEdmTUVtS1ZPTUNhaXNPSmZKcHBVcTg2Z3JSUDZoVXNOZXoyM1l4b0dBd0NW?=
 =?utf-8?B?S0QvOWdMdmM1UjFQUFI4T1pQT0pYRi9kOFN4VjV1Y2VTRWUySmVlbVJSQ2Ft?=
 =?utf-8?B?UWZMY2s5QmRqMTBGYUJRQlU1RTBzRUJvY0hER0F4OE1LbkppdW9PWTBJano1?=
 =?utf-8?B?YzhzNjNvQ3dmdjJjOXhpTllTaVJ5YVNKak1qZFlqbTduQ3VHMTNxeXJiMHFx?=
 =?utf-8?B?MTRERzFiNXVaQU9ZSXdqSlM0TS92SW9JckF4Z2VIaHZiNGlOTlBseStObVlu?=
 =?utf-8?B?cDl1TjRRdXBEWUQvNXQ5b2hPamkwTEJSOGVzQ0w2OCt5Wmthc0pFS05xaXhj?=
 =?utf-8?B?cWZiVDNsVnlId0JsQk5pQlFwWncvZnJBZ0d1Q0QzWDNYZXZwaFBrQytVYktv?=
 =?utf-8?B?M3YwQkdCM01hSW1wVldweGVCd2hDdWFrcTE2NnYwQ1NGeXJaMXAvdUZNSVdh?=
 =?utf-8?B?bXRiSXZTQWVNWmFsSkZISzZYZFVzejVuMDVaalNYb2hvSDcwZk50ME9FNGlt?=
 =?utf-8?B?S3RsdkoxMU1QcFhXaWxFMWJnRWkxc09Da1pObkUzWVRxanNFM3hCRnFuOThT?=
 =?utf-8?B?NklFYTE1ZDd6N0hyTFdUeFJrS1IxTG5JU2lmdTRsVE44NnNTOU5jaEl2T01i?=
 =?utf-8?B?cVJWQTBCbkhjdEtLL09ETHF2R2J3NFFCa04vc0dJcGI0ZTF0aERiNWgzalll?=
 =?utf-8?B?dU1ZUWptV2F5ZnVqdWZPdmlNVXhRdFNtRFdScGNSOFhVaE0vZ21IbjZXOW44?=
 =?utf-8?B?UkVzbGExNDNmL0dNOGQ2dGhNZTNybFovNVVrVkdHWFllUlFheG52NHJ4Q0gy?=
 =?utf-8?B?WHFlSFV4MkFRUlVXS0swS1VOeGtoeFdHdTdWY0lzUTBzTXY4amtpd0ZkY1cw?=
 =?utf-8?B?WFozdnNYOGJHdWpyYWZ5Nnh6K0tFVkJjeWptMVQvS21QSk5JdWhGL09mSW03?=
 =?utf-8?B?VzlEMkU2cVdVNEhDT3NURmc5eEt5STdNdmJvaThvQUZLT211aEI4dnlNTE9J?=
 =?utf-8?B?b2NHV3RHUk50R0E2RGttNml0cm5NNWlaWmw1cTNFM2UyUlgxa0V5MjlNbmU0?=
 =?utf-8?B?SEFJTmtjUUkvM1RZTVNiaHdyRjcyZ0FGclpucy9CNWlueW1FMytTeFNnOUdC?=
 =?utf-8?B?c0Q4Q2p3WkxGSXdNbmUvcGhVSC9aTy9zcmlxNnNDZDc1aVhDcXR4TllVNlRa?=
 =?utf-8?B?MnhxSHBIMDZoRWwxRFNjQWozcnRGYXZiSDJ2TmpJMnYrQWFhNjhMcUpoNGpB?=
 =?utf-8?B?UW9zbXhiZU1KZy82SzFwSFA2NDJCc2JhVGVKaGNjakJuOGdWL0Jzdy9vOXNv?=
 =?utf-8?B?dTRwVFdqM05MM0dHY2NoRHRXb2QvcXlhdHR6OU8yOWxKQTFBRzI2dG52ZUo3?=
 =?utf-8?B?N1N2emxNcXl0dUdEK2xwUzJxRmhvdFVFYXM1RSsyQjY4VVhCUUc2MWJtS2tD?=
 =?utf-8?B?dnJzcnhQQ25IbWMxbnBVMFFDK3ZNb0E0K29Ga3ZkcVEwcFVpK29oblNObFR5?=
 =?utf-8?B?MnhPb0d4Q1ZOdHY1OXJidDBHRGZsd1hvOWlpQk5LVTliclgrMzN4alQ3SHNS?=
 =?utf-8?B?ZWNBbG5aa3loNCsvMFJDaG0yWUF0Zm1iM0RaMmhucTVmaEdVRU15dXlHOHls?=
 =?utf-8?B?NlZycFo1R251Z0YrTEU0eTZHVm5lYU1CTnNrTTA2a2hQRjh1MVpsZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729afa6b-81da-4b88-259e-08df45ff66b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 05:38:55.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oi9d3G6pYFNzsXV2Na8pMPz4WJAHoxfKktXWZAmhUO5bV2aL0UQNdUpKfePgTmPNjgF8d7HWNWodA3g9e/Ubhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212


On 11/17/2026 10:07 PM, Lee Jones wrote:
> When descriptors are freed on abort via vchan_dma_desc_free_list(),
> pt_do_cleanup() frees the descriptor without calling
> dma_descriptor_unmap(), leaking any attached dmaengine_unmap_data and
> DMA mappings.
>
> Call dma_descriptor_unmap(&vd->tx) in pt_do_cleanup() before freeing the
> descriptor.
>
> Fixes: b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA resource")
> Closes: https://sashiko.dev/#/bug/linux-58b8113b-167a-4398-9be2-c2f3cbf73358
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>
> v1 => v2: No changes
>
>   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 628c49ce5de9..a0a1c7ec2ae5 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -91,6 +91,7 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
>   	struct pt_dma_desc *desc = to_pt_desc(vd);
>   	struct pt_device *pt = desc->pt;
>   
> +	dma_descriptor_unmap(&vd->tx);
>   	kmem_cache_free(pt->dma_desc_cache, desc);
>   }
>   

Acked-by: Basavaraj Natikar<Basavaraj.Natikar@amd.com>



Thanks,
--
Basavaraj


