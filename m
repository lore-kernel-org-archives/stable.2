Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919935B632;
	Wed,  2 Sep 2026 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332469; cv=fail; b=EKHS+GSL7W/Jdci2UzdI1fJ6vKVF+x9qZfDrIuQJduEqaXyq//bwpr4gERGD0GJ74wMTS5QKCeCciFZQUZZzUPntVMjmiQvFXUgIzjPwHOuTmB81tji62UamUWduKSRxg8sRzaVtHbxTBIldvSdAa/B4gCP9h8HoQqfX4aCw0HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332469; c=relaxed/simple;
	bh=I0CBiSXcsXzIcii/s/txvo+jZNEj4lMydrJoAvHCVQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qm7NeOaeL+LlvP6IrUWBOoXCYwRzblwJaNz6Bf68s6+3JHNSkHNLTppkIkh51GXPp4tp1DXl6ICVt6zkzFTj8uonqyjrbkUgwA38OtYEfDbsLa+HNpHNfnEejWSaA50GNlyzVkkPcQoMFtEFvRaFB4Ap74ut6Z3IndwlNww0VF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OmcJRcdR; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OmcJRcdR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvA7yoonWupkJKzwfxfZkBfLnTzzk8h+aEVQRift9Fr4S3mPxUlIL05AQHcOBt0PEG50aQg3Qv9tv3zNK77DchJZ2s9QmyDFtL8oKLBmcVgoBf3kMfOv8HUKsM14Gb/qlIYLm+l3xbHpuURnAzpZisIpI3aJDdSDtCMAJNvuA/WYtPik109y1Jeu7p8wfZb52F834+H9ILeYUvcmiZoNDE7DiVbKaMHiM/RTk2b3zMEpOiXKmBOysXpNPIWIphtOhiHXd2r1xDBxsAcB7fy1rHf5aALy3cgaV/eCIPnKIRPI8VW6qDmBKeVguao4OmqNrH7p6XN+AuWO1IAbxKWhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf6wwMPwlWMZrXz4ZL1yAc1mP8vVfrc88R5rHdNY7Gw=;
 b=ypFYt2vj4ZFEzY9Ty8Omefdg5GAZ73go9PAYVmYltKhTw8/v2+YwPTcxabDcDFrg8vBhYYt9lF2LrgHeELXHJ78Sm6jeJ3FUEXBmIxHG6lnmlEuD1+Ldk5ID1TZPbN2EGAfGMG9gozfIuBWQYehryya8JkBDRi3VhwjHGJ7LmMmOZuABgXZ01brItYDYuBHVpBBFkx3P/LQUbXRq8IN78BkP9uRFAbCPt0Wa26dOveeRv2fIuqlCAjTamP6Zo8bGYkZFAQdBhIcscFWmJAuhyjpJf/IdvNuo6lQwYb8sCftyDe2uGuZ7f3I6+7gDnoV4HCAENGIy7l8U/dfuU12Z3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf6wwMPwlWMZrXz4ZL1yAc1mP8vVfrc88R5rHdNY7Gw=;
 b=OmcJRcdRWHVQazFlOm7UnIS6afJ+ZFzA+sOHHGmiFp9X8fwjDRfTrJhMl/GHFzazInt+Cc82TSybVf8oIXDyLMxcaP6iwm55HFbs9+gjatXft2rvnvV8TE44x93TTzbvheeTPUAVLN1mQQnORnyMDzhi5q7JanNcI4kk7mK8jZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:00:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 07:00:53 +0000
Message-ID: <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
Date: Wed, 2 Sep 2026 09:00:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
To: David Hu <dhu@x6u.co>, sumit.semwal@linaro.org
Cc: alex@shazbot.org, ankita@nvidia.com, chriscli@google.com,
 david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, jgg@ziepe.ca, jmoroni@google.com,
 kevin.tian@intel.com, kpberry@google.com, leon@kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org, viursachi@google.com,
 xuehaohu@google.com
References: <20260901170849.4052816-1-dhu@x6u.co>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260901170849.4052816-1-dhu@x6u.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:208:238::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a62942-64d2-4bd5-83d5-08df08bfedbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	5eQbdpSIvG4I0wIDrp1rmkseJwf9WsMl3IfAYONaNdY8uJcenJ5LfAC8paV66MlGTsaGGEX3PMtc4kc2lpBOQZbmBGGr7n9cl3s4RwvZEi0MyNNCxovTAKWJUojaP4SiY4l9rOjmJLsifP1o47uw1s7QfKxwqi5bw3R+4j4LibOdARtk1R1ihjdUmTgIOqX1ocEHAqfhhr60z2sJjehefsX7jr7QEHTjeE4F9Lm2mlEvSQluyQoUux6hdljKRx7Cn+GEK6lENOUHn/8XQ46Nwo7HPlBXQBzSkTbR9OcuJtaIwHHL5IlskJ6TIMug1a5JeEkAwW89vkFfwClRpujIz1LkQEEFz3EhfMwj3qAPX1gZlBeAOlzyXUczHgh1UCpysLr2Z7ZdStobxAGz78j5FYDpBZoVYg5bSRChR7CJtZwbRmDy9rIYoX/Wzn0Gpyg1MQO0KOXM6YEfPdV+vhepp+r0SLhN713E7BpfI4OQJDBL9yuPS//SFiEpYzPBCwHZuceAbyvLwah2hPT5KIBEtETaXEQAfm5YliFvh9bPgoflv7XbCsEtO3qDtEvuIASBlBNgBZ+hTMg18Q/ExWAHnVvgXxNxpAMfZt55QTGp9QBeVd6zgUprTYUt8ZPaptjnpyf8Ck7ShUANefNWslKExtTPmQujFM0ZF25ROQ1K3eo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1RpdzlwMjZzL2ovTFZyZk5SWkNNeng3NDN6R3ZSM2FDelg3eldqeEpuMFBs?=
 =?utf-8?B?a29uOUNJeUkwUnQ2VDRielJKYlhoenFmTGxmVVRTd003eThSN05GenJnanpa?=
 =?utf-8?B?aHZWVEFKclVWWlB4QUdYK1Q4clBwUFdNK2RwOG13UldJVVU1NDd4ZlRWOWll?=
 =?utf-8?B?VG1FbmtzbG9jOU9qcDh2eGFJcGhFWnJFSUpMbXlIT29pSER5ZlgxMXJYZjJz?=
 =?utf-8?B?bWZxMkowY2VYcVovblJOdlpSQm1sUHV6WVRzN2pKa1dxd3QwRjNwRlJxdTI1?=
 =?utf-8?B?SlpBTUV2VlNoK1JPbVJBbTVXZ0U2SGJFM1F6MDZuZmg0MTZublhLVzllWSs2?=
 =?utf-8?B?WHJsQW1zV3NKbDBLY2JrWTd5Mk1vam9CbWVpYW9sVmNaVjlwMWhUQUtETlZ4?=
 =?utf-8?B?bDZ3bGc3djRjdmhTaFpMYkxXVUxORkd3L2dCbjZWNHpyUnVyUkREZUFGUUJs?=
 =?utf-8?B?ckh3VkxUOTUza1FSRW5jUjlLWGhpR25jdG8wMVZTUkJCYjRMenVJb3NqV3FM?=
 =?utf-8?B?KzRwWTdOMTB3ZjhNS1RHZjRaWGlhOFdEQkY4VnA0T0N3OVFackxuOS94MXhD?=
 =?utf-8?B?d0pGTlJJcWMwMGxBcWVEcXp0L25Xekk1MjZwekxtOW02eWx5SmkvdStBUzQ3?=
 =?utf-8?B?d1lvSVBYTG9Fak9VVkVHcE5TaHAzZzFleGNDdjZZbnNFeU05b3lITmdCYkk4?=
 =?utf-8?B?ZzdZa2tJNi8zYmpqcUVsTmo5czRCcEZlNzdkS2QycFIrMUpFeE1YRTkvK3VL?=
 =?utf-8?B?ZE5xeHY1VWVWR1FpNEw5azgxQi9zaTRveXJNLzNHRXdBQVBZcVVhbVRSN1Fl?=
 =?utf-8?B?Y1JuRjVEQ1liWmx5cFRtUEZEcW03U3NZOXdNa1djRmNUbVg5WmVtVHBKSjh5?=
 =?utf-8?B?RGxtUmo4WGlmaUxBRkgweUMwZnNuQnVYb1JwZVVzdDlzRzRnMGFkTUN2RUVE?=
 =?utf-8?B?bnFDQnUvTjJNbEtwMHk2bkI0QkhORXl1N1dJUWJZby9zazNBb3VBMHdId2c3?=
 =?utf-8?B?bzFOR2g1VTVMMnRZcmlUZzNraStzSFRPcXhCdnVkY3I2bXBmMGlPZ29Pck80?=
 =?utf-8?B?T2NWV1hDOXIwVEx0ME5BMkRhbVVpTWdkZDhqSlgwWUlUYmxLU1lkN3Z1dk1H?=
 =?utf-8?B?MDBONmpDblprdlcvWGpNSnNEUmtjYU1MZG5relVFRlJmcEpRVnFYZkIzNHdF?=
 =?utf-8?B?TFNCOHRjRGluditLMWhuc1Blbzc5TjlsRW5sR1dQYlBscWlmN0loRzAreENx?=
 =?utf-8?B?OGloUVBrUDhCWk5lMmdWcGFqeTBoNXV3Z0UvSWQ4YzhNYXZIUFJEVUR6eHpU?=
 =?utf-8?B?RzdjNllka1YyM21FK0gzWWw4cVBrNmN6VFRKZ1BJcDkwekVJVWVWMndCY29a?=
 =?utf-8?B?cVJyNTNrRzN1eStPU3VCOTFwMDJOYjVaWmUrdDdZMnBERE5BdEdERlBmSVQ3?=
 =?utf-8?B?MmM3NmxscENFMkxFL0R0cHd0S0Z1TlRWVUd3VnNFbEdJNTA4dnB4ZFJ6MEtB?=
 =?utf-8?B?bFJPU2lKbGo0bFJxcWQ5bzVtZVQ1VTNFdk8vVGtzdnlOYkZNbGpheXRVd0pL?=
 =?utf-8?B?SExFeGF0QmEvYUZGSXV3ejhwdWZ3bmJsTVUvMW1hNkRwb1RaVUlpbmFvNzFQ?=
 =?utf-8?B?eWl3SitjTW5pSjBVN1M3NUViTEhrNTBKeElabGRxUVFsVW5KMXJFNDlrS1Bk?=
 =?utf-8?B?M1BQTjJYSVY4ODhsaFN2Tzd0eGpIYjFwajF4TDFtQ3pKVXhJdEFRdXY5Vk0w?=
 =?utf-8?B?WWhzMVJETG1HNGMrZlJMU0xEaVlVMFVMRUZMdkRRazNZRUNhRW5mcEswdk5a?=
 =?utf-8?B?OVBUTmpNbkloUFRrQ1Y0WUZEcnl2UGp4ZVRwMFpSekMwTGR1ck0zVWxpdU9q?=
 =?utf-8?B?SFFPd2QvSkU2aWxBdXNVcEZBU3lmTTVXQ3dDUG9zd1pxTjJ0anhOR1dGZDNY?=
 =?utf-8?B?NVJ4YTlXazlPVmNyMWxwQmluK1NvYktDMTRLUVpBenp6QzcrQS9BdDJSYm5Q?=
 =?utf-8?B?RUVyOURCckx3OVlYMU0xQkZHcWhySUZTMTdkeXVGaHltTElaSmpEQThmUlU4?=
 =?utf-8?B?bVg5cHkraVFMdlN4UXZYUDVIeThRL2tnMEMyQy84Y1BmZkpDMlNzQmxPS09m?=
 =?utf-8?B?RDc1cEU3ZkZqRXBjQ2ZyZHAxTER4SUFhTFRFOEVlNmhmR1FIdko0RVNRY25i?=
 =?utf-8?B?YXUyTnpuZmNFUmpwQkZwMHdmVUlwWUdvSU9URWZjL2ZZeUJ0amlZckNMcWR5?=
 =?utf-8?B?bC9pZGQxRmh5RHRlSXJMakUzZ1QrRnZLQ1VBRWZZUVQ2Q2FWKy9kcXEzVGxw?=
 =?utf-8?Q?n377lXyE8MSy7aIlWV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a62942-64d2-4bd5-83d5-08df08bfedbf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:00:53.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5Dm6Ery9wZ16ZM7HVDRgoGDidZOlHF/Vxwv70obn12Lcy2jDjBNGao9rKB3n2y9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

On 9/1/26 19:08, David Hu wrote:
> From: David Hu <xuehaohu@google.com>
> 
> This series address two related issues in scatter-gather mapping,
> specifically for the MMIO based dma-buf mapping. The fixes ensure
> sgt mapping is correct, and proper for large MMIO regions.
> 
> Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
> (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
> phys vec to sgt)
> https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
> 
> Patch 2 Splits sgl by largest page aligned chunk
> (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
> https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/

*sigh* such issues are exactly the reason why I didn't wanted the dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.

I'm going to push those fixes to drm-misc-next now, but when there are more issues like that will mark the code as abandoned and not maintained.

Regards,
Christian.

> 
> Changes in v8:
>  - Combined the two patches into one unified series to avoid merge
>    conflicts.
>  - Collected Reviewed-by tag from Leon Romanovsky for Patch 2.
> 
> David Hu (2):
>   dma-buf: Fix silent overflow for phys vec to sgt
>   dma-buf: Split sgl by largest page-aligned chunk
> 
>  drivers/dma-buf/dma-buf-mapping.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> --
> 2.55.0.897.gb25b4bd76c-goog
> 

