Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB3388E6F;
	Tue, 13 Oct 2026 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881969; cv=fail; b=HMQnJWu30lz5z/s0sQKqPXIMxvtvPXQiN+K6qYFjv0M14+ISNeMChVwEvBrc0dqN3RQiLtgO65tVRd0uukjjEExIqtEzoOnWHZfCrZbcn+c7vLFc4TxE9X1tfiibLiP+9A20wAczg+2BlHNYbNN0Bh31OjujD5lls/981yFp2aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881969; c=relaxed/simple;
	bh=iGtpLAbrUNrGhXagXk28a1xuWI5iXY0lvS1gQ1jEP+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WoX5lQOvyAH7VXVE4bgJXfUUiNTknyt0kZpwsUTAExsugVRJaxQk4pKEqux3OpaTDaCdZjbmjef1Ye08+fKoCUswyzvqGrjkzKrFWJFWlRhFDckc6YO15UP/lz4NxvWU6C7CXynroAAqEaiIKUt83533ES50gvPypWsbYSkoOFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=jQWDqg9n; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lKA0jsD2; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="jQWDqg9n";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lKA0jsD2"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8GBrm3253056;
	Tue, 13 Oct 2026 04:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=oIDkfrCpPnDLu+Y5njnnGj7ROIwLb48lJXrqeZ+77mI=; b=jQWDqg9
	ncHMMHz/WX+ZrZmTzKnkq6d1DS3C5tLC4uUikuNLBlOrgyDBXEBb8BMbaWCNAkjn
	/WMbKZBkBjlseoa2Wp2bO+0oTya05pSSCZvwuo3ANZfRG/YJ0CSF3kAfAtGEmVvU
	uO+yK3U6oFeQ0B2tbq2MADQaH/oUJzQcY2194pgEYaLT4gWKvgbv1PouXrnYtb6K
	zka91wAm3XfHXEQRsKxC93ma1nctcWvjQP7P+vgxsAnOgU24eXCks2YrqyFuT7aP
	pE4bivhaKZdgz68ymEwzwnK74Rrymll6es5FPyJg+Cp5WJBTAELTOG58Y7636YwD
	wp1JsNhhGjPi2UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oIDkf
	rCpPnDLu+Y5njnnGj7ROIwLb48lJXrqeZ+77mI=; b=lKA0jsD2GjZZse+90FpDV
	dHlyY8M0cu4R6iPaVuuHhp636FzpwN3DJySxTjZWKbEKvdZ0M0YGHKS9Ys37DoFB
	tTsXtizWC/z43vINmWeUNkYPUf9nrykInqi2FlfHGu24quvcB0pRx2olMi+JnnlP
	Qmb4Lzu59Ua966EwQ8asVJcJSNHjfzU+kGTlJdvcNLfO/8uFzwtCLCshb8x5G0VS
	+PtivmC/UVoH3go14SMEutiFKc2Ypp/QmJ16oOj26N3SwuEQF+y0cAJFCoGPSlT1
	I+tjQk02p0v4Ts39TcZS4qkt3yNdp1uSbvbgXZ3X6R18jEgD06Zy6v064+UVXz//
	A==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012014.outbound.protection.outlook.com [40.107.200.14])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h90v5dbcj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 04:59:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6y6f2pUDPa6eRcbAj+dLz6bHJni9nDwvdrx3iDKauc4CSJ3Jrfa0d8tVTsTkYJhBqvyEkRP4ZAmaMDO1+sHplSiUE3IKDx7KqAm+y/rt8GPswzOjGAKBbLx4/w3+Z8tXL7U//OO2rh2OxrVQ1Ye0JjiSVQi+CJGJPy9bAQvONzjNKtQKs8t73FLU/dMrjHebfJFKI1nXUyA1L5ONJA7sswL0t61q36e2eKtCwIJ2NQGjy82fg7Z6jvjbZbvUtDBbmz0o6zILP8+W1nHb96cDyCInN25C5nwlYHK0nJWR1uV9+4HrrLgH0BySI0d+cjKPlNqRt77JMl6W9K7TOJ/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIDkfrCpPnDLu+Y5njnnGj7ROIwLb48lJXrqeZ+77mI=;
 b=txDXE6F0j3gYC4h7cpGkBQws0OV/D2IMg3l/P7IdptBRBi/KN8rvbqr68oV2niblS4VOg9TCtC7qv8T74mXtlCAb/LoOVE5a9GWyiMXJNnCW8jJaKjL+areGzeo73GzTBPFl/4xRbRsppbyC0J2x5CNDY1H617S/821TZcb7rZPFsoE5t2tddKLlnz0bRcNMDLvii8zGj1uGbfhccSBzt5RsNmMq3VaMoVw13T2TmekzDpm4SaKZAzsm+zx/5QPGBHldTSnUZ5HO5MGHVaG92dNjDzG+xMf/5qyUfztNcTcSEdX1eE/bCLvWYUBHVY4FXYAEzpQmN6HtofLDlmkBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by CH0PR03MB5955.namprd03.prod.outlook.com (2603:10b6:610:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:59:20 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%3]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 08:59:20 +0000
Date: Tue, 13 Oct 2026 10:00:35 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: BouziguesAlexis@johndeere.com
Cc: Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Lothar Rubusch <l.rubusch@gmail.com>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl345: select IIO_BUFFER and IIO_KFIFO_BUF
Message-ID: <as3zHnUUTcpJl9Zi@nsa>
References: <20261007-fix-adxl345-buffer-deps-review-v1-1-0c94c8d0443a@JohnDeere.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261007-fix-adxl345-buffer-deps-review-v1-1-0c94c8d0443a@JohnDeere.com>
X-ClientProxiedBy: MA3P292CA0003.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::20) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|CH0PR03MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b1f6ce-1720-40d7-bf8d-08df290844bc
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009223027099003|5023799004|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 HP0IAwJOWcxtfTJihATQmqb0e/Q4ZWj4A/elX2+q5BtzmWmRVz1JYeCZNTtNo907VtZ/kZ+3U2hNz/pxfLvieh9XPq5Motm8xPXn56rU/4Wqqi5NI2ScHkh2jqJcNeqjyaxnJ0qXepRKrmrhixLM6+mzEVDMKZfLA3+DQejh9S4+YSnIBXYRUGGdqfm8IuPPKYA49BkONcikn1RCHp6AqrIEfOOEf0AqKDax3+DVSM9w2cWdTeUMzpDEMUH4tx1/Ct8R9vIIO4mqcvTZR3FJLmjm/oqr5WFLtcO9S3On+p24OMu5pZzor+SqlOF+9zUPttkENrPAcu9dMWYPhSU+jrT/puMTuPPtP/yV37X1GZXdG1VnSCYN/UPLnLOWyAv5ovs8SDYgI9Px0EYp+6S5QQGYp2itaqLLBexnSZjo5s8UCyvZTtaUUMseVN6hfQgD9n/kFxzthak1H7NQngASjZ4VwBDq5wlXW5yKgLeTRJWtK8VUKnrPOItsuh/RjxxR1ROmvXJCZN8JgU1+SmHQ0+uO9WssQoNe0evmMxiT269UK9G8sDRzB0HMza6x6YN0mA1mO2uAZX638jjK5g18gxEXGQQkq4VMgEWHSK3zgLo/G98+8l6/gAzciA4F/tkgEHyFV2Vq+MBeKSoO8t5jGAqiNkXnRzU+iC0zSbdkw3o=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009223027099003)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a0c4d2VrZEY3TGJQQlV6RGZRdmFVbGtSUXJwT2I4SEhWRS9nbzZkUzFzZXd6?=
 =?utf-8?B?dHVRbjRYVk1VYlpnQ2hMaWdMNWlDWUhqb0ZuWEh4NFIrTHluZFo1d2hIOFZu?=
 =?utf-8?B?MmlBbDE0ajkvTHlRV0pCSjJxRlpmeE5jL25jRzBNbFJiSUJwVWdSZE00OXkw?=
 =?utf-8?B?OExDOXRhWGpJa00ycjJDOTM0WVhEaW9YTkpHUUVKZ2ZrUFBvemVDTS9GMUJ3?=
 =?utf-8?B?OUg1UDdxS1lkY2VnZW1Eb0xtdFlxdnFlR2lkS1RGbVNWQ05tN1JHeTRrYUI1?=
 =?utf-8?B?aVVxaXZESDhIa0tLNi9JczBlWWs1ejlmR091dEEzVE9FQmc5K0tVTXNQUWFv?=
 =?utf-8?B?YW1UYWtJZDFZUkpmaWwwM2ZISEkyajJ3ZmcyZGhmazRBZWZzamtIc3UrRXdH?=
 =?utf-8?B?dDRQQUhncDU2dWFMQVB5d3V2TXFHdTZBdnJNaElGVDRyVHdiYzloZDVES2NT?=
 =?utf-8?B?VzdHWGptVjNWMWdqMUlJcWxxckE1ZWpyM0Q4b29pcFZJZDhrYm1nY1lPdEto?=
 =?utf-8?B?eVR1cjc0dnhnb3h3ajBaT1lzN3RlL3FFT2laTEc2K1BCNEh0b1JOQmtuMXhF?=
 =?utf-8?B?aXFMVmludVkxcFduNVpPYlZUL2RtUkxjbThOTDE2VU5aUUYrOUc1RGd3czlG?=
 =?utf-8?B?dkc4V0Z3K1grVmJTS1hnMTVYSW1HSjdwdUpkdUtzSGlhcHR3MitiejJDSFpm?=
 =?utf-8?B?Mnlzc2lzeFVBSDRNcGl5V1ZadE54WmlKLzJuem5tUlNPL0dFMUxPM2x6R2RD?=
 =?utf-8?B?aWZsdHFPb3MvYlRLcEhzK3pyRUtNUTRqY2tnUFlscThjVnN0UUVQWjZ1bCs4?=
 =?utf-8?B?cHpSR29VeHBqUHQ3UmdIS0g0aTR1ZklXNmZsZWVYTzVHVlI1WGlHWml0V2NL?=
 =?utf-8?B?OUtyNjlpNk1PYTcyOVpkT0o5dkRTSmJDUDRqTlMvMWlBcFg3VU55SGNWN2lV?=
 =?utf-8?B?NGFNUHJ1RkFCUWRFVUtheG1ESHBONzFOeStpcUpZUVJYcTBiVWRmUG9vOXpp?=
 =?utf-8?B?aEF4bDVXbWR6VjlPSG5LSThSemx5em5qaTdoQ0Iwazg5WXVyZ09UZ1BVbXp6?=
 =?utf-8?B?WEJWRXFXMXp2c0VUeDZvMjBpUlZaZnpUNWVsZGNjcWVHVkV5WHpsclViZGh0?=
 =?utf-8?B?ZGxXN3VzOHQvSFhUdmcxS3JJcGpRZFBjbVdFZCtYUm0xSitIdUxkb2htV2ds?=
 =?utf-8?B?U096VmQwdU5lekJ0SlRYNWsvd2piUXVTRE11SDVQV0YwWllLVDdYU2NDa1hY?=
 =?utf-8?B?T0NObWNYM29IVzVubUlCRVd4QXV0ZGgwSEk5NVFkY2p4SUtLZXBiT0VsNWM2?=
 =?utf-8?B?QWcvZkdFcXpxQ3JUeW1yRnY5UEZodUc0OUtubzN3b3NTdW5zZy8raWt2SXdn?=
 =?utf-8?B?UEJMV0w2VUpyUm1sZk8xSkpuZzVQTFIyNnc0Q3N3dnN6UnpCYW9YVlBQTk81?=
 =?utf-8?B?bElOTkZkcDdvUVdwcjlQckNmMnpLUnlBN3doY3Y5YmN5WnI3Y0ZSbDY5S1F6?=
 =?utf-8?B?WTVIQkFvRWpwRDZZSERyM1p0QlUwSzBnaFlFbks0R2p2V0Qvc0tTSUZMbXEx?=
 =?utf-8?B?YU0wMzl2ZnpCTWRwRS80NkpTMUtubG4xU0pHdXlLNVZwc2djNkI3ZkhrcVJt?=
 =?utf-8?B?R1orSXpPdEJTdUJBMDFGNFEyN2NETnFwUlNyb0NQYWZxeTRkYVBnVU9NeVFF?=
 =?utf-8?B?ZVNvTjJGc0YrRjJadG5ncjF1WHFFWUMvSGpYOG8wVXNRNFNqa2VPUCtuRjJ6?=
 =?utf-8?B?bDdBSFhwRmFaWDkwSEI5SzZTejFpa0RLQVF2aTBPT1B6QkwwUVZZZERKa1Aw?=
 =?utf-8?B?NW1rOFZTamY3MmtNNjNpclRhbnErWlBCNlo0dnFOZVQxUXNHTFFBQmordWpS?=
 =?utf-8?B?SVNlQk84U0p2R0xYVGU5UFZoNDFkRm9paTZOQ2V6Yk1wMENOVXJIZXlsNnJu?=
 =?utf-8?B?eFoyMERmZllNa0w4WFhBTEVxVEh3a1NhS2svaUdoVWo1TXphQkFzU2YrOTAz?=
 =?utf-8?B?RkhRY2ZWeWhJUy9jKzU0OHhzVlhlcVNiZWNRaG1nT0RVanp0OHdOWFRuQit2?=
 =?utf-8?B?cVdQemxNUjkzek9PZDBsWVcyWFdPUitCbTVHcWovMUNWemlSR0pqU204bHRM?=
 =?utf-8?B?a2d6WEhUNDMxNWlGNlZ2c1RUVkRVVXhWRTYzVzdkUEFGaDd1RlR1ODNwVVpu?=
 =?utf-8?B?OEtMMS9LZ3lNbUlNdEFUSUd0QzNKRkNaZmtJTzQyTktZR0ZtQmJKdU9jNDNO?=
 =?utf-8?B?bis2MXltOWxtL3Axako1SVcxanVYWlVlaWwvN0diRUU3Q1p3clNvYmFRUHlD?=
 =?utf-8?B?N3VKRTl3QTQ5QlVjZjVkM25wczd0NHV3SWsxbWd6LytvSVlJejVTdz09?=
X-Exchange-RoutingPolicyChecked:
	pVtdXYDPU5zA+R+wD7JcMQGzFZ4sxlzYxxYfhh9nZcrB7viYdyTveeHTh4GkQ8RerEYzSBwz+YijDkGOo4moTkrRR22qtpWinJCgehSNTEufBVyI2rGBu6XNY453Gej/d4rDHwXqa00ETYVJ1zuIBzXZoOmt94pwLb22sox3AqJK+ArFDHQLZGLBn5JUalrCUREBRVfCRprof252WDCsyET4BybNkIGJ2DjqItIeVSJ918hgyLGMiNUSyqAhmjlCSXK+QQA593IQ5AVIqXRlVbM3L0TyIvJUsVbpNLZ6EChiN4aZAN43PX4dn/bQrUQ8HPtBN7ZkYwLPHOAicZRkpA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b1f6ce-1720-40d7-bf8d-08df290844bc
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:59:20.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5kiaAa8E6rxteyNO6vc1IbiUl3NBEC0pUfCF+qTNoyieb/wrdUF5SfMRW+GNT6jq9JPor3s8TKRp1WDKb+wrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5955
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfX/6pSbVC1JmEz
 OKUZPmbwSrtSmyNQ8a1SxkgNsTrYiMdV1IceegnakUUSdxZIfqkeNQbC1cAWon5IAQyZE8pxJ9R
 bXCzmtwLxzfIfuTSPQRJaHPVYhNyE4B8RoA0KE8qWgsm8M8beuTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfXyUSPMDIfrT8K
 Nvp4ap5l/CPZE6x3Li42sqVWE5Sbl+brwI6tNakLCYLZfpwEGs7Pj5wY2kbBlplcG33G6bSLyfN
 uCG42a0wgjhif0X5jI7lzqc/xnmIV8kTOWtT+QQKRqkMp6reCElE4sGYepEtvxE0LhrnChYAjfl
 KjclS0CCLZEINdnlwJyaJ4W6yx8B7TJMiun+LONq6Fv4oSaCMyyx1TPobLYYCmdtDNQzB1+lOHo
 nyGdTj9za/TowqnGm3raKG4nRw2ioRLWTynOMdtF62FDAW8LvPucLhTO6ENGdSoNmNJrAIhmsGV
 rqkJEP+3hg1WhilUYZ3qwYnGFSIWrEl+p0wuxD1Hg2rVeJnUy8rc4PCWLJFx4AeXgYGM39s7TpP
 TYjl7XaQf9JjYbGM+cmOabKwu/c3d9HqADEam5tY9c8fEAVxm1ZHF5yadKShsXnYwf9A3wn2Q6l
 V0MTVYNhPTbqH/Z6Fig==
X-Proofpoint-ORIG-GUID: -YWUdtmMf_KbwFJcSWCpIPVmty6-N2_V
X-Authority-Analysis: v=2.4 cv=Cfedd7rl c=1 sm=1 tr=0 ts=6acdf2eb cx=c_pps
 a=3EeCZaq8L1ZepF5DamB/SA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=ehHYDeGzAAAA:8 a=gAnH3GRIAAAA:8 a=7TP5CO67l59hWiJzu_8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=EDCrmqdYm2XzMwRyd5GK:22
X-Proofpoint-GUID: -YWUdtmMf_KbwFJcSWCpIPVmty6-N2_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130035

On Wed, Oct 07, 2026 at 09:34:16AM -0500, Alexis Bouzigues via B4 Relay wrote:
> From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> 
> Since the addition of FIFO watermark support, adxl345_core.c calls
> devm_iio_kfifo_buffer_setup() and iio_push_to_buffers(), but the
> ADXL345 Kconfig entry does not select IIO_BUFFER and IIO_KFIFO_BUF.
> Building with CONFIG_ADXL345_I2C=y and CONFIG_IIO_BUFFER=n fails to
> link:
> 
>   ld: drivers/iio/accel/adxl345_core.o: in function `adxl345_irq_handler':
>   adxl345_core.c:(.text+0x145c): undefined reference to `iio_push_to_buffers'
>   ld: drivers/iio/accel/adxl345_core.o: in function `adxl345_core_probe':
>   adxl345_core.c:(.text+0x1db6): undefined reference to `devm_iio_kfifo_buffer_setup_ext'
> 
> Add the missing selects on the hidden ADXL345 core symbol, as done for
> ADXL367, ADXL372 and ADXL380, so both the I2C and SPI front-ends are
> covered.
> 
> Fixes: cf04212d1fe7 ("iio: accel: adxl345: add FIFO with watermark events")
> Assisted-by: LLM
> Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> ---
> Add the buffer selections required by the ADXL345 FIFO support.
> The shared core symbol covers both I2C and SPI frontends.
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/accel/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 4094299e2ed8..fc130854af71 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -61,6 +61,8 @@ config ADXL313_SPI
>  
>  config ADXL345
>  	tristate
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
>  
>  config ADXL345_I2C
>  	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer I2C Driver"
> 
> ---
> base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
> change-id: 20261007-fix-adxl345-buffer-deps-review-69a214e05dca
> 
> Best regards,
> -- 
> Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> 
> 
