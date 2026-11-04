Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817831;
	b=rb6HJitrb5BigNnBLW3Jvwt03EvIusjBkRihfa9B9ibcrvy1PVnp/G3H9VUUU7tXPV6/
	 Fz8P/T18x8IIRuXwphpTUufncxMxM3AHYYRZhCtMVu/5w4LC8vB2+3LFXle0FXTVt+AWw
	 1J9BAN4BKr7qCyD7sTB7zJRfDrezIenTa0dV+yOubWiYqlUTOn2Il4dcK9U4K+cJ+aZ76
	 JBkt0jvKVooSRegt8SNlWfs/zcUKKMRI/BvdwNBVtCG8w8I+d3/h2Uq0MOr3RzeKH2ukR
	 ppliJWx7jTuUM8gkjHxgynmUnMK4V6ntdIhxszdocPKCB4jroaz+yuoG84p0fFpMXyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+nnqyL+W3DjF0huN5RLGNnIsxEpiJqX6PDwqFHVoZRc=;
	b=eSrAMGhtI9Mb0gcQIl4ql9nh9Tmj65ejg3c6yKm3JCNQmhaGZOR3sHdPzIT/p8sIuaWX
	 U8+A3SS2Q/IVrkfv5diLx9389gr5azTYlXngQINI6I3KqhYBpAX3gws8zYrxMhV8/VM8+
	 //LNVeYkMRm3UPJ7GANchjpVUFTEd46WNUmKKXUsfbXw7YK6010kfXPWzOCOBFTCEYqC1
	 lnzOLko3kcXgtIluqOl3DNVuuK9CMrv71ibHPUDepY3I3rBUqnxQSNKu4YMd3m62oWUBL
	 AAX21BOrDvXVWxYz6Cke9fhOq2t4pr6sg9x5Idx+vASE+fuQv/ReDDTjcTVtTglEviw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YWXgsOhs;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D490606D822
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D490606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YWXgsOhs
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-53dda625f63so725498b6e.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817830; x=1794422630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+nnqyL+W3DjF0huN5RLGNnIsxEpiJqX6PDwqFHVoZRc=;
        b=YWXgsOhsEld5/JggybkYa9i+q/tmhIqCIq4wkdqcaP+LaG3NvGvCupM/AAY3EufV7x
         9ViCucfyavzIuDPx6KyHBBOn/DgO5OqKT4NxACxA6OBK9G87ubo37/d9kMjB3t92tod5
         AfXeGWYN0iBqSl0W3LuYr+yb45TazSewElF1b+n1fhmb7+8yfQRwl+i6lAzDTbAz5zhk
         o2fuHOqU5HixAibk592/nMTmCrZDdwrP+dc2AsIeESCZcf0PjcDAm6uahUiXNCZKdrLc
         YiOXnaIemvWK5PHwYFHa3CLr/BG70abCLVyKk/PWQ7p/oEmP/KP7r66ZjwbO1YzgiCqL
         Dr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817830; x=1794422630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+nnqyL+W3DjF0huN5RLGNnIsxEpiJqX6PDwqFHVoZRc=;
        b=vG9yoTgWfRiMWsgqETtQRxEmCocyXpJPrDmEXvfBBgVI+IJJk2CDHlhdmWXVJZlK43
         AV1qdpLAObyKf8ex7fo5Pxh81la6YLlnlEBAPpr4v3TMJdMtFbQQGfd/0AmZJUqlfraA
         Eb/G3ibCUO1/HrwuMsBYEHjV2Oy62yaem1tf++r8L9xX5631ZuXpu/KuCefCslVm9m6d
         VisHOVkfUCXcCcda9w9GWzEVCU3UKA3OOgFSgn58XYE5Wg0hmttMsg2VAty7Dl9enMs3
         r99Az0S3gTURn745LZIYH4dtiAUMg7+w/LBTVIuMF5oSRLNLpO8qHdpjyius3AWvtN5Q
         fI/Q==
X-Gm-Message-State: APuU4Z/+62/ZNyicCVIvENN21AQX6KA0GAvKuGX8InNKTq8oh6mBYRg9
	INLMdi8xq0skctHFdrqOWdBDa2YI6IixomrZCBdGYQzG6U8ihCYp82Kcxo5RBPWbsnQ16LfnSg6
	Ec/5ww4k=
X-Gm-Gg: AYBFou1pNz0OKteWBCy7v0rVg+OzZSpyqLYyP9soyAvpT3cX8Gm8eVDin5Lc7/LrZ2h
	4Edd83HwZbU2FN21u9B/rXr9vwl791SsECqE1SQrkckRpDjFW5t30pfS18/MpIMeN6a13s/EypP
	RX9WZ4aoAqcEcMo2LyPDgmK3PWH01HZDUixoCfW/GbrK0B6n4noVm6WeVMNsvYym26uJIHagfw1
	VdDrH5w++46MTLEr8LtFHgAx9VJuEuCuO1xqck3otgeb6EUi7DDlPYg2AznDo/IOmadC7axL15q
	iIdlTZ8VXod+llvkgSjsLPYS/7CW/r9Ik9J4gtUU046elNWz/MDgC6/gItD/Y6tOUdqWz02QiwE
	klOoGNsAd5e6zXuypiF7sAsHQR+jhH9OUAR83oev7Z0/5SZmJvyzRCg3hXRGqRS501hEwoKFlis
	FSo6jL7GUGKW76RMI80B7mA73tHnnQGJ9uxgPZq/JQAv+taIvKNDV+Cl9dNiU3yYunIvNIJGSUx
	AppHejNypts+5rUz962QZXD36xZJEeAPrcTsFhkhoc25a7uaIN/40qIfRzhnCsVuumc48MpowdV
	TMcInA1sR7aR0xbgClGOlO3gG5UZ/CZrYnw7kU88yvlcdo7fLZ9ctNOkTyhlZJPj3ZaZ9nuXEAk
	X90JCtpBlDh1G2bUnopo=
X-Received: by 2002:a05:6808:148e:b0:551:a229:c8a2 with SMTP id 5614622812f47-5640decc467mr11325375b6e.64.1793817830001;
        Wed, 04 Nov 2026 10:43:50 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61d382sm2595770fac.13.2026.11.04.10.43.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 6/8] io_uring: free XArray nodes left by a failed store
Date: Wed,  4 Nov 2026 11:43:39 -0700
Message-ID: <20261104184341.516297-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184341.516297-1-axboe@kernel.dk>
References: <20261104184341.516297-1-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

Commit 51bab09b7ca1a9a6dd9303a3b7ee346f8128c963 upstream.

A failed xa_store() can leave nodes without entries in the tree, and
erasing every entry doesn't free those. An XArray needs xa_destroy()
before it goes away, even an empty one. That was dropped for tctx->xa in
commit ca6484cd308a ("io_uring: no need to call xa_destroy() on empty
xarray") over a lockdep report from freeing the tctx in softirq context,
and ctx->personalities never had it.

Now that the nodes are charged, a store can fail at memory.max and the
leaked nodes stay charged. Call xa_destroy() in io_uring_clean_tctx(),
which the task runs itself in process context before the tctx is freed,
in the error path of __io_uring_add_tctx_node(), and for
ctx->personalities in io_ring_ctx_free().

Fixes: ca6484cd308a ("io_uring: no need to call xa_destroy() on empty xarray")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.6 installs the tctx before adding the node and has no error
path that frees it, drop that hunk. There's no ctx->hpage_acct either]
---
 io_uring/io_uring.c | 1 +
 io_uring/tctx.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 5836612781ff..af349afeb4cb 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3123,6 +3123,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	kfree(ctx->cancel_table.hbs);
 	kfree(ctx->cancel_table_locked.hbs);
 	xa_destroy(&ctx->io_bl_xa);
+	xa_destroy(&ctx->personalities);
 	kfree(ctx);
 }
 
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index d056cce2c1a8..cea6d082a262 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -197,6 +197,8 @@ __cold void io_uring_clean_tctx(struct io_uring_task *tctx)
 		io_uring_del_tctx_node(index);
 		cond_resched();
 	}
+	/* A failed xa_store() leaves nodes with no entry behind. */
+	xa_destroy(&tctx->xa);
 	if (wq) {
 		/*
 		 * Must be after io_uring_del_tctx_node() (removes nodes under
-- 
2.56.0

