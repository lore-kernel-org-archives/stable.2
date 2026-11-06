Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930030;
	b=CGUGqnFsvW00yIxJEt1ih+Pne/LdhFjAZnT0v8hzFRc5QPkPqGAuJ90rPoe2RL9qqbLT
	 i1RaGkN17WczfRr4FrQhr36Y/67NddtODa13U9BQDDspUcQlLswJgKVOwB3BsNKaWArw/
	 k3fE8DSMe/lsOzC4OfxhIj4znmT8HhPHlJdJDnL629ETogTpYmBl/yjs0H56OTcfMUU6f
	 F3yW+J5S/Bmy6qoROyD/3N/r0G7lcbZEe7UbGC2U3B9081NqIFz1wvyDBbqpEYlX7XnI3
	 VqSf7STBOdRcfyL1pDoocJ+K1JUFvESplS9GiDsSjBhQukpyrbGZkFRsWDiuv2F5seQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930030;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GoKuRBkWjiLRnZSlHYSEIztZ7rc2aYDjCOkhM0WELmc=;
	b=j+trOoC/LladNOUHUfxFMTOcosJP7PNHI9kQUtZuuTL/nl8DxGgcA8ViOIVQBCZTLKcy
	 wj0viRCJjx/SDXbc0AGxic8nXCgA9kucBVlRZ+u2PgEaChmhnco1mT63WtLmwT5eaIsBM
	 WjnopnbGYPmz/S0fl3BALsdcV9NbNZHdnRFYjZ7DRAetY5Tb7OV/X2A2Zd11apUy2EKtQ
	 yGgGOhwJpj9Dr/3iuAoFYbWu4p0lgPEOlmnFJDm33VNXHzUQXnYCfjwCpn77xoDQSGMW4
	 IIf+xrWc9TGn691HG0T4VTCrBFFYhMAM5kURcePNVxWXM/3ZBshYrksjC6CklieBIBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8TfoD1c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51885606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8TfoD1c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931DA1F0089F;
	Fri,  6 Nov 2026 01:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930030;
	bh=GoKuRBkWjiLRnZSlHYSEIztZ7rc2aYDjCOkhM0WELmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h8TfoD1cOMeokDVKYXkpK7OrJCKm09xEeMKXjkhjGuBhYtdMWqSYpRRQNIYmp1dvh
	 /SQkLjLOhlVKwwoyf/lDxIc3R6aWKzd1FGVV5jYfY8Yx+rGWZkZ5uLZPhBRZ4J92Bh
	 ZbINjGVnU4X0CRtDhodiK6ZPmK3rML+lUWFVHF44nM4hP0FY1/Ml57pt0vBjc+MjfE
	 HAZ8rbNl+RPSHs2A9/Our386YqoWETv88YyElqyF4qPrCwypN9sRRY4NsFwqqPXkAe
	 I1mw3T0XtUsC1CKRsExkRarEOendeaQwG3YeHGsD5Q0J0rnlT7qkL1iPLDudNdbs6r
	 dloFSdU5tThPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] NFS/localio: detect a short read or write before the iterator has moved
Date: Thu,  5 Nov 2026 20:53:47 -0500
Message-ID: <20261106015249.3498940-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110458-dreamt-steering-e6da@gregkh>
References: <2026110458-dreamt-steering-e6da@gregkh>
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

From: Mike Snitzer <snitzer@kernel.org>

[ Upstream commit db3ca539c1142d2c5380c5dbd3154ab7bb1c7d77 ]

nfs_local_call_read() and nfs_local_call_write() issue a misaligned
DIO as up to three segments and must stop at the first short one, or
the next segment lands at the wrong file offset.  They test for that
by comparing the bytes transferred against iov_iter_count() of the
segment, read after read_iter() or write_iter() has advanced the
iterator, when the count is the residual rather than the request:

    before the call:  count == expected
    after the call:   count == expected - status

The test is therefore status < expected - status, and it fires only
when less than half of the segment was transferred.  A short I/O that
covers between 50% and 99% of a segment slips through: the loop moves
on with ki_pos advanced by the short amount, the next segment is
issued at the wrong offset, and the header's byte count is
over-reported to the caller.  A write that slips through also never
sets NFS_CONTEXT_WRITE_SYNC, which is what makes the writes that
follow a short one synchronous.

Take the segment's count before issuing it and compare against that.

This is the same defect that commit 250ec14932d5 ("nfsd: fix
partial-write detection in nfsd_direct_write") fixed in NFSD's version
of this loop.

Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
Fixes: d0497dd27452 ("nfs/localio: backfill missing partial read support for misaligned DIO")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
[ sashal: adapted completion handling to the three-argument nfs_local_pgio_done() helper using force_done ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/localio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 3c5891d3ab897..3138439d19109 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -682,6 +682,8 @@ static void nfs_local_call_read(struct work_struct *work)
 
 	n_iters = atomic_read(&iocb->n_iters);
 	for (int i = 0; i < n_iters ; i++) {
+		size_t expected;
+
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
 			/* Only use AIO completion if DIO-aligned segment is last */
@@ -692,12 +694,14 @@ static void nfs_local_call_read(struct work_struct *work)
 		} else
 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
+		/* read_iter() advances the iterator: measure it beforehand */
+		expected = iov_iter_count(&iocb->iters[i]);
 		save_cred = override_creds(filp->f_cred);
 		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
 		revert_creds(save_cred);
 
 		if (status != -EIOCBQUEUED) {
-			if (unlikely(status >= 0 && status < iocb->iters[i].count))
+			if (unlikely(status >= 0 && (size_t)status < expected))
 				force_done = true; /* Partial read */
 			if (nfs_local_pgio_done(iocb, status, force_done)) {
 				nfs_local_read_iocb_done(iocb);
@@ -878,6 +882,8 @@ static void nfs_local_call_write(struct work_struct *work)
 	file_start_write(filp);
 	n_iters = atomic_read(&iocb->n_iters);
 	for (int i = 0; i < n_iters ; i++) {
+		size_t expected;
+
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
 			/* Only use AIO completion if DIO-aligned segment is last */
@@ -888,12 +894,14 @@ static void nfs_local_call_write(struct work_struct *work)
 		} else
 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
+		/* write_iter() advances the iterator: measure it beforehand */
+		expected = iov_iter_count(&iocb->iters[i]);
 		save_cred = override_creds(filp->f_cred);
 		status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
 		revert_creds(save_cred);
 
 		if (status != -EIOCBQUEUED) {
-			if (unlikely(status >= 0 && status < iocb->iters[i].count))
+			if (unlikely(status >= 0 && (size_t)status < expected))
 				force_done = true; /* Partial write */
 			if (nfs_local_pgio_done(iocb, status, force_done)) {
 				nfs_local_write_iocb_done(iocb);
-- 
2.53.0

