Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4E483821;
	Tue,  1 Sep 2026 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281678; cv=fail; b=oWBqLwGQaTfC9ptdl4C6pKBlXEGEXq2Zhf1M1Bt8unl8aojnzYL7efajP5FT4moOL1zj+QtGXyAic7l04z48V3eZSZ72+JcCyUoFz6JqhKO+4Jj5DbZkKcvTpg6dsmFJsw7/VKMnqSuIOR66tVkG8BL6lcXpToNnhHSbh86m9m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281678; c=relaxed/simple;
	bh=nFMFVI4CpOBO1em+PC7cTi6/TZdtFfAmmsZPtvBXXF0=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=kqhRWrE1woaNkltx+sk0oGy6X9uPWQSi/BngkISMGlAHHpmpycNxsEgWe2Jx9Ol6bZkRxc57EMitjDHZENgcFqqvfDnhL2K0mzj7vik6vQiTNk6Ot99nbMXZtxPeXmUNpL0abjDahVSE6xxFRGLl2bK8tyqRvS+sJMeejSrSzms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E9wIPqq8; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E9wIPqq8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rz+xJDzU7/QY83aB1SqNxzODroHV4wCViuEt8hIk+9c/b+DCZe8gPdS+uWz9mmHEgyU6ul5shJw5SY64F7AQc3lGz7n2p6gyqj98voiOUNIZqqi7UZzq6+Wu8VhiW6q+hA5ol47Y8Cl3UEOghEuRdXZ5Jf2WYfsFAqUoKqHbfQaDHC9OX58k0BMIGwY0xK5QW7oLIDuzDAq7OJgec/ept0tnUuUX7vgYgtKuVq863TXLIKxulFNgVGp4YrPj+f8mfTdTDKmlfJ5YfLZIyPOwQLm3fCsu5y+IXcUi0g9cBcTzGSCyDsbVVINyLID7u0Ydav4pr52LQUBWAFhmnCJ9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxVNJ5MXzBvHvjEF9yu8dUbwdrsKV7cguGNSgn3rR3s=;
 b=et8UV7IcXOxUo67RQFAL7UHivvxMU0fiO1v2J9xbfF4+udIpbBPlk7qn4lG29fWdmMUPDoQl7Gd0XNMcbwJP2NUwZFNSrPWxJPtjw9I+CJDsXen85aah/rMwDbCZ+OJop2G0R4Cv9uYd2tkNqadWl78dJsq7QTCCyyIv3pxXYYXSgnyIH8OyphHiBBnm7o965JShyVwX4myHUjgch3FC/lyLW+GiWuuYk3SSw2/HwONIhcIbrZ2fufRr2xETd4jpEggYTOgDuxylEtbt7jx0bIv56MtP5H/xRELHw1QwRZPvURBUoDZMF1OQd+MR5P+fk/KlnPwnFyIXCUGnEOD8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxVNJ5MXzBvHvjEF9yu8dUbwdrsKV7cguGNSgn3rR3s=;
 b=E9wIPqq8b2TRMphM2pnyQDuofSTHEcPAQ5++V2wXj6l56ffq9GucroKtyRY308rB8Dj60xYyUf3JY0nsfBympNT3HEbWAZUBIACIsEMn7kxBNZyaVDEI3Y1Af7//NUSF5Eo8ZmlvYHjsqhzrZ4SoAY/ppBko4o++qNDy1WK/hzdeuMuoWaxh88rtyJNKEyg5qsvqV4gzfuSW6NR6rmYmX8PDPV7dnZx31lbe/KrhlAO9+agnS3yzL7HqR8by+Z4wjrjCIHsU6pB9B8TPZB18PiExeFMzwWHv0nDqXA5K4DVlXw3sh9rMqolfBQmNEsDLg3nvyVD7XgOfUVKVtFOEuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:54:31 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:54:31 +0000
Message-ID: <cabc530b-3504-4243-86f9-19c57ceae514@nvidia.com>
Date: Tue, 1 Sep 2026 17:54:27 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, linux-stable <stable@vger.kernel.org>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "Sheetal ." <sheetal@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Subject: stable request: 7.2.y: Fix audio support for 64-bit Tegra devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To DM4PR12MB6063.namprd12.prod.outlook.com
 (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6b6f95-ffdc-44ad-5e63-08df0849b169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wx0GSEpugg0Sek2nGgQLqJ6CDOTAuV9Dfoa6IOJkq9Hc7EQUiCMi5gkj0mVoulxnD413VzXBzTeLK5JlsBqayOobjJZIbjuEHL8MkV+Ebyay4zlmDTuXTWWp/PJN1muRkECx9iWao6s9PmeGGFIeNKbd9vJZxlrBV6f4yJdTifWFN96dx9nTRyLBZ3buf5vtTKr14WJJAjjX4Kux2lQAsL4bDdUGaRn8a9YjwYel9oKd4dDt2am/RO8z1CrMx0QKtBMYOE6yy8OfoeQkIhe1kgDsaVQt8mZW6sMw7V7uUURB1qgp8cNzI843AwBcxWfQFCMVxqRz74D6A5Y5EaQtc50cFyQ77gJ6V6FvPLFDHt8iYX8IBZYp8dZpbBJ/A8P7GiXgNTvhEPZ9z/Q8tuESyzBaJhviN9d39VsQPgfrXSAVMmN+DvWABqcuivvt8IL53ui0fAg3Bw5jorTrnUvamh9TIzpDQJNz6g39GCxT/g1S7oQn10Aqoo53NZWgO7rQLAC3kfDJ++OwKo73B7vGP5NDmPR/g7nSVZeoHR/vPiXOkilb0jfCO1caeltWUBtgBDWpxlhU+0U18NhG/S4ogx3J04rwPfaSizDCsDkOuRlkILamu5RwxoVlqI6y5GDbY2GL0VrHyz/5a09Sy4HyVtwx9k/33/orgg9Xh805emo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0w2WWZGdFJRcTBKZkpwYVdCZFZZOUlYTHBqcENHUWdzNzVhcm5TOS9aWC9Q?=
 =?utf-8?B?OU9lRTRmRVVIaXVIR25JYmNIY3BUWDRobUZidEdHQ2NyMW1BcjN0bjlXMUkr?=
 =?utf-8?B?Tmh5M1hiOTFJdXZFMkozVEgzckVMOEVodENUNWhMZ2NWbFd5bUNsd2lOaWlw?=
 =?utf-8?B?SzFmckNOSWoyT2loQjNBbWhQSXV3S2RoWGZBK2l4K2FpRWJoWkpaUTBtZENo?=
 =?utf-8?B?VkhpcVRyNnBjazNiU012NkQwTk5LaEppSUdhWUVvcXdPT2IxNkpXZ3NGWnFV?=
 =?utf-8?B?TUF2N2ZDSSttRjN5T0FGbks4emh1TkpsNjhpUUQxZENvbHRRdVNNc3ArNGM0?=
 =?utf-8?B?ZDE5WW0xYUsydlpLSlJsWVg2Q0lqZHdIcU93L0dJZGlTMVNFSFR4WjFiYlAx?=
 =?utf-8?B?aHlWSUx1Zzd1MnNSTUlPMHl5YUZRTzNaNnhNQ2laRzB2bVNpNFMrOU1CNzc1?=
 =?utf-8?B?MUN6Y1NiWFZIamdicEdkc3hpWndpUkdRZmIrT2I5cnV0a3EzMHJMMTRaWXph?=
 =?utf-8?B?cWtVdnlKN0dFOE9aa21kOHdIOCt6bjgxNUNRazRMUFBPMitPTC83ZVRLRUYy?=
 =?utf-8?B?U0dPVTRDdGJJT0kwZys4UjVQaDNGNDYyYXNweWZNVWJSWXo0bXFhTDl5TTZI?=
 =?utf-8?B?cllpa21WSU01ZytjL3E4eUs4RTYxN2h2UUNNZXoxRGtmNTFzVUJkbVAwS1lW?=
 =?utf-8?B?WnFReG9ENktkVExkaGl0YTBFVEM2Vlc0RnhNSUZkVnhhUWZLQWZnYzU4THk0?=
 =?utf-8?B?L3BhYTc5ZWlSU3VuaXl3YzNoNjV5MUc3QWtxZFNsc1puM2crZ3dzNEwyN3A0?=
 =?utf-8?B?WGNUNWV0cjY3dWNhU0k2REdBMWZMbk10L1E0RHFHQjNUMDVJTjBmUWNUZGp6?=
 =?utf-8?B?ckNlSTd6R1ljSHNRS0VqbUJqNm1hVmN3VDVObWFOZHBDdkU3NVMyeEVQNitH?=
 =?utf-8?B?ejFuY3lUbnRmRk1GL3g1YVFBNjE0eGFQeFJOQnRpaFVscXNrMi9YOS9UOTdT?=
 =?utf-8?B?aDFHNVlvSWdldFZCcU5xd3pmbm9NbFpMLzJuY3BWcy95eDRudFl4VVpWd3pG?=
 =?utf-8?B?bU1JWWZ5cWN2UFNoWTZ5SzkwQ3FxRGlBVS9yQTFXcWVNd29sMzM2SzR2bkg3?=
 =?utf-8?B?MmZaUCtiOTBZUTRzV1haWmRXS0VjWC9sMElvL1BmNXV6MSs3NlBwN0lYaWlJ?=
 =?utf-8?B?UXdieVJtS2htcXZLcUVvRGhGTTlycWQyRTc5a1ZPK0F6YkdBSXd0eTRGc2to?=
 =?utf-8?B?VThZZmhqUmZudFRKMUZOSDlJdXU0bEh4ZENyUjRDQmRjR2xOTW12YVFxTzg4?=
 =?utf-8?B?WUtqSXhSUmRoZytZeVVaRnAweW1JUkpKeU1NdGNBb3A5TkdQelRBNndBZEc1?=
 =?utf-8?B?M3lMZEFFVmtDSjE3c2Rva2wxVklaSDJNNHBLbTN2YlJEc1FzeTlqMjNRbXI5?=
 =?utf-8?B?NnNQa0FIb0hNT25ZdWVSWkxRbFpxMzMyNGVOVHJvRkZNNnZBZHhyMzUwRG03?=
 =?utf-8?B?WHV3dWd0RkJUblI4VWNRQjVLaThNSHFhR1BQS2RZMzZtTkR2Y1pwdUZZeTls?=
 =?utf-8?B?WmhmNU00NHhBb0UrY1pLMFk0WSt4RlRQcE1ZZlZMUUFweUtqbnFwSS9kWGI1?=
 =?utf-8?B?VC9rVExOeVhsSzFmWkpQSWJKTFNYbW1VMmIvcXhwQk1BbWpRVlJmS3I2M3Vw?=
 =?utf-8?B?OTdrdVRRaVRINThoa2VPV3ptL2hUSmQyM09pVFNpdVUvQmxmdFJrUm1tSlhJ?=
 =?utf-8?B?UmFCTmlBdW1FRUxSR3R3UUw2UGRDUGRlanNNZ1B1cUJjYk5NUENhTFEyL2lr?=
 =?utf-8?B?VFV1eWE2MFp2bFN2V0l3U1kxbzhaTHFHUUw2T1B1cWxBNy8ySFFuelBMMW5W?=
 =?utf-8?B?NmZGZnZtbXZ5b2NCSlp1VmcrZEJtVHIrZFhidENUYU1teHhSVzQrTEgzemlP?=
 =?utf-8?B?cURoNU5nYy9jdmw3UVhzSm5VZ25wbkRxS29vb2gwVlhhRHdaNkRWUm5MeGVM?=
 =?utf-8?B?ZFFVREc3d1FjSC9EMEx5Q3FxQmZyOUVwdnQ2aHpsVXVkQWVrcHg1S25zeU5E?=
 =?utf-8?B?N3dXQWJnRmJqYkVWaTJhMUVwbTZwWDhXWUpGVGM4ODhZUHdoR0ZXbGZyM21D?=
 =?utf-8?B?eVJOUlZBM2d2RGJ2ZWdtemhuWDF0MHIycHV6QnJSMm5CZ1BkSW43WHE4eTBZ?=
 =?utf-8?B?ZndkUmlYeGlIVHhUd2dQUEtuR2hycnNvVlljOEY1VndLWTNHclB0Y3U2VWhQ?=
 =?utf-8?B?ek90V1ZNZTdkbS9FTzdnb0VuT3ZUZ2NRV0V3OTFxUmFYMzUvWHZldUZkb1hY?=
 =?utf-8?B?TnJLbzRaTVJlK3d4YWpma2E1NDd6U3dNNEZrUEVNbVYxM1BlQXFDQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6b6f95-ffdc-44ad-5e63-08df0849b169
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:54:31.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wpmZlqAlEoYSKzzsJmO4bDG3F0vy4wT68/iDGvwwINbL8iIrX2rzgx/L8IVgmrDzhNA0vVBo4h++4SZXV8cWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309

Hi Greg, Sasha,

Audio support for 64-bit Tegra devices is currently broken
for Linux v7.2 after commit 4b05ccb17f92 ("regcache: Sort
the local copy of an unsorted reg_defaults array") landed
exposing a bug in the Tegra audio drivers.

This has now been fixed by the following mainline commits
and I would like to include these in the linux-7.2.y branch
if possible.

597273563d90 ASoC: tegra210_i2s: sort the register default table
82da8df38800 ASoC: tegra210_i2s: sort the Tegra264 register default table
f70bc276fc7f ASoC: tegra210_mixer: sort the register default table
53dd1c1de851 ASoC: tegra: Fix the I2S enable default value
5442b8093a2f ASoC: tegra: Fix the MIXER enable default value
18d48bfd1bc1 ASoC: tegra: Sort ADMAIF register defaults
abb5bed6f48d ASoC: tegra: Sort MBDRC register defaults

Thanks
Jon

-- 
nvpublic

