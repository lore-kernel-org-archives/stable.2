Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817926;
	b=HhRqphWl/Xom8+S69EDn65R1PNsHCEjnAbMugZQPaTvT5PLaRtlljcK8XIwUxbwHmRFn
	 XLaF+uVu+MIbD23nCKIMf3EkYdQhi6ToeSKSevO5jQabwt8MihmkErviAZl0rJ4JkbTuA
	 u0PX524B8vJ3gHW6Kci2Y8XmDEZrd/c/+MGKwNkPOdQcsvlHsmf8R1XU7xs6V7tjMrHcH
	 kVDMJoY+p3nM0Ygywuz/8JCGZvRRfg4qBJQmU8dkUNXWvgwV6YEgNEnyvTWNO5OffnQkm
	 W9rije6OuBtZZbYsWuSJfAmsrmvkM2f/SCHe6WWcaaG9XlD9d0j7iFmTupwoDFFE1JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S0RA2f2cgyVrp6v+LF6XfZ+hMDnwJGxzl9MKkfNS5QE=;
	b=MTCIRJGD9nHDGc3DphcmvCg0qgV+kQtslPkde9vHn2IM0wcOSy8b4zg1G58WtP48XsTr
	 0bDMTb4w9l7sGrcLJH/Iux+PXrR2HBaGrqvnZ8s3oliNKxV8tcuM6Q7v/NMCRDQtfHpgK
	 Q1Dm2HyJcGztDMAbzjMAakNpCxfJ+u1nhe0J7EQFRlUVnz6Hq+p5nXmp9DEBlYuoV02Mm
	 7MCN/SZQcIP3HXCpRLls6c0LMkF0uUTEauXsIm4fhOmcnqz7YPOQUXbqlO758kqUOybEE
	 0HhfbKZFJXnucXSoPalUt3GUTzS6IOGvReFRx93MDa3LmcFMgLQA4l7KGU3m8xiRJIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hKuRRCR9;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFADE606A335
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFADE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hKuRRCR9
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4a6bb779d13so675152fac.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817925; x=1794422725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S0RA2f2cgyVrp6v+LF6XfZ+hMDnwJGxzl9MKkfNS5QE=;
        b=hKuRRCR9wgEa6dkfdM9Gt4/6iFa4LClMlg/Uit7QRDvQzlgwIjRNkaYOmONbGZZXsW
         0BHbjUrnbvhT1fPGZQ429CObRwSIp2yth1fCma4JU8B+KDsz8LJhDoyNc172NmusqUmz
         hx+yoWdWmvOz2Ai8d6rXeSgM9Qxzqxz3PrNYOec92bUUf/ANFabGDoMtdSrcZk7RpUte
         cFEMgciIuIXyj8vjdonooI07ZkkfF/erX0t1jFEc5GFgPv26aDSHyy2Ybw6cMeyaRg9g
         mEwscn1JmcxsnquEkeoI9bFQ1yyaU3Z3CVl2wNOs4L90YYLsunqvRQaJl/f8roXwjcK5
         d7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817925; x=1794422725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S0RA2f2cgyVrp6v+LF6XfZ+hMDnwJGxzl9MKkfNS5QE=;
        b=Ulh3NGk3YT8LC36wtz41IO4DjkFhHlIUFnDMMy7o4/udhBFpV96DdybM64nycXdHtN
         o61o/GaWfHglAhcMhKr3nHb8iUAJCrm2k8VG5+YiibPs+lTiAhJLhpSCJjYPxw9biOU6
         kBmsVKg2IStA8XF/4rUX7WI9QRgX/nKozqlYCVtABCOzk0xKv1MA82ynXF+7mJm/MWWx
         Iyg95CVz3WqvMMLCm0LD8w4WJLO6ieVLZJzIp6GH7b0GoiPp/etOWEtNOtBwhwG2HuNl
         i/qhKZnAxW4XC47I2ePl6zZjw7Y8GtnvnFYHfLNeqv5r8sXHIzJZU+9bKkYvX9fCdoIB
         3z7A==
X-Gm-Message-State: APuU4Z/AYtJIO3W9IdWrFKO1CVeIYPMgRQ2jLS/2rk2QFEDLz86y97ns
	jkTkYaUM2wDdVc4hb8fWRinoqF/ftMtAkD13BqDXRi71Z8UvRXJ6h9vPTCn8z+Kz9H0b1yxCT07
	R5Eq1/40=
X-Gm-Gg: AYBFou2u9/l9+yk4fMftrt2cnFCTqYE1bv2/dYnVC1D1zXWS4EVZYPtEjww9Rll75w6
	NKIb6hpTzs+41jtzc9GC+sMxhjIsuNQ50pQHIeJTwQLzoaFts2TgqNfZn5k1sQpJxyAvveN0i0z
	7Ve5Nuj3f0BjJ/9YYPxQaxnIeWJNjvuaUgOD0CFAREjfEpCVUBTBfnT/vX8p9/Net5Bhi+lNJS4
	UiZA95nDke7uufTgGsv8E9bKmVBC/0JbEdnzFym6CEz1liNPU9lPcLbi4UtHXh+K71VwndcKpjJ
	a1KRwIO3B5bXH2aTjcafywWMXHW9yxAN27pcOWOjrGeTV4Ei8lJCwjDE3h87P0RB1lNjhEB5KJj
	+/Qaa25IFixDUvjE/eC7wXgL2Tk5VrreR2sER0FjlX+PP6oqaNgRqnV5qHQi9fSys2WEgjn29zW
	GC1oKRwNiDZRvIFAJ7HsTmJTaBb8B7JKXZgJi9Gk8cpsYmjAcitmkwlyYYp1vBnLvJy2KrVcIMM
	LO1JnZNnD+IYFjAh6nPAh0Y3fzRb0ussibV+2Un4ovaeviQZUbFTY/+7C7UIsjTtYFpVCa70G8j
	C232MG8939As9phN1UN0SHIB6cZH8f0hhEPY4fCDoAcFaAKt/Jf+zJrN+PvJzeo1lTkiXnbEsw=
	=
X-Received: by 2002:a05:6870:d692:b0:48f:e107:3176 with SMTP id 586e51a60fabf-4a90777e992mr11363623fac.41.1793817924417;
        Wed, 04 Nov 2026 10:45:24 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 10/16] io_uring: free XArray nodes left by a failed store
Date: Wed,  4 Nov 2026 11:44:41 -0700
Message-ID: <20261104184447.516768-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184447.516768-1-axboe@kernel.dk>
References: <20261104184447.516768-1-axboe@kernel.dk>
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
---
 io_uring/io_uring.c | 1 +
 io_uring/tctx.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index f218a1ec3f09..880be1fed3a6 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2297,6 +2297,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	kvfree(ctx->cancel_table.hbs);
 	xa_destroy(&ctx->io_bl_xa);
 	xa_destroy(&ctx->hpage_acct);
+	xa_destroy(&ctx->personalities);
 	kfree(ctx);
 }
 
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index 4dedcdc44780..291e30e00e45 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -189,6 +189,7 @@ int __io_uring_add_tctx_node(struct io_ring_ctx *ctx)
 			io_wq_exit_start(tctx->io_wq);
 			io_wq_put_and_exit(tctx->io_wq);
 		}
+		xa_destroy(&tctx->xa);
 		percpu_counter_destroy(&tctx->inflight);
 		kfree(tctx);
 	}
@@ -250,6 +251,8 @@ __cold void io_uring_clean_tctx(struct io_uring_task *tctx)
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

