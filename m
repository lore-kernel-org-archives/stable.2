Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057863B5850;
	Tue,  6 Oct 2026 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287516; cv=fail; b=grPxsVrX+artaZ+7jJXEmwgcL1EMP1bpK6HAxYJpOcMs5PsalqW/8ggWX5w90osl+Wy+oZsUv1WRTt8DprBYXJVce0YQMwG3fGWXzR03gWZLgsbxEx+PHFLM7B168HL9w/gPHnTCWxgMsX8dujWYlT06WVBer+S1abbf/qEZS3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287516; c=relaxed/simple;
	bh=WQ7Zqm3gLIMuorfvtpQmX9BSViOPnNnftNCswIBGYgU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f5nGG2Weq96q4RjzURSSdOL2FR3QA4LjotK5i1TKOVjayy3QYaWhTRXF/3x9uFIFKEfZvnw98pX/0OOySTmcZ7k6hNcpW7bOb0hHSaKi3tUlM59S2+ClFmTQZdaCatFAg0stehTMnRlKfSRk92YgpDlrKLLCrudUgLaaXyG9SJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1X7SXL8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1X7SXL8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791287514; x=1822823514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WQ7Zqm3gLIMuorfvtpQmX9BSViOPnNnftNCswIBGYgU=;
  b=e1X7SXL8tahYRJCXwzhwyalpCa4onARJWPD+pNKqdAG92HgygAr31/Wp
   1myMr9mP1h+28FZ0tahVdHeyjVKQppNE4YUbMl3LHAvklSLaLv+XHGXov
   LUJjnZA5V9lTSjjGhAQTnrQn+vJABDEwGuLaRkz0DKbEXegoKGvwEmR1Q
   f99OxXvJ3wHE+DkWvYs9XjG+5zgrIPQYFwdFT/JwnfMQ9J7+94P82tPYc
   pcfNGAIIax//DhMuJnrngf/fhgD6mUgEuPWmZL26MOb6QMdyoIIlOWWbc
   2CJK1yHEC4RvCrBtE00pyPMzJKzMqNE4eTkc6t4pX41D7SgZwHNT7dYlE
   g==;
X-CSE-ConnectionGUID: uNajoZojSEqQoAAR5QNmRw==
X-CSE-MsgGUID: IbreA8ppS+a0LwaDRxmFXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="29092"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="29092"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 04:51:53 -0700
X-CSE-ConnectionGUID: /Z3fk71GRJCZkiXLxuW3UQ==
X-CSE-MsgGUID: 5cJHlerPSnGwxN18na3WdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="315151489"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 04:51:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 04:51:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 04:51:52 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 04:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdNTwBMkIEaAwD8uAjxr1YmXsz9iBxhIIOZA+F2yhlB3DX8M4BRrOkn/Lg7bq/+vKZlq6h1DL6DUPD9AICPGi/JphnDPSIAqoM1cWW29iNRiJ7CWb4GN5eNUYwF1TJ7xBR+wybKUJCIRAN7L7qmrDYDXa4D2gtn4qsivgX3E66cm55emmI3kUiCuMRV56ZYXXciOXKgWxftXsMJ48A+4QdxgHDc+oNRFza90tSZ3s6muSSkWFYj3x6ScuhnyE9AvFkRv6bp1zzQ0uT5nueloDoxglDcDjeRME1BQ6JU98GN+WRVyT3kphsCtc6s53w9RdQCuktNin9HvLJgu1EMdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIWJGS9u7UXs0d2xEM/4BNo4y9HrhTyCSMLXKj8YmFk=;
 b=Ixk8AfB2j6fDTfXsJ2/5IK9VZMwPQsDLqMR69yx6MnpjfLpWQXjQrI0dsWjClhZnUHyqKVkxUvHM0Yih9trUecwrvUUaFt9b54TI8o8mOKxSeJ0Qp0Dbh7Be8jWxH+zmh+1yPLyzjqai//DrjSPoFod3Mzvq/hcW/FcKAOlBxeFMRYUrnMocSeDgcTmY7jZt5SPBb3JkiQJZ+N63cDT4bClyFry55IQKEZjHM8YCOXs3khcXCvpml5w6EI32Q0xNuxNuxyjUdZaEiDcS9j7+n9FL7P2NTE57gUgiTQe0ErM8j3euHRvwGNpTca2HVM3NyGCJaevltNIOIUoo8rH61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB6970.namprd11.prod.outlook.com (2603:10b6:806:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 11:51:48 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 11:51:48 +0000
Message-ID: <13319d31-c7ac-4b78-a8d1-3f764ce57204@intel.com>
Date: Tue, 6 Oct 2026 14:51:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: map unsupported driver type to
 Type B
To: Ian Ray <ian.ray@gehealthcare.com>, Haibo Chen <haibo.chen@nxp.com>, "Ulf
 Hansson" <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>
CC: <stable@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-mmc@vger.kernel.org>, <s32@nxp.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20261006105301.996-1-ian.ray@gehealthcare.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261006105301.996-1-ian.ray@gehealthcare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0243.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fca1d9-fa2d-474d-8227-08df23a033b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|56012099006|11063799006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: a19p90rFLLNgsa7OAxJKBAEt7hWMA96V+iMiDb6T7aJXH/6WrBYL3MXX73qpqvkc2ZK4t86htAuiPWSDn2r1o4oTC1pVjkqb55No7Lb31ryx7WtfGtH9CzvtV7uMTw42OvozuV4rOp/9E0bh6uQ86WbU8sIvI1mqvGjClhMHiARjBDz1LvqW8tpmOFG3LQLIhNsmK228nH3QMJFFMmNHf6iMI+zALyGkhDj5ZGp5AVlqtZ4CE4ABTT4mBbhliLU8xF1yUApfDbCpHJtW8MIDIegUmP6mVAggy5+pws77QnNX8I/vNnuZJvSyaAFw3knF9/AJy/KPBS77Mg/cHdd8U+B/FSq8uIXrqFbLYxOzl+CBjK3lvlSW6m5pI6WsifuGHr9z6b+TStcDjtwlydSIaHaO0SpatBL2Ho3H9e29ZtABqQQwCN6G+yXpkthgrJCK8pklHYU4Z1mdWITdqjQ5RE7qumNiir/Y4hHtL9bH13ghlCcOnlHOws3VwogBzfFhbWsdiNwYw/GdsFQBkmiFXzuDC1ozPrdJiwlCZN5pYobIqjCOeKtAmbadTBSWcwSnF/5MxL3l/Z7cqdKRwSyshY4wQaAuLvsX/87GTuj0Exi9uQnvqL94ssv/JiGtmjHx5OOkUeStMI/daBW8IojxKydsgs9AYXVsqzV5Z0KrHhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBkcDRvV0R0WlljZlROM3R2SEpMSEgwMVlDR2FRRkdkRHJ1TDFucGwvcFBU?=
 =?utf-8?B?OW1ER2lsN3NGb1FkcDl1SEgxWUVkMjQzeDdFaXhTRlBXUWlFa1dQSnV6MHdI?=
 =?utf-8?B?TU1qcmRkc1dEWHh4MWpLck1tUWl1RzdiMTJPdWlIVFpBVGxJZGc1WEpQdU00?=
 =?utf-8?B?U3lzRlFmYzBGWTFDSmNORVVweXdRS0hOay9lbVJIcXJ5Vk0yck9WcGUxQU9n?=
 =?utf-8?B?RUdObUd0OEhxOUlSS0FxK0pLd0dGQTFYKzIwV1FENXdGVCtjRy93TGlHd3B5?=
 =?utf-8?B?UmZzVWN1NTFIZlJCeUxIRzhZemp5TGZEeERhK0djOVpUSkNjakV0WUx2VVNq?=
 =?utf-8?B?aVAyMWlYMUpweE5WdHdGL0dlby9yalZFaXRvajErYXBnZko5a1hTclBJVWFl?=
 =?utf-8?B?YW9sRkppNjlKRGNCaWZjK0oxNFd2ME9qcjcvTVJsZVJyVFFLbkl2QVZQa3hK?=
 =?utf-8?B?ekJqdVJRWUc4Nnp3ZVZWSzFZbEdYZmpqZm1sTUxJcFRVUFpDSEQ3R1lQSGc4?=
 =?utf-8?B?TVhrYVhtWldaQVk5VGVkVmM0Rks2TGVUcS9INEJqaEdQM3pCQkM0d1RobVVH?=
 =?utf-8?B?VDN6aWMra0JaaDdoSEYzT283UUJWaksrNi9PWGdsWVIxbjN3M2JVRXlNZVlw?=
 =?utf-8?B?OE9FeFYxV3F6ZXlhWktyRXNaMzJUMDN2ZHo2L29yS1AwcUhBbkRsa1NMU3kw?=
 =?utf-8?B?MGlQTkhtdmNUSjBiZzdzdzh0ODkrZFBCbDJCYkFNd0xPdFIvYk1ITENBMVJB?=
 =?utf-8?B?UVBLU2lwU2ZkcGp4TkduVmhDTEYrUXh4aFJYNWthZUlQcnlsYVVMUnNWY0Qr?=
 =?utf-8?B?ZHA2aEZsSlhqWGhxZHc4Mll0S1NVTUFKcFNKbVlWTFhzSDdubll2N3FFSkNn?=
 =?utf-8?B?Mkpsd2RtM0ZGK1c2ck9qczNVVHFUVlFqMVV6SDgyVGF3WWFuVUcvc0xTenZs?=
 =?utf-8?B?ZGUvcEI1aXllZ3lRd0Y5L2FEVlZrM2xjLzlTSXp6QUdsT3RUTjR2dXgvSjVR?=
 =?utf-8?B?NWdFQ2ZKaVIvWTg5RFIybFE5Zzc5Z1JpVWtoOTZ6dTdSdytrNyt2RndWaTJE?=
 =?utf-8?B?YnQ0dTJuK0V6cVZkb0hYWEpVaGgzT01qVlN0dndqUm1UY0NSRFdjVFdiNnZZ?=
 =?utf-8?B?WXZjbkdIZXNXYkhNUmJhbG9KR2VBMG02NDhTTmpwUFI1SmtKMlR0ZFBzOE9s?=
 =?utf-8?B?ZUFMell4blI0V0ZwdENIN1gwNStYSzVuMWhlZktXanh4OHFrdFVKNlgrUC9t?=
 =?utf-8?B?L2w4SGh4WWVoMWJreUZPOWsxSktuR1Jva3ZBWEdCWmZHS2VBUHZiSzFoQXBm?=
 =?utf-8?B?aWFkUWxYa0FlWnJJTnl0cG9kSWlJU1I0dFBIMi9LQXBHTHdZWXpyUDVLbmR3?=
 =?utf-8?B?Q1dCUkZZT2txaXJvZTFMMHVxS0pnbXgwdktGNG53YSs4R3d5Yk1WOWpJRG01?=
 =?utf-8?B?VWdCekgwM0pNNUtRNUlydXlZR1ZIZEt6VU5SWTlydnFjMDcrTTVsS1dHc09u?=
 =?utf-8?B?ck9wMXZNTFc3RTE1K0s4SUxla3JmUUlLeFZ0VVBNSzB2bFQvOGxXV3ArZmNU?=
 =?utf-8?B?dTFKa01uTERnLzR5UFNDQVhKd2Q0TlUydDYxY2h2dmZrbEdqUEZ3ZzYzMWs0?=
 =?utf-8?B?eW1OcExIY3FZYXp0ZUNlNGhhMld6V1BHUnZGUm92M1c0Rzh1eXMwamNGMEt3?=
 =?utf-8?B?bXo4WXllU2kxUW94eXdtVlBDWFpuY0tXeERSUTBnZTdIZDE2cXNwN1FNS3FM?=
 =?utf-8?B?cDczMVhSV29uQ1c4Sm94b1VrbVczVG1iak5tSU1GOWViUDlISW1ueEszZmlQ?=
 =?utf-8?B?d21DQmcwNGl3Y3BiVFlEc0x6eHI2QmdsT2FJQ0Yrc0htZ0lmQXJzQ1A0MFRk?=
 =?utf-8?B?Uk13NEhMdGRrcHZ2TFhKRnUwZnd1YkllSElwOFFQSXAyY3NXNWYrcDNaSmlI?=
 =?utf-8?B?NW5BR2tiaUhPa3BwWlRiaGd5SDdJVU5KQ0dHZWVBNjJJUVBaY0JueTloRUtO?=
 =?utf-8?B?NXEvVE10d1JhTFZGOFJGNnFiVDV1T2pSR0swWnJhREtoSVB0d0tyaG5CSjVR?=
 =?utf-8?B?RkVOUmx4NU5FZmNKdmJTSGg0TG0zSU1aYXJLQUVtNStKUFQxSWFjNmhJVTM5?=
 =?utf-8?B?cGhvTEQwUXkyOHMyQUtuZzdyTllqK2xJUDIrVFFnWmJhL0NnNm51MGNVR01a?=
 =?utf-8?B?UVpMcFJiaVUzSzFvZk1SM1dkZEJSSjFFTkJxUVVBWU1sTGZ2bmV5RzRnY01j?=
 =?utf-8?B?TmVyQytXZExqVUZpbW1FM0JjY1V1REs2V0FoOHNqYkZpNmdxN0lub0kvL1p6?=
 =?utf-8?B?eWh6cEpZbVV2cnhYYW5PRXJjcEVNNkR3U1Bma0NobjJyS2VZeFhnUjhpUElu?=
 =?utf-8?Q?nGVgJkIAZDwPz9Ko=3D?=
X-Exchange-RoutingPolicyChecked: eej3SHAGfPhGplqcz5nXs/E9Jf9LinV3RX0ddNSYcMGos9qwybPoyFa4lNq7agR+646XR46lEggehK0CobMDM14LyZqq/Kk2kuY2YB0M9NjVc45jEtif2LRiNcxL5BpAqFA/5ZaJ6qXs6N5gkIveqYp4BZGsoWkEpa05rwSV223wzcx6FbrWqHqNTeSTGWHlcZqzLU7HGVPnJjt5Ee15TSvn3ldvDwWnwYEyKAvls0xBEsSjbFZGt1Cdr9cqxN7IfQfGFUJLZiOhIhjIJCVnEIGtcwr1dn515KbB7Bed/L3Vkbl6Tz8tkGpWcEMDegMD01qn93BF6wZzJjvSNM1ovA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fca1d9-fa2d-474d-8227-08df23a033b7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 11:51:48.1597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWhPTlGDHQH3sFvo7302Y1s1HXx+QmBam9w3cpUbgymbzy5WI+TAc2+lbo6gfaqP0Zt7m5cKBucyx9KL7dt9dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6970
X-OriginatorOrg: intel.com

On 06/10/2026 13:53, Ian Ray wrote:
> Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
> for fixed driver type"), the eMMC driver strength is passed directly to
> mmc_set_driver_type(), which propagates the value through ios.drv_type
> all the way to sdhci_set_ios().  For 40 Ohm driver strength [1], SDHCI
> correctly warns:
> 
>   mmc2: invalid driver type, default to driver type B
> 
> Hook ->set_ios() to map any driver type value outside of the SD-defined
> range to default Type B, so that SDHCI always receives a valid value.
> 
> Tested on i.MX8MP (usdhc3, eMMC in HS400) with
> `fixed-emmc-driver-type = <4>`: the warning is gone and the HS_TIMING
> register contains 0x43 as expected.
> 
> [1] 'fixed-emmc-driver-type', see JESD84-B51 Table 206 and
>     Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> 
> Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
> Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthcare.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> ---
> v1 -> v2: Move fix from mmc core to sdhci-esdhc-imx driver per
>           review (see "Link:" above);
>           always provide a valid host driver type.
> 
>  drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6ab59d3e346f..33f63c6dc8ce 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1142,6 +1142,14 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  	}
>  }
>  
> +static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	if (ios->drv_type > MMC_SET_DRIVER_TYPE_D)
> +		ios->drv_type = MMC_SET_DRIVER_TYPE_B;

Looking at esdhc_writew_le(), it seems that drv_type is not used
at all.  I'd prefer:

	/*
	 * drv_type is not used (see esdhc_writew_le()) but SDHCI rejects
	 * non-SDHCI values like 0x4 (eMMC 40 ohm) passed via device property
	 * fixed-emmc-driver-type. Force drv_type to an always-valid value.
	 */
	ios->drv_type = MMC_SET_DRIVER_TYPE_B;

> +
> +	sdhci_set_ios(mmc, ios);
> +}
> +
>  static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -1949,6 +1957,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		 */
>  		host->mmc_host_ops.init_card = usdhc_init_card;
>  
> +		/*
> +		 * Validate host driver type.

Not really "Validate".  Perhaps "No SDHCI driver type control"

> +		 */
> +		host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;

Does this need to be conditional on esdhc_is_usdhc(imx_data)?
Seems like esdhc_writew_le() is used and drv_type ignored either way.

> +
>  		host->max_timeout_count = 0xF;
>  	}
>  

