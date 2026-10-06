Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1114048BD26
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298777; cv=none; b=iTYOlqz8rLmE0ggCvQhL6CpHPbBXmFiJ7H8ZXrlYhdTsYl7X3xMMY13Y2u3hITe1yr1ESJrGwYrmCRo2vaQHp6PdJ3saH63B9Esym2RK6hbS07nJMsNOoZGXKTyJRrUHQ6XKl6pFyr6lgZcFA1x7TZ02qroJfVvRpPxAPQfd4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298777; c=relaxed/simple;
	bh=a2pGJgyenrOQBcUgU4+aMvSHZwkv/cIvXJyf0CX0F6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6taAbgogEq2JeHaE9Jc8ODkNSlP/XtvGkFfedYc5hCQQ87JZad5eLAERJUObpUDdAooFkbuCIopwl8aAk7bBtC+PM7MZOBIFxAE0QtLMCU8Jji1gkSfCG4kGRbEqWCW+EQAxsyTo8r+dALnHYTfKWSCvJc/AuJ7U+bi56U9mQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=VVZUX6Bx; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="VVZUX6Bx"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-49e1dbfe15eso341209fac.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791298773; x=1791903573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tI0LY/5mH9k6I/X/x+R0S0p1KLDmL/lVZOe8khheaM=;
        b=VVZUX6BxrOH5ap4dVh95/WwdcKxlHK4sNY/3R9hnWFh37bX7WVPtrnoq6WFJDL8iHH
         fa0S56URHS+G1ucb62rrjPE6RPKkKnzDIRPPsbF8DfFzsJUy6p03MZuzCX2eRBOzO0hO
         DmyrZEIFohvvKxz9/caN8mTIpVFZKtxs0/FH6ed8uVn/sHEhlBiEwvcH3g4XOH+df3nY
         4owhplpdcdwy0ISvrsyHXJ4dPn50FCzFwz9KeBI5054dhr0YaLs5ajsgR70jaFxVhFzJ
         NQgHJ7eSXOj3xupfMQLUcGCFoIRlPufWX47YQUkzfJfmwoX9xQaWwjUX9ASNAP8dnbq1
         Q9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791298773; x=1791903573;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4tI0LY/5mH9k6I/X/x+R0S0p1KLDmL/lVZOe8khheaM=;
        b=BZH42i/iAxVmZ8Av+rCPyizI5dYKt4rKMY2EhVSfBd1jOq034XLYy4DiS2/FrWuv2W
         HzHu8nuyb5xtGATegNHh0xwd96NT3NgeEJ65Bi922P/aqMXX5sJ11p5WCKirTSc9333O
         bf22d+mIOYatwsJ3c20DhNKEg54c8PQ0iiUOp+SQKLIKjURjLKJ02mMH5evRd6ayD1kQ
         21ZNty6tQO3RAs7Gg1hV4FgFtf9etL+FHSxN5+sI/b3EEq+4MIirCsmKHCYATpJdFsB4
         nWM4/Gaj+O/TOIZa7S4PA9KrgM088EyozfoX9EzFLY3mLQGocJpUWU4sFOWvGhT+i08h
         pGEg==
X-Forwarded-Encrypted: i=1; AKwUvByevK3lp9KPiyjy2rFugVnwBUc/vDpf5IYe1g23n+DDmX2SFaiTcQXu9b+6IFkNn9l+pabF6X8=@vger.kernel.org
X-Gm-Message-State: AFuF++mdBUqlrstQyI9DW+GcGPZzc6zjpRIvH06ez0AjJCJUspFSjF5f
	27y8E4BMZUBhWAmfIehQyk8CSFWFt6EY0vS8E2H+snfHx2rat6NvUjkeXufqzSF/Rsc=
X-Gm-Gg: AYBFou1aaMgKCE41o8s7DmbPmzC5TZkFORhwSM8g4CsyStel6QbQAEaSwGTp3QjIbEC
	WSMPidivMh1bsLprYdWjh8WWCDYurG98Njjy9F2WKEl2d7f+uDMCQY/mvTigAQJqYJBvOmTq3n8
	kO1i0uGr2HceLmWixIs047cPo9Fg5UegZ3Y2JpNBpFPxxOB/Bej0ODke2x68RGetL78Okk0gu9z
	+uz3pHH23xJkkGdYgDCxOT0JB5tojM3PO3qM/sPUdwEwmtBydftex6OmbMpM9yRIgDB/Lh+IG80
	2LGL+Ak14DTHaGaCByV0WOth5Tmur4F4qvwyd4CoaWxjpEFfXKZ3KMCgSjBtVgJH5//iAaRP+4J
	2jUYZSxtxWAeIMk1u56b8qY3T1hLA+uZnwg3FidEincl3XXugs1HrPFLFIX+kgEIN2iVnUtmVdq
	Ta7oOnTREkCgiK2nfcNGjGSW0ZThXm2MdxcOdSKGiqDfZ43JqLcgYBeaqmZXCqO7gBIZiDb2av+
	f1YEtALriWjAXBhR8+/z+jytqeZ7a0WdbNptThvdy1L9sBirWg4uD64S86aHMa5XnAl0gGa37jQ
	wB6jwuzhuLoMBdtDcj0RPD5E
X-Received: by 2002:a05:6871:110:b0:498:f70a:b54e with SMTP id 586e51a60fabf-4a240515209mr1399607fac.43.1791298773492;
        Tue, 06 Oct 2026 07:59:33 -0700 (PDT)
Received: from [10.0.0.192] ([72.170.223.115])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16f00b5asm13145180fac.14.2026.10.06.07.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 07:59:32 -0700 (PDT)
Message-ID: <01d75013-9eae-4ec6-93b5-cc1b2b83b791@kernel.dk>
Date: Tue, 6 Oct 2026 08:59:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: do not charge the SQ/CQ rings to RLIMIT_MEMLOCK
To: hengyul@cs.unc.edu, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261006125732.3425762-1-hengyul@cs.unc.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261006125732.3425762-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/26 6:57 AM, hengyul@cs.unc.edu wrote:
> From: Hengyu Liang <hengyul@cs.unc.edu>
> 
> Commit 8078486e1d53 ("io_uring: use region api for SQ") and commit
> 81a4058e0cd0 ("io_uring: use region api for CQ") made io_uring_setup()
> allocate the rings with io_create_region().
> 
> However, io_create_region() charges the memory to RLIMIT_MEMLOCK, and
> the rings had been exempt from that limit since commit 26bfa89e25f4
> ("io_uring: place ring SQ/CQ arrays under memcg memory limits"). As of
> now, a user without CAP_IPC_LOCK gets ENOMEM from io_uring_setup() when
> their rings exceed the limit, which is 8 MiB by default. PostgreSQL
> developers have already hit this in their io_uring tests [1].
> 
> The issue can be reproduced with a simple liburing program, run as an
> unprivileged user:
> 
>     #include <liburing.h>
>     #include <stdio.h>
> 
>     int main(void)
>     {
>             static struct io_uring ring[64];
>             int i;
> 
>             for (i = 0; i < 64; i++)
>                     if (io_uring_queue_init(4096, &ring[i], 0) < 0)
>                             break;
>             printf("%d rings\n", i);
>             return 0;
>     }
> 
> Before those commits (v6.13), it prints "64 rings". After those commits
> (v6.14), it prints "21 rings".
> 
> This patch makes io_create_region() take the user to charge, and passes
> no user for the SQ/CQ rings.

Agree that this is a bug, stricter accounting may break use cases.
However, I think we can solve this simpler, and actually kill more code.
How about something like the below instead? Only apply accounting to
user backed memory, which is how it used to work too. Would be great if
you could take a look and also run your test case against it.

diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index 48c0eb012412..da2328b52b38 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -16,10 +16,8 @@
 #include "zcrx.h"
 
 static bool io_mem_alloc_compound(struct page **pages, int nr_pages,
-				  size_t size, gfp_t gfp,
-				  struct user_struct *user)
+				  size_t size, gfp_t gfp)
 {
-	unsigned long nr_compound, extra;
 	struct page *page;
 	int i, order;
 
@@ -29,22 +27,9 @@ static bool io_mem_alloc_compound(struct page **pages, int nr_pages,
 	else if (order)
 		gfp |= __GFP_COMP;
 
-	/*
-	 * get_order() rounds a non power of two size up, so the allocation
-	 * can hold more pages than the region exposes. Account those too,
-	 * and leave the compound allocation alone if they do not fit.
-	 */
-	nr_compound = 1UL << order;
-	extra = nr_compound - nr_pages;
-	if (extra && user && __io_account_mem(user, extra))
-		return false;
-
 	page = alloc_pages(gfp, order);
-	if (!page) {
-		if (extra && user)
-			__io_unaccount_mem(user, extra);
+	if (!page)
 		return false;
-	}
 
 	for (i = 0; i < nr_pages; i++)
 		pages[i] = page + i;
@@ -120,15 +105,8 @@ void io_free_region(struct user_struct *user, struct io_mapped_region *mr)
 	}
 	if ((mr->flags & IO_REGION_F_VMAP) && mr->ptr)
 		vunmap(mr->ptr);
-	if (mr->nr_pages && user) {
-		unsigned long nr_accounted = mr->nr_pages;
-
-		/* a compound region was accounted for the whole allocation */
-		if (mr->flags & IO_REGION_F_SINGLE_REF)
-			nr_accounted = 1UL << get_order(io_region_size(mr));
-
-		__io_unaccount_mem(user, nr_accounted);
-	}
+	if ((mr->flags & IO_REGION_F_USER_PROVIDED) && user)
+		__io_unaccount_mem(user, mr->nr_pages);
 
 	memset(mr, 0, sizeof(*mr));
 }
@@ -154,11 +132,12 @@ static int io_region_init_ptr(struct io_mapped_region *mr)
 }
 
 static int io_region_pin_pages(struct io_mapped_region *mr,
-			       struct io_uring_region_desc *reg)
+			       struct io_uring_region_desc *reg,
+			       struct user_struct *user)
 {
 	size_t size = io_region_size(mr);
 	struct page **pages;
-	int nr_pages;
+	int nr_pages, ret;
 
 	pages = io_pin_pages(reg->user_addr, size, &nr_pages);
 	if (IS_ERR(pages))
@@ -166,6 +145,16 @@ static int io_region_pin_pages(struct io_mapped_region *mr,
 	if (WARN_ON_ONCE(nr_pages != mr->nr_pages))
 		return -EFAULT;
 
+	/* pinned user memory is what RLIMIT_MEMLOCK is for */
+	if (user) {
+		ret = __io_account_mem(user, nr_pages);
+		if (ret) {
+			unpin_user_pages(pages, nr_pages);
+			kvfree(pages);
+			return ret;
+		}
+	}
+
 	mr->pages = pages;
 	mr->flags |= IO_REGION_F_USER_PROVIDED;
 	return 0;
@@ -173,8 +162,7 @@ static int io_region_pin_pages(struct io_mapped_region *mr,
 
 static int io_region_allocate_pages(struct io_mapped_region *mr,
 				    struct io_uring_region_desc *reg,
-				    unsigned long mmap_offset,
-				    struct user_struct *user)
+				    unsigned long mmap_offset)
 {
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN;
 	size_t size = io_region_size(mr);
@@ -185,7 +173,7 @@ static int io_region_allocate_pages(struct io_mapped_region *mr,
 	if (!pages)
 		return -ENOMEM;
 
-	if (io_mem_alloc_compound(pages, mr->nr_pages, size, gfp, user)) {
+	if (io_mem_alloc_compound(pages, mr->nr_pages, size, gfp)) {
 		mr->flags |= IO_REGION_F_SINGLE_REF;
 		goto done;
 	}
@@ -230,17 +218,16 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 		return -EOVERFLOW;
 
 	nr_pages = reg->size >> PAGE_SHIFT;
-	if (ctx->user) {
-		ret = __io_account_mem(ctx->user, nr_pages);
-		if (ret)
-			return ret;
-	}
 	mr->nr_pages = nr_pages;
 
+	/*
+	 * Only pinned user memory counts against RLIMIT_MEMLOCK, kernel
+	 * allocated regions are memcg accounted through GFP_KERNEL_ACCOUNT.
+	 */
 	if (reg->flags & IORING_MEM_REGION_TYPE_USER)
-		ret = io_region_pin_pages(mr, reg);
+		ret = io_region_pin_pages(mr, reg, ctx->user);
 	else
-		ret = io_region_allocate_pages(mr, reg, mmap_offset, ctx->user);
+		ret = io_region_allocate_pages(mr, reg, mmap_offset);
 	if (ret)
 		goto out_free;
 
-- 
Jens Axboe
