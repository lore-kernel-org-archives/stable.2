Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D8407CD3
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231730; cv=none; b=lODyCKbsCN02TiLmld+Ck2wcVd6PuUN59EBhVt7ajzdQIP2schmIV2dhdgVOj3DHcnQZHRvJkaRYNeymzBpxuaQdY8SKtILqiRtQ/xTupolG5YfnBvOtd1HzO3DVkI1xoqt8bD2TowSbwv0xlW8o5cgIXXeJGyoFRoa7eBwGpsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231730; c=relaxed/simple;
	bh=3AbSrUMjHcNwweoxrwa7fSRqHGF8abFFrjw6zZ2hhhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+pThKpHff3fUTE1wweBBn2poaNSUGRktVDZYqWQuLy8koDnxf9VYr5BhmEZ18LYY7WWG555Kunup043wcxpj94EwPgmSwaKLsdLiksM5n+Np5OSd30hg1P3O5PTz86NDmd7+0JyFdnM//GwqbjcpJVbE9nkWii4qD+4qjoVlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=paYQdgj0; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paYQdgj0"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso686490a91.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790231728; x=1790836528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+Sroy11/gckPEHKGdrfw2wtlJa78votk3/kT41m3uM=;
        b=paYQdgj0OqOiVoA72matpo3XrEJfsv0Yqn/gK67ht3wNXyPpWZkmpmmolS7gNNucQx
         apUcDgLuL0iffLZCGUCXGMlgfc+pe+bTnivKU2UVsjPeErXeGB6qmIBfOD/ZeY0t8Y1L
         /TOS6liN4OMOF5ODGD7aKAKgJouGaSoxehG4UaHHo4RFOcJgr0mjMvMHwikmtoIXlNV3
         BjdnDS460dtiZti50VtPzH5spG74SBh4Bp09Pydl396tcjfJyEnY8QoruqGeU2JPoThG
         iIUE2jWpFH43joVaNrtrc70sEPCQks09fPiTDYg5W7QNl8CPSwzJaq9vF6V7v8u/5Chu
         zFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790231728; x=1790836528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F+Sroy11/gckPEHKGdrfw2wtlJa78votk3/kT41m3uM=;
        b=m8CeTIBbrOhEw8O1ZbXoK6ZrMkUXhHsgZigDJ1XUYA9G5mLaRk+ZV/xDZcP2XG1eIp
         nDM9zwFCJANTNUCQU+rjjtdYW/Yod12J6VVfc+4P+Ec0ATNLs6u/XGNUOYambavD0z0k
         ywRGoeIdVpbdsN8g0WdxYyaYOH+ZaIMj1YQw28zr4im2sFtMDUgoVxk5Va8lVNpV/mYe
         jA4rkIWUtt078qUKQNshmcJeAlYQ/sZptKXCgAufW34EG89x8w7ak3jAvwKu/OPCHNbM
         RYlPdjXfCyTFPgxUL48brTcbU1tdUEaBaxStpRo6r2Hkl6VGoh+w2YnVlIkiEhuwBQBe
         EF9g==
X-Forwarded-Encrypted: i=1; AKwUvByelaK9fojza5IhgSOrvjOE2pyTbanLLhZyh0mvPab1c43zMUVYZr6cH54lpaOxjjRdrq6IYXc=@vger.kernel.org
X-Gm-Message-State: AFuF++kXA9XjSkiZ/asaqAh7AYh+XXIA66wJo/4VY+CWAqftR/Vy+9M8
	HAIc0m4CpUHHkevfO3YZMcl6vFI4mKCK23g5+oeD16mqbpu3KYiA0JiO
X-Gm-Gg: AYBFou21evQTpC57N0JfAHVbANnodBmHPq5jtR2Hb+jRbxsFE0TQW5TZstZSXacrCdr
	jP08+vuBic+bi2ASfjjEBFAIMsCdqnayWvHq48W8y0moHxiLFgsoeQMKl9jXGoGre9Zm14mAncz
	Rg6oHj8aELTU22pmFVsbWdIp11vWCI5xe8VJCJ9YUUW2vM919J/iLxE+PoXh8z00cZ8A6qk48AX
	M++a6r5guuY5TlUhtfod/yPwoHpuUoeqMfIgQaODwYCxMHp1RBI8ExUFVXes70z0oDw54TTAS9k
	8m98ddhbOK/1quF++E4brgIbZ3mY+PFHPdWkC93OfKMvpKLBDD0bL4Ki91akKpJ+gAcRhc69+Pq
	5mlPE49spaOfYDkU2b+eFdRJtANvoJFcACBaTLIvCWLiJSwn/qkbedxZEAVHiTsmkc66RRmOgWk
	PxDW2LQxxi4Md27u0fp/F8Mzu331jRDqO5Zn73j789/7nZ8mzV18GOV9UwGM1283UYehOQ+1BVK
	NfDs+dhfKdym+8rAZRlWtc/fyXQFEXm7W7SKYJc5md/sV7tNFstF2jJn+S3pK4Mi0WDPga6R0Qh
	RUpKhW9HiA==
X-Received: by 2002:a17:90a:d2ce:b0:3a0:797b:443e with SMTP id 98e67ed59e1d1-3a0986084f2mr943846a91.3.1790231727654;
        Wed, 23 Sep 2026 23:35:27 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a096b8753csm3109897a91.0.2026.09.23.23.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:35:27 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 1/2] io_uring: only insert skip CQE for IORING_SETUP_CQE_MIXED
Date: Thu, 24 Sep 2026 06:35:24 +0000
Message-ID: <20260924063525.2500081-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924063525.2500081-1-benquike@gmail.com>
References: <20260919203516.2581409-1-benquike@gmail.com>
 <20260924063525.2500081-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In io_cqe_cache_refill(), when cqe32 is set and off + 1 == ctx->cq_entries,
a dummy CQE with IORING_CQE_F_SKIP is written at the last slot of the CQ
ring and cached_cq_tail is incremented so that a 32-byte CQE in a mixed
ring (IORING_SETUP_CQE_MIXED) does not wrap across the end of the 16-byte
slot array.

However, on a pure IORING_SETUP_CQE32 ring (where every ring entry is
already 32 bytes wide and indexed by << 1), inserting a skip CQE and
incrementing cached_cq_tail writes IORING_CQE_F_SKIP into the middle of
rings->cqes and advances cached_cq_tail by an extra slot.

Restrict the skip CQE insertion in io_cqe_cache_refill() to rings with
IORING_SETUP_CQE_MIXED set.

Tested in QEMU against Linux 7.3.0-rc3 on a 4-entry pure
IORING_SETUP_CQE32 ring (where every entry is 32 bytes wide): on the
unfixed kernel, when posting a 32-byte CQE at off + 1 == 4,
io_cqe_cache_refill() wrote a bogus skip CQE at slot 3 and incremented
cached_cq_tail by an extra slot, corrupting the ring index sequence;
whereas with this fix applied, skip CQE insertion is skipped on pure
IORING_SETUP_CQE32 rings, preserving exact 32-byte alignment and sequence
order.

Fixes: e26dca67fde1 ("io_uring: add support for IORING_SETUP_CQE_MIXED")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 1/2 as requested by Jens Axboe.
- Added testing details in QEMU on pure IORING_SETUP_CQE32 rings.

 io_uring/io_uring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 61053421d809..ae7c77158c58 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -733,7 +733,8 @@ bool io_cqe_cache_refill(struct io_ring_ctx *ctx, bool overflow, bool cqe32)
 	 * Post dummy CQE if a 32b CQE is needed and there's only room for a
 	 * 16b CQE before the ring wraps.
 	 */
-	if (cqe32 && off + 1 == ctx->cq_entries) {
+	if (cqe32 && (ctx->flags & IORING_SETUP_CQE_MIXED) &&
+	    off + 1 == ctx->cq_entries) {
 		if (!io_fill_nop_cqe(ctx, off))
 			return false;
 		off = 0;
-- 
2.55.0.1082.g2b9226bbc0-goog
