Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894921;
	b=F4aNS9H4qyIC9O+XTlyeufi7CHkzHzX01vEI2SLwfvlusBTANxXaMWaztzBkJlg7Elo6
	 /SawfjXYLjkPdQ51h74CV0qW9Xz17IsRXFiEbDyTN57dINxVwgs9JySKTZc6ex3ajaubH
	 mORPASAKeX9SYCQQZcRpbZoHfnt8rPqNDqsYMV89hYxNq0IWeDLFw9pEOrcmrTg3Ttrk/
	 xhgQbfOlqMFLu0SQU6BW8CbEslZUzJr8FpTurPDrfhPuBL4QeQjGfST8Ilt0PUEEU9ZDG
	 DwNYGL3iepRSIt2nQOr3ZD/tZUdPLmiX+CcRl5a/3Z8kvSWJhLZ5E8h8HlYhtGps8Aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894921;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ivShlYObfBS2CdIXqxEA/GBjUV8blr5SG1jgl3/CVXA=;
	b=iHLQ5i4ywWUr4bgiD6R8PXK9O0aoUPcQuerpUeW5EqzkWUWD4r/qWn3umlz3OMvUq4+G
	 79MaM7smiihEoxT5Ijhr5Y1zdkwUyxAvwUokmk1jbnzQ9l9DxWS8/TfJgaH0vyweWjCe0
	 10JzvWkTi+G2Jag6c+Xd55IxwLF0g4Cx6LDw7QnFzUWDwxhV2mdfecY4ijHcMQ8821adZ
	 BETij23Nq0wx3NvKCCMxBle8WcsWZYzJP6MwkeFdIYLEL/ciFv2kKUTDFWh2bQsX1IKNt
	 ZDOwFNMxLcXgWXTV4wPlEbU53aC0nykeihRfyB9qXhvhN9nyuus6Ar+iDmkEC0Gpf+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UTWeAg0S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.18
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB32606CF8A;
	Thu,  5 Nov 2026 16:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB32606CF8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UTWeAg0S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LILoD6rNL5iqX671tIGz4RIO8d14Zyh3A9KZGEcLeHJeuyXRm4YKai7ALte5mTxA7weKCMKAgHvvQJwohyoV9MQxX0xMLaRjF4KxlFIXFZVNfVepXfs2E4YlSLYvqDrvjCxCJ3XIFefkIHvH+Ymvr9w6XtZ2wa3bdT/OQiBb8ZgKnNwrWW6ZUrgVmF89d/DMiWvtzsk8fG9wzu0TrAj9sKMeo4wNxJKuSFkAESFxfl4SRoTrfjxuGDKWHTP9VCnxJJmX5NVnoCJ+IXV64sAI9j79jKW8cIGMObxEvo8UWS77ibmGgWmPYIWF1cuVUYwvDCqI7fZ6bGcQ98TIusbuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivShlYObfBS2CdIXqxEA/GBjUV8blr5SG1jgl3/CVXA=;
 b=yJ4FYOv1Cic1kpFXgwSSGS8i864JZs4xC1jboaFBvovPtrV9qKw4bcsx2iReeN2BpAmsYokuKcCrO9WKya2oU8uEnZjRbdC4GbhlULl24aZu+wlG1AE8brHd/eHJXyMFDPk5znowV+w9j3GdjHnFgUuWWJ5ot4a6CINWW4DzIBC7UQg4sLRn5D0mI3XULVTc2+sW52/1l2lh8AFpfq9VMTHyCGhfKYAu3Ib4v4vqfloJ8Je1S20ifTM6tA+feRV7sk9hizHUp82aco3iO6+LAxihnQe4rf06qgaap71rlHCCOuaW9p9PkfCcJBjcAQTVccwmbSK6VPXBUKa0uNjsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivShlYObfBS2CdIXqxEA/GBjUV8blr5SG1jgl3/CVXA=;
 b=UTWeAg0Shx4ygkEtP0KdrxUa4g6yRMo4//3s5vBPfQUGsnuix0ODB5qi3DVd582tw1buAt5FjTUb8IXk+dvVRtawjNhlqYk7O5zqlBkn8sUCZVk7LTb8bDDi3WbVeLjGQ+UjFLXv69MI2XCCM43iloInJMLv9WxMyy/FPoiewYTYZLNI18v2aR/zFi+rqcBspgTGDl5gNZRLTet0IDlBdrJqQv5GWbgy/bktUfIbpadpAUY3utZFVBblk9AfcWreeY8IEKOkhgPZMP+pWAxik6XqZPn17SOmdj/3JfRuU1NSDzSorapZNrTflIKVAjVWz1AkplexoH+IjWpH66jVZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10) by LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 16:08:34 +0000
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052]) by CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:08:34 +0000
Message-ID: <a05ba405-73c3-47da-8117-0494b306a31f@nvidia.com>
Date: Thu, 5 Nov 2026 21:38:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: Set CPPC Enable register in cpu_init
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
 benc@redhat.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, stable@vger.kernel.org
References: <20261105123244.3132560-1-sumitg@nvidia.com>
 <f3d2b82b-81bc-433d-8589-2fc88822e342@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <f3d2b82b-81bc-433d-8589-2fc88822e342@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::17) To CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH4PR12MB720178:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f8512e-1911-47ce-a4a4-08df3b570abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261009223027099003|261021121427099003|11063799006|4143699003|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|261102123227099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5KsEw9bqow4JHefJ7Y61RuepWuHxCG+sjNKd5dfbaQ7rXKoKWg2hhysAsjGTl0+P3QEdkITtgfslo/CfjrgIQ63R5+Z+vPtH726amz7bs78VMCTIX9lNoTMrmEVawBgWahyEJjWrSMHFXjcPr241zs/FiGoyFTTDTh8HKHOJPewRj9YPjJxRGaR/vMgODYpISaceriJuE2SjxTQqPYZMIN4CCsh/TJvO/2o7it4E1RP8XdQJYb3zbz6u9RQ8TRZL9/sB7DoewNKI0I6/BibknCeZVfCKeIrkHyINvjWBmS0Ansk8+o47vnhVJcyUH+DVWf0mWarB1GAdBGwI5r+mq/9DRhluGasTeO/C9uS6SH9lWXyv/39A0TOX0IWalTejX1ZADZMVF/Oh6dCXmfczRn+UXVnK7HCYy8fhSFnN0AcapI657Scwmo3p0WBTf/EWJkmKZwbYCPOrdi1h0m2rTxaWupb1SiWAsH/jE+g6lu1k1Qo9RX/KshCnn33kiipkZY6aj+hBMqde5O4s+LjF09EghRbC3AJgMDkcYBn/2jSlxhyzXGZEAFoKYkb90VyyDBikDehfr7V67NiebfQzPqRqVsexufZcuxlOpRBt8pdLZNy/NtQgSHGsjLTiQ0LwOrNIkGBCl7hG4pdtEOETATuOumj1R/BBx9ILydkesnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR12MB720178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(261102123227099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjRIT2k1VDJyRnY0YlV1UWg3WFNRUU8yS0N5VUhwaE5NTVFTYU5TbzJsbnVC?=
 =?utf-8?B?cEp4SXVydklUblhRMlp1VVZFSUVjb05EdzF5eGQ2NmxoTGVrdlFmSGZiOWJD?=
 =?utf-8?B?U2lTRjNISXVBaWh0cGY3aVhFSEhxL1AyNmhlbDVIRkNxK1hXenFlQTk3NWlB?=
 =?utf-8?B?NThYK2NqUGpTT09HL1Y1aHZ2K3VFUS9zK1FiRTA4OWo2dXhhOW9xZ082UjE5?=
 =?utf-8?B?WXhGQy9GWUhtbkJnejlCYURjbWwzRnBJZExBRFRvcFFsU0FJSGFyUXhoK29J?=
 =?utf-8?B?S1gzdjJJMFFTZ25veEN2NlhVVllleXBSaFlEWHZ0MUVRQ0V4UFFHcExnWEZn?=
 =?utf-8?B?TW5MaU02MzEzOGJDSXVHYThIRFJmTEtSM3VFMzdpT3FtQjJCdGJtSDRYbE4w?=
 =?utf-8?B?S2plTFhVOUR5dC9Fc1hZM0RIK2RrRXViQkEwdldnTzlPSjVqZ0I5UlBVQWxL?=
 =?utf-8?B?UFhPUStwdmJIWVRhRmh3cE1GRHRoZEY1SzNlejdMNHl0ZURXVVNWelV3Qkxp?=
 =?utf-8?B?WWVQR2t1K0doYjJtTFNraHQ5ajB5VExXakVUWEJYbno0bTBQRFZDNFhndDBS?=
 =?utf-8?B?cTZyQ2FiVmxjdkQ5MFVmVUkvZWU2US9BSklOZWdRYUFJT2pmL3ZQZlpIVHFp?=
 =?utf-8?B?U3c4UElpNFpOVHFCZWRFYU9aRU9ENTFTS0Z5K0tUR3FybXFETDFjbEcvbXFT?=
 =?utf-8?B?M0RhTThScFRoQ2xsTmIxMDhnbmVtZkF4V1pFZ1BORWwvR3F2NHRvWE5FMVJ3?=
 =?utf-8?B?UGdpR0Y4TUJzMmFVYmlCUVUveFh2QmdiUUE3dWMxbDJySXVmTDhReHhSNW1E?=
 =?utf-8?B?NXdNb1BhTWxKdytoQ0dKeUlNcEcyam8rVVdPdTlGdzFERzQyQ1JmNEVrOG5F?=
 =?utf-8?B?QXVOUlZzSG4rRmRFR2VJbkQ5MXVrQjdsZmR4ZkVQNmRwbVlGMU1HdHhrNG5E?=
 =?utf-8?B?VHhwMHdxeksydEZ0TldOVVdqbDFad0NCVmpadEl6QWg1S003bVFsMXYwczdM?=
 =?utf-8?B?TGtYQVVwNkVnRU8wSXpNZERnUWR2azMyZ2NRWGp4QkNDaTg5UGFvZGoySXJ0?=
 =?utf-8?B?cTlHKzBHRXBDYlBJaDl0bWs2MVhwcTJEYVR6RnBxUzVWSFoza0JQdFdGb3JU?=
 =?utf-8?B?MloyTjNmdzJ2UGZ2WGFiRDhiR1hmSlg4SG5hUGxGRHRRQ3gxb3Z2T05wa2xX?=
 =?utf-8?B?V295ZHJJQXZjOE5DdzQ1TkwxQ29maHM4dEdZUE9OSVRjVzV5dDg5aTFRM0xk?=
 =?utf-8?B?ZUxjdjl2Rld6YnlTbGR5RGZDbWZsSjVyY2dJM1JHeFVGZndnMmoxam1KdnJQ?=
 =?utf-8?B?NGxyQktVeXNndTMrRHcwZXJ3UFkyYkFCS3FJUnlub3FBTVQ0Lzh3ZGhOZXlx?=
 =?utf-8?B?eXVlM1RjSWF4T3JLUXhubnZuTjl0bmV2eG9MWGt5QTZCUlpGVEoxQzFSMHlq?=
 =?utf-8?B?Z1dTdm1wSDlRT0tVNTFRMklXVGFuYVgrVnJGRE1heWZYRzVuSUxQb3hueThZ?=
 =?utf-8?B?TUt5VXVwWFJNRktLdGNhQjUyWVhmcHJjdFkrTnBXWCtDdWpaWWNiMHRlcmZ3?=
 =?utf-8?B?VGEvczdaU2F1Q2NsNDU5RklUVjl4emROWGpHWDcrRVllQzNtWDZDcXNIb1NV?=
 =?utf-8?B?aHRjRDJHdnNPV1Q4aWxid1JTSHUvQjlsbXBUVXczVEh4OVd5aHJHTHphWGV1?=
 =?utf-8?B?NlcrRzFOWVF1SCtKcWI4YUxScm5pdkpMWWxOUWhmMEtDaS8zNVlMdDN2RTRQ?=
 =?utf-8?B?amVTQ290cVQ4UnZZY3V6cDJVcEY4NC9Rc29VQUJEV1N4RnNoL1dMbGJLZ3Vp?=
 =?utf-8?B?b1RoZEthTHFaSzQwR0oyQklaZFhFMXdjUm9mcENrSlZsVS9UWWFYdG5jN0dH?=
 =?utf-8?B?ejJmREIvM1dza01CeWpVcEw1WUZ0Y0ZrS05YWmVLNlBZbXFUdEM0MzZ6cWw3?=
 =?utf-8?B?RjdwcXU3RmZnRXNFMUE1aTZGSnNBMUJzenlMNUk0UE1LWURDbldSMmUvejd4?=
 =?utf-8?B?VVNjRW9NY25aVWdFVE0wL3c3dFk2cXpRTzFTZDVpYjdyZjBTZmdITm43QkpV?=
 =?utf-8?B?YjNhMXRlT096NVdxWUFqMEdydmNWUll4aktZNHRtb3A4eU5aeGo0U1F3L1Jr?=
 =?utf-8?B?UzgyUUFwYnUwcXNUblRMNEM2OWp6YTc3NjNscTh5WG1GeUdVYmFIdnNwRnk5?=
 =?utf-8?B?RUF3K0tmR2U2U2J4cTRCR2dZS0lHR1BhRFVDRXZzQ3BEQUpQa1VvemZLMjFp?=
 =?utf-8?B?Ylo2UVdTbm9jcWFYRUxzVUdtRnI0WFhEWXZ5Y2VpOXpvQzl3NkMwRVdpUXBz?=
 =?utf-8?Q?NkZ2BU6MIEWty7ICvq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f8512e-1911-47ce-a4a4-08df3b570abe
X-MS-Exchange-CrossTenant-AuthSource: CH4PR12MB720178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:08:34.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XjHHMbbMj9xYmWFHChuLh6ItX1dZ5NIeMGHuBYLbGLDkjX6/JtfTKlyJPVp0XZ8hirNyaAWjazu+kvYxldXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776



On 05/11/26 18:52, Christian Loehle wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/5/26 12:32, Sumit Gupta wrote:
>> As per ACPI 6.x s8.4.6.1.4 (CPPC Enable register):
>>    "If supported by the platform, OSPM writes a one to this register
>>     to enable CPPC on this processor. If not implemented, OSPM assumes
>>     the platform always has CPPC enabled."
>>
>> The driver never writes this register. Call cppc_set_enable() at the
>> start of cppc_cpufreq_cpu_init(). Errors are logged but not fatal, as
>> the register is optional.
>>
>> Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
>> Cc: stable@vger.kernel.org # v6.16+
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> 
> So apparently Nvidia GB10 has and needs this
> (I guess it doesn't hurt putting this into the
> commit message)
> amd-pstate sets it so all good.
> 

Will add it in v2.

>> ---
>> Sending this separately from the autonomous mode boot parameter series
>> where it was patch 1/2, as it is an independent bug fix.
>> v5 of the series:
>>   https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/
>>
>>   drivers/cpufreq/cppc_cpufreq.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 957fa7775260..b8f4399b6e0b 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -679,6 +679,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        caps = &cpu_data->perf_caps;
>>        policy->driver_data = cpu_data;
>>
>> +     /*
>> +      * Enable CPPC. The Enable register is optional - some platforms
>> +      * may not support it.
>> +      */
>> +     ret = cppc_set_enable(cpu, true);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             pr_warn("Failed to enable CPPC for CPU%u (%d)\n", cpu, ret);
>> +
> 
> Any reason to not fail here?
> 

No strong reason. If this write fails, cppc_set_perf() below would
likely fail too, and no platform reports this failure today.
Will fail init in v2.

>>        /*
>>         * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>>         * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
> 
> 
> ... also I guess we need to set_enable(false) on
> other failures?
> 

Yes. Will move the call to just before cppc_set_perf(), so that is the
only failure after it, and disable it again there.

> It should be okay to do this only for policy->cpu AFAICS
> but I guess we do need to also reenable on resume.

The preserve series [1] handles resume, as resume() there calls
online() which re-enables CPPC. So I would leave it out of this patch.

[1] https://lore.kernel.org/lkml/20261030092416.1993889-1-sumitg@nvidia.com/

Thanks,
Sumit

