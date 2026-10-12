Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CFC45D921
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805403; cv=none; b=BwYnmYm6mUdTCOGJU2sV0mQT4Q0GlpYBQNdmgXPALoJLNfOTA/ZerNfM7eBpEND/g2Vn6N2pC2bL/d6ejnv0sPplzBE7/2jh6GFXqV+zF3rwL6RCz7VUFYedBbPwRgS2KnGISfx0m8h8BJALbEaq5smbxGwdWWJ0BRdPyh/l0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805403; c=relaxed/simple;
	bh=9hLGw+vC1NxsGvQcb4+L9MgzWu8rpVYS9YHDP6ePl3A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sEbsP5PI9AwL8UJ/Jch61p7FzdgdCePj05rdzVWqn4/jzHSwRAqvIy8kTBbfNDBuNvNXMYMnp/1B589HTp71DjmK2JMUizhKPmTLQ0UVDP+RPtDiuZEF978xCTf1Na9NvnNy60PjhpVo/027ux/5Brnl+lhE5hmPuVcdyQ51Hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/GXAWbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/GXAWbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6E81F0089B;
	Mon, 12 Oct 2026 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791805399;
	bh=ExzB+ixlnqqvKmdv1xsxH/8YKZsci6eYQfdQu8U+W/c=;
	h=Subject:To:Cc:From:Date;
	b=z/GXAWbgf0xpdnyNxT9/MthxQeF0+v5YYaFjqx7MDDlnLC6o20g4kcPINW2H6g1Xv
	 X64OQVRT2vvOlVWCXQ7EdBR8/UulT8uqv1Abfo3IZGjq6+IW5DIEwJXFf2Xaonfq/y
	 i8xyW0QjpeenyAx+i+uqwdLw8fXCtpwvdC0SfNH8=
Subject: FAILED: patch "[PATCH] io_uring: do not charge the SQ/CQ rings to RLIMIT_MEMLOCK" failed to apply to 7.2-stable tree
To: hengyul@cs.unc.edu,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 13:43:24 +0200
Message-ID: <2026101224-backroom-send-7931@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x b59cabf9b4acb65f3f9968087ca0e18010d85076
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101224-backroom-send-7931@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b59cabf9b4acb65f3f9968087ca0e18010d85076 Mon Sep 17 00:00:00 2001
From: Hengyu Liang <hengyul@cs.unc.edu>
Date: Tue, 6 Oct 2026 08:57:32 -0400
Subject: [PATCH] io_uring: do not charge the SQ/CQ rings to RLIMIT_MEMLOCK

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

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c2ce83c7c1f1..79c40e0abf17 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2070,8 +2070,9 @@ int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
 
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
@@ -2735,7 +2736,8 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 		rd.user_addr = p->cq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &ctx->ring_region, &rd, IORING_OFF_CQ_RING);
+	/* ring memory is not charged to RLIMIT_MEMLOCK, hence no user */
+	ret = io_create_region(NULL, &ctx->ring_region, &rd, IORING_OFF_CQ_RING);
 	if (ret)
 		return ret;
 	ctx->rings = rings = io_region_get_ptr(&ctx->ring_region);
@@ -2749,7 +2751,7 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 		rd.user_addr = p->sq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &ctx->sq_region, &rd, IORING_OFF_SQES);
+	ret = io_create_region(NULL, &ctx->sq_region, &rd, IORING_OFF_SQES);
 	if (ret) {
 		io_rings_free(ctx);
 		return ret;
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 7c309173dd19..7c59ab9cfc8b 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -676,7 +676,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = reg.ring_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &bl->region, &rd, mmap_offset);
+	ret = io_create_region(ctx->user, &bl->region, &rd, mmap_offset);
 	if (ret)
 		goto fail;
 	br = io_region_get_ptr(&bl->region);
diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index 48c0eb012412..d4d716946971 100644
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
index f4cfbb6b9a1f..0714bb5a9616 100644
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
index 02bc103bcc9d..d11a53d68431 100644
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
index beb35077f3ce..939885985333 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -432,7 +432,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
 	mmap_offset += (u64)id << IORING_OFF_ZCRX_SHIFT;
 
-	ret = io_create_region(ctx, &ifq->rq_region, rd, mmap_offset);
+	ret = io_create_region(ctx->user, &ifq->rq_region, rd, mmap_offset);
 	if (ret < 0)
 		return ret;
 

