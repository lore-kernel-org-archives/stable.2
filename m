Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341262;
	b=r96hh3pyXmK4WRkxaWDgiN2T0sXil/XA86L4Mse+a055GYqnPKWNZK9aP2DaQVRdfTVM
	 Vmxek7kEe9+fbkFpLkDxHY/1pwEPNut8pF79ZISliJqHFDhcy/KdzUhfEUdrtXng1NMEc
	 Fw2BOpiYCSJcWEAtk8dtMFDvXOJlhhRYwK/4BR3eIoyFGYSeL+Ezog0DXEl9XjpKlRYwp
	 fHfRj02e4HjAhajXuYApvbFLon5utW/bNwEEPNhekg+Amspzp6e2JGaLclAdZIgxW2zgo
	 ews7I3WJtcGlooPhl8amELqnH9xle0EqVPP8myMvvNMnmuHxtQH3Lh365GueJyZD2YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341262;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CjznWCSnq6LPvTATsAMpi6vVwQ2Jnpc+YmEv4715Rac=;
	b=qzPB6h+ZSZuhpFLIA+LwKyCSP4DIOstQYtP4yO/XE1PsqTRIgTlnw6CFNLbPsT2sa7Mn
	 BGiAGfcuJEKWpMuOztpg9KfQ79o+63VbV/uYFWqmuotPpDgVeMcqsG5cUIAh864GLM1Qy
	 KBZIo5pQ/iSh6iDQpIOuTkGg7dcgfJAFT8bDzqW/0IqjLb+pw8TdLBdgT2YPj8fL0sNtk
	 4qWJjGQL3hcgPGR+4lntO+EAEl9HFHT6ROc6uLNQ8hVi5NEXzglTR2IxYQgR3ucHiG0jz
	 Xq1zWI7UgqFdFpOjUKmzZqEnIJ9iK/Gw2cvK/OTlaE0Pasbd4LzGilcMC0+egYPqxsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnEX7tDa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68335606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnEX7tDa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBDE1F008A1;
	Tue, 10 Nov 2026 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341262;
	bh=CjznWCSnq6LPvTATsAMpi6vVwQ2Jnpc+YmEv4715Rac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TnEX7tDamh9ClBCJMRniHkViYOC5/aZtG1XwTp8wxqfrNGVb7Bckqw55y3BSV3ZFi
	 awgXoWCtRP6+/ZmacAQdVc2o28lNtG1FjqQ1xV/VgXDvIDFmTJObkzCy9L5yrVDkO8
	 yZaUfgefIMrXrAwYKhcq/9ywLVfXUlkJubOdONlw9ev/lGMLqt1cmJOpK+VQbOVaTU
	 Q0jZGDk1IuBsdbxji08q4M7LDKLof7P/xD/kQfbBFLG2xauFRehGNfrCQ/B59mnkzC
	 K/RX4VPlCqbIRoDEG4s33/f3lwLSPTHvZ61/yAgG7Qg/wjNDKrFRM4vooDdPFDTDnM
	 sL4qmEbtUmYhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] iomap: don't lose a failed direct I/O bio's error when zeroing the tail
Date: Tue, 10 Nov 2026 15:07:38 -0500
Message-ID: <20261110200645.3703693-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110200645.3703693-1-sashal@kernel.org>
References: <20261107051102-failed-6.18-a9fd24bcbe69@kernel.org>
 <20261110200645.3703693-1-sashal@kernel.org>
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

From: Andrea Parri <parri.andrea@gmail.com>

[ Upstream commit a9fd24bcbe690ed4a5b8ea6a7516fa297fae9360 ]

iomap_dio_bio_iter() falls through to the sub-block tail zeroing when
the data bio submission fails, so that the rest of the block is still
zeroed and stale data is not exposed.  The zeroing result was assigned
to ret, which overwrote the submission error with the successful
zeroing result (zero) and the failed write was reported as success.

iomap_dio_zero() can only return an error from a can't-happen
WARN_ON_ONCE() (nr_vecs exceeding BIO_MAX_VECS, which the existing
comment there says "shall never be reached" for any in-tree
filesystem), so it isn't a real runtime failure worth reporting to
userspace, let alone one worth losing the actual submission error for.
Make iomap_dio_zero() return void and drop the error handling at both
call sites instead of threading the result through a separate
variable.

Fixes: 10553a91652d ("iomap: fix iomap_dio_zero() for fs bs > system page size")
Cc: stable@vger.kernel.org # v6.12
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Link: https://patch.msgid.link/0cbce1012f5333690be36a9adafb3e190fe2ca77.1790342457.git.parri.andrea@gmail.com
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/direct-io.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5a97614507530..4301145674259 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -284,7 +284,7 @@ u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
 	return vec_count;
 }
 
-static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
+static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		loff_t pos, unsigned len)
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
@@ -293,14 +293,14 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	int nr_vecs = max(1, i_blocksize(inode) / folio_size(zero_folio));
 
 	if (!len)
-		return 0;
+		return;
 
 	/*
 	 * This limit shall never be reached as most filesystems have a
 	 * maximum blocksize of 64k.
 	 */
 	if (WARN_ON_ONCE(nr_vecs > BIO_MAX_VECS))
-		return -EINVAL;
+		return;
 
 	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs,
 				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
@@ -317,8 +317,6 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		len -= io_len;
 	}
 	iomap_dio_submit_bio(iter, dio, bio, pos);
-
-	return 0;
 }
 
 /*
@@ -424,10 +422,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
 		pad = pos & (fs_block_size - 1);
-
-		ret = iomap_dio_zero(iter, dio, pos - pad, pad);
-		if (ret)
-			goto out;
+		iomap_dio_zero(iter, dio, pos - pad, pad);
 	}
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
@@ -509,8 +504,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		/* zero out from the end of the write to the end of the block */
 		pad = pos & (fs_block_size - 1);
 		if (pad)
-			ret = iomap_dio_zero(iter, dio, pos,
-					     fs_block_size - pad);
+			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
 	}
 out:
 	/* Undo iter limitation to current extent */
-- 
2.53.0

