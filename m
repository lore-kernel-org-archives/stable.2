Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839913EA947;
	Wed, 16 Sep 2026 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539579; cv=fail; b=HAFCDK8Pdajb1h+nWr/moThl9ZaHSuLApfY4oUk9SpspwLdLXid0f8VF/2yXPa7U5dOYsTQfahzLSjgBIJdOcmexwWEiVR5M6q3QgNCImfTcbP3X6x53xgaS6cWenFYk18ZRtT7xU3AS5nfppXNj562OrrzpO4823+c4pMwo3Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539579; c=relaxed/simple;
	bh=8wXTW1yyq5+HtYuFZzNXZp8JK9ylrqOp538DZ2E9kIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ycn4x0boZfD+UBmPang4JvEzsNacyngNfNUG/QDoL7qT9+rMpGkXFJcVluEMZGzdWP6a5ANgkPriV1S+NECnl7sOM74OG79vIjqPNYmXqdVNNHyj/U1F0rYZTzEJS2Vyqua/VMdwQ4IAw6RgkhKA/lNX9tEJfgVz/lT15FbJyLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HwQqGVBg; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HwQqGVBg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrUanpiDssj5T4e7GSXTiaGOG7e5Gp+PeST7KbkqPtmNRqiCZnbHoO4JKd7hFWWg8cJo18aKKasARPhYD65Y4waQLc2wtF1MkL29hA48UyyH2bFWU4dQVM7USCPAjuKXYW7XNpckhKQPne1FLCN55eCCIKCPAsPjgtZrmfRFxG1XqsF5Kis9JxO8fn7yeJZvnLdCHjea5tEeC2X4VL9/aO7Dg6ZOMRHW0zO1ZPAF/xmLw/TjdG5tnJzCM8WbfzYKFxhPrMT9SsZr3lpFUWqp3pXusXjsBkNX2wPLt39jpBJmv4guMNK1ZOM7dtR+YgjCA1JeAW6gx4U2AonU3P/9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0dbx7gtwFJQEItRfIgGeOtdzNXBuPR6pUDWioKJ5G4=;
 b=lRXxioiRIqhjIttYtQWSTUqExADzRPTFoZ70WRx8HhCkcKiW8z2vXKigcMz/gnKKqeH1Vw4tLFQH9z6KI0sc6tDZIFHaGQKD72YrbPM3S2eKUDwb3y2k+zmvCe5CyuOIPi03hVn2q2lMGL3n0iuCaCVIYf1vkRPQjd7LYJoOtF6ed76tDwDna9KgIvGS5FanABJTbC8CjbwyhxELy8YCcS3kUntRvdb8a4haWgISE6YLCUzHY+KIqPbypXgGzCt7lnuOMLyYav3O9qbqFeh9omIVSpm17SkSPMNzJ3GEfQcRB2adJyKytAipIAUQ4iQR3Ub8eTgep1cgGwvLKuXL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0dbx7gtwFJQEItRfIgGeOtdzNXBuPR6pUDWioKJ5G4=;
 b=HwQqGVBgwQ9wKJFKsls8E92VGg4GW9TQ5qwR49LSA0rl22eRpRLacuCC2r0NiJ/RYeUbMTnjT9JRnU4hwK0GLoPXWqB6CyIqu+x99RXosTj8xF3BhB5jHwbUZVu+GAgJbH4Zjjn82J/Fh6E2QH0+ORSRmxhmfq/egA1kTbYjPtJzfNxZ+fBkJvkiMMCgvJuk2X607UGnthkzCTK0yWNWf30eGXW7YOZPNBhBGHOdmbyMbH2zs4P5ATMTmu/tTB89fTbU+ysjb+Zc5g/z1ojznf+8o0vTUyySKAF3rkMyreJEOdGInu0IdIOMpfy3IgkMndXogB19Oi8Mf+xRxk++Qg==
Received: from BN9PR03CA0511.namprd03.prod.outlook.com (2603:10b6:408:131::6)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com (2603:10b6:61f:fc00::629) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 06:19:27 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::24) by BN9PR03CA0511.outlook.office365.com
 (2603:10b6:408:131::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 06:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 06:19:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 23:19:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 15 Sep
 2026 23:19:02 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 15 Sep 2026 23:19:00 -0700
From: Wayne Chang <waynec@nvidia.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, "Thierry
 Reding" <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Wayne Chang <waynec@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] usb: typec: ucsi_ccg: Add retry mechanism in ccg_read
Date: Wed, 16 Sep 2026 14:18:58 +0800
Message-ID: <20260916061858.1471606-1-waynec@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6fbe48-c47c-4d24-b775-08df13ba7450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	OhXZSQ562eMtNUz4GjLxdpkkYJ8kQh3Vijgg7UAhUyiqYYsjnP/fG5r93CCS/BpCpaxXIn0YefCSwlW7HTxE1/E4/yn/0L+iaUskFsrYtL8mTlbkZ9FnMOs9VCz94HEfH8FyYtk72G9CASiwXQwGC75tj/8+/TLmuolhBtjWe4sUHiEjR+8qe5YTcOQj1n7/HECkIYefYC1euYrYWh+McuBgLbaxjUTZ2I1lXDHsxwbU/SsQRo/pEMKtUxmlAw2GziW2RFGoHa2lEEkcypTHhVx0pLhSi2K67zagjdZ8/zJnwlEJOa8B1rvJj3+Wz3BOvPqPmfKNiIcCzVaZHmtkeeV8i6qNKAmlL2uumyZ8xo4D2AQQ7FYqLATFZ8tLluggzbmjL3QRuEjbTUS37F4xI8MDWUFAzf8Wa29DaA3N09U99Jqjq4l+m8VyUNpfAjmX+82c86TRvKHeRaR1447cewjezR5rbhOa6WVRyFf3XGAdNIsmk7s5UXjsqDK4z6OTnUK+buQonaDxsI7wZonOwsWRxUfBnTgMqQSNH5ZPzSEu483PYmvXcX2A8CilWH8Sh2D4PFe7tjCmjA70LLqb62lU7KcAajqArPBiX2vhA1NdtthSDoPlAgELjQ4KWrs3hPnKrNYXiv/7cd1O7och2JUfm9sbgjNpUbVPkNj5+c4cIG5aGJa9TzG0JnNjiH6MdhakDKnlpxvKwdK9e/vH1Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IyPwY3z03j3Oibl7S1BQsQ6tRw2XPW8/JYbJ/+D3bvo2LA8qNw+9W0UvdXeMk5GnvPc0UExEIvH8O6QNt0tu83cDjx/UWvSWrcYgctQNa63O9t9MUL7GT0V41QrxduyidBm7f+difdF/o7Z4hOx4cee/L+uW62Q0tMLYTY+R+7Qrddy2zFJptRtcyQjOwmSYFp7cCEWJZ14LSxzfbHTd8MOXmKroDsw0Rz96OQklHPXAcpVbh9VFuOZSaOb2KvhUPu8tlSfwJbsStMiSU2fx0lxF4FWfwQZxoezlWRr7K6JYNQD+/Uk1NgfFWqNQ6EIUZsBmnNCwcE4VlDANTBMipYH4yI/A1QZCoW5DzU/YZI46St4qI9QUtanyF8qsRpeSRrCCLkvMfIBfqSkhKMKmTCwSoRmySgEwGP56bUFWlrDuDV6G07yBy4v9+CeYpHNp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 06:19:24.4114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6fbe48-c47c-4d24-b775-08df13ba7450
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2

CCG4 firmware occasionally fails to respond to I2C read requests,
especially when reading cci and intr_reg from the ISR path. In these
cases, i2c_transfer() returns -EREMOTEIO.

The CCG4 is EOL, and Infineon no longer supports firmware updates, so
a software workaround is necessary.

Attempt the read up to CCG_READ_MAX_RETRIES (4) times in total when
-EREMOTEIO is returned, sleeping ~1 ms via fsleep() between attempts.
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
v1 -> v2: Per Heikki's review:
- Fix off-by-one: CCG_READ_MAX_RETRIES was 3 but the loop ran 4 times
  (retry_count <= CCG_READ_MAX_RETRIES). Changed the macro to 4 (the
  actual total attempt count) and the loop condition to
  retry_count < CCG_READ_MAX_RETRIES, so the name and the loop bound
  now agree. Adjusted the "skip the sleep on the last attempt" check
  to retry_count == CCG_READ_MAX_RETRIES - 1 to match.
- Use fsleep(1000) instead of usleep_range(1000, 2000).
- Reworded the commit message to say "up to CCG_READ_MAX_RETRIES (4)
  times in total" instead of the ambiguous "up to three times (four
  attempts total)" that prompted the off-by-one question.

 drivers/usb/typec/ucsi/ucsi_ccg.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 91c2958a708c..4b6c53d2a998 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -135,6 +135,8 @@ struct version_format {
 #define NVIDIA_FTB_DP_OFFSET	(2)
 #define NVIDIA_FTB_DBG_OFFSET	(3)
 
+#define CCG_READ_MAX_RETRIES	4
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
+		for (retry_count = 0; retry_count < CCG_READ_MAX_RETRIES; retry_count++) {
+			status = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+
+			/* Only retry on -EREMOTEIO, and not after the last attempt */
+			if (status != -EREMOTEIO || retry_count == CCG_READ_MAX_RETRIES - 1)
+				break;
+
+			fsleep(1000);
+		}
+
 		if (status < 0) {
 			dev_err(uc->dev, "i2c_transfer failed %d\n", status);
 			pm_runtime_put_sync(uc->dev);

base-commit: 940de590b839f71d6dc846160534bf202401b8b7
-- 
2.25.1

