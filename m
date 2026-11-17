Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943158;
	b=CvSjFVfXUZ2rZpy8xFYNvQ+sLJXA0Ji86rX3bgDPKyxABjXNMuoA6Dr2W9Gl4giBrsFA
	 U1ahB0/6R/JkImx+G4QROMVamDLF4+cI9/iN2PZEO1wcZc8h3NB3fxUJV0a7Nu8nFTq8E
	 PSKJMvNDIrF/EfgOw8OmpsP8M/W/pz3t8MhOxgEXnzE7K67ZbMZoarCIylMgHj+uzBz11
	 e1oNO3OAgtliVmtcuwZp3JuVNP9+m7dC/1rBZ53zIDcOyTGXHE541nHXBKZOx585bn9ny
	 mg3+R2sLfez+qEMRVOPUOXlPJNJEW0x44fpC3G8alTRzIR8Q8L5SanYznehIdNPFWSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943158;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eXLFyzYcdrvZJ+1uNjpVRLWMVm/h5f/pMrqiO1k4+zg=;
	b=dznRjoYeOn6GEIxSIEXo7aqnBT/w72FWwWz5Xh1Pdnxm9rGwwtCRvS44+lZd7nUGlRWC
	 i46XgZcGNkdHd/FrlZYRr4zijsBkYlugX6GspiXascEQaxrMcQDn2R4I2XbdJntI7tPd/
	 iRnRZq2VZ73H3o3370MA+rrc1YAk3cRXcsyTuJMp6glh1Yvb2ssj0KTMKju+6WMpoobUe
	 /8myJNP1HgjcehBII4lT702Xc6g5aovo8qcmQbXmUbdEmTNfgNQ6H41/ZUG9ZQ0gNuxxG
	 kqSp2hT/dAAI90nxnCVvzeN0/w9BAunsAfsjqfLQGkctIL65pP8y4j4Y5swus1fMxxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dwgEm8Mp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.44
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D26606A881;
	Tue, 17 Nov 2026 19:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10D26606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dwgEm8Mp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov6oxAh4Z81MrxnukpuDBiIpQQOMa+w+NLdlMWqVu5iYStsiXyxnRCnIT97DPu5jLle7AtHVrTJgDXMtPGgvgHj2ynr7RZgHqQcQLA/PYcMD1ypPNGyZ0epHhlEMeb7ls5QIdCdjc6lyp5sGM3tYvHOgTCq+Fbxm783Gm6ivSlFVWU4Nulxcc3EcXmkTha/kL5azUR5C5YlplQw3MmGWlsC5+ADNkLcQu2DwG+evuTD6cW8TtfeUh+LkEXzqJB/sT+w+7A91I4frLGaPs/NsKwhc5Qu4kOEPVRXARDXJuWIRdFHnPYwuQfBR43h6r4Zs2eaxc7LEq9KOttSXWPAbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXLFyzYcdrvZJ+1uNjpVRLWMVm/h5f/pMrqiO1k4+zg=;
 b=qYFE8O8xPHX4FXKR8ff2TgF2nmSV2UL0wFthZfcUUKxqlQQTemeZ9eyM2PhA83rTCm7Bdb9xYri19F+aTKbsiwK+QGSn7TgsPc1f8zUCDAoXtuxNZGrGVwStB6Apkfx2/WwNgK6IrNtJN32d9JEemtSTDMcyaMGyaok8R2cGtpbWjbu2mXTOwr1eu1ql1UMer8QG7bbiglTuUJ883l8JBc9hFlXSOnr9HucEAW3CKa7rypFlwb8TjNvHGDzlajKFKzvl4RpXvDE4FbvYfgn+r0Gc0wFcton21h/RZjplHa4CIUlD+vjmWE99cbo5haiDKJBf70qD4lkTkksp4KtPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXLFyzYcdrvZJ+1uNjpVRLWMVm/h5f/pMrqiO1k4+zg=;
 b=dwgEm8MpibguRaHARI1DSIywj7xoOPtIhNc6+2Zmrpr67C5uS0hGV8gZK9JZACJpKc5Lkty4DtDISpgqM0WetyrdtQT9XJkHr8ZJwL4ilMa3+evQqAfL4VCUjQpFVWnT7zJ9Ms3nsei02GMZSAJcaOVrbOo11WAWU9RT+gKMjTY=
Received: from BN0PR10CA0023.namprd10.prod.outlook.com (2603:10b6:408:143::20)
 by DS3PR12MB442436.namprd12.prod.outlook.com (2603:10b6:8:547::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:19:12 +0000
Received: from MN7PEPF0000014E.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::45) by BN0PR10CA0023.outlook.office365.com
 (2603:10b6:408:143::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:19:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014E.mail.protection.outlook.com (10.167.254.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:19:12 +0000
Received: from [10.11.96.223] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:19:10 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 17 Nov 2026 19:18:54 +0000
Subject: [PATCH net v2 1/2] ionic: reject Tx ring sizes below the minimum
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261117-b4-ionic-tso-max-segs-v2-1-f9792566c5d5@amd.com>
References: <20261117-b4-ionic-tso-max-segs-v2-0-f9792566c5d5@amd.com>
In-Reply-To: <20261117-b4-ionic-tso-max-segs-v2-0-f9792566c5d5@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Eric Joyner <eric.joyner@amd.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, <stable@vger.kernel.org>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014E:EE_|DS3PR12MB442436:EE_
X-MS-Office365-Filtering-Correlation-Id: a79f9fd3-3430-4829-961f-08df44dfa984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|261009223027099003|11063799006|56012099006|261102123227099003|10067099003|261026121527099003|261021121427099003|261022075727099003|5023799004|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	472WmcOrRazY53cFdimSVzW7p2FhgpQNNTOpLGWUwSQ+cT6FPfWln3hxsfwhM5+CWyfgNDcqc6UsSTXwUPqTqzMUsd62chNUeaPbxpFkhO9ams2+sw/9yLGEI/l0vazlADyPCJpT+iP3HfPcNZ538sm5iQSK20EiTZPD7sh9tyG6Ny06lTDjlQTzK4LLB4uq9lxAGhpWyVQ9XcHRFZKQThzLM1UzbNe0m0WuzzBy1RNpUqV/NH8222ZnsUwxC97vCIuEyIoDFCg3lRijOj7lRm3jFSA+k5qSLzU/FlobHD7lxNO2SeNuQNXwwRHO2OMRrxpwMSHet17MjcCQ5UN1sIGph8y5ZLo6AhtdTXVplPiAdmk6oz/jVSER5eJdVDrkq0glFB5nhsJ69xJ0uL8WH0+8Qi44pq3kawxwdxPATxLO4TnmmonfkIvqEzFmngz6jSaIFEuS1/R8cqQDqyJT6YWfoRHQLQoSpQTRTERq0m4AxA/Gv5W37htJntpqZo8l8QGvZ1C5Pf2YEvhp7apr8nBTV/Owmn2AM1QSx1pGjUSQIT4gvsU5jA5FhsqinkXKUblSk0IuB29qtKa2bpN1W67QukDX0mAPPxEnw7xn7/rHTU6+Md1mRGACeHgaUXFI3eMZIC9oW4yEQgEODyWTnwvHpuZ9jKg01ZJxecGBCeta7B/gozhIwQLWa5uWrbvXxV4wjbOZJjQOj0Xjj8Me2A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261026121527099003)(261021121427099003)(261022075727099003)(5023799004)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1B+igVNlY2mNSJrdQPFOAdXo8hohRwPl+MK8/tIDLFEaM4OJxGRViad9RtOXyJ77uUMHQiiAfOqYB6WR/s4r3bQou767CvlCWqxilrhtUhVbBJF5WUnKRzEbT7viVC4tSe7Z5jhzWxtodc9JDJHruLp+SRXzKL87IKD87eOPULhuQ/oYT70vzYeIKMy1oaothi94eV5aLGx9CPIg0ZIKzjCPcykI6oTq9F6KH673zhRn0hhTJfLcGi+mEHFLnC4ncLj03AEwsY+BLgOFcIZP03rRvvIDdikxhTA0jz5GLbh/YaRuO2/BagqfLB6surdPgTvYFqVxRLKXL4xL69sXuvJ6vMLU+wqyT1p7znJhuZQiJuiEvkpmJ+AN0p+F3jAOT2lZ2sc7/AxvmzWgnhGqgmYeIubIfGkmGB/jwVgr4u6JP+c9C7BLBI/b1rJmypJm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:19:12.1890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79f9fd3-3430-4829-961f-08df44dfa984
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB442436

ionic_tx_cq_service() wakes a stopped Tx queue only once
IONIC_TSO_DESCS_NEEDED (44) descriptors are free. The threshold is
sized for a 64 KB TSO skb at a 1500 byte MSS and assumes the ring can
have that many free; a Tx ring of 32 or fewer descriptors cannot, so a
stopped queue is never woken and the netdev watchdog fires.
ionic_set_ringparam() only checks that the size is a power of 2, and
the ethtool core only checks the maximum, so such sizes are accepted.

Reject Tx ring sizes below IONIC_MIN_TXRX_DESC.

The stall was confirmed from the wake and stop thresholds, not
reproduced. Tested on an AMD Pensando NIC: "ethtool -G <dev> tx 32" is
rejected and leaves the ring unchanged, and "ethtool -G <dev> tx 64" is
accepted.

Fixes: 061b9bedbef1 ("ionic: Rework Tx start/stop flow")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org # Running on a local machine
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 119ac720c078..3518fbf5882d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -708,6 +708,13 @@ static int ionic_set_ringparam(struct net_device *netdev,
 		return -EINVAL;
 	}
 
+	if (ring->tx_pending < IONIC_MIN_TXRX_DESC) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Tx descriptor count must be at least %d",
+				       IONIC_MIN_TXRX_DESC);
+		return -EINVAL;
+	}
+
 	/* if nothing to do return success */
 	if (ring->tx_pending == lif->ntxq_descs &&
 	    ring->rx_pending == lif->nrxq_descs &&

-- 
2.43.0

