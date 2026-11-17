Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794896062;
	b=4tZS31Tw3m/IR1PC1NJPi9XeCCibefecAdohs++JNu67kxN3FUhBC6XI82gNuyt4gzWu
	 /LwTfsR7l5sMnqhuu60z9qoi3coaYzsUeAXIOj+q4tkIDWtVyEObiI6h5VqmSApIfzhXU
	 G0b3EXyOFO0+qyAac7i8El7Rd8FXHW7X1Lp/xpx+SV0UskGstlta8obOtk2BqlUb6aE8F
	 iGajATLmF88GZSys5Edzv6Rc9Y7f95nwj0VXSd6Ib+bjVXk1erAL5+KS2ORkAqunzB/D7
	 HrVNXnv0FPbu/LTS03G6c3UG81tkC85hJZ6tOOGYntK1utkifYCqKTGE4QsHEdjiZBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896062;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7p88v13RMW25OGAJPTDuiDFwE7fvjuOWyNuOQppS/mY=;
	b=y2NCshkvPhvLAoj5axN8rwhfXoFHZfqxQYJog4nj3YqASwUTUTILLPcGZDGWoZDlc91l
	 9UJYSLyV4Ehfiu01ZOSKK5QmUIstjrtrSemJXlnncFZaYBgVweCQ+7sJI5Y2REUAesf4R
	 QndtUtVvmf05/+k3eUV7seMNZDe+EDpgDyUcNQ+IVFf4EtiX0NO8Rw0RDklPGAqarp5qy
	 Woo0w//scyph8hQ+/miTWCW8q1GlK/6cdHGgEWc/QSxyayOkheJaidyrlMzPXvCHnVHxS
	 tUMeK1TCMVHFkJvzFtkanAp2xse17z88aDgtUi4VmxuAmseW59b4FWnuP3JPGAYpIfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=dltEypvz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.73
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023073.outbound.protection.outlook.com [40.107.162.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A5D606A32C;
	Tue, 17 Nov 2026 06:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A5D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=dltEypvz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNvV+FwkhgosjjoGS3w0sS7r8sgzy7TqtfEriDL/Xj5RJCYVN8jgtfk0SW0n/IEKhExcCpGRS/Fb6cp5kQ7RVIddQfyoRXjh3Zrth3yBxZOOoA3OadKV45ziWeqklkCj5gwhJv6K+Celg8c0wRTm7gunlRknoXr+Moz6wXnrauE8FN6XwmRbqS2ERZdeCkCjBcrOvlPWku+I1YJRNbkfwXcr5oEv83OnlMD+X8su+PmyoV0IZ8ksFc59gtQSOujfUrnWwioR4DGyzzDpz2U1n2Dw6zZy5uxsaGpup0YiQEqW5jANl0dSUB9pRQzecDdZt2XXdQuFWr1h6TNdF2LS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p88v13RMW25OGAJPTDuiDFwE7fvjuOWyNuOQppS/mY=;
 b=UYzmfvSUi4ddVDtJqv6PIPozdf5UMwyFduR1WxU9aS+pyI2I5Cpv0iOCAmF9oFm+fgItsf8H9Xq819GvMyV8ym3F5OZFukBeW5PBCGrpf/7WvIqVVKBAYFCKisxTAiPOQmVQOBo0EJQSeT+idHChUuP5alGPfRxMjWTT676HaEJQ8d2ftMz9wgDBu7/tI46InKdLZHZUVvQvAwluvB7gLDGnN9h5Ms77+gxXh7oAN3q51csv78O38V3Bk7Hingj5if+dGWrsYT8lPk8I1997JlXJrWGUZ28rMo5kcx/M29W8OeW6k/bUAmaIi8juHASFWRxf8CoFJnmrmKrB729BBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p88v13RMW25OGAJPTDuiDFwE7fvjuOWyNuOQppS/mY=;
 b=dltEypvzeG4MJ40LvkZ/wZlV4SWriboM+JfAEh6J4znpDtEljChPR64FrbFr6ONHJLDfGrGxpzsLa2ZNU+GMAwKoUSwVv7B5O3hAVR12SL81ufhe6aa1NK/PWpemqEE1oBWKqUgJvqbp7s3fCYqM2rkfafNKACDSz06Aq9zG7uXeGy6WQQdsPglCbqjhCbHUf2+mqAwPRyqD/fRQ2GJXHXWEmM9meuWPtX9JKrFOrxZcgb9Aj1JXEMB3qJUBg4ZutYVB6/gRDhotpPjiVAbFL3EOjClPRJ9PHgqiyXj3EDGvoSmiMqyhmrJDZB4rRDtwNNMZYZQp3srBrmfdbOVuUQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by DUZPR06MB8724.eurprd06.prod.outlook.com (2603:10a6:10:4b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 06:14:12 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 06:14:12 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH v2 0/4] serial: max310x: transmit path fixes
Date: Tue, 17 Nov 2026 06:14:03 +0000
Message-Id: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKvw+2oC/2WNwQrCMBBEf6Xs2ZVsgqH15H9ID2vd2gXbSlJCp
 PTfjQVPHt8Mb2aFKEElwrlaIUjSqPNUwB4q6AaeHoJ6LwzWWE9EFkfOjkzGJWOvWSLKjV1tHDU
 nFijaK8heFOvaFh40LnN47w+JvulvzP+PJUKDnjpDPdWmIbok1shPPnbzCO22bR+D8LG5sgAAA
 A==
X-Change-ID: 20261112-max310x-tx-fixes-eba3803195ae
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794896051; l=5344;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=r01L2tAgG0EdpyLBiafcyv8yRJjs31ulgeieGGMhUq4=;
 b=wmcEmtW7Y8O/25wpCuHf5pPNTSpHavgiGkcCHaUpo6R2ZMDPLysr3VffzQBAxKJyKt6ctA2XB
 1LK+NoVLpp9AQCwwLtflgRJUNjZptzXMmBqqL5rceZypn75da5y4K4w
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|DUZPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: ef03df20-3190-4316-ae6e-08df4471ffd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|1800799024|376014|18002099003|6133799003|3023799007|5023799004|11063799006|10067099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	rVRQfYK9asWL1E3hIQGzeE+EUv02q2u32PpHVGvVK9+d8JzEQvRhv5F2bj3bQbNFMZhPQBzu21lgz0bGNLPvCZIRxM34QfHXaaOCKdW0cFpol5uaHdRnm0sffyi22NIoZAX6Ho1ZMXZzO/NTtXPHcBlnLrBSWipydd3/He1sYSlx1nxz55pM5Mo1BCK93fzlWhDqDVeyb0B5FqeIJ1KkryupwzwhQXq4YW8JIZBSViWMS0fYbbsOmObY4fG/CH31t/eGnj3b6ISfSbrTRt8YeKcBLHcW1ZXBNy5GEsP7VpfInYICYVwSalQaJtBKzgiTy3+UUf7856bEvfQiR6m91l0j+J4WOano0D41g3+0MEfuOIuZtxq66LvNUMzbBwoQrdQwtHB8+X2tLjdHLyyGG/hVR4YUqykBBQ+ZjM0XRr0zrwk3ITZawAr8DqNARHA2VYbHYTmRY64Av4zzBb+999wiB6av2EEMDvqi4opo7zt1032BQRRN6PqDzAdd8pPlyXqAPuQprlHfLfmInLtHmyFVLt2Wv1nuP77QLcqE5eu9CIG8S+imxJhf87pOUqWhdrjpaXHigLBHHY+e51OThYKbOpd4vFuU29yUqaeoWlXwwYe4xYs9IrZBEiH6walo9dD0LEIytK5Jf8z9AWdZrGLmSSMy9Oz5fvSUXTQe/5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(1800799024)(376014)(18002099003)(6133799003)(3023799007)(5023799004)(11063799006)(10067099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTVCS1JNZlVwSE4rTXVHdUJPY0xZQ2l6OHp0TitKczB5U3hVNjZiOVRkZGR2?=
 =?utf-8?B?V2hJY0tDcXppWHlveWdWa0RiNzNZVTV1eStleGU0SnNaMnh2QWhaQ0Nic2dt?=
 =?utf-8?B?L1RkQVI2M2RqdHFJNEdJVGdXbW1JU1hBM2F1Q2g4eGpNZHl5d25ieW5INkl3?=
 =?utf-8?B?eEVJdnJoZGJlZlpaYzI1T0F4NDRUSWI5MHcwVmg4aTlISjRWRFY3TUhUdm4z?=
 =?utf-8?B?TTRoOGhXbDZQajk0RHBZSTlmVHN5ZDZ4Tnc2UkM5cER1M1ZGc2dGclhZRDUv?=
 =?utf-8?B?LzkvY3BkYTByWk9TNXBZMHNadHZ2TlJpbVRXaFlnNkNFWUNmMGxLQ2lXOWJU?=
 =?utf-8?B?SEdiZVB4M1Mwd3VlakxoRnRCZ0hHSHgwQitGa3hMQVFWQ1BXTVdJOHJPajNr?=
 =?utf-8?B?MVkvMk4zZFRoUk5MNFd5VmtONHlIdi81WkdUbVNrWVpQVVZEbXQ5c3ZHOUV2?=
 =?utf-8?B?NWRyUmU5NUJHTWRlRWVKZTRobjYzdllmeDlQbTE5dUlWais3bVZGeTlpWFps?=
 =?utf-8?B?WGtTS2xqcU10bjQ0QkhwNlp5bTlPcVlCVGViVHBRdkFQay9JVDBrdWQ2VG8y?=
 =?utf-8?B?bFdkZ04wZXhZT2oydVl0QjZXMFd3NlBqTjJhcUwvVUtpUElsNjEzVWg2YUk4?=
 =?utf-8?B?amU1UDVndGFOblNZSzBaVzFyNVhZVWNnSjI4Wmt6R3RJejgxT21hSDFzd0lO?=
 =?utf-8?B?RjZjYmVJdFNHMXltb3puRXl4b2d3YjZKb3FPNGoxNTNmSUFRRzdZRE51Uzdx?=
 =?utf-8?B?bHlrQkIxN25lcWd6YjVGSzJMVjJyaU02bUNxcnF5c3JtNG9McjNaZWxZTDRn?=
 =?utf-8?B?Ulp1alhPWjlQc1NwSTdnejA3Qndvb3NxV3h1MWRiY2kxTzBDREV4TDdWWDBC?=
 =?utf-8?B?M3F5RzNVZzJQL1poSUlQTXlPdHZ6bTRGSERMaTlwdVVteFovbW9hRXZpWFYz?=
 =?utf-8?B?SHlYdjBLNExLT1VCc2kwbWRMTnE5TU5SZzZlQkk4ZTNVcDVaeGhGbW1DVFVW?=
 =?utf-8?B?Zmphb0RKU0cxRitlMjJkd2dKYnV1cHhDVzlGR1hreEVTOCsvU2dPN2JEVVUw?=
 =?utf-8?B?cndLQlN1VllKMDdzRkVCa1Z3UjVvL2tnYjFONTRISEtwUFpLeCtNWXBURFVy?=
 =?utf-8?B?NVc1UDlrdDRjb3Nucyt3T0h5aVd1ZVA1d2ZJbmdONVdPNkJCNzVWSnAxS0pP?=
 =?utf-8?B?M0lBWGpOV3NjbXpqTkVpbEloV0RWdzJkSVV1MndxR2RKSGhlZGJDV1laME5j?=
 =?utf-8?B?OTJvQitxVEplcFQ2K0FpdVhtOEhSRE1Tak45ZXZ0aG83ejJZRVNJR3lWeEE3?=
 =?utf-8?B?TWNHZFFSbFMzZ1BQbWlsQXV6bEJTb3Q1TGpDeUFlQzlCUU1JYTY4bkREVkVQ?=
 =?utf-8?B?TEdKMkZ3VUhYanZSVzE2aXo1aUczQSt6SjBtZDBuekZ3NGV0cHBjNEppSCtI?=
 =?utf-8?B?MHIxRzR5ZmthK3ZHbnY5WGh0ZUFibjRRa1ZkQWQwRUx5RmxvVVBVMzNyakxR?=
 =?utf-8?B?dVNub0szblZ2WWVMclVYU3FpZUhnVmFkRDdwUHQyYTNManhOZkFVMnp1SWJD?=
 =?utf-8?B?aE53Qmo5QThLVm1FaW81MVFsUUpucGdDU0NUZHp5VVdIeFVHOTA2Tlhsc2tJ?=
 =?utf-8?B?Y0tJZHNaSjRZY0dUTVZiOC9wZ1VsdXM5b2JWaG1ta09ramI4UUlobjBMN2xO?=
 =?utf-8?B?OGwrS1YvZy9aWTNXTlZGbWh1dHFnQld6c0FEaW14S1F2cEc3L2I5aGp1aTJS?=
 =?utf-8?B?eUEyQVUzaW5kT1FoeC9QWmNBWHloM2lBTnpBaTNpaFl4OS83NnVjclpGOGtw?=
 =?utf-8?B?eDRwUU1TOFg5RER4Q2dDQlVVRnBVOWxtNlFmZHZteGtkOUd3SkRrcmFpbXZx?=
 =?utf-8?B?MFAwdTRFOEd4QmtVamFvNVlKRHFCM0pDSnVzaEx4SHM3RWZEbjlaaEFlK3g3?=
 =?utf-8?B?Q2hPcUhPT3N1aFJHUjJLY1dzUEkyaXV4dVpVL0FCRHZ5SWZnZ2syemhGMEow?=
 =?utf-8?B?L2EzeUZmZ3VTc0FxaTU3NWpTM25WeHhtVlVOc2JQQVFTNS9Hd2xMZ1RlNDBF?=
 =?utf-8?B?dWN1KzUwTzhMcThRcHd2MDlTSlJ6TEZUY3RBYmNXQUFVSTBFeUlkTFNpdHAw?=
 =?utf-8?B?NW1hNUpkYkVCUlZ0S1MzOTVpdGVkUVVnNzg3K2poN0FnMHd5bUNMejB0YWJN?=
 =?utf-8?B?MmpxNTg4QXE3UDlMQUJGYSsxMHVxNGNjaHhxTU8zTkI4MWx5MjNpVjEwa3lN?=
 =?utf-8?B?cC8wUXIrS25IUzdwQ3lhZmc1enlGcWxZZnl6NmZxTVVaQVIxS3RRNGVRblkz?=
 =?utf-8?B?QUhZdmNUZWVPZDB2NmduNEJhYjhEY3FtSmpUdGhKNSt0WFYzb3dUYkVTYWtU?=
 =?utf-8?Q?7AcXzqbqNcEJxp7c=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef03df20-3190-4316-ae6e-08df4471ffd7
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:14:12.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nrs9lWhIjVwvmkMe5EmqL82LJrqNkTdHzvuH7CxMCz4oFa4Zm9EJmcmPL7gIhn0h28aeQuypxHQt3XvykPFsFMSl8UnOjTW8U/wmAexP3QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8724

Four fixes for the MAX310x transmit path, found while stress testing
the software-timed RS-485 delays that are new in v7.4.

Patch 1 fixes a race between the transmit work and a flush. The work
advances the fifo after the SPI transfer without the port lock; since
the kfifo conversion in v6.10 a uart_flush_buffer() during the transfer
leaves the read index ahead of the write index, and the fifo reports
about 4 billion bytes queued. tcdrain() then never returns and stale
data is sent until the port is closed. It carries Cc stable, but does
not apply to v7.3 and older as it is: the context is the v7.4 driver.
6.12.y and later need an adapted version.

Patches 2 and 3 fix commit 33632215e1bb ("serial: max310x: drive RTS in
software when hardware delays are too short"), which is in v7.4-rc1.
With patch 2, data written while an envelope is closing no longer
leaves after RTS has been released. With patch 3, a late TX-empty
interrupt of the previous envelope no longer pushes the head of the
next write out before RTS is up. Both lose data silently on an RS-485
bus, so it would be good to have them in v7.4.

Patch 4 is new in v2 and fixes the same commit. A flush that empties
the fifo while the transmit work reads the chip FIFO level left the
envelope open, with RTS asserted until the next write. The sashiko
review of v1 pointed at it.

Tested on a MAX14830 behind a single-core i.MX6SX, on v7.4-rc3:

- flush during transmission on all four ports, five minutes: the fifo
  length stays within 4096;
- 20 unbinds with a tcdrain() blocked on a slow port: no task is left
  sleeping;
- RS-485 loopback with data verification on three ports, 57600 baud,
  25-byte writes every 20 ms, 20 ms before-send delay, ten minutes:
  no byte lost or misframed. The numbers without patches 2 and 3 are
  in their commit messages;
- baud rate changes at random moments under traffic, each one moving
  the port between chip-timed and driver-timed RTS: 7672 changes in
  ten minutes, no stall, every byte sent;
- TIOCSERGETLSR and tcdrain() polled after every write, 12500 writes:
  the port is never reported idle with data unsent;
- xmit_fifo_size raised to 256 with TIOCSSERIAL: 570000 bytes per
  port, all sent, nothing in the log;
- output stopped with TCOOFF, data queued, baud rate changed: nothing
  is sent while stopped, everything after TCOON;
- TIOCSRS485 repeated every few milliseconds while a second block is
  written at the end of the first, with and without CPU load, 50
  minutes on v7.4-rc2 and v7.4-rc3: 30900 block pairs verified through
  the loopback, none lost;
- tcflush(TCOFLUSH) timed to the end of the delay before send, 9509
  flushes: a byte written afterwards always gets the delay. Without
  patch 4, 68 of 975 flushes left RTS asserted.

The envelope timing was checked on a logic analyser with an earlier
version of patches 1 to 3, on v7.3-rc7.

Known and not changed here; all of it is in the driver without this
series:

- an x_char is written without regard to the RTS envelope;
- a reconfigure while stopped output has data queued asserts RTS for
  about one character time;
- by the code, a TIOCSRS485 applied at the very end of an envelope can
  arm the after-send hold while a new write is being pushed, and RTS
  then drops under that write. Patch 2 closes this window for the
  transmit work, not for the work item that applies the ioctl. The
  TIOCSRS485 test above did not provoke it.

sashiko also describes a flush between the adoption of a queued block
and its restart when a reconfigure is applied. A TCFLSH cannot get
there: uart_ioctl() takes port->mutex first, which the reconfigure
holds. In a function trace of 1500 tries the flush never ran while
the reconfigure was being applied. Other callers of
uart_flush_buffer() are not covered by this argument.

Tool use: Claude Code (Anthropic) was used throughout. It drafted the
code and the commit messages, wrote the test scripts and the hardware
test plans, and analysed the function traces. An LLM review of an
earlier version found two faults, in patches 1 and 3; both were
reproduced on hardware and are fixed in what is posted here. I decided
the approach of each fix, reviewed every change against the code, and
ran the hardware tests. The code and the messages are mine to defend.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v2:
- New patch 4: end the RTS envelope when a flush leaves nothing to
  send (found by the sashiko review of v1, reproduced on hardware)
- Patches 1 to 3 unchanged
- Link to v1: https://lore.kernel.org/r/20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com

---
Tapio Reijonen (4):
      serial: max310x: do not advance the TX fifo past a flush
      serial: max310x: re-check the TX queue before the after-send hold
      serial: max310x: hold TX data until the software RTS send phase
      serial: max310x: end the RTS envelope when a flush leaves nothing to send

 drivers/tty/serial/max310x.c | 132 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 106 insertions(+), 26 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261112-max310x-tx-fixes-eba3803195ae

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

