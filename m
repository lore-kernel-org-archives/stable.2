Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794278517;
	b=QinXYkuShoY6MaoM1I74vCCSSoDwv9ut7+bgahIBzSkQ68zZPrWSJGnY3STg+oKTu6iP
	 4SjGju9djr8xgWn2cyoqUsaKkrargg1Enoa2id7KUPLk5K9LQKYwxCe8eNwbWv7Q+UFzm
	 IVIKMWZ5AaaMyrlbrn7F64/idKL6aaYRuGJnuvKPVl60BJchY9OheBJv8Gl90k/Qfikul
	 2mvrrMHCME4UhHoi85Tp5/W5aHyvfhAraBbTEsCJ59Q6xG1JsUWRnwux/Z8POMA5Mqr1L
	 qi4QLdzuuwvZEXmFl+ORLlmK1V0kbI3LpqOXuKwfAEMFSbC9pDceyuQUCM7+2WRZ2XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278517;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Gf5vm7cvpgQIIcKEgetbD//2pRCYO1NBnRFDgRJ50lo=;
	b=JAMZXFVQ+m4nfnFCNsMrgJF04yiaeWusk2EnRwvpP13s498oqSCU5JT0k8/KWVRV9wi8
	 IQayBzdxUSa8CvJhPklIP/4RPqtmRdhf0uoN4Mnhd8CpeQVElVR0xyXAiD3inzx1jrW8s
	 Fs8EyUr5IITgjDDqFxIhxqL65yM7bqTF+wOlDC+gfkFwngnv9wNuXmUuiCisQqWvgBN3N
	 p9gAWxQopLyJFm0sVh4Z4c7kpccuxU0mbPeuHAxkWc/Cy/j2jL6LHjueGCrK/bd3cd0+3
	 DVNFirTyFTMIE+J2z7pIQmmz2Fti7fFqhiu21d0KpPN2sqtz8sl8xM4pd0FRw7R7kpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2hAxtMD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D15606A31C;
	Tue, 10 Nov 2026 02:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2hAxtMD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794278516;
	b=Rr4ToNFxdtn6L/Ke9rnzPPvIL3avMZPZfcED6BYZK6Yyh7zww2fN+ldQg/Jehc/AaadQ
	 SGg+vzSFO4wT56ujnQjoTR4zdn2e22oU5+CtnA+9rDEzFKgd2St4AC6yPmXKjJANofJ/I
	 JdMQLR5xlmhfGGztcCab9fnGfQ0dECoZxdLTRwbUM3lE8nKKPJBi3Xr1CxPJ0yS63DVkw
	 OOQxMi+DHX59rZWCvDN/kDm1/rQ/WPl15ghbeejtyChf6lylJJjLYQEzuS1VjYVwLNR1+
	 8K5gFJ0NFX6km2JUUjDSSvKInIXcs7PEa9aKPMGzxEqkSa5JsGg8OlXTkg7m2en9IyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794278516;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Gf5vm7cvpgQIIcKEgetbD//2pRCYO1NBnRFDgRJ50lo=;
	b=Bcvd8GNjWD1ma2zJqEa5vIiMowCk5EoJLeyUHqkTkpNnT52nU/BfSD9nXtuUFG8mbuI0
	 k3m+/3u9wATWZo+R7yQjb0frMyl0jddRyz5MdKksUwd2bQQPIC1J0uRLm2GAuIJ0r+WgG
	 SW7B2EnMXYPYcKH+bA+DngZLHxhzzTRJAlBlCN0vi3/ndlVRWMoAHxk7/5nHWngyGSjEX
	 ZSdcTys6vb0mnBWgtUohQPR1c5z1V6S26Lvs7wIu6kRuGzdmbBWGS+4b7XyndlyYLtJoA
	 WOBmUdmbAwjEIdYVMbHq3QAcXg+xDAyWHk+cPCLyc5mMjUDy1YjR1w+31kiDl0I78ow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 99ABD1F0089F;
	Tue, 10 Nov 2026 02:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278516;
	bh=Gf5vm7cvpgQIIcKEgetbD//2pRCYO1NBnRFDgRJ50lo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=D2hAxtMDMg7Jg4UkP6LK3pTlIVBYdpWnUf74FfaTcvhvkko9ewdzmQau9qCmGEeeF
	 yf0tL7ERBurMPJUYszdOI+fiybnYK1sUgN4FOYtf7nlvkiToBSt+KoJGg075s8GnJJ
	 XrBsZhi/HRCuuSAHxoTOaGGS4lu6N5ZwlAKx/HyGMiVO1SJ90V0ywuQrIEJN4wwwGz
	 AwEq3lf9ZTtUG5lZVhsQFZUQoC2BHrQcfpVI6vf5i6k3Wb6TwsJhK8HUn7FAo7UIZW
	 NVCRBIWuidH7OnLIE5KmKgC2VnpEedNV9jEBhXaZBimSs0OBt8BaGu2+5eqbKFmTlG
	 ddwhTU9rjeSww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1679948786;
	Tue, 10 Nov 2026 02:41:55 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Subject: [PATCH v7 0/4] usb: gadget: gadgetfs: fix ep0 request lifetime and
 event counter
Date: Tue, 10 Nov 2026 11:40:46 +0900
Message-Id: <20261110-gadgetfs-v7-v7-0-6d05409cc61a@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAC6E8moC/yXMQQ5AMBBA0avIrDVpJ6G4ilgUo8YC6SAScXfF8
 i3+v0AoMAlUyQWBDhZe5gibJtCNbvakuI8G1JgbY7Tyrve0DaIOqyjD0hUZOo0WYrEGGvj8bnX
 zW/Z2om57F3DfD5UYMlVvAAAA
X-Change-ID: 20261110-gadgetfs-v7-e529a852a027
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jing Lin <kayano050408@gmail.com>, stable@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794278513; l=3007;
 i=kayano050408@gmail.com; s=p600; h=from:subject:message-id;
 bh=PKUcg2l0YyjidzyI3AUerGASJfY84sbnjO7rcZqOJPg=;
 b=NnWcF6I+zVGDvJeFUfJlAm8S7qzFCsny+XGnztNTG2DNjspzooMcfYPkK3WFuK/cAlAGGcvur
 ywUX4a/2pnnB/0YlDNactv9yx+LZckTiILL/B+NIaB18HztasrtTpOW
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/p600 with
 auth_id=1475
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com

This series fixes the ep0 request lifetime and shared request buffer
races in gadgetfs, and the pre-existing event counter underflow.

The first patch covers request lifetime and buffer ownership, the second
the ep0 setup abort and unbind state races, the third the event counter
underflow, and the fourth removes the const cast in gadgetfs_setup().

The setup() callback runs in interrupt context and may not sleep, so a
mutex cannot be used to serialize it against ep0_read() and ep0_write().
The shared request state remains protected by dev->lock and the control
payloads are handed off through private buffers.

Changes in v7:
- Split the former lifetime patch into separate request lifetime and
  buffer ownership and setup abort and unbind state race patches, as
  requested by Alan Stern.
- Submit ep0 requests through a shared queue_ep0_req() helper and wake
  dev->wait on every runtime clear of ep0_req_queued, including failed
  submissions.
- Wait for the asynchronous dequeue completion under dev->lock in
  gadgetfs_unbind().  If the controller rejects ep0 dequeue, keep the
  request and its dev reference and let completion free it after
  udc_stop() drains ep0.
- Destroy non-ep0 endpoint files before tearing down dev->req, matching
  the order in which the endpoints are created and destroyed.
- Record setup_abort before gadgetfs_setup() early returns, keep
  ep0_poll() from consuming it, include state changes and setup_generation
  in the ep0_read() wait, and return -ESRCH from event reads after
  unbind.
- Ignore zero-length ep0_read() calls while a non-zero control OUT data
  stage is pending so they cannot clobber its payload.
- Address the remaining Sashiko findings from v6 patch 1, including the
  ep0_write() state transition around copy_from_user() and the unbind
  event path.
- Write only event->u.setup.wLength in the const setup pointer patch, as
  suggested by Alan Stern.
- Link to v6: https://patch.msgid.link/20261109-b4-gadgetfs-ep0-v6-0-b410e3dced89@gmail.com

The series was tested with the syzbot reproducer and with targeted
lifecycle, request-reuse, abort, unbind, and event-counter tests on
arm64 QEMU with dummy_hcd, KASAN, and lockdep.  The syzbot reproducer
still exits 137 on the fixed kernel without a BUG, WARNING, KASAN
report, or lockdep splat.

Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
Jing Lin (4):
      usb: gadget: gadgetfs: fix ep0 request lifetime and buffer races
      usb: gadget: gadgetfs: fix ep0 setup abort and unbind state races
      usb: gadget: gadgetfs: prevent ep0 event counter underflow
      usb: gadget: gadgetfs: avoid writing through the const setup pointer

 drivers/usb/gadget/legacy/inode.c | 395 ++++++++++++++++++++++++++------------
 1 file changed, 276 insertions(+), 119 deletions(-)
---
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
change-id: 20261110-gadgetfs-v7-e529a852a027

Best regards,
--  
Jing Lin <kayano050408@gmail.com>


