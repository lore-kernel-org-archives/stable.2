Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865A422526;
	Tue,  7 Jul 2026 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431394; cv=fail; b=atqseEKCDFhJ3212iCNi2rEsA1HbBO6YrBy4UaQ889m/K/ZWutkFAXLz/IpyS3Kg5IjBb/ItaUECHIXKYiFMZct9IZaAiTtEzJEp/5rkURDtbYphJXfrZE16XDk8KXmT7zjqjWpQNyoxHgfiWcBjD7yz5VDUqT7mPqWOAeKjeLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431394; c=relaxed/simple;
	bh=gnjG+1TFfauaWf7YGFOCUnj+bnz/T8JID7dOt4UBboQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsHXkWL5AQkB18PnpwvwYfmiQ2bNhWVS3W+i04RX1mxKCZlaSshZAtNj/6TEVrOj4RKxxjHQOzITz410kCd80V2uYxGZLnW3Qf9FsYWTWakSrHWSFbq4UdD4dVtWDvDliQuQFEhzA9ICfpzDmSDc0kaaOaPt/ZouyFsUQi0gu5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=weidmueller.com; spf=pass smtp.mailfrom=weidmueller.com; dkim=pass (2048-bit key) header.d=weidmueller.com header.i=@weidmueller.com header.b=PdQ9EAbV; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=weidmueller.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weidmueller.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weidmueller.com header.i=@weidmueller.com header.b="PdQ9EAbV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABXcpKNho7NfLzaHNavFEcEPFd5eeIuvoG/dhFA/4nzqZKmz9j63CvdDJBtoVjgvL5BjYjV0Va0MUyrwQF+0eaH8kbXgPXrsDybF2dQ1SJ1F5D4mm/+4na0CbBOnWoCLWK2OJkZ1GkSk8QXfPB7RmnLD8E3JLdBHs43bfl7BtS8zVid5fkLQkjdZx8k3nFqaucu8RTbbD4vWYOEFxkVB/gqwTN5jj62aos1rUyqs5rL2EtJ4pPHIG4A9eA6OY/0Uzlkes3Rt3fOeMcTX5L2Wjj7S8sfeYSRuq60BVqSy+I08yUU/HTO9VZUxNKHsB3s6OAKbwshwP8TSHXYy6ORioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3ToJlNE3dZAixWVES/tKqm3RYXBmuktaaFlBl1X3po=;
 b=LEsfZGyea1hlpCtPBQMect5X+bs1b3PpYlZFKAsDmT4ktjwzRF9DQBs67yjZ/fPMAk03Skvohj515TpIPntyiSTS6vC0NkAw5mRmtuyVuEzSSK456PNqrloUeW9IKQ7beLNDHc4QdHy4UronJfIzYJQnbdKkw60lKxCetyGIDirI/Auu6U0YeFMG7l6HdLPC8wdeg5QyDkeQRqdBakIJm6KFmoTkR2K5C0OszNCfC6Nut3PG1zFYT4S7vSs390AmuzfilKZeg8ITz386rc7sfR40xW7kTO3p9AB9i1l5hlVvYgeZT6LlHO9SKc+KEUzJKoxQlSVqbCjweuL2aGLdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3ToJlNE3dZAixWVES/tKqm3RYXBmuktaaFlBl1X3po=;
 b=PdQ9EAbV9VxAxFBvBhOlIvqfd2KjHwrG3vZXRW4Wl2BFXGhseGb/kMpmO3BJurPXbZFHgLg4VF3KokpJOw/N76EsH21BKyQ9YKeh5oCYsMKL3m7xvKTifQ+H2CGnfYBqJNiyY8a84ueJmQGRikjL6NEkjiGZaX6BKVph515SFMDnLXVKjhMoXZZIVCGldDYT5CdYWduFQvtuRjRnAB+G5cdhY3vK+ybys5HGpzeUxdA+giURFHQ3zL0ej6DN6FRT7uAE3Cv7qem2qzxFUV1SUucCznCJ+KqGXUzxjRyCOtLTHAytGS7YkoWriz6rnEs24JhQP2D210iVSDCFE8J/LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com (2603:10a6:20b:578::22)
 by MRWPR08MB11730.eurprd08.prod.outlook.com (2603:10a6:501:99::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 13:36:25 +0000
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778]) by AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778%2]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 13:36:25 +0000
Message-ID: <4c0570d2-5018-4389-ab63-5f829cc41f32@weidmueller.com>
Date: Tue, 7 Jul 2026 15:36:24 +0200
User-Agent: Mozilla Thunderbird
From: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the TX
 ring on link-up
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 christian.taedcke@weidmueller.com
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kevin Hao <haokexin@gmail.com>, Simon Horman <horms@kernel.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
 <20260706150422.-wYiCBuE@linutronix.de>
In-Reply-To: <20260706150422.-wYiCBuE@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To AS2PR08MB9199.eurprd08.prod.outlook.com
 (2603:10a6:20b:578::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB9199:EE_|MRWPR08MB11730:EE_
X-MS-Office365-Filtering-Correlation-Id: 24471a51-19d9-440e-c76f-08dedc2cbda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2i00xY/V3h/++wEbsO7dGw6ld3L76LpaNEYo9sMSRi9Z+eGkmbd5Aj2twVPlC6ijNG5EEa6oqGfLzT1Dl6f2d8FKdWzD7WAOLvw8lb1mAconNtWwzy7TmrnQqZoGCpXkDRn0Eb5cai4thNwlQWQV866Kd4loQgKsYqkLxXhgTleKnJ0D92u9YMdD7jBtzc3msxoURVJYDijBdnnEi921FWUk0VGYNOoS7RLyhs8AgA7YjA5eRWuOVdXb8mcSJd67fTVEusowYa68gy+h6n8+De4D+5gukm6sQCt0X5N2uOzSzjflHIfLS8LDSBJ4R1J0DV53nOZxjo80bzRutXSMfD+diMgzMAmLqsyOxxipxJT1neZpgo+gsg7mlUuczagHItGbUbMibQj0vurqE9/12/Dz1vJ1HSbyeCqkkRH48E4y9G3mhHdFZeY6WZpWmBt2TP77D4NFA0fUr2Z994gI5PNTf/NsYnS7mctgZot5bUkyineZGIC6AXm6UkwfSf2jm9uPL1jIpV5UD2XQGhLq0R1BRDcmcTt3ZuLsJNgakGyKjEqaY/QUj42dKrtSOXWEyu7Yak8b8Ucp1ewWqHaPrz275ovtFWlTXGr+0EYTvCt9acHbbPedG0OomNc1qdYm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9199.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnlQOHl0TTNrUUIyUUVMMThVbURUM0xINVhreGcvUFJmQnZ1cjA5YTJwRmV6?=
 =?utf-8?B?T2d4OGp6QTFOeHVHbDBPb1pkeTd3RzZkMlRNU2lRTWdUZUIxSjNoYUc5d2VE?=
 =?utf-8?B?T05nWWY1ZzRYNzBCWWd4TjMrN1dUNFZMb0lpejZNRmRTT3dqUTI3V3dhNE9w?=
 =?utf-8?B?Qi9yT0ZUb3k3RGI0K05KVDhnTXBNcGdHMjJCblhXT3RWUmlsT3J3ZXNadDFw?=
 =?utf-8?B?SnlZSHl0SjNxZ0QxMHJIbjA1S0pnbkw0d0oybGxTNFRnTCtRS0hjWDRpc29N?=
 =?utf-8?B?alI2Y3NoYUkyYm16VXAzTUxvMzZCOG1oM1doMEhwTTVhWUFnSEFiQlV4cS9S?=
 =?utf-8?B?M1dyb016ZnhZYnQxUmhDWWZKVmRScWJ4UWhuYWFjMERyNXI1dXBBMkZldTZq?=
 =?utf-8?B?dFR1UnJ4T2VkNGNxalBGRGwwUFBTc25SWm5kb3lUbHpHYWhuMU42R2N0TU1r?=
 =?utf-8?B?YVZPZWdhOXVFb29hTlNnWkVJUm90RWt4WEUxYm91ZVJXNEZ1dGk3dHBVRnVC?=
 =?utf-8?B?dmR1dCt5ajJqVG40NDByeEg0ZFVEeHlIMS9DY2JUZDNseERoYlU2dlVITUtl?=
 =?utf-8?B?RFFMekdtMmJMbFJFVWI3NEdlbU5YTnFaaFRJYnY4QzN1Q3M3Q0g5MjR6eDNU?=
 =?utf-8?B?UW9pT29lVi95Z1RsTWxmcXlYQlN0R1VoSDMwNU9vTzhTOGZ3dFFoSmx1Vysz?=
 =?utf-8?B?QnM4SWVPY2pRQ0Z6TWFJQVF2MTYxYnIwQ3F6WVorb0tkdk5OelNHVk9HczJN?=
 =?utf-8?B?REd6bDU0alBKdEhQV1NMeWxmTWphaUE1c0M2MGtLSmx4b2ZBMzVoU3k1TzVj?=
 =?utf-8?B?VUUrc29sb1dzcThxeGNZSncwL3ZpbG1DT2g0R2lGcWVoUHFBczkzOVYybmNl?=
 =?utf-8?B?cHFMZE41SnVYRHV4djRMYnZRZVVoS3IzWEpmRWNuSzV1a3l0ZS8xMjdySEJs?=
 =?utf-8?B?bjNNUFVSeTJxWEtnWi91QTlCVWNuK3E1b0NwSTByNUJBMWQ3VjB6YnR2VXY4?=
 =?utf-8?B?d2pmRFJ3a0s4aDc5K1BsN09DQk1zK0ZoeW0xcW5pYzd4eHRnOGpwZXRpMHhD?=
 =?utf-8?B?NzJINWR2dCtlSitlWGtWTDBTTWVxTTYzRk1aTGRNSzg5dXA1OWt2OUtaZVBa?=
 =?utf-8?B?aTVnNDY2OXJaQUpBRVNjdC9kc09YUm9UMzZ3b3E4WGZhcmNwMzJRcCtYYkx4?=
 =?utf-8?B?dkM2SEtvcTdrSDJXSlNDb1dpaE1COGtzNmN2cmZVZkc2eE5PcE1hUjdNcEZT?=
 =?utf-8?B?a0RLZ2xYa1AxTHhIQjdKajJLeFI5Z1BXWk1kV1hWbW8wd2Y1UnN0bll4eGt5?=
 =?utf-8?B?UjUrZWN3N1gvaVdIdmVHUVhMT2hNYUlMd3oyV0h2aEpqbTFDcEdVVU4vdXZN?=
 =?utf-8?B?c250cnBWdUxQMC9kMlRFdTBjYnNLWUtsTENHbHhUaW0zRzM0NExDZVFCSVFR?=
 =?utf-8?B?UkM1NUhWMGkrK3k0UVdtdXp2WVNsL2RIZWFUeGp3c3BNckxIa1Z1V0dyR2Mw?=
 =?utf-8?B?cnBrWFNQZ3YxdHNTdVBsWXNITXJlOG1od2RXOEJRUEVFNGZuTmNzZTk2Y0lS?=
 =?utf-8?B?QmVodjRjL0t2ZENhYXc2a3hWeUwwcEZ4aWFkckxEL1BEZDg3ajVXcWRjQ0NY?=
 =?utf-8?B?MnRFRkZsUzJHMjVQK3FPWnBRbVNDUDFlbDlyamw1d0NacERDQmFpdGpOY3cz?=
 =?utf-8?B?b0hlVjZIS2hoakp6SlplN1BBNkk1OEt5d28wNHA1Z1NIOTJuV2NlQ2FnaEd5?=
 =?utf-8?B?OXBjTnhKTnM3akpSYXJpY0M1UDJ5NUlFTlZhSGN3U2ExaXZWRkhpenpTbHNZ?=
 =?utf-8?B?MFpZR1ZNd3E5L3J1dUhWZFZ2Y0FsY0R2WFlFNmI0VkpGSEJVVWFVa3VaTWcz?=
 =?utf-8?B?V0dhS09oWlNabFliNUNMa2dyNlpZUDdCUjExMnlhekdkd05DT1FVQkY1SzRq?=
 =?utf-8?B?Lzczd2g3OU95V3NSSDVMdVhsS0dhMDZtUFFaTlVPV0lJQUpHSGhNT1B1VCtv?=
 =?utf-8?B?ZjBTRlhNNnJ5aHZBS25BeDl3UThDdmlHczFoUzFrWEsxNXZ5MnJWZm9QaXF4?=
 =?utf-8?B?U1BCWTdiTlhTNXJNbmRiOXlZNkVHSjJZeEd5dTNieEE2MmkydmVwNERsby9k?=
 =?utf-8?B?T0tubFVWSXluL0NaTTdNYTFuWHh5d3JDdVI4eWdaZ2Z1OCtLUHBrUmh6RHE2?=
 =?utf-8?B?RGxHNU1QeHVOYkRsM2VKYk50SFNMK1BRWjB4ZHoxVlprRHVlS1Q0eXQ3eElJ?=
 =?utf-8?B?QWNFbERqUzc5TXRQY09YOXBYR0JTb0RZYkJGKzIxUmFpMGNXcVY0K2pyckRm?=
 =?utf-8?B?bGc2Z2NkV2MrRHVNanlLSGJ0b2dHaEtOSFRSRUZNdEM0RWp4cVgySTlkK3dr?=
 =?utf-8?Q?JTvTaiVFs2R6ZdVAh2wF2T3kHIgw8xhjpg9ui?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24471a51-19d9-440e-c76f-08dedc2cbda4
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9199.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:36:25.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3de8XCESlUDpYTztwvI5hO9mUeP/kVdRmeQQbHCMW9sMVxfM9NkUvPPccnFOo/psrqXB6nsSW5BLIpq4p1erngwY4XQK9By3HDIwZIFDnQWso3jGPSBAI6x7V89K5sCC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11730

Thank you for the quick review! This is my first Linux kernel
contribution, so I appreciate your feedback here.

On 7/6/2026 5:04 PM, Sebastian Andrzej Siewior wrote:
> On 2026-07-06 16:02:14 [+0200], Christian Taedcke via B4 Relay wrote:
>> From: Christian Taedcke <christian.taedcke@weidmueller.com>
>>
>> gem_shuffle_tx_one_ring() rotates the software TX ring so that the
>> tail sits at index 0 and resets queue->tx_tail to 0, but it never
>> reprograms the hardware transmit buffer queue pointer (TBQP). Other
>> paths that reset tx_tail to the ring base (macb_init_buffers() and
>> macb_tx_error_task()) also reprogram TBQP to queue->tx_ring_dma; this
>> path does not, leaving TBQP pointing at a stale descriptor.
>>
>> gem_shuffle_tx_rings() runs on every link-up from
>> macb_mac_link_up(). After a few link up/down flaps that leave
>> un-completed descriptors in the ring, the stale TBQP keeps pointing at
>> a descriptor whose used bit is set. When TX is re-enabled on link-up,
>> the GEM reads that used descriptor and raises TXUBR. macb_interrupt()
>> schedules the TX NAPI, macb_tx_poll() makes no progress (work_done ==
>> 0) and macb_tx_restart() re-issues TSTART, which makes the controller
>> read the same used descriptor again and re-assert TXUBR. As the MAC
>> interrupt is level-triggered, it never deasserts and one CPU is pegged
>> at 100% in the threaded handler, eventually triggering "sched: RT
>> throttling activated" and a dead network interface.
> 
> But this should also happen with !RT at which point the interrupt runs
> at 100% CPU and the softirq has hardly an chance to make progress, no?

Problably yes. I had issues reproducing the issue since it appeared only
on specific test setups when a lot packets where sent to another network
device and this device's power was cut. And even then on some test runs
the issue was not visible after a few hundred iterations. But after a
restart of the whole test setup (including cold reboot of all devices)
the issue sometimes appeared after 5 iterations.
I only metion RT here because it was the only thing i tested. I only ran
the RT kernel.
Should I change the description?

> 
>> Fix it by reprogramming TBQP to the ring base on every path of
>> gem_shuffle_tx_one_ring() that resets tx_tail to 0, mirroring
>> macb_tx_error_task(). The early return for an already-aligned tail is
>> left untouched as TBQP is already consistent there. This is safe
>> because the shuffle runs from macb_mac_link_up() while TE is still
>> disabled, so the transmitter is halted.
>>
>> Fixes: 881a0263d502 ("net: macb: Shuffle the tx ring before enabling tx")
> 
> This is v7.0-rc4. So that RT tree of yours has some backports or did you
> run into this while trying to reproduce it upstream?

There were some backports. I ran this on the linux-yocto kernel
https://git.yoctoproject.org/linux-yocto branch
v6.6/standard/preempt-rt/base.
The "Fixes:" commit was backported as 0a47c3889fcd before their version
of 6.6.130.

The kernel i reproduced the issue on was linux-yocto branch
v6.6/standard/preempt-rt/base after 6.6.142 was merged into it.

> 
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index fd282a1700fb..b11cb8f068b7 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -820,7 +820,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
>>  	if (!count) {
>>  		queue->tx_head = 0;
>>  		queue->tx_tail = 0;
>> -		goto unlock;
>> +		goto reset_hw_ptr;
> 
> This update is even needed for count == 0 case? I kind of do understand
> that you need to updated if you shuffled the descriptors around.

This was my understanding before researching more because of the email
from Kevin in this thread: count == 0 may happen anywhere within the ring
(e.g. when both the tail and the head point to the middle).
Resetting queue->tx_tail to 0 but not resetting TBQP results in them
being out-of-sync.
But as Kevin mentioned in his email TBQP is reset to the original
value when transmit is disabled (by setting bit 3 in NCR register).

I will investigate this further why my code change fixed the issue for
me, but according to the documentation in [1] it should be a no-op.

[1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm pg. 1040
> 
>>  	}
>>  
>>  	shift = tail % ring_size;
>> @@ -869,6 +869,13 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
>>  	/* Make descriptor updates visible to hardware */
>>  	wmb();
>>  
>> +reset_hw_ptr:
>> +	/* tx_tail was reset to the ring base, so TBQP must be reprogrammed
>> +	 * to match; otherwise it keeps pointing at a stale descriptor. Safe
>> +	 * to write directly here as TX is still disabled (called from
>> +	 * macb_mac_link_up() before TE is set).
>> +	 */
>> +	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
>>  unlock:
>>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>>  }
>>
> 
> Sebastian

Christian
