Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE7EACD
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921108; cv=none; b=LT6etNvPeGnEA1tsYJAwwH2DBDFP1FxyV0tmYFmetPvOOzvepzb5NjpTFpvtwHoXD7M838gxZTgL4fMwif3QvhCYA1T9tP81l6cuu4zxVz2VbP+3D9QLqTeija9cQGBfwRHccGfn/jEjLsLWvd5u7DPVq6M/s9hIR3iPx7mWALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921108; c=relaxed/simple;
	bh=eauprXwXHzSDmMa8lR/3cLb7PNmC7AfAZ0kFs8RPt+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQM1V/8vdAhGFTiljBzbeyqLSOUI2JsOiy1Q4kefXqZQlDCG3nczEJfPrabJCIK8H70RGFbG6nY2Myvx843KDCxoxtGRMqGKPEVxe70TprT4shIZOA4PAQNjw8shpFQ3hBk+/wzl0hY6S54ExiFQqAz/9KfHFZG/nSV3QZNkknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJbCh6ED; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJbCh6ED"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca913a601fbso1884558a12.3
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 22:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783921107; x=1784525907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivIVSVi0tei/ccOpIZ9e7O0axGdkjSgdrLeU2t78Aik=;
        b=cJbCh6EDCQog2mHYuj+NYerBKQFOpfkJs7rLExyfifiER2REhdqaDSJojN5FaLbqrF
         NhM0oCxw3DGQHMYshUsr6swHS4nzkWJwOjuEBC5O14UWsR56HetcNxd1HVTypIP2fk3n
         3gljmi5Hw5FRKNutKinPDhz8+SOn1JbYAM8NTvfYl/ZUfYwTWi9oGrE0l9aN96YagqJd
         JPgcEqkzTJDtD9GG5NOwdZ2R6RTiIfKdHdZC1CTPVncZo8PEsVAS0Yd6kn2IkGSqWfDa
         //HBmKbBOFMlATU6VN+wpkXPqbx7kUGY351Qh6qYAiUaVO7tN++RT19XZbKcI5VzTKZk
         HY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783921107; x=1784525907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ivIVSVi0tei/ccOpIZ9e7O0axGdkjSgdrLeU2t78Aik=;
        b=mVl0FWaAo+e6ribK9WVGmncnGxORx2u97ZUsID7P9v9k17Uho74hxY1O/1WfowRDq6
         JrDiBhCIWucV9ikY818dyA69OvsaAbxkQt4WMtifri3V6xDjftDwU+nxuEOR4SWJtsoG
         e0WbHAegUarQp1B4tPPh4qu+x/6waueiBofunAMmrsCPYYQW0vFItCBgJj0CuxrINNRt
         SwcXhbU3W628gB65048rvFuDcTvnbHaiYl/D8O7G6VTjjAB6MwQU9POQavGFnnrPoEKK
         yWiuGvUHLt4dHp7HK/vFdOXjMNzTitnWUI8oYpzjoJ1fvItbygtwRLY7qi8zeDi/YDLa
         6FLw==
X-Forwarded-Encrypted: i=1; AHgh+RpWfDMiJ23KQq168WP1IlqwLKLyMKEJq5F0kGgHBIk/YO5Uyh36km8D9xTjGOi3kHc4yi9QAkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5edXZU6wGetOfdaa0oD5FAPsMaCBRhdHi9DK/qHq5TiISizb/
	YFSWbbjhP5KLTbKeOq0a2RzDkL190Rg/6g1+CV4WzLDSfB2gQMMVesjn
X-Gm-Gg: AfdE7ckIK5ifwYk5BtaCFv4kKOaNOlQp7R21R4ahjBxs/fVofpNwi4n2GfduAcrgEAt
	tCFJPIRNF2SpI/tg1L6IFpKflt7aTClx1LDQF3b24uk0/VUAUnVgALP3w7ot99yzHQvGjLCC7A2
	9dzersDVngO9u8eYnOUT+LiJ12JgR/1znSf+0N5GEp/sLFQ4moyhfxQbixSmM2hHN391L7XOBqg
	g5nmmJ1paf7MmqV09J6KrDaFDHQX029vgDFkinqo/n3df41LxDxPM5Hbxbwoidc+tA0mt5LIRJ0
	GgCndn/M0cVvWHKgbpdL9xZd1cKUeRT/QjNdTssA8U9dRaBdPefj7ZE/dDKPgOy2IvZRH97m8Ei
	j3DuiJLeYOhWOXuvSaa4BFfxN3IEpM+Jyd+mC/ZRXT4n8qL1xoWtcpriLP1KMgJ2j9mG2xiTzW6
	RzoQeAGeVEfAA7hYT42MaXcEvhNlvv+ThN7d2sB6xPT6flZ6I6qCgYVfnH6oIU8hwiFS8zYlajx
	qJtE2msbO3Kj/GcYewS9Jr8BRv+aVQCRioevKQB0dMhgTLyOOCDaUdA4hjEFT1iWBSHY7kJD7k2
	f2QEj7JUSdbnd1GmslOgBnQrBCQGCmtu9rHuEGzTGRGL3ZKDagnbUmRK20lFKcybn9T5Ho2kpin
	Auq8PwF+CkeJo9ZV0BnyOUV17+V7Ue+ayPrw=
X-Received: by 2002:a05:6a21:6f13:b0:3b4:b340:411d with SMTP id adf61e73a8af0-3c1108b5fe1mr8860026637.24.1783921106934;
        Sun, 12 Jul 2026 22:38:26 -0700 (PDT)
Received: from HEXER.localdomain ([175.157.29.69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm32915270eec.7.2026.07.12.22.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 22:38:26 -0700 (PDT)
From: Kanishka De Silva <kpskanna1915@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kanishka De Silva <kpskanna1915@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: adutux: fix unlocked read_buffer_length write in adu_open()
Date: Mon, 13 Jul 2026 11:07:37 +0530
Message-ID: <20260713053737.912-1-kpskanna1915@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071358-illusion-basics-1146@gregkh>
References: <2026071358-illusion-basics-1146@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adu_open() clears dev->read_buffer_length while holding only
adutux_mutex, but every other path that touches this field
(adu_interrupt_in_callback() and adu_read()) correctly holds
dev->buflock, per the locking scheme documented at the top of
this file. This is a data race: an IRQ callback incrementing
read_buffer_length concurrently with adu_open() clearing it can
have its update silently lost, corrupting buffer state.

Take buflock around the reset to bring adu_open() in line with
the documented locking contract.

Cc: stable@vger.kernel.org
Signed-off-by: Kanishka De Silva <kpskanna1915@gmail.com>
---
 drivers/usb/misc/adutux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
index 369d0d2..606ef91 100644
--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -228,6 +228,7 @@ static int adu_open(struct inode *inode, struct file *file)
 {
 	struct adu_device *dev = NULL;
 	struct usb_interface *interface;
+	unsigned long flags;
 	int subminor;
 	int retval;
 
@@ -265,7 +266,9 @@ static int adu_open(struct inode *inode, struct file *file)
 	file->private_data = dev;
 
 	/* initialize in direction */
+	spin_lock_irqsave(&dev->buflock, flags);
 	dev->read_buffer_length = 0;
+	spin_unlock_irqrestore(&dev->buflock, flags);
 
 	/* fixup first read by having urb waiting for it */
 	usb_fill_int_urb(dev->interrupt_in_urb, dev->udev,
-- 
2.43.0

