Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857C4E535F;
	Mon, 21 Sep 2026 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011612; cv=fail; b=gr+mDk8y/EvNoTQyVgMtGDkRKg7g5AXvrYdKHo0jRXQvgYd8uWBkkSNq9ZrWgFsCtRdTdA+jFMrvJbopD+G0O89mrHcVDp8HH5mnqb6s5hVIzNcFOxFpesGzQs/Ul/wv8fyt8PwdantTTDmJig/Cs49vzIHXqVtrGg0L0aPn10A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011612; c=relaxed/simple;
	bh=Cj+uXsRcgYMuD8JHLU2+O6NOrsAX1IoqKyEgII+6s6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HIW2aVnQZR9Dwk7uDIrrB1Szyw5f61VbRoXgwZsZ/YQKWvNvdhLg2IyCIFmCuudMQ5CDtIZt0HWEKArmUCWSA5fbY5UvnTccXyLJINCGf+dyimLDZEDsw7vm3vY/Gc4vTojx18nnMSZJgyXe3CzzP4ccmcxdASRae7cABV+Muwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mqQe9DGa; arc=fail smtp.client-ip=52.101.57.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mqQe9DGa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3g0imWaMA5UFy6B+2mfKMF2WgOu7LtxFZGybyKBRA7KyhRjdKhRoTVGjXTJi/eo/WM6tmzcYYlgXyeeO8WPrQgQ3WA1Bb5Y+V6E5y7PEjsS6QMw76XNEw0XW/jRUZrGXU8y+p+M8wFjDTZnRHky4p+DmlWXuvyoMSlREGSCtizMApOh/xqAqoGbyn8xMdY2Nk4Kreu3jemwuPZgP33kVz6E4ARfE77PAFYyQM94sWM3Zfzr/QxBSzEx5sKIGL2W3me+MMoE+4hYYvHTIkySUFg8/ydxbeQ59j1IS+ETtJVcENgA3TvnpCfXIrYF+or11/R0JEFN6vU9ZPkJlP7+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2WUCMIka3Z/CZn7zyWPhUlCYM381zT/yxxUoaY5Iqk=;
 b=mI0e/vUVMyZIq56QnJNyCNqNfKap6QYNtvGGkBzGmfgCKvxVQUCT6ClEccoM5GwVymTLWfvShmSu0I7e6L3dcVRkNqt2WSIJJmudRLRrw4OhkPV6J4qsjHjAnmqwk8MxYm4Sxy0n3s+rMWQjASKLcuKETcx3VXMIoC7S6coNY1KBBmMdB7BXkLq487HBHR2SdIGV1l5MrTnXs2vRFXyZ8t3teyKFKOJQNBvT3r5LS35lKcNU7OGl+DtJFEGcl2M8UY1lMl06y5z1JWgGfmIsoYe26RB4G3eEZeq3elZ/U4gtWpG4wnmxkcXEm8gsI76fZ35Cyy65FkVq0/+g+RMcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2WUCMIka3Z/CZn7zyWPhUlCYM381zT/yxxUoaY5Iqk=;
 b=mqQe9DGanv+kfFVBoADQ/Uf/q1G5piSzMaUDm0LR8Bd0u7e5X8qkAwYRw0Mv8N08GzkXs0TvEUp/V4tPXRhZ9GWY5XObn3qZUUWNicF53IUSQcvAJr/BBvqz77DtGT+1nvyhXmgg9Ztq22DYgNQUUYVzfYRMx3NOiCJlfuDv+t4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:26:47 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 17:26:47 +0000
Message-ID: <809a9742-697e-4f16-8c49-b9952e7a6d7a@amd.com>
Date: Mon, 21 Sep 2026 12:26:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] platform/x86/amd: hfi: Fix a use-after-free when
 unloading the driver
Content-Language: en-US
To: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20260921170411.1149960-1-mario.limonciello@amd.com>
 <20260921170411.1149960-2-mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260921170411.1149960-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::23) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c8a21d-e0a0-4545-6a4c-08df180583ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XSPrpwFjpRLYwiD9haMHS8iphb3TKade2UlgDJQtPVnbbrHT5kr8MMIfMH+kxYFfUFyzPpjyInkUfTjnqP3rpFnXOnUBJOP0yvV7alAGC4xCXTcEFHp/ZMs5oUc/PHiQBwMOpMO3YX4cmNRG1qwL+qErRZ9qkA7W6mdSbE7nzr5cLxESvN1j0LXXnzzt1JN58K2PX/Agrm/W7CPjDy1jcEnScnXsF3SnZrapaax1LKNsGHbjKLoPzKWcQRPLrkrSjJRLVm1wc1cujrT4VJr1tHUVb5F35wWm0ABrR+BkRrwBKloTSQuRpDIG7i1V8uAo4iBogirIOiWQJOYXbpgFSEwqbhApxtiiFshzGDoz+DScBXqqXcYgVZYg1fGkxDHz1/rm/Q9Pf+YzPX6+eDljXq9J11tDm+3W1b5HiXNz5Vjgd2WXCy51w4dd/mF2WHeWK4gTVj9Pb4ZnpFNhan7+fgebQiRcoo2wNJU9k1xZVWHe2IzRi2xJcfO3F2o/qwERnR6zzaR1iFhrhZc4kiU8as5QVxZxRkTUM1VLXRjAy0kOvXrKja0X76syOwAzQ0l2tK0E9Vmk4RB9QryQVV/a8itcqxikH/foA9fj+sreIgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1VmZFJPVjhzTmdRK2hSb0RjOWNUYlRDdVZqQ2dwaTJVcVkzZFNJREppSVcx?=
 =?utf-8?B?RlQxeTMrU2Z6YnVSMFZXVWp6UEpldTBsbE9wMXpnZG5lRDlGRFVSTDdZREwz?=
 =?utf-8?B?ZG00RHNXdDc3eUdmTlVaYXI4NmI5NHVjNHpkREgvdDE1MksrL2JUTlFZdUdK?=
 =?utf-8?B?cjg5UDY2TzNvMXlhcnJuQ091ckllTWFoeDZGQ3dXaWUvY1RJOFZaNkpFOEg2?=
 =?utf-8?B?WG1UUzlXRXp0Qzhta1p1U0NkMGsxSTJ0Q0oxUnlLZ0xpQ1FNUTM0UkdXaWFL?=
 =?utf-8?B?QXNLZldGN2pEc0wwTG0vemd1NzRJODIwQ1dvL2xNQkxSVC9LOVRpT1I2bFNh?=
 =?utf-8?B?bDhmU2QwU0hUUm5odVQ1eTFabzR4WllxZ1Y2NlFxUTh6NHpkME1rUDJPQkFr?=
 =?utf-8?B?OVdJbG1vTVdSVHhlNGJjSkJRTmM1dUgwSjBuZDJ0LzV6T2VlZ211VzNNdEhB?=
 =?utf-8?B?ZUJubkFIcmpLZ2NkZkhXWnh4TXpFcGZYTzA4bFR6UWcraUdyOE1hWTdlQ0JQ?=
 =?utf-8?B?U0hlWFY1bzNZcEdHdmJNUWdhQlhUV3A2cVBzWktjcDhMdlhVQkdiMGh5UnJG?=
 =?utf-8?B?V1dCVStqZmlqWlBvcmN3TE1sWkdzMXZnazhHK3NSWDVOMUx1UGNuZTlWb0NO?=
 =?utf-8?B?ZVR0bGptUStGZDB4OGRNbjFkUWlIL3dROW9rQWdxY2hDODFwbWFuekZuSjdX?=
 =?utf-8?B?dUtFdDRISWN4M21OQU41djlKWFI0UGtoUFdwV3hyazhPVk9BanNTUmhBcnhW?=
 =?utf-8?B?clJkSkQwV3hYbjMzcHN0Y09ybUhIUER0dnVBVnh6VTN5cGxIanIva2o1ZVFm?=
 =?utf-8?B?SGZxeW9TTFlIOTRLL080V3NkSlJMZzMweWxNUlRGNXVUV2tNVWpVUGhqYmFL?=
 =?utf-8?B?WXpqdVlCWVlOQ2VZbTExYytYNzZPQTZjQ1JweG0rVHFQVW9WdmI3MllTaEF0?=
 =?utf-8?B?RVMvanMwbzU0cThaRUF0L1FoWmJlVUZvb0V4MUx2bTF5Tmg5RnArUEhwdndt?=
 =?utf-8?B?TUc3OXpFR2hRRlpjamxGUVBXaVNDcWtYREVKUFRPamR2ZnU5QzVCVkpmdVg2?=
 =?utf-8?B?N0QvemNhV2JpMUlxbDdIMytFaElWNmw4VXpKVmdzZFVadkYxdzk2LzNNcDR4?=
 =?utf-8?B?MGNtVnJ3MGk5M3IrQWw0WWRYWEhEUnA3V2N6MHlUMCs0Q3kvazBkbU0xZUc4?=
 =?utf-8?B?dEZJZG1ZNVpGTEVNajBUZnExMGp4T3ZVSzFMOVVYZ0J0RlZnQ3BTN3NCcVVD?=
 =?utf-8?B?Uk5pTitlbDdPeEt5dDRzUTRadjdnS1BTVUx0MmpvcDhuMGR2amtvVEtuL1ZS?=
 =?utf-8?B?ZjhTREVvZ3FzZTRTRU1UUmVDWklCRlNselo0S2VnYzdqYXVLWVM3UkFRQlAy?=
 =?utf-8?B?di9rL2c3N2hlV2FOMVI1aTF5RHBGTTVTT29ybHpkQWdhbEFpajZVMDZ3NExH?=
 =?utf-8?B?SzVJOExTb3BFaDNkL0oxMW5XelREOEhBUHlNMVZrYktGZFc1cVpXamphbnN3?=
 =?utf-8?B?cU9ZZEJKL0laV0RScHlSZXRiVWFFMy9FK25XM3l4OGNsYWcwN05scFN2eDRY?=
 =?utf-8?B?SHFJYnBTR3VDNFFPcTJmTHV2WG12TUhieVZHc2FCUGtOOHg4eEFLcjVMUUZv?=
 =?utf-8?B?N21qdlVRNk0zYU5oMXRydGF0U0pvSy9RYmk0QmNFb05Bb2ZLL29ab0RMZ3l4?=
 =?utf-8?B?NkVMTjRkc0JpdjFMWmdhdVJ3UVJncmM1cGx0cFErcGd0MUhCS1MwNjJUVWJR?=
 =?utf-8?B?ZlRZdjROTVcvZTc2ZkJTUGlkYk1TWnd1MTBPbm9KbXI0MXVPN0dQc1crZzZB?=
 =?utf-8?B?Wk4yNlM3bkhKd1A2Mk44MXFHaHdDUEpRdEtLYjAwdW55cFMvajNaQlkxZVR0?=
 =?utf-8?B?QTh0clRkVVRaY1hjZTJYZ1BUbVlON2hnVDBCM3crTzhwOEJVR1JobTF0NXBz?=
 =?utf-8?B?bFRmZi93NmJvMGU2VXRDT0dFZWdSVFVlQmI1N1AwaTh3ay9OTDhjV3BvUDR6?=
 =?utf-8?B?UEwxd0c1d1BBWW1nMXB4Mk5GYmwwSHQ5eFRtYlFKMFVQajJmNFpaUUVBTGxI?=
 =?utf-8?B?RGp2WHVYc3dkMDBwVytNSmF3L004ZDlEZXV2WFZvZUFxdGhJby9mV0lIaTdL?=
 =?utf-8?B?RU9NcHJtM1ZGZ0VkOVFMK3d1WXduWUNxNi9XNC9ZcnplS0NqWk55RGljRE03?=
 =?utf-8?B?dkdvQ2pHNlI5aWJmSENnQ0g3K3ZyN0pqYmZWa2JqeGIzcDRTZk41R0E3K3FZ?=
 =?utf-8?B?aThqS0ZJQnpqM1pQdGUwZEpFczFKT0lDU1FuTW9aSGlBTUQ4SlhHSEYwNHB6?=
 =?utf-8?B?TncrMkh1VnNkYi8yWXp3YnNwb1RYTlRDTDlEVGZhRUhHaXdLWUl4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c8a21d-e0a0-4545-6a4c-08df180583ba
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:26:47.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYPcxIZwdODwnUAG0CeI3TysQfpiAtqXOb72yF62tBdxHsYzSLW6v9B3Cz4R4oXpPdPw7TAHfCC5p2FGTI9lJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525



On 9/21/26 12:04, Mario Limonciello wrote:
> amd_hfi_probe() registers CPU hotplug callbacks with
> cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, ...) and schedules the static
> sched_amd_hfi_itmt_work work item, but amd_hfi_remove() tears down
> neither.  The dynamically assigned hotplug state returned by
> cpuhp_setup_state() is discarded, so cpuhp_remove_state() can never be
> called, and the pending work is never cancelled.
> 
> After the module is unloaded and its memory is freed, any subsequent CPU
> hotplug event or execution of the scheduled work dereferences the stale
> callback and work function pointers, resulting in a use-after-free and
> kernel panic.
> 
> Store the hotplug state returned by cpuhp_setup_state() and, on removal,
> call cpuhp_remove_state() to unregister the callbacks and
> cancel_work_sync() to flush the scheduled work before the module memory
> goes away.
> 
> Cc: stable@vger.kernel.org
> Fixes: bb20421c05fc ("platform/x86: hfi: Add online and offline callback support")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: 
https://sashiko.dev/#/bug/linux-e2a43433-2732-4af4-97f1-ec320a95f087> ---
>   drivers/platform/x86/amd/hfi/hfi.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index e0ebcb0c4acde..e1c776b71f3e6 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -76,6 +76,8 @@ struct amd_hfi_data {
>   	struct amd_shmem_info	*shmem;
>   
>   	struct dentry *dbgfs_dir;
> +
> +	int cpuhp_state;
>   };
>   
>   /**
> @@ -244,6 +246,8 @@ static void amd_hfi_remove(struct platform_device *pdev)
>   {
>   	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
>   
> +	cpuhp_remove_state(dev->cpuhp_state);
> +	cancel_work_sync(&sched_amd_hfi_itmt_work);
>   	debugfs_remove_recursive(dev->dbgfs_dir);
>   }
>   
> @@ -494,6 +498,7 @@ static int amd_hfi_probe(struct platform_device *pdev)
>   				amd_hfi_online, amd_hfi_offline);
>   	if (ret < 0)
>   		return ret;
> +	amd_hfi_data->cpuhp_state = ret;
>   
>   	schedule_work(&sched_amd_hfi_itmt_work);
>   

