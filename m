Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0DE42BC24
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062426; cv=none; b=nJWNw8uoahHulAdmv8hcCr2XxR5GZ1EYGdN+ZvcZ0ekSerZe0j0OcCFKj8itWk4PG8lYdwK7CWEPbgV6mdpp7kVs5V4D69B5sJ5XVqGwUcqLotxgaMvCVrx9vInS9RfcKE2Nc/pO02ydtAFm+VNPNyZeCvjyJ7Ttqy/NQ70SgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062426; c=relaxed/simple;
	bh=CVxlXqroJ+zbdEQvFTmQSEai7uJdckgsx5rP8Fi9ZbM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6x0fgQVq69h3C5+XOsLTJWQnyIKux22tRjvKb9KSKlKEYQ1Adr87cTflcMcZsAj2iwVuiQSAaLgTRbkJBTGV1KQcKgjunDMVuD0xbsaYxK7Xo84ooMIRFOvbPHCkpd16o1rKjY1/WKrVZ60pLOwhTcWTlesmSiAkoI5kjCyTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNFCDX4Z; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNFCDX4Z"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-4909b046dabso7546975b6e.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784062423; x=1784667223; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYYbKFCcbxU1GiSJBJboqnLv1Ilizhm2sLEHzbZubZU=;
        b=jNFCDX4ZS/SrUzmwXeP6aMNOW3ClyoEKQwj5Q8qZGcrYZp/us2iNcGKp8O8Wo6ra5B
         EjZdHNgX6jUDMp2vxOZnxMecr4pLQzApw11zbOaULoImtagM5OAA4A4A0+Uq6KJrCsoK
         sYxaBQFwYmhkZNQWP9R8hswtxz/xe637ArhhqNx3eX/SfraTyRdj/vsFoC5h83WAQN2Z
         I+iyxx9lKhwIYFgdD3EOalv+Q4i5vWGyHLaIy8rp9ojx45SiXQFOJVqaz80zdlIzR5Wz
         sdJC5SNUOcKZ6bYb8QmP77twm5pGmYjJHQ0tBs3jlc5lzI6vkUQQy5+O2C+wQDgqjMf/
         dGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062423; x=1784667223;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AYYbKFCcbxU1GiSJBJboqnLv1Ilizhm2sLEHzbZubZU=;
        b=aVrca5tfte8353pCH8thkJfLS7cc7gEhQbtVSAnXIVxD3uOAA/PAYLNjAM8erLihZN
         z2HDsHlw+zh9yacI0hmre41z5c0PkKu9nFRuPwSDpKIluJPDv5A6Wm/lp9Rv/nTwDqJ5
         BkY+GtTkvTgxgrekMaFM2N7QZdZVOawXFOyvQMKP4f6fsYkFKd/ecGlB7Fv0+iApYJ12
         Wb1gN52uTICNuerWc4mUDNSWshs3ze531NNii9yNCfBb6w+597ajhtEE8N+V+r/VljYy
         Abf+Y369ar7bN5uBTUMiHSG99w5IKY/AogoYXCAxuBkWmBLgNDah7gS9ISF9lB/giIBs
         vk8w==
X-Gm-Message-State: AOJu0YwkjMGWfDfLr76yFNFIdr096XHFjPesg8fnYz2JJVdHkYzuzZmN
	k3SjB3l/b2m1IyvpiWUAPygmgVchZXJjZYjf/H2Anl4WGrjqbp7WEI9Xfgt8Gv7OOp2hlW3s+cw
	CMFJ1eeX9BN4k4wQPwZQs646+k5OSndm31XeMfui4Ehi8uCYS80sGSfMWmHfzdJjqEfUDwBxOXX
	oFzeWWOzrT4oQKDhlY6/lunDyyb4I1Be9V4K0pmFI99g==
X-Received: from jatb13.prod.google.com ([2002:a05:6638:150d:b0:5e9:1651:373f])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:221d:b0:496:dfe1:6d91
 with SMTP id 5614622812f47-4a472b41732mr4180069b6e.42.1784062423245; Tue, 14
 Jul 2026 13:53:43 -0700 (PDT)
Date: Tue, 14 Jul 2026 20:53:15 +0000
In-Reply-To: <2026071415-tragedy-purely-e8df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026071415-tragedy-purely-e8df@gregkh>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714205315.1584726-1-nkapron@google.com>
Subject: [PATCH 6.18.y] usb: gadget: f_fs: Initialize epfile->in early to fix
 endpoint direction checks
From: Neill Kapron <nkapron@google.com>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>, stable <stable@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

When parsing endpoint descriptors, ffs_data_got_descs() generates the
eps_addrmap which contains the endpoint direction. However, epfile->in
was previously only populated in ffs_func_eps_enable() which executes
upon USB host connection. As a result, early userspace ioctls like
FUNCTIONFS_DMABUF_ATTACH that run before the host connects would see
epfile->in as 0, leading to incorrect DMA directions.

By moving the initialization to ffs_epfiles_create(), epfile->in is
accurate before userspace opens the endpoint files.

Fixes: 7b07a2a7ca02 ("usb: gadget: functionfs: Add DMABUF import interface")
Cc: stable <stable@kernel.org>
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
Link: https://patch.msgid.link/20260619040609.4010746-2-nkapron@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(backported from commit 82cfd4739011bdc7e87b5d585703427e89ddfaa5)
Signed-off-by: Neill Kapron <nkapron@google.com>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 737d60b26e02..1a1fa04a9e34 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2353,6 +2353,7 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 			sprintf(epfile->name, "ep%02x", ffs->eps_addrmap[i]);
 		else
 			sprintf(epfile->name, "ep%u", i);
+		epfile->in = (ffs->eps_addrmap[i] & USB_ENDPOINT_DIR_MASK) ? 1 : 0;
 		epfile->dentry = ffs_sb_create_file(ffs->sb, epfile->name,
 						 epfile,
 						 &ffs_epfile_operations);
@@ -2439,7 +2440,6 @@ static int ffs_func_eps_enable(struct ffs_function *func)
 		ret = usb_ep_enable(ep->ep);
 		if (!ret) {
 			epfile->ep = ep;
-			epfile->in = usb_endpoint_dir_in(ep->ep->desc);
 			epfile->isoc = usb_endpoint_xfer_isoc(ep->ep->desc);
 		} else {
 			break;
-- 
2.55.0.141.g00534a21ce-goog

