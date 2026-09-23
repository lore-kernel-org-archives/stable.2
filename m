Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6E442B21;
	Wed, 23 Sep 2026 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163656; cv=fail; b=FoW3p8q2g06+Hpm48sLihJ+sFLtoCWzDyUnMwM9eXCuEnvmXLOEfIEC4phsCHieWHCIE/epi1cwBM15zeoSOtMuJzZqnhgG2cQ9tDWdGNBIT1bM2M+yMzXkTQAubsGbdKgkVKrkSS0sn2Kp6Au6fV8YQf+mY+VYkFYaz5DfV5ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163656; c=relaxed/simple;
	bh=7hT3bcbSUiwIWTHWzjZkh+ZCAW3X5VV5OSOmHtPCNHA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DW+mHiosMw+bYuLHn5NiXp4SCj4aKmBlPf8sjcMyI1GjC+jjKWPGQODx7vsTlQwtIRrWddAhZ3j+mBUPsj/tNH+geS5yMfYNfHSwOHidKLS/RsgFakx+IdTNtPT6XkkAMb7lukAfZpvVFiyGc4n8mdR+7ZYZSf4TjzVZaI15YXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D/ZK4Mbr; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D/ZK4Mbr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmaKd3faqY24GNBrB/w+JQWORGWYo8Q+7FmmswoZUqBHkw2is99eRnX2HFFIc1ntH66rQlD+oDrGqeUT5nPlm+GE/wWlX2oCA6WRz2ekRT8dvu1UIOQ2Hk3clHGM4IbgmoArP3hz4j2HLkKx23XLc8py1Si+U18r+zu6Tqf0CPP9Ksmf0uL5Q7+V2GfESZq4nNn96b3ODuqfaukTS3o/VReujPrZ4hd1wTsqPY6jYHfnOtU7Ze2VIOa7ZE3s/X2lltSdZ6Imx6JJgD9qubaAyI1hjO4jJMCwPCUycY1CERho9h7AGDQwlDvWC87Nthb7ecwCVnX5ADGf8QBhTyRFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f00e5dqXGx2dfvPtylZuMo9aacBEokzWWS0fU3EcqpM=;
 b=vGOG94VTDZgYiXRwdZ5m33jaqVGsN5T+v/9wnzX2f3yas40aIRneWyOdq75/Vm76fHfWSMkGpPjwfxEvXON5LuP/FR0gNnp/0vnfXIUTazLDywgHUcz+pXCOe9bOJtHI2lPsgPCFNAtkvULUuMZnZ2NKaiqNJHmPw9YyRpz/QXnPErw7lT9S6YC1U0edbg3Z9AMagWFeISVFf44FL2tcI7PHWTCaUHcBQd41XEoxHfNbovpYJ1MjaIzy5Ab2EpvGuV3GnGhbyJz/Wr/eOKxVGNo7aWwGXVEBamvgp1ns9VHBVdpG9xtFy6CSylQZPlzzsW4V+i5DlF2xCeYZl6i38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f00e5dqXGx2dfvPtylZuMo9aacBEokzWWS0fU3EcqpM=;
 b=D/ZK4Mbr3bGDF5/ERF++9NBS2eFegKKEWrw7gO11jQJRxzxARy63jgD4li652onoSMHZQo9o24j3pS06EFZRpNQoWqNUZiEOGz7ckgEITts9//fDNwV9nihhR5B9yff6f0DjVyoG5WJ3kr4T9WDurS6SG1HZzTGJyoNsZ+W7KKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 11:40:35 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:40:33 +0000
Message-ID: <cedf454c-1840-41a2-810e-16f0cfee452d@amd.com>
Date: Wed, 23 Sep 2026 17:10:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/versalnet: fix remoteproc reference leak
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260913053532.1324671-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260913053532.1324671-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::25) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 896eb56a-b84b-4094-fc02-08df19677a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/fPQ6C8mexvSRlWOQlfWNbEURoSQZJto6ZuJx5PsS/eaX8NUvtDmJVojEXl/FW+FDszi0Yo9jcRMXmO/TKJKVqTHUHcTi/xkJMN2ELIPDSOYQYxwPkmqDEaYw+Uxw7a87YUN5wz2qN7Y7bw1Kmu6cAEJV+dLEKkJF31hCt/AOshBEoeBJMJ9J3ynrKJYFOOK9GlD+9ZXQiZowNoU1ZOQqsT3qMQgpwODqIQalXM0SQqJ5kq+K+sIsL8vz8oNc+JUzQtwnLOPXvVMluqhkSRxWh7spnsIcyy4a2TZJUZfUstRo+JFcmqK9i9+YGgO36W2T+8F5iX2nXv3hWpNbpj/d1+4aDJV/F5ioOWf0S8PzwNTNfK0vbIhirXL6KLPaqrmudp9vEE7t01+kOsJwseECS/BJPjpMEY15gRCxEs7HQNMVzIEg/IzSoE/1yujC/9OvMkPh674J4A4W3ckd1Y8fN06WvWphC62L6guPKzei0kNY/qD4tYD/LFEweFr2SpEYC81B6LlbrdQwmSdNkk+dhTVor8uV3rRDxUrP1PykTEg2omC0S0vaMN1Q3mYnbNaHVJS8Z6nD9EX73a52uaBQc7oqFKhkMeq1Ct7VP7katdzf9poeFHKXAjPhtsuVuBWx2bl4BGp6nrKsV/i+IdqFmqKs865Tw5lUcJvKMKw6tM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eElqV3lUMDRHVHF1QUg0bWJzcDdGanFjRmlSOVBoVk1mY2ZaWW1YQkZhdXI3?=
 =?utf-8?B?YnV3OGRjOEVkN0ZZV0hMZEgrWk5yTnA0OTg4Skoza3J2N1I3QVd2MWpSbXRa?=
 =?utf-8?B?L2ZNbmo3WEs3dEt1a0lQS1VCTUZlOGt6bTNEaVBHK1NEMzRCc0dCcFhCQUJp?=
 =?utf-8?B?aWJaeldHNkNrR3cyN0V0c3d4YmV3VGJWZ1I0UlcrNmxmeUQ4WWNZWUVQSnVG?=
 =?utf-8?B?TmZGQWFkSUNxRVlsWUp5QXhKOGlpY2xLSVJaZ3F1aGpiUVVOeFljRXJyZWlH?=
 =?utf-8?B?VUM2TUhWUk0zbWxzMXNKaGtDc3R4VWVpS2xhZzAxK2E4cGlNM1ZBS2EveHNP?=
 =?utf-8?B?eTdqazRiREdoSU9JUFV6bGZFZi85YndiMnkzRWFLWitYQXNkNjY2b3Q3UTZj?=
 =?utf-8?B?SEhCUkpiallVcWtMVThIZGJLOTZRMk53REw4N1FkWi9vTlFFTm9hK0VYanNs?=
 =?utf-8?B?Y1BvT21oSHMwbDVsMjBoaldkSWdyODNmNExoWkpYdnpRaU5pRjJjU3U1OGFk?=
 =?utf-8?B?SjVVSFhOQ0kxVW5aa1VDMmljUDYvWmtabE8yOS9GQjkydGJHbEhtanZNam9F?=
 =?utf-8?B?alpaR1RnQkFMVFFxUVArNWxkajJlb1JqR3BmTXl1UWtOWTFYY3JoamRHYkRD?=
 =?utf-8?B?cmt5UTZheGlET1V3Tm93QjFvOTdiKzhReWFYbzROcWFFTjczSlY1TlJjUEds?=
 =?utf-8?B?amJZNEtGcGZsaTc1enJZMXc1UjExWVQzV2RXODhFZkxvR2R1UThOS1hOTjZq?=
 =?utf-8?B?YThBSmlqK3B5Tm03TGtoNXBWek5GS28xYnZvQTdrUk9wck9yUmR3NFhCNjJL?=
 =?utf-8?B?UTJWS29hRkpxOTVVbVIwV2c1TndPVkRBWGhjNGtkVkUwSVJRMHRGeGJobi9j?=
 =?utf-8?B?VkIwU3J3TnVFeFdoWUk2OUxqdDNPTDBEUndkd08yRy9EdDFsblpZaXd2SDlr?=
 =?utf-8?B?dmsxSWNVRXV3UTZVQ053ZXVKOUdxTHJzT3R3d0pVK1NZWkI1bDEyOFJ1dDA3?=
 =?utf-8?B?WUlFY3JSc1ZmTVBBNXpDVlFpbDJGWHIvU1lzVVpKTXBxMmhTTC9xL1Nnc09r?=
 =?utf-8?B?MXdYM2Y5Y2VObkxHMytBZ2h1bWhXcTVxaXdHVWd0MXVKK0QwQTl0VUJ5TWtC?=
 =?utf-8?B?UEkvUUNPQ3dQNjNuKzRtc2o1V3hEZEtMcGhzRlo3Zm5XVVVmYi9wczM5NU01?=
 =?utf-8?B?QkJiSExiYWFjVDBvcSt5ZTBtekpBU3RxS3lBQmp2ZjBKcFRoMXZiRlVURlN2?=
 =?utf-8?B?YmlIc2lTelRoQzhiYVVqZVpIbEo5MW82d293NzNJQndIQmVnVGNkcjhKaEw5?=
 =?utf-8?B?Q0Z4a0FoZGFIWkxHNk1nLzAxVmNKZFc2eW5SbEVLRSsvNFMzMGQ3T3pBMDI1?=
 =?utf-8?B?RW1LMnFwWDVIWVVYdTJtM2hod0dQaG9Cb05oZjNCNUtvdGwrK2EvOUpwZkc0?=
 =?utf-8?B?YWhnSUhiTFArS3BZaHVqUUExSVUzMUhhUXR6YUhua1h6cUhQd09iNzdUanls?=
 =?utf-8?B?Vyt3M21mMDJvcE1abFE4akQxUk1kbHU5RXRBUkJzVE5QanNYMDFZYjNoajJt?=
 =?utf-8?B?Y0QyMXhIcjdpbkc1YzkrcnFrNzlMNjBBNjFyWTRDWmh5TjYzQjZpam8vNEV0?=
 =?utf-8?B?REJ0MTdBcW5NejlJRUpMQmlnb2V3ZmhHSG5CaGswVW5mWlk0QUpYdUY1N3Rx?=
 =?utf-8?B?RVVLbmdwdUNqeUJwN252cWdQMHdSYWVvcVN0K0JFQU9uSXIrSXBrWmU5TWdH?=
 =?utf-8?B?M1B3V2Y0dVlaRFNSOUhNemZYT1EzMkxuWGxlYmdHK1NGektkUll4aFVPNWgw?=
 =?utf-8?B?NHlLMUR6bUVuc1M4ZHZzdmZsSnpBNjlaSVJ2czBsN1ArVytJeGU2RFJEZ0hE?=
 =?utf-8?B?OUFsZVZLZE1xVC9uUHhBN0hlTXdDMGNOYWh0djNBVnhTd3l2Smh3aExYVzA5?=
 =?utf-8?B?aEtDcDF0RDdMTzZqVWxrVkNxeHJkSjJKTGJLRTNUcXpTaXFpNXFEV2JzcmR5?=
 =?utf-8?B?akIybGdLSWFZUnh5eFFJOFJLaXJvWGdXcHBXK3hieXpqTHVkWmRZSlZiNEFt?=
 =?utf-8?B?TUU2ejJjREI5Y044ZVoxOGpzYytKQ2ZvV29iakY4ZlRObGpsaE51Q1crdktx?=
 =?utf-8?B?QnU3WHkrd255SGx4SENpVXBReCtmR251Z013bW5yVURabmNtOWdSbHAzUGlx?=
 =?utf-8?B?bkh4V2phTGhiak43YUJ4aThyVmpMSnlaRFNRRG9teUM3VWlUYlNlQUpFbFdu?=
 =?utf-8?B?L2g2U3R5bE9tbFZqYjVhaG5qbUE4RW9DWW12S1d5U01KeXBOUUllWjhaWWFZ?=
 =?utf-8?Q?zu9qzHAb3tg1kcwNlP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896eb56a-b84b-4094-fc02-08df19677a4f
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 11:40:33.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESojEpBvAV+Sq5EhCu7h6nUHTZorC4Bq/JwB5EoJBcWwuXh98eP8U6OcJIRGaUoV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246

On 9/13/2026 11:05 AM, Guangshuo Li wrote:

Nit - EDAC/versalnet: Fix remoteproc reference leak in mc_remove()> 
mc_probe() acquires a reference to the remote processor with
> rproc_get_by_phandle(), but mc_remove() does not release the reference.
> 
> rproc_shutdown() only balances the power reference acquired by
> rproc_boot(); it does not drop the device reference acquired by
> rproc_get_by_phandle(). As a result, successful driver removal leaves
> the remoteproc reference unbalanced.
> 
> Call rproc_put() during removal to release the reference acquired in
> mc_probe().
> 
> This issue was found by manual code inspection.
> 
> Fixes: d5fe2fec6c40d ("EDAC: Add a driver for the AMD Versal NET DDR controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!> ---
>   drivers/edac/versalnet_edac.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
> index 97ec05d68bbb..3a06b41c1d84 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -953,6 +953,7 @@ static void mc_remove(struct platform_device *pdev)
>   	remove_versalnet(priv);
>   	rproc_shutdown(priv->mcdi->r5_rproc);
>   	cdx_mcdi_finish(priv->mcdi);
> +	rproc_put(priv->mcdi->r5_rproc);
>   	kfree(priv->mcdi);
>   }
>   

