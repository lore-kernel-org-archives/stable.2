Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627273F1ACE;
	Tue,  6 Oct 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297836; cv=fail; b=MuFYOVdS1XU+E7+MilgK7cKzzHxJvYGgh/tsYMXjvXA/gz6E3fMFKGMlArKxz5139JE8ESurc0lGGm8oFZGAMlF385q9jNb/K5xluuQQdoAmn6/7fwgQXLS0pt1F5F7wzKnOYbSSx6IduK0wYiCNCxO/QVOvrPglYVSWG8hi5rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297836; c=relaxed/simple;
	bh=5gs9U6pw1XqPjU9mlTybd1sw2zyW0pqpGD2Wu7nhyRg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eA4tNkI4CushcyOtS0JhjTezTYktSSk2rcu4D6ySfSKcqUIM0hRvYNV/O8X7UwJxA2/pL+gNeRJhD2tyi8wf+B1V7uoDXLyDdkBF00RJSXLZBUTnYiK4OPLf1uxW5S69citMQHvSM8kN2Dmw9ToGr0Ei7dW3nFYt+CpwfwABaE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=mwcbv/1u; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="mwcbv/1u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSZG6PIOrWZ6sqwU6NOv8mVzS8R/kN/9FPpUj374XZUh3g6e5qCABFNXaLSDAiY6Bcy1r5DVfKBy2H6sxCpapDv0kSyv8nI5lA82W0mi1AaQdo/Vvrzmq6H1aeTi5avk7AWmRpG25Ar7z6BOYXLHU0KHAb+SKWcYEezR6gUit/gVxG0GFyIKmVooDuRX56M3W9eG8DDyIzKPB23E68Agr+ygFj3cRmdqpktpvp2fjld65SadIPI0dyEqoHcKmE+djf2xjhmZIMt0tkXrJQzggduKYFA8fz5nw67u/zK0bEELX6pgOJbrgk5T8WjanSGr1NzMfdg//wY0j7Gj7B0gIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhQaN5T1hU1rRx42cQYMLNsDzKy6RS7+ImA5ST0O1uA=;
 b=aKuV98wh4TuBGAktz9vBSRkpPCDMUxtMVIKqefc8C13NL/LHS8fqHAYSr9B/i1nzoo1tzCNcwqip44w9U4aL/QOBEuEDOjU43r21AtOFs6oOcnuKYcdrXYC29zDoXXjJ2VNmxX1GWiboXHuVcUECMXJ0Lt7T+Eeoexo5/e6Ap7+dyx3GxOeEIirur6EaFgfsrvAvEhjzFrTFkNSsxWi4VdtBSyhnJuFEDYwvqw7DC2w/y/DrJwhcGTGFQxXwN+u+5ekKZZRALNgZBdrbQa4Qw6yQbrH5Qw+bMZNzMtEFT0pJCCzAWH0WMN45mxgfmCYa5ugXdQRwhDXTz1Xcv0i1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhQaN5T1hU1rRx42cQYMLNsDzKy6RS7+ImA5ST0O1uA=;
 b=mwcbv/1uNSrsKccut0rXlY1w/NlNWw5x+/ZZjhrkvjuh1LgZhQ5jm7x92fbc/MNcls6PPsto9kSJ0gy4r4aXQU5LcO8Dh8S4HRnvUvyU1EIzNMwu7d1CQpklBPkuO+Bog/ERqhnZwRxcXdvoE6h68FrJFw2olqtC9SGvDgujTAg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8274.namprd03.prod.outlook.com (2603:10b6:610:2ba::5)
 by CH3PR03MB7459.namprd03.prod.outlook.com (2603:10b6:610:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 14:43:50 +0000
Received: from CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096]) by CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 14:43:50 +0000
Message-ID: <cf503bba-9f46-4cf6-9c42-710d0ffe4120@citrix.com>
Date: Tue, 6 Oct 2026 15:43:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-blkfront: Fix IO race during unplug
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
References: <20261006135807.2571779-1-ross.lagerwall@citrix.com>
 <asUCYtIJkFchdbNH@Mac.lan>
Content-Language: en-US
From: Ross Lagerwall <ross.lagerwall@citrix.com>
In-Reply-To: <asUCYtIJkFchdbNH@Mac.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To CH8PR03MB8274.namprd03.prod.outlook.com
 (2603:10b6:610:2ba::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8274:EE_|CH3PR03MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 34faecf3-9617-41e7-1ceb-08df23b83c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|4143699003|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NGHT28ITpfGjij1ElAPudr0jFeJDXg3D+tCudvNj72BEksabQ09ChWik+/Tb3jtYD9Fgnnu3afPnFkFECkEswb55IiCGdFhSnAkGCshvwxo5W3AQPum6zeECgoTPVg3FQT6HIllzgCbDUiSrXvQkmOYqw6lCTnD+blS3WkE+1oILYH65Z4LEyT6WhD8yNqodZrV/XSOJFCA89WVg1NJKtg2N9A1sBich6iJVuasd/tDccfwF1Twm3ogijNcFJHtWlKZH/zhuaDzsIf1hSfhIX+PoOPhrzJcL++V/zlL9TyXP1U+yA0/ofGgymctNoqWguu3AEbPEVrpuzluirjqjxmSsLQVHj3S84zs7rnW0BTFKq3FonbUNYyNOD21Ld0vXfi9RBSswByrOE30t2+FGklr8648qDveZ0GtXJIe0miwL+Ax9erxLXRkrJI5G59R0is+bfQltks2r3ugBWa/t+2ebcATaylhzVPbFAPn9K6XlumrG/MJEmpGEmrU0CCV4F2WQtNkrjmJXUubPX0tamC5MTIQ9AG4qJS5nXCaxX2icyj3rCcLL7t4TWbj22oWrbdYD6oWt+qnaioiaQTO7v+UIiu22f5PuX9JxQtQU5PoXHzcsPwOEHNjkVN9PKbvquPxY8utF0blBIt5EQXbtRLOc3jvMg69sbtArLJP6y+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8274.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWxtdURMWXk1TzQrcHhwNkFDeDE1WUJ4RlN5YVVaeXdBbVMyZlFJYTdFRUhH?=
 =?utf-8?B?Rkc5bTdITlVrY1IycmVYcTFIMWxVWkhRSGtHWkt5SXg1bWl6MklIZ2o3MzJD?=
 =?utf-8?B?RDhEcll6TFVwZ2NCMjlEWm4yRGVCejVJWFg1VW8yays2V2RsOFYxVkdQbWV2?=
 =?utf-8?B?TFY3ZFB5NHlXOTJXUXlCQk93K3ZFL1BNaWpLdUpyWFZScG5hN01UMjRxSzZW?=
 =?utf-8?B?S3lXdkRXYm15aEYrRUo0R09zYVU3MHNzNlhTVkNXRk5xb2dUZlFHWXN4elZU?=
 =?utf-8?B?bUkveUJ0N1d3U2k4MXJCUVZwdWZWaDZUU1dBRjZGR1RhQjJwTmE3d1dPWXg2?=
 =?utf-8?B?UlViRm1rVisrdEsrbWFXazM0RFdYMVBkbndXeFVHTjl3d1RNOUdxMllhcW01?=
 =?utf-8?B?a05PNjk3MUo1RUlsNmJPM1RmbUZXTmpmMTdXY2R5cjBOZ0s0ZzV3Q2p6Y3FI?=
 =?utf-8?B?V2l4Y1JjTVI2NFVjRVVqQ0RUaEIrckFneFN5eGU2M0dDSVpmNDRtRERQU2Ni?=
 =?utf-8?B?QnhLbVh4WmJqOG04SmRlVXh6S2NGZTA2SnhxMGFzQ0RKZkdxelZKRnEzSGE1?=
 =?utf-8?B?MWpZUkUwYlRwdHVkU1RBazhhSXZTQzY5dm5yM0FnekpBdS9kU3VZOUFFVnBF?=
 =?utf-8?B?dmJudVN0eENHSzI0VHhxdFZPczllWEltUm5mWmFNc0VtNHJISGdIYm5ERXN4?=
 =?utf-8?B?RFU3Q1pLbDB4NVZacDhlcXFXRkdmOFA5cEJ0RGMyQWNMTmorL2NpK0FkWWcx?=
 =?utf-8?B?TWpoOVFWeWtwSHhSanBZd1FXeFdHTlVLaWFpUkxFR3E3T1I1RzBxTEZlaFRs?=
 =?utf-8?B?MUk2MEVEYzdQUXY4dzQ5TFlOMWpoWGpzRjlTSS83Qld4ZjkxakR6K1QzaWhN?=
 =?utf-8?B?ZlhpV21hSm12bG5ZR2lSaS95SDBCREZ2SndPMnhNYTlQMThjRk1RdVRhNVAx?=
 =?utf-8?B?WmlvRm1uY1F0Z2Q3UUJ4bkJORWgwZmI0aVN2bytFbWNUV3VWdzVhbnM0UXFP?=
 =?utf-8?B?Y1NFUzV3Skx3QWl3SXlqbll4SGYxOUNzc2FmcnA4YkpKRXppM2p0VGdDb2ZF?=
 =?utf-8?B?c293N2lhQ3JteFNaWUgzS2wxOURmMzhtVk9nL3NVb1ZoR09YQi9jL1ZLZ0tT?=
 =?utf-8?B?akU4L0RzM1BxdXl2VXBqTFltTnBoUEFNdmFzMDNpK05qQnh0QWl6clB1dW5T?=
 =?utf-8?B?cFYwRjJmUmpMdVBwUWYwcHQyVUhTWTV3VHZYWHMyUUZqaUc0TFF0UUROdElY?=
 =?utf-8?B?MVhOeDlDSHdoSjk3TVhZVVVUWVpWemlGZ2tPZlROS1N3NW9Hb1lZV2dLYkpN?=
 =?utf-8?B?T25jUE9sUzRNRFZxZ3lQSlM2VUpmMVFtM3BBUm1temFmdkxENEJuU29lMmxH?=
 =?utf-8?B?Rm1ZSkkyK0dnblYzVjF6YzlSNFJVRGFMcy9GazdnK3dxRXJXZGZqNDJlaThP?=
 =?utf-8?B?UlI5cEkwakxOTTB1T1p3OW5CUGZsQnJvbWpQMFFyYXErMzlwcVUxSmYxZzJI?=
 =?utf-8?B?cW5wU2tRSGJTQ25wWnhJaE1MQjR4c21lSkR4QkFtTlppVWowK3JCR3ZCa2wr?=
 =?utf-8?B?d2JHUjJNSU8wRDhhY29Rd3dndktjUmhKVEJqMjVDNmlxUDEvS3ZLUGgyd1Z6?=
 =?utf-8?B?WVZIRWJyeDZTS2NqeEpnZTYyY0d1NzhRSW9OQXI4YXQvVEdnbUM5bFkzc1dB?=
 =?utf-8?B?NkRrTTJNZGJJbnI2dGZrZk1kZTMzUXZhMTdjbHlVUlZ6cVJaampVK0Q0R3Zp?=
 =?utf-8?B?dG9VU0tzWTk3OVR4UlMvWWpjVENORjFaTjhWQ2MyL2VyNHZaWEZNM2tCcXZw?=
 =?utf-8?B?TUhwYjlUZ1E1REJoNlE3c3ZpQnNQMVMxdSt1U3NVdGF3amZZN0VSMUxBOG9S?=
 =?utf-8?B?MkE1Sm5LL0UrMUpXYUJKM2ZnSXozTno2U2dyNjZVMkxvUDhyakJtMU0xblIz?=
 =?utf-8?B?dThkNXJTdWRTYUVOOHBsbVBmOGVldzN5aWN6RDBGZVZweGVBY1FvNGF0VFFZ?=
 =?utf-8?B?QXlNQXVYLzVLaVpWZkhWYzlwQTlZM1E1K0JPQ0tGdHhXQVNzU01Ja2wxdjRE?=
 =?utf-8?B?THFTTHJzZlRnQ3RGYnNSZE1DZ2VEbHI3TFNFR1VJd2l0KzFiWWlWM0ZRNnBo?=
 =?utf-8?B?T2M3ODJ1dVluc1BtRFhkS0JVbGJkNFRMcjZpcjJnNWVGNWxGKzJVd0xKYUIz?=
 =?utf-8?B?ZEFnL3FxakRJWUJ5OVBkWXAyM0dQYXBNbHRlbFJsZHE3cm5aZi9ZMlc5eGlL?=
 =?utf-8?B?eGpoeTY1LytES0l1NG5HL1UxbG5vTUV6WXAwVGs3Qkx6Z3dZanJLcnZkamMw?=
 =?utf-8?B?dmN2b3ByRFZDVXFtdER2SVcyWGZTc2p4aVh4S1pRVXpELzNra0RTTmk3Tzkx?=
 =?utf-8?Q?pLnpNMHBB20ERKUA=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34faecf3-9617-41e7-1ceb-08df23b83c40
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8274.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:43:50.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLpIFAqkka1k3aQVyaT1YBkuCrRDKSm2Bra01Vd77TFkTSdxiVmz3QKEgGuf9G4ZIOTiLSRfO3wvTUHLGtYLgsPoWmvSdtLJri5nqyEdfWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7459

On 10/6/26 3:14 PM, Roger Pau Monné wrote:
> On Tue, Oct 06, 2026 at 02:58:06PM +0100, Ross Lagerwall wrote:
>> During unplug, blkfront stops the hw queues and marks the disk as dead,
>> then later during removal calls del_gendisk(). However, IO issued after
>> the hw queues are stopped but before the call to del_gendisk() will be
>> queued but never handled. This causes del_gendisk() to hang forever
>> waiting for the queue refcount to drop to zero.
>>
>> This can be reproduced by issuing IO during an artificial delay after
>> stopping the hw queues.
> 
> So the window is between the blk_mq_stop_hw_queues() and
> blk_mark_disk_dead() calls where requests would be queued and never
> processed?

Yes.

> 
>> Fix this by simply not stopping the hw queues directly. Marking the disk
>> as dead also freezes the queue which prevents new requests being added
>> and it synchronously runs the hw queues to clear anything pending.
> 
> I think this likely needs expanding a bit: the disk is already marked
> as dead with the current logic, and in the same place in the code.
> 
>> Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
>> ---
>>
>> I'm not sure about the Fixes tag. It's the most likely looking candidate
>> to me but I didn't confirm whether it actually introduced the
>> regression.
> 
> I was wondering the same, and even then someone might argue this was a
> latent bug in blkfront itself, and the reference commit just exposed
> it.  I don't have a strong opinion.

Good point, I might be inclined to drop it then.

> 
>>
>>   drivers/block/xen-blkfront.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>> index 8dad7bf5f664..69a2315a1b20 100644
>> --- a/drivers/block/xen-blkfront.c
>> +++ b/drivers/block/xen-blkfront.c
>> @@ -2138,10 +2138,8 @@ static void blkfront_closing(struct blkfront_info *info)
>>   		return;
>>   
>>   	/* No more blkif_request(). */
>> -	if (info->rq && info->gd) {
>> -		blk_mq_stop_hw_queues(info->rq);
>> +	if (info->gd)
>>   		blk_mark_disk_dead(info->gd);
> 
> So blk_mark_disk_dead() behaves differently when called with the
> queues still active?

Yes. In both cases, the queues are frozen and the hw queues synchronously run,
but the latter is a no-op when the hw queues are in the stopped state,
therefore it could leave requests unprocessed.

How about this for the final paragraph of the commit message?

"""
Fix this by simply not stopping the hw queues directly. Marking the disk
as dead already freezes the queue which prevents new requests being added
and it synchronously runs the hw queues to clear anything pending. If the hw
queues are stopped when calling blk_mark_disk_dead(), running the hw queues
is a no-op and can leave queued requests unprocessed.
"""

Ross
