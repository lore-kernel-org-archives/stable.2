Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022108.outbound.protection.outlook.com [52.101.126.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF82DECB2
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783653448; cv=fail; b=AdWHMAe+lXefX/qjE3aP69hEMQukGcJ38ujljIKMEmIhtHQamLH1M+70gyZ6UuFFwU3sdHpbVJiQthz6zqGZ2aXnWm5apAClgXaBwErCtvE487RVV4PtMXNVEbtGudrRmbMUDh5+gzhhXxFqz7a0ESLOGjMTdr0A5waa6GOe3HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783653448; c=relaxed/simple;
	bh=KqL9VPwkuzNT7S9RbhCQfir/9UXZ3pvOw4b98kvRjrg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QUt8ibm+AaFB/vsAA2iz+pBCuHPVXrRB6cO0FM8D41C5tbQXc2bKiAdk8PBJC0taCezJMuxcKRbzNNeA2tQIMqMvlvKsW7g0/kPy2yi63LWazk8IAcxnF6VfqB33JEhtB9MblYkDqKC8IwT1O/zkOXiapxrzXzblbDuNrSkvzW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=W/wTQLkg; arc=fail smtp.client-ip=52.101.126.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="W/wTQLkg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmU3To8dqt1ouXK83NovUMLFAC657V2ggOQbW+KZCeILAL99dj7MqmiZ5P/Njbbo7kBuOqk3FjdKdOGi2ND8FRLMcmKZJXfKZWNgJJm/KgsxbLCoGQ/eWkxxtg0bfbd+cymcs5A0GkzO5RlqXaMTQ8DJ1feASQsNkWPC9nWKy+hAsBIXURpRo0h38opBDV6UJi/R6tlyNEeFiWih5NyQaW3nNbywTKYJfBArs9l0GhkUhS8/C+H92WodFFRi1+LFTVs845cs5N4Bobe0tr7VRXcw2yaryo+muTphatLFMk1SvGoQp1GEiD71wIkmjxFC70uw27dleGICBWMlsxXjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsJ0X0+x3wSZCXtJh7PFD/Yilb4Xhn1stDyxzrWBSdU=;
 b=fmqe8lkbQ4fA1ZXqPKuOJiBh/n1NSlfXREKQJ98dJIw7XlcFm+YJupfUteGrRklyVkJ1VZOjLRIfX2IIFQlBHs1zFnZSidBuxaoMLlXHG+QAlKHO6hiQrZ0HD7sohob/QsJk1P47WteKSX/gkFwuVzKlCZk3If5CzEAPy3Gxggk9pI7eIikLTvPAyTTVKHGqkUr347aHmnEmoTF44pjEe+PuyvHEQFDnz3F4MChH+bVzAUBALpPOv+SxZ/U4FCgyMEndzjfFoxOmLg00txZKjnjBzNCIocUguh1tBVacp3PioOq7DpdTrchcj4ZJkUwlvKgCae6oiPxigMIz3GCC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsJ0X0+x3wSZCXtJh7PFD/Yilb4Xhn1stDyxzrWBSdU=;
 b=W/wTQLkgi33HJ8j4y2XFa3zJZIK6lWmoPsoXQxE2P5s0J+lr2A/En3vEJt7TigHK2eoYb7VE1mwEpSblyWxPJepIsnBXpcWz72tK9dGfJZ0w3k4WGsVIC25QysRE4weZzidAEEyci45CjVOD9DSMaF+MrjRWXdnFu/i6CzDByNbjmnatHd2L/KWcb/UDQnyjIrnJVzAQoyDVDScz+XhRG/oYFmzNmTUiL8JxAg68cuSIhs8hcG+OnY8yDgLlUKL3q0lWAkdwCBVOPK8d0c8wnwnaZ1lNHEqvYD4p74nRo/hm+CE/54cTWCJlRnU22Kw/06gxGdcLap4kS3zMZahW2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by SEZPR03MB7679.apcprd03.prod.outlook.com (2603:1096:101:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 03:17:22 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f%3]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 03:17:22 +0000
Message-ID: <21c69c82-f947-49b6-a046-cd0cd3037dce@amlogic.com>
Date: Fri, 10 Jul 2026 11:17:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix UAF issue in f2fs_merge_page_bio()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, jianxin.pan@amlogic.com, tuan.zhang@amlogic.com,
 JY <JY.Ho@mediatek.com>, Chao Yu <chao@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260709-origin-5-15-y-v1-1-5ac64636d2e8@amlogic.com>
 <2026070937-unveiling-atlantic-b798@gregkh>
Content-Language: en-US
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <2026070937-unveiling-atlantic-b798@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0060.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::11) To TYUPR03MB7232.apcprd03.prod.outlook.com
 (2603:1096:400:354::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR03MB7232:EE_|SEZPR03MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 70eff984-da1d-448c-91d2-08dede31c207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|56012099006|4143699003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	vrnPPlM9ZWJ12TUzlSFyfFOdyqhkvyDpYjfvHIMEftD8P2ATz/hZrlxWceoyorYMDbSid8Aj9zURNpKZJejGwYQ4QmpdXCpzf4ZiJwVLGKikjkvKp5q+/GDh4spMjHAfudI9K159IBdAcWy0wkE3yY5JbP2Y1xg3N0ntJWjky+gqOXQ0WY+uau3QXNRlqyu+cYdgpYdn94h/fEsjnlgVO3oKQ7WnmC5kGyoiwNhkTazltKahWLjCz4glmnN6a23wSOVxs4PTQudmC6+39tXOB7PKtjupdTHcWx8AWGgsl9dAKMhmYk3H6e6cVBcHv+npwm5M4iW0HVLSU0/qtLFMqMf8vmmE7KV0ck6NCrUJwS6CkV3OyXQZXeG/PDWPFg1Dst8uGGE+j4gz5/yJsH0H67xcoVMtpzalVLeQ1I0PbplFf7gO1iqOk77VhpJu03xHBSVNqcAgca+vO2xUo0THvbVptS7QAsSjBLU+CYJwOGdLLJkJyDqRNrA1k6kk6yp4UvEPcqOywqCaE7FeTm/ycy1ya045UU2zjBezG3b+WyM1mmEO1nXM7nDfx6rTsUpO+H3FJy4ddcAnB55ZUgLkW7veL56Z87psg/0KHfVLJjS9xH6uZ4c/HDnY9q+ljoLt/Jl70E9dflkq2yCH1qN9K0TUmFcsJs/0uCg34wA+3tQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7232.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzFMNnR3SlJWcmVEdFVJc0pmTmtwaWw1WkxvK0ZrNktSTkM3NWhTREV3Y0Rk?=
 =?utf-8?B?V3RHQjlxTjJodlJjUU5HVE56aE1TckFBSEdYUnV6empFVUZhVi9nOU5oeW5k?=
 =?utf-8?B?VXZueldxWVcybkhnbDA3Y29ReEk5ZlIzVi9ZUHpsSlZUMUpjRTNPdll4WllI?=
 =?utf-8?B?T2JDMEpreTFuSE0raW8vUlo5WlNCMjZwVk9FV2FlNTlrSndMYXhkejUzS1hO?=
 =?utf-8?B?UUl0MXlvamhySi80cStJYnc0QjNmVjlXcW1iUkM0SVpTTlFYUEFocmVocTVV?=
 =?utf-8?B?S1pUMFJ0djFOR3dXMURBeFpWQ3NQc043WXFyUjR1WjByVTR4WCt6eDMrWVZC?=
 =?utf-8?B?dzBmQVhKeXd3TUM5aDJpL0FJMFZ3L0pjQTJGajk4UEhCanIxcmdFSlREa0w1?=
 =?utf-8?B?UjZNL0dxcCthMGQvcnMxVEIzRURzeUt2MUREYWFpMjh0RWlJdElCS2orK1F6?=
 =?utf-8?B?T1VHbkdTTHQ3QWRSRDltaEcraUlnV1RBSDVZMzJydll4ZzhDbTVVRzVzT1FJ?=
 =?utf-8?B?T25PNXlRaUpaS2d2aDVGc05iZU52bDBOSHFSQ3FIUjVyWjhYR3Z4b00zcjNP?=
 =?utf-8?B?MkFJLy9qRUpxVGJPUTZZaDA1VlNqMU5pb1VPd3AzYXQxdExhOGo0K0pxMWoz?=
 =?utf-8?B?YWt1UG5LWXFQeCsvTDVCZWNVZFM2Q1lrWEJyYUJpV0JQUC9kdmlnejVYTnI4?=
 =?utf-8?B?SUhlTkd3SG5UQzdTYVhGc0c1L3Q3TjNwRkpITklzMFBtQlpSU0NaaXRWc0Ry?=
 =?utf-8?B?a0lkRGg0bzBaaEsxOVZrUjBqbDZiTDVienF0Z080NjZiR0E3aWxsNTRRRi80?=
 =?utf-8?B?WVJiaHc0WXJNdGVWQXROUmw0cTNQYzhuZjZoV21XaFBCQzV0OVlIaGJWR0NX?=
 =?utf-8?B?RmF3NzY3dnZRNDB3ZGhlOWRTTFBNdkh2RmhIRWpqVmF4ZzNYNW8xU3Vianpi?=
 =?utf-8?B?WXQ0UDBGY0NKaTVpN1Z2a1hGL0N3YzRIYS8rRjc5cXlKR0l3ZllWN3F0S3cz?=
 =?utf-8?B?bjZMQjE4SjR5MDBCMVJqT3VDdDdXQ1Jjd2xRY3d1aWxFbEg1WjhObkJoR0Rr?=
 =?utf-8?B?VVFyMVg1Z0ZlOUhmSFpXZVpPakZrOVhXQlZjNnUyc1RCdVVjbHFOSXZCVXlm?=
 =?utf-8?B?eWFVT0IvSyt0U0pNVVk0dEZPeE81ZFFFVnpGSFVXeVprdFcrbUgySVZQOFNW?=
 =?utf-8?B?cUl0R1ArYVA3dDhvcDJyWUF6MXhDMkpQRzFOeXE1RVg1MTRJTVpXU0lUMFNm?=
 =?utf-8?B?RzFmc3laN2JPb2lOMmFXbXlNNjhGb3U1ekEveGRtOEFKcHRrdDgxazVOeTZU?=
 =?utf-8?B?RXp0T3NXajJ5MklhS2p1QkJXUnBHY2ExM1B5bGRtdmdGVWhkeDFCalJ4bWZB?=
 =?utf-8?B?Tlh3SlFIUGJFTktScC9KMWt4RVpXWG9rQU9ZR1JKdWRpSWgvcGd5N2MvVGVG?=
 =?utf-8?B?UnBtWEZxdS9HVHNWVmNlQXFHVVNaMDhCb056OWs5bWJFQVdHMFE0ZDZCWlQy?=
 =?utf-8?B?WXYrVktzTzMreHd6UXNRVEFiWEVEZTZHSlFGWUJpSjFuSnA4SlpQZ2NobjBY?=
 =?utf-8?B?cXZOQmpVQ0JJY1NEaGdEU2tWQ0J3NDlTZU1mRVVOZW1hM3FsU3IwK3lXTzQy?=
 =?utf-8?B?RGx2WENERm9sbVlNQ0p3OWFxN0hGNlhIRTI3WTJFbVBOdXdickRWbktJVnc1?=
 =?utf-8?B?WEgvaDE1THBWVHdPNVo5UFN0dHZvZTR5eGQ3TUdPZHVzSVNSWmZ5Wmh4VkQ0?=
 =?utf-8?B?Yi9Pdi93a3ZFUmxIRVNJTEcrNlVGMUcrT1hGOGdaUkg0Rm9ld1FZbHd5dVk2?=
 =?utf-8?B?TjgyLzZXR2xCRzhKUGdlOHhWV0hxaTF6SzR2bGg4U3BKMkEvNEhHR1dUQjJp?=
 =?utf-8?B?M3NZdUU4VmhPSG1FL2RXcHZ3RnMzbWZXMVdCbVhuNmZpQVE4WXFpMnRHbmhJ?=
 =?utf-8?B?SzRUdURKQy9ienY2M0svS09DUzVwR1BhVU5LNERmT3l5YVZnMzdKb0VwQksw?=
 =?utf-8?B?dHlveWZLRXl2SGdUZVQ0YnpVMC83Umhya2hVMjRlOWxnaWZ6b3NSL1RoeG5m?=
 =?utf-8?B?aHhObWFLdFExaGhFV01RTVkvbGE4Y3FGNkczT2dPR1IzSENsSXdqSHBIZnp2?=
 =?utf-8?B?RzdQYWhQZ05PTDFJUkJhTTdndWRCUndvYkx5eDhYTzZ6NWFGeTF4VEJJMEJZ?=
 =?utf-8?B?NUVnemdZeWRVbnlMT2ZyOG8zTWhKQ2pYMzRMZ2UwWnphRDNLbnBKUGVuTUNu?=
 =?utf-8?B?ZEFSZGVVZ3Q2SE5vNkk1bDMxZkhnS2lVVkhSRU5EVkFlTkZuWGNFNmJrUkRM?=
 =?utf-8?B?NlY0U0RJdjNIVWQrYWdCSTliTGxmM2wxQTQrN3lRVHl3SWpITDdMdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70eff984-da1d-448c-91d2-08dede31c207
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 03:17:22.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bNLPBCneXAGiB8dvqc+zkLg+mo3YzAUHTruksel3M5B2/l68e/gBpRfv82oY+/ZO9MaYRz7kx32tcNrQmHn6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7679


On 7/9/2026 7:04 PM, Greg KH wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu, Jul 09, 2026 at 05:35:40PM +0800, Jiucheng Xu via B4 Relay wrote:
>> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>
>> commit edf7e9040fc52c922db947f9c6c36f07377c52ea upstream.
>>
>> As JY reported in bugzilla [1],
> 
> What kernel(s) is this for?

I'm really sorry, Greg.

This is my first time submitting code to the stable git tree, and I'm 
not quite familiar with the process and rules yet. Please forgive me.

I hope this patch can be applied to the v5.15.y branch. I referred to 
other patches and added a "[Mark: backport to v5.15.y]" in the commit 
message. I'm not sure if this is correct.

Thanks,
Jiucheng

