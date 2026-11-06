Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952150;
	b=IG/8vD/7n8ZjoS52O+p91fqwBufG7tbmfeIhNkUzAsXmJ+55cL604vcXVd8E1TtHwHho
	 Qwgsw+iJahVST+lGUZ8Xi+PmOON8NvjopF6jI7VdxqBog+g22mgeq3cVCTmlqy7iMJKDr
	 nC6wawK5ISrtKv5MLYk/W5ic3ba1rOwEnyRY/GoJFxwTeBFyVhjslAnjgyeRxRvPsIewv
	 PaqIVLHR4ZS/BVTv0jBgajR6zpr6fuhrQkDrSnb3VsqksSgC2B3aAVrFI0jImTyRq43z7
	 cH4+0RPo07vYHlJACtKlkWnr+nGy+7EvI8GIkoyTWab6kmgK8gXm0/oznFF+zq/Nmcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952150;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DjfUCkwD8qRA4Uhsl9jOlY4UWrPe+9W9YxmV392X8vg=;
	b=0a7oSMBOLs3zzJ4u1kQDF2ncd1FyOHOATy3voPj93jt2d7oSWaC8fh10qkYoEvD0pWV/
	 lKKbMceyzvfgdAcjC4fp8uUswV2uM8/+uL7TwvL0IPHq+YI99P6CoCG9KrA8QOsPkBQmb
	 Mvyg5CutJK0DYMk35k7O8sVAWj7Up9yD14GQvVxdtiRQstEOhx+AhgJRoh2dAEM7ola4U
	 dsEJ4cjEtWXuyNKbuB3Ch7QfTW7NhEzgcsU7UFQl/gopxZoWHGv0Gm1D+7E2EhaTKq3dQ
	 qMyJrxtqEYvHzMho7j0jRtFDoxkQJgMvQfB6u+3UEoGHzEIqeHSBzNVI0Gi/LSFsMvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzVCI4JC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23999606A326;
	Fri,  6 Nov 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzVCI4JC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4D31F0089F;
	Fri,  6 Nov 2026 08:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793952149;
	bh=DjfUCkwD8qRA4Uhsl9jOlY4UWrPe+9W9YxmV392X8vg=;
	h=From:To:Cc:Subject:Date;
	b=CzVCI4JCU/F/oSpY/lTrB7XTLJF1ErmnXMc4fVoVNy90xtkz4QbN29KCkx/RPN/L6
	 cJeSZKBL+VO7Do57c4Y6ck8Rmbe/15FxR6nb5Fo6TDsOM9ghxspyr2BRnJ7gBnDav4
	 bnsYr4VR3ZR8s+VSIZyDpQaLyL57XQNrvijG7Lk/WPGQTSxyaRXA+ehAdCsD7tZDvs
	 TaeU61AQu5UMV/LiUvkFcGrpBL2Dsn40PWcT6uv8jEDQFwzpxX1BhZUfFc2BH0FY/D
	 lHWo8IfKXDPm2XUrEbGlE0sBuynlpqe/4VjIoVSABKrDLTF5qp7S33ca/TKnSFhh30
	 7N08RmG0bMdjg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xPEu3-00000008FkA-0aT7;
	Fri, 06 Nov 2026 09:02:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	syzbot+58b2d8b19cd6761a395b@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: mct_u232: fix NULL-deref on open() failure
Date: Fri,  6 Nov 2026 09:01:55 +0100
Message-ID: <20261106080155.1967097-1-johan@kernel.org>
X-Mailer: git-send-email 2.56.0
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

The driver uses a second interrupt endpoint for reading but still
dereferences the port bulk-in URB pointer, which is no longer overridden
by the driver, in an error path.

Fix the dev_err() on failure to submit the read interrupt URB to avoid
dereferencing a NULL-pointer.

Fixes: 35807187e4b3 ("USB: mct_u232: clean up read implementation")
Reported-by: syzbot+58b2d8b19cd6761a395b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/6aed834c.dadc8e63.45095.0003.GAE@google.com
Cc: stable@vger.kernel.org	# 3.10
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/mct_u232.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index a6de18917ec9..8a7aee2b26dd 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -457,7 +457,7 @@ static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	if (retval) {
 		dev_err(&port->dev,
 			"usb_submit_urb(read) failed pipe 0x%x err %d\n",
-			port->read_urb->pipe, retval);
+			priv->read_urb->pipe, retval);
 		goto error;
 	}
 
-- 
2.56.0

