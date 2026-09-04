Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB53E008A;
	Fri,  4 Sep 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537925; cv=fail; b=Gr9TxDmDdIXBTNSchn3w/bIDngWs72pbFFBJd/X4ctvqeY7ISt2KCMD55Ne1+y6pKyZea1sZOqf+Bmm+Pqip5irp+gGpeCqr2LTR/wRpmNeHrTG2f339iG1fGTfDj/qosLiU9uQri55boIPmfpGcKKOT+oS4zRsxepOYSRZ/uX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537925; c=relaxed/simple;
	bh=7kQ5uE6FOCD+nQuPmzjXKpF6TP3X5wVDEWM2wxbxQ+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIPlZZQDCX1zgCTeqOsVcOmMeVCkcqbfyuQ3vmbKiKjJrgI5QRsbqVAu5zqWSMl+iheiiuU+dZxXK3GyFFM2vcjoeC4QGPtusYw7bKPOf+6UjCu9euBg50MHzoe8DSftAvI3Xv9RY67T9HmcVqTYFxIexcoti/CAOwWNPKwXDaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=fXmmzabE; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kwiHEQPP; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="fXmmzabE";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kwiHEQPP"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Ftngt106064;
	Fri, 4 Sep 2026 11:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=UbEUoX40saLnMcH5qf3la+zfYMV2YCAXf4lgSgFH6
	Do=; b=fXmmzabEqA60WwbXo4kBYfwXLy79QhH0XqLuYikIjAO70mevXWdtyQze1
	aWl4K4w1KJ3FZbKjYj+CaDEi5SQ7mRqbsZoLftQRr4PemFY2+2PqKJlygKcWWUxW
	qbYcQgqHf1LYCk4LJJIe4M+CtW9L50sFRojXvEPi8gco3oZFfaWfQw08Ct23mViG
	h/8HcW10IVNJJfU8VmHqXmWTZ06c2Wzjnp2gtnHaO+jrtOizCoqw8l53A2JHaYHB
	+XoXKmVCmXgzv4VrnsbNP177klpjKmFHMRyVKbCtINeeiXcH5gfW5yS41J5FwbU2
	dxGSCYFxDBxBdAFc1wCA/Ntn3/+bA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfyyq0r4d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 11:05:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQ8lBOKGH15zxtnkQU444+i1rsnuTjwLR1J9delSipPcaG4B3jr2wnhEffKS8D33h4GdbSuAWqGl1s6i5iq8bi+Eo+Cl4OJJf1Zvja1pmRWLQ83NTqFVjhuwRxdj7NAEXgh+AlEBuTr+PtAVVjl14xo1rBO8ifHDZIH2T7ZH1j5NftfeA8vL4Fhwv0Z0StaKXe8I+hGzr47YXWkZmk2pSK9PRYzkezCGf0P9Z1FccwVVIjXuRw9zKM0alce4lM5mI+IxZ6KM/n98Lb5enn3UoxeVQD5r+8TlDZabI+Ntlr3Rnjf00pLX8gTjFUK1JcttnzWBnVnFYoGGK5CIIyzAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbEUoX40saLnMcH5qf3la+zfYMV2YCAXf4lgSgFH6Do=;
 b=EIDyG6cYNXacpCZ/7NQ0tWC1sjgKgXuXLkFzTJbexLg1TjWhD+7wKgap1ZczCS4Y6DBdv3vnpRcmOhPsoy5kutznjRFy3xloFlkDl+WFmqoUPmcwR5LVPyVqETJHi7tKOxbQ2Z/ceRIy5s2aXh8lgKwN13BBNOn21aipb2KRM2iVE3ahBtBfBRwL0PrWXE2pT3NYwk57EZUtcgb3f8n/kXPgZPrF9DgfT30w06AZzL56MKbAae6IJt5K3AsO3YOYBFdHsPpEpL2kTTBiPPxRKk/EZteQZ2zGjy6ruv/8f4Nnbo6uRQ0CEv4wDFtK0EPbrhNsP9bB5UzbWj5pD1EhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbEUoX40saLnMcH5qf3la+zfYMV2YCAXf4lgSgFH6Do=;
 b=kwiHEQPPLAp4O9IeSHkvgejPce+8XUJPAjim5KcCLYAtry4EZFJ4B43DwiKUVR1qhpiHpVH7geG2kXidtqNeKyCd2XVgjeIIQTrpO4hIzLgBmT1Cnw2i5MkfbjYXYZ5hUCs9PxLF4Qlc9YLt2eHAddesGaSCWUqIO5fxsD7syDY=
Received: from CH2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:59::40)
 by SJ5PPFA7DBF91DC.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 16:05:08 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::48) by CH2PR03CA0030.outlook.office365.com
 (2603:10b6:610:59::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 16:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 16:05:07 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 11:04:20 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 11:04:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 11:04:20 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684G4KE83789666;
	Fri, 4 Sep 2026 11:04:20 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Judith Mendez
	<jm@ti.com>,
        Moteen Shah <m-shah@ti.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Set MMC clock pins as OUTPUT
Date: Fri, 4 Sep 2026 11:04:19 -0500
Message-ID: <178853784680.2998213.1218746974953764875.b4-ty@b4>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260813111238.56892-1-francesco@dolcini.it>
References: <20260813111238.56892-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SJ5PPFA7DBF91DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bd12c9-ecbb-473a-d06c-08df0a9e4a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|23010399003|10067099003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	aElekd6s47q2rRE8UwPaUClov6MMCBX+WV4G2b4FWcBd5GYvT7yE3HMFZ2sPFH3aWo2PN1e5ZEciEBJZAqfDJsbZUV69b6UyZmRdB4g3jO8J8bqQOkLFfq2Dkvh4kjkksGaYdBRfEa0WRT8FxOnhB8RCgCtHV435DA2BPPJZXMvs8xRiBxcEvZXMWpFpuJ+2tHeYG+v0KTdmghtHel2JnbY4+fmUP431mi6t+iytTFzEehBAE0GYU1X84YeJxDYfAvYHSO0wLpF68fZqWgoJwmd7YFKYi8bXrn26TBIwfBrqTM1cFFYnf9o548cJi2ciZH359vvjeymyViUvmmt9Q8jdeG0DozG52btrp4eqQWL2itMmhhMd2vemRgwDpHgsgER8+vedPn7TPEAlhW+TFdQK6Twgw4iFYHKDkivMumXZjAR5Z6/6o3wn2k6Nn9LGiVpcD0VUcRSrMQdUPjHZQghHcLNGCWbZegmUiDkU8sCXrHOolWu9F8y5HQHNHhzcXcWLVrUHTLsTzfhMZ/Ne6nvwdC2C0CsAUQ8Cay5/7caK72PTMvRbi9FrEMnccC3CbtMwROeVAGuLeGPgBBIlAZkrFt/J/DMQN/MQuZPd1U9tVbTp6XyCtmhPOchK22lggsNDCbCRkGiLcFyNXm24IZkhLO3LywXYctZnfoBhwPfN7PTTPIdQ9yBHHKNOwxC5NkxDyZovc5x59nLX3d5IFA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WLhjOUEuoPPvCOHHC1hSwztGKbAihw8S+1UF2Pz0v5Rb/W3iveqQ7+mDhBNebx6MRqun6ieY5xsNq5vXRqfB0q7KGdPGA8A+LkuvyvMgrmPJ8d61zeqs1R5TfZNkchZrs60W0ovejp9e5C9LpabVoq5y0pSQdlWXGzmnlmf0kDDqQZu4OqpYIZ9jr/QKgbutni5NAgEseezkv/BnUdvv4rtwAaYXS/U/YTYxXQRgPyH8uH9siN8Dubvl+JDO+L6w3y1VLWOJrJHt0xpDrJR6SnRd3ZDOuSzZlS75h0tQr4/P6lOB+Blkm3OpgCCmqCqyznVhoy/1v09nuWWSaxjcPZxpBg57qLldACBljazcCafZt9l08NylngRW6uWV9Zg+0e5vmKo2cVMe4Bsq5kzdy5gfvKBcnlOl7Sv192DjcS0f9JT0n5d9xftd+m4ZuVGY
X-Exchange-RoutingPolicyChecked:
	Y+lyn/cfNBlCtvgR91xsjzsK1pvJRkW9Bqe8IN5wWJnqzpN7gMRKE4/6wlsKYIh53AyWI9JlCzgtn+XMcyyFoTBC34o0NrDnRyMrcgw+pe7GQAe5nbQb+l/fwLSqcqJyTLrNP8Z5NUiNKSSL2J25cocHNhhzRYGmpjj4H4OHdaIIUwgfZWQnfjQjE6B5e2xG2uTla/Eu4455wVmSg1y8T9dP1LZR+RDrk4Uw71l6kJngJo/yC7rzPEXh2Y8r9JULJExU/ZkxMU/Rcvt3QyBbrLTxj4aA/oOaT+1KP8PYWRRqMKSxHt+IGwgEIofE1wGyPMG3dkHinyHZbHsXHqcTew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:05:07.1554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bd12c9-ecbb-473a-d06c-08df0a9e4a04
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA7DBF91DC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0NiBTYWx0ZWRfX/L8+IF/Ebfyu
 0sC+ykAMeo6UaPkLqboCWP/ZXf8xIZB62xfZUdP3lLvCoq9mbz7AcZVfS4/B7NQBpKaOTh87bCk
 slHQ8HuYxbDQFjsfrTqCRrb1Noh/ukQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0NiBTYWx0ZWRfX52SrqAwPJNT2
 zBNliSJSXF2zanVOnQeQHgw0UHNH5Z03Y+nRO3V43WuhJ8cyXkiPJEUcjzxvh7Cavhk5Ax4TkMx
 zABp0OCOI36fO4kuziTQIZ2lhUTHzEyFeijEpVpA2020cbow48pZTgZBj3Sod0RJt3+xnHwka4o
 hWv1EVVzSW62MZNIcEkE/aCCVPMZUpU36JssGzjsYAc3/WzUIC9c6ODWacrOjV9Kan51spZHfvR
 juPGzmGzNpdiOo6pW0mnd9Y9blYm9iCTg3bCE6IlDGIs2efWoz7aG47OvdhrZge0pjnGLaV6chh
 vAjGc/VIcAzIiyI7qhEtb3ypOLfbNoGBNlToT+xVzseTfsfcoAd1zjGmmHBLy5dnxsyNAeU9eca
 7YHaearBuHiR9kGajYOL5oyvrFFOhnZikYIV4pkXqTOlB0dPzfwpi42+Gbm+bsTxM88dVWOXZ8e
 CiOx8EQWy/JWExX0pfw==
X-Proofpoint-ORIG-GUID: CjHo1vkmvBRBLXEukOeVB4uXx-6w_ocb
X-Proofpoint-GUID: CjHo1vkmvBRBLXEukOeVB4uXx-6w_ocb
X-Authority-Analysis: v=2.4 cv=YqM/gYYX c=1 sm=1 tr=0 ts=6a9aec37 cx=c_pps
 a=Ba9BPv0Mt2atAB5a3SkMeQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=o1kACPpZKAZCWsj7fAYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040146

Hi Francesco Dolcini,

On Thu, 13 Aug 2026 13:12:36 +0200, Francesco Dolcini wrote:
> MMC clock pins must be configured as OUTPUT-only per TRM [0] with
> receiver disabled (RXACTIVE bit = 0). Change MMC CLK pins from
> PIN_INPUT to PIN_OUTPUT to match documentation.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-verdin: Set MMC clock pins as OUTPUT
      commit: 0ddd661c19ec1465e1f2c204fa9b2488acfabf4b

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

