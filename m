Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793603532;
	b=VgwZZK9cerNfLajwsf+kv7VKMebTSFQNHSkTLsj1q6aLEb2i4Rst+pKohXTB+NEjEiSx
	 jRq0dNQrbdGALkuIIWb9THvmSARi8vyKFQ4MEmA23WB09/wwitX+A6/5j+xYUzQEmitCn
	 xZLaORbdTD4RnWrgblrm9YArvJ9gssquhJYLh2RYEv7EohKXhNoklGkf0fY269KME6fme
	 6NWE1tLcYywXxKZ5hd0BUGNpwq2HSil1VuR5MOXRg3xmF3W1zNddrBe4/8AzRWMPrbko2
	 SQ/FOgxra+pFMzomWxKJOvf0KAFWpA1dvogkHG+lI1QCBB+xafaG+EYZuWJbX9ALieQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603532;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
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
	bh=STjztyzTwL0p18OzfDBVbDKy73h6u7sCHye5XimNoyQ=;
	b=bLGbQ27vcc2rAEvMqus/J0W7afErFLIuTihRbDqnpaQTrgmDMKVE1tIlqW1bbGHO0qy6
	 GfgAS1/i3WNdZxqgaXbxKnywebx/x6KKFATXESuPJspSIoJ49OPKGiVqNes/F3juyjqsA
	 ZPRLAnuHQq+RsZWaRETn7CYs1YyapsudJj+cPOL7PWxwAGWamzh9Gsl8Fen1p8+LTkaej
	 q2pbZ24DkKtb7WGAZ/GjSq6/DIdQLcemPSb2Y6tFSCcg49gHE5xDUXBmB0Wk9cV48Z9k9
	 U34P63UUrPnrIgOka5qOA1bGGM8BLdp1WnQ5YLs1vPEL+nOPt0gyj4S+4eOufqbscig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="Sf/wagEk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.7
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B1606A324;
	Mon,  2 Nov 2026 07:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD7B1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Sf/wagEk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZqJhjXz30YW3Hc4AXZylGMM4IbWuEoC3GqhzRuhdwb7VMiWDP4q2CmPLUwEbWEtK1x1HpLvr7hnnz4Hk3Bfp7Q/YnH8QIEL6BZmrVghKGppQkT21WleLJDbyWQvuGXq+HvyywxSr25JIK4REStjlljNZQbo5DC4BnvTqSNoyoTT/KquoLAtPooC/j1eY1IWJZCnF63Jlovw19GznHxHhHPv/qCDNFD1kQQORFi11PgPY6X5/XJwO88g6KUEM7NeImOqbFUb8GazBKgMjzkZZcWKVgDRVpc3c5z8BIKDHXHAzXop9d6u0y5Ew9jxLI79k07D6C1+uYRykqnaCn7JUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STjztyzTwL0p18OzfDBVbDKy73h6u7sCHye5XimNoyQ=;
 b=WydNpY/G529ri9gljnR/YGyfuxpJnWpib8d1SZXTRdrDISOjalXuszjHiRgJZxdOVQt86hmx1GPk51g95WA7O0vhqtWVcKi0tC3NM/t0L/aIi55kXie7tEZ/YMaxHcvXbN1+1VOgUKmwD2y+IASWru3a7iT8uH6VV0DPE2jIuvGIOSJ7zGUccgPES/Yoa9hgrbbmQef0di4zpOs9Lkl8H5G5Zem0TIusBrQ1lu3JWhE9ai/hfe9KXg/8196TdFCN5SN6ReVZPseTcowhxNozPoa8rBWsfFWkflZeGninascZ/ozAoc8ZxKHcKeh8bQsEqdwSW/0ugc+EWgjRXD5qVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STjztyzTwL0p18OzfDBVbDKy73h6u7sCHye5XimNoyQ=;
 b=Sf/wagEk9B3J5W7gBJQoPIooknL5gDADwSigWich03pdmLEwruN2xbBafv7v4/dG8oUA/WtWKqQ3XbT3Cn5HELPYbNVZ+ocOTEw6+esA9K3Gu1SRWoKziu+Buy3M8EFKgNTX43ysT+MKGWEByRkLXFNUVGPOYjCknu8cYExdvpY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) by
 PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Mon, 2 Nov 2026 07:12:08 +0000
Received: from DS0PR12MB9060.namprd12.prod.outlook.com
 ([fe80::e096:864d:d60a:c83f]) by DS0PR12MB9060.namprd12.prod.outlook.com
 ([fe80::e096:864d:d60a:c83f%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 07:12:07 +0000
Message-ID: <108cf042-5f7f-4b1e-9656-3193744e8043@amd.com>
Date: Mon, 2 Nov 2026 12:41:59 +0530
User-Agent: Mozilla Thunderbird
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v2] iio: adc: xilinx-ams: fix out-of-bounds accesses when
 parsing channels
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: "O'Griofa, Conall" <conall.ogriofa@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261023185652.195025-1-kapoorarnav43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261023185652.195025-1-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0311.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::17) To DS0PR12MB9060.namprd12.prod.outlook.com
 (2603:10b6:8:c4::12)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB9060:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: c4555514-e2a7-4ae4-d3c7-08df38b09a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261021130227099003|261021123027099003|261021121427099003|261021133027099003|261021135927099003|261022113327099003|261022105027099003|261022115727099003|261022075727099003|261009223027099003|261026130827099003|261026121527099003|261026135527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UGUT9EeMA+KgsyhCzCqqIA3Mpqum8l1niO2bhX3ZYi7v4pT4fhYET4FXSMEm4+KlKc4F5Jl/EEV8s0fDOAJ5MSnkPxfZAEd+EAgpDwqXCq2LAGvoBuLH/8l287d8hEqhcegbbWfUc0xDWj05ztdWTL8TcoKr4fFdPvgc6armJXFCbOHO5ErI3evyNojao+9OBGZFLwJHabfgL0X8rRVLyekBhMMHv1iWxqrUGMgTZxnrwM+Y+/BNnF4+6Qx5jhjlH8/r4cKn91WKWooEZMummbtE+W3eOZKcQRbtioF0oJy8H9cOcLLG8XDPSenVrYxYf4cTNgXhMTnOtxazYDBvAYsESFIjoftmmRvFrmkj5JCuJp3WzmtiOWOzeVmDe2BiRhZcaLYyskU/nHIBKWtJr4UydZzZr3KuzygBKsMiiU5Y5bFZb9iRBiwJhDG/ENTFCYHlJ7v9ymHngUT1OeF9mtvYtG8Cl9r8lhygIIJVBA1iJFBUb8p7SNnv38Zto2ucA3zDBokevx0Esp4WNTJH9D1THW8MN+xsHFnzClDN21e/PjVtJUhyMb5ezuRkSTor1kS3XYhksvw4XCNmGXvBfBoePxO+t6xus74T+HcX+7XXdag2zJvzBIyZG8rAId8f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9060.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261021130227099003)(261021123027099003)(261021121427099003)(261021133027099003)(261021135927099003)(261022113327099003)(261022105027099003)(261022115727099003)(261022075727099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026135527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlY2RXl2MmVpSlU5N3FONkFMdGxmUDJQK2hUMEx1L0MxTVc2NWNKZFFlcmZY?=
 =?utf-8?B?azlNYnNYT0RrNE4yREtrbnNUSXJmNmNpZThTTkZpek81Y014bDlwVXMwZGx3?=
 =?utf-8?B?REVzVlorQU9WcEUxNWNyUXFuUStBTHBtc2gwTlVtRDRsd0o0cjJEWkluMXVx?=
 =?utf-8?B?cHZTQ2tYUkpKRDdPdGlKZGVDM1dYWlA3c29RalRYNEJWSnJJNWZMakFGN2JV?=
 =?utf-8?B?ZlVNbjJFK2Q3eit4TVVldXduNFIyeU5SZWE0WTh5Ulp4Y0FFd1ZOVWZzaWx3?=
 =?utf-8?B?M0VzdGV6ZFNTMTdKUUZ0N0ZGVVpWSU1rUEZnT3ltWGYyQ1RzdW90TklNYitN?=
 =?utf-8?B?c1dXTzNlL2NDblNlMnFuWTc1THk0elY4aHBOVHdkdCtQMjM2a3RyVWhEdXls?=
 =?utf-8?B?V3BLVU05Uk9JR1FkcTdjV3FNSi9PSkxUOE85RHg3SU9lQXZPMHdGQjhjVjlz?=
 =?utf-8?B?bzl4NzJzYXZ2WG14YXcwMjNqK0dVSUhHOU9UQVp1SkZJMHFNNUEvTng5b3Vq?=
 =?utf-8?B?cUxxdUR2OEMyaDNBZkNCYWNMNGFIcFIvVHROQ2d6UkJ5TVlnS04zdGV6OGho?=
 =?utf-8?B?enpuYUtXaU1YWkM1b1ZWSVdpckw2cGVwL1MzQy9VU3RZUG91VWppcS9TUEk5?=
 =?utf-8?B?dFVuMWxCVHFoTUVob0xxOHdMbEppRWJnSyt2QjBKeWQ2cWFGMXgrSkJ5RmpR?=
 =?utf-8?B?QVo4czVyN01CeERJK3VuN21LSHV1dDc0N2I5L05pczdnVGhabU42TFlkREZx?=
 =?utf-8?B?Umh6M3VWNjVHUFM2V3QzdjZnL2M4SzMzUjdja0UvWE9IVThBd3RnMEJ5eWlN?=
 =?utf-8?B?bmQ4VjBHUUY5Wk1NUHBVT1d4NUtVNEcwTDVOS2ZiWjFJSWZHSytFSkVkYmZw?=
 =?utf-8?B?QU0yOThWZ1BxVzFlKzBvMkxYRjNuWjBiMG9VWnBFWm4vUDJiVXNjaExOMCtR?=
 =?utf-8?B?VmkwczZYUkY5cy9Hd0NPMkRXbzlIclZoVnhrRk9DMFdmbXRkRHptdWt6ZkVE?=
 =?utf-8?B?d2ZmRW5SdldrYStMWEZwL1dBY2J6Um5oWURsQ0I4YjJkRzVkYXE1Q1RSczMw?=
 =?utf-8?B?MWpVSWdMakRadGMyU2lzMzlLZiszL2ltOVowTlBrUEdrSzVSQTFiQzFrS1Fp?=
 =?utf-8?B?KzBuSkRKZC9qNndMTG54a3RPUzlmRjNwMUswcjN6bFZpOXlyUzR5bElrYWtl?=
 =?utf-8?B?TDFDQ2dCS3FZTTVaSFRPSzMrMU9PZ0h2eVZSN0xIbC9oTHBHWkpFVXp6VEUx?=
 =?utf-8?B?enl3K0hlRXZicXVpNjNOWWR6ZlNKUW0wdnQvL0k0QUlISTZQc01QOWhsRS9P?=
 =?utf-8?B?UXFnWTBuaFVySHNOS0hjam1yOTNRa0o4MDhMODJaQkh0NEdudC9KTkdxV3J6?=
 =?utf-8?B?ZWROclZUQmwvWDVLZ0hxUktUTHAwVC9pQUQ5bm9ONzRvdHlmb0NMRkx6cGh4?=
 =?utf-8?B?Y3g3S3lBbFFscVdsdVNnTGl5U2JmaU1Bb1V4THJwMWJMTHMvMWZnZUl1ajM2?=
 =?utf-8?B?a0FoL0dtbUFIR0JEZUI5WWFya2RFMFh0MHY0QlFZdnlUWVM4WXhlbWxoWFdF?=
 =?utf-8?B?cTE4NmFGcWNhQWJMY1pKYSt0T1VNRVJWR3kyQnd2K1JLekZ0N28zbTJvemEx?=
 =?utf-8?B?cEFQQjRvRGU5eUpUUVMzbURLT2VuSUFNQXlNOVFHLzdsZk9BbjU3a2RCdk9t?=
 =?utf-8?B?NXZPYjlZVmtaSHpoRWlGTk1DSENYSVFCZy94dG1XenkvV0pPcm9IZHJjV2Ju?=
 =?utf-8?B?WGt3TXFjV0Rlc0RidTMwWVZZRkRQSkVKb20rSTdVWnFucFFWTXkybGh4Vis4?=
 =?utf-8?B?SDM2RWhIOVhLUThqSWRCTURjZXo2K3M5Unh6MEc1TGR5SDNzbERHUW16TjVF?=
 =?utf-8?B?dFdkNzBud2o0a01IYk80eDNxaTB2Z1QvalFXNWYraHJyU0hSUXI5L2VENFky?=
 =?utf-8?B?YXB5REtiL0JBbEFmc29jd3V0dHNyUXNCOTV6WFh1R2NPRWJNZ0JvdWVXcEhC?=
 =?utf-8?B?UmEyWTAzcmNHbUd1REVWajZ3SkpWaGdXeUR2MlN3bm9FL3d2M29BMlZBTksv?=
 =?utf-8?B?elVSOENyUFBvK0JhMi94Y0ZwSEl5VFNMSTNYTW5DNDlwenZCMmI4MjI1c2dp?=
 =?utf-8?B?czlWb3VHaWUvcGltQnM4dXlQWjY3d3paT0w2RUoyd3J3ZU5QSW1lN3RMb3ph?=
 =?utf-8?B?cWFZT2UvMUJNYXNGekE1S1h4YWM3SG9vWXF3MFRiVkt3NFBKMWdqek5hUHk2?=
 =?utf-8?B?UGd5Zk1hWUJiVFpoVFdsalUxY2NYaDdHVGZZSnVnRFZDSG5kK3I1MWNTc20x?=
 =?utf-8?B?a1B6a3IwZk5Rc0ZhTVZjeW8zN2V2b2lreEhjK3FWaGxRZzNSakVvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4555514-e2a7-4ae4-d3c7-08df38b09a5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9060.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:12:07.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vcoSlGLIN5v2NZYjyGI4FCPNGz8OsRyIppD44/d4bOyFsERJy68YagKz/dZGqadyMqDmStA5p8y1dpHUqyFQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819

Hi Arnav Kapoor,

On 10/24/2026 12:26 AM, Arnav Kapoor wrote:
> ams_parse_firmware() allocates room for ARRAY_SIZE(ams_ps_channels) +
> ARRAY_SIZE(ams_pl_channels) + ARRAY_SIZE(ams_ctrl_channels) = 51
> channel specs and lets ams_init_module() fill them for the AMS node and
> each of its children, without telling it how much room is left.
> 
> For the PL-SYSMON node, ams_get_ext_chan() appends one channel per
> "channel@N" child after the 10 fixed PL channels. The binding allows
> reg values 20..50, so a PL node can have up to 31 such children, i.e.
> up to 41 PL channels, while only 31 are budgeted for it. Together with
> the 13 PS and 7 AMS control channels, this writes past the end of the
> buffer. Since the modules are filled in device tree order, the fixed
> channel blocks copied after the PL node can overflow as well.
> 
> ams_get_ext_chan() also only checks the upper bound of reg. ext_chan is
> unsigned, so a reg below 20 makes it wrap and ams_pl_channels[] is read
> far out of bounds.
> 
> Pass the remaining capacity down to ams_init_module() and
> ams_get_ext_chan() and fail with -ENOSPC when a module does not fit,
> instead of writing past the buffer. Also reject reg values below 20, as
> the binding requires.
> 
> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> Changes in v2:
> - Fix the truncated subject line (Andy)
> - Drop the paragraph about an earlier report, I could not find that
>    thread again to reference it properly
> - Pass the remaining capacity as unsigned int and drop the casts (Andy)
> - Keep the ams_get_ext_chan() call on one line (Andy)
> - Rebase on fixes-togreg
> - Drop the bouncing @xilinx.com and @huawei.com addresses from Cc
> 
> v1: https://lore.kernel.org/all/20261021225356.625288-1-kapoorarnav43@gmail.com/
> 
> Compile-tested only (W=1); I don't have ZynqMP hardware.
> 
>   drivers/iio/adc/xilinx-ams.c | 54 ++++++++++++++++++++++++++++--------
>   1 file changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 158e6133abf5..7f0f7778d6aa 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -144,7 +144,14 @@
>   #define AMS_PL_CSTS_ACCESS_MASK		BIT(1)
>   
>   #define AMS_PL_MAX_FIXED_CHANNEL	10
> -#define AMS_PL_MAX_EXT_CHANNEL		20
> +/*
> + * The external PL channels are addressed by their channel number. The
> + * binding allows the range from AMS_PL_EXT_CHANNEL_MIN to
> + * AMS_PL_EXT_CHANNEL_MAX. AMS_PL_EXT_CHANNEL_MIN maps onto the first
> + * ams_pl_channels[] entry, AMS_PL_EXT_CHANNEL_MAX onto the last one.
> + */
> +#define AMS_PL_EXT_CHANNEL_MIN		20
> +#define AMS_PL_EXT_CHANNEL_MAX		50
>   
>   #define AMS_INIT_POLL_TIME_US		200
>   #define AMS_INIT_TIMEOUT_US		10000
> @@ -1142,20 +1149,31 @@ static const struct iio_chan_spec ams_ctrl_channels[] = {
>   };
>   
>   static int ams_get_ext_chan(struct fwnode_handle *chan_node,
> -			    struct iio_chan_spec *channels, int num_channels)
> +			    struct iio_chan_spec *channels, int num_channels,
> +			    unsigned int max_channels)
>   {
>   	struct iio_chan_spec *chan;
> -	struct fwnode_handle *child;
>   	unsigned int reg, ext_chan;
>   	int ret;
>   
> -	fwnode_for_each_child_node(chan_node, child) {
> +	fwnode_for_each_child_node_scoped(chan_node, child) {
>   		ret = fwnode_property_read_u32(child, "reg", &reg);
> -		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
> +		if (ret)
> +			continue;
> +
> +		/*
> +		 * Anything outside of the range of channel numbers allowed
> +		 * by the binding is not a valid channel.
> +		 */
> +		if (reg < AMS_PL_EXT_CHANNEL_MIN ||
> +		    reg > AMS_PL_EXT_CHANNEL_MAX)
>   			continue;
>   
> +		if (num_channels >= max_channels)
> +			return -ENOSPC;
> +
>   		chan = &channels[num_channels];
> -		ext_chan = reg + AMS_PL_MAX_FIXED_CHANNEL - 30;
> +		ext_chan = reg - AMS_PL_EXT_CHANNEL_MIN;
>   		memcpy(chan, &ams_pl_channels[ext_chan], sizeof(*channels));
>   
>   		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
> @@ -1183,7 +1201,8 @@ static void ams_iounmap_pl(void *data)
>   
>   static int ams_init_module(struct iio_dev *indio_dev,
>   			   struct fwnode_handle *fwnode,
> -			   struct iio_chan_spec *channels)
> +			   struct iio_chan_spec *channels,
> +			   unsigned int max_channels)
>   {
>   	struct device *dev = indio_dev->dev.parent;
>   	struct ams *ams = iio_priv(indio_dev);
> @@ -1191,6 +1210,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
>   	int ret;
>   
>   	if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
> +		if (max_channels < ARRAY_SIZE(ams_ps_channels))
> +			return -ENOSPC;
> +
>   		ams->ps_base = fwnode_iomap(fwnode, 0);
>   		if (!ams->ps_base)
>   			return -ENXIO;
> @@ -1202,6 +1224,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
>   		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
>   		num_channels = ARRAY_SIZE(ams_ps_channels);
>   	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
> +		if (max_channels < AMS_PL_MAX_FIXED_CHANNEL)
> +			return -ENOSPC;
> +
>   		ams->pl_base = fwnode_iomap(fwnode, 0);
>   		if (!ams->pl_base)
>   			return -ENXIO;
> @@ -1213,9 +1238,14 @@ static int ams_init_module(struct iio_dev *indio_dev,
>   		/* Copy only first 10 fix channels */
>   		memcpy(channels, ams_pl_channels, AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
>   		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
> -		num_channels = ams_get_ext_chan(fwnode, channels,
> -						num_channels);
> +		ret = ams_get_ext_chan(fwnode, channels, num_channels, max_channels);
> +		if (ret < 0)
> +			return ret;
> +		num_channels = ret;
>   	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams")) {
> +		if (max_channels < ARRAY_SIZE(ams_ctrl_channels))
> +			return -ENOSPC;
> +
>   		/* add AMS channels to iio device channels */
>   		memcpy(channels, ams_ctrl_channels, sizeof(ams_ctrl_channels));
>   		num_channels += ARRAY_SIZE(ams_ctrl_channels);
> @@ -1245,7 +1275,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>   		return -ENOMEM;
>   
>   	if (fwnode_device_is_available(fwnode)) {
> -		ret = ams_init_module(indio_dev, fwnode, ams_channels);
> +		ret = ams_init_module(indio_dev, fwnode, ams_channels, ams_size);
>   		if (ret < 0)
>   			return ret;
>   
> @@ -1253,7 +1283,9 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>   	}
>   
>   	device_for_each_child_node_scoped(dev, child) {
> -		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
> +		ret = ams_init_module(indio_dev, child,
> +				      ams_channels + num_channels,
> +				      ams_size - num_channels);
>   		if (ret < 0)
>   			return ret;
>   

Thanks for the patch.
Changes looks fine to me, it is properly addressing the out-of-bounds
access. I think the underlying issue is also in the DT binding.

ams_init_module() already copies ams_pl_channels[0..9] as the 10 fixed
channels. Inside ams_get_ext_chan(), since ext_chan = reg - 20, DT
entries with reg = 20..29 map to the same entries and it create
duplicates.

DT binding requires update to allow 30..50 for external channels. This
gives a maximum of 10 fixed + 21 external = 31 PL channels, matching
ARRAY_SIZE(ams_pl_channels).
Please let us know if you plan to include the binding change, otherwise,
we can handle it separately.

Regards
Sai Krishna

> 
> base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9

