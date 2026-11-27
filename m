Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799260;
	b=kGQlLD2g5+2aZX9B2aFUK4gKDmg2HkO2ufN22USIvizOIGMksnzXBvKn6RqJEgi1PD9B
	 Ou3BEXoQwky7mfNrKuqHAgX5fJ3KsXbexWeQ0tc/NF+to4E8sV2SwyDN+WtIDLgf9MDGN
	 oVMcbsuwL7Adjawg12G3ikmD0RYwBquRclHX/EP2vQDGI25hmcVq2TnJ+lPzQ6oO6qrCk
	 fiDmCj9XSuFHqeHOMUNGUE2v0LskR7tgii9Tz149VI6ZTSNyR7pXNHvM1Esa12WDD8K0i
	 4sNTt9MPNb4uqsl1Wa2dp7jQePTpEB4J17HYlJpxvcx2S7QIHWM/OobJAWxFv1njg+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799260;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+NRKsruszYP6cGTV2pxgiB3mv2zesdJK2UybdTLYFSc=;
	b=aDt+S7xfUPE08CeWuiEhXMC1FYiHmSBvt5in2NbXMst2+Ga46HmmC3UAz+7RWph97Pbq
	 Ha54PPIAfAklla5NxeANT1Z3RgEFR0kRy0UaG9nTKFJ0AipqDuVfILx8FxC9rs3JThZCj
	 tP6rUMktQ9VL/6J0zu9I1y3oMHOv10dmgbuWV4M4iw6F/yKIMGtFcWjy+/IMFsDnoBpev
	 Lz85vU8uo28XGJGBQczG1hBXKKbxOe6ZaNdVm7/QxfGiiWUydNth4t6icQdrezPM3j2AP
	 mUN+VyMiI3KGlmDewH8DbpG4KSx+B3qw8r5d+ergsGDCe+ZFgHMKM/EFyrVNeF79plw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+pBHGkw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2593606A31C;
	Fri, 27 Nov 2026 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+pBHGkw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964941F00893;
	Fri, 27 Nov 2026 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799260;
	bh=+NRKsruszYP6cGTV2pxgiB3mv2zesdJK2UybdTLYFSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k+pBHGkwr06j3UAtUHpffLRHxhklJ7zn1r4FCL8ZxVXa1nJhzcfpYjUlgLG/3QYg6
	 QGZHZOF0hPDrze1EhRX6dnFWnDbc65AOnbHVjVj5h4YsuP9Oo76Yclzdvq2GVNzeLO
	 5+JqEDIQ9ShgXwmiQCyWf0bIkEtC12ch1dXQIY9nDrRoP8UEWbyQu6TA1goPLaFxcg
	 OPr5RrgrKmTb2Tp6Or60a2svWAA12ExsfX19P/KJulVNrrozcRNajxznNdyoGfQfp9
	 zFUUf0Inik7QUWCd+fvYlmBCKv+InX5JW77GdG4syDOH7FT7o8EEKE3dsz4XARNgXe
	 w89jx8cXpbpvw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Lopez Casado <nlopezcasad@logitech.com>,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 03/10] HID: logitech-hidpp: Synchronise send_receive_buf against raw events
Date: Fri, 27 Nov 2026 17:06:21 +0000
Message-ID: <20261127170712.3163443-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127170712.3163443-1-lee@kernel.org>
References: <20261127170712.3163443-1-lee@kernel.org>
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

__do_hidpp_send_message_sync() stores a pointer to the caller's
stack-allocated response buffer in hidpp->send_receive_buf while
holding hidpp->send_mutex, whereas hidpp_raw_hidpp_event() runs in
interrupt context without holding hidpp->send_mutex.  Clearing
hidpp->send_receive_buf before releasing hidpp->send_mutex is
insufficient: if hidpp_raw_hidpp_event() loads hidpp->send_receive_buf
just before wait_event_timeout() expires and the caller returns,
writing *answer = *report corrupts up to 64 bytes of the popped kernel
stack frame.  Furthermore, hidpp->send_receive_buf was published before
initialising *response = *message, and error paths zeroed *response
while hidpp->send_receive_buf remained visible.

Protect hidpp->send_receive_buf and hidpp->answer_available with a
spinlock across setup, completion, and teardown so that
hidpp_raw_hidpp_event() cannot access the response buffer once
__do_hidpp_send_message_sync() finishes.

Fixes: 2f31c5252910 ("HID: Introduce hidpp, a module to handle Logitech hid++ devices")
Fixes: e2aaf2d3ad92 ("HID: logitech-hidpp: fix race condition when accessing stale stack pointer")
Closes: https://sashiko.dev/#/bug/linux-fed46492-e564-402a-b7b3-8a761e52e5e7
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - No changes.

 drivers/hid/hid-logitech-hidpp.c | 58 +++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 60fc6b86a085..6c95c4bcdd42 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/spinlock.h>
 #include <linux/kfifo.h>
 #include <linux/input/mt.h>
 #include <linux/workqueue.h>
@@ -185,6 +186,8 @@ struct hidpp_device {
 	struct hid_device *hid_dev;
 	struct input_dev *input;
 	struct mutex send_mutex;
+	/* protects send_receive_buf and answer_available */
+	spinlock_t send_receive_lock;
 	void *send_receive_buf;
 	char *name;		/* will never be NULL and should not be freed */
 	wait_queue_head_t wait;
@@ -296,39 +299,44 @@ static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
 	struct hidpp_report *message,
 	struct hidpp_report *response)
 {
+	unsigned long flags;
 	int ret;
 
 	__must_hold(&hidpp->send_mutex);
 
-	hidpp->send_receive_buf = response;
-	hidpp->answer_available = false;
-
 	/*
 	 * So that we can later validate the answer when it arrives
 	 * in hidpp_raw_event
 	 */
 	*response = *message;
 
+	spin_lock_irqsave(&hidpp->send_receive_lock, flags);
+	hidpp->send_receive_buf = response;
+	hidpp->answer_available = false;
+	spin_unlock_irqrestore(&hidpp->send_receive_lock, flags);
+
 	ret = __hidpp_send_report(hidpp->hid_dev, message);
 	if (ret) {
 		dbg_hid("__hidpp_send_report returned err: %d\n", ret);
-		memset(response, 0, sizeof(struct hidpp_report));
-		goto out;
+		goto err_zero;
 	}
 
-	if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
-				5*HZ)) {
+	if (!wait_event_timeout(hidpp->wait,
+				READ_ONCE(hidpp->answer_available), 5 * HZ)) {
 		dbg_hid("%s:timeout waiting for response\n", __func__);
-		memset(response, 0, sizeof(struct hidpp_report));
 		ret = -ETIMEDOUT;
-		goto out;
+		goto err_zero;
 	}
 
+	spin_lock_irqsave(&hidpp->send_receive_lock, flags);
+	hidpp->send_receive_buf = NULL;
+	spin_unlock_irqrestore(&hidpp->send_receive_lock, flags);
+
 	if (response->report_id == REPORT_ID_HIDPP_SHORT &&
 	    response->rap.sub_id == HIDPP_ERROR) {
 		ret = response->rap.params[1];
 		dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
-		goto out;
+		return ret;
 	}
 
 	if ((response->report_id == REPORT_ID_HIDPP_LONG ||
@@ -336,13 +344,16 @@ static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
 	    response->fap.feature_index == HIDPP20_ERROR) {
 		ret = response->fap.params[1];
 		dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
-		goto out;
+		return ret;
 	}
 
-	ret = 0;
+	return 0;
 
-out:
+err_zero:
+	spin_lock_irqsave(&hidpp->send_receive_lock, flags);
 	hidpp->send_receive_buf = NULL;
+	spin_unlock_irqrestore(&hidpp->send_receive_lock, flags);
+	memset(response, 0, sizeof(struct hidpp_report));
 	return ret;
 }
 
@@ -4125,27 +4136,33 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 	 * previously sent command.
 	 */
 	if (unlikely(mutex_is_locked(&hidpp->send_mutex))) {
+		unsigned long flags;
+		bool matched = false;
+
+		spin_lock_irqsave(&hidpp->send_receive_lock, flags);
 		question = hidpp->send_receive_buf;
 		answer = hidpp->send_receive_buf;
 
-		if (!question)
-			return 0;
-
 		/*
 		 * Check for a correct hidpp20 answer or the corresponding
 		 * error
 		 */
-		if (hidpp_match_answer(question, report) ||
-				hidpp_match_error(question, report)) {
+		if (question && (hidpp_match_answer(question, report) ||
+				 hidpp_match_error(question, report))) {
 			*answer = *report;
-			hidpp->answer_available = true;
+			hidpp->send_receive_buf = NULL;
+			WRITE_ONCE(hidpp->answer_available, true);
+			matched = true;
+		}
+		spin_unlock_irqrestore(&hidpp->send_receive_lock, flags);
+
+		if (matched) {
 			wake_up(&hidpp->wait);
 			/*
 			 * This was an answer to a command that this driver sent
 			 * We return 1 to hid-core to avoid forwarding the
 			 * command upstream as it has been treated by the driver
 			 */
-
 			return 1;
 		}
 	}
@@ -4723,6 +4740,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	INIT_WORK(&hidpp->work, hidpp_connect_event);
 	INIT_WORK(&hidpp->reset_hi_res_work, hidpp_reset_hi_res_handler);
 	mutex_init(&hidpp->send_mutex);
+	spin_lock_init(&hidpp->send_receive_lock);
 	init_waitqueue_head(&hidpp->wait);
 
 	/* indicates we are handling the battery properties in the kernel */
-- 
2.56.1.839.g22a8290db9-goog

