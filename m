Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715E4570DC;
	Mon, 17 Aug 2026 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985271; cv=fail; b=YPFtq8QZQ99uhTARJG461zNh2e1J+eMZpxkl1czKSaMM4FLG2ovOPqBK+LbgsbDB5lbJHrobjrg+DQ9L7f9mxLqgggZHF3/ZBYPOa6gDZWiaU74tgKJtDIHXSRc+otzFDY5LRc7giRbAd0EO7RW1p5USl4e0UE4FpwK7k77rnbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985271; c=relaxed/simple;
	bh=fshWY3/7H25MwcHZ3FOq8MKZYXarPuJEQMUACLQ+y8Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k/uz5l5sNb2+9acD9o5BYL9MUQuXM8NbPoMLzX5iftpudRvjT4cGvk57ioBYhMSOQ2bbpFqz7++HO48gfdPSrKnKYyws7b53bFFpFDhX2dBkfPWvIHj60r9c9iw10F0yfSbbxKTWZD6TmrCI+SW60V7UBcpK9ErzphDG1f+XglA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=viVVDxOm; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="viVVDxOm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcIjQ5k5gtDNqqX3sgwxla1HDAkNEdZAdPoMotIi/f7ohP6sjdBC48QpLE9ZJ3UkE84reBcKykODz8h2iegR5XQoIXZBkBFhf4MGgqriIw72pyr2dmKmuCT9GcckQXZdFFEO/VWmnNwnOa80ZdPzD2jst/MYwUgJaB7DaW+h1XIxa6m4oQS7V8YmSHTBmbmgVFnu2DbFdUOQSzVLcPoTrMiIFPc/73AZVarxwUG75O1PMbHiKMvjbrgY8hrdQWqu7z7h5G+YgHEA/0ybJNQgHmpXveNNGBSxAdxpr7wROu2YWU414tvkcMPDin3eFOQ0r59x7NqKPwRkqXyyrZ5TmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEaBC98C6MSnA9NHyQkOPGiDF4Xct8OPeACWb03tjAU=;
 b=q8+WmH2+CxWSM6UpyMGY007iRI8f4ekTNZYWahV7Y4FRFEnIF29cBpPiBMnQB4QQbfKeiVr1YoWDTydmayUFjemBilp4Bj5Fxu9lnSidTNxyfytHVnWOTLLON8TM7zjpHfAUVIRJx1fIjsDGBt8JuIMurhT/ueKSGu3VuAbzy+pP3A4d9oiAKkHw7G8HZSIDYefFdK6uhiFYY7IKq9xJdElyeyfoap2/eM22ctG7oSdxX7ua62Ec9luAYszjeq+iwkbF5KsxkS0z5JM18/hqTlBtT7v3iHrKEcupY6DrV9SW5FyyJn/XpbJh58Njgg2/3MpwPUJhk0jEFpcQMQ+vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEaBC98C6MSnA9NHyQkOPGiDF4Xct8OPeACWb03tjAU=;
 b=viVVDxOmcEP83VaZkHvvqObm/vFF74N+WwM3pYEPwUnjcEam044HtYp2fijitWdnaUyyWIO/M9a6suFANnVgPItotD7t9EpV16C7DYtHUDuXfrrBciwL+DzLCKFxwQCeV1jH/NEdNzqKPqCyINwMuNYnVg5Ubu9ZlQrsuNKE6J0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) by
 LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Mon, 17 Aug 2026 16:47:43 +0000
Received: from DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e]) by DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 16:47:41 +0000
Message-ID: <7d66516f-f636-4452-a0cf-9ae18c5b7637@amd.com>
Date: Mon, 17 Aug 2026 09:47:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/ionic: avoid OOB TX partner lookup for
 hwstamp RXQ
To: Shannon Nelson <sln@onemain.com>, Anand Khoje <anand.a.khoje@oracle.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Abhijit Gangurde
 <abhijit.gangurde@amd.com>, Leon Romanovsky <leon@kernel.org>,
 Eric Joyner <eric.joyner@amd.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kees Cook <kees@kernel.org>,
 Mohammad Heib <mheib@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260813051315.430146-1-anand.a.khoje@oracle.com>
 <5c7cf96a-74a6-46c2-bde3-f39b25a2d09e@onemain.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <5c7cf96a-74a6-46c2-bde3-f39b25a2d09e@onemain.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0441.namprd03.prod.outlook.com
 (2603:10b6:610:10e::34) To DM4PR12MB5389.namprd12.prod.outlook.com
 (2603:10b6:5:39e::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 92020875-9952-4739-d232-08defc7f4105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	3rbBEgotYzPhDNdUG+EA2jpabDABaqfSedOlc2kkL5pTWskwfR1LbCFoTKTg/GrsXsgLBqxx0OcIhOJYbMt29Nhe34YjxVSGbjO0bUQbK53QHu8vSVid4lbxvCW9DpTS41UPTK9q7jjkLmHe5Ctm8yB3XBO08WRxdBzsNwZLUcxNTMG6TmXQPtXVJyGpCUwZbgEvTTIL3zB8KM8TzZ+PV80JPnz66ByhT4x5P75sZkK492OOmnEJ0yc1zgbaA5QSe1JhQweaa0zsgFlTMaKK+0pan7Wlu2nObDwxaodjICWhHev0f6i+SmMy5W2fF6l9qgJZiDhsp8h1cMtRSQMgNt4aHYCxW4oK77UEOEz6obohwSSuU1mzb/7JqjNCrhjT1bjN7sYHtiFjQQz0xrps8yIILIgjIUtlAIHVQwQxXyS0+pZWN3/WklVUk2fNTG6V+jNQaAw0+n7ZrVxWcitIZ/UqwL1TJQjYzPY10A+07N8B2W1I6LnhV3Yv39k3rjFM0t/WmdHnKW1zn/DNJ9yaLXzz4GHpuiaaZTINky8L3t8boaxFbX8JMi1S5oFLEJnD+sRkntVQ0opjFLVR23YWHxBmwvmgoCXv8tiX8I3S6MueLvT7eU1i8L07j5KTEzR+CrbE6Uosicsmzz8zhB+WIcclU15/3nh6Fx14EtKuGupAY/SDo0hEfAGfpuhx2JAT2gtQL5my/J9tfImTixO0KA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5389.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkJLNTd6Qm8xdW5US1JWSXV4dXBycWM0L0hYbmthUWcvMk9Oay9valEySUpk?=
 =?utf-8?B?QkxRaktaRk5ueWYwbVFob2Nna3lxRWxDQU5rdS9WdkwyODJEOWloRXdZbksx?=
 =?utf-8?B?bEJuM041TDFXZi9UaUxYa2dPK1o5UElrWGRTUXJ1ajVpbjN5VVpoV1UvQWN6?=
 =?utf-8?B?VXpFV1gzQysvcXRPMlpuREdPK3MxbjR1SE1qYnZheDRhMDdpOFhjblVxSnpk?=
 =?utf-8?B?SU9MNE1YcnhNRzhNZkZXV3JCMUhucXVEdlNPd3daNUdGVXA3a0xQdUxzZ293?=
 =?utf-8?B?TlJmeGQzNnd4dHFQNEM5VzlMUXExZTBEeG9odjhiZ0NsaGp5Y0pRWUs2NG5W?=
 =?utf-8?B?L080cXRYRXZaTXNzMzlncHhWN3ZwS291ZGR4UUo4d1o1djEwSlJQMkd0eUh6?=
 =?utf-8?B?WlNGbTFSWXZxMm9IYjlKd2VpSHJRdmNCMW9JRGZoNmpjQzYvYVhYM0Q3Mk5n?=
 =?utf-8?B?elhkU3pQL2oyTkRRUkZJZ0RNcmtPUTlScDNQZmE5eEpOU2VnSjdGcEh1OXFK?=
 =?utf-8?B?cnBQbmczeHViakN6VTdqc2hFV3FHWkgzSzFVOFNWYnliZndWYUZWWnZTTlpW?=
 =?utf-8?B?ZTREalZ1M2VrdnJXc3hodGVOdVVOamVFVjR0ZGw4RmdQQmtFejQ2MEpTa0RT?=
 =?utf-8?B?cXpadjh5M3VkTkppdlhNdUFGMlc1OXJ5NDczcllkN3I1OVVaczIrTkk2eVpU?=
 =?utf-8?B?c2ZPQklkRVpSdTZQU1BuUVRlZksyd3hGVWtsUmZJSmlYbjJIZ2NHNCtheGxa?=
 =?utf-8?B?TXo1TXFuWnlWUzZDQW5wT2VNcis0U1VRa3hnOWFEbmNpWGpPSTFIQUIrQnZ2?=
 =?utf-8?B?WnViZlNTZkRrb1V1RUh6U0FEUE51TmVTREt3UWNlMnRNSVIvYmgwQmt3TDRx?=
 =?utf-8?B?d1I5WDluWVlXemx0dm54c0FjTXVtdFNEbTRJSGZVbHYraVEyMUVxZmdFa2lF?=
 =?utf-8?B?WHE1djhOaHBZSWtMZE1Wam5uR21kbjc2WjIwTksxMEg5NXZqZ3VLUVlkRXRZ?=
 =?utf-8?B?eWcxRjQ2QUVoeGxiMkdQcE03bXJaODdpVlR4NmNZN0VjYnhjeHQ5L2VmcEZ4?=
 =?utf-8?B?UGU5T1dGc0EwSzdrL3M0dGpaZnNOWkcyelIxbkFCNFJoTXJPU0NTL09UTzJK?=
 =?utf-8?B?U1FQSUpjS1NsUnB3TzgyaUlDV1ZuOEl5a2w4TE1wRjdRVEtoMVdKVVJkUzhC?=
 =?utf-8?B?b1ZIdURrc3FsTi83SUJ1eGhOUlhiZWdqSkEvVjhjS2JxVEhBWXVJTitoamd3?=
 =?utf-8?B?bzlDalRKeVNKTTVUa2hRRm9FY1FvaFh1dDJQaWNDZnkvRWMvNStxa2toQnp4?=
 =?utf-8?B?WTgzcDM2bUFBZnN5NENzdXRGdHlJdVNpMTQ5WXBiemhCMUU5cURyR2hkSUxV?=
 =?utf-8?B?TC84RlE1NndCNk8wczhlbHloZEMweTEwazVCZHByQUFOcFFORDRoUlk3VEZX?=
 =?utf-8?B?WDJoNHJ2dCtla2NvZnhLdjJEbmY5ZFRHajNOYldnQWxiTGU0bFFhKy84em1n?=
 =?utf-8?B?MzF6SHJhWDgxNVhSWWM1T0FXdFRxU2VlVi9GVUwwOUIwcGd6c2pMVEhKU3Fn?=
 =?utf-8?B?NXVOblZ0bjE3VHFBRWdhekplTDJ5aUtuQTkzZEk0SFErVjVaRXN2dUlCNnho?=
 =?utf-8?B?aU5UL05NcFJYSElmR3hBaTdMdnFtdXVUakN0ODEwUkhIKzBXU0pKT0lqVCtr?=
 =?utf-8?B?ZWZIczN3cGJhTE8vRXJUR01MWVcvR2dRbVBlakRJdGU1ZmR6T2RiZ0lEbDVH?=
 =?utf-8?B?VmRGOUJIbWxOUzdPWW9zNVlHRWd0dWg1L2YwZE5wVE50elZoSlJUZi9ubG9I?=
 =?utf-8?B?dEd5dXhYU1I2MnovRnBiM1BvVGtvWkpSV1orU1ZaZUFUb3ZFRXRNODJWQWJ1?=
 =?utf-8?B?UVQ1WlVSaWRGTWtDcUtpZllYRDlwYUpaVGlLK3Fja0tlbkszYjRqTkF1SnlG?=
 =?utf-8?B?S201N0lxa1g2amZNYTM3aFhwSDg5eFEyaVBkWVd4R1RmOGJweldzc05tVGNp?=
 =?utf-8?B?ODNHc0thSjdncmNudVZTUDgrOFVNSzQ5ZG1YamxqZSt4cDhOV2RWcjhOSU1s?=
 =?utf-8?B?YnJKUHZ1Zi84R1ZrcllTemNka3FCYnFoNkVqK0ZBcHQzUTFtTm5oNE9KV3Za?=
 =?utf-8?B?MVRDenM2LzF4ZXU1bUFlQkVCUElob3ltQUczTzlPR0FMZHNsY1N2eUJ4c2pu?=
 =?utf-8?B?ZXpQdVFQeEdLQmRyU2YxWjVlaUp0NXc5OUlwWm5EZVF1WjhkWHpOYk5BbHdv?=
 =?utf-8?B?QkRJWnhhUFhWZml5bk8wLzNRemkvdmE3YlpFMCtiempjQ1ZqamZyeG9Ub1Vq?=
 =?utf-8?B?OXhXUzRONy8wUTNodTJNQWxsZmdGTWNDVGtUSVhiRjQyanpVbWhqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92020875-9952-4739-d232-08defc7f4105
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5389.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 16:47:41.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AbbYZhPcgLUHvlwSKthcKPXmDs/2Uk8gvMvxYVJGa8zsPdIdtzTADnA4HszzgS/DaZQVcRlBxhy3VysvTGsSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750



On 8/12/2026 10:52 PM, Shannon Nelson wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
>
>
> On 8/12/26 22:13, Anand Khoje wrote:
>> The dedicated hardware timestamp RX queue is allocated with q->index
>> equal to lif->ionic->nrxqs_per_lif. The normal txqcqs array only
>> contains the regular queue pairs, so using that index to set 
>> rxq->partner
>> can read one entry past txqcqs[] and then write through the derived
>> pointer.
>> Only link RX/TX partners for normal queue-pair indexes. Leave the 
>> hwstamp
>> RX queue unpaired, and make the XDP_TX path abort cleanly if an RX queue
>> has no TX partner.
>>
>> Fixes: 8eeed8373e1c ("ionic: Add XDP_TX support")
>> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
>> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>> v2:
>>   Fixed the Fixes tag.
>>
>>   drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 14 
>> ++++++++++++++
>>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c    |  5 ++++-
>>   2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c 
>> b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> index fd3ee9820531..1822361e1070 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> @@ -920,9 +920,23 @@ static int ionic_lif_rxq_init(struct ionic_lif 
>> *lif, struct ionic_qcq *qcq)
>>       };
>>       int err;
>>
>> +     q->partner = NULL;
>> +
>> +     /* Only normal RX queues have matching TX queue partners,
>> +      * skip partner pairing for hwstamp RX queue.
>> +      */
>> +     if (q->index >= lif->nxqs)
>> +             goto skip_partner;
>> +
>> +     if (WARN_ON_ONCE(!lif->txqcqs ||
>> +         q->index >= lif->ionic->ntxqs_per_lif ||
>> +         !lif->txqcqs[q->index]))
>> +             return -EINVAL;
>
> This driver doesn't have any other WARN type statements, and the WARN*
> is more often frowned upon now that so many places use
> panic_on_warn.  The other place where this kind of check is done simply
> prints a dev_err() and returns -ENXIO - see ionic_txrx_enable(). Brett
> or Eric J might have another opinion, but you might stick with that
> practice here.

Thanks for pointing this out Shannon. I agree and would like to keep the 
driver consistent regarding not using WARN statements.

Brett
>
>> +
>>       q->partner = &lif->txqcqs[q->index]->q;
>>       q->partner->partner = q;
>>
>> +skip_partner:
>>       if (!lif->xdp_prog ||
>>           (lif->xdp_prog->aux && lif->xdp_prog->aux->xdp_has_frags))
>>               ctx.cmd.q_init.flags |= cpu_to_le16(IONIC_QINIT_F_SG);
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c 
>> b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> index 301ebee2fdc5..73998d61593 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> @@ -543,13 +543,18 @@ static bool ionic_run_xdp(struct ionic_rx_stats 
>> *stats,
>>               break;
>>
>>       case XDP_TX:
>> +             txq = rxq->partner;
>> +             if (unlikely(!txq)) {
>> +                     err = -EIO;
>> +                     break;
>> +             }
>> +
>>               xdpf = xdp_convert_buff_to_frame(&xdp_buf);
>>               if (!xdpf) {
>>                       err = -ENOSPC;
>>                       break;
>>               }
>>
>> -             txq = rxq->partner;
>>               nq = netdev_get_tx_queue(netdev, txq->index);
>>               __netif_tx_lock(nq, smp_processor_id());
>>               txq_trans_cond_update(nq);
>
> Other than the above, this looks fine to me.
> Reviewed-by: Shannon Nelson <sln@onemain.com>
>

