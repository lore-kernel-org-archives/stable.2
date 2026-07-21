Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ECF379C55;
	Tue, 21 Jul 2026 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599749; cv=fail; b=mAczVgZ1CXkIofYvJqKfeVl0iQj4DhyvrPTifhohBR7SkLFi0w1NrQNL0yv0DO99fxMuEGfD9CfnoJvQ0jX4ikxCO+/aLU9XjrUrbfe7kMfHezR4kbrkAvMk5wqKnIlB0rHIbJO6apkNhpZVbBsowucm3G7x3YLT+NxILzCWsrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599749; c=relaxed/simple;
	bh=L2ra+crn7dCQ9Ojdmk+E+3jJmBGEGLnhun7qmUVYH6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WDDIzZ6wPq5gGRSM3YaVYIXHHhypBeJbfvBlZqiYlgO6DkJa+d+EFjAURnEtoutZeBkZjW4siXRMZaHuI+dp11roEIsdMoNclSqO2X0LFr3KryT9/zJ30AkHGjutOWsz/ZiHA4TE/YCIM+r+vWi9Md9OHGeqhrTut2hnILyk41c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YwNxgp8n; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YwNxgp8n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3gmwXBnZPMEwk3GV+2zMF80b718rAkLSFkOJekZqoOjlbakRuj20lynlYBF8Y8pHGs5PY/yhraGHrbeOOP7DA2ygmHh0uaBPvbxIwBEBvLzL2B27ZVXQ3FKicDZA26lYeADmJbP4nMNjugYfNzutgOcxhbAn59B+NF/LEUkDW+SfZhO0sxwi4FJa9ysYu80c+8y65E3JoAZwdUlxlTkpoaUIY3CfdvsPBnH/EA18socNZvInEakABYj0dmybhIxt2flmFivbTlla546TaRdvafzGsiqCWDEQRKehem9X/O4RkwQOuP4vmEUNbWlVpZCqdIH0DIdY3Tz+lwSTbmh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2ra+crn7dCQ9Ojdmk+E+3jJmBGEGLnhun7qmUVYH6U=;
 b=tP2JgdpP4MpqOXrO7AkOJjQK+4bSOJ+xCLaJg3p6EfgK0ZHSJ5dzrtSen2fL+/2gx96XnzHJV5o1nCR/XInXh/mqF0pg1LwatsAiLYWYiTBLYVhoq9CwuA9XYLERr6w/hWjnSo2/nEqjeBkglUJSqkO/sgKCTfZ/MQ4SLrk8yNF2j2Z+OcpIM92g59Lp83jOgcoAZd5ojfQZPlJmyctDEqU1WUFuQYMZu6iJvo9QSJuv1CmcCU1tJb7fpLVPqr4RKPydphdwYZtCcGukKSJKrnWD4Hq8vJFkY8VFQNSQ2s/qHCtxVgQh0b7u6ph2VMy5plnqV9uW1cmeOt5gIiTr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2ra+crn7dCQ9Ojdmk+E+3jJmBGEGLnhun7qmUVYH6U=;
 b=YwNxgp8npLzSUsNaGSIwqTZqRjfKxwoc8AeXFzfTN+BzpBD4p/+r8k0BqTJd1bWR3zfCzxd9EZh+4ye41arYEZNU5rr+wYOFvvTv7B6LE92AlVN7dB5Y7DsQJgRGPGK4bqCRSOKn0ZKDWkqFZO6DcW1PDTvUFWYPgZBI42nzL+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) by
 MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 02:09:02 +0000
Received: from DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c]) by DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 02:09:02 +0000
Message-ID: <001fa28e-0355-4f06-9110-d8ef44d963e3@amd.com>
Date: Tue, 21 Jul 2026 04:08:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: SEV: drop FOLL_WRITE for encrypted region
 registration
To: Sean Christopherson <seanjc@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, pbonzini@redhat.com,
 tglx@kernel.org, bp@alien8.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, thomas.lendacky@amd.com,
 hpa@zytor.com, yangge1116@126.com, ljs@kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260715063626.65899-1-pankaj.gupta@amd.com>
 <abecb83f-aea8-403e-bc10-4d8d878c0d8c@kernel.org>
 <059088ac-81e7-48a9-b4e1-05dad48975f6@amd.com> <al579lcf0NnxhD3T@google.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <al579lcf0NnxhD3T@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To DS0PR12MB7771.namprd12.prod.outlook.com
 (2603:10b6:8:138::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7771:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b54332-bd16-4941-698a-08dee6cd08aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	J2iV9cqVBvMeq+mrV//pDUKR1ABfJ+iJC85tF1cZyvuv2Jam12Cd//A5FNPVIn8BElIaXD3ASQTKzHHRH1CvtOijSHW1FE3i8GpRaK6OUoZfj5TGyY396AQyb63oOoq78psXjZXXFgQzeY3n8mvorZqaaMiPnBSw72gaoy7S3JyVvwLarhwbjVCgaru/EMMQavKyZMVUHMaWzd1KW218nKQna+1MzSXbO0pvpndZ9yIwTiFy0S84Mvto+uIklz2w2eRMIJtxXQ+YO8NJmzZxr8QsnbxKaBrJzZuTYyyojjNn5YL0ictozZjSIA9wvfL0QUOKiCdw8uDuPx+EtKGEEtbLihcXn+8NThktCLEAeoqiW6joRAyln3QEmt8dFQQ1UGtDVVBdgQNJnEePXaVLe34lvmNhdoY2R+nbBN/Fp3amJosI07husZFqTguUyjyt6ZkZ59Jz2h+DW1bb+RRMmXXVYDvK52Jw6HRxzgv9gjXURvuSBjy5tI0J/UQ5O5L/YtWWoSmYIrVO4HD+0aKdged+caJgp+boc9/Npvic0rQbRKyBWoMBdMV+WkOEgOVn91SDgXPjsQv1gW1h0kCSd2SgdNFee1/KcpteGC47QLKAZHUPPjp4To3JalFa7B0nApzDxp9JQzsVTomssdqObiF0wyA+eHhtIySYH85r6o0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7771.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm5JQTk5eTFicFFDR09SakFtWVJSV29PNm10enVFd0RhUmJPY0JFYjR6UDNt?=
 =?utf-8?B?Q0U3QUp1NmhWN0J1cXlDQnpYMlpGUzlsOEFhSitEaFI0OVF4elBadWhYRVFm?=
 =?utf-8?B?ZVM5SmMrZzlYS3FqQUJiTlp4ZmxNWmxnM3JSRzNXclVoOURnZDN3a05CTDFH?=
 =?utf-8?B?RkR4UTdRcFZQdkZtOVd4aThtaGdSMUlqUkZuZmxQTG9jYzdZOFg3Nm9Qb3ky?=
 =?utf-8?B?T2ZKTlNQWHZxSXJ2YStDOUpuM0tCWkpaVml4WjJuZndWUXg5T2JCUTFiZnNO?=
 =?utf-8?B?TTM1WDF3Mkx1RVFKMzNtaWRZSlFsSkNLb1MzYWx6aVVkSDVkeXdwR0w0czQr?=
 =?utf-8?B?azBTQW9WTXJaeityZkg2K0lzdW9QMU9CT29TTm85ZTNJdHRTNUdlK2hUTW10?=
 =?utf-8?B?a0Z0SkJXcGFOeVRoVWJXRklQbVZudjE4cUkySHc5WmpES2xzaHlqb0pObEtz?=
 =?utf-8?B?bVR3b1BwbndUaDA4UVJGaWxiMTduYisvanhFcVpmM0tIM0xCbnlKSHJOV2t5?=
 =?utf-8?B?dWl5TkxCU2FlYktqZStZL3hUK3RBQ0I5S2xFc3BVL2M3Y2hsdmtkWWhHUlRp?=
 =?utf-8?B?UXhnVUpTMGt1ZUpvcUVXb0puUHdnT01SSFc0NmtoY1hTV3ZlTGtOdTY1RFRI?=
 =?utf-8?B?SEkxMzJBL3JJaW5GdWFtTUN0djMzUmlNc0dEMGZsc3FkMnZyMlAzZ2lTa1NM?=
 =?utf-8?B?eWlGMzhBa01ZWldMaE1nTFAra2dRNDIweTVYbW1lVW9objBTUGs0MW1Bai9S?=
 =?utf-8?B?bjJDYU1IU2xMamJTdXh0SWhjaktqRmZVTG1PZUZZS0VCczRlSWppWXg0K1NS?=
 =?utf-8?B?RnYvVzRiakxNZ2phRTBrL1VCRndBcXdNeG5Rdys2ZkdoOTNoOGdEbTc4M0di?=
 =?utf-8?B?dldmQ244bmIvSC9KRkJiSGlYaEY5VjRwZHJQVHZvandCTkw5aHZDRTJtSUox?=
 =?utf-8?B?U1U3TmdzbGZETW4ydmdocTd3WWpBaXFaQzlhM3BicUYwTFdhclVqMkJENVFI?=
 =?utf-8?B?amVrcWQrMzd3ZGJOLzl6UnFWdW1ZamRuN3I1T2IzZHlZU25lWHRZRTBkOFJ5?=
 =?utf-8?B?ZzdDOXRHdXFoMldJcTJDMWxlcytRcTlSTExmUEF0MFpmK3NYVm0zT29URUFP?=
 =?utf-8?B?NUYyL1hXRkY5Z2VRWkVZZzFScFU1MVZWK1NtRy9KcjR4V2c4WTNkZkNBMTRu?=
 =?utf-8?B?TE9MSGRad2wxM1AzR0JFV1VSRFgwdGY5QjYvVHo2RzlSeVQ5elRuaWU3QUt0?=
 =?utf-8?B?VUxBSzhqWDU5UjJCV3dGajllRm5BLzVCZDJTbGZORDFDSzZhb0llU0dhZnVI?=
 =?utf-8?B?VzFyeXRCRDAyMFFYMWtObWVQeXBXN21uRG9OZlJYZVBrMlBldTJzYnU5K1Vk?=
 =?utf-8?B?TXNMcDdqWGZsYXdMVC81a0l3VGtLT1BKWXcrTlNVV3JpNG4rUDB0Zm50dU5x?=
 =?utf-8?B?L0Jkck1teDlvSzNJQjNBU3BFb3A3K2xpaVZQZXo1eS9aNlllTVEray9ZbGpF?=
 =?utf-8?B?MFMzYkczMk84NzdnY3dNSkxROVJ1YVdqUWxsT0NQazcwcysxV2RzWnVyOEVp?=
 =?utf-8?B?cnZlb1Z3S2FaZjZiMVBxc2lndkNGVHNUTjlqYnBidVJVb3VMUmh5eTlVak42?=
 =?utf-8?B?UytOTXUwSUdNcE92S0Y2WUtSOGd5S1NVVmFKSTBFN3RMcDJINWc0elI5Tll5?=
 =?utf-8?B?dktqaHNjYVlMODB4TjdhNW1pZVR6T25SblJuanNEcmxUU0NUYjQyVGdTcDRF?=
 =?utf-8?B?RzlobnByRHMxTjFoL2ROTTBYa1B6REtxb3RYQXJVeUxmN2F0bmE1QnpOL3h4?=
 =?utf-8?B?d2pOSDZHbHNHdmdlSlI4cW8xVnI4SUFuYUoxd1VSL0pNWHBOd0NmL1YrV2l0?=
 =?utf-8?B?V2QyQ2l2cFdSRURSWUJ3VGtOUUd3dmp5dGV1emxFaU12MlM4VzNiOWxyYm1S?=
 =?utf-8?B?UWlmeGdVREx4UnAxbGx0bDBlSDg5QXB1YzJmZjlSOFNmQ0wxcmc1aWpqOFBy?=
 =?utf-8?B?Zm41ODBQaVlPNFlmakJ0VklleGV0UTdpQ0FheldKdGlycVZXakhsaVllRVJY?=
 =?utf-8?B?emt4aEVaTzJEODZra2xaZ1d5UndnaFBFL1Z6TlZUbGxDWk9DWHdPOVhNSUFi?=
 =?utf-8?B?U3p1RGN6Umt2Q2hkWWJQNGlWeVp3NWZxa0xYa3JTL0pwUERKc3psbUFaVTdE?=
 =?utf-8?B?QU1mUjVQcytVRmZRSTcwYWZ2VG5sc2VJaTVneUx3a1JQUk5nRkVsbTBDUTd2?=
 =?utf-8?B?N2hWcnhaU0dva0dmZTFpV2QxNjg1dFpka1R0OHVNQ0NyK2MzQnB4NWxOcWVC?=
 =?utf-8?Q?qgetQG0Tx2m9kbYI6t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b54332-bd16-4941-698a-08dee6cd08aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 02:09:02.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxkC8gSPylOPSI5XEBBM7rcy6edMzh254yqoSv8WUuYy3+8lvZWtm2OoIBE2zZzv88e+mUUZKMn/+0EIGuZrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141

>>>> Commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering
>>>> encrypted memory regions") added FOLL_LONGTERM to
>>>> sev_mem_enc_register_region() so anonymous guest RAM is migrated out of
>>>> MIGRATE_CMA/ZONE_MOVABLE before a long term pin. It also kept
>>>> FOLL_WRITE on the pin.
>>>>
>>>> Combining FOLL_WRITE with FOLL_LONGTERM breaks registration of file-backed
>>>> guest memory, such as virtio-pmem host memory-backend-file mappings
>>>> (MAP_SHARED). GUP rejects long-term writable pins on dirty tracked file
>>>> mappings since:
>>>>
>>>> commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
>>>> commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").
>>>>
>>>> Region registration only requires long-term pin to prevent page migration and
>>>> does not write through this GUP pin.
>>>>
>>>> Drop FOLL_WRITE and pin guest memory only with FOLL_LONGTERM.
>>> Worth mentioning here something like
>>>
>>> "In the past, FOLL_WRITE was required to trigger CoW unsharing, making sure that
>>> we don't end up replacing the page in the page tables during a later write fault
>>> after already having pinned a (shared) page in MAP_PRIVATE mappings.
>>> FOLL_LONGTERM does that nowadays (see gup_must_unshare()) even without FOLL_WRITE.
> Heh, this was going to be my exact question about why it was safe to drop FOLL_WRITE :-)
>
>>> Given that SEV only pins RAM for XYZ and doesn't actually write to the pinned
>>> pages, we can just drop the FOLL_WRITE"
>>>
>>> Fill out XYZ :)
>> Sure :)
>>
>> I will update the commit message in v3.
> No need for a v3, I'll add a blurb when applying.

Thanks, Sean!

Best regards,

Pankaj

