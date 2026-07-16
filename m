Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010020.outbound.protection.outlook.com [52.103.23.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C23D331D;
	Thu, 16 Jul 2026 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215721; cv=fail; b=XoozttP07cFg9gj0i801ND5osIFHg7yql3pgmDnH03rD7VQlLMITLOE7+Ihq/9gWyaeE1cdBqBThqO4G6Ar/FRyBKpAWyzjLAhkWNPMA+sT6Bh++8uNiwMyEkFSGIB04BNldvkTx7Ry5HRDVdDgJg1JmWupupchKeXdwK39JaG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215721; c=relaxed/simple;
	bh=huBsLkNONK+a7fDHWWTZHhYd40C6uB/0/Y+hNkv8FHs=;
	h=From:Date:Message-ID:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IwJVS7aYpbeijvlS5bDfqwWJq0khTqxNWizTW78j2BAEALRc1CCxbOwjl8EuhglfKsDRWYOBZTrHJhnxJdm0ZRlW4p8m7nJYIAKfUh3PdHJE/N1KwfHD5XS20EasJQCc7WdvFqreQqdpgNwHBEz1vRdlvUz/KnjHTXKZ3NxAlmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p4b51ABi; arc=fail smtp.client-ip=52.103.23.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p4b51ABi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt0Re42ChM/gFnUCLjkhs5eyQrst3OqfwMVF2mpyEDH5+IHlaDzgyFDjYvAHzdKgIk9rpFLaGS84+3zf6JerpC3eN3PvQthwxmf/vUkQWEDYpORrKfPmtZ3vEW0U2Og6zDwnbM76kJRKdmSLAxy9A5qzVLMsEJGrUJcC4VVmNVuK8p07TbP+3yVak19VLdXu2lIenCLc2/DEartexm2kaG1/oDO0qjenYW5/Wnfd927zPtU+n+cL2Q27eoJLAzYYvxHFulj60Suff54aJKwOX18PYHaJFbruT4I69HQDNzQFwtny7RQC+Z63MGhQbiDX8OGiFpVu9UC6auPBCyDZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huBsLkNONK+a7fDHWWTZHhYd40C6uB/0/Y+hNkv8FHs=;
 b=aoGsoI3E5oxNDGd0y6br7GErmKPL6gbU2iB3N0tD8a0yK98rnwMXRvRUYgjnWX1wsxEyLvtxLPY6Np0tJlhBN7Dfgdd51a3sPgi8r8spBTs0kDUn1jLrdGCUJlNesC/fQSQfbVrDRZD2n//HxzHJlkJ15qecUsFW9Pe4XlJhTh1LYlWqyAJrB1kfiaLLecXPA3wUqcU4Bd/G2i7+SWYYjuurQt+NbnuDLGFWrfFyIN77oQll2/RYaSQjnEvtdhRV2YrSu/NnM1CU2NbOCIB3+AJ2v81xREPfq1i7+37l9bXQYv9Afv1IiS+XT/ihEgS7Zsif5Qz/ewZHsNv9213oAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huBsLkNONK+a7fDHWWTZHhYd40C6uB/0/Y+hNkv8FHs=;
 b=p4b51ABirLAPZiKHWx9/z46lcGeSOnqs5SPPrRE8gLyerO2KMSGKb05LyIOfzqgZAZoSUUW/fLKQ0RIq8pk8bjkzCd2s1QkpIuloKFd7FEP6gCiz/MRHccY31noS4iJWMobISJws4S61v4XEP3LksasECWTXDzx28KvPF3wZbTmYx7t6A44OtREGSoAefWZTCG5twbDQSs6/F/2k34FQZUtkEWWuxdUUjAOMjZmaBoVCZMbDvCYy56x3+YWMrH0/pwQyqOB0ajiWnOFpQPfZhct63M6yyDBYk1zV8d9PETHUSqSqEO5QP7Ao7ciAs/Bq0FLIIBFV2RhL/EmZouavVQ==
Received: from MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
 by MW3PR19MB4252.namprd19.prod.outlook.com (2603:10b6:303:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Thu, 16 Jul
 2026 15:28:37 +0000
Received: from MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374]) by MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 15:28:37 +0000
From: Liu Changjie <liucj1228@outlook.com>
Date: Thu, 16 Jul 2026 23:24:52 +0800
Message-ID:
 <MN0PR19MB60918BBB814A2859931E45D9ACC72@MN0PR19MB6091.namprd19.prod.outlook.com>
Subject: Re: [PATCH] phy: rockchip: naneng-combphy: Always configure SSC spread direction
To: Alexey Charkov <alchark@flipper.net>
Cc: Vinod Koul <vkoul@kernel.org>,
    Neil Armstrong <neil.armstrong@linaro.org>,
    Heiko Stuebner <heiko@sntech.de>,
    Shawn Lin <shawn.lin@rock-chips.com>,
    linux-phy@lists.infradead.org,
    linux-arm-kernel@lists.infradead.org,
    linux-rockchip@lists.infradead.org,
    linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
In-Reply-To: <20260714-naneng-ssc-fix-v1-1-1c40a58061ae@flipper.net>
References: <20260714-naneng-ssc-fix-v1-1-1c40a58061ae@flipper.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To MN0PR19MB6091.namprd19.prod.outlook.com
 (2603:10b6:208:382::21)
X-Microsoft-Original-Message-ID:
 <692471bb471f40948b9d5173e586a6a0.1784215492097304.tspi3m-alexey-tested-by@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR19MB6091:EE_|MW3PR19MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 917138b1-32da-4066-4364-08dee34ee80d
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6cUe9t9Fs5HiQGsDL5YS4QsOvyTFE7Zf6zu8RitCO4BGgLQstjbeazAJ+WWYZw+0+FTbPc4n4IkwbMcGJEBg8rsQiPDhmANf/ab6bolWBJLiYBZVjbTHJuIJYrKUhByN6GMJ4eMnusqUo6OpnoRYKscXXK+XyhSLzf0BKp8zjXHPd5jCZFOzRR1YxgDXluNvEwBMCErD/JLvqOhCY+/pHYPNJCrRGDIkUvWw6SUdt0wrR5tKc/M0doWBgykGAz2g8GbET7FCJBN07R2FaIelixK5gNRNNjy/H55ponXQ+ji7Xt09/jOgNOWnRCNGrVo6XYd8qQk+xAJ6+khz6haULrI51owb1nUiuiDax08orQ3YHR43G1k5VVT5s7PtRRUelAl4XJ2uLI+bPrQQXGNmnHtjvbKszYAQM0XBnojqZ7XXeMLKAne3S0VMY4hGYXCyPj7zJ3YxjdJmhKfQnESURIdJGR/7/0HJVqgbpROFBMgCqyLgasfUz/NpJqltVkLlIvMLzn5a5EVV5f8Yti9rInOFwMEHFqvt6rWXcDTwoQtReiraIyG2pL/iw6Lu1DcI25teiN547eXfkzPPBOY/zs3tYPl/uJH1usiyOeV66MRWyDcnfgQeDBagTKZV67Rp4XxRsQ8q0qoumni4Ca+tNlYb8dqkaAtqIq+vvH7EBlI8PtK8DVPfPOEgf9YtWdkd756ypL2PtdHxA9bV7FlFRVwTiDf/Cage4Ef2PkHMOIIA/kiBxQppHO0Z8sj1kQAli0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|6090799003|24021099003|19110799012|8060799015|15080799012|5040399003|37011999003|5072599009|51005399006|4140399003|3430499035|40105399003|18061999006|26104999009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEl3bCtMN0lmZEEwUG1UbE02V1E2QjhPR3FoUDdFRnVLemVwakdqa1pkck5h?=
 =?utf-8?B?SXJNR2ZTUXVyUjFzM2xrSERjSS9ubWFRbitSUzJBMytwclNSQUFLZWhVRGJE?=
 =?utf-8?B?bW04VWNHNkVqanBvZXFObGFFWGkyc0U0Vmxwb01XUE9ybDBHTE1HZGFxWHdT?=
 =?utf-8?B?WndEV2p1L1dkbGVyaEREV3ZzNE9DQlUwTk9nNlZVT2lwVHNsWnNPNUMyTDdR?=
 =?utf-8?B?UTFna0E1Tis2aC9PQWVRc1o3Uk9uN1AvUnhNQWRPUldwUFU1S0dwRW44aTNs?=
 =?utf-8?B?SllQUFo2c0lqU01nUVU2MnBqYUlqaDgxZWJkbFNNcmtyWjR2aDZQZmxSb2dQ?=
 =?utf-8?B?RXczVmkxbXgwb00rWjNCMHhjck5JZVBqWlJzSW50d2FvMjR3RkNkOEVjNkdY?=
 =?utf-8?B?MDV5UGlEWkVxREdQUkxyNGNGWEpRMHVOSFdWUkM4ZDZiYVRacVEvUEZpTS9I?=
 =?utf-8?B?c2ZYTlI2dVBqV1JQNnJQVnMrcmRQZ21wZUVsd1J6SThLQXVMdTNiRXFRZ2Vq?=
 =?utf-8?B?b1dkeVNXSERseWJqbFVTR2h3dlZXTTBqUXlJa0hCbU5vTk0veTRra3BiR2Y0?=
 =?utf-8?B?WnMyU2lSU0crL1RiY3puVnNXbnJVeWtQMlBxRHFJMk4wTXNoYkZRZkkyVk5m?=
 =?utf-8?B?MWE1NzNXb0hCZHRQT3hFNHRGQXVvd0xaYStITnJPcS8vazBGTGNTY0JYaEd1?=
 =?utf-8?B?WUJRb3d4SUdVcnhiWkNoUWI4dE80K25hcWRLRzM5azc1a1FzS3Njd0puaWRp?=
 =?utf-8?B?U0NzOUFkM3BCdU5aN281eFJQL1RrNVRrWUJIU3d2KytGVzdCUHNsZUlJbVVV?=
 =?utf-8?B?M3F0djV0RHZHTlRhTmdTMGg5ZHlSemw1VnR2TVZ6RXN1TnhDbzlCTE5teExV?=
 =?utf-8?B?RDdiTGR0eFVPR2Nha1lPRWUrQ2ZSdmp5Z1hRYmkxcE90dWxMeHIrSmpXUktl?=
 =?utf-8?B?VTlPblFqZlhXUm9EYitWZUxMOUVIYXRPei9EWWVWM2lSSGJwSVZ5eEtPSVlr?=
 =?utf-8?B?bmZ2ZzN1MW9FOGpveDBkaTNhNmc2Q0hQc2VtSmxZbTZOYzRZdEVhQWlUenJs?=
 =?utf-8?B?NmE5YzFpbnZtcWU2SkljRHdxcUZ2ZVlQUjBNV2ZXY2VicVJuWkdTZkppWXc0?=
 =?utf-8?B?VzJjQzNvZTllU0tXbXZhLy9VTUFMcUdTU1NYVWUxdEs0RVErb3hjclpSNnlv?=
 =?utf-8?B?dUxYWVZOMkdhSzZmeHFjTk5aZG82Q25TZzhxaFhpK00zanlDK1FTeXlPZE4w?=
 =?utf-8?B?VDhoTm1ISFAvbnZ5a0dFbXVsY0dSTUE3L21iUkE1SmRhaTFKaHRKSHJXNUdn?=
 =?utf-8?B?MThOMTNzTzNjTy9qckV3M0F0RHhLZGY1Zk5uTEVHTExoTzdVclFuc2lzakor?=
 =?utf-8?B?cFNqSTRjUWpGUlE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGNKTS9tMjRLU0FCQldiZXNYVDRQYkRuWkxkd0hFSHNlaFVYOWtlaXZqUk5M?=
 =?utf-8?B?SVRmVGljVlRaU0tOSkExcDhaN0Z3L2hLVGs2blVJRk1IRVNVNGQxbFdiSUo4?=
 =?utf-8?B?TU4vcW5Rd2dWQys4NiszUUVwOE94dWMzZlBydnYwek8wbCt1aG1TNEg0b0pW?=
 =?utf-8?B?dXByR212bDkxYnU5bUd2L0haeFJvcVlxUWtDbTRpZm1PVUZVQVZoaVlCWEIv?=
 =?utf-8?B?aWhRb01OeHBaZEJtYVU4QVFOMnRRZjFjQzRLWk9FbWFjbElUZUxUanhOaDZz?=
 =?utf-8?B?bmxHanRuUFpvL2RST1I4VXJyRmpkRDBCN2FlYXlRdWw5ODFjd2RrbkJ0ak5i?=
 =?utf-8?B?dkVzQlBFTm9RcUFhKy9xU0V6WHNjMEFFTGUwZ0N1bTdPcWFHSXU4bW9lcFhY?=
 =?utf-8?B?NTNWQXJCL0Uxa2xlc21hdjBYTHdTYnd4TU5XdHc4b3ZwVS8zMzFYbElQTXNh?=
 =?utf-8?B?ZnhmT3ZScm5MMUZSNndRMkF1L1ZuZ2dFZXJHc2J4eTdFRFAvR2FjVElUQWdW?=
 =?utf-8?B?QmE5RVhRQS84NHd6eFRGdTY1dnJ1RWV6Sk4vNjRRVUVEN3o4ZVBmSWw5RG5l?=
 =?utf-8?B?VTh6VW5CZFRVdTJoazBGV25IN3g1SmRMMTV4WmUyM04zUUNaUUdTQVlCRWhu?=
 =?utf-8?B?ZElIREFrdnUrWUFsL0RKNWk4MTFHeVA5QWpFTlJXMWNQWEY4eGtvOGgzakxm?=
 =?utf-8?B?N2ZtMkRPTC9qSE8wNnJKRStmc3l3aE1tMVBBUkFRS0pIWS92VWdSQWorT2Ez?=
 =?utf-8?B?MWFNejJiZkxOMkk3VGJtT3FPSmliamV2K2dsMlJjbkx6ZVNDdWE0QVJmaEow?=
 =?utf-8?B?M3BrZzRaL2M0dkg2NUtlUVZ4UVorTHJ1Nk9XbW9na2J1d1BBc1d4emNIYmlL?=
 =?utf-8?B?L0JydTZ0Y1QxWmQ2amFhT3JYeFEwcFVvZWZOWFZmcnVRQjJjcmxvN0lFUGhq?=
 =?utf-8?B?RXErcGd5Ui9BNDNGOU5nRjBONE5oT2J3dlQvNXJEOE1GUG5wcXJ4WDYxQlN5?=
 =?utf-8?B?dkQ2SElmS1VWTC85dk5BZXhRdzVvcnlYeGZDN0dzWXgyQi9GMlB4VmVwMkZV?=
 =?utf-8?B?R1lSelFSRk1rMHpTV3EyMXc3WVJYRldvbTlYUXFYQlU5VUFMZU5Wa1pQbE5w?=
 =?utf-8?B?UW9oTHRGVkc4REwxcVkvRXJXVmROM0ZJRFN3cHV2VzlnemdEMEJDT2tHcFg0?=
 =?utf-8?B?blpSa2IwN1Z1TDJ4RVZnT2ZkS08vMWMvelNod25Wc1FxRmZQancwSk5yR3ps?=
 =?utf-8?B?UlF1a01PRG1XVXl1NzJmTzl1K0hxS3UvRnUySVU0dmxRUklnMFFvU1NtOCtY?=
 =?utf-8?B?L0dZQ05vYzdZNG1tZk5WR1RXM1E1WEFYRXExWlByalFQb1RWQmJqMzc4UjhW?=
 =?utf-8?B?VDV5eW5wd0ZnVnoxaVQxMnJDQzNCRHc3S3N0dzRDR05zWXQyb2EzYXFvbDZR?=
 =?utf-8?B?YUk4cXQyVUNuVHR2dVRyVldxdml4WFl5bjlPS0NxZkFIR2dpR3ZHRURaekRm?=
 =?utf-8?B?T3dWNWNyTzVTQmZLT1RpTTh4d2UzZnBsMUxvY0JvYXMxUG5NZGhLK200ZCtG?=
 =?utf-8?B?SnIwQmlkeWJPYit0djVnYjZiSmZHdk9oTW8xM2JvZmEvVkFIUkRQbFZWN2NO?=
 =?utf-8?B?TjR3REdnNlc3cU5LT0d1Szc3WDREZlpwTnNQYUtRWkYvckNQZEU2M0QvYkdq?=
 =?utf-8?B?TEhXQWNwUk1vTXRxL0t2eG1Qc3dJN2xkOGYwUElhYkQ1NFk0QW55bnhsZEgy?=
 =?utf-8?B?ZG1OV2JQQVhjejYyTnl2MDVYdzNsaXV0VEVkMkpVc3llM25oQ0JUbDIraG8x?=
 =?utf-8?B?anRjLzExTXEyb3BWa05ZWEpETXBkUXc2MjVjOG40QzZzVzNabzl4dEVQT2NX?=
 =?utf-8?B?RUZ0T1pYeXVRdFZrTE0vVzhpMWVnUFBqSmtYTytDNTBLN3c9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917138b1-32da-4066-4364-08dee34ee80d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR19MB6091.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:28:37.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4252

Hi Alexey,

Thanks for pointing this out. You're right: my change duplicated the helper
logic, while your patch addresses the root cause. I tested your common fix on
a Linux 7.2-rc1-based kernel, in place of my RK3576-specific five-line change,
on an LCKFB Taishan Pi 3M with a HIKSEMI MD202 (0bda:9210, RTL9210-based)
connected to the USB3 Type-A port.

With your patch alone, the MD202 enumerated at 5 Gbit/s and completed a
64 MiB random write, sync, cache drop and SHA-256 readback. A 1 GiB raw
direct read also completed. Enumeration still worked after an ordinary
reboot and after hot unplug/replug, with no SuperSpeed reset, setup timeout,
error -71 or block I/O error during these tests.

The separate destructive 1 GiB filesystem write/hash stress that previously
exposed later RTL9210 enclosure instability was not repeated, so this result
does not claim that sustained-write issue is fixed.

Your patch fixes the reported use case and supersedes my RK3576-specific
patch.

Tested-by: Liu Changjie <liucj1228@outlook.com>

Best regards,
Liu Changjie
