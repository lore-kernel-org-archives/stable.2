Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267F2F39C7;
	Mon, 10 Aug 2026 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350111; cv=fail; b=OarAigRwzsrLiPmHQ0aO6rZyN/7WrstIyU+ZK5Fs4vUlZ4yp696XQaI5LUUsjj855Iju7DsYrjN5R9dNoAwUzky1b+dTlvQQps6vvczdSGP398CtvEQ4+XaatQFQB/tk4qiX1eHgxY0nhsoGk3gYX9+D62LEGRAN2+HI9J++xFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350111; c=relaxed/simple;
	bh=jbger48BohFc8S69dgh0Klt03nokXlAMgL6SdILYayg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVNErzf9sRc6I30jyCYBYXL/t4DPGmKDxtZcuSswkLPjpw1TMWdyeStWVb7Zzvc3IwF6+hCF88O6NbBo39eYxpMN/jPyBOObFdqzCHB9RqgB1+2XW4HtjTt7cv+/ftaOGq9i7damWhVtbk4VfMQHa3MNNo871kZMbAU6YctC3xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=nKUnmsOs; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="nKUnmsOs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgeGMImUbRMQrwyRajcE+xZg6y+4FY+cMUt6E4bYKYJhWztLm9yKwEy/IImGReBiSkPhbS/bg8zIU6Zj2Jmsk4IgSLfpCXL0hGpEyMiozOoWtEU41uekshfj6fMvf73J+pCbwp3U52L9GDTeLcHDAxv8zVOeHrX6MrLusRlM2YYjUVt641b2gTRP3imlcgL4vTQQD5i/W35nbH0urlKTEso6G1EYY0LI2CVk3bg6uCNpeNA/aK+sxFpuxiUMO3Ke8C1ZjrvXw6w7/bdG7EInotlvDq2YMHXFUgFoLam36CfGNTNDQ/q2R/WT05TR+dwYq7saH2fk9x3sMRaoYbn5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hK7/0O31ND1R9nU52JSQRW7bsszYpjMfB1irG4X/7U=;
 b=lsBuWVAnaCLTU6fSJNGFKBdUDyZUlqq0zPf+fb9oKYM6BkPTAqY8yY6oimNbxFuZMu7R/LP6qzagIn4T+OFt+q4ibzucE8TK1LX0q1peIjkZGIlDRcyX4l/NakV1iFj0B+fAcDGLAtp6qdsC3Lt1DmRiVpkmLuEjTkBEX022kJ4e5DN40z5ChstmFox9LdaKNvkUs7eYPT8/KoAyvMhNSPWq0W+nrau3TxxnQzqOcb98xxBcSN7niD9EW6QwvSCdBO1zBtWfpGoX7w7Uu0+BUPL/sl8AkvWv7AqxM/OUyoQnaC1vPn5JLCjGfk6hEPgZTwPspNNzJD8VNaSnXDu0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hK7/0O31ND1R9nU52JSQRW7bsszYpjMfB1irG4X/7U=;
 b=nKUnmsOszIqVc/ibC9+/njxicCCxhsKb0bSA5UmyaozN3B2FkIrL1Rh7ELqocyPMmRap/zih7llFcTkqIvHSPSefuPazha9eBSVIf9r5cWXHpWUu74tZrJZLgx2zY4XOv4SAP+l1reVAlIWbwr8T0BLOfxNyNiAYQ23XtIpG8R5h5Qb4g/0N17EicTSuc7b97ky/iI38MGB7OHtt+AofhPkbNrsmocbTLNfVpDhvgNRvfh7/3Uu8o6qdgL4xVSf/P3Wv41MQ93F4hCyVQ8UOBJEKReQDPycAwIsne6Z0CddS07KVsr3NLkAu5BHUQZ1pPqmvxzCFKaGxyjmMs3MHog==
Received: from PH8P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::13)
 by IA0PR22MB4305.namprd22.prod.outlook.com (2603:10b6:208:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Mon, 10 Aug
 2026 08:21:46 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:2d9:cafe::9c) by PH8P220CA0043.outlook.office365.com
 (2603:10b6:510:2d9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 08:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 08:21:44 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 8CD3AE4DB;
	Mon, 10 Aug 2026 11:21:42 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: David Heidelberg <david@ixit.cz>,
	=?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= <clement.perrochaud@nxp.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	stable@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] NFC: nxp-nci: fix deadlock between firmware download and IRQ handler
Date: Mon, 10 Aug 2026 11:21:36 +0300
Message-ID: <20260810082137.719-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|IA0PR22MB4305:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 52bcb350-c5ab-45c2-7799-08def6b86a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	utUD0Kz8FKGFfzJgplD9jilnHbINoTbAI2cUwFK5pv3gC93hg6/xp47WyGCIzCPnhBb4xO0cHTCzDwxElsa1uBsDnHLpn44FTNO4V2Rub3A/6lZ8cE39f4brtDJvlLSepnJPpobMOy8yA8aOW02UXNA2ejfL7lWNR9TNraPA6E0mJByZ2db7Mv/O4+jXdPCsaP8HJwPYxlQD9KA70PFDzzOT8gJ/aQTyzNx7ySZP9P/anEq7T5wTv00dARGUsx4dOdROCPTHFpeGooks3MpYh8et0XkmQFFj/UuURH1DDBhB55Vw/a1qp4fcxrRKaR5m20QQwWetlAPLEzblg66EEQSMSuO9fDFZFlKryANwwNcl5/bg63FF+TobVtgrhXS5ZXDYiIqp7y9U21VecpYndAugroLK9jSJSfMrv1aYV26NepzDPux/9c4A9nVA7CgjokVlRHM59znPcYYgPKXyo6E2tephZKfguzz/F8o3Fcx4rGInYMak/9M16X41JWLeONzhG0xf1698LcgMrIy5QvK1pbGBY+rTl8vHeUEkfwSD3oewLpFKOCv41Om6VxCVPkxR4dYksvwm5pJv7rhjozd/pxV1soJrg9inWzfWdPQ4M6LUs83kZpmJDdP1Wtx2oAmp+ebP1IP0+dBPbAq6knyEX7QGaOrCEk4pjD0/+POAC38gspKOnLOpvScUrPCpdBd7DXThSwcGZvb0JxRYjA==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2GEyreIZG9yprayF04L5v5l0UWB2u5Ic2mKFkGDP5ewfOV2dMNIxanvT1YbasyF6rXTLu3xALXR/VIkid+lAIOHTjp+lCfzyt9MzkeD9+PCL60nBaZhnY+aWbWpgspymNlWjjHVs9RnJjtR/3npskLoDBVjeSSN1NSCSUQFWCTmxGP+UqbRalHV8JYstH7Os9acLgq42EXfVpnzo0w90ICm8hvGEW8WfCUjEFdzv2B8rSOF/UDbE7rYjUr5LhS8Hq5LqNgBOi6KDv8uQb7RNoATNKCJ6zUPvjFSSOaVeDr/8q7t/EU5zqfbkCzzkwtaY4dOodfEyhMFc0JZADLK0pySroYgscpmLGDbH9ofo1GFAYmIcpIRJxOSZY1lBWBJU3+CHutyu659CxFNGqPaelZo6LvYSLtvKDQ2Cl6dxgmfu2R4haHuLwxnj8UeUQVHr
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:21:44.9507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bcb350-c5ab-45c2-7799-08def6b86a63
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR22MB4305

The firmware download work function holds `info_lock' while calling the
nxp_nci_fw_send(), which waits for a completion.

The completion is signalled by the IRQ thread handler, which also takes
`info_lock', causing a deadlock.

Fix by dropping the mutex while waiting for the completion.

Fixes: dece45855a8b ("NFC: nxp-nci: Add support for NXP NCI chips")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
Changes since v1:
- Fixes tag
- Cc for stable
---
 drivers/nfc/nxp-nci/firmware.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nfc/nxp-nci/firmware.c b/drivers/nfc/nxp-nci/firmware.c
index a9533977aff8..38fcac26ce56 100644
--- a/drivers/nfc/nxp-nci/firmware.c
+++ b/drivers/nfc/nxp-nci/firmware.c
@@ -154,8 +154,13 @@ static int nxp_nci_fw_send(struct nxp_nci_info *info)
 		if (fw_info->fw)
 			schedule_work(&fw_info->work);
 	} else {
+		mutex_unlock(&info->info_lock);
+
 		completion_rc = wait_for_completion_interruptible_timeout(
 			&fw_info->cmd_completion, NXP_NCI_FW_ANSWER_TIMEOUT);
+
+		mutex_lock(&info->info_lock);
+
 		if (completion_rc == 0)
 			return -ETIMEDOUT;
 	}
-- 
2.47.3

