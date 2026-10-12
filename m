Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1D3793BB;
	Mon, 12 Oct 2026 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812382; cv=fail; b=HGX2f2EZ9CaWRma1pYZWalQ8zVfb2CaPJKfxmzDcFcyIA4Z37IPxiX80okLvMPwE0+s3Dv9t3sw1YT6nNo/QfcSn/4cgUQUkJ2z7gf1q4DSpGw0hKgB1tE/segYzD0TVCbqYCbqQWqK2hk/igsjsfEDvnLZXjhzrcm+/qA8qAcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812382; c=relaxed/simple;
	bh=EG7Pd8eZYeZM4vIGWUWrMCXDcs30hIb+xqeZ+J9CSI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jh2sItGkppzKuBNCPNtJa8skwvHQs+7OihFfHCXVyVtSAatenx7F7H9AbWHiWbktVOQyeWb2LzDCPK5QzdTBn9wMz4rN5pRW4ym1uT0Dmohlodrf2fpSLgkcAvSSNAlhETPRQHmJgTThizYVpd7e4dgox7RRM0tsqYc9r2qs3xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EiZw/d83; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IK34T4Rq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EiZw/d83";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IK34T4Rq"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCieGF1832792;
	Mon, 12 Oct 2026 13:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=THj2VAH4vYqjf10+6QNYcZhiTBzTrCzAW0E7FuPMxP8=; b=
	EiZw/d83xRahnJ0anfFTCN2aHzBu3b+zK8J7U7ujjNHKcGfQeXSUdq4Z6TbGEpoY
	nzYsDDPHXWcWHUmBaiEGzwXc7DkzSl5iNHvGnEA/1y4qWLoSCJiJGTn0LajQjhL/
	ZdG9MbupawEU3FajqqLFY6ee3ATEWvG7mB5jk7TgjzhE0HroU4Eo9SUnKLiIhSXC
	CxsUq0Ey69+UPIFlMvjziEHGd1yFiWyUgLj40mqFX8QXmsI68qh0j9ecGbnXshTG
	1Vjju5qSBNaaoebqfhd1UXvSu3Nt+SKMPJqSHWss5/7uTQu/LgJcutQnORXwcn52
	gBK0t1puBtsIYESVKMOZNg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dcsaata-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:39:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CDaJ3g001138;
	Mon, 12 Oct 2026 13:39:29 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7bt80uv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 13:39:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejTF9IPGn3Q40aHhpVHSZukKg2L0ATF38yd6SyNNXyMLYRgOVYhBRmv820E5wX9LGooya5GFlxbhUM8mecygaMgZJSvSSEAs+wHSFl95G4wskAroiT65fBQfApSOkAdo2YZQQOaj9lV9B6Emh6mUsNl9k67dqLhMARarG8C4eplpFIj3GGEJpW8Fw5YAcmndfjYwrNi/MKwjRB6L6Sa0Dvouqm1gxV7h/GFSXjhEUsF7XVIUgBvggn8ILWt9tM5dj596bkVkWvY9yD975YCjrb6UxXqxfo7YR0rIyBSf+qmmThltKdhz875fom6MYd8IgtLQJO9HQYDxNVRgHT7ZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THj2VAH4vYqjf10+6QNYcZhiTBzTrCzAW0E7FuPMxP8=;
 b=RSNzn3AusBWUPB8N+UgoUowKKoGA/YK0DLOU9PKdyJn9wWYlv/KWXe40x5Q1DCAKhYLDgeOJydq6UNo154RWGIAXb1uZfVqrVDY2RH4G1Hczei0fbJKX/atlz813nRO576wGnpbdVu/EypQpWtTQwyR5Kwhjf+kJxlo3TSU8FZDhThPBunD5SYMvVGc96lK3kerIqnL8ecjNW+O2UXRTAn1Sxg9vG5deXKP3GY3eesad/glPgU3QFcw2DA1P6PL3DPRisXeSL2sjesVltsoPgMj4MJPJqBl3BPGjHXJ5qAuxdzG4Rhp93ef/FQQXLJ5bPCeDWdvJlEqddL9JBNGr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THj2VAH4vYqjf10+6QNYcZhiTBzTrCzAW0E7FuPMxP8=;
 b=IK34T4RqE0iU/xvW5PSTnPHoHUwc4dqKhb4z9NlOba8GwEPWMEv2ZKfQzXeDHXdvLVEsVn2hkd3PdKRMjbHZ5JyRdDHW0cdXbtYtbB3Xz+RFh1I9kcasVF7Bs+vK36KaRDUrQTnIvKl24MGEfkP0M+K3o3lIu2XE/w5809GSHjM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB5834.namprd10.prod.outlook.com (2603:10b6:a03:3ee::16)
 by DS7PR10MB7374.namprd10.prod.outlook.com (2603:10b6:8:eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.7; Mon, 12 Oct
 2026 13:39:12 +0000
Received: from SJ0PR10MB5834.namprd10.prod.outlook.com
 ([fe80::2444:1d33:3ce:d83a]) by SJ0PR10MB5834.namprd10.prod.outlook.com
 ([fe80::2444:1d33:3ce:d83a%7]) with mapi id 15.21.0522.002; Mon, 12 Oct 2026
 13:39:11 +0000
Message-ID: <2c0c5d51-197c-47fd-b002-ecff397a826e@oracle.com>
Date: Mon, 12 Oct 2026 19:09:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] wifi: cfg80211: release locks on error in
 cfg80211_wext_siwgenie()
To: Wentao Guan <guanwentao@uniontech.com>, Sasha Levin <sashal@kernel.org>,
        kartikey406 <kartikey406@gmail.com>
Cc: johannes <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <20261010043002.2919860-1-guanwentao@uniontech.com>
 <tencent_54DE3A7910D4598F5676AE58@qq.com>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
In-Reply-To: <tencent_54DE3A7910D4598F5676AE58@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To SJ0PR10MB5834.namprd10.prod.outlook.com
 (2603:10b6:a03:3ee::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5834:EE_|DS7PR10MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d737abe-319c-4759-5b85-08df286632f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|261009223027099003|4143699003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	GnESs4MBjsOdg8ZFKeZjyWxjTvh0N6MFNhm3TqQNbOEsE24w1N2+zbbER9d9Vbi4FhK6CwBKn1/nXfndUzETuplP35TaVMh1z11GckDE86ogy6Qux5ZvGv0ZHYxb4PqeO4N9+oVKAGxtvN14Kd3EMyjV10fWZQxJ5OMGGbo/psXhtctNKi9uVHTocimKNvlkViAUitr0n6YTek5GGDksxsEqfOy5SbYt2hqmtD5nmthABzUgpHOfFxU7Qvd4AOhetZ4CSDeP5sfqqJW/fBePmh62bmxHRZYjimvdYQihSU8kVFwhiwWYMccM1sj0dnqPaFUbnL910W6UJ/qwi3Uh+zQazmqYxjuscx917jDdOZSlhhyBGQOkZSr0Ul8fI1XwcWi3j30SbR0BwYVpGdeW8A1jbidfmZ5lEeesXK2epU3TMRcby0N1tLqbT/b3m2iTGsQ9KHwermASvmi7f2c2yCbnuMvZp9ZnfumedSdeiuDYmJwrBwvuLLaCRcRLR5xArDFT8yn1wKcfG7A0y0Tb/S8mqSF7MKdXjI4JRdzrBUIzFiJR1OY3du8lc+S2WKPpPirvJ1BJeSQR8+Zld+IWwPUSsEzzvTezBlIc7rAu7itw15RFhBtJicaWuob2ca4+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5834.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(261009223027099003)(4143699003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3hiV1I0dnR0L2ZlRzd1UW1DaWY5SVFJWWovOG0vRFdhdlNrazZwZzNDK1FO?=
 =?utf-8?B?aWhEMGNEc1dxcVJKQzJIanBsc05TV0NUNm5nSmtLUUVkSU1veE9nME9vUmNh?=
 =?utf-8?B?QTlSQlpUYzRrZzd1ZTRzR0xaY25IR3NwZWd4ME9rVEZ4V1pVUkNOWi9VU2ho?=
 =?utf-8?B?Z09ObDQxVUUwRVlsSEFuVUFPNlRENHBlbThOY0hGa3pMRXRLSnlscTdBZmNR?=
 =?utf-8?B?ZUVFMy9RcEpzVEYyeU1CZ3RBSmREeXlPbnUzbTlMZjRMZk13dEgvV3B6dkRu?=
 =?utf-8?B?Q0Nvc2t2R3FkZlpJWnpCWGVGQm1PSk85cTBQZ2FQWW5QaXlqanA5dTZyOThO?=
 =?utf-8?B?OUt5Wk5iRlJJcW9OSUNKM213Rk0zdlpZV2xPNzkzaXZmd09DMWhnMUxnMVk4?=
 =?utf-8?B?cU9HdE4rTHJ5dk9kVTZ2ZVRsWXBKZmY5ckl3eERsYlZaakJxRFFtYTZ1M3dB?=
 =?utf-8?B?d3NDUm5vWjZ5a3cvcFE3ZnhFbjdESURXY01OUzd0cGdMT0pqMDAxL0ROL0s4?=
 =?utf-8?B?TTB1N3NnRWtZRmtJZG1uQkN5UWl2OVByaGNNZWtZUU5YVGFaLzZDdVFZTDJC?=
 =?utf-8?B?cWhyZnA1SDJubzJ6dmtOSE9KTWE2eFRUYlk5UG5lK2xoeFNVb09idlN0VlJN?=
 =?utf-8?B?ZDM0SWJXV3liSVhnVDg5TGtLWUhiKzNTSWFKRDVYdTNSb0ZZNVlvcTBuTWJL?=
 =?utf-8?B?c0QzMGdqY1pzcTVFSkJhaS80R0kwelYycVlGY2dVN2xZSVNLKzVOSFRtSEE5?=
 =?utf-8?B?NkQyM3dNN3F4UXFmVjNqSzdaSjR4R3grbExBdDZhZ25NSHRvVEFQU2hSQVBv?=
 =?utf-8?B?RnU3SXRhMWhDcmpqbVZmSFFMSi9hSjd6VFQxNXQvRXZSamZtc2cyVEVpQnJV?=
 =?utf-8?B?UHV5SDBWQlVMTzY1M21vVThBeTdhMHNVM2tnSDJGYXVqVWpsTGlhc2c5UHd1?=
 =?utf-8?B?WU4yZzZtbEhGWlFvK1VLc3N3U3BtOUxMZyt1RDI5OXRJYzcvQnFJZVMyTUlX?=
 =?utf-8?B?Uzdsb05ZSDlsd0J4emt6S1Q4dUZmNDExN1VPRzMyM1dFbnNrb2s3Mm0yQkZR?=
 =?utf-8?B?N000aFFJRzlFM09ZQUZ3OWFwcWtmdWlZN2VvUmFGQ096OUNJVDNZUXVZd3M3?=
 =?utf-8?B?OUF3cjYzQVRLT2VBeTlxOEpqVmpFdGQ4VnZJVHk0UEs2cU1ZalJTKy9YakM1?=
 =?utf-8?B?ZXpIeHpoUkswVm5HUmVrQmZrUlQ4dVRNQjZNNXd0a3R1aE9id05SSWpZbXpB?=
 =?utf-8?B?RzR2UHhIdmJPSGNkZG8vVmJocHVpeW1zS0M0K2R3WGM3V1NSdjQxU3NHQ25J?=
 =?utf-8?B?Tkt0ZDBucWx5SjhJZzRGaS96TXlGMUlsVmpGL05mNS9FZ3AwbTBOcjVHcFFJ?=
 =?utf-8?B?eVRqUFBnd0lJWXpKWHJld0c5MitmT0QyMmxNclpxU3BZT3NYVGRLRGFpU1ND?=
 =?utf-8?B?QjBRd1ZmV3lOOTRCYTBCVURLbUFNTVZyN3orWlcvMXRoVjBXQ015cU1BNlFG?=
 =?utf-8?B?VTVQdTFLZ3BVVTdTSVo4Z3UzQ0xSUW1TTXFsWTVpN3RGOWJQaXQ1SnBsNFJU?=
 =?utf-8?B?Z25CUWRXMkpycXVDbm1yWUg2cUZMUEhwWDhpbWZVdFc2OHV1ZHNlQXh1U1pH?=
 =?utf-8?B?QWV3RFQ4VjUvKytydVpzWGpoZlVKRmIvNGhCN1p2T0xobHYzQU4yR09zKzJ3?=
 =?utf-8?B?am9KZC8vUXg3R0djVzRMdy9rUVhVa2h2N3RsUkZNQ1kwS2lnSytkblV4bjFu?=
 =?utf-8?B?cThxNmlyR3lXU2wydDdLTit5cGFEV1JQZm5kZXZ0N1hpQ3dqSlJ4Nnc0Vk1Q?=
 =?utf-8?B?OEovRG5MdHhSSG9BRkszdWUxRTVBSG13VTMyVVIvdWcrdlhlMmEyZXdJM2Zx?=
 =?utf-8?B?bHVmeUFVZXVYNFM1Sjh3a0EyZzd4N0Nlb3V1SjQ2NEVJUEErdFM0SW1LYnRP?=
 =?utf-8?B?Nm9LUldpZWo5VjZFbVRkN0RDdXdmYnBLSlNPWVNlSTlrSVZZUFlLZVJMYnpH?=
 =?utf-8?B?MVZWNWZXU3RGOGtRb00zVjJFWXNadDgzNVZGclVRWCtGY09uUUQ3M1hPczZQ?=
 =?utf-8?B?NGd5bGZFWlV5ZWhiTjh1ZFBJY1h1bHJDemtvU1hhM1plYmxhQWc2bFBlSEM2?=
 =?utf-8?B?cE9jMmkyVFdaSkxvdURobGdLQ1pLSHIrZmJPQ1daTjJDbUFkL0h0Y1dDQUZp?=
 =?utf-8?B?NGlDckgvVlBIVThhQ21DdnlzUnBEYnNGWDlTSG4rQ3N2OGFYcCt5dUoyaVk0?=
 =?utf-8?B?WCtIK05sb3hEdkF4cG1yUHhZQS81RWZ1QVRUOG5GVys2VFEyclkyRWs5d2FJ?=
 =?utf-8?B?S1lpb0c2enNkbnJ2Y0JPL2pybHdvd2hKbHA2WWZyZzFGdERON2J3RW1rbTVX?=
 =?utf-8?Q?NkAUKe9yDVxhmNNyzmbq5eqVMSnsjReO65hxx?=
X-Exchange-RoutingPolicyChecked:
	tLbmIIdZ2V04h4LrjlIOzh09ReH+Tbp5tm7w1sPIaJszRU+JJIwNk3kLDxgTWzh9/TUzbedspFt9xRT7HHBfTVmOlPpHG3hlQgDeTRUrpNcFltz1JG7eI+m63djCuilZWeI7Sdr9BRuLiHQzVZyZif7e0sg1+FUCuP7x+zFxAXRQ5UxTQqPIcr8JkeSeN8vz0bf+TF42Lyxvtu8Ja7VbDl1L7XAQPrh6zm0wR5VtJA7xu6juvPv/EFwaFkuMUY+5cSf2zvYF5eDESGjTMf5a1Olu2GiZVJ9Q1LohcF2Y0kkQMoZuNO6Kc0t6IU1bRKGb4lzTNARy5H/T/mKO3y1SpA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WGkPYmZIVrWGJIRKLgP30m1dQpr8CNPUCD3DAm7oNmrErGNoktNkulXj26vfxhltxycrSIrOTV6jEfVr2gmDndecZlmS4ccvJaMcgGknl3o3YeEnp5E4BnrZPra3rF3tSjV2B5jEdVS75fb3iG8M3Xkd+6FdZBnksEWsZBgaFGw2X9EkKuc9nxn4txfv0tzYneRjsyBBTAQrtXfue73oPJmdiVJRwHXf62X4GvlA3CENCYEevJLX6+N9BJkckLlBXGRVu5A1bEmtpckRe7PAITzIK8x6nDcbiKdqlDQDygu2I1cPEoIlOIt00AS7r8NX3T7hesbeqr0RgMG4c+LFzDoAmzaBKin0UG2+1KRYTqmI1iGoQ/Gk/jI5KHWBzBe5PpuLtKApg1cj9mxnT9hxbQwjTq1EWoklMGkthr0EZ9suE851uIpSqoCkCekjc7jVSohH+/v/+E98OQLLbCbW9e0D9YLA9i7UaudEc9M0AIlnKHjlbcIhCYOu0tn2+nc2qVzYPVV2I+HCQ4etEHGtpQ1vjf+x3O1/purza86zp1kPYYZiyNl/qcnDOWL8YWydcK/6moF6w1uW/4/WORR0ypjbdxCwZCaDd6IEshDfLz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d737abe-319c-4759-5b85-08df286632f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5834.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:39:11.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqDtZbTraND1g0dIkCT3K1gVWZcobu+mNt76HOgsfz0tGMAoDf7RoGpaiJHkWhhdqw97N8r/Yq6t6oPo8xM91pKAIDsEg0PaBpL4z6r9E/X5CQxG/cEAA0R4BSOndfSS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610120054
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX5wXELvl5e0LV
 ZPRZuyXSs3P5q62BHxqm+lEyt6TB2rwuw/636XQ9DaMlt4w71EbJAkHfO1sjTMgtHOJ5ZF+ES+3
 Zn2nF4rUI0RS5WHpM1qQhxsftbsY+l99U6hyywmf/3xIBwtNiU+U
X-Proofpoint-GUID: Mgmje-8OeoyPf0yYnOsDGOASdYDDTKGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX8Q7KjkBNHX6b
 GSWGm55KzkgjgUS5BdMVRek4DxJx+yjyGDr9cpVxOD0qH05Wjh0MXM2OTyK2HT+U6JAuHr1OGGC
 myPES000B/3iNJ5G8G9/N3NmydQr1DRoFBz4sar46aJeVjxmB0Ih0JEwIOmprsSuRpbRFZdSTZ5
 9IwXvkHCE+G1x1XjZcgS9mui0oQqBSLvoxVPCWXDAueXma/4kDUNRdvUKsTmAahBqqTKGm94tt+
 eYXpsvxPB0Usqx0AGGzAg94rsBUnuMcFzHuf1O3n48IVuSiYJGcglbAmDr5q918Q4UQ00VQ/Q88
 7rbyyHMstHP31wsRNWXodhMjqoiNoLsUjTZR6tvcAS+iADvgZicidE8koJoRNO9bZnCnQdPJK+G
 kq3L88LAlIwcEoZXjH0o8oyToDPk+hXZ6qTtOqwO4wrwVfvByahBnNqUd4gC1uFk9/hoZU2yc3K
 NgMrZS6n48vec50GbtQ==
X-Proofpoint-ORIG-GUID: Mgmje-8OeoyPf0yYnOsDGOASdYDDTKGX
X-Authority-Analysis: v=2.4 cv=EdZd0/mC c=1 sm=1 tr=0 ts=6acce312 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=NfuPzBKRnNo-DpCcSiQA:9 a=QEXdDO2ut3YA:10

Hi Wentao,

On 10/10/26 10:04 am, Wentao Guan wrote:
> Sorry, it is for v6.6.158. cc the stable list.
> 

this needs to be fixed on 5.15.y and 6.1.y.

This was reported here: 
https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/ 


thanks for making a patch.

Are you planning to send it to other branches as well ?

thanks,
Harshit> BRs
> Wentao Guan
> 
>> ---
>> net/wireless/wext-sme.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
>> index cfa903eb0e82f..0e7c314bdeef0 100644
>> --- a/net/wireless/wext-sme.c
>> +++ b/net/wireless/wext-sme.c
>> @@ -354,8 +354,10 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
>>                          /* nothing */
>>                  }
>>   
>> -               if (!for_each_element_completed(elem, extra, ie_len))
>> -                       return -EINVAL;
>> +               if (!for_each_element_completed(elem, extra, ie_len)) {
>> +                       err = -EINVAL;
>> +                       goto out;
>> +               }
>>
>>                 ie = kmemdup(extra, ie_len, GFP_KERNEL);
>>                  if (!ie) {

