Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2113BFE4C;
	Sun, 27 Sep 2026 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790499028; cv=none; b=hc2xv3b7LUq5iOHtc4YlOZ5cxGJNt+JWs7RdH0s7Pa2pXSOGq29Ewipv2FTSubeu8ONHLJomG8fQ1RytJe3mXOL+aAwgRdSqgdFlqUfUiucqcRDyFYL2nubyquVeyOhgK/b7vrQ3dMGWTh0tT7Lk+oWuIN7uUD0vsR2Qn2DRs+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790499028; c=relaxed/simple;
	bh=5LaDpU6fGaHrV0IgPjndRA812opNzIdESMeFYj+vRmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ydgcum8tujLakId68IukxkFAPabbguOpIAIAqdek5xj8BJ3ICBvaXo4yJV3luyw5SDYF5JhiTWLusYwIQLfkOwXzFVK2qPB0pND9QeB8ujMk/2XqyBYrYMMa4HIdO6iXT2rZ+RuPa624/+SqhbCmdO3bkrwGY4wS1kPLM60ykVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G/KdE+us; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G/KdE+us"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DA
	c3cvfHFxzrBCC2xcvA8V34m/HXJuo5iD2TpyT7ixg=; b=G/KdE+usNp/AfgATcD
	fKfjsU1+dS+JCzQe8PTOrtP9qq4ZTFUJ9cjEgQu/StFadIfjl6ZXlogp4M5CWjC7
	4hOW0jfUeVx1llB1hTxjF1Avo1lVU+a2hHG7I5LiAwIcYUsCXdHFZEDo3DNsAalo
	8Kf8DW8DHNtS+VlkaITo9eXeQ=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD339y52Lhqbg8gBA--.18321S2;
	Sun, 27 Sep 2026 16:50:02 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Aleksa Savic <savicaleksa83@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] hwmon: (gigabyte_waterforce) reject short input reports
Date: Sun, 27 Sep 2026 16:49:59 +0800
Message-Id: <20260927084959.893708-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD339y52Lhqbg8gBA--.18321S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWUCF4UCr18JFW7Kr1UAwb_yoW8uF47pF
	W5AFsxKr45tF4fXr4DJa1Uua45WF1rJrW3Wry0ka9YvFyYkrW5WryIkrn0gws8WrWrKanI
	gw48tr1fKFWDtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi8wI3UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhotZ2q42LqxugAA3l

The HID raw_event callback runs before HID core validates the received
report length. waterforce_raw_event() reads command bytes and then accesses
fixed offsets for firmware or status data without any length checks. A
truncated report can therefore cause out-of-bounds reads and update hwmon
state with unrelated data.

Require every report to contain the firmware response fields, which also
covers both command bytes. After identifying a status response, require
the byte at the highest status offset before accessing its payload.

Fixes: 42ac68e3d4ba ("hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---

Notes (update-waterforce-v2):
    Changes in v2:
    - Fold the command-byte and firmware-response checks into one minimum
      length check, as suggested by Guenter Roeck.
    - Drop the inaccurate hid-asus comparison from the commit message.

 drivers/hwmon/gigabyte_waterforce.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyte_waterforce.c
index 4eea05f8b569..f4d0376dd68e 100644
--- a/drivers/hwmon/gigabyte_waterforce.c
+++ b/drivers/hwmon/gigabyte_waterforce.c
@@ -257,6 +257,9 @@ static int waterforce_raw_event(struct hid_device *hdev, struct hid_report *repo
 {
 	struct waterforce_data *priv = hid_get_drvdata(hdev);
 
+	if (size <= FIRMWARE_VER_START_OFFSET_2)
+		return 0;
+
 	if (data[0] == get_firmware_ver_cmd[0] && data[1] == get_firmware_ver_cmd[1]) {
 		/* Received a firmware version report */
 		priv->firmware_version =
@@ -269,6 +272,8 @@ static int waterforce_raw_event(struct hid_device *hdev, struct hid_report *repo
 
 	if (data[0] != get_status_cmd[0] || data[1] != get_status_cmd[1])
 		return 0;
+	if (size <= WATERFORCE_TEMP_SENSOR)
+		return 0;
 
 	priv->temp_input[0] = data[WATERFORCE_TEMP_SENSOR] * 1000;
 	priv->speed_input[0] = get_unaligned_le16(data + WATERFORCE_FAN_SPEED);

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.34.1

