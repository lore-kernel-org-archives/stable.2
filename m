Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7BA36DA14;
	Wed,  8 Jul 2026 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553143; cv=fail; b=mBOoycmGYcFC4GiaxQGlAE/7M8H4Y1sXoDjSfETDmwVmuufEDLbwvTnBGomHL3vmVvzyKmsnfDSe/xjggP9YH24P2q0RQOBZBkEI5GtC84MGK4LjGvA8LssyAUliqE8YtpnFHDYdicq2lEIWWOhw7V2a/pgvvVedkLpxrpej43c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553143; c=relaxed/simple;
	bh=1zS/XSnLLhwQf3Pe/3oyNVYx1ULuf+0GMjcJhFASEMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tjhoIRtEFG11pF8Owro/JcOhcU8ZCf+VlvsN6s53x40fJ8o9PKGWx4WWBxaCSNb2opAQaaP74w+7owdgI6TYlAgBbwI+rwhPQFyMUnpi7kbjxfv15Jc2leq1bh+KhQvAqbbDmLcl6vTjSmGTnQQ3HIvXEwzXqFxG6XvOtUwN6p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BBPF9VHz; arc=fail smtp.client-ip=40.93.196.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BBPF9VHz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7fvq99jO+MuTM1jMRuuiLWQ/HLAkVhItERQb3UWqZ+QAcaJPXwEe4wPKvEisl05JFijkwYC3b6NTP8W7yZKMxvrtr4txx22FsRlpCOCh4lhP7PD7I3II3h0LDdsfL6HTmQ3I7jGfN/Jd9HsFsVCORJ93eBS8tFKrtz4NQbrBtAciqoFHmobp3aqagMt27AQ0fdpU2/uO5SS5AjPo8BmHPKQg0i1rkCZxuwI3uOxn5LL7tQpXkyzAb3UJddG60fOiaVSCx/kH3XABkfKDXOW9YrGoq5Flap52QPnWnNth8h+IqSUZ+O+0Kyfgx8+i1abVf2c63EbPaYQyyvb/ss35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVjIF9wcUfVGBGL9PrjRY8dEHIi8NMeJH6HUEehRypo=;
 b=QK3jDEzdUtbbon6oz9Oq0W8vkLQ29k2QpHDlGGMxtw4Yl68OikzbPK5181vkU71USr2r4p3cecRygo+7VCjYZev0YdJckaw0HXR7wHCycueko5Dw1uVw4VZK4Itx/t4I7WjjsJGdGvtBgt0Ujl91f1OQ2pGT6PGSks8XWpqHlsIzV8YKvHP8EY5U/C/lRtACxD/ptTUk4PM2kzh2T7vqkWkMf/dVVsei0mbqXD6pyGZvpF30x5kdFRzWB0gABZ0bsyujeRJ3AlNWpwh3VXRMQQevmmf8PZYpunPYVTn9iZajbLSMvgQfcCB9EkQNEXz+hXdJ/cq1G9xJfPONzARaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVjIF9wcUfVGBGL9PrjRY8dEHIi8NMeJH6HUEehRypo=;
 b=BBPF9VHz1IsgR35gRwbC4J2SzB4WR59yYSHIdW1m6ykS7vfqlzeLZ73sEv7GWF/aNZUqF266X1FLhFftA5J9pcLKcF6UY8cHxnKHziaBHMV5bZ4+rOL0eZJMYb/aRIFOV76vQw7O4bcHFnhL7BgZfw0QZiTIbwruwLUD4++4KPDgoaTYechckQn7SX+qTscEBxNGkLw8hXySN5hgAbJi042rMQd0VkACPEjn/aQVXTnIgXEUvL/Z0to+pZMrtZatI0NSt/M4fGSL7lgyCpj/2aKXX7Nv/zRK4HnoRNpjOG7IGkmLu74t4zVRJr8UPV1WDL+/pPhmd/6Ls8kRkfi1bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 23:25:37 +0000
Received: from LV3PR12MB9412.namprd12.prod.outlook.com
 ([fe80::c319:33b5:293:6ec4]) by LV3PR12MB9412.namprd12.prod.outlook.com
 ([fe80::c319:33b5:293:6ec4%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 23:25:37 +0000
Message-ID: <58219e62-99aa-4bb3-9c6b-5f96dae12649@nvidia.com>
Date: Wed, 8 Jul 2026 16:25:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
To: lyude@redhat.com, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Timur Tabi <ttabi@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kees Cook <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, Mel Henning
 <mhenning@darkrefraction.com>, Aaron Plattner <aplattner@nvidia.com>
References: <20260701182857.190713-1-lyude@redhat.com>
 <20260701182857.190713-3-lyude@redhat.com>
 <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
 <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
 <DJNO6SIE8T88.1F0ZUILIRVDJC@kernel.org>
 <b5d08cfe-aead-45f2-937d-6e9ef4dfea50@nvidia.com>
 <971d09c47689981c1ea44c89555f71fcc0b5db41.camel@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <971d09c47689981c1ea44c89555f71fcc0b5db41.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To LV3PR12MB9412.namprd12.prod.outlook.com
 (2603:10b6:408:211::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9412:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: abe39a56-401e-412a-ee97-08dedd48374f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|5023799004|18002099003|3023799007|4143699003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	1czqPzHlKRDIPogbmdWxUZUlEdjXYt65DOvamfvWe2Mw38C2kpKI5IcUtWP9bUrbyyGNOlXhuaHZPNQ22NwPEUdzlILUPnRpqNywGwZfrok77WngL0TUeVvAcsG8qwAk+6hzDXinpldcdJcBvuwfBHngSq9CV/qcJhRJRkbuiljkKFr8sbfWoUz+6ZSOvETeqPS63QY6n2aPnRAONl0BBz+oSzTRKkVI/RtNWlZCSAwIsvpI5MCep1wve/ScoAtRlLVpAWosrxge7j+FaApYXzxBSi4bAcE5neOG04PLfh2IhArKtdjMKaSVmfefM1O/1fmIThjdtXZnVcgUsSWdgvDJuWCaO4Cpis8Xp5oHjbcjVcjHA0c/hs739YNseNKJBdc+vnYuLHSLDQXDHkl+vXR2l0Q15DpWumjElHLwyraphJ2mmMZIZ+jnYFwlSjfnaUHxmAXvaK657iZ6ta66uwN1EUOPEtg/zBYE4MO4w0UTVE22hEwiwcSMBW+veMrCj3cL/SdAPeQgfhQx86mqQo/1fxMf/m+Ta16ETccz3nFL6X7dmWUx2kYj75muZCyEpLRmzBaoqTWAT1yuMdpZ4Ioit1+7J58kJvwmDbBAuq5Mke1Zyas1rz2GS9Yd6GGYNZqSlQfX5YrjAMHOqNfVxVstqZDQxtC46hg+px3Wdss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9412.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(5023799004)(18002099003)(3023799007)(4143699003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzRGYU1Vb3F0SGkyOEYzUEdOSDFjOW96V3BDN3Rxc3ZOa0pTQnZXeHh4NTJO?=
 =?utf-8?B?MEFGcnlZSDNyQ1hIaXFLYzMrbnJuUFgwejBtZGlTVCtwVjd1aWFGZGR1Wjd3?=
 =?utf-8?B?QldNd2lHRUdoRzczYkJvUm9lUzFhZnhJZHFNZzF6aGhMeVZDdkJIcGgzQnhY?=
 =?utf-8?B?Y2MrOWNtNnZLS1BSUVN3SytyVDVQYVdITDlIc0RlT1JpektkUHpHM3FNTjRN?=
 =?utf-8?B?WmxjWEt0V3R4WnIzS0R1TnNFT1Qwd0xOWmZGS3NiN0tHaW5NclphN3lKL3Vq?=
 =?utf-8?B?Z0dVK1JvY2VXdS9LbG9nakM1RTlSQUZFcFNvVGJLb3BSUnlIS1JwNUowU083?=
 =?utf-8?B?QVNReDQyK25MZVo4YmtNcVNaaThKRnlGNHY4SmR0ZUx6MDJRMDVwODJueVFM?=
 =?utf-8?B?RVZpdWZQY21BODFMbTFWVFdka2wxWEVpY09FbFl1LzZjSk90NFRraHQyNUdQ?=
 =?utf-8?B?TWV1N2VHemxYaUhJV3lMOHhRU0FPZENNQ2Yrbi9OcGpCY3JYNnc3alo4dDBU?=
 =?utf-8?B?a1pPQ1ZzcDRLZ2dsVVBUaVI3Rm5SQ2s5Q1pMTjRTREFVckczVXVxU3V3K1o4?=
 =?utf-8?B?Y21YSzF4cW9CWkVRT3d6T2szRWZiQ2p6T1FPVHl2eTVZNHdOL1hzZzh5UDI1?=
 =?utf-8?B?UnZWaWpPWG5CNnl6eEVFeGtiUzN6N0R5cWRjdWFLMk5oT1Y2SzNESStWUVBY?=
 =?utf-8?B?TWtyQVI1Q2E3Y3IzSlJUQW92YWZuZFJhMVpiOGYxNGVBTjgyZFBPVXVuZ295?=
 =?utf-8?B?YTY4aXIzamJWRkltZXNMOG1MZXpHM2NwMFdRWDZKQkZMMzVBaHhSTDM2eTJF?=
 =?utf-8?B?RXVnQmZzVGNDcGhpdDk2Sm5LR2VpNndHWnZ2ZTFYdTBDWTRPWDNpY3A4VzU1?=
 =?utf-8?B?UmZVYTRNUFRvYkZ2UzJiaE9IdFM0Q2ZOM1R1MkZaNEtXYS9Qa3BZbDkxZVg2?=
 =?utf-8?B?dFdRUVlPZDUzR250bjhRWGVIaEZqOHZ0dXlXNGNDWVRNR3pGWUdKeGNqaHFG?=
 =?utf-8?B?UlZDc2g2aG0xWjhFNmJ0MmVRU0Q3QVBlS2g4MFFIQjRuT3QzMW4xbFlueXdR?=
 =?utf-8?B?bXE2WndTclZUeS90eFpVK20rczhUR0h2UUdiTDNobE10bkdNdmNIRmI2Z0JO?=
 =?utf-8?B?OXZ1Nmc4YlE1WlBhLy81c0hlTG5HNzBrSDFpM3pCYko3c1JqVmNrM1dxM1o5?=
 =?utf-8?B?REVQSDNUaGo2S1I0M0VqdFZyUFFxWFdLb3ZGcWhPU0pXcGdYN3M4U3B3L0Jj?=
 =?utf-8?B?blpQeCtXVlZyOWJqdElsYjFPbkRHcHpyakJWRkZsYzVvSWIyWTNNSDM1bW54?=
 =?utf-8?B?aXJXMXlqUmZHeWtKc1JjR01HbVlZSC9WZ3gzcTZtQjM1SmxCS1NOUitNeXYx?=
 =?utf-8?B?eDhCOHNWVmptaVVHakNkUHZCYVBJNy9odGkzNUhkQVZKNzJBZ044TTNhNnh2?=
 =?utf-8?B?VTB4eHBlaCtWV2NySEwwY1V0eUl6d2xxRGM1ZUZpays3dEhuVHRMS3RSM2hs?=
 =?utf-8?B?bko0bDVsK1lFZHBWeUFkcTF4RE5EZyt5VWg0SnEwQUJnNm5QNUZiYTViWDhG?=
 =?utf-8?B?eVNtVmR4NnpqQmtmUi85MWtDWENxZ3h3THJTUHlHU251S3kyRTF2VHlYWXFH?=
 =?utf-8?B?S1VidU5MSkpybmZZMVM0RnYwajI4ZllDTlNLL2gzSm15djh0VzlORHE3d3Bi?=
 =?utf-8?B?QlJacVpYTERZU0I2TEZrekMrNGhaYVI3QW1KUlFzU3Q1amkrZHBaTVkySURU?=
 =?utf-8?B?ZlIxYWdBZWpjTGhkYUZXYlJGRzNaZ0xhVVg4VGNjbW9TSE85OTJ1WFpueE5T?=
 =?utf-8?B?aTdIVFZzK2cwT1EyN1NpUGVmMUNMaVQxU0ZPWHhoYmlSYnZrK0F4VEVRZnNU?=
 =?utf-8?B?RStwd1dBdm1MVVcvK3RJMjUvVnlwUzZsSUtGV3FUdGdVQllyS0JzOFRWL00x?=
 =?utf-8?B?WVJWMlkza0lYVVVUYVVzOUdBM0h5VVB4ZVIzcWdUbU5XRnM5ZWtRa1psWi9V?=
 =?utf-8?B?VWczRUpkam5RazByMVNvbVNpeWFRZ0xwSlFwR0JpRjc4Tk1nMHhlZTZTMkd3?=
 =?utf-8?B?L3ZaZ1kzWjBVQllhMXE2Qy9PajdnOURoeCtVcUF6MG9NVDdlcGVsWG5ib3Nl?=
 =?utf-8?B?SkZPMWFubVkvS3NYT1ArNlJjVmRFR3o4RkVXaEZZckpDZUwwRDFtL2pFbE56?=
 =?utf-8?B?ZUUwVVFzOHFXRnRBY3FmNExXNmlKdmowbWtQbVJmT25KYUtmY293ejYyOGdW?=
 =?utf-8?B?Y0tmYVZEalgrWCtlZ1hOSXQwTE85VXZla0xjSlhRb216c1gwRzAyMlVCRmlR?=
 =?utf-8?B?WXZxMFJXV1lwRzJWZ0d5dVNiMDFnN0Q5cjFOQ0RHTXFlY2R6aGk1UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe39a56-401e-412a-ee97-08dedd48374f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 23:25:37.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29BRUkiTJV3xvM+Qgqnsvnetwst32RHRz6uVnHTJKBN2Db/fAVBMTKIjeXC7sPaujb9MHByOgwbckBL4MJ7GCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542

On 7/8/26 4:18 PM, lyude@redhat.com wrote:
> On Thu, 2026-07-02 at 12:46 -1000, John Hubbard wrote:
>> On 7/1/26 2:47 PM, Danilo Krummrich wrote:
>>> On Thu Jul 2, 2026 at 2:30 AM CEST, David Airlie wrote:
>>>> On Thu, Jul 2, 2026 at 10:27 AM Danilo Krummrich
>>>> <dakr@kernel.org> wrote:
>>>>>
>>>>> (Cc: John)
>>
>>
>> Also Cc: Aaron Plattner. I've provided answers below, but Aaron
>> has actual experience in debugging suspend-resume on our Linux
>> drivers.
>>
>> These answers are the result of my moderately long session with
>> our best AI tools, using Open RM, GSP-RM, and Nouveau sources
>> as a reference. I'm not actually experienced in this suspend-resume
>> area, much, but this makes sense from what anecdotal things I've
>> seen before.
> 
> Would definitely be good to get human eyes on this, see down below

Re-adding Aaron to Cc.

Suspend/resume is hard, we need an actual expert here.

> 
>>
>>>>>
>>>>> On Wed Jul 1, 2026 at 8:17 PM CEST, Lyude Paul wrote:
>>>>>> It turns out that the only reason our previous fixes looked
>>>>>> like they
>>>>>> worked for this was because we would occasionally set the
>>>>>> Gcoff state to 0
>>>>>> in the normal S3 path, which fixed suspend/resume on desktops
>>>>>> - but not on
>>>>>> machines using runtime suspend.
>>>>>>
>>>>>> The proper fix is to just never set this flag. Our current
>>>>>> guess for the
>>>>>> reasoning behind this is that Gcoff likely coincides with
>>>>>> GC6, and not
>>>>>> literally power off.
>>>>>
>>>>> I don't think GcOff coincides with GC6, it should actually be a
>>>>> power off.
>>
>> You're right, it's the other way around from the commit message
>> guess.
>> In the RM sources GC6 and GCOFF are two distinct GCx targets. GC6
>> keeps
>> video memory alive in self-refresh. GCOFF is a full power-off where
>> video memory content is lost, so RM copies the used framebuffer out
>> to
>> sysmem before entering it, and it reports vidmem power as off while
>> in
>> GCOFF. GCOFF is the power-off case, GC6 is not.
>>
>>>>>
>>>>>  From a quick glance in OpenRM, it seems that with
>>>>> bEnteringGcoffState = 1 it
>>>>> also saves off buffers flagged as
>>>>> MEMDESC_FLAGS_LOST_ON_SUSPEND.
>>
>> That matches what I see, and it's the key point. bEnteringGcoffState
>> is
>> not a GC6-versus-off selector at the FBSR layer. It becomes the
>> PDB_PROP_GPU_GCOFF_STATE_ENTERING property on the RM side, and that
>> property widens the set of allocations RM saves and restores across
>> suspend (memmgrAddMemNodes, through its bSaveAllRmAllocations
>> argument).
>>
>> With it set:
>>    * RM reserved regions get saved, unless they are LOST_ON_SUSPEND.
>>    * RM channel-context and kernel-client buffers get saved even when
>>      they are LOST_ON_SUSPEND.
>>
>> With it clear, the reserved regions are skipped and the channel and
>> kernel-client buffers are saved only when they are not
>> LOST_ON_SUSPEND.
>> So =1 is a strict superset of =0, and it does include the
>> LOST_ON_SUSPEND buffers you found.
>>
>> The part that matters for nouveau: in the full driver that property
>> is
>> never just a standalone flag. RM sets it only when it has decided to
>> do
>> a GCOFF as part of its own RTD3 policy, after it has reserved
>> correctly
>> sized sysmem for the save and turned on comptag backing-store
>> preservation for the state unload and load. Setting the flag in the
>> FBSR init RPC on its own, the way nouveau does, gives GSP the wider
>> save
>> and restore set without any of that surrounding GCOFF handling.
>>
>> So I would adjust the guess slightly. It is not that nouveau never
>> saved those buffers or never had them. nouveau provides the sysmem
>> and
>> GSP-RM does the copy into it. The problem is the reverse: with =1,
>> GSP
>> saves and then restores buffers that were meant to be reinitialized
>> on
>> resume, and it does so without the comptag and state-load handling a
>> real GCOFF pairs with them. So the accurate framing is "buffers that
>> should have been reinitialized get restored instead", not "buffers
>> nouveau never saved".
>>
>>>>>
>>>>> My guess would be that with bEnteringGcoffState = 1, GSP's
>>>>> resume path expects
>>>>> certain kernel-driver-allocated buffers to still be in place
>>>>> that nouveau didn't
>>>>> save off, or rather never had in the first place.
>>>>>
>>>>> John, do you have some details about this?
>>>>>
>>>>
>>>> In nouveau we have the INST_SR_LOST target, for buffers that
>>>> aren't
>>>> preserved, I wonder did something change between 535 and 570
>>>> around
>>>> what needs to be kept around.
>>>
>>> The r535 code never set bEnteringGcoffState in the first place. In
>>> r535 OpenRM
>>> seems to do the exact same thing.
>>
>> The set of buffers did not change. The FBSR client ABI did. In 535
>> nouveau enumerates the exact VRAM regions and sends them to RM one at
>> a
>> time, and it never sets the gcoff field, so the flag is a no-op on
>> 535.
>>
>> In 570 nouveau passes RM a single sysmem buffer for the whole heap
>> and
>> lets GSP build the region list itself, and the gcoff flag is the only
>> control nouveau has over which regions GSP picks. Forcing it to 0
>> makes
>> the 570 GSP-built set match what 535 effectively saved, which is why
>> 535
>> looks like it does the same thing. So 0 is the right value for how
>> nouveau drives suspend today. RM derives this per transition from its
>> RTD3 policy, and 570 setting it to 1 was the deviation, not 0.
>>
>> On patch 3 (the resume state flags), I looked at that as well, and
>> here
>> is what the firmware actually does with it. In the 570 GSP firmware
>> the
>> resume state load already runs with GPU_STATE_FLAGS_PRESERVING |
>> GPU_STATE_FLAGS_PM_TRANSITION. That is set unconditionally in the
>> resume
>> path, and it is gated on the bInPMTransition field of the SR init
>> arguments, which nouveau already sets on resume. The firmware does
>> not
>> derive those flags from srInitArguments.flags. That field is read in
>> only one place on the resume path, an unrelated display workaround
>> gated
>> on the PM_SUSPEND bit. Neither 0 nor PRESERVING | PM_TRANSITION sets

This "unrelated display workaround" might be related after all, perhaps.

>> that bit. And the value the open driver itself puts in that field on
>> a
>> standby or RTD3 resume is GPU_STATE_FLAGS_PM_SUSPEND, which is a PM-
>> type
>> indicator, not the state-load flags.
>>
>> So from the 570 sources I do not see a path by which patch 3 changes
>> what the firmware does on resume. That points to patches 1 and 2, the
>> revert plus never entering the gcoff save path, as what actually
>> fixes
>> the push-buffer timeouts. Your 100-cycle RTD3 result is consistent
>> with
>> that: those two are what stop GSP from doing the wide GCOFF-style
>> save
>> and restore.
>>
>> I want to be clear about the limits of what I checked. I confirmed
>> the
>> resume-side firmware behavior against the 570 release (latest)
>> sources 
>> rather
>> than the exact 570.144 build, so I am not claiming patch 3 is
>> provably
>> inert on 570.144, only that I do not see how it changes behavior. And
>> I
>> have the mechanism for the =1 breakage but not the single allocation
>> behind the timeout. I can see that =1 restores LOST_ON_SUSPEND RM
>> buffers that should have been reinitialized, without the matching
>> state-load handling, but I have not isolated the exact buffer that
>> produces the failure.
> 
> Mhm - the AI must be missing something, mainly because I went back and
> double checked - and at least with runtime PM on this ampere machine
> I'm immediately able to reproduce issues if I drop patch 3 (in
> particular - job timeouts after runtime resume). The actual
> suspend/resume process succeeds, but it leaves us with a GPU that
> doesn't seem to be able to render anything:
> 
> [   93.167997] nouveau 0000:01:00.0: vkcube[11028]: job timeout, channel 4 killed!
> [  100.365899] nouveau 0000:01:00.0: gsp: rc engn:00000001 chid:4 gfid:0 level:2 type:38 scope:1 part:233 fault_addr:0000000000000000 fault_type:00000000
> [  100.365907] nouveau 0000:01:00.0: fifo:c00000:0004:0004:[vkcube[11028]] errored - disabling channel
> 
>>
>> My bottom line: patch 2 (=0) is correct and is the right value for
>> how
>> nouveau drives suspend today, and patch 1 is needed with it. Patch 3
>> is
>> harmless, and from the sources I do not expect it to change anything
>> on
>> 570.144.
>>
>> Assisted-by: Cursor :)
>>
>> thanks,
> 

thanks,
-- 
John Hubbard

