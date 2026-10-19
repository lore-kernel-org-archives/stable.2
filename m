Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E63F211A;
	Mon, 19 Oct 2026 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407219; cv=fail; b=V61QAs4/qARvBojOUjlsKUyrC5GZ5Iar9S1VEg72e1j6sJkLakdHrj/if7LBDuJCtHhXV3JHhLJ042OuG7+LPyn6qa23CarZLBiUxJgDyOpYSPaKtaMZ6kjBF1YkCCNy7g4rMQWN7/Jl6EX8+6Z/LllfGuEvqdtcr31i7t2oPYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407219; c=relaxed/simple;
	bh=RHOOQRHLxEZz8uSObzG98RHT7QaC66rorjkzEibxPUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCoS/ROl54c2YF1BtGU36jYoybZjOf0hFKaorkskcxxCCZJyVnjsyP/UNWXmGpKD3vi4z9wAZnAk7PDB8bjOdwzo5jbFDMiHuOJkohwNxQ8VtCI6wyyMYXRPr+GU1KTVhuOCF+KySxQ2vpPQH4EA+1lXmjSt6rGELKxDS8Vot7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=bw+MHmXf; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Pznv2sIl; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="bw+MHmXf";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Pznv2sIl"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Msae534337;
	Mon, 19 Oct 2026 06:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ceHUqyeDSi812ckcxj0BQJZNsAbBx6bCCsoa62Le1eg=; b=bw+MHmX
	fNvdI5hlUrgax/ccN0asu/4RiQDTl3yEKZwkO/2b0Owjax35y0pEH8/87wBesYQo
	o6HEUi6Ljw/w8cCDvc0RwT1G2tk+hsXGO1RihpKlhfNZTLYknOQi1lJTvjMvKfiS
	w5IkjEAJNqhyUrZoi/Wn8YjlDyK4X0iTU8ceD9kSkEB8ueDMT0TlyGaXHp0Vz3Rr
	DfTDkxaupuVxlLEvZw3ojRYJg/5JyXvql7gfRu134Lbsa6tgK6jxg9FwnCay51p5
	avifgpSJooou098eUsiKZYXydMnxOtZRBuq03fmCjCX+hgx1zSFrWp+/EjdgZIQc
	+ISD9wCkKfT48QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ceHUq
	yeDSi812ckcxj0BQJZNsAbBx6bCCsoa62Le1eg=; b=Pznv2sIlFIJUOutPcotfc
	u2g/7VrIJ1FcoA8Ydu+CU4idW5mLAJ0TliOlEWV99bBbLvj3OOvyq5fQmvldBa2o
	z5wayO4YMeTc2CYFie9Dla/j47cTRi/HiPGjEgqKjorU4dXDwh+m10UMZo6Wp0A0
	JawwgU4Rrw6Oq64ygE7oJo1raEo8DlZLJ9jl8a8EQtKdtUP1j1zD89YUTM+1zAqd
	qs3b3cIV1VX6Q/TwH9aOyuRaQCL5KcOVpU6dDZrYGuRth2/pGQklJezAHqB1hVk6
	1ZOwVvZ+ycoSER0LdMx1zsoCNKrTq/4axmnjUfr3IEwgtS4oXqXm7Nkr+3iLQlQO
	Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hcu2f54jb-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 06:53:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdDpdJ+B9JDpMba9FlbA8qthcqkXLDzdqfPXqC5S8I8ZplkpGH9z3JfyytNhZ0iHhO6vjXy87Nj6tdkc2f69j79bOQRMczKY3y/IlgYylnSc4gTb0Qqp3PxDs3m6VuyyQw0vGckZZmTS8KWuhWyaRTFrUGMINTeSEQUxguubWpayQ9n0HOt+JJZJP8lf4Lj5jkQw57UoYeYtepGooXBZC/bIoGuDr33JXRu8jrFyJTlXHjQP08BmRJp9nw1q9aDV+1pClImWTpl43v9B1LQlS5NMTNaXzBaV5V6xwK/aIzv/7B015VWuk2Mjhh5VKVSj6CbZqK1RTMx3QPrR+S3D0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceHUqyeDSi812ckcxj0BQJZNsAbBx6bCCsoa62Le1eg=;
 b=nrxm/TGSQ1HgRENkxNOy6TSrj75GHDJUeWLAzaECzsX8cMxQXOlxjq299VgX+vW8KL2YaKaxqFANWKJuHgOp7zpAm3S5qqmYfsD5RTvS9ZR8WHFZaS3hJKHGqOOJJNCMJmlc5U8UGDqCckzgBULevtA9chiGDTo4QaGY1qzuXmMRMVSwoHRFbw2OFH6eAlV9b9w1h9nuUvv/mrqTTcL51z2msLOjNelUoRXW21JSW0KAyw8uf725MpLjQqNVAFl5Ro1iiJLROH15LGh7gGo3OJSmWO6pJOtdBycJCAdvcC8GAJZHHkwOTc8/SWKfI0bG/XBo8Hc4h5gugviwbhlwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH0PR03MB6194.namprd03.prod.outlook.com (2603:10b6:610:d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:53:27 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Mon, 19 Oct 2026
 10:53:27 +0000
Date: Mon, 19 Oct 2026 11:54:41 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dingisoul <dingiso.kernel@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: gyro: mpu3050: add missing trigger cleanup
 on remove()
Message-ID: <atX1alPtnByIsGFr@nsa>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
 <20261017-mpu3050-fix-v3-2-d6f29f335a2b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261017-mpu3050-fix-v3-2-d6f29f335a2b@gmail.com>
X-ClientProxiedBy: MR1P264CA0163.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH0PR03MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f824d5-caad-47fb-7e66-08df2dcf3472
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 LVoV/TMoxAxB+th5JYarmR9cxmQ+XcQIwihod7vcE13izkgszB+xqGPCoChZoR6X3uaMEvTFTUPSfo1T/70dnjtIRn6GLqkjyyxY4Qkms7bFpK1oFatIGSEXyVkJgOEXoWgROudHq/BUigvHXjY5xA6zyenQVZz5Q4x88bcDryWsOQZspWj4RDJggM4wguahxr1Dg3fXAdC4YF59PnwDtzjWeCNsauSbHpxNGYIaN4bdxWJJoIjKjqwD9IE/wEmyGF+hwewxTRVtcQ8A/YLvUcy/6too/K+NkhGbfw7LSYu8cx4xPdSfyMLGuQYr4ZELJWEMW6ofkS2OXjpmoqpSyZWLpzncMA7WXTHsH9yPrj+Go79JYJYFL0k8wE8WPWP3V31xsRdwlsSagZFBD6zvGCiBoTwMgEsNUk5MhQop4bpI4z7KIjeEwNNBa6Sz16Csb8lfKOSbNwpMBOT1BRAkzIRiWb1pJZn8ouWg9oIOhaAXFkt0TkOsDZlIuvt7OTAUn6JAYNYqrnhEtWZmied9KK8E6lEibR/iDJAjD01LMEKSOIzUdMiBx4mlK7x0EN65MV+Tudf0Sqq9+tAKnRZkvA9RJRmU6pj3k4lsBE7srbiXChP6AVDaC1woeUPF2PQZ
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aG0rekNhUVUxQmFsUThlOHdLN2FsYlkwTnZhY01tZnZTRnlvaXZSVWNCL21p?=
 =?utf-8?B?TGNVTnBLaVhrZFhuUWYvSjFtVGRZUDNiSzNlRUc4dkNadndwV1R0bFRGUDhp?=
 =?utf-8?B?Y3oxZVgyaUE2NElZUS9FSFpQVjJ5MVBwTFdocURLTTVQTWZjalhURXNyU0dU?=
 =?utf-8?B?WHVsSEdxMk9kV2UvbmRCZTdYRnhpQ0U2dHBQYVpGVG54THNLSGNwOXhYSnhi?=
 =?utf-8?B?Q2FmRmFqM3YrQmlaNjhFVExpUi8vZXFhUEpCcnhmUnlibVNDQzJGK3pRUGtE?=
 =?utf-8?B?aG5ITzBUZzJ4T1NlYWlCWEEvYkRpZkJRN1dGdHg5bjJxckNmVEsxSk5DQnZN?=
 =?utf-8?B?aW82eHRUMENKUFEwOU5jak5KRW1IMkhxZFJIKzBiVENXM1I5SDU2V0diajhZ?=
 =?utf-8?B?R0NxcXcxSnRYV0hrMk9CY2VlTEprRi9Xclk3Z1JPcU5tendYbGJEQTFFeVN1?=
 =?utf-8?B?TXRXUlVQYnZpc1BJdFVTU2p6S2IzY0IxM1BGK1k0VmdPeExDYkN2WlYyT1pD?=
 =?utf-8?B?d1BEbmRIc3hFS2tSQ2w0TXZzQ0FuaSs0Vkl3UytMQSt2UjVrOUh3K0ZsOFFH?=
 =?utf-8?B?TE4rYmZqeUEySlhBTm1uRzVadUJScHF2QTRXZ3BMSHNZdFo3RS9pWkNHOURr?=
 =?utf-8?B?em5iTU51ellCZ1BTMUZlczBaNGlQNzR3NU5kSVJWTkpXQ3Vtang1OGN4VmVF?=
 =?utf-8?B?ZVZYRGRDaTZyaitDN1AwaGJUMSt6S09NcFAralZvTHF1djNNUXVaazRQZi9a?=
 =?utf-8?B?cCtEamJhRHVENTRWb2pHOHRES0pLVnlNUlB4UVFIU05EZE5mc3ZVakJocXB5?=
 =?utf-8?B?NFJiRk9zeHgzQ204b2RkSGF4RGl3SFZ2b2pmcHdrZE5tai9pbkRrd2JVK0x0?=
 =?utf-8?B?Rm8wTm92VkNVUjY3clRxc1h1SWMxeEVkVGVGRWJ0VisyTDNKbGhBaTltaXhN?=
 =?utf-8?B?UTFqWUE2bDJvam5oaERLbXk3QkZ5N3M1NDY3blBBT2t0OVEyYVRzcU1Hd0Jh?=
 =?utf-8?B?S0xobmdtRW85RzFWazJuUkFhWVkwb2pIYklQc0xiRzdqNWErYnJ3aThYRGNW?=
 =?utf-8?B?am55Q21OZWlMTHRDM2c3Z3NjZzJsek83WGNsSUtUZG9XQlNCZDZMOHBwVFV1?=
 =?utf-8?B?TkVnODgrQW8xTmo1S3FIYzVncklYMkg4SC9rUmxubndxN01QUE1IOFFpcWNo?=
 =?utf-8?B?cG54ZGFnWFh1ZjV4WDNNRDJINE0zK2Mxa3JWeWJKdlRJVEdrZktFenAzNjBr?=
 =?utf-8?B?eUNLalZDbWxzUERGRTVOMnhFS1lpM0dZdWVzRDN0eHBIaTRMdVVqWXZjeVNy?=
 =?utf-8?B?ZEdLaDl1Vmd3d0lPaWVPZ0NXLzRJcDU2OXFjLzFsZm5VQ3RiWTM4YWpOUlpU?=
 =?utf-8?B?K0djTkhSYXZDQzZYM2U3dW92Rmd3V1ZPNDdha0N3OXRQc0Q1RW1Sakk4MU9a?=
 =?utf-8?B?UHArWlAvS2F4OEJYNUZwSktSTWZqeW9MNU5vNWdnRjkyTVhKL2VLaVNWTXZT?=
 =?utf-8?B?elE0ckhKc3k0UmREaXY0b1JPTXNIRnpML1p3cFUxcjR0WTR5WEw5dkNwQjA5?=
 =?utf-8?B?c1dNY3FIdVU2SlVNTk5LTnd5VmxDaGNicmFUZEZJQmhJZjFNTDU5ZWd0VFh3?=
 =?utf-8?B?VlBjQ1UyUjZQdEJ1aUlBbjBaNi9iT1pHanlIa2VndWducVhDbU94d0lSR1o4?=
 =?utf-8?B?S2xuUDVCQlU3OEo3WlJxOHBlcm41Y29OVFA4VWNsVFZnYXowUVZKZHV6RHNt?=
 =?utf-8?B?R1lyeEovdEptUWN6TVh0ZTVmU3dsMkl1QUQrcmpPMWdDNjdLTlZpbFI1bk41?=
 =?utf-8?B?YXFEdWV1QktWYTl3d2dHRSsyMnVvM2c0dlIwaDhKTHQ2bmlFV0E3eW94YVNK?=
 =?utf-8?B?VGU2OHZZUUo2bVhETVIycW1sMHBOdDRkamZodnBJRGs1bGc3TTlhUVpiRm1h?=
 =?utf-8?B?M3RsZlpiZ242QmFZNnFUNndsZjc0UmtCdFdFNEFiUmNwRU1qbDhGL3ZrUnpV?=
 =?utf-8?B?QU5xcEdKb04vTmp0bTFLZk1sQUYwOU5TRE90NFBJay9pVGltU0M1S1JsQXl6?=
 =?utf-8?B?MmVIVk5BTTVxL2ZYeWRSSjduSHRTV0VzcTNVMFZJbWF3blJCZThGbmVVMnd0?=
 =?utf-8?B?ZEFXZkFjamtxV3VjRkxMcDVjb3l3SCtISmNGbFVDUWxrZ0F6bUoya2NyWFBz?=
 =?utf-8?B?MjFKRllHZmd5N0w3SXFFb2RzMkxKR0RBQ0NYMkhFZFRobmNlWmwwMlFwSjQ0?=
 =?utf-8?B?RDJVK3dTMkZyRU9tcnYwRlpxcmpjSWhsbnkralFqY3hUbUVnZE9UTGFwbG5o?=
 =?utf-8?B?cERKWjYxa0Z5TkM5b1d3cHRXak5tUGN2bzkvRjUvRUUrRjNSSFpWdz09?=
X-Exchange-RoutingPolicyChecked:
	sV0COGUZq9zBK3bBWTquqxEewOMaeNgY2hQHvp67gGJbtkmh3BVnVxwuJfUPAVRfpMFdvcj9TxBR+huIUfLAZNti9CQqwnn4eCVM6bxmIaOBMTQ3lFIdqQQs05rPX3OVWF+q5EM6dqOUlMAR6/8yZZEvLDbtadoDln3KifMIFxHthgxJMJyK3B++fHgYpCw2K9QknUps8to7iNPQ9RnJ2ek1i+/kia4kl9u3sAZMtwUiEx8wG3NDPckv40xufKJbEXRQ+YpOoZFuLv7cLnzlO6LWk71oqwcxKnyHAfkmBu44AtxT6rMQ2wvASpC+U2CDRMWF1uZKH9sP9A5H1hsrsA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f824d5-caad-47fb-7e66-08df2dcf3472
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:53:27.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfUv3FPucn6EUfnhEWJwv3MggE+trNP9WrC82HfHYEgmUFJaLWLgXlquGLPAAKOQvcA0HCnPyjZP428EoP/4dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6194
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX04PDFeIDjTjY
 IifTy0rTHia6rdg67Nu+3sIaciuLKg82bjGnWP2s06sU3OB2thS9ZoNV7ESQuaZvbtRd8Y4nZKC
 gAafi59vAFA02XAbnEO9Gc7pI2V483lvkBZT9+VqQ8hUq8f8QVcO3s/tIbi70eaAWZLG+gLUO/v
 H13ACTGKVbSejPQXOV/3YgTVRUTRYby2VjE2ipEAD2GDgqIR8Tl4SC3o+BBukRd5QYOEltAzDye
 r29aHhyBVpe5zn0pEdWFKPuFlbgKG/vS5XiUR2+W5VXkkYJrUg9ulydr4QMzC3+UTMj8zLdAa15
 7CQdCNgNcCO5KPy8oX/t1xX9K68qjDMRUSrl8vC9TmHwbjboAcTt9IHIwU+soch7i5uGq/XiwIY
 H/ILFLLIuMqGPDXWuhFQwM87It3FDRqb57ehfFRP4DdFIneMjwCLeU+Cohx+63c98sIIFEkYuOM
 2rmkFnqG6+PgxpoRt2Q==
X-Proofpoint-ORIG-GUID: M6CXxOgsrgvKje8cpY-AKLtrdCLkaOPb
X-Authority-Analysis: v=2.4 cv=N+68hG9B c=1 sm=1 tr=0 ts=6ad5f6aa cx=c_pps
 a=t5Pm7pJ6jXSUtateXttj1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=qtq1Sy4DNLU9JFyDYUYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: M6CXxOgsrgvKje8cpY-AKLtrdCLkaOPb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX4WtNly9ulzQa
 U9pRsnf+u+DGZLiU1aYp3s6c8YZq1F8OQIfwvt2dWKh6hWnslGPXGUY6uYa8aD9Gb45tWn1+gdI
 Kyce4Wc4quedHj+Gyo/dKdX87i96P+3n2fYNv8Y4o9ST1L9GBEKt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190043

On Sat, Oct 17, 2026 at 07:19:21AM +0200, Joshua Crofts wrote:
> The mpu3050_trigger_probe() registers a trigger but
> mpu3050_common_remove() and error paths in mpu3050_common_probe() forget
> to clean it up, causing a use-after-free bug.
> 
> Add the missing calls to the iio_trigger_unregister() function.
> 
> Reported-by: Dingisoul <dingiso.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.kernel@gmail.com/
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/gyro/mpu3050-core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 879caf3b729c..9e747836df3e 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1262,7 +1262,9 @@ int mpu3050_common_probe(struct device *dev,
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> -	if (irq)
> +	if (mpu3050->trig)
> +		iio_trigger_unregister(mpu3050->trig);

Yeah, I think sashiko is right... I think we can just reuse the if
(mpu3050->irq) condition for unregistering  but then this patch depends
on the previous one. And such dependencies can be set for stable so
don't think it's an issue.

I already pointed it out and Jonathan seems to have said the same. If
you do have the time, converting the whole thing to devm would be nice 
- could be patch 3 :)

- Nuno Sá

> +	if (mpu3050->irq)
>  		free_irq(mpu3050->irq, mpu3050->trig);
>  err_cleanup_buffer:
>  	iio_triggered_buffer_cleanup(indio_dev);
> @@ -1281,6 +1283,8 @@ void mpu3050_common_remove(struct device *dev)
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> +	if (mpu3050->trig)
> +		iio_trigger_unregister(mpu3050->trig);
>  	if (mpu3050->irq)
>  		free_irq(mpu3050->irq, mpu3050->trig);
>  	iio_triggered_buffer_cleanup(indio_dev);
> 
> -- 
> 2.56.0
> 
