Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795468453;
	b=Kt0tEuDE7H1Rvhh4bP9oOC2Goc2+K+MRaeA3M9+GS0sug58BYoJxmmLCMvjc6EGiXF0K
	 Yakn+eVi2avzO10uc+8m+9F/io9U8S+CU5XwgEcLDohiqmIFKyhJf4QZn2Nz9JKaL+tim
	 qZwgrzP54CzN8bARAZTQTfqFv62XU0Us564eMtLvx7lt4ll+zixyemMVS9zFs8fUP8UAI
	 4u4/U1YTsNe/TSaXV8tuzlaN4k0nZnxMwCOF6DDHGjWJyetzvkP/wBpnv/wr1sKQn4ja2
	 JulNKgo/ZnJdxD7ZJuQGvTSypU96wyalp/V1p+nhPIq9uF4YUeUMKsKzi3jlhS0q/TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468453;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NK6h5CauMMO0RH10Sq34hpwSXRgpG2BRmUaid+rHfak=;
	b=OFvvjWu1XyxtGl6VDyipbtv0irlfJP8QZq7u9UkSPgfLg/Qs7uKg+MkKpiouErI59kBn
	 ABDEtv+bOLC1WW0+JbClEtZpcEoXlCjqEDouisjyMHyh3jcSbwb7flfbyimZ+PlhdNJZ4
	 ipqOceFdnDASCu9fuWTbwaijziGAjopBKGcHcZ/Ygjx/glnODZ6WigOX/dsa0PgDRCaqv
	 bW0q8Jd92kCnRjCLr9lpHjYmvYiEbQdOWZDq/FzbYv4hKxxDbOCF/+rEKwMVpKltufNJL
	 4PYHpZGzyUq2IiPYiqq6UQC6I5vR/qv6LIxnXypPqjDq97nGD3NirjiFj80slbtl9Hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=E7pWLSAI;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="oQup/ApI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41515606A31E;
	Mon, 23 Nov 2026 21:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41515606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=E7pWLSAI;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=oQup/ApI
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6ANJuCX7543593;
	Mon, 23 Nov 2026 15:13:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=NK6h5CauMMO0RH10Sq34hpwSXRgpG2BRmUaid+rHf
	ak=; b=E7pWLSAI2Kl0jXGntDSVAVWGN3ToRpMT2Qc97ZYB4N/6+gnkfRIhhhXgu
	7ABVTZZke32n2eN0bs16C6pIyzko+gjFHc/aOiWuctpXH6WRNi4qias9PXQ9MFZ9
	OwKpHHLPLvUrFzzj8e9kne0aOpBcA0f0g9Z92LR8nDViQ7zgxGyJJicQyP2NPjmM
	G6EdTRRAcyIyjL4Fhv21YE/6jguZt3xcVJOU8CzCE90Sy/4OgIdyTMQTJA2K5Xlx
	i9xRbHtG/vNHUPfmRn/+T5ClT0TFKsbm4iqOan92irlMQ9kRZwwzu52neJ20BjMo
	mYUaOtV8P+2cB9FXbkgrs45slKjTw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	by m0384305.ppops.net (PPS) with ESMTPS id 4j3x4sgr45-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 15:13:47 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpozXULXdD/12ECr60eMe3+ujdQhvvv0sBLblt0pWjwu4rQM9ELOMHU+nalXylMkSA8J9DUt5ZzLoWxHNgKwF7rBZFANPvnWWlSGenijxFXM4yyRauB5VBYJoNLjEd9likvMBL+06PpnL7kh/y0rhkjh4jhh4N0KnqoNLO/eMtZPv4PsHhJRJQ4rUuD5/dU2OuIC9aXU+rjjGZ7cCTvtvTBses1cLrED0mYdK4rjDTJDjOpbulsghtsliL1a3YBJJNm/bTKlh+gS2lWYen1ssS6EZKRA9H8Q2zl/RAF5Qj+pF6MBgp84fp4p9dYqXGwIKfYc0XMbVfgbnk6KbLlMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK6h5CauMMO0RH10Sq34hpwSXRgpG2BRmUaid+rHfak=;
 b=QFy7GvQTgLMRBx3owQ6vAiS/DLkGaW+dVNBgNojI3ASvrfzx0vMfufNvkRHKsEmyXbnCp+WCVvEfHNSQUguyNPAjhKKxacJC3Mlh2+QPuM/VDuO4SjB/J3Bay5MqDLhfyuMRESabTFtkr+aXTHFXbShtm7n/XnjzW+cjjucvw4UWuk7hcsKPkMsRsI9LrJb3KMTa8rq7YQIheN2oBZmPHq0evGl94ifzgiYLFmOdYjRU7rCzcy1YNWjVYJbAVLQYbYaW+tHa8sDKjHP3CUAF+i9rpj4PF6d66Fjwak+XqQYxl/SpHDEMrYia151okSXMM6rP8+vGjSx2rPz8phK4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NK6h5CauMMO0RH10Sq34hpwSXRgpG2BRmUaid+rHfak=;
 b=oQup/ApIGF2VfrBLWrA/mfo1dlAfAHN06hfwIWJ5saLNvnCzGwW1X4uVPKw6mjtQFirn0bvRqYaOQWys4c3RdBca2szVDBmlWtj+Q4q8SqGPHciCWwXyK4BfH/vkR3PvDwsbvxbSVQXhLcEnA0M/hid04TO6smu+b7U7WHArvD0=
Received: from CH2PR02CA0022.namprd02.prod.outlook.com (2603:10b6:610:4e::32)
 by CYYPR10MB7626.namprd10.prod.outlook.com (2603:10b6:930:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 21:13:37 +0000
Received: from CH1PEPF0005BD5B.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::90) by CH2PR02CA0022.outlook.office365.com
 (2603:10b6:610:4e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 21:13:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0005BD5B.mail.protection.outlook.com (10.167.244.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 21:13:36 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 15:12:47 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 15:12:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 15:12:47 -0600
Received: from [10.249.33.32] ([10.249.33.32])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ANLCkti3430474;
	Mon, 23 Nov 2026 15:12:46 -0600
Message-ID: <7788ac2a-1931-48bd-a775-61c818ffa03b@ti.com>
Date: Mon, 23 Nov 2026 15:12:46 -0600
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
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: Lee Jones <lee@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20261123075320.379664-1-lee@kernel.org>
 <20261123075320.379664-5-lee@kernel.org>
 <f9218622-c265-4302-997c-e60985201de6@ti.com> <awSFqWsxExNtTyjf@monoceros>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <awSFqWsxExNtTyjf@monoceros>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0005BD5B:EE_|CYYPR10MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b5dacd-6f9e-4b55-3a84-08df49a6a340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|18002099003|22082099003|6133799003|7136999003|56012099006|261021121427099003|261026121527099003|261028144727099003|261026140227099003|261022105027099003|4143699003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	KhU+whoD1s5JFalTf0Zq6D/ekXhXi7Yb4ZO8cyTLvo13k8HiHyS55jw/ciXwLCILJytRHQTEQvZt8WDWSqfvPvEY/hcmhBaNtGwujnZLzCikNwO+UoaCgLgyU53OHt3GPR5v66oiOHT5ZmSKmlUJA6LbYZyuQxXxnk0l6GwfZ9VmAv4F9fP65SIKNvc9iwyGVm8JvwoShcOtz0d5KWjBhPS/o4aggrFSpFtf1wDwal1osgjJ9sviqVCS8D9aG1POrfUNef7YNUvU+RuCa//7/h0UvbqbJOGe92Zk4KPwTAgvc0YkVd12FPR5Aq3DujOU/WJPUg+srrf7d7KSvvUG7nCzvSP2I9ggxSVpV6q0V6zkDUMiBdau1q4OwMJG3CdjqVCbcjOVycBSTSkddgSLUrwzZniMFFamayMa/1EPuFGh3wpOJlWsI54mlPwtgI3bggjAUWMpG7kSaJe86L3w9lGl7WnfUXTRq5tTep7ghqfBnELegrIJDSEyPganQlcafHGJP51jADg3oemD6EK0vvjqMamYscNEhg/m0Xr/RUS4K5FhF0KeKKvVnIsyd6hBkctJ9PU1KBG5VzkcLWQ31aErOJgIgq3NiYDFh56HGpwgS3vFBCukAWbdUkBGtcw9lV0HC8mG+Nhf+1Hf3g24SXXqs9Eg/9I1P7QnYMIWhYfHNotdJHceoLypkdlN5AuGLfic8DGo5Xt7SL/IRXTdgQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(18002099003)(22082099003)(6133799003)(7136999003)(56012099006)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(261022105027099003)(4143699003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yZA+zP06NWgiWifWWy6l1nf+RxRdfVOnF2n3BnPWruAy6tsGXpJRRHAyu5GZf9zcX7tBmjwDsf190DpdlFRrMtNbBQolys0MAwoId8PmF13zGduCoF0Gqzu+DOd3gPgBlt78s/ViCxOSO6Z48u6n/Ox3cCi6Sf02SAy40ELzDeUlEF9phBVc/sK/ay8P7VtH+VrVysJ1bfoQuPU5EWzRfMkIOZwLAURfqWK79c9RBDV2j9pS+lXwEuQw+MSjxANxhP6ZwZGiusA9VmEdiBc+W80OVqDVBBFDYWVqtrTZCtS9jnkjeH3plm6KEJn1cf0+rOjKXFxHwJZzj0lb5RGuECG5gmUgZkFKs6YRQ8YLBctI8vGcFU5UueJ/tc7qAV8FDkj2Or8DAN0gHvDqA12+/LLZzXC+9uWvrpSNpkmF+4bqtG3MwCVfMninVeAIebH+
X-Exchange-RoutingPolicyChecked:
	OcQiqONIxN+eUaXf2att+27Sb4M2Kd0/pCNPl2crYZK8W+9gAwOLy/jfBtZIk9lNGT7WP+5SdatCJWln1Ih7Whez6ENMurbQ/nYvETciRKyf6oEXz/e5rBKuSkKg9bdv3gd0moH61w0oAHuEZBYq4tNyY4mbNy410rL7xdkAo3Lwccr7mnwkvKPTy/cxRAufuOs2k03Z4PomsorS41P0I/n2LUUYUCWd3211dYz7zCOF0giWZDxNzMPM0bk6GhwS50APJE5IztMJgCJhiZXgc6CYxJm2U9KPHYp+uSwpzEoSWbEU9GWfHcUqAS2GA98PILAbh/7OxEanWNFb3ZbQPg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 21:13:36.1126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b5dacd-6f9e-4b55-3a84-08df49a6a340
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0005BD5B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7626
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4NCBTYWx0ZWRfX+rr7p3vnIBga
 jfCU9ByaBvMMWTl22MZxylRQt43xaZwgKGTjUILXfD9fIPCeY45+Tuv9ue6Ln3bdcUldOBKIGPi
 qoJ5ZEdGKAipnfD0BXF9PGJNdFliOak=
X-Proofpoint-GUID: -Su1gOmRzlqzJfbOex1c4GxLgmpUVAyX
X-Authority-Analysis: v=2.4 cv=d8pgWhjE c=1 sm=1 tr=0 ts=6b04ac8b cx=c_pps
 a=k/S6D1Pxv1bk3xTbD0KMJg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=suTJkOW39ddT22jHOPoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -Su1gOmRzlqzJfbOex1c4GxLgmpUVAyX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4NCBTYWx0ZWRfXwt+hOeP1P2ko
 dtFg/AH6VhlTG48cIFj7zVvPXNlL3Y0Ky+Zx3t+wsWBHf+p8gPpIL93//p2vkapv+uhQZTUFGBW
 ehX70koLmFoqtJQ1gEUnu4y62ebQxn054wnHmRmbrTBnA2vR5TUpITD56/sC1YoNvZ1JPrLssmy
 qGLUgxEU521Z6sM+OjnPDfvX6JQlP08cSFpIVP3F66ujoKFaq7vSjoNfbpb891CtfdLSJ/QTs+v
 jEyZKv1QsiEHnN/1JVdNRAAWBHWIwD/h+tg1/9Fgik4SonUXP+X6P4fbxCSVQ4Et8cYILD38L7i
 LpZ+XqhJBH9sEqRMCbRS4e7+EvC9l4jNpo35DM8bgyXjpCWmz1cezjNabce1N1yeEqRV8hTSyfK
 dh33yQJdVMe/PIKDOTgwkbNNhf63vbjsFUm4vHIm/ip2FSUYmTAdm2HQpKMtJuJDvUN6ItU4C3Y
 lfCGISo5X5YnlJyFatA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230084

On 11/23/26 2:43 PM, Uwe Kleine-König wrote:
> [Fixed Thierry's email address, I suspect two of the three @ti addresses
> also don't work, but I don't know a better one for those.]
> 

All 3 of the @ti addresses are gone, dropping them (all other than me).

> Hello,
> 
> On Mon, Nov 23, 2026 at 11:49:27AM -0600, Andrew Davis wrote:
>> On 11/23/26 1:52 AM, Lee Jones wrote:
>>> ehrpwm_pwm_probe() calls pwmchip_add() before setting driver data and
>>> enabling runtime PM.  Because pwmchip_add() immediately exposes the PWM
>>> channels to consumers while runtime PM is still disabled on the
>>> initially RPM_SUSPENDED device, a consumer invoking ehrpwm_pwm_apply()
>>> before pm_runtime_enable() runs causes guard(pm_runtime_active) to fail
>>> with -EACCES without resuming the device and accesses unclocked MMIO
>>> registers.
>>>
>>> Set driver data and enable runtime PM before calling pwmchip_add(),
>>> disable runtime PM on the error path, and disable runtime PM before
>>> unpreparing tbclk in ehrpwm_pwm_remove() to match.
>>
>> To match what?
> 
> To match reverse probe order. Pretty common and IMHO the description is
> good enough.
> 
>> The core of this change is moving pwmchip_add() after
>> pm_runtime_enable(), but in remove you switch clk and PM unwinding,
>> not pwm and PM unwinding. Both changes here are correct, but the
>> second is not explained in the commit message.
> 
> The commit log says about remove "disable runtime PM before unpreparing
> tbclk" that pretty well mentions switch clk and PM unwinding?!
> 

But that order was wrong before, and fixing that is unrelated to
the rest of this patch (which is clearly about enabling PM before
registering PWM). It is just mentioned in passing, basically "BTW
fix this unrelated issue while here". Which is fine, just pointing
out this could have been two patches for better logical splitting.

>> Would be better to have a patch before this one that switches clk_prepare(),
>> pm_runtime_enable(), and pwmchip_add() over to their DEVM equivalents. That
>> fixes the remove order issue, and removes the remove() function too.
>> Then this patch can simply move the pwmchip_add to after PM enable without
>> any other actions.
> 
> For me the patch is fine, if someone invests the effort to convert to
> devm_* that can be done on top of this change.
> 

Fair enough, I'll switch it over after this goes in.

Reviewed-by: Andrew Davis <afd@ti.com>


> Best regards
> Uwe

