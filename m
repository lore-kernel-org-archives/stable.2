Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929809;
	b=ZAiGIaIC8vSbKc5Y088ZidJPV+iZ/NG0fx3+qXGzI5/9Gg3lukTYxUPdrHziaZc5DvPZ
	 hAxVBFb5qvzX+GljYdnCe66QfL2UWiHsNgjIQncpULuYyyX88WPoew0mnaXZT4jCWCMjJ
	 30rjmouRV0vjilCpWnrEOo/p2r0RvN0aEJ5VvYUmDoeHQqhqxfTd+y+YlPg9lJ+pbsyhF
	 T238TIj7cQ9GdKn2EPHbvhbSlGLPwTDl61vtroiGKjuD/TFts8xvUSPtYY/gj/rrdAvgw
	 xoYzlamy8mMWdjfgaStiOj3FI+kmgO3GfKX+C6+W8K2PiRp9Sm1RKqpS7RfTVtVZxOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929809;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WxtCpso7bcy2x3pwPqbs8QbQWCcvaIwVnloUq9Zuj0w=;
	b=Xx9l3C4h33kswwKgzn749+VFQYDIdtUp/c/uw7sswYXtquMEDS3Yckf2bQDoN7hrHls0
	 Ta37SyCDT1QaboTQkEJEUvD+EsNeC90lOqJsHS0BLKrOaoPxRXFj5rBMnphFHNlJgVm58
	 LzD3U0SK0moo1JdnRDHfuVbaJhgq8sGCOtHOieoVva0NoPo9yE6Y7GlLXeAHtceD171rX
	 JBmV8EsAx5n8x354SDYQ1fw1rLQQRPt3fK/0AZEC5McLEtMwkNy1QyUWuceZr5a445bfq
	 AGWIlL5FWwkEqyyMau+tHyfrbESi2TRQsy3rc2JSyDbGT3pjSTGWJdWZZkI4+ps9lug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=U9v+8OSN;
	arc=none smtp.remote-ip=115.124.28.122
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7126606A32E;
	Fri,  6 Nov 2026 01:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7126606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=U9v+8OSN
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793929798; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WxtCpso7bcy2x3pwPqbs8QbQWCcvaIwVnloUq9Zuj0w=;
	b=U9v+8OSNp5tIbDiFKe8hQ8oiO2q5Y14vNOis/q9Z/TukEyhyl3he8f6KrOnoYPpoMMud7OZqscP3GCP7xtCmWwVcQak3GQ6nNzx1v/JfHiZ0QYyc/t3HFjy7UzOXN6E5NpLix7jKuXyT+xJR0n6wP542q/v7PF4WcNJRRfLviPo=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3417178|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0152312-0.0248496-0.959919;FP=7284897808806151810|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jxtOPNR_1793929797;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jxtOPNR_1793929797 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:49:58 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: xen-kbdfront - bound the backend-supplied keycode
Date: Fri,  6 Nov 2026 09:49:57 +0800
Message-ID: <20261106014957.4130059-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

Ignore keycodes the bitmaps cannot hold.

Fixes: 4ee36dc08e5c ("xen pvfb: Para-virtual framebuffer, keyboard and pointer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/input/misc/xen-kbdfront.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 6471d836f..e9092a788 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -92,6 +92,11 @@ static void xenkbd_handle_key_event(struct xenkbd_info *info,
 	struct input_dev *dev;
 	int value = key->pressed;
 
+	if (key->keycode >= KEY_MAX) {
+		pr_warn("unhandled keycode 0x%x\n", key->keycode);
+		return;
+	}
+
 	if (test_bit(key->keycode, info->ptr->keybit)) {
 		dev = info->ptr;
 	} else if (test_bit(key->keycode, info->kbd->keybit)) {
-- 
2.50.1

