Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456242;
	b=hHxVaCkbeqBa9tJOUPAobyMBItTWsq2u0n51+nBnOO18tMldpYWGPiIh3gokNXdNbQQf
	 QpEKbpyIUb7zA1aohB6N6fkXUG9JiOQRIaWmo8xOUGtp9GDR1SNYwJ9lNmnN9sSMbbVX3
	 /i0RKtLAIhTlhewZD+Q+12NOjWP8+a3uGXdkcHuH4dpk8wQsLpa2LHrNI3gPb8446L75x
	 8JpU6FzzMMt4USwsq/srlDF7qETnMODi5Yqbtjms6z38xft6X2ZcUUlnRzN2AmM5cx4GE
	 pZ34HVetanRnZ/coj14g25SoDYPyrDvBPBDiBHr/DeXAPDkVxIwHQFlBJrRXDBzrSgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456242;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/tN+sKAKQM+OhoHvmlBayP6ZsWDErWK9W1MJPSOPoEU=;
	b=qWNOwE1LqCibJ7PxnuIgJoVXTn2bmuaUpAEnwCcYeky0BE76lkyonR50CqAqHP6t3m/u
	 /ITgsDbeBRlcnwOSsyzG9F2cK/+dgkiFdwhKImNzeW/CaTnnnYsNKy1WkyNRxuQi28E8i
	 VWMDEHrz5/m/a3XVEyjtD+cuDm6rKMOhm1I8yrObFTT6gZzMhbkmplGLedkOESSLQbStt
	 ADkBf9PIdaSm1kISZQuOWAoyWIUMEoTpCxzijntmq/V4fEDXQu0B9e1T0XDkkfNxwFm88
	 vlIcYzk3WJYwQbU4Joh5/76cLfP/9iQDZjblYTh0yCDJh4tMIjNxCM/2mFKaHOt82uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QMvNM3GR;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=IgV424vn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B8A606A334;
	Mon, 23 Nov 2026 17:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50B8A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QMvNM3GR;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=IgV424vn
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6ANGHn6Y4078761;
	Mon, 23 Nov 2026 11:50:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/tN+sKAKQM+OhoHvmlBayP6ZsWDErWK9W1MJPSOPo
	EU=; b=QMvNM3GR1kV3iRL/m4FsNuxvxI/qIQjTfMm4VgSjGk7e91aqHzaGf+7as
	gLQXgL0Vy4q2rK/fed1ZUvUMFNY4mNHL+IbO3Jiv4CSWz+PeM4UhOKJbSrwi5Vuq
	PwFYc8mGUKW7o5BAFUBaSnKP6EMO+2Xm7OHcum/Xv22C429qsUHUGeMBU/4hSdy4
	4MUMYLEfkcPtFU/G01VtLtiFkOwTCgRDCAnaBnFVkU78nahxFNkA7EtX03Scrzvt
	zCKSi17F2dkI6wJvRLbmoLnVAlCpnUo4OI7DtwvnubYHIO6hXkHs/JgHgF+z+Fmv
	9U1uPJo4BqngZ+7trhMEaCHlfUn4Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	by m0380145.ppops.net (PPS) with ESMTPS id 4j3w6t7sve-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 11:50:25 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjEkka0nKbGpD4qx4tjO8JyV8NQgePH9Uc8UzaNNaYHzvOoooWvK5d67+N/CjaU9ZcKuahB5ozLpODXA9A88YxlGirObFm+uCINvjpUU7ZDgWSHunAXznrHOs7TeDpC6aASO4E8sAZv4a+jdRBRpr1aHETFQU63jnRbCRj8y72+xEXrfYg2mUqulz2XVVnRfhBqyIzEyH3+iDSOTQQwJn+z2miHUnZDleckTsUbQoPbOnajvzCRfmy0uLMVul9Pd8/a40OnLJdnWUYKsoE0W5DKEkefhr4d8s2sKkdDO6iFfxFKZ2mMZYJwUfkCRyQULSBnzqFh8+MgwMyRzOb2SbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tN+sKAKQM+OhoHvmlBayP6ZsWDErWK9W1MJPSOPoEU=;
 b=cZ9suJ8W+5hAfZn6trA0x+puZHubngR4IWNx94Y9KQIEXl+V4g4/qCE5rN81EfUFlvPaeQEl7O4cJJ5cuZ5hFPRvs8Cl+WOv+LyraQgOuCu3WCYFfoU4EcWsQmhzHtXfjp2kIVmw+18hgI4DifzKlwYo/ky8FQA5kyandLpgT++s+7d8ZNyyxM0aGi9M61RSrZ9nee20QweoPO9Pbpijig2foqmtgNUNUai8+8x2gH07wjiAzAzO9HXjiIDDoOZdfzdfWrWoJbVC0hYEX8jTduIi0Ef7sUSZiTK5+V1uiHLTfjnvgp4RFN8Z3UmzIgfARNk0Eh/Ng1cy2jbO2HiLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tN+sKAKQM+OhoHvmlBayP6ZsWDErWK9W1MJPSOPoEU=;
 b=IgV424vn6ncOFyJNhXqVQmN727yIwyugVryT02h+sdfCis5WUBe0noARYMYbJ74OuLQnW+8rGCfLpPvmPYKryoHdF9bVh5VBzitWq+aGv8TwL5KJ6xsJjeuHQHbInXFeZZwIZTNSBish7VQ7Utvg+TKqsRKatdV3OlqhWgatS4I=
Received: from CH2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:610:55::30)
 by LV3PR10MB8059.namprd10.prod.outlook.com (2603:10b6:408:290::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 17:50:21 +0000
Received: from BN7PEPF000000A7.namprd05.prod.outlook.com
 (2603:10b6:610:55:cafe::b) by CH2PR18CA0050.outlook.office365.com
 (2603:10b6:610:55::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 17:50:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN7PEPF000000A7.mail.protection.outlook.com (10.167.245.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 17:50:19 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 11:49:28 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 11:49:28 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 11:49:28 -0600
Received: from [10.249.33.32] ([10.249.33.32])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ANHnSKe3149786;
	Mon, 23 Nov 2026 11:49:28 -0600
Message-ID: <f9218622-c265-4302-997c-e60985201de6@ti.com>
Date: Mon, 23 Nov 2026 11:49:27 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] pwm: tiehrpwm: Enable runtime PM before
 registering PWM chip
To: Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>,
        Gokul Praveen <g-praveen@ti.com>,
        "Philip, Avinash"
	<avinashphilip@ti.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Vaibhav Bedia <vaibhav.bedia@ti.com>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20261123075320.379664-1-lee@kernel.org>
 <20261123075320.379664-5-lee@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20261123075320.379664-5-lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A7:EE_|LV3PR10MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: c732f84c-84cb-49c6-f35d-08df498a3d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|5023799004|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003|261009223327099003|261009221227099003|261009221727099003|6133799003|261009220027099003|7136999003;
X-Microsoft-Antispam-Message-Info:
	0nG/uXTSvlwdG7rW6PqOvRK3Ltdm44ypRDEpvAGF48pMu1xd2gI1f+Q+dzSas0DIWKQM8JhD/wsHs/IRn5QJeNWe/JHUVu/ghjJZ2lMuZysSf3FMX88BIjc7CAc9j4W/6tIyBX2IkiwkXqjjCEXOZSPXEl/JjIJZjKxzHyMuyRUThN7ud9Buu178+d1L8J7eEoc4CUL932PMmoQoTAbo1lS0CQZxlxzIx/7gkNRCPYQbdFRWA7jdRR58yneREDWUAyFN9hQD7RZirL4l79XNlzgL0ZQ1zBUWEELb85BDv4ybt6SR3stTFF1c1isNmB6bgaqHxHirfGCy9mLesoSV+QDjDIWhw1aXxjsVcRC6d14USxY3GBvmCkpijigsuApqXp0S5+umn+bseAtP03bR6HvmkuUWvn96Z8J2oT4LnDSRVbEJ2ZOiGqfSS2BxRGxMZDsCGbjSwQb4Fj89xdFs8ltTkhnQKT3a2PwoptMv6iwFIW7BGfvQYQuunHYiP6fMylKY2/vjTJY4sIuLxbkTT5uxlLfovvYCxc7/v7j41gMftMPjrZp9Vqc/Mo0v+PvcNVBehUFSs6fcP2cE7IZe8aJ6dLdvSDkmEdygjEMJ0G9eZpa74KKPknA2kmfoj/fFLjnDObC7CtvxaCMZDQH1xQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(5023799004)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003)(6133799003)(261009220027099003)(7136999003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bD95trsHFNhp1EwIY0SmtTmqQVisem+Q2mYYtR3Rpcqy/K45pUNnGYYlrCn+whRSU3D9iLzeg0muxR9wi/AwbdlVUo2BTt2WR0TxYLXo9uU2fjWqt/tAN2Z9iGB6Asd/f8ZOOU2W3Z4zLweRYJo96K2yeYY5HiVlLyeYpQ5Dr+z6lcmveFOIaFhYibi1C0PTlLfarTk4vY/PNg72MmJIvel4FQmC+eFKfye9rIQztM64H7cwfmCL/3FwwRRm6zII5GJ8tX/VqDjVkk3tssGljkNjF3bSvM8McSERAAaVEiRT+TVhw+W7faPb3HDe28JhyHoKXZBDhk7CvF7M0/30tbBzAuOfvnZsV2pbfo0sdEbbb4WRRAQ3b3cIY9oCq4McAPJW3gW6QuLwcGhRhzkwPPrcYYz+YG0SlJdoiyt7EF3HOokmhk2k8QKrgPxKC40T
X-Exchange-RoutingPolicyChecked:
	dDQ9NywjZWGvZpVAANJuWEOK5GG8evPzuoDqCrpgsUkNdcrTIFhi6k0iF8thT4xW4SZBZ+MMxB2bUpWJrR4JVCm7erYYpI0ZTgfhdxy829EwAtuQryG35pXcHGfJ2QCuOulJd1M24siWxMuAZfmsXLAlkWOC7IjZCHnofMC59mGf1N31tXjIUepU3Re2ZniTF/mLfYgi6ky5hf/D+9oUZnIH5rdNzb2jNgEUq1pTUf2gehX2DIfkERjSBwmD1y7zXMi0bzD4+Yj5Ta0Kjj0IBj2JQe2OKf0L5lu7EZ3oM72OxmHb8894Xz5eB5DOjOdoXa9JPdosg/PPK9CY+NG82Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:50:19.5815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c732f84c-84cb-49c6-f35d-08df498a3d8f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX5EI9GXu5jwLZ
 p9e7gkShkxAfccwEYQCruxMOPhh7Xo5AU1lThx1ueaQxqTzQFmW/G3TtY6f9hIoTB4LzL7YFeqB
 QAjmBRe/yMAjQaoEhhSLWJe/VJI6plQ+QMc4MDOHdKmsJ8syIK6B3dbNtD0zvEwqvKxmbemGTXS
 DlGdt+Z50V36Er16jx/SMuwhWGX44IMrwnGBUgyzqsDdYcmk3MwdsuMiMnmLuinWD6oHAsMQCoH
 iHDucIbjxnmmnQSMcwLTp6GURzPyTSgbKa3r7Y9jaksYHq/GnPjXcgR+4MbbBlI/AvhPZc6UpOI
 aXht3ucGfEiE+Jex0txkuOI72TfFmF3+eBI1gKFHRHl5xUAyf1t+cejd/dfcvGyoiEv2kKtiMQI
 Pnt6zBZGikKh/fOQDURZW8AQrKLq3RYf95XZ6hoFTBZoaFTfQ+Qlm04UVMPocbOd5vHfYlHEvIY
 TK8n9GgCiN4lcmeRtUA==
X-Authority-Analysis: v=2.4 cv=N5K8hG9B c=1 sm=1 tr=0 ts=6b047ce1 cx=c_pps
 a=fgNoY2FrYBgJmLE9YDNrYg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8
 a=wEVF7ITnQ8Y20ABcVNIA:9 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: T-wlDGGr08Q4uBt8iu0nEz4lOcWdViBS
X-Proofpoint-GUID: T-wlDGGr08Q4uBt8iu0nEz4lOcWdViBS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfXyujQYN9MIwEq
 9nWhDOlXe16LNIu1xf3otQSdFWq07ltMEltohP9Y79Yt7hj+AuNhgDIvksDKxeLSPjJaBKvcNfa
 pRFRSgB4FnP9uHQkFgPURWqAUjAS2uo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230071

On 11/23/26 1:52 AM, Lee Jones wrote:
> ehrpwm_pwm_probe() calls pwmchip_add() before setting driver data and
> enabling runtime PM.  Because pwmchip_add() immediately exposes the PWM
> channels to consumers while runtime PM is still disabled on the
> initially RPM_SUSPENDED device, a consumer invoking ehrpwm_pwm_apply()
> before pm_runtime_enable() runs causes guard(pm_runtime_active) to fail
> with -EACCES without resuming the device and accesses unclocked MMIO
> registers.
> 
> Set driver data and enable runtime PM before calling pwmchip_add(),
> disable runtime PM on the error path, and disable runtime PM before
> unpreparing tbclk in ehrpwm_pwm_remove() to match.
> 

To match what? The core of this change is moving pwmchip_add() after
pm_runtime_enable(), but in remove you switch clk and PM unwinding,
not pwm and PM unwinding. Both changes here are correct, but the
second is not explained in the commit message.

Would be better to have a patch before this one that switches clk_prepare(),
pm_runtime_enable(), and pwmchip_add() over to their DEVM equivalents. That
fixes the remove order issue, and removes the remove() function too.
Then this patch can simply move the pwmchip_add to after PM enable without
any other actions.

Andrew

> Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
> Closes: https://sashiko.dev/#/bug/linux-28b36a80-e4a9-4bb6-97bc-7ca02895570a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> 
> v1 => v2:
>   - Clarify runtime PM state prior to pm_runtime_enable() in the commit
>     description (Uwe)
>   - Disable runtime PM before unpreparing tbclk in ehrpwm_pwm_remove() to
>     match probe ordering (Uwe)
> 
>   drivers/pwm/pwm-tiehrpwm.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index e3407d0a1f7f..73fe2f91243d 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -461,18 +461,19 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = pwmchip_add(chip);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> -		goto err_clk_unprepare;
> -	}
> -
>   	platform_set_drvdata(pdev, chip);
>   	pm_runtime_enable(&pdev->dev);
>   
> +	ret = pwmchip_add(chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> +		goto err_pm_disable;
> +	}
> +
>   	return 0;
>   
> -err_clk_unprepare:
> +err_pm_disable:
> +	pm_runtime_disable(&pdev->dev);
>   	clk_unprepare(pc->tbclk);
>   
>   	return ret;
> @@ -485,9 +486,9 @@ static void ehrpwm_pwm_remove(struct platform_device *pdev)
>   
>   	pwmchip_remove(chip);
>   
> -	clk_unprepare(pc->tbclk);
> -
>   	pm_runtime_disable(&pdev->dev);
> +
> +	clk_unprepare(pc->tbclk);
>   }
>   
>   static void ehrpwm_pwm_save_context(struct pwm_chip *chip)

