Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793675641;
	b=o6iWLvYKpZ0lEzCpaqG6HTx4AQ1pw65NR7doRyVp0Yai6L3+IaGrg6+q0xc2KSQP8p6/
	 IDZNW9NazLlw1cvsi+QA1XiYfHRPtPzexX8Fw0nwZTmTXX8mlHweu8sIwZb7jg6VHM4N8
	 iFted1yBcdQT5atWZm7nTGrQ6wp4OA32jyu7WbmhKoNz0yPuyNcYH/cKVdO+x4Nw3jTR1
	 q7AiIxHbQ8S6bz1WX/txbstA/hPCdKXY4TTsC/tIiypYKbTnDdU/+jFIawf703R7+jxCO
	 TQrSxiF/nY7nOLWRq1EDAKMi6NyyzSK4d+IAJn2BYU+PVFXuF62OgwLqnnHRxwsK0QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675641;
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
	bh=3ZASsjjTs4yOtopvDV5SjaTBsyc+0lOLk5XZxt3K3Yo=;
	b=uUYy40+u2YhF1F1CH4a+khk5wdkp3vAVdPS41q13IpFoK3JzeJxqc+3AQNa9WTrZhy/x
	 wX2zEiE5xCqwi8FsI9qBkAu4HVLPc1H66z6dLPmCxWAe2RK6Zhe6dAuH2alKz+abLY/MP
	 3vqY/1zdH7visQEVM79/WHfFtD9pzQ9UXDUGf8+57VfKNy1V1doE7Hc2Ibpfpz8qqvW8+
	 nwS0O1WKJa0YT/oiLtCwciEjgMgObyABTAkFETPsdVpweVaowwD/ZYevELjXhf66Nt626
	 Nuin5WhPagaMKfdZrb2S6p36De8cm33NrwCuuMeKv52YVnL8/t4TWG+N18aaxNsuU2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IrbpN+Qg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.19
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07550606A324;
	Tue,  3 Nov 2026 03:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07550606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IrbpN+Qg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSRKHeUbSaTzdMiyZEa1bZcGGmXw9L/ejQLOnwuwV3u7PmdVnDoZd1pDtMbX6VT2RMkjLWW5x5gKZ0FiIxjDerdUgZmdyfNI11Peo3J5piY59qAuAA5bUKEmkaakmL7TwAomC+DVa59bKNfYYOn4E6UGkGLtEj+7PIf8umR+E6fu3ELUwI6gep0DyS+UcVgj+anXPiq3L3Cy958IT7qpqEzCmerZUPCFn2BmFWOzQhnnppmk/XlwFQlaAsnykkyteGSywbuzzX986ROgBNBSENj/M7uj5JiSs9jg/3SdUWo5P1Tg7vLvs9CQJN+o6Wkgf03EdIJUNFYfAQq31+tpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZASsjjTs4yOtopvDV5SjaTBsyc+0lOLk5XZxt3K3Yo=;
 b=SEas3kqvT1dxOB1bbRh8BVczVVqBoyLJU6UlixUzd3LCVVKOcLv66VuOWpJqwEa7mn73Tny3CocSEI+0YpeoIzPToBOFPW4fql4WWqqshUZiuwut4M5gVk404oaWFV5qPcjxy63n85HvZjKCOnrt6VAiL9R6ZcvuUm2QzWkyc0cC5mHkVajT0dmKNF/mKJhoNZz1WqxI4uYTYeOF0SHHkz/iIWu27m7GFf3d+HjAaLYHohretk1tM4faUXCW5DTfufdCcIJfsicAffH/9ze/6OjzbpENcf00kVAV+xtKtKzHHAP2NG6ogBSoWLECJVvFwB5NMH1P8KOhrDzlr5n8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZASsjjTs4yOtopvDV5SjaTBsyc+0lOLk5XZxt3K3Yo=;
 b=IrbpN+Qgjq8gckPbY5TGMWA0yxXnxS3f1R6RUIQvuvibIeZpL+ssLoBLrgbACSMFw+X4nA+ziRgZ3ELGC9bqYkdQy1585ierlNVaGa4F11hlJG/MxjWO3JG/aSdmn3vVJJwfR81oaHmV/ZVmyp80jWmnw+x2oTm/WlMq86/aTdcE4XDPXsKCwS7l+YDdcTyDCgHaS5XWw3NMTGX9xCByfNdjy5usz6HTKioBuZ9/4rNCa31ZMwQftpiUGkP4mcnhMXNIA7EdMO7K/IX2FAlBkJS3P/Fmu4qzOOJs46oG9xPuy1m2iLDyYJ4gaV7sQMQIpfOILAzmK6h3xgQABaBlXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Tue, 3 Nov
 2026 03:13:52 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 03:13:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:13:50 -0500
Message-Id: <DML8Y1C80SPN.2OBHSX5SNKB9A@nvidia.com>
Subject: Re: [PATCH v5 10/12] mm/page_alloc: retry alloc_contig_pages() when
 the zonelist is rebuilt
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
To: "Gregory Price (Meta)" <gourry@gourry.net>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-11-gourry@gourry.net>
In-Reply-To: <20261101021340.2251928-11-gourry@gourry.net>
X-ClientProxiedBy: MN2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:208:23e::12) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ccee873-ac2f-4256-30a9-08df39587cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|261102123227099003|18002099003|56012099006|261021121427099003|11063799006|4143699003|261028144727099003|261026140227099003|261009223027099003|261026121527099003|10067099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	KovL9N1DOkBY5CnQvb+rRarDk2ZkfTkpe03jYqxJ8twAqOG4eUn6JUZylTxnvS/Oe7mxGiPfOYtQz9qw7yJLWmZFFvHUgtAvLLZaRcfd6RmqgGzbxPwfoAOlZ30XN7yeWU6Irlzf6kC9VZ7g6DHRfEidhFKbCCGvluzu2KKUn26EdgMymiQ8eZWTX9WQLHRNZxvoNOAMmdD38DcGFmidHorXKJXxFDLe+29y6Zl3KJ0ZXmRNTDX6OZArWYQM3/LX+jM+50OyW23EFDD5ISdU5cz21RTa4c+y7pxtjwK7z/JXuWgnOCI1yemY74rOMpYoEtrHuNZeM2n9/WNe/Jbjl0QlhX75YmAaFKjrUx5B6aPPGf9xXxwyqtSBG/kNTs2z5o4DQvPNwS2usiG/MSjtsxUnBpLTLugP1fo84EoVYOt7Icq0Jlmj84D2QwRAqAH8CrbfMAPmEvGe4XjoZVWD28ed8MITwzHo9Dya6+ClucGR/uw0xgROF/dayn2kPva7+0ZXGxFyMtfu1CddGCRe5R7rRoj9coTC3ZzATGlBsgBxEeZtzA9Evo70YzP0DhZdd11kWeYJdZXffL90mWKPDMMEW+E1YuXezwiwaYiEGJyv+qoo9LVZSERMhXYQAnJhYdCz8vexDfz2ZuBySuynP/SreyoWR6neH7Os6lchATg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(261102123227099003)(18002099003)(56012099006)(261021121427099003)(11063799006)(4143699003)(261028144727099003)(261026140227099003)(261009223027099003)(261026121527099003)(10067099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3F3ZUErc2hBUzh2Q3p6VjhXbDNhNHZTWm91clN5ZGdMRHRlMFZ0MmE2VG9t?=
 =?utf-8?B?UVJwZnpCSHd3V1ZBTUpxQldrV2ZMNDBzeXEvNWlTeGRuQTFlSFZmOUVoODlN?=
 =?utf-8?B?MTRDbFl4NTdBSWJCakRpbjF0dHlIVExBZVNZWkNIRXhHd1NrSWFqTjl6NzNk?=
 =?utf-8?B?SE9pcUZ2a1JKcDFmc2tYMVlFeEVsbEtvMG5xcWdMQWZMTHgzVVg1Q1kyb283?=
 =?utf-8?B?emkzMHEzRnA4NXNNSFBNVnljUThhQjErTWV2VEFkWTRMcHk1RGJXeWtSZGgz?=
 =?utf-8?B?bHU5aytrU2lsa09JWEJmbXUweExESGVPVXRiOUZlcFpyY0FJSjlOdWRtWFQx?=
 =?utf-8?B?clMyV3lNVlhNSzZIbXgzUW93eDBsTEdjeFVjU1dCdThhcVl6V3JmazI5TXpJ?=
 =?utf-8?B?WTNEMTFyUjhQZERDNnBKdzBGdHpSSFc5ampPQzdKSU9uc1RIczBTRTVIcUor?=
 =?utf-8?B?SzFabm42dEFFTVVQZlNaNUNjUDlvbVJCcVlCTzQ5bndFelBoMXAveng1S2JO?=
 =?utf-8?B?ZW4yWWRuaWVHSElFL2lEaFZjMVlNSERZVU9ERzdkQUV0U0M5ZUxITlJaU2dN?=
 =?utf-8?B?djloR25DUndqVUNOd3JzaDExcjVnSkJxSUVaUjRWbVRvM0JvWVoweUxGVmVT?=
 =?utf-8?B?OW9QOTcrcU84NzQxRElBZHM4empoSXIrdmwrWVBtdkkwSkQ0VklzTEFhYUEw?=
 =?utf-8?B?MGQvUWZSSUsyYlFvWWdOVC9Fc3FvekZ6TURYY0R4MkRmSUZ1M2Y0Rzc4aW5h?=
 =?utf-8?B?WndsZnp6Q0RzcEwzSmpjZThva1NhNklCSEl0eHM0bEhicE5WTkVBb1BURFh6?=
 =?utf-8?B?YnhORGJNQ3RpeUtHQnNIZDFSRFRVQkJ6VDVvNEdBcDdiNEVpbi95WTM5eEND?=
 =?utf-8?B?SHBtTldDOUxYMkM4K0tlOStNTllVdXBPVzFqR05ZWXJqaHdjTTJJQXJEcWYy?=
 =?utf-8?B?VllDbGJucU5pQ24rUDRYUGs2YmtLT2MzZFJFMEVSbWhBM2hYaTA0aUlOc2Jr?=
 =?utf-8?B?RGRaMnBTMTFOTUZna01MV1l1TGp3K1lFdGxWRmlBVzROMk90K2FXNkxZejZR?=
 =?utf-8?B?RFgwbDBPUVJQdndwNWRRNVN6cjQyc3dmcExONE9UTkQ4OC80aU1waWVQSFhH?=
 =?utf-8?B?NU16SnVxUVRLVHVkcnNuampkVzJPNkdTTzd5YTN2NnF1SDlnODVERHlqOCtr?=
 =?utf-8?B?c2NEZWRlMDhWWlVqdnNxYmIwaldtdjJuZS8zTUlEZXUvczFyS00zdFJEVFZ2?=
 =?utf-8?B?UnJIdjNPRFV4d2daVjkyVzRSSUsyRWlrSXBIekZzUFJhckM1K0NkbVQ4WU9q?=
 =?utf-8?B?TThsRXdtQ1pBeExGQ2hsNlhKRGpITW8weDFkUS91ajRJK3JJem1lMEJ1Y2lU?=
 =?utf-8?B?R2JneEFSd0ZzY2JPeEh2NCtlS1pxd3NNcUJnOGdXRy9SSS9ldnZFbWViVm02?=
 =?utf-8?B?d2ZpZE81aCt4ZVJWd0R6QzVqZ1FhLzNUTlZRSWlOY3ZOMmhiMjV5RFgvYUV5?=
 =?utf-8?B?blVEK2kzYlRyYjdCeGVJZmtqNStaTThraWx0TWUrYTMyUWJIa0hGSXlOQTRD?=
 =?utf-8?B?UDl5Q3Babi9oM3JsN0F3MU9TcjQvdDNueDRnNXhGK3UrdXdyeENVNTYyK2xH?=
 =?utf-8?B?MVlnOXl4RE9PVnhmbS85b3h2ZUtya0tyeXA3cDRYUzRBRkhaZDNtTzU0NGxZ?=
 =?utf-8?B?eWM2d1R1YmllSnlIQTc2MlZDQWJaelZRaExwZGtQTVVvM2hRMU8zS0tDS2JT?=
 =?utf-8?B?QldRVjlMNG1jdGxOc3hzUnluTUI3OTBmQXNmRW00TzRxNVVyNjhoKzkrK3FR?=
 =?utf-8?B?dSt1ZlB1eHRuMlByd0Izd2VqVWlDOFBNcFlrakpnWXBWRVJtOVpreVBuT2hx?=
 =?utf-8?B?TExaYldPRmluSWg3ZGlrMG1sdCs3Y2Z6bkJmSm1FRWNYVUNsM01FSTlaSitS?=
 =?utf-8?B?VDVyVDNLb08wdFQ0UTZRakR4OE5wVVQ5anNLNWdybjlvSDFiY3Vjc1BHY3RQ?=
 =?utf-8?B?cUlhQW10cTFJV1YybFJwR2RRQUNsdlRJRXNLa3pqMHhjTENrUDRzZ0UybW9S?=
 =?utf-8?B?SllVc2h5UnhraXFTUW5nR0M5RGFia3FZeHpPMEdvTk1jbUZ5aEpPSTdqYnNa?=
 =?utf-8?B?L0dYZFdnTjBMNUhlVVB5U3JLY1BXUVcxMEt5WWRhYnNLcWFWNWMxMU9Mak1C?=
 =?utf-8?B?Ykh4SXhjcCs2WjlGbEhONkxueUxVS2hYMnhJZVdYdko5NkROelMvdnZLODNW?=
 =?utf-8?B?R2tLR1p3Mjd2ZTR1N3EvakF6NXg1N2E3R0pmUi8ycCtRWElITnJoZlVFL3hL?=
 =?utf-8?Q?KJRhwC31LOqD4vG6Pw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccee873-ac2f-4256-30a9-08df39587cbf
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:13:52.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GvAW/hNt8IvlkSUg+RWEqqnNBnCVt2T5vleK2zX0n8DI+q9u715ISmvm862W+VK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091

On Sat Oct 31, 2026 at 10:13 PM EDT, Gregory Price (Meta) wrote:
> Onlining the first block of a zone rebuilds every zonelist in place,
> shifting the slots after the new zone.
> alloc_contig_frozen_pages_noprof() approves a slot by the caller's gfp
> and nodemask, then loads the zone from it:
>
>   CPU 0                             CPU 1
>   alloc_contig_frozen_pages_noprof(GFP_HIGHUSER | __GFP_THISNODE)
>     slot 0 (NORMAL1) approved
>                                     online_pages()
>                                       build_all_zonelists()
>                                         [NORMAL1]
>                                         -> [MOVABLE1, NORMAL1]
>     zone =3D zonelist_zone(slot 0)    /* MOVABLE1 */
>     alloc_contig_frozen_range(MOVABLE1 pfns)
>
> A gigantic hugetlb page can then land in ZONE_MOVABLE, and a nodemask
> caller can get a range from another node.  Gigantic pages are kept out
> of ZONE_MOVABLE since commit 79b63f12abcb ("mm, hugetlb: do not allocate
> non-migrateable gigantic pages from movable zones").
>
> Check zonelist_update_seq before using each zone, and restart the walk
> if it changed, as the hugetlb pool walk does.  Check again before
> escalating to the pass that may migrate hugetlb pages, so a pass a
> rebuild cut short is redone rather than escalated.
>
> With kprobes holding the walk across the online, the base kernel put the
> 1G page in ZONE_MOVABLE in 3 of 3 runs, and this change put it in
> ZONE_NORMAL in 3 of 3.  Direct GFP_KERNEL calls with nodemask {1} and
> {2} got a ZONE_MOVABLE range and a node 1 range on base, 3 of 3 each,
> and neither with this change.
>
> Fixes: 5e27a2df03b8 ("mm/page_alloc: add alloc_contig_pages()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net >
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/page_alloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

LGTM.

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

