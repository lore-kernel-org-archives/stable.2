Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4C34EEE5
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685167; cv=fail; b=dcMWcKJ9SOj+EAUEtN1QexlBPBi70aqA+Rx59rUHLbKZskTSu1FEnYlKjrkX3gqy2ggb9NiikSBF/fYK0tqLzqAvTJ6osZ2n/ujY14tlbQbeK/FVHZVKveoDrHKKftK0uj5VGz42f8dcazdpHPHRNxOiIFmBQqy00VB7lPhDDuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685167; c=relaxed/simple;
	bh=lzjzoh75Vr8kRLbwuRQrr2gl5GVVQc38i+yGNm9iy5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p5Dv74paG9GWaSefQSbBCzZAGDdj5sOfwdZVxwxvSW7wfIzFPGxBzAmOFa78qcMtrukPpu3vKzOytkXO2sm4ZXxr9GG8FTGd83Gvx/KGVnlA1BPLrk6tnnwkdlto0OsMGWsgLssHE2x1vUNH8nqNN9tBgydBJE2ZNT+XPWcEwUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EX7s1+XG; arc=fail smtp.client-ip=52.101.52.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EX7s1+XG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x980MLUYPh1r3ZIRNBUJbJ38bdY8NrVG2uo8VdQwlpYgyWf0p0c6f7QdHvPlINazrfm9tdoOzM5LRyL3Z485EZ42ypbFQdRyG9G02CTNQtl5bu/F7EvtyxhBluKrAYG7CEjVpOsO62yJ85t1AHLwVQS3n1+3Y1OdKnFvC0Ll7ud5ZBn+JUDgURLC8AbzykQkFySVpjYUnjE8IQcowLlYYtb9YS9WdXfMnpQCYe8QvvdBzG1IVksHymZMTRqmz0WzpdhZxYSl+XTKHoMqIXbwyYx1/FRWTDwZ4VNLt3K6yzw1xsmq75trbLsaft+AyddSVDABknayPvb15+Iewg5sKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeoIYjcS88ozTwuVQ+N6aGWtq2TZqIUpirM6cdTNF1M=;
 b=pqI6MV5kVQV0jQ0rasrcFwsORtJB1d1XvolSUWc4QNknOaB0Cwk3YA3r4/mxCWqShIWlF1RAzSQnSlSk4wGIvdRsFTuGl8nzZA2bIDews39JtSnl3HSbat70G3NfsrGvyMBSDXF1tilycgFRKbC5ADJDdab+dYrEjBajkpu44mSaIoTtRNhFgJALT8FdhuXy3mJtY7+/UEdvvC3JcIc7akROeICbpat0f3juuMhLOCAgTeObAUzxwz1zGK3etxpq14z8xS+iclCfhT5TDDjQ20oqlcxapmy1PCjEU3H4X9vXeqtTY38OMPwf7d8MD+MzXNQT2Z9VM6/svWSjPeY2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeoIYjcS88ozTwuVQ+N6aGWtq2TZqIUpirM6cdTNF1M=;
 b=EX7s1+XGQjmY2CXxLocUR4hjCsqNdtRaKLbJgj5y6HP5yH3wfOllTBBvvyWK17srxV4gSh1XhushkVWjbHGTVs0kM3qtW7ZojgorB3fueiqDklK+sU9mVO/HF8+0JD+rrZOlZJRtIreYdfGDKmHky7LJY/fA1cYuO+fU11iedYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by DSVPR12MB999191.namprd12.prod.outlook.com (2603:10b6:8:496::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Fri, 5 Jun 2026
 18:46:03 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 18:46:03 +0000
Message-ID: <c967565e-e68c-4881-8cc6-064b7a3c3397@amd.com>
Date: Fri, 5 Jun 2026 13:46:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amdkfd: SVM split-tail remap regression causes
 SDMA0 permission fault on RX 7600 XT
To: Gerhard Schwanzer <geschw@pm.me>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <2bfa2f1b-567a-429b-aee2-a8dcf7efd5aa@pm.me>
 <53c2ad43-091d-46e9-b825-9aaa1d7114e8@amd.com>
 <2145b14f-00e7-4565-b1da-9e08d2c89a49@pm.me>
 <d39183d3-b961-4c74-997f-885eb7a887e4@amd.com>
 <IA1PR12MB85172F7FE9157C092EDA46A0E3112@IA1PR12MB8517.namprd12.prod.outlook.com>
 <d30aa220-802d-4575-8ab0-058698e4ffbb@pm.me>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <d30aa220-802d-4575-8ab0-058698e4ffbb@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:610:e4::7) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|DSVPR12MB999191:EE_
X-MS-Office365-Filtering-Correlation-Id: 287582eb-6884-49e3-a5b7-08dec332b18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099006|18002099003|13003099007|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	nSa1hSMI7nOsbKMlNd+u54noJUmXKJlDNgY/r/6Zs4UG/0ZLIDdh2HkAxaSzFJs24VE2lvBXpebmwCdZuDuQVtZs6zOY1XEhR0b/pmuDJ0G9Y9rSQxDcPDOq3Oa8i4QZmVh/3lwUC2qTLJiuMmZHl0Mx5jpJbeCO88cxeHsLukR7+S9rLFEhCF/I0LiK+akYEGCdMKab+7Y+KWCJ341zzncCKvAOTbGyZniTn349o57qKim8w8zIpho98kxox8KqnKW896OioyaMj0+TH1y2MXkwtLy3vUHf2epzMEmHshgjYW3zwFq5ndZ+hiSHiGvgMPD6zBxEML8GMxMNqqlrxcagi2wirf7yzVHpGBKFYMuz0GkCDK1Sw2L67TjBzeqQ6l69UXrpoEQuFIffsJHGrtfRmC8Gj9guBG4x/Z4rHREVdF6m58127SjVY9jbv7CA9HNrbFHvz20m4pnK33x2eJ9AUM+eSEHrjeNfAwWmPb8SAxDtZJKKfp/A8pcARURAj59fVEhSCGszOC1lt7n0cmuyfqXebPNMroM1vlu8nYd2ycDwWi3VJ8XahCs6q+4Xu87rorcZBhrI4sxPp4KbcUQH3yWNteSqxc35aB/a8Xe8iLe9GeZFATgsHv8g4Su/uWG8BMtmHbNmI+oE6rUq8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(13003099007)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEhnNjg5K2xlR3ptVnQyS3RQTURYN2dTUWFnVzh6SVhEV1pqRTlLSFRycUhB?=
 =?utf-8?B?ZnBsZUVQVHE2L2x2R3hsRXVnaEVaK3NpRHdxTXd5VFdTVXhJakcvTEdNR1dV?=
 =?utf-8?B?MEhaeEs4V2h5NUw2VER3R1RmUTk4bjBIbWU2RDJXbGZwKzdTUTVFWXZLMHJ0?=
 =?utf-8?B?SDE3T25rSUREOFRrQi91TTA0Z0FhajlTZ0J1RG90Y2plZlBsWUEveHVnVFFx?=
 =?utf-8?B?VW93Umo2VnhrZk96MlVrNlgrcFN5ZzNGVTBuVlhUbmVuQllUZTVyV25LZ3NL?=
 =?utf-8?B?OGNXd0ZwdTNxU3dyRTRHMlJmczZYdzF2L0FHOXlTK2ExaXpMWnVrZ25YWkhv?=
 =?utf-8?B?ME5ZK3FRWUl6WS9xZGZ4WTlDUmUzUGtDUjh1U095RGdWR3haUmFTRktaci82?=
 =?utf-8?B?OWFhZzdqYnpJczgyQlVHRDZiRWZwais3aHZJbUQ3S2NFRnBtRkVnTlpnR1VQ?=
 =?utf-8?B?M1NuZm1oSDlYZURaNnFWZVMrV2R1Z2hWeENEV2ttOGVFN3NzT0xzb05ySHVy?=
 =?utf-8?B?UTRvNmFJN3lQOEhnMzlVTjZPY1VUa0EvbGl5V2VBbHhENFF1K0dGRnlydFVO?=
 =?utf-8?B?aStCemludkVDMXlZc0VmWHNWU2JJZVQwbSt5NHNRYjFoVU1KNG5GcGM3U3h4?=
 =?utf-8?B?MmNTQ3ozb0dyZW1nZ254cXlhbUZwWEU1d1gycEM2bGZIaDJ0b0lQc09EMlFR?=
 =?utf-8?B?S1hjMWVKRWVsdU5QbGhPQWtDbXZvRzN3SVQrMVlTZ0pyd2w2SUhqcysyUndE?=
 =?utf-8?B?ZXJFckQvdldaYlNJSTdTUzl3d01xQ0pUQStIUVBXN2JKZUJzUUFoMWZaSHhM?=
 =?utf-8?B?Ry8vQVNPS09EbnVtNU5nUElzbFNNTWExVjVJY3RYL2NaNGUzcVJ2cGZFalEz?=
 =?utf-8?B?M1hjQW5aNk1aVjc0RXV5SUsyY2FPMWJLeTZhaWpFbnBCbldQd0RmK2U5ZDRI?=
 =?utf-8?B?V2t1OW9iNForWWErajh3NzVjc3p3QXRWU2MyT0tiOEthTmR1Q0ZWbEdwYlQ0?=
 =?utf-8?B?bjRFdHJ1N3hiNjBTM0h0TTFsUS9rZkhoR0RZQjR1eXlDS29UMjR1S1orMURu?=
 =?utf-8?B?RmVEZjZLTE5panIwWEpWcVg0RThHMkVXNmRpTkhVZmszK2swU1ZsYnFWck54?=
 =?utf-8?B?MTg5NWRvU2Ewa0JSTUxRNUVJdGxSN1pHdDY2cThIZ3F3Z1pQOE5YdG5mMGl3?=
 =?utf-8?B?blpwdzhSUGthUHdpMHF0Y0w2WjBoRjk2dW5HNDNLbWk4eUd6MDQ4ZTJKR0Uz?=
 =?utf-8?B?dFM5aDlCMEJMOGdra2N1dldUNDFvMFVSOVRBbnkvLytlNFBRaFpkREpvRkMy?=
 =?utf-8?B?L1g2K3cwRVpzMmJGRlVFSXhmN2lYVXRGaTg0RHZ1OVBYYjhPcnp6SVM1d0Fx?=
 =?utf-8?B?MDJwd3o3dU4vNHJLMHFweFROUTlGZWhvVkF6MHRXSEpHTThRMTdKYlM3aTRa?=
 =?utf-8?B?TktrRTkyKy9PY3BPSXZVU2Z1SU5ka3hkdkkyeVhMZjl3VmpDcklld0lkSzg3?=
 =?utf-8?B?aHlkS1NCNC90SENyYS94VlFRMTRmN2JHODQ0RW9wUmw3R25YWXlGZVBnNzd6?=
 =?utf-8?B?RzN6YXFSdTN5Wnh1TXNiRzAwdU9pbms5emtqZEdsd09sSzNmU09YOXNSWEox?=
 =?utf-8?B?ajd6aCs0VmtIclBIZzlSYTBXOG5uTk9qTFk2UHQzNlhhQXZlWmozUDlUd25o?=
 =?utf-8?B?K3ZTaWFSSHJ6YU1wYmw1ZUdCd0R0MkpLTTFBUlpnbkZiR3QyMVpoc3ZURkNv?=
 =?utf-8?B?RjEwOFZDLzljMzh6OXpUck9SM1dQcGJhU2ZkeitLU1E1YmVVN0JVTHM5c1hr?=
 =?utf-8?B?b0krenpLRXZXdTJ1TmUzWlhRWE1yVXY4azlRU0RQOUFIOE1LODVoUVN1aFNt?=
 =?utf-8?B?YmVma3Nta3ZRVFFlaGE4bm5keUI3Z0VVZXRyeVhhQisyZU56TXpQZVRLcUF5?=
 =?utf-8?B?d0pqbUJyRHVncWFkVVBacy9aSHFkVEZsS0FRa3l6U1JramdEVFNNckdoYTda?=
 =?utf-8?B?cVl2OWQzdW40YUxXbnlLZkd2V1NnZGYrUjFjUGRKNTBGbnQ2aWVva0x6Nm5t?=
 =?utf-8?B?UEt2WFgyendLM0JJQ2MrM2FTQUdYZUc4M2x2SWpNQWdmWktHVFl4bi9KcjVx?=
 =?utf-8?B?Vmp2NDh2WlRoWU13enkzRXplVmt2aWgrQ3NHWlUwTjA0WTRZNW9HdDZJanpG?=
 =?utf-8?B?M0VXOUZTaHRnbk1hVkp6QkdIblJjSytpckJ3d0ZmeGgvcjBKb1pJcm96dlIv?=
 =?utf-8?B?TjdsY2dtbUhqSWZ5RzNBallRQ2FYMzdUTXp1dTZOdHlZVUpQcUVRMGtrUG1W?=
 =?utf-8?Q?urdmrR4CBL5I1a32fz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287582eb-6884-49e3-a5b7-08dec332b18f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:46:02.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6DC8W9tnrw1o4D5wlvJwycqKh6Vp6uaoei9eBeFWfz0Fb4+pZs/XJCnbGqb54uK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999191

Thank you for the testing/confirming.

Xiaogang

On 6/5/2026 1:41 PM, Gerhard Schwanzer wrote:
> Hi Xiaogang, Thanks. I tested your attached patch on my RX 7600 XT
> system. Test setup:
> -
> kernel 7.0.11 with 448ee453/bf2084a7 active
> -
> local revert not applied
> -
> your attached candidate fix applied
> -
> same self-contained v2 reproducer source as before, unchanged sha256:
> 33347b5a1915f7452417f776c85527e55f825078c146163470bfe3eacabe3b27
> Command: ./kfd_svm_split_hsa_copy --upstream-ab Result:
> -
> 10/10 runs completed successfully
> -
> all HSA/SDMA D2H copies completed
> -
> no ROCr memory access fault
> -
> no new GCVM_L2_PROTECTION_FAULT_STATUS
> -
> no SDMA0 permission fault
> -
> no GPU page fault in the kernel log So your patch fixes the reproducer
> on my system with the original reproducer unchanged. Please feel free to
> add: Tested-by: Gerhard Schwanzer
> geschw@pm.me
> Thanks, Gerhard
>
>
> On 05/06/26 at 19:59, Chen, Xiaogang wrote:
>> AMD General
>>
>>
>> Hi Gerhard:
>>
>> I think the cause is checking the last byte address of svm range for
>> 2MB alignment when decide possible huge page mapping. Your test case
>> has vm range that ends just one byte before alignment.
>>
>> I tested your app with the attachment, no page fault during sdma
>> operation. Please verify it.
>>
>> Thanks
>>
>> Xiaogang
>>
>> *From:*Chen, Xiaogang
>> *Sent:* Wednesday, June 3, 2026 5:51 PM
>> *To:* Gerhard Schwanzer <geschw@pm.me>; regressions@lists.linux.dev
>> *Cc:* amd-gfx@lists.freedesktop.org; stable@vger.kernel.org; Deucher,
>> Alexander <Alexander.Deucher@amd.com>; Yang, Philip <Philip.Yang@amd.com>
>> *Subject:* Re: [REGRESSION] drm/amdkfd: SVM split-tail remap
>> regression causes SDMA0 permission fault on RX 7600 XT
>>
>> Hi Gerhard:
>>
>> Thanks. I can build the app now. And I saw the regression. I am
>> triaging it.
>>
>> The purpose of this patch is to remap split svm ranges(head/tail) that
>> were mapped with huge page mapping(pmd), but cannot be mapped in huge
>> page mapping after split due to new svm ranges are not 2MB aligned. It
>> seems the remap decision misses case that both head and tail ranges
>> are from original range with huge page mappings were used. Will check....
>>
>> Regards
>>
>> Xiaogang
>>
>> On 6/3/2026 12:54 AM, Gerhard Schwanzer wrote:
>>
>>      [Some people who received this message don't often get email fromgeschw@pm.me. Learn why this is important athttps://aka.ms/LearnAboutSenderIdentification ]
>>
>>      Hi Xiaogang,
>>
>>      Sorry, you are right. The source I uploaded was not self-contained, it still
>>
>>      referenced trace_history_replay.inc from an older local replay mode.
>>
>>      I uploaded a self-contained v2 source to the GitLab report:
>>
>>      https://gitlab.freedesktop.org/-/project/4522/uploads/7395b8985ecd7c54183a7615d479c02c/kfd_svm_split_hsa_copy-v2.c
>>
>>      The --upstream-ab path does not use that replay table, but the missing
>>
>>      include
>>
>>      obviously broke fresh builds. The v2 source embeds the table and otherwise
>>
>>      preserves the same source.
>>
>>      I re-tested this v2 source before uploading:
>>
>>          - clean build from only kfd_svm_split_hsa_copy-v2.c: OK
>>
>>          - ./kfd_svm_split_hsa_copy --help: OK
>>
>>          - good/workaround kernel: --upstream-ab completed 10/10 runs, no new
>>
>>            GCVM/SDMA0/protection-fault messages in the test window
>>
>>          - broken kernel: --upstream-ab reproduced the SDMA0 permission fault;
>>
>>            the first kernel fault address matched the planned split-tail page
>>
>>      Validation summaries:
>>
>>      https://gitlab.freedesktop.org/-/project/4522/uploads/e6d0f31c0fda0df2c999439411f29dca/good-kernel-validation-summary.md
>>
>>      https://gitlab.freedesktop.org/-/project/4522/uploads/bdf8a3ac6786ddb88dd426b59edb32a9/broken-kernel-validation-summary.md
>>
>>      The intended triage command remains:
>>
>>          ./kfd_svm_split_hsa_copy --upstream-ab
>>
>>      Generic build shape is:
>>
>>          cc -O2 -g -Wall -Wextra -pthread \
>>
>>            -I/path/to/rocm/include -L/path/to/rocm/lib \
>>
>>            -o kfd_svm_split_hsa_copy kfd_svm_split_hsa_copy-v2.c \
>>
>>            -lhsa-runtime64
>>
>>      If you still prefer a binary, please tell me the target runtime/distro. A
>>
>>      binary built on my NixOS system is Nix-store linked and likely not
>>
>>      portable to
>>
>>      your test system.
>>
>>      One more thing that would help me test any replacement fix: do you know what
>>
>>      specific failure or workload 448ee453 was intended to fix? I would like to
>>
>>      avoid validating only the revert side while accidentally losing the original
>>
>>      fix.
>>
>>      Thanks for catching this, and thanks for taking a look.
>>
>>      Regards,
>>
>>      Gerhard
>>
>>      On 06/03/2026 Chen, Xiaogang wrote:
>>
>>          I cannot compile kfd_svm_split_hsa_copy.c, there is no
>>
>>          "trace_history_replay.inc".
>>
>>          Or can you  send the test binary?  That should be enough to triage the
>>
>>          issue since it is a regression as you mentioned.
>>
>>          Regards
>>
>>          Xiaogang
>>
>>          On 6/2/2026 5:04 AM, Gerhard Schwanzer wrote:
>>
>>              Hi,
>>
>>              I would like to make sure this AMDKFD SVM regression is tracked by the
>>
>>              Linux regression process.
>>
>>              GitLab report:
>>
>>                  https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>>
>>              The regression was originally reported on 2026-01-27. It was bisected
>>
>>              to the
>>
>>              same functional change that Alex Deucher's revert patch later targeted:
>>
>>                  448ee45353ef9fb1a34f5f26eb3f48923c6f0898
>>
>>                  drm/amdkfd: Use huge page size to check split svm range alignment
>>
>>              The affected kernel line I tested identifies the same change as:
>>
>>                  bf2084a7b1d75d093b6a79df4c10142d49fbaa0e
>>
>>              Alex's revert patch:
>>
>>              https://lists.freedesktop.org/archives/amd-gfx/2026-February/138824.html
>>
>>              A small C/HSA reproducer is now available in the GitLab report. It
>>
>>              does not
>>
>>              require PyTorch, ComfyUI, Docker, model files, or the original
>>
>>              workload. It
>>
>>              uses ROCr/HSA, an anonymous THP-advised host mapping, explicit KFD SVM
>>
>>              SET_ATTR ioctls, and an HSA SDMA D2H copy.
>>
>>              Single reproducer command, same binary on both kernels:
>>
>>                  ./kfd_svm_split_hsa_copy --upstream-ab
>>
>>              Same-machine A/B result on an RX 7600 XT:
>>
>>                  448ee453/bf2084a7 active:
>>
>>                    1/1 run faults with SDMA0 permission fault
>>
>>                    GCVM_L2_PROTECTION_FAULT_STATUS=0x00841A51
>>
>>                  448ee453/bf2084a7 locally reverted:
>>
>>                    10/10 runs complete
>>
>>                    no ROCr memory access fault
>>
>>                    no new GCVM/SDMA0 permission fault in dmesg
>>
>>              The bad fault page is inside the split tail and inside the SDMA copy
>>
>>              range:
>>
>>                  critical tail: [0x722429d61..0x722429dff]
>>
>>                  copy pages:    [0x722429b30..0x722429d70]
>>
>>                  fault page:    0x722429d65
>>
>>              A full ftrace/PTE run with the same C reproducer/SVM sequence also shows:
>>
>>                  split_tail ... current_remap=0 old_remap=1 missed=1
>>
>>                  MISSED_REMAP_CANDIDATE split=tail
>>
>>                  no amdgpu_vm_update_ptes covering the fault page after the marker
>>
>>              before
>>
>>                  the fault-side GET_ATTR
>>
>>              The suspected code issue is that the split-tail/head remap predicate
>>
>>              introduced
>>
>>              by 448ee453/bf2084a7 can miss tails inside the final 512-page block.
>>
>>              Since
>>
>>              prange->last is inclusive, ALIGN_DOWN(prange->last, 512) is the start
>>
>>              of the
>>
>>              final block, not an exclusive upper bound.
>>
>>              I also sent a short follow-up to amd-gfx with the reproducer/A-B
>>
>>              summary and
>>
>>              asked what original failure or workload 448ee453/bf2084a7 was intended
>>
>>              to fix:
>>
>>              https://lists.freedesktop.org/archives/amd-gfx/2026-June/145800.html
>>
>>              I can resend the reproducer source and summaries directly on-list if
>>
>>              preferred.
>>
>>              #regzbot introduced: 448ee45353ef9fb1a34f5f26eb3f48923c6f0898
>>
>>              #regzbot monitor:
>>
>>              https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>>
>>              Thanks,
>>
>>              Gerhard Schwanzer
>>
