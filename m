Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67239280C;
	Wed, 12 Aug 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551894; cv=fail; b=F1zE1m/8ZGHZ81jGE/MoLBKczj2S3K4akKSi3zFB4vyYagGMFcPzwEd0V/46/A+RkBVVIYY96EJr10NFiAaZ0Z4PoeIH7jYK4GoAbtWTAhHg9PZBeBIt5Oje8zB5Wjbd3rk4CX0VllUfkTBQw+2F7uFgDBwuHiU8Fv0SiFsB77Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551894; c=relaxed/simple;
	bh=4qRQq2dvBC5FS9Z8JfSZ5lCyaJRqFwzHVXChD2VJCP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OFM82cneKtaxqAb+GupCWD9xjqHDWKKlNOu9psZZhxx1uCfOrXKMTnUchnk+bjw+TRdLLsp235FNu+HEHUUuA2rpCR50IuAO9aIn65w3rgAkHEYyWlwEoPXDCZAYskYsFvenNT+YYNfMuTJ5Cl2GpxpxR5vgPQTDE3K2upDFsDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MfZNQXej; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MfZNQXej"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHN1/GTVVWwvwuo5+9zhg0aSVPgqi+r905wT0aIRxJrTDeD4j2siNvqGRbY4x7ueyAvtSILuaGB4Xz6Z+zBJsscO7/FN3o9MvLDYLrrRFmJ852KLHmepdzkeqGZUw8HIEXwPcmxx5KnxJxooZICLW0E5ZR4bypet9ykcAC0Sg0IwHDqOAIEm7K3UurSki5A5n5Kyj3EVmDRLR2OU5dleL2OnT0IcdZqokfogng/w9GZSx5LitKamiE3pXshSOM5RppjrFBb6lZ11qMcpgrZ2wmhi3u6jCqUaoCr4BuBkAP0denLq9Udkb7krlgoTR6fOBCnoelMgP5ocL1TE7oTrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W19NBkh7fbhMf3ZrazZ6EPqRfx9w0SkvsAbVhzl7FOg=;
 b=NbUKXf71p96MXkKuqfbQkcLCFYUinjzH4/JFGHfLsLDp0EWlSekeHRDzp2X6M2EZimxmo9KwE/dwcdBwI0vPNv2PBYBOz60VFxgbAuP7EjFWUjgNarFlFTQgdHzxoDFHeVXRxxLH483hEznCWoqF45sgvqILvX/CeoXBObbh7TaZnbZQzdoO8d1XXJlUWol19TmYxHt7hoYJjZPFRm8tq1e3SQKm4p+cU2hRZ6URIlsFxn/bZNY9bkdmaiw0rWcI2kbJW+4ud1lC5UXVvCHADGC2PKi+noVHqNPDjufDdYZ5OZjZfJsNHrdOJoFZAyUnPqyDo26HJJn76bfswmm0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W19NBkh7fbhMf3ZrazZ6EPqRfx9w0SkvsAbVhzl7FOg=;
 b=MfZNQXejxmLgcrkHdjXKJTWg7qAD8xsTQ3zAUGST3a5JHTNdGtWFMbPBYJGkbcH91u77HInHd7+xafvJN6CJG+pf38HarxmAysziZXSpknZuaqU0IS7aiYTtNS03zBhk3ge5EOXXxwJ3ZTNma1/50cJUBRjpssgMgNvqU9OpWxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by BN7PPF0D2C72F0D.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 16:24:45 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 16:24:45 +0000
Message-ID: <59226f81-ddb6-4138-a67c-90ef6db7021c@amd.com>
Date: Wed, 12 Aug 2026 21:54:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: tipd: fix uninitialized typec_partner_desc
 on stack
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com, stable@vger.kernel.org
References: <20260807174659.3720863-1-radhey.shyam.pandey@amd.com>
 <anw8wDlUq4Vf4JN6@black.igk.intel.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <anw8wDlUq4Vf4JN6@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::17) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|BN7PPF0D2C72F0D:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6754e6-d6e2-40d2-4c70-08def88e3849
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|11063799006|6133799003|10067099003|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	66GGfWW72AAXoh8xUDGdpssTSgQvfSPwTxfvbEZ9Xhos3C0SLsVMv9//Ea8LGNb2WmzYRMtImpKmXkYMU8HQJPfMnpl9hC7/DYGQXy8riG9yFFyncBHP/4oP1HQ3GiF+4AxUNU0KfTO36hPkm4HjnAGg0cbUn5xiPMMdYNlE7w6GH5GNQTUQCNYoFV+gipZbVfCT32vD0XGJk1O9eroXUqo4Wnbcda6KvDwgkm5HgWaptj1BTR3ejtWD/TGKTSyLqWgkS58fkznCTYkN25tThIV6Rv9T5wHSFgYEvEpSKlUt4HVgXsbTAPeMsWk1exa7xjkIl7sYjzkU7h+YrIcanjIV1nqGjXhVbkzAUwC7YKklalm6zfM5tkB/duS9Uqv6K4lClKc2HlQzfzJ9zZiokNYKzIkE7PMMl/28O+W27Bqv0JG3qHmWUd+5rWg+pGPJBfT1vnJGolKR8aRWTMgwGFFZppAq0CXtTqNyPIKWR+oxb9i9nQ/IC8pqghYbxhBqd8nccvKYC4tNs4EUBEl2IMmvJYwY1aNs/gUp65uV0VbmBJtAfQf4nq+gc/Q/s8PbK8PwSXGXALA7NeY7QKXFxkPR/CZZ59NP79HQxiz4FC41yquolDxfRrYC6zUrLUzIQM/M7fDM/XZQJENlqVOnEcaMLshyc9mu2uBBA6+CCrI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(6133799003)(10067099003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tld2OWlBZjFHOHRUdWRpbDgzdEhEL3RoeVRnMzc1YXVaSGZkVkpyV2FpNFg3?=
 =?utf-8?B?b25DSU80UmV1RVJ6WTRxWG1NY3ZMN2FMbS9Kbk1RbEVmMzN5WEdjWFkyUkZZ?=
 =?utf-8?B?MFNsL0RXbU01NklOTzdhMDY2TGQvN3o3MUtLVFpVNWtESGRjUFJIc2s2bDUz?=
 =?utf-8?B?OG51dU1KdmR6M0c0Z2FBRWFkbUlZVGdWdVpGN0JtKy9iamliNWZFNlpjREQx?=
 =?utf-8?B?ZjRNd2pabS9oVnllK3Y3UzNObDc4MFNJVHM2U3VCdis3RCtINVpRWERvSW4r?=
 =?utf-8?B?M1ZJRzFLbW4zMG54eUZEZlRaTzVCbDBLcGNnYWo2d0RFTHkxRjRQeVc0c1BU?=
 =?utf-8?B?REFqRnZrSEFORjRGZE5qVkhLVFNrYlhnNzR2VDl4bnRhSnN3bWpqVkg4VVZh?=
 =?utf-8?B?dk1nTDdjeWFnNVQvdzQveFlXN1dRTFBVdW9DQkl0dkd1UFhpNVdNNlNFTkJP?=
 =?utf-8?B?VDV4d01BbGxvMWpha2djV2dBY0g2Tm1pN0pzSHZaTTV4SjJiQ3JxM3pCZmZD?=
 =?utf-8?B?RExEWTB0RUhXdUFuZnhHdTl6Tks2T2xOTEZmam5BQjArRjVRQ1lWTzNIL002?=
 =?utf-8?B?TjlyVWRldmJWUEptek80djdZczVJUWNzVlR5T2VTbUZQVGExNG80K01VY2dE?=
 =?utf-8?B?QmszNHBxWmxrK2RVVTlwdi9IYXBDSEFQTU1jNXN0cEJpTkhianBJdiszS0Vl?=
 =?utf-8?B?LzhIamd3SE5BNy9QeXdpajlyb1NCQ21yQlJTT05pbjR4ZW13d25mS1A3TTd3?=
 =?utf-8?B?VWZ1OGVrK3hxREtGVmRsZXpndUxDVEhjMXJyU1ZoVC9DN093bUFuTzJuRm4v?=
 =?utf-8?B?NHlCVmZlUUo2cFBsZisveEUxaitaaUc2UDZWOTRuZzJXd0NOaEV1WkRTVjd3?=
 =?utf-8?B?K3h5OGNHY0ZVaXZ0anVHUGk1bHllMVIvejR2NHhqc0JRSDVHN0dJeDhud25H?=
 =?utf-8?B?c0Y2NE8rbm01Q1NCOU8zTGkxODlzR1ppZWk5enFyK0hLZHVjTVhNRWFsYk5j?=
 =?utf-8?B?QVlZQzg0eWRHU1Z3TEVrTnZqOThleC95TGtSUFdGUlp4bFRIblZsLzhTNlBz?=
 =?utf-8?B?ZFBHZlV1dytiUGQ0MURmbGllZ2NXUWY0M2VXaEJlaWwzQ0F5S2JldFZqb1ky?=
 =?utf-8?B?V1hWV21GNGpXMFNmei9jVmJkYXllazBuUmZXdDdDSDI1ZWxJakpYY250QXhV?=
 =?utf-8?B?YnhiOEJZY2Irb1cyUHRiOFpaUWNCSHh3cm40aXFINXdncHJqSTU5TmlRNWZh?=
 =?utf-8?B?bWREQm1waW12MWxxNXlyY2F6aFBjYnR6dGlvQWMrckJqMWpOYzJZQ0JaT1Mv?=
 =?utf-8?B?S1IvYlpjR3NBMmZvQ2ZlUk13QU5qNmVKTWgyeC9BTW5ZUU1BeE5yR0dPUjZX?=
 =?utf-8?B?OXFKR1JLN2F4akprUk5PMVp3TW5UMFhmdXo3RWYvenpoanNOMERGVHpsU01w?=
 =?utf-8?B?ZWdsZDFVTFU5cmtJQ2I3YWgyNmdMaWFKRXFqMzBDb1FEdEF2UUNQenpJeXFJ?=
 =?utf-8?B?L0x3WWNnM2d0STRyR0R6b1RXTEN6N3k5NVMrREZOZVEvc1hyczdIUWoyN2E4?=
 =?utf-8?B?dUFQREF4ekh6K0dQekpOUkNGRGVCTE02OHRDNGZJRHBUVmVCOW9UVFpnVVJ2?=
 =?utf-8?B?SGFiaFNCUXlyNHlPTVhJNGk3M3JkNjRTU1J5RmlLTHVoWnQ4SlZ4ZGtuWmgz?=
 =?utf-8?B?STJLR2RXS0VXL3RvOHpaZXdkUXFuOHdXVFlVbEE5UU4xc1hFYzV2cm1JNGlX?=
 =?utf-8?B?Z3dhQ2pXVWpadEZ6cHR1YmRPZmJTVDZFdU5lVHp2N2JzblE5Z0htSjFXb01w?=
 =?utf-8?B?WnNCUUR5N3VuUWpzaTNiMFRzRTVpM2RPdFVJZCsrWGUrQlBzMkhYWGJGUUdD?=
 =?utf-8?B?eHFYdzF2NDNQeEN5bklTaW5lKzc4OHRSR1oveUlpMlFtRnJoODI4WUxHM0pQ?=
 =?utf-8?B?YjQ0K3owUk1uMUZ5TFhNaHZGV2hTaE1IbytIOHY2eGxubm50ZnpES2ZnZU9n?=
 =?utf-8?B?WmN5dlVvSlJtdk5Gc0pzUm0wdnNDM3JSaGVzVEF2cU90WWpSVnhlaFpKL20r?=
 =?utf-8?B?WkZjNDB5MUdUTGhWVjdWUDFta1FjcG8wWTlYRS9lcW0xKzJab2x6cEJNU3F4?=
 =?utf-8?B?SDlCWitQcjllUXgxRGllaU1Lcm5kVnRkUmFEb3RnZXE2MWtmaDQyS1RDeGVx?=
 =?utf-8?B?NWxlUmt2WjZaTHdLQjF1MjBUVTBFejRVaUdXdmREbmNaRVlwaVQ2NHhrSVlM?=
 =?utf-8?B?NzV4YVYrbVRmSXRPU1BpK20wV01QNy95dFR0UzRucEFYSzZCYXNLVzRGRFE2?=
 =?utf-8?B?SUszK0RmSWZjV2ZNeWlTdmFsU1lQUjF6Wm1SZWpZSXdwczhmWmFUQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6754e6-d6e2-40d2-4c70-08def88e3849
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:24:44.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dm9g1vTqn5FAUjSG+TUgH9Y8yKwFNGHu1g87tHvNgCWjnyx/SLQOuq6aiqMteKm2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D2C72F0D

On 8/12/2026 2:58 PM, Heikki Krogerus wrote:
> On Fri, Aug 07, 2026 at 11:16:58PM +0530, Radhey Shyam Pandey wrote:
>> tps6598x_connect() and cd321x_update_work() pass a stack-allocated
>> typec_partner_desc to typec_register_partner() after initializing only
>> usb_pd, accessory and identity.
>>
>> typec_register_partner() copies attach and deattach from the descriptor
>> into the partner. With those fields left unset, garbage function pointers
>> may be stored and later invoked from typec_partner_link_device() when a USB
>> device is linked to the port. Uninitialized pd_revision and usb_capability
>> similarly leak stack data through partner sysfs.
>>
>> Zero-initialize the descriptor so optional callbacks remain NULL and the
>> remaining fields are zero.
>>
>> Assisted-by: claude-mythos-preview-high
>> Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
>> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 

Thanks for the review. To simplify stable backporting, I split the
patch and posted it as v3. Since the patch was split, I did not carry
over the Reviewed-by tag in v3. Please have a look at it.

https://lore.kernel.org/all/20260812161454.149606-1-radhey.shyam.pandey@amd.com

>> ---
>> Changes for v2:
>> - Add  Assisted-by tag.
>> - Remove explicit indentity=NULL
>>
>> AI code scanning identified this issue; the possible call graph is shown below.
>>
>>    USB-C plug event (IRQ)
>>      tps6598x_interrupt()
>>        tps6598x_handle_plug_event()
>>          tps6598x_connect()
>>            struct typec_partner_desc desc;     /* bug: attach/deattach unset */
>>            desc.usb_pd / .accessory / .identity = ...
>>            typec_register_partner(port, &desc)   /* class.c */
>>              partner->attach   = desc->attach;   /* copy stack garbage */
>>              partner->deattach = desc->deattach;
>>              [if port->usb2_dev || port->usb3_dev already set]
>>                typec_partner_link_device(partner, dev)
>>                  if (partner->attach)
>>                    partner->attach(partner, dev)  /* indirect call via bad ptr */
>> ---
>>   drivers/usb/typec/tipd/core.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index 522f56742aa9..d99a55063e34 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -344,7 +344,7 @@ static void tps6598x_set_data_role(struct tps6598x *tps,
>>   
>>   static int tps6598x_connect(struct tps6598x *tps, u32 status)
>>   {
>> -	struct typec_partner_desc desc;
>> +	struct typec_partner_desc desc = { };
>>   	enum typec_pwr_opmode mode;
>>   	int ret;
>>   
>> @@ -355,7 +355,6 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
>>   
>>   	desc.usb_pd = mode == TYPEC_PWR_MODE_PD;
>>   	desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
>> -	desc.identity = NULL;
>>   
>>   	if (desc.usb_pd) {
>>   		ret = tps6598x_read_partner_identity(tps);
>> @@ -841,11 +840,10 @@ static void cd321x_update_work(struct work_struct *work)
>>   
>>   	/* Set up partner if we were previously disconnected (or changed). */
>>   	if (!tps->partner) {
>> -		struct typec_partner_desc desc;
>> +		struct typec_partner_desc desc = { };
>>   
>>   		desc.usb_pd = is_pd;
>>   		desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
>> -		desc.identity = NULL;
>>   
>>   		if (desc.usb_pd)
>>   			desc.identity = &st.partner_identity;
>>
>> base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
>> -- 
>> 2.44.4
> 

