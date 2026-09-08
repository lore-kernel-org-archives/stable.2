Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4E54B1A8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876335; cv=fail; b=K2aAnze75hO2dMMaWsomL7GVAwBE19HdqlPCLQ23XxHkVJMJnWT632TPZvEg1rTbZJALh5ZhaQNSonrItrjSwRO36nA5R7y/UdGyPx8BgIWIhteNSETki7R5JJBXFshC+lbvylDQn25f2S28ef7Qw+2ipBoMWse8L6If2vfIWIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876335; c=relaxed/simple;
	bh=mtsj8N746bEp36ZtcOFdrH4pgQuDPtYeBO+C78eZYGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A6XUEkjOCZJ4GoUxb1WUO9Jj1TQHxfcCI+J7mXIKLBq4nDLclnf/Sc+bZP1WFAkXdpE4thHZ4JW7mtpVa5yJncqn/1z57Z/wwYlmT9BUMBJvPorUWol9RK4EpFFU3MKV7B0P0pmzh8YsZltNd5jB1DVru0oCvrgbHCOlijwQc/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pQeJr+WP; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pQeJr+WP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpsiSgcciASxnkqOF6UhpM0EuRSiG2ACbK/U/Wd3L5TZFLRQZpt+fxX/GlZPVbxrVrX+W2Qq9G8tx/VYwekSR6B4S4w9Pp53I5OGNvBeEgjajhPXsDErY1sPIDqqrumdhwD+orkKsLsh8tJDeJgQnBe17EACW8jwzAGetFiZr4H/26PLYnjn6h7z4/xpT4Gozsz9IclZrCCin5pMvaPDgC2oGPI9kndkanVjFNR8FEidQHcwZNiXqXr5/p77bKE9K0jNr4aXMgzgNho/o3foPtYjxDfl1izkUzb0QK0Qlssa2A5jkhrzAg8jE41Tm6Cp0PtIFyPiHsbogWpRrnHehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sd8lL+uNAkOT7JykRdDAcjZeuuytXTXH0gHrvdtebu8=;
 b=D/JcEosjsFjmZ5IOUZaVaYJ2XKlyooHdKjxZsXwyrQsHs2erk1IQhDfKYVQRcMpBUePGmkbtHAueXZsBaRIEIkrb9SaKtaX9bVNVDPhE2RxhrEbkGB+ls36ybqspoF4oynsDjR/JIkI4XIE9g+5bO7YIl7+cUhrnkSaCKdlyndc2J7Z6G8DGhEmm2D5VJov+RPAKUwKkA9+1wqI3hIz/onV0Budnj9c0aiepvghqch+EDZcTdwnnE9YjcJH7obNhMBavWfDSKQsEYEjd2Q0YDZXnPQXstyAu/PGlnbOVWJhJG/oqNxS0PLszqQY8oLjjLZEle+ELjFKMfK8jeLMMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd8lL+uNAkOT7JykRdDAcjZeuuytXTXH0gHrvdtebu8=;
 b=pQeJr+WPlILY+OtvXUg3D0aG3yCGzGnOuoBCnA5/g4mCxg9HSltkbD0NN3h7B22qScjVMt9CkouqO5WKvUUwr4nRFy9slIQelwV68Y087H3PGt6qS8O8PUavHuwM2MbcDcurGUr22TVwtFHgvxjlclcZaJGPTHXYXA+vT/CY3xY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 14:05:03 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 14:05:03 +0000
Message-ID: <daf90404-9aa1-4f86-ac41-bf6e28446b08@amd.com>
Date: Tue, 8 Sep 2026 19:34:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/drm_exec: fix contention when num_objects is 0
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260908091729.2749399-1-sunil.khatri@amd.com>
 <1081fa83-d2f7-40be-816d-29f28c6e7576@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <1081fa83-d2f7-40be-816d-29f28c6e7576@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: c771bb7c-7ea2-4c01-89b3-08df0db22dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3CgrPFvUHTD1xWaC5iGzhmg9X84HN7IUWcICPFtlTV9A/JUjPR562tnnVTOn9cdbOyAvkSj/pRIFCo1geqMfC+hTgoyteI2XRNwh6QIISXLxIqX7kaiiEV2LqCIhfFM87ssEa2UIIel8tuGeMM4gFVYvYObUK77QQDediDtroMzGOeXJLJNUVMxAzt9o59+lLZdTMUytU5Q07DmaJPMfqTPxMva08/Ajr0JVQ/9ho9v3QeIXic59H2/Hanu2gSyID+FWdRrl5KEJU0R62M5fSQB20pPR7Om7/244do9fJOii7LMscU1qqbemtQoj1i/Ina9XK2g/YnM7rPf1cbg8IcI37g0adWqgPXFQ8Lu1TX33AGWsdak/cCx/qsXln4nQUyFePwOerXO/qITmib1LsT4C7711UYcWAL24ZiXD/7bL9rLCE0PpiukcXVsKv6qPp+IXWFtovQYt4SHj2CQ8ytmDb7DRol6H5ZOh5wAK/xV95a9cOsy4ccoqpqjBs3gVdTVuEN8YPsWiSI7B4z7nZR633yUNQRVJW2l/mOS2Mm31UzeHSRQyJUHMQkJtixvQmz/iZFcHjuB1TAtxV+D90qpGmK23pSHfVHmDLJ3NeYrm3ARipihN4MrOA7eySPSyeV0W/rRRJtbPsg1HHNk9AL1ln33OdSLPplScUwlzp6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7794.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUlicE5TVlhCTENrSEN6c0R0R0VVNmp3WmtIVEMyczRyQzV5cjJqNmR4RTFk?=
 =?utf-8?B?bm1wZmtpdkxRWlNUTjNndUZkUlhKRGZsdlozZHJNMWR2U1lRczE2THpwNk1N?=
 =?utf-8?B?eEJKem5hL1l6S041ZmhNcStRbmtLd2VZRUgzTCt3TStmaUc5U2h6ZjZCMVpI?=
 =?utf-8?B?RWZVb2dQTnhLOUxUN2VkakJPcVgwVVBTSDJ3ZVI3c3lQNEhsb0lPRzBEVE9r?=
 =?utf-8?B?dUhPN3k2b1lTNDM4dWhuNDNuZStyTUJNbWhRUmNOR0FEbEVPV01Ob3BTbnA1?=
 =?utf-8?B?dTNFYXN2ZndDbjF1WUdaRnVySXE4aElHa0ZaVjU0TU81T1BDRStzZ01BajBq?=
 =?utf-8?B?VFpGWldrSUd3V3FOR25GbGlCNjNBRzZZOVZYaU9IOWoraVZJcTNkYXVQVjZ2?=
 =?utf-8?B?TlhFT0c1S0NzbFlqTGYzQ1IzZTBYdktFd0k5OFMydUpXcFZPZXlvTk1ZMlIr?=
 =?utf-8?B?WkFXT1NxbnV3a2IyMTVNZXQvQUJ4RnZqL0lXaVVrdXQ3M0lsNFFxelNvdlI4?=
 =?utf-8?B?eTRTTGZsTDc2OWF6UTdRaVVaZmJ2Y2hHcUV4K2o5RjRnZ1YrZGxWUmFIMGd6?=
 =?utf-8?B?Z0JiWk9rc2hLU2tlVGYyeldCeWRoMG85Yk9rOTlpeUNteUloN3BQRy9iR3Zw?=
 =?utf-8?B?SHVjZnB3bmt1MnY4MUVaVnEvVUlUOEMrbENpQTFqdElKVm9ibG1IN2VZUExl?=
 =?utf-8?B?c2lxaXRxa3ltZHJoQUZBdjFXSVlseGFMelV0TnhLRkhXVTh5ZE8rZmJ1U3A1?=
 =?utf-8?B?WG00RlZnbVpXZGpmVWgrRzZteUphbUgyeXJIaGtwTEE5MjVHQ0trcUExVjBz?=
 =?utf-8?B?SkI0QmlIV2UvUzlOdXJrL3hHTXRHR1A2UU1sY3YrdmRVTkpVZDlrR0NCMnN3?=
 =?utf-8?B?bWtWeTRSY1I4d1Rsa093QmZ4WmsyWEJKTUtLSmdWbVRuZjRYempTQ2Vpbkh5?=
 =?utf-8?B?bW9hYUhZM3d4MS92b1FnZ0JGejNoUGFuY25IaE5jbHRoZnRqSGZHQ3NNakR0?=
 =?utf-8?B?eVlPc1BmZ21CR29ob1RYcXZBeXNIcTZkVG5TeXBiU3c3dGJ2RzBPYmdOL0NK?=
 =?utf-8?B?NkY1S0VZN1E5dy9QUDdKSFF3OUt5VDJlRG41Z0drdTkwdy9qL1V1K0R4TGMw?=
 =?utf-8?B?Z3RlU1FYOHBzSE9pMGNSSGxiQi8vMm42MjhoUEhZRVdzbndBM1FoOFRZVnJF?=
 =?utf-8?B?NVFjc21FbXFMMUp4UFB2VWZqcUJxeWhVNTVReWdpY3RhNFJJRm5ib0xWS0di?=
 =?utf-8?B?S2ZyNVJpdlhNdEJTUDg2RmNVRk13QVBndTBJVVBvVUhCck1vUlF3Z25Xck9C?=
 =?utf-8?B?M0NkenR0WGpIN3ByZU9Za0pTYm9pRm0zUjYveStwUEl5UTB0NGtuZXRMZWVK?=
 =?utf-8?B?WmNIUlhCWHE5aHlBZXc2dXhpODFlR2FYSkYydDZKclFrdW9uVlJsY1ZSa2tp?=
 =?utf-8?B?ZU04SmhSNHdFTERJTnF2dTVNamxOdFFOK0ZWaS9sWmx5TXpUZmlqUTRJaUVC?=
 =?utf-8?B?akZyYmxlcnNIR0V2K1hVRTBCaVRmdkZxelMzUmYxVlg2RXZCdVcycG5Bdnha?=
 =?utf-8?B?eFg5UktQQlk4ano0OTNlMUt5YS9xS2YzbnhPcTd3WXhPOFVRemtKU3BBV1ZV?=
 =?utf-8?B?VVVYb1pWbC95SncyazMxQkhKMStYZzc0R2x6cGtxU3dEZGtUMnlyb1F3Y0pE?=
 =?utf-8?B?Slo1Y2dzZDJObU5CVnBJYmFPdFZZeVNpc3FOcStRMzQ5aVlsaE5jWjdjd3V2?=
 =?utf-8?B?WVRoQ09sUGJKT0s0OHlHaHhrRGwxYmZJZGZNL2VYQlY2YmNLUmE1RWE5aFZy?=
 =?utf-8?B?QXVYRld6UUlSUlB0cnROVklWN3N2QjcweEpqc1FlY2JBOW1pMnVCd1ZPNlNX?=
 =?utf-8?B?cDk0SE9sQWptVTlycXY2WE9jc1E3UDgzS2RnSzAvdHI0a3V4N0pLMkZ0QVF4?=
 =?utf-8?B?dEw5dGdVMHpEVTloR0E0NWlsby8xQ1RYMld6eVFxNVU3ZDlma0VZSHMzR0U0?=
 =?utf-8?B?QlBQanFYTHZKWWRtYStUaXZEUDQ2YWdETUJEblBDQzlES0Z6Tm1Bdmc1cC9i?=
 =?utf-8?B?YVhTVm5Nd0xlOFY1Q2thdFFTZEd1M0hnam5JMmMrUXY2QktBMFpEdUplVEs0?=
 =?utf-8?B?VE9SeDdvVjBrVHVvemZ1TmU1U2preVJzR20zVXQxZm12Z1RwdER5ZWlyZWdD?=
 =?utf-8?B?VFRWY0JQSThjUVBXd3VrYzY4ZVFTSlRkNldGQktBTEtiS0xPNnNZU1pRZ1JG?=
 =?utf-8?B?YUJyeUNSbFpoRkhzVkJFVUhQS0EvOWNGNUxzMWowWHlLd1dudVNrOWRLRkNH?=
 =?utf-8?B?Z2VjNmoxa3pFRHdKbVRXUkhuY0Vyb3cyVmlZeC9FNk1sV1l1a0Z2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c771bb7c-7ea2-4c01-89b3-08df0db22dd8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:05:03.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUOnbyDycBA/rsHmWaxOkYeDMwDOcWguOAaJXtBXS9zS1WpuvcYa6jbHetrLx/4OOsHcZSi8NMtoUdvfS1uMXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551


On 08-09-2026 07:26 pm, Christian König wrote:
> On 9/8/26 11:17, Sunil Khatri wrote:
>> drm_exec_prepare_array() silently returns success without calling
>> drm_exec_lock_contended() when num_objects is zero. This breaks the
>> invariant upheld by drm_exec_lock_obj(), where every entry point into
>> the locking sequence must first attempt to lock any previously
>> contended object before proceeding.
>>
>> Drivers that chain multiple drm_exec_prepare_array() calls per
>> drm_exec_until_all_locked() iteration (e.g. amdgpu's userq signal/wait
>> ioctls, which prepare separate read and write BO arrays) can pass an
>> empty array for one of the two calls. If contention is hit while
>> preparing the non-empty array, exec->contended is set and the loop
>> retries; on retry, the empty-array call preceding it is a no-op that
>> never clears exec->contended, so drm_exec_retry_on_contention()
>> immediately jumps back to the top of the loop without ever reaching
>> the call that would resolve the contention. This spins forever.
>>
>> Fix it by having drm_exec_prepare_array() call drm_exec_lock_contended()
>> directly when num_objects is zero, so a pending contended object dont
>> loop infinitely.
>>
>> Fixes: 09593216bff1 ("drm: execution context for GEM buffers v7")
>> CC: stable@vger.kernel.org
> I've added a # v6.6+ here.
>
> BTW: If you identified the commit you can use "git tag --contains=09593216bff1" to figure that out.
Sure thanks.  So the first tag when the change is introduced to be used 
which here is v6.6.
Thanks for the tag command.
>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> I'm going to push this to drm-misc-fixes, please sync with Alex to get that cherry picked into amd-staging-drm-next as well.

Sure once i fine it in drm-misc-fixes i will sync with alex to 
cherry-pick it into amd-staging-drm-next.

Thanks
Sunil Khatri

>
> Thanks,
> Christian.
>
>> ---
>>   drivers/gpu/drm/drm_exec.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
>> index fa923852fae4..f4503ab82c66 100644
>> --- a/drivers/gpu/drm/drm_exec.c
>> +++ b/drivers/gpu/drm/drm_exec.c
>> @@ -322,6 +322,19 @@ int drm_exec_prepare_array(struct drm_exec *exec,
>>   {
>>   	int ret;
>>   
>> +	/*
>> +	 * Make sure to lock a contended object even when no objects are
>> +	 * given, otherwise drm_exec_retry_on_contention() would loop
>> +	 * forever on patterns like:
>> +	 *
>> +	 *	ret = drm_exec_prepare_array(exec, objs, num_objects, ...);
>> +	 *	drm_exec_retry_on_contention(exec);
>> +	 *
>> +	 * with num_objects == 0.
>> +	 */
>> +	if (!num_objects)
>> +		return drm_exec_lock_contended(exec);
>> +
>>   	for (unsigned int i = 0; i < num_objects; ++i) {
>>   		ret = drm_exec_prepare_obj(exec, objects[i], num_fences);
>>   		if (unlikely(ret))
