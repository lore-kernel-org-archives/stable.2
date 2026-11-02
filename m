Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793647167;
	b=5DwEdCwc/BOtMRBmQf62IJddAA4Q9lW/WuuuX9YWYi4rN2y75LrOOUtp8TMUH9GaYJi6
	 271hMhclYSFlDLhCCiNVaT4jquw7fJ8Y+Tl2Q4v8hGnF3gr2r4GNPvnCKxiNqxEWYDz+J
	 R6hDWkuevhFJpocAt4g/KVUopZ4c5SKHYOiKjIY6Gm+LKHx/U6Hd7PQ+KpTa0fum9Tx7V
	 NRspyFwRb2NxTvJhkiGw71rGSZ1rYCYqA5X3EcHfP75o6eUrZnAWHRWBmEtS3rbsS7sig
	 lICTmZF8ErGtG7436IsQneXEL6glE7n01fPI/lZiZO2xdfa3GB9Hmj9fkzfVNz1KZug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647167;
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
	bh=rFSxBWUyWD/Jw5BtxHIA0Vj7XnWhnkBjvZImOmimzZY=;
	b=XxgfxGcUBCUTn3rugPq9lOnwi7756Hz3f44yHgdysi8Mn7gCH0vh4Q/SB2NekAzlwLM0
	 0TqK3HFEk+GM9M/V7lqutOpuYTdVgCDCaWMeQoiTan9LdAZMLpRR2bHaqALNF7J4IoLpW
	 X+J9GYTfr4LHWB5UiiTsNGu16LJrqtypqF5Qz6rj5o0IPdiuUQ6yDGpw0/nmUSBrKe6AR
	 JvEFzrfEg4hwYSjaXWjp/Lo6Wbk2aZsKlToXMcuFYPCx1yOuDMckaGZbUUAhIJYQnXfFs
	 gSW0mMj80e6ZzY+uUZf2ui2uZfaW7m/yMheJ13gxmtGdwzyxzhD0P57Tmk3orPzv51A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QAT6mCfV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.0
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC484606A324;
	Mon,  2 Nov 2026 19:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC484606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QAT6mCfV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDlYK/fOuTlhtchg8WV6OsELcPSFbkhKsrsYbv0ftUro28gEo2j7+9y0Yv3ABCsYf/LdrcBSODPtqzKijkL71aGOwKOLRk/TYo3yO18Rtrnrfp7uvCCu6Fo0Gw3fsjJCB/zIZhg0CCmtXa5yvu1rjvYkUW1CN++P0B1Z+Ml7j05FXB9QWSgnH1e2+4kTzVOEpS96RSNhpuwZIx7op9/rPZqyrPZ4vbARvyGMG9BbdS2DjO+aFlmqEk3wj5dOIEXuJdCu+a8TGIpNxyPDUNRSgwOfXjNJp7qCsPoFqtxb6wjz34t90w7VUksCqMFLPxuyq1J3xrkhnzDNUorjzYWHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFSxBWUyWD/Jw5BtxHIA0Vj7XnWhnkBjvZImOmimzZY=;
 b=Hk+UOBQhj7q0IIJay3WXJxn3YuLbVvvAf47DIds+8LBv1XoF+WOsNFRtPq2AyPSzaLQXUhCuc/M5ksRq+xpdLhuVFtZBZyRwC1h4q/9hslMP4L/VErt5Och+Vlh26aE8YfRqnQbnJ7quPItlzCuYfaMyXJj3ZBY3gYWHQgd/B7yMsNvMCXREofZilPICRjGMmrXiLLU4vnoFjKocsN/Mje4eoBNxNBOrCoDlEmdzk5sCDfhp3qJv9own5Iid1wXVXHasyckCi6G/VcwgylotRgG+FdebaSUPVsFkf/Gw+gMtobrePFjICfB6y/Rd+dTHtTSxayyxs1dUUtEguVbXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFSxBWUyWD/Jw5BtxHIA0Vj7XnWhnkBjvZImOmimzZY=;
 b=QAT6mCfVBu+sps7RSOtdDbGqL0NmmmFRYhomCaqRuA7mz4XJ49S4GaqbuAz4H8HQ/SLmUpNvqc5hADeWXQgGKqPIAls21KBh6NVSuELWw30r8GIhph8Jj03Bm2pD3YMZQHugCsCmHuCPCamrulxQ4Cr0bKgdw9onngYHhYokzeA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:19:22 +0000
Received: from LV8PR12MB9133.namprd12.prod.outlook.com
 ([fe80::d29f:9915:159b:b02]) by LV8PR12MB9133.namprd12.prod.outlook.com
 ([fe80::d29f:9915:159b:b02%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:19:22 +0000
Message-ID: <6df15eda-d160-4f61-8cc2-34e528d70764@amd.com>
Date: Mon, 2 Nov 2026 14:19:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: amd: isp4: fix self-deadlock in
 isp4sd_start_stream() error path
To: caspar.adriani@proton.me, Bin Du <bin.du@amd.com>,
 Nirujogi Pratap <pratap.nirujogi@amd.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Benjamin Chan <Benjamin.Chan@amd.com>, King Li <King.Li@amd.com>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>,
 Yifei Gao <gyf161023@gmail.com>,
 Seifelden Abdelmonem <saif.elden.hatim@gmail.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To LV8PR12MB9133.namprd12.prod.outlook.com
 (2603:10b6:408:188::15)
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9133:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: b28e9d1b-4bfb-4bab-2819-08df39163366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|3023799007|261102123227099003|56012099006|11063799006|261021123027099003|261022105027099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	gGzK0gYBuD+LMT+2HSAYOhwmCTjKI697MTpwFHxnNlUY6f4DgpKxxk3NCfW+ufEp0gq6Oxlj3+dq8qaPwqiz6mFhg/9OiEjX42WuSWx1E/5ckYlHgLGMx1MCgLBuScaYrPb2AqPmTkjr1ci58brqAMERF97qYmc3+hiu63CQDGcCs7V8E0GUyGM1F/StUrXIrpXzTW+e1LCI3+yZXjC1QXrEQUXohywWlsPFWStMvosw1LfmztbnxA1oKCpkoywaeoepHlooGRRlPp42siMK+/waYq1vNgBGb0rMhc2XkOeukluTVQgcsrA8I2zd3zT6CWxooBKGRcGpKUasEoxRU0Zg/ArYpC7A0zASs3QDVTSzPOCkbxA+zFCNzr89VPttJTagujMznr0OA5mxkqV88NNXj7XUCeEP2Nf99o9fpBdijQZiQCw1iWodChoyuGJco5R/qJBYp7b5sR4ng/yeMa5msrlzD7DcETA4MD0fYmlOD6e1B4939uGY7lmQGGM9XJVAdyZMVvytx3gmxIC/76Po3uJvRL+l0hVfuc37gN/p/ZWAuORDN68lX8z4qvzMHTCPEwbns1qGyCAgZSwrv/FKYbJBCgjIUFKm+95J2sVNoN100552vblesqIXRBV9YwLJp4RkWin4nwXy4J/FYolD8yL0xQ6sciTPgNzkgSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(261102123227099003)(56012099006)(11063799006)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Lzg5TDYrUVdXT1ZDdDd3dVJGTGxVRnRBdEQvaGU0M0dMeS9DSml3QjF5ZFFq?=
 =?utf-8?B?elY5ZFJEM3ZqL0VIY043UG9YM0NXN2RhQUl6U21kaDYrb205YURxTWlPUFdF?=
 =?utf-8?B?N3Q1a2NWQ21YRThKQUd1MmxJaURYemUxbm02bWRVcGhVb00rYlZJQlJHbU83?=
 =?utf-8?B?Z0lhMTdXUGRkRC9GQUJ6T0pURlYyS2V6SHlPRGJXNjhwMWZZcUhnQXV5L1ho?=
 =?utf-8?B?eFFKTVczSDNuOXM4eHlQVVNheGFaMkhwWDZwMDZpRXdhWUNQdnFmOE9jN1o2?=
 =?utf-8?B?WTNlWm9ySlNHeTZSSTI4VitkTFJCTjk5SjZKODFtbVNxb3pQUVJ5TEp4cGN0?=
 =?utf-8?B?Wno4Y1ovdjV0SU1kejVMWXFXMENld1dYT2kvM3dWZ1dnZkszSkFBc3EyYm41?=
 =?utf-8?B?L0hDNG91OFRvWFZzSTlESHk0aENXSlpMWXFVTE5oZUpESGdiYnlKcmI3ZXhX?=
 =?utf-8?B?aWx2ajZod1BiUFdtR0Nldm5UTkpBbGR1Nm1oaktHMUdTKzhNdWhIc0M3ZmZM?=
 =?utf-8?B?d0cyVERkZmhQM0VyMFU5MUh0QjBTVXo4VGt3Z1duREZSYXRrVE5KZVlKNjdR?=
 =?utf-8?B?NGliem1VLy9zZVRzMCtZRUlESEJCVlFYTGVYRWw0dkRWNEZvc3Y5bGx3Z01G?=
 =?utf-8?B?VzRGZVg2czZUYU02TkhGd0l0UmZrSnBtRU4rZElSdWNSOHgzalZvbWpKZW04?=
 =?utf-8?B?UUowNmVJWnZuVkxrWTVZbmtMZkUvbUxoaXhuNEEzaVF2WkpjUS9JM0dPQ1Ay?=
 =?utf-8?B?RnRMM3hpeVlXNHFkc1YvS3BFdUtwNkxEa3FjaE5rTlpDS3NsZWZQakFYWmtI?=
 =?utf-8?B?d3BNNWNKNzRTQkVMSmFkL2M2b0JsRGxFbUNzb2lLR3dNZTVQV0NRREZXR09H?=
 =?utf-8?B?STAvRFZRSi93M296dU1ublppT29OTkpzSE1KbzZVVkRVaFVPV2RpbDJ6alg3?=
 =?utf-8?B?WnZDSDdzdk1vWnNZTHdFQ3dqSDUybzBWMTZ0VXBhNHc4MGUrZDZOOEIxVVNW?=
 =?utf-8?B?SkFXSXRRUU15dmZrTGpYbC9Td1djeDFnZEd5aVdzTVRISitIYWluVi80NlJz?=
 =?utf-8?B?dVgrVGs2TEFkSlRJRmtuNVRFdVBHTzBTMlA0bk83bFlld2wxWExzdVJsOXE4?=
 =?utf-8?B?SWZITHJZRHdmUnBsOXJEMmNpelZpazBSQW1LL1R2dTZiUjQrbFcxUDVlaW1E?=
 =?utf-8?B?Sk1rdDZxZy96UlA4c000ODRNbVUySDgrNER4Rml4UGRweWoyTTNDRVQ0bVJz?=
 =?utf-8?B?clpIUXZWNUsyUGR6alVWODhORGpQVWxZTHIxT0VGbkc1ZHBNeStGQVliN3NJ?=
 =?utf-8?B?Q2ZzVU4waGUvWEw3K0tka3hmWDFuUlhjVzUxVFZiMjl6QXRNUEZYL3B6cmhH?=
 =?utf-8?B?R05zcHV6NzR0akh0ZXVpYy9KUDJnVnBPSmpFOHdZaDRVTDU4dHZiMEtaakhI?=
 =?utf-8?B?KzVwSHJsaC8veGZraDVJVHMzY0w1U00xUUlxQVQvTENqVmU4TEM1UUs4VjJa?=
 =?utf-8?B?WmtwZVJQekJzcURMY2hYMEpMYzdUWlZEWjVKdTM4VWdTbmlCV3FwSTNiYUhz?=
 =?utf-8?B?cmxIREY4RnpaRG05S01wNlUxbzlidnpuMThqSXhsd2k3SWMrZlhtTjVCbC9u?=
 =?utf-8?B?R05GRXJ4N0ZGOXoxcTVWWjVFRW0rRWRPTFhSSDI4QjVBenpiVnVjN2RKZEpn?=
 =?utf-8?B?UDFaTHhWeWN4UUt5NFY4SzRIUXBTQVd5QjRDZUhUZkdTbHl1aEo4WS9lNEg5?=
 =?utf-8?B?eDA3TXhEMGZCSnVITUFhZzVmK0VLb1F5UVRTRUZsc25wMS95WDlaRDBaSHpt?=
 =?utf-8?B?YjQ4R0IzamJiZEp3MmQwK1poSXFSQ2hBK3pld2wzSmNFMzRsUVZWSUhkcGU2?=
 =?utf-8?B?MzNtejZHTFNvQWowZFNUUmZKVEt4YnpDOUhidmJyTmtnQ1hkbHdpQjV2UUtO?=
 =?utf-8?B?RDFFLzQ1T3BVdmR0V1BtZnhrVmFqOWZ3cXJXeWkvRzNNQ0VYQnRoR3FoUE9G?=
 =?utf-8?B?T3pDR2tMalIvWDQrelpyKzFqOGkwOXRoS3JvUUh4TnVUMXU4d1BQY1owMEhJ?=
 =?utf-8?B?Und2a0IrTDZyNGs1ZUQ5K0ZwVGorTlhCSVY4YldmbXczcVR3bks4OTZqdlRY?=
 =?utf-8?B?eVcyOEFLWWhRbVBROXNkT1MwQjFFNzNveGdVR2RCQThKMENKVGVPbkw0MmJq?=
 =?utf-8?B?SEJ3blFRa2ZWR0duT2pVMUMrLzZaVXk4akg0d1hrb2tHUHF3My94NnhzRU1J?=
 =?utf-8?B?cW1DY3pwNDVQcW04OUd0M0NaSFZucDAxZWhYTmErQ21ZdWY0N3E5REhCYlUy?=
 =?utf-8?B?VVdpcjJkNVdydHBPNDR1bGhqV0V4cFZqYmlGSmZldlhNWFFYLzRLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28e9d1b-4bfb-4bab-2819-08df39163366
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 19:19:22.6180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RbXiRZsSc+mDQbQzQ3D2BHqMYbUUhUNSuLgO2UhCf0Ror50TN6Ru44sx0/hyJpWCZizHDJK5xQFu1SnNsZAeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172



On 10/28/2026 10:05 AM, Caspar Adriani via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+caspar.adriani.proton.me@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Caspar Adriani <caspar.adriani@proton.me>
> 
> isp4sd_start_stream() takes ops_mutex with guard() and, when
> isp4sd_init_stream() or isp4sd_setup_output() fails, jumps to
> err_stop_stream and calls isp4sd_stop_stream(). That function takes
> ops_mutex again, so the task blocks on a mutex it already holds. Every
> later open, close or ioctl on the device then blocks behind it, and
> only a reboot recovers:
> 
>    INFO: task .v4l2-ctl-wrapp:38440 blocked for more than 122 seconds.
>     isp4sd_stop_stream.isra.0+0x43/0x1d0 [amd_isp4_capture]
>     isp4sd_enable_streams.cold+0x8b/0x26c [amd_isp4_capture]
>     v4l2_subdev_enable_streams+0x1ff/0x360 [videodev]
>     isp4vid_qops_start_streaming+0xf2/0x160 [amd_isp4_capture]
>    INFO: task .v4l2-ctl-wrapp:38440 is blocked on a mutex likely owned
>    by task .v4l2-ctl-wrapp:38440.
> 
> One way to reach the error path: start and stop a stream, then start
> it again without setting the format. isp4sd_uninit_stream() clears the
> subdev pad format on stop, so isp4sd_get_str_out_prop() fails on the
> second start with "fail to get out prop" and "fail to setup output".
> 
> Move the body of isp4sd_stop_stream() into __isp4sd_stop_stream(),
> which expects ops_mutex to be held, and call it from the error path.
> 
> Fixes: 4e5e7a7ddb4a ("media: platform: amd: isp4 subdev and firmware loading handling added")
> Cc: stable@vger.kernel.org
> Signed-off-by: Caspar Adriani <caspar.adriani@proton.me>
> ---
> Tested on an ASUS ROG Flow Z13 (GZ302EA) on v7.3, with a local,
> not-for-upstream change that adds its OMNI13B1 sensor to the ISP4 ACPI
> tables so the capture device is created. The stock firmware does not
> support that sensor, so no frames arrive, but the start and stop paths
> run. Sequence: v4l2-ctl --set-fmt-video=1920x1080 NV12 --stream-mmap,
> stopped after 10 s; the same without --set-fmt-video; then the first
> command again.
> 
> Without this patch (v7.2.8, same setup) this failure hung the task as
> shown above. With it, VIDIOC_STREAMON returns -EINVAL after "fail to
> get out prop" / "fail to setup output", v4l2-ctl exits, no task is left
> blocked, and the third run starts and stops the stream normally.
> Not run: lockdep (CONFIG_PROVE_LOCKING is off in this kernel).
> ---
>   drivers/media/platform/amd/isp4/isp4_subdev.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
> index a108d90ace..08512f060a 100644
> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> @@ -745,15 +745,15 @@ int isp4sd_pwron_and_init(struct v4l2_subdev *sd)
>          return -EINVAL;
>   }
> 
> -static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> -                             struct v4l2_subdev_state *state, u32 pad)
> +static void __isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> +                                struct v4l2_subdev_state *state, u32 pad)
>   {
>          struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
>          struct isp4sd_output_info *output_info = &sensor_info->output_info;
>          struct isp4_interface *ispif = &isp_subdev->ispif;
>          struct device *dev = isp_subdev->dev;
> 
> -       guard(mutex)(&isp_subdev->ops_mutex);
> +       lockdep_assert_held(&isp_subdev->ops_mutex);
>          dev_dbg(dev, "status %i\n", output_info->start_status);
> 
>          if (output_info->start_status == ISP4SD_START_STATUS_STARTED) {
> @@ -786,6 +786,13 @@ static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
>          }
> 
>          isp4sd_uninit_stream(isp_subdev, state, pad);
> +}
> +
> +static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> +                             struct v4l2_subdev_state *state, u32 pad)
> +{
> +       guard(mutex)(&isp_subdev->ops_mutex);
> +       __isp4sd_stop_stream(isp_subdev, state, pad);
> 
>          /*
>           * Return success to ensure the stop process proceeds,
> @@ -836,7 +843,7 @@ static int isp4sd_start_stream(struct isp4_subdev *isp_subdev,
>          return 0;
> 
>   err_stop_stream:
> -       isp4sd_stop_stream(isp_subdev, state, pad);
> +       __isp4sd_stop_stream(isp_subdev, state, pad);
>          return ret;
>   }
> 
> 
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261028-isp4-start-stream-deadlock-6c33a97d3297
> 
> Best regards,
> --
> Caspar Adriani <caspar.adriani@proton.me>
> 
> 
Reviewed-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

Thanks,
Pratap

