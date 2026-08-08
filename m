Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31B233923;
	Sat,  8 Aug 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187611; cv=fail; b=i9yVaSyP/zI6hTdb6WFBSMzLkQ0hkAxbUeTL8usjqAeUEXS4Yzr0nUC1wsBpeK7g+OWVqN8UD1sBp1qnqbfY7+l1LM5BKrq+n/6mr/1TAd2//12EoUM1IeGUc5uheW1y8GQiJA0Ntr4gWKRUHvVoVsq68iwp6K8Sr1i7y85oNPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187611; c=relaxed/simple;
	bh=A4ipxQbPq4IHHcnmRn1/6wqvyc9TDj9gnQ3PD29yu3M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WsL9tf4fi9Rv57Q2/VfXrTz/bporqNzL2pr0NoNiqu32C4WiZFcOouLrX2Gf2aFZj0FTIyKcyLGq9P6xwvRiePKIqVJ1zoMSI9LX7N4A/HHYNMFaxiT7y6uXor6HbQuqk3meKRDl7N+gEtHOOjRo8T/hCLxSGQFHDdF4TmXRKkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t+LDgFLP; arc=fail smtp.client-ip=40.107.208.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t+LDgFLP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz43VB4WNgpvX8q6FydIjDGKCz70uxPFlTLqBbL9LS767C09TA82KUGuXiT8BPT03suNz23u854nO4qlXNoUqIQWaBPlS93r5+UZckVKllG3rJu5pNzfYD3K/VZmwPPtV2QKJmx1kXm7IIM6kFpWJPKZKmmAWjBC6upyMFFKy70YyoDNMFJz91rUkUYnMrvWfMAsba49YHWKLNK8lZNvi1GgTSuHuF82OgLxJpcJLtBFx/VgPn/OHD+yIL2bD3P+fgBeUnOhl9fnAz6pVNsaVtUnUW32JBETr2shyOEw2Bo2R1nn+Y56XlSW/AgckFMHFjs/O5tBzeCZ8278BLQiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ndURG8VdqtzM1YKluYMm/71++ZztV0Q/9FAMMO+e68=;
 b=CqHMfboJmTWOqyDKURTM57uAfk3grJlo/dTuX7xYE2o6JpssUyViZZAKXNWrCs/fhvM5t22op7qSkMFw+0PPzfwQbj+D9Z0BVuAqhd7PpVZ8JdKmoU6PMyjDjOtNv7CWR7xKnIH9dQVkh8V+WpIIVlBVxTPsfax9367XrcPMfdJ2D1YtR0X34bU0zm3nuqdHasjx/et2XANj3KhEPouh3jC+LOwfeoF4pLPHek1KG3+xPrqsIyzK520XWnDTQs/EvQQO1Ox6TKbPklNxEgJZegpcrwewyMXWPH+ZzCN0vvj8o5HsMSBpomFZIOKHq333m+vD3XaCTp99LpeOvnQkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ndURG8VdqtzM1YKluYMm/71++ZztV0Q/9FAMMO+e68=;
 b=t+LDgFLPOfpXr4hmddJu+VH/Yy8fFq6PCWvMDqakIuYkFinzPnFFjnxM1yAjxzh3WPDFsWNsYfJJo5A7Qlwj1p2mj+GBw2nUevpwEKtavk3PLCCeFeaLj7hz3SUUUvfOeD1e/0k5gRlcfTLGcn2jBi4AnmN4jPZ6yuaO7u2RJ+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Sat, 8 Aug
 2026 11:13:26 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 11:13:26 +0000
Message-ID: <46ccf549-339b-4085-a47f-430c307d624e@amd.com>
Date: Sat, 8 Aug 2026 16:43:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: gadget: Fix use-after-free in
 dwc3_gadget_free_endpoints due to race condition
To: Pei Xiao <xiaopei01@kylinos.cn>, Thinh.Nguyen@synopsys.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <331d1d5133496d2b4184e05f8848adb06930a138.1785893865.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <331d1d5133496d2b4184e05f8848adb06930a138.1785893865.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::6) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: b6eb7433-4c05-488f-4ac2-08def53e1133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Hojl+eO5EM34Ayku0SCE3VxR6fMFLq3LMaY5CF2BsNKDfdtRHvrGNlU0S5ABaDbtNN3cgdb7x5KiUIZ2/M/a0FBHs8jMQ+Eqh6wJr5W2LMEV6raEfpjE2HzyLWtAFtRU8mh49b0QcGM6GmDw4oM/CDXVAiQbxfxvTjpfnB2rxhiEJtzc4CcERkhfw+nRJDjKKLL8y/72QaBy9aiStAe8s23PgMzaTUfRj3auZP3uyTdBDTgAp7P0J8vBO3g2A0VyYBGZTUv0ldBMCXfc20k4CiV4t348j9VxgVLMknPdxNpIVJgcOI6qPQq0fH/a1F/7rAS0tuKYLNIhfi5mdF7/h5Yg9qDwXGhePSHFerxEIn4DPokDJuJ80t2PWshOLlgZB0YhgiAqKqcAJFi4xubVLCw6Wqol0XH9UiEa+8hQRpGH08BxAtsCWdbjFQnoEil+EKZ4nOD0xtXu6guvnVkxDNU2Q5mvyeQwqbnlTcPi+mFbbRRN5/8z/IE+1JtkuwYyizIOPcqNA2HtyOONfK4eJb8pEEs/DRCcrwbQKzQCkaMSrE5vY55ldWVT+0WVbFpUgj+DEHNryhso5QgXWzZ7LJrYvcE/u/QQvPEgY7ZoU5NT2JTzjp12Gj99fTYHZyGLUHVgp4gyVJ06VYtBxnlzqsdeQ6LcevOSdjIGC62bskM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXZoZFRLZkhSWXV1T0F3WlZEUUttd3B2V1NqWXVubjJRaktrMFg1QVl3S1JD?=
 =?utf-8?B?dXFidkZqUVo2MjNBQWNjYTVoWkUyb0ZLR0g1UU5wbS9KSGVIMnNhVHFyS1Nl?=
 =?utf-8?B?c1ZwUzgvMmZQY3lHTnVsR0VJbmI2dXRjU0o3TWtsY2FSTFRLc3IxLzE5RjRT?=
 =?utf-8?B?R0U5aGRndXBkY1ZVVGRHWXJ4aUtDNWV2WXNPeVdtWXA4NXhwK0tWa0Q0VnU0?=
 =?utf-8?B?NkZ0Y1YydUhDMlo3WVpwbXdPd3V5c2JycWJVNzhtNGZ4Z1VJanpDY3FkOVpi?=
 =?utf-8?B?MzF5THE2ZlROVmtnVGJzQ1dVR3dwaEliNzFDMlpzNDJDNGppcXg3ODljclZT?=
 =?utf-8?B?N01ocEhPSnBjM3E3SDdpYzEzSE5pVmt2TkhTM0taVmgvajJadXVUT0xULzJB?=
 =?utf-8?B?YmRNMmJiTmE2WEs5bjZHMUFRWGNDaFNiYUxNVjFPdW9lQjIvWHJZTHRxejd0?=
 =?utf-8?B?b1pIMnlCaGFwSE9sRWVNSG1adEdsOWxlYXJYZ3BORHUzbWtrd2hYRFhwWFcy?=
 =?utf-8?B?K2h3bUtVcTJ3Y2FPMVo0RGkwdjVEbWJNSU9EeTJTYUg0bEdKdGt1bHVMSEVj?=
 =?utf-8?B?bzIwTnBWZm5DWXZKYitpNk1pdDNIWDMybDlqcHdRRkVLZXpvR1p4dG83eFVH?=
 =?utf-8?B?MVRMY3M0VFdBdUZNYXJ4R25VL3JBZkpNTEdGTnc4cTRFRGgvTEo3ZmVJSHha?=
 =?utf-8?B?NnU5MmZrOVRmdTBEUUV1Z2s4Z3FkRWFxdEM1TDRxdGlqeXI1ZWFpWnJqRTRC?=
 =?utf-8?B?dXRpckcwN0RDYjhyTTRQMWRsZGZFSlVRdXBDU3JmT2hjcmQxcWsvczNYUzJz?=
 =?utf-8?B?ZVZFYWdDbWRUSiszOUFIWld3QnhpTlBxRFlCSlFJYWdjSWZYUGpZSmViMzg5?=
 =?utf-8?B?c3drMGpPVTlnVy9EZEJTeHdqYVBUK3RrLzNmaTN1MzFnYTJUTTYyYlJzQ2Rl?=
 =?utf-8?B?czJvNzJyQ2ROZkJFc1Zqd2pYM1ArTXFXNkcySjVzZjRzM1ZYcm9sbnpYVGgz?=
 =?utf-8?B?SGFIcFZsaWUvVUNIUThaSWhBMWNwRVgyb2xsL0J4VjZjNVdjUTFJT0JFR256?=
 =?utf-8?B?VVZJUG5GQ2x5M2EvTE43VGp2QnVBRW90bUlNM3VsTW9RMUtyY25qS09ZelFO?=
 =?utf-8?B?dmZwVXMzWFBTUEdYYlVBeU10dzRIK2VRcGloQjAvL0J4cmM1UVE4eCtlb0R2?=
 =?utf-8?B?dHJqWjRXNnNYQ1lrR05HZVpDK2xzZll5cXhRcS9HNjF1TWRmdXRMQzlFdTMv?=
 =?utf-8?B?Vk91RlV6R1AvMWIvUjhzRFNqTWtwS29qRit6ZWtEZm56UWZSd0JUekxNZ0g3?=
 =?utf-8?B?OEc0aE9IRVZCSWNTTWF6VCtxR1ZyOVlXQVIxTEdNQWwrSmFiajI1YlJBdFJK?=
 =?utf-8?B?cE8zTzhmZFhhVWpDR2J0WDVrbTVDa2dzYmRhSFV4Qlp4RUtOSVBlTUx2Rjg2?=
 =?utf-8?B?dFZaME5DUVBqZnRSUGV0dTVSYk1xeGd4Ymg5Z2hMc20wK0RYL1d2TGpka1lU?=
 =?utf-8?B?b0NYV3MybGovWWQ1UHpEWUZoRW1XQW81K0RmZDBIeXNIakFsNkpQQisvY21o?=
 =?utf-8?B?eWRLTDRjWVFNZ2pZbm9ZNWVqenFWKzFpM3JlZ1ZEQXk4aTY3cGNxenVmUGZX?=
 =?utf-8?B?bnoyaFRuRHIwVi9XeDdlRlpsQWtrZ0lKMFNkYWVjci9QdU80TWN5ZURXdHNF?=
 =?utf-8?B?MThLT0wvZXJ1TE93Y3ZlOVJXWFZwZ2ZsdG85MjV4ZG5PWTM0ejI0cmw2Q1Fo?=
 =?utf-8?B?RXcxWkJLVVVQejB6cFZBZVMwanRUVjUyRkh5dXFZS3FERk1CM1pYcGRPanZQ?=
 =?utf-8?B?MjZVanpUOWd6Vy9KWmlpQVFJeENxTjR0UW5FbnhiNjl3ZFJpOWpGMTBRUTdk?=
 =?utf-8?B?V3F1cXNDNzEzcDJONkJ4aVNlRjJkSFh0U05MR082dXYvbW1vWVNOc0ljOUhD?=
 =?utf-8?B?ZVpTRkc0TU5WTThhMWtOS2U3REVGL2dmQnBTQmdnVGxKZUgwSnJpRU5Td29I?=
 =?utf-8?B?cDhzQmppTTJ2UVFaREF1Q1gxM2lDQTZCUnQ0Vm9udVpJWHNrQ2xPS3NoZlda?=
 =?utf-8?B?ZWFlb2dRaVpTK3hjSWRJa1lNR3Nhb0hNOWd0NWRqU2Y2WHV0NHJaeTVHTi8w?=
 =?utf-8?B?cmZVd09lYWRITnNlVWQ5RmNlQjlxS0pQTjk0L0lxOXZXcXlzMnNieUxLeEJB?=
 =?utf-8?B?VGt6RVVDSlRjSVZyZ0gzbUVjN2Vhclc5MFkzeEtGc2RWNlJSZmxwSEVYTFZ0?=
 =?utf-8?B?QllKK2R5Q29uUWxkSGRSbW5yeGIyWUpCWDV4MWxxcEtXbmRDNExNazRYRXA5?=
 =?utf-8?B?RFVVdjN1NmZsci9tczY5eWtQK3BjQ2F1RktwUjdrL2REa3hmRzNiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6eb7433-4c05-488f-4ac2-08def53e1133
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 11:13:25.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToSF7oKY3MwpVuLRPs6Z/h5XhaRZHL3W7LZi6u4PxT8vYIOcLEQ6zZ68fW8rm2lq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626

On 8/5/2026 7:10 AM, Pei Xiao wrote:
> In dwc3_gadget_init_endpoint, &dep->nostream_work is bound with
> dwc3_nostream_work, and dwc3_gadget_endpoint_stream_event can queue
> this delayed work on system_percpu_wq when a DEPEVT_STREAM_NOSTREAM
> event is received.
> 
> If we remove the gadget, dwc3_gadget_free_endpoints makes cleanup and
> the memory allocated for dep with kzalloc() is released by kfree(dep),
> while the delayed work mentioned above may still be pending or
> running. The sequence of operations that may lead to a UAF bug is as
> follows:
> 
> CPU0                                      CPU1
> 
>                                            | dwc3_thread_interrupt
>                                            | dwc3_endpoint_interrupt
>                                            | dwc3_gadget_endpoint_stream_event
>                                            | queue_delayed_work(system_percpu_wq,
>                                            |                    &dep->nostream_work)
> dwc3_gadget_free_endpoints                |
> dwc3_free_trb_pool(dep)                   |
> list_del(&dep->endpoint.ep_list)          |
> dwc3_debugfs_remove_endpoint_dir(dep)     |
> kfree(dep)                                |
> // dep is freed                           |
>                                            | dwc3_nostream_work
>                                            | // use dep (use-after-free)
> 
> Fix it by canceling the delayed work before kfree(dep) in
> dwc3_gadget_free_endpoints.
> 
> Fixes: dcfe437492e2 ("usb: dwc3: gadget: Reinitiate stream for all host NoStream behavior")
> Assisted-by: Codex:deepseek-v4-flash
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!> ---
> changes in v2:
> add Acked-by add Cc stable
> ---
>   drivers/usb/dwc3/gadget.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index fa0f16ffafef..fa944856f956 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3508,6 +3508,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
>   		}
>   
>   		dwc3_debugfs_remove_endpoint_dir(dep);
> +		cancel_delayed_work_sync(&dep->nostream_work);
>   		kfree(dep);
>   	}
>   }

