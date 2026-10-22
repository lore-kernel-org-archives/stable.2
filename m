Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792641902;
	b=grCuXUB85EDcagiz5o778IAN0o6NQE2wozcGPJfqJ8c1tjIZsRFsViLf0bBwRO+PLUSR
	 Ex3jamhBspLzicCir7nfxjjUe5wJ/zItFoirAJ2ng16Wzvz5MsJWD4mKdpqZOYmackBU2
	 5xNauHH9dRucmZH2/du2y4BUCHH7H1aqavIBpunV1Pf+pFRfT4M+ypn0pJFn9O/SxnM62
	 gvNLvoopOLg8Cz6f9BvaL1tizL+wASRPW6+HhIchRTRgy9xZqkg09/wof2NMO6U5cg1Eb
	 FUmxNLQP9yRz96qhxOOUGCqJvL7fXduGg3s3+NnRBuvEvxszzLyy14DQMX8JA+DCAAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641902;
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
	bh=lOAZB56aAOCpf/5J+rSwb8tTh7A1q7LUV2n2GftI+bA=;
	b=lgLDFPom6WwFzBZ/ZYEFLNIg2bmK+eCQlIQBWTrsh1nkO7LwDSXy9MeuUPzZCGv3eTZ/
	 iBfiJyofdOWzmETg0UkBLrqeDUhj7taxTc6Vm7FKBNph6z1gV7OZWbq4DflE9NbZPuKCy
	 eWtDAZKGGVcgF50F5yT6L7SSB/okS0IckCSBbjNCDwvTlRzs4GGeZCu+5vuyAD1sSS8Ec
	 kP123ibvB7Z39eTdHhrKaEPeJc74Awc1hZDdfrcLUGGadK3Wm7PJB01pSZ3tJ30bxycAt
	 S6eceoJKTcb1TOBVjOgVdlzY8O+1Op9bTZ2wp/jLkyQq6EIjZY6JVve9xCCUoimBZeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qHEo+vH6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.61
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D0606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 04:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 454D0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qHEo+vH6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgIW5ZgxFtptMTqPxv3mpUk6jkcN+GQGaAZkNIoqSw08z6MzoYDZEf8yoLifIMVUtVylae7Wmpzd2h5bJdaUQdC1ekqgvRbwRpij0ti4KME6PC6F9eN0qQpOMCmLQa/0WGNslaM8N+wli9NFI12kFpTboSIl2D6m6BHzkP2qvd+a0LkvzC0iiUuggt4y5F8oOlr96WDiXgr1u0mdvu9nF1obCEJBoC1J1Nn4hHv5y/x5ZlqzgZMuoaLcC+OCIsv1WKgfY3MOkF4DdPQtTMPkoqvFgUPl5HocjhgqSyOhcQB7YqMAiS8beDMKJIwVOni3IhgTFAUv2YS/CoeN6Ii/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOAZB56aAOCpf/5J+rSwb8tTh7A1q7LUV2n2GftI+bA=;
 b=cUMEpgqvXwoZPHI8ML96VVK4uyOib+fq/bJGV9SNSrclz52WxPS7Hdn1/aMWzojRTr0ferOFB05SrIBsDKTnTQH4L7QLoEmOb9Zy/sdtxKmcyinaG4iXcR2V+TE/kq2rGJxanHCp8U2058XCUNmKHvCcAtuoM4MivWe2USbrDqeruynL0NrwHkoN6ZfYhHDgnK4bEFPBgnlqvrGjSH5W0t88+CfXEBlw/G9sKR6CYk7qPXN2jTfZYVng0AzvobS4PtW6CCmQFnGRP0aW7DZO6NI7cF6WtlcHWgoebdZEw3gSZH9wwe+93caIL3n/H073cd0f80T/dcKOpf9FH+UGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOAZB56aAOCpf/5J+rSwb8tTh7A1q7LUV2n2GftI+bA=;
 b=qHEo+vH6IXuLi02fWayXGB+5Sw0VtKjiEB56z5eBdC0oYOPNV+v+5JjzcViovsRRHxXqrRDXu2wImEQkKSqww3WXJtoYVQb4k7a4VTWCqTJb1g3aBizxune3CzylHM7F8Z9h3Scpp5yoQRX/q3czSSci0mYq2olax38qSEyMlZ8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 04:05:00 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 04:04:59 +0000
Message-ID: <4ec3b046-56db-46f1-8930-4062249988e7@amd.com>
Date: Thu, 22 Oct 2026 09:34:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu/buddy: do not pass caller list to
 __alloc_contig_try_harder()
To: Matthew Auld <matthew.auld@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Shashiko <sashiko-bot@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261006110706.1636971-2-matthew.auld@intel.com>
 <DM4PR12MB5039955C1A48C78942896415E4672@DM4PR12MB5039.namprd12.prod.outlook.com>
 <281c6c14-2692-40d4-b812-e41c3a2acaf5@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <281c6c14-2692-40d4-b812-e41c3a2acaf5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 708d4cea-4ec7-4918-c84d-08df2ff1a41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|261021123027099003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	rFU8GRB9SV5u89I0q5tFkfkpf6go8s3Fln9TrRP8NcF7rKpUWCWR6tod3X6pZ7S0xV9PMqnNYlLC+Qh0n2VFhX+1VRw+57sEYZtQ/09gpQwP1hWccBMlNBUkm0JCEvI7r07nBhncK823STTy7Vu1VbWA7qIsBFCYQZFWr4L5hUiw7SyuZLV1LvLrxwfu5xhMwh0+XKuKSATPjMrwkCpVvCd+dkubqX3NVmFk4BzT/U9+b9hPwEjR0pRsqlVLcDYs/qitJ4SHskXKMlyJnEIoIEaXTLmw7wh7du05jndCzoegJVT33r7YXvaJFEKaNgHuGs3Lc1IKFgkCDiaDKaBEhKDs5YD9WfDcsPN4SV6ynkHVvktHeyswxWLwIqgYSpxB0IVNulz7JwwTcfJDeNXIk3Dn1DKt+qCKGQHFHsziMtGJWeeUmQoDNZ0dM5+kK8jQQ01nM+HjR0EsAI986iy918hncZdPxTzMSWGderTuKG8P9ElXGeZCqgQBVf2diOO2aICQy48Y2qy9kaEy5ZXtQ9wxJnLgHPL6qbiJIHfdsx3kOo0WhE+ATMJ4RJDa3WCfJ0MGF6cucDJObD8oYxuv9X7VqMTpLjmld+DeDPrIbWQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261021123027099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TERIZEREOXNBaHJ0emFIeCt5M2hHZWNBUno3dDZMUTFQMmtiOEJ5c1QrMTRF?=
 =?utf-8?B?MU5tcTBpSVVYdmdMUTZOaWJCNWxVRkxEYTdJMzlNZURzMlgyQld6MWlub2dn?=
 =?utf-8?B?cVVzOGN4Mm93UXM5bXVJQ01uTHV4VXVqci84bzArd1MyTlVnSVRhMW91NGRi?=
 =?utf-8?B?blp2L3pVVjM4REpYQTVkeEh5cU5MWUQ0NVd3b3BLd0Y1TmtVZWpweWd0SmlO?=
 =?utf-8?B?NlJpZndENUtjc0FiNXdWbFN1N1N0VDZEUldwYWdBUVR5QjhLQUFIangwajBC?=
 =?utf-8?B?THhTb1ZwWGFsMW1xUzNCMUpYTVEzQ2NxVFY0bkx3NHg2MmdJelVUZlNXcE1V?=
 =?utf-8?B?VjlUR0gzajA2Qi9NU1B4WEtMYktKcGthQndUdTJibE0ybElwVjgxRkJnNlVo?=
 =?utf-8?B?QVV6L0xmNVV3MnNYUFFreGY2ZEVWem1XTmVmclZBOUJ0by9WQ0ptVEgrMHo1?=
 =?utf-8?B?RjZIdWIxTE5FcktmYXRjU1hXUTR5UkFtbXZrTGU2MU9kbXYwRVFQZDhSVDlZ?=
 =?utf-8?B?M0RSQ0ZmZldSUFEvOXhIMFZJS3VRUGg3SWlNclhkQlI2OExFNEJJYnNVRzRs?=
 =?utf-8?B?R1p1OVhweG9aYlUwdjV1dzhaT3BiKzJuVms2dlRZcjlpWHRGYXVoOXI0V1Jq?=
 =?utf-8?B?ejdjTHErWmpVY0wreUdJbUpWbk1jT3gvM1AzMUpSLy9FL05iYzhZdnBMM1Fv?=
 =?utf-8?B?YkFuTENiNzNpbXNoN2p4WWNaRWdmeWdFakVYeHdnYVV4Rm1vekROc241OUtZ?=
 =?utf-8?B?MFlWY2Uvb1V3djN4bzUrbGJzellHb2hDdWh0SUFuSDJrY0VtcjNobmUxNjB0?=
 =?utf-8?B?NHJTSEcyeE1EYk9pcW1GeVRoRE5WVGFhQ25oNTljVmpEeWw2VFpJYnRTZHgy?=
 =?utf-8?B?WEQvcEZRYTJ5QUY1Zkp2cEVRQUJZWlRUYWtqVFp3MEw3dTZnZ3VrTFJSOWJS?=
 =?utf-8?B?c0ozQ3l2alVteURSSW0ybFhBY3pYaDBIRm82WjREQmlySno3aW1OTTdYOGJC?=
 =?utf-8?B?aExzb3pxVEs5SzZQK0xWVEk3UW8ydGlBN3AxWTJWK0F5bXlnRVk5dEJGNFlY?=
 =?utf-8?B?Yi9odWVkbC91MzBkbHorbkhZZTZMc0ZiYllMMm1qTHA0N0Rta1BRYkJyWmJT?=
 =?utf-8?B?aGZ2V3JlU3MrSjhwcGxsM250Y05PbXFjVlpBUDN2VG9xRkRlMjQ2dW52Z0tI?=
 =?utf-8?B?OHVQMHBZZWdUc2QxWWo2OEV4OURJdEc3TFBkQ0paclF3Yy9hUE1jMDc5M0xu?=
 =?utf-8?B?TjFHVWhDei9ZY3BaZmZMV2FrRTIrbTFtV29qOXlmNmc4RFRSMGtTV2JhNHh3?=
 =?utf-8?B?Um9JWitOZkd0REs0aCtFQVFBd09QaEVpcnZVTGY1RVFjTlJ1Q1ZFN1AwbnA0?=
 =?utf-8?B?bTVJdkRQTm9obW5UeU1kZmpLVkdKaGY4SEt0anJmb0h1My9Pb044MlAwOXpo?=
 =?utf-8?B?VVFBMWJTbDRIRHFPc0xPc1E0MFRqSXB4Q1IwYS9zUXRMNFRnQUFBb1lWeEJx?=
 =?utf-8?B?eUhLTkg2RVBvVGZaU2Foc3o2ZlkxVVFTbE50SFlGN1V1aTdtNkhrMTk3cWFL?=
 =?utf-8?B?YUI1dnZ5Nm01TmVRTCttMk9tTUFVYVhLWWNzTlAxUUNob3pTd0hCcEVxN1dW?=
 =?utf-8?B?M0dMd01XWWtZWnJGQzUrRENSYXhuM09taldrL0NscXlFeEhjbXpaWUlESDVH?=
 =?utf-8?B?RVd5eWFQVUVIYXJIOTdaam52d253Y2tWam5mUWZGT3Q5STJhMk5vUHhVTkhW?=
 =?utf-8?B?UERVV3p3NXFJb1YrM2pFbzVWdmhYRDFXNElnRi91bERuMjA4Zmc0RW1ibWRF?=
 =?utf-8?B?YVAxUFk0dk9VYVRENjBwNmtDZzh1QkRRdTEwVWE0S1ZkY2tvRnpESlk2dlJN?=
 =?utf-8?B?WVJLcXNnQnFzTmNocWh3ZW4zNkVvbG5XakhzMjBJOHNmNVVBeVY4S3NDdEZI?=
 =?utf-8?B?NTBuRVR6YmI1aUJmcUxRQTVVWWJCNzdtNFRSQjAveGdpUVFOUFV4LzE5M28v?=
 =?utf-8?B?OC9aTFNTTmN5Y3NTdDJoYzJ1bjZncEliWnc2Q1BkcHd1MTJFNTl4cmJsdXB2?=
 =?utf-8?B?N2pZQ0xqcGNiSk5FZUVZV0JjSFJJbkJUYy85bWhYcDlnNHNSVjBmK0paTjFZ?=
 =?utf-8?B?bDhyMzlCd1hOaFR6WTU4Z2JuU2w3K2o3TVN0ZlRETVo5VXV2b0x3eXFTTC9Y?=
 =?utf-8?B?bkZha1hNM1RwcVlqRW1UT3BjN1diS1BtOWFFczQzd0UyelNuWFdoWTRTUXo0?=
 =?utf-8?B?SzRmeXcyK0JqNlZHUFdXMjliVXhQL21neHFieXkvT0pudktuY1BObWZmZ0V5?=
 =?utf-8?B?ZzFnT01qcEVTN1UxRVdQaWc0Tkd4emdUV1VBQkNIMXRIaDRZakJNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708d4cea-4ec7-4918-c84d-08df2ff1a41a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 04:04:59.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxK6f5ABFUMJUDAfq1rakl3b/Y1t2P5NUwgrEn4sHH8mJwV7VBWD9gYmgogXtWk5p5fB0CNYT2v7MxvURR5AXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546



On 10/20/2026 4:47 PM, Matthew Auld wrote:
> On 20/10/2026 07:06, Paneer Selvam, Arunpravin wrote:
>> AMD General
>>
>> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> Thanks. I assume you will merge this?
I merged this patch.

Regards,
Arun.
>
>>
>> -----Original Message-----
>> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf 
>> Of Matthew Auld
>> Sent: Tuesday, October 6, 2026 4:37 PM
>> To: intel-xe@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org; Shashiko 
>> <sashiko-bot@kernel.org>; Paneer Selvam, Arunpravin 
>> <Arunpravin.PaneerSelvam@amd.com>; Joel Fernandes 
>> <joelagnelf@nvidia.com>; stable@vger.kernel.org
>> Subject: [PATCH] gpu/buddy: do not pass caller list to 
>> __alloc_contig_try_harder()
>>
>> If the caller passes a non-empty blocks list, 
>> __alloc_contig_try_harder() unconditionally frees it on failure or 
>> during retry.
>>
>> Pass the local allocated list instead and only splice it onto the 
>> caller's list upon success.
>>
>> Assisted-by: LLM
>> Reported-by: Shashiko <sashiko-bot@kernel.org>
>> Closes: 
>> https://sashiko.dev/#/bug/linux-fa721daf-7333-48b5-a26b-624c7f5791d7
>> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   drivers/gpu/buddy.c                | 20 ++++++++++++++------
>>   drivers/gpu/tests/gpu_buddy_test.c |  9 +++++++++
>>   2 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c index 
>> 2f2aaadafe35..a86f454fbb40 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -2022,10 +2022,16 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>
>>          if (order > mm->max_order || size > mm->size) {
>>                  if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
>> -                   !(flags & GPU_BUDDY_RANGE_ALLOCATION))
>> -                       return __alloc_contig_try_harder(mm, 
>> original_size,
>> - original_min_size,
>> -                                                        flags, blocks);
>> +                   !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
>> +                       err = __alloc_contig_try_harder(mm, 
>> original_size,
>> + original_min_size,
>> +                                                       flags, 
>> &allocated);
>> +                       if (err)
>> +                               return err;
>> +
>> +                       list_splice_tail(&allocated, blocks);
>> +                       return 0;
>> +               }
>>
>>                  return -EINVAL;
>>          }
>> @@ -2064,9 +2070,11 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>> original_size,
>> original_min_size,
>> flags,
>> - blocks);
>> -                               if (!err)
>> + &allocated);
>> +                               if (!err) {
>> + list_splice_tail(&allocated, blocks);
>>                                          return 0;
>> +                               }
>>                                  if (err != -ENOSPC)
>>                                          return err;
>>                                  goto err_free;
>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c 
>> b/drivers/gpu/tests/gpu_buddy_test.c
>> index b75d32ca6ca0..2c6f1da1a6d1 100644
>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>> @@ -1235,6 +1235,15 @@ static void 
>> gpu_test_buddy_alloc_contiguous(struct kunit *test)
>> GPU_BUDDY_CONTIGUOUS_ALLOCATION),
>>                                 "buddy_alloc hit an error 
>> size=%lu\n", 2 * ps);
>>
>> +       /*
>> +        * A failed contiguous allocation with a non-empty blocks list
>> +        * must NOT corrupt or free pre-existing blocks.
>> +        */
>> +       KUNIT_EXPECT_TRUE(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
>> +                                                      3 * ps, ps, 
>> &allocated,
>> + GPU_BUDDY_CONTIGUOUS_ALLOCATION));
>> +       KUNIT_EXPECT_FALSE(test, list_empty(&allocated));
>> +
>>          gpu_buddy_free_list(&mm, &left, 0);
>>          KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, 
>> mm_size,
>>                                                              3 * ps, 
>> ps, &allocated,
>> -- 
>> 2.55.0
>

