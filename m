Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462F3D1A97;
	Tue,  9 Jun 2026 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029061; cv=fail; b=Rxcb+r8UaPiPp2f69kQgy5ZJDwLCZtPjC7DNhxGk6WweniXTVKt97+LUUfPyab5/tElOAnjMvn03lrhyRctRh/vYmFJ+5EscqMBhrpDRIdMTwUJnGBRwvIWT3uUScFS0VZ5dti7ApLt+9I/JDfHGntz4yRP6PT3KYBCNhNsK2PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029061; c=relaxed/simple;
	bh=f4gVJwKv1ARgI5VnJx1MPUkIs2dEqGpSse9uY28Kv+E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mOk7V6P2VSqBJaiz01g8FUkAUPlb0bnTUEQ0w5wZP2E8q5Ak45fNnRYjuJMMHJYE7eUW4+ZjuQ5jC6ZSGdOhsUdX9MhQZeglq3hkOZdIuizOIsQkKucaAWVJFmeyxMzEW6MP7mBWrI0O3DzMjX+uKyYms5R6cVjRe7Xazd8f/k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J0j/yKtt; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J0j/yKtt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpdoPJfHDWjYqd3zFu1NuD7VwRbqMwcAesL4YWi9KKIEYXdwiybYBCSrUS3lgKMGXRgXQW9n9QMPXpqea8LJ0cp8sOoeJ9FNPRroFH8D1277cv1+S0OuYv4Ttvj4INBYwMN3rblH6HASF81Vj7fXBid46YMgHbPsKxW3TzPSmfPT2V9v04Zg4i41ECtkC4YsI66Dyh42jxXAvqaHDbSfRFXZyYjceuP3CmQIS4c7PPA0fKXDSIsk3Pl1gVc1q3FKrxhsNpFgteCYwZ7qIOiOza9GlCWNkW95JbFn/LSH/xJfKwtHThVFn2cyPb4F3zJF6uX1UMmJ+OSz8O3Qy5hOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7SvUvf7rijijHm1x5rRcmeiFP9QCAP90w8AbPvubmw=;
 b=AE2do6nx3IWMvO+nXOxbnSbCxbDMrkOzLawWE1HZ+LZClwIPcBTmczvDvt0E4O0qBFwvp0xPy60E1WwglgU34J+xNMMIyozUnGVplAb94FXpiZHUTEml3WKTIHmhtG+EuOl9FXK8uc0o493a+VbSmeAWc+H6sGtl5tBOEsLsxUT22NeGxirScg0pz2dc3ra0YKG59k0dqwpFODDj5FNkTJMWIx03cHFKrGAFv3x+QPPdhap9C0jZhkNLgNiUmtabI1ZtVxlXzYoZlmeXFIcpJBZBfVPnLLdJfSPRH9ILksU7uOJiN7etYClXJd3upF9aQG17VgI0I+qJIwcpLtbtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7SvUvf7rijijHm1x5rRcmeiFP9QCAP90w8AbPvubmw=;
 b=J0j/yKttTYP9o5N5xYoflWf+btzmfzwNOA8RPAxuQSvU8c0ZBNBTXHIghsHZVft5NmTVWyKmeD/kdoYlLGBU6l9zwO10ZZKX0ZjwWP1+dDv1Q9hrRSgQ34HM/dAN14ssv5pJE4hTme2Aly3EQCIav7Embm42eLicockaxbgDmJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Tue, 9 Jun 2026
 18:17:36 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 18:17:35 +0000
Message-ID: <3cc3f8d9-a6bd-40d0-ad23-2a30112b2507@amd.com>
Date: Tue, 9 Jun 2026 13:17:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/ras: Fix match_memdev_by_parent() pointer type
 mismatch
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org,
 ming.li@zohomail.com, rrichter@amd.com, Benjamin.Cheatham@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, stable@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 PradeepVineshReddy.Kodamati@amd.com
References: <20260608224319.587614-1-terry.bowman@amd.com>
 <aihI9XAslh04a2T_@aschofie-mobl2.lan>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aihI9XAslh04a2T_@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0144.namprd02.prod.outlook.com
 (2603:10b6:5:332::11) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5662d0-b9fd-4006-1f27-08dec6536172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|11063799006|56012099006|3023799007|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	tPhFAzT35WhvOTX1cIa1iQGGwdZWk+/01qfl6xQfxwZMuO3LPqcX6dJCVPud8d0TudITouloHbnFVJhdKILVT4BeLkSjkUyZZUHCdaLZbh1ZBhm7fTdPninqxQ6juhbvzZk4+Rpxi+ReQUMi4LURFY3gMJ8zC+qcekhb94wWwGvDdTNFpxJHneUkH8IskwrMaDuqNLbdDbzm7VES5VdPaxssXuLalVNkZJFzZAyBM4k9tNtpX3CTM0GcJPyf3LptohCjJ2g1F8qLuvVZQKb29wZUJJwjlkjuNJineq6uWc5mKV7Wg4Hr4YjB4E0Ersqqoh++f5C3zpLLLt5DE94UaVNTYwsYKvnXfEUi2cSUPsAxAEWkQ7Mej00I33j4u6vxMGhs87+N6U3f+MVQXGG4XjlE08qZ0ghcXV+vNcAj4CFiDZJtsm+XAZp/rhRRaWXThykX3xAzoOK2vYDBIQLh6PFw6RCL3M2UvhAu10Zz3VtQF8w5XFDi/Muv1J92jQBYlFY3pB3/JkRhessr0HAFNGnZk3sIXnGgeEE2luXix/L3yAh/hrHOwNPu7LHwDlvspRXc+GSMSNM/cAzBdlKvUCmDzgp2o5e665vlLjTu9NtpP75RmzkUE/swnb9hnf9vF8vUAqKp0XF0LEFIxYhbN+l/yQfCJmvZMEA8LjYypHlbx/6C/zIq+ZV+jyroeL9k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2NlSVFUaVk5d0pEVTQ3SjVyVFZMWHN1Wjg1ZkE4ZTQrSnpSS2RNL2FBNTdt?=
 =?utf-8?B?L20xU2lnNTdHdUFLUUhhZXluMFFVTFE0Zi9EZDVOYU55M1NvOG8zRnA2R2kx?=
 =?utf-8?B?UnZBRnY4TXVGTGxLQjJYYjdjcDUzRElSa2EydTdXNlk3Smd0QjY5SGkvbXdO?=
 =?utf-8?B?TTVGc0paVjJxbVJLMnlCclk4eTVKT2JSNnpXakgvS2hvT3BlT0hsNVhHemFl?=
 =?utf-8?B?NkpyM2JSQTREaThPOTk4VGU5b1dEOUkrT0JKREM4Q2JSOXJhVkFHRVg0bndv?=
 =?utf-8?B?eTBIUXVnYThxNXFQWWdzNDlzU0p4L3ZLYWROb2JqVm40STc4OEpxV2ttVC9l?=
 =?utf-8?B?bXA5KzV1TnFVM0RXa2w0cUd1SmczZmluMm0wRi8zWG1ybU0wYVE3TGJ5d0ha?=
 =?utf-8?B?ZlBwc2gwQ0ZGZ0p4OFo5RllMWm5wYU94ZjFRcTBYUWs3KzVJYkpqVDdXa2tR?=
 =?utf-8?B?ZWFqSkZzcFFRenB2NUFhOXk5a3hsR2dTYktNYjZJOXc1U3ducWtyKzdSR09J?=
 =?utf-8?B?R2tBL1I3VmJRRW1ROFBzWnlMNWJvNERrQ09lWjR6LzhNNC9ZS05SdEpYMnpI?=
 =?utf-8?B?N3pzMHVyNkpIRjdZQmxmdzBUdlA1T0pPbjFSVjVjeTlCNFpjaWhESTlMMTJF?=
 =?utf-8?B?YnpPRkJ4cm51MGc0WXo3cU1NUFdZRFdXNUJnZGdKS1ZPbDRVOGNTYnFUV3pk?=
 =?utf-8?B?MkhRYUFDRnA0YjhaZitGdkt0TGs0QlhEYmJtUWhYVlZhMW84N2twdmh5RjhZ?=
 =?utf-8?B?UmxJc0VjSFpHVHdpdjcwWkpmSVFHMjZtd3hiYW1CTXlwdk94TTFMMDJwOUFY?=
 =?utf-8?B?V3lORTViNEs4OHdld0xqWDVzd3BxVkx5MkwzR2pGSytYZ0JoQjhCZjN3c0tw?=
 =?utf-8?B?SFcrU3ZKWEZtMktWK1U3NUsyMHNQbHp2Q1g4Wmx3d2VEeml2Z0liQ1lORGh3?=
 =?utf-8?B?RzZLVElFbEh6Ui9JcHQxU2p6YVFEd29YRkMveHNvQkIva0V2MExOQ1lIZjll?=
 =?utf-8?B?MW1Ub043ekladUpmdGlGUjAzbm5ONXR0dEE3c2NFQy8wTDAvWjlsY1prSjFp?=
 =?utf-8?B?dUFBYTFBU1ZIRER2TkhrTXZ5MENjbmVUYlo0Q0pZbGsxMnlhdnVMeEZ0RmlQ?=
 =?utf-8?B?L1BpYW16dHEyZGtYV3ViaHh3QnNLaCtpU2NJelMrd0k5ZElLeWcvdWIvYWVa?=
 =?utf-8?B?aVp5bVBuWW9kV016cXJkeUt5ZUZlWXBNS0lkcGd6NjNkc0lOdkFORmpuZWd6?=
 =?utf-8?B?aFdaZmdPcnVGMjd3RTN2WEF3ZUpHcCthYVRUenpsdTlRaFltTWpEN3U1YnY5?=
 =?utf-8?B?a3Q0M014akRGZi84YjVzazFDN0gzaVNERjNBcWxlbWZlYnlZdGhhdVQvbEpx?=
 =?utf-8?B?NVI5cGxvd3pEYWNtZkpKY01leEdJTTRJZExjVmVzQ2FQdzd5a252YlRCeUhq?=
 =?utf-8?B?aWs3T0kwOW1TUzhDUDhQQ0J1bm0waDM0a0pzVUtMUmtvSVFPMGRZWUFhQkxO?=
 =?utf-8?B?cDhtMUx0b3JyOWVZWG9RdU9IRDZtZDhjSmVoZE1JTURJQ0RqM24wY3EwVVVH?=
 =?utf-8?B?NU5vMXRDUUk1M3NIRGVDZ0t0OTFhem5USW1Hb1dOcng1VHdPcUlQTGNQZVd1?=
 =?utf-8?B?L0FsSDZEbXNPL1dpZTdlREpQNUJaeUl6bUpHWFVSbHgzWjQvM0RLTW10S2NJ?=
 =?utf-8?B?NSttKzh1Zm5YTUloZlN0TTNZeFNzc0pqd1NXYUNSOFVYNmFwOGY3dUtNWmFx?=
 =?utf-8?B?N1Z1Z2o0UThXT2pEQlZMMko1WXV5dWIveDljOGFkRXhKc2daeVZrKzIwNHAv?=
 =?utf-8?B?Y3AyVkVVdU1pTTJqTUdaMTJRRzFxRFg4WEdaM3JnS1Z1TjhkVm9SaktnTXhR?=
 =?utf-8?B?dlE2N1BNVThGWXhWWTJXUUFNY252WHVYZ21JMVN1dmVaQ0hBaTd1VnFTZGpB?=
 =?utf-8?B?UmtTMkNLU1VNbVpSalVWSnZROUNDNnVLYUh6SXczOVcyZzVIV0dzMXZlSk9M?=
 =?utf-8?B?UDltaHhpczZlY1cxSndtandEQUxzZjcrc2llbEdPMkc1cnZiajhaVUV6SGcw?=
 =?utf-8?B?MmRtV3crdmw3S1FVZGtTTTlwSHJNT3BhM3BSRlZmZkV0eDZQNDVNb2Fidkpl?=
 =?utf-8?B?amZwcHIyQlFDbVV3NW5UOStuNklBbVhCekpDRzNQaGVUK2FqYkVSUENZbnRn?=
 =?utf-8?B?aVpydUtYUWF5eVJVVG9DbXRHbERUZ3B5dWRzVzdoZEhya2pNeVdZSGQvQ05E?=
 =?utf-8?B?THRyZk1OR2VkcWhYUXNhMFhwbEpuQXI1eDQvRGh5NVpKR2JXVmdxQk9kaFl0?=
 =?utf-8?Q?t7OFNo7mqedUEuZ8KL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5662d0-b9fd-4006-1f27-08dec6536172
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:17:35.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfRnsbNoG7gcWy6Khtwy1tjaMjQeO095PUTk/75qQAd+Lyz1FQg5+hdHadz+n6iyjn8MLbBoQ4qYdCPN9k+Rgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

On 6/9/2026 12:10 PM, Alison Schofield wrote:
> On Mon, Jun 08, 2026 at 05:43:19PM -0500, Terry Bowman wrote:
>> bus_find_device() passes its data argument directly to the match
>> function as a const void *. match_memdev_by_parent() compares
>> dev->parent against this pointer:
>>
>>     dev->parent == uport
>>
>> cxlmd->dev.parent is set in cxl_memdev_alloc() as:
>>
>>     dev->parent = cxlds->dev;  /* cxlds->dev == &pdev->dev */
>>
>> So cxlmd->dev.parent holds a struct device * pointing to &pdev->dev.
>> However, bus_find_device() is called with pdev (struct pci_dev *)
>> rather than &pdev->dev (struct device *). Since struct pci_dev does
>> not begin with struct device, the two pointer values differ, causing
>> the comparison to always evaluate false.
>>
>> As a result, cxl_cper_handle_prot_err() silently drops every CPER
>> error report for CXL endpoint devices -- bus_find_device() always
>> returns NULL and the function returns early without emitting any
>> kernel trace event.
>>
>> Fix by passing &pdev->dev instead of pdev.
>>
>> Fixes: 3c70ec71abda ("cxl/ras: Fix CPER handler device confusion")
>> Reported-by: Sashiko <sashiko@linuxfoundation.org>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Hi Terry,
> 
> The commit log is burying the lead- no endpoint errors reported.
> 
> There is no need for the full struct layout analysis in the
> changelog. The important part in the functional regression
> and the pointer mismatch as root cause.
> 
> Please reframe the commit message along the lines of background,
> problem, cause, fix, and validation. Something like-
> 
>     CXL endpoint CPER protocol errors are processed by ...
> 
>     Following commit 3c70ec71abda, endpoint CPER protocol errors are
>     silently dropped and no trace events are emitted. This happens
>     because bus_find_device() is called with the wrong pointer type,
>     so the memdev parent match never succeeds.
> 
>     Fix it by ...
> 

Ok.

> 
> How do we know it works now?
> 
> -- Alison
> 
> 

I have not tested this patch yet.

- Terry

> 
> 
>> ---
>>  drivers/cxl/core/ras.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 006c6ffc2f56..7ec2dab152a7 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -94,8 +94,7 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>>  	if (!pdev->dev.driver)
>>  		return;
>>  
>> -	struct device *mem_dev __free(put_device) = bus_find_device(
>> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
>> +	struct device *mem_dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_memdev_by_parent);
>>  	if (!mem_dev)
>>  		return;
>>  
>> -- 
>> 2.34.1
>>

