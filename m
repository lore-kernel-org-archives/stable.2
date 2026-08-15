Received: from cvsmtppost27.nm.naver.com (cvsmtppost27.nm.naver.com [114.111.35.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0F33EB1A
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786772419; cv=none; b=Z0FPplBm32xw9yM41QVQyh0oJIKbgMolkLBSxhXoLqUTa2PU50GAYgxQGqNaiYoAaokNMwMdt7vyxP5wB1FeQini1O24Z2djQcesBDNdmIEEZ9B4aKm4up8ygf5rvJcKhAJV8jPRXWukyzXMV6YYHV4TFv1mB+3h3vj/B0DdkUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786772419; c=relaxed/simple;
	bh=884LaAzVVhTshgpuDrYlbsmxSEorMucoGoR8jRD33oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKcnwgBMMhbrhmlwkWzpyi2JZEjhXpMa8HqQk+RkM+0l6263MXatny4a57b3M4LjnnkgVMq2hJa4trVUqKmlRhs4X3ARcX0OeG8JnzT2wNFdES8LOtCXdbO1HVEPfxcyX5UIA3Y4NnjNFb6wVCxBd4p4hv38ZwvyAbt8Qn7md58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=s+s0bLrz; arc=none smtp.client-ip=114.111.35.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="s+s0bLrz"
Received: from cvsendbo002.nm ([10.112.20.42])
  by cvsmtppost27.nm.naver.com with ESMTP id S48EA5MTRuerfVGonIs7cg
  for <stable@vger.kernel.org>;
  Sat, 15 Aug 2026 05:30:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1786771806; bh=884LaAzVVhTshgpuDrYlbsmxSEorMucoGoR8jRD33oY=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=s+s0bLrzylkJryJgjaoc82iBmA3Fqh2UyxSfCXMhmPZqDjGH+QS8q9wen3CIJxWP7
	 RSsWly3vv6XBj9RK2LGCeLQyTtWvAY03dMRW4UCK/8rXd2rI3rjAuOuvJzhl/sO5TK
	 llyJM+DgYj6jRoobKLQAKfnXinXgqczdQ4vgwJZv2gO3UFWV7Xj4Mb0W1aeJCh/Src
	 UGvQJ+fx3hEZUzhAJxIyCCXwjPFQIlp6gvnDNYPVqBDYvkqm2NTra88TBqgA0MOlUU
	 Ypm+r6hvYtObIUUkkdT44jNr8BH4wsx8mCJCZzJyHT62dl5yi8INVGxHhStS46IB27
	 P3w4KmwyhHYLw==
X-Session-ID: 2HYKETDkQXm94HPKqk7Zcg
X-Works-Send-Opt: rle8W4eXjHwYKBm9FAF9FHmwKo2mKqErKqb/jJIFjAJYKg==
X-Works-Smtp-Source: gqYqFqM/FqJZ+HmrKAtl+6E=
Received: from bl4ckhyun.localdomain ([211.41.193.194])
  by cvnsmtp008.nm.naver.com with ESMTP id 2HYKETDkQXm94HPKqk7Zcg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 15 Aug 2026 05:30:06 -0000
From: Hyeontae Lee <wonju345@naver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyeontae Lee <wonju345@naver.com>
Subject: [PATCH] usb: gadget: f_midi: hold transmit_lock while freeing IN requests
Date: Sat, 15 Aug 2026 14:29:29 +0900
Message-ID: <20260815052929.146901-1-wonju345@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f_midi_disable() drains in_req_fifo and frees the requests without taking
transmit_lock.  f_midi_transmit() holds that lock across the whole of
f_midi_do_transmit(), which peeks a request off the fifo without removing
it and then keeps using it.  kfifo_peek() does not advance the read index,
so the drain frees exactly the request the transmit path is still using.

No hostile host is needed: __composite_disconnect() calls f->disable() as
well, so a bus reset or a cable pull while a MIDI client is writing is
enough.

  BUG: KASAN: slab-use-after-free in f_midi_in_work+0x126c/0x18c0
  Read of size 4 at addr ffff888104818e20 by task kworker/2:2H/164
  Freed by task 158:
   kfree+0x121/0x380
   f_midi_disable+0x20e/0x430
   reset_config+0x9d/0x200
   __composite_disconnect+0xa7/0x140

Take the lock around the drain, the way hidg_disable() does.

Fixes: e1e3d7ec5da3 ("usb: gadget: f_midi: pre-allocate IN requests")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Hyeontae Lee <wonju345@naver.com>
---
 drivers/usb/gadget/function/f_midi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index fba8cf787d6c1..9e67b3c74296f 100644
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
-- 
2.43.0

