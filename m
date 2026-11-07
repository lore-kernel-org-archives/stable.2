Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794054600;
	b=clB6Uzs5qLRiDnGEAc1YZ0kmeT2GHanmsUglIacEeroJ2lExFNDz87Kg0EMAOtZH0T+g
	 cKsc4ZKPSDgYLd2drIhN10EJ/pZXbrA/whrKiHLf1TZOX4Nr4AVeoTuoiCQz6wZ31zDCW
	 KIOaIJQVyU7jF6qqdluXUeUx4qhl9PF+IOKG61GyVwMeuwzBSUjtmq93RmWoK8/l/RlDo
	 FjtDOITND11krT6fOTQdbhHws87Ue1+wQOLLVKGEuTxK/ss3edBqnzZFWN2UaFc+AWpjB
	 hOO7uimC/ptIelz6wfcm2zrqqGMzpLcNGYRrFm2M+y1Xm6go5EMq4jXsfEFuSTxHpLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054600;
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
	bh=wejPd3dX6AtoK+6O0zf2aN7uDRDFs9bMDr/9uv6mOVg=;
	b=Up7mg0tDgYvpjduX4kVtbIF9t6XWph6OAGBYMyKlW1pLeJ5W7bVe+lAIEkuYqR/Xqlvh
	 V2o9ZTMBfccPkWfLVWMSS/n/uXWY0aKnb7pe4+nHONXuHBMT+T/CEnx2tPvLa0zWH0WGl
	 6UBRnPCE+SZd3TUJBm1h/wX5YmfaIKK3VKRRpB+CODieOMADdN/H+QBQIDdmouAkshOD1
	 LmMxHgI2y3JNptuWMfp5bm09hoxhSSPDN9axv3pqfUouCEAOv3Q0vdjfk6OOujuyaifyn
	 20dePFYW9PH1l6Ob/IjQOy31iCJrntQyXHjMbeQjZZIRKZHbKAZbInkivmEu89Z/smg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=prqijMwq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.105
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022105.outbound.protection.outlook.com [40.107.193.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F4606A326;
	Sat,  7 Nov 2026 12:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875F4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=prqijMwq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Seosa5AaHcZYHjddH+/9Dk/ZJOFMp2xtWTwBgjJTzIAuZEppA9AsPoZmpZgqbSprxgKDHAy0/eD34rHEds0JJL13dUfcZNGeUl/OanK53y5NnXJ39A7yI4lQd+8iNDD+NancpClHCwn35CqtnMslYm9AOx/BC4zYan40DNienKZ2/3/cs4yAPNFmJu7H1dj5XfT/fc1/z14etFjYT82Y1CsGG0g9XEgY9DzX2DtGjPPMm17X3i666DVflsB2ZmB6WipFNLBT77yCjA+zPPEobPFORAaWwipMJk7k4A9xLQjBfcft2Dgwo9KfPLj4cP4CdYsAirTPxysHhzWWOpRCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wejPd3dX6AtoK+6O0zf2aN7uDRDFs9bMDr/9uv6mOVg=;
 b=D9vaYeZ9FIOS7dv0ldVeixrsnyGLNiUSeGklCfBn4YrElH+GdsrgyZsiUBRQUZpip/6ke0eB6CpT2N5xpMpanrp6xMrZEw8K3BBYp59mkZqlKcYTO6nseyJFp0Z3w0b/w0e8owjXhzgAQ1hfwjggyi4omc8uB1LSyUeQqfMwNEGaL/0FKI+DRXd03yZY4K+y7nVSkUAYp8zB+7U9h+WRi1Hj2y2q5uAXcIg0MVkB6BlhMl5sazQftx+bDsZwtt5Y53L4GYPSjsHWnW9iL9OpaI+j8WlvFY5VkGLv5whtNNSjd7VcHmifnUr+KekWSi6zdSuOpd4/h9lQRhsaMdTVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wejPd3dX6AtoK+6O0zf2aN7uDRDFs9bMDr/9uv6mOVg=;
 b=prqijMwqKvaLm+tzsDTwGSd8FPWjPuMi6qeC3Glbv8RwvZxkCXF/4lHymkgAA4v1vRg4HrdxKbh+k3rQwYxHhtzA45FysutIpCwOtnZ5s/d9SW6Lpmy83Ew1eiS0LkG7isUgFL0xp6mgh6uKOue/wTwIZ6mc++KMjlnOwKz1wlPTxM8vjm0db2VllH/9b+l2OaBLFUNHZD/3iXXVo+2yOnbJIuNlfHIoYpTVtVX71/3ftjeZy0BtxadtF7+AJWH1crvWZP6Kqi2ztGLOwd9GWCsdfm6TLtmd13BQbevxUe8rHQp0dueNASjECnr3ixtKdkuvAzHYq2fbhKDJ/fqzlQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB9494.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 12:29:56 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 12:29:55 +0000
Message-ID: <c77635b1-9c24-459a-b75c-82cbfb67185f@efficios.com>
Date: Sat, 7 Nov 2026 07:29:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] locking/rtmutex: Stop spinning on the owner when the
 waiter is woken
To: Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: tglx@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
 will@kernel.org, boqun@kernel.org, longman@redhat.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, dvhart@infradead.org,
 dave@stgolabs.net, andrealmeid@igalia.com, shuah@kernel.org,
 juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
 <20261106235931.1478800-2-mathieu.desnoyers@efficios.com>
 <20261107002927.3cbad7ff@fedora>
 <20261107104329.GA2668564@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261107104329.GA2668564@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::29) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5e85fe-d6cb-438c-3773-08df3ccad477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|56012099006|4143699003|261009223027099003|261021123027099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	boSfYCPe/mt+a9wS1EPyBxmDtvYoTQkrLQ++BNHJZrAcYx7jgsMaN865zBea2kgtkiMKz05G0k1Xqf2lPhCloWntnGhJsQcU+eAg5m7Iw8NzDreeOUA1/U85hjxzunktUg47UmdULgNqU/6iIImH5KK0dvf7GvdOfQd2EvDrQ4O6YytZl4MUl9eIwty54t/JoroHjWH27F282Crzfzj616sHaef2WR2lv+28a+G+tEensXjsnuo5sLWkavesyVmxmv1szY4O75sOjtJV5DHklMPnsuUiyK9Z1OLyeAeUY61zKzFeBhz/9EnXrNW3uMbYO43h5vos6tEFOhY77UaP9PaNYnB7Mv//JaN0tdsbWC45caNS9xNZs9dgOAaBsiShWMCk1RwRKGZms5Oo2RKbjIyA8UE/jpS3kGARkU7Tq9Ti/gcec9Pw3f3pzI+gMyT+gRBr77d8VSIXXUqhh0mhPTDcc0NZADeaz063/eAZAZtsYvT9NbrhTDx07xQodwXhun79P07AmIoDhNOOiaVU5qhcE48zKjV+MJkojXOuqmQEBU5311AfA/6m0RZ/sXz8fklglJPF/XODcER/rbTLUdLHuTYxxrvpuoX4NqXWVzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(56012099006)(4143699003)(261009223027099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzJhRkdRbE5velJEOXIwcjFhM3FMYVNhVDZEbnFSVDI5elJNcnE1OHZWOVFl?=
 =?utf-8?B?WEtqUmtTSWNJTXRUOFFFWXBCUjkvK0VUV0M4QlJFdWt2ekdsalFmZ0ZBTjhy?=
 =?utf-8?B?N3ErQ1cwVnJlZGxGTUx3SmdnaGU4aFFvN1U2c2ZWN0pON1NHUVd3bXkzUUpP?=
 =?utf-8?B?K2V4MVp1RWVHaEs1NlZZSm5jaWZDdEptbnBqMnQ1TlJkWUFKZldmdUNjWEdn?=
 =?utf-8?B?Ym1YUmxtbFNBOG9ZbXk4V0kzcGoxK3lOMWNTZHhYMjhaOCtONjJiejZycVEy?=
 =?utf-8?B?L00rNHZDcjFnSWZtUUZPU3ZGZGJ0VWRObTNYcGI2QWFXUWcxRkFGUTFsVDhW?=
 =?utf-8?B?WEhYbFBWZ2ZLME9VeG1TWGowejA5UDNiOEdYOGJjTVVrRHlteVlUZUwrZDFx?=
 =?utf-8?B?NVNXTTVSb3lLTDg1V2M3WTFORktOQXhsRXkrWXVHUXFuNXdhMHNEblErUUo5?=
 =?utf-8?B?SWFJS1A0WlBOYTV3dzI1cm1DaG9rSThoVUx3N2hMOVZCOU1QR05BTks3M1FB?=
 =?utf-8?B?b0xJa0oyY2pXbjU4end6QWxVMUFZaUdZNnQ5NE4ySGlKWWozOHlMdTYyU09B?=
 =?utf-8?B?UE91cUVidVJscmxLWlI4cDJZZVNxMXkyNk1WZVZxdlZRMVpKVmkza2xaOFhM?=
 =?utf-8?B?WWpxZDZGVTUxQUhQWXNuNTZNdW8xd3F2Tk14cVA4VElLQVVESHdvakQxQm1Q?=
 =?utf-8?B?SkJDb2pzWEFlWGdYQU1LLy9jNkhlZUFFQmlQdFBUSi94dlhZUGpOTStvdkpm?=
 =?utf-8?B?dXYxcjlTd1BvNDlPaWtiVVNvaEVYaDk0dlhoYTFvM0toekowYU9jcUNjWXZx?=
 =?utf-8?B?KzFTK1NsMDlCa3I1RHExdTRlYUEyOTZVN0cxZUpCYmhKOHE3Y0tvbURWcVN4?=
 =?utf-8?B?dmUyZW1ZTUxoUWYxSzk1TnBoOHdDWnZ6WXBLNHhFUWJySEgyMXEyaS9JaWJE?=
 =?utf-8?B?YmpJd0VZRnNzeUhsSXJEbURNeGN0ZktNdXlZMW43dkFoN0s2ZkI1UXhNTmZy?=
 =?utf-8?B?d1JHVTJUQncrdWduM2hNYzFTVlpRS1ljQUxlNmR5ZnhvdEFJLzdLcmV4N2ZT?=
 =?utf-8?B?anJDVFdNVkFiQVQrV2ZZNEo3QlFuOWlKdFZUbVpnS3F6ZHB3ZFVpTG1HODlx?=
 =?utf-8?B?elk0TjU0ZkpPOHFWWkYxcng4ZUZMc2ZOYTcwSG9Hb1cyOUM2djlZNWNFdExI?=
 =?utf-8?B?YkhpN0dnYWVmd1l4ajVWU3BIMTBISjlGaHZkTk5CcXBHdEVFWjFYN05vekhO?=
 =?utf-8?B?OWdnZms4SGdmRnZ3Z1IyQWhpcU5QMnpMc010ZkZFQUFYNW5SUlpXY000bGRq?=
 =?utf-8?B?aGtIejhKSGUvS29kK0xhOTF2UTdWR1hZTTlSbjdqSlMyL3J1TnVPcld1dzF2?=
 =?utf-8?B?dHhjSFRDN1RiV2llM3phT05mWmhualZWQXBDZnZTT0ZoV1RoTWRSMDQ4RXNa?=
 =?utf-8?B?TWNyd2M4SVdIYmc0M1ZZN3F6OHFMTVNXMjQwcWZtUHZIMjV4SVNjeGpSR0Ri?=
 =?utf-8?B?djdiaFR1b2tlaVFsUFZaMzkrZXN3UERsRTJxSldpRHBHdkZ4N29KNHp0MFVK?=
 =?utf-8?B?WEhwZWxkVDV3S05KV2dNTFRiaDg3QUxiRVdkQkZsQURKVWZ6U0IwdnJYSkFQ?=
 =?utf-8?B?VkxNYVNEUWN3eVpBZVVOS1FrczJsVGxsbWdvMllmVjNvQTl0dU1HSmZrVnpM?=
 =?utf-8?B?UmxZeXZSU3VwaGx4ZzBmellNS0VieDU1a05kdTFMaEwvY2Y0Q2dDdG5ZMXlZ?=
 =?utf-8?B?SG4wUTBJR1V2aGdweTFJZE1BVFFRZ1NyVW5mSTZkSU5wb2x5NUt3WkwyVWtz?=
 =?utf-8?B?R3FndmVjQ21Td2d3ZU03cUFhK0xXVnNDZEdpa3hNOWNwNTF2Z3ZJaTkrZy83?=
 =?utf-8?B?U0Y5YWxPL25mU2FKeFZvNjVUdDBHNk9qNW9aek9kVVBQd2NYMUFReENHbkg0?=
 =?utf-8?B?NktSTlZCKy8wemJ3WkdwWjh2Qk9adDZXOG1yNnZNNWcxeHYyemNTM1h4ME83?=
 =?utf-8?B?WDdRVldoMUc3TDRtSGZiZVhyWCtCK2xPYllOSUkzd2RNRlpOTjFMRm5KUlQy?=
 =?utf-8?B?akRkL3UxZW5iRTVBM1V4T0VkS3BpWW0wOS84dmtUR1EyVEVwRWwzMktDMnlD?=
 =?utf-8?B?Wmd0cU1SamlHRms1K1J4Tktaak82RHc5bkNZY1dwc3dOSUlXUGhZSXdJTXdp?=
 =?utf-8?B?TGRFMkFVU2xscVVSTXNjd2tLakZyM3lHWWRDN1JnMXZMNndhVUhUU1FxaWcy?=
 =?utf-8?B?NmtXWmdEdkxyMVcrVHN4Q1FtWTZOelJ5OEkxNnJJNFBNMHl4TFFXWWRvd2Qv?=
 =?utf-8?B?cVRpaDYrMWdoMjNpUHEwVVd3dXZYK2ZHS2JwYUQ3ZjFFWWNzZkRKRElSN1dt?=
 =?utf-8?Q?id160u8ZTDULRNbY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5e85fe-d6cb-438c-3773-08df3ccad477
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 12:29:55.6428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTAeyo68cA82QRCpErU2PdWF9vsVljveKVORhLhXX1MSeiefYLOWK2LVzOHwokl9F+FY4YMUIqrzBhw5R9zY8FK7QDR1ATVRzxDzOF8LnPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9494

On 2026-11-07 05:43, Peter Zijlstra wrote:
> On Sat, Nov 07, 2026 at 12:29:27AM -0500, Steven Rostedt wrote:
>> On Fri,  6 Nov 2026 18:59:27 -0500
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>>> The top waiter of an rt_mutex spins while the owner runs,
>>> rtmutex_spin_on_owner(), and does not stop when it is woken: its timeout
>>> and a signal find it running, set it TASK_RUNNING, and the spin goes on
>>> until the owner leaves its CPU or the waiter's own CPU has to
>>> reschedule. A PI futex owner is a user task that may run as long as it
>>> likes. On v7.4-rc1, in 8-CPU VMs, behind an owner spinning in userspace,
>>> a 1ms pthread_mutex_timedlock() returns ETIMEDOUT 126ms to 631ms late on
>>> average, 1.4s at most, a SIGUSR1 is handled up to 1.9s late, and a
>>> waiter killed with SIGKILL is reaped 0.5s late on average. With
>>> PREEMPT_RT the wound of a ww_mutex is missed the same way: two contexts
>>> in an ABBA on two CPUs at SCHED_FIFO spin on each other, and the older
>>> one gets its second lock after 96ms on average, 0.95s at most.
>>>
>>
>> The above is very verbose. Are you starting to use AI? ;-)

I definitely am, as stated in the cover letter. :-)

> 
> He definitely is. I can't read the above, its word soup. Part of using
> AI is making sure the Changelog is actually readable. This is not.

Feedback on the commit message wording is welcome, I'll try to improve
things for next iterations. Is the following easier to parse ? I fed
Peter's and my own criticism to Claude and got it to rewrite the entire
thing (and keep those learnings for next time):

locking/rtmutex: Stop spinning on the owner when the waiter is woken

The top waiter of an rt_mutex sets its sleep state. Then it spins in
rtmutex_spin_on_owner() as long as the owner is running. A wakeup sets
the waiter back to TASK_RUNNING. The spin loop does not check for this.
So a timeout or a signal is only handled when the owner blocks, or when
the waiter has to reschedule:

   CPU 0 (waiter)                            CPU 1 (owner)

                                             pthread_mutex_lock()
                                               takes the PI futex
                                             spins in userspace
   pthread_mutex_timedlock(1ms)
     futex_lock_pi()
       rt_mutex_wait_proxy_lock()
         set_current_state(TASK_INTERRUPTIBLE)
         rt_mutex_slowlock_block()
           rtmutex_spin_on_owner()
             <timeout> hrtimer_wakeup()
               wake_up_process(waiter)
                 __state = TASK_RUNNING
             owner_on_cpu(owner): true
             need_resched(): false
             keeps spinning                  still spins in userspace

The owner of a PI futex is a user task. It can run for a long time.
With an owner spinning in userspace, a 1ms pthread_mutex_timedlock()
returns up to 1.4s late. A signal to the waiter is delayed in the same
way.

With PREEMPT_RT, a ww_mutex wound is missed too. Two contexts take two
ww_mutexes in opposite order, on two CPUs. They spin on each other for
up to a second.

Fix this by also stopping the spin when the waiter is TASK_RUNNING. The
slowpath then handles the timeout, the signal or the wound, as it does
after schedule().

rtlock waiters are not affected. Only the lock handoff wakes them from
TASK_RTLOCK_WAIT.

With this patch, the 1ms timed lock returns after about 1ms. The
ww_mutex ABBA resolves in microseconds. PI mutex throughput is
unchanged. The futex and ww_mutex selftests added later in this series
cover both cases.

Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
Cc: stable@vger.kernel.org
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
