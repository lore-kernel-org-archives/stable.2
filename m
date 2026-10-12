Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98F48F02A;
	Mon, 12 Oct 2026 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815386; cv=fail; b=q0aUz8ZLCiHcWCHLv65UCY98LS1nxbpAAlmS1mYJ5rBCN8tELTfy/miov1O5gmjwPRBndkH/x2kruzJTT/GIKJdM4ZnpX99WwhTgUctAz5yHg7tYoMIPGzsCFpcxrZUBCsloTDiu/SDHyIbkY2QvcwbUJch98py4qUllLSc7hoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815386; c=relaxed/simple;
	bh=zboNFvGKfV1nw0nOXFbaEhDuyXYu9VGwegOMSfLb/nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i8G2xXB0v8UqStz1KiUv9t/AdwyglRdvPl/beI7woaRF2Fb3gFyMGt8b4rpoYyOrLaL7Lr6QyITAw8TGPzv1+PIFObW6ymc0juVwXurTGiWYGjeCr+2Hd8OfFzP+swdxBrcxhyavEpPtxzGelGU9ox9jYrrINjfWxVo8PsZW23A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=n1OnHihN; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GpkBjLtT; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="n1OnHihN";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GpkBjLtT"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CBvRYB2113038;
	Mon, 12 Oct 2026 10:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=f0aGRfbqSuPUwzzOUCyxAXorBY8l7ZGv8OGGLG8B2Ko=; b=n1OnHih
	N805XIv9/w2VEIGdk489Kg9yHoLyncwRhccTUuuhiwzhVpbFombSCsBCpiv5Eer9
	ow68Lm7ZvrZaXlSc5HdEY0wknoiWU3df46eUKn5p9Lfs+bHd++tc71oInSgWIXD7
	S71FuWLkwSJa+Y6+g8y21vqamge9XbNGMMA9eQIuDR0IDU+ghjZ5u99bQSzHka+f
	st2LkkCnBBba+n68vj2konMIpal9rQjmSRVY3PCYEgM3cYabJBMt61LtAe7H0+d8
	kb7+niJjhfjY0iRR6QY4i9Ld20Ky2kbTDBL9Ii923h5IhmiatJq1kCzF1Ax/cbnN
	6J0XAdWNbHGhw4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=f0aGR
	fbqSuPUwzzOUCyxAXorBY8l7ZGv8OGGLG8B2Ko=; b=GpkBjLtT1trJAC0b89dTh
	CPuiZiSdLGRSZqpzrz/L6PLUdu0hONaCCoF2usCX2c5FQP1lTWCjhEI9OpvfnUYo
	+rFNLgW+UzWwu5P9iAjkjoRiV/1OjcQGzuAxnXnA8+yjjT87RLsAlqkMrmpv3x6B
	iJ4G3t1ZBTNe70cW7h55B+5C2mia32PDBbnoYYhpfHGxkaWu06l9MW13ar1ro0Fy
	qfNQa+nXJraJqXdGM0vbCkACF5LuBKOUjYltUjRvzksbDl/k4QequFg6A9ilrsni
	3+Ion4I/Yy5w7RqdAh5ukeeIalLwfnatUekonNf8JMfUwhBwuWJm9FpYuesKe7vD
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h8pecb5wr-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:29:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceH5C+iFbGmhdFW8qT2o7b54OEjLS/+ecHDtat1rKPsMPnMeSZKxB9mjw8SRrJ/dKhPCEodslOb+k9kIZiWwXS/jvMrNqKuQ9sbExgN22EgdIz49FV7xi/Y2VsWVvVI+RN5xdF5qiQhG3V2FeaXNWCNAu/00tI/+S1gZQS+6/cP44u28N+q2PFr8kaYyVuvILueyzU/kDvyoDK7HK9BF9tmayVjIAkM9U6dFbMQlA9haE8QuiNnIAvKCjBSL7+Oa0G6pjB8oY88uiGQOaLlny1mAJZmQgTDVUDLyJ051jOsb+ugWpw4heMRsGW81dbjrVZR56e7mCt0p8yGMuB5IuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0aGRfbqSuPUwzzOUCyxAXorBY8l7ZGv8OGGLG8B2Ko=;
 b=VxXRHAdaL7AFPvodMiqHqySzDMQvpZ0DnrJjc/wKyBoiO2DY2YSsUgwVTqxZshxhGc5sEGPvzsLeehSI9wrn2ZOOPmz919hpkHzwE76rwKoMa8REw1DstdmATka5ynLfHb4j4eJi9wK+EpeAhovtnzWGJ4i1QOF699VrRTz0xoZXMhgsYrPCWgQ/nbtwL7S6oDh3HnYlvDBX6HjiUp7ONejn5o3MwxnE0HcMcdeHnPPwu2zl2AgQequu10i5GbzVg3eLOOAF02sRIzB+rr8DIbARa/R8K2E87WS1y0XwWO1kPtaF5itKM0zE4ZSXhrb8MJ3+CLdzpejElBQ3XAxoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB6925.namprd03.prod.outlook.com (2603:10b6:a03:41a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 14:29:32 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 14:29:32 +0000
Date: Mon, 12 Oct 2026 15:30:50 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: BouziguesAlexis@johndeere.com
Cc: Jonathan Cameron <jic23@kernel.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Lothar Rubusch <l.rubusch@gmail.com>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl313: add missing buffer selections in
 Kconfig
Message-ID: <aszu6m0hclBWzPEv@nsa>
References: <20261006-fix-adxl313-buffer-deps-review-v1-1-386006c407be@JohnDeere.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006-fix-adxl313-buffer-deps-review-v1-1-386006c407be@JohnDeere.com>
X-ClientProxiedBy: MA3P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b323ee0-c644-4dd0-383e-08df286d39b3
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 9BGpZPMAUYrdOvQTni7QTF+S5O2W1K3qv+btffjIlv3mW9XMlgZEFxPrspkW2aG94gxNRHyQjT3hhbpj0I7u7MMMagAY6IxMbScfK+q6RA77nVJxx89wVeEYQnZxaSZ0fxJZ83gd81Drh0Dzp3x7aiuSUu7WfnNm5OaQVovHfW9aWiLO8SFU7kchvYbP7R/8JPv0m26JksXVoTrzGQM8gJMfgBkTUmcdMQrQBwMUHdS/R4bHpNfgul0oeWGTSUl58KEr7SQJYgHQb1HdeqYlUCR2yp/lUqT/UTEUwyhAdMvSBRgkuqEX0opdesq6kG35jXXnpA2TUNlOmRUMpSePeWF3vppbEY56wa7Om594xxqhPiONwvJtVZrgtGN28OM4W6dVgoNFC90LfJ+jXxZifFRU7UFaMyHR1HZ8rsrIuGs9Ts3DbJ2Bf2W8pVTaMvkD2pOowdx+uIRtyzket9gYXAid7na/VQbd0wHwfUJJBUfSnlOlFdGyopRsNHiP0NEX5UVmhaO7+OTf+XiQzCTkB2+i18FglP6kB646t5uwMsrQEWA062R7Q7tLwGS1edyL/HjbpO71BlEvYZoBFuA3qkNolVWnXYvRJYta8M4lx6/i3zJ4Va0zinnFBdPyEX1sAmXPQuB0yoLjr0I6nR8oezPb2NSCPbgxznLlYZQ2DpE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Qk5mNDlWOWU0dDFuUy9iSVRtUXlPK1VBdzkwWWhWQWsxeW5HOXROZGh5c1Ji?=
 =?utf-8?B?MlU0VzlFaStnTlF6amZ4T2liZUt2UzdTTVY1T3huWG1ST00vWnQrenZKMUFM?=
 =?utf-8?B?aWYzcG5oaG1MR1RvbWx5YUtBY0trTDM1V3haKzVxOENjdUorcHdrZzllYjBx?=
 =?utf-8?B?UXlDSjE2ckc1TmpaWHcxUnh1S2JpQUcvU2FCNmVDWUpzcW9NV2VyaDlTY24w?=
 =?utf-8?B?eXBTeW15Z2RZRFZ1K1JUN2RENzF3OEhzMTk4MDNMd2FDdnVYZUJxcjJ4S1E0?=
 =?utf-8?B?Y0ZUYW9rNGVPK3ByWWRxeXB5ZHdBMzRpbmttUnZ2aElkZFp0VDk5TmxQRG1j?=
 =?utf-8?B?Z05IRGdFbGVVc3FiWXFBMFIwV2lQclJTbGN6MnN2Z1FjTyswbTdtUXFjNWtY?=
 =?utf-8?B?MXRLZjBOMnZZOHlLK3MwTUhxU1BaanYvKzRRQXE0ejltMHBIUllJVVNrcllh?=
 =?utf-8?B?cmdIZTZFSktuOG9ZU3Q0a2p0L2FjM3JLck0xNWMvQ1Q5WWdEMGJUTGlsaDBY?=
 =?utf-8?B?aFRuN1FtZjNZaVBWMWx3N2d4bmFXRGIzcWQzaWNTR2xhbktyR1pTMDZDNmk5?=
 =?utf-8?B?TzhYWVZVR3BPQTVPRWg2ay93V0NmN3NlWmNvR2l2MHMwMjhnL0IxRkIyVWI3?=
 =?utf-8?B?S1ZFZGZDT3lDdWFld2VNUlllUjMvbHlDMWU5UGJnYk5QWXp2RkhQOHFkNGZ6?=
 =?utf-8?B?clAyL2JCMi9oUXFrNGRlS3BDbHhmV2lQZm91djhjNWZjRHg4dU5CVkNSdnhi?=
 =?utf-8?B?eGtTUzhiRHdsajlKMzBLSEZrUm56SzVFR1BlVXFxMHRuSThaMnl0TCtZRFBz?=
 =?utf-8?B?THg0LzY2YWR6dUNWOTZQTDd2eG5GVGh4cm0zK2VhdEtMZmZPdXVWVkluSVda?=
 =?utf-8?B?dk44M1l1K0ppb1hwWnVITXV2UVNNSDc0aU42d1hRNmVucVllZ0lzS2FwK1JC?=
 =?utf-8?B?bzBnako2TW1TTGowSEJiVDBvRFM2UVI3aWNpaE9wVkpzQVhCVlpwdCtlNVdX?=
 =?utf-8?B?MFhjVG16UHNscHZtSWdZZTV3NGxBWWV0V3h3clp3WmdYbHVnSG12Y1VUVWVH?=
 =?utf-8?B?R2VRL1lpNW1uazJsVXdZaklXZHVBaW16d0NwcFpCVWpGT3pMYm8xVGQ5T2xW?=
 =?utf-8?B?WXJ2V1J6ZFhJU3pkOUNWUUVHdG00dUtnLy9NTCtuSStaZGxybUg2dWRvSjhM?=
 =?utf-8?B?QzZjWEJsL2VUVVZZUWE4THovK0RXVGQ2bDFTVDQrRk9IMit1UTJhQi9xUWIy?=
 =?utf-8?B?NE1xRmZwQS9ubGZIMXFjZUpPUmtZTlA2TGxRVzFGRytNK3lrQklhZG1UTGF1?=
 =?utf-8?B?SUlidXVFc2E1eWRGTkdCSWlBRmVXU1hYd2tPMGNIbENTcmQ5L1dFVnFQMVlG?=
 =?utf-8?B?WlBPZ0hZV0RKQURVbjVoV1dRZVNGUHVHUVZsc2hKdHQyTUlkcWxVUU40UVVO?=
 =?utf-8?B?WXoxRjJteTQ0eFZuYzdHaEpYZ003bTNTREllTnh3Nk5Xazc0MnBxb1k4WFFY?=
 =?utf-8?B?OG8ycnlEVSs4YkRwdERYaUh6TXZPUlR4cmRrMXVZcGlEd3E3N08xZE5NNjdm?=
 =?utf-8?B?cFRrZHpWWS9YQ05CcWw2YnFOT2hKc0I4bVVTVWIvVkpERHEwdG9mdXhJM1F3?=
 =?utf-8?B?NnhFd0hTVTc3S3JCVElJRHpIRy9TUzhma3c2WTBYa0U1MEYxcTdQemh3TVho?=
 =?utf-8?B?VWRPbThZSlhUMGROQk01YkFFYWtjcGgwOURZYWwwVC93OXBscUdkWCtwbmcz?=
 =?utf-8?B?QnNhNjNSZE5IOEQyTzdGaElVaTBrN2wvOFN6b3dNMHoxNzlrVnBvSjFNN0dk?=
 =?utf-8?B?ejVYVFNyekhxYU44YkpTeEhZVm82aGJCWFFQdFZTWjZPSHFyVUhuMmFQVC9t?=
 =?utf-8?B?ejU5U0pET0c5bnFKSG1DWVZVUTZzU0Z6RVhXUEo4ZXl1eWwxZlNkVmhxcC9D?=
 =?utf-8?B?ZUJ2ZUI1ZFRCVG04SlFXWVB4MXFSVUtOUnpmcUYyTnhTVmNFd1hQbzc0Slpw?=
 =?utf-8?B?Rml6dWNCSThZNzNNVVR4Q1I3VXJwcllUQjhNUzNyanRsOUF5MFVEdnlvQk4x?=
 =?utf-8?B?djFpOFArcG0vL2ZLbVkwbWRIOXhPcTRpNE9SNk94SlVsRktRY0UwN3pjb3VM?=
 =?utf-8?B?eWdSbjlWdXNVY3dKM3RyYlpqeWVDMVY1UzJTa0dPSDlueDVkWHRRNlBEUXNu?=
 =?utf-8?B?MEFDbmhLMXc3eWVNMzNxYzVWd2JzemlmRDREM3g2c2lvNGRMSVBXSGY5M3d6?=
 =?utf-8?B?THZGbVQ0dVQ3U0FsTmJSSlZrNytNN0UvOFJRbHd2QWx5cG02MDhoSUw2OWVF?=
 =?utf-8?B?RldWZVZyczlOczhKMXdlemxmNEo3eEMxZzB1RDFmaVozaE9WMTA4QT09?=
X-Exchange-RoutingPolicyChecked:
	csvsuyxYQOat332lK62MQvuJzKe0idxUA2rRmNCAJpdhZy8V6r87EMo59e4h9pszn3hgGUIVXTyhGKD80med1HGHfPgDgHYLez5hh/z/vkmg+10o34tgHZlu27nl88ialQd67XaM8skusqaOteB15CXOaXr2X4Ev7QsV612bkXNpleNwM0hWNVVX0qgMareEh+vJfk/H2w4Az9jQH9bBXBhU3s04uzgheL2b8EVK4Z96HBoRVbs915kZd+ZdnqHyWK8P46IfgFj0uTXJRKKjPvymQxdD0jYQeM+OnAbqDEltVacEUwie/BjMlH7NGjLy+FQR7cneX5959H0LcXnXRA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b323ee0-c644-4dd0-383e-08df286d39b3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:29:32.2083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdnkdJzGgSSz/ufhaW0fChqIDt8OCfmehT5863kR3VdF/yBEBcGtY00axg79dT+PcnMaTAhIyuMZV+MvPkztsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6925
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NyBTYWx0ZWRfXyK/mIcMS9N+5
 mFuBuMA8h/PGqVxNmRd0A2k+CeLI9YPxnmOKrGLu3fC78uSYdY3g2imjcmb5DwX5iiCIzWxKvX0
 8+9SD9LFvU+kZO+0R6i2wG7bnRHsGUvo58MF18sUb66AXYccQlO0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NyBTYWx0ZWRfX6XsW17C5+KBz
 Q+Gq1jFeSjqG5KFl3Y4r3o33eeGYvqSFRA4CikNuFy+h+4PeFZY5y/fu2+Be8qEzmo88xyRbVHg
 ibQ1IdgmDwGY0EWZNZspISClAeaAsoSaMDlPRgzUgUf93jf+gRADHpUvEnXjsKonvNX+fGyZr8C
 KZXBXf//OSA5wy7gcqjTT3L5YWIF0m/pMnP7UDl8Fisn3DSoGhLxtyCTLmQky7VZRkRsMzFE2Uc
 VKzmzq4fzaGHHB5xZkR5vjjZdOeA48SrCtCWPA/Gh5iIX9u1EhT6VpHFIl//fR0nkiXXhMX1JA0
 1y1aTKxWUW82PqKStnSREK6+SdK2XV3gKjzUz/GnOvzXWVtUDBH29H+hMn6+9kTynqAFjKRlxZd
 GHRsERIIt3ve5lmelQF5ORT91fZnCpY8wRJRtrLY4bq1Qzg5Ez6NJCqKo9YawPQX4Zz+7T/Gb3w
 osGfSSIh25R+pI7kM3w==
X-Authority-Analysis: v=2.4 cv=AMeVrcbb c=1 sm=1 tr=0 ts=6acceed3 cx=c_pps
 a=KwaHDfl+Bay0OUlNjUYd7g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=ehHYDeGzAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=aCBP4o_1Wk44LsfSh-0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=EDCrmqdYm2XzMwRyd5GK:22
X-Proofpoint-GUID: EWVKbQzhH-0xWuoeIsqaGyBMnK5CpHcq
X-Proofpoint-ORIG-GUID: EWVKbQzhH-0xWuoeIsqaGyBMnK5CpHcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120057

On Tue, Oct 06, 2026 at 07:08:58PM -0500, Alexis Bouzigues via B4 Relay wrote:
> From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> 
> The FIFO support added to the ADXL313 core uses
> devm_iio_kfifo_buffer_setup() and iio_push_to_buffers(), but its Kconfig
> entry does not select the required buffer support. Enabling either
> frontend without IIO_BUFFER or IIO_KFIFO_BUF causes undefined references
> to devm_iio_kfifo_buffer_setup_ext() and iio_push_to_buffers().
> 
> Select IIO_BUFFER and IIO_KFIFO_BUF from the shared ADXL313 core symbol
> so both the I2C and SPI frontends have the required dependencies.
> 
> Fixes: ff8093fa6ba4 ("iio: accel: adxl313: add buffered FIFO watermark with interrupt handling")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> ---
> Add the buffer selections required by the ADXL313 FIFO support.
> The shared core symbol covers both I2C and SPI frontends.
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/accel/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 4094299e2ed8..7b5c1ce66e95 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -32,6 +32,8 @@ config ADIS16209
>  
>  config ADXL313
>  	tristate
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
>  
>  config ADXL313_I2C
>  	tristate "Analog Devices ADXL313 3-Axis Digital Accelerometer I2C Driver"
> 
> ---
> base-commit: 69f80fef3153299d9c72c53d1d71eef6354b6926
> change-id: 20261006-fix-adxl313-buffer-deps-review-73bb575e1e39
> 
> Best regards,
> -- 
> Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> 
> 
