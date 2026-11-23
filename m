Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795432115;
	b=xu0uvQbGtHWk/TlE4cijJ7KiHK87xiRAQ7TjfnRvmk+UzKeU0lKJ54nNPkjbT2Gg40Ek
	 G65Ium4tVKYAJzI6G1CcMUrJkLQGJi7KK5/e6w4Vl/OBUw8uUEufFNqkM588UyJhzf29Z
	 JrPPtQ9vQKcnmECNAkufL1I0dVz745Qu0BR4npRocT8lPJsvTdatDCUElANAj1BjjMq9I
	 eRhpn7FEkpzfYKHKb6oBTciIfLGz7rVYzC4fGIfEXxCMmthIGVHz6hcoCPvAeJ0NDukEQ
	 QevPEUZXvRihEza2F9mCc4S0D9cVS5YnNK9mYWNXuwCjG+XdpFyPrp7lEzysHapxBlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432115;
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
	bh=H/i3cH5wu2q3CqnPEoamEzXK0JUM0CMUIWay1gsGg6w=;
	b=rmucs/jf3YF+2EPb7ArP3fLMACJpzjjpjQePESDURNxBRJ3TEoO3l3kffMcC4Ufoff0r
	 UB7ShVphTnbRmqfdGJd2Hd+B4dDICVexqF07HGed2pVcXdOn5RrrtIJFaizcSzAcacgWv
	 YzfP17a6XjF3FhzwnWuUM/8dd7PQg+YppozWpKVDFJUC6F6m0PGQpurMUk0OadnNydGo/
	 1x5qhGYWej4/X1VR8Ic5goEHl7n/uNzTRib13NVHz77NVtNRnsUgzye84HnbYugCZsf7l
	 8HhebWahF6kqLQoG8pA76c2KXwiGi8lSNtaTvswX83O6jsNBoxlGYkhZ8cEdtzzCX7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SkK6MruN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.40
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E0606A32C;
	Mon, 23 Nov 2026 11:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C2E0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SkK6MruN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dr2MCr4IsDrfx0WEsfoFcUnHqowNzaDbSyfR2Eb6FgltKhoAFdOD7L+ahkOTnSMmAlzeodLZCNW4l6417nHxa7M0asoDuSRI+ajGoszwtYsKBaMjBnVEXiBkpG5NFyUAPKbBkg+Z7iyhCowd7IqN/sWeA2EaZEbLkELBEZ11dCefGwzfJ3u9qu2EaY2ihptkEd7lRmyMoWXQxxkMBPpXDwYPMjcVOv5NA3h0dnRpaCgxt008CEYnxLc5s1vbCBZcmhqUxSmaMw0HCwUqczs6ggTBa+MTKbvOnO0K4Smol/8f/H25QQqB3Jjd7gPxSn3uQn0yuzO7cXuhG3Sa2ZL8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/i3cH5wu2q3CqnPEoamEzXK0JUM0CMUIWay1gsGg6w=;
 b=n3RENVcykHdqLqHWSG/Q0BQm9Vc4SXwE5zWDR0pkwtzSZ0pu/Hl+SPIW+32PlkxYHPUng61rTwwK0DBu8Z4fTxBg58ZekrFl7hwLxyXNBMiEyKzdZPOQQQ0oUjs82bSR79LqMHM3L4PBaB6h7WN1hPXCBiF7r4R0AzuG/9KwiG6+2cvSrOPsasqouQFA6D/9cmtxqSmAS5Olef6Fe9+2JgCoqpqP/G9QozacHjVu1EwGkCGfPfNOYlXaQaEFxMQpSnx5zkfs1M3bu7LKfSfw+XcoTMS6U1nImBAoZK7x2dL/H+cr7cADm6WlVzNw4HSCk3o4y1dh8lbz8k+Obk5CsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/i3cH5wu2q3CqnPEoamEzXK0JUM0CMUIWay1gsGg6w=;
 b=SkK6MruN+WTIRqQ8lrqV4CUYTJSNum6xRyOYE/fAg82B5bJcEO7dLTsPC6zfxXzDX7WJD2AM+L/OhnQBmFopc/BfZWChPEFZa1RH/FZmuftRLZxuvL8kEOCuBBSzB13XAk1DKdhq4JVgTWoaCAreyH6CJ8uQCsw5fitHt7ROg28=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SAEPR12MB328447.namprd12.prod.outlook.com (2603:10b6:802:209::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 11:08:32 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 11:08:31 +0000
Message-ID: <96ad4d0f-6454-4ff7-ab81-8bbfc88d6e0b@amd.com>
Date: Mon, 23 Nov 2026 16:38:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/amd: Prevent spurious IRQ disable on high-rate
 GALog MSIs
To: Sairaj Kodilkar <sarunkod@amd.com>, Mina Almasry
 <almasrymina@google.com>, Joerg Roedel <jroedel@suse.de>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
References: <20261101062102.1000477-1-almasrymina@google.com>
 <b426d646-5dd7-40b3-812b-e9377ecce4e9@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <b426d646-5dd7-40b3-812b-e9377ecce4e9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::15) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SAEPR12MB328447:EE_
X-MS-Office365-Filtering-Correlation-Id: 544e85ff-2422-4775-2110-08df49521c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|261022105027099003|261022075727099003|11063799006|56012099006|10067099003|261009223027099003|261102123227099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9cU6hEDD7tl3q/9QAGvRecVLOxkWj/IZDVTRW/rB0fkGRooiLce5BLHmrHavuP6hhSdJFnwG+W2/fuIhqRLOpTfXv1yX5TvNHoy8gLuYZylyIbnaZmK+ka/3b9IhcW14dMGa7yQkjds4odJqjU2IVhXrSKw5gLSjhvYw7ahDEBOXSbs8AlL1FU6YMoO1J+Vodv/s4/oBT6Nli/t79C2npGmNjQ7HiQptZPOW4u7NhFVSzmycUW7qcr6SF8AVPCvPI0kDhtihvzLrNAfLANO9DNljXbKyPNenjO6ccu/y8k+fQjJBGZ8BkrXO3db9ROIVcqApPmkepdUgirsP+6z6mLrrSlmQtFd2UWAczb2rVPr7GzoNM4FqvADJiYtGxDvA3IJuYaOKbfbhzFvIape4XiT3+io/JCyXvJO5kZUBZH5uoaH8GBpyUYjAlr/WgIpTo/zlBfx/pRZSmf+BQH66gGq5qkRvnwuLB200oKBr/84IQT+2oJMCK1d+MhYwDALP+QdpTHZgPAaAdbq+v46BCM6+dltUspqtGKYURXZz2MqkkqtRcJR//MC59QeB9taBaoB6+Mb2Etzk+Wsqd9OnqX3BUuPo+XQgqQ2wXmBAPUP5XSoQtMCBhRm5jeMjDBKgJJhuDwwG6NmCtyo9iOda3GqWTSVNH22YOwzgR4fFDx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(261022105027099003)(261022075727099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(261102123227099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjI2dTdLS2s2NCtjdlZzRnN1QkZVZGVhRWJ6RXFkdFRrNDQ1UjRsOUQveHdN?=
 =?utf-8?B?NGlsQlFzcnNQTEVpZkt5NXBXa05yODJrWW5jMkRQbW9nU2xLcTdoN1RPdm1J?=
 =?utf-8?B?c0NQYzQweFFlS0Y2c3pmUkNzV1ovYWhUS3VmeHNwMkVhZXpSYmlEWXJmREps?=
 =?utf-8?B?MDZvSC8wLzJrYTNlOVYvU25pSGttRzRlTDVrc1RLclRWTUw5bnBRQ25EdDgv?=
 =?utf-8?B?RWtPSzZrS0wzZThlK01mQVlGZFVXRlppcDNpMmttbkxwLy84cnhPcHN3TmMr?=
 =?utf-8?B?V3hyZEl3cEtkdTZGZVkvM0EvNUtDeTdNSmxRTHhYbVpERUtLN3FnUng0RGdP?=
 =?utf-8?B?TTV2ZFZwdDhBREZxVGFralNJTVJQWjhsT3RDS05tRWJ5Y04zU3B3THVyNkI4?=
 =?utf-8?B?MDNtT3JtSFI4NWoxZzd1ays4NUNZTnZ0Y0c0YVZrQXpoVzFrQ0oyZlk5cGRa?=
 =?utf-8?B?M0dJTUlPcnFiS2NZYnI3QVVMbWkvMDFrakYyR2xvTU1GRWZJS3BzeEp3ZUlk?=
 =?utf-8?B?MFZ3aXB2RzlUVVRESGNwVmxNejZCRUhWb0t5cGZ2emd4WDV5MXZaN0MvaVJT?=
 =?utf-8?B?SVd4SVBJd2F0L1ZCM1pTQmJzU1VlRmFpWGhxVVB6dDJPaGhNM2JjeFJGeC9W?=
 =?utf-8?B?eE1QdmNxZ20wZjNSeC9FY0luMW5uc09OWjhiTitXdU03UXJUY1QwemJOWCs1?=
 =?utf-8?B?MVoxekZicDQ0WTlzak9MZGRXOE44aXlOSFI1RW0zMXFCYm5mbTA0OWFmeU9n?=
 =?utf-8?B?Zk5YM3dOOEpETmVOUXBVRjM5NGFUVy9CZlV6NnVLb0wzbXYvejU1Tk9mZTRw?=
 =?utf-8?B?b3lybjY0eHkxZTR0Tnc3T2RqczNhZWkxZU1CQXdObmRMWG8wdEc5WDhlWkY0?=
 =?utf-8?B?ZEt6aEtkNWVETUlqT25rblMwbGtyNWNNMmE4Y2pURDVNT2xwSU5rc3ZZaE4r?=
 =?utf-8?B?MzdIU0xTSWdaQnNmeUlET0VseE5aL1EvZk9zcEo0RmFweFlnekV6aDZtUUdX?=
 =?utf-8?B?N0VMT2VGMU8rbGR6RzFKcUM1UDIwTVJrbnMzOGUxNDhHbjh1UVZzNGc3WWYz?=
 =?utf-8?B?RVRnYVlCS3NEYld4MTVmNkVrWTlYVytXbnBXUGwyUS9aVHRSMkdiRDNGRG5E?=
 =?utf-8?B?MitTWkhCQjVOYlNQQnpxYStyWVAyMXRteWlBUWtLeWd2UjFjVVNmaGZsalI4?=
 =?utf-8?B?VmNHQUlZRmpyeFZoMXpWV3lWbURaNUNldVNLMyswSW84R2xYUG01QUF1WlY1?=
 =?utf-8?B?akpwaTBwNGd3NTdXRmJoME1jR2UvS0xDeTQvY3BFYWY5ZVVVcWlQM3daNlk1?=
 =?utf-8?B?anphSzhUK0NJYnphSFBVTmlJcFpldEhucjcvUlI0S0plVHVBSy9IUHNUZnJJ?=
 =?utf-8?B?VzhhZUxiNld1cFZrYWFudXdOK0JpUVpQNnpRNDgycUJkOGVva0pjOStZR1Rv?=
 =?utf-8?B?UW9JYytRVjNJZDRrQW9UUlJlMFN0U0VsMjJXa2g0NGhPMHdlKzdXcjV0Wnhx?=
 =?utf-8?B?SWNuUEhONUx6MTZKMnJCNUcveWVDeE5YSlRxWFVJak16NHF2RC90OGh6UVpv?=
 =?utf-8?B?Yiswd3VBMEtweFRFNHhqeTU1MnJhbG5adSsyR0ErYys1bkg2N3hXT2ExQWx0?=
 =?utf-8?B?L2l3akhRMS9GbXZVRjR3NW53YnQ2VENUZnYvS3kwWUllVks0WEJ0SnhtZVpW?=
 =?utf-8?B?VGgxRHFySGlXQ2VhR2RvdE1aTXJLRTB4ekl6WGxVSkhtaEh3M0gvY3pwYXQ2?=
 =?utf-8?B?UnNVWGRYZVdPdUdON1pTVU5nWDNIMEdSTFdFMXhCK2h3aWlGQ2hUcytqbWh3?=
 =?utf-8?B?ekMzbVN2SGJTRkdTNnp3MGUvcHFURldzaTVZYTFHTTYxRmJabkNsVHNCVGpX?=
 =?utf-8?B?QXp4dEpqMXhpVDZORzBjbzRDczkwUjRWa245QXk3N3NsTzV4Ykp6NDZOUTUy?=
 =?utf-8?B?cUlpcFppNWdFazFnQ1RIdld2Z2xva2d4Tk9ha1UzRE9FR3EwRk91cUVsdU9E?=
 =?utf-8?B?ckFWV2hmKzlmSmptSlAydDhDMDBzOEZ1QkpxRWdIVGNjQXM5dE90ajlQYSt3?=
 =?utf-8?B?TkZrbzZmRUcrbzVPdkw0Y1d2LzdZSEIwV29vcHVSanBTU21BTjRIaUtHSjFB?=
 =?utf-8?B?NW96T3RtaTlnR3M1ZUdkejRZWk8veVR6Zzh6NE1jTWp6RWRMcEpjTE9mS29t?=
 =?utf-8?B?YUxrVjhTMk1kMkJYN1d6ZmFjSUVjSFlQamxZeWw5ejA2SHJHT01LWlZvcStm?=
 =?utf-8?B?R012Q28yY0ZPMzFMQWU3aENZRWVMcFZvSUFIR3JpOHpjTVZkTXFyemRreUgv?=
 =?utf-8?B?SmdEOGsvSk5oR043cTlTM3BJWFVqN2czZ3NNcVFQUXB1bXVwQms5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544e85ff-2422-4775-2110-08df49521c1a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 11:08:31.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPklJPYTI631sOpuzl9Qv3osaC4hgK6LZN1T0BxEor+1a20FX52p0YThBwtpxC9qV7dHjF/XiOOEqM3VDOnAoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAEPR12MB328447


Mina, Sairaj,

On 11/4/2026 2:49 PM, Sairaj Kodilkar wrote:
> On 11/1/2026 11:51 AM, Mina Almasry wrote:
>> On AMD EPYC (Turin) hosts with AVIC enabled, passed-through SR-IOV VFs
>> in KVM guests log interrupts targeting non-running vCPUs into the IOMMU
>> Guest Virtual APIC Log (GALog) ring buffer and signal the host via an
>> edge-triggered IntCapXT MSI (AMD-Vi*-GA).
>>
>> Both __iommu_setup_intcapxt() and iommu_setup_msi() register their
>> handlers via request_threaded_irq(..., NULL, thread_fn, IRQF_ONESHOT,
>> ...), using irq_default_primary_handler() (which returns
>> IRQ_WAKE_THREAD), while intcapxt_irqdomain_alloc() sets handle_edge_irq
>> which does not mask edge-triggered MSIs during oneshot thread execution.
>>
>> Previously, amd_iommu_handle_irq() cleared MMIO_STATUS_OFFSET at the top
>> of the while (status & mask) loop before calling int_handler(iommu)
>> (iommu_poll_ga_log()). Under overcommitted multi-VM TCP_RR workloads
>> (1,000 to 10,000 flows across 4-8 VMs with vCPU overcommit), new VF
>> interrupts for non-running vCPUs arrive while iommu_poll_ga_log() is
>> draining the ring buffer, causing GALogInt to transition 0 -> 1 and fire
>> additional hardware edge MSIs while the IRQ thread is still inside
>> amd_iommu_handle_irq(). Because desc->threads_handled only increments in
>> irq_thread_fn() after action->thread_fn() returns, note_interrupt()
>> (kernel/irq/spurious.c) accounts every intermediate edge MSI as IRQ_NONE
>> (desc->irqs_unhandled++). Once desc->irqs_unhandled exceeds 99,900 out
>> of 100,000 interrupts, __report_bad_irq() logs "irq <N>: nobody cared"
>> and permanently disables the IOMMU GALog IRQ, breaking guest VF MSI-X
>> wakeups.


.../...


> 
> We also encountered same issue recently, I think right way to fix is to
> address the underlying root cause -->
> 1. GALOG is a circular buffer and any new entries created by the IOMMU
> can be handled in a single interrupt.
> 2. In an high interrupt rate environment The ga-log handler keeps
> looping without incrementing threads_handled.
> 3. This causes note_interrupt to disable irq since it thinks that
> handler is stuck.
> 
> The solution that I had in mind (not sure if its a right way) is to
> break the while loop inside amd_iommu_handle_irq() after certain number
> of iterations.
> 
> This works because.
> 1. We enable the interrupts before processing the entries
> 2. Any new interrupts that arrive during the entry processing will set
> IRQTF_RUNTHREAD.
> 3. If we break the loop after that, the irq_thread_fn() will increment
> threads_handled.
> 4. And irq_wait_for_interrupt() will return true because it sees
> IRQTF_RUNTHREAD and irq_thread() will call the handler again.
> 
> Although I am not sure what should be a right value for number of
> iterations, the initial tests with 10000 iterations resolves this issue
> but increases the interrupt latency.


I did look into errata, spec and kernel change history.
Orignnial commit: d3263bc29706 iommu/amd: Workaround for ERBT1312 (Joerg) never
had continuous loop issue.

Later Commit 3f398bc7762a iommu/AMD: Per-thread IOMMU Interrupt Handling
(Suravee) introduced this continuous loop issue.

Of course we have bunch of follow up patches which tried to improve interrupt
handler path.

Looking into the errata, looks like its with MSI Interrupt generation mode only.
I don' think newer INTCAPX (x2apic mode) has this issue (I will double check
with HW folks).


So IOMMU is configured with x2apic interrupt mode, then I am tempted to break
this continuous loop. Other option is to wait until interrupt bit like GAInt
becomes zero. But in stressed environment this may result in overflow issue.

@Sairaj, Can you try above approach and see if that works?


-Vasant



