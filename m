Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444078F59;
	Sun, 21 Jun 2026 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782027582; cv=fail; b=IfapwWntgx30q5Hweb+X19ynZbnawOsSW1JIvceh3I5LbwpUTHyAUzSLI9Wdzo0y3LpAb9Qo5aerneW7Ocdc6Vl9uOLDWHTGbf4vuovWSlp0YmGbWqAhBEzIRBItes9Y/KQNfmAtW/AR7cLnPi+R1Fwsjcb570jBmsand6qYV/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782027582; c=relaxed/simple;
	bh=bOnde65kga/gYob8FU3dKxk9KcVd3yHzG+bC84bCs30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jofsiN25aR7mBPYuX2RJXmmQxl6HKuiLD3ZxM+FVLFRtCRaz8FJRebGZtuHMPO1aHai0jzUi9XuTgz2vyu3nThy8yBFTIsN8M5pxs9bVhrzzv5ayAy3sdEavCKUf2GiaX65LGqTK0CBFMQXDP1UYHV8LKpgbHA7wt+la4AkTHj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fg62XwXN; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fg62XwXN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHCnLhaJRZT0l7dIH+UDwxPwD46KHfjhNbmR/+MDTSHhz05Z8U/ua3B16QlZDIpRyXvF9ZxP5LD0w7WZoFSEGA6yaVHygT/lR/TbYpMxu6242uaJ/8U3CHT0VTlmqtDItpdlJJXJ6FS3CT79PYFZGukDtG9YGeC3UO5bp+Y4WCpXV+U4jb5ifwAhT5YUtRfamx1DNSEn3kOAHNgH921IpdcglHaX1pCM0h5vSKguAVRp0u7y4Nqtl0q8Df2egxBMkjDfmekJNA6oRAEtZ5dJtlLVopwWDpkfDRyRlLFPefzhpX92QXUS+o64AxvOcUskra79BFZU2865pyRNaFx9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp0LchYyspW81wbnfdTTTlK3u1bSbQEzszC0MJ96Oaw=;
 b=UjinRX6STi9l3W1/TsWa8jv35VGWztJzrcHVK1Qpz5Qgkj315KvlCsm89NBFHfGSvVztmUfYy4LRDSbs8Esc5SLrhQ25cY07FbcGM1nJLByDxVJGyfPI5uMnbaCrLoJlk1rynB5zTdi9Qq8NKlNW5utD9hHpD3cLC50mHlMxgCy7gglvs/0Hgt4TCd/I2EJzLRwcygXmbDBAn8yc6LZ2MDl3kH1My8m4objV2Da9A+X0Bb1NJHhopj2jwa02mIEZjGyTnhs4fSuPfLohI0O1NkzEDuLjRS6BXkRtKy1knGHuiEdUtmRt7Or7MABhm8yCpEKkcxmspxUaVqwZDQTGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp0LchYyspW81wbnfdTTTlK3u1bSbQEzszC0MJ96Oaw=;
 b=fg62XwXNxhWTGElfxJSEfLgrvLB/fQ8njTTtzS+Y70BqEDXBgmPx+dMx7fKIYUl5xSmYYJa3Z+elovAPSS+CQv4WqLjbAD9ChTEWXKlGRjX0cGSUaQlUuY/2ASZHY1s6+82fLs9zuuLwswl+VfxQDnNL7cU6evB6/bN8Xsp4JAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Sun, 21 Jun 2026 07:39:38 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 07:39:37 +0000
Message-ID: <e4f60b98-9bd8-491a-9703-a5a7a58a4ca0@amd.com>
Date: Sun, 21 Jun 2026 00:39:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [resend] [regression] amdgpu carrizo: no display signal after
 modeset
Content-Language: en-US
To: Salvatore Bonaccorso <carnil@debian.org>, Jaak Ristioja
 <jaak@ristioja.ee>, Dianne Skoll <dianne@skoll.ca>,
 Chris Park <chris.park@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: 1139950@bugs.debian.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <9fba2020-24d1-4235-9869-319d4aab3a4c@ristioja.ee>
 <178198613176.3658222.16247101620976737948@eldamar.lan>
 <ajcLuO0YZCoPN7Xw@eldamar.lan>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ajcLuO0YZCoPN7Xw@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:510:23c::27) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d276e9-8320-48e3-fd4b-08decf683f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|921020|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BoL1hyrDIiVdXpvH8O3+d9wFidZhMncCBu6xzNCYdzbUQZylunXv9w4dwT0LuFOMF+3IU9D/enwB5JAPvzseLmXLXJ6WgJCSC3NGfmQgJR5oZEQv/ZIx7blLVSfU3RVLoJDqZh3YwX4MGAnueI0j6xfFdB6VYg4uJOv6mPHzxqKRN0tIWLpRVphSVRCDmD2eBJ0Yd5UipPduaZFdWeHvk5Z/gTYLL4/lYY8eb2JcFzerCsYrrTxh3KwcD+u0INfUjkxcdmncqFUTQR/uXl7eR0FcScpY9wOaMMmhq/R3WVtLdi3NyBjSE0FQ44jcIyVpFeQ5iQxiff/rYimqtvOlpymTvdgL2fOH6GHiRy4IqEumWxamMzEocIxMBMMn4e4GB+pJuEQfcTxOVCBHWSMVoRcZUOz3XQG24mRRYo8LXz5cVizD5X4AUVmPFeGXk/PiL7eJd/KPXb3S1yTSVCGjpLk2R6r4W7NlfdBK1p3VTehe8dPXX5z8QnWAXitZk+Ucnn33fC8SyIsqVmpkfxIPEKZZusAfMEnlXtUO5Qy5zEGaMSgDha1hXwZasqaL0heKzglDX4kLhIYtU9C5qJQQExXvsLIjRzQCI9+eYevQfv5ljsPkLg/BzyVVqPybADJY9o4lxQ+h2I7ad5KbvzJAgh6Qa4EtSm6H4gI5MqIx6Q1gbUPltxXDJyJFpWwiSnrgzaEvfMW0oPlChJz1QIbxyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(921020)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVBqOCtNVUkxM3dFZDBaWnIvaTJYSzVKeStUQmhWaElNZVZDOXlGU3Viakxz?=
 =?utf-8?B?Lyt2K09xRU4xaXBSclVuRnFOb2lYTjBPNE9QS3ZwNVNlRDMzZG94eFNNUWdO?=
 =?utf-8?B?TlVkVTlRSjNGR2lOQTNoL1dJKzFybVJjeHphYndWRllhaWozbkJDSjNpQWVh?=
 =?utf-8?B?ejVkT29SS0UvN0NWdkxHWDRudytJUC9TeGlvZm9aTmhabzdRZ2tzVExxVDB1?=
 =?utf-8?B?U1MrNFJicW5xOExhY08yeVFQZDFxSlFRYWY5cENnQkM1d2R0RkpiSWd2MTdr?=
 =?utf-8?B?ZEUrN2dhVURPUi9KTFBvV25rTXNSRHVGemNwdkdlRS83NXFBamtCbE5BZncv?=
 =?utf-8?B?eHA0QndxWGJiVHRlU3c3TkdTMG9BZFA1NXBlTzdndmxHbEFHUnBleWZVMGpN?=
 =?utf-8?B?emJUNlRWZXlKZTdGc0IwTXhvOExoTDZ0ZXhHQlJyZDZJZkJ3WU9JMXRjS3Fx?=
 =?utf-8?B?WHhSOXU1bzMrVkZLZm9qa2ttdjYvVlZQa01DdnNpVWl1elliVElEaGpMbWRK?=
 =?utf-8?B?dWVjRTJjT2RlNWZkU2dsZlZwWWp3MkhKVys1UFFGZ2FWOVd4eUhyeWdkditm?=
 =?utf-8?B?M1duM1FJUm51ZStRNEs5bngyb21aSlg1QXNIWFdTclFLT2FtNlFFUDBOU0Fs?=
 =?utf-8?B?MEFMYW9yVU1xT0lDWFdzYnpZeWlRbnRkdldHOExoVHh6Rm00MVJkK0hRQjJl?=
 =?utf-8?B?WlVySG8rdDFLR0FmaFp3eTRTYnpvN2dHbXhWZGN1amYrSUkxWldTYldTN1k5?=
 =?utf-8?B?SFdPVmI2V0VDc0dpdVlVQUg5YmVNVEpmMDFPOTRpdW80NkUyd0MyZThOeTlq?=
 =?utf-8?B?dDAvZTNUNUJZa1g4WEJqdXM1TW9JVzQ0MXM3Y09WL2NRV2RFZXFyQW1wVm5H?=
 =?utf-8?B?R3FibEpscE5KSjdnNk1nWDhXN1ZNYnBwbGNURFMzOHpacmljQzJJRXlwRXY2?=
 =?utf-8?B?NE9KR1k1aWN5TmFpaTF1R3dNdnhtd2V0MnR0RkpLcmlIdk1JbW5wK2RCdHh5?=
 =?utf-8?B?ZHV1VkxVNmdIcFhGTUpDL2RrbU9KWm1YTDhqbHJlTzZLVnA3SXZEblRRY0JJ?=
 =?utf-8?B?eStUY0trbzNsT1A0R3pjdzdPOUpnUFRzZ3pGRVhCVkNyNHMwZVpuR012d3Y4?=
 =?utf-8?B?Smg4VFp1d0JxZDlFSkVzS1hRUnFvMmN0SGlkSjA4eUs5SEhLbFZCRDJteXVp?=
 =?utf-8?B?TUVHL2FpZ1NtMFEybXBuWEVtN2wrR1YyczBZMFN3cEx4M0I5TVJLTmhFOUNj?=
 =?utf-8?B?TlRQTi9kMldFRlZ6MzllUDh5MXUwWXdGZFcxRmNsdnRRaW52R0VnQzczSE1j?=
 =?utf-8?B?ZythY3d2RVhiOXNMYUp4SGdkTUYycEo3cVd5dXQ2Y2wzdVNvV2RzclRSTW9W?=
 =?utf-8?B?U01NcndJMWVteVBjVFFJdkorNStnNFo2bWI4VU9kNVBkU25yUWFpczFJYWNm?=
 =?utf-8?B?ODN4andjUlRiYWRvR3ZOMFdGZUNSSXJJYTlvNXhuWHBHMExHc0M4TlpBakN4?=
 =?utf-8?B?OGozUkZHb1ovYnpmYWhPR2E3NWxsOGRwWXZINFVOUUg1Y3o2aWVrRHpTWlMv?=
 =?utf-8?B?bVZhWEVJdmtkdGU5MEp5TjNzWERnRzhsZTN6TXAxTVpYVWt6RmQxVnZWanBY?=
 =?utf-8?B?bCtIajBkKzN1dG1Yc0VqaVJzcm9HbkRjZVMyRWZmVkVPbmR5NHVGck9Eb2lj?=
 =?utf-8?B?UHl2SXZ6NUxWVDF0M1RIOHh3Qkw0TXhsUFE2dXlxaXNXY1czNUMvYkYzNWIz?=
 =?utf-8?B?ZDI2TG52cUhEZEZSSDFZZlBRcUJXbFBMWWFNZXVlN0ZNcGtKS09yaVpOVlBO?=
 =?utf-8?B?Zms3MVdHRXBEQkl2SHdWTTk5S0RiZmQ3QXJTOU1KdFlNU2JzVGxObmJnaFZH?=
 =?utf-8?B?OHEwYmN0TU10bVMzNU45UllBTmtycloyS09ETlNIMkNQMWN1b2V5eDFObGQr?=
 =?utf-8?B?am45TWMwU1Zrb3pzUDhJK3U1UGF0ZVMyano3YnpLWG1NWGx6S292UkhoL2Vk?=
 =?utf-8?B?alEybUVoWTRDTm14RnhBWkFMeFlUOVRjVTc0bVNwaW5pWDFXU201MGFsbzRJ?=
 =?utf-8?B?K2VvUnFJUjFieU5RL0tPSDZXVm80alE3UXlpYUxBMlNsUDduRDh5UEI4RHd1?=
 =?utf-8?B?b3dLSTBLUy81cnBVTFRwZFdRYlplUVZLdXg4TDRVTno4SlRVcUxFWkV0cDZL?=
 =?utf-8?B?Z2J3RWNTYkRVYXU2eGN3SEdFcmxOU0hjWEpwdnpMYTgyeVJnSnFIS1pYNnBD?=
 =?utf-8?B?aGFid25ScHVDMStYYjhIUmVxckVDWXNOamVnaURNUDlqWjE2Vnk3Vks5VWx3?=
 =?utf-8?B?cy9RSlI2OEwrUmgrOHljWlRuSnJtN0M5YVEvNVN0aFY0RHFCakttdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d276e9-8320-48e3-fd4b-08decf683f22
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 07:39:37.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlp9SxJnpLkkX3r2Hm/Osavd4FYLcac3bNB+Fmke49IstOkCb6nHB7QMsJt8WptnIXxf1emqmXYlBssxIZpwzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

There have been other bandwith related changes.
Would you mind please trying to reproduce on more recent mainline 
release, IE 7.1.y?

Also; can you please check both your cable and dongle?  I wonder if one 
of them is not compatible with HDMI 1.3?  Are they marketed as 
"Standard" or "High Speed"?


