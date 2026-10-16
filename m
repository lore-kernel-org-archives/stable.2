Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6447B43E;
	Fri, 16 Oct 2026 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143191; cv=fail; b=nsuu5cPJGBkfx1GGgMy/mG+mxBqCV0flzHYOEjd+U/HKXHLpuI5TTJtpaCLZLR5gBxEV0hlU5dh/7LhY2rUKq2c5Uve8KXLsG/tFvF5DEA0DxMifQ4A439YSLJfwA9gXEzxMmZHsi+aLuXMtm0YvOXgSyObd0Eo4VXIHd9WhYs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143191; c=relaxed/simple;
	bh=RWPyM3Feww7RarP51o+US/tsaegUN3F3AZ3PtLRavT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=poFkcN0I9NEDmMPDWhgzqbGQzc2a/q3yZtzrx1Ooob8kx6FUGaselw63UWlyjdtz5EdaKwJa/UJ3K1Jyctl4k0Y2Vz++LAvzWQbPz/R6apVz6mGyeIcu4LYshDnRn4ykDlGpwEufWVGhZV0FC0VqGEdQlrwsQmDivc/+NVBPc5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jXcBkaJA; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jXcBkaJA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY2vXlEpJayPK+3k2SXhrPfz4qseVMDV6LLLsJvb9WVPI5YMpEsXSWsuL59P0vKeBOyCTAFQb88Zh5TrVaia9YGgxvwTnxSxZ64Wmzs2bfj5mnzbfIv/s+oj8lREILGrW8JnhvF7RssrMV/GHse9KS7JGbDzrDDbxEa5mVb0PAu+iFiRcZ2PfYNuLGOLa98MxRX1Fc14sOdu+7r85V/NZOlct3Fdn8u13OQ9Iw1/aghuMMJHklA1E7wzXJPiDilBqdetuv+gzmS2IRgCwTKG7soUA5ETtJi6XBNim8V2q5TENrLqmwEzAAIoKAMAbcfbrXo0BEOZJINtV1ba2Zj+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsgVIhuWgOShB2gYu5OrHHCePfMJwOc3BenR4fvc9Og=;
 b=PnZThv2zgmJKqq+F2702u/d1Y1nUXJxXbaYye/nHnIBb6/HWXeDBj04m/vGx6KVo55eR3lHLssWx/D0gyXXRPcW6rJx/r3liU3pihN3Agi88sAhZWxEKKc6kxqToPMhKaS5FPXMoE5kcYIwOB4xCIpfWwgL3pVO2jHFAI1WfXMeh0pOrD6n+5IFF09IxMb6aCga6Oa2/NVDA5ZHbkMJ92eff991RVUuWL9H953Bpuw4B5yHYNqRBUtMp69SGbnsH9RYRsZRacbe1rve0+Jx5bKYPV+t3QX/0yhwaj41EIa6VTiagTkvir/JHH118VVURLuCfjvzmnH2Nk1GEEuxjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsgVIhuWgOShB2gYu5OrHHCePfMJwOc3BenR4fvc9Og=;
 b=jXcBkaJAwqP4thgK306uVf2P7xfZeRW/jJycIshPerb2KCACFhgZY4HhT7BxxsanOOEEuSSkmSQI26rIucZG6QkOFUqHl0WBi+PMNZTM2YudxPUYtYZ/bPIlWWPNLkU/PDqzVuDkGdHV3mVbau1MrDUL3rBaaRj1sm78oQBLKN0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Fri, 16 Oct 2026 09:33:05 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:33:05 +0000
Message-ID: <bde2e986-56cd-4d07-8b7d-feb64bdf59d2@amd.com>
Date: Fri, 16 Oct 2026 15:02:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: acp-config: force SoundWire probe on Dell 14S
 DS14265
To: art.home@gmail.com, Venkata Prasad Potturu
 <venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com, stable@vger.kernel.org
References: <20261016-dell-14s-acp-v1-1-89b40d95720c@gmail.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261016-dell-14s-acp-v1-1-89b40d95720c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|DM4PR12MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1811d481-a070-4f43-4d7f-08df2b687ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|261009223027099003|11063799006|18002099003|10067099003|6133799003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	GLkVp1LCVIOzUUfJamBNFJcnyLN7S+sMrEWH9Ea6lMtLIGJlcFTxIK3wU3oa006aabU8wvVv5wMSeTiZ4x61V0g9gvdWXaZ0T/d4ZTtfR7bmyBTQ+zDCkRE+skO666J2/0NEcnC3Fd74pIKxE+bKOAx32fjf2qqc4LuCkuCqo9fhaPeS20eppdZSEUirw6jRJ5bsCB/FyYfwiTKXOMFDv1MkSjvZx4VD5DYCpvnKc90h6kk2X8KemWqMP46tAbAnLra1avO7i1XHnWrryZ87q2cav+1ycRFNjBxEn/pY+x5wf1vblpsW6qpnjU0SP0hIYJSiBXk8LWwZnUL+pD4Ab34aE0BVLFY/zsGQf3Jr6dXsS8D+hUTYgp8mJ9uFh9QntXR2zuI3a5ptTWjUpZbZHHiDSTrmQWtaVOdNAi0JDmyes3e2HtVCmUiLaeij/AVgwxnHatfZNK9rMM3o4p4/BuV+pyS49ro4yRNW4SiEocWIoKvRFoMomEj9mXO1/47iaIcVTf61qtzo03/PN7JDZRj+SZ7n33VxA9JixfNlQGI+H+Be487klzERkk2c21XNvbK8QfVaXiVZEx9fI8g2nae5sTXu/rPYCNJt63pUglrPalOjgYb1Dw16rFNoTt9ZmVaOCF0aVx1AmsPCSoouEOotyHQscGst66YomV4DXoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(261009223027099003)(11063799006)(18002099003)(10067099003)(6133799003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2h2QjVrQjY4ME4xNVg0SWdVdHRpeUNudHp3TFYxdGovVWtrcXhOZUxadkh2?=
 =?utf-8?B?Sy92aXFyQndmMzA0NEJTa1ZTQjlWM3I1eE9YWUpSWDdGc2RXQnMxQjI2RG1S?=
 =?utf-8?B?cmdQRHpaSlJFT25wUXgyM0lpL0x0MzlTZDZOZm9KS1lvM202UHJqbFBZS0o2?=
 =?utf-8?B?S2JVV3NvbzRHczJFY3gvWENWaEJYV1dkYmE0cVRhOGFmNGdYSm9KL25UZEoy?=
 =?utf-8?B?eWJFcVZ0dDhxVDJhYnZpMWFxZTloSUpuZG1uSytmcFRWMExlNXoxOU9qTWxm?=
 =?utf-8?B?Mk5SdmNTc3lPR2JWR0tJTzN6akQ2TUdvYmdYSllFQkdYWkF4YmJSSkRvc1Vw?=
 =?utf-8?B?aFFJRHJiUlI4SnloRFN0TzllclBXelhwSHRJV0pkTU5zOUh4Sm4vMjVGOHFD?=
 =?utf-8?B?TWdDaGVRdXNYRDY3ZzV4QkxDQlhJRWN5MG9lWWpaOHZ3VEhEeFErdWg2L3ZK?=
 =?utf-8?B?WFJKU1hON1Vqb0Fob1FvTklXUEdMUlZuWlhpcDZGTTd0YnFHMXhvQ3hhOUNL?=
 =?utf-8?B?aTRscU5PdGQ0WWg0eTRSVlpGN1NIM1F4RkVLbWNsUStyeFdhajNzQURGWnNT?=
 =?utf-8?B?VEo0Qk5zbjNSZ2NwNURCbWczQWJldTVtN2tSRVNsdW54MGgrVmVGZlJ1ZHVV?=
 =?utf-8?B?M002SHQ5a0RJbzFTT0l0ZmgveGdDZmNKR2s5QVl5NzJpNnRxTGVKc3pXZmdh?=
 =?utf-8?B?TXhvS0VCODU0a2MyRVVBdW1zZFZpRTZVc0swNDNBdk9kVEI1TGhhMVlJbURz?=
 =?utf-8?B?RFMydEZvTW51dUtzRjlSLzhTdkpPY3pDV3pVR2puL1ZTWmZBOUxrSkt3YlZG?=
 =?utf-8?B?SWlqdVNuVFlUYUlGcW1LYldKV0dsdXdjS2JXc3V4bVU4YmQ2TlNSdEY2QVpw?=
 =?utf-8?B?RFlxRVNPaFZUR0t3WllVVWdoTlBIajg5LzJnWFFndjlrQ3VNQ0FCZWR5c01K?=
 =?utf-8?B?QUlMMGpualNZUnpjSXF5WXZwalpEdDdiT25BQUIwckRvSlhKRkpnSTA2TTdJ?=
 =?utf-8?B?Wm1SOW5kQmxNT1VMY0k5b0RKYXAvZkFZOG0rb1VSQ1ZPVXE0TDBiYk9yNUwr?=
 =?utf-8?B?VTZwdThOdDJSL0RrNDRubUV4ZGs5d0xnQjUvelJIOHdOanZ3L0VMVGg4NzhM?=
 =?utf-8?B?VndOc2RVQ2xmS0QzTlZjcFFZVGhHL2ZiZDRBYlpXSUZuNlZjSm8yNkV1UlJq?=
 =?utf-8?B?RERqUXZxMTJSMFpNb3ZOdk5HMTk0VFA5S3p3b3cyOVFIYVcyMVNsMG1OT2VM?=
 =?utf-8?B?dFhNZWhGYW1INUNXSThkZDBYNmQvRnR2UWtlUUpvaXlOaHFaZkhTNUJFenpn?=
 =?utf-8?B?M1A1TmRlb2pwU3VNNE1zNVBaa0RaTUIrL21NNTltS0l3bkY3OWZMT3NsV2Zr?=
 =?utf-8?B?QmRnRkJvMHEvaXJkaFNLdjZ2OTdLdGo2WGZTK0ZWOE4vdzdkR1RrRmtHc29y?=
 =?utf-8?B?OGQ3cXVKTHlEMTNuU3U0cHpBbjhPcEl0Yzl1eDVaL3FtTTNBVzlvelJqV1p5?=
 =?utf-8?B?TC9nbDlSZFZNZUFpdWhEc0IwU3plWGRFRm1zeU1uaVhodHNFR0tYdHFUbEI3?=
 =?utf-8?B?OVNIVFFQaXdWVHJoc1pGY2libTl4eXdXY0JjZHhpUXg1Miszb2UrNEdhejhD?=
 =?utf-8?B?WmFyMEwycWs5K0NtNVJGbUJIVWVSMXdHWW1YSGZVVHprZ21ZMkJlbks0ZkNE?=
 =?utf-8?B?eSsvcDR0YmhBWW5GZW1WSFB1L2V3Yi9SdW5PdWEyKzFGdlpXQjRJd05nUnJV?=
 =?utf-8?B?d2JEZXNrTitkNUJ4QitkaFhQVkJzdGZZV2l4NFkwVWxjMTZnUUx3Sjc0Wndk?=
 =?utf-8?B?SVB6L2NaOWdmNy9TK2VJVFI2aDY4SlJNOFdBV0NDRWpXZzZZeWtNcEl0K3lJ?=
 =?utf-8?B?SDRWT2FHRHJmeTIwSTVCZUlKTnQwekEvSmd2ZTltK2ZwOHJrQmNHWURGbHlU?=
 =?utf-8?B?SC8zaE9jK2x3NklNS0JlMmEvZ0dKSitkcWdURTVaNjhmSjR1TjhXTEVUOTlk?=
 =?utf-8?B?M2puQy9OUktBMmRhanhwZUZ6ZEVMYVM4S0hmWFJRc2h5ZU1aMzVMMDNWYkJQ?=
 =?utf-8?B?Um1XT2FiZG0wdmErZ2NvSWF0YnpYa2pKWHFEN0RiZkJhV3cwUlE4QndjcUd6?=
 =?utf-8?B?UWlnY1U3Z2tjS0l0dFNtdVNYbXJiVHRTRlh0dUZqQU9FZFI1dmwrSUl2Vkdv?=
 =?utf-8?B?KytzSkxWeXVocHZzY29xYStHMkIwRUJuZGhhcDF0bFNRaFA1L2E2NHlFTnBF?=
 =?utf-8?B?M3ZFR2ZiZVVRNksrYUlNUzE4R2pnMmJiYUNibXZSMjlZbDU2QjhKUzNQdERh?=
 =?utf-8?B?M0pqd0hlWnRNUnp2VFh5Y0dzakYraGYydThlUEI2ZjBEdDI4TlZpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1811d481-a070-4f43-4d7f-08df2b687ad6
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:33:05.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSk7xypYGeJLVdfXoD8AwWb7ccSMYzMujpeF8Ok6dGFwIn3keKcnAS2FJlnb+ao/U6Ijo/N8y/AZa06yqcz9Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352



On 10/16/26 14:59, Art O Cathain via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+art.home.gmail.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Art O Cathain <art.home@gmail.com>
>
> The BIOS on the Dell 14S DS14265 (ACP PCI revision 0x72) reports
> acp-audio-config-flag = FLAG_AMD_LEGACY_ONLY_DMIC. As a result
> snd_pci_ps returns early and the SoundWire links are never scanned,
> while the legacy snd_acp_pci driver probes the device, finds no
> matching machine driver ("No matching ASoC machine driver found") and
> no internal sound card is created. The CS42L45 headset codec on link 0
> and the two CS35L63 speaker amplifiers on link 1 never enumerate.
>
> Add a DMI entry for the model to the ACP70 ACPI flag override table so
> the firmware-provided flag is overridden and snd_pci_ps probes instead.
> Match on the product name rather than the board name, as the same
> symptom has been reported on several boards of this model (09PVND,
> 0M0J65, 0C7F12).
>
> Tested on a DS14265 (board 09PVND, BIOS 1.5.3) with Debian's 7.2.6
> kernel, with and without this entry. With it, snd_pci_ps binds, both
> SoundWire links come up, the CS42L45 and both CS35L63 enumerate, the
> existing CS42L45 + 2x CS35L63 machine entry matches, the amplifiers
> load their firmware and calibration, and the amd-soundwire card plays
> through both the internal speakers and the headphone jack. Also
> build-tested on asoc-next with W=1.
>
> Developed with AI assistance. Claude read the ACP driver source,
> identified the BIOS flag as the cause and the override table as the
> fix, wrote the DMI entry and the out-of-tree test module, and drafted
> this changelog. All hardware testing was done by the submitter, who
> has reviewed the change, understands it and takes responsibility for
> it.
>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Art O Cathain <art.home@gmail.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/acp-config.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
> index 30e01bc47ee0c2b28f369358cd3ea18897ff0c5c..2fb9789cac0ace8365b2c98c21f2ef1a18b6093f 100644
> --- a/sound/soc/amd/acp-config.c
> +++ b/sound/soc/amd/acp-config.c
> @@ -98,6 +98,13 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
>                          DMI_MATCH(DMI_BOARD_NAME, "8EA2"),
>                  },
>          },
> +       {
> +               /* Dell 14S DS14265 */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Dell 14S DS14265"),
> +               },
> +       },
>          {}
>   };
>
>
> ---
> base-commit: 0f8bc3b93b76d16682a4d4999f9559b1e18016f9
> change-id: 20261016-dell-14s-acp-6628310dd359
>
> Best regards,
> --
> Art O Cathain <art.home@gmail.com>

