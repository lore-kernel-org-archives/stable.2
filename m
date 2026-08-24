Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8836469824;
	Mon, 24 Aug 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588978; cv=fail; b=uxEoqZOWWOSMBTNnlGnA4VH4y8UbPPWEGpni/xc65oDQ7hhRzl9HxLUvTKNGFgqI7Ht2yZQ8mvR6EGlDm+3Ogi47LXpvYoZX517oWFrDte6iJFRc+3qOy4GH06RLnI88KpsQLghy+OgxSgnbeRTt2HZmTnSUfNC+H7pghzYcRtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588978; c=relaxed/simple;
	bh=PBcFEbXWSJEab6A9u5OUCWJKmYxf1sAh1q13wy4Ehz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hCfrSillmkni4XkDeHenAYpGdItuUU3mMS0HFVXwr7R/FyDIdvGbqbgHWMiEKTLAs+zry3UPsTNqWPAy0Mhv6w0CrEhzwtBBeUTmDxNM9zEKUHF/hJ2HpwI93LLDEoaal8ryIGRh8VNfmiHadxq2SEFeNFlQwxoGGPaz/Shum2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=HcD2l0nk; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tL2BiD80; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="HcD2l0nk";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tL2BiD80"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OFmRYE3636831;
	Mon, 24 Aug 2026 11:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=hiWMvjwpJCUFQ
	daPsQHfIHVViDJTRoQE+SUqzy6Yq+E=; b=HcD2l0nkGxcUTxGyZ1oK808K+WLIN
	ZC/+MzWVqotMYykB9WG+YfnrzQVyUECYKKjN9UU3Xu/6Jv++k4XDVr8dK7DDNr/P
	vHS9stPWVrORX+LTdqeLng89E2MITCsTNsntasP1yLKCIspU56KuwmqabNvglqlr
	7woPY+/4TPQ6SZ02jUbguIYu0IvGnWYvHHQmNS+S3+aEL9PrgNC3mcuGfiLBiNQp
	cZD3ATHl07sU8zkWLUcJlozQfD6b7N7KSZG/vzqAiW8V8V/uUIpMk1dRsTXkNYK5
	KXmVj+3evBAzAdMK4BZ+R1EP8EHMDZOx9VCqiynVO29wqm23mJSVS1Kjw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g8d1fcex9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 11:29:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWk9v6KYAeaopKShmSRNEx9uSD7mWGSzK7ydDYUOlGEdSGBpqALpygz8UwDfDAG/d6QJaLE1rutI8NRl++d4TX7RZpo+rIBAndBQxLCnajgWiwymFhSAP1EXFsHGPoP9D1NQoMdtWznxYBKmr9YOD8xeAMAda92fTzRcF6lIcpzAnnSlIMvTxa5F+zBL9TWS4qNAOMYPUL+Q0WY357mDHbOX//4cLxaQxehq/Duvfkbk3Wra42TdMUwMDAXVZaV4bz2TBCXOgdN/bwYbO8IU/Z6S6yYwZk9+TeZ9VRA45qMlJ0Wrt/yizX8X+EnxkPNwgvtcxKOk5OjUjlynBER1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiWMvjwpJCUFQdaPsQHfIHVViDJTRoQE+SUqzy6Yq+E=;
 b=DDg3JskopYPJmQASXrpi5PIAVn5kxGtgr4+Cb6Dj8kOoML3Fqfthqy4nKyZ6tYf8ury/5LXgALnglrvPOwH9ZM9hG3ZySD86wo/cE1YqEBaBO0OeJN7LpScDGD92WvupEawklIloLVrJur31a/1Zr7EBpFmJ9oRuk+gsaAZOa68je+7KTOd7Hcpv7eXzum3y4+GDbBpDplFeoIzvvKn9U1nMDtxToauAa4rvc71TnuiIMrNKRlJhrtV+rmQWuiQkG72XJLsIVhGUyWsEVohEkUCWLDI4fh4kuSblzMle5QmM4KjdYrrBCbIqCPyZInajZo7QujzRIf7WRxJ4dcNgXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiWMvjwpJCUFQdaPsQHfIHVViDJTRoQE+SUqzy6Yq+E=;
 b=tL2BiD80nK4dhGH9unhRrf4PA2TH/8EDQDh6DA4EyxwqEzxYI0fqos+riZWOJWx8+jhwd8HEK9bqTmNELRnPWbRmt/EbJOfSq0qs9N9+z9qq6JnmNXFrcmktImOZ53i4TOfWq2MFMNAjJZz9fz/XKgg2e/OnFqVJdRoeOB+xnQI=
Received: from BL1PR13CA0219.namprd13.prod.outlook.com (2603:10b6:208:2bf::14)
 by SN4PR10MB997923.namprd10.prod.outlook.com (2603:10b6:806:4fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 16:29:26 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::12) by BL1PR13CA0219.outlook.office365.com
 (2603:10b6:208:2bf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 16:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 16:29:23 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 11:28:51 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 11:28:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 11:28:51 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67OGSpxw3434524;
	Mon, 24 Aug 2026 11:28:51 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Mon, 24 Aug 2026 11:28:51 -0500
Subject: [PATCH] serial: 8250_omap: fix wake irq cleared during suspend
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260824-uart-wakeirq-fix-v1-1-6d81a230a1c4@ti.com>
X-B4-Tracking: v=1; b=H4sIAEJxjGoC/x2MSQqAMAwAvyI5G6i1LvgV8VBqqkFwSd1A/LvF4
 wzMPBBImAI0yQNCJwde5ghZmoAb7TwQch8ZtNKlqrXBw8qOl52IZUPPN+a5N5WyrtKmgJitQlH
 /y7Z73w+Dcb2vYgAAAA==
X-Change-ID: 20260824-uart-wakeirq-fix-33f470ac7245
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        Tony Lindgren <tony@atomide.com>
CC: <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
        <vishalm@ti.com>, <k-willis@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787588931; l=2461;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=PBcFEbXWSJEab6A9u5OUCWJKmYxf1sAh1q13wy4Ehz8=;
 b=aZqACz4kkAAobwLaRr6Jnl3pCmRLLydwRXTA4zbolsY+OYVRltvlVjMsDQrBBp4WkaKJdvD3x
 vPYJHYzY34OCfpI949HX7hAmKpruyvhfrazssSO/sAvsXGPtx0FHQ9v
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SN4PR10MB997923:EE_
X-MS-Office365-Filtering-Correlation-Id: 183cebf1-cb69-4d41-8789-08df01fcdb71
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|10067099003|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	18ZlNz9puCcKGsD8RxwzqNG+rh1WUKO5zhComr530wxbQVsJw2pCdVPAhcs4utcEcykUmMNSTMYzjSkbARLR4XXhpB+m18c7r7zW0Qp8Gy2adZ2ipI75aSR020+TPVLpc4QQRH2quBHYp21APk1ptDE3TUZ6x1Zbna2n7pjW80BylCyqwV0x56w/iDhTFfjooaM/a5RBHFRoHCsZal05cYkoKSZ+r7oy4hpGjoHy0AFUsyYwaMvG2L78MP2B8WAWMZCCg5Kj2RcQxKOh7rArG5Fhwd2uyysW+b1JTCjSdq1Dk0/MFej/MLfPDlS8Wvsg7EeT4tc3FOT2Yv869fAvwL92RfnLewXqwoZGAetMwIO4kZTx/R2qbWjMHhuEIzkFDIMUtMCpFLIPuDwG+rp5cRjNwJs0q5J7sR3eoEYHm0QCM0G+LYagw3sqGWbC//AcW6Thlm26/zbxbrh5ksuloRUnhn0ROMRlM+tp5oxGHlNKb2+PctYOGnmrsCmHe7IKqA3X3TYrdRtlVuBAdyuPzUNiHPvuux0xpl9s0SBL+ogFcciwU4XlDmKn4hKMGY81JaQj1B5pegQoRwTMD33R5lx6qWI9fNu8ZeEhE7TgdEEPP41vVZ7/6jxwLx3KzFlA0zk5ciyCdaizBHZYzWOLSN2iBveyj9VqKWmK0C8CvAPbGHdUWANJ4UJkdXSGE5mUpnxAq7mdVFQJvXOOHDaLNw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xth2nnIF6kSzC9ulIghjOehECV1rAbr1MC+4UDgBMAsl4ikQQdGa/+9W/zX3fqST+bg3uNY1+ORxI0/rBSdZyorWSgKBpPKBL5WTYTtgQoYQ7FnwACoRoHpzKi5rYzGgw+xm43IL72fdj9HSK5EE0T4nRS/PZs3pHw62S3jZ2Fcwc0BODRiKe00b1Es9FA+G/BSkcu3BdQ6UmLA0SGazaX+RGz2ab/Y4AYdStQxY1btdR8P+CWFSr52aIgM6n25sP4fwXH3Jnt222+t7A8ITJQPYuCGrssWd6gYymswrgW/DLnJNo+MZMKWYRcAIQCUzsLOLPPj+xmBSS08Z27ZSGQdfXzYm94Fq3JVhTpmFlwlexXNB+zd98s5p4f4OWXRj3LEvY+Fzk0AwutxLtJsF/bLInv/M5MaVSxDReYPS4q2oloIoSCJtf7rCDTNpFERN
X-Exchange-RoutingPolicyChecked:
	M1Nj/fY1fcM5NpymNFUsPTyHpYRb1ZEIeI/noNWhRg/sCHuw1FnEGOLRSxWcwMcqKMRkDY5vauhYNjNfu+DJ5+nt3oq0uj0rK4LXlq5juR9lAXmugwT/CSqU6O9VhfbG7CQFpx485QP1+HPM+wcVv/pLJh4bMQM47q0eI23bqRMebJB/Qe92gmR1GQJNrhLUPEzEJAmwj+9bezTEXMUoM26bCtOtxKakPKu/bhtRCWOIvawvWmTvTyMRapZBTWjAkRYd8fhEAOQ3bhOtfYgcOuK157LUvu6hU9+UKkclor1gN7vLPcMNqGs2PLBEznPLDas0VlGlZ5BMoT0SYlwogg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:29:23.3775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183cebf1-cb69-4d41-8789-08df01fcdb71
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB997923
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfXzPhUsUl9nIEh
 +euu675QotShwaiEvzZs+P1U9Q8RQcdx7A8fAIn2s63hbxZ0RauPRqzFBwGTVLEebKbG+WuzbNm
 O3ZR3mjnRLW5HcLAExxcEqTLGg2c47Twvj++fdHmBHve+YvwMxe4aBJ9mQ/P6+EQw2V3hJSKjim
 nVVsqRdFm+KWp9U1lte7XPxqfOh0FaVEfIW1I3WSiiN33EF2Kdh/3q8+LwLYiCY3AvxyBOWOMxv
 rcaQRF1V27YO8fiFMO+F92XFxr0szKtxIAhMUjsKu57k5sVCsPZm4zrfgvoCXmy6dOt0QUi5Cp8
 AbAoAHUqdYXlBQp/wD38vmJkI0VDvENgaZtLsEM8BoNnW9XTsFazSC48aPw3+tBsWSsXEX+1Lr6
 2CepTS5M+KB9nBmV761Fs5K+eFezEcy8d5HB51Pz4IHPVb2L/rb6TRcs1ScZVohEd5x6fYCY6rT
 B6EH3WAvfk67J1vqjug==
X-Proofpoint-ORIG-GUID: mu8c9d03q5vw2JklueQs0uqNA9nhKqim
X-Proofpoint-GUID: mu8c9d03q5vw2JklueQs0uqNA9nhKqim
X-Authority-Analysis: v=2.4 cv=NZ3WEWD4 c=1 sm=1 tr=0 ts=6a8c7169 cx=c_pps
 a=Ei0IHGVoEhmO3RFfwX1Atw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=jEtcNFeU0uYd4u7O3DYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfX/YUbx7/ufZnZ
 /AZy+2MKyBU00rXc/lZgPKRqt/zYAbGy4ufYE1Agwc0oEmIaHmxyCvQnowN2YD3obspec16tsXz
 A5RojiGt39DzvYYAntz+GGjQQEEb45g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240139

The wake irq was cleared in shutdown(), which runs during the suspend
sequence, making it impossible to wake the system via UART.
Move wake irq setup to probe() and teardown to remove() so the irq
remains armed during suspend when the UART is a wakeup source.

Cc: stable@vger.kernel.org
Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 3c7775df27effd309419b413c791b46688d4aacd..9cc88d2c510ce1c4e2fd63bf1976f23b9d7871e2 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -711,12 +711,6 @@ static int omap_8250_startup(struct uart_port *port)
 	struct uart_8250_dma *dma = &priv->omap8250_dma;
 	int ret;
 
-	if (priv->wakeirq) {
-		ret = dev_pm_set_dedicated_wake_irq(port->dev, priv->wakeirq);
-		if (ret)
-			return ret;
-	}
-
 #ifdef CONFIG_PM
 	up->capabilities |= UART_CAP_RPM;
 #endif
@@ -787,7 +781,6 @@ static void omap_8250_shutdown(struct uart_port *port)
 	}
 
 	disable_irq_nosync(port->irq);
-	dev_pm_clear_wake_irq(port->dev);
 
 	serial8250_release_dma(up);
 	up->dma = NULL;
@@ -1588,6 +1581,12 @@ static int omap8250_probe(struct platform_device *pdev)
 
 	priv->wakeirq = irq_of_parse_and_map(np, 1);
 
+	if (priv->wakeirq) {
+		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, priv->wakeirq);
+		if (ret)
+			goto err;
+	}
+
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to register 8250 port\n");
@@ -1608,6 +1607,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	flush_work(&priv->qos_work);
 	pm_runtime_disable(&pdev->dev);
 	cpu_latency_qos_remove_request(&priv->pm_qos_request);
+	dev_pm_clear_wake_irq(&pdev->dev);
 	return ret;
 }
 
@@ -1630,6 +1630,7 @@ static void omap8250_remove(struct platform_device *pdev)
 	flush_work(&priv->qos_work);
 	pm_runtime_disable(&pdev->dev);
 	cpu_latency_qos_remove_request(&priv->pm_qos_request);
+	dev_pm_clear_wake_irq(&pdev->dev);
 	device_set_wakeup_capable(&pdev->dev, false);
 }
 

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260824-uart-wakeirq-fix-33f470ac7245

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

