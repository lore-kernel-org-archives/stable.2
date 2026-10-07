Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616641D10D
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791409151; cv=none; b=oMppkQdDPaP53KY70j1tW6HodYf2kER1bacpuu3hkw564NR60LFFKax/gScnTnkfP2GiDy9O01tKvqW8cp0GUfUVo8cV+dfwb2xy0FW0zIuvfMIVu75Tc2zszLvGHRCCTGXnm/p8MjKMHFqnVno2icdYnslYkJU10y0uZPZZiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791409151; c=relaxed/simple;
	bh=bHNxYkdJPMV0c3mCbJm/KxAgtbUiUhtBx/89itrM5O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7kTBCyrZKQt5Ztpe7NAf/CFWdkVXEQy+4SuqLbSMs5WekOjP2PVKO7Oen8KRODvsJmARNoa93XDscd/i93kXaCBr6gFmEDQcVDjt7M/sj0ldoY9feiMztfUFS9tVT6dalzCQyNNp1e2J1p0I26AXZBDc1fiUdFhL4K6JqJnXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=VN6al5ag; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="VN6al5ag"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1438d9363fbso1664961c88.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791409149; x=1792013949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Nns8aiPTfaF/h+f4iU4OgWV4cRfzK2BO0PwfYSOV3A=;
        b=VN6al5agIh8nUeBPBCSenhQGXlu6drM6Dn17hp2oz3Ldy5FANsdNIuL+hWtlx/qZiZ
         zmbosS0MDCsVNNSW3I9F3H/gt/lbpZOU9iX8DF9YQ3fMIjCy8v+kT0XWgHsgFYvi5B+d
         BRtxfjLuXwKCuvS32AARerxSy2J+gWAaC1575C6K0j4BX3ZUXN/l5NdJHjzCd3d5iH8/
         u6GtKjNL4ADWUnbgAeA8pMneEUR1Lx5172hpKDHVNAGnTvsghK/zLv/oCVnJQKhnZgAG
         bJiC6d+h6V0K2VTwW7au/B7KsF8yK0v2+QfP9HYDrYpFbK/4qnHstfRc6iXfcpHWrIhT
         FZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791409149; x=1792013949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Nns8aiPTfaF/h+f4iU4OgWV4cRfzK2BO0PwfYSOV3A=;
        b=Onj1eDVHx+oW7D4hiNQRrzLu24U2BNVYK8ves7gEABgEm0LANy5hcYJPY9StQJCJqx
         jkmuB6KblQcSfJCTjOOQEy30CtIZAWuUWLOaLSdCjjjSMsD87bssabS/e3dlJApSWsMH
         sJJE+NG8khlsto5RCbxFJwGUJ5BcOFHIm32mEpx9Nydn5NuSEVJtZW3DhCsiMtkcd71A
         1wBlNUaXqFrNQKXi2ZpuV51C7w4c4tq+dO2M+NA6JZ6N4W1z5GK3DEfLz+1UippdxR0T
         +gnfsa6f7fAmVJFoN/E1L/gwz0oSEteBOBQ22hkw0JVK+6sHFaDLA5FCQEXzHaYZJGvU
         sqjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQ8MBDk+MHphNJKNijhVukFUhdpCBWmolSsRDIMlw9nLypVsmdgFHQ2JUVeHNmOeKaK0kZOTo=@vger.kernel.org
X-Gm-Message-State: AFuF++nNvriAKFOkQ/kEiHeilKQd7FmcaUKTcIDfC0R3fv0JxeupkFG8
	ic7HkWkUqVQCptB2sy77T1rX2B/XeNyrMjL3gkxzQBMC0RwDCUvqa0LUT6vtk+LB2+doIsSzhSu
	jC+ESzQ4=
X-Gm-Gg: AYBFou1HhFnzqTBracWv4MPhxoGXPUCACjqsi/tj6ujtBo56WsgGBeVQRATQ5C0dBu/
	w2AYCGaw2WSx51p9ccgUheAMAh4POQPbUIHbX1NOveNVULBK8uyku8ndj7L1h3W5QUXiZ52qhpW
	FlmyfBEsj3ahrqODqU3Jv+qw4NZVlwTDy0owc8s2lWB8A0e61xCnhS7M3yO/Eerbnau/7q0iRB4
	tEcmK49tcPoVT8J2prHZR2bxfIZNx/FVX+dhV8+SfkcWE6haW1/yaQFh1EqZenWJiZhi1ggkU4S
	zcL5CH1iv0DZ2Enuz/Do2jhzFeoJxDKcoDQ+7WUzeA/gCvSLdzkADa7oPyqVSU0jSjwAnKuwZZC
	9acegvt2xG+zwCiIHx+zQiKNov6ydnH8qhHROOpGGCcljljv1QQTWJRmkJ8AjLNhpUwNkzbxgJJ
	oKoncjMTV1xkYXPgCETM3S4A4YQ4kMWqEPmtfvVc6ajZaWINhB+oSSlbtBjiqcXdeVacObugJTx
	OhbFp+x5PdqKmLGvNWxg5XQqmW0fxZaAZos0OATMq56KEutI/qzwiI=
X-Received: by 2002:a05:7022:522:b0:143:1bb1:3305 with SMTP id a92af1059eb24-165a887c9cfmr785296c88.22.1791409148978;
        Wed, 07 Oct 2026 14:39:08 -0700 (PDT)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616602b33asm8788217c88.3.2026.10.07.14.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 14:39:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: dw@davidwei.uk,
	hengyul@cs.unc.edu,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring/memmap: only charge pinned user memory to RLIMIT_MEMLOCK
Date: Wed,  7 Oct 2026 15:38:57 -0600
Message-ID: <20261007213903.445430-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007213903.445430-1-axboe@kernel.dk>
References: <20261007213903.445430-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_create_region() charges every region to RLIMIT_MEMLOCK. This was
correct when the only region type was the user provided parameter region, but the SQ/CQ
rings and provided buffer rings have since been converted to regions as
well. Those we have tradionally excluded from that. Kernel allocated
ring memory is memcg accounted, and never counted against the memlock
limit. Since 6.14 an unprivileged user runs out of the 8MB default after
a couple of dozen rings.

Charge RLIMIT_MEMLOCK only for regions backed by pinned user memory, which
is what the limit is for, and leave kernel allocations to memcg. User
provided ring memory keeps being charged, it is pinned.

Reported-by: Hengyu Liang <hengyul@cs.unc.edu>
Link: https://lore.kernel.org/io-uring/20261006125732.3425762-1-hengyul@cs.unc.edu/
Fixes: 8078486e1d53 ("io_uring: use region api for SQ")
Fixes: 81a4058e0cd0 ("io_uring: use region api for CQ")
Fixes: ef62de3c4ad5 ("io_uring/kbuf: use region api for pbuf rings")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/memmap.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index 23e8a85111bc..da2328b52b38 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -105,7 +105,7 @@ void io_free_region(struct user_struct *user, struct io_mapped_region *mr)
 	}
 	if ((mr->flags & IO_REGION_F_VMAP) && mr->ptr)
 		vunmap(mr->ptr);
-	if (mr->nr_pages && user)
+	if ((mr->flags & IO_REGION_F_USER_PROVIDED) && user)
 		__io_unaccount_mem(user, mr->nr_pages);
 
 	memset(mr, 0, sizeof(*mr));
@@ -132,11 +132,12 @@ static int io_region_init_ptr(struct io_mapped_region *mr)
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
@@ -144,6 +145,16 @@ static int io_region_pin_pages(struct io_mapped_region *mr,
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
@@ -207,15 +218,14 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
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
 		ret = io_region_allocate_pages(mr, reg, mmap_offset);
 	if (ret)
-- 
2.55.0

