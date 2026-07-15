Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270992F3621;
	Wed, 15 Jul 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124589; cv=fail; b=b4BBXm4TvYQl2QOXqeatqvgthVMqA5gAkp6Xea4Z6bg3yVM0piKSGnrg+5wfz/8omUKJ/42dMqWVcQ5/rf0A1wft1CYLyT4XGhY+ao/Jit+tsefZn+xnVvHUzxCk50eC6Owr7LFsQ2q5sMSIkRKddSrK23swx01QnUMrfGD2Y9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124589; c=relaxed/simple;
	bh=wSw2mwHDD0+oLUoAhd7sIlq149f0ZvlLkKsJ/mtz8qU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SX2tI2bF+XSC2nLifoJyOscuCpUoTss4NdIK9xK5vy6pfRQr6DbI98IRzA6x47dTKB/rC6CjBAPlC7rkYutmI+it6F52Gzkq9gy3QUJKYbDczW5qknDb4ulwBvLj7Mn/VSOZNCr/Zho072bboxlGXedBHVlcF0htoafrstKbuCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UY6kRCW5; arc=fail smtp.client-ip=40.93.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UY6kRCW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qqa5Qps2gIfLBr0c8IQyOZcwQ6gKyfgmHh0GuSqgBsdRafrFDa7zj1Zi2Xj9bNBqgJRez/MoCHMsNB7wPAg7GF9WvMIidzJsOSes2J0r1OZkgW/KB8c9DVYWYXW+yDcNeItjsawKCeaKmk9tinDzxSoN9RMa4KEcerXHXmBAsM/wSMHxurZAM5d0Oy8ATe4uWFqRVUzT1TS4sl5LOWQPhjnlzCqWZEKsaGk6ovRkLhbieYtfeZZ0eZfmiuPX86LKqr26OOwMLYArMUt+SdW2740PN21OaoKPP3/7FPyKbk/+GwNGey40uREP9pDym19zLBORPhx/zXNWZ1amjmDHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSw2mwHDD0+oLUoAhd7sIlq149f0ZvlLkKsJ/mtz8qU=;
 b=wicVjMBhszyRred+d4sX6XwoNVCGSupdE0L9wBrNmb6OTSX517804G5MKcPsFTkL9FtYAFwWGQLi4R7t6FzcCbYxhbqDHy2ucCjpB19TJEPLwMzKa5YxnrwIy7uh2D8RdmFOVTi3qBkBvv6mwDvHSnBkkpYlgtYUtjt4eWki9JzwWLnWsHx24+pRgMeM/vd6jCY1TWp/4YL4HKzpKnVb6k40KqKkbeSsYGJKeiPsR+MwHhi8OTJVEDfnblmrhXvqCOaI/idykRQeAe169emaSzEaAPbjjdcQJv4oJ47EIX0H5PYX+cPkSVJ385hq63an3I0O9QIpStwyoXi/d5jF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSw2mwHDD0+oLUoAhd7sIlq149f0ZvlLkKsJ/mtz8qU=;
 b=UY6kRCW5OLnNZGd6v5G3URHUnWGaqSALN0lwGq/2t8h5pPDKs/mbx7fxtxJ4BXM4tjXGKU7/N7cMkpdEQvgzIxsw6HJOanxGjbPscDN1Q5cdS1GKgBF+7gpz5e8edm69vEiVi6mrtNJ5axM/GG9FghGa0huc25ZIoGKQCaGx+Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) by
 DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Wed, 15 Jul 2026 14:09:42 +0000
Received: from DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c]) by DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c%5]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 14:09:40 +0000
Message-ID: <059088ac-81e7-48a9-b4e1-05dad48975f6@amd.com>
Date: Wed, 15 Jul 2026 16:09:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: SEV: drop FOLL_WRITE for encrypted region
 registration
To: "David Hildenbrand (Arm)" <david@kernel.org>, seanjc@google.com,
 pbonzini@redhat.com, tglx@kernel.org, bp@alien8.de, mingo@redhat.com,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
 yangge1116@126.com, ljs@kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260715063626.65899-1-pankaj.gupta@amd.com>
 <abecb83f-aea8-403e-bc10-4d8d878c0d8c@kernel.org>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <abecb83f-aea8-403e-bc10-4d8d878c0d8c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::12) To DS0PR12MB7771.namprd12.prod.outlook.com
 (2603:10b6:8:138::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7771:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: bb255117-5199-4f18-d58d-08dee27ab5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EKgZFYHyyeOGeyRfuKkLcfj7P5rxALC0lTfjP2a0Qh35INjmUVZKTfD1Fh8EcLUSAL+pyjB9MJv62g84gBBd+VluHmfONTlfApe63F3uV79i+Va6sXv9ZyrrESFpv75Mkl0gCqd846L2oWFibjOy0X+jU7AHl6U5FHe79l5aEol35NASg4zgWPdfL/rAPhEeSTAK1+dJXyUyxlOVu8hKTCYK1mqC6D7fJZ/boJrMlrvd3hdSBVQUNz1/vo3Dote5jLQBG5XdWcJvFXBG4oOs5s/9TErOFg4j9dTfvpttMD0l7+MXYhL0v7qhY0rynTCCBUsQ0yyB8dNQWlulJGT0LQCF3Fr/RjQgqi0Htw/yZf7LrHiabjTkLgs04pSoROI9LZjULUy8YEpOneorRDLisUg3KoiAGEw/Hj/c79B/MqnitjqLwK89b6gll9P5mDP/jMpVlF6kaS5lvOOhG8YemNcJofPbVxYnX91YK5QKWkMuh6/ukoLbl99a2wj6xIkDI42+gIgfeH03bhORuDBIN2wx48j7xONx4OKKOj1y0oAO1G6YK/usxWedegEgsDkxZ3PkzIaa+Ooq9FGxWDEAx35I5Lsy0/S5ynV+f+RCQwhURVkuaRXI6NkoMsmTq3MylYc62xut9KDtCdxdrqNvoljIBORpGfl6juwXFPSUTDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7771.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEY4Ukl0c2hsUnAxOWtYODQ2RnZmUTVKVWV4UG5EU201QVhrTUxZY2YzUWYr?=
 =?utf-8?B?NHQzaHltNlhyYklHdm5mRTNDYVJBdmwwTUdBOURXVzBKRVFnZUxXVkppTUlO?=
 =?utf-8?B?T3RIYjJZZ2hVN3ZKQUFwc2Z3bFhMRUl4dHdOZ0xtd3FhVW0wYkhlZlhVNUpj?=
 =?utf-8?B?Z1BGQmRoTDNDMjVnZmQ5dDJCSGJUVGtOcjUxenhLV3FIRk9KWmdxcXh4NWJi?=
 =?utf-8?B?QXEwNE5lamFBUzJUZFd1akhzdjVZeXlVK2d1QWgrbW5CT0gwdVJpQ0RTVXpD?=
 =?utf-8?B?ZTExK0w1SFdHbVY2bEZ5Q2tERnpqZVcxR1U1UzNCQlgxK0dCZEptUFVIV0l6?=
 =?utf-8?B?NnhMcndaczBYVTdiNVJZRHpvVmxUTC93WURGN0hnRDZvbXU4cWQxWTE3Z1Zq?=
 =?utf-8?B?QkhWVFlvblpkTmVzWHo1aFZHbngzMmhLUFJBN0ZLNythSzNXU3B6clhVMThz?=
 =?utf-8?B?Y0FFc0RDZEVRQXROQU9zM2MxNkRBbUxpRE5pSkNrZDhva1Vza2NEamhhUVNm?=
 =?utf-8?B?alVzZzI3S2IrQTRmR2FLUlkxbExESFhQeUU5WVpBRHhuaTBSbmpHc1JEbDNR?=
 =?utf-8?B?NHg0bExzS2JtZFhYWEZseUFRYTVkbmREQm5QNVJjTnNLZkVNK0FYRkRmWnNY?=
 =?utf-8?B?d29SNWYvNytYYW1pek5FQTZWelNoZGRMSlZUZ0hwaW5VTlNtb285aXMrKzhs?=
 =?utf-8?B?V3ZQNGhOTkFMdXpQY3ZhS0c3dSs4NEZQdkZJVk5Eb3pST3ZSWnFpejIxa0Iz?=
 =?utf-8?B?dk5KSnBSWEhjbTBXVjFPUE1ETDNsV3paK1UrdlI5TDRaa1RGY0w5MXdETGhP?=
 =?utf-8?B?ejhKeGQ3QjhKTHdaMjNsMld1NXZQVkNzMld4TkpQenpEaGtSRVVNUi9RTzJl?=
 =?utf-8?B?ZzhnNWhqRTczR3FzVkwzYktQbmpHa0NjK08vTk5nTXcvUTNZclZNeS9EcUEv?=
 =?utf-8?B?M1ZpY1lhSU41SVVjZDI2U29iTkxQNVp3SXBjcDNkL0xHQWdodVNnUDU2SnA0?=
 =?utf-8?B?WkFnT1RNeEFzYlgvVjFwYzZBaGs1M2VxWVJJajRDQ0Nja29VcDBwWkJCa3BH?=
 =?utf-8?B?UzA4ckhPVGh3T0JTdWZ0VnVPV3RwVlp0VzQwWEtBNjVxNldteUhpSEovQms1?=
 =?utf-8?B?bjBOY1Fxb29VL0VlTFhrUmlKdjBWV0lSa1pMbENnSHp1c1ZzdGZDQWcydFRM?=
 =?utf-8?B?ZkxTNjFyNEYxOUtWaTQzaXlVczlya2l1TG9LOU9zakh5bVY4R2FUVXNzV3Ex?=
 =?utf-8?B?eURnK3pFby8vdGxBUi9EZXZRWnpwOWp2dzRhM1RzWUFFZTZLdW4rMVpYeWJ5?=
 =?utf-8?B?YnlIT2VWUVBjTkFtTEZxcWk4eEh6OERaMm9mSUtOWVh0RXVnQzNodnRVemZ4?=
 =?utf-8?B?TUw1eW9Cam5mSDdUbUVxclZPM0twdHNEOUlDWFN6RFJ4dkJFYyt1TWpORGZN?=
 =?utf-8?B?dXVvSys2VEdXTUtmd1lqN0k0dndjYk1GM2k4alRjWlNEOHRFMW16ZXJWc2ZR?=
 =?utf-8?B?WnJ1aVFwRVg5dXo4czJMeDJTeHk0aThWaDBtcXJ0bzVHZlZQZ01nU1lHWG1j?=
 =?utf-8?B?N3IyK0dRS29qNDFWQmRBS2lNNi9qZXBXSE5tTm9jM1lBWkZhWlNOaE5rbmF5?=
 =?utf-8?B?eWJaWGdNcHB0NDk2UndYZjUyTU9IMkJBMGpoL1l5OHVSelF3Zk45MDAxcmdw?=
 =?utf-8?B?SENGLzlYdHFYdThERWdIM0JwaXBqempza0NTdENISFFNM0w0bmVYVnVUOFB2?=
 =?utf-8?B?bXd4aVdEWkRJYWRId21RSDFUMDh0aU1rUVdBcGVmTWQzVGxYdmhOQXYyOGxj?=
 =?utf-8?B?QjM5VmRJKzZidDhWNE4rMm44cUFSbFJ3cEd6aTFCcEtha3M1djFieFFRTi9x?=
 =?utf-8?B?TkxUQTJtSTZsdHJLM1A5cU1jbUFwZk1icFYvSmlTNHFsQlVFM25qMjhvVDZB?=
 =?utf-8?B?T1E0Rm83MXFueVNkWFF3R1RIUkxKajYreTJpYmZoVXh4SXdNc1dxOWJnVnRW?=
 =?utf-8?B?NmxNSk9mN0NRc25VR3hBNm0wZ1A2WFQxaDVwNjhYZUFGZUwyZXJHUktZL051?=
 =?utf-8?B?cmNsWldUQ0p5TVRCL01SM3RUSFFIMkVUT0NRT1phWkRLSWI0R1dSRGxjK3pP?=
 =?utf-8?B?V3JUelpyenFIN2xyUVZ2eFp1ZlQ1TGFmaSsxNjZ3MWdPQzNLZFd0SDFPUk9m?=
 =?utf-8?B?alVjRW5zSVRVRDlPem5sYkZXMGhnWmJidXFDbVJVUVMzNllhM1hJNDVGMmJu?=
 =?utf-8?B?cFh1YTlYckxWR2xMZFVxK2Z5REtiWjhBQXlsZFlISHZQQUdoc2pFcHNFWjh0?=
 =?utf-8?Q?Cg7GMLMMTjwodKvBQT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb255117-5199-4f18-d58d-08dee27ab5ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:09:40.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6xZ+e5vmSGdJNlfX3Sdr8MvP74EhzZ+G5tlkKAab8y53HB8yMP0GuueezKMz1G9NCkx50EDuhc3z9SFikS7vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327

>> Commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering
>> encrypted memory regions") added FOLL_LONGTERM to
>> sev_mem_enc_register_region() so anonymous guest RAM is migrated out of
>> MIGRATE_CMA/ZONE_MOVABLE before a long term pin. It also kept
>> FOLL_WRITE on the pin.
>>
>> Combining FOLL_WRITE with FOLL_LONGTERM breaks registration of file-backed
>> guest memory, such as virtio-pmem host memory-backend-file mappings
>> (MAP_SHARED). GUP rejects long-term writable pins on dirty tracked file
>> mappings since:
>>
>> commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
>> commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").
>>
>> Region registration only requires long-term pin to prevent page migration and
>> does not write through this GUP pin.
>>
>> Drop FOLL_WRITE and pin guest memory only with FOLL_LONGTERM.
> Worth mentioning here something like
>
> "In the past, FOLL_WRITE was required to trigger CoW unsharing, making sure that
> we don't end up replacing the page in the page tables during a later write fault
> after already having pinned a (shared) page in MAP_PRIVATE mappings.
> FOLL_LONGTERM does that nowadays (see gup_must_unshare()) even without FOLL_WRITE.
>
> Given that SEV only pins RAM for XYZ and doesn't actually write to the pinned
> pages, we can just drop the FOLL_WRITE"
>
> Fill out XYZ :)

Sure :)

I will update the commit message in v3.

>
> In general, LGTM
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

thanks

Pankaj

