Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859284;
	b=5fVzLdkH3vyaLEiIK07/KA2N2IDd+AlPt+EefguidYyyUxesZq7lRDcNL+FrnV2z7FOc
	 wRyW/fwIToM/m8CdqHWb1FAH8YpwNrW1dHNIsHgUOdN22A09UbfJ6M/hTv+Jx8hRa6kzZ
	 jNxLmz8sLO8VNUwdqIsLLDos4wyisv2S8vaQlerc8cWWkDiCtw1Fr3y120kf2sr8qBhbg
	 Xttcz3DlBCGPzsWN9WXj1QkqtN8qbpovPh4kR1rzRjCESu/gh+uElO74BFj/H94dNnb30
	 PsAxrejWU9ZzTA+oJdraUhratrEuucKW/zjvsS9hb5yd0pVnt/r8GryURXoEwXA8Upg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U36Txc3YHDyJmUAwKRZH3QKFOSd9Ge1d4BD1cisI4v0=;
	b=28D1jxsmNSorVEquOquPlyDIS9/TqKXoju80cperudP5PuAx8tMqYqWsluXlGAHRkzhx
	 0B1aiclCN4+k9cctI9UIp7amGgvWCgcKnhiMBA6mgEh3sHE4vAfEcsbF7/O/rg+fq7KYV
	 H9gl3vJVdAlZssZ6ZS6IyFkbbf1TVNX/xpJK7ZGc9MC7p1MTG+l78FzKdbjXVXpFk/ZGG
	 BLKHQ+Ma5oHLlo1dJWEiky+lTttA/P8KnJrUbGBroMZzu0Ly5+S/P6KOfvDHkz7HERhz0
	 FrEbPV/JsVXyFg0RQChoCwrihDAWGOOaDezJfmZoJdw3WQipbnEXXX7FxJ+derlKaOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="s/Ee9+Xo";
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B0606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C24B0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s/Ee9+Xo
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-824f3901d55so1420014a34.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 22:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793859282; x=1794464082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U36Txc3YHDyJmUAwKRZH3QKFOSd9Ge1d4BD1cisI4v0=;
        b=s/Ee9+Xo4LDQ1MArYxLd6K9zq/yI5dpCu9hbgjb73RDC7vIjiAHYy5YuaInU0ZF+uG
         IbMoH6bsEMPOuQnaiEU23F1el66kHy6+RLW1ARCRCXYXecfs+I93CstqiRoR/myBpNIb
         dTQE7rAgVlt3GEqOQEsqC3duFc67dYQuDUQDAKt62lz0o9lbxVhIUE0h3LobGGnIJdb0
         mOk8faBQraBXk9TtWuvQnMgdSpAIhne6aI2B3EmbhoOfaYgVncx/gfG8cONUo3aNkkKs
         9l0j0sG9l/7huXDZJE/tSSac+9ElbHbZAz3dvHMcu6hfLmcmHa8xTO9VdzjJpauwZ76k
         0cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859282; x=1794464082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U36Txc3YHDyJmUAwKRZH3QKFOSd9Ge1d4BD1cisI4v0=;
        b=PYudM4VEygAFF3RlN0JeH7h8CfH+o59jPoSYQHlHI7YtImSkS5LGJqFmh7Ik5TIsXY
         osek4HB0FBTe2FMbROwVevZmGRsu/UyWJZEfeHT9H0LwOUVeLwgunKDi0OixDFlW8OWr
         cSWk5aLRdamzeLvqXEdKKdKqWolQGmIsLGUwb88k607KDMiRhHbaaUWrHZqq7aLUp6Q1
         jISHKBeeneEB+U2wT/J5FUq8AnpXjRIFKLpNaQIx1PCwwHlbAVC994n50eHoEsX5A1Kq
         NlJYlD2S/PdPSxAMRMMqM3up4UPXuh9GCiOyLCvxKqabMJ/tobbYZjQjSWBmBIYeZ5+j
         bwsg==
X-Forwarded-Encrypted: i=1; AKwUvBx26qPmi1oEkR8hQu1yfiiUxWRaCGwJ/1xlLLBbvjZxDAh+jG0FbFDUufh54GLfJAWmpYNUXfw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9PVlY9d2I2Pt7l51wO3ALyWb7M9TVN6BoAwCgnP9f7PIkh3ss
	19fHO4s+FufDTZmonm6I+pgqNAHympHFLE+rZGYAGVxPbLzt88q0lD4M
X-Gm-Gg: AYBFou3HgsTk2zg1UUq6uT/X9/htrIm+KpnDTXYs+QYiDFrt/pF6d3jo+x7IJjr//Vv
	g6Ne/2ca34HRNBtWk/Ch8fxHmcFge6dW0t7YbvJl6NdIzR5KZscloYtXL/TKXQUsjsFaBF38QHM
	blwJBx7TXTvw/jP/O/+avzSPSQAQLmJ0/xlWnxnhr91IPVqsHjrIwjXMuiKR3edxVMqGL1gQmAc
	elpmdpApjvhiJRAKwqR1xEAa7GwhI7IziBCNAjnQl9vEv1YYCcttdEP/xbuq8nYHUGPE4Sek62b
	x8MjmPzxwvNT3kI4LjpLRovUCmQsLnmFJkJgrE7jNe0ZvTZV47gFyIUTHfA8AFwhMgocID15B/K
	jZJfRitnPmF8vjLEawWwG2XHs46yc/GYzSgFLD8r8M5zQ33ijHr3nLwlCrdf/v3UT0yEqPtty74
	1RlfPy8/QylxwV3gxrjRoRkASDhA/eQ+vWnAFK1O7JUV1x8pxBbrx7ist5Dq/Ey5Bm2Y3MxPmNF
	lLC9jM+JntpJnDeQP4OtO75r3Ci+EFmfpjr3o49CbDAdbki2UP/yS1tlqoL4pB9oW4ItsstQgjf
	pTbEh9IJ7Wk7RGq5wUxnK87unp0B66mnzJqpNGSeq+wvuK1sx9lG3aMSlmibPf13ptaA
X-Received: by 2002:a05:6808:3383:b0:4fa:4b2b:5869 with SMTP id 5614622812f47-5640ddc3bebmr12496211b6e.38.1793859282632;
        Wed, 04 Nov 2026 22:14:42 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.39])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef6e3bsm3469009b6e.5.2026.11.04.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:14:41 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	stable@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] io_uring/kbuf: fix cross-mm interpretation of provided buffers
Date: Thu,  5 Nov 2026 14:14:33 +0800
Message-ID: <20261105061433.1947491-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

Legacy provided buffers store a raw user virtual address.  It is
recorded in io_add_buffers() and later returned verbatim by
io_provided_buffer_select().  The consumer (recv, send, read)
imports it as a user pointer, so it is resolved in the address
space of whichever task issues the request.  Nothing ties a buffer
to the address space it was provided from.

When a ring is shared between tasks with different address spaces,
for example across fork(2) and execve(2), a consuming request reads
from or writes to an address chosen by the provider, in the
consumer's address space.

Record the providing task's mm in each buffer, and refuse selection
when the consuming task runs under a different mm.  The buffer stays
queued for its owner and the request fails with -ENOBUFS.  The mm
reference is held while the buffer is queued.

This issue was discovered by Tencent CodeBuddy Security.

Reported-by: zeroday zhao <zerodayzhao@tencent.com>
Fixes: ddf0322db79c5 ("io_uring: add IORING_OP_PROVIDE_BUFFERS")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 io_uring/kbuf.c | 23 ++++++++++++++++++++---
 io_uring/kbuf.h |  2 ++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index abf44f5dba26a..b585105a17202 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -4,6 +4,7 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/mm.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/namei.h>
 #include <linux/poll.h>
@@ -97,12 +98,18 @@ static int io_buffer_add_list(struct io_ring_ctx *ctx,
 	return xa_err(xa_store(&ctx->io_bl_xa, bgid, bl, GFP_KERNEL));
 }
 
+static void io_kbuf_free(struct io_buffer *buf)
+{
+	mmdrop(buf->mm);
+	kfree(buf);
+}
+
 void io_kbuf_drop_legacy(struct io_kiocb *req)
 {
 	if (WARN_ON_ONCE(!(req->flags & REQ_F_BUFFER_SELECTED)))
 		return;
 	req->flags &= ~REQ_F_BUFFER_SELECTED;
-	kfree(req->kbuf);
+	io_kbuf_free(req->kbuf);
 	req->kbuf = NULL;
 }
 
@@ -124,7 +131,7 @@ bool io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags)
 		list_add(&buf->list, &bl->buf_list);
 		bl->nbufs++;
 	} else {
-		kfree(buf);
+		io_kbuf_free(buf);
 	}
 	req->flags &= ~REQ_F_BUFFER_SELECTED;
 	req->kbuf = NULL;
@@ -140,6 +147,14 @@ static void __user *io_provided_buffer_select(struct io_kiocb *req, size_t *len,
 		struct io_buffer *kbuf;
 
 		kbuf = list_first_entry(&bl->buf_list, struct io_buffer, list);
+		/*
+		 * The buffer address is a user virtual address that gets
+		 * interpreted in the address space of whoever issues the
+		 * request. Refuse consumption by a different mm than the
+		 * one that provided the buffer.
+		 */
+		if (unlikely(kbuf->mm != current->mm))
+			return NULL;
 		list_del(&kbuf->list);
 		bl->nbufs--;
 		if (*len == 0 || *len > kbuf->len)
@@ -452,7 +467,7 @@ static int io_remove_buffers_legacy(struct io_ring_ctx *ctx,
 		nxt = list_first_entry(&bl->buf_list, struct io_buffer, list);
 		list_del(&nxt->list);
 		bl->nbufs--;
-		kfree(nxt);
+		io_kbuf_free(nxt);
 		cond_resched();
 	}
 	return i;
@@ -575,6 +590,8 @@ static int io_add_buffers(struct io_ring_ctx *ctx, struct io_provide_buf *pbuf,
 		buf->len = min_t(__u32, pbuf->len, MAX_RW_COUNT);
 		buf->bid = bid;
 		buf->bgid = pbuf->bgid;
+		buf->mm = current->mm;
+		mmgrab(buf->mm);
 		addr += pbuf->len;
 		bid++;
 		cond_resched();
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 401773e1ef805..fe0b01c475a49 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -44,6 +44,8 @@ struct io_buffer_list {
 
 struct io_buffer {
 	struct list_head list;
+	/* mm of the task that provided this buffer, see io_add_buffers() */
+	struct mm_struct *mm;
 	__u64 addr;
 	__u32 len;
 	__u16 bid;
-- 
2.43.7

