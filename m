Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CE3B27F0;
	Sat,  8 Aug 2026 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187232; cv=fail; b=uw1MTPtHHIwlUrrDFWxOARdFNkVjU+9EKQASoM2Pc0dv1Ek7s9YNTyGiguovP9XYhgE/AtL24uD+XJ7K5MRdvziKEbNiXd2FTZRJmhmPYRPRLyAipZAiqjRNuLQz8t0nqifXPCavY7vj3kXGgfeG01Xm3LrUqzmMj4Qv/BbySKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187232; c=relaxed/simple;
	bh=9zLOY/+lCJvO6fI0+CIIPCMN4Zo44Eo6p1M5Zkay9IQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KH9WVRG9sDPeXvni0/e9VU0IIXhAjI8uVKbQ1cZB90PXRkbgRbzGKarXYze2q03avucdv0TOexiF0zVtHXrX83LIwg0g23ZlNcrie0LgYi4dJY5o9iyJJNVGE+U8cU6FWHjRdbIBV2XDrO1xDXzgOwQhDJvC7iz9zK+3HZANh2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NKNQxHDJ; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NKNQxHDJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOBMJocTjhH9je6FGKH0Hk269soiTIKRcakmHjGHYt1fSTKcNLlnVNjx+Zr7KNrDBQkwMVftNqRiI8L76zGWCtbZC1UIAH+LJ7X1c3YiKoDq6yNoohVgEwdjpLgiuFg/QUEpz2INOnaniNTVC1jHoK1D0F/ouDsnyo/16p8KCkvC4KH3ONgp5f3hwN6EpUKbfOs6Rcv9egKts7ZnbW1q4LH71bsPQaOuYUZw0yrdknV9ccrZLvP6ngeKWrCB15qa6i8gY9SgAggYSs8wWBf4Esy82r8d+DmYlJujGGkPywPv2rjKvsjctH5kOyid6WLcixmX/+4v0mYsSyMAKKtICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X46YelmUuGJz8O5Mb4SUbF4PsPza8YYxBOfJDOPJQBw=;
 b=yw1bR/ixKYaRjHTfqgZQaOabxC17blO4hsly5DWrTgdJUfc61PzEfKSVOry7E6bf8mceX2k5tLGAnJ0eu615c7iBC9iMd4QS40fxpiZjp/DaZn8fYToagvFJUq2nYcRhM7M7fXDHl+3UENSgPc7wZzkuRglXzQtZ7W5Baapc65OFPsTUrPTTkg9+e9/ImfIyV8ntySJPvC4SK2JyOCoCFp7gYmqqAxOcAcKwafKGPXvZzPDzLFBT3FWgnLc/qxVfIlvmKEWTDY7ByRV+RWs1H/Tjwq/CD5UJ9h+Y3kWaFZZaEFBjrdzyGu1RSdHa/UAZ+n+cbGelVgnyZgTQO142Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X46YelmUuGJz8O5Mb4SUbF4PsPza8YYxBOfJDOPJQBw=;
 b=NKNQxHDJe0VuMVMTLdeWxp39vdwolyEHEnTDk8WODBXyPw9ptGVX13qv+16uX8LhkptDYjCgEXqWM6NANVG0vIMiOvvNQMU5JiDqyMTfIm17ZOQ2bRx6tKmX5MxxySlWU7czihLYBQEAET9a8UCf7AIknNNalZALzKEXIt6gPo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 11:07:07 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 11:07:07 +0000
Message-ID: <10768491-bb0f-423c-8c6e-8ee1878a98cc@amd.com>
Date: Sat, 8 Aug 2026 16:37:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: gadget: cancel NoStream work before endpoint
 teardown
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260807182318.3736662-1-radhey.shyam.pandey@amd.com>
 <anZW8H1kQfwXW2Ix@vbox>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <anZW8H1kQfwXW2Ix@vbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e69efc2-e33f-4a7c-0cd6-08def53d2fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mZSr/Z3P+LHtrRGwpYvumDGuIchQgOLjZOXTSV3yuNowEIbkUnqkPZ1Vkgmzw5iR3bVPgrmmdXG3deWx2WnyPhEF1Ewq8Xkt2yJfHwFCBZJ1W24YH22y3stbDCOiTNLlgOB6IRktoVmwqHQ8ccexUC9TU33JW4Nx/TdyAP2FN2c3sFLsEdyONxtYBClNr/05VHKqOUkabABoAVrZ27MPPYDz1c0QM0cIAd7R8e4mUvhuK2Ki2tnQpMpMhQu1f3Iyyot3khpwMWSgTo/dbRL29fBow+9dBRiy0+F4gMVejtEbIPE9upTG6A7Ujxn2X+aMYRsxIkx6Ijuhy3eFlXhyDg1pCbvGt7L32jxr1SYmj1OGXFYyvr2U16W1pK8++0Dp2oSeZ01UiQEshIWFBij6UQ0IzNSrvND/LsWnLvYYGmSdyA6raD6Ud8tIbIEPtfoiYeL2+7E4jRHxayFblEb1cVM7EOe4zJRE/fngoPBLZXeOnkuJQFng+oOvUBWu0+oxtl/Em7eAb6hos0buhqvxtG+Jls2yh0/JOTllUvxsLGiwumG8XCnk97sHVqGuCR//4j2eq36Whs4gCoCTA68GKEDFPDjo+NmwtJcuPrGS+Jc4YQFmE46RFf2+TrbuoY5X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MC9yT2dWazlONUtTZGlrMGdFM2tQaDMwUHhiWFRYdG8xM1BpVjNTMmpuY3dV?=
 =?utf-8?B?NStrVXBNbVdSUnNLakg3M1h6d1Exc1N6RURzZmV4QitPcjl6WmRodC9UbGNF?=
 =?utf-8?B?c0JFdnFZVTJ1OGRTVGdFVjIrQVpDclpYbHlCZ0RZV2lCVWJvcFcxTTM1VWMy?=
 =?utf-8?B?dzVUM2p0cUdqWXdRMFBITmFOdXk2QlZ0bzhqckZkZ3B1MWxrY1BFVkhqVzF1?=
 =?utf-8?B?NFV1K2RsWFJLRGlQR3lqVllvajVLdm9rVEZWWFJPSEdJQVpjOUcvV2FHZEVL?=
 =?utf-8?B?Vzk0VVdaYVhRMjdaTVBOTkN3OXRvSzVFTFJOVDFFL1NtR2xIY2U3U2RvQ0NV?=
 =?utf-8?B?VmcyUnArMTEvbmpiZk9Wc1FMQXhXVEg3Y3JmWmROVVBKZmFocy9jTk9qYUFG?=
 =?utf-8?B?THNTT2NaeUFhRW5mNmRONWd2V29pRHhGMzRocWcxVnRNZzYwNGV2TUVLSExs?=
 =?utf-8?B?MlAwVVZnc3R4OGpyWnpYMXRrNnBDa3hjV0pMSWFMd0Y1QkNYbzVmbUVmQ0dF?=
 =?utf-8?B?V2xsSzBDUWl2YVpxUHZEWDBlelhrUW9LM3Nicm9mazMzdjdZVkxGNXdjc3V6?=
 =?utf-8?B?ZFJDMXBCMklBNlFYaTZIbFlnNldQSnBvTWthVTZjZzFEUUtPZEpoRzZqaFVU?=
 =?utf-8?B?dXNGa2FjZkNYbjZoM1dWbFpSTlpMK2hZUVQvZFR4K0dvcW1Nc05vWFh2Z0hH?=
 =?utf-8?B?VnhrbTZicFZQWGw0TUMvd1lyMFM5Vjk2WHEvY1BjYmdQUllObkVaMHFyRjVq?=
 =?utf-8?B?V3VWc0l2by9walp6OTBST0MxRURrcFdDKzdoNk1FUVZLTE4yVmIzODFxeFJY?=
 =?utf-8?B?ODF1N09rcFQ5dEtTUGRGQUtVK01UUFF3bEtIRzdSemJWK3NJL3dsOUlPY3po?=
 =?utf-8?B?QzRxSWd5RzA4WVQzMTBGcXVwcjVpaVorNGhMR05SU0RsQ2Y1TW5wNVhkNHFx?=
 =?utf-8?B?eWRFNmlzN0hTQjRiQlVMbUJ5WUllY2VCdi9HejIrM2dzWU9lZVljTlcwRHlL?=
 =?utf-8?B?OExSTUlPVEhIaXUxd2ltcWtjelp6cGdlVktYR2hLNUxqekpQa3BsNWQzR3BY?=
 =?utf-8?B?YUh1eU8rQTZOUXZ0ZWVuTmxzY0Y4VVBRbzVDVmc5Y1dPQm5yVDdlcEpWbEpI?=
 =?utf-8?B?ZjVzNGNJaTZ1SE02a21UMy9WZHNPYmVvOXRBRnNiZlhqemhIY0tzb0tmc0pP?=
 =?utf-8?B?bUR4a3A0Y0UwZUgxVW0xbnFOa3piU0hCOW1XZkN2VnIySGszcGpMZC9nNlZz?=
 =?utf-8?B?VXh2T1d6T1c3RWF1UmZBVGk3Q2pLUnJYOGhRdU5sQmdtTVlGRDFDUUdOcUpM?=
 =?utf-8?B?TWxzcU1INmF5SU00c1JEaHZXYUJLRGRlaFpSSkdXa2RORk1yYkVXUGJYenJF?=
 =?utf-8?B?WTJVejFsZnZZVmtjVXBvSmgvczM1SDgxWmFjUHNNd2ZQcTI5MStlSkpVdzBk?=
 =?utf-8?B?bFZxVTB5V0hmYWVyR09ZQmR3QnNPUUV3WjBxYVgyd2lnWDF5SFBhK3Axc01l?=
 =?utf-8?B?Z3pFV3NRMTZUV2ROZFlaS3ZQTTYzYlBWelJRVGtxQ3ZkWE5iSGZsUGVtelk0?=
 =?utf-8?B?UUhaK3U5LzZUS0lNMGJoT1N2M1RBSTVaSjV1MTA0S08zM1VBMm8wR1pjVElR?=
 =?utf-8?B?R0lYdXdRait6WTlleVhjLzdiYTgyR3pwVGxXcGJ1S1VXb3V3bDNNQUh6YVRw?=
 =?utf-8?B?Zi9mLzhmbjRIVkdScm1hc0t2K0VKNW9Id1lmRzkyUHp4RjFXNHdiNGNUMWxI?=
 =?utf-8?B?QjJkcnhNSjd3bXlNV0dGRWhpZUN3anRRRlFRM0UybVRTZk9yK1JuQ1M3elhV?=
 =?utf-8?B?Zks5WGJEQXhFTWJwYWVuWEFYcXdTY0ZTdFE1N2Q3MGJSb29hdiswb1M4MlJy?=
 =?utf-8?B?a09SOExBWlloRVduL2NnL0xwRzczR0ozSWlPelM5RjRIbXQ3VEhQV1oxU0hL?=
 =?utf-8?B?VEZnTDEzUEhUY0lOVUVTN1V2R1FJYWd3SHg0cThDeGhvV3FMYkQ4NjJXc2lr?=
 =?utf-8?B?RmcyUUZVS2dvU1V4WUovME51TU5RSjJSRVRaMUhSdHZuZ0k5aVFhalBob24x?=
 =?utf-8?B?djdqZ2hNc1RwcWtGVVZKMnViSGVSdXQwZHhlZG54RTEvYmNYV2lYQWhyUmhF?=
 =?utf-8?B?WkIyWGRiOWdLYitVbDRtS25mMmJJWU9ReUxHYVVBNnM1TUhsNVhZRVEwLzN5?=
 =?utf-8?B?NVl6TmIvQmZnVTFhcFp0bkl5bUhONUZoM3FhcmJncVhtYzdackRWbktGNHdh?=
 =?utf-8?B?K3RjSVAxVVlLaDV6RVR3VWNvYVU4ZkNBWGZEQkMvQlZKTDlaWGxXUDkwaW9D?=
 =?utf-8?B?ZHl3Q0FGaVZjNlhTbW9idjZwaGxCb2M1UmVHMnUzK29qS0VwcXcrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e69efc2-e33f-4a7c-0cd6-08def53d2fbd
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 11:07:07.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wXT73/JdTwZ2kJGspALwKitS6s48CVma0GL5ca3tdzQUNMRoZMuvFAhSPwVcfnG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428

On 8/8/2026 3:42 AM, Thinh Nguyen wrote:
> On Fri, Aug 07, 2026, Radhey Shyam Pandey wrote:
>> DEPEVT_STREAM_NOSTREAM schedules dwc3_nostream_work() with a 100 ms delay.
>> Neither dwc3_gadget_ep_disable() nor dwc3_gadget_free_endpoints() cancel
>> this work before freeing struct dwc3_ep, so the handler may run after
>> kfree(dep) during DRD/OTG role switch teardown.
>>
>> To fix it cancel the delayed work synchronously in both paths before
>> disable or free the endpoint.
>>
>> Assisted-by: claude-mythos-preview-high
>> Fixes: dcfe437492e2 ("usb: dwc3: gadget: Reinitiate stream for all host NoStream behavior")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> ---
>>   drivers/usb/dwc3/gadget.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index fa0f16ffafef..ddf1e262e2aa 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1175,6 +1175,8 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
>>   					dep->name))
>>   		return 0;
>>   
>> +	cancel_delayed_work_sync(&dep->nostream_work);
>> +
> 
> We may not sleep during dwc3_gadget_ep_disable() and we shouldn't call
> *_sync() here.
> 
>>   	spin_lock_irqsave(&dwc->lock, flags);
>>   	ret = __dwc3_gadget_ep_disable(dep);
>>   	spin_unlock_irqrestore(&dwc->lock, flags);
>> @@ -3508,6 +3510,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
>>   		}
>>   
>>   		dwc3_debugfs_remove_endpoint_dir(dep);
>> +		cancel_delayed_work_sync(&dep->nostream_work);
> 
> Just this here is sufficient.
> 
>>   		kfree(dep);
>>   	}
>>   }
>>
>> base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
>> -- 
>> 2.44.4
>>
> 
> Pei Xiao already submitted a patch for this:
> https://lore.kernel.org/linux-usb/331d1d5133496d2b4184e05f8848adb06930a138.1785893865.git.xiaopei01@kylinos.cn/T/#u
> 
Thanks for the review , good to see this issue is already covered by
Pei Xiao's patch
-Radhey

