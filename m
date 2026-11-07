Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053266;
	b=qC8j8OlF1udM4BpDNRha39Nv6WufdGXdKKqptHhf2JlGyIA1Hcd9kcxwFVxNBnHRlTI4
	 zln/59V6by/beGi8bMhPQdWcRb9UhLJpnYM1TBa/Yuvb94s73nJm6gSaSQeOx02lxxbld
	 6QmzHMxkL5A7H8GPG1Vx4pajty0CYJGmFltwoh1AUQ8HiCJtpIymlWhvlK4PdBODY6Jai
	 wx4Jh1/ywobD88svIwVQdpp5i5FtkklAXUfZ2nLert4LZW/qe7pnGgP3f0+CW8wyG7OZt
	 06J8TL3NvyHT8QfCWPJA3R1wJdgxXLWzhoC2WqDIOe1R2cPCS7H7rapKJt8S4vY4jFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=APp4ihS1ze9hJMMqSrZZz9+ALw7PLJiVTBxB+nCGuBg=;
	b=IwI8hxPUZHdqwu56bqXKNUh7mFvqMO69f59BY3aFGCT9FES+8j1fC+gfrE8b9EydVZmT
	 qOlo4GngeetZCPJhhi9MtJiQXDD/2toTnQLkabifkVgE7guzeIUr+v5nFtSJMXV2jyoVu
	 e2MrsrQTkYQIcY8SF7k/NMz5zmTHGyeQ8GW4e0UzHMZYv6lHX/Cd+56Oc6xt8/wwyiiXT
	 k5yMCF0yQfnlY2prhTiAPkq/0qfXNb1JIK7MyDfKWkDs/yo64ila76slJpdhhYF7N1NOI
	 JHFE7VSg+mJcyg2/7ChFAeo9Kx+MmriZx6rGd6tG1RM9t/a1vOkA27U5x33N0SzmxJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nHPX+GnU;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB3606A337
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 12:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71CB3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nHPX+GnU
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so871425f8f.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 04:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053264; x=1794658064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=APp4ihS1ze9hJMMqSrZZz9+ALw7PLJiVTBxB+nCGuBg=;
        b=nHPX+GnUkaMH8ELrtKc3s8CZRdiM7Q6PTIErXiFqt3WKKFPLerMy5QIqF0XyxPb+Ct
         VQG6eL4KPSUl6IKdI2vAaper47oSkIzj0bFbbOdlDhetQfN3oNrYLw3ctScmVm8CBDKP
         qCkf653CyFzXvqSF9tfe/RBLf07Y/Q6aHZidaiPU1+BUNb8jGkNTnPydFLsda0caXXk0
         0xQhGEVAWJMcNnmHXWw/Kgxu1DYS0vyV5oLFZN2NZSw4QQ7yOtFQb0tgu2JZyNPHSPHJ
         blsIzXzcK0Ayd2N/2Td+fnEe4NLlsDkZThHuXQfjskVgIi1kaWsueUenPfb6u0GXvHJY
         A4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053264; x=1794658064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=APp4ihS1ze9hJMMqSrZZz9+ALw7PLJiVTBxB+nCGuBg=;
        b=ZcwBMfFmQQpJT/DOA42Fx5UEGRaAJNe+y26zrM3y2p06eKuPnip+zLqL9oS1GZQ1kb
         5b9ua7lSt2ysI7qs6Ub7x5Jz7jnQnox4xRr2kSoCeRngbu7EBEzsO2wk3Wnim2htzZAL
         AmHjt3GZFYp1HDaBlyBfvZGX7H1MTDtXpqPT32UCFtdfAIICKrusT7+dOjJHPf+52oQ8
         kAiK+747zR5YeqOenfP9uk3Tg2BNrw51BSclSSXAPUa/MrDhN0ySljxSutqmJLyhCOKE
         uXbpuDPNIORyybvc/Vg3qlZ3VObaFsake7tWHv+mNrbRU047nqjbXE7mAqikFoflJspy
         xmQA==
X-Forwarded-Encrypted: i=1; AL+hErHI6TiFb7RPne1N13Zr7QiPhIcV1DgICla1lxYjf2qpOn3mFkVvwudCV+wfQpxpSwrgD9u6zqA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9d0KoOoyoKs5gF05h8keb7s0kHQMLn+9zU9JTpmmNdBvgY1QqW
	4AvigL9ShHOHhTv0273ZGqZMQfWMN6HjwOQXySmuqHcTlDS1eMLHROI=
X-Gm-Gg: AYBFou3uxIKfaNynjwH7WWs0FeWy0hxFDfPAdaD1U9jZWgujGuHkXhdLJs54UISzn/y
	32XBjXgK88kRyJDB2b37kVYq1Lo2iJ1P+2SyM/FGA9QmkaHMpJhCJYMzVsyfbSpej8PL3gp/REA
	yTmUqu95JtAFMITLAsfxdfeUNPrrrzEQMDrFk951ISmlmX62ITedqhBIH2QAbCSYrCevEpm7Kko
	Sk7obw4Hvs5CNILx0B5DqoHhIkzaNA/gT9vE90DAvG8sxNaPOvuMYajl0nrCYmfKR7WdxN7gHA2
	l1qZylfyLWgiOPq8xiyxzy73bv6YlsnGBiwQZ2pjMbGxZjZV4l5wSwYfMrR5L2XPyg85Ppg2dJT
	QgwaPy1FZQlkZgUbwGDMbzpYLwx4ONyjgw5dsW5c/LDJWCcnRp9aqLrF38KzbjgOcdgdfD8+l1u
	aaMIlxzFc88LTUd4Ta5YWJkSN5WIQKFzm24rdqzYiI1dJibzQ3ZKCpIgZeJvoghFTENJQSuA15d
	mg0l4bqEwW9iSRGNSqd2UcCAfsdH9ZwsGTkOHVQFTxGoUAMiXlpiS9dv5jXp3Kr/nrIedobC0xC
	kTWVE9NSY8RvDULxiFrCutIopn7ir1aH71FTBA==
X-Received: by 2002:a05:6000:25ea:b0:490:39ba:4359 with SMTP id ffacd0b85a97d-4927527d826mr8912522f8f.23.1794053263593;
        Sat, 07 Nov 2026 04:07:43 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm9381719f8f.51.2026.11.07.04.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:07:42 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
	linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aamir Ahmed <aamir.ahmed@talencesecurity.com>,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 wireless] wifi: wfx: validate firmware message body lengths before processing
Date: Sat,  7 Nov 2026 12:07:32 +0000
Message-ID: <20261107120732.941805-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

The HIF message handlers cast the body pointer to typed structures
without verifying that the firmware actually sent enough data.  A
shorter-than-expected message causes reads beyond the message boundary.

Add a min_body_len field to the hif_handlers dispatch table and reject
messages that are too short before calling into any handler.  For the
multi-transmit confirmation, which has a variable-length tx_conf_payload
array, additionally validate the array extent with struct_size(), both
in rx_helper() before buffer accounting and in the handler itself.
Guard the body->data accesses in the error and exception indication
handlers against truncated messages.  Add the same minimum length check
for the inline-handled HIF_IND_ID_RX and generic confirmation paths.

Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v3:
  - Add min_body_len field to hif_handlers dispatch table and validate
    before calling any handler, addressing all hif_handlers (Jerome)
  - Guard flexible-array data[] accesses in error and exception handlers
    against truncated messages
  - Add body length check for inline-handled RX indication and generic
    confirmation paths
  - Keep struct_size() validation for multi-transmit flexible array
v2:
  - Added validation in bh.c rx_helper() before buffer accounting
  - Used struct_size() for overflow-safe flexible array validation
 drivers/net/wireless/silabs/wfx/bh.c     | 20 +++++--
 drivers/net/wireless/silabs/wfx/hif_rx.c | 70 ++++++++++++++++++------
 2 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/bh.c b/drivers/net/wireless/silabs/wfx/bh.c
index 0071659bc9c98..b877dd01fb00a 100644
--- a/drivers/net/wireless/silabs/wfx/bh.c
+++ b/drivers/net/wireless/silabs/wfx/bh.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2010, ST-Ericsson
  */
 #include <linux/gpio/consumer.h>
+#include <linux/overflow.h>
 #include <net/mac80211.h>
 
 #include "bh.h"
@@ -99,11 +100,22 @@ static int rx_helper(struct wfx_dev *wdev, size_t read_len, int *is_cnf)
 
 	if (!(hif->id & HIF_ID_IS_INDICATION)) {
 		(*is_cnf)++;
-		if (hif->id == HIF_CNF_ID_MULTI_TRANSMIT)
-			release_count =
-				((struct wfx_hif_cnf_multi_transmit *)hif->body)->num_tx_confs;
-		else
+		if (hif->id == HIF_CNF_ID_MULTI_TRANSMIT) {
+			const struct wfx_hif_cnf_multi_transmit *body =
+				(const struct wfx_hif_cnf_multi_transmit *)hif->body;
+			size_t body_len = le16_to_cpu(hif->len) - sizeof(*hif);
+
+			if (body_len < sizeof(*body) ||
+			    body_len < struct_size(body, tx_conf_payload,
+						   body->num_tx_confs)) {
+				dev_err(wdev->dev,
+					"invalid multi_tx_confirm length\n");
+				goto err;
+			}
+			release_count = body->num_tx_confs;
+		} else {
 			release_count = 1;
+		}
 		WARN(wdev->hif.tx_buffers_used < release_count, "corrupted buffer counter");
 		wdev->hif.tx_buffers_used -= release_count;
 	}
diff --git a/drivers/net/wireless/silabs/wfx/hif_rx.c b/drivers/net/wireless/silabs/wfx/hif_rx.c
index 64ca8acb8e4f2..ea3eba49552d7 100644
--- a/drivers/net/wireless/silabs/wfx/hif_rx.c
+++ b/drivers/net/wireless/silabs/wfx/hif_rx.c
@@ -7,6 +7,7 @@
  */
 #include <linux/skbuff.h>
 #include <linux/etherdevice.h>
+#include <linux/overflow.h>
 
 #include "hif_rx.h"
 #include "wfx.h"
@@ -62,9 +63,12 @@ static int wfx_hif_multi_tx_confirm(struct wfx_dev *wdev,
 				    const struct wfx_hif_msg *hif, const void *buf)
 {
 	const struct wfx_hif_cnf_multi_transmit *body = buf;
+	size_t body_len = le16_to_cpu(hif->len) - sizeof(*hif);
 	int i;
 
 	WARN(body->num_tx_confs <= 0, "corrupted message");
+	if (body_len < struct_size(body, tx_conf_payload, body->num_tx_confs))
+		return -EINVAL;
 	for (i = 0; i < body->num_tx_confs; i++)
 		wfx_tx_confirm_cb(wdev, &body->tx_conf_payload[i]);
 	return 0;
@@ -297,17 +301,17 @@ static int wfx_hif_error_indication(struct wfx_dev *wdev,
 				    const struct wfx_hif_msg *hif, const void *buf)
 {
 	const struct wfx_hif_ind_error *body = buf;
+	size_t body_len = le16_to_cpu(hif->len) - sizeof(*hif);
 	int type = le32_to_cpu(body->type);
-	int param = (s8)body->data[0];
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(hif_errors); i++)
 		if (type == hif_errors[i].val)
 			break;
 	if (i < ARRAY_SIZE(hif_errors))
-		if (hif_errors[i].has_param)
+		if (hif_errors[i].has_param && body_len > sizeof(*body))
 			dev_err(wdev->dev, "asynchronous error: %s: %d\n",
-				hif_errors[i].str, param);
+				hif_errors[i].str, (s8)body->data[0]);
 		else
 			dev_err(wdev->dev, "asynchronous error: %s\n", hif_errors[i].str);
 	else
@@ -323,10 +327,13 @@ static int wfx_hif_exception_indication(struct wfx_dev *wdev,
 					const struct wfx_hif_msg *hif, const void *buf)
 {
 	const struct wfx_hif_ind_exception *body = buf;
+	size_t body_len = le16_to_cpu(hif->len) - sizeof(*hif);
 	int type = le32_to_cpu(body->type);
 
-	if (type == 4)
+	if (type == 4 && body_len >= sizeof(*body) + sizeof(__le32))
 		dev_err(wdev->dev, "firmware assert %d\n", le32_to_cpup((__le32 *)body->data));
+	else if (type == 4)
+		dev_err(wdev->dev, "firmware assert\n");
 	else
 		dev_err(wdev->dev, "firmware exception\n");
 	print_hex_dump(KERN_INFO, "hif: ", DUMP_PREFIX_OFFSET,
@@ -339,21 +346,31 @@ static int wfx_hif_exception_indication(struct wfx_dev *wdev,
 static const struct {
 	int msg_id;
 	int (*handler)(struct wfx_dev *wdev, const struct wfx_hif_msg *hif, const void *buf);
+	size_t min_body_len;
 } hif_handlers[] = {
 	/* Confirmations */
-	{ HIF_CNF_ID_TX,                wfx_hif_tx_confirm },
-	{ HIF_CNF_ID_MULTI_TRANSMIT,    wfx_hif_multi_tx_confirm },
+	{ HIF_CNF_ID_TX,                wfx_hif_tx_confirm,
+	  sizeof(struct wfx_hif_cnf_tx) },
+	{ HIF_CNF_ID_MULTI_TRANSMIT,    wfx_hif_multi_tx_confirm,
+	  sizeof(struct wfx_hif_cnf_multi_transmit) },
 	/* Indications */
-	{ HIF_IND_ID_STARTUP,           wfx_hif_startup_indication },
-	{ HIF_IND_ID_WAKEUP,            wfx_hif_wakeup_indication },
-	{ HIF_IND_ID_JOIN_COMPLETE,     wfx_hif_join_complete_indication },
-	{ HIF_IND_ID_SET_PM_MODE_CMPL,  wfx_hif_pm_mode_complete_indication },
-	{ HIF_IND_ID_SCAN_CMPL,         wfx_hif_scan_complete_indication },
-	{ HIF_IND_ID_SUSPEND_RESUME_TX, wfx_hif_suspend_resume_indication },
-	{ HIF_IND_ID_EVENT,             wfx_hif_event_indication },
-	{ HIF_IND_ID_GENERIC,           wfx_hif_generic_indication },
-	{ HIF_IND_ID_ERROR,             wfx_hif_error_indication },
-	{ HIF_IND_ID_EXCEPTION,         wfx_hif_exception_indication },
+	{ HIF_IND_ID_STARTUP,           wfx_hif_startup_indication,
+	  sizeof(struct wfx_hif_ind_startup) },
+	{ HIF_IND_ID_WAKEUP,            wfx_hif_wakeup_indication, 0 },
+	{ HIF_IND_ID_JOIN_COMPLETE,     wfx_hif_join_complete_indication, 0 },
+	{ HIF_IND_ID_SET_PM_MODE_CMPL,  wfx_hif_pm_mode_complete_indication, 0 },
+	{ HIF_IND_ID_SCAN_CMPL,         wfx_hif_scan_complete_indication,
+	  sizeof(struct wfx_hif_ind_scan_cmpl) },
+	{ HIF_IND_ID_SUSPEND_RESUME_TX, wfx_hif_suspend_resume_indication,
+	  sizeof(struct wfx_hif_ind_suspend_resume_tx) },
+	{ HIF_IND_ID_EVENT,             wfx_hif_event_indication,
+	  sizeof(struct wfx_hif_ind_event) },
+	{ HIF_IND_ID_GENERIC,           wfx_hif_generic_indication,
+	  sizeof(struct wfx_hif_ind_generic) },
+	{ HIF_IND_ID_ERROR,             wfx_hif_error_indication,
+	  sizeof(struct wfx_hif_ind_error) },
+	{ HIF_IND_ID_EXCEPTION,         wfx_hif_exception_indication,
+	  sizeof(struct wfx_hif_ind_exception) },
 	/* FIXME: allocate skb_p from wfx_hif_receive_indication and make it generic */
 	//{ HIF_IND_ID_RX,              wfx_hif_receive_indication },
 };
@@ -363,8 +380,14 @@ void wfx_handle_rx(struct wfx_dev *wdev, struct sk_buff *skb)
 	int i;
 	const struct wfx_hif_msg *hif = (const struct wfx_hif_msg *)skb->data;
 	int hif_id = hif->id;
+	size_t body_len = le16_to_cpu(hif->len) - sizeof(*hif);
 
 	if (hif_id == HIF_IND_ID_RX) {
+		if (body_len < sizeof(struct wfx_hif_ind_rx)) {
+			dev_err(wdev->dev, "rx indication too short: %zu\n",
+				body_len);
+			goto free;
+		}
 		/* wfx_hif_receive_indication take care of skb lifetime */
 		wfx_hif_receive_indication(wdev, hif, hif->body, skb);
 		return;
@@ -372,13 +395,26 @@ void wfx_handle_rx(struct wfx_dev *wdev, struct sk_buff *skb)
 	/* Note: mutex_is_lock cause an implicit memory barrier that protect buf_send */
 	if (mutex_is_locked(&wdev->hif_cmd.lock) &&
 	    wdev->hif_cmd.buf_send && wdev->hif_cmd.buf_send->id == hif_id) {
+		if (body_len < sizeof(__le32)) {
+			dev_err(wdev->dev, "confirmation too short: %zu\n",
+				body_len);
+			goto free;
+		}
 		wfx_hif_generic_confirm(wdev, hif, hif->body);
 		goto free;
 	}
 	for (i = 0; i < ARRAY_SIZE(hif_handlers); i++) {
 		if (hif_handlers[i].msg_id == hif_id) {
-			if (hif_handlers[i].handler)
+			if (hif_handlers[i].handler) {
+				if (body_len < hif_handlers[i].min_body_len) {
+					dev_err(wdev->dev,
+						"message 0x%02x too short: %zu < %zu\n",
+						hif_id, body_len,
+						hif_handlers[i].min_body_len);
+					goto free;
+				}
 				hif_handlers[i].handler(wdev, hif, hif->body);
+			}
 			goto free;
 		}
 	}
-- 
2.47.3

