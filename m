Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED9556FF9
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418230; cv=none; b=lNjjf/ceMhp+4/La8ZoCa1/EhpeW/iG/stX3js9ViwbzysZkFdFfLEAw4M1SZmnbaWoM0KPgMMxUT1ofVlUx59Dm1rIjT3ba/azSuhcsnjivqJfgflrM+DQ5TKiIPdyu0uWKYvHQKGtfAv9swVjO+nXkkXCopVxUWuzb3RMZMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418230; c=relaxed/simple;
	bh=94NKhQ0BK8ivfdo45xkT5X7BxKzocBpCjfSwp9vfESc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uLT/fuwMnVxddoym+/NRECSc3o1UYqT3F9kCFn3MH5mkkKP2mk2CXNMUi8heOHAtrrOd9eLzne5M8yoxcPXBBeONBR6O6XfyGItEWfXNgCseubSHelIGdYBptRQQdue1lwFNdCwoq+bPkc30ONSrbPgwjBhFN2B7DyRu08t3foA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RKogFDz4; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKogFDz4"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd61bdc8683so860362a12.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792418226; x=1793023026; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YIFf3SdOPdRgXsOGaFFzUQihN4zspixzOF8xtHPh48c=;
        b=RKogFDz4bhfktU8zwKFbXlABqyRUo7Hd4Lbav27SA/XmjlXU2rISbFFJBpXwmoSbGZ
         GXqI1VE17yEfbbcHRH+q+qJLKS9rGyv+AhqSodh6zf1TdJIs0IaQxmcCYBSzykBxDy5m
         9/708k5z9RQXvmftdekzXfIWPagR7zXKqbe7nAoWZTl8nEjUGbI9AzILVUL5vGHi0s8o
         LD1QUavnZAIrZfTlSJynkn5NUeplArLjju6KEJ4v5K/HCsuYyEAbDcMUL19EcFi1HxVn
         3KfKGk6IyBKcLSEOyzpeTLeDY0vUOX1Vjyx65rynKfEcxAKigLo4B7MO2vanDi8sfaa/
         voxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418226; x=1793023026;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YIFf3SdOPdRgXsOGaFFzUQihN4zspixzOF8xtHPh48c=;
        b=uwGnZTzlX9/KPZgcaZdpxczWcdMfcDdSfCmSC/0+rwYOLQGVA3oUHr6TtQ/UmSGIH0
         3X92kIJiTEeKXnzjIsu09Ts9JVzoHv7vO0OaoQ2VAgbe59pSQBrFKN2G+WH6zbe0RQ7C
         OY9yJm4SHeS2SBcPJPEc5yCbdy21iuTfDp9TqPaYWgiI9XTIblM7uLNdzEYaUToQbHmR
         WJCbu8YZyQkzLKY37rfsvCPVjzlom2ZWiO90mHv60/YryFduH8iYl2N672qv9+Fyv8Ml
         jIHzud1iklXzu08NG3DGIvg+b+G6M3vRIVG2IjjqdJyPLCopCe1Qqm1h7EW0lj2uc6nZ
         R/9A==
X-Forwarded-Encrypted: i=1; AKwUvByUIEcV47N0y8KbaMalBU82Oq9fzEjYQIspfKazhqpT9sw5NUE0fTbLNwgyvOGD/wjegzXX1wg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrd6DJYpFWUQif/K9LKlf57NSVUI9eX3FRDM8duVxs3X1CP3B5
	CF7V7ZMZBdX/CthNU4nJcycL7bxmNbCvTFhy9ioOyeuK6R6i7yZxEyIEWy5KLzzkWoBqyqHo+ti
	hNQnKQNcRvwbHKFzhnOw2JuyONfwupRAt9w==
X-Received: from pgac23.prod.google.com ([2002:a05:6a02:2957:b0:cc7:9d5b:c2ac])
 (user=sonalipradhan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:730c:b0:3e1:b678:3d7b with SMTP id adf61e73a8af0-3e225f91672mr6316738637.19.1792418225152;
 Mon, 19 Oct 2026 06:57:05 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:57:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261019135701.2767078-1-sonalipradhan@google.com>
Subject: [PATCH RESEND] usb: gadget: f_midi: fix UAF race during IN request handling
From: Sonali Pradhan <sonalipradhan@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neill Kapron <nkapron@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Fan Wu <fanwu01@zju.edu.cn>, Victor Krawiec <victor.krawiec@arturia.com>, 
	Felipe Balbi <balbi@ti.com>, "Felipe F. Tonello" <eu@felipetonello.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sonali Pradhan <sonalipradhan@google.com>
Content-Type: text/plain; charset="UTF-8"

f_midi_disable() frees pre-allocated IN requests from in_req_fifo
without holding midi->transmit_lock. Concurrent f_midi_transmit() or
f_midi_complete() calls can then access these request buffers after they
are freed, leading to a use-after-free.

Fix this by acquiring midi->transmit_lock in f_midi_disable() while
releasing IN requests, and checking ep->enabled under midi->transmit_lock
in f_midi_transmit() and f_midi_complete() before modifying requests.

Fixes: e1e3d7ec5da3 ("usb: gadget: f_midi: pre-allocate IN requests")
Cc: stable@vger.kernel.org
Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>
---
Resending and rebasing on latest linux-next as I haven't received
feedback on my initial submission:
https://lore.kernel.org/all/20260819102709.212646-1-sonalipradhan@google.com/

 drivers/usb/gadget/function/f_midi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 63fb6ee70a3d..c26d04eb9209 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -280,9 +280,18 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
 			/* We received stuff. req is queued again, below */
 			f_midi_handle_out_data(ep, req);
 		} else if (ep == midi->in_ep) {
+			unsigned long flags;
+
 			/* Our transmit completed. See if there's more to go.
 			 * f_midi_transmit eats req, don't queue it again. */
+			spin_lock_irqsave(&midi->transmit_lock, flags);
+			if (!ep->enabled) {
+				spin_unlock_irqrestore(&midi->transmit_lock, flags);
+				return;
+			}
 			req->length = 0;
+			spin_unlock_irqrestore(&midi->transmit_lock, flags);
+
 			queue_work(system_highpri_wq, &midi->work);
 			return;
 		}
@@ -420,6 +429,7 @@ static void f_midi_disable(struct usb_function *f)
 	struct f_midi *midi = func_to_midi(f);
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_request *req = NULL;
+	unsigned long flags;
 
 	DBG(cdev, "disable\n");
 
@@ -431,8 +441,10 @@ static void f_midi_disable(struct usb_function *f)
 	usb_ep_disable(midi->out_ep);
 
 	/* release IN requests */
+	spin_lock_irqsave(&midi->transmit_lock, flags);
 	while (kfifo_get(&midi->in_req_fifo, &req))
 		free_ep_req(midi->in_ep, req);
+	spin_unlock_irqrestore(&midi->transmit_lock, flags);
 
 	f_midi_drop_out_substreams(midi);
 }
@@ -678,10 +690,11 @@ static void f_midi_transmit(struct f_midi *midi)
 	unsigned long flags;
 
 	/* We only care about USB requests if IN endpoint is enabled */
-	if (!ep || !ep->enabled)
-		goto drop_out;
-
 	spin_lock_irqsave(&midi->transmit_lock, flags);
+	if (!ep || !ep->enabled) {
+		spin_unlock_irqrestore(&midi->transmit_lock, flags);
+		goto drop_out;
+	}
 
 	do {
 		ret = f_midi_do_transmit(midi, ep);
-- 
2.56.0.176.g3575e65682-goog
