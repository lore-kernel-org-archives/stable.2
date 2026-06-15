Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010076.outbound.protection.outlook.com [52.103.72.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60768400DEE;
	Mon, 15 Jun 2026 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536130; cv=fail; b=lC+abBpaRL2k4THddVLBQ/cDlYHYDuIeSL4ewHwpHPNRnb7AvS9YSSLQO3vE6pAUa/LfQ5VVkp8i559mRHOYspTr8DCed0xBcWHxb3OQSxvOedEnOdgdOLtl7MIHhrd/zYGMD0VIlWUcM2He0qM5a0YjozcGzRkUOiMTSqCPhSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536130; c=relaxed/simple;
	bh=4cZk1bue+wliX3V6akGA9wQmZIxD+L6574F3dG/2vZU=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:In-Reply-To:
	 MIME-Version; b=jlxopw3j2ej4cLoDI+3VC7MkYhz/0Dk0NrkjGq66TG0QXffEHCNpiVrZKXHePPrk2dLo72oFT1As+BR5CTCS5SYLcMd6DV5Zqz3d+tRJ4eDRdMnItTv+UqQtVsgk3pN0vdNOTNpYjxHQBpmcSJGxS0fitB+PxP9VtaICxhqQPR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eXk+4gQU; arc=fail smtp.client-ip=52.103.72.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eXk+4gQU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbGs2mapk3mddrqvoZsMo/8bh/3P1emGvj1KSkc+qjHRbdr9NJsafw5epOo8vmqrJdNnedNKT433mmo9l/RHiMlPunc5fjl/ttqhTSRE/ul3izn7w4uRwhEji/yEORwZl3tqz0+QRfHKtGUhLeCwpkScEGq49ZMhHgf6qOER0YcPnVSRcmZ13i8y756jbYIvvwm1sqb8Tj0ECeSXe8U43AojSQCZc4844jlwjN7LRGp+uvq4b7mF7oV0fk44q7Pou9jDatRM0ooq2ngXTukQP9cAmUEYobYs8vBQYkWbKaUTNR0I9x469uiYL9cnlo1wW/NoWDN9HG2gp+iuYpx8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIopT/fprFf51sZrBWlo+ToR1Ams3zdbcjHw9sIDe0k=;
 b=Bo+uwg9mN6zyBKRD0o/PerRiRFVNXZgfyEmGtU80sSyJdzfWy9X/CNO7BQEsNLjz4bbo1kgHwE3oOQPu9DfENGEczwVwBGyRWH7bLR352jFmRE4bLbM83bLHnGe1tgU4h2OwyB7TZE1en29XAHX8jFzubOMvmH6gVFowVyr1ArgxHWTx4MJUpK9y5YEzHwYunECxPMbzx7tjYo3q/G73gkXoJ09p3zLGjwEJu8D53UkwOoK2THzlyyK+pcmtmlWA88LcLHDoDUO16hd/iAldHoRyaV77NUaKIb2P8epXej1ICRqyd0tRAhRVEnsmUQqTd9k/fm4Jvrr/DA8nOcIHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIopT/fprFf51sZrBWlo+ToR1Ams3zdbcjHw9sIDe0k=;
 b=eXk+4gQUBaocC2uh7BVCryJCUpbliOlIAK1dl4tktvVupu5CRntqwTAAOQTxuzCv0GPIK83c9hLh9mBYBqwELmdqAC/+h8smlnf0gzkk9ZZx2a68AymNHeDtLw8zXQRc0zgYVcxse7W4ZaitqI6+bmmiXhfdFYaG6cdm/P4q3vapXuKU7HUXgDa650ghsVElgtTBw5Db2xvV21/2M+w3Ve8ge0jHo9HSzUBPDOBZBQRnJ7PcbshJ9e+myhaalyLel5Ce0B4cR4S9ukiRUrj6CrDswmOmE7PYn8UNGiusIXv9WmqBBQIpLtXKCxnhaFsvxddH9w88AoR7xLYL7oBlDg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY6PR01MB8137.ausprd01.prod.outlook.com (2603:10c6:10:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:08:43 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:08:42 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Mon, 15 Jun 2026 23:04:27 +0800
Subject: [PATCH net v3] octeontx2-af: cn10k: restrict VF LMTLINE sharing to
 its own PF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB78811656934E713B77DA6CEDAFE62@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAHoUMGoC/x3KTQqAIBBA4avIrBP8QcGuEi1Ep5qNhUYE4t0bW
 n6816FhJWwwiw4VH2p0FoadBKQjlh0lZTYYZbzy2smNXmzS2BBdyMkrbYDfq+IfeF2g4A3rGB/
 +j2HXXAAAAA==
X-Change-ID: 20260615-fixes-239a59dc6012
To: Sunil Goutham <sgoutham@marvell.com>, 
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=4cZk1bue+wliX3V6akGA9wQmZIxD+L6574F3dG/2vZU=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLAORqswPD6xfH5tr6npv9bTLMywXR+3/bMD2eHIWd
 9P7nY2Pntd2lLIwiHExyIopshwvuPTNwneL7hafLckwc1iZQIYwcHEKwESWKTEydCXtjRHU//5I
 yyNRjT/88ca4LwHKk45+eB3s9SBuUqTpHoZ/BhLrk6797qgN3qi15nz+mjMvviZw8+sGVDlf3ft
 bfNFNdgCJmE2+
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
In-Reply-To: <SYBPR01MB788101745A9E36F6FD81CD7AAF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260615-fixes-v3-1-c7a66c65b812@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY6PR01MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: eed30998-90f1-4849-0059-08decaeffcfc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|15080799012|8060799015|24071999003|19110799012|23021999003|5072599009|24021099003|6090799003|41001999006|20031999006|24121999003|39105399006|22091999003|10035399007|3412199025|4302099013|440099028|23121099006|40105399003|41105399003|26121999007|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkRjbGRCZDV0dGRzRHF3cXFobURjRWkxQlZ2VE9PUGVTSUM5T2tsS05BbVFT?=
 =?utf-8?B?MHZPUEFIL1IxS2J5WlRRZzlNMGZvdlNUb2hpOHZRSzk5WFA3MzUycGxibFFM?=
 =?utf-8?B?ZGUvQytFNG9WVHdVNm53UFVVakFJQnEyNHFBTS85MlBhRUNpclR1ZEhzajlH?=
 =?utf-8?B?YTBMZmJFb1pBYkFlV0pUZDU4QkZXKzRkSTRQVlM3N3kwQ1FGMHZiWXZCemVT?=
 =?utf-8?B?RFZMWDhmZnBqdTZvS2dqOHJLU1hnQS8rR0xKeG50N3NVNDc4dkJGNVgxdlFN?=
 =?utf-8?B?cklaOW05YWpoRkZBRmQrWVZDSG1zeUp6cXNlL0VsRys1czh5c0pJV2lURU8z?=
 =?utf-8?B?YWtUKy9xeWhjczlOdnZ5V3QzSDk2Y0tkMlZzYWdMVE8veVNVZlRwWXE3WlNY?=
 =?utf-8?B?T3RlYTRPV0p4bU1FSzJSYnAra2I0b0RHaUFnQ21QdFlybVp6S2pFOHNCclhO?=
 =?utf-8?B?b09jaVRCd2RRR0N4eXE3bGF6blNhdUJ6YWdhRFFQRC9pSkRYbG9jc1RIR3ZU?=
 =?utf-8?B?bU13a1M2bC92RzZNUVdsYi82RmtRQ2JSVys5Vk9FSmh1UjBCVkFLM050ODBm?=
 =?utf-8?B?WENYdVVFRTJ1VXRtQkx6TzVobFhVL2g0cUthZWVFN3VtSGJhWFU1SEpvL25I?=
 =?utf-8?B?Y0NuRTJuSHA3WVNaZ3JMdTcveXEvakJ3bERkT3ZqTlVXNW9CNkQrelovVWJQ?=
 =?utf-8?B?ZzBnS25RdVl4c0tUN0ZSdk5ERXBtR1FQalUxbHplcHF0ZnpZbXdXZnhrbVpV?=
 =?utf-8?B?SXduR2VZMzFRMGNDbFRUY0E5clVrSmtYNHhENGtEZm9EbnFnZkVqaTB0TkVm?=
 =?utf-8?B?aVYwbUU0YUFwNmFiRCtsM0RSUGIrNG5LN2oxb0NMekxqdTA0QmZvRkF4MFpH?=
 =?utf-8?B?cUR3Q1dKYVptNXVzeHlMcUdaWVlySjdkRXMvalk0SmxRaWtsc0lvem5NQlNI?=
 =?utf-8?B?SVZ2QlpQRU5kZThCV1RHTWRybldWOTVkcGtKOVhWR3ZzRko4QzlERzR3a2Va?=
 =?utf-8?B?ZFd0MFJvZFMwVG9wODU4TGpHNTNBZGJpSzlrNG1MeEdmTjg2MWM5UUt3Z2M3?=
 =?utf-8?B?OVJLU21NUTZ5eGRVRkdKV2VNTHA3YlkvY0tWZEF4dDNxOWdXRnBkMitJeUZh?=
 =?utf-8?B?MjVnc1ZocExJOHdyb2o4TWxjUWdNcnN2TjJ6TEFXbGdoc252UzJvdmhXaWo0?=
 =?utf-8?B?aG9LeGZEQlNBeXJKUU02QUZHMlk4WlIwdm9SUTRQN0wyZ3dFdzMrNFk0TkFN?=
 =?utf-8?B?bGRKQmhlNEt5OWJzTWVNQUpwemZWb1pBN1k1YnFScmZhTmltRXFuTlQ2dG5R?=
 =?utf-8?B?Z1VJenl6eGl5UjBuR0Z0cjlmc2gyaGRxS2ZrK1prTWJCQlpKajdwM3huWEtx?=
 =?utf-8?B?VkU4L3RvK1ZyMjBxUm1RS1dUZ3h4ZnpIYnJYcE5EQk5nSFJJQTJJaTQ4R1Jm?=
 =?utf-8?B?VFlVeFI0MVRzemw3TzBDZWdIVG5oOFN4ZWVRQVFUVDhIdXlUanNQV0JTcTdG?=
 =?utf-8?B?NWRXYXZ3cmtacUMvV2Yya1hIK1lDSlh1RUhkTFptbzZwZmo0TzZXdERNMWVl?=
 =?utf-8?B?SmlXMFdlQ29LMFlkTnZmcG5sbXdick82NENSWTVxUXBBVDQ3K0dyRWl0WFQw?=
 =?utf-8?B?cmQzU3lFRm81VGpzSFhqckw4bit1M2UzMDB5cmtNN0lTYUJOWDNzdlBoT0dK?=
 =?utf-8?B?RUVEb1RPVWVxMElxTUw2REMxdTd6VDBkV2pxRXpVdnZlUUVzbTBoYkF4WXFI?=
 =?utf-8?B?Z3JtUFk3djBUd1o4ZWdVVU01MVFPVjU0dzk1T2I3NWZLSngveVlleTdvQUV6?=
 =?utf-8?B?UmhWN0o3SmtvTTVoZDZId1I4ZjhhWG02TncxenlDaTdmWEQ1bVFZNDZjQjlZ?=
 =?utf-8?Q?duOyg3eRiJB82?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTVMQ2FLY1EyUEdrdko4Um56RG5PWlJlL285SjVnMExQcEY1TjBlMzF1Y1F1?=
 =?utf-8?B?VXV1MnBuVDJ3RVRXdHdFZGY4bVB1aSt2RWFXL0lIbkdPakVoWGFldUdZRzQ3?=
 =?utf-8?B?V1c1TjBMcDhkUExHTDV3WWRlVW1uTm0zZFZTTjgzT0Y3bm11Tk0xZDlCRi92?=
 =?utf-8?B?Q2RKbmlla1NEOWtHZ3ppZHM3VjFqUHdQRDJzZUNDbFpUUjRWUy9FbC94aHQz?=
 =?utf-8?B?MzRCSHdtQmNuWVFmaDdmRWpjLzh4TlRPV1IrQlYycTFVa1MzUC9teWg2cHRn?=
 =?utf-8?B?TDdmNWtxb2NRZk9MNGEvNkM3aW16R3hTb1dtZE9IMUtUbWRueGs2WHJjbXY2?=
 =?utf-8?B?djR6emVrdjhEMHVxRktiVFlBVVRQK2Y3Y2dhUFNBTkYvUFppdU5NWWlFOUNQ?=
 =?utf-8?B?NjZlWTcvZ1A0Wld2WG9GOWZwYUp0NnRJVmNzWjJMRzNkK0VYZVYyY2g3cXE0?=
 =?utf-8?B?ZzF0VXl4QnJJbDVDMGNCMG5nM0RUTWhDc204REdKaTcya0FhNUtzUlQyVDVY?=
 =?utf-8?B?dmFTODdFR3NUYmFMVHBaZ2MwMmUxY0p2SERyckREZm40YTJGMWVmMUxLb29q?=
 =?utf-8?B?b09NMmZDeW0rYXdwSnp6R29GdW9wUHp2RS9Jd3pxMmF0NlhTNXVsTm1NeVVs?=
 =?utf-8?B?ZjY0M2tNbHQzRno0Nzg1N1N1Wm91YzFZVWduQ2tVRnRLTlRuQk9JNkluWW5z?=
 =?utf-8?B?RzMzU2p4N25xa0xYTWNudnBSQWpoRTUvZlA3VW5yRDNaODZDKzNCazUvVDVV?=
 =?utf-8?B?MXQwdXZqSlZ6L21pdTE4ay9VcU5seXJZV0hNZjl0bmFxNUp3NEREZGpkRi94?=
 =?utf-8?B?bVpvS1BRcGYwY1dRUE80ekJIVkg4ZTN5aFBqK2hmWGFrZGJ1TFBmZEJtbWV4?=
 =?utf-8?B?OXJkSTdTbU9jU29mcStaMlgrMDFPcHRmU2J5a05RaFl0a1dFUWZlVjhYa1pJ?=
 =?utf-8?B?SkNySmFoK2NkQnYwWEk3OGVMbkpCeWdSTE93S1BPY2loM3FGRVFLMzVYbnda?=
 =?utf-8?B?TVMva21XVFBCdmRzOFE1OXMxc3dOcmhBSXcwZWZuZjJKWXJJcEk3ejJMRllG?=
 =?utf-8?B?RENNOGMwMUhqRmtmV0tPUmxlTUtNVUpYUHdHd1hkRzBmb0RoaElFalJkVnBQ?=
 =?utf-8?B?c2Rsd25wd1VJa0UrSEJWdEdkMFZsWUdiRW5wS21ES1Z0TGJPRVYxazFrbnRk?=
 =?utf-8?B?bm0yRjZIZ3J5d3U1OE1ZQjUrV2E3dWs5Y0k1TmpDemdUNFgyTFJuN0VPS0pO?=
 =?utf-8?B?SFNRbVN2ejhXVUMzcVVlNkpxb2x1UEREL0IweUI1dHhIZ1AySXR2M2pnTndk?=
 =?utf-8?B?amZmUlNOekticDV6RkV1ZUVyZ3hKSTNmWG1KTG9KRGdsN1A3UndVbUtFaUxK?=
 =?utf-8?B?RGFXVk9Ld09adGMxNk9NTGZ4bHZ4STU3dkNuTm9Hc0hId1V5ZVhUaHRmZ1Jm?=
 =?utf-8?B?Q3ViUFpHLzlXRjFDQWNja0FvOVEwYXl3QkNudHhWWm12WTRwM0FZOVdRZGZX?=
 =?utf-8?B?elMrZDR5d0picjJpcVlVMlJzMTV2NHNSSjlDTm5vcnI4Q2F2MnliaitoT25k?=
 =?utf-8?B?NWhPelBzZld2UUZaYU5jWmc2TVEzUnpqd1lZWEs5WEt5S0k3NVJZbzNiSzFD?=
 =?utf-8?B?ZjdRMkdERDlxUlJhUUxDSGREaGhrL0tBK2pMZDVyd29nVEdPMkJyM2d3eHM1?=
 =?utf-8?B?YnVodlA4NjBsNGpnVlJZNmlzMGYyNzVDMnR6emZsdkF2OFQ4TTBqRFZpMDAy?=
 =?utf-8?B?KzNyVis3WXNXRElHdGdoVXFTWG8wY095a3h2UTYrZEJnUkYwTW9NSit3c0My?=
 =?utf-8?B?Y2hxaFZTZzhLeCtHNFp2YzF4cWVBRkFsYmQ5M2haUk9zQVFOYkFIR1MrU2Vj?=
 =?utf-8?Q?RhylDRLJ8yqHH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed30998-90f1-4849-0059-08decaeffcfc
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:08:42.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6PR01MB8137

rvu_mbox_handler_lmtst_tbl_setup() uses req->base_pcifunc as a direct
index into the LMT map table to read another function's LMTLINE
physical base address and copy it into the caller's own LMT map table
entry. The mailbox dispatcher authenticates req->hdr.pcifunc from the
IRQ source, but req->base_pcifunc is a separate payload field and is
not sanitized.

Reject the request with -EPERM when a VF caller's base_pcifunc is not a
valid function under its own PF. is_pf_func_valid() bounds the FUNC field
to the PF's configured VF count, keeping the computed index inside the
caller's own slot block.

Fixes: 893ae97214c3 ("octeontx2-af: cn10k: Support configurable LMTST regions")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v3:
- Validate base_pcifunc with is_pf_func_valid() in addition to the same-PF
  check: it bounds the FUNC field to the PF's configured VF count and
  rejects non-existent functions, closing the wrap. Thanks to the AI
  review forwarded by Paolo Abeni for spotting this.
- Link to v2: https://lore.kernel.org/all/SYBPR01MB788101745A9E36F6FD81CD7AAF152@SYBPR01MB7881.ausprd01.prod.outlook.com
Changes in v2:
- Restrict the check to VF callers only. PF callers are trusted and may
 still share LMTLINEs across PFs.
- Link to v1: https://lore.kernel.org/r/SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index d2163da28d18..fa4ea1258d29 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -178,6 +178,15 @@ int rvu_mbox_handler_lmtst_tbl_setup(struct rvu *rvu,
 	 * pcifunc (will be the one who is calling this mailbox).
 	 */
 	if (req->base_pcifunc) {
+		/* A VF is untrusted and must not redirect its LMTLINE to
+		 * another PF's region, so confine VF callers to their own PF.
+		 */
+		if (is_vf(req->hdr.pcifunc) &&
+		    (!is_pf_func_valid(rvu, req->base_pcifunc) ||
+		     rvu_get_pf(rvu->pdev, req->hdr.pcifunc) !=
+		     rvu_get_pf(rvu->pdev, req->base_pcifunc)))
+			return -EPERM;
+
 		/* Calculating the LMT table index equivalent to primary
 		 * pcifunc.
 		 */

---
base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
change-id: 20260615-fixes-239a59dc6012

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

