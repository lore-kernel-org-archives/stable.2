Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915546;
	b=3NOdF7LXLgBXBykXGmtv1mn6u7pULVWvME2y4CoTzOemX887vBO5dnwnqyi19PD2tuPC
	 C0OAAmHPg+MS8izFCF2J3T0DQLgoIzItF81zF5FsbsvVLBELQs+qevetULP0JUiG6bgJl
	 aexPF9/o2oXsuxTUHlvOXpZ4b/4N3R20UDOkIiBgcYNDpe0KBLfBil02zXQkPrifZBxiL
	 XuoamqH1Q+AVvbmF8to3AT//CLYzWj8mBwD6VkxXaGv5Gk65AX/OrQZisNXkO9jCktErw
	 Kd/RKPMRkV3kmBVIW1HZ4QBeE71WLJ/l9gw8yyKXu63ianQPjty6K/5GymQ4Rf7NDcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915546;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=5QFm4/7llb/j/07OzcUIgHm6qGl30pGitU6RrQ/neVs=;
	b=jaV07fCBMSE2Pvoy/RZPgYWw0M4/0J+D0uA+/6QG5FoKJcEhQ4V5CBO3H1gjQ0b4knoT
	 QKwCiK4+Dn5YDbZjsWuX0GYQhQB0ElgVGA1aCC9lCjmr8/wsww8weZVWG+s2WqmRimeVa
	 FNKPWFcU9SWqn0dBGgiph3reXcJf0Wl5SSU/Rszn7XuDQMNWW6I855p8VhhTl7Ng7SxYw
	 10QibykqWR90ucFKqs5cgs5PYvfCs7JXmoGMQekmiLSwyGN0CZc21okYl/Y7hqqtkFwam
	 4RcHah/rFpTZWrQUvXHsn01hgrGzswZosW8MAmuFr5jqaL393ZOymhZUfJRuaEwQPOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=boo9cVih;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB3606A31C;
	Tue, 17 Nov 2026 11:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4AB3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=boo9cVih
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794915520;
	bh=5QFm4/7llb/j/07OzcUIgHm6qGl30pGitU6RrQ/neVs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=boo9cVihgo6Jqix1XpEmeBcSaPct7Zl8kp/6/kRmzPjlZikfkvpWC5nAvJ+7RuW1n
	 Yx0ijCDK5lSvC1bryXQIPCr2Wej9dGWLQfk7+xqlQvhDkyx6gZubrpWDzH9OgS7sAm
	 pUHfW6V5frSFPHrWise+3eq7eVMNbwTD19xiOUWg=
X-QQ-mid: esmtpgz13t1794915515t6b445356
X-QQ-Originating-IP: eG9PVL/S70p3ZY5sbdOW2QvStsmEFfLnDmJFGp9BGaI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Nov 2026 19:38:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17527824163099040394
EX-QQ-RecipientCnt: 5
From: Siqi Chen <chensiqi@uniontech.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siqi Chen <chensiqi@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (pcf8591) Propagate channel access errors
Date: Tue, 17 Nov 2026 19:38:19 +0800
Message-Id: <20261117113819.3336050-1-chensiqi@uniontech.com>
X-Mailer: git-send-email 2.20.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OD6FFkn240CDbIOb/5HyV7pBJQyRknUwa5fQvDWGhHvSgtwW4OITrtOk
	HTDoj9cyyNQOBCBCAjDPTe93Aa12fxh2SyWoXzd4mJo/BNuAyLYczCvAtBpa84NsS+TorL4
	lJNDmYTxJePGBlnHTLgJYWiqtMJuboQN+1K1+e85qMud/tWgFIDBRxM8EU+U5yZReeKt6Aq
	bvDjDFO9cTBvj+5uiXT9kwOvPZIl7B6y52TinYGI+pJJB9K1PTcHU09C7nzDFG5aQPxdRFy
	uD71zxx7BVGnREneIjX41SGgb6Twt8oSQCknvtVU+jBkm5n8VnOOtZ1INUfENIuMHJ6iIer
	xureP0klczkOMi/cuJbN4cENZYJf7pmdFjA6sNiosZ8fsEgJtOPP4oDqVaEWwptupusVxKc
	4p3lCkIswkpcx0ZCOXr/zor7tp1OXsN/8UA7PUSFNAJMmIT7Oz/kJywmtbEWzI5DTYQLZlU
	3iwspNrLatqQeZZjNU2owsagQsVRO9TeJcl8uIqOqbG+2Z0zGgqW77Lt5bVVW9uE3EZdpV0
	YH/uphu9Z/lpvIybsCJftIAq5fxgtpMWHOMyWy1Dfx+bXtDUlu14ffbPYvFHnuob0ML5v62
	umbPfhb3DuE7Epkmcc03waTncZ6kLzaeGVlSPUv+AD9lSyWRtAg+8ekKOeIn/hbkFU/ajH8
	dDvCmYsE2zapGKhD9vkleIRIrYEUsnCCtuXNIoryWZwHEJcXfR8G7gZeCmiJEaFVJ2EWeww
	kOY06OsGeDn+I9q5rHJNO9E3h8sx4UnAFLD7l1NYWSJMkNNW99c0rEuhuQv2TUpkZ/OQMW6
	PhA01TFum1Vtr3nytBqcr2u1BUf28E+cZcRCEzdR4D4BYNbIInxGZUsnIOtaq6JYnR5oHGy
	HD8riWmn3+OAD1EOkq8WhMcPEYzEaSe98rrnNFad7IJno6eHbKu65UrR9ydFa+ui4lyaf2B
	7/1W6KNGpawHtLy89sS9f0oBS97+qpPU4++b47HnJFNeTYn3zGynwH8RWKL7M0wH4B//hkr
	mLWu/mev+nGcv/ZXoFbyOjXGsHYL9xLP3epd6bwCbjUPWmAJFs
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

The SMBus channel operations return negative error codes on failure.
The final read result is stored in a u8, causing an error to be
truncated and exposed through sysfs as a valid ADC value. Errors from
the channel selection and dummy read are also ignored.

Check all three operations and propagate their errors through sysfs.
Keep the cached channel invalid until both channel selection and the
dummy read succeed so that a later read retries synchronization after
a failure.

An AI coding assistant was used to identify the issue and help develop
the fix.

The change was compile-tested with W=1. No hardware testing was
performed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Siqi Chen <chensiqi@uniontech.com>
---
 drivers/hwmon/pcf8591.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
index ec98e6b66c49..602d0caeaced 100644
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -68,6 +68,7 @@ struct pcf8591_data {
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 
+	bool channel_valid;
 	u8 control;
 	u8 aout;
 };
@@ -81,7 +82,11 @@ static ssize_t show_in##channel##_input(struct device *dev,		\
 					struct device_attribute *attr,	\
 					char *buf)			\
 {									\
-	return sprintf(buf, "%d\n", pcf8591_read_channel(dev, channel));\
+	int value = pcf8591_read_channel(dev, channel);			\
+									\
+	if (value < 0)						\
+		return value;						\
+	return sysfs_emit(buf, "%d\n", value);				\
 }									\
 static DEVICE_ATTR(in##channel##_input, S_IRUGO,			\
 		   show_in##channel##_input, NULL);
@@ -255,27 +260,40 @@ static void pcf8591_init_client(struct i2c_client *client)
 
 static int pcf8591_read_channel(struct device *dev, int channel)
 {
-	u8 value;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
+	u8 control;
+	int value;
 
 	mutex_lock(&data->update_lock);
 
-	if ((data->control & PCF8591_CONTROL_AICH_MASK) != channel) {
-		data->control = (data->control & ~PCF8591_CONTROL_AICH_MASK)
-			      | channel;
-		i2c_smbus_write_byte(client, data->control);
+	if (!data->channel_valid ||
+	    (data->control & PCF8591_CONTROL_AICH_MASK) != channel) {
+		control = (data->control & ~PCF8591_CONTROL_AICH_MASK) | channel;
+		data->channel_valid = false;
+		value = i2c_smbus_write_byte(client, control);
+		if (value < 0)
+			goto out;
 
 		/*
 		 * The first byte transmitted contains the conversion code of
 		 * the previous read cycle. FLUSH IT!
 		 */
-		i2c_smbus_read_byte(client);
+		value = i2c_smbus_read_byte(client);
+		if (value < 0)
+			goto out;
+
+		data->control = control;
+		data->channel_valid = true;
 	}
 	value = i2c_smbus_read_byte(client);
 
+out:
 	mutex_unlock(&data->update_lock);
 
+	if (value < 0)
+		return value;
+
 	if ((channel == 2 && input_mode == 2) ||
 	    (channel != 3 && (input_mode == 1 || input_mode == 3)))
 		return 10 * REG_TO_SIGNED(value);
-- 
2.20.1

