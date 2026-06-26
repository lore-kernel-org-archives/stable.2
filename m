Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F6C3A0B24
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488237; cv=fail; b=IIqh+jaHIVVXZXq6nSakobw+0p0cE1MW6ydYbJbvxOZ1EAo6MXf8F7PpF2BdH6ESMADvieST/YYL0VDKP60/aJaTEXUFOT3d51szJygw5OQgIowiclrtmkKQNAwDJ9i21AIrGTyWSJzKgb4ScTXsjuS8wLECSXFCR9OLyS9jtZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488237; c=relaxed/simple;
	bh=k13ArHsUKDklRpMIYHfXZoP6UDm29idePrqWO8rnJNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d08JWi4F9rSFazYIqv/Hf+Cnna/l6ngtfKPCh1c9SdHcPfbm1973d0QNxKypbT/nKIcsQLkPfEv3EJ/DdTZoqLvlDKIMJuG3jYfXGDZnWcKv/7R5egXcPl91TaRSYMxD6+sziaFwA5bsknD2vrj6RubDsrC05faOuJXPy8pueM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CPBtpUgD; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CPBtpUgD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHRIfgd3Z1cI3fot9pFn9OqDgMmLVRRTpd7EH4jLidYa9Jf5jop2eWE5+Yppp8oDWgkxKjV1bWfLmIdQaOE4fX0HT1y78fZTbYG6M1aOAFHYygd14o6xZVlJ8NWw+oHY/OUNo2Uv3ZFct5PNZaKKdhZR+eMdDqRk+X+GCVQMlpgzb10q4NIK8M2iQT/70rVEffsJG+1IUxD6fsUwhSNRyC/nlpARdIRRSZbTX98Y/pL43qjEAbGIRmWhYzckQLVXK+HH4bGsiykc3pWMj0UbW+yp3BH2z2WDt1LrUWdFWnUnSxZ87xUJg1pCenDSOy2uKpSyhttRkDG6Qc7Ako8xQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI8ne+nQj+pUtuZxyaCn8ph5ietmi0gg0M5KzbHe2AY=;
 b=jR8apjsiS9+J0UyfK5+kVHCGSpHI69F2dlA6YneE4FYLqPI8Fr7lkldoXglOqigeDbm+I5i+HrXiWYWAN5bORJuENmJwYQ4VnkQApMfO022HlLRcVzVxweMKUHEn052u2q0KP7qbNq/sgMrIrvoJoLOFNFkCGHzq3mCcCGSpouEceAvsFKMG/32q7rFaDHlCcmx5ns0+Oo6ueqDdZDB9BjD6rX21tQQFb08w5kJtzWuX7tUW7g6GI7bpnGd3mSHRpYrZWvb7g0J5YKf25Ljwubx7F7Pgtjk0/Ddw/eJlvuu8+dXOTpb82hcG7wDe4w6/WJSm9PKX3sGaqPhqIL+HJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI8ne+nQj+pUtuZxyaCn8ph5ietmi0gg0M5KzbHe2AY=;
 b=CPBtpUgDQ1Sagd3FttktxLwSRLfsnpd7n18zt/Khx1hkhvKx7eCOSOHnR3dFs3z7deDaTNkUG0Qq4DDy86xK2nJfdGvzzadTqNLa5NQfKFjcnt+9CsJiO56ep7Z+2SfCRpdCI8tctkFlYRBU8tJUmNohZyLrwtT1uzWDWUHus30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 15:37:11 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:37:07 +0000
Message-ID: <77548d09-b133-4616-bdf4-f01d78323ac3@amd.com>
Date: Fri, 26 Jun 2026 10:37:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [stable-6.12 1/3] KVM: SEV: Ignore MMIO requests of length '0'
To: Jack Wang <jinpu.wang@ionos.com>, gregkh@linuxfoundation.org,
 sashal@kernel.org, stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260626124539.201250-1-jinpu.wang@ionos.com>
 <20260626124539.201250-2-jinpu.wang@ionos.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <20260626124539.201250-2-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:610:60::31) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 85761536-122f-43dd-d1f9-08ded398c810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7XvzyofOxoVvZ4Pmv5vbBazYFiSuDj2HLdz7wougvhq+3KqiY3Fuqds7Cy7nl10VoKmkq6goBJHrjZTk8thAhEuljPyql2So/I791vT0OgqiH2NgJS42hGEqK0XHVmUMQvHkEZcaIZKMDVVuviiTHFNVs1PVs+Y04HHrZJi0RymwgkLvF5Eqkkd/KleH9YLI40gMaMlf7Ila8kf8L+NNzHPz14APCFfszawdtSo6BrdVW9+k/jMYoShMeO7Yzj7SVZt9haYQvlygxZZMFfqOhkfysFj57J2J0tsTpYwPWIzMA1tzr7w+QQRmYYHrTUb0oZ7tXNQDWWBjV8CghQRuAgaf7KnRqJ3HoJQsf73zIQDXGY3Y7Iicti8Mn7azbFr9GIgn7ZoC0PLBV7WZd/ZFGtsmN2380ywQN204CH5bBnB9VwBltts/t6e6xPx+iTs7U83F3a1NCRXjCGwKoJ0Yn7bslXGKxh6/baMS9uLD0gPoD2jcLSqBwLRwFISSaqYv3bTphirhxrZtjcTRl3S662kMO4DYdIlwymfEoaI9RnIAlH890hbLAUaaR871jYrRVuk9za7NXSaMQ5c2BTPx0XtihaFTmicbpR0YxNroLzBdEFoqEdY4LfeUN39QUKfIfyKXABUcS+4qqXRLo4Q0bzuc5bVLzommWuzqnxmhX/s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjlsUVRlS2RXUXlLbU5KSG93MXllMWJab1ZPSW1LejROTUx5L0k2RUdkS0Nu?=
 =?utf-8?B?VDExRFFUdEFTMElMVUtLRExJSkJhQjd5MjY2ajVncEgzMkpBUTBUd2g1VkR4?=
 =?utf-8?B?aUovRHVSc2tGekJqbmlOMWhqY0MzWVVMb0FwUmlCQzdKTlBUaktUeit0QWJ6?=
 =?utf-8?B?SERnQ3htM3lLd2hWYWxTOWZ0VnZGVVBrOTRJV1BqODQ4SFJQRzdmU0poaU5J?=
 =?utf-8?B?alljb3lrMkpiZ3NoOU1VaWtiSTR2elVDZ3ZZWk5iVENxYzdHZUduS1E3MjNr?=
 =?utf-8?B?aHZFa04vRHI0K3loa3RHK0loa3JIalpOS0drRCttUHB4TVh2WHlOdlUwWXZY?=
 =?utf-8?B?ZWt1YnZtOWRJbDZoMVluNWxiZk10a1ZTeTBzWmRHWVhIVG9YWC9qU2dyMi9M?=
 =?utf-8?B?S1MwSmUxeU9nWlNnZFo3c2xaTE05WVh0SEJQQS83L2dhWEM5YzRNNFA5LzVp?=
 =?utf-8?B?V0cyUzc2T2dsL3ZiMEMrZXphT3VvSi9seVQwYmRwbFNEMElHUVZhN0N4d3Bz?=
 =?utf-8?B?WjI4bjNRNktRMXM4Z2NhNlRCQ3JLbXYyS0tNajc0TzFDUVVVRjRnbFBQWlBq?=
 =?utf-8?B?bENKRmVjb3ZBQU52eGMyWmdJdldsM3l3Q3pIY2lyd001N3gvWTFyMzI0SG5n?=
 =?utf-8?B?SFIxbkxKS0RLSDJ3NGZGTjBJV2xia0pxSDN0NUVqUzkzb0k1Wk8vdm5CU3Jl?=
 =?utf-8?B?bGs5NG9McDVjaEFmM3QzZ1AvN0FvWUd0K0hscGV3b2R1eTFmOWVsMDhodTVj?=
 =?utf-8?B?cnNZZkdOTkpDQk1rUmllY1J5TjJaMVFnTUN0Y21pMHFTMjhvMG56OE1nVytv?=
 =?utf-8?B?ZTdLOWFqOFp1WXFseDVYc3I1cGMyQnNZSFU0eGxJZWZ0azJoQTFQcjFkbXhC?=
 =?utf-8?B?ZkFtTkNtbFpQazlWV3RWRUhYUDBCOUpLQnA3SmNMWWJIOTUxL3RieWN6TGFZ?=
 =?utf-8?B?M1E1YTVVUmRjdjJyd0FmUGlaNy9DSSthOEVNVnRpZDZqR3FETjNqZjZMTkd1?=
 =?utf-8?B?R2U0OWFaZGxuVlZwWVRWS2hhTWR1SS9NeEFaOHpVTG9YeDJmWUhZVnlKTjl4?=
 =?utf-8?B?OGRURjI3UHd6Q0pFRjdxSG5KMnZlenFWcHNId3JKbFRuZ3p5aWpvVlVkZEFm?=
 =?utf-8?B?VmtCSTdiT3FsVVl3K0FhR2Y3a2ZieFRsUUVNZW51aFppVDVRTllVekFPTGVW?=
 =?utf-8?B?QzNiSDZRZnhyaUFzMXlYU05JMm04eUlkSk1aRkpYeVFVVnpFQkRaTVkxZGR0?=
 =?utf-8?B?N2tNNWpRbVBYbm0ybHR6dXk1Q20wbUFxaWV5TnlNcjI1Wk5jKy8xS3hvRXk5?=
 =?utf-8?B?M1dpdFlpUjJBenhwV2I5eEhHM0dPaHBCKzB2YWxTbDFSdkYwclJNYWdCQkRG?=
 =?utf-8?B?ZEZjelhoMDV0aVVWeUxrYTVKZ0NENCsxdjNOUFFTV0h6d2VlUHg4bmlyUjZ6?=
 =?utf-8?B?U2F3bTd4VTVFc1RGUmdmZ3dkVEpNczFPM1Nid09VZXplczZ6U1hDMWQyY2Vn?=
 =?utf-8?B?MzVFL2FHYS9MSkFHMkRuOFdJVnRaQnJHUUtvNnpZd21PSkNLRmtrYURMOUt1?=
 =?utf-8?B?ZG1Ndjh1ZHB3OFdMZWhvemJER2Z6SlJSSjFMRGhyY25vUWoxOStDdGhkZkFE?=
 =?utf-8?B?eXlvYnc5WER4SVZPT3hGQlBCdlVPam5ta3VZNGxTb2tQV0thSUlUSW8yU1Z5?=
 =?utf-8?B?RmUyWm82UCtidzZ4Y256dVlzV0RZS2NYWmRNTDhibnBqdENxOW9jTTRCMi9N?=
 =?utf-8?B?Ky9WcFM4THBGSWlpMERrN0xyY29ESWQ0dkFvSVU4bEp5SFRkUnJFR2tPWXRE?=
 =?utf-8?B?V2VlUVdBeWdWUHN1L2Zzb0hJdms5SU1EQ2FhaXEzT2dFeEFJU2kvUHYyYXBh?=
 =?utf-8?B?czhYc2hkWjVRaTZETEFRd0V3d2tnUURodjY0VWRmU0dyTHBRTWhBREQ1UFdw?=
 =?utf-8?B?ZTk0SVlmdm9PeFBoSTlPRncyeHBuOVF4ZmIyVzNaTytNVmx0b1RxbUtpZFcw?=
 =?utf-8?B?T1R5SXR1V3dnWXVxQzhnb3V3Z25IOWNQSG4zaFBFUXRZeW9RMGIyU0dtckF1?=
 =?utf-8?B?WjVxMUtKai9RNVNSenN5NjdlNWs2cFNKYlU3Uk5ERG5RaW1UZ1FNN1BnalNV?=
 =?utf-8?B?SGg4dUF6TUFTMGtjRUJCNVZyUHhrVFpiNFZ5Q0piRitSc0F3L1VGRW4vVTg4?=
 =?utf-8?B?bitOTlN4Q25wUGVSc3ZqSEM4T0JXUzBhZWhLT3hmQjVNYndRbzhoMHEzN1Vu?=
 =?utf-8?B?R0RzaXlOcGlMdHpEQm0rR08xS04rV05paW9idEZtZDlCTnJBSU01cCtrWEVu?=
 =?utf-8?Q?WMTMCTUSFLlu+PCaEZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85761536-122f-43dd-d1f9-08ded398c810
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:37:07.9570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ibkn8w4YrnFr0jihFsn5eXMYh+/3lGUSpT5y1WoKBOGF9KYJDAzloTGWhLm7oZZ4P8kA5weKX1SAk8BjUqtD1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244

On 6/26/26 07:42, Jack Wang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> commit 1aa8a6dc7dac8b83234b53518311bf78231f4fa5 upstream.
> 
> Explicitly ignore MMIO requests of length '0', so that setting up the
> software scratch area (and other code) doesn't have to worry about
> underflowing the length, and to allow for special casing '0' in the
> future.
> 
> Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
> Cc: stable@vger.kernel.org
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20260501202250.2115252-3-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  arch/x86/kvm/svm/sev.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 115c59c86f44..9374b1a93df8 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4356,16 +4356,22 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  					   control->exit_info_2,
>  					   svm->sev_es.ghcb_sa);
>  		break;
> -	case SVM_VMGEXIT_MMIO_WRITE:
> -		ret = setup_vmgexit_scratch(svm, false, control->exit_info_2);
> +			break;
> +
> +	case SVM_VMGEXIT_MMIO_WRITE: {
> +		u64 len = control->exit_info_2;
> +
> +		if (!len)
> +			return 1;
> +
> +		ret = setup_vmgexit_scratch(svm, false, len);
>  		if (ret)
>  			break;
>  
> -		ret = kvm_sev_es_mmio_write(vcpu,
> -					    control->exit_info_1,
> -					    control->exit_info_2,
> -					    svm->sev_es.ghcb_sa);
> +		ret = kvm_sev_es_mmio_write(vcpu, control->exit_info_1, len,
> +				      svm->sev_es.ghcb_sa);
>  		break;
> +		}

This isn't right...

After I apply this I get the following code:

4349         case SVM_VMGEXIT_MMIO_READ:
4350                 ret = setup_vmgexit_scratch(svm, true, control->exit_info_2);
4351                 if (ret)
4352                         break;
4353                 
4354                 ret = kvm_sev_es_mmio_read(vcpu,
4355                                            control->exit_info_1,
4356                                            control->exit_info_2,
4357                                            svm->sev_es.ghcb_sa);
4358                 break;  
4359                         break;  
4360                 
4361         case SVM_VMGEXIT_MMIO_WRITE: {
4362                 u64 len = control->exit_info_2;
4363         
4364                 if (!len)
4365                         return 1;
4366         
4367                 ret = setup_vmgexit_scratch(svm, false, len);
4368                 if (ret)
4369                         break;
4370                         
4371                 ret = kvm_sev_es_mmio_write(vcpu, control->exit_info_1, len,
4372                                       svm->sev_es.ghcb_sa);
4373                 break;
4374                 }

So we end up with an extra break at line 4359 and the length check is only
applied to the MMIO_WRITE path. This patch should just add the length check
to both MMIO operations before the call to setup_vmgexit_scratch().

This will need to be re-worked, as will the second patch.

Thanks,
Tom

>  	case SVM_VMGEXIT_NMI_COMPLETE:
>  		++vcpu->stat.nmi_window_exits;
>  		svm->nmi_masked = false;

