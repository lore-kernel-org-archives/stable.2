Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793873731;
	b=h/8LtSzAguBeFy5qv5PYjr8x1sbvyqQyl++bqJSfliFTq9teGf0jtDYsCCEo5/2UqdaT
	 gD5T4p9nkw3jiVmapjj4atPeR1M7qmfrwWQYxqvPGf4mlXMluBS0z1Ld5oXlnBb/HDkyl
	 XNyPlZmAzqFpZ6dznKlBGheHO871ZlnIT+NRgF+w9cwM8Op274P00lgFJuazDicJMX+l9
	 OLe9Wkt/WRyUkbVTJYElnGDu6ep6roxdgx9FMxSWTCkjB8bDCA9+jI0y+RMgWNNifXhlV
	 +XajShttCFvFPJnUzib4Q3yqAsDVFDT0cTVs681MbdroHNn08UbWfpUJbBRZsVXat0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873731;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
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
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Reason;
	bh=SIBppA2366C43hK9iK5FptwHElk4KYkeI64Zd0T30FI=;
	b=1fv+FO8WnyG4/dGsEEopRd2l2CIMqxWUX2R31z3+qYSTTi9+ZGCpXe9vmYazP76R7VJv
	 UrDRDjKwLZ4xYr1dafqfZ0/XFlBRtNrI9Rj6Sybg+LwSGCE8V7/wX6045HQksUu7jYvxw
	 1DRerjyJ9rAiOlB/WfvMb281l8wZhALKUHMFn/77buzqeBRAPgU+9fbYQvy6H7p+loPgu
	 BavLzehv4wEcBYh81y6YtKYQ5cJMLlSRLgYl1Sq7HSXD+H8WYXJcLotMQMApnqdTYDM9j
	 JLJvLToZgThgsYuLi/wCSqa1JpJUdXeJZXkX/PAidxfI/dY+OAxx2yLinz3G8rgEJdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=AESlhJz3;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=hCJFcQKr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213A606AA5C;
	Thu,  5 Nov 2026 10:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E213A606AA5C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=AESlhJz3;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=hCJFcQKr
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A52KR6O3669519;
	Thu, 5 Nov 2026 04:15:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=SIBppA2366C43hK9iK
	5FptwHElk4KYkeI64Zd0T30FI=; b=AESlhJz3Sf/vv3+XvM/9nHznArWh72rZMs
	gAE3/+fq3p1bf1CkDIZzTgoHWmPThQMxtHRakK9txh12/p27RCoVI4D3IaNqsuLI
	c1762tCqMZ553U9SOlNmylaPmrXQtdArS5rtZhVdRF7bwu9pvhJZ9+1wN4LfXMks
	B8/Zt/7Rzm0m1GnDZPV1RlVAj3hgiunEBWaCt0NBgMcm3NGRfrRRMyBBQ3VKbFh9
	XXIYNhcXpNGMHHyucnH5ECO79iJM9Ok58rz1B0z8dM/Kvz8GeU6beih3WgTQGnpi
	GuIt3xdS7EEMO/PLqUEnsOFLxCew8+9DQ7cCbl8Y/cqnoJSfAc3A==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020099.outbound.protection.outlook.com [40.93.198.99])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hr73fhk1v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:15:21 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQhiXfC4P6qsTj9TJAX3XdLzTY/CBTX2D+lPQ7bDFS8fR0rbr4txSFXFNMHgC3XTITV4CEIMzt65eHJteE8M+DCc9nLZ/U+5ZaQEVt1R0O653DtSK5I7AU2NiL3/kki5psL9kEXUzTWa0UN+FGlRXXFy6mwGsjZJgKPsMCH1HHf0Fz4VZxs4+y2BLkyODRICROAetzAL1Gu7LSup3aYfhuWK3QmGdKNpkqF4kO1vcKwdFo44GTURnQi1ebvXG2DRyfmYHdfhwJP/CtoZTAvYH/U00TnPQdU/TSdtBspraVswbqqZLAt0+iBlHlVqg7DfwDiQlMA3jzTnnZpYzwLn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIBppA2366C43hK9iK5FptwHElk4KYkeI64Zd0T30FI=;
 b=SpU/CPnE5tbYaJkznLeN0A3S/bw4fFxRMoLLgliDn2OZgHuFvzOW1Pjb9j3VL0uz9Ose3bQGKDWwGWpSOJPq3RXA9BsvKwDbIe8ylYqer6/AbeOuw7Bs86xUG+ustM+v75LWtBuCLil+MjYTq8CVYwPwkApyPNVgxkdxZUQNd8u+hCmClS5OyIJIOvcAPM8msVkeVgf0IyXQBqfaGIQCM219zpBI2OLA8S/ZSjMHLHwkCNqx6NUFA6kQJU1MShSrQ1tuP2cUU5zzEiMln2dVz2W91uUS2NjMtsTZMIbvRwoHI8P5xXxlAOmOtGASB8S6nC4ReT8qXGX5guwCKsWAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIBppA2366C43hK9iK5FptwHElk4KYkeI64Zd0T30FI=;
 b=hCJFcQKrZEedPblsj9JYVe6uPYGsP+GUJgwkBXftbwjY7M3hEnzTLRxKp7OLHBOvpZ0dZ/mTr4sPUB5sVmR9C+QyMxR86nfG5XU5JJrjH8IgcscUGf26w4nyEAkJusIlH8dPwMSlcBOzAxftD4tzPL385OZ6ACUrlTHYAZ1mrqQ=
Received: from PH0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:510:5::10)
 by DSVPR19MB997311.namprd19.prod.outlook.com (2603:10b6:8:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 10:15:15 +0000
Received: from CY4PEPF000392DB.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::77) by PH0PR07CA0005.outlook.office365.com
 (2603:10b6:510:5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:15:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF000392DB.mail.protection.outlook.com (10.167.247.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Thu, 5 Nov 2026 10:15:13 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 5A9D6406544;
	Thu,  5 Nov 2026 10:15:12 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4333E820273;
	Thu,  5 Nov 2026 10:15:12 +0000 (UTC)
Date: Thu, 5 Nov 2026 10:15:11 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Lee Jones <lee@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 04/10] regulator: arizona-micsupp: Cancel check_cp_work
 on device teardown
Message-ID: <auxXL2v0SRPOLBAa@opensource.cirrus.com>
References: <20261104182148.1176116-1-lee@kernel.org>
 <20261104182148.1176116-5-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104182148.1176116-5-lee@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DB:EE_|DSVPR19MB997311:EE_
X-MS-Office365-Filtering-Correlation-Id: b703cefe-e668-44eb-91cf-08df3b25aed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|61400799027|376014|36860700016|82310400026|261022105027099003|56012099006|4143699003|11063799006|261028144727099003|261009223027099003|261026140227099003|261026121527099003|22082099003|18002099003|16102099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QvB7hBNLzDM60z84UoKVfDTZ+O31nObh1DvMaPvOdzuVJeekdfFDtGoznt7r2FluRZFp3PV7tuEc9Fs0rQ+OJJXYcsQj+cU+rRCO1DfajPsCNVVpC/rUaBUJNKHDcnNvfDaKUv5y2Yke4jqOjDhMe3QwkYzglOzqMj6kmRgVvcM+vmsx80UD+swZGkT781DS95iPobIpBxeXdQizKHO2eWAlfqonjnJqDVPOYUixGMlj9s9PSoE/kwO5aUCrRE60PSq7SiMj2jd1hfKbY4WumGRQDQ1JX6znhKXFZPZn/GRBF/ah02IrMP2MplF7nAV3jpO4JfmVPuKBL4HXwVeiLHgg0JoU/6+EZ6Rk6Vkwt2faVMCs/ArTyFxoxwcHJT1sZO5aBFRFU+M2zDIp6xv+BPXCLq7Txefz2UxYO+TwIVOF/TbavzVcIWgczciFyjPg5cjKsSxtGeXnJKrZw9Igfr/5imCo67vhESFtIL9hIWECMzz+H9J5t71rgX8W2RQlxWf6S776JL34m57fZDoHr2EYKi3/t8Q5pVAyVJqahrrFrNGzdpxp1jYj3PeAwhBdmJLRiEr13tKCMlRRD2r8tEqhfWD6ukO2++11j17reI0xRR7jVQ7P3/M2fJ2a5Oo1o4l8UyaWr2b8QeXmD2oM8g==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(61400799027)(376014)(36860700016)(82310400026)(261022105027099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261009223027099003)(261026140227099003)(261026121527099003)(22082099003)(18002099003)(16102099003)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0ZEW/TUTswzGA65IOOqqTi1EvTbs7jIC2OaZ7XAJLd7XiXMTrjjuTpvIfvPE/DSDBTw8VmsCxOkmZnFDQ/FH7Y4o+FLnQLwGJ8AGNNz2B78OLjU651UtKxYa3ANzAQRU/C1AbU+v/1PrgAKNm5tGYGmY6sgfK/n/BI+s2+qeo3MlmxuF9WArUHfS2hhoQlMicgaBPWlBIivwjFCwoQM7K1zHxYnxz9p0vjc5ZNW4qX/pw2USDlGKq6MrN6vm7B0wgnemK0lPQk/2CY70ZHoRomzL7cj3jSvZo8VHBaATgsOvqSgHtrMfNz7chCmd2U9BDOnSElwgKIzkGN7kJ3ak/+BvPhD9DwTK8nE6SrQDHt0l+DmeWUzDUwjCcuk9Bk9zNM4qkhK8Ihghes3kHqmH1Pu5TxEd+TYG4btx+UKW0VobPwyQpMwwgNcsr9C8efGb
X-Exchange-RoutingPolicyChecked:
	M9L0ZT/kjSGgxB7r21pq731qDxVToOYoUcXAGCbx9T/WWKm9Uqt/73cpa/GBQjT3e2xhnpn9NyN0gr+S+Eb9AabgLSkS2OF6uRYbQwL3yzrupzkPArCI9jmTSuGQxoAT1l9GZLtKCJnLiGuHmqjoGoa7dYyf8nqCn97jqSynJ3Ve3p+zEHSS4SISISTrCpgSQ5WfHR01pVGE0AxU012MfihLVnbt7mHOEeeWQpI5lnuhsVgF50cBwuI+QCmJeMjztucfHURYCfxC7KR2r35c6UYEhxQyvX+pGgg9ksMxCx5JUHtBByMtN0wlChQWTTlg/UmVISLvMKJfCfpBK5Px9Q==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:15:13.9943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b703cefe-e668-44eb-91cf-08df3b25aed4
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF000392DB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR19MB997311
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MCBTYWx0ZWRfX516r7WjxeRXI
 QIZfN1bhChXLVX60FVMspWOvibEstwv6yOYYpv+0vBmb8gfxGkMObXINpAqyncxR7o/Jr1AIEYr
 lJEgQoDnmrw1YHN1N4Sjk88Pc+hPBsk=
X-Proofpoint-GUID: r4fn0jmDNbyWZP9afU2ZivN9ZMDKrKvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MCBTYWx0ZWRfX5vBy89qFAnCp
 HS9rr/gYKteOu2ypdaObLoL+0FGzUdnE9DyFOgq/O2OPutJx2SJPov96WE8j2lRWdR/vKStDEfs
 g+47gelywwoOL6B8rDNpE2Zeevo8f2Z/OS0bU8gAeLqx2ilv46KTSicu2IQGgB5IZQLinoB8owI
 DN9p6y3tONHvUOGPp3LPSgQJrxNoi4IEjizGBjHPOjTSXcVrMHo0xskNOaiHZ/upS8Mo1btzAne
 wjEYIzli9bQrhAHoh1GNapHZQoERcteqjLA2HqIspksnDSs1dGxb+73LjjFsgcBvkMvR7jMrLZO
 NmJuDBysJQxV9pzmbecErMJ6Hofu4CHzrSWWwHoCP/25m3KYhRhVxt2zbWXrwvj88ZAwUCncU7k
 lDVRYlJl3Fu2SuGtPAny2UVZYbNyR1hNAE0XlAd6omjYS5yVBoz0R09uqH5WbrQoylWX2SonCQC
 NScVEZCPXt/Inrqqp1Q==
X-Proofpoint-ORIG-GUID: r4fn0jmDNbyWZP9afU2ZivN9ZMDKrKvr
X-Authority-Analysis: v=2.4 cv=K6S3jCWI c=1 sm=1 tr=0 ts=6aec5739 cx=c_pps
 a=GknEWMF7HrfbFJOd498rxg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=zeWXDPi-NAzp5XSfxpsA:9
 a=CjuIK1q_8ugA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 04, 2026 at 06:20:54PM +0000, Lee Jones wrote:
> micsupp->check_cp_work is initialised with raw INIT_WORK() and is never
> cancelled when the regulator device is unbound or when registration
> fails after set_machine_constraints() has run, allowing a pending work
> item to dereference micsupp after devres frees it.
> 
> Initialise check_cp_work with devm_work_autocancel() before registering
> the regulator so the work item is cancelled after regulator teardown and
> before micsupp is freed.
> 
> Fixes: e6ed90581bfa ("regulator: arizona-micsupp: Enable SYSCLK for charge pump")
> Closes: https://sashiko.dev/#/bug/linux-3f85eadb-7493-4aea-9e4d-ce319b6e0688
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
