Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013074.outbound.protection.outlook.com [52.103.43.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B53EDE60;
	Thu, 24 Sep 2026 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245879; cv=fail; b=hdcXQkCV+1tK+E3ZJ/3RZF2P1jsADiTWhvgQO69xyMByFt+mPMBH8ABW0Ntxer2QDFUUeeRWXWC4iZB+IuL2kVHMxf0cfCiwDvzGuAWN26K9GNRz5YS/bo9dQw/vApgK/oXxm5YuhMJlvvayTk0VaHMG1RQOqsMfZYOCt+08I9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245879; c=relaxed/simple;
	bh=pQhuTXwywun6oyrbXmtocJtJBL2T0mnLwDgdVhsTDUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vAUcJWPk4yscPGsfm+d01Rt9dZOEKxF8Bce0yRHmKYoJt1xLh1qjFELaJd3H7V5ZnQR7Eq0XXIyHRd2jAD/lSLG0TnwVSi6RPogS8t8TyKCIaMx0lbqyC/9pwkEaaNUdQHdsnsfLJex8MCzH27hb8fA2Fi+x5+6qNex3VQ+EZl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=cGrkrCR4; arc=fail smtp.client-ip=52.103.43.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="cGrkrCR4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsrjGHAXH7ZO0l3RvQe/IMXNmXox3plxOO1M1fpSO/zO0sRQscehZ96j/lD9bqTi1MLf5Z67HwYys6dwb7qqf1Q0+rdRKPnX2abmZQJiHMw5uoRucz03VAclRhm/rKe7EC1DfXOsVQFHYqC7QMjgwuiRZYhkzlYuAHx8iNV8bNDI3u8tHZMLB61cRGlZ/WPvyXFYEmeCiZISmzJtDSakcmIqjjfTAFmHZOYhR2aSGj5POW8PjY1x22VEUVMIf2Kh4VcIqOEfgZqDL+3XV2r/aWK1snLrUkWb27fTa+wzBj7Le6BBeFzURA1S1hCYsAivmoDVh69U+hKeiz8JUMVkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzTbrzaMKufJUagcNZfomKGGpYTXlMigWodziA2kk4w=;
 b=Zs4Jhk0UPSEuKmQEgM7v24ID9dBSKp34bFz3k4L5752kSco+ED/Ibj9itAUN+8aeuN2RYhEWXgYDx0vGcTORBJt96QyQmRRyDiCTwNK1olwfreufJMajDPCq8glmvhfd/ilW/Y8il6Up0BUWQLjQPP9nDsoAt+1iyNeTeUZUUXG8lco8kzrhoqXKTtgJf4aayxs/3KOvsMHSvCd4zs7xNwyE/r7tZLP3UIGPDhsEUlRfXfJMi2yVhnPs+2II3METANUO62hcNGaF8eGybPlARIC1KgxFdqwwlZKnHzLdjvloOVFVluQOReycsjhrODPAUgO2w34gmPxxqc9oS73ifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzTbrzaMKufJUagcNZfomKGGpYTXlMigWodziA2kk4w=;
 b=cGrkrCR4umY0GEewGYaVQ0aWcOFjUDzeAPiQazgUEPX59u9MW/+Izu/NuUCEuaEcIkdjqSdl0oTh6B/Ggp4nhOFFOAd125r20udaKL60adpfucUBus6cHCC3UnP4vaAx6P6hUR/BKLuaPJ3lqLob3cVmXCtGK7v7/EKLAa0hRk2SN9a/xIofQ58YC4dWRgu4c+KsqnevFC6CnuwWSj3L6i9n0Vs+9+s8yfMoJnipzwApON/RrgtvVZ4k+7LqqbMBYWB/3Aw+RwXY//jD7j8SU2eTGniTuv6UIVQFGzakIQ1hxoj3YP7+J8rloU/+5zskNStdmiEXCOPoxwRtGHS6Ww==
Received: from KUZPR04MB8925.apcprd04.prod.outlook.com (2603:1096:d10:46::5)
 by SI6PR04MB8221.apcprd04.prod.outlook.com (2603:1096:4:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:31:13 +0000
Received: from KUZPR04MB8925.apcprd04.prod.outlook.com
 ([fe80::e3dd:6f77:3be9:b71d]) by KUZPR04MB8925.apcprd04.prod.outlook.com
 ([fe80::e3dd:6f77:3be9:b71d%7]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:31:12 +0000
Message-ID:
 <KUZPR04MB8925D20F0AB4F4FCAE74793EF3812@KUZPR04MB8925.apcprd04.prod.outlook.com>
Date: Thu, 24 Sep 2026 18:31:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Fix IPI delivery for out-of-order vcpu_id
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>,
 Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260917122012.2577-1-yuanxiaofeng@eswincomputing.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260917122012.2577-1-yuanxiaofeng@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To KUZPR04MB8925.apcprd04.prod.outlook.com
 (2603:1096:d10:46::5)
X-Microsoft-Original-Message-ID:
 <e04ee895-1ed1-4829-8121-f355dd297566@hotmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB8925:EE_|SI6PR04MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: a95462f0-36ba-4bbd-da52-08df1a26f461
X-MS-Exchange-SLBlob-MailProps:
	a+H6FLLcF3oArmUeIqZHaFYD1WEyA+laSdoDdnexXHsGONCAqpl+DsBQ/2tLa+uvO6MFpJfADjay2/+4V6RBkM5gCcEip2ZbVNzukfLtWK+bA8oeb46FEbMVfM5DAThRdFk39KJApneqWChwHQk7T5Of3Cyp98p6Wkj4BmGKqsGlVDD22njdKhjIic0+ur4qHm07d4xY5LTeRYQcP+3jvbrOCifvqDEnYE5hrbwJMt0woZMdS9FRcn8NWihpPbW3BbmK88q3t1D+1qB9g4vGtCvp0P5tL2kNol6jtm02s/J3qIgq0xCe08bGS7A/TD/kMJ/46zutxuns/y0qp//xovmuTrw8FbPUFKL1h1rpiprBkb2W5/nkqG0ProDUBygGYjh/YyKMum48obwqXCJF3RJHYu0Md2yJXrogD7S9ADnc2UgGogpt3/Ejf8uwSfPZL/baw7BND1HybS35rf+lu2I4Id/Z9Rm0hNXtgUgaCnB20GDhCQCVKeCWN795n/S7tldRsi05ned4d4bNOZAng6qqOn9htiHEN2Qkar7A9PYHAgMHHRGumJCIUNPTeyFD9qHBD3gAEAQuZizLnjDZFVivLYyoZJ6TDWWkWRsxqDYIC2ToP4lfE3zg/2cI1vtxRtT0gSwAd0yXBTUCot4Hid+RzuthuHum5pu5qBJAKahL2ynzYgeMwxhVS5XSsXPiNGPxEOlmpnKSG6lsixzDe9Yu9IGvNdOQyGUkjlXZSXlZ5AQFNoma0snQbNkFeahhOHhPoXt8bxVptXmtTDHksZJpoalefrGPRGgBMmY8xCu8FC3f0iqEDZn7WixDPgmS
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799015|5072599009|19110799012|4140399003|21061999006|23021999003|15080799012|22091999003|24121999003|55001999006|19101099003|25010399006|16041099003|3412199025|440099028|40105399003|53005399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXI5RVhGWm1ZU3lrYzJNYzJhN2VxaVViTU1RWktzRk9ic2x5Wlp3ZnRSSUZh?=
 =?utf-8?B?TGlhejY0WnRMTWZOLzNSczhLZ0hDQ2dhZU5pbWJ0RThrMVNtd2E3L0NPNU4r?=
 =?utf-8?B?dnhOWkttd1ZEUFZEYjhQb0RNdldSaWFPQTVFeCt6SjdQd0FLQ2F1aUUwd2c2?=
 =?utf-8?B?dVV1RFBLc3BJelJMVHFyeDEzK3ZBcDZYWXdlUzRqbmtYbC9UWTJNdnJpMDll?=
 =?utf-8?B?Smhka2d4eXdmRXYyNlg2eFZTUUpJaUV0eUM5WnlvTXdnNGFucit0RFZpaTdI?=
 =?utf-8?B?OXVwVmVtSzdzZTZCN1MvcExxaVVlU2libmtnMkFZS1crNU4zM2JTWEdpbzdN?=
 =?utf-8?B?eVJhSXBzWFVlb0dMOVE3dGF2UzNXbStXNkZVQWdNLys2RmtlWWcxeGNpV0xy?=
 =?utf-8?B?eEdyU3YydW5sc2FwQkZuRnRrNHZSWnllTFhVVm1uV3VnVlFYaDFsRElRNjdP?=
 =?utf-8?B?dktDYkZzdUpSazZCeDd5Q2ZUSmFjWmlJU1JvN0E4V29nRjhkT0FUN3F5VEdT?=
 =?utf-8?B?aTRRRVM0ZFlDMGZBdHpyRWRrNEt2RjZYMU1aUVhyRVpHeGpQMVpxdU1JaTk4?=
 =?utf-8?B?L3VMVUl4aW9hc2lQdU1CVkZyQk10VUwycjlJWEFuckVHVEp2TDNqWlBOVmdv?=
 =?utf-8?B?WU1YcEFFL2VyN3RRQjlhZGl1Ly9BUFdwTExpV3g3TlFiTExyWnY2cDFuc3RF?=
 =?utf-8?B?RUJBQzlEQTJWOGE0YVU4UGJYS3NTU1BHZzg1M3pDL2sxQ1lUT05RWnFWL0ta?=
 =?utf-8?B?SXdXa0x2SlZtcGlzam9EYUFUejRQb1lTd25BdGxiMldEOVFNNXBoMjllR0hI?=
 =?utf-8?B?V0VRYjNPRVc3alRzcVNLa3dmRTRadTYwN2E5NkFCNjBuKzExajNxNE1ZOFhK?=
 =?utf-8?B?NytKZVAveThDQUt6anh2eG1ieEJtYjlkMlBuTnJFbjlzWWNEemNTL1E4VjhQ?=
 =?utf-8?B?dURwdFNUSzR6MTAvcE0wU3AyTHUzZVFZblY4Qk5tQmVadnB2TW95SWhqOFlH?=
 =?utf-8?B?MnZtUkNGcks2c2tyZnYrZEoyVHgweUVleTh5ZG4rNjJBVnJrWlBDc1UyN2t0?=
 =?utf-8?B?R0JDY2RxRzZNRi9FcWtadU9IVjJhTVZSYWY5VXJLVFFmODVHOHpxQXNNcFdV?=
 =?utf-8?B?akNoaXlLbkJPMnFmSW1qSk8yYkJES1RRdWYzcGUrRTRyVjJjU2dsZkpMM1N1?=
 =?utf-8?B?T0o4U3BFU0x4L2lFRXFzZTdxcng5SUZiOTF5azVGc0tZS0JMelUrOVNNS2Z3?=
 =?utf-8?B?T01EYldyWWIvNHY0Tzg0VFlEbzFGbVhoNVVnVDdCdmhmeHRBNzcwbU5CSi9L?=
 =?utf-8?B?Q2JDWlp4Ky9JYW05ZU9GenFyUFQ4aDNpNHRZRW9PTWxRUnREcHNxbDl3R05j?=
 =?utf-8?B?VVRXcGRRc3dDeW1ONW8rdTZiN25jdmQwODcvaXpRZ0FEU3NFZmsvUXVNSUkw?=
 =?utf-8?B?eUU0MjQrSGJhUm1jb3RML2xwU2lGUWxoNVBLbjNpWERpdHUzVW5OOW1NalJN?=
 =?utf-8?Q?pH37vvPdwJhQllvTOX6rkbLhs5Z?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3AvaFlIRHZucjhXUVgyMFROWkpwWUJObnlzVUdjWHM1ZFhXOVFPeWp4a1ps?=
 =?utf-8?B?VGltSThRWFVWNDMrZjJ0SU1UWEttMm9WZW9uenlmbnRibTAySGVtdjdjTVZ2?=
 =?utf-8?B?aVIxL2NmRDg4c3pycG1NVmJqVGhLT0o3Q2Q0NysraTFHNDlwMFJrcWo0dDdG?=
 =?utf-8?B?ZHNlb3F2UGlFVDArSGlxNmNwZjdXMGVDTlZqTlZLYkUrNHFxWGx5ZXJGckhB?=
 =?utf-8?B?cE90T1JkS255dXVaZ2VCVzFreDZrM1NESWJMazVWNGFNRmFhbWQvWkFhcVlu?=
 =?utf-8?B?czI1bkRYSXlaRmVTcTY0ckJvTDJ6RXRlakp1L2IrT09vL3A5d0pROWhLOUxD?=
 =?utf-8?B?eVNiN3NiTTZkUW1mU05nZHlSVk5aU1VJZ1hmZVZCdkhVczI2T0lkME5ySERZ?=
 =?utf-8?B?cWF6TUZxczRlTmUzd05FWTg0SElNbFV0c1oxaEdkcjdQdG9rd1hjYVRVOWZP?=
 =?utf-8?B?cGpsVGRUQjl4N1pNb2ZoU2dxMWJZUlFsWFM2NkQ2NTc4aER6czhzSDEzZ0Ux?=
 =?utf-8?B?ZWhzbTBWWk9KWEQ2M2Q0WUdZUlhDZXpSN0lJdHFHQUoyeUpOQnFEQTNzc1lU?=
 =?utf-8?B?MjEzZWs5c1Rpa3JGcEUwWE1xOHk5RXpZc0tndlhQSGpFME1hOGozbHRzYmN2?=
 =?utf-8?B?KzhRcjRFbHhCLy9BRlFiYUtEQmJ5amt3T29nYmRDbDh5dGp6SW9Nb1ZkcGVj?=
 =?utf-8?B?TmxKamlPMGRPZ3BXeDE1bjV1RUthVHFXWmlJc1lQaHN2Nm1obGJ4TWozUGdJ?=
 =?utf-8?B?VjBPTjg2T2pOM0lOdG4zU1FVdURkajlZUFRSdjNhcjFTRHZMV3NIbjlsdE56?=
 =?utf-8?B?WDZQUGNzS3F4K2Z4MWJuTkxwOThLZFFTK25ZTTZLZWFYRHZkbmNGWit2Z1Jp?=
 =?utf-8?B?ZHBNTHFxK3AvZjYzTDhpRG4wS1FjdU1EeFpheS8reUpYMFNTT29LWXdVT0hs?=
 =?utf-8?B?VERoUHZJY1JWUkxub2NoOU5TdnVZSHBtN2xPTjNpUFlXbGRJK3d0TWE0Zk9T?=
 =?utf-8?B?L0xGaThXZGJqNE04OFpTcjdqZzA5N1Ywa3BUS2JVUmxlWlRRY3lRYWVqclNE?=
 =?utf-8?B?Y3YwcUlPeS9NaC9QbGtKMzZCYzhkejltN0NOTXJ0VzkwS21vRWF1VmxxM1l4?=
 =?utf-8?B?NHQ2SGR1NnRTbnhFZVhkWjB1djBuWDBvUVdFSkpuOVNxVm5vWVpwcGFYYWhY?=
 =?utf-8?B?MFk5emt2KzJMRVU0ODVrMWprTS9nMUJ6dHNyaVdIS0NEN2tjWEVhSmYrU2lq?=
 =?utf-8?B?WFk5UDZ6S3Z1ampjSmRkcDdra2dta0Z2aGNHOExkZGEvdFoveEFVOG5EUEFJ?=
 =?utf-8?B?V1VsbkxaZk9mOGJuUWFGUmN1ekZ4eGlINXBiKzBqMTdZRjVJNENOWFllWis5?=
 =?utf-8?B?M3NpcHJqd1ZVbTVhL1QrcnF3TXBzRHU5NnhJQWo1Y3grZHFXNHo4bGx0S1Uz?=
 =?utf-8?B?ZWRhQWpGL0p0NE1zMDc1Sy9GQU84czl4VzNEQ2hRaFgyc08ybTJzQWQyYUla?=
 =?utf-8?B?czI5YnZzcy9WLzFEQUVBYmUweFpZbUFFeTZKYVdwamU4ZkxhRzRqdXRNNWVt?=
 =?utf-8?B?NVJpOEJlVmVqdldLY2hySzdYWVRqTXBaTmlHSWp5VkJiMHA3a0liV2p2MWIz?=
 =?utf-8?B?dmdSR1JwYk16VFdCd2gxakwvdHpMVXRBMjU0d1NqU09NdE1nSmg1S1hRWk52?=
 =?utf-8?B?c3IvWkc5cWVDaXgzaE1uamJpV3lGSElLeUdCNVZEOVVnTFU1bDZuQWhtb20w?=
 =?utf-8?B?M1FtV1hEUlZ1dm1GMTR1eTFqeUhkeWhpckh6b1NHN1d6VERuMHQramZzTXYy?=
 =?utf-8?B?NFBJUXloeVBTUUw5ZUJua3dzV2U0UjZOQTZWZXh1ejJhOUhJQkxlV3AveGtJ?=
 =?utf-8?Q?JX7BgoWSxenk1?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a95462f0-36ba-4bbd-da52-08df1a26f461
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB8925.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:31:12.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8221


On 9/17/2026 8:20 PM, Xiaofeng Yuan wrote:
> The SBI IPI handler walks vCPUs with kvm_for_each_vcpu(), which
> iterates by vcpu_idx (creation order) rather than vcpu_id order.
> Since vcpu_id can be assigned out of order by userspace, a vCPU whose
> hart_bit falls outside the XLEN-bit hart_mask range may be reached
> before vCPUs the mask actually targets. In that case the handler jumps
> to "done" and stops sending IPIs, leaving valid target vCPUs without
> an interrupt.
>
> Replace the early "goto done" with "continue" so vCPUs outside the
> hart_mask range are skipped without aborting the loop.
>
> Reproduced with a minimal userspace VMM driving KVM inside a QEMU
> (RISC-V virt) guest: three vCPUs are created with ids 100, 0, 1 (in
> creation order) and sbi_send_ipi(hart_mask=bit0, hbase=0) is called
> from vcpu_id 1. Before this change the IPI is dropped and the ecall
> returns SBI_ERR_INVALID_PARAM; with this change the IPI is delivered
> and the ecall returns SBI_SUCCESS.
>
> Fixes: 0611f78f83c9 ("riscv: KVM: Fix SBI IPI error generation")
> Cc: stable@vger.kernel.org
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
> ---
>   arch/riscv/kvm/vcpu_sbi_replace.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
> index 506a510b6..c2f1f7f26 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -64,8 +64,17 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>   			if (tmp->vcpu_id < hbase)
>   				continue;
>   			hart_bit = tmp->vcpu_id - hbase;
> +			/*
> +			 * kvm_for_each_vcpu() walks kvm->vcpus[] by
> +			 * vcpu_idx, i.e. the creation order, which has
> +			 * nothing to do with the vcpu_id (hart id) space
> +			 * that the SBI IPI operates on. vcpu_ids need not
> +			 * increase along the iteration, so harts outside
> +			 * the hart_mask window must be skipped instead of
> +			 * aborting the loop.
> +			 */
>   			if (hart_bit >= __riscv_xlen)
> -				goto done;
> +				continue;
>   			if (!(hmask & (1UL << hart_bit)))
>   				continue;
Seems the above two 'if' statements can be combined.
Otherwise,

Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
>   		}
> @@ -76,7 +85,6 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>   		kvm_riscv_vcpu_pmu_incr_fw(tmp, SBI_PMU_FW_IPI_RCVD);
>   	}
>   
> -done:
>   	if (hbase != -1UL && (hmask ^ sentmask))
>   		retdata->err_val = SBI_ERR_INVALID_PARAM;
>   
