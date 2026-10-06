Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A52F616A
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791316194; cv=fail; b=gk1YFxKw4YBP2QAevue63/FEUGcKai6pi47WudaChDxRd67LZp6gw4HphmHrRJq6VJl3LsOuuj5+01iFgRgTO8wZs51SfZB6AHDPNE+oqUTNnMuAWr7m0FGSuWnP2QH0tz1mibTThI1903mZglHK0pI0xZvQQYzbqudqVNBSF+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791316194; c=relaxed/simple;
	bh=6CuybToCJ77iX64AvGvhFMrCkAAb9XkCgXeJkK7Ivu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oS1hbgw4j/kROTRAtdUyKMeUrBHBKU2glNdSjdABsfQWERYem/Fzbu2R4sA/Q8wCHtcMn6fsNXaQ7Jx+ExETolLpyExLii9O67hzYetpi/68vNKY0xiG/g4zqkhEsj+lyqnl7RpCA21i614O0rg/YNivxI4Un0HWsCAm03dvWjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vRb3cmIy; arc=fail smtp.client-ip=52.101.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vRb3cmIy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJ9vHkkNCvBs9io2H57uQTDyCKRuui9J72L8cOaNUkipY6myz1FJZYA6Q6fnB1lPb8Va5HoKmW+hUOf55Kfy/gzuEBT8OpXt6a94aADTbqvfpqbOGT0F+jnmABrJfPrhm4Cl2WPe998UrSKITTyrCZ5y8Hkmo/oEF5VSB7o8TEdEC437RzUx8n7p8+X0Cp0D6GkH2HhV7uqTrDTCL0cmd3pMqHsCNAipKmPWCAI69OUu33/6QUFHMNWpLw5e5Wh4Vrr7aaz+9iIKaacdSw+Jv6+ocQzUt8Z1IK37yofzaL5taP8tDFbuEhxQ2MQiKlYkb+k7biJ8+FSDVUBXyqAY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqOxJWKMVzHq4gAWlpcepmr3l6ql+856zb7H51XPCao=;
 b=tXeChNwOkXUx37W80SQIErY1QA4lKU79m/TPPH7cXqkOITTIthuiGu6R1Z6N9wGjJqtWDrBpnne5KOGUIdd5dfphe0XMgq8u+U9ZxtmX3Aju4bTXYHGXHhyjSMw8FR8zr69O/Q2Q+RHAxZlbVQ1AP1Butwz2z82i3/0nmI0rKywgg1xxDZcpJVVUgpTY2qUZc3W5aih85QvRvVf6PaYiF881vE7QL5JeJ3WoW4VjXgR/iRYA3mEHD//iOhLp0uzdRqHJD3ZHpZHRBbaAM8+ZDxfTBdXjMcwmQZHpgeGuPE6xfKWk957seiOfs3tu89s2bqMxHFXOvfgXfAXozBG3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqOxJWKMVzHq4gAWlpcepmr3l6ql+856zb7H51XPCao=;
 b=vRb3cmIy7jHuU5HXVdcsemi7/M1K+MVwJIcRoBbTM760CKiBEPBG6+L+oqqinxnf93aCkRwS2K2dQIqQr3PY/uDVxTz4ujEy7ItFE3YHrz4AzOxr2TsPQitgjKWQhQIdkb13AgNDKPmcDuULalL8kAGj7B6zKoDIb4kJ8+e5oO4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 19:49:46 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 19:49:46 +0000
Message-ID: <ee4ea3a7-81d3-426c-b6f9-617a9e854627@amd.com>
Date: Tue, 6 Oct 2026 14:49:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2.y] drm/amd/display: keep HDMI 4:2:0-only modes and
 automatic 4:4:4
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Miguel Mesa <miguel@miguelmesa.com>
Cc: stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Jerry.Zuo@amd.com, harry.wentland@amd.com,
 mgorny@gentoo.org
References: <20261003131523.1502250-1-miguel@miguelmesa.com>
 <2026100353-vintage-skipper-594a@gregkh>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2026100353-vintage-skipper-594a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::15) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fdf3eed-d929-4440-6c5b-08df23e2f939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|10067099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	5xlwXhOL6RZLYktfIYY+2EwL5ho/hN7m9A9iPEWA1d8m0+yOFYKid1e7nKt05+GbNAXD82yAIDlmCtFjeMlNmzECxdtmDFaZKxBSMrghP9xW49poUYFy9ULInQXoEujg7CWZHR3ohaywvyQB3jW1awzIR0KxWuRnVJQG1iau4tbG+8tc/9CjLapLmbZyGFcO/n78Z5/QLFf8Ei8rGW4wCi2etPnHLEy8/0F85UnlAECJstauM0sXQKqfmWEpFMxs5/5Vg3qKgCodtjmtGTLVBefhqwtOA3I1xv5sp9tb7Bycn62wjqWk7H1BxdSK4K80DaiegcsC+Gpq0fnYSAOodIdV2K12aAC9FAPiBZArzMrIXTpZtktzP9BZuPgYy2LzHy/xlP6zyi+wn/5887+wpKhNxm8goAjO2yB2crsV4obVs7LDDC0uvhiWzyu+fTXdUvZ1TLGdvVyQepbKo3Obv/apt8HyLPPUnxWENWzJfCNLhWstyghbA+RQoy+F2iVhpu1if7dMBHaCI+3gXGOjN2g8M4o+6WRHnj9F0nwyDE7MnrNFtdWD2cvCj2I2cL+g3MWreHfvpM0tK93AOVbfJYI1XzO5LhcX4kT6yoUNcs6Pw3BzypaB5A9OoTF0X7zQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(10067099003)(6133799003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHdOb25EQ3dWeVZ2Q21kWVJqbEJGdWlzSkNwSmUwaDFZUXN1RmJnMDRpRDNN?=
 =?utf-8?B?dUpEK3lZNEtMUjJFc0k3M2I1SGZZSkxrZHVkMmlhNWFzUnJZUzNwZm9VRXdz?=
 =?utf-8?B?OWRaenJxWHZlTmN5YkhPcWphWUJZSm9xcmhlT1BaSlVrVlFNZzNEUFVJTkc0?=
 =?utf-8?B?WjVEODNlM0xJUXc2aEEralAyQURZZ3E1ekQzeTB3MW9BT2lRREtDVmVzb01P?=
 =?utf-8?B?L2JRM01hbEI0ZXBGU0htdTNhUlhkVzlvWkJUT3pQdEFYYVhNMTJ0Q1BJT01h?=
 =?utf-8?B?QWRqbm5zdnErN3JFcU1rOXI5cXhaNS9yQ3ExbE4wWnNoRFowbFVCbTcyamFx?=
 =?utf-8?B?aExRZUFoZXpiR0c5SlU4K1I1eGNvdnp6YmJGZkMwRm5aanBiNjQ2UHFoM00r?=
 =?utf-8?B?QklIR2dPYUI4SmMwOUhvVGhBVVlKczZ6dVpSN3NXeThNT3lQcjMzckx6eUZp?=
 =?utf-8?B?WmkrVnZQM0hWRXhjcnV4bFVKT29FVXBLQUl2cUdiNGRwZDZKNG5QMnZoS2NF?=
 =?utf-8?B?VmxoTXhDazlyL1h1MlVVem1LcGs1S0V6UFNuY0N6ditnd1FkUmM0bm5lTTZF?=
 =?utf-8?B?Yzh3bmdUNWJrVEc3cXdwYmlnSjR2Y2NTZFFIZ09QYUM5RGJMbS8rRFZRQlRE?=
 =?utf-8?B?Y0pTUEhZWDdBbmxwZ3ZXenVEMXRQU2pLM0FMMkc3UWtZWnBwVUpNSVRIQklN?=
 =?utf-8?B?VDZFTUYrN2F4TDVwTVpocDdFMlAxU3VlRHFxYTNybW5UWmFHWGdlSjQxUlBD?=
 =?utf-8?B?OTdjNWtpY3VWc2krYjA3cWVQMmRTbXBwd0FJL2I1bEZXb0xXYnFZeXAxN2xS?=
 =?utf-8?B?QVo0cUFzd2U1eEp4K00zcDdYT003LzhHMDlhT2FmbzYyQUxKWVhyTWd4bnU3?=
 =?utf-8?B?djg3WXVWTUIzeE5tWm9rUzN2enZJWTBzMkpWRVA0K2ZQdEV6bkp3c21rU1Bj?=
 =?utf-8?B?U1JuWE5QeHhpSU5aRytScnkzb3ppbnMyWHZyaUhFOGl4OVBSbWZDMXp1czZq?=
 =?utf-8?B?eE9tMkVWM2ltM1ZwRVJxaVB3YWl3NEJ5RHQ5akpLWVhiSWVZVXYxbTdvaWt1?=
 =?utf-8?B?a1RQMjdpNlFhV1g3NDBZY1FuSHgrNTZpQ0U2SSs2VHEzMisyeUQxbFYxWCtT?=
 =?utf-8?B?SkhLNFQzNEFHemVKRXk5MWlTUTJ3dG9zcno4Y01lUjFqODNxMDFTdFQ5VXR4?=
 =?utf-8?B?U3JSNzd1VDU5NUdJdUdaMDVuYlh5WnVVNWhuUkRoelo5UVcyOUc5Tlk0eGts?=
 =?utf-8?B?WlVMaVNIU1ZsaGZxQ05LRGxsVkp2emNOYzNuYTBBQmNkenQvZm9SY3h2elhh?=
 =?utf-8?B?SStvR0JVaUJsOW8vWFAxSDQra3hLQXhObDVxWVczK1g5NTBUUnpmRzNVQ1Vj?=
 =?utf-8?B?VVVGN003WTZwdGt2SlFpd3RvU2JsOC8xNkl0dnRzY1N6dUNjbGRnSmlEbHJl?=
 =?utf-8?B?QlMvbHdWM1g5SDJpaDh6a1BvOTE4QmY3a053RDBvcytyUENGNDdqdGVUbzVV?=
 =?utf-8?B?TGZRZEV5Nm9VMFVFSVVuQjBFVXF1Kzh4MStZZkRqc2FKN1RtWE5La3BjeXJG?=
 =?utf-8?B?eEUxai9rdjc2RTh3clU0VVdwMEpGRHF4cHVwS2RuUEVUK2grUEZZTE5wbktt?=
 =?utf-8?B?RTY5ZkxneGxRMHJTMmpVM2cwU3M4dHFneEhWY25qMEhzQmhaYWd5azJ1WG5R?=
 =?utf-8?B?bS9kNDg3UTdZaGcwSmxib3JYczdmQ1VOWnFOM3lsaFc3RzROYnNBMnY5SzVY?=
 =?utf-8?B?ZTEyNmtjWmVDZHk2dnNyak10WDdoYmxmWEIwOHIwWU5UNk81Z0xHNTFud3FE?=
 =?utf-8?B?V0MvTndsd0NyVFFkSnhjd2dHeVNsa1VjOEdMRUhYbVUraWdFNHlyRm9BVndE?=
 =?utf-8?B?Si91ODA3SjFqWWswQzJIc29uOWMxa2JJeFA2SnNuT255c0twbUpxOXdZZXR2?=
 =?utf-8?B?V2NyS3ducWJSR1l3K2o2dEFOSmJLZXNQZTJ3RXphY0FaeGtUNDJEdXdwbGxn?=
 =?utf-8?B?eUJBTVQzNkxMWkp3MnRQUHozRzBCL1Roczltd0NJRE1Wa3VMeTViSi9QZXJ3?=
 =?utf-8?B?eWZJSTVEaXlScFZUblkydm9kbzc2Q21sRHRQcW8xZjkzVzcreEJJVVViRlYx?=
 =?utf-8?B?WmRONzI5TE9CZ2gxaVF1YlBNM1dSQXdTbVRUbjRDU2hpSDREc3VxUlpVNCsz?=
 =?utf-8?B?aFB4dHZOVGYxVjY2RlJBbTFGUVhUc0xpY0d3TmVkbFVyVEFYMTJrQThHZjhr?=
 =?utf-8?B?WEtvN3R5dUZhK1V1NExDNnhJMG1pTzNVbFc3VzgwTWkzLzVyeldDQ09uNXR3?=
 =?utf-8?Q?da48O2eilGc2b1Rklf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdf3eed-d929-4440-6c5b-08df23e2f939
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 19:49:46.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VubOlwoeBzdoCftVd+cHTzW8Ategi17Fkt7Jau12pfCNjFBBiICVK0ssN3MMwhDYhBRUTouhmNM4c2pIxpALSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315



On 10/3/26 09:11, Greg KH wrote:
> On Sat, Oct 03, 2026 at 03:15:23PM +0200, Miguel Mesa wrote:
>> commit 7e5760f084d0 ("drm/amd/display: add HDMI 2.1 Compliance Support")
>> selects YCbCr 4:2:0 for a 4:2:0-only mode only when the IGT override asks
>> for it, and YCbCr 4:4:4 only when that override is YCbCr 4:4:4. On a
>> normal boot the override is unset.
>>
>> A 3840x2160@60 mode that the sink lists only in the YCbCr 4:2:0 block
>> then falls through to 4:4:4 or RGB, and the Wayland session cannot build
>> the output layer: kwin_wayland_drm: Failed to create framebuffer (EINVAL)
>> right after login. v7.3-rc5 selects 4:2:0 again for those modes when the
>> color format is automatic. Do the same here, including HDMI FRL.
>>
>> Keep automatic YCbCr 4:4:4 for the other HDMI modes, as 7.1 did. The TMDS
>> depth fallback also runs for HDMI FRL, so a mode that does not fit at
>> 4:4:4 can still drop to 4:2:0.
>>
>> This is not a backport of a mainline commit. The 7.3 fix is the rewrite
>> in 0b0ff65d3c ("drm/amd/display: Refactor stream validation"), which
>> cannot be cherry-picked to 7.2;
> 
> Why not?  What's preventing that?  We'll gladly take large sets of
> patches to fix bugs, in fact we prefer to.

It's definitely not a clean cherry-pick because of the refactoring and 
other fixes in 7.2.y already.

I let an agent chew on it a while with a /goal, and even it couldn't 
come up with a working solution:

----

- `0b0ff65d3c` requires the connector split beginning with `0e967e086e75`.
- That split depends on `f5165625b8b2`, `ee55bf7d6a63`, `4734e045f49d`, 
and `0618dec49415`.
- Even the earliest prerequisite, `f5165625b8b2`, conflicts with later 
stable changes already in 7.2.9.
- All six available rebases of the connector extraction also conflict.

A clean backport requires an upstream prerequisite series rebased onto 
this 7.2-stable tree; otherwise conflict resolution would be necessary.
----

So I'd say directionally this solution that Miguel built make sense. 
Clean up the tags as Greg suggested though.

> 
>> Jerry Zuo confirmed the pre-7.3 logic is
>> gone there. This patch restores the pre-regression selection on the 7.2
>> code, following the v7.3-rc5 rule. Mario Limonciello asked for it to be
>> sent to stable in drm/amd#5760.
>>
>> Regression: black screen after login on HDMI sinks whose modes fall
>> through to RGB, e.g. Strix Halo (gfx1151) + TCL 4K TV whose 3840x2160@60
>> is YCbCr 4:2:0-only (VIC 97). 7e5760f084d0 shipped in 7.2; still unfixed
>> in 7.2.9.
>>
>> Tested on CachyOS linux-cachyos-bore 7.2.7-3 (znver4) on that Strix Halo
>> box: Plasma runs at 3840x2160@60 with the same userspace and firmware
>> that stayed black on every stock 7.2.x kernel.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5760
>> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5893
>> Reported-by: Michał Górny <mgorny@gentoo.org>
>> Reported-by: Miguel Mesa <miguel@miguelmesa.com>
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Miguel Mesa <miguel@miguelmesa.com>
>> Signed-off-by: Miguel Mesa <miguel@miguelmesa.com>
>> Co-authored-by: Cursor <cursoragent@cursor.com>
> 
> A bot can not be an author.  Please read the documentation for how to
> use a LLM in the kernel.
> 
> thanks,
> 
> greg k-h

