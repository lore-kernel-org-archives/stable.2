Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341261;
	b=0kT954+yFqDzZ3QNQYLDU6BPfesvAhKC31Rh1GaBKiMlWgFJLW5senMBzJ412WCCDG3y
	 EHO3Fg+C2lMFbdayRIsVbsnL32ZQrAKIey3ap+kRhjX+Vn+nrUJqZYByYlbTAs34k3974
	 /XN/R0WTBuGUW9RXRg5holU71S8sniZGQf8XJedDT6Bfr7//qIj/ktfRKrLMb8Mnsgiye
	 WFY220ZeF8lubUzFRsXm2d5TdLAu09dT1oNUJ78z68npSVksfmxeyfgCz8MWznEKEecXD
	 88X1CbxZHVtPjBD9jiOUXM+VY01Pe9+L75EvFEurG65YDzMAPMWdTU/EOC1K969eWzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341261;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NNQobhWjGFIQTWoNMf2cRN1mZCW70dvPVu9+IdieqEY=;
	b=Y7nxGH3mITNK+sSSsbkRL/gDxFRhKBf7qhyGTh4y/QUGyffq8Aq18JkfH/N/FgDRl7wJ
	 co9vaTU9zCTAZCNJ7m67M3LHmmwU9YwOkGhceFC/9UmTtvC1qEQLDpNYZpx0qGVanZh4h
	 QsnIQH7BP1hwbqeEI97iRWlnbxQo1ggIsQMkDUVDhxtkoq1xOOCjqU+l0CwyD9QFe5RSH
	 DEGh3tZS3fyE1UtJutDwdnZ312MXQbqgyaHW3cQEi1k0Hw8JnrzR0pv//IQFE0VQmNNlB
	 t/clMrfWUO8FrBw8KwXDVxcV6ebh9U+s0qsasJ/dKjW1bc6PcAnYp+KcTCKzQJVfITg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bELarJHt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C2606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bELarJHt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB451F0089F;
	Tue, 10 Nov 2026 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341261;
	bh=NNQobhWjGFIQTWoNMf2cRN1mZCW70dvPVu9+IdieqEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bELarJHtCpLvZLWkgdTUJnDzPMcAKSbu/VSfl77E/Bq9ffAKx3RvdTD7a9apLxwVG
	 fqMciw87Jf2x7RPWNjtv+l6BkNfOYy+JqC2ualq3aKYgy2RuwwH4Xs50Z3QX23QP8K
	 t/hm7T0xVzBfrjIv6vaI5ivgmUFLKpwi9UYftACOKYc3xW7BfACkm+LpEYOg1Wo72i
	 eLQUpfYrnszkZ0GwXAVtCsx3ZDhxR4o0iK0Z0WTfZ8AVVS0Y+gU18lnGYd++P+lI7Q
	 8UH78fPzRwNNYqwXhPXxg8We4gvAU8VBnt+SzQ3cH7QZlqAl/EMs5RPg6xh52JpM1s
	 vcbWxxKdbAHlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pankaj Raghav <p.raghav@samsung.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] iomap: use largest_zero_folio() in iomap_dio_zero()
Date: Tue, 10 Nov 2026 15:07:37 -0500
Message-ID: <20261110200645.3703693-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051102-failed-6.18-a9fd24bcbe69@kernel.org>
References: <20261107051102-failed-6.18-a9fd24bcbe69@kernel.org>
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

From: Pankaj Raghav <p.raghav@samsung.com>

[ Upstream commit 10436adf9df60ae73390754b47a4bdebf728529f ]

iomap_dio_zero() uses a custom allocated memory of zeroes for padding
zeroes. This was a temporary solution until there was a way to request a
zero folio that was greater than the PAGE_SIZE.

Use largest_zero_folio() function instead of using the custom allocated
memory of zeroes. There is no guarantee from largest_zero_folio()
function that it will always return a PMD sized folio. Adapt the code so
that it can also work if largest_zero_folio() returns a ZERO_PAGE.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: a9fd24bcbe69 ("iomap: don't lose a failed direct I/O bio's error when zeroing the tail")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/direct-io.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bb276321c9521..5a97614507530 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -24,13 +24,6 @@
 #define IOMAP_DIO_WRITE		(1U << 30)
 #define IOMAP_DIO_DIRTY		(1U << 31)
 
-/*
- * Used for sub block zeroing in iomap_dio_zero()
- */
-#define IOMAP_ZERO_PAGE_SIZE (SZ_64K)
-#define IOMAP_ZERO_PAGE_ORDER (get_order(IOMAP_ZERO_PAGE_SIZE))
-static struct page *zero_page;
-
 struct iomap_dio {
 	struct kiocb		*iocb;
 	const struct iomap_dio_ops *dops;
@@ -296,24 +289,35 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct bio *bio;
+	struct folio *zero_folio = largest_zero_folio();
+	int nr_vecs = max(1, i_blocksize(inode) / folio_size(zero_folio));
 
 	if (!len)
 		return 0;
+
 	/*
-	 * Max block size supported is 64k
+	 * This limit shall never be reached as most filesystems have a
+	 * maximum blocksize of 64k.
 	 */
-	if (WARN_ON_ONCE(len > IOMAP_ZERO_PAGE_SIZE))
+	if (WARN_ON_ONCE(nr_vecs > BIO_MAX_VECS))
 		return -EINVAL;
 
-	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
+	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs,
+				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 				  GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	__bio_add_page(bio, zero_page, len, 0);
+	while (len > 0) {
+		unsigned int io_len = min(len, folio_size(zero_folio));
+
+		bio_add_folio_nofail(bio, zero_folio, io_len, 0);
+		len -= io_len;
+	}
 	iomap_dio_submit_bio(iter, dio, bio, pos);
+
 	return 0;
 }
 
@@ -841,15 +845,3 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	return iomap_dio_complete(dio);
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
-
-static int __init iomap_dio_init(void)
-{
-	zero_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
-				IOMAP_ZERO_PAGE_ORDER);
-
-	if (!zero_page)
-		return -ENOMEM;
-
-	return 0;
-}
-fs_initcall(iomap_dio_init);
-- 
2.53.0

