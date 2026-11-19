Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078433;
	b=IHuxH6t+Bv7JZ7OvZsZZsP3b2SqGG7vdgWnUKVl1Q+cI4+23Q/lttmoiAn+wS/oT95e/
	 cACAlHtTLCyfeZgCRCoS2ih9Ds60SxfDSuPwtp1toLXhX3Z8QVYaNZV/yqAnVnhwp1oHr
	 tMYCEXIQmr7XxLaH7bJewNY5LOEw/OhW8lt+0nz/LyTKFtiAgFBpRi2ZXkCFnm1jQ2NRn
	 +EToQ3fY2IehRPzZ54lF9Uc0Z0BE6fQHPXQ7hVwJqN60Dr8tFyTsQwsNazQtbqgC5dTRL
	 JwGcMC4WO4663dfNfooSeVTklCgWUWpMfpd6AYcwnqRkcmlVxrYe3u02DfTmL2M4AyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078433;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QJI+KfUGVHKEr1mdTWXtz7Qv+CTEib6/inHublf4J/w=;
	b=PjIa/NFKIey0WRz5XYZtPOW2ty7ejm5I4oCVcuJB+TrUA/hEQn0covLYdKRCrG39I2oV
	 Bpz1fNBFYAntGBwQUlkj4LnxEOsWx+IKhfMg6ele79YNQNRM84eNpbzTN1DPleV3NZgaI
	 pxi2OCTeTQrWXWBip97en9JNKWrYnp1JVpwGMahxhiUzp8fbRDyD6HiW0W9nQ+X4M+P5L
	 lK5f5JmTBf1vgNOUMdQjMVeYkE+zyJVTK9mGOrMIeDnkP4kKUCBU6xWNf0mASYPmNVBDD
	 F2VMWSqmBXogB+LUVX9IPwUJg0O+tfR4v9Y7v1qAm3oFFEEH8hUOEWhvvFsngLFed7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=L7AkpQ+z;
	arc=none smtp.remote-ip=79.135.106.27
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71FB606A32A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71FB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=L7AkpQ+z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1795078429; x=1795337629;
	bh=QJI+KfUGVHKEr1mdTWXtz7Qv+CTEib6/inHublf4J/w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=L7AkpQ+z49ZYKPf42RN3NKx8zjEvogc+9fHXwRqhYG5grMjg49JLPMTl33ZCVxXeY
	 Pvjr9hmnM5XHEo2Fy3ZdZkhslhVPpmvmhRNIdUhJYdViNcM+n6WC4xRa7LZce2U9+0
	 swhN+guKwokonydku1OYEoVdJU4odQtRCLWWBtwqRIaffLACMXbKY5uRTB88Y2zeql
	 9Lv40K9pbkuRUNe4KA2MZFhbkSXvEJiGU/ChLvZg5Qp7B9LbwkLJkUSKP00GJ9Dh0f
	 ra70HAgvnoCdod5p84v+lzVtnTTTsC76b/3liwG7fptDY+wf8/wwuty0kO8GsvUYGH
	 8C/QoUoJyshbg==
Date: Thu, 19 Nov 2026 08:53:43 +0000
To: Yasushi SHOJI <yashi@spacecubics.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Pavel Skripkin <paskripkin@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, linux-can@vger.kernel.org
Subject: [PATCH] can: mcba_usb: Fix double free of RX buffers in mcba_urb_unlink()
Message-ID: <20261119085329.539894-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: b59b133948a6ecb28f8b7fabb42d555e1530c669
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

mcba_urb_unlink() frees the RX buffers but leaves the stale pointers in
priv->rxbuf[]. It runs from both mcba_usb_close() and
mcba_usb_disconnect(), so once the interface has been up, the buffers
are freed twice: on unplug after "ip link set can0 down", on unplug
while can0 is up, or on a second up/down cycle. No special device
behaviour is needed; on a host controller without DMA the double
usb_free_coherent() is a double kfree().

Clear each rxbuf[] pointer after freeing it, which makes the function
safe to call twice again, as it was before commit 91c02557174b ("can:
mcba_usb: fix memory leak in mcba_usb").

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: 91c02557174b ("can: mcba_usb: fix memory leak in mcba_usb")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
An emulated adapter on dummy_hcd: "ip link set can0 up/down", then
unplug, gives a KASAN double-free in hcd_buffer_free() on v7.3.1 and
master 9d66f26fefac; the two other sequences as well. All clean with
the fix, and a second "ip link set up" still works.
Reproducer available on request.

 drivers/net/can/usb/mcba_usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.=
c
index 04170326dc7e..b40b323da9d3 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -718,9 +718,11 @@ static void mcba_urb_unlink(struct mcba_priv *priv)
=20
 =09usb_kill_anchored_urbs(&priv->rx_submitted);
=20
-=09for (i =3D 0; i < MCBA_MAX_RX_URBS; ++i)
+=09for (i =3D 0; i < MCBA_MAX_RX_URBS; ++i) {
 =09=09usb_free_coherent(priv->udev, MCBA_USB_RX_BUFF_SIZE,
 =09=09=09=09  priv->rxbuf[i], priv->rxbuf_dma[i]);
+=09=09priv->rxbuf[i] =3D NULL;
+=09}
=20
 =09usb_kill_anchored_urbs(&priv->tx_submitted);
 }

