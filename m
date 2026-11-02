Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793600446;
	b=HfyJb5+Xeeun02l/1Sj1G+Hs+tV7Y2Pwyv4gNFwghAOMvm2imAIatf4KDHe0BIWErGKT
	 HU5K8PUqaydR1QCt1pXtyzzw3oQlG61mLe+Nmf/kJx+y+EpPyV7PeeMDTYUQTgPnOJLe3
	 X0mZug7jsa9taaWzrahBurbyOvP9qJDgkiUNDwB7v6YOpjNhp9wdVuKaMejxtikRs0U4I
	 CfZHGZehP0iWwl5KZmfryJwSVlGp+WpVEPHb0OFzPVJg8l/GOwlE+qh456JIFjF3NSm7D
	 sKE6azVY9fCEUY4Q0oLuNv/qhz3SFe4GXHSgiM/ooqXqjvLPcElxKFj8wk1nR0P1yQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600446;
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
	bh=QRpZvifyIXXkrc2I+m+B9rAZp0uguA0rKZYYfsrGugA=;
	b=eRGe49n+51s5UxlPZIfrITeMH+XOQWDV7tuVb6iHMWhVRoPzW6SsOpvvLnEbjdkBImQi
	 NDBZMNCR5dNJ4lv8nfPGwhvdoa25K3EOwI7h8B1rjEclhVX6lbSsupgtKDH8Uy8ECzbWJ
	 LoRmUB7lebZyPOjCK56RmqIeUYJfCr216S/4HgmEJjNrwjhNgT9jj6jNp0FL0/f5BWh4V
	 lU+TA/l3DdyzD65fCvtv1JkwcGGlYeze5VrE4fx0URjDzSeiiGR2IDw2+N/dwZGJlEofh
	 xbCfLyIMH+aEmX0w3nHqZisYahsPOEi+TpvZmMKmFUR/tFkIrOuWcDfkahD5B++STFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mS172ct+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.22
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C20606A326;
	Mon,  2 Nov 2026 06:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81C20606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mS172ct+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNQsmRATqrtjY9cWI0SRT3RmK8p4W0LhFesl9haJU//TuwTHniCKcMzy1JDjXJh5dBtWtk6QmV5ALznf3PSLs67SZ6WXN9vzapziSHTdS30b/GxOvIVY5kKNL6QqQEq40qOgxTON2+lg0ldhaINwXKKNI+QcdpYnH0M2RL0wyL7UFqnWeYDgZvjoNMg3p6L1CoxPjIST/JsfPqCEm6IjCWO42SPMkrD+qmjiXMMybGp4VZCXxv6nUfo3in58yUp1X2Xg4fMTW6MtbSia2O3lm5XgYifovVM76fhVKe9oLCRPSSXVmggPIkDNqUFG3qV1aOgP9+ISZE9y1s3e/pQdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRpZvifyIXXkrc2I+m+B9rAZp0uguA0rKZYYfsrGugA=;
 b=s5ZhArANxEe0xRBjVELIJVYlwD3X4z01pX3WjhKBAlMq86VyyC7tSn28YTBfv0ME8tiwrANnQep0HwhTnqeQ/CS/t6azpC0zc4KFIKQedaNnwVGoLI96zWOr7aJtwdfNKSW7eGDIJyg361E82HJHl2nQ67mL5dze5YK+FAWk5FVw9N9CqBdEX8tdOwGDIMfMG00KkPMsQSxFGa6L3FxLQzDyCWm9ulOhc654WXSIqBf5HRJ8ed2EH7b52mbmJPNImh/bVeVMjcaZGUMnuEuA2Xmn6bd51sDdpuA/xC1O4bCb4eOzd23Iqy/K/gbF5R8MJ3FHwouJ05zb5XYWCl1sQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRpZvifyIXXkrc2I+m+B9rAZp0uguA0rKZYYfsrGugA=;
 b=mS172ct+ecoWXylGdozFSYVkvjyXjDUXTo5pICTKa3YnJqevmiPn7EQu07Yf6oqrQ/MsoWQ8PQcG4rffejBe++Jzm6LX4AqJ8CjgQwXmgqhSgiguhBsKdH+hMbWPUjUzw6FjRKnHOhGrbpLVDaipMp6/7AC8L2y7LJZ6BVPulbI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9804.namprd12.prod.outlook.com (2603:10b6:408:303::8)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:20:43 +0000
Received: from LV5PR12MB9804.namprd12.prod.outlook.com
 ([fe80::cab9:7e9a:fc29:bcb2]) by LV5PR12MB9804.namprd12.prod.outlook.com
 ([fe80::cab9:7e9a:fc29:bcb2%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:20:42 +0000
Message-ID: <cf369d2a-3e3c-418c-8a36-219fdfd485ec@amd.com>
Date: Mon, 2 Nov 2026 11:50:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] can: xilinx_can: enable NAPI before starting the
 controller
To: Patrick Zhang <patrzhan@amazon.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261030233330.3483988-1-patrzhan@amazon.com>
 <20261030233330.3483988-3-patrzhan@amazon.com>
Content-Language: en-US
From: "T, Harini" <harini.t@amd.com>
In-Reply-To: <20261030233330.3483988-3-patrzhan@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::14) To LV5PR12MB9804.namprd12.prod.outlook.com
 (2603:10b6:408:303::8)
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
X-MS-TrafficTypeDiagnostic: LV5PR12MB9804:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4c745a-00a8-4e9d-f18e-08df38a96c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|4143699003|11063799006|5023799004|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ns4h+crO29bTiy9wxPQQZPNceGZnZvHFAld8YxLiUzBbeVBUuqW2lerj4+NVOmn4VxIGFtHa5HjYah0Bcc4iG4cv2Pi6S+uYSZzfia1qbuDmy/omUplZM48fyxu3qXSeAKtPcFJeR8peWV7QTZhZYUR61PQKZygxN9ExN0dbD2x6xcjeGXgq5Y3nbVx61A6JgFsDlk91f9/EKI15JmjKJDpXUvEPj1bQPR/sI4tOr9mjyhpsfmMjGRTLl2oN+8xP8RTY8zj4HIydxwGg9baoG+Lj7aYWaB2J4u3Vwoqb/Kp5GmYIMip+RNq/6p9p3/s9tHI10AFsEOnHcLyB1sHwmrR31d+WrrLDRpBluwJawlNJP50RUh4UMqn3NqzyPd2xlXZKAxYKwZfM3PJJUOD0vX8bbCrq56yMrTyENL4RQIJ5y/PzMKz3wCWPNiOMxyqsXpIIapVKoEUzU9mjjKe09hxlfWVRSUNuXam7r1ESavN1XXcYFd4YaCtnESMy80m+Sg3m3t5qagPneS+UeqE++MsZylw4HrkIuHgYNvu04Yw+zjZppyCdWTFOzbMVCg1xxcGPIhEz6LpTX2Yeethpuq8a7EaeEz9vxdh823/AeOqmKIfT3Ik+RH0DqeddH79Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9804.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(4143699003)(11063799006)(5023799004)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVZEajRBSWh0cFB0QWdZMmIzVGJRQWJkUVNPdzVEMEgrOUt2QURKaWliS0N0?=
 =?utf-8?B?bDNCa0J1SmdNdkt6OFB3cDJNMnRCZE9nbGxJemtTWUdXZkMzbFJVcldiejFx?=
 =?utf-8?B?bDZVbEFPN3pvTC9sL1JjV2lLbS9FdGJhTDlZUlc3bDVodjJET2MxNzJDUkVN?=
 =?utf-8?B?SnRxNGtmSzZkbzh6YmpoY1U4bEs3SWVYdG9USWxadEF5bjVYZGpHZkdaUlFG?=
 =?utf-8?B?V2Q0dDZSU1Q5bGw3T2hrYW5xWmExTWgrUHdwV1BsQlFWVXRlVFBXS3ZFQXl6?=
 =?utf-8?B?Nm5PRlNXUU9xN05ULzh6S3lpVlgyb0dEQWhsdDJoMitHL21kTlJza0lMTXNX?=
 =?utf-8?B?SWpncklvQVVveDh5aWZ5WG1ZcG5obHZzeDI2RW5Bb0krNmJ4NUpVS2RkOFlX?=
 =?utf-8?B?b0l6LzJnTlFaSzR2bWEzQ1gxNGs3eW1SQkQ5akdreHFJejVqeHFVb2NuRDlk?=
 =?utf-8?B?TDBGeHJKcHFQdkhVVUV1T1g1Qml4Q0pibWE4SEdkeGVmNjdWSFhqWkkzZW5U?=
 =?utf-8?B?UVNRamgyTnNveWNsWGRxWngrd0lqUFppUm9wOFBnOG43TEFmMVhJRW1TV0ps?=
 =?utf-8?B?UXFIdWVCYktSU1htYU5WY213MFh0Z2pUVHA5K1VncUdxRHFYTjVXWHBoVCtR?=
 =?utf-8?B?TytKRWVTM2FMMzhTeXdPcjJoSFg0WiszSGRDSGNuek12RlU3Z1YzN2RpQ2k4?=
 =?utf-8?B?Ry8yazQwWDc0NFBYOXdjWWdWcXNGY3ovSlpFZDBGcWlNZC9ZSFhDOWNBeWc2?=
 =?utf-8?B?czkrQ3ZGWUtpM25HTFBvTm9BcklnWDF4NTI0Z0dLY3dHT3c3TklNRm0ySWFl?=
 =?utf-8?B?ODY3TVM1aDNSVFNZM2EwZWdZU2pMdkhrcE82NWFyQzFsdkVzVjB0UDlaVGtJ?=
 =?utf-8?B?YnZZUXpRYlI2NTllSzJjSmgzb1hnN1paTTR5eTV5aEtBZ3gyUjJ4OVVEMkMw?=
 =?utf-8?B?cTg5bElDOWxLMmFnWlp2MnROUUhiOTFqa0tDZHBweFhSejBNWWNjcWVEQzJD?=
 =?utf-8?B?ZGQ2NlAzUS85ZktwTGZhR1pMMFNDM0ZSNmhMd2cxY05lblRJV21xZExVaHUz?=
 =?utf-8?B?K2FRZGQrTWRWYm5WbjA2VHJONzFISnkvRVo2WGg4eHdnbnFIdFg2bzZadERX?=
 =?utf-8?B?cnRTTmFXM1YyNHdXeStIU3hrRHd1YlVJOW5QTVNoS1U3dEt0UjdNMU1qbGU0?=
 =?utf-8?B?cDU3c0MwaFJnWE1MVXU3TjBteVZTQ0RXSGQrTVptNlg5NTdmSjJia2k1dWtW?=
 =?utf-8?B?VVVpS1FtVVdQQVRmUTV6aEdZNmxEYkw3aFBRVWtJeHEyYUV5am5FdzY5cnRG?=
 =?utf-8?B?VDNnZkE5MGlNZDdVOTJMVnQwT0VaQkpjRzlKK29nL0JsbGZFaldYWGQzbjgz?=
 =?utf-8?B?cUV5L1VUUEpDTHhSQWt4cXFMRVU5dDhvWDREWTBCZnFEZHN0Ynp4blRKWDdD?=
 =?utf-8?B?WWVDZjNIN0ZIdmFTcEs5M1BDNXE0RFJ5Zk1MUVFoL2ZaSVVxZXZMdGlVcnlj?=
 =?utf-8?B?aVhzLzRNQ0EvVUp0cWpLU2pIWUM5Zkl5TVVmS3N0WEpwOGt6NnVnSEVaaG5n?=
 =?utf-8?B?c1pwcm9FaFBVWSs3Umwvemc1UGJWNlFGM2pmUkJRTjBrME1yNmcyQk9DVmNP?=
 =?utf-8?B?bDdiOTE0N25ZK3AwV1MvRWFTQmJucThhRy9zWHUyeDh0blh1S1ZJa2pENTVB?=
 =?utf-8?B?cDR1bUVrK3VOc3Z4TDNzVFg2cDBxWm1LaWpyWWtlc0NZejNDaW1vTWZiL0ZS?=
 =?utf-8?B?STN5ZmVIeEtYeTIrQzdPUWgwcWc2Q0FYRk9IZ3g2U1N0YWR6aDV3azREZGs0?=
 =?utf-8?B?b0wwRXZiV1FOUHl0R3FYUzZ4QzNBdkJUa1dLRUZZNW9FdmZnRG0xZzNXcEhJ?=
 =?utf-8?B?WGhqZUwrNzBxRURtZndmWFdjYlRWOW9PUWxBN255K2JsWjFXcTBubXduNU5q?=
 =?utf-8?B?Yy9veHhTZEx4bWFXUlNlVlpKU0JDbld6RUNrd29kdUlUcDVJSzhwYlhWa2xO?=
 =?utf-8?B?MlQxSTB3aTVnNE81bHA1emJpZllkUmFRczJGZmloRmJ4ODJoUG5JM1VsRFk3?=
 =?utf-8?B?eVlvQzQ5MHFwaUdSUVZNSXhOanBsWjhYeExJQzV0eU9SYkI4bDJ2N3FIRDI3?=
 =?utf-8?B?VTYvWldjY05WT0JrQWpvYVZDdUR0dmR1eVNISDhvZ0tKYXhHdTJJRlEvN1BC?=
 =?utf-8?B?aWEvbEFwdk5xZ0dCUG5yUStDYWFEbnM0RFNRMWhiWGpZZ0U2cFdrMDJueURw?=
 =?utf-8?B?cFFoeWsrb2c5NUt0NWhGWllVemVxRUxsbGMvMUk5YkxaeUljTGM5RjJFeC9q?=
 =?utf-8?Q?NhSFFiqFgUX+uBTu45?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4c745a-00a8-4e9d-f18e-08df38a96c12
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 06:20:42.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aD7Mx5vRi5LZvbzcrnKts3yfjh1W7uLUWJCtQjpgwVJTTZ+EJKDOFvHXxzPSbly8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746

Thanks Patrick,

On 10/31/2026 5:03 AM, Patrick Zhang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> xcan_open() calls xcan_chip_start(), which writes XCAN_IER_OFFSET to
> unmask the RX interrupts and then sets XCAN_SRR_CEN_MASK to enable the
> controller, and only then calls napi_enable(). A frame that arrives in
> that window raises the RX interrupt. xcan_interrupt() clears the RX
> bits in XCAN_IER_OFFSET and calls napi_schedule(). NAPI is still
> disabled, so napi_schedule_prep() finds NAPI_STATE_SCHED set and the
> schedule is dropped. Only xcan_rx_poll() unmasks RX again, and it never
> runs. The interface receives no data frames until the next close.
> Transmit still works. The RX overflow interrupt stays enabled, so once
> the RX FIFO fills, xcan_err_interrupt() counts rx_over_errors and
> reports overflow error frames, but nothing reads the FIFO. Every
> re-open (ip link down/up, a driver rebind) runs the same race again.
> 
> The window is only the tail of xcan_chip_start(), so the failure is
> rare. Adding an mdelay(50) at the end of xcan_chip_start() makes it
> reproducible with continuous traffic from another node and a single
> "ip link set down/up" on the test device.
> 
> Enable NAPI before the controller starts, so that an early RX interrupt
> can schedule the poll. NAPI can be enabled while the controller is in
> reset, because nothing schedules it until an interrupt arrives. If
> xcan_chip_start() fails, disable NAPI again. Otherwise the next open
> would call napi_enable() on an already enabled instance and trip the
> BUG_ON() in napi_enable_locked().
> 
> This is the same race as in "can: ctucanfd: enable NAPI before starting
> the controller".
> 
> Tested on a Versal board.
> 
> Fixes: b1201e44f50b ("can: xilinx CAN controller support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Patrick Zhang <patrzhan@amazon.com>

LGTM.

Reviewed-by: Harini T <harini.t@amd.com>

> ---
> 
> Notes:
>      v2:
>      - Correct the commit message: the RX overflow interrupt stays enabled
>        during the stall, so rx_over_errors is counted once the FIFO fills
>      - Name the ctucanfd fix by subject instead of "the previous patch"
>      - v1: https://lore.kernel.org/r/20261021205924.2538511-3-patrzhan@amazon.com
> 
>   drivers/net/can/xilinx_can.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 43d7f2282..5c2412bf9 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -1570,18 +1570,22 @@ static int xcan_open(struct net_device *ndev)
>          if (ret)
>                  goto err_irq;
> 
> +       /* Keep before xcan_chip_start(): the ISR masks RX interrupts and only
> +        * the poll unmasks them.
> +        */
> +       napi_enable(&priv->napi);
>          ret = xcan_chip_start(ndev);
>          if (ret < 0) {
>                  netdev_err(ndev, "xcan_chip_start failed!\n");
>                  goto err_candev;
>          }
> 
> -       napi_enable(&priv->napi);
>          netif_start_queue(ndev);
> 
>          return 0;
> 
>   err_candev:
> +       napi_disable(&priv->napi);
>          close_candev(ndev);
>   err_irq:
>          free_irq(ndev->irq, ndev);
> --
> 2.50.1

