Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792764435;
	b=KLQE8rwTgG01JmjCjBo6b2c7A8+Ew/Qjx0dECXp0oyrBTox12/25t5c7R7ffCv5Jvkkp
	 Q1dSic0dgXkua/An0e3O3ZwUpUXABhx3ibnxA3RSkuaa2DYQqPHjiwTGMN+6cpQwBk74D
	 qdXp35L2IlvrkSEf3ToDNcrpZ/dOBsPdlTtKLA2QHPE4Ur3sYnDGPkDonVR6dxfAKK/x1
	 hA8sLe8LeJ3gijBDB32IbKAG6Ae/CnKSkNQJYtbQUGdXtPg2/5Uqh/jU+A8dV+8KcORSK
	 OYLNgLhcPot6Nn1SCQClouIjw+tq6yi8dRcDM1M/d8AjDiE2c5PxgBdLb7mK4nl1DbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764435;
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
	bh=f4XJRKDmtlqQm5OERMso+IJiJ2PWcryWjz5P9hvlKpo=;
	b=eVXLm3bdykUZdE4vfIhKXUgXZuAEkmKk67B67EzVUIj4pHK8nnEL+EnIa3jB+Ec9bq4J
	 ilVYG2RT/hEmusmJGoslGSRvsCCT25UBKR301X1hbBuPRd0w/0gtra567hT7kC0cn5nYA
	 F+2ElSPRUUX071q+EDBj64B6c8o+5UD4lVk/cZSwNfLCASzhz42Y4J//X/YbLp5iH9Uwv
	 u+ufUPKvb0dyB6/M8hZGwbrp22L/ZPj8JSyYEKYT3fX0shVVFcFvG+QfqyyaGOo0SU1J3
	 viP8sfxCAna72Rmz6Dmek3/Ddxinwdr6oNo5io6wijhwA6/VAm+4bu1WA01Pl9DbKVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KFJBcKZ+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.18
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012018.outbound.protection.outlook.com [40.107.200.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D6606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA8D6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KFJBcKZ+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6vffTsqlwZIoV//3+6rWEzHnJO0WeI/9sOQOPDqvynoVQTfvtJ+Scgc1xOH27/S/c+rMN6n2zu7spxsorp7DAlF/+3OxQhryPuUazXDHjbuCb+/TElwl6D7R7x/5cLzNdpG6PS7akxYVGv36tkLx+nYGeBBvbdwipTLJGr7CEvlzHIZ7aqfwEHeUawpygS/E5DDy1Kp7XVGgZR5/N4qFIYsaTHrsqzI/i6voyh/xjWRxIZEBVP8tUzHSK5HP3L3xPljpGj8RiNHU+Q88vMbCblFd2TxJj0Jp8BQsBhgPU3RRvqLwdr34ESt3A5Azz99PB9k0cbvqfK6EOZXP0QRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4XJRKDmtlqQm5OERMso+IJiJ2PWcryWjz5P9hvlKpo=;
 b=ijX/I+BSE8Pg4Ic18HyKz2kAOmGXpErbDl3epmk2b1RiMiyMghU8fmebDIdajdz7z/N2pA48mME77ZUY7KB2WgqehjahhOQ3Wt4sIoxD/LYNNu0FnaQrXB+A10u4a2+veySQWh9nvIMkGU+LfWfWO9f1blnSN8CBbSjYWCQlMcSNVI1ofTk4FD0IcUEISp9sC7ehBAqrudMgP4/IIpkeXNXXFwnrMwg5DQ77ayp32bdIEb3Pbn58tchIfL/ZlOE5uZgoOuV9BKFaw4SES4JtuQuhiiKYFddNWFlwlqYgTZpAnji4rYQiFFFRCTQ4vgz5SVK5zYdOACyXONsUphtONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4XJRKDmtlqQm5OERMso+IJiJ2PWcryWjz5P9hvlKpo=;
 b=KFJBcKZ+dqBhqv5urn1pxLArdCbZBHu0bTJ7ZvLdrZXUHZ5H8hUUJMIOWb6df0xrzedOInFBfNs2FZ1etHzh0vrgexQ85KMS14RiT5vz1db4xvf8JxY4i54T8LoRZ6VCr/qBIiS/WANSYZeQk1RYTh1qLN/Kazgk+ICgMaN6UKs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Fri, 23 Oct
 2026 14:07:12 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%3]) with mapi id 15.21.0546.016; Fri, 23 Oct 2026
 14:07:12 +0000
Message-ID: <5b1dd697-d5b0-4140-b4f1-35b3d7dd91cd@amd.com>
Date: Fri, 23 Oct 2026 10:07:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: cancel idle work in hw_init failure paths
 for vcn/uvd/vce/jpeg
To: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 Prike.Liang@amd.com
Cc: stable@vger.kernel.org
References: <20261020193212.19760-1-leo.liu@amd.com>
 <20261021125444.27886-1-leo.liu@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <20261021125444.27886-1-leo.liu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::25) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 870d798b-a516-4cbd-23b6-08df310eeeec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|260925021911599003|11063799006|261021121427099003|261009223027099003|261009223327099003|261009221227099003|4143699003|261009220027099003|56012099006|10067099003|261021123027099003|18002099003|261009221727099003|260925022911599003|22082099003|260925021311599003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	9gOF6Qten9r+SotFhvlqJSIBiRkPcr3lVP+SFGx2z5uM3voE2vzuNaI6NnrhvnZ1nbdJmt+x0Qxg0ch+jCcpS2/p80wCLA0P18xsm6xjKwKdnsa3zvklMbL6tuvBf12o36s4vIHp4z/m5/kEtW6LZMAuFtnWOUh7HzxUCDUJTwgCoQWFekR1yYDpUbXz/iROau5GU/1yzAdNELPjEF+1x/7pi0uEtWviOCwH8YcCgOMS5u0/PuGpGpCuaxetO29mLEmPELFSAN+axroIDmFhZIuSYcI3nabZyttF2GTdyaltuVDFoSbc845EzpaXBcwSyu9EDlnCFUJ0cu23JcwmK2GDAm+2ANsuvDcSmO9j9P6mvK/E0zbcysYXzjPpJ7HR6JOYyzHj/FN0nZuIhCIwYKMmnBhWtfMFA6cPVGUyCIK6FC7PQyNICv06hjvjMB5uZ7/RVSaxXOd77ohopK7KmZYbXt8l/sfBbQCpome8gVZUdHD5/K2D8y6TOgcDMLEBhXDu7Lwg9RH2OPQAp9mt4qXWtFD/3UTmQyTCIdyDeJn060kC0WW02L8H3mbT9J9W9UiH6SqV/Gb7AFfyoZ/+pYq5QdZD4otVKQBB0pVhFrSvszTHVHDVPLAXGAJe32WY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(260925021911599003)(11063799006)(261021121427099003)(261009223027099003)(261009223327099003)(261009221227099003)(4143699003)(261009220027099003)(56012099006)(10067099003)(261021123027099003)(18002099003)(261009221727099003)(260925022911599003)(22082099003)(260925021311599003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGdnVkl2L2IrS3N1WCttOXJUaGRKWjYyVlp6dkNveWJFbStFNDAyVkVoeE9H?=
 =?utf-8?B?aCtSSTBablI5aFZ3Q29GUWN2N052M2ltdFp0MXMyUUNVN1dkQmZ1ekpYWWNy?=
 =?utf-8?B?RnZPcGRpVVY4U2ZvdktIaFJMVUkzNVRDWDdQL2Nmck0xVFBkejlqb0d3bkNt?=
 =?utf-8?B?ckVYSVRUQ2lFN01NUGRHa0pmTzIwZmpBOHdPWmhxdnB2VVZNVnh5eDRpWHZs?=
 =?utf-8?B?UUZ3eG5vV0dsN2VNOURnWTY1dFEwSlY2ZU5OaHJkakNvb3NHcGxnZ0ZodXhI?=
 =?utf-8?B?bmVnZXN0T1o3STNxdDlDdkhZVnlqSkU5Y1NnN1ZUYzA5NmRqMzZYMzhuTE9S?=
 =?utf-8?B?YXRHanlqS0ZCdU5HMzJiZENGdG9Vc0NMdXFHNEUyaWdGengzQ1BqM3BCdXhK?=
 =?utf-8?B?NjdRRnRrTE1hM2JrMVJ5SElkTTZuRWRUNE13UEdrL1hNak10cUVvZmxJOVNM?=
 =?utf-8?B?UDNneE5qMVR0dmpudkJSSWc3RElnYlExZjlxNWZIVitOTWs4bnlKMmpDaE5M?=
 =?utf-8?B?bm9Ic1BBQWs4bVZDZU5FbWR3VVkvdWJtNDlHcE5hdTQ2dUliMFVyL1pPSy9E?=
 =?utf-8?B?QTdUNjdXZFg0Q0Fwako4TkVzTEhLUUtWMGZVdS9iUzBqZGtNTHFhR0JYY0Fk?=
 =?utf-8?B?U1Z2YmVzSW56VW4xR21YV0diTklCZjByL09JSEZPc3JVLzFwR0ZFUVFXQUpx?=
 =?utf-8?B?TjRuRDZtR3ZFSzlvRnBWNHFsVmtNQlg5aGxvTENvb052UGFPZElnWFdGL0RF?=
 =?utf-8?B?K21GRHdkcm4yS2JhK045SnRsQVA0SEMxR2lCakVzaTlJUU1XT1g0OElaNlNK?=
 =?utf-8?B?NGpKa0NKVEpOakJjYUwyc1JpSzV4bE9XakFjcVdnSzkvb2t6dFhQTDJDQVZr?=
 =?utf-8?B?cmdaczJkeWovZytVOGhhbmRGQmZLVmR2OUc2K1AwTVRRNTZjQUlRTzRFRTV0?=
 =?utf-8?B?NGxadHRHKzNmL0NYdG1qWVBYK0pkTWJTekZRMHREK2pISmlOV2U2MG8vT2Jx?=
 =?utf-8?B?VFUrWjdkK1JRb25pWjR2c2c4RTZhTm1jbnNIaEpFak9Gb2w0ZEFhNzRwSTE2?=
 =?utf-8?B?bWFJdUd0UVR3TVZQamNBSlM2Qm9yUXdlU3VtalNxVVl5Vkl6SCtadW9UczNP?=
 =?utf-8?B?K1NPQldtYkp1anB3ZzZaZ01RdG1VWk9WWmJSeUtUU3lzL1RaTnJFdDZwZVRj?=
 =?utf-8?B?R1kzamIvR01XMG5VNFdnQy84aXhsUXU3OHVqcUpuRzZWR1Jac05PRS8vYXE1?=
 =?utf-8?B?eW4rME16Sk9KNTBMeklGTGNPcGVTWHFnN0FTTjFpSjdRVG12NU5tK1RGVExC?=
 =?utf-8?B?eGI3SWZvL2FtK21vY2xXcHpGMk1aQzBrL3J3YjVxWHNsb29qTEs0VXpTWm1w?=
 =?utf-8?B?T3lXcXQzQUR2c005NnY5cG5IcE02TXdxQkFWMjBWTnVpV1ZhNVdOYzllbVdB?=
 =?utf-8?B?WEkrcmNpS0hnZkhzM0FVVWQrS1F5cFh4VEFreVVjYWVScitwbGFEeHZNOWhk?=
 =?utf-8?B?bkViL2JwcWtMMWxNdCtJc2F6UEVVZ3hOQklYY0o0cDBiWnMrSytNS21HSllE?=
 =?utf-8?B?Vzg5L1h1ZkJRVTdOVXRwOGQ2RURLVEJpdkdKZ00xeC9Ta2R2Ym9TWjYxMnlD?=
 =?utf-8?B?aitFOFVjcjRkV2l0a1N4VGVaOFY3aGpRbkVjSTE1bk90Z2lzeU9lQjUzQmpQ?=
 =?utf-8?B?ekQ4c0dVS2ZUNDB3bEZleEFreDc1MmNuR29FOGdMaThpODRreGs0Z1ovVlp0?=
 =?utf-8?B?S2F6UDhRTjVYclkvREZvdTNjbkY3MGd2TW10bmJ2dGZxQUZCV2VkTDdySjdP?=
 =?utf-8?B?TDJWb05Pa0VUVzVDL1U1b3hORGI4cXZoZ0cranAycmp0bUZtdkhnbllDb3Vq?=
 =?utf-8?B?eko5SGtJWmpwdEM4MUhxVFAwdG1ZUlNhSnd6V04zWlFXRUExblRaUTVzQ1NH?=
 =?utf-8?B?N1d5dHVlZ0FLUlN6OUVBemRjV2ZMeHNaR3lJQXgwM21nNXZZcld3WjdnR0dW?=
 =?utf-8?B?TTNlcCtUUmFBQTd3cGJ3K3BFSTdBUXZjcmNrbUZzdkJhSUlTZEdiNCtXNi9V?=
 =?utf-8?B?aUZrbWFnTlJiU2d6Y0VqbzB3M1VBZzNERzVpdm84Um9JRXRTMkpnc016eTVG?=
 =?utf-8?B?OFFMSXhJZ2hQaHBhTlJqZGIxbjJJOEFsOGlzUmVBMC9HbUpSQTh4M0pSOW9P?=
 =?utf-8?B?a1dRNDdyMG5JeUpwMkdreVd1cEpwQW1kZ2JScFBndWsreGtSM21zdXlTU0dj?=
 =?utf-8?B?WFgyTEN0YUllQndQcDhXNDdrQmtTRWJiY1VvV1ZlWjhVVjVTRENUWXVUVHha?=
 =?utf-8?B?bm56aXJpSklxanFkeWxXTnUwaDdpTnZMamJydWNKTjdneU81RHZ0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870d798b-a516-4cbd-23b6-08df310eeeec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:07:11.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyDb+qU3KNhYdp7ZqrpiYYSi8L3Aht1PbAft3JgAWGjexu5MEb5vchud+/wVyggYofB8IndQ5ijz1uEgdtMJIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267

[+ Prike]

On 2026-10-21 08:54, Leo Liu wrote:
> From: "Liu, Leo" <Leo.Liu@amd.com>
>
> When hw_init() fails, amdgpu_device_ip_fini_early() skips hw_fini()
> because status.hw was never set.  For VCN, UVD (including UVD ENC), VCE,
> and JPEG, hw_fini() is where cancel_delayed_work_sync() is called.  Any
> idle work queued during the partial hw_init() is therefore left pending
> after sw_fini() frees the adev state the handler touches.


I noticed Prike had a patch that would fix this issue too, by cancelling the idle work in sw_fini(), but that was only done for JPEG and VCN. See: https://lore.kernel.org/amd-gfx/03452daa-204a-40a0-98a8-0a34861dac2f@amd.com/T/#m2df0c271613363762202ac982aa9e40d17a32d3c

No opinions on which approach is better from me.


> Cancel the idle work in each hw_init() error path, immediately before
> returning the error, so that hw_fini() remains the sole cancel site on
> the normal teardown path with no duplication.
>
> Link: https://github.com/ROCm/amdgpu/issues/234
> Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync call")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:Claude-Sonnet-4.6
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 12 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 12 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  | 10 +++++++++-
>  29 files changed, 174 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..7ce3396b1431 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -159,11 +159,15 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
> +	int r;
>  
>  	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>  		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>  
> -	return amdgpu_ring_test_helper(ring);
> +	r = amdgpu_ring_test_helper(ring);
> +	if (r)
> +		cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..46293664fd28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -221,10 +221,14 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  		r = amdgpu_ring_test_helper(ring);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 564e40899df2..361d0f4b4bc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -174,11 +174,15 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
> +	int r;
>  
>  	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>  		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>  
> -	return amdgpu_ring_test_helper(ring);
> +	r = amdgpu_ring_test_helper(ring);
> +	if (r)
> +		cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..4e8eed2b62db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -204,10 +204,14 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  		r = amdgpu_ring_test_helper(ring);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..1925d3092d02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -435,12 +435,16 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>  							VCN_JPEG_DB_CTRL__EN_MASK);
>  				r = amdgpu_ring_test_helper(ring);
>  				if (r)
> -					return r;
> +					goto error;
>  			}
>  		}
>  	}
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..a1496412810c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -232,10 +232,14 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
>  		ring = adev->jpeg.inst[i].ring_dec;
>  		r = amdgpu_ring_test_helper(ring);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..1a4594d5d952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -173,9 +173,13 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
> -		return r;
> +		goto error;
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..efdc537ec81e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -307,11 +307,15 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
>  						    VCN_JPEG_DB_CTRL__EN_MASK);
>  			r = amdgpu_ring_test_helper(ring);
>  			if (r)
> -				return r;
> +				goto error;
>  		}
>  	}
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..eb3dc9558e0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -280,11 +280,15 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
>  						    VCN_JPEG_DB_CTRL__EN_MASK);
>  			r = amdgpu_ring_test_helper(ring);
>  			if (r)
> -				return r;
> +				goto error;
>  		}
>  	}
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..0cbb2b8a7e78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -156,9 +156,13 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
> -		return r;
> +		goto error;
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index ff7128a11cad..97c265daa2bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -710,7 +710,9 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
>  	amdgpu_ring_commit(ring);
>  
>  done:
> -	if (!r)
> +	if (r)
> +		cancel_delayed_work_sync(&adev->uvd.idle_work);
> +	else
>  		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index cf304b489d87..90b57a08d6dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -198,7 +198,9 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *ip_block)
>  	amdgpu_ring_commit(ring);
>  
>  done:
> -	if (!r)
> +	if (r)
> +		cancel_delayed_work_sync(&adev->uvd.idle_work);
> +	else
>  		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index 564d8fb58905..aa75b2691d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -190,7 +190,9 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	amdgpu_ring_commit(ring);
>  
>  done:
> -	if (!r)
> +	if (r)
> +		cancel_delayed_work_sync(&adev->uvd.idle_work);
> +	else
>  		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index dcb8487e22b1..3016227cf0ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -515,7 +515,9 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	}
>  
>  done:
> -	if (!r) {
> +	if (r) {
> +		cancel_delayed_work_sync(&adev->uvd.idle_work);
> +	} else {
>  		if (uvd_v6_0_enc_support(adev))
>  			drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
>  		else
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 46222fc30be6..48eac56f758e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -583,7 +583,9 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  done:
> -	if (!r)
> +	if (r)
> +		cancel_delayed_work_sync(&adev->uvd.idle_work);
> +	else
>  		drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index b1428f5bbc81..0ba9bab7c921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -651,12 +651,16 @@ static int vce_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	for (i = 0; i < adev->vce.num_rings; i++) {
>  		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	dev_info(adev->dev, "VCE initialized successfully.\n");
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +	return r;
>  }
>  
>  static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index dd870ecac2a4..20a4cb6d17fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -483,12 +483,16 @@ static int vce_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	for (i = 0; i < adev->vce.num_rings; i++) {
>  		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +	return r;
>  }
>  
>  static int vce_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index d5adccd3e689..7637305df7e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -482,12 +482,16 @@ static int vce_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	for (i = 0; i < adev->vce.num_rings; i++) {
>  		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +	return r;
>  }
>  
>  static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index ee445d8abe47..4e1fbc7b50f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -533,12 +533,16 @@ static int vce_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	for (i = 0; i < adev->vce.num_rings; i++) {
>  		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +	return r;
>  }
>  
>  static int vce_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 76793a5caa70..b3e63d6e79a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -252,18 +252,25 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
> -		return r;
> +		goto error_vcn;
>  
>  	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>  		ring = &adev->vcn.inst->ring_enc[i];
>  		r = amdgpu_ring_test_helper(ring);
>  		if (r)
> -			return r;
> +			goto error_vcn;
>  	}
>  
>  	ring = adev->jpeg.inst->ring_dec;
>  	r = amdgpu_ring_test_helper(ring);
> +	if (r)
> +		goto error_both;
> +	return 0;
>  
> +error_both:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +error_vcn:
> +	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..12ac20484396 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -294,7 +294,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
> -		return r;
> +		goto error;
>  
>  	//Disable vcn decode for sriov
>  	if (amdgpu_sriov_vf(adev))
> @@ -304,10 +304,14 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>  		ring = &adev->vcn.inst->ring_enc[i];
>  		r = amdgpu_ring_test_helper(ring);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..2b2abe689508 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -481,18 +481,26 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  			r = amdgpu_ring_test_helper(ring);
>  			if (r)
> -				return r;
> +				goto error;
>  
>  			for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
>  				ring = &adev->vcn.inst[j].ring_enc[i];
>  				r = amdgpu_ring_test_helper(ring);
>  				if (r)
> -					return r;
> +					goto error;
>  			}
>  		}
>  	}
>  
>  	return r;
> +
> +error:
> +	for (i = 0; i <= j; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +	}
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..6543f21daa1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -417,18 +417,26 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  			r = amdgpu_ring_test_helper(ring);
>  			if (r)
> -				return r;
> +				goto error;
>  
>  			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
>  				ring = &adev->vcn.inst[i].ring_enc[j];
>  				r = amdgpu_ring_test_helper(ring);
>  				if (r)
> -					return r;
> +					goto error;
>  			}
>  		}
>  	}
>  
>  	return 0;
> +
> +error:
> +	while (i >= 0) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		i--;
> +	}
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..8b5646297c2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -349,11 +349,19 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  			r = amdgpu_ring_test_helper(ring);
>  			if (r)
> -				return r;
> +				goto error;
>  		}
>  	}
>  
>  	return 0;
> +
> +error:
> +	while (i >= 0) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		i--;
> +	}
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..0c58ca25d7b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -395,11 +395,19 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  			r = amdgpu_ring_test_helper(ring);
>  			if (r)
> -				return r;
> +				goto error;
>  		}
>  	}
>  
>  	return r;
> +
> +error:
> +	while (i >= 0) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		i--;
> +	}
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..a6eaa57ec2ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -303,10 +303,18 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  		r = amdgpu_ring_test_helper(ring);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	return 0;
> +
> +error:
> +	while (i >= 0) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		i--;
> +	}
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..055729a42094 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -267,10 +267,18 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  		r = amdgpu_ring_test_helper(ring);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	return 0;
> +
> +error:
> +	while (i >= 0) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		i--;
> +	}
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..55a4b2f9463f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -342,11 +342,19 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  			r = amdgpu_ring_test_helper(ring);
>  			if (r)
> -				return r;
> +				goto error;
>  		}
>  	}
>  
>  	return 0;
> +
> +error:
> +	while (i >= 0) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		i--;
> +	}
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..ea6cdbcb6352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -257,11 +257,19 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  			r = amdgpu_ring_test_helper(ring);
>  			if (r)
> -				return r;
> +				goto error;
>  		}
>  	}
>  
>  	return 0;
> +
> +error:
> +	while (i >= 0) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		i--;
> +	}
> +	return r;
>  }
>  
>  /**
