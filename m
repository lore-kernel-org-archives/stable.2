Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013086.outbound.protection.outlook.com [52.103.35.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC64CC271;
	Tue, 15 Sep 2026 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498478; cv=fail; b=FKay94vYfLrbxcWXfAos2rVChcd4+XkKyr22KqeOvovJPhWVkqSSTYVnNayTXP/lfI3+aSip3hxqGLRG7kuFV7I8vWaY2uQzGFNJyxcq6+fW9pRJZCPOWI0SBWr5NNOiO9uc8LLdhtGp+szEjo4zcDQXcCOvFR+jbD4j8eCcvNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498478; c=relaxed/simple;
	bh=3g/GJzvqKUMk9j4vL1puMBP0KjCRaSIj4HV3Gr7jTWI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tw6FA7tDpAG5tXmWHty+D+DhlxwtwNliIX38yH9UUvuJbfukBGoS5uRV1Ls5XcdsZGPfsS4dYSvf9KRItIDOEESpLfabcOB3XgOlhIRQcXIwjnT5Ti1HWHAcPgUb/zLUC+gNAIUU+WwmCCgYcUmc8Ln0yByHnJR3ttRIF0tw7sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=EwpvNRui; arc=fail smtp.client-ip=52.103.35.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="EwpvNRui"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyA3EjIoI2or4G/lOheTLgmB2dr/COJAewC/EYfFL+1Fdld4r7JIFzYnq+HNBjKoJ1lZ/Zuum1+sfw9QAMWAGhO47N10LZX+wQQrw0CNYDF8YPSX/PrsSg89JFOEWI8Y4RVHNO0nSIXUSesCvUXuZckfy8MfhIVbb0/SDQfHVSqiNC1sgZuh/iOLx68KIadx9X7Ewts7quEnsigsJOSDZdUVPKFYS/IBeDAoO7/gwBte0cI9addQ/e7GKbB9RNi9riCzvhcR7fLXizYzxhF3Gbcsy1HitdUlzgxSx0o4R6zat37+y5ysC1EIhqV8MfIxjxkjB0HFi59JanIK8JChFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IozRiobq81BxsL5XdhKZrOBqQX4kW8gz8BLCjX3oiwo=;
 b=kNXyA/TNhNuzG8j2eNAgAs5k0bLQUx3OKt78vOwjSuXekywbbG+e5iRd7tv9RVVxaBeVyRyofyKh/k052C9qYFnb8rT6pBUZ/B1LwITr8zjBddLqKlFX72hukACivNS6gCxtaPM1Wkf440w3GOgzsAvclKy+vIM3wMXwf+VEwWqN6lRtF6BPDRVGLp86RsWzfEFH/95JW4oM3/kdijLQ46XyNYLGmODAR+zXctwMFVYkRxC5D0iC5qPYi0axEhUnMLiIQ/Slr85GImf7Hkp6OEBch1aynpnPB84uPDADJOtwLYZmFoK/a3+qPnbYyVBPkqfBrG1JK+qlxZIIkKIAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IozRiobq81BxsL5XdhKZrOBqQX4kW8gz8BLCjX3oiwo=;
 b=EwpvNRuikkMhsWaMC9H5sDIz5g4Ln1CPdz4GupKmdZ/+sgM/H3ajUhsAXHSTwatfC4V0DyCwXMrxRRc77RY5hNtXSgFEtIIztfq+cwzZ+siUJZ1FDQwV1qGdoYpv+2LTDw6/QCS7SWyQ1/0hDmSxFtwTj6862MQNsbeRq1PfbKSCst++fY+1oDBud00oJPG0T8Dwm2XIM/HoNCfKJoMbQycYxA0fwrinQ8wYYzYlhGMPFWDmqHoBQ7T7UtEgjOJ15RMPvqIHc/0fZCgXFjMY0bnVc4pr6o8Yf/xMiEzPiDdRFSRusErFD7WdcWVRmXg7LNn7ip1H4rKcDuthUwYYAw==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GV1P251MB0954.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 18:54:32 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 18:54:32 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()
Date: Tue, 15 Sep 2026 19:54:27 +0100
Message-ID:
 <AS8P251MB0001789BBF04B72745C7D96BC8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0316.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::20) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260915185428.11326-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GV1P251MB0954:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca78685-6175-4bc2-de2e-08df135ac74e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|6090799003|25031999004|5072599009|19110799012|4140399003|12121999013|8060799015|24021099003|23021999003|41001999006|15080799012|55001999006|5062599005|37011999003|51005399006|4302099013|440099028|3412199025|26104999009|1602099012|40105399003|2607281247196008|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWFabDRTL2VTdU93M00xdlp6U1Yvb3VmTlZDZllzalQzMEswdTJMQXY4N2x3?=
 =?utf-8?B?a2wwcy84WHJTbGVoUyt0eGR0cjFJWFcyaU85QWNXak1KYS96OG1YMlpHcVNs?=
 =?utf-8?B?ankyZ2lGMm1tM1VSNTFGVDdhWlVQeUp3Q1pPY3A4NHVBUUE0RFBTbkd5ems0?=
 =?utf-8?B?QTl3MDFBbjl1T3YvUkoyRmpLbkQ3THVUMlFKZTdNMGpxR1pNN0JrUnZOdWhQ?=
 =?utf-8?B?YmoxRW9SeDF3bFBDL3NtT2tmc0dYSmNZQlFVMW1UZjYvMkNBOW52RDRHdHkx?=
 =?utf-8?B?SWl3T2NlM2tKdCs4S0FpNzRGdWR1Rm1UQm10RDdwKzZIU2FVcGRHSVBKTjhv?=
 =?utf-8?B?TDFOYVJxL1JxTmlKN1JJRVgrMURIUGlydzVQL3ZSMVA5a0hIVjNHSFRTcFFt?=
 =?utf-8?B?ZG5Kb01mbTNpeTNndnhCMXNCNndmYWJqNityV1Ura0dIYlVuMnVkbWM2SEtO?=
 =?utf-8?B?aVQvN2pJSHBLKzhhQU9BTUFxOUgrU0VRVlJqUjN1ZXlDZW5zSnZyTEp0Ly96?=
 =?utf-8?B?V3VRUW8zVUloeHk1dGpkaUdLb0xPWUxGWGFFTUl5bU9NV1dkYmR0VTM0aFps?=
 =?utf-8?B?RUo4UjkwQytpOUZjMXM1d0dicnorOWpJMzBQZnNFa2RrQ2dXYmdFekJtT0xG?=
 =?utf-8?B?d3dReFdpM1ZZYWNvbjVacjY2Q0diRnFtY0x4QUlrVE5lSGFPZHEvVDl1KzVC?=
 =?utf-8?B?Nk1pVmdnZnBJTTJOUCt2YlNZNlVMMGpUSVlqb3pSaVJjQk5OTEtCU25abDNZ?=
 =?utf-8?B?M1VqVERKM3JXTWZPYjl4VjJweURzalBkeFN2RGNIN3g2VGdFcnJZcXdTM1R5?=
 =?utf-8?B?alMrWUdZcDgzazc1Y3F1YmlBK2Foa0ZvblBCQTRGU25uajVzWWVxK3R3K3A1?=
 =?utf-8?B?VzQ3QjlxdzA0ZkU5c3Btc3AydEVRaTJlRFFjd3c3OGtWcTVObE1BTFhCN3NN?=
 =?utf-8?B?REk4RFJxdzF6YXVZUUFqbGNQZktsNHVCemlId2dJVzl4Q3JpdUdKMDBxdTRv?=
 =?utf-8?B?MnFid09idXdLaXpJRkFJNXUzYnlXcXgybUpJOWxvOExhMzhIRm5kNnhqdWFW?=
 =?utf-8?B?c2dmY2xIWGFTaDc1RXVYckh4T0VXSURyZ21ncHhYWURuMExkeHpmTFk3MU9s?=
 =?utf-8?B?RHJyZTM4YkR0bXd1ZlVlekdIR1hnU09QSlNjaUNvQW8yU0d6ckhlN0JWZlN6?=
 =?utf-8?B?SUx4V0hKTW1BMzkwN1gxMWVCVHhSa1llOGNrY2xFaGVkZVJ4Ymh6Y05sQ1hU?=
 =?utf-8?B?ZzliMXZNODVZZ2szNjUvNWQ0dkQvOTQ1ZVcvLzhxUXVTOTBmaWZFdXRVN1Rl?=
 =?utf-8?B?WFI4Rnd3c1JLTmpiZzZ4Qmw1dU81MUM2SWpuUlVlREZKTjgybUI3V3FLZDVF?=
 =?utf-8?B?T2syY3JYVTNVZFA4YTRoZWl4cWwzWjV2dVp3bGw4OGZPVUdvbVF5MmtUSW01?=
 =?utf-8?B?T2VHTndGOFJBVnZuUzlLQXE4K0ZlVm9UeVorZnEwY0JXTmNrMW1SQnpwWmJ1?=
 =?utf-8?B?VnNWTXg4NTJ5QkswTjMyRGFWcXdSd1QzTUVzdlppMS9DWGZ5SXJJK0l2SFRK?=
 =?utf-8?B?a0tyMEZ5ZVlyR2R4UzVRQ2JSeUZRYTdsNEpuV0I4OXJuWTNMYXdyUHpqSGli?=
 =?utf-8?B?RjgvUnVWYlJPMGpwTWsvcWE2ZnJTNjI3SWlNSVBkSWM5MUdjYjJmK1dDbTRH?=
 =?utf-8?B?eGhaNmlCSzNhL2FIQ0hkVVBycDVHcjZGOHNLcUJiMnVCUkhhcnNESllRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ky9JcFpXc1c2c1lZSDhXdUJsMW9zTk92bWd6QnVSaXJ4WU9xdG9UdXpvc1p5?=
 =?utf-8?B?KzBiSUo2YmZjTElmT3NxSGR5SWFvVjNIYWx3eDR2ZS9zeHh6U2tzK2ZJSjJk?=
 =?utf-8?B?L1Rwd1VPMExnRC9wTFNCc0hJb0E5TC9EZkZvSFBwRUh0dTNUMk5JUVVFTmZ6?=
 =?utf-8?B?NGpoZXEyM0tOdzB1ZFhqRzFTSEM0TU1KdVhvdXlKUm5seWd4TnRraTRPMlZO?=
 =?utf-8?B?dEhXcm5lZE1UdzJyZFQyMitjcUZZWW9KZTJmV21tVno1S0RzV00vVGxyNHFQ?=
 =?utf-8?B?Tm5Pcnl1ZXlRYUFmdWF4WUNWTXIxaVVCUnNUbkxNWENPb3d3SktUL3VJUDYr?=
 =?utf-8?B?czdRM0orR0paWWdTSVpJSW9YM0VkY0E0dG92aUgrZXIxSnZPb2lldXU3cThk?=
 =?utf-8?B?Tm54R2twcUxqcHR2dEZWenF0Mjd1VC9QMCtDZjZIQ0E2ZjBkMFQ5TFd5L1hw?=
 =?utf-8?B?UHY1bXhGZUFhSml3eWtTSG1uWTljNllEY2RReG1CS1ZQaXljQVVnSkZwS0pF?=
 =?utf-8?B?dDlpaXBNK0pnaEhQam1pM1BwZkdDS3BJcnJLVm12ZkRoNHdrV08wbDdkd0JC?=
 =?utf-8?B?VGJhbHNKb3Z4b0JWS3pFRTRaYitlYkZyYnV2S0NFSlQvNVBYSFV5VFQ2Zllh?=
 =?utf-8?B?R2hyeCt6NkdnWkxIODJScURsV1RET00vRzllSjU3MjdQSDVWVUI4K3FkMThN?=
 =?utf-8?B?YnFPM3E5TkdIYyttaXkwQnFhMW1xWVJYMkZreXVZVGdhdU9WdXg1eUJRR2Qw?=
 =?utf-8?B?TkVLenFuR0xUYTkrNVcrS2pUTnBmVG1tSkZ5R25FdmFheURFWkhpa3Q4eTVQ?=
 =?utf-8?B?eEw5SEcvdVAxbDlTYjdXRnpOV0VtZ1BCSjBLOXhNVU1UUURQVmxwM1Q0WVhl?=
 =?utf-8?B?MjVIY1dMWk1yVGZXdDIrRFJHakdOeUhGbVBHUTU1cVhuUEVFbjQxb2dGWkg3?=
 =?utf-8?B?RVQ2dTFoWDJBRUl2TTlCWFE4ekxvZHVad2FPWktyUVZyaXBoL2tySmtyQmJW?=
 =?utf-8?B?SGZOdGFORUNWWjhQUVI0WlN5RTltWjZ4TWszUFR5RzlJOGNUUmVoQXBkSk1k?=
 =?utf-8?B?VTJETHM0MXlMSVNFZkRYN3c3RFNML2YzVnBFVCtDeTUvby9tMDhOd3dSMTRM?=
 =?utf-8?B?am9qUDhQU0ZIOURhOHFZOWJHM3pwVHhTMzg4YWowb0p4bFVRSkdVUGtLa3Zy?=
 =?utf-8?B?YWNFZkFtd0NVem5uNXNScEhjbnI1cFdWeERjbjZVdldZSlNFci9USlF2SXFW?=
 =?utf-8?B?Ni8rSWxrMjNmMkN3ZnkzbG5OTklCSm5KR25NWk9Wa1Q4NlVXSGZYclprU1Fn?=
 =?utf-8?B?ZkEveWd5TlpCaFZLZ1lTMkpaSy9TMkkzYzJsQVhwL1paTStuZTVzdjBFTHlp?=
 =?utf-8?B?VzBuczliK1lHMXZ0S1hnOEJJYW4wc3ZRczltS2RhbnFpZGJEZ1ZlNG5GZ0ky?=
 =?utf-8?B?eTgza0J0QWUyS1ZLc3VCQVB0ZUZ1Zi82Ymg0eG1JUlJ6N2R5YWRXL0ZkSFFo?=
 =?utf-8?B?Q3J3SUFOZnptRnUzN1ZPSy8vN1NGUFJBU1BiWjFMV2ppNFc0UmV3Q0dWN0Fz?=
 =?utf-8?B?M2xBUDBsY2lja050NmJIOFhRN3lVWmFkM1VtVnlRc2tPZWdRRVR0dUk2Wktn?=
 =?utf-8?B?dGlSLzFNSUpYR1RCaGdNRHNSS01DdWJEaEMvZ2RSRFZudzdRN1VwdWl5NHdP?=
 =?utf-8?B?RDRmZ0VXSHRRc3V0WWhjWHk1N3FKbTlrVFo5RHVPL0lEYS85ZjNWVnJhMjJp?=
 =?utf-8?B?eUgyYjNtSHErQ2tGUTdwWlovQmNOb1ZMZmNienRkVTN0azVWOFFRL0cwek5j?=
 =?utf-8?B?aGUrK0dDS2dKaGg2enJabGdvOXJEbTJmSTFvSjY3djllWSs4RXRob3AxRzFC?=
 =?utf-8?B?SCtIQlE5RFc0RzV3L29YQkIvS05PZDdNQzZIWVpwSHhRamppb0thRU9mYko2?=
 =?utf-8?Q?YCgyNdotjwIE0SKQBZGWMMxIQdMPDN8q?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca78685-6175-4bc2-de2e-08df135ac74e
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 18:54:32.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P251MB0954

nfc_llcp_recv_hdlc() reads the sequence byte skb->data[2], via
nfc_llcp_ns()/nfc_llcp_nr(), before any length check. The receive path
only guarantees the two-byte LLCP header -- __nfc_llcp_recv() checks it
with pskb_may_pull() and nfc_llcp_recv_agf() admits two-byte inner PDUs
-- so a two-byte I, RR or RNR PDU reads one byte of uninitialised skb
tailroom. The byte becomes N(R)/N(S); a peer can already set those with
a well-formed PDU, so this is acting on uninitialised memory, not new
peer control.

Guard the read with pskb_may_pull(), as commit 95674f506c63 ("nfc: llcp:
reject PDUs shorter than the LLCP header") did for the two-byte header,
so the sequence byte is present and linear before it is read. RR and RNR
PDUs are LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE bytes and an I PDU is
longer, so no valid frame is rejected; a truncated PDU is malformed, so
return without a DM reply.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---

Notes:
    v2:
      - scope to nfc_llcp_recv_hdlc() only; the recv_dm() half duplicated
        Lekë Hapçiu's pending fix (20260729011547.19191-2-snowwlake@icloud.com)
      - return silently instead of answering DM(NOCONN) as v1 did, which would
        close an established peer connection (Sashiko)
      - guard with pskb_may_pull(), matching commit 95674f506c63
      - add Assisted-by, target net, Cc the right lists, reword the changelog
    v1: https://lore.kernel.org/netdev/AS8P251MB0001E8602F36054CDD8979A2C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/
    
    Built net/nfc/llcp_core.o on v7.3-rc1 with KASAN and W=1, no warnings.
    No NFC hardware; not runtime-tested.

 net/nfc/llcp_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index cac1b54..c553123 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1074,6 +1074,9 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	struct sock *sk;
 	u8 dsap, ssap, ptype, ns, nr;
 
+	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE))
+		return;
+
 	ptype = nfc_llcp_ptype(skb);
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
-- 
2.53.0.windows.1

