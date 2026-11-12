Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493392;
	b=Rsba4Ec/bCYIAF5gOgBfwm5Z80ooxTyNh3jzNVBKX08b3AOKYWlEcdF/czrvxox4zKAM
	 Frz97hJRxtu/tEThdt5MDZp982g+1KDV2BJoITRRnO36N698YWm6+GpB7tkkLOj3IvbH1
	 rke60zPjeuA6V5FLgTrMYw3OJrYVmWnNEhH93K3wgWVxOkDBloUTdhfoT9BUIS7BzZVIW
	 xjoH2xbcYpDIiWLgCircVBF8Ie6HzqOpJq6oeDJ3e1zuIrXW/wKu46lEXo6cjQVc1AfXj
	 oLeRAC2wIyPp7Nza8s8b7F4VYqwC0tHmUQ3kRHrYzagj0eIwilcbzRVXrrYAFfd8oeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493392;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LVlcHVe8/7X0mUIuney01PS07LJsDftBfDsKm2npMBg=;
	b=vLco5k+NzveSFv96bMojbQEujBrQ/K687pCsxpn+mBS3mcem8K6CfnjqqoACUKwuoHC+
	 fq6xMumBU0upsKHSVbOG7fYR6AHG2vM6mTODN1EXjYpLLvulF539h1vGEkpiz6LNEaQ+U
	 ldjBZ4UPcMnLdMbscIOKhG8/1tcYjAnQa+Py2as1dkg2qO8n62SkgrQ/J1gyQWYg1ieKt
	 1KjA6s6dSeT5Nvkx7Ac+44DV7hUNPkYnEoGedZbN5AnfExP5tr28oGa1zIPLDYNnqMOMa
	 bCssXkkPy3RlIJYx4Ztoi5o7arrYZvYOxc2mEKU79wpGDvyFJIHGDvPeDfbjGMZM9Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io3Av5M2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDD606A33D;
	Thu, 12 Nov 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io3Av5M2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220B81F00A05;
	Thu, 12 Nov 2026 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493392;
	bh=LVlcHVe8/7X0mUIuney01PS07LJsDftBfDsKm2npMBg=;
	h=From:To:Cc:Subject:Date;
	b=io3Av5M2/mWX3YE+iz62RG1EoJWRr/XxC0D2Es6yI5yFXTComFXLxwMWbC4tudLiD
	 B+MOZzyIbfLrYMZZiEKqR4kcP5lh1zlB3CmHOYG58vmDnFlaCqa0zU2Ky0a1tvKM2D
	 eIkbjg2YvkV+NpxUuXlGh8TKYQFPrp3CDo2qIYtOSPqLZNuPV9bY4hWGSM92xG/x7l
	 opKcSbmOLR5S6iPQmChB7zeizuSclkBtyP94AYTwWajsbP43D/AsEA6LL55/DlE/hb
	 MHVXpMrVWqP0vCDsPbar3G1syQgvvTDkE7/ISs1MUigPktldAHd3DlgDnEID+dxNB4
	 U2BbRqyaPTn5g==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xRVhl-00000001uCu-46At;
	Thu, 12 Nov 2026 15:23:09 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: core: fix use-after-free after driver module unload
Date: Thu, 12 Nov 2026 15:22:09 +0100
Message-ID: <20261112142209.454331-1-johan@kernel.org>
X-Mailer: git-send-email 2.56.1
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

Deregistering a uart driver frees the driver uart state including the
tty ports themselves.

Restore the uart driver module as owner of the tty driver so that the
uart state and resources like the tty driver name do not go away while a
tty is still open.

This specifically avoids use-after-free when accessing the tty port and
crashes when accessing the tty driver name (e.g. in the tty printk
macros) when a tty is closed after its driver module has been unloaded.

It also makes sure that the uart state is still valid when waking up any
waiters after releasing the final uart port reference in
uart_port_deref().

Note that a few drivers deregister their uart drivers also when a
(platform) device is manually unbound through sysfs (but if you use that
interface, you get to keep the pieces).

Fixes: 2f16669d322e ("TTY: remove re-assignments to tty_driver members")
Cc: stable@vger.kernel.org	# 3.4
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

I hit this when investigating a deregistration race that can lead to a
deadlock:

	https://lore.kernel.org/lkml/avSAyV6QE0Id3rAk@hovoldconsulting.com/

Sashiko noted that this is actually a regression in 3.4.

Johan


Changes in v2:
 - pin the driver module by restoring the tty driver owner field
 - mention that some drivers also deregister their uart drivers on
   manual unbind of a (platform) device through sysfs


 drivers/tty/serial/serial_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2e53d194ecfe..5492bffd3456 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2813,6 +2813,7 @@ int uart_register_driver(struct uart_driver *drv)
 
 	drv->tty_driver = normal;
 
+	normal->owner		= drv->owner;
 	normal->driver_name	= drv->driver_name;
 	normal->name		= drv->dev_name;
 	normal->major		= drv->major;
-- 
2.56.1

