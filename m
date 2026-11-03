Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793674904;
	b=gcF4ONvzQ+h1aRHhslMZZAm0raPjSzCzNpHHlmzQQy9cMxPGCdIZ/t6EDbzYfHTrANMW
	 cqj/5ojMpeXt1q0mQyYcMTq5gu/WBWZ6uBNR/bWmaYYygGN6gSpGtzKVthpHycKt/0yYt
	 /IzXORd6yEEZixBtctN03iv8hleJ2VYIAZUjLQoCxwgOhrKReSvhwxzhcFmh8yLSajJgD
	 OqWT5DkhbtvaA7ofEcPBSWdCDkTMtKYquTwQAmDD6sByLzTFt11uJdKeaENXnq8Xv/aWc
	 rTkt+sy7TpQLC3LAWtr/bJ1eHUYCsZUjMq9fmj17jFOdstGIu6Yd2bndERW14tza8yQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674904;
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
	bh=IkElwCgd4giFwvWBgSR4/6i5DRT/RrEQQLucrCdY+pM=;
	b=AYdDrJ9FTdTOGSo7nK4rlLTtOoJGt5T0TUp3zvrqAZdiTJm6VjJFbRLCq0BeGEJ2uW2k
	 EaTQ2IGIlfIJ5Sc7IYPj1T+GtuIGTN91TwvHghN4Rg/D7TXTsbulK9gnWLYhSV9K5sg3h
	 5HC+tLOTQdIaPlR6MGYg1ZsM6YCDHTrk+Gt7v7feqKcH4gXSF3NijISP/c6eBqU7V8y0j
	 EjpYXm8C2a0w/wdyqjWbqF+G9UrC1j3Iz1Ftw5vxZUyaX/NWi39gZflJwbxkHRNqSBO+o
	 wUXpXONp/mramWO3zNXqiHbFbMLXBfDvtqAaZU5EbFy6cbkDmGo0HBrc/xtVYrrA5gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cd871SAm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.10
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83967606A327;
	Tue,  3 Nov 2026 03:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83967606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cd871SAm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYpDd9bQIhxEYzijukUWNtdqn4+ntH0+aA8aG3lYfD/STXJsxTs9ze6/DWaEpCet6HUFGWUD9ojGOErrHZ1YpumIOJnEdKywnMzMnSivkC9QthSGSQqpvjsLOksChdPVj/MdTqdBP3hCcIvMoh5kb1SCneX/p21c/NI8a6dy4H/rYVYrNl71Ywkr+6s8H75k2AaM2t1lTd6MXzmKNdhaTbmLg7g894AK1Bsd5MqZ89gbnFkCocqSCeR5KMpUrJ/RVNAAeQYRAbS3VQpHP3kOYCar5xCcoNQTUhsgA32/202reLBWtkz+BsVZ2WtMMcI3SgLeJGIAjS77CpVu1ohZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkElwCgd4giFwvWBgSR4/6i5DRT/RrEQQLucrCdY+pM=;
 b=W1XYuXS2HC9V3QDxcxJLOVvAoRMWaUifw7ffQyytA+WsIFM2R/y/0uEOEu0JT+LkvXZ6G7oqId3kVrjIv90C919pR8Mbj0IaCvoe56oB0WsSWEMKF0RD7fcAL6ni0fm92qi/fH4U84Qzn1A/i1VOVw6xXlnX524sX9lrP6j98v4feTkbQA62cMwYcrZzbTu2yEYTox9+DZkIsKCN1Nr45Da1r7yBDSmPjX9y3XTNIc8O+XDgC62HuoTN/xsTZ4xZPtYfnQR0Hrr06xym9EY0+hdqVWHvcyqaj7PNkpmcxVnum9aHKyNOsMk03ShoQ4znp+iNjIVbwG4N/W7qyuFO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkElwCgd4giFwvWBgSR4/6i5DRT/RrEQQLucrCdY+pM=;
 b=cd871SAmFgXknFoHKc6yGwqvwVeN46oEu8BryXOanCraqkov4V7HEqj/3TU/bwvxDxRq+watLruQBZ7NFrIYiVuvqBR6lT2nK+WLIFmRU7Zcv5N0LEco9vlapnzWcjVDzGymXfdjV5f7kRAZFucV0Kl/zZ7LARhdSwdfgnFp0XyTiHqb+E5LJaltkP1WXAzG2D51BCbL+nYNnW2tvY0BIDmi+59sTIK8GRz0CMhENbehoz9iY+fyEaWy3sTiJrYUwM7Y0NUCVwZgxsmRT5aprXhocxPfpkNAy2Xu1fCd3SDisghroJHO8U1dyouyiHp0YnNiwUFPjY4OaVVqJeCRrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 03:01:39 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 03:01:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:01:36 -0500
Message-Id: <DML8OO28WT5O.3U6NG100XWKZP@nvidia.com>
Subject: Re: [PATCH v5 07/12] mm/mmzone: read each zoneref slot once when
 filtering by nodemask
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
 <20261101021340.2251928-8-gourry@gourry.net>
In-Reply-To: <20261101021340.2251928-8-gourry@gourry.net>
X-ClientProxiedBy: YQZPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::17) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: e657dad5-fec8-4ae8-a239-08df3956c7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|261102123227099003|56012099006|261021121427099003|261022105027099003|5023799004|11063799006|4143699003|261009223027099003|261028144727099003|261026140227099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W0rrzj0rCFRII+xirkyfewLvivLalIUhvJUbA8IJyD8AZ8OUgA1Y2uUx2mJzjzkfgDR7eSQQG0WS1y07U3Gc1FGMWdXWISOv60PywKuJ+g+4lTQ/XRkWQnxUaoUc9ys6YH1/nWxW36bZ0eBnF7aYMisE3FsCd6UO6EigEOYouu6XV5X93KOyCyOCZRSMb+ODubcVneLHWCUqu6qTCC9VYMH0NK8EqCKNKVNymt0FTgIQ6gocc5N1N145Gwu+Huf4npwQstU4z2NVMHX3EUkkwwYH6V/ID2xBwiDrBSGsEAyDPgk/2xro6M8XlwwiuNdyKw2Mc8XOSrG/0hR7ks6uKG38dHJ6X81+u8e4rqLKGevn0a3jy9kiTVmwamQ//LEBg9eOEwZ2PtTDZO9Bi7+PNmS0Ic4SiMXiBSzHq73PvoVTahOuMvN1eEM/bfJu0nN63T3wcfAIQPoSU85sAQWHBjuIC8YoKpN8EttX0KjiXqpaES9ZRYBO+522JkzuQQvSY/uCpV9yE/cwlKR2+q1Vbai1R0cIoZlnF3v63M/WViZnowjgEcP/AV8bXFH+NpSQE+wT6eZCFDK0hN+sOYiwT3NIIiy6EFwMxGGVVSoknHx2adPfE+VO7ZaNKA7jHLtxz40A1nMMy99mqc3OKXMVVIxyaoLybPNLeiG5woYqGtg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(261102123227099003)(56012099006)(261021121427099003)(261022105027099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(261028144727099003)(261026140227099003)(261021123027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3ZYQzlBY0VYUUgyTHlCeU9OcDJMdUJYMk5qVjdObUlvaW9lYlEzeVFUUXF6?=
 =?utf-8?B?OE05TkUxTnBYWnpXZGVUaktIV05PaklYNDI1dEFMNGtvNjVsRlRpNXB4enJE?=
 =?utf-8?B?YzNLYWtRbDI0cXFUMm1CYUUwUTZyM1NkY0NxTGZkUC83VUFkUyt6VnVjS3N3?=
 =?utf-8?B?Q0kzMmFpRVZHRlgyWTNjYlViQW9lZVJUK2FtKzI2dzZSZ1dSMVlPNTR1TkU4?=
 =?utf-8?B?TVlPUXdsN3pZdTFiWjU0Qm9EN2FFeXVmdVQ2ZXlrMkpiaW1KL3c5ZmZHQklQ?=
 =?utf-8?B?ZXdnZVlFTFlrcXZkUGE5U3F0dzM4aXhpUXNtTklGeVo0c2p1UWc5WFZkS2g1?=
 =?utf-8?B?UFFiV0FvTVkvYmQyTmgrYXRJZE5yQXJHVE5SV3d3NjZ6Ti9IOEk5aVBiem1M?=
 =?utf-8?B?TE9QSEFWcGVHK1pUenFKNHVYVkdGVlVSUjhmbEdnaDUzbmp3OGxQOTZDelZy?=
 =?utf-8?B?WEZySXJqZW9CclFCQ05jekUvMFlTNDc4VU5sdnMwUXgzZEJvd25Gakc4dm5Y?=
 =?utf-8?B?YnVpR2Q4dDlkeDlaWENTUUhPZUQ2dmFlek0xREJSeDNDY0xqbTF5Qk56Qk1I?=
 =?utf-8?B?TSsvSThqcEZ3TkpEcUlMbkhoWnZ2VU5PalMxc0dRZ1NHRHJmM2F6RTUrOStl?=
 =?utf-8?B?M1VBVTY4dmdnV3VJNCtoOS9HS0NaZlByMEdyclg4WDQrU254SU5iajZPcFo5?=
 =?utf-8?B?bnZLclpXQlhyQ3VhanVwWWRLQk1La202czJna2p0WFJmZ0J6clpIUEJEV3FI?=
 =?utf-8?B?N0RGM0pKUnFrSkhXQVlWV3dNSXI0YmVKVXdxVEJkWklPalgxNm5nZ1pzQ0hY?=
 =?utf-8?B?MXdQdmdTNFJibXUzcTJpR1dWVjNNQUYrSkNzTU9jZHRtcGc3WDRZUjlUUGJP?=
 =?utf-8?B?TGw3dUV0RXMwbnBOaGhHSUpVT2RzTEhnaDhtWG5oWEdGTTU5ZVJpUjNKQjNL?=
 =?utf-8?B?SGxjVittTmRHZWhzdjFPT0djQlAydHV5bi9qYVc1ZmQ2UklXbkEvbDBQVm9n?=
 =?utf-8?B?K2VpVC9rTFdOeDB4NnhNbjQ1bDZkMEo4MUJCaG1vNlNJUWxYK3V2aVhNNks4?=
 =?utf-8?B?dmZHUS9SRFlnai9kWVJnbGxaYnpTUzFNb2oyWmRhOVpGUERUK0Y4UEhxZjVx?=
 =?utf-8?B?bkUwcHJlbUNPRmRyTG1KajhzZ1pHdGNkeGsvV0tvRldaaWtWSUtTTm8raTFY?=
 =?utf-8?B?bzF4TnNYODN5NURnaXBKUVlyNDdkcC9ROVorWnhMTlZVemxLNC84eDJlbm9E?=
 =?utf-8?B?NWFKOVE4ZVFZY09YanFoUGVidXhWZmJoQW1mTWtmRUQ0cnBiaWpROXV1SldG?=
 =?utf-8?B?RDU2WHNVd3VBdWdxMXgzZE5nTmx6WDZUQ3ltUjFCNmdWbk9LVzJjcmlPY3NV?=
 =?utf-8?B?ZTZndm9wcGN5MWYrNnhIWW9MZXFiWkJvWnlVSEh0L214eHhBZU1Mbzhqejls?=
 =?utf-8?B?eTZtcFJOcmQyd3g1QlBkcXN4VkZocklsODRRdkd2c3VhaHlPYkYzT21LMFVq?=
 =?utf-8?B?aEhBOUNVdlhzZ0E2RVNybFZ4RExqU2h4T21KS2tWSmE0N09tRjNGMlVlZFFs?=
 =?utf-8?B?WnRzaWR4KzJEaTRiOGdEYXpvaHZueUJRbkdKMkpwckNSZEZFbmNZajM3TnhO?=
 =?utf-8?B?Z01zMHdhNzEwSDFDeHBGNWNGNTlYVERqTnJuRFNmNWlxS053U3cvaWpvbzNy?=
 =?utf-8?B?cmVjS1pOVjhzQVBlMk9UNXUzM0tPeVVmdzE4UWVDbERJNzF0aHhRM1dqMFFy?=
 =?utf-8?B?Zk9NdExsYnd5Q3U4VTNLUFNCTi9lUXBrRitlSWUvd1hTZTZWQlRGVnBuSEg0?=
 =?utf-8?B?Z3FvQS9IVkI2ZFZsRllsNk1VZFJIdVZ4dW04WWI5S09hUDVQa09aR0VwblVC?=
 =?utf-8?B?WU0rVzBSeXNZRHdSb1QwdlB5QTcyazlPVEMvUkVFRVVya2NQUU5DTmY3M0E4?=
 =?utf-8?B?TTkrYU8wZ0xwa1lOMXp0c3QxRjJ2MEZhT1Vlb0ZPOW5lVDB5Z3ZCTkFqY1Y0?=
 =?utf-8?B?RmNOdW9aSngrOVl2VHhZMWlmYUhTbU1DYTNDUFdiYVlYK3Y4U0RWbERQdFBw?=
 =?utf-8?B?OXQ4ZUpLM2xNOVlaVFpyQUxCSXBnc3hjaGtPV1Y4VVEzbHV6TE4rWHdxUjBG?=
 =?utf-8?B?alBxTU13VnZ6VFBkVUszQ2NMY1lMVVNHejN3YjN6RXJXWWduVGxmUHR4WmNR?=
 =?utf-8?B?bDFNbnhuRmVOdnNyNGhBNmdUa01lVmhidmlYNVZUNG5UNFF5VzVmQmJHSUI1?=
 =?utf-8?B?MGVxWmlXNmJnbFZJby9vekpnZ2NpcStzWUJmSm9BakRvb1YrSkdDZkFvZmRD?=
 =?utf-8?Q?10Sfp+OkddMNqP5HJZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e657dad5-fec8-4ae8-a239-08df3956c7e1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:01:39.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL5gsG15AeqVcM2ZIx42y3VIDuN0O7PV2s7h2D57yVJ3PuQYXQuoouef2oenKowj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

On Sat Oct 31, 2026 at 10:13 PM EDT, Gregory Price (Meta) wrote:
> __next_zones_zonelist() tests a slot's zone for NULL, then reads the
> slot again to look up the zone's node. Offlining a zone's last block
> rebuilds the zonelists in place, so the second read can return the
> terminator:
>
>   CPU 0                             CPU 1
>   __next_zones_zonelist(nodemask)
>     zonelist_zone(slot 1) =3D NORMAL
>                                     offline_pages()
>                                       build_all_zonelists()
>                                         [MOVABLE, NORMAL, NULL]
>                                         -> [NORMAL, NULL]
>     zref_in_nodemask(slot 1)
>       zone_to_nid(NULL)
>
> Current GCC and clang merge the two reads, but nothing requires it.
> With mm/mmzone.o built with -fno-inline -fno-ipa-sra, holding a
> nodemask allocation between the reads while the node's last movable
> block goes offline oopses every time:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000060
>   RIP: 0010:zone_to_nid+0x0/0x10
>   Call Trace:
>    zref_in_nodemask+0x9/0x20
>    __next_zones_zonelist+0x23/0x70
>    prepare_alloc_pages.constprop.0+0x16c/0x190
>    __alloc_frozen_pages_noprof+0xaf/0x330
>
> Read the slot once and test that zone. A NULL zone still ends the walk.

It is better to spell out the rename from zref_in_nodemask() to
zone_in_nodemask().

>
> Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_=
zonelists")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/mmzone.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>

Makes sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

