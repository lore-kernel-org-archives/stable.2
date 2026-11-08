Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794144232;
	b=tV1nBHHWMH7oMyjJZ8rGUOJNt5ik08Gaq1TkiZB1q+OvJrcgnQu8HqrIwKEwMMJiaGkJ
	 Nkm1MGfpvvO8jUIsrfu/JPogjKzRikCdYd1/wgv5pCpg/MNOlbXTIDYpHoFho+0CYVTwr
	 j9rQ6+MYNT56MfWQRqtc+ONBLdcA/unvdpTHgD/s4upoBGKEwRT7uNHLlEmuwfenN4nT0
	 gBjFMB4no/OmVTSa+HeAykMrXdZB66OIucF4hPTMLzx3nh8KUkic0pt8WrJ45mcweZKYW
	 E27UgvbKhRsps8BmQIH9QiIVfTj4mST/SL28xCXyFOJW5/TzarXiyrnpiJY2DOlF9GA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144232;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=p72pDBbr7HHactFR0hZxl1j6wxNTtzgk+oAp0nON7EM=;
	b=Ru+crH6FDf+w2VY9WUrAR8/l7oZcht4OlD1yPjEV+UuPVxMHKGMPWCdFCPSxTyxDgmrT
	 W1uGaTy0QMqhDrY19GV5eJeQgy0DIv369H3mdGZ6E1osalj/zy7zo+KbinmwPtL+1BZk2
	 GlRWtTPGLroBfQ1YHaeCtlSyEDtEdkkIOu4KPV6zg4zG/0Rlsmy66Y7tJdafzSs87QHny
	 1FvGW5GRxPUIIlF+buZsoMa6mcmQWoEtxNgzsKSNvTQFVCdxSvClB2p3ElzlkWNHPe+wh
	 AJ/g5QgFQJEtuYqaXO8ykhHbIYntUulb0JXdrAXTZeQSzap7WTDua3W2Fja9LQM5c3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=bnfscUaL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.131
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021131.outbound.protection.outlook.com [40.107.192.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A8606A320;
	Sun,  8 Nov 2026 13:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B1A8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=bnfscUaL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT3Z5EUDHBi2Dq1Gnb7n7r9DVzHsVXhUGYHiVeUitoA+aYiVEpzgfSYR9UMsCdS6HVyquRdVQPkkHDF/5wQGV2r93q2B3UOMx7FPPiYrYFNE39wPYG1xRc4zzsu+SIyc6a1tpr2ALL00TJktUjwvVdd6w44HTBI59azWDdCid+Uo3Ezc80zBqtMiqSmhdw40lsra52bP0cLEn7zy3c6kRCHn0zcbMOv2hQxCO3Zdm0aXiawD7fqs6zpSXJWwxK4ivsaHhNKTaWfWjSK+XnV95dw8xUGFWkh/NZpGymLdpl6c1PQwwFPFsiwqA0qR++fuXs6yvojU8NBAwUrcPur6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p72pDBbr7HHactFR0hZxl1j6wxNTtzgk+oAp0nON7EM=;
 b=GfNPQcqIts4/iw0uswhbw8xngwMksw/tCgKNtG6HDEkMVjs0HCnV+Z024dOTRGWgPwWiSmArc7hjiix64372FXQIac6W8DYlQmGGvJ7N0JqSjC0qqeOiEljFMG7L+2T25hD1ZYns3qdTe1ZPI5MEAkHOfh5bS86SxgyLap6ksoT0NSC/OfuAmtJz98T8HcAKDMjFF4YugRW/WE5UR1Va1qt6uaqJboMs7Wk62fMUDRDGCJj3mpKAQ4bX6almlTIeI6JQmFDrw3XdS2fpy3sS7fiN7jymnsb3nUgdQLm7ZEyaIY5uXxCo5EFMNZJ5mbmjecHT0cd8XahPMP3wh2yRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p72pDBbr7HHactFR0hZxl1j6wxNTtzgk+oAp0nON7EM=;
 b=bnfscUaLbfLY4jKYiUBq3IZ2wFxvMMaBYWdIaITiw5Ndonivn9Tii4/QCircZi8LZiEUa0iSXjFFSiqlf8gYyTxNO3mf9xc5tYAONfqJy5YjSOOmPG9K4LZ43c+tefcIjmKt/Jgpn/ax3CbTUtezotWSCbzzc4yXosT76j1EI3HBk8N154CgV89SDiDr4qlpfnlelx3sUaScU5oFMEOKIL1i9U4zad1GSEEcwuzotRkQGX7Vj8d2ighx+/VG2LCPU8xW/Mnj1uLuX9Xym54FWgjkfWsCmK6AqzRHPHPceJwkeiyW3653jD36hhs/aQpAmjoRkfrKoIndvKWJZAKOBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PPF794138A02.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::552) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 13:23:48 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 13:23:48 +0000
Message-ID: <1a3fff79-6e94-4e55-b262-8970ad2d54f2@efficios.com>
Date: Sun, 8 Nov 2026 08:23:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] locking/rtmutex: Stop spinning on the owner when the
 waiter is woken
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@kernel.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
 longman@redhat.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 shuah@kernel.org, juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
 <20261106235931.1478800-2-mathieu.desnoyers@efficios.com>
 <20261107002927.3cbad7ff@fedora>
 <20261107104329.GA2668564@noisy.programming.kicks-ass.net>
 <c77635b1-9c24-459a-b75c-82cbfb67185f@efficios.com>
 <20261107123642.149677cf@fedora>
 <2a786b46-e935-4269-9bdc-edac43521a80@efficios.com>
 <20261107171841.06d3ac92@fedora>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261107171841.06d3ac92@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::24) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT1PPF794138A02:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6a8ccb-939b-4748-7044-08df3d9b85cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|10067099003|4143699003|261028144727099003|261026121527099003|261022105027099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	2TFJPORNSsUb+9QXFLEunf2EdP8LYGshZuKYCVFxoySPmB2BGQHEMgc9beFlDXGe3gD/EJk248Otsll3XwuA0JWpfLBlYWlK1EXpKTWjSI2qaGRKNL8QqZukWHpqyAtZjU8V4bmA179GAqOtmAzigZy4enZuQHJlVDfKB6TIzq9VZbNWc6HcbQvxM4r2RvKNJr0n9BsWGJxJH/7WJZvBq3CZpF+QV5f8Tt6Ck2MHrzb1gR9JJT8Ahw9kO3Nl0QQMe8RAjg4SwBAd1g2oh5TWQTCabazoxGASPKflgW2TFl0Feck3c7QxL1cDUu+C8UodI9lFXtHNi7JSDXE4aFG4DcmOxghQGKt+N+AfP1jHdozMdczruTe9eoxwjDobXPthVWBlJ5njOboJK8xphU5sexjooEbSCLB1eKi/9uy/d9WqfcU4LuOqlQyNZcDRrAFdm4ey19gYuKTQbow1vTvm/AQQuvLujzN4MlBOtjxiTlu43RUoEPp7CSabMZ5LFgRDWbnPilcAexeUdxRpz5+ftghaO5USljbnrv0tb4YuABDt1/L3QiPsKBH0npDfKJ1/STXUox5PJ/IPUTRUs8L1CcxBo1fOB9aZyQrEgJ4Mut4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(261028144727099003)(261026121527099003)(261022105027099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0lqYUU1RnFkeUkwQWRZL09vSGZHZDRMMU9aUTQ0bDVickRtdnA1b3JQRWx6?=
 =?utf-8?B?L2hKYlNNQ2t4VURhT0NxcVVzTThYY21MdnJtOXZFRUJHZXRhQ1JMRW9FTFly?=
 =?utf-8?B?ZjZOVnZmMzNRYVozcEdHRUhhZlBReDRJQ1pNVW5OQ1JRV1pKNTVzVTgzUU00?=
 =?utf-8?B?cyszMy9vWktrZ1gwOVpHbk5nM1hzcnhYeHZYVEZXcHNyZTlHemxxVXZoUmRz?=
 =?utf-8?B?RkZncEkzN1F0QWRNRlltK0hDUXJxUXlpbVVWbTZFN1NHTVZUc0tHaXdoUDdx?=
 =?utf-8?B?MlpDTkwrYjNEQjhrYUlmZXZjNldVU1JYUHl2dWpKN1k5MURxZW40bytBUDJk?=
 =?utf-8?B?bjU1QndxY204dXpLdjhBNlV2RHBaNks4dW9zVTgxeFpOWG56dEhYMm0vNTR5?=
 =?utf-8?B?N0dJRVo5bTkrWjdsVENGNlprTDlxRHhYaGhNbzkrcGd4L21sOEIrUFRPMWlx?=
 =?utf-8?B?RGNPT2EzUXB2M29WUzJ1Q2h4SVJDcjhRakdZaWZHTG1HU1BFNHpaMXo5WE52?=
 =?utf-8?B?OWM4MThRN2FOZEVUMmZaTnQreC9DckU4c1EzK0lxYlZ6N3hIc2ZjUHJsd1Uv?=
 =?utf-8?B?U1prNTVVZ3gvekw3REM0emkvWHdDOTZ1OE8wWGpCU3NZQkZ4OEs3ZEIyZC9j?=
 =?utf-8?B?VTVFRjQxWlc5VlB5eUc3aEVaR1pkRTQzSjRVZWVPdnlmZnJadjErVDJaK1ZS?=
 =?utf-8?B?cW81MGhIelNKaHk1YjBpVmZGejhUMlR2d0d3eGJySVpEZE51eDdZZVF6a3VH?=
 =?utf-8?B?TDhDZnRUSHdtSWY0bE1xdzVJdW45QUgzOExvbHBoSFhmc0diZnNXeVY2SVpR?=
 =?utf-8?B?R1Z5Qm1JSldpRXhJUWxPSU4vK0QvMDd3MkNBaHBOcVVZZWhmazVFRUpZajQ3?=
 =?utf-8?B?WWJqWkFUc0RWT2VOeUdtNFF0Z1M0eWFwSW9iMzQ4TVZsWnE0RVBVQTJPa0Ix?=
 =?utf-8?B?eDRNQ2ZZaWJUNkZMajJMcGZwSWNuUTdjbGNHa1NwcGZaN1pTVVRhL2Q3Y1Vw?=
 =?utf-8?B?d1lDVytHdnFSMFhYa1pzLzMzSmVFVzd6RzBCVzM5YU1zNjlEOXJQUFVYMmF1?=
 =?utf-8?B?aDA0N0JCRnd6TUZoV1VnYW5UYnFtQkVoeXg4OVdpOHQ4TFROcWgvTUxzK0RG?=
 =?utf-8?B?RFhxTWRjMmxUWFo0SCtlQVh4MFN3aC9selpUSlZDMjRSNnhIakI4QThPbk5H?=
 =?utf-8?B?dXZ5cWhSWTBYTzRpN3JqcXNMTkYwaGhrZ3FxcHg3UjdicEIyU3Y3TTYxNEV2?=
 =?utf-8?B?SEJ3ZHJuYlVDam9UZjl2bzJENWN5RjJDT1U4cDk1TG5GKzFKTE5Dckh4UWdT?=
 =?utf-8?B?WU02My9OQVNDajZhZVVUL1IzcDNOcm96OVVJNW56WmhrdGZYanZzMngzc0gw?=
 =?utf-8?B?T2llNnZvMisxN09JekRHQkRNeUpON0lKamJ4UHI4djVPc2hBcVlackxiSlh5?=
 =?utf-8?B?Ykp3aFJKVTVlNmd3d2JpQm1oSjVOVzJ3VkpaZkF1VlZ5UGpMS2E3bXg0TFhC?=
 =?utf-8?B?YzJzRDZTZEtrWkQ0WGJTOUhFS0V5czhnTndON2I5ak1kYXpzTU8xcFBEUzlS?=
 =?utf-8?B?T0lTc1NvZWw2QlR5ekdteU9WTzU1RFFtMlFDVVNheThCdHNOQnU4b3I5STht?=
 =?utf-8?B?MTF0V1NKT3QvQWhVTzNXamtNdDVJZmhteGZKM3BSZFlUUkI0Wk1VRTMxWGxB?=
 =?utf-8?B?N2RSQlZmdk81cEkyOE1RQWx4czMzMWVoT0JaRW5zQ0N5eVNCK1FuWXFKaVFE?=
 =?utf-8?B?MXdESysyWWNmZ3BLQXE4Zk03em0zd2hROFN5Yno2K2FJUHc3NFBIQkFqYVZh?=
 =?utf-8?B?S1QySWVGZFY3amlyUTV3SWRXYjRvNEg0VEpicXQ1ZkZnZ3JnYk8rczVJY0Fz?=
 =?utf-8?B?anN2bXQrdmQxT2lIS2Rxa3NVNGNmN1JHNFo0U2RxSldDb2tjcVo2UVZnYU13?=
 =?utf-8?B?ZEx1Z0xDMGVpZk50cGx2cjJZM3kvUmFLYWt3ME04REpHSUZOa3BiZXRYdHpt?=
 =?utf-8?B?dzg0a2QzeDdHOFNPZkhOUmtxcnMzdk9iYWlwcUc4N1FIeFNkL0lNNFkwQXNl?=
 =?utf-8?B?aDVDNVZkV0U0eVlUREJCa1pneDY0dURTUXRySTAvcTI2WlAzVW1EWXVraDk2?=
 =?utf-8?B?dEZvMkNaanRORWtRaURBY1RrRHdYMlNvZHR2OW56cXprL2dNZmdGUC8zL1Fs?=
 =?utf-8?B?ekVwYklNTFVYTmlLU0lWVWpPT016YVNvaGRnam1SMDVLZlREclJSbTVWeHRu?=
 =?utf-8?B?Y1VpYkNsdEJFbnJyS0F4NGZHek4wbFlINjRVd05ySENVbnN2enU3eUtXZG12?=
 =?utf-8?B?NzAwSFR6c1RWak1sWG5sdW9QbXl1RndHcW8vcmNjS1hicFpnMEEwWDVkWVAy?=
 =?utf-8?Q?DcwWu6YNLpZHFkvY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6a8ccb-939b-4748-7044-08df3d9b85cb
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 13:23:48.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvMgX6Ffc3T3VXrrABkVCFfJd4rhe+SDNq6FfQgIPFwz5X5l71dQEppOPtvx3kATRd+YeaU7QWVLEhjpoGcV+07XdcOmuk8cuf8da6hKEkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF794138A02

On 2026-11-07 17:18, Steven Rostedt wrote:
[...]
> The last sentence doesn't really make sense. I can figure it out
> because I know what the slowpath does, but as you see in my version, I
> go into a little more detail to why it's not an issue to break out of
> that spin on TASK_RUNNING.

Thanks for the feedback! I'll take your suggested wording as is and
add the two paragraphs about user-visible impact of the issue.

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
