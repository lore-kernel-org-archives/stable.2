Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323432AAD6
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841982; cv=none; b=IDeNMNzoTPncPZhNST/2N7kDGYerdIHVVRwBbbcXWcfJl5wx44JDgnLCvKXkgP2qQ7BncCx0gWiXCjKNZprZojKcHG0UCXjEQx+WP2jfrjzLEo+swyMucfwEuESYLbX9zJ/y+Ti68OKLsP6OuphWhWJ/21Q7uLRX1f099K/zSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841982; c=relaxed/simple;
	bh=nftBYdP67zsArySbYAbmzoYET7x7VfM2LBmwgUSzhEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gc/erRMlF3u7kAARXdV0bp0uuatWaWPHWiHxILnoPXxjI/AbbJEYQ0uBR9/kg61rB32pwDPNR8iJddoqaOQA3HhXSFOCaoc9Xqmg5KTkJspsc++yMVxbDBYjXdQE55SQAHukQoEF66lp9EndGCJOfdjNyN4a/fTRxEG9PmgTwBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PuggBTIf; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuggBTIf"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-4893fc86bebso3467981b6e.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 21:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781841980; x=1782446780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWgKW4ndueXEPoNUBny6URTgdeHcCM4KkKjb7H+dGhg=;
        b=PuggBTIf9f+y7VfZ/TApnSEnPPHjc6OH+Y0QlvGZrmHtIXiqgd9EijylwatNJlBbGs
         iQYK87QVXkdnqN6QHyposboBFj+gr3OrI4cTa4FZoWwp609CtdoIVQYwcXlxMrZDGIJy
         tndXCCI5d/+SePeAdJZ8T8MjcjKSzaAfnKAGnBd/Lxi4YVHOqARZj2Be3ctBqTYhT53P
         k7O96OZh9wxPMpCHs0Sz7AsNafCJzyGXreLx/R03ZCjQrjR+wj6ysyPc+RzuOzhn74yr
         ngZdGVqHWtapcUwVxMUBPk27jxPwCKZ3iL+IgIhKfqhfZeqbFb9rVLaB3q/l/PyYoNhJ
         vMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781841980; x=1782446780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWgKW4ndueXEPoNUBny6URTgdeHcCM4KkKjb7H+dGhg=;
        b=jBjiN7l8yBR9k1QvDfLvM5y8hH7jWV9tDgu7zgVCZLkVxDsLmJI3VA4NuUGK9F7+LJ
         2i1dC0bn+EGBpA+CJpOvl7PJI2zs5NksWEMCfFmyZpKnc9kh9sjjoj0C9zm1tfg+K2wo
         4m5ELCVL+zZJSk+Thmx0lgQfseCY4nd3cIQCe7wykztgYkCsm0LVB377IeH/EKnjhECE
         mO5c60HseAHbVIeGO3qbJBHBfGq7TYc18tQNpzqZvb6e/DoC4VfoUU7S1pmo/BsCidDS
         cQQy57NNW34dCMPatIVKYu+N/9eqFAv/wEzG+AJs8T2H0RAsuSjOC3CJXqsE/ugxrkM9
         fVMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dm6jWJ9TnmoKejHlWGjfHR7DGuQdQeYNGXuo4lw0GfCwjhjcz+sKnbKoDZm0yYxQwlzhEHYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PmJk8uP8+bGZiZHjNWk2mUpRR/znTSoxkP8nNfLqJzI1KVQ8
	+nOc7KKThNCgtWDTJaC2Y/oohZvsTkCh5k6+AtA2/Hy6qxJmA/WyZTZSCRTk7QwQX3ekDE3GlQy
	whoTHvTpSvA==
X-Received: from iobp21-n2.prod.google.com ([2002:a05:6602:8695:20b0:998:4431:ccf1])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:4c86:b0:489:79d8:135b
 with SMTP id 5614622812f47-48979d81734mr1189800b6e.25.1781841980164; Thu, 18
 Jun 2026 21:06:20 -0700 (PDT)
Date: Fri, 19 Jun 2026 04:06:03 +0000
In-Reply-To: <20260619040609.4010746-1-nkapron@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619040609.4010746-1-nkapron@google.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260619040609.4010746-2-nkapron@google.com>
Subject: [PATCH v2 1/4] usb: gadget: f_fs: Initialize epfile->in early to fix
 endpoint direction checks
From: Neill Kapron <nkapron@google.com>
To: gregkh@linuxfoundation.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	Paul Cercueil <paul@crapouillou.net>, Simona Vetter <simona.vetter@ffwll.ch>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Neill Kapron <nkapron@google.com>, stable@vger.kernel.org
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
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 75912ce6ab55..38e36faefe92 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2364,6 +2364,7 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 			sprintf(epfile->name, "ep%02x", ffs->eps_addrmap[i]);
 		else
 			sprintf(epfile->name, "ep%u", i);
+		epfile->in = (ffs->eps_addrmap[i] & USB_ENDPOINT_DIR_MASK) ? 1 : 0;
 		err = ffs_sb_create_file(ffs->sb, epfile->name,
 					 epfile, &ffs_epfile_operations);
 		if (err) {
@@ -2453,7 +2454,6 @@ static int ffs_func_eps_enable(struct ffs_function *func)
 		ret = usb_ep_enable(ep->ep);
 		if (!ret) {
 			epfile->ep = ep;
-			epfile->in = usb_endpoint_dir_in(ep->ep->desc);
 			epfile->isoc = usb_endpoint_xfer_isoc(ep->ep->desc);
 		} else {
 			break;
-- 
2.54.0.1136.gdb2ca164c4-goog

