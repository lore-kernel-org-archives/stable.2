Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675038;
	b=FZlg+bOK0yFt8ye5QVoPNPUHub/H0x4s/OBy1uyWD29IXv7PmNfW67U54GPTV0MT0L1/
	 VNVwVEHHdZHJFdiy/2UUDzGs+/IJlbYadPFJpPcX87RVOCC4JwolBjvHWyeTfJx5iBeaW
	 xBMQxDmepF9KGZHNPYhVYSvBMIcZi9sINBnUD8LJdka2VXPkuyH4TW+ZPHHimqMHGsUaZ
	 cFaq2YQYuQX6jGZClFscL2mMdPhcSlKodm61vaulR3dxHgbBz8TXLpa9qFq7T9GHBXAGW
	 /NaEUrtGHzAmykNhB42e4mmjWbRTbXqnTW0Q+r59G2yR7Be7RsPT24IzlS7C139oRDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675038;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=icoy7Gf/IplQfV6RecP1I466B7QBiJvV4Gvbs9QWtt8=;
	b=3ampvfW/3Mit86hr2Y0QL0jLGWcFSGFV7JqUen25zmgEO2btyRc3jnT3I3zHoKLujkdN
	 YV4b/Yd1B6XmspvGiH6R3ufhx9l4rRE4TtGy4CXkoqtosoxAqd/omfSsnBIhbUxnpGpBV
	 5F4Dzv10xQwB6JHEBgCaiYefnQCBmOzjiGu6TUhnFS//hJRqRKfHlq+wq7uQ5SEgwQ8CQ
	 pJG0+sAwrY87XAFRhPKsSF313rULZO9x1WOYFbMQBTcNRqnp0krtyj+FHekQG3vj51Wd9
	 4cIH8dI7M8XOHmJhhcSG+r5JSz2siY0eP89FjToqPRdrmnMvsHbbN2roGcglo29W92g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZjADE8f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C78606A32A;
	Thu, 26 Nov 2026 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZjADE8f
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795675038;
	b=q+q9wkpfZS0R+gFx5Jo8RH8GCW62o90tEO8juNNdiv3Gtqk2QkBMV1syWe0JMUQFDmUV
	 6CVW1xHiMkPw4N9Ruptxp/PW6UaQ3O8Cahs2dVqHijADYpPfBtmyXCqzw7lV+g3Tu5RyF
	 swl5ughYRLKqcM82hb91/XA5Q1q1GBWG4cgrRUIER8axozzwkAFTbS9ZLMCiESXwWE1m+
	 m81o6nVGPFv6IRt7TyMY2uRBgL1xSYpziT3Wc/TdC6VL/+e5vGV2r1dOo81w/beKGIni7
	 5jCbRYaOzC7RwLhyZrrTS7VI8mc4w0lSpgKCUkv+KulvenlEqcKmbSh3RGBkeDqDGqA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675038;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=icoy7Gf/IplQfV6RecP1I466B7QBiJvV4Gvbs9QWtt8=;
	b=m/yZObVKp+3SPkfK6nstmopkf6QHif9H4NQkO7RU/uCMJ4RolL+9/wvSHvE4r5iQB21f
	 vGV/Zy+axUqzRfI6uChfeAchr3aOTEhbkwdy5mmJkSevwxIDCKJwGMa8cYuBITYlR/NLl
	 gvo8HcjjtneJuahQ16JFatmmJNM0NZaojwNN1eI1Kwwsq1RvWMiHnJxobDq5EdJ7AKbu9
	 gBb8z0dx3SRDrYUI6+GNtjNKhZOzJMaYVUwz62sOJY53wYRNo85bRtFKPhCnqoj6cSBQd
	 zl97vVpTvCkP7ch80PCqRSACiUeyQzA5nPARH9Z6d+PjiO2lWr3cCI8WrC4PYr8D+0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AE2D51F000D3;
	Thu, 26 Nov 2026 06:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675038;
	bh=icoy7Gf/IplQfV6RecP1I466B7QBiJvV4Gvbs9QWtt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DZjADE8fN0KMq0+gjGUdqblA21QfG85k+qIlCnaJ3QD9rH4AVCy1LxwppRDZjlt5t
	 AwFlv6vrHlByB2vIfKfYmYh6Dqxongj7SwmawEbOQD/FGZkV1x7UXUxShKD5dIvze2
	 Odr3rTdBj2y+m/LTfaH3mKO/5NXjZH68hmqCjGE/Z2tsciUtKX4PW33V1CWpcRAmKS
	 zB2J7iRkyIJWDJnUSZMobB3LCMM1KXObRVpMNijfthwRgWXYcaf9A43YtEDd6xZm0x
	 g7b0Hddk2M/9k+ia/PAcvwSw2WibNu5K+V1Krk8axXrjlTXPoIFcUusWLTJjOxegYU
	 p2bu8EPw7at/g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7576A4D2A4;
	Thu, 26 Nov 2026 06:37:07 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:37:09 +0800
Subject: [PATCH v9 6/6] usb: gadget: gadgetfs: avoid writing through the
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
Message-Id: <20261126-gadgetfs-ep0-v9-6-81b464c6e641@gmail.com>
References: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
In-Reply-To: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795675025; l=1670;
 i=kayano050408@gmail.com; s=20261126; h=from:subject:message-id;
 bh=ZBmJwrzWJL9P5eP6VSC8U6h5A7VH0l7p13ihjdZGb7w=;
 b=3TXpwFa6U/3EMgBjYxWlYlpC3kgKe550IuQahTxs9KNubb+wEiuOBntzrx8jvJ3i/KgqT9ejT
 OW11N1b1shKCWEB+wsWUjf18Ih9QdiFZti7nxyzUkJl0KsvpWuXxu9+
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=40M3hugIx++9w3nkAoFXGcN/vLWsPMGDYdbduV+lUlI=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/20261126 with
 auth_id=1648
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

gadgetfs_setup() receives the setup packet as const, but clamps an
oversized control-IN request by casting away the constness and writing
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
index bd77d0848db2..eb8b0d152d4f 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1648,10 +1648,6 @@ gadgetfs_do_setup(struct dev_data *dev, const struct usb_ctrlrequest *ctrl,
 
 	if (w_length > RBUF_SIZE) {
 		if (ctrl->bRequestType & USB_DIR_IN) {
-			/* Cast away the const, we are going to overwrite on purpose. */
-			__le16 *temp = (__le16 *)&ctrl->wLength;
-
-			*temp = cpu_to_le16(RBUF_SIZE);
 			w_length = RBUF_SIZE;
 		} else {
 			return value;
@@ -1804,6 +1800,8 @@ gadgetfs_do_setup(struct dev_data *dev, const struct usb_ctrlrequest *ctrl,
 			/* state changes when reader collects event */
 			event = next_event (dev, GADGETFS_SETUP);
 			event->u.setup = *ctrl;
+			/* Report the length we can actually handle */
+			event->u.setup.wLength = cpu_to_le16(w_length);
 			ep0_readable (dev);
 			/*
 			 * Return USB_GADGET_DELAYED_STATUS as a workaround to

-- 
Git-155)


