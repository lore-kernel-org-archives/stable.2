Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930548;
	b=VzY+ydSIBkU/tVEJ3C++5yDALIlnLqYrUuTPzwvj6sNEsd5U6PQZR6zmZLu4x0eZHrwp
	 LbKFFo7nZpICNh+el3WKDyXVgoEiYSdWMeumpUJit1SXd6A23+J18urv2RiCC2xX+c3Jy
	 3Yh43jy2MN0aUuYR6MEPKOtjjqcjenE/35BNUwDnLqoLf2Kl4aQibeJW/fRQP89cXl4bZ
	 SgC2Q6kzNv/7pCoWOG3vNQvPLZ/xT7jLAe9RW4AovVTdSGNNIuXzYWeV5rF71pj/TTf8f
	 bFXoSxdw82Vea8HTDseewQ1V+24xG30e3VlAx2Gj/FMUQO5RSfUPXCh0N1zhHIjqUwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930548;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pKmPuefvTAbfdN4jAqHdCzsBrC5bf2nTi/bHl0k4C9Y=;
	b=dyQiP6VjsdCQUSyz1LJ8gU2/TwuTh5Dx5K9WRPhV+2Jf1FXeWsNSw1AnnZ3K0geuuy5M
	 8RSs/qOiIboBqCR3sGW68A7zazVsL2LYyjDNAS7EU33b0TziO/KUBkyB3vuZ8uf8gxoQ2
	 Ttt1DhstAmOTXyMDUdF0aWQrk3MkQr+Acgj7ZY0y3ISgSv1zyw/n5pdJsgqXqr4o4O1UF
	 tpFrXb820R5i+Mi7wDYlt7tEjafOORj2TMGyzjPOzpSVpSC9f4l7jlsK+zLrH4Nash6Ev
	 sRc5fVdonMDaYb77VlBxlk1/1ZvveIheC4xS00etp9cjpculmfK48cSNS4GTujua0MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ladNjTS8;
	arc=none smtp.remote-ip=115.124.28.145
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E937606A31B;
	Fri,  6 Nov 2026 02:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E937606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ladNjTS8
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793930538; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pKmPuefvTAbfdN4jAqHdCzsBrC5bf2nTi/bHl0k4C9Y=;
	b=ladNjTS89SBkUvIF6eC4kNtp6THHEQ6TWrndAhaZWxqrPi2Y4EwN8GoJ7g2sxQEchyl/HueT0MT1rC3Uu8d7P3naI0G1UX0LtnukGC7u7qUVqbHmn6TiJpglD9zzi+u0VU0cSh93VH7PJVrsnS28/709iFOoXqnAb2XLaPM+6BM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2143449|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0535512-0.204086-0.742363;FP=3679924564259477098|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jxvJMbx_1793930537;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jxvJMbx_1793930537 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:02:17 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: xen-kbdfront - bound the backend-supplied keycode
Date: Fri,  6 Nov 2026 10:02:17 +0800
Message-ID: <20261106020217.48481-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261106014957.4130059-1-guozh23@xiaopeng.com>
References: <20261106014957.4130059-1-guozh23@xiaopeng.com>
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

Keycodes arrive from the shared ring the backend writes:

	if (test_bit(key->keycode, info->ptr->keybit)) {
		dev = info->ptr;
	} else if (test_bit(key->keycode, info->kbd->keybit)) {
		...
	} else {
		pr_warn("unhandled keycode 0x%x\n", key->keycode);
		return;
	}

The keycode is a plain u32 from the ring page, while the keybit
bitmaps it is tested against are sized for the KEY_CNT keycode bits
declared to the input core. A backend that sends a keycode at or
above KEY_CNT makes test_bit() read past the bitmap to decide which
device gets the event, and no keycode at or above KEY_MAX is a valid
EV_KEY code in the first place.

Since the event sits in memory the backend keeps writing access to,
the keycode must also be fetched exactly once: re-reading key->keycode
after the bounds check would let a concurrent backend write feed an
unchecked value to test_bit() and input_event(). Snapshot the keycode
into a local variable with READ_ONCE() before validating it, and use
the snapshot (as well as the already snapshotted pressed value)
throughout.

Ignore keycodes the bitmaps cannot hold.

Fixes: 4ee36dc08e5c ("xen pvfb: Para-virtual framebuffer, keyboard and pointer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---

v2: Snapshot the keycode with READ_ONCE() so a concurrent backend
write to the shared ring page cannot feed an unchecked value past the
KEY_MAX check (double-fetch, sashiko review); also reuse the already
snapshotted pressed value instead of re-reading key->pressed.

 drivers/input/misc/xen-kbdfront.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 6471d836f6fe..f95aefedf026 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -91,22 +91,28 @@ static void xenkbd_handle_key_event(struct xenkbd_info *info,
 {
 	struct input_dev *dev;
 	int value = key->pressed;
+	u32 keycode = READ_ONCE(key->keycode);
 
-	if (test_bit(key->keycode, info->ptr->keybit)) {
+	if (keycode >= KEY_MAX) {
+		pr_warn("unhandled keycode 0x%x\n", keycode);
+		return;
+	}
+
+	if (test_bit(keycode, info->ptr->keybit)) {
 		dev = info->ptr;
-	} else if (test_bit(key->keycode, info->kbd->keybit)) {
+	} else if (test_bit(keycode, info->kbd->keybit)) {
 		dev = info->kbd;
-		if (key->pressed && test_bit(key->keycode, info->kbd->key))
+		if (value && test_bit(keycode, info->kbd->key))
 			value = 2; /* Mark as autorepeat */
 	} else {
-		pr_warn("unhandled keycode 0x%x\n", key->keycode);
+		pr_warn("unhandled keycode 0x%x\n", keycode);
 		return;
 	}
 
 	if (unlikely(!dev))
 		return;
 
-	input_event(dev, EV_KEY, key->keycode, value);
+	input_event(dev, EV_KEY, keycode, value);
 	input_sync(dev);
 }
 
-- 
2.50.1

