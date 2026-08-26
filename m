Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09546AA96
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766503; cv=none; b=XAhjRPyuqav/wiAsFZIBwGPxeORPuciOkM7GgchuXgBFvqAqPsrcvZZV+EMIFrBz3R3hnJeFN6E5ex8j4j2snXN9hUB6oZA9JwO+j1QG3StR0sR+uW3qo69BiH+rujKHPD/ADQRMoIfvp1p3qvx15lQLbea75his+oC26IUJA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766503; c=relaxed/simple;
	bh=amFDVCWT6g79MLaFrh2uc26g1eAPKwFS0ESm8xjSIfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAFFWi9ZsSvjV+X5dA5e/0S7V8BFmu/1MAXMk1QE4kJnjaEHrW1RvCxugEzpD+dBLWArJST1hyaLjgYen3VWTAtTsU0mHhz8VmyofQlARBSUP5h8GsM7dieroLMopMpF5ck7uOzNRNlRRQ4nGqW2Vnbggjno+z8HshjiWLw6C8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRlcnHZa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRlcnHZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181BC1F00ACA;
	Wed, 26 Aug 2026 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766492;
	bh=qfsv60XrPVYZ2qnJeXBnvyDWx5tU8Zn0KI4IF9oLQac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRlcnHZaylcBCjHWVaqIATXqn6YM+QVBoNLkiQ4TXaRd5jKRdNgula32BH2LcBAry
	 Br781AyqpbmpsY8X3eRzYdK7CHezvAfks5bIacTGnyeCklI1p3Rxb7SJXAVcBOBpx5
	 sQHfMBlsugqDjxrVIQXptHnKOq8vqwCSy/WR7ZiRE1NoH/qb7p9mTpuaaA6wxyhZ99
	 Z5O+o8DDnqatwm/7ZXdLVcVo5jQ5vfK2IJP8EbLGxncFJDFsb67I7t54ZP6qIKS524
	 9M0wsa5HH9nw2dtnStE2WZrYezciJl9vHiBd5K60YGin2XThsDpxzTnqQOR7JEGHB3
	 cIy/6yoaEgItw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Enrik Berkhan <Enrik.Berkhan@inka.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/7] HID: ft260: wake up device from power saving mode
Date: Wed, 26 Aug 2026 13:48:05 -0400
Message-ID: <20260826174808.2489782-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174808.2489782-1-sashal@kernel.org>
References: <2026082538-overhaul-surging-7a4a@gregkh>
 <20260826174808.2489782-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Zaidman <michael.zaidman@gmail.com>

[ Upstream commit 4b3da6853a619a952e8caf2e8393264dd42ffa27 ]

The FT260 can enter a power saving mode after being idle for longer
than 5 seconds.

When being woken up from power saving mode by an I2C write request,
a possible NACK is not correctly reported by the controller. As a
workaround, the driver will issue an I2C status report two times in
ft260_xfer_status() after the chip has been idle for more than 5s.

Co-developed-by: Enrik Berkhan <Enrik.Berkhan@inka.de>
Signed-off-by: Enrik Berkhan <Enrik.Berkhan@inka.de>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Stable-dep-of: bf3e39df3a39 ("HID: ft260: fix stack-use-after-return write in I2C read race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ft260.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 4c6c7dfdd6a71..3c4ca0016659b 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -31,6 +31,8 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 #define FT260_REPORT_MAX_LENGTH (64)
 #define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
 
+#define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
+
 /*
  * The ft260 input report format defines 62 bytes for the data payload, but
  * when requested 62 bytes, the controller returns 60 and 2 in separate input
@@ -237,6 +239,7 @@ struct ft260_device {
 	struct completion wait;
 	struct mutex lock;
 	u8 write_buf[FT260_REPORT_MAX_LENGTH];
+	unsigned long need_wakeup_at;
 	u8 *read_buf;
 	u16 read_idx;
 	u16 read_len;
@@ -306,6 +309,20 @@ static int ft260_xfer_status(struct ft260_device *dev)
 	struct ft260_get_i2c_status_report report;
 	int ret;
 
+	if (time_is_before_jiffies(dev->need_wakeup_at)) {
+		ret = ft260_hid_feature_report_get(hdev, FT260_I2C_STATUS,
+						(u8 *)&report, sizeof(report));
+		if (unlikely(ret < 0)) {
+			hid_err(hdev, "failed to retrieve status: %d, no wakeup\n",
+				ret);
+		} else {
+			dev->need_wakeup_at = jiffies +
+				msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS);
+			ft260_dbg("bus_status %#02x, wakeup\n",
+				  report.bus_status);
+		}
+	}
+
 	ret = ft260_hid_feature_report_get(hdev, FT260_I2C_STATUS,
 					   (u8 *)&report, sizeof(report));
 	if (unlikely(ret < 0)) {
-- 
2.53.0

