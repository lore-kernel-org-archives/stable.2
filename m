Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF94EF146;
	Tue, 13 Oct 2026 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897361; cv=fail; b=YX/DVFTnvIDCR/EVh5E0oGNvRirDjjABO8EFv372idqaZGGhrtEsSUR5w3DTA5Cw/6UZuH+PIEA3+vjL/4f/ue0GpsYhcROQwWXiEhpgj/6fV8qk8qQyzPb25VevHzgHmx7BM4IbnDJxhIRWy6QxStx4INuWHXiYyLlJ+i27oZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897361; c=relaxed/simple;
	bh=hHjfcvyvc7q7Qgj4TXUJ/81DEuIOmVjatxB+Cut7MhE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=pAhNeXOJxOOvtesNznr1ZVZBOXpyjYNyh5/RWx+Ziu1RGgIWsJMYTsIB3/rWwNecp5TzyeOOkYLG6ZhU27k5sAXX25xndnBryNRsqrGmxFDnKSbckCRaCEZg+DMkrrPG9E/VALVJOqclb/Np0NgZ42ykp/scNcknI2RuDgZp+/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Nb6jy/Pg; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Nb6jy/Pg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaIB+FFZMWiNR7wTW8XsT+H7rj4cl/12yeKLGk/cr5T4p4yPlHKIIAlereuObKUXZhiumqXp2iNWFoK3VM4raKeFuABLeT9qU/FKStgpwbYMY6/EHoVkEVEN14a6ZQdmI16JcX85RMXzetOKFxhANnsmfY5pT2IlSXAeDYdlru/BlH8tk2vDYTxrTH5cfM+ezVqILOVXEpohamZdQRSK2RM1fivi91m+f8OqEkbVXtDc9B+c9fNJm3e0E/wkeWdytMzRJPbpYIYgmyVm1P1VFoAx9d1c3N0+q2/0qzPQBQPErPJiZM6wijjlcW3x7WYjLcrBpBT4pfGh01fGAiNWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KceIv5N7pnpLRfisyrQLKdKJgEG9/5bfn+OGpgNtHaE=;
 b=tm2klzwn6Js7LPpWkpskurV98R86YwkeIPFyRtjSr/ZjM4GFqyNxFotflkLSlXX4wJvPeg7Q1VCAbffER9l09CoebFGu7mIUmAr413LWRTWvP76DT7IeUceU9cMpHsA2v/jSVk+OIDoJRoR9MSP16Vzr7E1JguXluyUkea2H6EvFBdn8SIlxi0YAVXAgUoQPnKW9/HAgP2wqyBeEIYp8FsvHHXSPxBsGcffIYxT8hgpy8Sk4QDdU547tS5g26rUlOa7j3YJfP9Qav+cD7ykMO5MrkXgeZkjemFmoq8+X5L0Bq6fqExBw0kctUksGzjC+giu9Zma8MRC/uMT9x0nl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KceIv5N7pnpLRfisyrQLKdKJgEG9/5bfn+OGpgNtHaE=;
 b=Nb6jy/PgjqiBLc5Z0g7KdS/+7a2Hr2rqXJ32NU4du9aztXb14tBzO86k6BoLv+MXzDHZG6olkBtfDf/FjC++yDM253/cFzSmuAk1XOdvfuZmbIKiBVS3O92wXt4cnOr7uHz0uOVGBGtHHlKifTbND4HZMkMzdJJsyasqSgr1jRgn0EsA/QuQu23EDH/FClXF7ERqsQwmby/Ip+0c4zd1lKqKiARMRJFz3ZaBvNRioM0Qc19PoOg2wR2Td5cg/rA+Ofqer2rb42f4YXFrrMqp2QJWnoL8u5vwPoUZi4YbpSeZDibgC6aoItjf5r6UT4a6UNkDNP1syyy9Y/AQzv04IQ==
Received: from AS9PR06CA0721.eurprd06.prod.outlook.com (2603:10a6:20b:487::7)
 by AM0PR10MB3220.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:182::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 13:15:56 +0000
Received: from AM1PEPF000C1AD5.eurprd02.prod.outlook.com
 (2603:10a6:20b:487:cafe::a8) by AS9PR06CA0721.outlook.office365.com
 (2603:10a6:20b:487::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 13:15:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000C1AD5.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 13:15:54 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:16:08 +0200
Received: from localhost (10.252.6.143) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:15:54 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 0/5] usb: dwc2: fix low power issues found on stm32mp1
Date: Tue, 13 Oct 2026 15:15:04 +0200
Message-ID: <20261013-dwc2-low-power-fixes-stm32-v2-0-79865a4f1b63@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkuzmoC/32NTQ6CMBBGr0K6dkg7hEJceQ/CQsogNUJJp4KGc
 HcLxq3Ll+/nrYLJW2JxTlbhabZs3RgBT4kw/XW8Edg2skCJWklZQLsYhIdbYHILeejsixg4DBm
 CNIpy0mWDOYp4MHk64riv6i/zs7mTCfvj3ugtB+ffh31We+8nKv+JZgUS8iaTWdsVGklfOsecc
 kiNG0S9bdsHpK2yuNgAAAA=
X-Change-ID: 20261007-dwc2-low-power-fixes-stm32-0c1e5e68b252
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay
	<amelie.delaunay@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1AD5:EE_|AM0PR10MB3220:EE_
X-MS-Office365-Filtering-Correlation-Id: cf10e9db-909b-4b06-5860-08df292c1cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|34020700016|7416014|376014|36860700016|23010399003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	tXkHZyOkniaduv/HWYsnhZq5bZem8CHQX+HVMprAN5ztPwGrHpPadGpKoQ1y60qdlhHyCBC4PWqDR/6E3rP8XA6B3qOpVShl1S0q//JZF71sPVL+keUotQEyf1sBqLeGQ8knezFNO/qHga4axpFpUpRdiMYN8r7lG2/NtMJsdQ+hC5HIv3s8SV6qDoFhc8Adsja/cM5PcmNy1XCxSXDKFLBKiLnVuU2EkrQiEXBUBpBXXdw/Bx7aJc7cfumaioPrh5MF1nBybl2m4JrQd0CT9Qp7gusOKmFdxpMbXCrFJjwQ3KxKsOsC8Sf9YWnZXcJ+LWu5ea1lszYwoImvZlQfNx8ttwzy5qUzTZ8RUqdIA+FU91X560/4VHcN7OYyQjdEERQVklHrAr0jwk9Arbe0Lif+mQajqLKNCX4ggZb/OyIoqvoBRhXtIMGnkq4aEMM35s2tHfrapmq+7mwJWA86uER+gF0fat1BflXmEnVgUa+BVzMGKzOcbqFnRVfiLrxI2+xMhTJUw23cxgMVaBC4b5SyuQLnVVpX153opHSPU35BhESfNyf3scibW6zyShzASFDKGxB7WDfimGnmPyaihRS5Q2bruwHqkSdToPb7rS1RRx3vvbiYNrZkGozbyXLSal89RU2sQ2iJZLzLfd4noa5hFwbBJUN3s+RhMi94qdE=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(34020700016)(7416014)(376014)(36860700016)(23010399003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sTUTbB8vKxqy04RS88Mse0ENW6R++RdZNHnjhsWJFAbL921lHiUXEBs+yuTPWQSHoDWOHG5txmtvzM3CudeEeAJNvZY9D5ZEsDSlsqKNQa+1FrhiUfk4PQxPkOA4e5ZgKCn8MtPyLw4+fQkWb3sitJXM69z3m+dm+E4WXJrT1jJkl7Mq6qHye+kL8MNYo/8HmXpij1edMSlc1REHnPzZm8scP05iKr5WzwQrb5ihOLYeaSFMylF+rMXOKixL3g+rwnoBUcyQ9HRrMYINKFuHQsjD5DJqZDl4K5uqwLLURe+qt1ROGM8mPmX04qR3moDNb1hfGnFPV8Ts9Rf5YWbnk51SFLWRpzpxuUIyeia2WBR3oSRDv+kxqZv6JzRLZ0GCAR0x88Ap/Ctr4syhf/hcVUkSyog8EW+vgCJ4i2aftZlVvfkUiD5+z52tU97cfk9b
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:15:54.8239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf10e9db-909b-4b06-5860-08df292c1cd7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1AD5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3220

This series addresses several hang, bad_irq or re-initialisation issues
found on stm32mp1 when going to system low power (stop mode):
- First two fixes can be reproduced on stm32mp13 DK board, stm32mp15 DK
  and EVAL boards.
- Subsequent fixes can be reproduced on stm32mp15 EVAL board that uses
  an external Vbus regulator and stm32 dedicated detection logic.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Several fixes or commit messages updates since Sashiko review (see
  changelog in each patch).
- Add Thinh instead of Minas to the recipients
- Link to v1: https://patch.msgid.link/20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com

---
Fabrice Gasnier (5):
      usb: dwc2: fix recovery after PM domain off
      usb: dwc2: fix a possible interrupt storm on stm32mp1
      usb: dwc2: hcd: fix possible successive vbus supply enables
      usb: dwc2: hcd: don't disable/enable external vbus by system suspend/resume
      usb: dwc2: platform: fix stm32mp15 detection logic power management

 drivers/usb/dwc2/core.c      |   1 -
 drivers/usb/dwc2/core.h      |   2 -
 drivers/usb/dwc2/core_intr.c |   9 +-
 drivers/usb/dwc2/hcd.c       |  12 +--
 drivers/usb/dwc2/platform.c  | 228 ++++++++++++++++++++++---------------------
 5 files changed, 128 insertions(+), 124 deletions(-)
---
base-commit: b634294f400bc2500de5acd9c4961649c8d904c9
change-id: 20261007-dwc2-low-power-fixes-stm32-0c1e5e68b252

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

