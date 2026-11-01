Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793563683;
	b=s28edXaQKdoT+51F1mcWVne6gjSxJgk6xjYB9IRvmO1d0bd6HQ7KkCLnAKiGxQ7Enb6E
	 yjLyTuqetgz0tdaZWGP6ZNXuveaQoHeRn9le1emctEXZsYevn1JrrGL1hGiw89jL5MPP7
	 tI8uNlTOkTOW+g6lEIactZXstO7i0XmlnHccRRjaRUFiN6UjovTxlwVt7CDU3kuj69kuA
	 t29Mp2snrNV2UUmi+AB+57Tj/EHMCWAdK+4VZG0yZNKW2Poz9y2pKs2y/1Nl95QZmqiZu
	 I5VBGNT/FhtXHj7LmJeAATzQHHl5saD7woVx/EsoUWrqlgeylmP/ogpKHWVYEBzRrQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563683;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=dHE2XQAXzUh2NAaDZ3bmkVtT2edw3j2E/yaBCpKhDMQ=;
	b=BklMPt29lay4Fr2F0KGaroZtP9x/rc5zT/IgjEdBXhDqobIhAIZo9hRA8KuMZQgT8wK3
	 U71U7xl6Iz35h6n2wcjzJVmlwKLFb0VOI0jcI7+CAjowMHFnttrL4u/QuovIxAKjTQnoM
	 9O8weRTdkHNJe+24/gOkXbyUlAnlF1AElkNJj2a4P1nO0nrAaKd6ho3BI8J7MVJq+2zIc
	 3DcmC+3UpFFY7xBp8H9BboOTGYW4nb6N+0ft30XPLlJpVtXEicEPnv2vNHR+3QVKg5Tj5
	 gtTjTQ1Ge62B/RJXskayuOdzU7208oQMog3xdA+T2YC3tBwSGjS3SEW+8CjAYMdlgjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PWQxl4Vq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.1
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B23606A324;
	Sun,  1 Nov 2026 20:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6B23606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PWQxl4Vq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTLv6einZebrYA9uYscVdpgfdxjjvjP74ac/hpjScIqmgJeUxBcLrYS5IXBYBt+yEsk69GITDUFWVLdT9md8kRZeASCWZnlSgvwIKTJ6Wpg2BdGwDtqPowyTlCt2Q97QpNMwRGsmNAXZBJ9UqUgc6dfKfXLosOFU8iKUtN1jh65bsCE3hC1JNDXqWAywtuyRFniFFKUR0YBBlJkM53fkjmoBEZ8+BksSJ3iPhclzAo3DALBg6DAELE22PDZL7wXp8j4b+Gm26MioX+1srncb11S0fQQY7Dy5uM0VN0bQHl5PrP7i3MMLTSp4Evrc927kyqHPgDAxllQatwSmSmpRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHE2XQAXzUh2NAaDZ3bmkVtT2edw3j2E/yaBCpKhDMQ=;
 b=aCghTDk1E4u6nYlnmD5isNaEZqgF/CkYt1MIyP+gDUt3skR0fEBX1jV+AQVwA9BkS++KAlEI2MPQt42piNm5/rQkLAfsD7yWl3M7Kj5FNx2yxTVbSYwmQBilYCQIaxAc8sX9E1lCqDLA8K27yOvfWDZ/mKZv7Sl/Kjf7yhOItyLQErfhRz6wjfrhAIobWrbMSeIog74cPKAqiOb0/bNTiNm+S3KANXekiJXFy9eeP10Zqr7KdnF/CL+g9SDHdbT4AXt6drArq9qWSiOoH2QfVUFsEDfc63kkrqoChGHfTs6M37SvDiGdUuFepyXUdJRvFDvS99W8IyL07jw6ELsd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHE2XQAXzUh2NAaDZ3bmkVtT2edw3j2E/yaBCpKhDMQ=;
 b=PWQxl4VqToq8HZBO3a0FLix+2F0Jwl7EzUwfJjBHvDwAqCqQTYFRaya+YGel3q8WjE8ZSkO81ere9a+l1piuNx+244xCkVoUVekjvVvVDoOOcfV2Z7qUFSiurU9hHqIvTRZiG4Dh/E3dqa+sBqV8U+txY0BIGRfi5lsOkVQgb8ffU3mwBydkwWdN09NCAr3wUd7Ygu6a9t6MN2qXSkP+ymN7wsV9uIt3xfsEIiImZjvfbt/EtJU8hKA1151cK3LG8l5Za4QvsTueUKheaUHzMIb91hDNix+vOjrWjfempPyewU5fNQpNnDXmuTRiLDqr93vVk1A97vA6Yrmy9q74SA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 20:07:58 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 20:07:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 15:07:55 -0500
Message-Id: <DMK59DO8M3AP.3OTG2YR62D9WO@nvidia.com>
Subject: Re: [PATCH v5 02/12] mm/page_alloc: keep the pagesets of an empty
 zone
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
To: "Gregory Price (Meta)" <gourry@gourry.net>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-3-gourry@gourry.net>
In-Reply-To: <20261101021340.2251928-3-gourry@gourry.net>
X-ClientProxiedBy: YQBPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::19) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9a8cf7-6e56-48a5-66b0-08df3853d2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|4143699003|5023799004|11063799006|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BHjbccvyC94Ik8lVLRb+Ds+cmc+tFvEyjVxmxG6J5tBbKYW45iDfndCuZii1zPruwzETkf0X4qEa/RXq3wIdrRzjvU1T4lWNA4lqxEjYgKnTQKeRFwshfQ07Fove9pPpdY7uLln9tMREIfxjyvLKuMsyJIff4qMnZNrJvyh25qtz3CsvL6W0qMbKiD/HAMs1CaCbRAD2QXNCrekGB2bemIeDRHTg7svm13SnasA+iIZ+kQZP+U2iN2Q9ZwXmfTtnnPRqL8c5NgViu7QXS6RcKtdteUsR+VsjgXoqLvg9dCM28JNCu/9wYtFrdCRqETLHSKOiZlfdZeuJzGJVFMqGLLNTv+3XFJEQhQTeCV5WYMZOCgi3ApWHBcMiDP5dudFiYAWe63trfCZNRSlOeIH1AG+F0po7JZMvQtfFnn7AKz1s2RxAo3u6N7jt4dq0Y5PI4lmu/dOFMMwDHT1CqRp15VyogxTdW305qZVSncy6ZiRFOywStRmIo+becXvvqMutLco5oXcGm4CdWxO7aKC7SIExv5dn79rmSy4vuXiK7IuQARr+CrpDJg7xMRJK4NuazZkyf3EyxPmLy3uyKacepOJM60iUfD0jWL5SYTMW9FCX72qqNZa5xssWsrAYKZFpKX0lQ7JYH+IARuUL6mYnrSXx6rOl5Eo2SofuPU+tjVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDJRT0NGcDR1ay9EZ01tNnZNMGVCT3JZZEV2YnVXNGRhVlN5Rmd5VkFpc2xv?=
 =?utf-8?B?ekNuUFNQYS9Wb1E5Z0VpNzVMSDYwR0huengybG5kM3JmWHhuQlk2WnRRcTUy?=
 =?utf-8?B?ME9TVXRhVitLOC9FTEd4T0ZodlE5MzR1WHc2bFN4TFN3Z2cwT2VXWHJ4WXRB?=
 =?utf-8?B?NHNSeUc1QlhRK3paa2lRTVFJOUN5Z2xwM2ZjK2lqRER5SDR2N2VabGpWRU15?=
 =?utf-8?B?cXB2Wlo2M2Y0bjE0Sno3VVlTRkMvdnBUYXpIeUFaald2UDM3WDlmYWRMRktR?=
 =?utf-8?B?eE8xZi93ZHZuZVVKL2dEVFFnS2NMdm12RlYyUVlmWTkvSEkyYm5JcERTcUNt?=
 =?utf-8?B?QlRXNUVvdTNGSEdtWjlodUVFNmtPUlo5QThuMlZuK0duV2U4ODFnQ3NEc1hH?=
 =?utf-8?B?dGJyMTI3dlRTZ1hxTXlEUEFTb095eTMreFE4ZUpMUVFQRlkyWmFtZmJsWE5M?=
 =?utf-8?B?NG9xR0RieHVOTzcvYmJya011b283L1dGMCtQUGVDMnhuaER2VjQzVWZoQ0hC?=
 =?utf-8?B?WnRyRXFIVzVSTTE0dG1ZQ1ViVElGTUpWcUlabU5zdXZjcUdTN3lBMnlzT3lk?=
 =?utf-8?B?eFVjaG9FeDk4aXFvcTY1MUM0dmpmOU9Dd3ZtdXBSS1AwcXVPRWt6Qng5Y1B0?=
 =?utf-8?B?bmlka3pITzNjdE11NndSVHJxZ2swVVVBSlZhOTRpTEpFMmVMZnlQNVJ4cjdL?=
 =?utf-8?B?cE9UWjJHeE0xOHZ1L1lERXlnQ0JmNUwwdS9JVnA0dTNIU1pOV2F3UmJwN1VQ?=
 =?utf-8?B?bHAzTTFZM3c1dTl0RWxtTUxjc2lZWkJZaXh2QTRWN08xMFlKdkNmTko2WVZF?=
 =?utf-8?B?K2hHREZOcG02aHNyTTErcyt3VzdYOHFsdUdxamlkK2tyekJrZXJOU1dKWWZm?=
 =?utf-8?B?aDE1c2F6SEZrYUx5VUZ2NnBsN3gxSzZ1RlJRQjQrcHZTWjQ4MDh2Zk5oaEg2?=
 =?utf-8?B?dTZheVFQWXdycEMzM0Q4ZnpIWkdJSWlVOXFjTmhoK1ZLaGxhSGYreGxsRnlM?=
 =?utf-8?B?NnpOamZ6S3NzMEgvaEhyWnpBelNvbEpTVjg0dDZqaTRpcFpLeURyRnVaemZY?=
 =?utf-8?B?eEllZ2dwdUpaN3JiYkExQjhIcnZkc21DYWpidkJoQmZnMnZiQXhLNnRIak1H?=
 =?utf-8?B?WllUUjNSMjNvTUJ0dVAvQTRBMUF4TW9kNUpyK0ZtcmtFR1ZMRGw1S1JuVUxH?=
 =?utf-8?B?eVJhb2F4RVptaklHZ2E5UkRrL01ZR0RxWUMrUGNZUWFiSFc3YWE3MUZUNFE4?=
 =?utf-8?B?Qm1xR1FyNC9hYk82VkZhUG93ZlUwVlgyeWJzdXFQNXMySWRrQnR1MWltckQ4?=
 =?utf-8?B?U0pjRWdWWDE2c2dnbFRHWStDZ1NDaENYeGJnZlpIa01oSSs0Tno1ak1iVFE0?=
 =?utf-8?B?VG5DTHdCMXl2WEJQd21TMFN1S0VlM2JUOVFjRGFUSnBvaWpwNnlGWEVLUnhD?=
 =?utf-8?B?WU1aOTd2TDVSdjdNb2hUV3VHYkIzMTN3cUdlZFp2N3Q0M3JFa01sbHNtRkt3?=
 =?utf-8?B?WmNsVjd4SjFuNGg4Myt0YVlEZ1V5dURYWWVoUXlDNkxaNGk1MTZJZzBoL3lM?=
 =?utf-8?B?ZVY0WmJWckFYRGttVHdIUDdoK0VmdVB5d09vQVpyeGZlTEYxcGFacEJIVXBq?=
 =?utf-8?B?RHprdW1wekxnRUJSL3FhMDdaSjlDSmZtcmVkaStMWmZpNkYvUW1zYngycEtS?=
 =?utf-8?B?a2hFMURnR1ZEU2Z3TjAvZDdhL3FaUi9WckMvcStZdTViT1FvY0tJeXQwQzRD?=
 =?utf-8?B?VTdhWDlIc09MR0JUUlpJYmE1OXJXUXFLQ2x0YW1yeUdYY01aemtMRGdKWjlE?=
 =?utf-8?B?SWRrTzRjZUZJcWZkMmNMMTVzOWZSVDNlcm4rRGU2VkErazltdFBEcC9MVU5i?=
 =?utf-8?B?OWpTYXVvS3dDeXlZT3hqdjAvUWZNUGJMNS82cWYyZ21CZE9oVFIvS2JZbGNS?=
 =?utf-8?B?cEtmT3ZSUjhsK3F2dDc2ZnEyRlhua2lVTkFTUzNubTBwNXZ5RnRBbzh1OWE4?=
 =?utf-8?B?VWtrWWdzT0JSejRRN3JsanlKWGlnWXJXemZ5aUNZME1aQXQrUjJGVkhQdlZ1?=
 =?utf-8?B?UDBmblFaMEh3MnIxUlF3dU1DZnRTQWlzb2xQbnNnZnNLQ0ozM3lnTjRsWnVJ?=
 =?utf-8?B?VEN6YTV3blZqcFNUbUNQSGg4OGYzNW5aUVpIaTRSM2ljS1c5WnpmL1lvZHNC?=
 =?utf-8?B?b3dFZ3AzVE1VWUZpSjR5N3hualpFQjlKL0FPUjN0am40bE9HRGEwVTBpUWpT?=
 =?utf-8?B?QUxYcWtNVzJ1S3RvcnI4V2xXUzh2UG14OHlzdThjbGNqcnhsWU51aStIUnpE?=
 =?utf-8?Q?nMq+h01pwM3ZZC5ebn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9a8cf7-6e56-48a5-66b0-08df3853d2c5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 20:07:58.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQePEbi0nCxb0uziX4WWNV6m5J/xhkM9SwxkXvGi8tPWqbEFEqg4f6aljWddYhxe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226

On Sat Oct 31, 2026 at 10:13 PM EDT, Gregory Price (Meta) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> When the last memory of a zone goes offline, zone_pcp_reset() frees
> zone->per_cpu_pageset and zone->per_cpu_zonestats. Nothing waits for thos=
e
> who found the zone populated and still use the two pointers. They take
> neither the memory hotplug lock nor any other lock which offline_pages()
> holds, and some of them can sleep:
>
>   CPU0 vmstat_update()                CPU1 offline_pages()
>   refresh_cpu_vm_stats()
>     for_each_populated_zone(zone)
>       pcp =3D zone->per_cpu_pageset
>       cond_resched()
>                                       adjust_present_page_count()
>                                       zone_pcp_reset(zone)
>                                         free_percpu(zone->per_cpu_pageset=
)
>       decay_pcp_high(zone, pcp)
>       __this_cpu_write(pcp->expire, 0)
>
> The same goes for drain_all_pages(NULL), which takes pcp->lock, for
> zone_pcp_update(), show_free_areas() and the readers and writers of the
> zonestats. If the per-cpu memory has got a new owner in the meantime, it
> is corrupted.
>
> The pagesets are only freed because setup_zone_pageset() would otherwise
> leak them when the zone gets memory again. Keep them instead and let
> setup_zone_pageset() and zone_pcp_init() use them again, like it is done
> with pgdat->per_cpu_nodestats. Their lists are empty, and their limits
> have been calculated for a zone without memory by the
> init_per_zone_wmark_min() of offline_pages(), which is what
> setup_zone_pageset() would come up with as well.
>
> Fixes: 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes =
empty")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/page_alloc.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

LGTM. Just a nit below:

Reviewed-by: Zi Yan <ziy@nvidia.com>

>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f1048168c90c..1850a41f24f7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6308,6 +6308,10 @@ void __meminit setup_zone_pageset(struct zone *zon=
e)
>  {
>  	int cpu;
> =20
> +	/* The zone has been populated before, see zone_pcp_reset(). */
> +	if (zone->per_cpu_pageset !=3D &boot_pageset)
> +		return;
> +
>  	/* Size may be 0 on !SMP && !NUMA */
>  	if (sizeof(struct per_cpu_zonestat) > 0)
>  		zone->per_cpu_zonestats =3D alloc_percpu(struct per_cpu_zonestat);
> @@ -6400,6 +6404,10 @@ void __init setup_per_cpu_pageset(void)
> =20
>  __meminit void zone_pcp_init(struct zone *zone)
>  {
> +	/* A node which is added again, see zone_pcp_reset(). */

it might be better to explain zone->per_cpu_pageset can only be NULL at
boot time and it needs an initialization.

> +	if (zone->per_cpu_pageset && zone->per_cpu_pageset !=3D &boot_pageset)
> +		return;
> +
>  	/*
>  	 * per cpu subsystem is not up at this point. The following code
>  	 * relies on the ability of the linker to provide the


--=20
Best Regards,
Yan, Zi

