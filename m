Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156F33D4E1;
	Tue, 14 Jul 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043362; cv=fail; b=lBihxhIIEPKSXwJnc3jymIbsEGQzj9+3GapmDzuafI5y9BO7GRCvxCO26cFduOsZw8m4prW31Int1Ebs2QU3Gmq5AWeywi71n+Tg3/KEiFPMGWAcxX66JM6mDcvk8T6HI4iFAW0x2Dj3Q4OQlF8iu2ftb4z55q3ydnqqafGl5gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043362; c=relaxed/simple;
	bh=WpH3NLU37o+Ik1z8E+FXoUcvY/TFexq5Ir1qFQSpfZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ciItMMQapDGavvYi+klgPAynbd4+FS763oyLlXpkN5wMlrxFJDT5ZYedCCPICSTtZ2i5fBCWU7uXf5+Z1IEVy4zOGdijqjwi8wiJJjR3QCEQK7f8KOc299DaiRXxOB6a70HeAK5lMqJ9OryMmystGEBqyHT8Iy1x9e2YpPe+XYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=weidmueller.com; spf=pass smtp.mailfrom=weidmueller.com; dkim=pass (2048-bit key) header.d=weidmueller.com header.i=@weidmueller.com header.b=8A5iqNNH; arc=fail smtp.client-ip=40.107.159.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=weidmueller.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weidmueller.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weidmueller.com header.i=@weidmueller.com header.b="8A5iqNNH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFOeHS1ZqTH6JmzrKmAZ6FCqi1cELqpk3FvC7d327hML+rr38Rm8K0+Cw/ljZPvjETosthTnMmkWsA9ZAIRJALOd7FvcFAwd49L6hLNmG6IK6q2jxrpchmW/9zUCFd0D8AxY3ACJLPF1R+6T0jNuBCiC/brvcA2kfyOSWjRpUuEfi88x/WT5pvpOk/WIJTy+gMssqUVvANkNnMMlgk7hoCUT1KIKULTOTVcXYPhuacEYl37HBYPM7GEZLvffLq641CvhMJPot9glhkX61QT3wGZRF0QuuTuj/OierNhn0zf6dNRz9P9OKLMBVxV6QjbKeKZtHaRwtrLVEAUqlN+gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEfo4KwCZXBUT/e2NXE8bgL39yxiza8RzVGAN1Ulbhs=;
 b=d1mOgSxgnCuCVSdEnhpmFWKZjDK/wInIYmdrsgCLnlvPB+yXzvh71EtAf4x5/hmU5B709641q7cgQyDBtgxn9ynUcnuFOJ6YpE2sDFgsV5/nJl7whNb5S7kDTeq+zLCxjAVBHy1I4pL6G7fXDBNT57NSrTBp/wilKMT64BAyhkQB02YR5xggjKR2pWhOlK78m6uo3L+BJiha5j/no+85EFXShzAFStT9AUxWvl2gYWOfKHQRB8IWg7DuzgbAY9jAa6yVY4aDPEE+iKMeJDcBu6vAKwu33iKSXm8Gv98+KsW4BmbY5PHhNw5YKOux+5SQXc3B8LOt/mhCGRC0DHXmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEfo4KwCZXBUT/e2NXE8bgL39yxiza8RzVGAN1Ulbhs=;
 b=8A5iqNNHpQGz5P+Qn1yc+pXyn1wlTOx7h+VnPrDTFiS9pcYu+nq7Qa0gSIHueP0D/jNCrYfp7KO7fKWkiy7qhutYh5DMp9Is0A2B0Ft2SZkte/PQPaHTfJSSEasNoSiahBWPPK7sQJhXYOvpQFgfMToWre2gk9sB/lDoz/cs5D+gd/SNRYSTlF+Lt/LzHQR3S7aFG4qVyqe4q1nDcwOTG0jaSUgW9CVrrQ66yg3iDZYh0ftWCHlv347nGkOrNJC3I/TIUka5+QvxfoSdns3liA5Z64qrJmkwmNF9SL8rrwyNkk2oH7umcg/DYiDR5fUE80OpbEEwW/CVYDu36Fmcag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com (2603:10a6:20b:578::22)
 by GV2PR08MB11393.eurprd08.prod.outlook.com (2603:10a6:150:2a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:35:51 +0000
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778]) by AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778%2]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 15:35:51 +0000
Message-ID: <52f6b231-7351-4dbf-92cf-459f1f19d150@weidmueller.com>
Date: Tue, 14 Jul 2026 17:35:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the TX
 ring on link-up
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Kevin Hao <haokexin@gmail.com>
Cc: christian.taedcke@weidmueller.com,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
 <akzDQrmdYwHAMMmw@xiaowei>
 <8d53c3d9-7918-456c-8c27-e9d73c896452@weidmueller.com>
 <ak2-XJHVc3Cg6ZEk@xiaowei> <DJUXYXEQMUJ4.31H82KQMG29UC@bootlin.com>
From: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
In-Reply-To: <DJUXYXEQMUJ4.31H82KQMG29UC@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To AS2PR08MB9199.eurprd08.prod.outlook.com
 (2603:10a6:20b:578::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB9199:EE_|GV2PR08MB11393:EE_
X-MS-Office365-Filtering-Correlation-Id: 41af9c90-a329-4062-c89f-08dee1bd95ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|4133799003|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	t7bOR/enL+kzccG2WcyLvJ2JZ6NIkyn7Zcj3lJm84Imi2ejLz16bKHOWxHh/OtKyBoipVsMc8PekcDI+if3CzhTzCSYc7ALd+Pu2KU+LOR84BFiesex8s1ulTBK8tLuDLgggxXlZ+D2qhQzPw1s2JzkgHYjfVkfWOB9BthnFDCcfMx+/HxTRZr9W6uW2KsS/N/P2Sj4PrL5QVp3EqxgiEQ5AHwCDQLIon6nuTvOoYe5Es6DrqLgn+HyaMDDbmdb+mGz6X3XBd8UieyzrUG1NzstRcpq52p15HUxvmK/qRAEfnBWekT9pfB+XTxtd439PhZriZF7UAA4CjzLR8rTk1lQJqVCWsXMw3ELoekY3WMWa62yoaloaWEyfXI0FNnKYRmwUr9qRRTLityKEPwflrA8I0Pc0F/b/K4kIVMLLpEdQ7z3mvC7sC6nLI6lJcmqEqJwFUbs8x+rgh1OIXJKuO6uiCYwHAGOkPgy9JnW3QMgm5Wp+YlwYa5KAG8usePJQZrniuioLSDPLt+iBa08FHNcB7RiK+skfe+2AbkLODUJHy4CBbqNeWEF9yd8zYxxCq2Bk3z8WEqlt0HzNBXIwH2Qq+aDvw6MEVeMjByDG4U4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9199.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4133799003)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGFINUZRNHM0V2F6Y1dic3ZQS2hEcjM1N1JkMVBEUVFKM2tyQ0NWQU5CTnN6?=
 =?utf-8?B?UWlxTWRDQUJEQTFsVThURk91eVgza1J3NjZwRCtwNkZaME44YVZCMHJ1cjNq?=
 =?utf-8?B?U24rSDJRQ0JwU25TU1VuQ1RWNVNxdGxCOG5yMStzU01JVEt3L2hhNmhwZDgy?=
 =?utf-8?B?VTBaNU5yUVR4dFB5ZStwbjd5YnQ5NmFPWUFPU0hxTGtycEdVY3NRU0dBMDUy?=
 =?utf-8?B?cHlYOUkycXhkSTNLaVEveERVcmd1Q2J0RmZ3OVdYNlN2VzBvQlJSZHYySnNR?=
 =?utf-8?B?QkNYWVJ1NjBSbUQ0S3EyN3l5RHBBNlFhN2NkRHZKTFlxRUFIZUUzV1BNTkYy?=
 =?utf-8?B?MlhXNUZOMXNUM2MrdTE0VThsa1UwZ1RQaW1PSEk2dWdBblZzVldZUUE4dk9x?=
 =?utf-8?B?TTR4V3pJd2tORWp2Tmkxb2U4VG9KMHQvK2lNOEpSNVhwNy9udFBDeUxtVzV4?=
 =?utf-8?B?V09udjVtekI1RFhqV1MrZlNraVVDd0JKNXZRQ3ZaOTE4M0FHdW4yVmN4ekxs?=
 =?utf-8?B?UGpuMjNHMDRzbFhpUGtHcEpwcVpLcXdxUU5oampwdG5PcndvdmdMUlptdjdB?=
 =?utf-8?B?U3p1SFF4bVEvU0daT0dWOGtVNmNLdGJWS1BSaVpmb2NhaitQVmM2Qmx5MW1Y?=
 =?utf-8?B?VVRUMllWRVRONW51TXpqZzNLMG9iS01OblZzVFhnVWRNMVJYVHo2QmpvY05h?=
 =?utf-8?B?WVpLOGZoSVRCOGN6YXFUTXNIZnR4MGtCN1RlOUhKaXYybVVrN3owblQxaTNl?=
 =?utf-8?B?amJpMGZwNHIxcVRUS2UrMFZ0V3lsSDFlbGxMVjdBblcrZForOUUwSjd4bDFs?=
 =?utf-8?B?RTRTYlhEd3hnTjF1VHB6YzVMbUxVc0JmUTFQT2FXSVlmV2t2L0VzQWd1SVZO?=
 =?utf-8?B?MFJFYndFL0ZPN28wdEsrTEpUaHl3bDVKMzhrbXZlUk9VOWpSVXB1bmlhbUls?=
 =?utf-8?B?NlB6WGIxS21nUmF6QnpTR1BoL1dLMzdnSDNyc2ZwbC9CYXdUclcrZ1VpWUNQ?=
 =?utf-8?B?akRHdkFoWW4vQjUwZlNraW9CNHN5Lzg0VkdlZDhpaGx4bHFCQ2tsSk00Smgx?=
 =?utf-8?B?ZVdRbloyWmZDdk93VU9lRVhWcTI5MEpST3RYbWhGcS9GYU5DcFVhYzJucUlR?=
 =?utf-8?B?ZngxQldoSThmTDAyZGk2Z1YvVHVKRHp4L00wSUdGNW9XVit2OHYvdnFnL1ZU?=
 =?utf-8?B?b2o3M3hZQ2hGdmRTWXlZdUh0QkdHeDRDK2NJTnpldit1QW8wSUJEYUtsSHY1?=
 =?utf-8?B?bTdUQ2R2Qzd6SXlOT1dIckppY25sNmZ2cFlJalFzcFg2SWhPU1kxSTJMRWVj?=
 =?utf-8?B?UzJkd1JDNkFIYmliUUZGUHVXU0FiUUQ1OU1JVDc2N1FKa0JvZjBKUHJldmVi?=
 =?utf-8?B?YURPdThQTU0zenhqY1I5b3RITU9CQmhOeFF5aHZhcm9kMUxDaGI5QVMzZlVG?=
 =?utf-8?B?WUF4N2pnUTF3NEdESmwwUWNSelRacUd2ZGNBUC9PcFE0Rm9UMFVnRS9YUDAw?=
 =?utf-8?B?VDhpZHp2ckVIK2NNSTdlY3ozd0ZHV2M0ampaZCtLSXZ0ZFRneDNiQnJSMXdR?=
 =?utf-8?B?WFR4cVNDUkd4U0J0MGgwOEFHZDdBNXFaa2FKY3FRZkk0aS9KTzYwV0NkV3Vl?=
 =?utf-8?B?NG1GbW4rNVZiL2tzdHRnNGZTWnh1QmZsUFBzR0RMYlRBRCtab2xjdlRTaDF5?=
 =?utf-8?B?OWh6T1oyWW5CMzQ2VVJSV1c1eXBCQ1lmdGNkQmZteTluWEpRU0g1NEwza3Vr?=
 =?utf-8?B?OVJHQXlKNWxlVG9uSHZlckVTVGE3ZEl4US9GRnc1ZTZwQmxnc0NlSU5ycWVN?=
 =?utf-8?B?cThZR1c2WWZYTWNtSzhaanl3eUdFSzZLQU5OV2lSVmkvZHRYZkVkWVlyem92?=
 =?utf-8?B?aUxUdWJraVlhS0M3Y2VqM0h2Zlo4KzVzUER1c2lCc1MyaXpiTkRObnltT1FV?=
 =?utf-8?B?dDNNZ1lhd3VVUkltL2VpUWNCVEZieHBFVGU1WldBdWt3WVB5L2oxNGtOeE5S?=
 =?utf-8?B?dzAxdWkwaG0yQkVHaEtNdjN6dm5XWXFTaGxqUHh0d1AxN09KNVpjcXpCcjVI?=
 =?utf-8?B?OGJFbXBVSkdTL2doejc2cU9RZEpMMU4rUG9PblR0RjhBQmJhWXRtTUc4elI5?=
 =?utf-8?B?V3MxU1JyWGVvS0ROcHFvZUNIcXk4UlNhNFllYlVYeUcxTnJoVlhkVGxSR2VB?=
 =?utf-8?B?dWNpM2VOcDE5NmxVS29Pb1Q3dEYvY3hTU0xYTkNBbDQ0QXVuNWJzSlR2QzZ0?=
 =?utf-8?B?S1IxTmhJNnNUZkFLSGtTWENhYUxRRDVqbDZZQVppS2RSdE5iYm5JTVNSVmsy?=
 =?utf-8?B?Rm5RWXBhRVBHOFBNVDFEbUlpRm5ZUXRHR1pNelpxZ0lZQ1cyV1B2S3BqVGZC?=
 =?utf-8?Q?bKeLaqYwxE3KVeDZtDHomYscjkO4+ovg1JuVP?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41af9c90-a329-4062-c89f-08dee1bd95ce
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9199.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:35:51.2633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nGnR6H/0nm9npMSM/SMsrSwsqRSK2d2FXPg7y8ejLeyZ5lQF9xAUIygln+Ok+TBCZPmHUvIzpfxmA9i3AthBCW/MNNzQPPUeaZNTKfdJjPLTKX3VqCTYynKOkgGBnUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11393

Hello Kevin & Théo,

i recorded some traces and include 2 of them here.

On 7/10/2026 3:56 PM, Théo Lebrun wrote:
> Hello Kevin & Christian,
> 
> On Wed Jul 8, 2026 at 5:05 AM CEST, Kevin Hao wrote:
>>> I agree that the TRM says the transmit pointer is reset while TE is low. My
>>> question is whether this describes an internal pointer being reloaded from TBQP,
>>> or whether TBQP itself is restored to the original ring base.
>>
>> The Zynq UltraScale TRM [1] describes the receive-buffer queue pointer as follows:
>>
>>   An internal counter represents the receive-buffer queue pointer and it is not
>>   visible through the CPU interface.
>>
>> I could not find a similar description for the transmit-buffer queue pointer,
>> but I believe it behaves the same way. From a software perspective, it should
>> be safe to assume that the TBQP is reset to point to the start of the transmit
>> descriptor list upon reset. This assumption is supported by the description
>> of the transmit_q_ptr (GEM) Register [2]:
>>
>>   Reading this register returns the location of the descriptor currently being accessed.
>>   Since the DMA handles two frames at once, this may not necessarily be pointing to the
>>   current frame being transmitted.
>>
>> [1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm
>> [2] https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/transmit_q_ptr-GEM-Register
> 
> For what it's worth, I agree with Kevin.
> 
> It should be rather easy to detect if the patch is needed, with more
> logging. Dump TBQP before link-down & dump it at link-up. The code
> expects TBQP to reset to the ring start automatically whereas this
> commit message says the TBQP after link-up is some offset into the ring.

These traces were captured on a zynqmp device. The patches in this series were not applied.

The traces contain information from both tx queues (q0 and q1).
tbqp contains the value returned by queue_readl(queue, TBQP).
base is lower_32_bits(queue->tx_ring_dma).
tbqp_ctrl contains macb_tx_desc(queue, tbqp_idx)->ctrl.
tail_ctrl contains macb_tx_desc(queue, queue->tx_tail)->ctrl.

At the beginning the link is up and communication over ethernet is working.
The cpu is not at 100% load, everything worked fine.


Trace 1 (everythink works as expected, no high cpu load):

The ethernet link goes down.

Trace from macb_mac_link_down():

     kworker/0:4-1679    [000] .N...   141.796925: macb_tx_hw_state: macb_tx_hw_state q0 linkdown_pre_te tbqp=67cd0030 base=67cd0000 ncr=0010001c tsr=00000021 imr=3fffffff head=2 tail=2 tbqp_idx=343 tbqp_ctrl=80000000(used=1) tail_ctrl=80000000(used=1)
     kworker/0:4-1679    [000] .....   141.796958: macb_tx_hw_state: macb_tx_hw_state q1 linkdown_pre_te tbqp=67cda598 base=67cd8000 ncr=0010001c tsr=00000021 imr=00000ce6 head=3985 tail=3985 tbqp_idx=59 tbqp_ctrl=80000036(used=1) tail_ctrl=80000000(used=1)

ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
macb_writel(bp, NCR, ctrl);

     kworker/0:4-1679    [000] .....   141.796961: macb_tx_hw_state: macb_tx_hw_state q0 linkdown_post_te tbqp=67cd0030 base=67cd0000 ncr=00100010 tsr=00000021 imr=3fffffff head=2 tail=2 tbqp_idx=343 tbqp_ctrl=80000000(used=1) tail_ctrl=80000000(used=1)
     kworker/0:4-1679    [000] .....   141.796964: macb_tx_hw_state: macb_tx_hw_state q1 linkdown_post_te tbqp=67cd8000 base=67cd8000 ncr=00100010 tsr=00000021 imr=00000ce6 head=3985 tail=3985 tbqp_idx=170 tbqp_ctrl=0000800f(used=0) tail_ctrl=80000000(used=1)

Ethernet link goes up.

Trace from macb_mac_link_up():

     kworker/0:3-190     [000] .....   152.966203: macb_tx_hw_state: macb_tx_hw_state q0 linkup_post_shuffle tbqp=67cd0030 base=67cd0000 ncr=00100010 tsr=00000021 imr=3ffff305 head=0 tail=0 tbqp_idx=343 tbqp_ctrl=80000000(used=1) tail_ctrl=80018040(used=1)
     kworker/0:3-190     [000] .....   152.966206: macb_tx_hw_state: macb_tx_hw_state q1 linkup_post_shuffle tbqp=67cd8000 base=67cd8000 ncr=00100010 tsr=00000021 imr=00000004 head=0 tail=0 tbqp_idx=170 tbqp_ctrl=0000800f(used=0) tail_ctrl=0000800f(used=0)

macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));

     kworker/0:3-190     [000] .....   152.966209: macb_tx_hw_state: macb_tx_hw_state q0 linkup_post_te tbqp=67cd0030 base=67cd0000 ncr=0010001c tsr=00000021 imr=3ffff305 head=0 tail=0 tbqp_idx=343 tbqp_ctrl=80000000(used=1) tail_ctrl=80018040(used=1)
     kworker/0:3-190     [000] .....   152.966211: macb_tx_hw_state: macb_tx_hw_state q1 linkup_post_te tbqp=67cd8000 base=67cd8000 ncr=0010001c tsr=00000021 imr=00000004 head=0 tail=0 tbqp_idx=170 tbqp_ctrl=0000800f(used=0) tail_ctrl=0000800f(used=0)

CPU load is normal, no issue in this trace.
tbqp on q0 is not reset to base. But in this case it did not result in the interrupt storm.


Trace 2 (results in interrupt storm):

The ethernet link goes down.

Trace from macb_mac_link_down():

     kworker/0:3-95      [000] .N...   459.682957: macb_tx_hw_state: macb_tx_hw_state q0 linkdown_pre_te tbqp=67cd2cb8 base=67cd0000 ncr=0010001c tsr=00000021 imr=3fffffff head=4061 tail=4061 tbqp_idx=306 tbqp_ctrl=0000800f(used=0) tail_ctrl=80000000(used=1)
     kworker/0:3-95      [000] .....   459.682991: macb_tx_hw_state: macb_tx_hw_state q1 linkdown_pre_te tbqp=67cd85a0 base=67cd8000 ncr=0010001c tsr=00000021 imr=00000ce6 head=60 tail=60 tbqp_idx=230 tbqp_ctrl=80000036(used=1) tail_ctrl=80000000(used=1)

ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
macb_writel(bp, NCR, ctrl);

     kworker/0:3-95      [000] .....   459.682994: macb_tx_hw_state: macb_tx_hw_state q0 linkdown_post_te tbqp=67cd2cb8 base=67cd0000 ncr=00100010 tsr=00000021 imr=3fffffff head=4061 tail=4061 tbqp_idx=306 tbqp_ctrl=0000800f(used=0) tail_ctrl=80000000(used=1)
     kworker/0:3-95      [000] .....   459.682996: macb_tx_hw_state: macb_tx_hw_state q1 linkdown_post_te tbqp=67cd8000 base=67cd8000 ncr=00100010 tsr=00000021 imr=00000ce6 head=60 tail=60 tbqp_idx=170 tbqp_ctrl=80000036(used=1) tail_ctrl=80000000(used=1)

Ethernet link goes up.

Trace from macb_mac_link_up():

     kworker/0:3-95      [000] .....   470.292877: macb_tx_hw_state: macb_tx_hw_state q0 linkup_post_shuffle tbqp=67cd2cb8 base=67cd0000 ncr=00100010 tsr=00000021 imr=3ffff305 head=0 tail=0 tbqp_idx=306 tbqp_ctrl=0000800f(used=0) tail_ctrl=0000800f(used=0)
     kworker/0:3-95      [000] .....   470.292879: macb_tx_hw_state: macb_tx_hw_state q1 linkup_post_shuffle tbqp=67cd8000 base=67cd8000 ncr=00100010 tsr=00000021 imr=00000004 head=0 tail=0 tbqp_idx=170 tbqp_ctrl=80000036(used=1) tail_ctrl=80018040(used=1)

macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));

     kworker/0:3-95      [000] .....   470.292882: macb_tx_hw_state: macb_tx_hw_state q0 linkup_post_te tbqp=67cd2cb8 base=67cd0000 ncr=0010001c tsr=00000021 imr=3ffff305 head=0 tail=0 tbqp_idx=306 tbqp_ctrl=0000800f(used=0) tail_ctrl=0000800f(used=0)
     kworker/0:3-95      [000] .....   470.292884: macb_tx_hw_state: macb_tx_hw_state q1 linkup_post_te tbqp=67cd8000 base=67cd8000 ncr=0010001c tsr=00000021 imr=00000004 head=0 tail=0 tbqp_idx=170 tbqp_ctrl=80000036(used=1) tail_ctrl=80018040(used=1)

After that sequence one CPU core is at 100% load continously executing the macb irq handler.

The issue seems to be q0. tbqp of q1 is properly reset to its base address.
tbqp of q0 is not changed as expected in link down when tx is disabled.

Are there any other details i could put into the trace to determine the root cause?
I suspect that some packet is still in transmission/ being processed and this might be the
reason why tbqp of q0 is not being reset. But i do not see that in this trace.


> 
> Lastly, the cover letter mentions that [PATCH 1/2] alone isn't enough.
> But it doesn't mention that [PATCH 2/2] alone doesn't solve the issue.
> This would be a useful test as well.
> 
> On Tue Jul 7, 2026 at 3:36 PM CEST, Taedcke, Christian wrote:
>> Thank you for the quick review! This is my first Linux kernel
>> contribution, so I appreciate your feedback here.
> 
> Welcome!
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com/
> 

Regards,
Christian

