Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793326149;
	b=dzvB3zmfQ9o4NsAyM6TkYfKqEBa1yu7did3L+gbJgmT+6CkvVKg5YiyFw+zog9oe0PY+
	 1BDHsIkzeo0cf6fNC8pMB3V/unpZpWrWcZpWY0hnenCqW4y0hQwn8ikotsdNaGPFsbzsb
	 Nmqq3easxcHYW/euGwtTy19ej5Lxmw67cAtvqzQ+7/x9GfSC8jvYEkG6mxRl2JKk4TBKd
	 lPze33gatKooGbA2AvyB3M3GpSu9+TZv1h7gRCi56WYAZRINKGL1dZj38XXT0sNi8Hv7O
	 HfIFUK/nbAE5sA3gBxR82WOHNK2CH25mSa8IMaSykLjyH01iWgbODLkwx2XK635987Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793326149;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=Fs5lxatRcHniRo7WEmF0RBJnWapdF99b8ZOlitQHlZM=;
	b=FRuWvVnefoKTBSgAok3YqZKKUkr3rse8bSJ5a3MMvsqNXQKIxc8mFdV/hz5us/XNCHuz
	 9tO0qkeEv/S8g2c28FXXlaBq/i4DNhfWbXUWFVZlHs+DzA3PqpWyQgA3ahaQKbMO8jJXK
	 el6zsGUnIGUD7OPBBVXV3lghK6d9LFeymIzd1QREHoJdpn1/Ks3J7JAKfWf2ct+uQyX+c
	 gE5P+6e5R2audTb3PmtNAYttHo+jJxls3pxv8lRYs8YnNniYLrUB9T4rqRWOyxwFi/uFf
	 9Kl2UVYr8r6XqubgrDK+lMY+vyNjfZuWSRjZPM7ewJwPB1VgeL/pA6NhDVFTak3wlNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DBFdgPnm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.10
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985D606A31A;
	Fri, 30 Oct 2026 02:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5985D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DBFdgPnm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMQ/lVdWAn5TWAvjBhWyAsejuYzVYxnY+qCx1pTxf4F9dzEMokvPJmLl94z0qC0r1cZckiRSRlgJPELEA6nrk2ntTAhkM27DJkTGM4HrrbniQ0L8XDwNNF64KwT0Sh5MG3sI/XVbpLpXZRJ3sV+/JPiE4T5vtmYaRSBAhlZbAIg2ZlFgnUfWdP0iDVULCWvxJRUURzLnprrNiEaWivIm7dM4irR+mnCTAoU5WQMzWcb4AhIATmBU6NuHfahV31kK4+9fr7nOPwC3PTdjFSfQC5LJ71uRfNR5ZeIwSpTXom4wL5WQVl+YTINdf48QGWrvmBMhkQwFUlSJyqK6sr4fbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs5lxatRcHniRo7WEmF0RBJnWapdF99b8ZOlitQHlZM=;
 b=SCu520/StYn8+sEkuOuQtlpGuBXDiznyxOYUD4II+R+08hAYRMsHNrMYwM+VkRv77lMVZFyfH6yjK/yV1Qhyfi9QC1Q/R91X3royqHDheTiOBKs7myPDI0rC0MQFUgZdXsJjtXmVxBcNN2Kq5U9LxqPc0qX6Ialo7SMqYMogsGto0p7uxtWIOnfQofSpZGVoRpgB/yoL86lQFSYnqNCfhUJIrz8YPOenRes+gK0M2g16SM5t9popMqMcen1eWbOUJKTgeC7M8QM1unjqvfjbb8KI540obsLW+mxZhAtXTId0INDhVraz23Ang/FOmL+6rPf8g0X6XZRz9A+VOvu5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs5lxatRcHniRo7WEmF0RBJnWapdF99b8ZOlitQHlZM=;
 b=DBFdgPnmUkgjwDrVVXxeYYiRznh3qlJo4ZPSzsEFEBr6RaQPzs4K1LVGoDM84+0vVV5qwxheOH96Fdg10u5Ezq1dOOTn+q5G/E/8uEJ31ipFXWREZVOrnr9mKEA/RJBsw8vM6MK+Nyhj8Y20DxiQxd5Npk0PnKT7AyP38X+2PP0+jYRpU05CwhbNlN8wscWZ9KOtNmMP/eO2xvdIp+bgAzGY+yEc8bKk29/TZVLizgzHThW+gh1NvJ0GRa/q83LBP8fbn/WzGJn+nYTEttEitrnUKohhP/UEIHsHuOKDxnwTHlYBAKQjtfy3GZfCyzqA65t4OjXrhIr+XBiVlDuXeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 02:09:02 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.007; Fri, 30 Oct 2026
 02:09:02 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 29 Oct 2026 22:08:44 -0400
Subject: [PATCH] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fix-split_folio_to_order-race-v1-1-a483c7451b0d@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORvoenDOVxEpXZdqZCwjqSKMv
 fvqPH6H/1/BSJkMrs0KSh82lrmiPTWQnnF+EPJYDd75c+t8j5m/aMvEJWSZWEKRIDqSosZE6C5
 d9LHPQ+4S1MeiVIPjf7v/be/hRan8prBtO14PpjaBAAAA
X-Change-ID: 20261029-fix-split_folio_to_order-race-087a2a9fbf7c
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: YQZPR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::9) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 5783cb9a-a279-4bdf-6829-08df362ac4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|366016|261026121527099003|18002099003|921020|261021123027099003|261009223027099003|11063799006|10067099003|261021121427099003|56012099006|261022105027099003|261022075727099003|260925021911599003|261028144727099003|260925022911599003|261026140227099003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	f2PAmFrhXZkpVsqXfGs88+3GItkmBJZgMNFVytbGDwnG3nZGQRyqy+mjsrnh3Zj5oVGf64HTnMEz/1JJi+qmdnMIdDaxp7jGEU9hylYAP/4wUeXsR9ceztJ3VXnKDoMlrpQwxKSz22T2MgOiypjU1bLmyjkW3BvgseRb/HHPJWoNFldm+D/HQxgbVBTA0S/oc+MJF6GIUJV8eEf5S6acnHcf2HB55ly7HaViFw33ntF2uV++6hKhGDNGv/N94W67Y5NWz+/NqMXew+CZbbq7d38mDFUQSsau8lZNCvHMCyMvsohMcD17yD6Y79oUTIt/pBan49btayk+2FDn/4GefCLIFjxOYDbIj6J77I6J8+3SyeHT6V4L5484gaHUbY9ZoQdEmOwSmpuQ2YWazICbK3JjsPG+kGj9foH+g3WJa/jEB2fLwCOkaNMq3nROV9dsVQvPtiDweKzmVpIDEbSbCI9YD+7lzO2EeucnxT3C9sg41iGkas/JbXwYsBjM4jPWEA1BkgGLfXADMm5w1zJwJK45KxzhqomE/QyA3AHkWcw67eEpOR5TUNAcGcqYQWq13er1PCngmOu2Iw/TWeMKCGNHr0lU9TtJW9rEycuvOHRbeOBTYWb/+DA/XwzE37+e378yjDJVKM+BZSJMh9HOkjssY0X/nkQlLNy18FKQxKnVwBNdmbHDkuznKsAdzetRWJmlNZjy6npc6GGsNXO9hA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(261026121527099003)(18002099003)(921020)(261021123027099003)(261009223027099003)(11063799006)(10067099003)(261021121427099003)(56012099006)(261022105027099003)(261022075727099003)(260925021911599003)(261028144727099003)(260925022911599003)(261026140227099003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnIyN3JiSVdGYWxJcGZsdCtEVWFLVENQd1Z3ck5iNEpac2ZGQ3VqTy9nMUZs?=
 =?utf-8?B?Ri9aYThpamcxV1B1MjRSbVdGSzYxM3lId2ZHdzBnZk9yVkQ1QUFBeDl4MkNq?=
 =?utf-8?B?RkxTNXNySFdPWXRETmd3dmlFRkU4NldzdjJCNUE1NVFNdld6T08xYzNyaFdL?=
 =?utf-8?B?THhuakJ3UXdOMFRTQ21HWS9obytBQVdXT3ZwRzI4VlZXMjRTVXJjazNsQk5t?=
 =?utf-8?B?a29zNlI5MHY0K0lrSlVMT0RVck5kWWJWNmREditvbHVhTklKSi81KzB2SGxY?=
 =?utf-8?B?eHdVbGQ4Q1ZSMlVVSVp0NDIyWklSMkpQQ2VINmExdkVpNHNjMkZpV1BOZkVt?=
 =?utf-8?B?WGdjSnRWU1pIWThabHNidXhKeFA1TldRZVBDVjNsV0dJUDIvTU9zbGpUQm82?=
 =?utf-8?B?MHh2cFQzQmlxNEltVmlvcXd1R1NrNDlNRk5Qb1BZaXptZU5qU2tndm1adVc3?=
 =?utf-8?B?ai9UTDR6S3gzTHpWMmR4c2NzYTlKSUhyYSs1SU9VTXFRRmpjUjhOVDg3Nmt6?=
 =?utf-8?B?MVNMMEtXUnR6bmZ4RWVwUWkwS0hCOWdJUlltdklXbW9SSkk1cU1jdWdqdlow?=
 =?utf-8?B?SVZUZzY2YTNqUHh2N2p1ejJrVkV0WVBOdVJDV0dxWkRvcDArZUova3V1VmR3?=
 =?utf-8?B?MDVrQzRDWHMwdk0vcWlOZXpNWmJsdWZlY3QzZFpZWG81cGczTUF2VEhnQVp3?=
 =?utf-8?B?VW5hejlrV3d0NHgzdXpWZHJmSy9mRS9zUWNxQnJzaWlNWTZ2czJwOHYrQTc0?=
 =?utf-8?B?bGpmTXg4TThjL25VSlY4L1JSKzZHVEczU2VFbGNETHdTMHNHVjIyU3NYcHFz?=
 =?utf-8?B?MU1IUm1XdmFXczJOVlp6L2dDS2ROL2pZT2c1U1RIenJBSWxONTV2T1ZVdkt6?=
 =?utf-8?B?dHM3eWxOaTEwRGxGalNTNk1FY21wQUIxTUhPSXdUVHhPV0NBYzZleVV2Ykhs?=
 =?utf-8?B?cEhJVGpPZjc1UlhvNVRQejRZVlZZUnRuaTJKcnlFalNSUGR0ZE5JK2l6SHdx?=
 =?utf-8?B?ZEU5UmwwTXRDSmV0M3dsN0pzVGZtNlhWb20yWDk0Sm01THE5TzJYUFB0cTJ5?=
 =?utf-8?B?QTRSRDdyWTUyVFBwU25EM3VUcExFTEFBbWlrS2EyZEQ5WnZTS21ZYjRGVU9w?=
 =?utf-8?B?MzI3eUpPWnRhZlNWVzRTMTUzVEhTbHdQS0lHMWFwdC9Oc0RuRlZVSVFzU2dU?=
 =?utf-8?B?Y29XRHBrSGhDc0xYbjYzS3N2N0NXQzRNS0lvK2YydytKUWdTK2dkMm1HdjBy?=
 =?utf-8?B?QkVRQlcxTnRadDdQREIwbkpieUluemlzWjNTdTVmTzhIUm9WcmhYejVZaGRj?=
 =?utf-8?B?VE1uNkIyU1RLWW1SR2hsaC8rTjNweG5UaThJeCs0SWk2Vkp4bU4renh3NnRn?=
 =?utf-8?B?Y1JuNFgrUzRQY25oc28vTnRoTlFUN2hYbXhsZVZBRjRxaTZhaFJleFRiMmtK?=
 =?utf-8?B?N3RMM2toNGIxcjArRnBSYWxnRlpKN0Q2TTc0L2t6ZkRFaVFsNkZVVFYyT01Y?=
 =?utf-8?B?RElvQkRDOWxSQmNGR0xHVmM5ZGJaOEpQa0VHNzFOemYzNFFYem00Wnp4M2lz?=
 =?utf-8?B?aFpoaFRVQWRHaVZRVHNUVFN6bGQxOVVmY2o4UzVwS0pYeE9WcERlTmJzMFFH?=
 =?utf-8?B?aXA3a1YrUU1md21YWkxqWnlkRmRXTGVlMUpFMXYwWGYrTWgzNkpmcXhDK0Vk?=
 =?utf-8?B?UjJHMzA5WWc2Q3A0NDlBeHc5V1hNZEEvdmpZVU9PV09kWFNubU96RDNKcS9i?=
 =?utf-8?B?bU10MGQrWCtLckxJZSs1RnA4amhSOUJuM3BqN05sNGNsVDR1SXRhSXh0TzFh?=
 =?utf-8?B?d21hOG1HblkrOW5MSnkzdmhTcTRSZmdrNlFIZjFvVGpVSnNiMzVYZyt0cU84?=
 =?utf-8?B?aSs0bDJBTThiZTFVS2lsYk5zb1U2MFNTQkloaFc0SEprdExGbVh3cDhQQWF1?=
 =?utf-8?B?Ly9KeUJMdlhvcW1VbkNVVXZMbHhGTno2U0x5aXdCVEtEdDZ5TTZRKzdIQnVW?=
 =?utf-8?B?NjVOOGs2V0tQT0pJWFl2QjgyTGQ0UFVmblVFQ25GYmxTVXhHdE9ibURvUmVt?=
 =?utf-8?B?b3BkVHdCTkNVeDgyTmJCR0FIWTh0dGZtbENOT09pTEgrLzQ4YjRTWjNsT0Iw?=
 =?utf-8?B?bWYyMzdSRFMzQUJkUlp1ajlnVjFaOXZLcERkVmVVdjNVb1hySkhsc2ZtYlNE?=
 =?utf-8?B?SEZxemMyK0xwREQ4Y21BV2V0THJaT2dSRi9DTDNUY0hDZHdTTXJCMytwTkx2?=
 =?utf-8?B?RXcvVW91c2ZPQ1Awb2xmYjl1ZW1pRU9zbHpCdytQQWJnK2pXV3Q1bnZYeSt2?=
 =?utf-8?Q?Tq34EuwHbbsGqtALt+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5783cb9a-a279-4bdf-6829-08df362ac4a3
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:09:02.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue/8C28YJ7sY3YYa5WjfPvsQViTQpOT0ebXH5XaExPlYgNzpKtI97pEg6tEME9uI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727

__split_folio_to_order() calls prep_compound_page() on each new head page
to create a compound page after clear_compound_head(). prep_compound_page()
uses non atomic __SetPageHead(). It is mostly OK, since the folio is locked
and frozen and no one else is supposed to modify the folio's flags.

However, code calling migration_entry_wait() can reach the folio by PFN,
then access its flags. It is because softleaf_entry_wait_on_locked() used
by migration_entry_wait() sets PG_waiters concurrently without taking a
reference and the frozen refcount during split cannot block it. Meanwhile,
__SetPageHead() does a plain read and write, so PG_waiters atomically set
by softleaf_entry_wait_on_locked() will be lost if the set happens after
__SetPageHead()'s read and before its write.

One example code interleaving:

CPU0: __split_folio_to_order(new_order>0)  CPU1: do_swap_page()

1. clear_compound_head(new_head)
   new_head->compound_info = 0
   (page_folio(new_head) == new_head now)

                                           2. migration_entry_wait()
                                             softleaf_to_folio(entry)
                                             page_folio() -> new_head
                                             (not the old head any more)

3. prep_compound_page(new_head, new_order)
     __SetPageHead(new_head)
       tmp = new_head->flags.f  <-- load; PG_waiters == 0 in tmp

                                           4. folio_set_waiters(new_head)
                                             set_bit(PG_waiters, &flags.f)
                                             enqueue on waitqueue, sleep

5.     new_head->flags.f = tmp | (1UL << PG_head)
       <-- store; overwrites step 4, PG_waiters == 0 again

Later, folio_unlock(new_folio) sees no PG_waiters, skips folio_wake_bit(),
and CPU1 can remain blocked indefinitely.

Fix it by adding the atomic version SetPageHead() and
prep_compound_page_atomic() using it. __split_folio_to_order() uses
prep_compound_page_atomic() to avoid the issue without adding an atomic ops
to other prep_compound_page() users.

Reported-by: David Hildenbrand <david@kernel.org>
Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.com/
Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org
---
The issue was raised by David when reviewing Ye Liu's "mm/huge_memory: use
READ_ONCE() when cloning folio flags during split" [1].

[1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/
---
 include/linux/page-flags.h |  1 +
 mm/huge_memory.c           | 10 +++++++++-
 mm/internal.h              |  2 ++
 mm/page_alloc.c            | 20 ++++++++++++++++++--
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b0ddc652e76cc..08492ab3da895 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -854,6 +854,7 @@ static __always_inline int PageHead(const struct page *page)
 	return test_bit(PG_head, &page->flags.f);
 }
 
+SETPAGEFLAG(Head, head, PF_ANY)
 __SETPAGEFLAG(Head, head, PF_ANY)
 __CLEARPAGEFLAG(Head, head, PF_ANY)
 CLEARPAGEFLAG(Head, head, PF_ANY)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e86845..319b038eba89d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3779,7 +3779,15 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 */
 		clear_compound_head(new_head);
 		if (new_order) {
-			prep_compound_page(new_head, new_order);
+			/*
+			 * new_head is recognized as a folio after
+			 * clear_compound_head().
+			 * softleaf_entry_wait_on_locked() can set PG_waiters
+			 * on it without taking a reference, so its frozen state
+			 * cannot prevent it. Use the atomic version to avoid
+			 * losing a concurrently set PG_waiters.
+			 */
+			prep_compound_page_atomic(new_head, new_order);
 			folio_set_large_rmappable(new_folio);
 		}
 
diff --git a/mm/internal.h b/mm/internal.h
index aeebb3e49ed11..9b8864a8540aa 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -807,6 +807,8 @@ static inline void prep_compound_tail(struct page *tail,
 	VM_WARN_ON_ONCE(tail->private);
 }
 
+void prep_compound_page_atomic(struct page *page, unsigned int order);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 143776e671abb..ace1359468046 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -682,18 +682,34 @@ static inline bool pcp_allowed_order(unsigned int order)
  * This usage means that zero-order pages may not be compound.
  */
 
-void prep_compound_page(struct page *page, unsigned int order)
+static void __prep_compound_head_and_tail(struct page *page, unsigned int order)
 {
 	int i;
 	int nr_pages = 1 << order;
 
-	__SetPageHead(page);
 	for (i = 1; i < nr_pages; i++)
 		prep_compound_tail(page + i, page, order);
 
 	prep_compound_head(page, order);
 }
 
+void prep_compound_page(struct page *page, unsigned int order)
+{
+	__SetPageHead(page);
+	__prep_compound_head_and_tail(page, order);
+}
+
+/*
+ * PG_head is set atomically whereas the other metadata is set with plain stores.
+ * It should be used when @page's flags can be modified concurrently,
+ * e.g., in __split_folio_to_order().
+ */
+void prep_compound_page_atomic(struct page *page, unsigned int order)
+{
+	SetPageHead(page);
+	__prep_compound_head_and_tail(page, order);
+}
+
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);

---
base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
change-id: 20261029-fix-split_folio_to_order-race-087a2a9fbf7c

Best regards,
--  
Yan, Zi

