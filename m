Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792473574;
	b=Zv8NmIotZfAahFzkMg8zdoh08YqW5lIKDZDlF6Lj38oah/64dW/8vrfiw9y+sdDajYTU
	 jfRO9jyDOCZVbBxPHaCvCR6Wo+KR+ux8Ki4fwqw3h5fpkDM3nF425s5bcEJ0zJ+XX+uyL
	 hbrb2dyfPlb9YP3ea1C8TxC1VukBANoRJjsWkg9J/Yn34s5THmrVh7lL9dVrbQISW2HfK
	 Y8aGDm9sLMoLM40yzbcN7w8gNIJ2NGE251JV0ktMj/k53n6earYNwMV01ZjgcO6/TEWnA
	 tt3bcPSMW3bdf+EASibea0sY0mpQe57NV9ZTcRVKhj5poHJjwDqhnYMKdTN2hExfqMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WiwuSh+FB4wlU3qM122kTHIbF58w/uDaDwSp2c2z4b8=;
	b=iddiTVaDGr8+R5Tl+jFWMvtqJwuqnih9FD79eeR969S1zDl9aLkZcDTjvsew0R+mh8wT
	 3+f1T24v9Dj275kmnj9RT0xLrXLL2YMzLxurxkHknZ1nykR9PrhaJb086sseY3z140+c9
	 gIqOc6k4wKAHQ84x2Or0+NAAZGZuwh4zit1VgDVEF5kmvzbJ4O7W5BN3G9G8nI0Y0PPwk
	 iJaJcei55VsTg1nhvFS4Mf/ptLYpo2KlMteC4fnxU2i4P36F5dmVmxjf8OwQykCf1iJh5
	 CAJOaw7Lc9ex3q6Heu9k0SX0yOm5Pehkal4EBkY58BCNuvRVIUReM1+J2IUTnKhIBFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BlmUULdJ;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8A606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F8A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BlmUULdJ
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9f6a16aedso9033735ad.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792473573; x=1793078373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WiwuSh+FB4wlU3qM122kTHIbF58w/uDaDwSp2c2z4b8=;
        b=BlmUULdJDtjKoJrEy8yAl3GreePE+o+r052NwAx8OHhqdzSv+OPzw/a8/ZsqaYvDLo
         F4NIR/R3OH7fjK20x4vZpDatoTxUBbt+XpRYubWrKMTG45tAwqwMipIS5tHVzETdPHih
         CqaQo3p/zIKLd2qmENh4rZlUapJeedpnS8hp5rDMHyc3o2ztD3IanpKR6W0AqOlC9oRe
         M6lMUsGl+aOcS+YoSwYHiY0GzbtOFQ5P+h8ESYzLbvU5GqzJMAdJMA1x4sCliRmYQtiR
         z7gpvI36Q8tDTBzIlTPaSSQ85+fArfpAXjRsSd2GrqkIHoGAoNigK9euCz08Xbv02m1S
         pJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792473573; x=1793078373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WiwuSh+FB4wlU3qM122kTHIbF58w/uDaDwSp2c2z4b8=;
        b=pxYH1pHYRMw9JEh1Mqq2wwecmuRCTGzWZnkYB32UiQ+qUdm2nybyx9xqNNGnJQCPya
         W4wO8QAYYEMM75DI35fgqUUYMTSpfHuKfz4HnxWKARthEAWcxDIt5Q8CN8OYmm5d+5js
         loVJHg8NFUA1B2qNCv0pPUyEPxjApjpA5PH4LK3vDXC0gs6PyW+GpvAne69IMXDowWYM
         aNbqF9QRWPxM50eTm9ZeH4tmrzr/yfzM9DfWN0oasnMdWZmfAzAyN5mtZdxUgvC1CijW
         vi9dIl8xOFsKD3k+30/jOLyr/CV8e19T4/pXMWD7meByhDYGqOv94lXoNDP2yPXEjHIU
         r7gw==
X-Forwarded-Encrypted: i=1; AKwUvBxwsvyNCLaegNLrQGDhmA3BqZ4/2ESsCodqs5loWIJwHuWctKvizZdh5qRd6pmml9xGPMsI8Is=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVq3lKoXupVs6PSo2y/zmpp+j5E60QSgtjdRRkJXvF1rKHo0cQ
	d3G5U6ICtZdUkYGCyjzfOARcJtJYjiP2pVcs7MTII0aw2gY83+y2LyH2
X-Gm-Gg: AYBFou0Mj9g5pJQYNkF+AiHiNMNgZtC8V0UG6Fbz8/p3KDpqmJwjhqYFXjhVE/5l+x5
	VDGgqRSXfeQYZu2xQReW+RDR8+lb7bqfg5bCc7F+axMQEBU4QBOFSuvES3dzUL4WaHI7iTY9y7P
	vXheSFl2kaAht44c/a/8tszP0PFNAqYG8zYJ0JMpSLn8fr5b62i2fMLp4nqGj2iZ+Wr/tOt5Ese
	bXSSZ9T+4kQX0UUtaQo4Ov+Vk8Mpaz08HqucwDFrEwFRkTTo0Fw13Hl2fmM9E20rdB9gmLVcWOf
	dQYGPxJgiyOy41vpTZMYSLa3rQHCjpFwhMFMY5JSr87fdqdx1cHKHjgWYHW8R7c8EKwph+vzvMM
	9rNALg02Bl2F3AEUj85qCx/TbgKFXcw9KJzbYdz5KmbH/jcZ8yDiGjwtT9UfHezxAy869hZ8y+c
	1eYUFfQ6Ya+oLvjBRpUE0tXVgRRFBlSzJdYQhd55Y2Vt39/xZp31H7+mikImCJXJf6vJ1TyKeXw
	Cmfj91bMkGrrHfOXt7ibRaOwD11MT6GAql6NIQ0NOqgNoKp5aUOG2/yZ3IFwQxm6Vv5Xm/hEPdw
	WsD81kqMkCjTkByr6+xjpVGqlrZWeYIqUPiI5L3mh26ZqP7wSoj+HJZWRtYNbVisVMA82oWhzvY
	WDT5Ub8jz6IoqUbnpkdpYF4NHq9LoZw==
X-Received: by 2002:a17:903:2c8b:b0:2e9:5c55:c46a with SMTP id d9443c01a7336-2e9a6834a18mr82663075ad.7.1792473572624;
        Mon, 19 Oct 2026 22:19:32 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea145af6c5sm8940965ad.2.2026.10.19.22.19.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 22:19:32 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_fs: check ffs->gadget in the DMABUF detach/find paths
Date: Tue, 20 Oct 2026 15:19:25 +1000
Message-ID: <20261020051925.92294-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

ffs_dmabuf_detach() and ffs_dmabuf_find_attachment() dereference
ffs->gadget->dev.parent as their very first statement, without checking
that ffs->gadget is non-NULL:

	static int ffs_dmabuf_detach(struct file *file, int fd)
	{
		...
		struct device *dev = ffs->gadget->dev.parent;

ffs->gadget is only set between functionfs_bind() and
functionfs_unbind() (UDC bind/unbind). The epfile ioctls, however, are
gated only on ffs->state == FFS_ACTIVE, which userspace reaches by
writing the descriptors and strings and which is independent of the
gadget lifetime: an FFS instance is FFS_ACTIVE before it has ever been
bound to a UDC, and stays FFS_ACTIVE after unbind. So
FUNCTIONFS_DMABUF_DETACH (and the DMABUF transfer path, through
ffs_dmabuf_find_attachment()) can be issued while ffs->gadget is NULL,
dereferencing NULL:

	BUG: kernel NULL pointer dereference, address: 00000000000000b0
	RIP: 0010:ffs_epfile_ioctl+0x402/0x1700
	 __x64_sys_ioctl+0x120/0x170
	 do_syscall_64+0xf9/0x540

Reproduced by mounting functionfs, writing a descriptor+string blob so
the state becomes FFS_ACTIVE without ever binding a UDC, then issuing
FUNCTIONFS_DMABUF_DETACH on an endpoint file.

ffs_dmabuf_attach() already guards this with
"if (!gadget || !gadget->sg_supported) return -EPERM". Do the same in
ffs_dmabuf_detach() and ffs_dmabuf_find_attachment() (the latter also
covers ffs_dmabuf_transfer()): snapshot ffs->gadget, return -EPERM if it
is NULL, and use the snapshot.

Fixes: 7b07a2a7ca02 ("usb: gadget: functionfs: Add DMABUF import interface")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/usb/gadget/function/f_fs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 44218be..0976db7 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1473,9 +1473,15 @@ static int ffs_dma_resv_lock(struct dma_buf *dmabuf, bool nonblock)
 static struct dma_buf_attachment *
 ffs_dmabuf_find_attachment(struct ffs_epfile *epfile, struct dma_buf *dmabuf)
 {
-	struct device *dev = epfile->ffs->gadget->dev.parent;
+	struct usb_gadget *gadget = epfile->ffs->gadget;
 	struct dma_buf_attachment *attach = NULL;
 	struct ffs_dmabuf_priv *priv;
+	struct device *dev;
+
+	if (!gadget)
+		return ERR_PTR(-EPERM);
+
+	dev = gadget->dev.parent;
 
 	mutex_lock(&epfile->dmabufs_mutex);
 
@@ -1570,11 +1576,17 @@ static int ffs_dmabuf_detach(struct file *file, int fd)
 {
 	struct ffs_epfile *epfile = file->private_data;
 	struct ffs_data *ffs = epfile->ffs;
-	struct device *dev = ffs->gadget->dev.parent;
+	struct usb_gadget *gadget = ffs->gadget;
 	struct ffs_dmabuf_priv *priv, *tmp;
 	struct dma_buf *dmabuf;
+	struct device *dev;
 	int ret = -EPERM;
 
+	if (!gadget)
+		return -EPERM;
+
+	dev = gadget->dev.parent;
+
 	dmabuf = dma_buf_get(fd);
 	if (IS_ERR(dmabuf))
 		return PTR_ERR(dmabuf);
-- 
2.43.0

