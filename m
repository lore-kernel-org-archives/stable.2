Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793564911;
	b=UvPH4KcAEU79HPon58QNP6He4pZUCRBwkPUWubvXPytzUpWlfQ/uxL0QnI3lQFCwajH6
	 mxTk+hytaEotdgniNBVde2/Bxm0iAzmdH6rsgr9D+t6Re1rEzHQpzG5EfzgqNaA98gYxk
	 KrEPwdzTYu1VawAOcyHJn4N3hnEfPm0XC+RvGmoOOYSiSd6NPpJKInpD/1+Ilu2ltENtu
	 XmVp6+hoGqw6Hvt9n69b1gDQkoT12Ur+P0qw2Ecbji9zfAPJ6KzhH5FiNR35zO4YMMT3r
	 gJ3d5IA9n67H/3W40/hrEtZSJnk9UM3O9HJp07tnHE5Joub5+wj/e/D4R3BZfOXqv6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564911;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:From:
	 Subject:Cc:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=HGNdihntOlDTAftwVOtuJXV/f3ZzWcT7Yc2qDCWMRoQ=;
	b=Y+jgXo3h+xO81kFKBkhUoS0Qhz0wbi6SGEneO9hWIMfvgp2O7OLUAAiEmYlV1nttDTsX
	 r3FqJqul4tlcl0wtcNR7WqScGETL7qQ/aPWrWAwoowr3yAiHh1eoBOX/CyDNccmPi4ddc
	 b5+kx+ZqtlmmvQk/rD0FuEI9nTA/WI1Zd8jKHj/UuOPecIRAvwD2sSAsSn77FnV1y0gLU
	 bmY6yCvEYrclTv3vXMuCuYh/RDpy+pq1tIQYsgu14tsl8kTByy4TMcY5p/nNfG9rUe0tf
	 b/erV2KP5oaVASFZmS330ZETe8eRKH90fHKb25SXV8nvrcxXdFaIMmnEJE++Fn3fQ6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XzVgTnjY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.12
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B2606A324;
	Sun,  1 Nov 2026 20:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B2B2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XzVgTnjY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItAWphcbtYIFnjbMn6WF3VejTa609ZD4tKCUn+E6KRA1J0SpHIBlhfo9ASSMg5BBp+Oe2teqPv2zB1y6E7T5KxYsbTqlALageUbzb8dq6Bygpgl3E7I49mr/547DZk7exRPurMUqI5c0f9atzcHTu1zORAtkX03tUNE+8Kyyz/8W6T01LIv9KqXrZfbN+PJ5sccyB0T5JYHLnz/IaKUHrVjA3Go1aArOz5VCw6hcjE1YmmEBJgC4ZbCZND5hmlVBESGMUDUF9Q1V/YtHrkTKBMA7XFYZ9HjL071JZf2zNxUWe+Jf5DOvZDeBgA3t6syxg2K0woysYKkQSzpC8h40Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGNdihntOlDTAftwVOtuJXV/f3ZzWcT7Yc2qDCWMRoQ=;
 b=eCOZ0H9qNaYijovotQqJUyiCz0rbv9yfafyEtGTxpLWnIHQHSUViql70XBSpapqIC9v5iXRl3ilgBp0DCTv2+t6ir3lcOp3p6okpiHNozLtHma+x0HWYIgoRkR1Q+Fgc9MUA6OHIC1u2rkNB/bkyUZgekH2VHHG3oNRs5wlGqOKEGxObpbOzRO+WLUZmQMxL7n02md41yxhQlvZixRtDsIN9kZLdgO1IRa5e3gJ6LSzNGhBtZfjHZLEml14n/91nXHYFnEwoU7eZJ+RtI1bKKgegN/JpDJoOMBOzrMbWjB5QQQsPtEaGF4Vtz2crBHa2kb5NVYwtSMgVkvBWlffA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGNdihntOlDTAftwVOtuJXV/f3ZzWcT7Yc2qDCWMRoQ=;
 b=XzVgTnjYya2bJY4/hd3Oulcb/+xU215MtXchbDLTsBwdOgoFH3qr27nHdLbDAYegenAnaAlLzsI2Ne5+n5zbkaltzJcpD3n1k+f8ilsgvmqNUU/BddXw7saXEiyj4nsT4hbEh+ehjaJsDZsurZAjNc0gBTIjjXDP+ZvSoTNTgOKc3Oa8KUPNbLNeRYw/3zz602OO5FG+yJ/qW5omTQq7KLN96AonHSqelzMWpoyo9+WFQOu/uY2Gyor5CWbsqcoslEVOx7cN5PsGS79uKnmKQ/12yQI76NjWc/3Z7YO29gbzBuKTNx26je8VVkwVfeaIsc5AvP2W4BG+XEVvFxPyWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 20:28:22 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 20:28:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 15:28:20 -0500
Message-Id: <DMK5P0HO603L.36WWXRPCO12YB@nvidia.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v5 03/12] mm, page_alloc: pass zone pointer to
 trace_reclaim_retry_zone
Cc: <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>, <akpm@linux-foundation.org>, <david@kernel.org>,
 <ljs@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>,
 <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
 <kasong@tencent.com>, <qi.zheng@linux.dev>, <shakeel.butt@linux.dev>,
 <baohua@kernel.org>, <axelrasmussen@google.com>, <yuanchu@google.com>,
 <weixugc@google.com>, <baoquan.he@linux.dev>,
 <baolin.wang@linux.alibaba.com>, <rientjes@google.com>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <muchun.song@linux.dev>,
 <osalvador@suse.de>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
 <ying.huang@linux.alibaba.com>, <brendan.jackman@linux.dev>,
 <hannes@cmpxchg.org>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
 <nathan@kernel.org>, <ndesaulniers@google.com>, <morbo@google.com>,
 <justinstitt@google.com>, <Bessel.Wang@huawei.com>, <jiang.liu@huawei.com>,
 <mgorman@techsingularity.net>, <anshuman.khandual@arm.com>, "Josef Bacik"
 <josef@toxicpanda.com>, <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-4-gourry@gourry.net>
In-Reply-To: <20261101021340.2251928-4-gourry@gourry.net>
X-ClientProxiedBy: BLAPR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:208:32e::31) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: f20a3f22-0ef5-4c72-da4e-08df3856ac47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hmcsXgtq/JLmcenmbV5juuQZ6uvcUHlFjrtbK2hSIHBn2+1b1nCpEgCvEntP2x2c4b72lOjXu2A9iPAUCkaxECHo1kAK5h5PwiadAGsi4E4Lpc+pFrdt+xqSNJ/97CxxaNcar9mdQjex9yqFrOfH/m9hEyHbmimYnfCsWGu24XR106z3WDofz0Hm13NC8U+wAUuhpoK16nIR3J3lg31Pfd+pJgw1Ob+x0qhE7pJB6+ISgKNLGM43tau53QuTk6VxEqZeS2Zl+wGhgbIUtSaYdRYLpg38gw6uEtLY7SqqCxgJ/O0z8KYbuzlMjRVwZERZljG1cTA24YeyBrnkH02i/y/JXvVek8JIfKOzJ48TrEdZwM7sK7dj9OLoeeGWmiRdH6cOzeZXfLMTuLTNFF6DgER8jKJ41Okf5QssKqy62uPaFxhJCKsLCT5VaZUgTO58F6hICV4YXad5OCO8Po86/elwEptzGiL4nzDb6dQc+LpF/+8KZJ9Lsx2kdeuX/O05cboIfWEZ4c+dw4jfpTxZzTPBjaU/KQUbmNlVJUFrXkKf03rsEXsjCGUsCVD/YnJzu1O/SPxYCT2nGQB8ARIHxWgIK0lcBMKnvRJhR8M3VPmghnIwjWb41u8Zelv+tT4FNE0f8v7aoWrDrsW7NHhc8+9x4J80YKTq8dd2pFSZpKg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elhjSm9mM1N0TUJjSEs2bDFsMGF2M0xsKzFrOEI1Mzg2NGJuTnpwenVlMDM1?=
 =?utf-8?B?UEw3Z3g0c3AvVGI2Mjc5RDF2UE5PNGo5MnRLa2M5bDlUWm9lbVRXYUZKSFkr?=
 =?utf-8?B?NC9tdW9EcFIraDZyS1ArVWxLa2RreHBLNitxemJ3QWxEQytBTkN4d0ZKSWhz?=
 =?utf-8?B?R3JxeHZ1ekY3RUQyalVsbEhCR0VZcVptQkdGdmZXb2Q0QWFLM1hHdDJMYkRl?=
 =?utf-8?B?RXlQRVZocHY0OTJSb2F2K2FzSjZHSXV2dEhVMzNQYTJxaDJMeGU3Y3dNOWZX?=
 =?utf-8?B?WmJwWjQvNjIvZHNNc2tnYjBhVVRCQzJ0U1FrUkVjSFF3UEp4VjNreGpDRCsx?=
 =?utf-8?B?YzNOUVFNdTlZMXVaVGVKYTJ0SmpjOE92MDh3Wm9nNFVQcStLWml1UUxOak9U?=
 =?utf-8?B?NWcwV3kwN0toSzErTzg1amVMTzdVT0NNN25IZ0xOSnFPc0lzMWx1cTdCeTFn?=
 =?utf-8?B?ZGJpT1NCY2VFNTNjUEM1ZE93bEdRbm9KZWViMUJja0Y0eU9Ka1UxdXUwOWxy?=
 =?utf-8?B?eHNldER5UkdETnBIakxldnl4ZmdZOXRsUGphQXdpa0U3N2pLeW5YdXlXdmJq?=
 =?utf-8?B?aHc4QkRqNm5JZjIxaW40cDJyMDdSTytSUkZ6RXVJQTJOV0NNNnF4L01kOTFU?=
 =?utf-8?B?L2trbjJ1TXNIaHNTbkdwU3ZLalVobTdETGtFUk92M3BCYllDRVNNb05hZm1E?=
 =?utf-8?B?STZ2b1BDSmJqY25aZmhudlVIZzZDWnRjMEdNQWVwR1RiZE1TRldIMGdOWERF?=
 =?utf-8?B?ZGcxb1VjQ1plOFlteVZOQ01FaTREWHVNWCthTWU2Y3NJZXZoK0ljcTUxRjQ3?=
 =?utf-8?B?OGRFTG1GcXhiaWhZN2RObC9oTUM0eERORWFTdWdyTVhTS3RJM0FIMTRsK21O?=
 =?utf-8?B?a1JkUWJuWFovQUJIK29MRmVYeVE1RkIzbnpsdVZ1N3ptQlBjdU9HemVwSVQw?=
 =?utf-8?B?RUZ1bERvNVJRUzlhMUttcUVjeXAxZy9SWTFCSDU5UVk5Y3d4SzFkSDNzbk5X?=
 =?utf-8?B?ZFdzSjV5VkFVUUxzYnREeXpvS2ozTHM4VVI1ZnkweWs3UVBQekZ3ZGFXVjU0?=
 =?utf-8?B?ZXJtVUdxZk1SUXNxeDBITVJkUWtoWmdmRmN2S0htM24yYnpwY3JYRFFBS090?=
 =?utf-8?B?aEpEMGY2L1VpN0MreFdPeXkvUk83dkJQNmZuckVBVFc1d05KaldScUxvdjZi?=
 =?utf-8?B?a3lCUVdVMkVaZHEzRHVZVytta25Vb3ZKeUJXUEJsOTVDVVl4TWYzMnBjTjV1?=
 =?utf-8?B?MlpWd3FEYVoyc0MrL3UvYW5FYitrVmNGMUR3K3I4eWJjVnFTWlMyYU15MjJR?=
 =?utf-8?B?dEVGRWdqWjBjY1l3VzFQdDlVUGNOSmZqS3lJLzcxQUtVODVOQjVNQlpnVG5Z?=
 =?utf-8?B?ZXU5dm5UTFhwb0xOeUZZaVk0MmFIVEo1ZTdkWlArRnhNSFlOd2g0M2RmN254?=
 =?utf-8?B?bVFMcld6bEVEK0VhalpWRjh6em9WVjZURVFCeDJIeXhRRzlRS2JjVU1tRlVj?=
 =?utf-8?B?R1hTaDNEUmtielIydit1TGxmRDdhbmgzcFlKNjM4QTUzRFNGbTlrQy94V29W?=
 =?utf-8?B?OVRsNUV3Y1NkR0dTZXhxUjJHeEVsalpJVWJhYjIzTHJGV3hDTFR3NFZqMUdD?=
 =?utf-8?B?Nm9aS3lVME1RZXFhLzUvcklKYXZvYzFqTU54dDRHL1hyYWNYcFZ3NEJ0Mm1y?=
 =?utf-8?B?S1JaNG8yc0UwMWkvR1ZSNm11dVBJcWFXZzZmM2tEY3BtVlJxR3NZZjI0VmVt?=
 =?utf-8?B?MWJiZ3pLSXk5cjhJUzJpZHdrcE1YTmFqemdlOHFiRm1oTzR4MG9kZGFKSGxO?=
 =?utf-8?B?MnZxVjdkWUJwaEdOendzY2xSY3A3S04yMnFyZjk0WmRsZFVyVDhMVVRmUTZt?=
 =?utf-8?B?NFMvSFdZNUowL0ZVQzFqTDRoMDVIV2J0eFRsRGdDUmJicFRFZzFwNE5sazYv?=
 =?utf-8?B?SEo4ZFVHLzNoKzY0cU1saG50NUlwMkVMWEpWREJzeTdHMHRyYlY4TTZhS2dG?=
 =?utf-8?B?a0xoajFoVDBZRk1TVnNrQlRCWW1Yc2Vvcm1hQU5TRE02ZTBIaktuUndYam92?=
 =?utf-8?B?TjFvUXFBcjZWeXF5ZnFBRC94YTVaZG5kSmJ1RG5wQldlQ3hzSEFQaVQrR1Rj?=
 =?utf-8?B?UU9XbjlWLysxbXBBaDNNeGpUdXI4REVnakhXYSs2SC92cVlPcHNRVmVaQTk5?=
 =?utf-8?B?WG1vVTk1b2F2TFZ1WGRiUVdrT2JQYTVHVlZWNjdVSnhCUzJUaHp3blhzaWlp?=
 =?utf-8?B?V1k5cTQ3UzlJdWZmdVluUnVDQWw1cFBsTVQva1d6MHpRU20rOWlxZ2xHdlU4?=
 =?utf-8?Q?ZXxwspwyOuPiSj9eKM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20a3f22-0ef5-4c72-da4e-08df3856ac47
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 20:28:21.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rtgbw16iX7cCeN79UUkR0sbAxNu+MJX7hzLMNMVneMZkPZBXuszn4aY13g3vUPL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452

On Sat Oct 31, 2026 at 10:13 PM EDT, Gregory Price (Meta) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> should_reclaim_retry() walks a zonelist and passes the zoneref pointer
> to the reclaim_retry_zone tracepoint, which loads the zone from the
> entry again to find the node.
>
> Memory hotplug rebuilds the zonelists in place while allocations are
> under way. When a zone in front of the zoneref entry has become empty,
> the entries move up, and this one can be the end marker by the time the
> tracepoint looks at it. zonelist_node_idx() then dereferences a NULL
> zone. Short of that, the event can name another zone than the one its
> numbers belong to.
>
> Pass the zone pointer instead of the zoneref pointer.
>
> Fixes: d379f01de095 ("oom, trace: add oom detection tracepoints")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  include/trace/events/oom.h | 8 ++++----
>  mm/page_alloc.c            | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>

Makes sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

