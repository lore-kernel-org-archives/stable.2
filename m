Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792696650;
	b=AGZIK1MwI78BHW52RcJqyAaPA2FhZsUQOEW/o7nKorbkwFrphmZWz2IIPhpr5OJN+/v1
	 Gm9qZwDhXQzGfPUgEaSwECS5kNhRyPmnchKgEGIrDLk579JIom3LSvbGkcexHiAp90kyw
	 lWzmWAeS73dKQz5kRNb0YKp8leI6JcqK/BpD4MN/OtFX9W6j+5a+8waf+jaDePtQXbpoG
	 JkYYwHLCfLrRNgut1pFUU/LtEzJQlSzjZal565GijQpsSahPZKH7zvY/NEE30m6bVG73x
	 Yr1lXmC0opvKvo5cr3aaZlD8DdEb7iAEqRXN7/5AfPjsWJSwJpVsv08Z+egj//D5hiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696650;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vLZSIvu9tswtMpg5y0yANYakrk0EaQCuuRZrIyQP3Kg=;
	b=Sn/Ok/V6vLqwiMMJ6vsEYaFxtlXgLAXeEm3ncsV//tyYfa7KmEK8kJbtMvsa+edDFPHJ
	 NZbzIR83yLMTjG7Zw5qsrMzMkQwmXM3T2BTRIrTCH2QTf9Y2l7z5E6U3S7TVP50MMBtAI
	 DGfTG3hNpLyAMB638BSu2nYNdHRC8FTP3+4vjdKpR00TzV4SzZNNK7qaxBdm26MGCqZFZ
	 JBuH9eKIJuU7ig4FoV+eZvS2BsjPtQVxNBXZJ3ce4RjBYUcuRyQYSwundnZRaqeEQzBRH
	 mtg+8mfc0Dk7qrC3X9+Kd3ziUt71RYiLgCH5qPKDwx+RJMY844NswdJsIQ6ewL16bDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=RqWCrUUd;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=iY7NCKXW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862A606A31B;
	Thu, 22 Oct 2026 19:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0862A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=RqWCrUUd;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=iY7NCKXW
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69MHsgrD827476;
	Thu, 22 Oct 2026 14:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vLZSIvu9tswtMpg5y0yANYakrk0EaQCuuRZrIyQP3
	Kg=; b=RqWCrUUdOCUxvYCa6zNHRuWcw2Kqua2N4fT1DKx+Ou3vJF05qR1sSfC57
	+m4z6+/uUvmeE32Qk9nCGBGdPvq/yLTSNhNMRc/F0ilcYRaJ8q8XB/jjWVaSmvHg
	aowiM5KTl5lDWEocjLxXMZbDpoLo/0KHkib9gVSGcPxLCgkm7ccNZkB9pttbmNxd
	XAAgmTZyIkpUC8f9B+fBJ3eO8ay1tnS2FA4YU2X+qWVnU2DYyu+/mhd+K/nU7gec
	2jYJtSscxrkVhpF/bDCm2/vAZfKhN6XKpTUEeGY1Wy38Hc/dhu3fA9YMNTwiM3oY
	gUBQIgzkVqNqNsyJdgm0Aggo8EiwA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hfmg21rr0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 14:17:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=To6trLFumHyfGGdeAdQ6XOET/mFWYbS4kmh8hJ4hc2j2l2eYmZhwv/ys3n6MRezuflut5FZUJBPp4C41q7JMPqg9gk4oLWBF3w8QW8Z82WGlzrxBH8Y8wUU7ZastKfCYbASulXFymavCsBiBiZ92g3lhDW8jjaMmoATZsId1DjQpqK0mCOGMiKQ9fP6iJdam4icWilItqIjOM7IK8m5U/6a4T2uzJ+wZMLrHGvWCkBBvV4dOqr9y19169wQNgGaeIPt7igCV3ZDo9gmhkrKnfpQ7EW7p3SxywD3oM/MJCSn25HZ3YE/V12zgN0r11BQ5pGmLrUgrO1u8PhSSpBrrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLZSIvu9tswtMpg5y0yANYakrk0EaQCuuRZrIyQP3Kg=;
 b=BD5e6Hx2x5oLx0J6IVCnriIyRCgr88X/00dKv0z1/8V4ASt1slvMqPeWzNLwBmLR4CmXphWerBUb7pGNs/F8R7LejL0KDVoU95GpSpFqNHT5Ryb/aFRLXGUCrEgt2iW1UTXLm/M38kQeucrbgenDJhVedA59ECoLHDOl8XzCpBJ/4JCPHT+Aatrmo5iUZyffKOEDCo+biVB17bUBDXxpHHaqh3UK9mXFXG9csJuouujewmec07KCwPILz4YI94c5ZcrkqeBhaOQSB8RgSlhF56VcFsPX43xO+Wa+8bcd6ixXo6bF02zguU2Gd1asDVAmfclc5b1R4OUcsAXC6QcuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLZSIvu9tswtMpg5y0yANYakrk0EaQCuuRZrIyQP3Kg=;
 b=iY7NCKXWM6GbMMxJWVix728uT1gKyGviQn4Yn6FSkcgVLbeNgpXGdR+RyjAfmHaInoeQ/sRUcJg9lJuUc/L6XMSp21kWVgT5bPT/B6/xVVOtn9WvaIrI7NKxZmcOMIgun+eXForw/AzI2Ki26K54NUxiXktPuiF2ZLNdP8jybG8=
Received: from MW4PR02CA0013.namprd02.prod.outlook.com (2603:10b6:303:16d::13)
 by LV0PR10MB073341.namprd10.prod.outlook.com (2603:10b6:408:3fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 19:15:22 +0000
Received: from MW2PEPF00014676.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::83) by MW4PR02CA0013.outlook.office365.com
 (2603:10b6:303:16d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Thu,
 22 Oct 2026 19:15:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW2PEPF00014676.mail.protection.outlook.com (10.167.249.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 19:15:21 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 14:15:06 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 14:15:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 22 Oct 2026 14:15:06 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69MJF5iV989659;
	Thu, 22 Oct 2026 14:15:06 -0500
From: <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <nicolas.dufresne@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <b-brnich@ti.com>, Myeonghun Pak <mhun512@gmail.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v5 1/4] media: imagination: e5010: release m2m device on probe failure
Date: Thu, 22 Oct 2026 14:15:00 -0500
Message-ID: <20261022191503.1025072-2-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022191503.1025072-1-b-brnich@ti.com>
References: <20261022191503.1025072-1-b-brnich@ti.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014676:EE_|LV0PR10MB073341:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdb66be-a4bd-423a-43cb-08df3070d170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|261021123027099003|261022105027099003|261022075727099003|261009223027099003|56012099006|10067099003|22082099003|18002099003|261021135927099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	eRIOCM0N4z9ayrXMdxnhS3PF+sH1mxFSJ9IYJ/AmOJpuH65+jC+kxmzbBcZX73UNGq+5ROWv7m3ngLSieCu7eNSLS5tuBl4GlibqJmZXZzPcwXwlXusNzd0R7a0YdlVHi7FZBTcxqJgaiAS8uec2+xVaP0lLP/6E4wSFMgYPPz0r3bvWuMbrU0MfvQ/4wAbs6kU/XsU2cyg1qPh6xBVWMsJpbkt1Qvyk71KcucJYwLr6xG+spmQR7uyICaOA1QMMfxzKI9OgBULumCfFrHOf5P2lpkL63AT8FyVXgg1gBnJ16yuanShqLijeNmZVEsOz/LD5fXPxLJSpHP5HVJsztFvXVQXmHDIItGL7T9Atr/wrdMsxGIVn8ItscqohVE6diuc4vX9KUftTyPdr3Lvq7kaOochPwaaV8GdivkQ5cHNItNokCJlx7I40uXvyBZE4dIGME0CxKUOGAAm/UCv7jzOj2TGsaG7rY68Xp+Plx7vlEqet4+Ve7ztgOCPTl2oGBghdi+ex2xG2qTkvHLVwCjb2AFzx/UQoNygsLjd4Hg03qg0sr9INkzxbSDelaXmGxqLx/Scg7BcDb8BHRqH+hJpRCOoxMzQlsMDk8kJtTokK+E1NaRIjwZKcFUKa8XFjIHnEcFJ7QVzQuQ5JaDRjxDAEBCbnn5YgLGrRzuakDPXq6aOwF1Aab0CkMEyGsBO33XnCJ8etsW6JnWbLRvtzBA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(56012099006)(10067099003)(22082099003)(18002099003)(261021135927099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WA75qwK/s1X6xVLuf2FJybyOyjq5WKRVY5vbYw4SwNRBzgSZlUbjAo/9F/UAECEgBCz2Gcmww+IcZ5c9DW0OdZwcpMnxmQ1NVi1ZC6FuZJcryiZAZtFoobYWbG7VBjhlTiCnxIPHp2GV+VAM10k0Tr8D2QTKx2A8uiDXK62IkT2svFCHFuvFwJAAjRntROFiJb9C3DcN5z9R+AVRcFk5mipljHKu9cz05bb5vcH2VbbSnv0sdN1ci4fKgGo8W6A9E+WH0e3slJTOlJjvVHk08NKY2ss6VRNpkcaEeTj7TT5BYEfv/A7ymCIWFE+RMY0SD/T/eMLtujhhuJdqNrmrepZaFfliKNwzuX5iVv+/4UqG8h3e3jygNTdFmfGfmgi0IZj23hNjXJ3RZtTGx3fcKaJU1VCKH5BKT1ZR5bgzdjM3W+zkVkiOj+6/SCnkBAKK
X-Exchange-RoutingPolicyChecked:
	hwQfZ5k6z0r9mQV29y6EKRXdlhEv1bfjEwtXqw04F2LFIgW2Th/TRHDyfRyTJttAnNsVWd4qbdWxwH+fnu7bxauufyjkSTAPgzXYKRgKDBqbJb+C+N9IU+RlXpDNTQQWWMgZmGVhwFcxHKLiJ4mZ7myfnFyDdnYFZzWQkswULvkHsFCop0pdZK7SaIWAhxbOxKirGs3ZVdzDEThLKfjnkJhLBQWqFHzOgTCe+cUnv382rgUVKeCiYA5VXdTjnY1m0y3Agnh1GK+eQMJ4c6bpmBSmMR7cEtjTxRE8gfg1oXsFljEIRe92aCbJbFcZ/oilM/JT1lMilArZMhghACjIYg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:15:21.6734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdb66be-a4bd-423a-43cb-08df3070d170
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014676.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB073341
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfXyzgqEPlTZrkx
 ilyIa+ZGHP9flDfuI8aZx2EfH5qGqe44xoXBn2cOp+Blljdid0yRk2QPZH0Ie0C3+cmNHGIQK+u
 QH8fiKgUsL/b1KL+kOM/3efsShFJqZI=
X-Proofpoint-ORIG-GUID: dWv-CXozltB68eeRte4LzWRWQODMOgJM
X-Authority-Analysis: v=2.4 cv=XISl2ghE c=1 sm=1 tr=0 ts=6ada6146 cx=c_pps
 a=LawZwnZ+dX5EiMlPDlYRuw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=Wph3wFxZ5adJ-jZmi0oA:9
X-Proofpoint-GUID: dWv-CXozltB68eeRte4LzWRWQODMOgJM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfXwM65G1JIOBXO
 cy3jBDByGXYBBBt4newb4ixL2RnhOlJ+YvBSbvnUpmLx8C0DyzbdamVxkjwOlt4+WiyAa7Hyxne
 XQVj+ilfltxHYeSXuOJe4cBeBVLc64urQ40kdo0u8gBppeG8QPNHOGxtbgSiM0FyJQY+zUI6/EQ
 vd0de29x/rAPuDTOaoaha3udzdSEJeF9joGjxgQZEP+vUeOYmrvOJ+OKy1Zse7MWTHuygN6YMa2
 rtLweYimpYalIN5m0j9uJtlv7In37Lf6GBiYScqKLGDOVL2D8udqd9w5GBUF8XEwikEZqsrHDTb
 CRvRYnqea0CTUta2UcVE2AYRK5CuTLGKpBO671qIAOKgSGP8b1SiMhnIVgAaUPPoIT7J2O7I5ru
 GARPmItHN1BXw8PZlONtYdO0uYEPOjW5oxiawy3qREN4YLiE36Z7qntM3Zq+kfzYCqxMktlmGYH
 t3DEkhsXpBeCtWDXscg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220076

From: Myeonghun Pak <mhun512@gmail.com>

The probe path allocates the mem2mem device with v4l2_m2m_init(),
but several later failures jump directly to the v4l2_device_unregister()
unwind path. Since the driver core does not call .remove() after a failed
probe, those paths leak the m2m device.

Route post-v4l2_m2m_init() failures through the existing m2m release step
before unregistering the v4l2 device.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 420cb8bfdb12a..628d3ee35fb83 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1072,14 +1072,14 @@ static int e5010_probe(struct platform_device *pdev)
 	if (IS_ERR(e5010->core_base)) {
 		ret = PTR_ERR(e5010->core_base);
 		dev_err_probe(dev, ret, "Missing 'core' resources area\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_v4l2_m2m_init;
 	}
 
 	e5010->mmu_base = devm_platform_ioremap_resource_byname(pdev, "mmu");
 	if (IS_ERR(e5010->mmu_base)) {
 		ret = PTR_ERR(e5010->mmu_base);
 		dev_err_probe(dev, ret, "Missing 'mmu' resources area\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_v4l2_m2m_init;
 	}
 
 	e5010->last_context_run = NULL;
@@ -1089,14 +1089,14 @@ static int e5010_probe(struct platform_device *pdev)
 			       E5010_MODULE_NAME, e5010);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register IRQ %d\n", irq);
-		goto fail_after_v4l2_register;
+		goto fail_after_v4l2_m2m_init;
 	}
 
 	e5010->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(e5010->clk)) {
 		ret = PTR_ERR(e5010->clk);
 		dev_err_probe(dev, ret, "failed to get clock\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_v4l2_m2m_init;
 	}
 
 	pm_runtime_enable(dev);
@@ -1112,7 +1112,7 @@ static int e5010_probe(struct platform_device *pdev)
 
 	return 0;
 
-fail_after_video_register_device:
+fail_after_v4l2_m2m_init:
 	v4l2_m2m_release(e5010->m2m_dev);
 fail_after_v4l2_register:
 	v4l2_device_unregister(&e5010->v4l2_dev);
-- 
2.43.0

