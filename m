Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449128;
	b=TlkrGyTefLUkSe8oQLM60RcvvSusO6e4tpIWse5eEK2pmUsFgpkX/7Wh6Wg9+dUqTHXe
	 D1Ms26MlhGPefLBOIK0eAAo9/Waaej9U7ZAcgmrBoNOoZrUNVxw3GxxlUY4zxfW6kwaXg
	 alZDfk67RWQ+kmj35qrqzdxzBxvZsXEWTDzz2JFfjKoyfuN73YqN1Pf5l1VcTFDT1miAt
	 Hkyt2DNTgpI2Nka9ZxQlxYjsdkDimJwTQA65TWCS33RIRTgPLCqg9kQODX6SCw8jJLVby
	 kUb0WHeaVf3u9Y78S9SVqNy5NrKyYvl/dgyTpijMer7RBsE9mgqpIeLlfyd1QUUbF5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AUYQpJ11dxZ9tTv8qjFKRAg2mgOyiQaAMkMjucxD5i4=;
	b=0FGZEzMrAZil4CXeabyfJIwA3IYCXTIk9/3vDSvpQTPiTz4iTD8/pZAN+XnzuhK2furl
	 fd7jTWyfxggNfsfgawg7uCKy9Uu2d5uBvyHyOKLaD8E6ilzC0WW6Xy4lZ4UmJKKAzbrcR
	 2V1mx8/IzS6xhkP1pCSXBJMelNSp6YFb5/Z/eQPx7r87HD1fjlm9W2HylLP4O8FAaRrPP
	 6C5/+rQqXC3SnyF8Ie5/EMU9YDkeGjyK5u2p7eVUeWjY79sEuavjiRcGYsg4MqNu6VL/4
	 RGTSXR+O9e4JnqaIrputj2ldUNz0eHZ/3sJQie8wUN2FXX5zeO6bjR8L6b7s1yteyrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S+57Su/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA22606A31E;
	Mon, 23 Nov 2026 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+57Su/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BBC1F000C0;
	Mon, 23 Nov 2026 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449127;
	bh=AUYQpJ11dxZ9tTv8qjFKRAg2mgOyiQaAMkMjucxD5i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+57Su/ZPE5eZ1Dgr0V3cMZ/ag7IWlpXtpesV2l/aFB/ev8z3LIarnp8Hx2jfg9Z+
	 iB+cSZ1HR5ZYsfObD6IwigszegXm45bGzjE7IPpxWyuuNn56oJASmzHug77QE/u/uK
	 +YrGJc0jJQKhblRHS/lH9V8+2LyB1xZGAC0ZcIgB0oSdhu/uQn8OWUDo2N/j08LvNc
	 2mvLkCZ8lW7btnOyNtqeUkHtj2ZuDeZTL2lmdhk4jSv4JQHtUWQcxqBdqPWnZ09Em1
	 bOdqIyS8C1JlXWdFYj+fYrNognbQRPs1sUcrKtXoCKIiGWI2FcGmk3Rc3U3O4zK2Ta
	 rf6DdIuclx/JQ==
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
Subject: [PATCH 03/10] HID: logitech-hidpp: Synchronise send_receive_buf against raw events
Date: Mon, 23 Nov 2026 15:50:47 +0000
Message-ID: <20261123155138.2907049-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123155138.2907049-1-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
2.56.1.750.gf70dc682cf-goog

