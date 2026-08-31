Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9E35C696;
	Mon, 31 Aug 2026 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788153945; cv=fail; b=Kw/mj59by5Ta1dy2RavcCBw1rbcxUtC/ZMk3PqMAesVFMPTfE5HFa/PJZSULLYBG1uBjIWqJn3T0ryIkz9moQFLVXOhvDVK61sY+zdL2JRcm0oCF6k9INjn11L7Sk9ferQ15SHJiobGs+VFR0V/FOFSb4+C1UmTQSWMTcPnZT8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788153945; c=relaxed/simple;
	bh=Om9KHWUBxQYi1NSQ8KiB9qYxDrt3rzd6ABcBBs4isB0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gg67Unm721hHzd6YgxsGVTipiTm09P2d+4JzEeIeZQqAO9fBdhnrHdfM89CL/EXUeVG/MtS2B7vGKX7bRc2ccq9MVqWMekXJL3D+CYstz9idFAv76oxWVmmjEUHMKurWWttxgxEWEBmnwn1wXO4dXNc4nLft0qoJQdD2U9xbH+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4TaMcY3S; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4TaMcY3S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb/EOyur4ugssTE6SJfnkP9AatBCa8uVJ+LZXky0jLyiaF36BlrMeroXjFLgtEeeLYv/E6pKIipsfFyhw59dwk5ztNZyAoox3yibq48GWg5GibCX6QDte9qpCO4llFAbBm066W3lsgIyWTtup+PzeGaC0+T1PIl7s7s2XlilDx1Ps0G1I3MvT71eJWN5tv+JXuOO+6I5/UknQBwysJmL6TD6l3Jf2rIAe17oSV3GX9j/uc4WqsHP6PRJgFkvm4Rj7p1qwIDmlXGhDsYOH5+bFsd71XT3W9ChV8O60yQHfH4JtQD1Gx3Qg80raFi2oTfc5pIGo0CHUEM3qHvfx8KuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egDUWPK+Bwm6aZwag7w708n2pVe/RkYxTEscFUgxzm8=;
 b=PBS93kmEC22U82pXSlHB+MqJMMdAYZqNFbA9/vL67CW6czFa/KRXt33PF0t8hqJiynHgiZPSKVtiBLSH0XrdLnHXS6HATY2bF4zIJvFp3VSUzytzsNeA1V3I1K2ZttICCZvYw2uZyuoth5jxnyMKrvbFZ/M/qeferrTgumGwOELByRC1wGr8KVc3c3L5FvPuGnPBc6WjJirh//1FEkfW2Ea9IZTbj9sxbpq3tXPFgaWVk0MPcqAddJ8nmUny9DkVudZf2CMQdLwLb3S0GqaiDpJCwBCaPBt8uDD79UxkwT81qS7FbeUs7AOHUzhCaQNhXGnUR/TvmjemBvVayFloGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egDUWPK+Bwm6aZwag7w708n2pVe/RkYxTEscFUgxzm8=;
 b=4TaMcY3S8/+39e72kACaP0MFGPpC3UUGgrpFAFgFHCYl/JR0H7b0tU6yRmCiSgOL4yIQckJGm0vSkWQHSgWtjEJlLH9WmtCdRXDgefHLt3c/XZEzWsqI4gS2Cy3Qukdt52kgIlfzZBw+LA6WT4at3lcCxbAy/Zfijp7Wp6BIvCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:25:39 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 05:25:38 +0000
Message-ID: <0f49c8c0-237e-4638-a53c-1260f915e4de@amd.com>
Date: Mon, 31 Aug 2026 00:25:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Thunderbolt Host Reset Change Causes eGPU
 Disconnection from 6.8.7=>6.8.8
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 =?UTF-8?B?RnJhbnRpxaFlayBUaWNow70=?= <linux-development@tifran.cz>
Cc: Gia <giacomo.gio@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 westeri@kernel.org, linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, kernel@micha.zone,
 linux-usb@vger.kernel.org, Sanath.S@amd.com
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <CAHe5sWYnbJAjGp66Q4H0W_yk9uYTcERmW=sPvJSWTsqbFZFCVg@mail.gmail.com>
 <9659dd5d-af8d-4100-8fc1-ceca42223827@amd.com>
 <f8d6f64b-0783-46bc-82d9-cd56da07cac0@tifran.cz>
 <20260831045226.GA124825@black.igk.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260831045226.GA124825@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:806:126::32) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0f0a5f-9317-4132-2b65-08df07204a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|3023799007|56012099006|6133799003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gY27JyScSDrRmG+5qYCKP7TeIAbDwRy4SGEYZgzp6W1yhKRhico387DBg9m050CDnxbp5LJhjpbOtVMyWxoD9NhC+QKlX5nMSoZ8zmsUx9e9reQ3pcwuIqsHr6oqA6hO8CpNBhdXzqerzf4XVzxOZ0WHYaB24sp85uexE02oazHkSJhU5zz29m/D8Wv/FIC9vls7xd/gQE60KGI355UhDn3mPlST8eltAZD+s05x0kd1swCwwpcheha+wFtPEjsc+zFPmIg+fyXKwg5lk0lBdDdTc01VL1wduCIpfd1WyTD92a/86K73tUw0fLib46eQ2M6hOtxXxZlO3vhRDFGvhkFZnRgMufa80wKcsDuQce7k31HVhpKxpItOg25pZaB6aDBiNQNx8N8pQO3V1SZfu+z2Yd4aXjANp03xB+196NlOLIP0gPsO5UUvso2AOBOzXPMpX95Z0aepa3flMoRssw18d0dktKg1fkYL0T3HsBN8JkeKsfvRKcTAY5oxDErvUdxpUPyE+P+m5mZfTiF8xJw2TiDlCuFGzIHgvKtFwcIIlYK4VrnJIXsx8F64mD8iPL+D+oLdAnppP4/u+TbuzM3QdJE5pv4fgpo7IpjEUrlFGg9ZSwxNgGoaovICJBKA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Skx2ZGxqVHJEMzI3TXVmclErWG92UDdFS1RrSThLTEdTUERwYXc3d0F1L1dG?=
 =?utf-8?B?N1d0ZWJRTzhTOEg2U3VBZGJraVRJQ1RwK3lacnV4ZU1WTFRVMjN5UEZianhW?=
 =?utf-8?B?Z2o5aVF2RklPSFh2c0JvNUhpVzgzNzZKUlI3U3psVWlwY0RPSzBlOThCTTkw?=
 =?utf-8?B?Zk51NkxCeTgrMmhSaS9jV2dReit3UjZsT1FiQmJFb1NUNmFLZlZQcUZDV1hX?=
 =?utf-8?B?a3VqZjRlSm9HeFhTdXVUVkpHcSsxc0FIb0REdmdPb2ovc1lIdGxtbWJtREZY?=
 =?utf-8?B?cGVGTnNEczhkZmlyRkYxblI0YlJxTmdrWjZZTW13UlM3SFk5aDVVUFIrZ2xQ?=
 =?utf-8?B?YWswMWk3UG90Ti9ZRFIzaEFuY3NqZGsxWW1FQjdXaXU3dGJlRkozR1dqRGsz?=
 =?utf-8?B?YkxqRFRmTS8vd3p6QkUzbEFTQVhFRE9rd3l0WmRrL1BialBZS2EwV1NnVzN6?=
 =?utf-8?B?UW94d0ZXS1dPWEF5UjM3aExHRktJNHMxR0plcTM2TnI5a2lBOHpwWmFCWmhD?=
 =?utf-8?B?YTRNSjhrQllpYzdTSlYrSHA2ajFUZlg0c2xKM3pueHZpbSt0TzVRVlBZTVNz?=
 =?utf-8?B?bjhKOVg5cGhuT3NBS2xsV3BqdW9RaGRvSzFSUDVvOWgvM2doSFBHMVlTWkJ4?=
 =?utf-8?B?Z01QaGg1WlA2UEdGL2dic2Z1R0kvQTloWkROYWZPY1FTUU44amRIc0dqQytW?=
 =?utf-8?B?aktMNTJLdUpUQ3RWbThOK2k0MkFQd3dObDR4UWlrU1NYTldNY3pKQ1E3cGZW?=
 =?utf-8?B?cUxSU2s5aEIwL3pDRmJMWFEzNkMwVWZGNjh5VmhuWGNFQjBxS3d3ZlVsNi81?=
 =?utf-8?B?dmRwbGlpTGxQSHNPUEhCMXVJQW9FSUV1MjZWZXRDemNXVjV0ZzhFS0dqbHJL?=
 =?utf-8?B?ZUQ2bCttZnVCOTVsVjJsRmp6aDNhcEhhck42Q0xjdng5cklQUFNYL3d1UUlm?=
 =?utf-8?B?cUE4dFk2WXlid3hPN2NaTitobHBHcWJvaSszNUp6Wlh6TVYvYzZyVHViZlBK?=
 =?utf-8?B?OVV2SEdtUDgyeFhrUlNIbXM1aHRFZ3pwSHFXNncxZkwrRmRKN3ZmM1JrREla?=
 =?utf-8?B?cmRhenpUMEN6UmtKK0xsbndZMVBkejZvbmFSYlVQRExmT0RtVnZNRE1nOUFL?=
 =?utf-8?B?OHdkZ0Z3dkZJQ2E4SVJ5WHhuc2xBRUN1dVhUcUl4amFpbm1sMmMvbW04RXVW?=
 =?utf-8?B?MEFTazNoMldySXZEb284K3RiSWRTVmdQTndGM3hWVWZTd3Y4S2k2YTZnZTNJ?=
 =?utf-8?B?Ykk2WEk4ZGg1NEZFdTAzdGNIZVI0dVUrdzlBMFVneXR0U3R0dW9YMDlBZ2Nk?=
 =?utf-8?B?MkhSZ0VVR3JMWkNFRlRONFlqRDVwZmJMNlpFM0ZMWFJ6OGRzRk1tSUcrdHEr?=
 =?utf-8?B?YXc5R09icW1HMUNKL2NySDJOdzBNVmdaUWNYeGw1c2pQU1d6Mmd1VTBTQmpt?=
 =?utf-8?B?WE9oZk5RMjFXMVdiUjNwaVlSNUlDUzhYK2puc2FXUnhqbEJXb0xoSXQ1eHcv?=
 =?utf-8?B?LzUyM294RTdYazNhVmp1U0dhTmFhUGpTRjE4TXYzMDQxUXVySkFHSnNYMll0?=
 =?utf-8?B?Vkw5c3U2VVkrSFgxUTBENyttNkJWek1NTjFLTWpBYjcxcXZMUVpyaHZsUkRQ?=
 =?utf-8?B?cERFTzJ0RE5CN25oblVBVU1qbFdPckJiQlpsUU1Mb2J3NW00VGt3cnlsSFI3?=
 =?utf-8?B?d1RpVUdRSDhWdUNZWlVtNitTOE9JVXVobXAzNVJnZWlwT0srRWFHOGErSXJK?=
 =?utf-8?B?SEYxckwzU3E1WmR2RWFhd0lVY0xZVkxDUHhYSVpIZzNIQXZtb2tTYllaamZn?=
 =?utf-8?B?bFAyeVUzSTBtenNlRGMyN0ZOVTBVc0YyWUQ0b011a2dUYVJ0OHJTNWc2Rjkw?=
 =?utf-8?B?RkhNaDhycU15K2M4bkVkTlZ2NGF5NURxMkx4RmZtSVBBR1pUU2NOSVRDbG8w?=
 =?utf-8?B?MnQzUXFINkdtVGl4RllXSk41dXVhVVlTVGd2WjFmVk96VkttSFYwMW1MOUxF?=
 =?utf-8?B?Y2tyMGwzVUhReUEwTzlaYVYyV1gwZzExMW4vM0huRDZLaHB1TEFSWFNGVkly?=
 =?utf-8?B?VVFlZW0yMEwzMlZlaTA5Q001d1VOclZMbHUzR1lZdjZpMGxNd1VGR2pENThn?=
 =?utf-8?B?MFhya2RoejJONFA5ZDBaZ2JSZGN0cFlHZGE1ZndpazJJVStxQVRub3lYblI3?=
 =?utf-8?B?T0NNUWNxRkp3V3dPaGRlbkdXaDNKdStLNzNmUnNMU1FubXM2azNMS0JvQXMy?=
 =?utf-8?B?ZEZnYkhuL1BNbHJmT054aEpsNkp0TWhUSUZvck5UWm8xckNIS3g4V241cmZP?=
 =?utf-8?B?aytsc0tRRjY2UEQxbE00ekozMHRSQ1VEazVhK3FwOTFjVVhuaEdkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0f0a5f-9317-4132-2b65-08df07204a2d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:37.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoBqMQDwyoi3vUPfEieZ90uC3RE4k5XQl0KgprWZQMW4DN8Qqev+W70Pgeiiz1c/cSOGNuOiP3Rc15Rmqb/mMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275



On 8/30/26 23:52, Mika Westerberg wrote:
> Hi,
> 
> On Sun, Aug 30, 2026 at 11:33:31PM +0200, František Tichý wrote:
>> Hi all,
>>
>> I've run into this issue on 7.0.10, 7.1.6, 7.1.8 and 7.1.9 (specifically
>> Linux 7.1.9-arch1-2), as well as LTS kernel 6.18.45.
>>
>> to Mario's questions (thank you for them; they were captured on the
>> 7.1.9 kernel):
>>
>>> Can we please get some kernel logs for these two cases on the command
>> line?
>>>
>>> thunderbolt.dyndbg=+p
>>
>> Here you are, the system does not load the graphical interface:
>> https://gist.github.com/Poirot12345T/be6b7849e039687e248b8c302615d9f3
>>
>>> thunderbolt.dyndbg=+p thunderbolt.host_reset=false
>>
>> In this case, graphical interface loaded successfully:
>> https://gist.github.com/Poirot12345T/c63a1a3b2b6609b30a1182e7681fbec1
>>
>>> Also what is the value for:
>>>
>>> $ cat /sys/bus/thunderbolt/devices/domain0/iommu_dma_protection
>>
>> That returns as "1" on my system.
>>
>> I've also done some digging myself, here's what I found out:
>>
>> (note: I will use host_reset=0 in this post, even though the thread used
>> host_reset=false. These two values are functionally identical.)
> 
> Yes correct.
> 
>> Originally tracked down in amdgpu bug tracker
>> (https://gitlab.freedesktop.org/drm/amd/-/work_items/5632) and based on
>> the suggestion to use thunderbolt.host_reset=false mentioned in this
>> thread, I traced back the issue to commit 59a54c5f3dbd (authored by
>> Sanath S, CC'd) which touched drivers/thunderbolt/tb.c (Thunderbolt/USB
>> subsystem, added Mika Westerberg as a maintainer and CC'd linux-usb
>> mailing list), more specifically function tb_start() and this code block:
>>
>>      /*
>>       * Boot firmware might have created tunnels of its own. Since we
>>       * cannot be sure they are usable for us, tear them down and
>>       * reset the ports to handle it as new hotplug for USB4 v1
>>       * routers (for USB4 v2 and beyond we already do host reset).
>>       */
>>      if (reset && tb_switch_is_usb4(tb->root_switch)) {
>>          discover = false;
>>          if (usb4_switch_version(tb->root_switch) == 1)
>>              tb_switch_reset(tb->root_switch);
>>      }
>>
>> This block should be located between lines 3060 and 3070 of the above
>> mentioned file as of the time I am writing this post.
> 
> Does is work if you boot with the device connected (and host_reset=0) and
> then once the system is up, unplug the eGPU wait a little and plug it back?
> That's essentially the same thing as what host_reset is doing and is pretty
> much the nature of buses like USB4 (e.g the user can unplug the device at
> any given time and plug it back later expecting it to work).
> 
>> I was able to reproduce this issue using AMD RX 7600 (journalctl dump
>> link:
>> https://gist.github.com/Poirot12345T/909f3d071f87655d875445e536da74d3).
>> I have also tried NVIDIA RTX 5060 with the nvidia-open driver which did
>> not trigger this behavior in the default setting. (journalctl:
>> https://gist.github.com/Poirot12345T/4deeae10508e3971521aca9e612b5737)
> 
> It depends on the GPU driver. Some of them are prepared for PCIe
> hot-removal, some are not yet. With the rise of eGPUs I would expect that
> we are seeing more and more support for this though.
> 
> The ones you shared above looks like amdgpu driver and I don't see any
> issues in the dmesg.

I don't doubt there to be gotchas and corner cases with hotplugging an eGPU.

More testing is going to find cases of bad assumptions on mutexes, ref 
counting issues etc.

I do want to note that for amdgpu we're disabling runtime PM for eGPUs 
starting in 7.4.

https://lore.kernel.org/amd-gfx/20260812080841.2936007-1-kevinyang.wang@amd.com/

You can experiment with 'amdgpu.runpm=0' on kernel command line.  If 
that helps an issue, then what's coming in 7.4 will help as well.
