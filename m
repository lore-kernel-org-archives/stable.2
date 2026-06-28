Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC49262D0B;
	Sun, 28 Jun 2026 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782673976; cv=fail; b=KehRJRp7WDtybHDrdaXDcwib5SGmP8QTXczsQFWa+VfrrIAITUzcoxKutDyPzH/69GBWeMI9LFf+U9E5LkiWPzTBpnMtSgPI96XJ2ps3Y71vkrqwQ0F/ONSDbAjUuG/dLHIt1nIsqpwwOWQDzSgO2Co/kmNwTW/K5POnGiuvnDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782673976; c=relaxed/simple;
	bh=h7OYk4OpQidbdmJuzNk+gjOfqKK8gtMkGhckd3wrA88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lkJ5aECMBaoyN2qXhaT/gSDYO/+aZWb8im6Q5PUgIb53woQ4kvlnzepZPMzuydjnrpQZozqcgsamY1yeSgH/WOoICDSGMAWcldGINmhfheWZz9pNmPD8DTkI3LP0tpu+PK9eq0yLew/kxs2+CcYurCsFGvfo+hDZdb9WrkyB+Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D6py7Khj; arc=fail smtp.client-ip=40.107.209.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D6py7Khj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkLoVlelmqAfPfavJKcv+QwLOUau6T/YZTWJxAtommw8dXz/cqNUlAkz3/HxoWajSCHExCiYkH9Zr1SC04Q+8K+0tjp8tUJtg/f0G2Fvts+i68VFEPEVZfYHAzhyMw1pYwD58oYFXg2FGAJHhhEGWYF6OwB5SH4jzbA7xy071ioF+iKiGSn1CDbPiMDAvdLDUykxcbL4gU7JoKgJIxAyVZUnpmMZ/2NkuLpl2BjBb8enCYUFM+Doe2Hl9NVbQDVtjNqi7KyCkaR37AsrnPH70W8BpcBiCf+i6Ksy1VXUwM/FxANKZ6wTUIaRzjkYmW7XXmGKdMWY5B2Q2yNebAgYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HmwFZW81mK8xvf411VCMNo7oO3kFExdFU1tq+i/AvI=;
 b=wA9BruIn/ZiM1x62cFguonwuEwmPsPS3FQiRslJaTE3SyqHLE3yz0YuMNHAwZKMRD2qmcMvrLdHgmzpnNP0hhkx+X5EJz0N2412CiQRrTCNE9oiiWJoFIqPr2eKpPtykKmX28IAvE3Q0PsSiz9kbk5rdCeZca0TkvevK3vsrFqmwoWBp4qzxS4Rrt6MlmW0RWoWTMO/byAfuod247tMQ+RPaBjE4cUKYemTwo8ghOCwhjOWrIaNWfyzcPLViPMOSGQucCZZezpDghTSMeCHKnq46oQy8qIQB/FKt+MTPtOaXJooEECby45k0fALqwfCrg0LulmYNVNHlvMEFbZx7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HmwFZW81mK8xvf411VCMNo7oO3kFExdFU1tq+i/AvI=;
 b=D6py7KhjIl3KxAuqgJl5PHFo/aosiLhgTlUtb99OeHVzpq9PfF/CuyrgI2wbQxXEsgT9MpcNIQC51m9cfcTdQywKZjhGPB3jadtnPI+fh+TtPY4xgqZDgjFTM3L9v380abjUUEs3w8kSH6CWtt9K0F+Gw53JJ5Z8wQscmtTUr9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Sun, 28 Jun 2026 19:12:52 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 19:12:52 +0000
Message-ID: <396b26b4-50ea-4635-9f18-4401778d20a8@amd.com>
Date: Sun, 28 Jun 2026 14:12:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: set new_stream to NULL after release
To: WenTao Liang <vulab@iscas.ac.cn>, Greg KH <gregkh@linuxfoundation.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260628072740.8884-1-vulab@iscas.ac.cn>
 <2026062816-contour-womankind-1646@gregkh>
 <E91B74F1-B7B5-4EF6-A697-634178A2F3A7@iscas.ac.cn>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <E91B74F1-B7B5-4EF6-A697-634178A2F3A7@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:408:ed::24) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 456d45af-321d-42b4-868b-08ded5494015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|11063799006|56012099006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gvs8BDlspeT8sirdiV5my2FYEf2PyCTqD8upR0t5LJgBbRTaYSjEUHeO8sgVufTx6Y1UcH4ZtuBIxSVvQQtSHXc5CYSXaasZEPnHjxgaWXZPEuX1X31WRBqLsEpDuqz50YRGyY+c+5BKiZg25sG6AjoWm4r0wb4DMblIoxbRg82zudoi4/VtNGQ2zY+adbP9JcWEgibvccJf9t2xEREQwD2f6F/36Sg6ioiI12iKvI5tVk0WqkQ6vqJcgJ5bcXKe6GgGqrffDdNPFAu1BgWxrovytdBBzOYALibW1IvrbPr/iaai2Rm/fiXtIMy+Q7KMep21M5luiFYwgYElAk9Vls3sPuv/fY/wUC6DBF2Aq3Uj0uepHTj43SYCRMg9jfu2IhpOlchlKcpYQns06hsMGdIMiRaG3GnLQw0WSEn9zCkluLreJW6dpgutsHj9kH8l1NaC540e5QHAHLndJyNvbqM5lB7Anx3xA8GclZQHLB64gdvJEwMYJx33/Mo+dxc4p5miqTGOwVGY8ODES2HWrJPy6msdTg27zafk1h+A9QJwxnBR6vDkfy8fgsPuaKSb4x9qDaKMZbB4ll/WusvTREbyEolE31zD0TLcKwIPC2OQrIbVtC52Pf2LDleTyo0Fz7VfHSxKo3KvP0/X2c1F9q7ynewP3VkWTJ8DS4fL1Ww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(11063799006)(56012099006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkNSQnZKQXpDcVZTVTR1ZUNBQmZFTWZwcEMydU9zdU1DSkllek1TVlJQQ1hZ?=
 =?utf-8?B?YkxCaW5iem9WMTBkcnhySHlwUk1jUHVUMllrclU1M09sQm53eUZuUXh3OERq?=
 =?utf-8?B?dlp3cHUramEzNUZZVWZ6a1BNNWhpWUwwVGpFMFE1UStyaUZkWHVLSEtmRlh5?=
 =?utf-8?B?THZKQVFMYWlBWWdXNkRjWXF3U3VIb3hwRG93RTlrSWFQRGR4a2R2c2R4cDhR?=
 =?utf-8?B?TFdRQk1QaCtSY2xxT1d6MS9qNk9XT1hzZG8wVzA0Qk5hQzNFK3NjZ1I4WkZH?=
 =?utf-8?B?QlI4enExbkpzazA4UEN5Rkt5UUVxT1Z6TVhQS0pTWDZ2OVhkamRBczZHSHM4?=
 =?utf-8?B?SUxpTXJraVcxL2tmNUJvdk9mamVDWjZFSGhoZWdZN0xnNDBTRWVzQlFjYWxn?=
 =?utf-8?B?K0NWN0VWYUh6Z2ZkazlBdk5KUnliMG9IL3VQbzMwRnE4dDZPbEFoTThNaFJh?=
 =?utf-8?B?K3VnQUVaMnl5UTc0Z21aREdIaWNBUDZhUkhZT2hSWDRKNnRpMU1KNlc2YlZ6?=
 =?utf-8?B?YmhVaEc2YmFMSG82dGg1ODBQWTJ0ZHB3b3Q1VG5EWXNxekxQTlRDckR0dVA2?=
 =?utf-8?B?WXBST0ZkYUtrbm8vMGRDZWNKdHRqa0V5eG11RXVOTG1CaDRWS3VyYWJoU0oz?=
 =?utf-8?B?RWE4WUxxdUJ5OVgrbTF3alJ2d2Vpdlo1SVcvWWM5alpLTk9LcGVla2tDMXNl?=
 =?utf-8?B?ekduVERWQjZMcDdQano3SlV0NGRRWFBSQTkxZGFLdkhGOElhVThLNEFuWTlx?=
 =?utf-8?B?dTBrc09mdU1mUDJzQzJQL1U3bjl0ZkJTVHVpSmZUQUt0T0lTajU2cjFEdVNP?=
 =?utf-8?B?Y2djSDZ2S1JEMTNlOUJRSWpsRVE5eENWbEhxaVo0VVZLb2hveHp2enN3cjV1?=
 =?utf-8?B?ZG40RjBaMXd6dDhKU1hHT0RWYUIzeEs1Z1VyVTJJTG5IelVsQmUvQlRkSXUy?=
 =?utf-8?B?akFMaTVQbGI5RVBERzByU2twY2hqZ0hsV2Y4c05nVUdQaXdzYkI1cFFUWWhP?=
 =?utf-8?B?Rk5PcW9FNTl3VGxqdklTZ25QY21WR3p3WXVyMzFCRG5lV1NoU2Z0dDhNRmFq?=
 =?utf-8?B?a2dPbGZNZm9GSER0OEx0MStkUzF2dnBGcWU0enZlRVVYVm5sS3RwWFFkVW5X?=
 =?utf-8?B?aTcvQnladXdwSHE4QytHd2tDcXBVQVJQbXp5K0FWRmlXQnllK2RrRDRVRnZB?=
 =?utf-8?B?MHNzT0JKYWFJdzRvY0RNRUtueU11Q3RYdnh4TlhaakcxTnlxMVQyRGVWZjNj?=
 =?utf-8?B?RUFoTnozY0FmdjhiY2VIZDJUMUtmRm44dWM1MGFybFZCYVdHTndYK3NwUzI0?=
 =?utf-8?B?cUxsaEhoM01PcEN0WnlvUmZwSWVZU2M4dm9hcU04QzlWUUhQUEUxN2F0YVZ1?=
 =?utf-8?B?ZHloWmRDaW8xa1JWSHNoVkJscmkyUnNqSEFGbFo4VXZGUnRFclIranNlb0k5?=
 =?utf-8?B?UUkzZEVYN2EzM3JLQmZZSUVJRXVwYi9nZDhJMmk4d3F2WmRodXRLL2puR3dl?=
 =?utf-8?B?L0kxcjlhVlcrV0hlQ3kvOGJZSk0ydktqZnJkaU5BWFhaOHljTHdaZmFXRDkr?=
 =?utf-8?B?Q09NV1pvV05aVUpsZHpLMFZ4Nk1xYjRkb0lhejV1ekdFbkRpZzZybWg2R2Vt?=
 =?utf-8?B?ZnFnUFhVTDNGTlZieXExWWQyT3VoOTRCYVFHaldSQ2NRekFNNlpwMCtwcWRR?=
 =?utf-8?B?WVQwN3NFRUNGQmVxeUNKdDNyK091aXhTbXQ5TXRMQU8zbHJxeWs4ZnVhRXNo?=
 =?utf-8?B?VDFiT0lOZFB6NUw5MnJXS1FSbFVXdjUzek9GYjluTzlvUzFkVUhKWWxrZy8x?=
 =?utf-8?B?eVR4NnVsOFBmVTErK0dQaUcxQkthY2FXdVRheUlqQXc0M0lqK29SWWxCOGRH?=
 =?utf-8?B?aEZualFjOVdRM29vTDZVa1YvaDB5RDUvdFFjandUQkxpelhjenN2NUNHZFQ2?=
 =?utf-8?B?cVQ0TEJKNjRNU3VSQlpVTDA5c0w2cnJoVitiUWprcERaUVBVUHNvTHV4cWpt?=
 =?utf-8?B?YTRTbHBnZUhjelpCeGZVeWJTU2NyclJGckQ5SGtjajlxRFBkcmxqRWIyK0Nm?=
 =?utf-8?B?R2ZjYlNLSWdFQW12Ym1rM2h0TStzMElHeE1mWS94SFBhRkJlbU93SzFsMVYy?=
 =?utf-8?B?VGJFeU5Cdi9iTTBuS2p3cjB1YTU0N0F1RU5VQmZrRWN0eGRCcjJuSitySHVh?=
 =?utf-8?B?MC9WTHN2K05ZeVlBU2ladXRwRGlZYlBvSkpBQ3hLdkM2VVdKSnlvZFlFc28y?=
 =?utf-8?B?TG5kdGNxdVFUZVcyNjYya0xtZWNLWFNSZnA1bm5LVENVaTBFUzhxOVJnS3Y1?=
 =?utf-8?Q?aNBL+7pLqMxejjMVtC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456d45af-321d-42b4-868b-08ded5494015
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 19:12:51.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E19geOWSjKOe8vC1AGAJ3VijOnkXCJsHLggFcu14wjzvucvhwpSFRA+QrbJ9/XQlyQLHEor6mWntM49fOz5eVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288



On 6/28/26 02:49, WenTao Liang wrote:
> 
> 
>> 2026年6月28日 15:33，Greg KH <gregkh@linuxfoundation.org> 写道：
>>
>> Did you forget to include an Assisted-by: tag?
> 
> You're right, the Fixes hash correction in v2 was suggested by the 
> reviewer in v1. I'll add a Suggested-by tag in v3. Thanks for pointing 
> this out!

I believe Greg is hypothesizing that this mistaken tag was caused by a 
tool/model and you didn't mention the tool that you used.

https://docs.kernel.org/process/coding-assistants.html#attribution
