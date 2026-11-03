Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793674568;
	b=HA3w7iz4KylDlOR2/qiQGf/XTJaDZ4kZDhX/+TCYY+aPf/In9HOUyJqbtlG8bXCvqQG6
	 M3M3BR5XQl2RcPhcZaE+Czlu2N9KIfc6+X10jbWnrV+8rozOq33Z7uD8M9UMKB0xGXM5R
	 1kJ5TrQI6T3tiugJbpdhlaTki8ihpg/dTkeFDvDwYUcqL54oa16NwMb6B+nwZKczVAaCO
	 VH4SkRkT+oD/WKTJMQGOTEoXqAN7xUa9YR8fzSYkRbPmDC/HsZCKWQMfo59UIroSakfH9
	 9pjNknWa+5kVOmFyWdht8ZMg8PhkCtGwQDQhmyYoP50Y6kPZSv62bEy6ckxV/RHKBUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674568;
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
	bh=/LIexXArgNuaA8DPhwaSHPdePSYgOAljRu5ZyPoAIZw=;
	b=5iquY++JLzinJAbATycGwxev/ZNt7UEWxS1L4/S1VE+1F16+4ZnetsER48bzg89xJAUo
	 /Qi31GNJ5ew8ABbzsvFvs3hcjy8nW6rmT4guS/z3lIw8oUdrfmhrHN7xDfp7Yjb8r17mA
	 xPeQxSSbed6gsbkEknOWsS45lre2M/RIL/lw/CCIPr+7GuQciOLzS881bfRlxeD5jna7P
	 QuHHf2IUwDhiNaV3WYNy7/cgIBl1mHrzhbGVFaNSUyBJ5BCCuKMGp2rFR3S8Uj49Y3rCs
	 W/oT+U3W3bUAEyK57BxE2RqEuNnrj6BsyodvIhTdU+UhcvPnstdXmZ9iyrCyQ2iMGJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iphSZI0n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.61
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC41606A324;
	Tue,  3 Nov 2026 02:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CC41606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iphSZI0n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9mInCDf1iD1u2wUzN38JGKoYHETXaQh+v1XI/zJAdetgSpk+y4uENjtNtZBddvVTQ0nHl1Pe8OrbiIeuu2HlcP8MPSwOUxodKQKTkLpqB3xexQWlxdxMdmAso+8Gewvbg6z9PJA1xV7Nvj2fuof5VlccwqiZpVhh4lHLXFlU6PL8cUIj5ahTLLL2ivrom8GWzhh6I7bpRAv9elqAa7mo0E5CmDDhqu6qYyDeimIwCjb2IEZS9QamiuDXP3WmjeKrI9eB0QGHIOTEzeDGH37s99awEnatyI5Jvn3nw5+InuNCC3O+L6+gjt3+Jtu2a1O6f9jk+9HNn6opR8lL6jEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LIexXArgNuaA8DPhwaSHPdePSYgOAljRu5ZyPoAIZw=;
 b=PC51a8+LXFjYv2/smB9uTLRBDmt+Yo6HJ9buLmKLjm72g0KNJlOMRKirYFMg3yEI7gVtFdUp8IXg6Bepeq4aR+vgVxX6yHbBchn8TLL34MWXpD1oqxljCVFXafM2JfLJuu8W/rHtvW0RKihfsNvYlcg20CXFXIa77aF1eopeMRMeDh2yAue3GaXbZmX5/a0Bn688+pk7M84TAB/tsh5Gt+pUIHNZJ4kFFURWQ2+xWAbltHblQW0JMiTVkjrqLDHPLK6isFpqbcQo1J7mDgjoNF/BXPPwHUzdRTmF7HWgm5V6vUCayF3Xkne78Bq1Nh1KSB8NOaNJ8swZCyAqqVSpGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LIexXArgNuaA8DPhwaSHPdePSYgOAljRu5ZyPoAIZw=;
 b=iphSZI0n9pAPh2q+qDI7joIjuIsoXxatf5sqpRvGyJIJPuLXqwT7JDrEbRGJa8lgqKCWnAyvWGoF0xEMq6zCIFpeRDaTvX/i01AfWsDdkb+iPsBtaDfFUPyJGBEr29dhjJvQ3UTdykrZ2bzcbmMEl3vlcdj58I58Uzg8mxfU4o1W2Jyw5jE6+uF3qatGyYSWdIlsXgQa1V4crpYbkTwxyp8fSVKq3V03RcbvCQ1rT+EM/jhLTwwFmO+E3FIr+h7uVliwzxSWqcV6yHGjrj0k0KWf2Kq8VU/Q/NfNI5EdiUqaOmA83k4hjpQaUHj3PAgCxz42og7U+fxmGMe1FCf6PQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:56:03 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:56:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 21:56:00 -0500
Message-Id: <DML8KDR7YID9.33GEINNZBE22Q@nvidia.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v5 06/12] mm/page_alloc: snapshot the preferred zone
 against shrink rebuilds
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
 <mgorman@techsingularity.net>, <anshuman.khandual@arm.com>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-7-gourry@gourry.net>
In-Reply-To: <20261101021340.2251928-7-gourry@gourry.net>
X-ClientProxiedBy: YQBPR0101CA0239.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::22) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7afeda-0b8b-4d01-e6e1-08df3955ffbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|261102123227099003|10067099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|4143699003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	T/34YU3bee4zyixZbv4zM69gUu3xeeWsfFGEd1m1ci4Y4cIZ1yenVbk0GG7r2zovFPCl1fOoTcssxT5ae4I4hp3U0ZWZXtOBFKxP3rYFsESkF9NZS3Y+nto2hfc8Byp67fBu3mOqB/p3VGpG3h8OMwifhpxAhgZwoE2rDfMvMtVhtUB1faML26HyZaiCWt038OWbgwA5e8ptt5riaUOT0TwF1B3OUVGHUbXK9h1oL6aQ9HXmnfpnxTFvGN1VwQo1nc05c0KoRdGTu6eh2OAzdMF33ptiQbUx0PKlaf+2mbhrkrvX/5byNc8Bp1/nUQUoXF91cdqfxGGIB1HhFsZ+7HPjpse/SPeLBtshhXSWyuRoQo8nYAMbMNI+G+s9A8EjmvRKW7377bgMVM/VqVJTkmL0WAEbNOiuaoNw7xIxNnHBR8IMh/re0CIoVBj6Nmq9STJPGJPVHzQHQe+j6F7etV7ydvKGKgCAwmmasWyQv2OdmqhKr45avWAFOelRfIsCLcg7VgbkoTEqYhbkg67NPeleqjQJAvsAJ/rczIZIF6yVM1e44KC3EBjOaU5TsHn2KK3QWWFQfyEg9eTPaX9PcFX1UFYkKnphAfrySp/hW+sw+0PMSPpSWf1l86HtL+gRRn2Iim+Z4RdGDE5Hp7V2IE0hcWo/LFFWsd39HWHdRP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(261102123227099003)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(4143699003)(11063799006)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGxQZUVqL05CNjRFUmpsaGVRSEVXSEhIa0Y5V241VGhUUllmRFBnbEhpbUdq?=
 =?utf-8?B?Y2dWU0hOODA0UDZpRS9icnpOMWZZQUtORE40TTdCdldMeDkrRFFjZmhHTGFN?=
 =?utf-8?B?TUVQTlVZZHVCbm0yN0t6dlNvVjF6R2pHSXVlMU10NTZnaGlJRTFrUm4zUW50?=
 =?utf-8?B?dnV1cHJzN0kxUHRMODc2SHVRL0VqTThUZmhWckZiWWN6ZTdqWG4zTXMwcEkz?=
 =?utf-8?B?UHZjMjdXUXlGeGljbzBZSlVUalBiQkJsVHBNZTMyRkhsSHdtWVFuSERtMkFX?=
 =?utf-8?B?cS9jSW9EZG1FZzlDcngwdGJYMmVWR3FtYmN2MGtTMHAwTmdvQytqQWdwcGdJ?=
 =?utf-8?B?cnBqQ1FlZUQxWC93SXpZVFhHQ0VrME9US0w2MEk4KzVXaCtJbnpQalUvWmo4?=
 =?utf-8?B?cGxWcjlNa0JCamY3R2trdmtpNXNkNW1LZjJvZ0ZWVmxGeHdBbFlUb2hLM0lj?=
 =?utf-8?B?cis4ZWpTcjlpWnBrZGNFbWNHYVRUUFpzNVpZRXdkY1lRbVVtYUp5b2QvZ3Rx?=
 =?utf-8?B?Qm53L1hsQ0J4Wjk4KzR0bVJyaXZ5UjUvNlhMT2dzTytrWm1rMmIwSm0vVUhT?=
 =?utf-8?B?ODloVldtVWtYc1FseHNEcStsbUFjNnEyR09pMXhoR0pEME9sWEgvcS9RNVA2?=
 =?utf-8?B?ekFxcnkwZVNtVVoxbE8zNEZHR2pieWZHRXp4Y09pTS9WOEpvZ0FuSlRrYktN?=
 =?utf-8?B?ZC9rdzlwczBmS1BHcHRCaThSOWtnbXN2bmhlUmdVYVVxZWZKQk9kMlJaTmVw?=
 =?utf-8?B?M3BqRERqdTR5RVFaeXJEZDBERzJoMHQ2V1pDOXZxbmZZVHExUnExOHF3eXht?=
 =?utf-8?B?N2UzN3UrTVVVdjhYRGh6S3hpeFRicTJza0hKdWtFV0dhQkdQWmdmUndQdTlX?=
 =?utf-8?B?UFdOVTA0d243eWNPTDJiUUsxUE5NWEZpb0c0endBaDBGeGhqSDRjUzZJOFJB?=
 =?utf-8?B?NHFyUDVjRmY0SzRXMmg0WFplMEJsaG1iK1h1N3E0ZW5lLzRPT1BabDBJUFpF?=
 =?utf-8?B?cWxtT1plYTdVbWJtSVFFYjJWQlM3aFBoTkJJemtTQWwrZ3RlQWdjOWlvSmd0?=
 =?utf-8?B?cUNjdzRvbjVDVkkwd0kxdVdjMTRVaGhkcFE2ZmJvRllTUTEvWWl0RE52MFBs?=
 =?utf-8?B?aDg2K3ZXVFJwcVE0aEQwc1Q2MExtb1g2Umt2N0FaUjZ4dEYxQmxlckpDaFhl?=
 =?utf-8?B?bTJMZE53SThsZVpKVnlzS2FtWmltU0xmd1lGaE1YTys3YXc3ZUhWcWNraXBT?=
 =?utf-8?B?SGZVUnNsQkt1L09ISllXV0JZVFhLVTFZZVpMdkFCWXZpMm40aE12clREb2Vm?=
 =?utf-8?B?SmVyaTl6UkFQNTBGR3VjZTZzT2NDLzdDSUlNY1JmNlVWY1kvMXNYMGE1SExl?=
 =?utf-8?B?Nm5FS1V0dkZ1ZVVhNnlENzFINXJMMk9vbHVBSXdnbnU0RTljTXZ1eGpYV2o5?=
 =?utf-8?B?SFp0cG42S3pJc29rbEtpR3dyU0hlMFJoK3diZS92czJmZ3J3MUZJZEpoR2RY?=
 =?utf-8?B?MmFjV2x0S0dTblM0SFhnZ1RvSkRZbEhwZUwrM05tK3RRZkxUSDBCbVA5Mm1T?=
 =?utf-8?B?TWJMYUQzak53bmJIL0xweDlzQStDbEFENGJ0aTdSM0RwTEpGQ21OdHBzK0pj?=
 =?utf-8?B?c2xub21XQlA4dHdYYm9VeEIvUzdxSmhtV3FCRTNhT29taCt4STBFR0dXRUkw?=
 =?utf-8?B?OWRpSUIwcmxkVllxZ0hFaFNZNVBZMkliN2lmRXpzMnVHT3hqOTM2OHNiODZh?=
 =?utf-8?B?b2JZOVVxUEFZVXYwdEtoRXFnN0xvRlVvTm5PajJGS1IyaFNYQmFxdWJrSlVm?=
 =?utf-8?B?dkZFbnNkaFpWeDd0MmF0bnN0eG9XZ3RuL2ZDWjljc1llSmF3bkg0alRQUGxu?=
 =?utf-8?B?MnBPcHlXeTZNZkhuSHNoMURVQkRETGdTSjhldHQ2ekR3UXRpZndJVG1oRHJV?=
 =?utf-8?B?cXRRUS9wQ1dpUjNNVW1OUHhTMUdHOWtrbUZBSTNsMFdBTVduU3kySGdqcEJT?=
 =?utf-8?B?b2wweVArS0hiUFAra01wUFYvazJBdXljSGhyOTZWZkxndWdaVGdMRG5hZWlI?=
 =?utf-8?B?YWlEZmhIN3d1Tjl4VmdpTkQ3c3NudHdrY09vU0h6c2lJMGZNclhsZ2k4Wnlp?=
 =?utf-8?B?ZVYyNmRnb01HcG9uQis0VmVtWUYwbnFLNi82c0lnUXJSandQUFBWUU5pUkhn?=
 =?utf-8?B?U2hoSUhTQXhOWjBDZ3pCOEQzUU1aeVRqQlRpZkF4ak45THV3L3NBeFBydEtw?=
 =?utf-8?B?UmpkNFYxMEpNODhMaS90RWpyMXJGWlRXeFV1Wi82YUwwcFpIbnBnWG1ubHQ0?=
 =?utf-8?Q?HwH9k3AVBxJkzX6Q/j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7afeda-0b8b-4d01-e6e1-08df3955ffbd
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:56:03.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY0O8CvjDcjNL7i7kvtrmmImNkh8QD2XyNAQHYoQCB3IER+ttgr3jNS+sFBQzIB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531

On Sat Oct 31, 2026 at 10:13 PM EDT, Gregory Price (Meta) wrote:
> get_page_from_freelist() and alloc_pages_bulk_noprof() reread
> ac->preferred_zoneref->zone at every use. Offlining a zone's last block
> rebuilds the zonelists in place, and the shrunk list's NULL terminator
> can land on the preferred slot mid-walk:
>
>   CPU 0                             CPU 1
>   get_page_from_freelist(GFP_KERNEL | __GFP_THISNODE)
>     zone =3D NORMAL (slot 1)
>                                     offline_pages()
>                                       build_all_zonelists()
>                                         [MOVABLE, NORMAL, NULL]
>                                         -> [NORMAL, NULL]
>     rmqueue(zonelist_zone(slot 1), zone)
>       zone_statistics(NULL, zone)
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000060
>   RIP: 0010:get_page_from_freelist+0x6a5/0x15f0
>   Call Trace:
>    __alloc_frozen_pages_noprof+0x125/0x330
>
> Read the slot once. Zones are never freed, so a stale zone is safe, and
> a NULL slot fails the same way as walking off the end.
>
> Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_=
zonelists")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/page_alloc.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
Makes sense.

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

