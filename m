Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269903;
	b=FGslnRBmrB2bWlW9d1uTuXJKpoY22Fgb/H6u9a7AseAT63xthucS7ntOSt9iHsFfgRVG
	 yOibDNEfVuy+JAd2yorZnezQX6SdKaTeygmHbBcCiOcGh10jnSYrF6AcLx/BV1ShcgwLJ
	 ou4i6p2ZKCUJfpoGPThxqjYxHmIyrMmNOJgTO7egDJ2ddHTUFPuyDxVlVIIMqRqH/4yTp
	 4sELnU8A7cIsMHhrLDjinR+z7v2uKv0Mw2cin8dmLi5UlQTN0GeDko8CsLMpYYr1Gaw0O
	 9nmwHWJbNZbQtkKGS7RpTknb13FpvrvWdoBcQZ5/zGiC8gU5kQWyb7WcztIrZPamgUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vuWTuv7wT+CRQwrB4gpB0n/Lvy+IrJTCH55qZNEAo0g=;
	b=cshxHAssA2ybBlmMZOQQF8gTyTOp8jINmBgyrI+qsY+HT/RzMZ0lMa2jD+2E7p/3vPy+
	 1Q31/c3cSxWTHX97VyohsOz56jsRxVWsLNXgJSxM9XxmlyMWz9/iBai2mDDcMhDiRDetX
	 z3picAXTz0rqX9SGtd6h3t4enSNIXewyiSsJkpMBBi7a12687U3cT37TgxGjFE+ne6s9i
	 Rk6/NiGDjCdsh99rOch69Y9KdOkyArnfntUqLszG//mC/CUAf9yjkXaA5axcREPgZNLe/
	 2kK1HYO6oysH6v/WQe34VeP+8o1Y+RT2qKMyTTH/Zx/YJ3h9V+8hhTUw5A5u2TeHSlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OQORBYxy;
	arc=none smtp.remote-ip=74.125.229.136
Received: from mail-dl2-f8.google.com (mail-dl2-f8.google.com [74.125.229.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B7606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 557B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OQORBYxy
Received: by mail-dl2-f8.google.com with SMTP id a92af1059eb24-1379d236149so643097c88.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793269901; x=1793874701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vuWTuv7wT+CRQwrB4gpB0n/Lvy+IrJTCH55qZNEAo0g=;
        b=OQORBYxyuPXr2C6tB5FcSWZ112v3RYT/yYSVdqJedc+xpTOi3YmtBggvwlqSwE/WvH
         vzsZ6Q308sXimiWsIOkVEIkm3NjlCuNXH0SvPxqtHg1vrqhb6XTUorARtGDAbZz26gA1
         MZ4qyCBMH76lmEZMhD8EQq+Ovhn0o2Ppa4K2zjuGbWqUkS4rO/4ugKV/N2G1kQL6t9ad
         HP4ESulQxhJWNek8K2kjh3WgalyO4cXD78dzkztQdSjhzK6mVp1WiejGuIpBPxYNHS+2
         2X9oSiOcOS9k/OvBSf94hHKLTG7Ejm4A5PC2+rLas6g6g28MrEZIWxxINkiV6eBtqGAs
         WPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269901; x=1793874701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vuWTuv7wT+CRQwrB4gpB0n/Lvy+IrJTCH55qZNEAo0g=;
        b=Ccmphx7LQdHXsj5Hu+hvTRwcjb0iz3Wz1GJ9iLeyIH62EBXS1gpdXw3RwuaiBa3uSH
         fVZRo5rQHwbV42cFBsZzZRBakHqH20xOw2sEoZm0+JPj29XQ0RJtbgof23sUyiZXR3B7
         pVDPFJ/out4eXiBp/+epn4QZPiGzNXSwKI1zaW0WPe842ExeZafbq0xeYgPuTuTRQRYG
         gNpP38OE8RAZ9ObDUcN36dc4bAun0GgzYLJm7ydSP+ZywOvrp2gjNNbqRf5gJnM1UfaB
         dYdNO9Y34Tuv7fp7yj4MEdscAOICRZXW464IFaxT+3Hb89Mjr2AgrWoEemrfRuW9o0T2
         0vCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUi0q4+JaVS+Q0c5ERi8GwqZGnM2GJFtL1qQ2FkXRZRpWwQah8Z6+Jcz2iFBt8JM4OlGTgr7g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZJ4mCqR4/ZVApPoETHOHqzcRalC4rD50vkTzbEc0o2Se+0I8X
	LRolUfoxePA/LcXU/PC4NBSa6LtjdMsFPghSd8rukm40jtzOQLHmsg0=
X-Gm-Gg: AYBFou18mP/giDNWX8it8Pf0BG9ggM6l2u9i4W3UM0+MZVHfDCwFoHBAOtIeOPu0rFf
	1hXA1DkxSoXvZZZgc9hGBmuSjCT8rTOpd/mIlOjrK6ctxHybbwAaJJhpgmdf3CCF99pk7DsssVz
	+Dk6I2jAEtEUiSkHa/KlCKggBVVWJAB2AQy20k/quFi7l/uqE97MoVyZFqgbbjfTNPyN+/oPHtH
	vU1GdK35uEGxFz6uaNHSx7MwN033tAE9bIwwHEI2HmAIUNCW2qCyX13hoiwaJyp4oXZsqQKg12R
	gCu3OjoIBuHV1nkDnnlp/raVSg1Q5M5vhPl86icJrfyzj8KSPvtL2gmH4A4N1C1i12V3bOHDgj2
	AW35rsUfEUjyIeq7bHUIGU2vdNqgO4Y4BaaDZAxhMfQog0GC1bb9j3wJkLw7tkEQ6/EH4pWJ14b
	MjhZotDhp6RqKRQweaN2fWnRwNsBHM81C9oVB/yqhila1pNq5Q7FSEpuv6yWMefwvPGpZ8X5c0U
	L3K17Mu3+Or0xEP7jHWv7jEDFNkvm5ijh0kVoG+IlhdRb1hrg48+YOSXqpjUq16tvncvCo4hf6e
	dOio95/4pSKcJw8gtEQ3fL2CH3oiG3gu2wjev+8l
X-Received: by 2002:a05:701b:2818:b0:187:c940:21b9 with SMTP id a92af1059eb24-1a6cd684cd5mr7037612c88.30.1793269901257;
        Thu, 29 Oct 2026 03:31:41 -0700 (PDT)
Received: from archlinux ([2405:201:ac01:5300:9bc6:9c9e:e00f:4eb0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75f143cacsm12888470c88.16.2026.10.29.03.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:31:40 -0700 (PDT)
From: Anvik Loitongbam <permissiontogallop@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Olivier Langlois <olivier@trillion01.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	Anvik Loitongbam <permissiontogallop@gmail.com>
Subject: [PATCH] io_uring/napi: fix list use-after-free on PREEMPT_RT
Date: Thu, 29 Oct 2026 15:52:44 +0530
Message-ID: <20261029102244.141621-1-permissiontogallop@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Commit 45b3941d09d1 ("io_uring/napi: fix io_napi_entry RCU accesses")
converted the NAPI list teardown to list_for_each_entry() and
kfree_rcu(), with a comment claiming that list_for_each_entry_safe()
is not necessary because kfree_rcu() defers the free to the next
quiescent state.

This assumption only holds while the surrounding spinlock section is
non-preemptible. On PREEMPT_RT, spinlock_t is an rtmutex and the task
can be preempted while holding ctx->napi_lock. The raw lock inside
kfree_rcu() only defers the preemption until it is released, and the
release still happens before the iterator advances. Once the task is
switched out, the context switch is an RCU quiescent state, if the
preemption lasts long enough for the batch to be flushed and a grace
period to complete, the callback frees the entry, and the iterator
then reads e->list.next from freed memory. The same pattern exists
in io_napi_free(). I did try to produce a uaf on an rt kernel
build, but it did not work.

All list mutators are serialized by ctx->napi_lock, so the entry after
the current one cannot be freed before its own iteration. Caching it
first with list_for_each_entry_safe() in both loops might be a more
safer and correct approach.

Fixes: 45b3941d09d1 ("io_uring/napi: fix io_napi_entry RCU accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Anvik Loitongbam <permissiontogallop@gmail.com>
---
 io_uring/napi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/io_uring/napi.c b/io_uring/napi.c
index 7e698720cd51..d299c89cfc3d 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -110,16 +110,10 @@ static int __io_napi_del_id(struct io_ring_ctx *ctx, unsigned int napi_id)
 
 static void __io_napi_remove_stale(struct io_ring_ctx *ctx)
 {
-	struct io_napi_entry *e;
+	struct io_napi_entry *e, *next;
 
 	guard(spinlock)(&ctx->napi_lock);
-	/*
-	 * list_for_each_entry_safe() is not required as long as:
-	 * 1. list_del_rcu() does not reset the deleted node next pointer
-	 * 2. kfree_rcu() delays the memory freeing until the next quiescent
-	 *    state
-	 */
-	list_for_each_entry(e, &ctx->napi_list, list) {
+	list_for_each_entry_safe(e, next, &ctx->napi_list, list) {
 		if (time_after(jiffies, READ_ONCE(e->timeout))) {
 			list_del_rcu(&e->list);
 			hash_del_rcu(&e->node);
@@ -264,10 +258,10 @@ void io_napi_init(struct io_ring_ctx *ctx)
  */
 void io_napi_free(struct io_ring_ctx *ctx)
 {
-	struct io_napi_entry *e;
+	struct io_napi_entry *e, *next;
 
 	guard(spinlock)(&ctx->napi_lock);
-	list_for_each_entry(e, &ctx->napi_list, list) {
+	list_for_each_entry_safe(e, next, &ctx->napi_list, list) {
 		hash_del_rcu(&e->node);
 		kfree_rcu(e, rcu);
 	}
-- 
2.56.0

