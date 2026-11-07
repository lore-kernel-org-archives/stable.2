Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794061173;
	b=oFuSRsWzZBA2heg0Et82hI1B1zo/wWrMNSZUnIIdvTG+fSDMWRpnZzSodO0FCRSU4c9y
	 pEuVXiy/qNfMOvFIb3tTNBGe+GM3SKhrnDJ7z6PUljblap2Po9yvkyFsS6or1E61lVqWP
	 hy9RuOcoIYtGLIoBtYAFZZ0hAl+pSOlFU9085PKK8Q8PFZrCIp9qSZd0rQSEbKrDFmWpv
	 Ux3tukdhOj84RXuZUdKny9aslW6fr4kUGNpvVCsAQbAr9OW4hLZfgqWHd+ic6V7FXXq7M
	 0b+TTJHKT0HBxnWPh/YZSwrepema41pOmYkIpfuVEQ1NQ1t+TafM4wd8uWxakm8rGCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061173;
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
	bh=b+DzBOdL36e/ryMMirCAmgVhzmX/7X8TKo+4JJRNLMA=;
	b=0A+9Or1JurOvudgAmsRp2n+FYe1WxcXk6NnFUpP0eLfr5oE38B3Rt3vbEjRllq4wQK5j
	 xkQWk01T+im5i2aZcBNUgXDuTeRRmY6B5O9EHnDkpZpVWemr8XOSmB2ocC97PqBcMUoZJ
	 GUpdG5nRxOh6aiKfuwA+ulMvFhLdnlybq6kVehWRGs1+Xzd5yz4MZN6TosKI4l27oS0P7
	 RX2t675S4B2Lx8PPeFM+wIvIK4swqpl9W0dZ/Zab/gLWYCx0uz529vskObjxa43y2Bh3M
	 qyNOgG5bheMMWSNQcaod3uqTP5jDzkkaqY+tpag62gt363PQUVaG2WvfmrbtSSAYqJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=aUvZ1HWJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.76
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022076.outbound.protection.outlook.com [40.107.193.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3D6082BC6;
	Sat,  7 Nov 2026 14:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C3D6082BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=aUvZ1HWJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOhJuDk/O2son+X0AJ7EcmU8UhqQGw2mhLxarLRMYIoBOPPqe1FRHrYBKReqUQ01MZBUwgt+bhkZSb+Tz2m4faTYhFTy1zvKi5rD5vtI/av10inwZO0sv7IsGQZQOv/3ahS8eAhuSFYsGjXM1qBqYrSOANpWK4xYBM5WhXQoAobB/Nzclo9BDs/mxJFiMJ6NYsJtrfXLppoRiPb5/QY/Yquv1s2v68PlmyFoSSbM1todx97Z7iAX/MxRvXwBsmzQ6brrtH1Wm0O+CL3efSziSXGeagA0d59EzKDmQotrLP6OqdhG027b8pp//OeTmqL4yTU/mtY+fRWKsS2O9soNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+DzBOdL36e/ryMMirCAmgVhzmX/7X8TKo+4JJRNLMA=;
 b=wPxT3cI5yztXDDlr9fDOwMp0xWtimgiCTTs1yCvPWPqgpWp9eqHt3aFIBrWfwteoLbssRmZw/pXA9xfGBAbpt3Iyho6HR2icftdx6xq/epqX1B+vBSLb7z8SWDPcKwK4omvIXpbMi21SkMudCAL7GW7KeFQCRANAPn8nixXvXOj6OVdAkb6axpFo/sA5mEztUdZlbhbdMvjKST1C15eCHfb+bxrZbL1aq+LxOvP7rjJvdg10ctcAO17cir7jBZEacAfIQNKwZjovOA4AcEPJzqUs3vEvm2xTyDSrDLgEZRzQUmXA+ZSYv9LhSsrA1/cpC0iXcRavE9U9mPNRlt6tlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+DzBOdL36e/ryMMirCAmgVhzmX/7X8TKo+4JJRNLMA=;
 b=aUvZ1HWJeanCcQrXY7eO7lp8BNB8z5Hzgn9oylZlDmxUa9ktqKYqfrQAoH5gJP/O01KjzbfIqQpj0I+Qp4+2kgEQ14HscUgeviHmD99Nqy/LXw/fLsJDfgG7BWZByDab/pZJ8c5KSsqh07JATwH/NeFnBfrtVndxwmVBwQ1RmgY/ugoCP5rSG+eOORG+jPV8LPgC55BjI2H5NwkOYHx66yPs1UXtgH+a0XoZOjSqn2aGnzgb+Qc+RikUxwG3gm5cO3V7R7Kfb1QFF1+X5XKcU07gjecQD7HT3yNr6uSsz0/bcEaCesedsVvs7oIsgo41wZf53fXrmbni7RJR1e6x/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PR01MB9113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:cc::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 14:19:29 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 14:19:29 +0000
Message-ID: <7bac6a0c-2645-43b4-9b63-b9cd025d9e1c@efficios.com>
Date: Sat, 7 Nov 2026 09:19:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] locking/rtmutex: Clone a waiter's sort keys as it
 enters pi_waiters
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
 will@kernel.org, boqun@kernel.org, longman@redhat.com, rostedt@goodmis.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, dvhart@infradead.org,
 dave@stgolabs.net, andrealmeid@igalia.com, shuah@kernel.org,
 juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
 <20261106235931.1478800-4-mathieu.desnoyers@efficios.com>
 <20261107105704.GB2668564@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261107105704.GB2668564@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::6) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT1PR01MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5ea37e-5e04-4b90-89e4-08df3cda229e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|56012099006|4143699003|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DO0LWa+j+fYDK48TO9m1aFOyUlGzdqDHAFYJg5Ehvd3h38FwVjAJbAogdzabblkFKg5mzR4+w5Jfqz6bBZ90/6sBvhAK8QnQpsjPUJrrVfgzU8YSm7CpdNC3KIbPXE3lECHmRJ3ktu1W1VMFjA0cc2DmsQk9+tMo/ju/5ppiFL69zH+jfyjCFpZeony5BT7+fSYA7nmojcaTXUf3kzwtBzy7jQ65+uVKw/1RiC9m+r0MrdTQ7koKXhPXUI5oD0HQTliyTvJJpN+pEqlYbugntlJ19Uqw4gsFmlXek3AccHYbg/MyuzPN3ZCulRGGdYsntPdxsZ2Te9C0zKYYWTwe31SAt/5+VhDSF46oJWJkuwq0OiNPjaOi8ASxPz1lZR+mYvE52wPADrcmhTkmoelwLxLO7vCq4rLFjHhOBmP755WS72RzqrA71RUZ6vetdJiyYTKzsPLaCYeYFGoQpTWBSbgDQzwuzqd5tpSh9yuluUchk+4Bdn0Im8rCWyoNFjmKLhRk2SNL91r3G0BhpzJPNhKqtIMLZh9vAjfGfqpm1WxpDxhwJ/Zwsg7SPZu7IZBFlZ3vc9ubkOx6K1qV86CptimUy9qbhpSxgvVx/dp2UK1Di2fousgaLgGnHhgU8PeztfsqfJLeOPKNDhrxvkym20roUBCry/d3lMVnk9WY7ac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(56012099006)(4143699003)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dldWQVFaZ2wxNDVvdGlVWllvbklleGIxblo2YUxzSmgvTUpBTTBaZ1R1VDdt?=
 =?utf-8?B?TmxuT3c2YmRIdWM4WjQyUVUvOWMrdjlRWjNrNEpkamRMT0VXbFdHaVZFMzlS?=
 =?utf-8?B?MWowU1ZEWUhTV3ZCZ2ZaSkpvVzJZdEdLbXgyMENsRDRYMEUxMEhHZ1lpaG9I?=
 =?utf-8?B?ck11bE1NS0FraWZDd3dUZmtOcVMrTnU2YUFZb2hKZExaeGV6NTRrZVBSNXhk?=
 =?utf-8?B?MXppRGlWa0R4REtCb01pMUFubzBtOVFnNVR2dldnKzhjYXF3YkN2YlRhN3pk?=
 =?utf-8?B?STNqSWZFdEcxcitvQkx3cDNvR05VSkx2OEpJL2xBY2JmeWVQUmdpd3RpQUw4?=
 =?utf-8?B?MjFTSWxmaDJYUEo2a2ROZ3FWY25zbS9YMVBGTjJTNzJoc3k5dW9TRlExWkRj?=
 =?utf-8?B?dmN5WlBnMmdQblI5MkRQbVR4SVBsR29leXloWnN4cDh4Y08yQU51R0dGQ0FS?=
 =?utf-8?B?Q2diL0VpLytrTXNCK2lBZWFzaFhvTjNzeHhDUGU3ejdXL1U5bllzWXJJQ0o1?=
 =?utf-8?B?RWRDRXAyWEc2TUNGZ09kbGRlMVdYUFNEK082TVBQMkpZbWY2WHpoeGhCYkgw?=
 =?utf-8?B?MGFrSlFjR1I4YXNuVHQ3WWd1ckt4UTN3YThCMlcwL2lBYmYvbHpNT0RwL0w4?=
 =?utf-8?B?blgzYkY5QjhpWU51eGg4STlLMzFnOFNLeUdNMnV0QW1xemZjcEoxRnBZamdX?=
 =?utf-8?B?LzJSNjV0TzNDdnMvWDlxQVNXWEZmdGg5aC8ySzlUd1BjTURKSm1mTDlvQTRv?=
 =?utf-8?B?QlZKRkcyaU5DbzdJTDI2U2tYbVI4b0N5OUpxZWpFNlY2Yzd0aGlUTWZoVVIr?=
 =?utf-8?B?VmdEbXcvZlFuOE8vQjE2c0RBNlFtL0xrWlA0WnVJcHk4Tm5UV3V6NVduUTd0?=
 =?utf-8?B?VXJieUtES1FsS3RaaTNJZThVaUdEaElTT0h5ZDFXSWJKV2ZWMnlGc2VmcXpu?=
 =?utf-8?B?c2VFcFpnd1lIOEVkT3JPRWFac2R2emNYZnJLQlN3ZnVZV1EvZWVyL0JZVEpF?=
 =?utf-8?B?WjgwVjQxQmMxTktJVTZUTFk5bnJ5ZS9nTlBGT0hCYlNGRTJsbGlOVy8yVnhl?=
 =?utf-8?B?Y1pSSG15QmNTNXFhMEhLbTBXT1VrNzNEU0NtVHk1Mk05Qlo0KzZCbi8vc3lZ?=
 =?utf-8?B?OXlnUmQydFQ0VGtMOEo2NGx4SnBhT2FCSEEzbExTUTFwNitVYmF4SktlTlZS?=
 =?utf-8?B?SThZa1N5WlQ0SmRvWk1xTVJ0VzJYSXd5RHdBOG1LbVhmb1hEeGFIcjhMK29K?=
 =?utf-8?B?ZmpiSUhBa091TWpjNG1oUXBoeVpRWUUxaTBLSnF3WktVdDBsRHZnT3JmazNH?=
 =?utf-8?B?VUlBclNEUXhtWU5GSHh0dE82Q08rQjQ1R3NwTnlieDJQYW5ma081aTdVbnFI?=
 =?utf-8?B?U0ljemh0MmwrNFlpYlZCWUkrSHpFQlVWZTNDTWI2SDNFR0JpUFFPaEM1cXhE?=
 =?utf-8?B?eFZOZnQvaFN0M0tCcXZzMjlIRjJYaGN2MTI3WGRWakZZZ0lpS1B4RTFzZWsx?=
 =?utf-8?B?MTh2NGg3N3ZYTlRTK0N0RXpuZmVFRDZJbWZNWDNSVXpuVnc0amhPZXV1N2Zj?=
 =?utf-8?B?RnBTRi8zSmcycVk1UGdyaktFalRRaGdGQi9kTC8ya1UxT2EwNG4xak8rakNh?=
 =?utf-8?B?QzhoREt0Q2l3WEpUcFREVi9jKys0bnZaRHBuTFB6V0hDdGxXVGU1R1NDL1hl?=
 =?utf-8?B?cDI0dGRSRWZqdUlET1p5bnpuWWhtYm04V1dhajREOVdBS0JkTEkvZXFnR3dC?=
 =?utf-8?B?Vy82V1B0UnhmTHNjR2VCOW5yeExkRWNDSEhBYjB2UnBZUEdGQWdRKy9vVUMz?=
 =?utf-8?B?bjh6dGtYYTZpSVozd3lUN1FZUk9JaGQ1VmdiUWNZK25SQ1JsVWgxUnlwRFA4?=
 =?utf-8?B?bjMyNWNPRlRwbzhndXRrakZZbVJRRjNqSDQ2R1JhNkVQd01HMUQxck1DaldU?=
 =?utf-8?B?bzM1UU1vbFlaZUROYStIZXZickVBeXdpSXp0MXBIcGlhWUNTNVZBYXk0bFlI?=
 =?utf-8?B?M2s5Q01nVjFvNlBIUzAzNFZvRE5WbW9EVEtIMkF4MStTb2JBbEtscTlueUg0?=
 =?utf-8?B?N1pjVGlpSWMvbzk5blFKK05vU0I0ZWpMc0dCbFJWUmZua0o1cFdyaGZ3RG0x?=
 =?utf-8?B?RjBCZlVCRWwxYXBsUjh5R2tjbk9LZWZvL2c0N2U3VmgyL2plL2FFOXl2Nk92?=
 =?utf-8?B?bHFRbjFaQ29GOW5NZzJZQko2UzRxa1pnY2g1SHdhcTFlRk9wY2pUQmxkbWp0?=
 =?utf-8?B?Q3l1TTZmVXg3aEhyRytnNVdodmpiczJVWUgxNmJkRnBiRGo5Q3hvOEE4ZEJs?=
 =?utf-8?B?eXlFdlVmWFg3NElxTFFkRUUySUdERXNEeWp5ekVOQWhUU1hlbXpiTDJMTEJM?=
 =?utf-8?Q?wy5tFlpbmfCHD78s=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5ea37e-5e04-4b90-89e4-08df3cda229e
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 14:19:29.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQfiE1EpX0JKjUu2vLcPna9mGFKRkaQRKwFC/BgeY1+vrmZaK7fpxiUIadgECtRKlCEHWn9TJCusEY9wIo4sUKtrhWWHyQmjDxBNYj414BU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9113

On 2026-11-07 05:57, Peter Zijlstra wrote:
> On Fri, Nov 06, 2026 at 06:59:29PM -0500, Mathieu Desnoyers wrote:
[...]
>> @@ -1243,7 +1249,6 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
>>  	waiter->task = task;
>>  	waiter->lock = lock;
>>  	waiter_update_prio(waiter, task);
>> -	waiter_clone_prio(waiter, task);
>
> Reverse engineering the problem leads me to think this is the problem
> spot. Because this is the one site that is not immediately followed by
> rt_mutex_enqueue_pi().
>
> I'm thinking there's race due to dropping pi_lock between this copy and
> the subsequent enqueue?

I don't think there is a race there. task_blocks_on_rt_mutex() holds
the wait_lock from this copy to the enqueue. waiter->tree only changes
under the wait_lock. So at the enqueue, waiter->pi_tree still equals
waiter->tree.

The problem spots are the two enqueues with no copy before them, in
remove_waiter() and try_to_take_rt_mutex(). Both enqueue the new top
waiter of the lock. When a waiter's priority changes, the chain walk
updates its waiter->tree. It copies waiter->tree to waiter->pi_tree for
the top waiter only. So a waiter that was not the top waiter can enter
pi_waiters with old keys.

This copy goes away only because rt_mutex_enqueue_pi() now does it.

I rewrote the changelog and the comment. The new version of the patch
is below. Do they read better now? I would like your feedback on both
before I send v2.

Thanks,

Mathieu

-- >8 --
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: locking/rtmutex: Clone the sort keys in rt_mutex_enqueue_pi()

An rt_mutex waiter has two copies of its sort keys. waiter->tree sorts
the waiters of its lock. waiter->pi_tree sorts the pi_waiters of the
lock owner. Only the top waiter of each lock is in pi_waiters.

When the priority of a waiter changes, the chain walk updates
waiter->tree. It copies waiter->tree to waiter->pi_tree for the top
waiter only. A waiter that is not the top waiter keeps its old pi_tree
keys.

Such a waiter can become the top waiter later. remove_waiter() does this
when the top waiter leaves. try_to_take_rt_mutex() does it when the lock
changes owner. Both put the new top waiter in pi_waiters without a new
copy. So pi_waiters sorts it by a priority it no longer has. The owner
then inherits from the wrong waiter, at that waiter's current priority.

In this example, O is the owner, a SCHED_OTHER task. L1 and L2 are two
rt_mutexes. W1, W2 and W3 are waiters. Their SCHED_FIFO priority is
under their name. T is any other task. It changes the priority of W2:

   T                         O                W1                            W2           W3
                                              FIFO 80                       FIFO 70      FIFO 50

                             locks L1, L2
                                                                                         blocks on L2
                                              blocks on L1 (timed)
                                                                            blocks on L1
   sched_setscheduler(W2)
     W2 now at FIFO 10
     rt_mutex_adjust_pi(W2)
       W2->tree: FIFO 10
       W2 not top: no copy
       W2->pi_tree: FIFO 70
                                              <timeout>
                                              remove_waiter()
                                                rt_mutex_enqueue_pi(O, W2)
                                                  W2 sorted as FIFO 70,
                                                  ahead of W3
                                                rt_mutex_adjust_prio(O)
                                                  O inherits W2's FIFO 10
                             runs at FIFO 10                                             still waits

The owner runs at SCHED_FIFO 10 while a SCHED_FIFO 50 task waits for
it. This needs no race. Each step can come long after the one before.

Fix this by copying the keys in rt_mutex_enqueue_pi(). All callers hold
the wait_lock and the owner's pi_lock, as waiter_clone_prio() requires.
Remove the three copies the callers made.

With this patch, the owner runs at SCHED_FIFO 50. The
futex_lock_pi_inherit selftest added later in this series tests this
case (promoted_waiter).

Fixes: f7853c342418 ("locking/rtmutex: Fix task->pi_waiters integrity")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
  kernel/locking/rtmutex.c | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 323973be2074..975efa1d864c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -517,6 +517,8 @@ rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
  {
  	lockdep_assert_held(&task->pi_lock);
  
+	/* The tree keys can change while @waiter is not in pi_waiters. */
+	waiter_clone_prio(waiter, task);
  	rb_add_cached(&waiter->pi_tree.entry, &task->pi_waiters, __pi_waiter_less);
  }
  
@@ -1005,7 +1007,6 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
  		 * and adjust the priority of the owner.
  		 */
  		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
-		waiter_clone_prio(waiter, task);
  		rt_mutex_enqueue_pi(task, waiter);
  		rt_mutex_adjust_prio(lock, task);
  
@@ -1022,7 +1023,6 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
  		 */
  		rt_mutex_dequeue_pi(task, waiter);
  		waiter = rt_mutex_top_waiter(lock);
-		waiter_clone_prio(waiter, task);
  		rt_mutex_enqueue_pi(task, waiter);
  		rt_mutex_adjust_prio(lock, task);
  	} else {
@@ -1243,7 +1243,6 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
  	waiter->task = task;
  	waiter->lock = lock;
  	waiter_update_prio(waiter, task);
-	waiter_clone_prio(waiter, task);
  
  	/* Get the top priority waiter on the lock */
  	if (rt_mutex_has_waiters(lock))
