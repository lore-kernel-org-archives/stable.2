Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794203743;
	b=pLokPq/E2kZQcXQGHH0zIhQudzx1IBwf3JsQpZtRBL9HbKCEKo+My/w15kSJkuLOu6i0
	 21HDWoynWqXFbK3SbpQ96Sf5jnHge6kgSlFbvXYlABviEiPVOQbzreyu4rcMF11nrAgUj
	 m0YY2UywrkcfL5mdIYjzriEBYkXqY9jMbOLJmsrgjTPgkJmqxquqnto4riDNb18nxqxvQ
	 RIS1aX1hTZ7zNf8KYZsIiRsPn+qWooO1A735YcazM1PE2rlyqjRty7iCIpseTnTUI1qyK
	 TAdK4Prlf/Ld5/Oai6PdN/8XUIlcOxabunJ3xhrP4wOEAcnnGtCtgdEVgFaJqxVxzTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203743;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=z3oJgnptaN19AejKVh/vbHNPExVc9fLWO+Fq+4OfdiU=;
	b=HT/GeV36HBEJmM0NvRKrp4m4Go9WKkNOG+u89GXs0cdPVVVsaDF7ZV8Sgl9ODkCxVhAP
	 GTkAx6oU8K90KXNRo+KvUYB0L/xRmW/2j+cr/DYpUbsfJgQUEvyIwD1mzajwCWK/b1iJH
	 n1wAAaM312tzTJ4k3fMIRztvI1zoBAasseLT8RcNCZ9tIzmOnuTOSPR5KtWXkN7MalYRz
	 uQJ4LBX7uobvvyJvskDdfgbPk072MqU0Rsb4JAwqhkGkCaLidHMqnT0jz4GJ/n6cB/x/A
	 nlZcB1JPJIVuF6nER0938j/uTIV1ywTMpMGJrlm6MUVxcLQKsbYkXc+ToAauqomKUKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvsriZZo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4503C606A31C;
	Mon,  9 Nov 2026 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvsriZZo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794203742;
	b=bzREgmdFeWF8VeLypbBCeXF6HM/4iQhEVAOnBw3SREwP2C3VxS0l50Ak1DsSsXg2qyfB
	 omhNLayS/SGNf99IVSzKDfQQIJczI+oo1vSjuoW9ksy9y4EXH2jeVJXFuiiXIbi1N6tEp
	 uNlRsPkBn+r4iBeb61mC06QnXNvNcm4529m8Apcfc7TLPm/r6BisMEBKr6jVfw/NPn3gD
	 c94jXE6ZIY0PWELzukcJN9IUGQdkum0BGhGSnd3PSylrqZZL2EVdmyC9r+D7P5NeTD4WL
	 JDLU/Tw/1J5fYCVDkOJt+IrTYtK9GO5Pubtfc0IgXLHTYrvK7hvyX0dApLSzRiVJbxA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794203742;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=z3oJgnptaN19AejKVh/vbHNPExVc9fLWO+Fq+4OfdiU=;
	b=akCPm9MlDzsepk7uuvaBcf2qYtwI797KooIQhyfFuikcAxjecKTI/RokAJQY0ShLs3Wy
	 aeGh0gSXhqxPqdln42XjgojWWmMMLgekEtjP1nJ1rKYgInhieVyCHvEhiM5xRrliDWzeS
	 7jyd/A44BMmKfNgXaYHfZJGyX2BOrHYic5HlyZp0LqN4N9cTdC5iMoup7Dkbpf+S8LJ08
	 qpsubai4N9AIKIMQLzs9c2RhfMBHWV6Pf+jPLmmhwFFB0IfPsemorN+XOn0QTPDetLVfP
	 d4lrpebJcwo9v9SJpO6XqJjtKuZbvmewIM+OvUgowIAjIvvvUlm0CNCPpXuhdkIQpFA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 14F991F008A2;
	Mon,  9 Nov 2026 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203742;
	bh=z3oJgnptaN19AejKVh/vbHNPExVc9fLWO+Fq+4OfdiU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=DvsriZZor1ke6u5VCQaS3JjFnN6TJViBlqN0HomgSMcuffHlGieCnHxnRm0k4C8cE
	 5/fN49Nex8+BSePUmOIJ3MaOBYC6KLDDPWGPJeeykmAsDhnb7Vug6xUuh+hdsCxtZd
	 AhVidgNtNUUT3r1BJZrvGl0pNEAJMQL80eceU77TV/I2x4112DVuZgIWSVXRm5K1IG
	 TnALAxHY8CMBtHZ2Z82qdHUcGujzO934cPBdTiTt2wfDgA5XxWQhsY1qXyfeGzmPbH
	 eJy3+tTR6XfPn4nJUc4yVTkvdz7RzKrN1lNHb629O9WAmj+RsihCzZHvnc9Pf7us8U
	 5Dy+Zog0rlpVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 65F64482D4;
	Mon,  9 Nov 2026 05:55:41 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Subject: [PATCH v5 0/3] usb: gadget: gadgetfs: fix ep0 request lifetime and
 event counter
Date: Mon, 09 Nov 2026 13:55:38 +0800
Message-Id: <20261109-b4-gadgetfs-ep0-v5-0-f16d0b648bc2@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMMQ6DMAxA0asgz1iKUYC2V0EMITipO1AUA6qEu
 HsDjG/4fwflJKzwKnZIvInKd8qoywL8202RUcZsqEzVEJkGB4vRjZGXoMizwfAg68m21Lon5Gp
 OHOR3Hbv+tq7Dh/1ybuA4/nZnaIBzAAAA
X-Change-ID: 20261106-b4-gadgetfs-ep0-f814c14717a9
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: Jing Lin <kayano050408@gmail.com>, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794203739; l=2478;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=DF1axyv67iSuG+wzHaBzMijjoGW1EVzMAH6xitD2aQA=;
 b=F1GfACeEdJiCFHx9fxiPDGc5KPHyAloblPu5sPW7JYotxvczXHMMb7fbfnYBRBAflAHB9PSis
 4OIknUGXDE5Cckhan+yHB/qZ2XOvyx113NweETMvJWFk7/gKjzM1vly
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com

This series fixes the ep0 request lifetime and the shared request buffer
races in gadgetfs, and the pre-existing event counter underflow.

The first patch covers the request lifetime and buffer ownership
problems, the second patch the event counter underflow, and the third
removes the const cast in gadgetfs_setup().

Changes in v5:
- Expand the first patch's changelog with the concrete interleavings of
  the ep0_read()/ep0_write() races and explain why a mutex cannot be
  used, as requested by Alan Stern.
- Add a patch that clamps a local copy of the control request instead of
  casting away the constness and writing into the caller's setup packet,
  also suggested by Alan Stern.
- Restore STATE_DEV_CONNECTED when a delegated data read is aborted by a
  new setup, so the following event read is not misdirected into the
  control data path.
- Link to v4: https://lore.kernel.org/all/20261107-b4-gadgetfs-ep0-v4-0-86bdfd684b54@gmail.com/

On the submit/unbind window: every ep0 submission increments udc_usage
under dev->lock before the lock is dropped, and gadgetfs_unbind() sets
STATE_DEV_UNBOUND and waits for udc_usage to reach zero before it samples
ep0_req_queued.  A thread that has set ep0_req_queued but has not yet
called usb_ep_queue() therefore keeps unbind waiting; when unbind
resumes, the queue call has completed and the flag and the endpoint queue
agree.  The request that is still queued at unbind is then dequeued
before it is freed.  With a test-only delay between setting the flag and
calling usb_ep_queue(), close() blocked for the remaining delay (610 ms,
versus 3 ms without the delay), confirming that teardown waits for the
submission to finish.

The series was tested with the syzbot reproducer and with targeted
lifecycle, request-reuse, wedge, and event-counter tests on arm64 QEMU
with dummy_hcd, KASAN, and lockdep.

Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
Jing Lin (3):
      usb: gadget: gadgetfs: fix ep0 request lifetime on disconnect
      usb: gadget: gadgetfs: prevent ep0 event counter underflow
      usb: gadget: gadgetfs: avoid writing through the const setup pointer

 drivers/usb/gadget/legacy/inode.c | 181 ++++++++++++++++++++++++++------------
 1 file changed, 123 insertions(+), 58 deletions(-)
---
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
change-id: 20261106-b4-gadgetfs-ep0-f814c14717a9

Best regards,
--  
Jing Lin <kayano050408@gmail.com>


