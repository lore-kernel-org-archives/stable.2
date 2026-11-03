Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793721884;
	b=u2SpUD51AiHl/ZAPA5Vy18cXgiiyIUDozqzdITSQ5nRPFKE6JM2mulNnJ1WExyguUA77
	 k1ba0oMc+lQzcpxnh7XZ6OyY8F/Ph8/g2OI6fVCD+jbWO97Zc1xlGRu8ppb6FHCKKyGZ2
	 ZXUfZTFpF51JsUIDUDOnsl/XE7xuNwEQm3148gM11RuFMwwnwoRFOlKa7VIHbkT2Mj/SN
	 pww/Pt4AToEGMyZB6wT0U905Ag6u0Ovx2nVFaF1a2A8ygywLirAVhV8g1nkIyRimMHZNo
	 524cmZyMFw82YxbQBTh55eP2MLcGml4dRV6pBL3SLu762NQjljzU9qcKbDS0eFCGu4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721884;
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
	bh=qlXnfow+MJUsA1CjroyUQQvYPZNLEbhU0rfQfMv+cGI=;
	b=CBMADZDZjdNlfZS1NWeAhKP4RuLUqVp8Rs8xPF3svJibFWf0hZHH6JuvoWtcVOKcog/F
	 725jULJlb91HmD5GM/8tMPQhgM9WU/AWrQi2bPYUUWrSlmhSeFiX7odyn2JJT7uE8hjZV
	 sgrVgXEOukBbjpTQ7NPrh3BiaapWZqetAziHS0j+OuVyNhvAdAJ6prXvieJLpcbmM4Y8x
	 BACk9khrQbEr0CBMgwQSjQxxZqUXxMF4OrkSILf1U7s0NuG8cFWmxyyLSZSrIP+gRgLbF
	 7Zp5GoeAuhSToS4Rg0MVO2ZNeZMgPi9aL4ESUKWjOm5WAXXCjX6d9Ex+cTAzDaGLdiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CdNlgOSP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.39
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007EF606A326;
	Tue,  3 Nov 2026 16:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007EF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CdNlgOSP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUoAiETm03WRLYobG1MfH611ZWSky7/sfWWVgYF7c5GsTafNbcRLkFnmZQb4eJ5eV+ieM+t1BI8o2Ta4iyVT2s0Ks3dK3REVIBu/DJyB/1wb/0DVgwOgGGFwCZjgMxe2bDa6OmC/VVs3RxMgr+COIDC48AiUI2oJUm0FVlQ9TgWArhNSn08diHDCin5860GNAH37APrOJa0Qb78oWDuoJCNDbj9bC4BxgSXe8cFnRTLhLLybVkZFMRSoGNupGM1VQvBVkfiDhvF8WzXLDfR5JIR7zEbLiWfKcemzLmyM4dJjE/w5SfqKJ7krjKMTEm6qSrkMbrW4ziZ9vLpTtPHv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlXnfow+MJUsA1CjroyUQQvYPZNLEbhU0rfQfMv+cGI=;
 b=v2ZLRo8W5m1f8drmPZuHL4ml3sKpvgUQA8vcIgpLlRxHiraisSWQioC/fCWhv/zQ5bkpjgR7kfPLxIBCRaue/PkU7TqofFIpKz7cM65OgaF/yb533P9FX7Niw8Ri0gV8l/R6dDEhkzUA9N4okx6O1NObXTAymjMxhHPmyOur92fX1XQP50+jRKK2JHQy7q0ToFc/at77t2ByI4z8zVDCm16MWtEAfsPdwuwVc59At7oOBu/efk9hfo/1KZtJj6yJgCd3krcZiT18u2kFgoWWJJFcboQr1zgMHveIhyD/1UbBlnP11EJtUcOl4JINDflclvdZ9BldBoXrPLo3KOeqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlXnfow+MJUsA1CjroyUQQvYPZNLEbhU0rfQfMv+cGI=;
 b=CdNlgOSPl4IFRa7txSWEu8Vfcx/Gj3p9N6Qjc0AVD4tXYCdhgdGULb9pACQkZQA90yUqLA6wA3XWOnrBPPwk6OH94m8ADyw/fJyFbk8pd4K0iyBv6ihfpLNwA1XpL6emTfjfe1UOJnBDrjWVPa+Qr7cd5Q5ud4p3eS92wgU1MRnMP0DzYyAWH/k393FYJd1IYoChZshTa9Ofrd90jsU4q01pf04fldqPbN6Fzsiq9Qb7npTAhEwn5RrTjE5ScPwfB2dOhp/PhK1KHEf9yJE7zB3fzBF6sdOX8vfAA8XxHbLpgwJ9RSgR28bEJ3GtnGUqv09NiqCgZExoz6lTtblLIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS5PPF884E1ABEC.namprd12.prod.outlook.com (2603:10b6:f:fc00::658) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 16:04:26 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 16:04:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 11:04:23 -0500
Message-Id: <DMLPC0D7EWRW.EVYWUONVO18A@nvidia.com>
Subject: Re: [PATCH v5 02/12] mm/page_alloc: keep the pagesets of an empty
 zone
Cc: <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>, <akpm@linux-foundation.org>, <david@kernel.org>,
 <ljs@kernel.org>, <liam@infradead.org>, <rppt@kernel.org>,
 <surenb@google.com>, <mhocko@suse.com>, <kasong@tencent.com>,
 <qi.zheng@linux.dev>, <shakeel.butt@linux.dev>, <baohua@kernel.org>,
 <axelrasmussen@google.com>, <yuanchu@google.com>, <weixugc@google.com>,
 <baoquan.he@linux.dev>, <baolin.wang@linux.alibaba.com>,
 <rientjes@google.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <muchun.song@linux.dev>,
 <osalvador@suse.de>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
 <ying.huang@linux.alibaba.com>, <brendan.jackman@linux.dev>,
 <hannes@cmpxchg.org>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
 <nathan@kernel.org>, <ndesaulniers@google.com>, <morbo@google.com>,
 <justinstitt@google.com>, <Bessel.Wang@huawei.com>, <jiang.liu@huawei.com>,
 <mgorman@techsingularity.net>, <anshuman.khandual@arm.com>, "Josef Bacik"
 <josef@toxicpanda.com>, <stable@vger.kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Gregory Price (Meta)"
 <gourry@gourry.net>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-3-gourry@gourry.net>
 <DMK59DO8M3AP.3OTG2YR62D9WO@nvidia.com>
 <489b668a-033c-4161-93e8-15d6b9b28b51@kernel.org>
In-Reply-To: <489b668a-033c-4161-93e8-15d6b9b28b51@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0221.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::12) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS5PPF884E1ABEC:EE_
X-MS-Office365-Filtering-Correlation-Id: 421ac233-fef4-4b68-8231-08df39c4226d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|261102123227099003|4143699003|5023799004|11063799006|56012099006|261028144727099003|261009223027099003|261021121427099003|261026121527099003|261021123027099003|261022105027099003|261026140227099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	S5pcJlPBlmCCxbUSWfb+cMjVxvK5NrPdVhe8m+PfecjNh/+pTcfD2BzJ1vGHNUR4pHWhrlfvhfQSZBjZrt0qGI+oWQxfAKh0tLrUXLioyYfrQkrnbvH7pZuHU6j/mE7YtfWsQsZarIciMWJUR91MrVMkyskUm1tEs3c0Ww3d3x7RI0UG3RpxG3IdsFO/xyt7basezeg69E+xxWWl5dT8EvnygoTXuYtOESect42WqQxhxu1ou8ycDbBREA404LpF18Ndx8YypnraHtObxOG7oqJIoC14YGZ5hyi0oZUChG0BMmX7XyriMm6XC9RmSqwpOmYp3JJ+TiAqc+quHy/dwe1jau2egazBSDOcRmYb1kBB3IEXQnr2hQcIwYKiq3MpS+vGECEhoetXHv3veRKuRBWf71nPscb089v+zdSonzIrZQp+Womo80ejlhxaszVS1Z0zhMAmfecSdOyPl7h7y4fYrb9ycrtDziJGcq87S6IiFu6veHnty46QebZqk4oLlov6R2/gfvBLHlVSSbbWT4JDxTil3Z9YGwgXSJjAQ7EOMZIP5RP3EfvPChDlzMZXO2pQ0lNXQk9NKmrNqUDyzM/PKS+R7JJzoShIg/tBHCQFyAUcP87viUINwBxczGHZZzrrlmmGFWrah8L/8KdkWu2EAfcTRSmChrgnCTw9HkE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261102123227099003)(4143699003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261009223027099003)(261021121427099003)(261026121527099003)(261021123027099003)(261022105027099003)(261026140227099003)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEsrWGZDYlVxSWJ5RzBFSGFHaWZqd1MwMkVya2JFVzR1T2lINUdjRXNJckZ0?=
 =?utf-8?B?c0k3YkFvczVOaERMME1LdVJ1VHhIQm5KcjVVcFExNllmVkNhbjB1RHdYdzdF?=
 =?utf-8?B?Z3RJRVNCOWw2Mzg4ZU15SkhlNXpGS1RKSWF6b0JMMTE0ajBaVGNNUlM1UE82?=
 =?utf-8?B?Y3ZKWlJ1UG1nQ28wUk81bEpOZlE0ZzZTdks5QnB2MGRHRzE0Q2NaUXk4UXZ3?=
 =?utf-8?B?M1luTTZCS3B5QjVPL0JmOWxyUU01MGJWWW5CSkJuMVNRYWZiaTdMcDZDL3gr?=
 =?utf-8?B?VWQvVm8vZUlTMXdDMUxiVWpCbm53MmJuTnVkd0JFdkd2NE8zNW84SHZUOXgz?=
 =?utf-8?B?UFpmdDhJcXQ3Mm5XZ0pWcEhWTzUweG1aNFI4Sys3L285TFV3dGVpWFF4dnFF?=
 =?utf-8?B?aytkc1FxTDRsRElCOWE2MUt4eTZySVNWczMzUVMrZ0dZbzRCamJLOHdyUVh4?=
 =?utf-8?B?L1FjRFhhR3BMOHVEVHZ2MG1aZm1UQisrMENuRGVIWXdBV0FYbWxmNTFwUVZB?=
 =?utf-8?B?YW5sWnVoZWVQTGFEbklDZTBVS3ZBK3ZSVjM5VFJ0VG8rVktVNVV0Z0hQTG9h?=
 =?utf-8?B?UUxROUZnWEVDYmxnKzdON0pkWFNLR0JJRk1EeGovd255K1FHdmY4N0NrUTA3?=
 =?utf-8?B?NHFSVUx4S1BudEJ0MXlGd2dMMmtvUDcwWGZxNGhFM3hybUs5eXhTeWI2UFVs?=
 =?utf-8?B?eEt4Y2phYUVvNzlacVdwQ1FtazYycDkwZVdSUUhrWWJ6MjBSU2o4aEFUSVhq?=
 =?utf-8?B?L09GMjdsenNDU3l1Mm84Vy85a3ZsLzIrTXRzSnk3R3VqVmVLSkdzYnVWczJH?=
 =?utf-8?B?YXhhSXJvekRwNUpBaEJmTks1aHhPaUFacG11QVlZalN2RmxEQTd6ZHlCUjhN?=
 =?utf-8?B?YmhyM0xGbXBScTJiSUdtTVNJa0s5NWNTZ0Fsa2J6N24rTjlHUjd4NUtWYlQy?=
 =?utf-8?B?RkM0WFV2UzcrTGxRUzlJckErbmFvcnVxby93T25YR0lpb2IrK0UwQ2Vqdk83?=
 =?utf-8?B?VTJaMW9oOEJ2VXV5cncrdWYvU0tlbFBOREJXeGlnRzdZdDFiN1BCa2UxT2xN?=
 =?utf-8?B?K09sUFUwNzk5bnZVNC9zbTZXZHp1SVNiclNvTWJYVUU0a0dBbmZ6RzFvRjk1?=
 =?utf-8?B?VEJVN2lLa3BiaXNPdEhwRmxrTUMyMWlObEk3U2pvSTVUR2pNb1hvWTJZcnBj?=
 =?utf-8?B?c2l1TGVSZ3Bzbk9Sd2VDMDJmVzh0dnZUNEJMc2FJSzBnYWtOSHN2OEI0dGsv?=
 =?utf-8?B?c0Jvc1NQTWtoRzRIQW5iZ3JramY3cmV2VzB6TDUzaFJWMW1BSElTUzMvVEhp?=
 =?utf-8?B?SlhRY1I3RzVhQVVPSWl3dDFQeU16amFxOUJKRVJWemNZTm82WGRuem5jZG1Y?=
 =?utf-8?B?NjErQk1qVG5EMml0Qkt3YWhLdmJITGNudmNOQmlhME1KRWNCTUZHSWxrbU9I?=
 =?utf-8?B?T3JZeU5hSkd3NTREY1Z3WjU2c240MjRUWE5tR0owNWN1Uy96RTd1TGUzTTRE?=
 =?utf-8?B?azJNTlBiUWpWVnNxanhLZU5ZTUFML3VKNkVBcDNJazNVOVRBUUZMWXVyOHJG?=
 =?utf-8?B?Q2F2dWhuL0U3ZG5mbE1peTh3dUdRNVBRekcyUDRENVZ6Q1lIR3E4cU52a1lR?=
 =?utf-8?B?TllFSUo1MElnY1ZYaGNSKzYyVlUzZ2RCQWJzWTQwNytKM2I1WmZwOXBmUkNq?=
 =?utf-8?B?V3UrY2F6UkM2S28wODN1Z2htTUNxYmVsQjJVcXJuMWxnOHVraDJzVGg1alp2?=
 =?utf-8?B?YXBwcjI0Z1cxNmd0cGZ6TlJTcStEQUg3UERFWWtVeFdSRTA2ZzV4NlBTemxq?=
 =?utf-8?B?L1hFSDJmNjNuV0dyZXcvQ2dwd2QvZ3F2MDVRZ2c2eFJqaEtwOXEwUkswb2Vh?=
 =?utf-8?B?LzVCbVVNNmJnRk9hN2plcUpyS2ZEOHViVlRlWWpCL1k2SjMvc29EREE5UXdV?=
 =?utf-8?B?cG4yeWlxWHhqTk9idjdFOC9HTi9mR3FSSUhKRGRUZU5aYkxlRTREdWlrNGNK?=
 =?utf-8?B?bzlqS1hTREZ6SldLRk1GQWQ4RzVMU1MrbUVtNmJiUEs3cG03RGNEWEdSKzVi?=
 =?utf-8?B?SVJiVUQ5cFVJZkpzVTVHUERldzJNYXp0MUpJWEQ1aEZwSUpXajFvOGdqSHc0?=
 =?utf-8?B?NDFYcVBCQmdKNGZDUm9jckFqSHl5VGVqUkNpTE9aUEtDMEdBbTJtbDdYZmQ3?=
 =?utf-8?B?RjF5eWJ5WEJPKzhURSt3eW84bVhBSzFpY1M3dlpVdnI4cWgrYnZEOWhscDZn?=
 =?utf-8?B?QlF0cGgwUHd0YnhxTXpPb2ZFQmtvTmhzOHhRQXg4b3ZPTnRJR2kwc2hKa1ZG?=
 =?utf-8?Q?BPPjoBlXPrfjYleRZz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421ac233-fef4-4b68-8231-08df39c4226d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:04:26.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3A5oOJeK7FIonAa8TBbHRlLdy9SptOodPAELyoqFcziZyko3q7PTReu2PjRLoR4G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF884E1ABEC

On Tue Nov 3, 2026 at 9:57 AM EST, Vlastimil Babka (SUSE) wrote:
> On 11/1/26 21:07, Zi Yan wrote:
>> On Sat Oct 31, 2026 at 10:13 PM EDT, Gregory Price (Meta) wrote:
>>> From: Josef Bacik <josef@toxicpanda.com>
>>>
>>> When the last memory of a zone goes offline, zone_pcp_reset() frees
>>> zone->per_cpu_pageset and zone->per_cpu_zonestats. Nothing waits for th=
ose
>>> who found the zone populated and still use the two pointers. They take
>>> neither the memory hotplug lock nor any other lock which offline_pages(=
)
>>> holds, and some of them can sleep:
>>>
>>>   CPU0 vmstat_update()                CPU1 offline_pages()
>>>   refresh_cpu_vm_stats()
>>>     for_each_populated_zone(zone)
>>>       pcp =3D zone->per_cpu_pageset
>>>       cond_resched()
>>>                                       adjust_present_page_count()
>>>                                       zone_pcp_reset(zone)
>>>                                         free_percpu(zone->per_cpu_pages=
et)
>>>       decay_pcp_high(zone, pcp)
>>>       __this_cpu_write(pcp->expire, 0)
>>>
>>> The same goes for drain_all_pages(NULL), which takes pcp->lock, for
>>> zone_pcp_update(), show_free_areas() and the readers and writers of the
>>> zonestats. If the per-cpu memory has got a new owner in the meantime, i=
t
>>> is corrupted.
>>>
>>> The pagesets are only freed because setup_zone_pageset() would otherwis=
e
>>> leak them when the zone gets memory again. Keep them instead and let
>>> setup_zone_pageset() and zone_pcp_init() use them again, like it is don=
e
>>> with pgdat->per_cpu_nodestats. Their lists are empty, and their limits
>>> have been calculated for a zone without memory by the
>>> init_per_zone_wmark_min() of offline_pages(), which is what
>>> setup_zone_pageset() would come up with as well.
>>>
>>> Fixes: 340175b7d14d ("mm/hotplug: free zone->pageset when a zone become=
s empty")
>>> Cc: <stable@vger.kernel.org>
>>> Assisted-by: LLM
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
>>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
>>> ---
>>>  mm/page_alloc.c | 20 ++++++++++++++------
>>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>=20
>> LGTM. Just a nit below:
>>=20
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>=20
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index f1048168c90c..1850a41f24f7 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -6308,6 +6308,10 @@ void __meminit setup_zone_pageset(struct zone *z=
one)
>>>  {
>>>  	int cpu;
>>> =20
>>> +	/* The zone has been populated before, see zone_pcp_reset(). */
>>> +	if (zone->per_cpu_pageset !=3D &boot_pageset)
>>> +		return;
>>> +
>>>  	/* Size may be 0 on !SMP && !NUMA */
>>>  	if (sizeof(struct per_cpu_zonestat) > 0)
>>>  		zone->per_cpu_zonestats =3D alloc_percpu(struct per_cpu_zonestat);
>>> @@ -6400,6 +6404,10 @@ void __init setup_per_cpu_pageset(void)
>>> =20
>>>  __meminit void zone_pcp_init(struct zone *zone)
>>>  {
>>> +	/* A node which is added again, see zone_pcp_reset(). */
>>=20
>> it might be better to explain zone->per_cpu_pageset can only be NULL at
>> boot time and it needs an initialization.
>
> Hmm.
>
>>> +	if (zone->per_cpu_pageset && zone->per_cpu_pageset !=3D &boot_pageset=
)
>>> +		return;
>
> Shouldn't then the check be just:
>
> if (zone->per_cpu_pageset)
> 	return;
>
> Because if it's =3D=3D &boot_pageset, we are just setting the same values=
 that
> area already there?
>

Right. And zone_pcp_init(), called by zone_init_internals(), becomes a nop =
for
free_area_init_core_hotplug(). Then I wonder if zone_init_internals() is
needed for hotplug, but that belongs to a later cleanup.


--=20
Best Regards,
Yan, Zi

