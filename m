Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832618A6CF
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053049; cv=none; b=RNkYD0ZtoPJG3zYnfKeAsU3g2a3jLElVwuScTZKDILc2NMmvbI48nYzhLR84IkUQ8uMpNdaxOMZCtJpPcC8EpnRhpImk8hylyr54r9+PqX+f6EZa8N/+H1xY8qkjrd8s5T+6Z+5p+KODJ7WC9bghqwkxvqynSN7jMwIHFihoE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053049; c=relaxed/simple;
	bh=uOw43cY5CFaZn7+En1oq5YwV75CCsUyuLFnnYcXME/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBpfNvhxVjWUWu0H9i8qOYvURR9AVKM2sJYQMVpnD+TwMgO1CQVLuPcXziDYaJ4FJAoO/J0TJSe9A+rn5ULYCWycFr1fT2EErvAYg5DoB5o19f/xGxSKdMyYi8MBms1bh6HX24d20O41AgFfN4hJLXdDgGjECXhORxNXR9TReTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJR7AgyF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJR7AgyF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso19406545ad.1
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785053048; x=1785657848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DDLn61lk0snfIlNoYnHbyGIh3D2QrLa/9o3Vxcdtv5k=;
        b=CJR7AgyFLXPjAoanrcaaK7aebBEPyjoPz4o5Bjz6nhAf7pbuN7HQngWISk6C62FSjS
         5Ia4SWOHOBp47dpGZBRmJ7/Nzw70VX5Qf5bYa2MLRZk/pIReVRjd4AZI7HG7MDitLuFw
         Ku/NwVjuB15v9uNIVsTuGq5EZigJwPlj20Y8/IXNnSFUjtFfeNuNXRbVrpdu4mrAARPC
         tV55/lFXs56LA0+d+dJ6ldGXL251/LLV+n3MsECR4riYZdDiA+0ZjlMO0dAj3E6h9dad
         Frf0Q2qyYXPBhU52/tpsnHBuyZwif4K/qDdSErm89h+Htz5lpgeMBNrPK93Jq/MMnTwf
         buvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785053048; x=1785657848;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDLn61lk0snfIlNoYnHbyGIh3D2QrLa/9o3Vxcdtv5k=;
        b=H1pioiv8e81+2NxUxYV5TwhyrC96y/UvR+WM97wJeb7JNzABMZgnsJJTb3hGAKr7Lp
         fVItk2UNPHObM8Hf1tRO12cODGui5bd4bAIwkaUDgPO4LPZJH099622QDCgmYK5GHhkb
         8NrgnwWO75cWniqTdEiQ1YVhW+CN3trKqgkvKOK9zkBqvDrOUX2L16rh3TBnAzEYlsig
         hSwOMULU8p+dc1jJxbZ4ywpxqiDmtKy7Ms3g0aP+iGi8flEXW2gN5lumYO95apAoNlhK
         Ge1RiDFZWFzUqSL7Qfn6zuvJ01hCfi47rolkrpRRrbPxk5xFPf9cpyCDdDaKcviqoM1L
         xjeg==
X-Forwarded-Encrypted: i=1; AHgh+Ro78RV96PcoN2H+TjkQqUar8cUsf9VSiNs3jOR/9PlkAii1onXWzwXwDmeLKjyRnPqyUut8gvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzxJCJJvR1d6R056C8sSAwX+hmhhrEqdcxXL8Sf/Bx6yjednK
	Wp/xGhMjn9F5zVGhds9NratyXjH7pUAABV+Ov1FlRemX1r35BsVX9ibm
X-Gm-Gg: AR+sD11++5npMmY9WgEkQBqaNKDcasaWRQG5EXsVFkX8lCKwzvh+Damqc3iVbVAjZ6Y
	/Zf05eydFW4zB0baZ6tj5SpJN7ujY0t5TqolDvUIIzInojOO+2/+o5R3PotwQO3guDe5seReZKo
	0x0JOb6RYV7mt3q8D+e9Xqvi37fd6fNKnefzHvB8zhbKPzXdFchRJysflc+I4FCqnOUTJt8NEIf
	Z8IOF8rRN98oyWUarOVljXiyRkAw/rR3pjyOmirBTpQiDS6UXA18RlghUrrkp0gUXOQUL38DyDr
	V5byzmNSmTBPSFMT8sHtIWH3p1EQ9NfSs7Lqqv6zlqf5RN8HzlGVmDQQ9juJsbA7dC7AsF3Zqg8
	zErXC2J2ZgTBe/L4nc1GGP8mmuymmM2cDxM+u5p3AGQkgBBv8CG5SK5u2o+kEd/qAGEx2lJfzg4
	jIFHUrywL5lN86C+YgPbSxQ9Yw9fRu6evFa9y45pnDFvhilBYoN17m/RHQwYqoZKo=
X-Received: by 2002:a17:902:f685:b0:2c9:97a7:3289 with SMTP id d9443c01a7336-2cfde887767mr48077875ad.43.1785053047736;
        Sun, 26 Jul 2026 01:04:07 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b8esm17503365ad.31.2026.07.26.01.04.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 01:04:07 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] usb: misc: usbio: reject endpoints smaller than the packet header
Date: Sun, 26 Jul 2026 16:59:11 +0900
Message-ID: <20260726080129.44969-2-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726080129.44969-1-skyexpoc@gmail.com>
References: <20260726080129.44969-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbio_ctrl_msg() and usbio_bulk_msg() bound the caller's transfer sizes
against the endpoint packet size minus the fixed protocol header:

	if ((obuf_len > (usbio->txbuf_len - sizeof(*bpkt))) ||
	    (ibuf_len > (usbio->txbuf_len - sizeof(*bpkt))))
		return -EMSGSIZE;

usbio->txbuf_len is a u16 and sizeof(*bpkt) is a size_t, so the
subtraction is done in size_t.  struct usbio_bulk_packet is 5 bytes and
struct usbio_ctrl_packet is 4 bytes, so any endpoint smaller than that
makes the expression wrap to a value close to ULONG_MAX, both
comparisons become false and the check is disabled.

txbuf_len and rxbuf_len come from the bulk endpoint wMaxPacketSize.
usb_parse_endpoint() only clamps wMaxPacketSize downwards, it never
enforces a lower bound:

	if (maxp > j) {
		dev_notice(ddev, "... has invalid maxpacket %d, setting to %d\n",
		    ..., maxp, j);
		maxp = j;
		endpoint->desc.wMaxPacketSize = cpu_to_le16(i | maxp);
	}

A wMaxPacketSize of 0 is merely logged with dev_notice(), and a bulk
endpoint declaring 1 is accepted verbatim.  usb_submit_urb() rejects
maxpacket 0, but nothing rejects 1.

A device claiming one of the ids in usbio_table[] and advertising a bulk
out endpoint with wMaxPacketSize 1 therefore ends up with a one byte
usbio->txbuf, and the very first I2C transfer reaches usbio_bulk_msg()
via usbio_i2c_init() with obuf_len = 7.  The wrapped check passes and the
packet header stores overflow the slab object before memcpy() is even
reached:

	bpkt = usbio->txbuf;
	bpkt->header.type = type;	/* txbuf[0] */
	bpkt->header.cmd = cmd;		/* txbuf[1], out of bounds */
	bpkt->header.flags = ...;	/* txbuf[2], out of bounds */
	bpkt->len = cpu_to_le16(obuf_len);	/* txbuf[3..4] */
	memcpy(bpkt->data, obuf, obuf_len);	/* txbuf[5..] */

Note that this is all complete before usb_bulk_msg() is called, so it
does not depend on the host controller being willing to run a transfer
on such an endpoint.  With KASAN it is a slab-out-of-bounds write.
Through usbio_i2c_write() obuf_len becomes sizeof(struct usbio_i2c_rw) +
msg->len, so the length and the contents of the overflow are controlled
by whoever can issue I2C transfers, up to the 4096 byte adapter limit.

wMaxPacketSize 0 is worse in a different way: devm_kzalloc(dev, 0)
returns ZERO_SIZE_PTR rather than NULL, so the existing

	if (!usbio->txbuf)
		return -ENOMEM;

does not catch it and the same header stores dereference ZERO_SIZE_PTR.
usbio_bulk_recv() has the same problem on the receive side: it reads
bpkt->header.flags at offset 2 of usbio->rxbuf before any length
validation.

The control side is different.  For low, full and high speed hub.c
forces ep0 wMaxPacketSize to 8, 16, 32 or 64, all larger than the
control header, so usbio_ctrl_msg()'s check cannot wrap there.  For
SuperSpeed it accepts any bMaxPacketSize0 that encodes a non-zero value:

	i = maxp0;
	if (udev->speed >= USB_SPEED_SUPER) {
		if (maxp0 <= 16)
			i = 1 << maxp0;
		else
			i = 0;		/* Invalid */
	}

combined with "(udev->speed >= USB_SPEED_SUPER && i > 0)" below, so
bMaxPacketSize0 of 0 or 1 gives a ctrlbuf of 1 or 2 bytes and the same
wrap, during the five usbio_ctrl_msg() calls in usbio_probe().  Whether
a given host controller will operate such an ep0 has not been
established; the control length is checked here regardless so that the
invariant is stated once for all three buffers.

Validate the three lengths in usbio_probe(), which is the only place
that assigns them, instead of hardening each arithmetic site.  A bridge
whose endpoints cannot even carry the protocol header is unusable, so
refusing to probe is the correct outcome.  Rejecting the equal case as
well is deliberate: it does not wrap, but it leaves no room for a
payload, and excluding it makes every "<buf>_len - sizeof(*pkt)" in the
driver a valid size of at least one.

No supported bridge is affected.  The low, full and high speed devices
this driver binds to have an ep0 packet size of at least 8, and they use
bulk endpoints of 64, or 63 via USBIO_QUIRK_BULK_MAXP_63.

Found by code review, doing variant analysis on the code around
8c6314489550.  The overflow was reproduced under AddressSanitizer with a
userspace model of usbio_probe() and usbio_bulk_msg() that uses this
driver's struct definitions, checks and stores verbatim; it has not been
exercised on hardware or on dummy_hcd.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
--- a/drivers/usb/misc/usbio.c
+++ b/drivers/usb/misc/usbio.c
@@ -577,6 +577,24 @@
 
 	usbio->ctrl_pipe = usb_endpoint_num(&udev->ep0.desc);
 	usbio->ctrlbuf_len = usb_maxpacket(udev, usbio->ctrl_pipe);
+
+	/*
+	 * Every transfer starts with a fixed size packet header and the length
+	 * checks in usbio_ctrl_msg() and usbio_bulk_msg() are computed as
+	 * "<buf>_len - sizeof(*pkt)".  Those lengths are u16 while sizeof() is
+	 * size_t, so an endpoint smaller than its header makes the subtraction
+	 * wrap to a huge value, disabling the checks and overflowing the
+	 * buffers.  An endpoint exactly the size of the header does not wrap
+	 * but leaves no room for a payload, so reject that too and every
+	 * "<buf>_len - sizeof(*pkt)" below is a valid size of at least one.
+	 * usbio_probe() is the only place assigning these lengths, so
+	 * validating them once here covers every user.
+	 */
+	if (usbio->ctrlbuf_len <= sizeof(struct usbio_ctrl_packet))
+		return dev_err_probe(dev, -EINVAL,
+				     "Control endpoint maxpacket too small: %u\n",
+				     usbio->ctrlbuf_len);
+
 	usbio->ctrlbuf = devm_kzalloc(dev, usbio->ctrlbuf_len, GFP_KERNEL);
 	if (!usbio->ctrlbuf)
 		return -ENOMEM;
@@ -596,6 +614,11 @@
 	else
 		usbio->txbuf_len = usb_endpoint_maxp(ep_out);
 
+	if (usbio->txbuf_len <= sizeof(struct usbio_bulk_packet))
+		return dev_err_probe(dev, -EINVAL,
+				     "Bulk out endpoint maxpacket too small: %u\n",
+				     usbio->txbuf_len);
+
 	usbio->txbuf = devm_kzalloc(dev, usbio->txbuf_len, GFP_KERNEL);
 	if (!usbio->txbuf)
 		return -ENOMEM;
@@ -607,6 +630,11 @@
 	else
 		usbio->rxbuf_len = usb_endpoint_maxp(ep_in);
 
+	if (usbio->rxbuf_len <= sizeof(struct usbio_bulk_packet))
+		return dev_err_probe(dev, -EINVAL,
+				     "Bulk in endpoint maxpacket too small: %u\n",
+				     usbio->rxbuf_len);
+
 	usbio->rxbuf = devm_kzalloc(dev, usbio->rxbuf_len, GFP_KERNEL);
 	if (!usbio->rxbuf)
 		return -ENOMEM;
-- 
2.51.0

