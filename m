Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08049EC5D;
	Thu,  8 Oct 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466466; cv=fail; b=ns9T9DV5slThruaqevMCmibsYDB+ZNpeetuMdbIe6gLU7sgDXB4yotHwdyU3eJO+1EH2wz5P2LJoUKLDMbXTRkZKDVP4XrJQOcMS/WZwJFHCZ+/TCKL1beSOlDmjtlFB5q+sMbvw4pwRa3wCyYKrZt9A0LXioNVNoDldAWR9+bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466466; c=relaxed/simple;
	bh=Ukys5sWHHYchOcg2YWrzWk+W3ULoB4XAHNBvbabJzgk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rOMgW7M0SxzAz7HikM774tYeE19jY2C4urGEJCdki5UN0cdKr3PzxC2yMKgLp+dLJHefRiuXcB1RaUf4WFEWmb6lUQAYuXLVxcdbqgeEP6XGwosYwFJAokssFp0XlPVnMqif1qKXtSVPZGMf0GDgaj1wsOU4qwEwJZyA/JekLl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MVbJidax; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MVbJidax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gmg8F8pwouM0qCynftreJecd/OBkrncf5Jqe8J855GDSGOZsaQ+coAoShWNClVB1VI5NxYWHlUla6MTrdPIkKAx7dfHijUuGh30FsOhEV6F8csxIFL920Ew3vhwtx0Kbo5qtI/KXluTd9+pkrsNRZGdKaRdTh7jZziw9HWAApD41V+m/70Iiaed0UdO/ggjAq6bdhYIKEx9Qz3rOyErwZHf584IYqiHa+KKvVE1fpjCLp86mcoieIG2o2cWAWOqpMULpyOy72wlmjDWIG9+q7gB4IJB9XqCnAPcziCT9APC8WtprIdnYocNYRsLoQh3wzZpGYcfQftUZYiZvTT08tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YxnJPdSMNYaIKDX49PPcrmhGyQ2/xT1cgIuG2YZRMo=;
 b=baITeHouxAqNTropSVu147GxntaM/5lvihQ0eLf4dO6ah7aw3SGAYZ7l3b0nXAmayvV1A3hAi4H3g3O6NYCj2SOD+k5XatZxXUI0uINhCKo9R2/2Gdn9mkM0Nwo5sr/02fLMQIkmqvj46CPR6sQ/QXmb5VcDtzLrahQsYN81BXIRM6210DeidsbDoapB6CVh27054j7hptXFnedAUpb02F2SSNESrgTY57LQ5UTSQT9+UTegwoDNW0beUXCSXPzmhgSyPr484g7vmX7GQjoScXO+yrbAiF9VNIanWtOwnRtLvpl6O2XPB/53OSRfpdtPWlBCVnIrnton1sN9d5kjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YxnJPdSMNYaIKDX49PPcrmhGyQ2/xT1cgIuG2YZRMo=;
 b=MVbJidax2fH5NAKmrdsqR/7SFjdO4Y+aHcR3tKTRsqRUrSRU2Y8NfcXaLiceB7WjSzYhyiQI/cObEJo2OJjFqfZsMwIZSdJO8Sj5r9x3zPYtD3y6Lnad2zuyTXcepXP3/S90khwUgee0mBrwnfs9/uIIdIEZs4+5OcLmAH3QMQnK35RQ4HVI/usDL97Q7jKpe9lwGX1+r/YhRwkYxAYVwjivCMURLUoYqUztVQzFfbLK27lQyZlFDYz/kaJSV0PKH56i5ttgJFW1azZoWbb0w2z/esAQNp4Meh/tAoLMkmE0p7L8RDxS1Eu4AfxDSjSpc0Yn2xczi5B8QYIZLw9p2w==
Received: from OS6P279CA0060.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::19)
 by BESPR10MB756850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 13:34:20 +0000
Received: from WA1PEPF00009B38.eurprd05.prod.outlook.com
 (2603:10a6:e10:31:cafe::31) by OS6P279CA0060.outlook.office365.com
 (2603:10a6:e10:31::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Thu, 8
 Oct 2026 13:34:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF00009B38.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 13:34:19 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:40:24 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:34:18 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/5] usb: dwc2: fix low power issues found on stm32mp1
Date: Thu, 8 Oct 2026 15:33:16 +0200
Message-ID: <20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJybx2oC/yXMUQ6CMBCE4auQfXaTdglovIrxAcqoa5SSLloSw
 t2t+vhlMv9KhqQwOlYrJbzVNI4FfldRuHXjFaxDMYmT1ju35yEH4UfMPMWMxBddYGzzsxZ2waN
 Be+ilESqBKeE3l//p/Le9+jvC/C3Stn0A9FvL034AAAA=
X-Change-ID: 20261007-dwc2-low-power-fixes-stm32-0c1e5e68b252
To: Minas Harutyunyan <hminas@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay <amelie.delaunay@st.com>,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Felipe Balbi
	<felipe.balbi@linux.intel.com>, Jisheng Zhang <jszhang@kernel.org>, "Felipe
 Balbi" <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Minas Harutyunyan
	<Minas.Harutyunyan@synopsys.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B38:EE_|BESPR10MB756850:EE_
X-MS-Office365-Filtering-Correlation-Id: a18f0bda-584a-4b51-7f1e-08df2540db53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|1800799024|36860700016|376014|18002099003|10067099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	cyOEnuCwotVKw+6CH4yrNuvorK6t4WfUG/JijfzPZtzIYPXozvGCmRG6VG9ALt2NokfqfOEXmy4KHOyUEL/0UIsXMsBfUv7vVQZo7AiFiDpkPR2lCXQk4P20kWgQKlEEdmT3QqCw4ewe01yLiU/PwRDLyG3iY20+YPKWztocIQEnUw/3Kd0SBgCLB2/XdOO0Lk0L/cGFMziLsVlLtBz0+ZFJY/XkyI/gdB7PV+zICEo0LsvhPM2rxucTz33dFCp0KxPWMzvc73sO5xj+dVXsGYILKL+Qn61HMaCT3RMuii8chsBaSyce01OGeunYu8QvUSteielQpT6abgIKirPabyuE1hJ5xIp+A8sgMItG5PGdXE29Nl/jUXR1K74NLJ/uFmSLIB1Kqt9rAQPbEZBI7YmTMfkzfhDqY55iyFPu18Npc9T0SCf7ncf43+WceRhf5P9eVjjLibeIKq/9q6JuN0idnz9kPA/DV97WUF0SqSa7p6pw7FOPRZxPOiWAZ4uvV8QMKm6brXtmWZn3etpOFPlrjmLMhveVoRY2Pwsmuba45DFg+VqQh8wMAHRxHHvSGqXXx56y2cewcPyoDGMys6lzvfAMZMo06HRivcaHoxRQGiLbOi7d93lEeeO8JblTR35YIu3ZesseJ0V+uQIJWvjh2V/jSgh5UyTpGmcvitpG7cN8/nBdum1mo/GZy7NfCouPcXH24WseivNT9QbxXi+rebVGkng1ZFOlHFZsMREx3/7NZTxVdJmBhzj0/O8Z
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(10067099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S4jAysf0i7zOr8r7202i5BoPjNCa+RQxP6easYMPyc3CjsPKSpr0BOviLUuYtuF4AvlAQeyTRrPIqvucfQhBkQw9I5nfdFvG/pPsO2X3BE+VcfiHcGaPr28mF6EIllSaBaHW7h49rUmhfUfCgsTKhgbvM+S3VB0EXdIs2aocVbomydqeGlHSu/BS60TOxRr7JzPqyP6nmL7Ho1OXv4wf53tc/vi7G/CugwzOqsXY9LWwADv+nSX1ht/gXKaUXnE9ooGJv/LIh5OOkg/+H/vMIMY3YD48fFKxYSe5Hx+D72/97EhK/o4eX3n+I2DLpiVQKyqoaopgJNJKGDmQjzDa5vCXm7JX0zxf5srylluNnxxe1m8cuqRfk4W0EDcx7IAssCMfS2BSwmTu5FPpkRmf8BgS8QslDOR28ilhZxKt4duRAEvUazRisqjYokR4Bc17
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:34:19.6648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a18f0bda-584a-4b51-7f1e-08df2540db53
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B38.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB756850

This series addresses several hang, bad_irq or re-initialisation issues
found on stm32mp1 when going to system low power (stop mode):
- First two fixes can be reproduced on stm32mp13 DK board, stm32mp15 DK
  and EVAL boards.
- Subsequent fixes can be reproduced on stm32mp15 EVAL board that uses
  an external Vbus regulator and stm32 dedicated detection logic.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Fabrice Gasnier (5):
      usb: dwc2: fix recovery after PM domain off
      usb: dwc2: fix a possible interrupt storm on stm32mp1
      usb: dwc2: hcd: fix possible successive vbus supply enables
      usb: dwc2: hcd: don't disable/enable external vbus by system suspend/resume
      usb: dwc2: platform: fix stm32mp15 detection logic power management

 drivers/usb/dwc2/core.c      |   1 -
 drivers/usb/dwc2/core.h      |   2 -
 drivers/usb/dwc2/core_intr.c |   6 +-
 drivers/usb/dwc2/hcd.c       |  11 +--
 drivers/usb/dwc2/platform.c  | 222 +++++++++++++++++++++----------------------
 5 files changed, 118 insertions(+), 124 deletions(-)
---
base-commit: 1a5dad490a3f8533ae955be59ac5d26a3dfb6166
change-id: 20261007-dwc2-low-power-fixes-stm32-0c1e5e68b252

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

