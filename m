Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173707;
	b=JGiaah6V4U+3nJ/nlhmnT14SFbtH0T5Ck6YoAmJZjr8ri84wrmOykFNKlagzC9X5CDx8
	 SmV2svPyv0VC5GCa2PLVc9mA77cO3wgH86bHbKs0OhdzyTIxgv9GJFvyS4me0eTPapH9w
	 KONXZ8kSQ+Yxa8bgwm/uSViMSQKRgUrpfqyIUvsPwssHSopFMDEy8egLT7/W8SF1zhtN9
	 sPRA6D1UowRMOocgeBtArPp9teFvsWaRMxoh16xWZuqhyT/y7383MeY44yVbk2v0ozYha
	 Hzfa9bK0UqLqIpqEmFSAconKHl4lThjW1FC2JNuHYJZh/e/K2kOWH+DkkQacfmOW0Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=7JDiLc3LwKorBdxIG2fO2JqwT8cJrgK3MbYLow1HkeE=;
	b=t175VMQkBYiyS1H7uhXDWc44tu/eF/9IQKbCSLSzyxoLxinWy6xc59WOoKFJPAEGWsdK
	 rJedRX6Mk0aTcsoxE69BYym8gfxQLzLtfUOz8ySJgr6AeSZ5oYIl0XZTgt0UAgH64QFGZ
	 wEK9+JICHZ01htcw+KYtwXMIlbePhlmW4mdGdNXCG3MvQX0AyYl7P/cq2MfUuX2mS7bVR
	 eh3liBNe0xwmjARACkFEEN75tUnGDmkpPQ2cmOcRM4AXhQnLjqCeR6x0lY0dOkP8mASoF
	 3COfdXIt05h4p94hSyelmoPAhrgMFRs//EyGFxBEgHzhxy+O2NJO4KaNCgAXHLilCcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="WJwsi/aP";
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0643606A31F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0643606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WJwsi/aP
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaae8d29e0so5883065ad.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793173706; x=1793778506; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7JDiLc3LwKorBdxIG2fO2JqwT8cJrgK3MbYLow1HkeE=;
        b=WJwsi/aPDlmQuEKdqEBYuYMRnOF0Ys+WLx1d+m9JyaUXGwib3GorzJdcuivp7QkZli
         zIofH4rrKKKrF8IJ2g0uzdCfbFnuiS2qeaNFbL3eCS8Sdq4zB6Ou/JTDd4jaYB0Pzjjc
         JALC9Unlvj3ZStTweea5iGCX3+l0ZMMjkI5UJyBcYVONeyCbIJnLwhdepY0UTOpWvgfH
         uXc0bVnZFBNuDXmyJtNDUA7T6UmwSmwyx97W/Z1H8l/fDfA34gkutmxCL7Paw2YoQB/2
         ns0mKVANZ60JtEGSfoljBS1MEF+YynsbKhO/fLELjqvntrNjEn5fA5CNxIRDoNgkmbk9
         boFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793173706; x=1793778506;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JDiLc3LwKorBdxIG2fO2JqwT8cJrgK3MbYLow1HkeE=;
        b=0IdKjc33Nex7ZogsBpAtEYfPXJ/F/djwyD+gtowctITwmYTqmtngynHZgSsHn3sTUR
         8puW0q9+TmGm6AuRQc+5yWayicRP3tAWBiby4qDoFwDG7+4X1gCEX0ezYfC8pt0jgYRV
         7TpcO1IGjwdsrrb9k0QJQa0lLo5aU+F9LBR0sqSWnzi12qN9vnQwpy7fT0tcJmLlSZsy
         /QF0F9iFjL2U0AvszF6SznvpFSDUR7ULRYzPOuTuvm8FiyQpSmJc1iVe37egMybeXyrW
         UulerpoPLAMdBpXDTipa1yX4+n1EO9vIo7HNETfnZasiYpfY/g2McL06QCh5EvaWh/oR
         +KZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIYdsanri+kLFqy+7tkcKoX4MQ9c5ko90eHCW4NjUXON00uPjFQHdDnJc0lzVYgZlxscFwc38=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsqvR47A1xTI4UB/FlY2dxNXY4Bsf2Qz5fieCzczFKw9juNxie
	cj390G4osJlfEkIOJa3JyTnLOVrjRsPMM4WL4bXYxxG271xxverBUeN6cfg86PXRFRQxWkt5zpz
	jR1XTa94uy88HwOnrqzVPRIHQEx/nwU/NoA==
X-Received: from pleo1.prod.google.com ([2002:a17:903:2101:b0:2ea:f42f:612a])
 (user=sonalipradhan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2cf:b0:2e2:d834:a40f with SMTP id d9443c01a7336-2eb00141a17mr13956705ad.9.1793173705739;
 Wed, 28 Oct 2026 00:48:25 -0700 (PDT)
Date: Wed, 28 Oct 2026 07:48:21 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261028074821.579450-1-sonalipradhan@google.com>
Subject: [PATCH v2] usb: gadget: f_midi: fix UAF race during IN request handling
From: Sonali Pradhan <sonalipradhan@google.com>
To: nkapron@google.com, gregkh@linuxfoundation.org
Cc: tiwai@suse.de, balbi@kernel.org, jeffinphilip14@gmail.com, 
	victor.krawiec@arturia.com, fanwu01@zju.edu.cn, christophe.jaillet@wanadoo.fr, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, sonalipradhan@google.com
Content-Type: text/plain; charset="UTF-8"

f_midi_disable() drains and frees pre-allocated IN requests from
in_req_fifo without holding midi->transmit_lock. If f_midi_transmit()
runs concurrently on the workqueue, f_midi_do_transmit() can peek a
request from in_req_fifo and write into its buffer while
f_midi_disable() frees it, leading to a use-after-free.

Additionally, when usb_ep_queue() fails in f_midi_do_transmit() (such
as with -ESHUTDOWN when the endpoint is disabled concurrently), it
resets req->length = 0 and returns active instead of the error code,
causing the do-while loop in f_midi_transmit() to keep spinning under
midi->transmit_lock until the substream is drained.

Fix this by acquiring midi->transmit_lock in f_midi_disable() while
releasing IN requests from in_req_fifo, and returning the error code
from f_midi_do_transmit() when usb_ep_queue() fails so f_midi_transmit()
aborts immediately and drops active substreams.

Fixes: e1e3d7ec5da3 ("usb: gadget: f_midi: pre-allocate IN requests")
Cc: stable@vger.kernel.org
Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>
---
Changes in v2:
- Remove the transmit_lock and ep->enabled checks added in v1 from
  f_midi_complete() and f_midi_transmit().
- Return error code from f_midi_do_transmit() when usb_ep_queue() fails
  so f_midi_transmit() aborts the loop immediately.
- Link to v1: https://lore.kernel.org/all/20261019135701.2767078-1-sonalipradhan@google.com/

 drivers/usb/gadget/function/f_midi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 63fb6ee70a3d..48cda34399e8 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -420,6 +420,7 @@ static void f_midi_disable(struct usb_function *f)
 	struct f_midi *midi = func_to_midi(f);
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_request *req = NULL;
+	unsigned long flags;
 
 	DBG(cdev, "disable\n");
 
@@ -431,8 +432,10 @@ static void f_midi_disable(struct usb_function *f)
 	usb_ep_disable(midi->out_ep);
 
 	/* release IN requests */
+	spin_lock_irqsave(&midi->transmit_lock, flags);
 	while (kfifo_get(&midi->in_req_fifo, &req))
 		free_ep_req(midi->in_ep, req);
+	spin_unlock_irqrestore(&midi->transmit_lock, flags);
 
 	f_midi_drop_out_substreams(midi);
 }
@@ -661,6 +664,7 @@ static int f_midi_do_transmit(struct f_midi *midi, struct usb_ep *ep)
 		ERROR(midi, "%s failed to queue req: %d\n",
 		      midi->in_ep->name, err);
 		req->length = 0; /* Re-use request next time. */
+		return err;
 	} else {
 		/* Upon success, put request at the back of the queue. */
 		kfifo_skip(&midi->in_req_fifo);
-- 
2.56.0.307.g5fe7bd680c-goog
