Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.44.14.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526688;
	b=Iy/MeXQl8xSXGMeGFJZUnpM67uQM3drpuJgc+vVM6r0y5mWRPi022HAr9FL2UOO0djLo
	 R3duPBBFech7Bk6j3b9qQqECUXJ5imCWyanUNiCLi4Vmto006OfXV+VoGTk1ASG56h0jZ
	 646bDzXcnMWEsAIqkgMaoN9WRPvAQ2qKAnqyO5wajQekTdnAgGSYuhy6z4EDk7iBYoEyb
	 e5E+wfvO4A5BRjX/E1KBwVDKa7N1+OfKAnWE8YTYw5Jtaz0w/qHLFtvkaLy0bYqk/tNy1
	 zavpbfJ2ZYIBuV4lBLHPLy8RekjU8wmW9YYBfRI0eoGgFcdI0rUa2Mxd/5QkeHlO56w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526688;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fk2IuaBvGlXxlTrtOtv1YxVQ7SMykl84uczNc/ER+x4=;
	b=xnlVbJPjV1/9vFidvyAZT9Bixe+RIF/5fGheDeyGEZgl9JxJ1Lhm87MSEXLsJyjn7pYF
	 zufZUELyfVFZ2Vo/kSuRX3HNpHt6BrGYfES7Dtf+dO5ccgrpIktkWDB+OTCpgsD4D5RDA
	 MjChHBRFQjs9mPNsq/9Hgn/VRnZK1VkhTodRoC307+sUOgUVTTEQZFY93Fmiz1ZpcvazC
	 /vgbhD35Gxj6czZf1+rtfgraSUET1D2WRH2O+gyg7yBKm4IGUkBTPTeqjqsmcYUnwD2Y9
	 0baDC0OPAEnxhH5tnGdDURPi+VkTq+5I1gC+2QmSpCGmrRMgCIY+ljG+ow8x7dMUBjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=LAqUTiHb;
	arc=none smtp.remote-ip=31.44.14.20
Received: from forward504d.mail.yandex.net (forward504d.mail.yandex.net [31.44.14.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6E606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8B6E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=LAqUTiHb
Received: from mail-nwsmtp-smtp-production-canary-28 (mail-nwsmtp-smtp-production-canary-28.yp-c.yandex.net)
	by forward504d.mail.yandex.net (postfix) with ESMTPS id 80DD0100418;
	Tue, 24 Nov 2026 16:24:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-28 with ESMTPSA id YOg8RW3Xma60-ty8i3vw9;
	Tue, 24 Nov 2026 16:24:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795526678; bh=Fk2IuaBvGlXxlTrtOtv1YxVQ7SMykl84uczNc/ER+x4=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=LAqUTiHbAFWC0sTtzT02pzAafy1xxSzGztdMHrUZaZphA8YKtSJX27hhALzb1ugkz
	 M+DELfE5wTQpB1huljNZpI/WyG9i/wWVDO/vcS9qjr2i+nCDAbCvnJAMiHYnwWFgxi
	 aNmCdxlO6JX++05PjW3yffhdNe+BBdSRGeFaChsc=
Authentication-Results: mail-nwsmtp-smtp-production-canary-28; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org
Subject: [PATCH 5.10/6.1/6.12 2/4] HID: roccat: use atomic_t for device status flag
Date: Tue, 24 Nov 2026 16:24:32 +0300
Message-ID: <20261124132434.134814-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124132434.134814-1-dmantipov@yandex.ru>
References: <20261124132434.134814-1-dmantipov@yandex.ru>
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

commit 6569d814fa49384e3e0f4f41947ecfabf2eb93c8 upstream.

In roccat_disconnect(), per-device 'exist' status flag is cleared
with 'devices_lock' locked but both roccat_read() and roccat_poll()
checks this flag unlocked. To avoid data races, convert the flag
to atomic_t and introduce the convenient roccat_device_available()
wrapper.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://patch.msgid.link/20261022054454.238343-2-dmantipov@yandex.ru
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-roccat.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 12953852b465..648b42c2101b 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -40,7 +40,7 @@ struct roccat_device {
 	unsigned int minor;
 	int report_size;
 	int open;
-	int exist;
+	atomic_t exist;
 	wait_queue_head_t wait;
 	struct device *dev;
 	struct hid_device *hid;
@@ -70,6 +70,11 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICES];
 /* protects modifications of devices array */
 static DEFINE_MUTEX(devices_lock);
 
+static bool roccat_device_available(struct roccat_device *device)
+{
+	return atomic_read(&device->exist);
+}
+
 static void roccat_free_device(struct roccat_device *device)
 {
 	int i;
@@ -105,7 +110,7 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
 				retval = -ERESTARTSYS;
 				break;
 			}
-			if (!device->exist) {
+			if (!roccat_device_available(device)) {
 				retval = -EIO;
 				break;
 			}
@@ -149,7 +154,7 @@ static __poll_t roccat_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &reader->device->wait, wait);
 	if (reader->cbuf_start != reader->device->cbuf_end)
 		return EPOLLIN | EPOLLRDNORM;
-	if (!reader->device->exist)
+	if (!roccat_device_available(reader->device))
 		return EPOLLERR | EPOLLHUP;
 	return 0;
 }
@@ -226,7 +231,7 @@ static int roccat_release(struct inode *inode, struct file *file)
 
 	if (!--device->open) {
 		/* removing last reader */
-		if (device->exist) {
+		if (roccat_device_available(device)) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
 		} else {
@@ -345,7 +350,7 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	mutex_init(&device->cbuf_lock);
 	device->minor = minor;
 	device->hid = hid;
-	device->exist = 1;
+	atomic_set(&device->exist, 1);
 	device->cbuf_end = 0;
 	device->report_size = report_size;
 
@@ -364,7 +369,7 @@ void roccat_disconnect(int minor)
 	mutex_lock(&devices_lock);
 	device = devices[minor];
 
-	device->exist = 0; /* TODO exist maybe not needed */
+	atomic_set(&device->exist, 0);
 
 	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
 
-- 
2.56.1

