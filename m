Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670223;
	b=IcbHCcqJxLLRp7gGSG9EnKcbkQ9t16deldsuiqu+uEEJVD7Q6iCGuHQ8Qx/KJTCaQm3J
	 VQ5r2TS1nGmgx6SiRhkATnj5sBo0hs6uHToZsFCwpxYEyylw5z5dZOWvLtFzj+QVfGzIv
	 pjq2hBLCMrQbYy4jKpA1/GUW+Cek1SZ1ucZb6yVBH6oProTYbVtmkKsSOFCq7wMQZzcql
	 5rRyo9V0ikkzHYBjzkPZ3WnJmSNqtfdMcO74W+uIGi5xr2bH+lhe8LOWrT2Bjf/l5IJ2K
	 /DtfLg3yIv3XGA+l+jx2yNqjSHSL4AsyTK8OjOfEE+I19MzBVc8mVBmunP7jlR4Brng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670223;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7Unv43v/glTonTqKuI639K5Om/qW2p+A7y/QTmNAdjM=;
	b=sCVr5XMtT6TWa5fNInBRKKeDeiwuDuGbOOv4zxZRMuVmosQmPslvdBwVexQp/ZsGcZCn
	 Tug+vMC72pq8giulQC3SIp0zTXOSbFuYJqS6jKNyhnIUTKI9As7ab/rN8brAk8D/6xJaJ
	 AUZ6zUjw8kEv3vSW77o2/0hsyR0aN86GrCjtmlYaZr69MFG/J1idZ9XNQSf5mjy4lkRnD
	 A2uYSXI8bSNa8gerrsycA8v+cwQqVBSn2NqGWKf12uGyIaIEt0hYz5r+XStTgbPA945n3
	 6XJfq26oomRXFNH+pOoPQlWOh12Di6Dre/HFudv1BeXgeZCJVanEleFXxsfguhQQdyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXvY6vzY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968C8606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXvY6vzY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43521F000C4;
	Thu, 26 Nov 2026 05:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795670223;
	bh=7Unv43v/glTonTqKuI639K5Om/qW2p+A7y/QTmNAdjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KXvY6vzYoJ9lPeIDeKHjHi+PJnSgsAahX8G2opLvAXVL3es7RD9krf1D46BAwQzpq
	 o3XKQOCLNhHbLliLxttSn3f8HxAdo8u6W36XwVCJEVgxaFtW0wqkx0s+Samz5qydhj
	 mNvmr6WQOcKaIf7ieawLPUD+1WRtM2dOkdWRWXtpTAy8fP9nNSyqMhp1ar+LNujJGB
	 +JVxRV18Kflf7pJBsQbFjINUoC7/4+Cqqe7TSoquTUswjhlPiuujyZAzcHng7N5f7v
	 6kl0vYpK1aPISE5GLjdlDxvVkpzsgJYwfliKTqanSNXkR0vmRBMnsnmPUKKot3qq/+
	 VdNwneQahb8Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Tejun Heo <tj@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm: fail a REQ_PREFLUSH bio with data when its preflush fails
Date: Thu, 26 Nov 2026 00:17:01 -0500
Message-ID: <20261126051651.2140477-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112518-retype-seldom-2c33@gregkh>
References: <2026112518-retype-seldom-2c33@gregkh>
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

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit e92cd41e8e5ee5616c6c7cd4378661d942f0a7c0 ]

For a bio with REQ_PREFLUSH and data, dm core may send an empty flush
first. If the flush fails, __dm_io_complete() still reissues the bio
without REQ_PREFLUSH and drops the error. When that write succeeds,
the XFS log keeps running and fsync() can return 0.

End the bio with the flush error instead of writing the data, as
blk-mq does.

Fixes: 6a8736d10cb4 ("dm: relax ordering of bio-based flush implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ sashal: Adapted the hunk to the older dm_io_dec_pending() tail, since __dm_io_complete() and requeue_flush_with_data don't exist, by adding !io_error to the inline flush-with-data condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1a6bf13cea9b0..1d0dc2e9a1bc4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -894,7 +894,8 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 		if (io_error == BLK_STS_DM_REQUEUE)
 			return;
 
-		if ((bio->bi_opf & REQ_PREFLUSH) && bio->bi_iter.bi_size) {
+		if ((bio->bi_opf & REQ_PREFLUSH) && bio->bi_iter.bi_size &&
+		    !io_error) {
 			/*
 			 * Preflush done for flush with data, reissue
 			 * without REQ_PREFLUSH.
@@ -902,7 +903,7 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 			bio->bi_opf &= ~REQ_PREFLUSH;
 			queue_io(md, bio);
 		} else {
-			/* done with normal IO or empty flush */
+			/* done with normal IO, empty flush or failed preflush */
 			if (io_error)
 				bio->bi_status = io_error;
 			bio_endio(bio);
-- 
2.53.0

