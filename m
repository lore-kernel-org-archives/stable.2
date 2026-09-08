Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41C5A5122;
	Tue,  8 Sep 2026 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894060; cv=fail; b=AY1ntbJyr5S/U4eR8xOmDcz1tYZubUi05PAYeDGxQqyS79a4p2KdZqPtdeN+UmSGmL4j9CWF18WSdDP4PLQaTBndGNvhqHNn51cWJ3WEJD+ztBtIQks4oq4o1Sl6elrI+5mJUZYHbUt/0Yjg9PYHazH16S3omk1lNkl0b6d1BRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894060; c=relaxed/simple;
	bh=4QCU3TKnvWUNoa6FdmHfKLh/3YD46Pmkx7Kkw3aB2G4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M89VMKCZvG2tdTXyyomp+RYaKv4Q7DhiaC23L3vUGqjH22nhSrXaKsId8O/5nh7SxveLTjudy9aqIEM6jQ7ZEEBDhSk5QJNRqnwZa1L+DqVdGLYGX0TNDalIz/1UDD2ZCvI9sAiMXlC1JBU/BvcCvVq2CCkfNzKfkiNmTRY76Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=dOpyN+v9; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vdf3DcrW; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="dOpyN+v9";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vdf3DcrW"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688HOG3W2220205;
	Tue, 8 Sep 2026 14:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=ou5IOUbE/uH9B
	vyS/z3InmmzBuj3PORh6z4ML3xPJDs=; b=dOpyN+v9oHVP/3D7ZUicKo6DKhHWd
	NlUbxloVzuCxKH4AWFcVe4dr8y2anTb7UuZtOMxN3L5t1f58pk8yvOShZqREBh/8
	JakfGHYA3xf6yykbRbhox1lzwenhZ1iCi638i9m5uLXiETTVpi6mMdJ/4hPfDo4F
	yR27Ptu6aQhCTmixN6Gg9XPO8DAoF9erEcwAgDjDyq/lUQWdZkAuHXwOvAkQKkB2
	LdQyrmma5ZBz6CyBbd9pMNKEJaK2GNMjTt6R60e8OcLWt7w9zG2DsCPDvq/MHHNx
	gKfy/vFtTbbh7kMXZDgggbSIsa3LDtTzOjRtzK/sPlUyuxn1a4HojackA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940qbgh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 14:00:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9uEOwT7JGdRnWFnsCsOI0GHkOCHhE+IS6Cl3y2W5AxxBcD3FpvjpzNGe8sKPOPhozx3SX4IL+fc97PrWz4OpG6/nu3Y6FA0RS7ghj/IahxoNYhlvUplAJAGwoOR3ju3k3z5ZY4F9nfmKPEzraV8YYKEED0YG/beufkWW5iQLrDwT1CkEtwKfWNKco8XNXeMQxybxOXz2gRbuZhxdTdGDpLQjXmLmAaqnocbNCju6Y/fCyL23+fKR6kSTWVpdQooGSPdEtJXciITC5vgP33Yr5qNIjOzP98esOpOxbsuoKP2j2um4qJb8rZRSArzWhxcORtsQyqGnj1LHUdFcMnYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou5IOUbE/uH9BvyS/z3InmmzBuj3PORh6z4ML3xPJDs=;
 b=lUyKPyNnthKe+UhAvtAg7P9yT1vs975o7xvGOHD3WNUA64gaE0jNgJptSgNPoFihx6BoPi/JbquRvWe3sSu9Rs2vZm7bOu5c8dKkQZ3DK9jqL/vH8cjK3P5I4Wbo3qrU5L7ImIwaecQAOsBwkMj3MjyS0CxCBfRy9XQHHxFsEF3DoW84ifX/iX10g5HKlSqA5d86Z9Gn9Uu+g0GnmnHwpfhiiDYfcYk31KX15PcIbUqvwM8ZDzTDv/xHmCWhILQ35cxhkDIlWpTUKglK5UKvPg+8M2nUziYV5L9clsQfLPfZ5LiCJ+xAg2CDok4xv+qf2Kfi7NSFo3AbOz3MTlBeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou5IOUbE/uH9BvyS/z3InmmzBuj3PORh6z4ML3xPJDs=;
 b=vdf3DcrWngj/GEb6+Ql4EwUAimrfi8VVGiw6eDBHpu4aE+mb56LJ4fiw+0KtcOIIXFKN+X5ezHCZaFzGNLcxBwjWIiiqiMO55OHETbEqf+a6oYEf8T0+HFOrjEEyk9FRpWQHMHN2PW5m5aHtV7VpuW3jFbaVXu3bLOJTvliBBlk=
Received: from CP5P284CA0100.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:92::20)
 by DS4PPF0FF25AAD9.namprd10.prod.outlook.com (2603:10b6:f:fc00::d09) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:00:34 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10d6:103:92:cafe::84) by CP5P284CA0100.outlook.office365.com
 (2603:10d6:103:92::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 19:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:00:30 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 13:59:47 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 13:59:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 13:59:47 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.65])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688IxlqA3009465;
	Tue, 8 Sep 2026 13:59:47 -0500
From: Jared McArthur <j-mcarthur@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo <kristo@kernel.org>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>,
        "Jared
 McArthur" <j-mcarthur@ti.com>
Subject: [PATCH v2 1/1] arm64: dts: ti: k3-j784s4-j742s2-evm-common: Set ACSPCIe refclk to MAIN_PLL2_HSDIV4 for pcie1
Date: Tue, 8 Sep 2026 13:59:03 -0500
Message-ID: <20260908185903.404451-1-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS4PPF0FF25AAD9:EE_
X-MS-Office365-Filtering-Correlation-Id: af8967bd-1155-448c-a727-08df0ddb744c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|6133799003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EMy79tJNmEsz7A6DBtGepQMwSCBabvs18pl5f23oI+Yl1D82AZ9k8QTo6l2kUBXFC8xNfhBazwzWiw39jfVwuh2GjfjsTj585UOyR0U6WNbIEFzyKj0iw7+PwEh0zjySpbQ/YT5bAt2kxvJfxRJFbfI/r2/hN7dm+xohgO6+IWhh5H0vJ4I6xh51nUePoyanRIjrF6LB1uDRT09eTAXbbrzy9USo78oX+3cY9I20KKAMTwyY5nszQ+ixJMPxOfJKALWFMyfqbTLAz+P4qVtoRxhvkkj6aPFun/2k0+gm7v2FcrvcRJCSrWmk6A0xKlvTlqvhXBLgXLkFRFIqMpuBhsWM0+hONKF6ON9ca9rmmyvOn5ftIW+pBzwS+VFuBb+5DrSw/pFfbvndUNcR69QRb72ITd7XN6Ws9hKzUTxS70xI6qQcphdsNqlbsI1C9NHDDmcu4Bagnl/wQCkn+fXiXLznQbthvEFd94vt+14uiNXxx9KljfgRK8+ZVDl/770iuuIDsa6AIN5KtYrYM6YzULUebuD4P7x6toT9PZLHOR8mD5u0mIJJh4reo+s4vpNYg71YoamRzAD+XJaTS3DUb/KkQW4X7YiFZk0pwfM78HTygouUJ4bPzNeZC0oW7V4Jd8fHGUJuwD1pMQ0NRJoISbSIObFrLuhrMGcTbPtJQ08TkoGcjw3N18m3cTr/o9WXpvQ+RqHYOyPG1IsgVnSppQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(6133799003)(3023799007)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rIZyTQ91rwxdPfivULWg6QuNYPAq7OqnFPsfINUL/kao/ZH2g40kgGDLGdUFcBuYLr7Hsf6CGCSRShQ0OkinI0NkHekT2fqF+c1hi1MvGrFqszvIDLhr4TvXi5X0U1eOllpWyB2/641U2x3eG4UejIa9e1j8PnwxmZjCcyrfeFK3umDTb1Zk82Wf8yydEEl566JSvptn6lzVt2CLkM247+47beK4eP/AYNvAyQN/6Ope4wUuGd8p/mCzvWPvQ9xUjEZecgNuBmffH46sSe1OpV5Vzs3gB0vH8N9kBcWqQEEMAsrvv+PI/zHHsfRKG7IQUfenC60afMvif4KOzOntrbVTKhymgrVGPMPltAM/qHkKAWiusFICvbvAR/MEhIKVN5xfUAPyTMpH8Z/CYT8zgP37x0QSqlDOpJnBQKeXW5g3p5enpj+oPRz9xApiyXo0
X-Exchange-RoutingPolicyChecked:
	y6EylRnABe51u8V001pt4OuoAvI4Cy9hCATReXtk+1j77WWukw0sUwpbdBVcDLCvep5ASMDnK1TKVJQiWI51JURPcpHBN7GYeRTozwriL0GaojVz5fQAvzOjvMuQi/AXCUX4Gh/M/id9CYZolwoKdJ7FwUyQNG1AER6qRWnwGbA/KgkK/8aD9pNAMA3ouh3p/GkoOgXeb0B0udfylEBV6+26MhX8FakYW2t3l6TFooqmfU7/9K9rRHPzUH0V1jiu37jwPccQGscqAqOHvxnqgnjPZ97G/q5m2UB9LIYCr3un2edKHIMKlRomWtVXDbfjCrpR/yvwftrV6SF5BOAbaw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:00:30.9423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af8967bd-1155-448c-a727-08df0ddb744c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0FF25AAD9
X-Proofpoint-ORIG-GUID: WouKb_ZFnPcT3pfY83D6o2wzo0occL3V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwNyBTYWx0ZWRfX4W4yqdW1N7kX
 yN2RyLK6isE3b+uBhsC+W228neB9noHZyWJnqgHbvD906TS92iPYVA/rBTtjnAC9ScqGHPPm13/
 6+qP7Ye6xw85b+IjA8agrwDlPam5m2NagthTf5eN3af91afRbDbNlIeZtOhuvbbjLgnwLZTV0Kl
 aKj3MKu07wvdVPRIe4BX60AWv4QBscKFpg8e1aansPnK/4ZCbPNMPG3DfR4x7yBVijPLLb/ZrXX
 pFr3vffaC2v534CkMKD7Nl+PB7VEPgRatZxAYB2Nrr8fVijoYIVciGkKFrdP8XsQowYSq74Fssw
 ALNJpkDcw3SLUCF3sG9HvCWR8Xsa50+4HX0AfEQjl0+srkpfBWGQenQpVT1mTe49BbpmQKYdK/E
 g9c9KrTPcFLQYQjxkGrmkzzxgsRvsVurjTW/BAPDNUZXLpP+IrmNaJ+4fg4L5ntaAn/2UijFp+Q
 5ztN3OyTFJMXNfULT/A==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6aa05b55 cx=c_pps
 a=f333RhXzhOQaWIE8hCCRDA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=cLv2ltgyIHFFgOpPekEA:9
X-Proofpoint-GUID: WouKb_ZFnPcT3pfY83D6o2wzo0occL3V
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwNyBTYWx0ZWRfX/M56ZZiquxaZ
 ZlOBBXfbKshrul3JV9ido2qNiWzOlU9rDT7cTZrALO4bXF+b4YCUz3UUsjtQdZ1FTGQoYDec4Lq
 AERIctilR/I7p9qzZooCkDJqutWhAaU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1011 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080207

Commit e3dfcf482d07 ("arm64: dts: ti: k3-j784s4-j742s2-evm-common:
Enable ACSPCIE0 output for PCIe1") enabled the ACSPCIE0 buffers
to provide the PCIe refclk for PCIe1, but introduced a bug
where the clock is remporarily disabled during initialization.
The ACSPCIe reference clock is muxable between multiple
sources: SERDESx_REF_DER_OUT_CLK, MAIN_PLL2_HSDIV4_CLKOUT, and
SERDESx_REF_OUT_CLK [0]. On reset, the refclk is set to the
SERDESx_REF_DER_OUT_CLK. In the J742S2 and J784S4, "the SerDes PCIe
Reference Clock Output will be temporarily disabled when changing Data
Rates to or from 8.0 GT/s in Derived Refclk mode" [1]. Some external PCIe
devices cannot tolerate the reference clock being disabled and will
therefore fail to link.

This advisory is described in more detail as: i2242 of the J784S4
Silicon Revision 1.0 (Rev. B) document [1].

The refclk for devices connected to PCIe1 is provided by the ACSPCIe
buffers in the J742S2XH01EVM [2] and J784S4XEVM [3]. Work around
the advisory by setting the ACSPCIe reference clock source to
MAIN_PLL2_HSDIV4_CLKOUT. Use the TI SCI clock controller to assign the
clock's source [4].

[0] https://www.ti.com/lit/zip/spruj52
[1] https://www.ti.com/lit/pdf/SPRZ536
[2] https://www.ti.com/lit/zip/SPAC001
[3] https://www.ti.com/lit/zip/SPRR458
[4] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/clocks.html

Fixes: e3dfcf482d07 ("arm64: dts: ti: k3-j784s4-j742s2-evm-common: Enable ACSPCIE0 output for PCIe1")
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
v2 changes:
- Added "Fixes" tag and edited the message to explain the fix
- Changed SPRZ536 link to immutable link
- Added Siddarth's reviewed-by

v1 link: https://lore.kernel.org/all/20260828195140.3476062-1-j-mcarthur@ti.com/

 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index ff3a85cbc524a..7c085663c8880 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -1206,6 +1206,8 @@ &pcie1_rc {
 	status = "okay";
 	clocks = <&k3_clks 333 0>, <&serdes0 CDNS_TORRENT_REFCLK_DRIVER>;
 	clock-names = "fck", "pcie_refclk";
+	assigned-clocks = <&k3_clks 415 0>;
+	assigned-clock-parents = <&k3_clks 415 2>;
 	num-lanes = <2>;
 	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes0_pcie1_link>;
-- 
2.34.1

