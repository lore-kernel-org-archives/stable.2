Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5814A0129
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819563; cv=none; b=qDbukP2vOrXd1DYk45RJlGoq+cOikNqcZG082poDIdYiMj0IeRlF7l9pfGWpDMb2RTBeqrqjGyaKtuDhtI5DVY0I7gHEjtW17jyYslS8Fa4pzX38qceC+muR5GTo5CuHfnSseDKHNBAG2Rx00p+WsDEEPYk18tivxBL9KjjwNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819563; c=relaxed/simple;
	bh=CHamaVSsHF/rN3isaIOapfOCXZZ0XBWR/+ufl0RKS2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVQJHOHbJSvw9x7qNyV9IA1aL5v2h2Lj8mPx2wgAlNGmcRHQH7XzBh3vZQO9GlXkkqV107uuPMOw9uMFgU1Pq6wTVr4cIGr4fvzen9M9Dicq84fUK0LbkZdB/HpJVB9zZBlWYiLgvzK7yNCXwgDjwxUFMD0glJGDRhrNaw46TZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htkrsb/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htkrsb/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D7D1F0089E;
	Mon, 12 Oct 2026 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819561;
	bh=a7ze6ghILih4no2Lq/8/nsXce6xHF0NFd3F6f52JsT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=htkrsb/DsvE+WVThWsi2aMobV88hY+LbOxlGmGjxuRWIPw5NGr4vOZ4QfAZNUv3ct
	 eh1P1ynSli6ulMDAeIBfHdrp/jskhm6123J7lTKH1NU1L8sUhZzIaG7o9UOiXXr/bt
	 +YyYFJmlM0YMF9fhqprgYXGmwu60E57kTz1wkTAzj7mPZpGVzc2QXdgoQ9m6JdYois
	 sBB9Qoe5x8TuMGXIRfLQdE0mgHNo2aCQulBWQ9gA5Z21lf6xbfTgh4gGZ1bJ8Mb181
	 yGwMU9CR1MN8e8HGYGeuENzii7iA55Yu5eelobYd2LCJJd+1WMGu+abf5tT67ABHJa
	 E/4kiA6yNIRPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hengyu Liang <hengyul@cs.unc.edu>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] io_uring: do not charge the SQ/CQ rings to RLIMIT_MEMLOCK
Date: Mon, 12 Oct 2026 11:39:18 -0400
Message-ID: <20261012153857.1014795-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012153857.1014795-1-sashal@kernel.org>
References: <2026101224-backroom-send-7931@gregkh>
 <20261012153857.1014795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengyu Liang <hengyul@cs.unc.edu>

[ Upstream commit b59cabf9b4acb65f3f9968087ca0e18010d85076 ]

Commit 8078486e1d53 ("io_uring: use region api for SQ") and commit
81a4058e0cd0 ("io_uring: use region api for CQ") made io_uring_setup()
allocate the rings with io_create_region().

However, io_create_region() charges the memory to RLIMIT_MEMLOCK, and
the rings had been exempt from that limit since commit 26bfa89e25f4
("io_uring: place ring SQ/CQ arrays under memcg memory limits"). As of
now, a user without CAP_IPC_LOCK gets ENOMEM from io_uring_setup() when
their rings exceed the limit, which is 8 MiB by default. PostgreSQL
developers have already hit this in their io_uring tests [1].

The issue can be reproduced with a simple liburing program, run as an
unprivileged user:

    #include <liburing.h>
    #include <stdio.h>

    int main(void)
    {
            static struct io_uring ring[64];
            int i;

            for (i = 0; i < 64; i++)
                    if (io_uring_queue_init(4096, &ring[i], 0) < 0)
                            break;
            printf("%d rings\n", i);
            return 0;
    }

Before those commits (v6.13), it prints "64 rings". After those commits
(v6.14), it prints "21 rings".

This patch makes io_create_region() take the user to charge, and passes
no user for the SQ/CQ rings.

Link: https://www.postgresql.org/message-id/flat/667f7dcf-404b-4898-a426-57ca6e0617f6@gmail.com [1]
Fixes: 8078486e1d53 ("io_uring: use region api for SQ")
Fixes: 81a4058e0cd0 ("io_uring: use region api for CQ")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
Link: https://lore.kernel.org/io-uring/20261006125732.3425762-1-hengyul@cs.unc.edu/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 10 ++++++----
 io_uring/kbuf.c     |  2 +-
 io_uring/memmap.c   | 10 +++++-----
 io_uring/memmap.h   |  2 +-
 io_uring/register.c | 12 +++++++-----
 io_uring/zcrx.c     |  2 +-
 6 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 1bd294d003031..3d8c8a50fd312 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2077,8 +2077,9 @@ int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
 
 static void io_rings_free(struct io_ring_ctx *ctx)
 {
-	io_free_region(ctx->user, &ctx->sq_region);
-	io_free_region(ctx->user, &ctx->ring_region);
+	/* ring memory is not charged to RLIMIT_MEMLOCK, hence no user */
+	io_free_region(NULL, &ctx->sq_region);
+	io_free_region(NULL, &ctx->ring_region);
 	ctx->rings = NULL;
 	RCU_INIT_POINTER(ctx->rings_rcu, NULL);
 	ctx->sq_sqes = NULL;
@@ -2742,7 +2743,8 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 		rd.user_addr = p->cq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &ctx->ring_region, &rd, IORING_OFF_CQ_RING);
+	/* ring memory is not charged to RLIMIT_MEMLOCK, hence no user */
+	ret = io_create_region(NULL, &ctx->ring_region, &rd, IORING_OFF_CQ_RING);
 	if (ret)
 		return ret;
 	ctx->rings = rings = io_region_get_ptr(&ctx->ring_region);
@@ -2756,7 +2758,7 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 		rd.user_addr = p->sq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &ctx->sq_region, &rd, IORING_OFF_SQES);
+	ret = io_create_region(NULL, &ctx->sq_region, &rd, IORING_OFF_SQES);
 	if (ret) {
 		io_rings_free(ctx);
 		return ret;
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 1cf5be62bb656..d2fb952bb7ab6 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -675,7 +675,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = reg.ring_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &bl->region, &rd, mmap_offset);
+	ret = io_create_region(ctx->user, &bl->region, &rd, mmap_offset);
 	if (ret)
 		goto fail;
 	br = io_region_get_ptr(&bl->region);
diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index 48c0eb0124123..d4d7169469714 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -204,7 +204,7 @@ static int io_region_allocate_pages(struct io_mapped_region *mr,
 	return 0;
 }
 
-int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
+int io_create_region(struct user_struct *user, struct io_mapped_region *mr,
 		     struct io_uring_region_desc *reg,
 		     unsigned long mmap_offset)
 {
@@ -230,8 +230,8 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 		return -EOVERFLOW;
 
 	nr_pages = reg->size >> PAGE_SHIFT;
-	if (ctx->user) {
-		ret = __io_account_mem(ctx->user, nr_pages);
+	if (user) {
+		ret = __io_account_mem(user, nr_pages);
 		if (ret)
 			return ret;
 	}
@@ -240,7 +240,7 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 	if (reg->flags & IORING_MEM_REGION_TYPE_USER)
 		ret = io_region_pin_pages(mr, reg);
 	else
-		ret = io_region_allocate_pages(mr, reg, mmap_offset, ctx->user);
+		ret = io_region_allocate_pages(mr, reg, mmap_offset, user);
 	if (ret)
 		goto out_free;
 
@@ -249,7 +249,7 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 		goto out_free;
 	return 0;
 out_free:
-	io_free_region(ctx->user, mr);
+	io_free_region(user, mr);
 	return ret;
 }
 
diff --git a/io_uring/memmap.h b/io_uring/memmap.h
index f4cfbb6b9a1f4..0714bb5a9616e 100644
--- a/io_uring/memmap.h
+++ b/io_uring/memmap.h
@@ -18,7 +18,7 @@ unsigned long io_uring_get_unmapped_area(struct file *file, unsigned long addr,
 int io_uring_mmap(struct file *file, struct vm_area_struct *vma);
 
 void io_free_region(struct user_struct *user, struct io_mapped_region *mr);
-int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
+int io_create_region(struct user_struct *user, struct io_mapped_region *mr,
 		     struct io_uring_region_desc *reg,
 		     unsigned long mmap_offset);
 
diff --git a/io_uring/register.c b/io_uring/register.c
index d0da8f043dbd4..dab3eb4258dff 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -480,8 +480,9 @@ struct io_ring_ctx_rings {
 static void io_register_free_rings(struct io_ring_ctx *ctx,
 				   struct io_ring_ctx_rings *r)
 {
-	io_free_region(ctx->user, &r->sq_region);
-	io_free_region(ctx->user, &r->ring_region);
+	/* ring memory is not charged to RLIMIT_MEMLOCK, hence no user */
+	io_free_region(NULL, &r->sq_region);
+	io_free_region(NULL, &r->ring_region);
 }
 
 #define swap_old(ctx, o, n, field)		\
@@ -529,7 +530,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = p->cq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &n.ring_region, &rd, IORING_OFF_CQ_RING);
+	ret = io_create_region(NULL, &n.ring_region, &rd, IORING_OFF_CQ_RING);
 	if (ret)
 		return ret;
 
@@ -559,7 +560,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = p->sq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &n.sq_region, &rd, IORING_OFF_SQES);
+	ret = io_create_region(NULL, &n.sq_region, &rd, IORING_OFF_SQES);
 	if (ret) {
 		io_register_free_rings(ctx, &n);
 		return ret;
@@ -730,7 +731,8 @@ static int io_register_mem_region(struct io_ring_ctx *ctx, void __user *uarg)
 	    !(ctx->flags & IORING_SETUP_R_DISABLED))
 		return -EINVAL;
 
-	ret = io_create_region(ctx, &region, &rd, IORING_MAP_OFF_PARAM_REGION);
+	ret = io_create_region(ctx->user, &region, &rd,
+			       IORING_MAP_OFF_PARAM_REGION);
 	if (ret)
 		return ret;
 	if (copy_to_user(rd_uptr, &rd, sizeof(rd))) {
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 1b6832f6e10fa..0a9e8a58b99a1 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -398,7 +398,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
 	mmap_offset += (u64)id << IORING_OFF_ZCRX_SHIFT;
 
-	ret = io_create_region(ctx, &ifq->rq_region, rd, mmap_offset);
+	ret = io_create_region(ctx->user, &ifq->rq_region, rd, mmap_offset);
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

