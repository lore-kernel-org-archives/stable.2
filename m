Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792496978;
	b=ebtU5L68KCimFIq5IqDiv1HVPLZvwHGpE+yrh/siCOtL9/q/0ReMAIi4tYL7yXX8LJ36
	 lyaUSdIX/oDbyPg1U3KCKPft1UzUzOke4BsLWb0eMFkVy/Kp+7eAH5Dw5XkKF5fnHnyiC
	 62vtpOik/crz10e5Pwr+zdHFgdCjP0cdZqDsYFJ9D4wMdPdGhutyz77EcE8cCzFXHnVpD
	 b+lSxX8b/ouBuELz1X94UL20Y9aq8T8oCnuYFy6YQzvAsR6HiqnADQ/rUp1J7+mvBlAF/
	 JQMjsjB0EcHvgJuwG2GXG9f/KCKopqi0ImI3uy3RyEwpKSs+N604QtbV2KwVL3/h80A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496978;
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
	bh=AuQikB9GTZdM8oalpWKa+S5dRjJdaHN51O/4Z8pHB4Y=;
	b=gqlAsE562XsQFv+Xg+g5pZzafbeut7fiIG52E73nvPAYmm5S1z9WrzNtFGjoWKqPuKb9
	 q2BUL8TbNQImmlF6sXTcbJS3pDBxkZGLEtJ2PKy57tKtw0eYHW4+6ELGVkWU6W+BgV0FF
	 8ho00eq58HJXtdREIQ/M0tI73Cz9mg9h28YviGUpd5spR1nZp+VeYAbDJBnarE6G9yk0a
	 N5W7sEIBuiyWMowpjIgqA6TRmzmATkoGeUr5Vg3M0v70hnYiDDX1XaPUD7MyepM5bz1uX
	 hlEJE/gpjfz7iry2dftG1ouvEVZ/sB2PzhIuboiKS7GeLwbZO1DEcSmpM9O8tGEJVlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WWcae0ae;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.18
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55D606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B55D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WWcae0ae
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gh41G9H81IK6zpFgBguMlioG7sK585ViTjL1HLR/UjvbyBRvDaZ1R27Fx0x9Or4BJKiFuvk+C59Ge0vp6FYgQ8YXhI5ceDSGxHi3fpfVoCb2mvzZRWijJdEw5HH/P5geItJy8RtxIxqpba9jvvxW4911zm+OIwrDgqI8MTRdxMono/B2yZiNwAW6Bwp6mPwzfBowoLFfn+Pov7+Gtv9uCJ/kq1y7raU3BYef0U7obUeEpXxSEwG9SFccbuyNpB/BKUxLoBOJaZttREcPgAwe/NfxAqse1ih3m15VPPxXOAHvO/+440jTM/rtiVCNb0hlIjpJDrfBfQAWU8XTLrhZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuQikB9GTZdM8oalpWKa+S5dRjJdaHN51O/4Z8pHB4Y=;
 b=J1CZrwNzIJVzpjI8O5BRHT4NB35AzyfpimF3vu8w91+dTQ69L2rY+nTUNF9cc3x4Om2X7UKZdY1LukHSzJ3r9sPhAqyMjMVylp9Eh+EBrE6ZLfxK/XG1ZTslpnlVU1WIxd5AHVAFd4qTpCK+a9GYx7vQteze9l1z5pcIq7tF4oUB4HVlubvwYpW5q2zCcOtjgsf5VsbOm9IsxHryKj+G0UMUpGIq39BxjUmG/iCM5lCqe2oChGTB6M4tCK7gYT4Gtsgpe13wBQFCbFP5Y96qx43Ec7wMy6pBLMTqYYmZRtdTscuGs42bt6OH7ikBhN/MlsID644Ttax+daoeuCFg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuQikB9GTZdM8oalpWKa+S5dRjJdaHN51O/4Z8pHB4Y=;
 b=WWcae0ae6eLUkjsYmHYTQ5puX5sIkKNY6rVOqq5i5O78Nii+36mld2Fw2Ty2biMDZFzQEshyPJfqs3Ue1WbeN/Ku6AZpkL7w9Yopje7pOvYnS93Yy02f8OGWmQAb3Y1SvW3/1naJ95+bbsViacr95M2Qdghs8m6TAzDCMYqp5QA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 11:49:35 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:49:34 +0000
Message-ID: <325057ab-3eaa-4095-8799-5a568fc599d7@amd.com>
Date: Tue, 20 Oct 2026 17:19:28 +0530
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
X-ClientProxiedBy: MA5PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::7) To DM4PR12MB5039.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f914c9-4d1a-4c3f-80ff-08df2ea035ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qDQPv8tAAOpX0OCARGEOBmHb7t9U2FeasanT11UCBb/cVeE6/n9JXtNdTCIG1TDuU0atL7HHsIgofWvRL5jKkyEubUrxtPDk4r/iy8rVpGRr/+6Gron7HTz4J1glmTb6Xtv1i0soJcZRRiXk8FYi9FFE9TNe7DBGZcdomYSfSccJFfToovLyRPRQQq1aOxfbHAYwQhFrIZfn4rlOpxsqB8Hh6puWwop8/fVyy10MvPjTv7TEsGShF9DCLgr0trCpz/Y88mzGDUR1EW6W6Lf0VPQ2IIlq6BD+GBkZpMUhbS06ygclAXjQeIx5dwA8tBk5gxgvpwci2oSn1zhebGS6u76GRCYwcum6tmJD7sEV2LCp3mfh+SfmNjN18HijdEOY2ZbRjEF5wYhs0KYVWMeIos7tea9oEVdU80n7nAzDEstApZFh/nTw41L5d+thmJLIzRsUcP+odZD6LBs6pthzVjAFy5kxW0c47ZaL2T7X0DHxafFjTzMOp+1nvCwt2TMz1QvkKx0wl0/Ds5lX9RBcUX0HI10XiZ6kb+ZOikx0ldJiVdWZDW1WLaiRNTdAMEvuIKuUuW3/XcJdYN7nXEPBpmkeEi3gA0gPelSyM2T0634=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDJtU2ZOOVdiQnB0eFMzWXN3RkhYZU9SZjh3a2dlZjMyOWtvUUdBQ0grbUJO?=
 =?utf-8?B?bE5jVjNwc3ByTFpBcWdDeHh5QTlqQ1dSSHBGZzc2b2c2WGw2NmlmdWc4aUEw?=
 =?utf-8?B?a3F5cVdNS0EwZm9wTUVoMm9Ob0JkbGxDbG1ObjdDRmJlbVVKVWZzNUVjRjNv?=
 =?utf-8?B?RjQycjk3V2o0SkdqZ1F1aG54NHlqR3NMNUxSZ3VpclErV2Erb2lrWUxnVFlz?=
 =?utf-8?B?a285N3RRaG9UZ0x6Q3BvaUU3b3VpL1dzQXVrTi9lMWRxMEV1TzB4QkF1YnJk?=
 =?utf-8?B?dlB6dFRCby92Nm5MakZNWmQ5em1MNUxNZUtraGNpWGRRcUExQzhVc1MrMWsv?=
 =?utf-8?B?bFlKZXNUdm8rL3hlL2psTWVZbSt4TmxXQWNqRXNWcVhpT2pLQlJlMnUzODNY?=
 =?utf-8?B?NFdqcFhXK2ZJTldrWVpyb1lJNDNYMm5XeU1ta0RRQVR5MGlwRjdVeU1qN2VB?=
 =?utf-8?B?SElZdm5YZ3NGRStyVHJjdE5SVmxzelpvU3Y0Zyt3S2RGOTVidUEzQmFmWm5L?=
 =?utf-8?B?S1lFRmM4dmNCWVp6eGY4UGVZbFJYcE9lNW84RERkY1k3U1VwVnI0MGlMalI1?=
 =?utf-8?B?MzE2ekRiTzZOSm9XN3N1dzhHYS9qWjVKSEFpeWg5QzcvTGJHa2tQZC9NSzRL?=
 =?utf-8?B?eFAzNURjR3NVWThZenllVS9NZEhWekpNZU9hQWJxSm1EMGZOdHlhVDA4aHN0?=
 =?utf-8?B?c042ZS9xbEI1K0FuOHJ0Tkl6NTNaNEgyWm4wWFJYS1lVVnNFd3lpSXJxOFlX?=
 =?utf-8?B?algycmlycXhjVTVBZ0s1YUIxNzVjL2lNaVU1VWdGbE85bEEwUGcxRHZyVFBJ?=
 =?utf-8?B?a3dkSVphQjZtTGNyd21WUjhxMmRpZElnUlVrNU5acVVmU2NLZzJON3R6ejFU?=
 =?utf-8?B?Z2ZTZ2I4VEo5eE45WUY2ZU5GY1BqL01PQlZURmhmdXdLdEZoY1RmUHFRZDVM?=
 =?utf-8?B?dlJzZERHQkJOK3RBaDV2czJDUyswNDJCeUUydVlqN09NTjcxNHFzNnk3Wkdj?=
 =?utf-8?B?TTlER1IydUJiNzMrN3FVZmxVc1pvVDh5QnhqT1RPdHFOYTFJN2dYL2dhMjFo?=
 =?utf-8?B?OFBwRkcrOVFmdjloUEtFVkxIY3lYaHdxOFB5T0VFZ3lua2xsc3lTT0NhMllq?=
 =?utf-8?B?WGpvV3lTTE55N3VTQk9MYzZJMU5zcnNjZndMZXYvNGpFSFVGVWFMUTdFWXVp?=
 =?utf-8?B?L2toelJmYmNOREhmeXdTK2hRTGExS1NBRFBkN011aHozdFRKa0ZKb25senoy?=
 =?utf-8?B?YjNyL3FEbHQrdlJtcWR6Qkh2MGFKUVlLSVovMjV5WFJKN2ZCbW10UFErV1ox?=
 =?utf-8?B?K2N5WFZPNnFPY3hsQU9GTFdxb1U4NzNwQjZrMStEWHhkL0w4dUxTQ0tpamNP?=
 =?utf-8?B?L3YvQUJCZjFEeDJQcTd3VmN4SCtWQnkyZGl2aDRocmIrSGk2LzV3STYwc245?=
 =?utf-8?B?dHduYnhXeVh0UnhaYmVGMWZ4ZlE4N0lzSklYOTBtMXQ4M1ZicjRRNHMvZkdo?=
 =?utf-8?B?L1ZoVU1QZ0VQMktKdTBsWFZ0Q1doamQ2QUdTWmxBRVFJc1VEY2owRFNUY2dm?=
 =?utf-8?B?cWlMTlVlNUJrbk9DbmFhTm1BY2NyTnVLUHZwd1VyUlprTEg5TEJPczNsbXNL?=
 =?utf-8?B?V3M3SUV1TE9kMVYzVndIbm0zL0oySzlZT3ZYOElSd0RiWnNUMzVGRzRUQTFa?=
 =?utf-8?B?ZDkwL0pQU3NydVhMZ0tkbEYwU3hBaytrM3YyZEQreEFZUUFXR294Qy9NN3Iv?=
 =?utf-8?B?WjhvU1Z3UUU0NkUwUTloK0JiUW9nZG1uZDZCNm4yZEppcmJrcW9QMW9PTmFq?=
 =?utf-8?B?TERzNXZBS1QrTi9FVllVUFZuRWh2OGY4bTh6emhRWXNtYWZLWWhReThyYURT?=
 =?utf-8?B?dis1NE5QeDJCb2xPQ0JGeFNoNjJMS3JraFJtVGI5TFVxOEMrNGdMZGdBQS9l?=
 =?utf-8?B?cGlRa0NiMGV3R1BzWjV1TmFIZ3BiRWxVNHA4bWVPM0FlV3k0RXErV3dCZ3hx?=
 =?utf-8?B?SDdOckRnT1U1M0FhZHVraUZMckI1c3c5RzVTcTJtR2xwRitQVlYrREFNR3VN?=
 =?utf-8?B?enZMV2hFUUFXZTdlL254VFphdWxGSmxkZVNlVUpCcjlETmpNT3NKMGZEUlM3?=
 =?utf-8?B?bWE1TzVhVTBENERlK2pCb0VZQ0RjOS9LQUJLU1plQXlFMEhvVGZxSVZ3K2Rp?=
 =?utf-8?B?R2VHZnhrWWVqNWlqZGw4ZkpIaGVzWWxRcklwckpvdTNKNVdNUmN3Z3VyU2da?=
 =?utf-8?B?VEVBcjdBTk04dXpJRVZGeVBFek9jcDUvYytqYVVnbldrckNlM1BpWHNtUGI5?=
 =?utf-8?B?YmR2UDgxaGJpSk13VFVFczQ1Rmg0c1p5TTZWbEFBVVo5eENoa3JmZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f914c9-4d1a-4c3f-80ff-08df2ea035ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:49:34.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Itsv/uND4qiEqpSgWpvDBFROmNy7vQcd1J5INfacG5BcnMoxog2hv1i8XUzYLTkXHN9z4FkhnUgxz/nIjZ3ibA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019



On 10/20/2026 4:47 PM, Matthew Auld wrote:
> On 20/10/2026 07:06, Paneer Selvam, Arunpravin wrote:
>> AMD General
>>
>> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> Thanks. I assume you will merge this?
Yes, I will merge.

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

