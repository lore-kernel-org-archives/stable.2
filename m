Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097D31E845
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292208; cv=none; b=sSUrYFv5rqbThB3UVDVdMkBL4z1qm2kgyEW7n3sFSLjEXaT0UuO8vfa4rndr9xYvyMyOrGLZYLXwk98k8AfkwLNxdeuU06LihK31qf9pJSnNsYbnOBqXPbE+Mv6ICc+KRMsKZvgAGgI3fNp75gR/NmTjDOtXmDryk6D7D2guAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292208; c=relaxed/simple;
	bh=bt11OM5bb6A6fXVXlfO8qiFCEUKqzvv4GjiKScaj1S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MBvx2NNivYpWnPuZmtG5lEms1Wu7sa6+S/FC28f1a42LQQ1YU7Wm+qCKFK0+2WK6gwGVn8vLRECRMNMJtAFgrEjEtKVZ2SYD9iYcu62X1+mhCQLgtV0pJsuOzgYAsY6SHvjowVJps6khIyctG4Qklbl1bx5SNETjn5MWxhdEY3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPujBBgH; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPujBBgH"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30c52f96f60so1489445eec.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782292207; x=1782897007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AULKtZqUqAXCrW7SSYMD3oLYHEXTNz504Vn8mZFcNNw=;
        b=sPujBBgHK33/IrF4RHS2d5LjKYsFTer8wLCikevZOpf6U38FJg2FZ4D9NaF44/SzsR
         1hEHvoc6mPkZ0QlOwZE0rBtxB/Xh+8h+of3FzL0hcYYkDpTEnK8cTXMmaO24Yunc7736
         IoSFbFpBe2Nt6A3Zm8B4PFC5TD3lT+BzegLMd212/uHa6ngpHi/7CKvAV1jYFAXEwmzY
         bJPlEcrPJNtXWpmWTUF6pc2kBcsi3rUTauQ/9+IrQ3PZQUPthO/oZ9ur+McPcfTInEUD
         BHenGy5AsI2XKb5I0gPWRgDCjmYmlkQyYqiAjDZvxO4heFSNwu6ajD4N9EUPEfWav4TO
         r4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292207; x=1782897007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AULKtZqUqAXCrW7SSYMD3oLYHEXTNz504Vn8mZFcNNw=;
        b=lWnxeFmpOzwTI6CNsJFvzYfv2mf10HRwEvU0yrsevQcsFcTJW/vQu9xwyG+1pZHbqo
         JgMwU5TPHDabfch0mMdyijL+Srq/8+sQ6m0mSKAKBKosm7GTHW3a2RlV6AOycu0PH33a
         a4XnNh95iXDq2I/CwnbxblfwoMfy4FsOqthQlhJUQyB5f0l8jOc5ylJ138/aEhNJClBw
         XanHJfHyGeod5T87Ri1KULXa3wYDJsOAmH55xfd6ErW3MfZcOs3Sr8vvSZ5biSo7CY86
         ZYQW5OZ8YMAtaXObOJILaNCS7EsDiZfLD4wYxtDlhAv8enh9bd6hJsBavk5vXuyyhaAM
         FL1A==
X-Forwarded-Encrypted: i=1; AHgh+RpvjCWZkzxVu72dSipN2Si9R8mVWCiFR9NayeGrdyHYAsyEoVOquOmrgAafKQRThd5F9xfjgOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn3qpainx8C/vUcEMc3GdyhJC5+TO1G4x6vNPfJnyDi3+cMN3G
	DwXwAB50M38WHRrYPkvzCgveoZoiXhS3WTdllWN/0c+AgHy2H+sRMZ0A
X-Gm-Gg: AfdE7clvLDZh8MFvz9fGpVb9S1w6caivLZuvZZMCtGwCHieKasuPGYVPzU3ZrmZl5b/
	2gFbDGfalE+tc9R5UIIfJ4w4zR6ipYUwPyaUhoZTP8XNj63ycolMKQnZm1ScBPZI9rehAyOpWf+
	2yj2oxrRKi9D/Ux099DUNGLRwhYuS/9vWLLX3AKeZj1ZgC2WFnKRznwAB0Uhn+iK0KUkWJaAzoY
	EKzvB5sJ08NFyJ+jMT2jdNLAX+3c58UjlbPWreD93JUZah9+TjvAEox9gY+C76uf6gnewumHywS
	ACWGfYQxKK/s1ZGq6NxWDO9ceiTp0I1WLfJS4MvWwAxKlVDGExuro1WXrQdlog/TNTpCc0aRTrs
	ZB3XrdYeJfHXeerhZj5yLI0JTMiGznG42tU5CyMByqw4yi9Hwh5Lw1cMtGwhQ4yxaeylgxxkPlZ
	0+EhTeQzlO/ffNIobbcz/H3pGyUo0LAIr2u61C5Y2N
X-Received: by 2002:a05:7300:80cb:b0:2ef:9961:27fa with SMTP id 5a478bee46e88-30c1dbd18d5mr15967319eec.18.1782292206412;
        Wed, 24 Jun 2026 02:10:06 -0700 (PDT)
Received: from localhost.localdomain ([192.197.201.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c5af35cccsm9440207eec.30.2026.06.24.02.10.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jun 2026 02:10:06 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: misc: usbio: bound bulk IN response length to the received transfer
Date: Wed, 24 Jun 2026 18:09:52 +0900
Message-ID: <20260624090952.86439-1-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbio_bulk_msg() copies bpkt_len = le16_to_cpu(bpkt->len) bytes out of
the bulk IN buffer (usbio->rxbuf, allocated with size usbio->rxbuf_len)
into the caller's buffer.  bpkt_len is fully controlled by the device
and is only checked against ibuf_len; ibuf_len in turn is checked
against usbio->txbuf_len, not against rxbuf_len:

	if ((obuf_len > (usbio->txbuf_len - sizeof(*bpkt))) ||
	    (ibuf_len > (usbio->txbuf_len - sizeof(*bpkt))))
		return -EMSGSIZE;

txbuf_len and rxbuf_len are taken independently from the bulk OUT and
bulk IN endpoint wMaxPacketSize in usbio_probe().  A malicious or
malfunctioning device that advertises a large bulk OUT endpoint and a
small bulk IN endpoint (e.g. by claiming one of the quirk-free IDs such
as the Lattice NX33U, 0x2ac1:0x20cb) therefore makes ibuf_len, and
hence the device-supplied bpkt_len, exceed rxbuf_len.  memcpy() then
reads up to txbuf_len - rxbuf_len bytes past the end of the rxbuf slab
object.  The over-read bytes are handed back to the i2c layer and on to
user space through i2c-dev, disclosing adjacent slab memory; with KASAN
this is reported as a slab-out-of-bounds read.

The number of bytes actually received is already known: act equals the
URB actual_length and is bounded by rxbuf_len.  Reject any response
that claims more payload than was received, mirroring the existing
"act < sizeof(*bpkt)" check just above.

The control path (usbio_ctrl_msg()) is not affected: it uses a single
buffer (ctrlbuf) for both directions, so its analogous copy can never
leave the allocation.

Found by code review.  The out-of-bounds read was confirmed under
AddressSanitizer with a faithful userspace model of usbio_bulk_msg()'s
receive path (an rxbuf_len-sized buffer, the same act/ibuf_len/bpkt_len
checks and the memcpy).  A USB raw-gadget + dummy_hcd reproducer is
also available.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
 drivers/usb/misc/usbio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/misc/usbio.c b/drivers/usb/misc/usbio.c
index 02d1e0760f0c..24c4cd0df829 100644
--- a/drivers/usb/misc/usbio.c
+++ b/drivers/usb/misc/usbio.c
@@ -344,6 +344,10 @@ int usbio_bulk_msg(struct auxiliary_device *adev, u8 type, u8 cmd, bool last,
 	if (ibuf_len < bpkt_len)
 		return -ENOSPC;
 
+	/* The device must not claim more payload than it actually sent. */
+	if (bpkt_len > act - sizeof(*bpkt))
+		return -EPROTO;
+
 	memcpy(ibuf, bpkt->data, bpkt_len);
 
 	return bpkt_len;
-- 
2.54.0

