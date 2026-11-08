Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794144833;
	b=yCxqEVR+oF/YRPVoG+i3azB+MjjWgl1TPSNa6A7V111/xzOYBZdv/2TCk133zDYaSPCy
	 uV4KY3Q10NVFhuJD/jPgvBaLsIOYYYsXDZBfOGExCu3MHhLG/jhcDhNWzZCBNaAwAuX13
	 H1Qq7163BSIUNZg1a++t30TQvC/MMVsw20zgha8FU+5UG+E9Hrb++TOBP6Wpb/2bWcwOy
	 m7Em8VdxIYmklVZnWJ9x6gUjxvdWwv3Kigtn+QSE3iwjBUwppoG1ZD+REl/RLs+b9yqBF
	 086V92QjvNEXW0/8zCBiUMPvvfEw72BUd45cjNvmFifLc26nK+W/yYuEkrCZnHQyeIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144833;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=u3xBuhqWgaK/SFztpGcuD4zcTFheFGff/nVdNVTCDlE=;
	b=PbPoZzNBNFBcOn5ZA2nwMFa2e5jvs7Jlh6IzMK1jdpEZy9/VRe+aQtsMMnQhJludWU8T
	 iIuQuWdkNVVKF7K+4YgNl1ohenua7TrCp6+Nd0zPKeAIMHZwGEZuiIa3MpMQGG5JcZDma
	 FM0K/+QfPpj95ikKeB6BbgOmEGhe8Xlhpo6/PCZjAcmNagNyojj9pvkZYjPGiz9cjTRXY
	 HX64JtnzCKwfh9FLF5AhE3iCk2aGTp9pNMdpUGpFjUrJRfBAkOy1Gq5tihNwVECmuUhLl
	 t7hD7+vnk3zW0nQjWiUexjsyYtp4vsGQ2Ph7BomcKyRQCSPYdNEJTj4sgrfRVJgGeUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jljYBegO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.137
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022137.outbound.protection.outlook.com [40.107.193.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740E606A31C;
	Sun,  8 Nov 2026 13:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1740E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jljYBegO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqRDYGfV7oyEjVRy1G9FS9/JqERckdUoXoZKjUQ+YOq6gCTcMx1/CKb3U4pj0gJyujH+qtwEqA96HtvnkpBF6hYsOgwUJ7040nkRoWLiL+MAvKAbzJIqCpXgxb71Y9s2NJvQ6NNbk3tc6m+do8xOmmllBN+PxltB7fMh8YN976QqUt1MnW+fSYGRqrHT2ySbXsTa/PwXIiREYVzMiFtT8z2g6KdkdU3Qkv77JorEXc/fKtJHpwpyqEJzYKeMuIWUynO/GYsRJXLeL3C4mRS9H02RsPYjeXzdFw9cmv0r3Ga1FtqDBK3RzkfqMV/kicizQgesAfu/viQrG30enzzjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3xBuhqWgaK/SFztpGcuD4zcTFheFGff/nVdNVTCDlE=;
 b=ov0nx+ko8+iRcL2DDsjasXRUsydsu+cNE57qoyOSSJS0XqU/ozZC9xC1GcXN2Uz7+xHuYoXKgh2zHlTnvWyeWST+SwPXTTHI+2Lh0hztKpSE5nNsTl3rwWtiYdERh+sRjwRPzeCiqjieagg8uzN/EQ2LvYqqKBxcNe1bAkxwwYCLryzZe34ZjYQIVjcPUcUeictktpX2j+uCRKuEt+VQbWSmse+Ob3GAuMB/X4Do7BJpsU3/iUJZyWJqMmaeSM3lQst54hikFKnaaRiw/eH7AsHX44KpfHSq9Y47hnuI2VwQ6kfBnCWEyttez5+wcgTdxBMpJ3GOBtXasEbt5DBzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3xBuhqWgaK/SFztpGcuD4zcTFheFGff/nVdNVTCDlE=;
 b=jljYBegOMwn4WV7eSk7XeLEoWhtlqyrWb8YNCggxNnMtaMIdKZ50JSUWKw4Fc3ONHZri43m0H1zAVqUKc0RJyCkDAygqAt7cfsRDGVd4O9zn5hvdg1xWRGPrFdcIBaoyqSOAQEXywTb7d5a1BZKzI1Q6AU1+4JM+8UoxVTByAe4tRscbhu1uhFlNp+JxnLYXBU4l+lo63I3/vvnOPgjBDtyKEyRfiPaS2+iLM44rr5uFnsAPlLIac4uZXmAaZIzqzd4lc59lBpGoNS1u5AHWIF22yVILz5hTRBSW4dx55kFR9V0uWdzjOM+PsZNJIjNHdafs8mDcI1222l1oh/jsJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQXPR01MB5676.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 13:33:48 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 13:33:48 +0000
Message-ID: <74b00dcc-113f-4532-81f5-e7e0814ddc4c@efficios.com>
Date: Sun, 8 Nov 2026 08:33:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/mmcid: Synchronize exec MM teardown with
 affinity updates
To: Weiming Shi <bestswngs@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
 co+cab19e2ebe4d535a@bugs.sh, Xiang Mei <xmei5@asu.edu>,
 stable@vger.kernel.org
References: <20261108132634.2650642-2-bestswngs@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261108132634.2650642-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQXPR01MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: ae871fdb-5f64-471a-0fe8-08df3d9ceb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|10067099003|921020|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|56012099006|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Hvudv1by2GnLJSkgc2lqL06CVDn+J0BMZPkG4NVj93M0Qn0n77r+CHXnqMtM7HYYWjeMJoY3Z4Ygw+KOwQSd7UwP8Sx5Dni35U99RFauo3UECnihCUtuoqLhmv9CBQZUE9j6V2XlW87AWh8OhcyE2uEJtdYxL1mHh9BWgaeVaE6zBIIvQC5Oa+bXxl5GeQyWnT67hi1s9Vcc9zGOYilAyri5khAhJ0Fz/kiqxrgIYSsq9UY2qmjUVzYVz7vRh0lg3ZYZDmVgmuWj8RmpXH2yX478uHmK0ggibd0Wq8sTRXB3Fx9E1AjzsTc0qGs08rDJTE9qC0YRQfbmDocbBBPYffjbu8DhzJ31paH3X1e17rU+To+JI66dWbwfqvtusv9PmCC/JDqM/9HSQDNjjEUzC7ZF3tbiFi1r9+P32bknKWrYa/moZcLDM2Vkc4ueo6xt8Bq71GsHCyjIRCs4IU+iHehHtWQgYeGdjXrb28j3DixQajwo5OW4XkAY5Wj6BXePcnwT3qQ1ZEQRVb8IAD3bZ7GGl3Toi3TZi0d2C4ExiqTDOEyYh1V+7WzINhdr8klBX+43QgVCeKVUfxcoxHHzNFCslC4fjppqrYbfwEpj7PukT04YEzWTHel7EMa5eQW1XLBJBQEPNoi2CtuT4PHlVw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(10067099003)(921020)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(261021121427099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUNFRlZtUjNyUFlqaTgwQm5qeVpJTWNIUERGS1lndERWN2pYZTE2Rlo3aklN?=
 =?utf-8?B?Uk15a3lyNnVHOUpidDJWWEV0K0JIUEtJR1NCQzh3ejNkRzE4NzhxU1B0QXNX?=
 =?utf-8?B?bG9xRUxEWkdSVGV2VzUxKzlmRnJiOEYwM1JtWFJFZXNkMUk0bkxic3dpM2Fv?=
 =?utf-8?B?STkySHY1Y1psc0RwRUplVmIvTTNSZVpuUFFmQnpzUHpqY3Znb1RmVW96QzJ4?=
 =?utf-8?B?VUdteStaSjlZOCtQNDNaaUh3SVF1Q1BIV1VKTUZHK1RpU0YxL1ZURlJ1UVlL?=
 =?utf-8?B?UDZZS2llQndDZGF1KzF4R0FaZmU0eURHZDluNmI0QUJlV1pUZlFWOXJNM2gy?=
 =?utf-8?B?R1NpZElmT1lWazFJdXpMNHlrMTgxVVRSU3d1ZkJUUlM3U2RQMk1pRHorUmJt?=
 =?utf-8?B?MnJSTGt6QU5DMW1tTC9LMExWZDkyd1hnOGpISVRGMVJreEFVT0NLV05Hc3hD?=
 =?utf-8?B?MkJ0YW5Yd0E5bEw0bm9zR0hvRWNNWUVXcVdnZWFZRFFRRzdvNDFZbXJtay9Q?=
 =?utf-8?B?cHJFTFZDa0liU0EzNEJGeDlJU3IvYkdSKzMwMkduL1lWRWMxSWpld0Rna05R?=
 =?utf-8?B?a1hNWlhzRDA4WXlKbk5QbTBsK2VKVkZIdzdGNkY2NEJwMHVlOFV2NnNVVkI4?=
 =?utf-8?B?ZmE1U01URmUxd2xwc0hHbXc5V3NWeTh3Tll5dklqcTBkczJBRktVblMwdXNN?=
 =?utf-8?B?T3NTcDF0aEpmZXF5c2RLUWNsaVJZS2JydVZWR0FvdDJjMjcveFZoR0kyV2hv?=
 =?utf-8?B?NUJnRjlwd2tOYlhHUytWd3JJRVpFS0tzbWhjMTkrMi9TUWo5TjZMOURGQklP?=
 =?utf-8?B?MzdZRDBySm1QNm9Zd2JUaUFPMDBFYWZNd3VtRlBFQUlqcUxCUmlPVTRKYXd1?=
 =?utf-8?B?eE80UXhyd00wdWtsRkZXOTZTejhhTjM2T3hDZVgwVlpyanFXajB6NEVTUHVj?=
 =?utf-8?B?cG0xSjlhQ3VzY2dpODA4ZFdqUFNieWVoOVFVYiszNW5yaGxlN3oyY3J6eHFZ?=
 =?utf-8?B?R1I1SnVHSXAwWUFFcnk5OTJrYTJWTURiOGMwVDlRTTVOczBBc3l5MG9zVjRR?=
 =?utf-8?B?cEhlOUVRcVc2WVR4OXp1VTNiT3Z3bFZJSFljSy9ZbFVSMmx3cWcrY2UvZmN4?=
 =?utf-8?B?YWNseG1ITEU3dlN0UzN4VHhiUHM2QW1ha0tHajhoaEZXWlpsNTFDYUxtZDBE?=
 =?utf-8?B?aU14TWw3V0dhclRxRTI5QXF0dTEzc2hWRjlnU3pqM0NqRTZhTG5WT3BibGlU?=
 =?utf-8?B?WkxjZmtRYXhGZHNSK3k1MmFxejN6dTMwbXd5WWszRVh6ZnU3ZU1PWEZIT1FC?=
 =?utf-8?B?Nk9nWUZIV1M1cW1lcDJYNWx6eHV1T0pGUDVNcU5MV0FZeDhNbGJXOTJmZEEr?=
 =?utf-8?B?aVVwT2luQVRhcEpEWm1PVDlOYTdCVVRuRlZkVkNRREV3YzFYVWR1NnNzTjJq?=
 =?utf-8?B?bmRsMUNCMjRlbVFRdlltekltMmh5eElsMDZSNDVNb2lrMEZPY3B2RWpOMjBT?=
 =?utf-8?B?THVFa0RlRDkzZ3l4MUx1cm5ESVJtOGVaZlRldDg3RDdxMmNnUXdtNWxzQ25v?=
 =?utf-8?B?WjlZbGVuR2VLSElnTEF2eVIyK0RHb0YxYlNZVjkwSVc5cU8wV3dMa3FqQzdR?=
 =?utf-8?B?bzVnYm9NTXd3eXcwQTFxOVN2OFRlTjRhRWZDZGhheCs0ZGRWUWM0WVBMRkZW?=
 =?utf-8?B?LzNZcXRCUko0cmp1bkJ5d0RLQkZWaWMwWXJyVy8rc2l0Y0FldUdCV3NYb1pM?=
 =?utf-8?B?SUxza2tSOW9RZ21CTVRoLzhFS0ErQmNNTFNYemczaStCeTBndDhkczI3TkxR?=
 =?utf-8?B?b3AzOVlCSEhzZHVQajdySDNsTXJ3NEI2eVBraStyWVdPVDM0Lzh5MHQ3Uzk2?=
 =?utf-8?B?L0tFVUo4YWZDbmZHSzY3ejVuV1B6V3o2Q1I0UWpibDUxMkxiNStPbFk1Vk5X?=
 =?utf-8?B?SnFrYndqYkt5cjM3STd1TWM3MDNWd2tkS3FreDF1aHVGUDNZWHJPUm1oSi9N?=
 =?utf-8?B?RlpXamNUaWRQaEtDMjNVM2NUcXd5aEw2UExmR054T3A0NU4rWVdVcVlXencw?=
 =?utf-8?B?bGd3ZmhROG0xdGFxT3UzZzQxNWFtTDlucjJlWnJyM21XMUVPLzlqbVY3dHk2?=
 =?utf-8?B?eVArQnRqc1BGaW5zckU0cERqa1FPSWVXYWpwd09qNHBHcGVGKzZQaVVqU1Uz?=
 =?utf-8?B?TUVwbVc0bkhRV1M1by9MYldFeUNTSlZVYjZhUEh3TlNMRjRNb0dTQ21CZzhk?=
 =?utf-8?B?am9TK1hMNGZiUUxDaU9xL2c5dk5qcWtHZHlKUG14OWFsL3ZVaWtTK2Zka3FN?=
 =?utf-8?B?QW1mM01hYlJaeHo3Q2JZTkpNTGNpQ0ZiZ0JXN0MzOXZ6aG03cFFGMHJZUWda?=
 =?utf-8?Q?DuCjXtXFJJgctgX0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae871fdb-5f64-471a-0fe8-08df3d9ceb86
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 13:33:48.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbdDwxAKQxCRJ9CQ+hbb3RBSLbXS/furwIFeL5PgIol70gUx+XWfv+Vq4+JYLeUgtZzjMnNXnXUKUTz5MkNR2I5zpOJklffentkYiMd30Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5676

On 2026-11-08 08:26, Weiming Shi wrote:
> set_cpus_allowed_common() passes a remote task's p->mm to
> mm_update_cpus_allowed(), but the scheduler locks do not stabilize that
> pointer against exec. A same-owner sched_setaffinity() can race the target
> replacing and freeing its old mm. Current kernels are only incidentally
> serialized by futex_exec_done() taking p->pi_lock when CONFIG_FUTEX=y;
> valid CONFIG_FUTEX=n builds remain vulnerable.
> 
>    BUG: KASAN: slab-use-after-free in set_cpus_allowed_common (kernel/sched/core.c:10835 kernel/sched/core.c:2829)
>    Read of size 4 at addr ffff88810991b04c by task poc/5127
>    Call Trace:
>     set_cpus_allowed_common (kernel/sched/core.c:10835 kernel/sched/core.c:2829)
>     set_cpus_allowed_fair (kernel/sched/fair.c:10046)
>     __set_cpus_allowed_ptr_locked (kernel/sched/core.c:2842 kernel/sched/core.c:3224)
>     __set_cpus_allowed_ptr (kernel/sched/core.c:3258)
>     __sched_setaffinity (kernel/sched/syscalls.c:1161)
>     sched_setaffinity (kernel/sched/syscalls.c:1239)
>     __x64_sys_sched_setaffinity (kernel/sched/syscalls.c:1275)
>     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
>    Freed by task 5128:
>     kmem_cache_free (mm/slub.c:6757)
>     __mmput (kernel/fork.c:1204)
>     mmput (kernel/fork.c:1215)
>     setup_new_exec (fs/exec.c:1395)
>     load_elf_binary (fs/binfmt_elf.c:1024)
>     bprm_execve (fs/exec.c:1865)
>     do_execveat_common.isra.0 (fs/exec.c:1963)
>     __x64_sys_execve (fs/exec.c:2036)
>     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
> After exec publishes the new p->mm, acquire and release the task's runqueue
> lock before the old mm can be dropped. Affinity updates already hold that
> lock across set_cpus_allowed_common(), so the barrier waits for any update
> that loaded the old mm. Updates that start afterwards observe the new mm.
> 
> This keeps allowed-mask updates synchronous, including transient affinity
> expansions, without changing the MM-CID fork, exit, or scheduling paths.
> 
> This change was developed with assistance from an LLM.
> 
> Fixes: 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads")
> Cc: stable@vger.kernel.org
> Reported-by: <co+cab19e2ebe4d535a@bugs.sh>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Changes in v2:
> - Replace the schedule-in deferral with an exec-side runqueue-lock barrier.
> - Keep affinity expansions synchronous, including expansions narrowed before
>    the next schedule-in.
> - Avoid changes to the MM-CID fork, exit, and scheduling state machine.
> 
>   fs/exec.c             | 1 +
>   include/linux/sched.h | 2 ++
>   kernel/sched/core.c   | 6 ++++++
>   3 files changed, 9 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 8d2b14e1d455..2e1cac6a3de7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -905,6 +905,7 @@ static int exec_mmap(struct linux_binprm *bprm)
>   		BUG_ON(active_mm != old_mm);
>   		/* Defer teardown to setup_new_exec(), outside the exec locks. */
>   		bprm->old_mm = old_mm;
> +		sched_mm_cid_exec_mmap(tsk);
>   	} else {
>   		mmdrop_lazy_tlb(active_mm);
>   	}
[...]
>   
> +/* Wait for affinity updates that may still be using the old MM. */
> +void sched_mm_cid_exec_mmap(struct task_struct *t)
> +{
> +	guard(task_rq_lock)(t);
> +}

Using a lock side-effect as synchronization of what sits _outside_
of the lock is an interesting synchronization pattern. If this actually
works, it should be thoroughly documented.

It should come with at least one sequence diagram explaining why this
works, along with acquire-release MO explanation.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
