Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03148380E
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280532; cv=none; b=bpPmXIkvoSM6LNbHhw9aZmf09vxtWc0no67CzGAaZQZIw5htiF8jo/7yFQ1K3Sjp2p7bbqLEr4f1wvZtTkgf65o6B60r9cw6tjCGU/Y/Ufxk7JRpicPo0ekLngIMGJv81jxVnF//c97j+tH5l4rDcJNzdgA0d56m0eWW4mbdDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280532; c=relaxed/simple;
	bh=GF/bVHokF5FXjZ+g0nsyqkLr5qbnoJSW65kdmui+Z90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qykww/XezP+ef157ZJGyBNzs75Nvfa4QxjWuW5ewTnzVPx1P0VLGQq8cH3mW/W8v4qrpxFfSCcG7Yg86JxSviBxQ5DqfHTUm6ov5pAjZ4dS2gavY4MP96xRgwfKHH4+sSNygAB5XBBbNVctYwZ7PDEI171XreuU/3C/hvVBFREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vnogmpqx; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnogmpqx"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso12433a91.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788280530; x=1788885330; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1Px1YjhukNKpiGIzc6xWlYh1IDxs7EUGnftJx4GC/M=;
        b=vnogmpqxe/vBz7mSfzQ9Mq+0Uw9pn6X88u21weea1t8cmt6jd1l+KGl4/Ijp3rH+fm
         XrEP9nNPSk6wafORYRWwLoVLVzY8kdAqz7fsQP0eTgFfSfLtn8fdeoCo+f+jMOSlKxro
         xNtz4zjiK28aH8pKvf0tJ7dczE7W5CpcXS/vdSVzY/wBi63kO/Hjzy8P2hp9omN/HFyD
         ITrrRE5yWXqj+ny1BzbctPU/CCat043XCZ/ipoXaOb1xuyasAstocJV8FUBo7zYi8AkU
         4FqI1ZZTwiEVDqbEp2k/3/ZwYWTQmZc4aDuDkp8cfyKKUljuJb7hQSIAeMHpQ38DHjNO
         BG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280530; x=1788885330;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1Px1YjhukNKpiGIzc6xWlYh1IDxs7EUGnftJx4GC/M=;
        b=Lb3kfWPjw+XWsvhIc4j2xX6MLtuWj+haWMq5ROlXK/yTlB+ZdkYG4v2XUacnuX/H3X
         hRQSphZXXf2EiBm++qdeF3KdlY/o3XGvHQbGIAHAvDJkn/nf9LIeiy8IO+wiT3yuzFLf
         4Cv8ep7BCv+L6mXxjWBW8BOMC54NhECg29rH3epmJxoz9G9rvkLFK3uUz7WlokpEWfpC
         mhhi2Tc04W7PSwZrboBQ1ySROM2cb6/4yfNnJAfYHnHL1jhI/EHqgrKNoEXX/we9F16p
         UA6YroeXauOjmr2bxXaskPaOs2FaQFfrJPFxeQ3y4BaZ6YwKp0yBVqp4Ls2/55UUZsE0
         78Vw==
X-Forwarded-Encrypted: i=1; AKwUvBwvT4lSfdvjULOU7RmWY35W8vYSaxt7vBbIfENKEt0elqt885Dqz+9v3XV50kNOnmhHuksKTXQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lhRrLK3YYDMuS02RkwkU2r7xudtu/xMfwcPHWP/Ec1hpsZ1QKf
	9KHugS0PqehyAfocn1T9ynn2RcwW05l/g+PrMXf8Y+fHRSfrF1WDHRPqYqCLm5D6qln3kQhgFFe
	vGifg0l+S28qQ4g==
X-Received: from dybrx10.prod.google.com ([2002:a05:7301:4e8a:b0:314:f5d2:b3f3])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5827:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-39907d6909fmr15493354a91.14.1788280529991;
 Tue, 01 Sep 2026 09:35:29 -0700 (PDT)
Date: Tue,  1 Sep 2026 16:35:17 +0000
In-Reply-To: <20260901163521.1355535-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901163521.1355535-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901163521.1355535-5-cmllamas@google.com>
Subject: [PATCH v3 4/5] binder: reject mremap()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Binder does not support mremap() as it caches the mapping address in
alloc->vm_start. Moving the mapping breaks the IPC communication for the
process and can temporarily leak pages during a shrinker reclaim.

Fix this by explicitly rejecting the .mremap() operation.

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb%40google.com?part=2
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 59ff436f1138..0e6d6f6923d2 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6036,10 +6036,16 @@ VISIBLE_IF_KUNIT vm_fault_t binder_vm_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL_IF_KUNIT(binder_vm_fault);
 
+static int binder_mremap(struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+
 static const struct vm_operations_struct binder_vm_ops = {
 	.open = binder_vma_open,
 	.close = binder_vma_close,
 	.fault = binder_vm_fault,
+	.mremap = binder_mremap,
 };
 
 static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
2.55.0.966.g6673acef38-goog

