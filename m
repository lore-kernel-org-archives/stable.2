Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AD3B27E1
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909800; cv=none; b=MEEVyhwIWuvHSF3E94yVgyAqNb8CRRIg6hVlqZDHtlb+1Dx/QxJ1sJHrv16He8we+vBpEzie9FSfb7zFiroustm2m2PGhTLkhwl7d0AAQp5s6m8/liomwR+HX17BILLKIxBA+qmO9jTZ6jJh5PENTYiVnQFkwQnneXm6ot9g5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909800; c=relaxed/simple;
	bh=XE93PARpsFUC8Fu5iBpHVIPInN7GAPqYBflYnDxSCcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxQtFChNyYMzsJXX0/CtD2LGlXY571rW4erXhASFpBAHSYVJ4dEFsp6c7i0qFhIfrulDL8XHKT7VJKW2HGVXHK/WDEesbYworBJ/bw09OogBaBA+cP7DnaY5+cUKwaxhJQZy/AW87Zv7auJFGA695MNNRzXEheI1MM8dyag6Zg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXU5LmdZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXU5LmdZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so2996526a91.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780909799; x=1781514599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssI6ZEk3gw66VAN5mRRaeGUv1dLfHJJ6NdyjMb06HLE=;
        b=hXU5LmdZYyiDEn+bjDyaKZmC2hK/FAc53r4Jb43vlhwESd34WxcGddTg32qDUYEwxj
         DX8PKxbfQlHwqZzWtm6H3ltvpmSA/UlkkqwT0xsDMt5V7gVAyP1gnSqMO4e1nx5iy6Q9
         ZARYUt05WzK1GhtUbAw8g/6FIrOA/c6vzy5XGPWoPfMPOapxDGcAAKtSDa59tfRPL9GV
         QAtm2WRc4fRtbDB60Ec7UqbGds3T/LsT0HUoMrqRJ4IHiAIgI9RZrewutX9SSV+HZTkB
         sZImkn+kfrye/Hb7lm6nQeGinZ8e/yyvUouCNjinZK+hLDQHplnoAchYEvun8dKprflF
         q/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909799; x=1781514599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ssI6ZEk3gw66VAN5mRRaeGUv1dLfHJJ6NdyjMb06HLE=;
        b=FoZM48LP7ewHxlh5tgBQlrLDV5gYiUGkMQFPeDcgWA4InxhM8ofgjIC9EYeBtVFRsp
         4tN89UN7PdRXmvYiVpb3cTnJg5RGZEoaZco1njd7Z69FFDIpSQ9Ek5zFC441UWR2QEsf
         GVw4GDSx8VwM2luuJ1Xo3iw9rh1e6Im0kjXo3jKvUfMMwWEc03LK9Mcrel1ng9krc/tU
         2J1kMjgvQHUBOzVW5B3udiCic+1Xo3rJCSw4lY/5ePg5Zf5pZ8vYpskhgPNbLjyT27In
         H8aL55EurNsbEqSWySVv2xpdzw8rjaaKOHXGu98pg14Qtc2tWlVpjo1VrtemQZOCu/P6
         L4Dw==
X-Forwarded-Encrypted: i=1; AFNElJ+qtj/lscUP4sG30QULpgrgeJt5KuMUmVqM/9LvBta+YHFUHFwEEmpjJ26po6Y2yzrKQ/kK8rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweIJYwNZK9xrtNUy03Qkw0k08pVlhtSMazK9kCCf3VZVt46oyr
	fBa3KOTcU5fzndq7ZMdaxsW3Mpubwt2IMIx8HTw/Xvaz5J/i8HWDlM46
X-Gm-Gg: Acq92OGr5afVMR3o1u9wuDW1s9JnzO1CTHdPcEwLGVyhtn8m0jh5IbnzgIy+3Y5rRhv
	ZO90cFYoxGFJfHgqw7jdm5UB8883lPuM+cH5s6pfTwWtr+iagYA6OgZMCDbLublAgupPlSrVsCU
	/hQtci7zlW4tS2GlpKyo/rG1F2tSOF76+7LVLxAGqKHmcma4bTiDy2tNEIxkogMg8VR0TvkNpIP
	fs9O/7e6mwOXPZuNFtAsXfzBS9dZ1dHyDfBFqvHFeqwcgS00mpj2pT+kD2C+DbVZVM658aaAYm3
	3U8c0rEPoL93S7tBdvwbN2sZQfulED/fFNJOEgWG0HeD49VLjBMyta7Cb5e1Ikczo/5LZF7Wd7f
	jTVBXgbIj9F1ms9qhbbxNoiIPF0n3YTlkvN7CUOQvOs8AD0++3Nk3FjKXdvSOlxSWJicbgYgal/
	OKmtuiwdcQyIOvsDZ9pVbcDZjUOx+xcSZId//7Y1dQemcQ2YgVElM9J2wcec+rUcUTCUaIgGOQz
	4AtjSuGD+zCFgaHTJSh3F5qNxQ=
X-Received: by 2002:a17:90b:53c6:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-370f162420amr16555954a91.23.1780909798820;
        Mon, 08 Jun 2026 02:09:58 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a29cd6sm15147098a91.11.2026.06.08.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:09:58 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH v2] USB: serial: kl5kusb105: fix bulk-out buffer overflow
Date: Mon,  8 Jun 2026 18:09:26 +0900
Message-ID: <20260608090926.10506-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607095114.9375-1-sammiee5311@gmail.com>
References: <20260607095114.9375-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klsi_105_prepare_write_buffer() is called by the generic write path
with the bulk-out buffer and its size (bulk_out_size, 64 bytes). It
stores a two-byte length header at the start of the buffer and copies
the payload from the write fifo starting at buf + KLSI_HDR_LEN, but
passes the full buffer size as the number of bytes to copy:

  count = kfifo_out_locked(&port->write_fifo, buf + KLSI_HDR_LEN,
                           size, &port->lock);

When the fifo holds at least size bytes, size bytes are copied starting
two bytes into the size-byte buffer, writing KLSI_HDR_LEN bytes past its
end. Copy at most size - KLSI_HDR_LEN bytes instead, leaving room for
the header as safe_serial already does.

Writing bulk_out_size or more bytes to the tty triggers a slab
out-of-bounds write, observed with KASAN by emulating the device with
dummy_hcd and raw-gadget:

  BUG: KASAN: slab-out-of-bounds in kfifo_copy_out+0x83/0xc0
  Write of size 64 at addr ffff888112c62202 by task python3
   kfifo_copy_out
   klsi_105_prepare_write_buffer [kl5kusb105]
   usb_serial_generic_write_start [usbserial]
  Allocated by task 139:
   usb_serial_probe [usbserial]
  The buggy address is located 2 bytes inside of allocated 64-byte region

The out-of-bounds write no longer occurs with this change applied.

Fixes: 60b3013cdaf3 ("USB: kl5usb105: reimplement using generic framework")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
v2:
- Add Assisted-by tag as requested by Johan.

 drivers/usb/serial/kl5kusb105.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index ed8531a64768..e72a0b45a707 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -330,8 +330,8 @@ static int klsi_105_prepare_write_buffer(struct usb_serial_port *port,
 	unsigned char *buf = dest;
 	int count;
 
-	count = kfifo_out_locked(&port->write_fifo, buf + KLSI_HDR_LEN, size,
-								&port->lock);
+	count = kfifo_out_locked(&port->write_fifo, buf + KLSI_HDR_LEN,
+				 size - KLSI_HDR_LEN, &port->lock);
 	put_unaligned_le16(count, buf);
 
 	return count + KLSI_HDR_LEN;
-- 
2.43.0

