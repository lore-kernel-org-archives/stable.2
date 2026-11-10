Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342027;
	b=mVIKEAqdDw2FfO3jQCR2AQA3emsweassCenf13OMxp8P6H/BYETocHM1Yp3IfKNohSvo
	 29/Zzmhw2mNBMhPhw67C+BG9yltZA0+rxDIJ3XIVRzTD3irYcpy5U7ezf72GPvffyCVIU
	 s5Khg8ZhD3p7k5E6l0hKi707Tj+v9VSbAUs5v5tCKy545zVPcSFsVICdsAgRSZ950LKMC
	 OB5yzWbVWK4aTvSxdwFwVivvpYatEZ0wpxoOReTrZ4ozTiyVOOtJlvDD0K5tlIr2ZlGzI
	 04bo4quVOUTb/yLCvi25B5tYhAZE8asr1rfPMA82/MG1gZvET9egFWD0ouAjF5OTWDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342027;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PWTa5xUWX+lVVzpz8UgdQ/NNsoHA9iSHd6OnUDTMkM8=;
	b=f6jyF1oBmJtBMY+L3AdnBFbxbwNVJAUY5yczvBoKx06qNDdHrX2uCJSjQqzO2NttPmKQ
	 iExlBxV6fECJ5OYRjK+JVcAhwskPbauaBEWY83fJjXBaS8Vfz+9u7Symjqs/XEFLe/fY1
	 x2Z4Cj61BXyCaUE244zGpU2eEIauoZOqZs66J7+1lufj4Hk6Im907EIjIwyPJiLgWTsBu
	 izlKUCMt0/ZwbGWxtQNL6xjCTe0FAm9FjCK5cv41uPhkIjnAaDPKw9rBKLZ1qS7vSLOZ4
	 pIhsB7WRckKXac7LC58+QGNazzjY2cWte5AzZSCiX2WhxTBVnuNec5XGdHF2TX5Rb0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SevAdsDT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87984606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SevAdsDT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528DB1F0089F;
	Tue, 10 Nov 2026 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342027;
	bh=PWTa5xUWX+lVVzpz8UgdQ/NNsoHA9iSHd6OnUDTMkM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SevAdsDTKhOVTYqQZkt9LhgtSsTxw3TN8aGumamX8AA7k2GvhINY1pVUflGZKiUzE
	 KDYXMvzvpvEK3Bra86ZA7gOc3/XXNUYBeKXgeN/8drW8tzy03j3ZMrs8sLkG16iDl9
	 5+Jb4youmU5jcAKS9qNY5mfDjfPD9NGcNQlj9gbz+lyr4kEFNSrtgXWxkUaKSuwWjG
	 5279ALUoKKSe4h5IueMwZP6eeWzhuDvKh3lYm+x2jkdzYtjYCkugAGOJvZg3W2RWEn
	 6cZOIobKfgpdRPZYJi045HryaKc0cxgY8J0EAUS7Xjr2rofk1joFw1sjIDn1ApMG6T
	 gWL8ZNR8Lz+Ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iomap: don't lose a failed direct I/O bio's error when zeroing the tail
Date: Tue, 10 Nov 2026 15:20:25 -0500
Message-ID: <20261110202007.3738755-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052202-failed-6.12-a9fd24bcbe69@kernel.org>
References: <20261107052202-failed-6.12-a9fd24bcbe69@kernel.org>
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
[ sashal: Adjusted context for the existing 64 KiB zero buffer and length guard instead of the upstream zero folio and vector-count guard. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/direct-io.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c81cfcbb1bb6d..92eb494aa0f0f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -250,19 +250,19 @@ void iomap_dio_bio_end_io(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
-static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
+static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		loff_t pos, unsigned len)
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct bio *bio;
 
 	if (!len)
-		return 0;
+		return;
 	/*
 	 * Max block size supported is 64k
 	 */
 	if (WARN_ON_ONCE(len > IOMAP_ZERO_PAGE_SIZE))
-		return -EINVAL;
+		return;
 
 	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
@@ -273,7 +273,6 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 
 	__bio_add_page(bio, zero_page, len, 0);
 	iomap_dio_submit_bio(iter, dio, bio, pos);
-	return 0;
 }
 
 /*
@@ -382,10 +381,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
 		pad = pos & (fs_block_size - 1);
-
-		ret = iomap_dio_zero(iter, dio, pos - pad, pad);
-		if (ret)
-			goto out;
+		iomap_dio_zero(iter, dio, pos - pad, pad);
 	}
 
 	/*
@@ -463,8 +459,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
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

