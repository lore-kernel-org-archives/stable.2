Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A11227BB9;
	Tue, 18 Aug 2026 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787096811; cv=fail; b=bxS0VG7GVgVLZ62gAdIeBatdojmL6O4QkHT/q7IXQ+oBwi/AWGjZ5Kd3KKFwYuza6VuX/9d4ukkENfy6GekiSiTdbDMJIoPW+LfERp64krFgH5lBeMElFx9VEgnqofU0LAlJgLswkyJ8/XQ8L2sZau2a3LYRQt9NDpjCMtECWSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787096811; c=relaxed/simple;
	bh=CXMOcrRWkyaynT0f7e9744wLlvFU1NIfUj0xDupywxw=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=QfXvwBS2sQs0I3KQGGHXsKPn2Fr8ZKpcQt3u5ZFLwau/ekGx4KRnovDOsFiyVaqrCOU5YKqdESY6m3xohdvSxF9m7hBQ+gReId5w8H8OzZjm2fssffNL9dg8BniTDo8jPftNpkoZD4A7Krwon9M9MnIX2i39RBMnfIMGNUEuqOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=luem/KCI; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="luem/KCI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzy7U1jhFn5FnIP5AWPwZj50ucVWa3XnvsZjuVbUZSNtFjwakB1eyqqO/+4h8+I5s2/dYAGpB9bZQ+pCisCa0Xe4uNSQGAW/V1Z+XHMuLOdRMPfGgW4MwjyXm8DU9bpBamjIOKGgZseDDvaT+L+h1l6G01+pkxFwe/H0BM2ZVXAYxa03gPuwtjslBWvR09NbsvH9c3KNXp6PoE8XE9PkCXkQgGyX0SMUkQM4JxUjt3eiSC819c7aI4lsg2muiJhaEJiJYba1prjGFvNTUcKPanDXWDxKu2o1M/VMsUKRRZaJtfBY+JKj7tUXOTqYP6LCS+ShVf8BC67PeMHFEsrEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4CSNdBZgMN5J7D61L2Gh6JE+2Brbvl6cJLQySMl9HA=;
 b=IhJrKLG1NQN8C3CFa9CJdPF/AwmorHjT9oDxjxuVbqUY4UcMbVjTGpwLDI5odRUWq0AFKutKC0g6ywG6BwA1khiutOARJdKhumyE6oqQx66fppEGoCttI3URBNqd4J7bH/MGA1PCaRor/HS8qPp3cNwqErejO8oPVrXqef1uWE0hfzGw3q9t8YvQZEunyJgGtTyIbWvgclSZ/CixqESyhOoDIfz2WIp6dQy7rU1Wwsc7SOWx8gAffV1HaBb0HWjjPSXairGHQhiLgqG8LfUZvt/oZZCJhkkG3bEuZvhFWu+VqTb1vLp21qfP3rNckN4UlnYz+TXzGerH/BeHQVAB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4CSNdBZgMN5J7D61L2Gh6JE+2Brbvl6cJLQySMl9HA=;
 b=luem/KCI0/Rlk5oAIycEr7GzTQeHOdxYuAEczC1WpaH7YgrFtEd63NR21FTEvUCAT0SV9J5UJ7Nl+yvpb7eTe0vxc0uU6/gUQOY2naLH8OdOhWbDpKwNg6X9/hIN6VAZDNj8l3+YRhTSDQlblotr2LGJPZk8pwwm4rTZBE+NRFrsf0TeFyN+YsJh5/2CjgieJY525/wbqMxiCqE+H/bbArFECuz5agyRXHI5cXRGTtIeEgXJe5484f0nGLvHcOwOW3BZbTg0yTJSh0nzOGm0A5IiIj1YnpZRfwC6cFpeUgyfVNWy2LjbhVDAW9HZy+4O4NvmaeEx9dpHtJ3e/gEs7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 23:46:46 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 23:46:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 19:46:44 -0400
Message-Id: <DKSGY288L1AM.3S7CDZZ3AAGD@nvidia.com>
Cc: "Vlastimil Babka" <vbabka@kernel.org>, "Harry Yoo" <harry@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li" <hao.li@linux.dev>,
 "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <syzbot+805630f1453e490427fa@syzkaller.appspotmail.com>,
 <stable@vger.kernel.org>
To: "Alan Stern" <stern@rowland.harvard.edu>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH] mm/slab: reject unsupported kmalloc sizes
X-Mailer: aerc 0.21.0
References: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
 <3ec57a22-3096-418f-b10f-b0993a352007@rowland.harvard.edu>
In-Reply-To: <3ec57a22-3096-418f-b10f-b0993a352007@rowland.harvard.edu>
X-ClientProxiedBy: YQBP288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::12) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c050a47-3303-499e-9b9a-08defd82f6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|56012099006|6133799003|4143699003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	rkgWzKQr52ThyZfL4PriC/tkHkUr6JmCjwhZsCKfXKp5o1wHj/Ky1+z11cNMg7E/qZfo5H0aUipKCGPmXRx7B3XSfoYRhE/nVwlOvqw/HnzRsQ7u3Z5lN+tCGHq2eOmrThWIpoJjQG6YfI0fV3zm1E8+am+5W5PP5/9LZOzvU+Eu7XdKEh/cY+lGDYi8E7ol7HefL6VHMbtlfkMqkdQCuqQXoMXUXJcQVmrT4WPvrSuuAl3FefuKgI1h/0K711oHyM0PXat7kEqEI7+24zsoO2z7ILuRU9A/g7zwhvi4vlrogq8fY1XARirynMTLspe8MT95Bu9/ehT3u91xROlt/AFCcbEg/eXCyq+Y34N+QJbiU9W5+w2UuaZggwxHBoGIMSTr3IbxyFKi3Vir/JdSI+GgQJZUjRqDyhL7M1TTIiTZXfsF/nb8q24t698CKAD4vt9CRz3WEzfoYnyfFYLMsqM/Bw+OML6Hk6X2uz4OMslTl442E+L4wiMb0p4IgGSpexLeQilm/SHuhoRjapYWqU3VAHWtSmU/xqTlnxEJ5jelJZfLAgpQe7L0ZKH2wOQmTOmqgNjsqOQ+i7AbVUrWzUkXFxViAV0oonOASXhauBmnhIJ10ywHauE6jZqnZbGYo/UnKf9DwadH1PEgLuMjfxGp2RqPh24Rx3YVZ5fCFOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGdFZ3d2bDZ3dU4wL284cHFWRFB3UEYrdndhN2VpN2NxM0hRMTQvUkV1cFht?=
 =?utf-8?B?QnBVZ2tQU1hscFUzak1FaUhWUEFZQXp0VFpmQlJjOEdkNC9MMkE5SEdWUXpr?=
 =?utf-8?B?Y1ZUYTdzVjdkajVTMzdYa3BveEQwUlV3TnEzdDVOMHo0V1lxVnZpemRxRS9J?=
 =?utf-8?B?eDN1QnIzb0xGeTMxWUk2aWZUUFQwbXJyamJFV2dibEl6eVJKcEd1U1ltU3U1?=
 =?utf-8?B?QkxBSTF0RHRickpLZ2NIMHlDTGNzZmZtU3g1OHNDVkNjbU4wTFcvWm1UM0pN?=
 =?utf-8?B?Nm1kV1QwS1lFdUdQcmNYT1lEOFZnZkNaRDlOTHV3VzdMMHdTU1VpbWd3Qnlz?=
 =?utf-8?B?R0ZrK092UXNRVVMwb3BtYzk3Ym1wVjE0cmdPUDdxYkxSMDVFWlVJR0ZmS1dL?=
 =?utf-8?B?VTBTQlJSa3k0L3FTTERZanlUREdCOHM4UlI4eEhHQzlYU29zU2RoaVJJL2NV?=
 =?utf-8?B?WXFENmFXK1pCU29pbW4zUWp2OHE4VStXL1lZT0EwZm5MbWViSjRMNzlScFha?=
 =?utf-8?B?SXVMcUxuSVFMWkVuVW5tY0dNdlp1Qm4vRmxPL0czdUZJSWhBbkF0K3ZWTEZm?=
 =?utf-8?B?UGdhODJ6VXJ3NmxQSUJ4OXhGMVdMVmdBTXlhanlMNGY0YjNYMU9aVnhUUDVC?=
 =?utf-8?B?cUJ4U25BQzlQWlN3N1IrYlJQWGsyejlWQitOUVQrRE9WcCtNeU84aDBDQngz?=
 =?utf-8?B?WjhXbUlyeG53WktMYkhBSWh3K29FTjBGaW9PR1lraFJ1OStZMmdyK3VLRnBx?=
 =?utf-8?B?WkN2OU5ieFdQTm5nQnBEUmlBOGg4cnY1NHkweG01NmJMS3ZWbEFkdG5VU2Y1?=
 =?utf-8?B?bVU5Z0h6RWg4ZmJSblUxcnBEcFNkdVNFNUozLzE5NHlFbCtvSkZoTnc3MThl?=
 =?utf-8?B?bG1hTTNCOGVINEFxY0Z0T1R4VG9iYTJBdUVqcHpoaXJPSHd1VTgrbHB6UlQy?=
 =?utf-8?B?UzM0NURLUEpYTkVMSXNsc0VBZlZJaDU4VmtwYW8xOE5qdVE1Wk5zcnlqSllR?=
 =?utf-8?B?MFdOUlFqM0lnd0E5d1dIMjB1amR1b2k0dGxYQm1uYUdoRURPZ1lTVHBzZkM2?=
 =?utf-8?B?bEFRa05aZCtPN0pHbVBJU3loUmZycnROejdkL2J0YStOdS92bkZ3RDUzbkFr?=
 =?utf-8?B?NTRsU2R2bm9wTGprWHAzMVFuZmxCK1l3NzBsTHl3c0xzNFVWNktvRmtSQk9h?=
 =?utf-8?B?SW1qRnlSOFZBUDRJbU1zdHR3OGh4WjNSdmNXN0V6RGFZakx5MjFhc1RqdVRG?=
 =?utf-8?B?eE1qMzlYUmh2WlNVb0NmUExMbll0ZXhiMzZ2dDV5Q2J4YURObnZFekRVRDVi?=
 =?utf-8?B?UEt4MFoydzg5cHlKUGZxdTNwK3hOQ0xhNUZjSFJVYXRuTXZMS3pZakJpTkNB?=
 =?utf-8?B?WlpibUp5SHN2bmgyYzMxQ29oNlF5dEpDVWlNc3orZVF0VWo0bHk5eU9aQ29W?=
 =?utf-8?B?QWRhc1B4Nmpncnh1Vm51Z0oybzVEOEZ1TExNbXAxUklJZG9RSTViRFVZd2Q3?=
 =?utf-8?B?czdJamt1aXllampLemJlYm5CQXNQZFkzdFo2cUVVMlluZkJoVjA5OVF5QVJ6?=
 =?utf-8?B?Z1RRejRUdDlGSThyaEM3WTNQYXQvZHpqWWNOa2hKbFRsMHo0MTQwOCt4bWk0?=
 =?utf-8?B?M1lTdGs5V0ZvNy83VHgzT0tJSEtZeGs1cEZrakdVSzFobDluenBpQllaTkpL?=
 =?utf-8?B?NmZvaHA3V1NqdUtRNzVaK1BFVGxXbFptZzVXL1h0Zmk2TEErTXh4RmlHNUxs?=
 =?utf-8?B?R0RmV0htWjJrNCtUZ0NvdW84MEhRenFKSW05K2RkM2ZVdGtXb3ZXd1lVM0Ny?=
 =?utf-8?B?bER0d0VSQnhIS29mbFhRZ0tSUThOM29yU2k4bGd0WXhuWTRvWkViTmx2cUJF?=
 =?utf-8?B?aXdhNkdVd3QveVVWZUwvR0wyUjlZN1ZkejZBbGp4bSs4QjJVbVpZc1pORUh2?=
 =?utf-8?B?TzdnMmRnb1dzaWlxbHc0Q3ZRdGg2cGY3SzFhNWZsMVpKZTMyU01obHRVVFF1?=
 =?utf-8?B?ZnY5TUtEeDEyTS9yZWV3TjZLa3ViaGdtMitVSUk4cFkwelBCRGtaQnN3elJX?=
 =?utf-8?B?UlpYOTQxVXByNmZ0a1JETUdCbFpMbHBNcUhNcnliSlhXVi9zTmVNWkM0MXBm?=
 =?utf-8?B?anVlK1NNaFNPU01MV1FuSHREZlVkczdONjJ6SXRyYW5TSVhzbGZCNzRSMjNz?=
 =?utf-8?B?MHNpbWZMSytycnR2dFBNNDNIemt2OHdrZHVVcXFhOG1wenQyakxVZlhkQ2Fj?=
 =?utf-8?B?d2hwaGNuMHRPeXRpRUpUZzl5cHpHVnBIMWh6ZFZZTTVocGFhZnorZmpCTWNt?=
 =?utf-8?Q?sdXx+/cVi8+HHzwQwK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c050a47-3303-499e-9b9a-08defd82f6c2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 23:46:46.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZpcrhwhwWIAvrSo5494CoMKdRiz8WsAzrzG0w6R2gmk0xBjpDjAWF66WH5aiaZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835

On Mon Aug 17, 2026 at 10:59 PM EDT, Alan Stern wrote:
> On Mon, Aug 17, 2026 at 04:40:18PM -0400, Zi Yan wrote:
>> kmalloc is used to allocate physically contiguous memory for kernel
>> allocations. For requests larger than KMALLOC_MAX_CACHE_SIZE, kmalloc us=
es
>> the page allocator and can only support up to KMALLOC_MAX_SIZE. For requ=
est
>> sizes bigger than KMALLOC_MAX_SIZE, the page allocator can emit a WARN
>> because kmalloc allocates an order greater than MAX_PAGE_ORDER. Systems
>> with panic_on_warn=3D1 crash because of this WARN. Fix it by rejecting a=
ny
>> kmalloc size bigger than KMALLOC_MAX_SIZE.
>>=20
>> Fixes: aadb4bc4a1f9 ("SLUB: direct pass through of page size or higher k=
malloc requests")
>> Reported-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/6a820ebc.9ebadd4d.20b15e.001b.GAE@go=
ogle.com/
>> Tested-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Cc: stable@vger.kernel.org
>> ---
>> It fixes a page allocator warning (order > MAX_PAGE_ORDER) when gadgetfs
>> requests excessively large memory from kmalloc. Instead of adding
>> __GFP_NOWARN to suppress the warning, as was done for usbfs[1], change
>> kmalloc to return NULL without a warning for this specific issue.
>>=20
>> [1] commit 4f2629ea67e72 ("USB: usbfs: Don't WARN about excessively larg=
e memory allocations")
>
> Thanks for doing this.  If you like, I can write a follow-up patch to=20
> remove the __GFP_NOWARN added in 4f2629ea67e72, now that it isn't needed=
=20
> any more.

Sure. Once the patch gets an Ack or Rb from a maintainer and Andrew
picks it up, feel free to send a cleanup patch. Thanks.

--=20
Best Regards,
Yan, Zi

