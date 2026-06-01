Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011062.outbound.protection.outlook.com [52.103.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8232E143;
	Mon,  1 Jun 2026 06:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293748; cv=fail; b=VUNE8LcOnVpeBkV0Ri4oBvAiy9nufa9Bh4ltvgstTtlod7cfpb/LQ9bdpDcgr+2HEfXNOjrkaaQBRi7UMGdCAAjJPKIuE5aDC8WPl5OIrgmfL6CsDUS2jQFUHvERulce2AYxokBAiQ6MK1NYg9tbIpxbmADOwEQ6KhrqMO5++Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293748; c=relaxed/simple;
	bh=0pbW5UlCUbM1j+2V5MBG/br+1BvS+ibT6z0QNmaKRyU=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:In-Reply-To:
	 MIME-Version; b=Mlm0UUSTuJlgv92gIl2/vJ48eXZROP9RX1ny0CNnJtgst3yy9CVY1HRatiLSZniGAsTpQBaDKnio3LUvNikGRxU5grXWSckFVTfrAnVJsxatlHE2ZKjinvrSUiHvM/lmy1e0CiIx3SSDO69rRqAO5/7ETUdciCO6Y1tUrb6zBbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OuVK+twB; arc=fail smtp.client-ip=52.103.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OuVK+twB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0GiDly+ZfsVPaKVEiRk9eIOwq31GwfkSbEhKzb2PabFliImVelxQsH6o0paDVXKlDyhN/1SpQ45aAPyMmIJuj3tMkTsSJL0hXCdA/QfQhaY/oKtJOZZwEUTDbWpChQ4HSyQ01Z8Mpqa65ca7hAxyjGwyNATNFTCBywjoq90TdgCZhk7Yw5bDBW5er1B2u66Rjw2T7K7Xw5jheaBz2dNHsK/dn9ZOhRiqt83ShKVsAcAhrCg6NfJjIDYFU3AHvg0j1DhhWLcRbbxdRIt1V7wZDcP4bVUr8UvkRoE3NMYX8hD+k4wtCSmf8NF6Sir0YcputBG1OYxciS4THogSuYX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPVDY1S11F2PsWxpNFWBiATwZ4E8K+1MsfBt+MmeA1A=;
 b=gCv8cG5pTZe/rahf5xSbF0u1srVg62ums1jiArSlEqGgxzlWerdeQZCioS3VT5g/jhrKct4jwMkjbAPECnyc5MUqP3Aq8deHnBDLKT664JgEs4P3exeKPzSnjgG2i5W0bxlw0O71gmp23CqrcLKsHYtYZNsR03IGagRAhdIpQDgD2jQRouZ+OYA0QTE10zwDaOsXUTKbVIaHJKXzjRb5DiIJ94LMDWY/f5ihmQ+lQyDwtfxSpe/+1aR5IJ/NvflySg+l9Uh1oCEfIEXvNda8J5dn+inJCK1AtOOBYmq/s8SZXOu+38BjhzXEKfGoY/JCkiPcIH8lULjOYYzUfzem8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPVDY1S11F2PsWxpNFWBiATwZ4E8K+1MsfBt+MmeA1A=;
 b=OuVK+twB4cM1+yQ+Roi9wByAYdTpVxCkOkUFYwImrVxP5SpLytgfCsgfizsB65ERbeGwW5ayM1z379KCaTTrMyEFT4LD+vPC+JOcs2hy5v2f1gZdyjt/aow+ZRKoLFjxNDpuwZVXZPjNXlKxSe6b06Zf7Sjs06+56tG5ef9DUPqZ3ZKbkNzSDJp6x9NhoEAp5fXNVJEv03ywTNqRENtbgJn5jj3QVWbG9d8QKMRbtPg1DY1B8vbB4BnaxngSp5PcBauGsbNQV8aRuZkElFjpfED6WCRO2KZ4blA6SSPnZ/Rq6O1X4+O22V3V+ubEfRacVXB71tRmpLZy+z2aJO6Ohw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME3PR01MB6917.ausprd01.prod.outlook.com (2603:10c6:220:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 06:02:18 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 06:02:18 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Mon, 01 Jun 2026 13:55:05 +0800
Subject: [PATCH net v2] octeontx2-af: cn10k: restrict VF LMTLINE sharing to
 its own PF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB788101745A9E36F6FD81CD7AAF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIALgeHWoC/1WMsQ6CMBRFf8W8WZrXh9TqpA1hMzE6GcOAUKVRK
 WmBaAj/bsPmeO45uSN47Yz2sF2M4PRgvLFNAFouoKyL5qEjUwUGQhIokEd389E+KlAIQhHTrSg
 htK3TswjpFRrdQR7G2vjOuu/8PfBZnS/qeEJ+UGspeSZTzlPaxKiUXBFPKIn3Gaa0+8tY0fvWV
 chZ62zFbN+9rH2y0r4hn6bpByXfxZbDAAAA
X-Change-ID: 20260601-fixes-a06620632bac
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2096;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=0pbW5UlCUbM1j+2V5MBG/br+1BvS+ibT6z0QNmaKRyU=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLFm5HcdWZVbzMZjHfF21/8gs/WsPuWdwPOjvtL1iw
 dTP9sDwn1lHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATITJkJHh2lGVidl+jr48
 CVwzL57I9bgqH1XBnFYa0C3o/9wueB8rI8M8g6rI1fMP2er9urJP3I7zyseym7eO3VdW2y9nd8K
 ti4MRADgIRag=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
In-Reply-To: <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-ClientProxiedBy: TYCP286CA0134.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::16) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260601-fixes-v2-1-821d0cf496e6@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|ME3PR01MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea24501-1eed-4cca-5fab-08debfa35657
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|41001999006|19110799012|8060799015|24121999003|22091999003|24021099003|5072599009|51005399006|6090799003|23021999003|12121999013|15080799012|1602099012|40105399003|440099028|3412199025|4302099013|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VytCN1JzNklOWVp3THlSRkUrSElJUXNGNUV3eEwxaU5OUTU4eUVHeTM3T0pS?=
 =?utf-8?B?TzRyVnRLNDVXb3hGdXJjcncxL01QYTgyZEx2SWpwMUY4L21BK1RyUFFvVmFD?=
 =?utf-8?B?Y0JOR3MyZXRlUU4vOFZ2VUhSZUJGNmNnQ3NwMzA4WFNQNUxRb3Jud2tKMU1x?=
 =?utf-8?B?VDVGemFUZEw3M05tc2k2bDZEYzNULzZqa0pHTWVRODdtbmxYK1dRdHVYMDRP?=
 =?utf-8?B?MUNsak0waU5qR2Flck9jWmphcTdsbWIvVDQyWUtkdExlMWp4K2k4ajAyeUVD?=
 =?utf-8?B?QkJHUnY5NDVQcnVZVjI5SXJlbUo4UmdZSHJaODhhQmNSTkRieVhteHNBQWpR?=
 =?utf-8?B?YUpTSnhwWXg3cklDdjNCZXRWRXJwTS9VOWEzY0VHL1hxaGRjYjRhSDNFd0FO?=
 =?utf-8?B?Q29KVnJVeVlTRlh1bE9RMTA3NTNhdUxoTVhTNXh2MTlWT1AxVzUyY1p1ZXJh?=
 =?utf-8?B?Q1Vmbi9UNGVYZW16LzVPT0d1anRIYmEybGNXV0FFNHZRV0dUNEN3TXFTdjZC?=
 =?utf-8?B?ekpPcm00bUZtekY0VDJHNk9pTEY2MnNxdVZYYzY1VkZ4QlBMWmJrQVJIczFR?=
 =?utf-8?B?bHVkYVNoclNFM3EraUdDbVhTbERHOUFxS3kyNTZkZjd0VUtZQXNSMGtvQWVj?=
 =?utf-8?B?Vnk4a2pNbWZsRVFsaXJWVGhNak94L0Zjb2ZGYngrbnEvRDVrMjJyM1EzYXhZ?=
 =?utf-8?B?T1ZEVVBBazVjUFVta1pSdHJ3OGVrOGg2WmJ5NHBaYXJBZXlRU0ZhWmdETzds?=
 =?utf-8?B?UGhqV3hGa1hmdnVlMEZZTEZ6VERWTE5MUFpGaW8xWU81L0JBNlU2cnY3R2Zz?=
 =?utf-8?B?Ry9XWmYwR2FXejU3eGZJTnI3RWRZZjEyV1R2WHJEQ3ZQaUJEMEs5RWtoQmM2?=
 =?utf-8?B?MWJNdHQvUndxdm9SelEwcTd6NTZTOVBzYi9hR2VYcXNhbEo2a2NnOGxxMWZu?=
 =?utf-8?B?dTgyTUVsd01MUjBQNWhod0FNNzVRUFNpVzQyTlVIRVJWZVlXYVFsUmRRK0pX?=
 =?utf-8?B?clBVZVVtRFR2UDg2c3E5S0JRUUozaEI0WVJxU01Rd09FcUdPRjR1ZlBTMmti?=
 =?utf-8?B?cWV1eXJ2SUNyeEEyd3hvdlIxa0NaMDdkNmZWKzZkVnlCQm54L0ZnbXNvYmNL?=
 =?utf-8?B?bFNHSkZlSFE2TWF4VkZLOXU4R1RqZDhDeTdZeHFWcVRwcFpSMUp5SDRMa2ox?=
 =?utf-8?B?bTFpS09yZTAzTHllYkYvMlZGQnBtK1MxV2poS1ZmUW9UOXlacXN4bUlnK0tM?=
 =?utf-8?B?TGt6WjBDbUc5SkhyYy9iRVdIdEJrcis3dndUcEVmU2lvS0JVSFBIbEZhNk8x?=
 =?utf-8?B?Z2tDNXRqZ0JaTXQ2dkIrYVpXRUFleHg5U2llQXQzazk5cnZIWG8xeWtPUkJt?=
 =?utf-8?B?YVdSSHNLNG9xcmlvVU45RXM4K2c2UnRiTmxqZjI2a3o4OVVIWGN0MUs3N3JR?=
 =?utf-8?B?OU5GS2lkbHpxa0tmblhZSkhzRXJ1QTJzUm9hL2piT3c3Q05zeDVINU90UGpt?=
 =?utf-8?B?YkE5OGVjTDBTbWtxbW5nb0w0aFQ0T25BZjIwM3lQd2hZTTdLcUZmYXk3Zm5p?=
 =?utf-8?B?UnBXTGJkR25WdGh6R29tQWhrZ1l3azh2S1JzaFB4UmcycXB5OThMN3RJRDFI?=
 =?utf-8?B?SXZkdnFQRHNEa3JEamthNVcwWUh4RXNrNk93MVdPTDJvWkdSSk9ZUngrMGJZ?=
 =?utf-8?Q?RPQ6QGsJznBfXXUyImaH?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk81dE9sU0VoTlhzOVpRVEF5aEFoSGRxS3ROeXhRQjFpTmt6eWo0YVN1MGl4?=
 =?utf-8?B?d09PUkc1ZVVMdmEvNDVRTGx2VVZpSllxeWZVRmt1TzgvaXZ4VjZtSGI0ZVZj?=
 =?utf-8?B?R29OWE13OHJLZCtjNTNoSDJBYjVVbkdZRzlGR0poTFZCdGFlSE1ZT1RhbVpp?=
 =?utf-8?B?SUdtL3Y1TEJ6azhqa1pKNWoyd1cyVVdmNG5Qd1pWRzhNbzBPdVhzWXdoNDJ4?=
 =?utf-8?B?VHRtY0dWN2RXQWR6bVBNY0MzdXdoM0ZQeVRYWFZHOU9CMDAzNWZmeVduS1p4?=
 =?utf-8?B?eWdMSXJNTkZWbE00WktQVHdIbEJKVi9TU1VSZmc3ZDc1c2JOUitQVVNZZXJC?=
 =?utf-8?B?a0RTVC9PRFRjbElsNUVyb05lV21IdXFBVjk5SndSTytFcmMrRGViZXk5MStk?=
 =?utf-8?B?NHZ4bVczZHBtUE1LcmVkenVPTHlEL0V4cjFURXZPbEJlNzhKeW9XYitIV3ph?=
 =?utf-8?B?ZzFpYWF2bUZEYXlJWTNUM2hhZk41Q2ZEMWdmZFVIQmNVNjdERFVCZi8vOXhM?=
 =?utf-8?B?YTRNM28rV0U3bmp6cmV1TDJVQnVCRWduWVdKZEU0YnZoSHhmdDVkQjQzcTN4?=
 =?utf-8?B?RmtKYVZRV0RoMWNhQVMydDZzUDZWZFBYbi9nY2g5T0Vta0NSQjZKa1o5bWxQ?=
 =?utf-8?B?K2V1WTNuVURHaGd6Y2tQWGs2cWMyU3VpZUZBbmhwNjFjZThiUXRSbjhDQk5V?=
 =?utf-8?B?N0ZFUS9pN3UvT0lSaDRVK0JFdkVUbWZFL25YdWc4Z2lBR05laTYwZ3VGc1c2?=
 =?utf-8?B?ZDFwTGN3dDU4VWJBUXNGV1JyYXRMd040M0dBNFdpcVAwam1pUzJpMlpPRlpV?=
 =?utf-8?B?eW1pYi82cm8vOGtqNWQzMnJRRFdBLzdzQ2dwM0ZwMEY0K1loQlZrS2xJVHJG?=
 =?utf-8?B?dlBwbWN2ZUNyTnhTNExPa282OHBla2JDY2hQOVJsRU9mZHJlOWt5djlwOFho?=
 =?utf-8?B?YTg0QTVTaEkzRHdGMmVXM0VIdTIwbVg3TEY0ckVPbmhEREtnUWR0R0ZJVWNI?=
 =?utf-8?B?b2VVZklCcno4WGYydzM0MXR4a09oRWI2Ty85ZUkwaGRRM3FYeEppZlFrUmNL?=
 =?utf-8?B?ckZkTEJvb09Nb3lwdXk4dE1maG5KaTF4TnlVMUl6cW8zUHdwOGRxV20zRjZ5?=
 =?utf-8?B?Y1F1eDBzOFNFR2s1dkcvUEd4TDNCSlNVMXV5NittUGl2ZG1kK2RzakdKNTR1?=
 =?utf-8?B?YkxobDB0aWp2T082VklSWlFOLzFMTFlDbVpxNnQ3Y1FoTGVWSlNFWXh3akdm?=
 =?utf-8?B?d3pXVytIZkpnamI0MWlIaGRXemR3OWhyb2pnWm9TQnZGT0lKWTR1RzRrbU01?=
 =?utf-8?B?ZTJqaXpMWGMwcXJ0RUI0UEg5RFF6anduQW5vK2l3V1A2TFpHbGFqU3NDRG90?=
 =?utf-8?B?cFZCY2paVERzazF6QTJrbjQ0aWpSaUF5UzFkYUFYU3R3Z0ExZktUQ3hCamlB?=
 =?utf-8?B?S2E4WXdjbjVWVGVRby9BamdrZitPTWM5Y0JMRTdMVmt2NGdMVDhjQUJ2NDVh?=
 =?utf-8?B?eGFiN2ZZeUgxMzNIamFWdkVwTU81L3dQVzYwU1RScVVZQ1orMVBYR2RIeE9t?=
 =?utf-8?B?S2RZeWF3c2U4dUxWNkZ6aVRXNFptakp3UE1UTUNnRlliaHNWRHZxS2lWTTM0?=
 =?utf-8?B?S1FVbFlDTlRGTmhxWXZGcnRUVWRiUTBCR0VYRElxYkphZ0RWM0EzSzFXOXY0?=
 =?utf-8?B?aTdyaEt1SEZZQ2hIcHhDQ2Nza2NsR1M4cnVPZ2MzV3FLUXdpa1g5TjJJZ3Y4?=
 =?utf-8?B?L0w2RXZtY2x4aE94VXQvbjVqQlk0bzNHZ21FTlhMeDRycW1JWnpENEFPTFpV?=
 =?utf-8?B?RXkvSFRpa21BQ0R4NFlQRVV5YjdRc0s4WGlmb3g4VWNWMENaeEorcis1YVhk?=
 =?utf-8?B?SXhCZHljWkNxaGhDc3VKZXhyalhzWGhNMnBHZWtPUllGdFE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea24501-1eed-4cca-5fab-08debfa35657
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:02:18.7324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB6917

rvu_mbox_handler_lmtst_tbl_setup() uses req->base_pcifunc as a direct
index into the LMT map table to read another function's LMTLINE
physical base address and copy it into the caller's own LMT map table
entry. The mailbox dispatcher authenticates req->hdr.pcifunc from the
IRQ source, but req->base_pcifunc is a separate payload field and is
not sanitized.

Reject with -EPERM when a VF caller and the base function do not share a
parent PF. PF callers are trusted and may still share LMTLINEs across
PFs.

Fixes: 893ae97214c3 ("octeontx2-af: cn10k: Support configurable LMTST regions")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v2:
- Restrict the check to VF callers only. PF callers are trusted and may
  still share LMTLINEs across PFs.
- Link to v1: https://lore.kernel.org/r/SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index d2163da28d18..33f25e2fc262 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -178,6 +178,14 @@ int rvu_mbox_handler_lmtst_tbl_setup(struct rvu *rvu,
 	 * pcifunc (will be the one who is calling this mailbox).
 	 */
 	if (req->base_pcifunc) {
+		/* A VF is untrusted and must not redirect its LMTLINE to
+		 * another PF's region, so confine VF callers to their own PF.
+		 */
+		if (is_vf(req->hdr.pcifunc) &&
+		    rvu_get_pf(rvu->pdev, req->hdr.pcifunc) !=
+		    rvu_get_pf(rvu->pdev, req->base_pcifunc))
+			return -EPERM;
+
 		/* Calculating the LMT table index equivalent to primary
 		 * pcifunc.
 		 */

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260601-fixes-a06620632bac

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

