Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793821599;
	b=InzAIcjI1cROTry3FgCpUpAAnlr1Tx1o6SzWfkZqLLz33R4F75oVvUBypYsb1Z8SWjRA
	 ZTzgB3vqLBFbtbAyJoh9sZabCx8B0WFoKm0oX1QAOM3sH/+lYOhF+BkQwEH6Ge6VT+Adp
	 MiYVZa8nJZN0yEYWYIu6etRJj9w2R1gFFn1lxLHU/mbd5KPxjO3bAb8MazvXg5c2myW2V
	 +j76Om9DqyOxlYXM2teneLpRfiQOKahpcMtP5SWORdN69AUKRlmjgJqIrHyffLH2fS8eD
	 pRW5BFCF3Vx2hcPf+wX57o2B4X95Q2Re7UDLDZfFy9szvy66oovr/5VYhog5tSZa/SA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821599;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/WWQHCZaHPFPnAYagE9soyDJ5OW0uGwgRuV+lO+tPH4=;
	b=PRlT1QgrcG2r4DeRbmDsW/CsF5Vjm1RPcfCnBcSPxZLFe0t5tHC6tzUyanVEx6OC+1mC
	 RGpZI/8WfKD9RLzrICkjnM5+BAoDl/mByVFPFn7iFnMDBjmYymdEjFXwYHm5i8oiyL8zI
	 a5hWyeUSFSH3S1YBedxuU9PGYTa3iCh00iiNTzsGCm5sKmiQHPPUcrEd1cthDqk8H0iDg
	 GtW/bYFKpds5+VAYeVDspRSl6ilj6Ws4fgRVdIqZ/v353k7Md/JKnVRfgcnQ2CoJWr5o0
	 C4YGMVQz1sI3FRQqiuEyC3EDh64r1zCYYSv5E4guB0BHQvDdg4WCDBTtZxFLYyMgngw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=pjtb06XO;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NinrpVzl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9F608C9A1;
	Wed,  4 Nov 2026 19:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D9F608C9A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=pjtb06XO;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NinrpVzl
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A4JaNA9574819;
	Wed, 4 Nov 2026 13:46:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/WWQHCZaHPFPnAYagE9soyDJ5OW0uGwgRuV+lO+tP
	H4=; b=pjtb06XOWiRWAtyZst4u0LlTaFt6BcD1O03mh+ToyXaEEUv/6MxkVAlrH
	fx6DhTqqEjO9LydcWV3gJrRwrmJpW4UbpBKxdcKaNT2e3e/2BLEVtnRlen1qk8mA
	nd0O5KbG3mExNpas89gFAkw0LCC0YvRGbLq0pf9uKBem7AYIpPETAEIV/5vciE9j
	s8rthaofi9ij49OEaXG9mB9s8km+rrZWByRryw+6WOfUpGiCD4O/LOXt0uk8kP4r
	uzZi9o6F5Z+MpbMFOCaQFSMtR7hUCCkN/KSFopNhYamRljM543qHna1rVIXMIqFK
	U2QJnsr4nU5PqDVAUPF0oQQTGzYOQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hr252bhbg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 13:46:29 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC+DfdiOmo9UZ/et40+Lg1vkuZf3hqBvvfOHLeKVlv8gOS6HQxdFVAuETAFxLh8DPGHivhU/o87eqnnf5GTqe76XAzsR72+UrIjWsVM0lgy0D3+XkU1gKV5YhyzeKkdjBMQK+CeQ/jaswalRmnAWJ7CHk6eR4BUumnw9ZsNTWKeRgpuNgqIb0oOyj9PABn9EDyl7bI2sJWDXhukbRDc6cgppHl3UvR2h2odbEaMFCyt/sEHIU74ATnGc3MWcWMF+rqbVcUPahOjmv8tunQMpPtHjj/Om3F9wUVOdKGaIMkF7KQCesx8QLwyyF+aw7GxseukDjxngUlNvlZuv666WQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WWQHCZaHPFPnAYagE9soyDJ5OW0uGwgRuV+lO+tPH4=;
 b=ga/67eirCRJyc+yWZfcO+M9ydvgqNEiNr0C7z2ck+VKW1m28xMM7MJQWR6hjN2czqRDfre+y6uyg8FMxz6UwKSD9AnF+gR3E1GZGyCK5HbkGaH4Ew7Ures8a05FI+fHyWYv2avswtKvJCc6PqHAyiUibsgzkBCgIHV6wKj1VylW9mi+C9Dfy7lBib9NPRDbgIBrrqq7r4RpnLxgxlfRVZXTwkR5liARiLixz5AWXxZZnMuHEz2Xf1F7Re8M9KkB6aIHVt12vdKt0cj+kjnjiqRWqRhrd64ORm32nWCVFBrUAO0K/CgkfBpSPedHpW6w63cAaJB8uYx6rKu65aAVc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WWQHCZaHPFPnAYagE9soyDJ5OW0uGwgRuV+lO+tPH4=;
 b=NinrpVzlbl2BYOY5FJ7X7EL1x3IQnlLpEZFzxgxqMkJg5PeWxWcWp5zYSOBYSmDRHS+2+qQKyfYC8JpJQpj+PYBHG2qViP0d3GH+1gejP8LOXL4+i40EWltwoCspi55OtwNLOWXG15TWm91zJB1XgnA6R42q5e+h0N2xa4hXRjw=
Received: from SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30)
 by IA0PR10MB7603.namprd10.prod.outlook.com (2603:10b6:208:485::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 19:46:25 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::9b) by SJ0PR03CA0025.outlook.office365.com
 (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 19:46:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 19:46:24 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 13:46:09 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 13:46:09 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 4 Nov 2026 13:46:09 -0600
Received: from [10.249.32.147] ([10.249.32.147])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A4Jk9qh1814934;
	Wed, 4 Nov 2026 13:46:09 -0600
Message-ID: <b5c2784f-0b0b-4bce-b032-ceadacac38e9@ti.com>
Date: Wed, 4 Nov 2026 13:46:08 -0600
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
Subject: Re: [PATCH v3 1/2] leds: tca6507: Fix use-after-free on unbind
To: Lee Jones <lee@kernel.org>, Danish Khateeb <danishkhateeb03@gmail.com>
CC: Pavel Machek <pavel@kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261028174348.64014-1-danishkhateeb03@gmail.com>
 <20261028174348.64014-2-danishkhateeb03@gmail.com>
 <179370065155.793788.12273630752864277064@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <179370065155.793788.12273630752864277064@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|IA0PR10MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 12de3b58-8079-46b1-0d17-08df3aac4f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|4143699003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	v/ybLOJrNdsfzGJTDJIeOKMwcaQ/e9vHiAGJt7Mc9c3vRG0Si14KJVLiZC9twzsUpNvvQh37/LtvVDKhJx1OIFWbLOPdev3mki8udWneJvS74sbO66IDmTeG4f+uMfrf6Tq/mduUtP5ZWespRfbMJl23tHLZ8AKQ767oCdFN0AgHJ2ziwKvxr8UiYyzl4ND2z3QQvhSWhu3fxkhzimYAckbGqGj7W5sZN2uxQgfsvtdyvukCDEjhS3OQlr6ilKGkd8+8AQwzFwUL3kn/iyJd/WEX/+SuoUE+ru9ejk3IIImnYQopeH5sxJ+LrPKeT8xZBg5jjxudPhdjVxnRNxPWEowrbhZ8ybmDLHQ6ri1hYTmmJS0xFdGCbjj2ehhiMap4esxz4+xAAH5rZxxJ6yHCedLoVPpw43s2qG8HN/ndJ/HzRfuR1oG2cktvGYa0u3BIkCgBbZcrgApb99hdt2seTcGlBtM/WYVBcNINgARA1DtMr1ft8D8IJOS7iNHSJSQjHaWn81jszxUEDJmSb9TyuCLO8/1NVWtxQ7/6QHYrQ30aX7EdVe4X5jtbTUZ7FrYKG0MHIKid5rvCIEvHn4cFvfHVfa2vq18K2slOWdVmWJjUUrfZRGBan3RHqeDkewmKPoQQzkFjy41yb8VgDDTw0bNdTUeaFdIQ4HEwsspDyTEaeNSWna9sn9se4oS0I7HeVEXL4Uv2hWx8MeXCtafMfQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+Iy3ORtNbAHxQkTki9KLJFnf/Yh8KBAEugr8Vc4X1eve+byFN8MMT9Vvlb3U28vexMNOheGjY+CeyOgTM+28mi9eQNC3ZEh7wij/VSPIYihLBNz7Tf4nmkI0XydLgtiLYtQVtewj3jq/cAa6JNEgIuP31tVfl/bBCkdpuOLOxrPboQtBV32EDaPpYQARW7HyvgCIQuc9pYxlgoW8Sdq71Jx/GZgWkZktwPMIj1jrpuvS3pZXdWsNHz+3/bmOoQ3eZGY0S6Tnd66MC8VBrnH3pvx/mtBzRlCxCsJ+GstrA/WF+o1F+9ZX3h07hs7v4iN/S4kCV17ksP0sBZXkSbq+WASpzfqbr4QT7pioSoAxGnvBY8bf0/7DE5RyUTXP3HOyY1bXYMyrBuyOrPBwQnnrteg93+AbebNnpn6HWfWfHUp0XFumibLjMiOW6hr6/nkW
X-Exchange-RoutingPolicyChecked:
	wiv8ot8J18/dfLI0LsGUwZCbEnkr1MDvAbAMGiy06y4y8ImJwlN2u8heFM8FQRbESPXFLMPCa68vtXXftDnzKXf3LImFSRWK6fEVOlNndB6oFFHnAmDCwhNN+1m+Q3lkuoycbQRNmvD2uUzlLcqGwAsD9ipS96fXFHtR3OSYYcrS9etIPDpxlISHqWR2xExWSfgUEyu1cxsVq3Yq3yrm1eqkp2Xhh5GcSBrt4EPkzXT53TI6LCMs/OcBf+smMuVulnE3TdfPHhJosDfdLcM/vUo1nDWfWG54xAwt2VM1ZAXUCx+wDg9NRPGPVMEKaAaYkgaMzwF98qMtLiKsPRr2DA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 19:46:24.9480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12de3b58-8079-46b1-0d17-08df3aac4f66
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7603
X-Authority-Analysis: v=2.4 cv=DMsacCNb c=1 sm=1 tr=0 ts=6aeb8b95 cx=c_pps
 a=gt+0rivs0JJaOpoC1YDK5g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=pGLkceISAAAA:8 a=ymiUPDP2rjUc5QVP9rwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _Lg8lRog5EebJ3VfXOjQp2pNpIagRWb8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3NyBTYWx0ZWRfXyVrMuspqA6FZ
 3K/GmPkCzOrSxFlQ4AXO8ZHItxmwrZtNHS9K3hLjwtwXLE9yyGJ/6+JZZRYYn2hlIqsmnXctb6I
 LIBtPiJSsoJChMYUuTzqOxvqkuzDyyhdUgb9QixG9+vr5JK0NLAptl72VORasPgpCzrX9gUURNP
 b0AyNIyxZFXNvhVcfyf5K6G7TKy45nkZK5LDq6Zgq/KMc7EklFUT1SEBwK17lB2NYYOBzZLcf5F
 n8zcdj6pRz68DOanxDHFjdTURapK33982RxOBSic6Lh1lKWxYKJrXz22hy8E++rlPG2X2/GTQ04
 tPQTc6P8w5w6ZnPgdNMr5HpHZ6P8B95PypNiR56fDOlO4RSFZMCIQZXclvFBG8DCGYb+5Rs6J3S
 xuFvG+nTwN9Dmh0lf2Cpx3wRlQI6aZ2UxClD2phLGOQTRULw4rjcn5rinhih9hOfPWQiehZQ9XR
 QugIGqDljjY/6Rl+fBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3NyBTYWx0ZWRfXwgmNNZkpQfWO
 teg+KuMnHJSHw73L61CF1TpMyvBKCvSXOPtz8O20qCuj3QI7l8ze3Kf0swGOAOIIPR/avat21st
 h95xJGuaYlqzhLQqVTQvMBcA5NIy06E=
X-Proofpoint-ORIG-GUID: _Lg8lRog5EebJ3VfXOjQp2pNpIagRWb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040077

On 11/4/26 12:22 PM, Lee Jones wrote:
> On Wed, 28 Oct 2026, Danish Khateeb wrote:
> 
>> Since the LEDs are registered with devm_led_classdev_register(), they
>> are unregistered only after tca6507_remove() has cancelled the work.
>> Unregistering an LED that is on turns it off, which queues the work
>> again from led_assign(), and the work then runs after devres has freed
>> the chip:
>>
>>    BUG: KASAN: slab-use-after-free in assign_work+0x414/0x5b0
>>    Read of size 8 at addr ffff888010d5c0c0 by task kworker/1:2/65
>>    ...
>>    Last potentially related work creation:
>>     ...
>>     queue_work_on+0xb6/0xc0
>>     led_assign+0x223/0x340 [leds_tca6507]
>>     led_classdev_unregister+0x26b/0x340
>>     release_nodes+0xb3/0x140
>>     devres_release_group+0x247/0x470
>>     i2c_device_remove+0xbf/0x1b0
>>
>> Set up the work with devm_work_autocancel() before the LEDs are
>> registered, so that devres cancels it after they are gone, and drop
>> tca6507_remove().
>>
>> Fixes: 1b5c2fa7081c ("leds: tca6507: Use devm_led_classdev_register() to simplify remove path")
>> Cc: stable@vger.kernel.org
>> Acked-by: Andrew Davis <afd@ti.com>
>> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
>> ---
>>   drivers/leds/leds-tca6507.c | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
>> index 9afe2722986c..0f987e551f03 100644
>> --- a/drivers/leds/leds-tca6507.c
>> +++ b/drivers/leds/leds-tca6507.c
>> @@ -71,6 +71,7 @@
>>    * not recognised when matching.
>>    */
>>
>> +#include <linux/devm-helpers.h>
>>   #include <linux/module.h>
>>   #include <linux/slab.h>
>>   #include <linux/leds.h>
>> @@ -735,9 +736,11 @@ static int tca6507_probe(struct i2c_client *client)
>>   		return -ENOMEM;
>>
>>   	tca->client = client;
>> -	INIT_WORK(&tca->work, tca6507_work);
>>   	spin_lock_init(&tca->lock);
>> -	i2c_set_clientdata(client, tca);
>> +
>> +	err = devm_work_autocancel(dev, &tca->work, tca6507_work);
>> +	if (err)
>> +		return err;
> 
> This is replaced in patch 2.  I'm not sure I see the point.
> 
> Why not do everything at once?
> 

I see a v4 combining these just got posted before I could make
a reply here, but going to reply here anyway.

The two patches do different logical things, the first restores
the order of unregistering the LED before cancelling the work,
which fixes 1b5c2fa7081c. The second is a change in behavior, as
now we flush the work, not just cancel it as had previously always
been the case.

Both changes are correct, so combining is probably fine, but it
does slightly obscure the cancel -> flush behavior change part.

Andrew

>>   	for (i = 0; i < NUM_LEDS; i++) {
>>   		struct tca6507_led *l = tca->leds + i;
>> @@ -766,20 +769,12 @@ static int tca6507_probe(struct i2c_client *client)
>>   	return 0;
>>   }
>>
>> -static void tca6507_remove(struct i2c_client *client)
>> -{
>> -	struct tca6507_chip *tca = i2c_get_clientdata(client);
>> -
>> -	cancel_work_sync(&tca->work);
>> -}
>> -
>>   static struct i2c_driver tca6507_driver = {
>>   	.driver   = {
>>   		.name    = "leds-tca6507",
>>   		.of_match_table = of_match_ptr(of_tca6507_leds_match),
>>   	},
>>   	.probe    = tca6507_probe,
>> -	.remove   = tca6507_remove,
>>   	.id_table = tca6507_id,
>>   };
>>
>> -- 
>> 2.56.0
>>
> 

