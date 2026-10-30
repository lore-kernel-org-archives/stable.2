Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793360795;
	b=c/yYkhJCqbKxT2Y+suZbaoMZpAc/UjV9DI5VSyi77IxTpaN5GTdwlDuhj7MBuqp2Oe4I
	 aF42DOv8K8csjP1OQjOGY9lfUJ9DdXIB1DPuFn2KgmLJrhcUloFcXpuDioRAzicvyGo59
	 g1hClunxuooi0ifZsfnZVd/ROsYNI77reKoOVOpVXENzs7/vRe6ek8QF3DEwv2t0pZ/YE
	 CuBTCvdPXSguorIJUm8epgOYFuP5R61kKwXZMUJ7c4h/4lfyX6rD4S6rbmlnpQ3fVXPx9
	 +KwLTP7Cn/WDbMn/cHcja3R5edGJUq59Zua4qggylwPcJhwE6DavCtKdhtocq74C7qQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360795;
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
	bh=v9x/CxDpu39HLBRm2rDa4c4Y+4gjUUhvBrx06/kpVec=;
	b=jb2AR7gT7yIeLkEiJEKNaw+N0notD7V1ZgYLjkWYIFuP6+uLtxEzZY+AP2LJsoWsXBzC
	 Wv012vVsuWpuYpqcfqWlwVWo0BuDEgU3I+7j1fQ8g8AnoLA+ka+50TNYpKRPyyVlwwZGV
	 jtJciNx/Gip7zWOE83yvNQcFPRLZNn1iUjYxt8vNYBEJj1tLnows8WVAFxM1DmWaOndCR
	 LtNo2NCZqTQsCH3KamJQmO9NckG+6A64wKP61qlu0RFPUGO1wZFaHclFTmAqtccw3PBMk
	 zlvzZwwi0dePE4l+wLWoshHtvU9URCM7k3Vkq/ir5+i3DF1IneVQfIDAXEzD+dgXIVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SsXfAdGX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.10
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF212606A31A;
	Fri, 30 Oct 2026 11:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF212606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SsXfAdGX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLuwF2ji8gH0YcQFMRKZHdZjonPh4NYszxNmyKuE2la0Eh/ivauGnSqwxZGqYWtg1C38BPKc2r1jmOLq+7IbNAzhcpw8ZpLKixjugWtKUbaY33M0wIsMtAg5ox/viex0Mqn/Aizilp7Haso+DiLlDKKoLZMSyNFzo5tQ9IL+Gx0/uEzFEJ0Cxg/1sHSp2+zNzczRjbdilbpX8TrFsIvFaCFZfsjwJmuceEhJpls8x9W4ochxCL1A8iwlittMyDEYGjD0lS9OwM7fXfrDGMrDg5SrLsKhNt9Ay3m+f9XDe9iRpZWX+3FFrVZmUxwx/6FZmdRinmON3dUfDHz7KCmQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9x/CxDpu39HLBRm2rDa4c4Y+4gjUUhvBrx06/kpVec=;
 b=WJMRbuCpmBwHo+hQQtpk5ZDjcXMXjsQE1XZIY6jJ+Pf/c7rxp0bfD9FsrTbsR2+Wt4vPDEbJIuMw2VvFZpzxmSxJEoY+faVDZ5jr0myRMo5SxB/LwIHtKqKuz5AALHS31gLHRy8xixDGI2S4wBWaupb6eI4Xk7VJvg/1KFhXFfOnUx2Le4EbJfw+QVZtiJJMl8vs2KDkT1AFtCZzWbcAS0jqDK1a3yqXJb3FS7UtYL9CQ9fPUM8R/fm4R+opsteaxJQS3cj6nQHbQod9DEa5pP6xKm1SaEugChoUZK8Pyg6RjH0JEJrPwCNIZ1faZthsZAN6xeHOkl5DZQuz66iMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9x/CxDpu39HLBRm2rDa4c4Y+4gjUUhvBrx06/kpVec=;
 b=SsXfAdGXb7zbzS5VKAsv9mmo5kDtEWWxsbi9b24blXCZKNbuNTHyhyg5VnS6YiDnyut2WHscGAQktvzKmAUDKNo8/zCK1R7G3b2YHRYktdiQTDMEo3Z6LJnMUzMSRd+6LGqaw73vWo+mEMWCEPIRUQ2hG8esDQhW2B836JNVXT0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by EA3PR12MB178636.namprd12.prod.outlook.com (2603:10b6:303:308::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 11:46:31 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:46:31 +0000
Message-ID: <354b6a81-b8d8-4394-83aa-2afa13108df7@amd.com>
Date: Fri, 30 Oct 2026 17:15:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/21] soundwire: amd: Preserve lane control bits in
 amd_sdw_port_enable()
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>, "N, Poojitha"
 <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-15-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-15-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::33) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|EA3PR12MB178636:EE_
X-MS-Office365-Filtering-Correlation-Id: e16719cc-8de2-4238-5117-08df367b7096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|18002099003|22082099003|3023799007|921020|56012099006|11063799006|4143699003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	cBbSdrnLewnOViuI526v1NjyEeMkAxaAuNRUHUyfiqNgc0gWAQa6Ml/0l/eE3YtUlSUb3SsukYNi/o2YeJ5KXKQ3vJbcaKFhxQX1ZCrfCGwOy8gsxh0Eh8wMWnBVYCOA2SQ26RXkkpWwCNBemDdJhxsBo7jaRJp8J+DJqdHSVuO2j0Br7CyQfbxvw8CjJGQnE0ocJj+qAONbX4LwpRurRjNBv8wNZWWWo8TVdahx+44gixVFpaJ+f1fRScnfU+jVVENBpm1I/NoKfBAaVZCEDLiBinPGU6Xwm0T3yqKlQBmTzPQRy78SM2aCO8Olhx4591DbxpBfpOKHQkXIj5BbvI11R3vMeght35x2ERXX7YN8p9GxhkiNUO2NzaYLO8P2uUrNEsRh2QznSWwqQSF18/vl1642pIFVPsMXIw99BEc83LH/WGcPwXG99iC92lCfBqoX/MFInT3FDD/4fD41jq2xSGZXIu0erKujqWuxu9tWIObMePcpg+cD+YZ4nkwzePJldFcllnL22FHzHkmUWv6FwM2EKtgCDJlE9NF4tRGv+whQwFqP81EELi4YME7fx9OUTJQflDxFxC8dzFR5TQtfuUCqoTctLpEC311fAMKP1pMThsBaNCrSDP7psQ4Ggz6XDy0hbLGoG+rV9AZaeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(3023799007)(921020)(56012099006)(11063799006)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGxMdUdrelB2WU9wMlRGVnJJbUlFaWhGMjd6Z1dSODhjOVlQK2xYbDJyL00y?=
 =?utf-8?B?eGhlREVOcU5wYXdxODFIdnNXYnFveXhxcGxZdWJFZGEvZjdLekJHSzlsdTZE?=
 =?utf-8?B?OFBLSXJwNElZS0FPTkdJdit4NmFzQVRFYTd6eEtCQ25LY2x2WFZobUxCUjdw?=
 =?utf-8?B?bEx1aHkvUDVHeS82c3JYWkdHc3U3ZnVBY05LYjdWVzRQcmtvM2UweHhZL01p?=
 =?utf-8?B?aG96M1dpMVM4UldnNGUrMDBaaWYyK004eGo3eVB2OHJ6OVFjd1h2NHJrdklV?=
 =?utf-8?B?ckNBRFhOVDEvbWpRL00yb0pJeVN3eFdERGkxa1djU2NGeDNiVEd6R3F1UzVZ?=
 =?utf-8?B?Mzk4NUwvVGNEMStvc3NIakxHbzU3UU5PNUdPaXAwSDRKU2piR0pKOXBWa3hh?=
 =?utf-8?B?ZDlqSlg0UmNzUWtsWTdPeGFJY2RGTCtQSzgzUGU2T1VRbnFrM3dhMzkwR0cw?=
 =?utf-8?B?K29ac1lHdnoxLzB6TmJkR1JKdVlWVmUzUm1XUytmOWQ0akhlT01hRmVUUk1K?=
 =?utf-8?B?QXcxK3RSN1ZFQjZPUm1ZRFluV1Z1NmlVd3R6V2dnSzE1ZENpalp6RDQ5QUh5?=
 =?utf-8?B?NUZBWnJXakxHd250Ly9lODFkTUVUVTVtcjExV1lPYkRwK05MZ09BV1NyUzU2?=
 =?utf-8?B?Ny80NHhSVDZhRDJNLzhnUkYyMVJER3lKSmtYQWRxeDVtcC9YNW1xdm1HdTdj?=
 =?utf-8?B?Zys5WVFscUFiN3BPSURvTjNoNVZYZGxiOWM2ZVNSS0hRbUtDQkc1c3VyM2Rv?=
 =?utf-8?B?YitsS2hrbzJIclJHblAweWtxVFRXWC9IZnUwSGxIWkZtQi9QdDJnVnBjT3B1?=
 =?utf-8?B?MjA3RC9HSk4ybEtieFlEU0tVazdmYXh4eUlOanNrZkFGZmhyNUtTUHR0eEFk?=
 =?utf-8?B?UW9yVmxzSWo1ZkRJQmdnbXg4MjdxTzNzT1pDcEN5QnQxeFdOSTRYVGNSWm9w?=
 =?utf-8?B?QnpjMFNpekEwWVc4RnlGV2lvQmFQdktrcE13ZXFVNFJjdnBqb3NrQlVYcDFK?=
 =?utf-8?B?R2lwbmlBb3hsTHN5aWFuWmxydHZMb1VJdmJDekdVeWM5bDQ4YW1MdUl6Nmdk?=
 =?utf-8?B?QWZudDh1dmRvN0hMMTVpWVBkdnJSZnRDTVpWS0d6VXRmNlAzeU5aNHA5b0VY?=
 =?utf-8?B?bnVPWndIMFhaY2J0UCtPTGtoSzMrMytuSmVxemRQQmZTdis3Sk81bC81ZGZq?=
 =?utf-8?B?cTgwOG1UeVhLOFhqNEZteElYVzNhWkN0Zmw4SHZ3Q1FNMHFkWWhYbFpRdmJT?=
 =?utf-8?B?cXBmSy9sWGJuN1UraGRYSW9sSWcySm4rZDF4R3JtbXBHNGFsK1JxMGV2NVZI?=
 =?utf-8?B?NG1ZQkUwQ2IzMEJtdG1RaWVZeENFajd3K3p4d0l2ZHFHeTh6UDVEVlgvc2N1?=
 =?utf-8?B?ckNneFltVXRlM2tPUnJrUXlYQzZ3L1hIK3daS1R1N1VNeDVDb0tmeFl2ekVU?=
 =?utf-8?B?Y0E5L1BJcU1LTTljOGc1UG9IZW5VbldHaFBqSzhNSUJoSGpxMG9BeVBNZzVE?=
 =?utf-8?B?LzU4MmljNDRqd1lSNXo4Qlg0ZkxQa290WEwwbnRZdEp0WURqbmgwK0xmZG1D?=
 =?utf-8?B?WFBWd25pZ1lNN0djUHpaZmdyRituMDFqalNITG5KM1F3ckU4K0ZKL1VMN21S?=
 =?utf-8?B?MGRtckdjMXN6Sy9IbjRSSFo4MlZ4NGJ6S2tQU2tSeDF2MStxZVk0d2FGclBG?=
 =?utf-8?B?RzlGK1lDTGtCTEswWWV5aW53MUtlU21va1FDbndKRitqdUVjSkJNR2VJdk84?=
 =?utf-8?B?b2kycnpua2VPbExrSWJtb0FTeFFHUkR0eXRrbFVLRXJjek10S0NJV2tNT1NU?=
 =?utf-8?B?dUVyMktmWnFnNTBBblRjeTZJQmZVelVNSVdyLzUxenZBbE84NGhnNDFyNEtW?=
 =?utf-8?B?ZjFCK3g0djJxWHFyY3pjUmp3d0FyVDZmTDZ0L0VtZTVtSDczTmxWRDdUYWFB?=
 =?utf-8?B?a0tGblJEeUFISnAxWHl0cWFTMmgyY1ZVZ1dKZW1yN21DR1pwYmdMb1Foclo5?=
 =?utf-8?B?VFNUNUJubXB3cjA0NmJlY05Kc3cvK0ZpdDVMQk00WmJHaDZNSFRScThoQjRt?=
 =?utf-8?B?N3F0T0F5TEk0L0wzWFU3b1NySWVDUlAydldUVlF6T3RVMC9OSEVwMnM0ZmJS?=
 =?utf-8?B?UUNURXNJdUtKUmVlTThTZlJXYjJ0NS8zbVVsVmRiSkxmVDRoUE9zTEY1S3V0?=
 =?utf-8?B?MTVtNGhoamJUdDJnN3VObFo5VkpiL1N2OHJ4SS9mNWNMSHFyZnhFR3lmM3Nv?=
 =?utf-8?B?ZHU3QzFleEl0LzlzWnJMWHhzV3gyRnp4NUpsUGc0UVQ4WjZSSmZVallwbEhx?=
 =?utf-8?B?V1VjdDRjR1ZUbjI1WmFYYUIwUGs1VURsUmFuRkdIeWNONEpxdzJmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16719cc-8de2-4238-5117-08df367b7096
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:46:31.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9l/lFxWlunR8Al+kxlv6aukHW89VvlQx6yIUgUiaE9jPndgOul1G+P0lnJH5SkRD2UlXY4GBXtu8fvg2ty88Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB178636



On 10/30/26 16:16, Lee Jones wrote:
> [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> lane_ctrl_ch_en_reg holds both the channel enable mask
> (AMD_DPN_CH_EN_CHMASK) and the lane control field
> (AMD_DPN_CH_EN_LCTRL) programmed by amd_sdw_transport_params().  When
> enable_ch->enable is false, amd_sdw_port_enable() writes 0 to the entire
> register instead of clearing only AMD_DPN_CH_EN_CHMASK, wiping out the
> configured lane control bits.
>
> Clear only the AMD_DPN_CH_EN_CHMASK field when disabling port channels.

Multi-lane is not supported on any of the platforms handled by this
function (ACP6.3, ACP7.0, ACP7.1, ACP7.2). AMD_DPN_CH_EN_LCTRL
(bits [2:0]) is never programmed for these platforms, so it always
reads back as 0. Writing 0 to the entire register is therefore
functionally identical to clearing only AMD_DPN_CH_EN_CHMASK.

Upcoming AMD platforms use an entirely different implementation and
will not use this code path either.

The described bug has no practical impact on any hardware this code
runs on, so the Fixes: tag and Cc: stable@vger.kernel.org are not
warranted. Please drop this patch.

>
> Fixes: d8f48fbdfd9a ("soundwire: amd: Add support for AMD Manager driver")
> Closes: https://sashiko.dev/#/bug/linux-9a1be49a-7c40-47d3-9260-b933e590c90b
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_manager.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index a8220235a2ae..9dfcdde3f2f0 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -706,11 +706,11 @@ static int amd_sdw_port_enable(struct sdw_bus *bus,
>           * parameters.
>           */
>          dpn_ch_enable = readl(amd_manager->mmio + lane_ctrl_ch_en_reg);
> -       u32p_replace_bits(&dpn_ch_enable, enable_ch->ch_mask, AMD_DPN_CH_EN_CHMASK);
>          if (enable_ch->enable)
> -               writel(dpn_ch_enable, amd_manager->mmio + lane_ctrl_ch_en_reg);
> +               u32p_replace_bits(&dpn_ch_enable, enable_ch->ch_mask, AMD_DPN_CH_EN_CHMASK);
>          else
> -               writel(0, amd_manager->mmio + lane_ctrl_ch_en_reg);
> +               u32p_replace_bits(&dpn_ch_enable, 0, AMD_DPN_CH_EN_CHMASK);
> +       writel(dpn_ch_enable, amd_manager->mmio + lane_ctrl_ch_en_reg);
>          return 0;
>   }
>
> --
> 2.56.0.317.g454f8302e1-goog

