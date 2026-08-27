Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09483905FD
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805613; cv=none; b=Rt0xkrfnUWjTBPuX6SrbFTowgD9/LhQQ/U7mWsb1pNdQMbaxXqlYlI4GMh/rDhCoKGyaEYXapOoYoXsAOM7OQd38GKxqqNgoCxjEDE0chv5cLZEa+fDayRyr9+w8p1MOVTfZ/5Hi3GQ4qyhDEAZ+nn1nr42buem1ay9Vl3fpOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805613; c=relaxed/simple;
	bh=nq7rfwIiOi+70cNPttBUAcz7rBFHP3AgkKsO95AGi6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRJYZ+uSudm/LlegoRFzIiBww8uuK0Bx1Rzh3ih56S7tTBMhzc+FVuH9JQLqLrJBp6E4lqgEbnGhh8oHLSMig6XXGImeQHFhb8JxGUISMfeiW/PG/otEcEa9x4GBPUAG+aBlUT3dacTi7Fhkp+xKdEDGwv/sBLHXPmWvallavfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD9Kqw48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD9Kqw48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A6F1F00A3A;
	Thu, 27 Aug 2026 04:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787805612;
	bh=5RaYilTHCObGUjGVhECyCYSW1RIHrpe6PLY1xGi76sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PD9Kqw48w33pcjkBnVv8F/NSADMlMkUhFMUvPJklYh6E60kcJMcg9MGW4JaVHLl5j
	 VC2vAxJVa6igFii02TdoGY3ZYbP+gSgDOe1AWra8YnGAhsy3A5acg/J7GFcXyoya41
	 W7yMdDy2XB6Wu2A/F9qRrGar5foOXJ/BmhrENgiGUnhLpvZvBznH+z8teduLWyfate
	 L6ZGG174Dzsn1jhHh0kq1tDJU2tcj9jS4R1n0kq54zWgmfcT6HTCE6kwKq3F5bLXHL
	 +S4t4JvcpbGbdar99WpW6k+ZmwO7Sc827/Jb8vbr00y/HZtEjwn+SXIi4dDH0m2UBT
	 m+bQgZ7uN5tjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Enrik Berkhan <Enrik.Berkhan@inka.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/8] HID: ft260: wake up device from power saving mode
Date: Thu, 27 Aug 2026 00:40:03 -0400
Message-ID: <20260827044007.3635916-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827044007.3635916-1-sashal@kernel.org>
References: <2026082538-obstacle-cogwheel-cfc1@gregkh>
 <20260827044007.3635916-1-sashal@kernel.org>
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
index 6f6bfd305e229..d3c33c1b130c9 100644
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

