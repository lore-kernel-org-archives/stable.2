Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579665;
	b=1+vGE4g2/xGFz0EyBD1FwCkfIKGp3kH4FEix8zR81UMHKnxGLLoThY4Jn/PMYi1ktkDE
	 +oOdJx40MA9iuZ/rffnOw/Bt/bofM2rkqA0ynT7as1YSHxrjMui/3QxDtRuWKkrFdn+m2
	 U6oFeX2g4pbOw/nSlXuTYEVtrOMQCZXBvYPSMShXM2TdztUSokTi9a641MaKGP6zBPOUn
	 4yQKho1Pjp0FCmVlAY1lnjF27Wxz5nBl426uNh/lKnbd6m51N53liXVqc14+5Zf+KprZ2
	 djxgnmZ8jSjPTgsZ9VXG0FtrkWWhrFvo/53lyJfVR5nOdbmrnZ9NrApofhKqvLjYabg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579665;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=/Yh6b/SsZOJBDx4OSHpxtjQiQ5dN3xdal/mXss6FdVI=;
	b=yQkywx9w0sCwZ+KK6eCX7W8/f44K616zFs2tbvFQUJTwnmrTOpIs5pbtTCb7rdfuc3kw
	 7p+DiFVS+9B9SlUCQ+lyFSjgNOtBumDL6FPJc/ZfLcKV6q6gFzWQl6diRuiQL5ETlJsZy
	 jLH1UUPHuSZp3Fw0XSZGkjehuHZ22B9EfDFEdnMqeMdGL/0ERMYfTEfdb5zzFhb9NejJe
	 KATvtSGcavHTKTVQ/a6XAhevbpn7i7yLgCLmPjLCMwF2poLfC4FUNgf0OsmwoehEE4F54
	 b3vnism6dYW2A6ON3c5EorKtf7bzUIcMf0b5BV1mwt9pt6QGWp1A+1AURIdOHjoEYJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pk3gdYEH;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F85606A329;
	Wed, 21 Oct 2026 10:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F85606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pk3gdYEH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/Y
	h6b/SsZOJBDx4OSHpxtjQiQ5dN3xdal/mXss6FdVI=; b=pk3gdYEH3/33iineDs
	tsH0pxabz1INhNNEdbZVeQg1XQJE2pN3sZYEy3rnsTNI9zslpn7vBq784KxO0/5C
	ppsP7YH85ULzkkKiPp+HaWb19gWZ27Qp1Ro2t3aTI+UCiO1k0m+S/gdkqYkSYSn4
	0hBQYDU97Oo4khHvVkkDFAprc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDX3xM5mNhq3MNSBw--.27855S5;
	Wed, 21 Oct 2026 18:47:24 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 3/4] xhci: debugfs: initialize command buffer
Date: Wed, 21 Oct 2026 18:47:18 +0800
Message-Id: <20261021104720.4106961-4-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021104720.4106961-1-yaojiale02@163.com>
References: <20261021104720.4106961-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDX3xM5mNhq3MNSBw--.27855S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWUCrW7Kw4ftF15Jw4kXrb_yoWkGFcE93
	say348W34DCFWFvr1xAr4YvFW2ga4UXrn29Fna9rnxGwsrX3WF9Fs7urn7XF45Wa15t34D
	C39xWr1rK3WjkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0mNt7UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRwGQGrYmDwqEAAA37

xhci_port_write() copies user input into an uninitialized stack buffer
and compares ten bytes against the compliance command. A short matching
prefix can make strncmp() inspect bytes that were not initialized.

Zero-initialize the buffer so the copied input is always terminated.

Fixes: 87a03802184c ("xhci: debugfs: add debugfs interface to enable compliance mode for a port")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/usb/host/xhci-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 2aa01d99f23d..a020cbab9674 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -347,7 +347,7 @@ static ssize_t xhci_port_write(struct file *file,  const char __user *ubuf,
 	struct seq_file         *s = file->private_data;
 	struct xhci_port	*port = s->private;
 	struct xhci_hcd		*xhci = hcd_to_xhci(port->rhub->hcd);
-	char                    buf[32];
+	char                    buf[32] = { };
 	u32			portsc;
 	unsigned long		flags;
 
-- 
2.34.1

