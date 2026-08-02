Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7021A6835;
	Sun,  2 Aug 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688251; cv=pass; b=DjAXnOGExFAkzVXOBjW1xSa4wGo4VE3MhVFTlwFP/KDhRqPUOJohpd9wYu+AwRxXcxQNVLX2U2DzfPLoEyXhr3NuLxuHpu37rIbxgFeJ6s/uyhtFBPx3o6xgNrfsdwgPJK5u1MkEb9Zjx3KLPSMUn7vGkaUxVTYwgBNbxt5TR8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688251; c=relaxed/simple;
	bh=IIqcdcwsb7eDGa6O8l8DpR2MXh+6bFT1i6vAttWb1IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmmYwM/sLrAW4t2VocpL7lkN17D/4lJa+vF9Ded86DiLx6aatjep57jYoP741Q33LWWmFSIvbOm89J5ZvYPGHYRtSvMyShR4t4WlBE4bj+egIJuAQGun4Fd9gBQn107hmTYOdWPJZiB5NV8mFreU7e4ZqOmGr44TvImNF3e7ENE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=bMQhJHBy; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="bMQhJHBy"
ARC-Seal: i=1; a=rsa-sha256; t=1785688243; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=gtsBCEDix2ghWbg4DMGRJgrlAb0Z93+qiA3AzdisWSGz+hsou/RMKeakqEGQ4meY48uFjQKeTajtyPEZIzESB/OAaJwyVKDmjVG3bOw0F9Y5wFx0M+LwVVZAt57TlJZ+GIZICNm5PM4u1RCrRIuvBd5CetFcsNAyAYkiw5KC5QY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785688243; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nU1Z95+gk9dRhafpeF1DEv/I8ORcf0JCmcJz2aOPaRo=; 
	b=JM3WHkBY/nYzLF/TbsHnxaSQPqo654iVq43cSsaOphbeB3JJ1xj8MBu6DYH7KaXiY+9RoYfu13dQI2nzNRO46xN7g9NbkAWRe3QrQIMSNbV2Z1Ku9i4+XTlTOH7i+Ui/5QXQ0z7NpG0B9/x+bCXWsCkYPUTjM36GD7ruWvMiqAY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785688243;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nU1Z95+gk9dRhafpeF1DEv/I8ORcf0JCmcJz2aOPaRo=;
	b=bMQhJHByiFtHQr0jegHK5qOPZfeszs0lLCZfAvVyMrEJIz2xOJpBO6J8ljqOlpM2
	AB/WVLi9TWD5yPfrTH6DU6NV5JgCpqPgTW8kSes3QTOnJ47lFYQKcEhCCfRHFoi3QNV
	JhzoyOpL4vJKqXsFmc3gWwxitlnl0IkXBoPbEnDI=
Received: by mx.zoho.eu with SMTPS id 1785688240959435.0495173337787;
	Sun, 2 Aug 2026 18:30:40 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] io_uring/rsrc: fix folio size overflow in io_vec_fill_bvec()
Date: Sun,  2 Aug 2026 16:30:30 +0000
Message-ID: <20260802163030.51005-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

io_vec_fill_bvec() computes the folio size with a plain int 1:

	unsigned long folio_size = 1 << imu->folio_shift;

imu->folio_shift is unsigned int and comes from folio_shift() of the
folio backing the registered buffer, so it can be 32 or more on a 64 bit
kernel. Shifting int 1 that far is undefined, and on x86 and arm64 the
count is taken modulo 32, so a shift of 34 yields 4 rather than 16G.
Every other folio_shift shift in this file already uses 1UL.

The result is that the segment estimate and the fill loop disagree.
io_estimate_bvec_size() sizes the bvec array with the real shift:

	max_segs += (iov[i].iov_len >> shift) + 2;

so a 1M iovec on a 16G folio is charged 2 segments, while
io_vec_fill_bvec() then walks the same iovec in folio_size chunks of 4
bytes and writes res_bvec[bvec_idx] a quarter of a million times, past
the end of the array it was given. src_bvec is advanced once per
iteration as well, so imu->bvec is read past its end at the same time.
validate_fixed_range() only checks that the range is inside the
registered buffer and does not bound the segment count.

Reaching it needs a folio with a shift of at least 32, which means a
gigantic hugetlb page: 16G on arm64 with 64K pages, where
CONT_PMD_SHIFT is 34 and hugetlb_add_hstate(CONT_PMD_SHIFT - PAGE_SHIFT)
registers that size, and likewise on powerpc. x86_64 tops out at 1G, so
a shift of 30, which still fits in int and is unaffected.

Use 1UL, as the rest of the file does.

Fixes: 9ef4cbbcb4ac ("io_uring: add infra for importing vectored reg buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
Found by reading, not from a crash. I do not have a machine that can hold
a 16G gigantic page, so I have not run this path with a folio_shift of 34
and the out of bounds write is derived rather than observed. What I did
check in the tree:

  - imu->folio_shift is set from folio_shift() of the coalesced folio in
    io_check_coalesce_buffer(), so it is the real folio order plus
    PAGE_SHIFT and is not clamped anywhere
  - on arm64 with 64K pages ARM64_CONT_PMD_SHIFT is 5 and PMD_SHIFT is 29,
    so CONT_PMD_SHIFT is 34, and arm64_hugetlb_init() calls
    hugetlb_add_hstate(CONT_PMD_SHIFT - PAGE_SHIFT), which is order 18;
    order 18 plus PAGE_SHIFT 16 gives folio_shift 34
  - the four other folio_shift shifts in this file, at the folio_size
    check in io_check_coalesce_buffer(), the bvec fill in
    io_sqe_buffer_register(), and the folio_mask in io_import_fixed(),
    all already use 1UL
  - the only other variable shifts of a plain 1 in io_uring/ are on
    ITER_DEST, ITER_SOURCE and rq_data_dir(), which are 0 or 1

Happy to put together a forced folio_shift reproducer under KASAN if that
would be more useful than the reasoning above.

 io_uring/rsrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 8d0f2ee24e0c..deb2a844f568 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1477,7 +1477,7 @@ static int io_vec_fill_bvec(int ddir, struct iov_iter *iter,
 				struct iovec *iovec, unsigned nr_iovs,
 				struct iou_vec *vec)
 {
-	unsigned long folio_size = 1 << imu->folio_shift;
+	unsigned long folio_size = 1UL << imu->folio_shift;
 	unsigned long folio_mask = folio_size - 1;
 	struct bio_vec *res_bvec = vec->bvec;
 	size_t total_len = 0;

base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952
-- 
2.55.0

