Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FB356779;
	Tue, 25 Aug 2026 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695605; cv=fail; b=gIk/fkOGoFDHGiu5KoGdkAyRngkLfpS3v512b6gTy4S9yza8mvvPkFRTTY0yDUkYS5bS3DE9IEgX++yu/OfTA/CJyyP92fKUXwCBSegFHZxCDsWn81hNf5q8Kj2ysMksvHKUZZ445QQAwQyCTi8KVFNkS3c3hMdwihuIVBmoMRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695605; c=relaxed/simple;
	bh=V1cBF5zc74psVOqHLJ+0Ij3D11PMaHwyZ9CM0uy3JSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Vc+2rGenQRv9y82TbgfMR6opqsZvPk+tNW1QkVi2EPnG9GgS6bArXcWCOjVhIJCoS+URnY2hEN0tV2VD0NvsASR0qk7xnSKQOKmibTWHFAiGho5eTVRZkY+LdtCOD/MOtrCG32xouBsniEVLNL+TNtTBfgr0isyct5i31+Y13ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ZhuHUj4C; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dOiYmMkZ; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ZhuHUj4C";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dOiYmMkZ"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PLB8rh1898827;
	Tue, 25 Aug 2026 17:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=wyr8Wq2EJDqMQ
	8ift8UesJfa88GZ3Fl+zj+qWnwkJaU=; b=ZhuHUj4CJDh9SU1LqzzVTlMT4jiJX
	8XQExJWzc/jfQHogZ9Rh3IivvaLUz6QCKEdsIn1cQPYUt8rZEeOtqsshavskJnj+
	XFDpBIX5foVd9ahF7y47vVsON9HkqHrNZGbM0DXyv9uSXUMcjC23KEY0X/yP7pPa
	CrdowLj60mkoJLaR5zD+K7zweTv2j16Gc6pJ6eYDEB2KG3Pt1oSy/T86JxZp+fJw
	zPD4+owcKKNH1C+Jj5Z/ljTc4WoTa+op+P/CI2LqTjLq7FMonWF268Zg+VlvJPcY
	hSE7WATLPvZk0PrIvdWWxW0vgTfShU7B0Frhg08IfLIbzHjjdGvWcfbVg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxnxxj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 17:06:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUZPXj7B+bz/W6oguhjxfP6kyAIGbonlCESgMNAlu7zrPHJg25a7iAT4A1FxmIKq3XvJeV38f/SFaXb+eUp7xOwQneddvrDhDAh8h9E12slK8Fp56W7l8sdRavux6Dt4MQJDFOwXDCA1IbDdUGJ1xUkZE4J+kZ2mO8iknMmMuVpGkceF6vF8c0j7SvaxzIktF66d5vRQqnvX7EhM2DP2a6iqJx07Iu2a6oey/uImXNfM1sElDv08F6+X8sF6rX80DfQgRBgHijE0MOegdx1pNHmyHUsjlGwyTDuiOHmFyJ1I5CQQseXYoR0MyFU5HMAoNcjttlLlTSpQq1oU4WAfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyr8Wq2EJDqMQ8ift8UesJfa88GZ3Fl+zj+qWnwkJaU=;
 b=DjOqT0n8dZsFtW7wRRD3BflG//Y7g+EfZERN0HZh2oJaBOCCQGa3oRkYLumMRDRnAup87ziQNbtHsb0q+mpwA8CXAIu8zfofdsAEVQUgY6LAKbc+XHjXNVa7gPpCDs4hTzveaSEhnQhGt9xH47RJjJFKCHhmtNk1ZoCvFhtmqNWG+lxwNkG1LZqVSowFHcJKwuNPv0Wg6w70icm14SKcpXEk2SxKcAyKP/p9REOrIx74BG0TKluZv1v+8IkrZhndvm+GUuTlMOT94S6vbkKwABFDVmodUyQLxmGqcvaqqRvWoZwEauXBcxf8NI23CrN4bYcOkyLCMq4RMDEnzbqZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linutronix.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyr8Wq2EJDqMQ8ift8UesJfa88GZ3Fl+zj+qWnwkJaU=;
 b=dOiYmMkZ/lfXH/4sgGePKfhVfpo7zpvW7/cu9PSFByMuZYvhbySpNXt6gkUgt9yeVF0XJXAGbujn5MaEU5TWoMAIPLDOpYtgz6UztpW8DLDgM+JUmuPxQn9jr/H466XASjLfYtgRyoACi142R6jkjJnkABdoplYo/bagl5Vlixw=
Received: from BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::14)
 by PH7PR10MB7718.namprd10.prod.outlook.com (2603:10b6:510:30d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 22:06:17 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::9a) by BLAP220CA0009.outlook.office365.com
 (2603:10b6:208:32c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 22:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 22:06:15 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 17:06:14 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 17:06:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 17:06:14 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PM6EL21793695;
	Tue, 25 Aug 2026 17:06:14 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Tue, 25 Aug 2026 17:06:07 -0500
Subject: [PATCH v2] serial: 8250_omap: fix wake irq cleared during suspend
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260825-uart-wakeirq-fix-v2-1-0b9fba03d9b6@ti.com>
X-B4-Tracking: v=1; b=H4sIAM4RjmoC/32NTQrCMBBGr1Jm7Uj+bIsr7yFdhDS1g9joJEal5
 O7GHsDle/C9b4XomXyEY7MC+0yRwlJB7Rpws10uHmmsDEqoVvTK4NNywpe9euIHTvRGrSfTCes
 6ZQ5QZ3f2VW/J81B5ppgCf7aHLH/2TyxLlNiOvbRKCyudOSXau3CDoZTyBQcLPumtAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787695574; l=2702;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=V1cBF5zc74psVOqHLJ+0Ij3D11PMaHwyZ9CM0uy3JSs=;
 b=bzHWASQyvcqo3fZQ5V9u2EUwHNB2HHqxw4w5/N2OAalKuYNk0KpNx5MFRVPPDItE8B0eUM0eW
 HTZuNL4MiEAA6RuxH2pmMQaJK1ZYe3IxktkvcZ/a6LwqMAw2cZriinZ
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|PH7PR10MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf9f76c-e499-4a8a-05f3-08df02f514f8
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|56012099006|13003099007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	m/Uq+8wHmbjpttNaXKFPTwzC/8cu+R7gpO0nvweWk2AfwRvBpD8SKfB+xeUqZqflHj41B7Kl2AFt2tfKd9OlbWkiPFUJXZ30wIB+lMxwc+ddHiLK76QDfhNhdJB6hqJSjQ50N5jh/mHXDEtw9ogTuQUslW/P5G/yBXGX2EfOMSj1up/tAi+oyrJcrWSYF43odDpely+Na+YOSOKdxT29nbx+vIC6NzjBRy9OFW0FzQdBMZaqaOiFN5G+4XpwUx3xdEIZ6HeLlTtDu/B+5YhVaD6MiXj3h6TJu26BSQvXysRonFFkBkfU8Me4oCunC2zBk7IsdBIRDKR9moZZLwK33luiZxePW1odqZEk7ppsc6AvOsHq3JclDRUx2jausGTWQV/Sr0EpCGIurAcDp0/biwFLaO9ffc4ED3zDXFVDBRbs/WLuIkw5Qmz+J4afUsfSCh+aStmMIQt+t4kOtX6lMJlvbjQAqcIpsonvJyYqkQcknPH+0/jWT7E9hpaHpQH1NMZ03K/oIET6eRP6hBfzwakT4HoeCkslEMeP2XaWyuvptbdJNOCc8AYh/usft4qZmdpWTFTzOA2JrtkR6JRf7GF64I82JdVYo8L9M9JQZTmOeT003+GKZRxvSVsei0hg5gBiWSmm0Emhl1H28kNtS2sMRRToviiGYfTV7RSa3mzn13FV24JTnYkaIw9z1vW1YBO+zgWrWdXS4dJXkVkW5Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(56012099006)(13003099007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dkp8+Dg4H/pEJAbasuHxC7s9GpUZXWmU2f6Mrn9yWBCaA+QhrgOYwShxVd8HP7QgDInOXTfFaF3khfbVwmFpzr30bUuflPrNdW/3Z8AZPyWIbWpA9KJs320ZMwyv/BoSyZ3YNibWF0zBNmJguLfgMSk5ZSz2nxpeK/QD1zJaYpjLa9cy68EJ07o3NGjAKJXluJ+dpgt0o3uWrs7TBn9uAA0lAEOQRO0QqXSFtv2srgdmWfQvCFgn2wJ27NpS1m3MGxCD/J/CWrKevnX65NOXvyQf+jV6yFCFsjFrC4URy+YVrEfQvvuy6Cez2+Bxr6ycnSBWDBy1TK43YhY9S9wCdEMRcpMSzdWC9hWmxi2Pesu7IcEkOXD+9xh25w0+Zgeat6VjbeekyAfKjz3WgiCPBoYXI5CmJ4Wkv9FBRYHUCh7YuuIrQBVtkRAcS/oNIINg
X-Exchange-RoutingPolicyChecked:
	bw010xezPCxCriGCL3C/OUM3I/GvOFX3iPuwfH/o6+ZpMMVGXqa0ku24iKga0aAB1YkfLc2yNuk0y/mhE083mOM63GO0emNByZAK9NkYupgnE2s6Ha7KcCHXnzv3X13mbIcPz4Z+xt/G0NHNbxYOMxjAak4XTV7C4yt3RtSapsZ1fXGiNPcIdUkBFzyUEmc7TNBPDWAH5hMUjgNAFDXca4rTcgs/vXTh42sJdTF2kfU0/YslFoeIxla+Hx7hChKQXPwhiL1yavYwE7n4Zf6VjyjTCIHJgifC5mt1ZJPccXQWqahAzIpT4nWOu0aFardnN3lXtDfQN6KaBlWCHjRsbQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 22:06:15.0725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf9f76c-e499-4a8a-05f3-08df02f514f8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7718
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4OCBTYWx0ZWRfX24UNUzU9ACW1
 pWRqJc57K6lhCIhzmX4abRuQHxhMwnUG4S+CtEKXRMRoSM15f9yoISEJoKDdPBdXFRcB9SieQ1h
 Z0NC7HlwNwztpG5sJbwf3CeF5ohxFAg=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8e11dd cx=c_pps
 a=PxsVn2hUj41VgPYomOKOQg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=jEtcNFeU0uYd4u7O3DYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5SP1hrg0wdQXd07fi3CzDY7p1skXQa2H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4OCBTYWx0ZWRfX5yzzquJHZUoO
 I6ATHa/SSimGcy7jXUlEifW4ezuhlFpLcWz2P/IY2AYEYo64tCTbx8GQkvmpZAK2mBfjfDWSriA
 ggiIg7L00J9f9pwTS40ioXrfsEezIfKTN4ADQr+hJ/WfmFjkYFiW50lQ3LJkmOXExVM4JpPw80G
 p8bKED1cifgKf00FHkfGfq+Gq5NsTaew4KrNiCZIjLuXpynMm/N+kLOrbqhXoTq7nKHjj64Um37
 gx7bXZNUIFtX2ezonBb8G80mpeGCy27OBW/irQmpFT1BdxvbK+Wo9sFNB4sTTAgLK0evtvfDKUm
 CpxdihN0wEEoG8VDOPP2N/z7klPCfpHcK/mQbE+BhlPvCGiIuso0EUdKxSERfSrwdOUpfcuQ+zM
 SZho4NmJeGfsyvNvmFRIfDC0IIz8ibHoF1kKZWXwuy2foUbvyv6nrFjTXMTUjHtRV8pblsY8qat
 Sm4LdAPG9+rbMsalsSw==
X-Proofpoint-ORIG-GUID: 5SP1hrg0wdQXd07fi3CzDY7p1skXQa2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250188

The wake irq was cleared in shutdown(), which runs during the suspend
sequence, making it impossible to wake the system via UART.
Move wake irq setup to probe() and teardown to remove() so the irq
remains armed during suspend when the UART is a wakeup source.

Cc: stable@vger.kernel.org
Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Changes in v2:
- Move dev_pm_clear_wake_irq() before pm_runtime_put_sync() to avoid
  potential race condition.
- Link to v1: https://lore.kernel.org/r/20260824-uart-wakeirq-fix-v1-1-6d81a230a1c4@ti.com
---
 drivers/tty/serial/8250/8250_omap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 3c7775df27effd309419b413c791b46688d4aacd..ceecb39fb82da255377931dbb5cf83fd57eaf164 100644
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
@@ -1603,6 +1602,7 @@ static int omap8250_probe(struct platform_device *pdev)
 
 	return 0;
 err:
+	dev_pm_clear_wake_irq(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	flush_work(&priv->qos_work);
@@ -1625,6 +1625,7 @@ static void omap8250_remove(struct platform_device *pdev)
 	omap_8250_shutdown(&up->port);
 	serial8250_unregister_port(priv->line);
 	priv->line = -ENODEV;
+	dev_pm_clear_wake_irq(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	flush_work(&priv->qos_work);

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260824-uart-wakeirq-fix-33f470ac7245

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

