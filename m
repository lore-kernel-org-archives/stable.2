Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792496408;
	b=KZYIhEgL/wFMJBrdrmFj4IwQc8Zz8RCjzXWoPN9E2/ezm8UmEwDDlT8mwf9ZOF1fHdd+
	 F2KAP5pfusglmK0oyySH/EyoFwFaSj0Rx0H8H2SossOCI6xb+NpeerDdAN/U3a1HrYnGF
	 IXpOKkmGrBNOFXYHlsHbdPFEnTlIoKKcSrXoFh20TGdWO1ai8al4bNcxeiRWVDancoBN2
	 OlWedoZVjJKL+uTG1DfEXOu+kt6YKskIHtfxWod8aneKv8P8UuuM6WVaBPQ2SHaTg/TTu
	 46n/EGfTDNywvLr5ydVj0EsR/x3/kzhHu6sm/qMn9MboHvzYjdHBX7wn3DtYh1XyTnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496408;
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
	bh=4K3+mJO6L6vdgx0TxdKmZ+KvwF6/gC77ZE1nB+uzjRE=;
	b=ct2xYP2yYlZcKAFp+unsHandZNu54NKqqrqL5LLS5nxZYDSKQxNlNy3DzgU+a9Gp0q/T
	 O0rwwrTsDyJzCVSQDQJmVySKyZsa9AHYaAVwjk4LDmieZ/EBOoTJfSkgLP+LP0ZrU+SFU
	 s5fRqdvtDEBFjgcRzoqhFwCHQ0DzzLMWriKamek2cvDHAPo8QbiATpcaNRJdMTgEVWpQl
	 L1OZ688SZ1Z0tSOkFZl13WyShx9Ty3YYdzdDbpW+B98mncy0gHI4iWMosAHjfOS+kACzE
	 ahO015jrSqB4E2hSknYoAhUZ6sD6QpgCoOcElbQbaMVOMX73Ln57T3Er8qRDXth3/kA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LP32gAKk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.17
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15128606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15128606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LP32gAKk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvRU46ckHqIeqVd99kCUpPX7JBh+Nw2RNNd8DjHJm0lcf2vN1NfSLBIhiTGpORhYjYHEuJnL+h5WrYT0mPEFtJ/PdEdKPE4Ha64O1q3QDON6DW+LoNbdhtMo7ivClzf1oYNNKGzEZLLmfZRANx1uilyYG/0uu5dD/SRA7/dn58Onlf198VAX8Zc75FP1o8xXWyp+mvIaPFOBFBgxMj6awbTzWG+1Gk4Y6inbbTpbRotJJAa8EiakJeyQf2DCtK3aBS4UnBElcBPgeHr/0zbMfo27GjCOAbGJeZU3unQKtp6/7N/ZE+n8TYbimz20zoxo/EnN1Q0HW5UV3RHZTYhqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K3+mJO6L6vdgx0TxdKmZ+KvwF6/gC77ZE1nB+uzjRE=;
 b=beoOweod1Cwia/YsabOCfgZNdREd89raxfwFfw1kfVUOdmGBWjAJSqly8lieYjzpiqTW2IKw8gneTn3fUB3hl2jMFUAAudzI8Loskn1uBsFizxcJt/kVzhPrjkoPkcTskzSPt+r0Ji2wkk94zJJXWcdtvQTYdCe6LmLrkS/at6zr9jGRQVFegYzo/ivrj9qpH7N2n8Wwi2MeE2I80vh+FBgfyOy1u0/R7wo18yoivRGx31ovhsGZEPtsn54DcspZrL240jzbsyU5wBEAkRLbuvlR6R7qdCXShoA2ZSIadskPd7p0V92tnyVA2WcQXMnw1Kkgk1hwjb9kMrQAcZEkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K3+mJO6L6vdgx0TxdKmZ+KvwF6/gC77ZE1nB+uzjRE=;
 b=LP32gAKkrqKDbjrR2WN4a5HRRxyylS5/lhw9Ugc6NP1X+XE5h8pGy7xoDRBer8tEiHL/dbzsncBbABC+2ByO/yDBI99WJot33AwF3PHG1JhF11wdCQiLMEkYWqUhnNHLcJn47jBely9VF9XOYouR/0ezEirFTvadIpsfJJAJm58=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 11:39:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:39:57 +0000
Message-ID: <36edbff3-fb61-4bc9-ac2f-0ba549ffe248@amd.com>
Date: Tue, 20 Oct 2026 13:39:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gmc6: restore FB location and HDP non-surface
 programming
To: drury.brad@gmail.com, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20261020-gmc6-writes-only-v3-v1-1-70730a302504@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261020-gmc6-writes-only-v3-v1-1-70730a302504@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5ad20e-bc99-4f76-40ec-08df2e9edd8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	BrjA4TZcfhSFah1d60VKxRdSEUws+dOvprDN9Qc70Ugwa7tm5eQOzqQFepmmOp/xCbH9mvE3rA7ZUgOU3VIDAVAvJh0YNEKWAsfKtraZIlssjxmlVye67XY3yWyoscPsKt3QXwVsnXfVeW6cxk7wufJDU47tewAPBBWVyucesraXOycRNYMpadE/Rzh5E/ueW6Tv5M0VILCz65BSk7L2O+7O6PBdNV9gjgnfTodYWPWo0HaLZ8nfcU8YyRJS65ZGq7j2iML62N2aUIdWs3btsAWPSFpS6GgLAcPF916Ay0bgj5i/PLpa0oquy5DDXf5U2YmQKekk8Knji2PA8cU6R+vuVwhEjF4EzrvV2bROEHT8jNLvC8H3sVEiuFwdncatWgrap60aHMCS4y+XyN3t9DwN82vOinz9gmUAK6TtWQs6I6nLW7GVBWMKXdpFWJq4qrHYFDeElupRYQ9Ub3LUxnGXZHRJQlQzUIWeuNfheMJnUMfE9ShNehooNlB+7Ftzw3dVWxLNGpFM5etXZTgeUcWnpjaBt4D0IL2/NtNrOBf5kTXaalSa1Uxp2MFOz6uEwBU0VGxw2hfxQo9Yr8nVu+TrBxNqDKfftVQYscUfrIBBFt2Zt3zo3qTRV7gE9k+6BTl8SOfxm4WL2niln0yOHyANOd2dVc+QA/SxkJ4J0wg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXVDaTlxV2NpWnJmZmRobTltVjcyMXZzR0xMYWFBd0dpRzNhaWFVSGJTU1Zn?=
 =?utf-8?B?WHNxUkwvU2U4TFRkbzlyNDlGckhSYnVZaXFmK0pCZ3M2amNMelZWWW1DbVpH?=
 =?utf-8?B?K1FTbnBCY3lpSTFkNmJiTUVOWHo2TlBRN2p1UzB1S3hOZ0hTbmJ0UmlmZ25a?=
 =?utf-8?B?elQyTEpmbnJqb3o4TnN0azEycWdiUlAwNHZ1KzNyanRRNGVlNnZEVktldEFl?=
 =?utf-8?B?cXFSMjlVNmZmNldQVm5WN3I5R0tSTlNnRGF3clN5NHJ5MGdMcmc1eEh5SWda?=
 =?utf-8?B?MDFVUmV1MEFlR3l1MzlkYXA4bnlxSi9PWVdKR29rUE42d09icHZ3UTJXcGdR?=
 =?utf-8?B?RU0rY2dzaFJYYjFIR0c2M2ZtbjF4WmdqUUx1dlJLT0R4S0xPUlhtd1lXWGRh?=
 =?utf-8?B?ZWhIQmc0eWZIMkU1dkxwcVJNd0dBTW5FdzI1bFR2dDYweXo1SlYyaHdJL2x3?=
 =?utf-8?B?R1NnQ2hKMUhlUTkxenFTWUxSZEwrOU1oeTdSemNGVDJ2YmQ5bzljcElRSHVh?=
 =?utf-8?B?SGVGOURzY3U3L0V3Ung5Ymp3Y1A1L3BHbHI3U2FnSDFkTC83WURNMXBEUy9F?=
 =?utf-8?B?dStVbHpFSzVHNWRSR3lSdGxCa0Y5Y0xUK2Zvd1c4ZWswZTRnakpRYVRmOVRs?=
 =?utf-8?B?am1ISVo4Tjl5V1lUREZYUnJYRE1pRmk0WGxNOXcwV1BQVUFNWkM5Z0lvV0k1?=
 =?utf-8?B?SDVuaWtYT2UzdW0yMFNRQjBDR3J5VnFuYmQ4aVQya0FDV3o2a3FQOGlsSmI3?=
 =?utf-8?B?WGxFL1U2OUNTM1pSU29FN3F0eW9tZUlMUVdrcmlhbmZobUZXZjlLK3gwZmdu?=
 =?utf-8?B?KzVjQjNZVFFkSkVLQlZSR3pIckhsdU9UajBybUdoVTRJYU1LcTBVUUx6Z01O?=
 =?utf-8?B?SjhzV2hZcERiWDZsVUhBdVJuSWdkaVJwWVlIL2Y5TFVvNGlTbDFUcVZMMUto?=
 =?utf-8?B?cVhVL1hkTUZiZnJHeUFmZ09vUHFRR1NRQ0RZTkZ3ZkdhZ0NBTkdHQVJWMm9v?=
 =?utf-8?B?NVBMQ2pkQU1oWEQzR0Z3Y3pWeSsxQmtuREwzM0N5dFVONjBGeGJmOFI3b0VQ?=
 =?utf-8?B?MVdYQkxlemRIZTM4NWt4anpSMzc2eHFnbkVucHRIcjBzdjhwcWZEeVJISkM2?=
 =?utf-8?B?YWZ0ck9YeHgxcTY1UytncGMzcWRQTEVUUi9qZWxhaTgyVjZYemtYTzg1L2RS?=
 =?utf-8?B?dUlsQTlIdW5OKzdoTklnS2phNWlJMndvRHN5NGN0cy95THg1Z3l0YkZjd2xK?=
 =?utf-8?B?cjhoKzBYRWFhZUlRaVRwaXltYjlzVzBEbkxVMmtsYzJxRCtlK3dyb2RaN3lw?=
 =?utf-8?B?K0FTZlJCRFRrVGxsVUJ1R0xwbVZkMnRUKzY0UEd2Qmx6NnhacFVUVEt2b05l?=
 =?utf-8?B?eU1WWHlYM1BMQjJmZzlRSk05eXNNU2ROVTJKVGdEcnZOUjFDNGZqZGFjRUR5?=
 =?utf-8?B?cS9aOTBMOGx1bS92VDVPV0JWU0l1Z0hjS2liN1ZUZmxISGNLUlRWR203Mitv?=
 =?utf-8?B?aHdtYWJ4TXlza1liTzI3bGFveGpCQjR6THJqZS92elFjaHBFUlh1Nmw4REU4?=
 =?utf-8?B?a1YySFJ5Zk5CYzZTVnB1ZWh6UTQ1dU1CSVVVMVZXMzE3alAwTEx0c0xGbVFk?=
 =?utf-8?B?QkdLTnJPd0pQT3crbUF5MFNlV0N5VWZvelZQNXpteFd2V1psd2t4TjAxYkIv?=
 =?utf-8?B?ZmN6SDZEMjQza3huaDZuc1hrdXNtV1QxS0J4b0J6QnUyblpqM3pFc3ZuN3Q5?=
 =?utf-8?B?NUtvV1pYZ082WEplN1g2UUttRHZ1K0ZiOXc1Yi95SlVHMkZ1anhuSVp2Y2w2?=
 =?utf-8?B?SG9xMm9kOGVyYnVmTWd0Z3U3b1RubFpnMktMbGRzampFY2R0SmMyMHFLMkdJ?=
 =?utf-8?B?TnNwTHRGWlFRZlZuRjZNdlEweWtJek4xdldJeGFoeTNNLzFRVE9EdzJybWs1?=
 =?utf-8?B?Vm44OTg4Vjc1eDI3VDVRbmE3VGw5ZXlxRVRua1FRQUhqbEduVSt4N21tMUI4?=
 =?utf-8?B?a2lnenVWN2liMlZndnVGVStaTzZGRUE4dmw5UEsyUi9ob0ZjYS8wWnlGN1VH?=
 =?utf-8?B?MnlhV2xIRGN0Uk5NUlRGSXB2SkJWNm1oMUtONE9YUlRUeG9TMkJCVGJrV1B0?=
 =?utf-8?B?Y2w2dXpYWE1mZk1Da3p0QTVMRGNhaUE1UmpEQ1VyQ0VEUXdrdU9pZTV5WXZR?=
 =?utf-8?B?UFhyWVFjMk9rWTMxU2FmTStQaTYvVFhuTk8ybFc1WWRUbDYvWFV1VjNuSDl5?=
 =?utf-8?B?MDdsckVqVGxpVW5NeS9IVGJxYk01enM1bHliWFVLMVErbHdFWVh4d1NvSW5Y?=
 =?utf-8?Q?9gvVx1zNSXe+hklqTQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5ad20e-bc99-4f76-40ec-08df2e9edd8f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:39:56.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AknfWeciFLXFTkVF3aZwpIQP2Xg8T0tpkc7XXJxUiGsIBmLfkIkp0bSjqxP7bpdy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

On 10/20/26 10:40, Brad Drury via B4 Relay wrote:
> From: Brad Drury <drury.brad@gmail.com>
> 
> On a MacBookPro11,5 (Radeon R9 M370X, Verde, PCI 1002:6821), used as a
> headless PRIME offload GPU with the panel on i915, every S3 resume with
> amdgpu fails:
> 
>   amdgpu 0000:01:00.0: [drm] ring gfx test failed (-110)
>   amdgpu 0000:01:00.0: resume of IP block <gfx_v6_0> failed -110
> 
> followed by SDMA timeouts and a failed GPU recovery.  The GPU stays
> unusable until reboot.  radeon resumes the same card fine.
> 
> Instrumenting the resume path with a write/read-back VRAM probe through
> MM_INDEX/MM_DATA shows that VRAM is still intact after the driver
> re-POSTs the card and at the start of gmc_v6_0_hw_init(), but is corrupt
> at the end of it.  The gfx ring test failure is a consequence.
> 
> Commit 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
> removed the MC_VM_FB_LOCATION and HDP_NONSURFACE_* writes from
> gmc_v6_0_mc_program(), on the grounds that the vbios sets these up.
> That holds after the system firmware POSTs the card at boot, but it does
> not appear to hold after S3, where the card is only re-POSTed via
> asic_init.  radeon's si_mc_program() still writes them on every init and
> resume.
> 
> Write them again, with the same values as radeon, after the AGP aperture
> registers.  gmc_v8_0_mc_program() already does the same for SR-IOV VFs.
> 
> Unlike radeon and the code removed by 71086a3e8470, this does not black
> out the MC around the writes.  The old gmc_v6_0_mc_stop() relied on
> amdgpu_display_stop_mc_access() to blank the CRTCs first, and that was
> removed by commit e4f6b39e8bcd ("drm/amdgpu: remove *_mc_access from
> display funcs"), so restoring the blackout now would stop the MC under a
> live scanout.  On this machine the writes alone fix resume; a variant that
> also restored the blackout behaved the same.

Yeah that is exactly the reason why this approach here doesn't work.

We can't stop the MC access nor the EFI access to the PCI MMIO BAR. So what you try to do here is inherently dangerous.

I think we just need to do an ASIC reset on load like we do for other Macs as well so that the FB config matches what the VBIOS programmed it to.

Alex any opinion on that?

Regards,
Christian.

> 
> It is not established which of these writes is the one that matters.
> At boot on this machine FB_LOCATION and HDP_NONSURFACE_BASE already hold
> the values written here, but HDP_NONSURFACE_INFO/SIZE do not.  The
> register state on a failing resume could not be captured.
> 
> Tested on linux 7.3-rc7, MacBookPro11,5, amdgpu.si_support=1
> radeon.si_support=0, mem_sleep=deep, with this change alone on top of
> the stock driver:
>  - 7/7 S3 cycles clean, from a few seconds to 10 h 49 min asleep, on
>    battery and on AC, including two back-to-back cycles woken by the
>    RTC alarm
>  - DRI_PRIME=1 glxinfo (radeonsi), glxgears and vkcube (RADV) work
>    after each resume; no ring, -110 or reset errors in the log
>  - cold boot unaffected
> 
> The variant with the MC blackout passed a further 6/6 cycles, up to
> 9 h 40 min asleep.
> 
> This patch applies to amd-staging-drm-next with only a line offset from
> the tested 7.3-rc7 change and has been build-tested there.
> 
> Not tested: other SI parts (Tahiti, Pitcairn, Oland, Hainan), and an SI
> dGPU that drives a display.
> 
> Fixes: 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Brad Drury <drury.brad@gmail.com>
> ---
> I can run further tests on this machine (MacBookPro11,5, R9 M370X /
> Verde) if that would help, e.g. register dumps or other variants.
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index a7c353d1a..d6e315f4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -223,6 +223,17 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
>  	WREG32(mmMC_VM_AGP_BASE, 0);
>  	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
>  	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
> +	/*
> +	 * Don't rely on the vbios having set these up.  After S3 the card is
> +	 * only re-POSTed with asic_init, and without these (as written by
> +	 * radeon's si_mc_program()) VRAM is corrupt by the end of hw_init.
> +	 */
> +	WREG32(mmMC_VM_FB_LOCATION,
> +	       (((adev->gmc.vram_end >> 24) & 0xFFFF) << 16) |
> +	       ((adev->gmc.vram_start >> 24) & 0xFFFF));
> +	WREG32(mmHDP_NONSURFACE_BASE, adev->gmc.vram_start >> 8);
> +	WREG32(mmHDP_NONSURFACE_INFO, (2 << 7) | (1 << 30));
> +	WREG32(mmHDP_NONSURFACE_SIZE, 0x3FFFFFFF);
>  
>  	if (gmc_v6_0_wait_for_idle(ip_block))
>  		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
> 
> ---
> base-commit: f307e9d20cc7bd6dd54a3fd8c2af767dd7ef2931
> change-id: 20261020-gmc6-writes-only-v3-33151aacabfb
> 
> Best regards,
> --  
> Brad Drury <drury.brad@gmail.com>
> 
> 

