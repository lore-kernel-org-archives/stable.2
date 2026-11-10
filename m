Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794278517;
	b=WrE4Sy36UlmvWpaRQi8CRJMgFx6DoZkCuw8xwXMDe6n4COuOFAPplgmwXqNfSVqPBCpf
	 P+Wl6qGZSPZj7jX9+DzPiifSai6+848z7+h5zcdME+4jaGSACoLeunjaDicztPk1cQdmA
	 91LDKuJhv7+JEn1sFeyavzCShE1FzNZR54VtJwoIpViMvAPcgEbhVMIRo+H4QVloT/YGk
	 3QsPLFxjYJwc53Ez8pCo15uZ6v0cVfGY6AEHN9o27x6Ed14q5E/bGc6fM/y3xXrXGxgTP
	 goofiAsz7+Y31iAJgWOvlLLtdNxer6y1RgPIdHnQ6YQ/66rxoiRbRY1HHoBCHDIpvdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278517;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RQsONjRoXLg6EuvkW3CkhSlVC9XER7v6DGx4Vdolecw=;
	b=ouYMNHxE8GXdiZe6tc7N3Ut0bfEKAbY5Sajc2Yd0PvDeiXpkTdCuugmtcr8kh7k0Dg+7
	 XWJZ3Tef/8dMfg2OkPIcakeWB25nrMKkBA84aS6d+Rfk3J2bx5QWxzRWhNGoV8AecTMDD
	 PFlhDlM03koA3cFmhXfrA9qa0EJIsULPxI15rtG//7uLpt+zwUEwyclJFlasKgsIKiYuz
	 UfbVmKtlXsgwHaW5pVI7CNhOuzVMf1P5fcbqvVlhv0YyI6skbMYR6/eeljC/cHq5ttOcS
	 YuwLO+PJpPjTeYpWytturx6gGZw0xe5fYK6FMa5HVfpZZr2/Tw23Ijz/8rfUKw9Mr9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PkkqIa3s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B19606A32E;
	Tue, 10 Nov 2026 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PkkqIa3s
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794278516;
	b=ryESLPQgKsm4kgoJ45vULWZkwyZq1s/oYXARWy9hg5dMmyygrLtxKVtOmoLpbUoG6Dm4
	 CEo96Dua63iKYOb6AAtepmYMImjKZyfIpDn/U/A+xHhQl7mmpf3S5g9p12/FL6Aeu3z44
	 bE8LLE0hg7WZG8LsuV12wEddlcA3KvE8V/gdt54EyERr6YNIRHzlN+Quzo9qfSNxnMBle
	 T5aJTNCY1vO2Zk72PBS7f1girJULVpUKp3uQZQDlRY+hANvoVNCJ3yp1vmXJweaNrsgSu
	 nhZ4yvk57v+Q0DSQaPUaQbgdpe6Z/7YXH/TMSiiIZDmmQ9FTZz6exnbriAuHRbjTHcw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794278516;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RQsONjRoXLg6EuvkW3CkhSlVC9XER7v6DGx4Vdolecw=;
	b=xXIvVkJoUqHO948INHe63AncLwlQkVxYA0TlpM+1aGDv2bpkaEbnF2tW4JUcOzPYnUFg
	 JER7YnR6UY9BBPM/pFSAqUfGi2hX5cZxWtRlyyQHNMrv0KFgrkS3+sZQqGx3dy8iqxQ+y
	 +r97blwuWI/KIo3QQJ00KW2VgUBKuyTTWB+7zWSIOItKRcULwrcFwk/zIvtJX4jVjuZ3Y
	 z3U1ShU0cVE26qw4WYEQfiStmtfKhd+w5y1JL4o4nOiWRM8oVHC527f3NX8OKbxcubx1h
	 F6KiUa5Vb0/SpVvSya18OliNoGoQb5Onu1N1uNJLEP8HsMZpojnascGG5w0DFh1T3SQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D7D131F008A4;
	Tue, 10 Nov 2026 02:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278516;
	bh=RQsONjRoXLg6EuvkW3CkhSlVC9XER7v6DGx4Vdolecw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PkkqIa3smcaYcqQ+Z9HkY8UzSJaYP/TPnTJ/ah9hoC7GaCDTSJLqRwgH2elUiaddP
	 zrsxO9Nwj2+7t03V+opB7IP3flUOOboLv3f7VzD4wLBdK48sfc1HwuL6IzPf4SkA4J
	 NAwAOgR+QGtOXlpT+heEDLWEZVZg3zxlS44PUtkURnRfRhsNgtD02dlHr79bmKsXvf
	 64ZiIZvf2zZUKEl69DenaSKyuJCtpY46kmU+xbzJaocXL+rwPs/iw6D6vA45JEMQr6
	 NGbYIkWh+O0hKkoCpl2373VZ6RaVDyyATz4VAWhgzQ8ugWedppSb/I9k8f/ePtDmJC
	 A+id06B6I78og==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 62EE648792;
	Tue, 10 Nov 2026 02:41:55 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 11:40:50 +0900
Subject: [PATCH v7 4/4] usb: gadget: gadgetfs: avoid writing through the
 const setup pointer
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
Message-Id: <20261110-gadgetfs-v7-v7-4-6d05409cc61a@gmail.com>
References: <20261110-gadgetfs-v7-v7-0-6d05409cc61a@gmail.com>
In-Reply-To: <20261110-gadgetfs-v7-v7-0-6d05409cc61a@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jing Lin <kayano050408@gmail.com>, stable@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794278513; l=1583;
 i=kayano050408@gmail.com; s=p600; h=from:subject:message-id;
 bh=BRGg0GeWE86bbv0IxEfBEmu9UWVpi4xtBx5TMnNOtNU=;
 b=zuIrGohD8/uC8cnt9yxToCKhQ7355VL5yMElq3Lw6aC1pOLx7emjXeBOgWaubXzz1uJFjoA+P
 zjyVNzGRgXmBuwGLaqMMZhICmqw1EJByQv1KTVFStBk1ncBS4+yDsCJ
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/p600 with
 auth_id=1475
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

gadgetfs_setup() receives the setup packet as const, but clamps an
oversized control IN request by casting away the constness and writing
the truncated length back into the caller's wLength field.

The setup() callback has no business modifying the setup packet, and
ctrl->wLength is only used afterwards when initializing event->u.setup.
Store the clamped w_length into event->u.setup.wLength directly instead.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 0b3210f87..5970f0c85 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1600,10 +1600,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 
 	if (w_length > RBUF_SIZE) {
 		if (ctrl->bRequestType & USB_DIR_IN) {
-			/* Cast away the const, we are going to overwrite on purpose. */
-			__le16 *temp = (__le16 *)&ctrl->wLength;
-
-			*temp = cpu_to_le16(RBUF_SIZE);
 			w_length = RBUF_SIZE;
 		} else {
 			spin_unlock(&dev->lock);
@@ -1761,6 +1757,8 @@ delegate:
 			/* state changes when reader collects event */
 			event = next_event (dev, GADGETFS_SETUP);
 			event->u.setup = *ctrl;
+			/* Report the length we can actually handle */
+			event->u.setup.wLength = cpu_to_le16(w_length);
 			ep0_readable (dev);
 			spin_unlock (&dev->lock);
 			/*

-- 
Git-155)


