Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CC4156C9
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135235; cv=none; b=GGeoLBUOa9/1S9kF7e+iW0QL/+xFkOjQranfIWZx1Q0C/cxJk11p4Q8B3odBDa1KHyk2PeosDqigNjcoWrOFKlIFUkmUapyiPzaEN6vJ73uDdcrcj2ujnl6JfevXHv6mIdbw9bsGu+LkV0PLMjHZmh/JkzdlkZ3w65SplEJDJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135235; c=relaxed/simple;
	bh=Mk813TFCqqlmMVYF58q8Ra7/eYmWpuXZ8bzgguh1pHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GZjXVYwO2gR82WFaHf7jYRz3vM1TK7oYepGcnObreG4aLjeaLf3lEa/eyvJPrww/mp9B779marfLD9qSTC50vtcQmMYrVb6DbEpXPmhpEY01B5MCaJ8+wPB1E9GhtXrNFCX09ng0yGgZL4Z3xBgq1dgmQhG+mTiC22CbOgda9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEyBm0eq; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEyBm0eq"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso1357941a91.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787135233; x=1787740033; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RsoC28vCQHKdnNG2zgOJgL5SSi8lYenXYvOZo5k+sWA=;
        b=YEyBm0eqeq0ujLc/q9HnmeHFTX/4B8yTcMeEsh9oppaWse8XTsjmqnrnkE10TtR8uZ
         exLpXZ7SbyVC0bNcdlE/lqhGE9PBSrNSxFlns//uh4x+I2CRW39YEaaUdF7JihSbVA/Y
         LMejCJYkoABo+W3V49BwlnylTZlnh6fwVT07lUMwSa2u9dMGYFbrT+mrE3l8t1pkenwq
         yC/48zdn+jN0K9hgzZXf+KYjVfzEG44E3t/ihKS2gkRNlty0cXN4vgvbeLmZ6Esb9hTj
         vIpmXRbdDk2gXl/Ly8R2qHHL8eA7CmcQ/KPjCTYHuIgAzZuWexG4qTr6Wp/ZBM4jW4/T
         0ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787135233; x=1787740033;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsoC28vCQHKdnNG2zgOJgL5SSi8lYenXYvOZo5k+sWA=;
        b=iDJPXDqTckKosl9V6xfb1nKHbFjbKwEgoT/0FpW4uT5LI3p8DeHHi4RrYWpcE8pt1C
         hbWYT6bnC9qYyDGUmrV4/eJXKPM68oohAVo+942VpigZef3nzrKQ8WAPkL4V9zhHHbb4
         eH9pj9Ot6WnoBJAk0xKybT0tHMwU2nOepH5lfvgM8hkgZq6D94suyvTtEZHa7aOe80Yz
         tPpXrv3JOCEE6S5I3SD+sIg31uhZxiQt5Ry5Vc8HtS0A9NLAUWKx7ExI5cA+IWr3hubj
         M9ZS/AdP4wGi/Jci7Ih0EDwXvCRxK9UX9AqNWlK58yt3bDghXIPdyU4xJqqrwjlqURQc
         B2LQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoaFP2lgnm1p7nkBECZPKiGckQPAQN7CE38cEXUN0KYpX0hDZXBQZdhIZ2a7lrugkf2duXlXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4iCrlLGOkhraid1WWo7QGtqq2I1zNnjP+omD61gjC49upsFi
	a95/3PpT8q6LiIzR+dOrWGwYkSr486CtiEpRM4nQPzMPEFf5Km9mlGHYtq6rdF17tgouhZZMZIi
	hH4URBUcvp3TXnrC8j6Scy89zQZA/BlJ7VQ==
X-Received: from pgla22.prod.google.com ([2002:a63:b56:0:b0:c99:5634:7551])
 (user=sonalipradhan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3ca1:b0:3c3:66c5:68d6 with SMTP id adf61e73a8af0-3cd00f77410mr6894163637.9.1787135233076;
 Wed, 19 Aug 2026 03:27:13 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:27:09 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260819102709.212646-1-sonalipradhan@google.com>
Subject: [PATCH] usb: gadget: f_midi: fix UAF race during IN request handling
From: Sonali Pradhan <sonalipradhan@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, Victor Krawiec <victor.krawiec@arturia.com>, 
	Fan Wu <fanwu01@zju.edu.cn>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	"Felipe F. Tonello" <eu@felipetonello.com>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, 
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
 drivers/usb/gadget/function/f_midi.c | 22 +++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index fba8cf787d6c..ee64147b12f1 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -280,9 +280,20 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
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
@@ -420,6 +431,7 @@ static void f_midi_disable(struct usb_function *f)
 	struct f_midi *midi = func_to_midi(f);
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_request *req = NULL;
+	unsigned long flags;
 
 	DBG(cdev, "disable\n");
 
@@ -431,8 +437,10 @@ static void f_midi_disable(struct usb_function *f)
 	usb_ep_disable(midi->out_ep);
 
 	/* release IN requests */
+	spin_lock_irqsave(&midi->transmit_lock, flags);
 	while (kfifo_get(&midi->in_req_fifo, &req))
 		free_ep_req(midi->in_ep, req);
+	spin_unlock_irqrestore(&midi->transmit_lock, flags);
 
 	f_midi_drop_out_substreams(midi);
 }
@@ -678,10 +686,11 @@ static void f_midi_transmit(struct f_midi *midi)
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
