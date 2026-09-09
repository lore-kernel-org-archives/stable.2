Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0254233722;
	Wed,  9 Sep 2026 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967724; cv=fail; b=OQmPdsvnPCfRe/eGQ2l+tMmd2g2QBeuH2bZ/91gHQgjw7/8T/1aw3pDeZtR+v/6LoB72w86ySHIMwDH+jG5GvV8M+BQJSF6KrBrehwWzH6A0Ys3iwSGELePN78N/tVGf9xusSZzLjT19ShC7St4opf9c0+Q/gtdAYlwQAaE4w9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967724; c=relaxed/simple;
	bh=jhjjkYbsDkqvmQFP8SfjCKqYmNFtespNuqes781xpA4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nxsjol+IMRLYjKauC6y7HPw7DCyVz8iQVLRzddUsDIFMSnvWhJROm6/pEQjEB2EIzXoKgQWcOr/I7Y8J988zxAtqRK5uYufcaizEscDrsVoGfdbT7rpA7nx9433GAlSi3DYTl5RFhecPRr0KCgI4ncWHh7zu8Xs1mVLNCJx+5Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JHIUZs0K; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JHIUZs0K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt2uIYy92+j0etZVJ8Fl3s6zwgUZAF1Jd/0Dhveiwnp63l9l537aiOXa/cKzqd4y71c/0h/IlFGCqt4Pl06/Y0RQQEVmcEzGbMHQYbWXWLqFcBBUz78OJ3tzphVuYhm5RJ0+GvtsUuXhgyVLQr4H+0nu1n87SsJ7Xy9yX139tEYSOMumG9t6eCaiksP27Yc2/RvLQwAO/Yx5iuFV1gMxWf/wKDDo5Gs9n9dJwx6Xg9ktOIQV8+o/iWq0t6168H1oidACRWVWZHVsUbFZ6+HV37sh3dQnLa1XuW3dQqKCM53zeVroti13ecKIuG12uDddXKDhZNCm4fUGjoR7VUju0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oaabMC6KuoXRcUbk2Vz6G3WiDfcnM0FpmgUEi6OobY=;
 b=bAbk+rH9L33pC/1dpwr1RfiSON/ZtkdvXe0d0dsEBGVBc6M0iib92JlOa35O4XC1/wT9ucgyVjbOn5SB4UJoEIEBW78VduJF1akdcg1pYovb5NRxP27ZRFSfDCMcJXy6dnpOXusxpUHlfKrjMhvZ6ypZA4IMBdOBDzVi7CJSZx74fcJYP2LZhbLCCIXjIknXPWfIupPFxBRkM6PR4o1wCVHkIFRx3fQd6ePa8hv4nJBN3N2shRZDNxeK2ReZUKg+RTQAlI51ixJD/wn6Tkm6AKHjAhqK1OlC1MkJUqXnKXW0c9FvBC5GayrO8OdbewsZnKNO6by70Jk+YvbBvvWPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oaabMC6KuoXRcUbk2Vz6G3WiDfcnM0FpmgUEi6OobY=;
 b=JHIUZs0KP8nVDJRMx8MIUKGg1YOoed5FizuEq/UjJQ06NG+ocdgUa4cuMcR5jWXesB9VAXldx8cmUR1KVp9pHO+n8mhSMRbazRTFlsKHCqJEkz/mdG2TpoNgVOu+UOobBErllbX5BOjfgKK0BQ9nDC729fEdCPOAIbYtxlyj0YIifWMfczQO0dYRB2m2AhT6Tuk7uVIUnE+7MkBql57ZzmDxEEMhF0Yd1/pt+LYzjrjj8oDcLtLzISBRFKOYPJ8DuOY+GhsMTnKj0dGQClC8ek3zzcLvNqFB0cL+8CGfLTBYc4Fqf1aseO0bVXzR6Jvi6j+FZk9ezzV+Nytu03trzQ==
Received: from SJ2P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::8)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 9 Sep 2026
 15:28:38 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::58) by SJ2P220CA0009.outlook.office365.com
 (2603:10b6:a03:5da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 15:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 15:28:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 08:28:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 08:28:11 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.46 via
 Frontend Transport; Wed, 9 Sep 2026 08:28:09 -0700
From: Wayne Chang <waynec@nvidia.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, "Thierry
 Reding" <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Wayne Chang
	<waynec@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: typec: ucsi_ccg: Add retry mechanism in ccg_read
Date: Wed, 9 Sep 2026 23:28:05 +0800
Message-ID: <20260909152805.6254-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ed4e1b-dc37-4dfc-24f1-08df0e870544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kcrEm7rZLwI6rVK72HmGoJ45cH3vFG2NP/EiUxDwILYhtRorZNoI5hVm5zG+9USivsmskmwpWAqMXQo1ESfrDYqkT4cO7FgneWvw/dJXp6ccpuRfH93TknYR96LFxEQ3QWkr9/ghhTtUdSFglNbNQqwDJxhEI/EgZj4P2cMbvmchlgf/oAA0M6gbT8VfUx6Ml90ihOQ2PGrr5+VryQ64XUOYBV+37qugFVtnTePk2FUvtl1FNLd4672hcR5di+nmVGiqrksIK6mXS+dNWABw9+eAKutvad3TcN/fGbd8GXKY/4TvNNnm4qzFkq97W30kF6ygirxl7V1KeVJ57OmakA4GFr4TJbbWwEGzkBEjEpq+tTteLOH4ZohPEJQJ0OrV2ow4F/df1VZDjkRKcHPbfOkVWxL+4wa+ncnXGWenwiFZrfR7wyL4XVeithIHhWTtVw9FOjd5ksXimu7AG0VPpnO1ghnbLptJq3AaB2NQ8tVwPUlktGjX1tKG76MTVoaaB5tqYAV9jhPWiIbpfnmoaDCUYqBB9XMQw41n3xLY2SHXP0VCOZFOUKrhk/NvDTOcVlLsoC5xXykCeA6bkyIQZN461o+hhh4bk0ANKCPL6xo/FClTF+7rh0PWLR4EFK8FvMJs6VehpV06xkYjvc2mEowjBpo3YYhdNx87XUZLJiwauwDYPA7HtRH7/f5BDFyA6G+qbhM4bchvmjEkPDVuag==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0UeEb5zlEjcWEhAHU4zmVDalcFgA27+mnc7+P4iIKIBFiGKIs5EZm4riz6T6Czq/Jz9EscbkdLCVFK6g55kDZPTC9jTHpUF3jgBpr9xQUOGeNpfNyMwtfaTHsVfLQtK2mujNhkI9P/fd66gVm9k0+dCD/Z14Jy22+UlgegOUTchmkBibihtWewJMh34v10gD7HEFFASfR3GxiF32lp+fMRPNV+jtw8h0gJKym6lyOBlecUw4bukFs2YW48Zf8tDwDL8f210PfsjgMS2nbEMhNrRA/hPzX2F7DsF6dU4HMwnqbAhyGyENVuwtuVF4Tp/jk91zatghdhj/7cGfdWny6R5xOamMaoEWApygp2SsfCwfD37/MV9vABdRzU43AW7UpDIdBs6yhzmF1py0JseIUloMXpxNRXIeP75SZHhlX/tvHWGFn76A6fQ79AK3OkIl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 15:28:38.0241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ed4e1b-dc37-4dfc-24f1-08df0e870544
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

CCG4 firmware occasionally fails to respond to I2C read requests,
especially when reading cci and intr_reg from the ISR path. In these
cases, i2c_transfer() returns -EREMOTEIO.

The CCG4 is EOL, and Infineon no longer supports firmware updates, so
a software workaround is necessary.

Retry the read operation up to three times (four attempts total)
when -EREMOTEIO is returned, with a 1-2 ms sleep between retries.
This allows recovery from transient I2C failures without affecting
other error paths.

The sleep is safe because ccg_read() is called both from process
context and from ccg_irq_handler(), which runs in threaded IRQ
context (registered via request_threaded_irq() with a NULL hard-IRQ
handler), so sleeping is allowed in both cases.

Fixes: 247c554a14aa ("usb: typec: ucsi: add support for Cypress CCGx")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 91c2958a708c..da8beb14d84c 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -135,6 +135,8 @@ struct version_format {
 #define NVIDIA_FTB_DP_OFFSET	(2)
 #define NVIDIA_FTB_DBG_OFFSET	(3)
 
+#define CCG_READ_MAX_RETRIES	3
+
 struct version_info {
 	struct version_format base;
 	struct version_format app;
@@ -255,6 +257,7 @@ static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
 	};
 	u32 rlen, rem_len = len, max_read_len = len;
 	int status;
+	int retry_count;
 
 	/* check any max_read_len limitation on i2c adapter */
 	if (quirks && quirks->max_read_len)
@@ -266,7 +269,17 @@ static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
 		rlen = min_t(u16, rem_len, max_read_len);
 		msgs[1].len = rlen;
 		put_unaligned_le16(rab, buf);
-		status = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+
+		for (retry_count = 0; retry_count <= CCG_READ_MAX_RETRIES; retry_count++) {
+			status = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+
+			/* Only retry on -EREMOTEIO, and not after the last attempt */
+			if (status != -EREMOTEIO || retry_count == CCG_READ_MAX_RETRIES)
+				break;
+
+			usleep_range(1000, 2000);
+		}
+
 		if (status < 0) {
 			dev_err(uc->dev, "i2c_transfer failed %d\n", status);
 			pm_runtime_put_sync(uc->dev);

base-commit: 940de590b839f71d6dc846160534bf202401b8b7
-- 
2.25.1

