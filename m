Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2F3921ED;
	Mon, 24 Aug 2026 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609350; cv=fail; b=Y6id5Q+XaufJxcLYm03BEer10+fjG8G68NbMoxzlxkQ1bG6jMg9hm3nRCOrMdPj7kW/fepr04REXh6ZKXDQP95LGzZb3GHJjDBGenxSsmv63VhdqgHnLTlKF8I3iG6DiajYBezNycpL4WZ4EnyDDpAMe+Gq7uHDJOVdzW6TPifw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609350; c=relaxed/simple;
	bh=5bDiHefJFdv9/inVOaOIEDBG8mtCbAIxy9tp36OtuXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VMIjmemPvQoQSImaprhZL0uVi9y99G/EeFRPxuhoZIPIeyuBHw2YBxUru3abP6X9Ij1MIHsZ3TBph2B+g5HFl8JXZY78TjGKedmHa+ncKoVittgj+ncImf5eQ8H4SVKkdmQJ8LGMIc3ucjut+9iXaOycMpLV/UOiDCbLTHn7cpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LnLvJ+Rz; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LnLvJ+Rz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWqfxYb8pNeo6kGtj8v/sSilyzO0y9i6MoauI7z1USGv+F06FmivaDz62S+42NxLrNYuz+v3MGvTyDuJ6zbYtytY0m0Ge6CtMioL6xEqZ/5No6FSxbVttRkKM2SzS4UQEKgn5YQulDtNYG9ZBkCr230r/KE5N+kr3kiFaYwnk+pM05fjCXYttkX2kAHeWC7K6gaieKadFkHEQkyFEfMuNopk4OuHlyVHuxPU9GMdyF00UX0SottWRzTfGA2daZLIeJqhUo1VyY7rQievkrhLy+eqpfLA/QRalldmiEC2s47H9bcHiPpkPppOGJkAr6HExhYlsXze/pcCc3mmLXpD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOdCemElLYfh7xSujWIxLa+Zty3Z9yfPMBXVdwg9NZQ=;
 b=ByS9BAiAGgEfZuMm4pbKsBbOI8FzCPPp+AkIVEQXgs81PV1oFSiU8w1xODFOCd/mb2VYV/y9hgcz4+XBbEAKNml7id06L+aKApeWmoRd0hZO1veyw4mh6OlvvWn3dIiQFOgOuqto2MLX7EIfpZ7FK3OqSaLEXBOd9QGJejPZBH9/N2Fj4Yi6mp1lB0Y5e9WC7gAPpSmCUUZXdermptrc+H3IaEElOXx0blXXm7/I+ZIcpK78Hi+D1vl+itUlvz/EyhtJL4cEp2qgWRX6lHPA/QWVDyQOAP9j46BwHAk6Yv2TtbUNRRIG+F/rz+a0S4+ietggr96osZR10EQ8kkuIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOdCemElLYfh7xSujWIxLa+Zty3Z9yfPMBXVdwg9NZQ=;
 b=LnLvJ+Rz9U14QxE53YwOukYbWeg0MY+yd46fT2gl7jVjB94KMDUVIbgDOIyrGQKDgj4t3svrv5mroXZHxFJStGQrCj3Y7gKxnMjoV8TK9OuKhnuFchsDAbSRxWpOY04aswwb5bOF6cOXdYTa/hQ/o2jTju2WcXH2F34WumBn+sI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:09:06 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Mon, 24 Aug 2026
 22:09:05 +0000
Message-ID: <226b2f34-fa25-4ca6-8afb-0b3dc942715c@amd.com>
Date: Mon, 24 Aug 2026 17:09:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
To: Mathieu Fluhr <mathieu.fluhr@gmail.com>,
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: Michal Pecio <michal.pecio@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Forest <forestix@gaga.casa>,
 Slavik Dev <developer.slavik@gmail.com>
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>
 <aosGtkE_diwVJJtB@eggarch> <20260823174059.46fec036.michal.pecio@gmail.com>
 <aoser8dLytrwqBC2@eggarch>
 <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:408:e0::32) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9742d4-4368-4bf1-fce7-08df022c501c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	doGaNEs5w0xApqV3O36bJNrvycCmHbm/p54szyxX9VU0qz2c3mHgNQAG5xqeFWC0G53mlziGi+tjtySFpsLE6vKmY2VWUZlWvAXQTUdCJt7Wi/ZiaaSvmcFyiIOFYw8nO4DdEExvYol1CuXSSg4angB9G1ub8blPwBUS/1+mJ6oxcKv8dZ9ACqwC5k8jq8UsktdfiRuNX2cKJHwCUlW3evChax5Rmx0s4Va0QlZ7jMD5xT4fe3KfRszVmk6v4QfGXAoHtAnCDvypW+QB9dZS9lRgHtPmare0f8uB6zZUT4Xes2cpmARKANldinm7thA/6bMVka88Z80Kj7D/Z6uHWZ2v4NgFOY/KZ/MsOe/wYCxqF2Vp3sBU5PYtYj3E2WsiW2XinWXqL28SiHsQBTipaPhooI8o4YkKF+vPYmcxTuwmlcVFnV9XSdmARbsyYymYvodWoEXVl/POt+CK9a8B0bP2AJI0UwgnN7y1/So2NSl8nyZ3myzHgmckZBCsKfMYnHOUWjFNWvmKqdK9rbFCkefRdJXe74WAEiqviC6Bs9Y7ecWj0mVqzPMoPXMTKX/5bdi3zZbhLbmsvMShaM6zikDqD3/PTLk4WtbxyiNdRWHHSconScF8ymkQkd7o0fLqj714EoqXxe4T3YmGt4pvOYPA9v6Moh8zIrUXGsxfop8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkNVSGlkZWRHMG0xcC9JbjFFQ2RoR3lJc0ZuMDRob09NZnpXaVVOT3ByalRK?=
 =?utf-8?B?SVMwazY3VUp5RUdJMm9UeW4rUlMwMmZ6Mm1JclJncE5aRUhKMmJuMXZseFpm?=
 =?utf-8?B?Q2hudWYrandHeU8zY05IZXpTeThmcWJENUFXRUNhSmpUUk9JaGE4V0hLd3JC?=
 =?utf-8?B?czJxSmJ1QmZscm00RVRxeGlrc3hYRlNVVWluN1ovSWg3ZXp2REErQit5TzYy?=
 =?utf-8?B?UHRvTFVQSTF2MzJXMmNBOVRBQi9RT2xXWEpTTjRscWZEVk40UkdhV2kwY3c2?=
 =?utf-8?B?dHlrQjJFMmQ3N0tQNExFR1JMbEJNZTlKYTJ4T1BORXdKUksrT0F4T2ZRelJh?=
 =?utf-8?B?Mkpmd2lRV3ZHY3lDRmY2QW5aWXhzN3R1a3JzYTlPanEvNi9uUUNOeHdXY1RB?=
 =?utf-8?B?aDd6SDJ4RG9EY1FoYzMvWVpYZGNmRU5ra1kzMGduWHRMUndKVDdFaEZBTHJG?=
 =?utf-8?B?ZmFkWVJPN1dVVFNuVHBsS1lUNTZvZTRQUEh3dk51dGVJTnNUY3RmRXlqZG9n?=
 =?utf-8?B?b2lsYnZxVnN0VGVXQXBkQ201MG5ySWQ4NUpwbThTbUFJVG84b2VXR3RuV0x6?=
 =?utf-8?B?eWlSSmFhYVkvYkRMeHpxSUgwYk4wR0ZrS2NZOFpHNERhUzdMYUgzcWNwMmFw?=
 =?utf-8?B?VTJUTUtQR0liaHpQSEgzSlF1b3ZvUDhCWEtlSE11a1Y1K2NJcHIrNmQ3MFQ4?=
 =?utf-8?B?cnB4WHViUW00SEsySXh2UVhTM29OeVZ1SWpkTjNqaUdURkNOWEJXVGRseDM2?=
 =?utf-8?B?STdSUGVaSDlNd3VBc0tNUU5YbXovajI2UThydk9GbVlDUkkrQm42RW5NOTNa?=
 =?utf-8?B?R3pxeUJWemVibEN2c0lldlVsd2dYbHdqcjdpajJPYUlWTWhzTGVTV0RpOGgw?=
 =?utf-8?B?ZU1NS2V2d2VKdGVaZ3cyU1ZOcDdValhmak5IQWR5SW02RlJoY1UyaCtmTW1w?=
 =?utf-8?B?M0JUSW1xb1ZBMDlJUWl4aTJPV2M0dkRwbDZhY21UZE50T0VIMkhtZlNKVG9X?=
 =?utf-8?B?RHI2RVNQd1l3dlRmQ3BZOStvTGdQbUtMaW8vejVXWTFyeERJaFlhWTRqaEQ1?=
 =?utf-8?B?bG9seDMwZ2h4Rkk4VU5aUUNlM1dvcCtaZWZmREkrWkdDc1loTnk5dzlqMUti?=
 =?utf-8?B?N0xsOWFyMit1S3F3VENVNGhQU0pHemZtME95QTloamJ5dDMveC9UeXBoK0tt?=
 =?utf-8?B?VmFQY0MrZVpub0c5ZG42MUVtZ29zbWRYeG1ESzZjS2hHVzNlVlJjK1o5MGdj?=
 =?utf-8?B?aENaaDIvVm1HYzRuR1QzNDlhWHhmNTgybTZZTzJPU2lSVlduRjc0aEpCdEUy?=
 =?utf-8?B?STZRUlVCQm92elZnZ1RzaUxkRmJOTlRkM3Q0SkVUM0dSWkxiVk8zeDg5dHhm?=
 =?utf-8?B?R1g2NW5KWUM5dERzblYrYnVTZjlQc0FFUW1LRmRWcUZENzZxcWYwcnFmQ2M4?=
 =?utf-8?B?b3hiM3RhV3hjdEVacDVyUmFpQ0V1UjlCcThoNUhiTjgwRkxHemtqa09IWVNX?=
 =?utf-8?B?MmR3dU5YMVcwa2JhcStRQWhDSjFJdFYwcGpmejJiUW9HYXZuVXJ1OCtrZVlX?=
 =?utf-8?B?WGs2eE1JREt5NWFyOTh1S3g0OXQzd25OeHEvWkxpNlZXSUg0a010QStNbUp4?=
 =?utf-8?B?alByTXhsMmZvZmY2dldjWnFpcG1GSE9Kd2R3MTMwRFNmbVp1VXNUbjEwODJa?=
 =?utf-8?B?cStNTTY5Sko3NmJJbmk2YmQ0ME1pelFPVDdRb0tORGNydHpVTzlRVndDRFVw?=
 =?utf-8?B?cmtkUndnVE4wNXRZQzFCZXl5eDlvcmt2NVlEWWNzNFQ5aUhnL3FPVDhxTGtz?=
 =?utf-8?B?bERxeG9SRUgvOXA5aG5EZmFFOUZWWW9CSUh1VkRiSk5xWUZmNE9HSE5BeWZE?=
 =?utf-8?B?bGRLamdFdmVISkxZbEdzcUJKQVl0aFRsckFqelAxK3lya1dTSlZjMjBDWkY4?=
 =?utf-8?B?V21Hazh1SEpkQ2paNjErQytrT3krZHJ2MlN2K0wxdi85Q1MwZlpaWWh6dXlz?=
 =?utf-8?B?WW5DbFR4VDVxK2xLWUJPWXV2L1pMZk9LZVlZTXlxbXkvR2dzRExJRmJiVFFp?=
 =?utf-8?B?OTBaUVpuZ1RJNVRlcWxCenc0SnNlazRoNzJpd3FQd2pCcW5UZXYvV1lSRDZm?=
 =?utf-8?B?UWd4dXk0ZlpmN1dxTnBEY2JFeG9pT2tybHovUkt5dmw1R2hsRFhlM09jT0dY?=
 =?utf-8?B?U3BERlF3Wk84SVZ0cjIxb3VDenhzbTdhamdpYVh3bnpkdmljelh0VFRuUkZJ?=
 =?utf-8?B?RXZQdlN3VDZaamxrWDlpcmZlOFYxK3ZTZVkwV3V5dEdvaGhwOCthMXQwQ1FM?=
 =?utf-8?B?SkdIb0xTMUREL1Q4WDF5RzhaNzNycjQrb1JxUUVuMGhhK2tjVyttQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9742d4-4368-4bf1-fce7-08df022c501c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:09:05.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsB/DfCKxzxWVcNWdkfJYMSOsk0mF+GnGzb4Xk7uoBDN1ix9d3pkSj0v6xzQYqv6wr+9IodYRfNCbdK23TJCQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156



On 8/24/26 14:37, Mathieu Fluhr wrote:
>> The issue is obviously a severe HW malfunction (you mentioned MCEs, the
>> Ryzen CPUs simply totally locked up), triggered by poking certain xHCI
>> controllers on the I/O die of these CPUs in some wrong way.
> 
> Yes. As mentioned, I first thought that the emulator itself triggered that by
> doing something that the CPU did not like.To be honest, I barely play with old
> Android versions anymore, but seeing that I could reproduce it even with
> Android 13 or 14 made me suspicious.
> 
> I _guess_ Google implemented a workaround inside adb for version Android
> 15 since using this version, it remains stable for more than 2 hours.
> 
> But, in the end, the situation is that from a simple user account having access
> to some usb plugged in devices (I usually add my user account to the plugdev
> group and use some known udev rules to access my Android tests devices),
> you have a way to crash the complete system.
> 
>> Opinions seem to vary on whether CPU load must be present or absent.
> 
> On my side (and I am here only speaking about my TR. I don't know about
> other Ryzen CPUs), I can't reproduce it under load, and one condition to
> reproduce it is my CPU going in C2 state.
> -> I did a 2:30 hour test using several youtube videos playing at the same
> time on my desktop, also stressing the emulator with some 3D Mark runs
> (as mentioned, I first suspected the nvidia driver to be faulty). As long as my
> computer was busy everything went fine. But then I let it stand still for a few
> minutes, and it just crashed.
> 
> If you need me to do some further tests or experiments, let me know. I will
> be more than happy to play the guinea pig here.
> 
The behavior that is described here sounds like a platform firmware bug 
to me.  Are you on the latest BIOS available from your OEM?

Can you please confirm:

1. Your CPU model number/codename
2. Your OEM (from /sys/class/dmi/id)
3. OEM BIOS version (from /sys/class/dmi/id)
4. AGESA version (see commit bc91133e260c8113c1119073c03b93c12aa41738 if 
the OEM didn't tear it out.  Otherwise look in BIOS menus)?

