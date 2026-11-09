Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240346;
	b=X5XwIAccgYS6axBfBmluiSvhBZ1rDPdEnJGYDaO9casT/DU/5erj4YIi5vNgoG9o4Teb
	 EHzzVGGBULd38W4Z1zZj9ER+duE9DoM7Yns9kDVbPCtCoNJzuAeBlmNol/Lg358AS5qJ4
	 DH37jhuLUxr/e8blK53AfsFB8+v9Xm2+g4ZDqbOfs0RXGLKMcuLW+arEFxOLp4cmU0NDf
	 fD+baIffHI++GOULfVvyrDR41Ixymzv1t3uQGzs1JlcZ63sEjmA8cZICKCxUw2MredjBV
	 +BgvxSasuQFL3FcMIRX7yHQ6Lm2tpGRooMql/vTcvBSyaJC/vFAPiS9m7/shpD9PiqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240346;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=W+yIQb0ExEPrN+VXR7DlK+FaFDuHRQM1ALz9suIH2+U=;
	b=z+1oZXs6F0eaJhSTXeXI8nInxvLQWEbW/ONYlUQ1u7uwxZLLzAto/iGiNju5VeQd8s7T
	 wXiY3e1w3xaH7fLXtpXtTOINZ77k4cb5ZP4Bh2foVUVP3M3RXx+xurzTKvzF0Idek61gq
	 HY90HJP7ufJvgKgszQO4OqaKhYa54e8mp0Ybc0y9lA3zpmVO2fHl+M9O/w/ljmTC/CGy6
	 ez+v5MLJi8en1FfJxSH3VltaNCU9t+YYWJweckIQ+noLsBRKCdiqthEp6xC4tnkUmS0u/
	 s3KBnosst1YORtc+mEat2Zl8pAhsCEDRtQ/2tn8Xf05uX3d104VJ7GF0uFH5Vwm1AxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=C9GBIQuQ;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1GKSQdaV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB73606EE83;
	Mon,  9 Nov 2026 16:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AB73606EE83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=C9GBIQuQ;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1GKSQdaV
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9FVHaE2549206;
	Mon, 9 Nov 2026 11:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=W+yIQb0ExEPrN+VXR7DlK+FaFDuHRQM1ALz9suIH2+U=; b=C9GBIQu
	Q5jcdf9GaKN9sAAmnVAlgAJX7aGaXTinuZHAVAh0Yg2PdI4RzPF1MlSA3cVZBbla
	aDlIlKm54l28CiJzGkuf/2sUgFJUHxrqjw8mg2JMHYWasehwgKwjEmLFSofQ1z+m
	tM2ODvKkScdVb4P1cQBcFr1xLKqTo7ZzLQG5LO5J0caX4dffDgl+DIxLKMWcUPIH
	oVLMXCOy5LYMP1ntM/9uRIcYW9PmB/g5ljKdsza8wtICIABoNEB9hB4i+Kng+HNh
	v+coFTddbfDrVFjgTZDMxFWiOSgnjeLQfUkaovQlZ+joIK4d+6HIALy5nBfPrfsy
	1LMHPlpTh6bCUBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=W+yIQ
	b0ExEPrN+VXR7DlK+FaFDuHRQM1ALz9suIH2+U=; b=1GKSQdaVUF/N0PMKf63kn
	KKJVedyKskA7hLeuO+yeziVASwpZHXKI3HbCv7EoTAr4xOkCfgGfHnCAqX4qGv9U
	F6nMT180mLvtxO1xvgFfp5nPAD1rX1WcK4ZEOV11V/2vPUSbCb2VOwDhLuz+b682
	F4k6WWpi+8LrxVDGnuToW5+aJq6qoZ6EfopJGg53/cocg8jsWAxw3spXQNxEo2zf
	ZnhMBD79GytpzgiibuUuw7IQp7JC0HdOszWKkdJJoZbaXcEma8MTZi8nOZ3KYHSz
	gaHiIIRxxxPegtIGRA1ePcy7Abwc7+7RoNNbmRQq9ZzUVYUwh4Id5D+EK/4jwXwk
	A==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hugvx861r-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 11:05:05 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2g9ECjgiY0UE/om8FhPR7OSfLSlruIzq9Cg+CdVoIz30Xs+7N50ABAJK24peZmujg/0zJnAdTVdRrXk9oz6J3WMBuwdixF4oCCCYCS43QN9Ld5aJiXVl8qibXaXmpHfudjw5nTch2LfEyi+a+3GmixPGcMoiSgsq4I7nJZ9yvkel7YMfuQnyY61mlwbUCe1xIZnfl43tyxIwFcz56Ub5/ipFmogdt0xOOCUriAZC4qYxsHF8l6UgZpkJO+jm32F5wOxXAvrEYD49NY8h24Qj/KDD1vRLbodBUnteeQNQqggvenmEkxZ22sUX/zKbTDr7FAG/eKLuxfBJ31IbjPceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+yIQb0ExEPrN+VXR7DlK+FaFDuHRQM1ALz9suIH2+U=;
 b=W4Yf5pRqy0UFOTMDx4Hl95UCxD0tByN3bO9CPEmkw0SAp2j795aLH7PBLHaGOJT3RfnGDxVHqcr9iIkDRRW99G9+fTF7VrNxtlc0Qeqb7xsJWsVK4xRVH4r73Tz1OEtRURK3GnEB3Wyc9zgcLkaqccXGrcxl3666Q8GzyT4pI96S25A5QkXFH7/tv/EvzTvmzFh1m8rQPixHqYfHAF78+FD54u4t0Hvi+Ug6rEQ4XNGtW9zhmjyRRLUJidrFweWFNbBNbex95cmy9gML1nV4z91CSzpQLk7GUZn43b5SrIRKrbR2R1rhtyepl/aydcGDaeQFEQ3gfzxvi0nFi7RvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS0PR03MB989665.namprd03.prod.outlook.com (2603:10b6:8:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 16:05:02 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 16:05:02 +0000
Date: Mon, 9 Nov 2026 16:06:28 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: raoxu <raoxu@uniontech.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
        luiz.von.dentz@intel.com, brgl@kernel.org, pmenzel@molgen.mpg.de,
        pengpeng@iscas.ac.cn, u.kleine-koenig@baylibre.com, lars@metafoo.de,
        mike.looijmans@topic.nl, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ltc2471: Fix LTC2473 differential offset
Message-ID: <avHvQ_TmiuhrhwSC@nsa>
References: <5E0C7B547C19B947+20261109095553.3790087-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E0C7B547C19B947+20261109095553.3790087-1-raoxu@uniontech.com>
X-ClientProxiedBy: PA7P264CA0177.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::14) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS0PR03MB989665:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c75cf7-3331-4264-4a97-08df3e7b3670
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|6133799003|10067099003|11063799006|261028144727099003|261102123227099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
 zZilXwzF/UuCJg13dsY5FkZUkWToTKzJFW2BMbngQVKeLb8wFXRsS1CvART+jdb/oe5+a+Xf3vN/+nFv9BmHiwRnc/xeSncxsdVOcYknNvJLcmOuIGtdU3w7FPkWK+kaCz5/DpkNvqle8oqovKB4oyYCbbcDyVHjxtSkvsBprfHAQs+TLobvtEec1HRd7Z5aSbgyQwKygnXqMBISN9vlJB+W0cC3rOLvz/KuyDsiE0Ah0RuRdaJP7yyIBJ2SAKDGC7e0/16P/bJ8WxFia/NFj3bgOL7EWx/2mcsFfSbincikhCWZ/TS5uODBKQNwveTb6OtkQkd7JXlARH0yMOAscxiq7UAbiobF0FvvwsU3KFqXNMP9XShX/J6NCWYg3Z91B9NNGqho6D746bxGG7S6NdU5YIiZgKjOptkp18ZCKUTHQbeNXLD+aZ2nBlk2Tcu85Z3HbqMoGaeGShAHTO2cvAtNM5wfWdvL2WZ04J22aaQK2uE9IUuYGo99qEHk/2kAkYh8sRpfm4HDdvvNMwVOJssm4LRHhgOUPmVcPcY6k4ab33ELhsmchdEqdFLVV5bRwdF12QyFPJzv60FmgUXoAz6Qblryw7cwmSXSFngNWb7CVJguAzwSsThMGoLQvTvcTVuULMiLVLB7IckD9XkhJREV2bkvMhDhD8UoS9Ya4Vs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T29sY3NyOVhsR29WcmpoTElPSWtqSkRoeS9sZ3psNWZMQ1BjTVlraVRIa293?=
 =?utf-8?B?QUVkUk5ZTUNlTWNmMEZaSDlPeTRzWkxBWlNIUnROUnZUem03YmRtR04vUHEy?=
 =?utf-8?B?WnNDU2ZrcXc3Yk14bDNmR2FVWjJYSVhqcUkxeWxCY2g3emdEakJlOENrK1po?=
 =?utf-8?B?blJCelpWSC9sdS80aUVBSGErK0RqK2dJcDBLc2s0T0Z5cXM0WkpDSkdnVXNh?=
 =?utf-8?B?UHJITExMekNSbVZybTZOb1V1SVhTZnJ4MFdmN2padnRtY2JadksrbFJXQjc4?=
 =?utf-8?B?dmZhYXFFS1M4ZUtZWkhtOHI2TzhpWHBTd2l2MlhHYkFzNjRQMkUxeStRTG1M?=
 =?utf-8?B?ZHYyRm1JYldOQVhlOFNHRWw4Z2M3cGZpTjdHZWRpU2ZZWDNHcTBXelYrWkU0?=
 =?utf-8?B?ZU9IWGlLbnRCc0xha1EveXJ5elRLT28zN3VVMEd1YlZmTTgrZHNJUEJYT2U4?=
 =?utf-8?B?Yit4bVZiWi84dk9UeE5Xd2o1Zlg3ZkYvN2o1RVNFL2dOcDdPNkFEd1dqT3ph?=
 =?utf-8?B?NDhmNldzcFRSUTE3R0pPSjJLMmRPbnhqYlhKejBabTB4M2V1QktWTXZwZW82?=
 =?utf-8?B?NlpBZ2VON1lZakI3ei9GM254ZW81dlNrNHlac2xzM3pHb3JmcnBoMTJUV29W?=
 =?utf-8?B?OW9EVlBVSXZPakZtODl2TEVTOThKRVpwWWc1TzR6Q3lOM082d205eE91a2RF?=
 =?utf-8?B?T1hEdk1uY1FnTWMrVVhYOGJ5QkhQbmkyVkdvQ1ZmbkRNRHg5b0UwUTdOYjJR?=
 =?utf-8?B?NDQ2OFloYzAwRVJaUFM3WmRWWCtGUndvSFRZd0lKbGdHU0x1NkovcEpkQmkr?=
 =?utf-8?B?eFFmYy9ZUVZSTm5jQWNmTjMyQWtBdzZJa3V1Ymh2N0tCL1l6RVBYUDN1Umdz?=
 =?utf-8?B?Wnc4R21yL2FqUENFMXg5YklOUnM0dE9UZk1iRStqOXlpOTc3SndNU2dwZ29G?=
 =?utf-8?B?UUE5Q05FUmI5RGl5bmZYK3E0c3BZY2RVYmZ3akZzQ1RVSERsdG54YUNkS3ZC?=
 =?utf-8?B?eERpMlJzVDVKTGNXZUpPd1ZOZUhwamlla0NqeW1Kb3VHWThMYWpkZUxtaW9Y?=
 =?utf-8?B?a0tkNGVKQ2hvYXEveGRjNTY5NTBwcGlScy96SFErSUVzTDVnem9TVTZrelZt?=
 =?utf-8?B?VVAxcnQwd3IyMDl6RjZmWjNlVmVuSHFlZGhUUE8yTThPWTZnYXVpTTlGWGJM?=
 =?utf-8?B?Yytoa3Rwa1ZwejNtTDlUWlUvS2IyRFhnZ25VdW8waEx1MDVxM1hwVzJtOXhN?=
 =?utf-8?B?cFdreEFNUFd4RjJHT0puR3VvcVNLZDlnMlR4ZWMvODlFditSZStDMU5TWDRY?=
 =?utf-8?B?YWlxMjVWeTlmZEVtSFRMNXZPYitZUHpXSUJDRDlpT1piTUJsTitVL0xXWVAy?=
 =?utf-8?B?R1F1dE1vUmFVK1RqYlYwbVV0UEVhYVBIOEpFT3I5cEpic1VGYW5vMmNCdVJi?=
 =?utf-8?B?YUxaaUR4d1EyMWs4bGpGbTN0UG14c281QnVhY2VPVWphbTZVOUtROXBEWENn?=
 =?utf-8?B?a1UxclZyZmRGZEIxdGlPNVMxVkVKY3pha3hxekZHOE1uUVByNkh1aGVvblUr?=
 =?utf-8?B?aEVERGZMQWEvR09ONnU4N0NscEM1amdwRVpCSUhHckJMYkdqVVphRmxOOEJU?=
 =?utf-8?B?QjBnNGtFM05vbE1pMGtEdk1FK1VxdVBRMEdxTVNvRngrcG1lQnlyQVFDT0Iw?=
 =?utf-8?B?aGxkcWtERnc2aEltVFUwV1ZHQmp0dVgwL2pnWEFpRllZaDNTbnlrR2djcEFI?=
 =?utf-8?B?UzA4L0IxSmwyaVVod3pPUVFhSzdBbVdGMmxiRGxtWXUrMnZRYk8vejE3bitV?=
 =?utf-8?B?MGJtMHJzVkMwdng0azVQRFg3Z1dDa0hicStkWGZ5TC9TYXJ3YWpacWN6YlBt?=
 =?utf-8?B?UzNBcVJmQUdMTk80ejJsMmwrVW1VM2VmTUgvd3RORnIxYmpkNDhyK0hSeDdF?=
 =?utf-8?B?VFBtZ1BEdERiQ0Y5b21wUVRkYzdTU2p5VVFHQTJQcldhVVk5TUFxaUtmaFY0?=
 =?utf-8?B?dk9NaStSQTA1ZVFxdkw1T0RqZFNnTGx6SzQ3bk4veG94WVAyQTg0V2kwMzdy?=
 =?utf-8?B?cFBSNGdWeThaNzBTekdaZ2ZCMklRUnFOc2x5QXVtUTlWT0s4SXp6ZDl6cVYx?=
 =?utf-8?B?QzlMNHE4QmZaa1JkYnZEc3owcElnR1U1RnpncmtnU0dYMzhBZ0tqSXlwOHli?=
 =?utf-8?B?YTF6SnF4c0d3NXUvZnBzZWR2Y212elJ4VFN0QWduS0FHQ0ZDUVRrMlV5Y1dP?=
 =?utf-8?B?NjN0aDVrYjIycmFWYkZSMW9RbkVLeEEyZ1pWYkpNS3ljZGJxZHYyR1ppYWNB?=
 =?utf-8?B?Qk54YWkvYms4R2oyZ3FGVGxKdzh1b1R6a0VzMGVjaFl4OXF2OFIvQT09?=
X-Exchange-RoutingPolicyChecked:
	M6Mbs6Les9FQMudRQ7iU6hwHPO6rtw04tqEuvTxNV1g9Fys2uwRL4h7jVhQPoKwNynz9YmHUWjwJbx3mdJxCecN8VxNgxG2eFC+gu6tv4zHePdkr1dJz3dED2zJnn+Y3GgCTb3W8ocLJHkSHL6esT3UupvzyxxX/nov0zDTx/c+iI2CFLbrb/GVXW/dEA7+OW/kCqd6wxh33MyyZ5xuKAjRjQ8FsIHqeZZ8ZCLAnkdNMfDGzjR/Ux5xL4hBcF/QBJ6Q2zG9D2yhPEeFxpCidPNYqCJGMWx1nJXTx81x2ErxGWvkSLT7z0Uf16mmgck0r0x1DLVMuErS+Tn5OjpNefQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c75cf7-3331-4264-4a97-08df3e7b3670
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:05:02.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMhHg8IAIy0cuaXKtPfBFq5Ytodpmhss74QFTp7hz2qMiQK4ygnRjd/OZpuQ/Zza3CEKn1hOfShPyNBuxfmDhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB989665
X-Proofpoint-GUID: oqd1wHg8qXZ5FGCV1Eevg39osvNjlM73
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2MyBTYWx0ZWRfXzizK9FvT2c5b
 ZVXYeQ9pT5ahBsPecpjdFwuiinxteXFGuJ849mqKMYblyBQF8AUBU5amIrGiAssqKbb0lGFTcRc
 QbIEg62JJK4l7SaubPO4/WRqyBoESv0nycaT2fXt/5iyo0dJ7sUp
X-Proofpoint-ORIG-GUID: oqd1wHg8qXZ5FGCV1Eevg39osvNjlM73
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2MyBTYWx0ZWRfX8wvyFYjx/n1Z
 +HiigIaKSpuXYN3pLLwy9T9U2RA0sqBrOq8XOWSdEuk4P3qxvlKY4mbbzg5Y+1J5YL95Vf09JWU
 td/Ktpymo1odYR/hIw9Efb824TQEXZXrGNO89b2BhYO4xGOBdx334zvo9RPywUIMRV2odWQQATv
 2IAdH9aLcMjFbD0XVtw56hbWhOJ1cFJun321BdWEE2ylbozESxkrb+NdIFFyprdxto2/3W1JnEV
 IhjDsBAFi23jwYHJ054AwWFVA5PTHdcK1e/2FiEfR9Tm5+KhpG7KDpOYAUWK8y1Usn9ipQuUeI1
 ZE8n2lXApxEBC7i7R0mD8PeKzGDN7tS/VLu0NSTyFiSMXbqEao1JhDnAK6lbVgeniP3tAgckXAu
 Mq51XewdpmSwmrZHE2nUFmLFQqkWF7b09fZacmFD9LPoG2jkfTVjlZSuRmL7TfMKUGoCMUn0omG
 Ex1UPeSkwujh9sFf7hA==
X-Authority-Analysis: v=2.4 cv=D5bSufRj c=1 sm=1 tr=0 ts=6af1ef31 cx=c_pps
 a=5dagRegx5OoopB5Oy6OMtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=iHwBjlyiAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=GCxCbx31kmlJl7bIZM8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uNSKXYNwxGiU6LD0JREI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090063

On Mon, Nov 09, 2026 at 05:55:53PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The LTC2473 reports its differential conversion result as an unsigned
> 16-bit value spanning -VREF to +VREF. The IIO scale is consequently
> reported as 2 * VREF divided by 2^16.
> 
> IIO offsets are expressed in raw codes, but the driver currently returns
> -LTC2471_VREF, which is a millivolt value. This makes the processed
> reading incorrect: with a 1.25 V reference, the midpoint raw code is
> shifted by 1250 instead of 32768 codes.
> 
> Return the raw-code offset so that the midpoint maps to 0 mV and the
> endpoints map to -VREF and +VREF as intended. The single-ended LTC2471
> does not expose the offset attribute and is unaffected.
> 
> The supplied fix was reviewed and this commit message prepared with
> OpenCode AI assistance.
> 
> Fixes: 1d3eacbfa644 ("iio: Add LTC2471/LTC2473 driver")
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> Cc: stable@vger.kernel.org
> ---

Auch! LGTM

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ltc2471.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
> index 369af700969f..1c88c824d92d 100644
> --- a/drivers/iio/adc/ltc2471.c
> +++ b/drivers/iio/adc/ltc2471.c
> @@ -69,7 +69,7 @@ static int ltc2471_read_raw(struct iio_dev *indio_dev,
> 
>  	case IIO_CHAN_INFO_OFFSET:
>  		/* Only differential chip has this property */
> -		*val = -LTC2471_VREF;
> +		*val = -32768;
>  		return IIO_VAL_INT;
> 
>  	default:
> --
> 2.50.1
> 
