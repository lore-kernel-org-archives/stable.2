Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439C4A2A61;
	Mon, 21 Sep 2026 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998318; cv=fail; b=XDhDXYFKA+NAaJR+jBpaoczRtr5iwkaUbE2K66eM2Gstwia1IDoQgGfDaQ0UYs2PlpLlaGQJr/1ix9TaOo5B21I2uH4WDcXC/melFcxvq8Se8eHGWM1tYcUitRG2/m6kf//dwnUOxo+w1zOvxcTR6sRpbsq96oueKwH2qCTtKTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998318; c=relaxed/simple;
	bh=kPcjrhE3Xio0zYDCTtFCB4jelpVm9a8wGSIHrcIRfvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ECpkzdoOsr6XLZ7bKZWynx1emdNOkgkJ+Slz27Gu8GgWBj8iTpYqUZwXnp0Leu3ATe9wd6izd2MgmbYFjev5NGwpjj5/oO+q5lU/TtzsGMMRQIiGnJRl95CJd1Yh9d+sMufpfYSxlis+T3dfjkVfdeUf5jBGBlr/dxTu2FHHVXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IBEw9ZqA; arc=fail smtp.client-ip=52.101.193.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IBEw9ZqA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzftqxOh7OZ6QVzMSSTObsyp3vRhSNgRG95D2bzyR1MFavDY40/s/i7yPg5zjJONhUvRCI/mq/Gi8QkG1OVmesnXwZrhI2NDU71DhwiWfK0U5G8ZdKWP+VHlXKWNc3le2Wo0T6fsb2v3ts62N5WO+mVI2sciVVLOxn8WJHZvxsFgZrlIHSuSJ5sxCf32rw2SDaXJCtfUNYZjsLqpO8yCa4aARsFLoOAV7I7ApZUbzgnlzy47c0R5krls5v8rcpKhP+WPSW08CtecOdiDI4v7c/aCORzI6Kzf/GyHt78RPCYigMt866hOme9bEJwkaBTMFCPRVaZ8dYMZdUjN4bDHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UbjuMBLhEjF/nyRqWu5kM0yRAUEnWtA0eYquV6bLQ4=;
 b=xAjyG0vX5iLHY5m3+sam2eB/JxWAPh6P51bfUq3Ohp3kJw2jQCGBAKlp7TPRHG2IQx3WC+JxA9IVkHuMZf+txD9tCshO10VPwNiNGZfXoJJsAd/lHApTI6GneOWcNhPkInp4j/MetJYnWEf9BEv242JcJULpDM4zUi0SwbeZOQeMfOgGqjwSVjqATHFFvWy/flRKWuJRCJlO4HgIq5y+N8JP7DzHXsldCMyW/uxsxZiiNHeIeQDrQKiyYEI98U+qglcORkVaAhaOofiYVTltsJ2+gOrWj/GWs/7ZAMvIh3MFRdR8/OmEyGoolEH4FhJEsFOJXonKqoOV7ZgFUvlcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UbjuMBLhEjF/nyRqWu5kM0yRAUEnWtA0eYquV6bLQ4=;
 b=IBEw9ZqAWZCeZB+Zk7X4Sp47nCsRDqLQ0fNYYgH6bZ7m8FDM+zJBFuMwc1d8VXutxM8JcIESLGoaA62HnY1RKJMjQDDWkKQRNtedjJG40He00cW5JtgBRUXYK7xH9lAkW1Kj3pjimedETUp2YwY6fnNEXAG3UQs6AeJKGrDUiQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:45:12 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 13:45:12 +0000
Message-ID: <4d5e3cff-03a5-45f0-8fa8-a6c99e82cdf6@amd.com>
Date: Mon, 21 Sep 2026 08:45:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] pinctrl-amd: Don't clear S4 wake bits at probe
 causes power off to reboot AMD Ryzen laptop
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, Olzhas
 <marat.olzhasss@gmail.com>, linusw@kernel.org
Cc: linux-gpio@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, sashal@kernel.org
References: <CANzgjV0YWUX6=ZGTbn4KEKqQmVhsZTsDPeRf0Nfq=YFT1eoPzA@mail.gmail.com>
 <de1b64ff-ee8c-4b76-aae8-ca29628b2db1@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <de1b64ff-ee8c-4b76-aae8-ca29628b2db1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:806:f3::7) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e11bae-ad2e-4072-6b55-08df17e68eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	GgEDS68fNTcXr20DJyndl3Roic/OrGuEyoQni3FOAzh+SRWARBuhYgatn6oHXqQep17cr/fkl+hNRcttSJ62tSYOII/z1tuVxjE0713tfDmP7IbhfSX9Ct/8jwD9PfjUBMQVkL/pcihEqSHF5JrbnTMZYIBiZ+sGjpv+Fl2suytWV2Cbh98skp3xggZ9e4YBhI3WYwY8qL1uxyZIle5SNhpGANcgFDObQH9eUQ8QMtPmU93vZv4UyoPLILlNypYthfGld5Ou00bEXzj435U7EtYAC/OjijWteptwJEaA/LrYcIEjzc4e0hXpmxVBeDcjOQvtWtcxMBSS5uLfgjXDihE1akmho1F+CMMdfvj/GaK36uPmgq649ilAzEhy4C3aBDk79E9f4FoW60t+VixSEboWrV8f6+GPLfQqOab9uZyeNzwClsKokPCyenZFHZv7y1VghkMqzs5HLMp72fMDLtS1c3Bd+wDB7hSGIRnBNwZaB5OCY+VrQaT3dbSjM+xxJ+8PCv8Owz5sKcIs3R13f1QNk9UO5S6fAxcAYTBPKrtB4aTsV9yuCMykGXChRC0GnqABKT9rgELU6DLIayaPpoxfvZ2QgNh+Pizos+6Mx1ZUfMnLhel2GMWPHHj3W6Cz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlgydCtMT1pqeGFKYjlZQ3kvSzE2bmZoUUQ2Nmd0b2ZpQ0RBVzQ0NmxTS1Jw?=
 =?utf-8?B?UHVZYWlEOGFieE92cUpUNTZ0UWdrdHd6VllJZUQ4L3ZxVG0rZGptS0p5QjNP?=
 =?utf-8?B?ZW5XMTdidkpUaFZFek1Vbm54aVlEMEUybms5WnAvbTQ3QTN5eGRnZzFMMFMv?=
 =?utf-8?B?RTVJaWhFUG05NGdmV0swYlBOU2NEYmtKeTRGZVNZVHRWMEJ5ZkhPekowRU9t?=
 =?utf-8?B?VGNtc3lWbVd0Tmcxc2ZhVVVab1g2d1lzNXhkT2NoSnVOckEyejVCTnV4bktw?=
 =?utf-8?B?azZiRmlrQ29iNzVBYmViajZiVUF5VmVjZ2VSOTQxdDJJYTdkTUZVbkdsQW11?=
 =?utf-8?B?UkVWWVFhZ2I5WkxEQlpqQ3h6aGxFdHZMNjRWUUhZenIrV285bnhWRWVDL1E5?=
 =?utf-8?B?ZXlxaGJTcVZiaVlRbExzWGdCUFE0Qm5zdVJORzdQTkc1TUNWdnByYm4vTWpY?=
 =?utf-8?B?aXFpeGlBVmZOdURFVGlodDgxcml2SFlwWDJJT2tpRDJTUFVRQjJxMFdta3dY?=
 =?utf-8?B?dWlNUnh1cnpjeWErMHdYODVxdmdjUzNBRHhzSEpaUnR4cFJOZ2tSR2dPSEs3?=
 =?utf-8?B?ZXUreDlmZDBNRUsrNFA4ekxqU3JXUkxubFFBUytCRUdvMitQWndoVis0S2Rm?=
 =?utf-8?B?YWFGK294NHpmamI0aU95SVZhVXkxQ2krWks5Q1YxSS9zengrbElFUUg5ekE1?=
 =?utf-8?B?TEVhRVluRHR2WjNmblZISWZJTWZFV01qUENLQ0tYVHUyaHh1VWpYRTNKbW9G?=
 =?utf-8?B?Ly9tZTlBeW9JWnZOWnV6L2VtclBOa2E3Nm53RFpvbkVGMHVwTzl1OWp1Nkpr?=
 =?utf-8?B?bFA2VElORXdHL1FHK3U1czhzOU50TVVNc2xOMDBvM0pGbGlRR2NOeGIxSDFS?=
 =?utf-8?B?T2FQT2Vpb2RocEFlcWNRSWhqRlBPbSs5SDVkTGgxdi9ieTBpa05hTUo1NWhT?=
 =?utf-8?B?TlF0MFVkYVllb3RiNGlDUW1hWWI1cERidktXRFRacnhOWGdoZHE4ZFAwckxH?=
 =?utf-8?B?YUNrYzNEN2ZxdWVPTFJSZmxPK3ZyZE81UllIYkNQelUyT21lY2tXd2VsUDlN?=
 =?utf-8?B?ZXdJWjZQSW9YY2I2STJpTndwR0hMaTk3S2lmL2NtSkFucVRuSWRtS2pleFdH?=
 =?utf-8?B?dWNnWmhCVmw4QjRIVXUxUU1oNDF2THZKeUNIeGo3TW5DL0UwejRSSjd0SVZo?=
 =?utf-8?B?cWJjaVdLYml5SUJFT0tpTzRuKytMUVVzUjdLc2FCYThPUkhUdHpIRFRRTmpR?=
 =?utf-8?B?eC9lWm5qRGF2UzBwK3lBQytVWERBa3dwT0w1ZkFDWi9oODkyZm9QcmExQndZ?=
 =?utf-8?B?MWRmRytPREliY0FiNmZ4ZTI5d1JmSmdIemJHZlZEYUI2UnBEQ2Y2aHlMcWgw?=
 =?utf-8?B?QU5mMFJhTDZQU0VCMkQ1dENxSVpXbXFNY2FWdlJHbXU0SGFvcktWUlRLUUpX?=
 =?utf-8?B?RXFjeitZNGdqSHZHcnhYYjd0RFBWaTNQQjNQRHA1WGwzRUd3ejFyNVlHM0Ix?=
 =?utf-8?B?N1M2cndaSDVwOTJreEhPYXlyaXFBTW8vMGJHb1Z2bW42a1FWMjNPTTdBVGdH?=
 =?utf-8?B?ZktvYm5ycy90d01sbWsya0g1eitVNFBlQS8wdloxamFRdWFWTkg4THl5cDdO?=
 =?utf-8?B?V0Q0aDcrYXBybnZ1N2krVTZraEVXNWR6YU16bjNKWTA2elgvV01ZWGFlUE5k?=
 =?utf-8?B?VXhzNENaVjRVSlRZYTNqd20rR2NQL0hsNFBHRnc3K3hnKzAxNHJQQ1VHZmRn?=
 =?utf-8?B?M1pwYXVSV1JJTFlCNmpBRFJvWjRrbkJSR0JIb2VoM05pWHJCTWgvR2FNWC8y?=
 =?utf-8?B?VkpnLytvVURhYnNyUVUzNmlrT0dxNC92d0dOUEQ2dERrNndvRzNMdnpOVFlp?=
 =?utf-8?B?QUFlNi9oaHV3K2JJR2U4OFk2NjNqZkhtS0Y2WXBkMzdkYVV0emZkNitpVDBp?=
 =?utf-8?B?REM5L3JwclZXakhTRWJnZ081blZldmdWQVl3Qm5nYzRxUnZIZ0RTQlhMZmp0?=
 =?utf-8?B?b2d6L01HdEpXaG1lZmdoWFltbUJ5UmRMaFFhMURPRUcvbmNWOVBXRUVZNGhZ?=
 =?utf-8?B?OVdacmhoOXc2dGp5MCtrVWEvRitGdU1Bd1N3anhjNlovdjNsS2hnMmZSTWZD?=
 =?utf-8?B?R29nTDZ6T1NXQWlZbGlNWGJRU2VvMG5HMGxGb3dNZ2FibkpNbjF4K3VicDVX?=
 =?utf-8?B?bVM0ekYwOC80VFF6QURFUERXaVVHcjhSK254cU4ra3hETGRVK1hVMlZHcEpN?=
 =?utf-8?B?cjdPeUREaVkvNFc5Z0p1V1ExbXF6RXdlQm5tVEdocjdUVUZOL1J5WTh6UWVw?=
 =?utf-8?Q?B+SLQIZDNw4hmSxGna?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e11bae-ad2e-4072-6b55-08df17e68eeb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:45:12.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5fzJ8VpBVKIJdhEsmm8s5YIya7xpVyNv5H+G67ai3VU5BwFcdFRbbsFhIv1C2wqSI+CMbdpjCjlSJBcrgkN5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581



On 9/20/26 12:05, Mario Limonciello wrote:
> 
> 
> On 9/20/26 12:00 PM, Olzhas wrote:
>> Hi Mario,
>>
>> I am experiencing a regression on my laptop where attempting to power
>> off the machine results in an immediate reboot instead of a shutdown.
>>
>> The last known good kernel is v7.1.7, while v7.1.8 is the first known
>> bad release.
>>
>> I bisected the regression across 9 kernel builds and identified the
>> following commit as the first bad commit:
>>
>> a7c855969b1a ("pinctrl-amd: Don't clear S4 wake bits at probe")
>>
>> With this commit present, running:
>>
>>      systemctl poweroff
>>
>> causes the laptop to power off and then immediately power back on.
>>
>> I reverted this specific commit on top of v7.3.0-rc3 and the issue is
>> completely resolved. The laptop now powers off correctly and remains
>> off.
>>
>> Hardware:
>> - Laptop: Chuwi CoreBook Plus 16
>> - DMI board vendor: Default string
>> - DMI board name: Default string
>> - DMI BIOS version: AB8139_S_2C_V00.01_007
>> - DMI BIOS date: 2025-08-05
>> - CPU reported by the system: AMD Ryzen 5 7430U with Radeon Graphics
>> - The CPU/hardware appears to correspond to Ryzen 5 5500U / Lucienne
>>    silicon, although I am not certain whether this is relevant.
>>
>> Software:
>> - Distribution: Arch Linux
>> - Last known good: v7.1.7
>> - First known bad: v7.1.8
>> - Current test kernel: v7.3.0-rc3 with a7c855969b1a reverted
>>
>> I have verified the fix by booting the reverted kernel and testing
>> poweroff successfully.
>>
>> Since the DMI board strings are generic ("Default string"), I would be
>> happy to provide an ACPI dump, dmesg output, kernel configuration,
>> bisect log, or perform additional testing if needed.
>>
>> I suspect this may be related to an S4 wake source left enabled by the
>> firmware, but I have not identified the exact wake source yet.
>>
>> Best regards,
>> Olzhas Marat
>>
>> #regzbot introduced: a7c855969b1a
>>
> 
> This is most likely a BIOS bug, but we need to dig into the details to 
> understand more and decide what to do.  It could also be a driver bug, 
> most likely in a WLAN driver.
> 
> Can you please open a kernel bugzilla with the following information:
> 
> 1) /sys/kernel/debug/gpio without the commit
> 2) /sys/kernel/debug/gpio with the commit
> 3) acpidump (just once)
> 4) amd-s2idle report (this will capture and associate some information 
> that will make this easier to triage)
> 
> Please CC me into the bug report.
> 
> Thanks

FYI for others, a bug report is opened here:

https://bugzilla.kernel.org/show_bug.cgi?id=222041

We are working on narrowing down which GPIO is causing problems for this 
machine and then will decide what to do.
