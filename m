Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793620849;
	b=uraYzGVdAVevIJxPJzog2yvIpwwBf+E6yH0uBVXCQDfFqnJ34QIGU55G1L4y3Y4eXlOe
	 oF62dXr2zOK7Y4GhOHQyST3juuKHApJsJZck0CvF/x24lx/GKgCCdJOGwnKim/MZDiQci
	 VLsf5YYD2PYwCtTxppWMJ2j0rus4gN7CK4XFSW+Hn7H68OQkA3JwVA1aAK20hH4fEM9Se
	 d5VvdgkitChBFZyHMCcSlweoKG+3Ob1h1ZQIJdo6ghXNbAPDz83ULQidEWjuLyMP/x3cg
	 uvhj/+WEKaPb7jGFIMB8zRGMxWRpE/xDDAkL6olHY8lASQw8q+XS+fGyw3Zlt5YAUXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620849;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=bYM9iBrCuoK0F273ztbGdxvvVjVExdgRDtkGTe2q9cg=;
	b=ot/V2uiHdD3eGm8zNIe7HrdzTD6bSRjB/ebdlR5Cl/PsdEMFwbXVYtbhEEi6jdCJz23c
	 ofh9PYhlJp2YRyqXLEzrnLWxvM2xbOOXfeKZ+h28Xd1ChJP2piHmprz0Vn47DPwPz3Vzp
	 6Oz1gmFDYVCMMg40rhMi6bOSvWOan3Ka1vlfqUFVO23jwNQUDI3KXpg9hjhKs/2qoKzO9
	 2B5HsOvVdTk4+5fRqNf1mdh3H75dtA/JeUdq9xh4tSdOQmI6SOSVLnXJbooY90cyql89b
	 fMqy5iH412vQ7/LkPR3naZnSvmiAFPBhTP7bN7lbeFP2/PKFIxDT6vUXMwGTmhFIi3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=OD20wIvt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.3
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C93606A326;
	Mon,  2 Nov 2026 12:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C93606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=OD20wIvt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjaH11Hv3ILa4OyHw8iQt1AQdkGmcwEIbLbYNBe4jL7FuQVdktQSnMHDaaMiNwu509hpdUk2m60pbruWI2Q2w25TArLHupftHfdlqIUV5ppi+AcdITS8Zm2d0PKU5Vuatcxlx2X5NB/XtzPhMlIaDmb1cFa/2u7KWQ5Pzayb9Ct1YHPBbvGeynfND7RwyGlmVi/kPHl/yd+x8tGYCGSl9VUJO+EQGorlKbybdI25VWw0Ev5zwia0Off8mRPZRY9nPP2E6MMiNRmRjy13QgTS8UebFEklHXNK7jBGMXMhyTkAQVoFZh/Icx68oEcx7iLeg7OGHdjfLbMcIvfDklYCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYM9iBrCuoK0F273ztbGdxvvVjVExdgRDtkGTe2q9cg=;
 b=LkHw0CPaDvNvgXXk9W3w90Rtu7/lRzMXYA1tQ3l00Hqa+go9e7sG/MfKd/QK0JMz9K+4Sk8QJ7aO5s+rsBPbGo/r2CzXFZpzhfNjNF++FB92ipNBqqVr07UbF/tGkAh4GIZRAXBFW67xdX2kp0FGOJNKGoKO0YYOqigr+COFaoSRScGJUqycAoplZyOf3aXGN9VXHlwbsG2N+6YPAhIj510Z49bbaJYcz2WiwRDxdhDe5ThZU8Wh+HUuq0QZxnRsMLXLCQc9rb34jIFu+0TPY1jMojxIZTnwAUFZX9IxDZaPNs+RKNS+5YRMXv3Qk2v4yOokCCXYZW6Q9/+r5GhdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYM9iBrCuoK0F273ztbGdxvvVjVExdgRDtkGTe2q9cg=;
 b=OD20wIvtxcEsohxMhWl7wjTc13GAqQqqsCNask4KY3vd3w1y0uTiF6PuwNI4N8ID+i42KgtpSzbqFfDVtbAhtLAN2IU2YEMrh3UBiZW6LaiPBgvYVsbqnVDoJthZzn3IRP4/9eJMWXMJ4iAfzmA4hdrOOXID+eoySH8N3Bo6jpIORki4LsZgjzxVEZeFHgIn2rNs2YE2Y7FuZYorPcbpiiIuinlgJGxYq3xo5E4C1VfRDxg2FlHW/ZxWXZZQfkvgcUMfhdOHbOD/oTrwdKnv8ciL+OYAv5QUqprVXnb6UEpDSyg7Vpzl5/mkC+dR0lBwkX4BgA4+NOGB5mHQ74lhKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from FRWP189MB3398.EURP189.PROD.OUTLOOK.COM (2603:10a6:d10:1a3::22)
 by DU4P189MB3469.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:00:42 +0000
Received: from FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 ([fe80::4658:dbd6:d572:896a]) by FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 ([fe80::4658:dbd6:d572:896a%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:00:42 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
Date: Mon, 02 Nov 2026 12:59:51 +0100
Subject: [PATCH 1/3] wifi: ath11k: don't free HAL SRNG memory when crash
 recovery fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-ath11k-oom-v1-1-f3c391bd63f3@est.tech>
References: <20261102-ath11k-oom-v1-0-f3c391bd63f3@est.tech>
In-Reply-To: <20261102-ath11k-oom-v1-0-f3c391bd63f3@est.tech>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, 
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
 Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>, 
 Shashidhar Lakkavalli <slakkavalli@datto.com>, 
 Kalle Valo <kvalo@kernel.org>
Cc: Jeroen Trappers <jeroen.trappers@gmail.com>, 
 mike Seo <mikeseohyungjin@gmail.com>, 1152007@bugs.debian.org, 
 stable@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Sathishkumar Muruganandam <quic_murugana@quicinc.com>, 
 John Crispin <john@phrozen.org>, 
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>, 
 Sriram R <sriram.ramachandran@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Yunseong Kim <yunseong.kim@est.tech>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793620836; l=3699;
 i=yunseong.kim@est.tech; s=20260824; h=from:subject:message-id;
 bh=t8X5/dOxyhEvbjqTrZuLIckhN3dU6vmLQM8HWna6Lr4=;
 b=dtrKzhkOh0lhB0eBAn6M3MpwaSI+RcnAnN+do4zAD6I04TgXq8EuiIPlszpGFMpCIxppS801S
 0WZ7NdtS/kHDyeavBImptvND/JJJHIrMOMAAEH0YFuIgLOl43GVSUht
X-Developer-Key: i=yunseong.kim@est.tech; a=ed25519;
 pk=nfdmjNawkxBHo9UNdzLNBEht8sYmXp0MYUsa/hwC7vw=
X-ClientProxiedBy: LO4P123CA0295.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::12) To FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:d10:1a3::22)
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
X-MS-TrafficTypeDiagnostic: FRWP189MB3398:EE_|DU4P189MB3469:EE_
X-MS-Office365-Filtering-Correlation-Id: f555e1d2-85f1-4107-c9ca-08df38d8eb8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|261021135927099003|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gC2lnV9OdpUNtwWPBLw+M8kCRzUJLSsRFRnBZA9Y1VXr175jQ9hZvZ+vVCPb271q0peIEtz+GGajajcZ5ByhcyXSNiGml03pYpw/lc5SW3FMirwy7ljqQTl+G7q8b8BUBbw28b0xGpyrPnT93AlljoC624F/Fv7j5Dt4zJqc9i30T3OlNvjyQDiXZBmsB/12EOmL0OOs1NxJPKvtweNCRGPrHMr4KtVVN81MLbh4tuu+MDbH3anSS6xf6QbVtSWyVzHgTjeHkODBzZ67jHwSsitLyc30+LexyLkNHhLJQAEAupa6zOkhVjRq2cpIWJPF1L2y6qN1qDi87ZvYcOcHhc0COaGHu6qu4AfECCDv9ZhcsPAcLyko4Fg16C+wZtNWVkIv3VHclwCfdCUdv/9YUg3fMndkKdfdGbwyVjTLNk0BEUegqXAPR71oUYp4w1yisLudIFMvQZvIlRjv8uMI75flbSgbG0FZFb3/87P9m83UywA2BLwkp16hDN6I9hVUdnNA8rJPUBdL8Ck9996HL00uV3YQvwXIlpoX155VsZ2kEkvw2+SdK62J0Nm7hLXlEjYe49u+Ve4grcygpb6Y+tNCkJj4ZcCw5SXXbV5q+o4Kjiz/FftKs5XR34qTYSzk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP189MB3398.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(261021135927099003)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0o0aWxFQ1hHTGVsaFNMZG01Uk5MOEVJMDJkUWo5NENxRGN4UnhTcWVHWjFm?=
 =?utf-8?B?T21zWnNha3F0aWVyNTdCQWRORC9FcVFrTXNMS1FHNzV2K2lTSXg2R1RlM3Mr?=
 =?utf-8?B?UWN5TklHeTNjV0NJQ256UCs3dDNlSjBOWTM1NHAvc1I5VXg1aXZKR0dwdkM3?=
 =?utf-8?B?T0FXbjF6SUtTTGFtU05TWEVUYXhhTSthaTkvTHR3SkZWdkNWajFkNi8wSHd1?=
 =?utf-8?B?SzlPNnNLbjM2TzJ3eUlNdU81aHZhUHgxaUpQRjd5NWFBOEMzeStjTTF0TFY1?=
 =?utf-8?B?blNNN3I5OGdQVzRHaEEzTHBLdE5CcXZ2M1BUcVFrWGd5V1VlbEd5eEpiZzFi?=
 =?utf-8?B?dFc0VHpHSS9VTXNheE5jbnZwWHJ6WU9nalFjbGx6OUdiOGRPNU9QaUF4ZGdv?=
 =?utf-8?B?ZnRXOE9ZU0dvRG42cUJzZEpVN3luUHp6ZmY0bWNyTWFab0cxOVFEaVFnSVMw?=
 =?utf-8?B?THhmbTNKTzBIL1pMem4vYUJnZzY4bnRZWGFhcWpTN04wM1NRSnJsS0dFWTBC?=
 =?utf-8?B?VlJLcXlvSzh4cFJ2aWhkd3RwQzFNWm9JNVEyM1J5QXJSYUZ0WWVFMkRsV1pY?=
 =?utf-8?B?cWlvbWdBemRwTk9jL3JCUkR6cWJCYUNMbVFpNncrRlBFbStEd29iS0tsU1g2?=
 =?utf-8?B?N2xFOGhHSlJaS1ppa3RITmhMTzN5QjhrMFBJVXk3ZmxmTklJdXdrUFkzbDVS?=
 =?utf-8?B?Sm04TWJOZXN6SllFd2xrMEN5WnhGYnh5SC9CRjlib0Y4U09kYW5FczkxczRn?=
 =?utf-8?B?S2JyTStacC9rbEZUaFB5MXZYaVBTclJoMUQ1YUF4UkNtTjJVQ0VzQjAvMjhW?=
 =?utf-8?B?dEs0eWZVcHRBSmxyeDVHQ0VyaGphY052SFdlZllVRWZ4WmorRmhneGZ5SFFN?=
 =?utf-8?B?VmpmaUFyeHZZZlpHdU5LZFM4ZUxHalpvM0c3bVg3UkhvTGp0cVp4OGFOT3pn?=
 =?utf-8?B?TjZqMkFUd1BWbVI5VW1BTXgzUFEyNVdtTEdXM3UyNWI5ZE8zMTY4Um15Qnk4?=
 =?utf-8?B?YnJ6S3hnbGtSbHhnNnZYcUU3OEc2b3ZzYXpyK1Q0WHFwT2pVMjZwNGZQOUE1?=
 =?utf-8?B?ank4cHJiYjlpQXpsRkt6VzExVTJ3Y1U2Y1ArcllwdnpwSkpQZ2JzS2lCNVYy?=
 =?utf-8?B?MjhsT2wzeUh6a3ZmRGVxZEV4UjVDZzhaSkRtc0JDV2pYcEtsSnRhUEQ0S3I2?=
 =?utf-8?B?TzROQmRwVXNDOURRb0t1K2JBeDB6YmJGck0rRWdPblkrZXI4aS9HN3JlZ0J3?=
 =?utf-8?B?b0dXVTF2TVNObXZhUTNTcFYyMVFUSG9PTk5xODd3aVhqTUo2Q092ell3V21q?=
 =?utf-8?B?VmFXZ2ljelcxMm5kOXpDemdEZkxjaUJhUjU4VzlRRlVrRjRtcGYyY0ZIckhJ?=
 =?utf-8?B?aE5JUHhiZEh5UU96NllHbjhJdGRMOVNYNy95Y0RXeDh3YllDa3BRa0NMVzNE?=
 =?utf-8?B?RzQ2OUUvOFJ6MS9lTTRpQlVHWnhDY2ZWZjUxckc1cmYvTk5QQk9VTldpNExa?=
 =?utf-8?B?MG9FbjFNdnY0Mzc2K0lLdE5VbnZ0N1dXNDFmSXNIek51UVdVNWgrSkVMV1lI?=
 =?utf-8?B?blNSN05qOGZxRGVpdnJYVHJpQnBrTDVlRlhKZ2paRU1hU25PQ1pkSEpWditT?=
 =?utf-8?B?azVKL05pRWZVdGF2T0cwNlMzRWw0Y2RQdzRGNTVzam9tY3o2bkhRbGVtRFpW?=
 =?utf-8?B?d1l5blF0bTVObmJxdFZMYVRoRnpZdXhwMWJsMVNzTFhEZ09HVCt0a0tWVkhm?=
 =?utf-8?B?YkFBcWxEZlhmL2FxYnZQcTRIaFJIb2J6bjdyWjZaNndmM1VzNlpZQndpdmxy?=
 =?utf-8?B?a3I0TUZsUlFiYVF3KzJ2OWNIdE5ZZkpkcXYvcHpyRGpJT08xc1JsR0FoTzJV?=
 =?utf-8?B?NitxRHVzbG1pM3VtbmdxN2psaVVrUmxLcVRyd0lBYTBHd3VnZUJEKzltYmdN?=
 =?utf-8?B?MUg4KzlIbWRlNVJYZG5uczVmbG13NUJ1ZWN4T2p5cmMwMHNoYkltaURoYmdD?=
 =?utf-8?B?aWhRd0lNN2JwTVFISHM3c2ZEQkgzZHFBMk5xcVdTTWo5cWJVb3JxNWdXUmlm?=
 =?utf-8?B?LzEyek80WmdkNk4rWFE1T3pCWFRydGhFRkxJak9wMTUvbnE5UjRwNGo0Tm14?=
 =?utf-8?B?TUxaYjdlcE1lNFNDNno0S2tDb0JUdnFuUEsxMEVVTHBJZnBSODZqRmtheFpY?=
 =?utf-8?B?MTlqTVN2YUVBN3BUTHpqaWtiSVE2bUt6RGw3ZVkyVk5vWkY5WGs1SHFESlJZ?=
 =?utf-8?B?SXcvODBtMlNrS2Nob1hOenZiTWgwa3ZiYytHMmZISnB1UkFaNno0SkZpbjhO?=
 =?utf-8?B?Rk1YWDNsaEE2MndIM1VUcmcyR0VhVzdOZmdaOTFWL3dXYTZxcHk3QT09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: f555e1d2-85f1-4107-c9ca-08df38d8eb8e
X-MS-Exchange-CrossTenant-AuthSource: FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:00:42.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMSnk10K8QzbobwZQ5zNsneTK6fjxxVmfSi8ESGQQmestkKewimfZ4KxOnFm+yDaZLEbjizMGyzG5NPVH1T2UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB3469

During system suspend/resume (such as s2idle), the device can go through
the crash recovery path (ath11k_core_restart() ->
ath11k_core_reconfigure_on_crash()). In this path, ath11k_dp_alloc()
requests a 1 MiB order-8 allocation for tx_status. Because the PM core
restricts allocations to GFP_NOIO during suspend/resume (via
pm_restrict_gfp_mask()), direct reclaim cannot perform I/O and direct
memory compaction is disabled. If memory is fragmented, reclaim fails to
form an order-8 contiguous block, and the 1 MiB allocation fails with
-ENOMEM.

When firmware crash recovery fails due to this allocation failure (or any
other failure during ath11k_core_qmi_firmware_ready()),
ath11k_core_reconfigure_on_crash() takes the error exit path and calls
ath11k_hal_srng_deinit().

This is fatal for two reasons:
1. HAL SRNG memory is allocated at driver probe and freed at driver
   remove. Freeing it during crash recovery leaves CE and DP rings
   (which were already set up again, e.g. by ath11k_ce_init_pipes())
   with dangling pointers into unmapped DMA coherent memory (hal->rdp).
2. ATH11K_FLAG_CRASH_FLUSH was cleared before the reconfiguration
   attempt and was not set again on failure. Consequently, when the PM
   framework subsequently resumes subordinate devices (e.g. wiphy via
   wiphy_resume() -> drv_start() -> ath11k_mac_op_start()),
   ath11k_ce_send() does not bail out. It attempts to access the CE3
   source ring and calls ath11k_hal_srng_access_begin(), which dereferences
   srng->u.src_ring.tp_addr (pointing to the freed rdp buffer). Under an
   IOMMU this triggers an unhandled page fault in interrupt context,
   panicking the kernel.

Fix this by preserving the HAL SRNG memory across failed crash recovery
and setting ATH11K_FLAG_CRASH_FLUSH so that all subsequent CE, WMI, and
DP send operations immediately bail out with -ESHUTDOWN.

Reported-by: Jeroen Trappers <jeroen.trappers@gmail.com>
Closes: https://bugs.debian.org/1152007
Fixes: 32be3ca4cf78 ("wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again")
Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: Jeroen Trappers <jeroen.trappers@gmail.com>
Cc: 1152007@bugs.debian.org
Cc: stable@vger.kernel.org
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
 drivers/net/wireless/ath/ath11k/core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 766ae27306f43..b859b26f31114 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2349,16 +2349,24 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	ret = ath11k_core_qmi_firmware_ready(ab);
-	if (ret)
-		goto err_hal_srng_deinit;
+	if (ret) {
+		/* The firmware has been stopped and the data path is gone,
+		 * but mac80211 may still call into the driver (e.g. drv_start
+		 * from the wiphy resume). Treat the device as crashed so that
+		 * WMI, CE and DP TX bail out until a later recovery succeeds.
+		 *
+		 * Do not free the HAL SRNG memory here: it is allocated at
+		 * probe and freed at remove, and rings that were already set
+		 * up again (e.g. by ath11k_ce_init_pipes()) still point into
+		 * it.
+		 */
+		set_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
+		return ret;
+	}
 
 	clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
 
 	return 0;
-
-err_hal_srng_deinit:
-	ath11k_hal_srng_deinit(ab);
-	return ret;
 }
 
 void ath11k_core_halt(struct ath11k *ar)

-- 
2.47.3

