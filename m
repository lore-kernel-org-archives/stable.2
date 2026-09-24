Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BF483BF9;
	Thu, 24 Sep 2026 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262719; cv=none; b=Oko/FesTwU6e6VpbBokXky/YYH4X9oYzIgwm1efIbuS2C4qAxUN8vLbbFB8roWlTJaMVFD+PxUfgN1SVJauetddjv3ppIYxd4LvrSnrZcRyuXfXqtaozCQdNxQH0vZWdjabXkIQLaR1LOX2w+FpG+IfSoqh1nZJwtGehk1Hr6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262719; c=relaxed/simple;
	bh=z1fVKQyG3kFh+BFPM+VltqdXwbHV1NcguUr7+MG39BI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jnq7BOPvS/ABZvKw7mdsLN2qeLHHJEik7VTFRniAJpaTCqa1NZwjd/eGDqx2HukYKgi0WXvO4PKfzNHWU2TP2CRL70lRMiYsGBZPpvG7U16dqwqQoCOQRqVXdtjkz4pivN0JoyMF1aRF5AfAc256BOhcrtIUH9Yz0fVF560JkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G3JVPnOD; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G3JVPnOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1v
	f4XxP+OrgVyIzX4zJp2UaohykwkBrQmwM0c+DeFPE=; b=G3JVPnODi6U5Gwo8yS
	af5kZXjuEODqDcYd5Dc1l8WxeDhFhk/rGPxne2Xod0GvicxPCxqfHRQFlVAQrv/+
	VIp6naP6MkOcZwilKXU8KVvJgqPKzXrHx7q7FeS+Dct49E1KkscyerbnlhNpboUQ
	F/1i8q2A7efZfWKBq+LibaWeU=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnP2imPbVq6eE9Ag--.8701S2;
	Thu, 24 Sep 2026 23:11:35 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Aleksa Savic <savicaleksa83@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (gigabyte_waterforce) reject short input reports
Date: Thu, 24 Sep 2026 23:11:32 +0800
Message-Id: <20260924151133.1233860-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnP2imPbVq6eE9Ag--.8701S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWUCF4UCr18JFW7ZFWfuFg_yoW8ury5pF
	W5AFsxtrWUtrWfXr1DJa1UZFy5XF1rJrW3Wry0939YqF1UCry5WFyI9rZYqwsY9rWrKrsI
	ga18tw1fKFyqyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi3l1DUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgeAumq1PafViwAA3o

The HID driver raw_event callback runs before HID core validates the
received report length.  waterforce_raw_event() reads the command bytes
and then accesses fixed offsets for firmware or status data without any
length checks.  A truncated report can therefore cause out-of-bounds reads
and update hwmon state with data beyond the received report.

Require both command bytes before identifying a report, then check the
minimum length needed by the firmware and status paths before accessing
their payloads.  Commit 47669bec44fe ("HID: asus: refactor the two
workqueues and init sequence") added equivalent raw-event length
validation to hid-asus.

Fixes: 42ac68e3d4ba ("hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hwmon/gigabyte_waterforce.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyte_waterforce.c
index 4eea05f8b569..9499cb274cbd 100644
--- a/drivers/hwmon/gigabyte_waterforce.c
+++ b/drivers/hwmon/gigabyte_waterforce.c
@@ -257,8 +257,14 @@ static int waterforce_raw_event(struct hid_device *hdev, struct hid_report *repo
 {
 	struct waterforce_data *priv = hid_get_drvdata(hdev);
 
+	if (size < sizeof(get_status_cmd))
+		return 0;
+
 	if (data[0] == get_firmware_ver_cmd[0] && data[1] == get_firmware_ver_cmd[1]) {
 		/* Received a firmware version report */
+		if (size <= FIRMWARE_VER_START_OFFSET_2)
+			return 0;
+
 		priv->firmware_version =
 		    data[FIRMWARE_VER_START_OFFSET_1] * 10 + data[FIRMWARE_VER_START_OFFSET_2];
 
@@ -269,6 +275,8 @@ static int waterforce_raw_event(struct hid_device *hdev, struct hid_report *repo
 
 	if (data[0] != get_status_cmd[0] || data[1] != get_status_cmd[1])
 		return 0;
+	if (size <= WATERFORCE_TEMP_SENSOR)
+		return 0;
 
 	priv->temp_input[0] = data[WATERFORCE_TEMP_SENSOR] * 1000;
 	priv->speed_input[0] = get_unaligned_le16(data + WATERFORCE_FAN_SPEED);
-- 
2.34.1

