Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794110267;
	b=AQh0I/CqhlKzWnQnHPe8DsZboLBzAtT/6NzIfj8TwM6eQuXj6l2U0ZYsWhbYnH6MBV6I
	 mm2pPDdZmzVO4ul78uUB8Mfmzc/aFNoTF/7G2/D7V1Lgh4WWPScE53tT+Q8TO3WBfhgPa
	 Hurs+IEwXlArfN8BXKLSPIH4cpYjgB6epFNQUgIUnOMpKxHAupw92sPmSoVkXROREyJYc
	 rKbQ4TUgIDII+YAIpS1rvtB1oK4uW/zYnB760C1dwqNGG/v13q4QI50Jay1ytcCOC65vC
	 vE98CD0qQCag4r52Ep8i5CP4ujLABZYFY5rRaWDOiDsR1nl6benCSDxMFRJSsjg4umA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794110267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OkK1QpsvckPHNGc84sxFzeq342eSeHgHQkCvv2eX4gM=;
	b=KOcfIKshtu+dmpcXL3b8KpZorSVtyFNvkw49WrNh4CYPKmtxrIw9EVbBxdFgpNEEVSKO
	 0U5rCUUM+kxZnBg9NOFDZPoJYB6SKBRjvaOItjS8i37Y40a66xrZcwBGR8Lbt5QZppmhk
	 WFU1mbscj053G7lSYjnyTVzHxpqJc8J1VDEPzSbbK9Kg29Hp3tj/Yi3Rd3qzxeZeHHexH
	 LYB7GsTdu0MeQzIh1Lhr2++RT7lMjGExgtbTt1pIIGTfOw6zRplqKlxmdz1thJx0mPGhU
	 pkKg9lAMqevfHxj7hS773TPP05uYOi9RPIv5LpG1FBgNUNgSOeOjSNC521Ncz9yxrCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c9XlN7+c;
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D2606A31A
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 03:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 366D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c9XlN7+c
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2e96b8bfb43so728065ad.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 19:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794110266; x=1794715066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OkK1QpsvckPHNGc84sxFzeq342eSeHgHQkCvv2eX4gM=;
        b=c9XlN7+c2nzlBcazQqwfohtq9uldQRVdQetLEBph/Kt1Q6bsro8PfVGr4xPLRJiaKn
         62pFwM6bhGTd/UkUVxogwqSrgo7ruBCl/hpB941wwuhZdIUbRvcYYsy309vF1ObdQVtD
         M43fsBi3dSt0AVrSq8B79dSSGh/Vqm2eLh/KutVEs+SS/mQVTuVAniRrI4HqAKM3a0UI
         Ll35q6g7irGijWlyL37FWDwx1PCpJUYSFmqpm1AtoLiATEey4Us0/ZXAlEcK5+TWNGfH
         9TUG6CZqCWKun2y8TRBFHNnQMXit9qafL/pr8jUt1B3fsWeLTj8aj0vVIhAMWagmEz+0
         bnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794110266; x=1794715066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OkK1QpsvckPHNGc84sxFzeq342eSeHgHQkCvv2eX4gM=;
        b=YbL8oPbJ/+5AyrBXGdn6kvfzi7w20PGAQpk4jQqdztAXsXFBHAv0up7oLgUvAYBy8L
         4e/D71GVVRFWfXcbcMvJQI2ZE3h+OOhZJWgInVjqePAQfmZiG9xHxkaoSowiMsgpRYDJ
         bXuzosSL2fZAYL7tvyI4ElLe4iFP8ORBkMGCos2FxVNhOwZRIYRrbgUFKhv4k+KFrJe0
         Gxb++CEap47T+Otsbz5uoYyFW7x71vSoKKKrzDThvsraH+3TgvpU95QCIFAEWaME8K56
         9K3KTwyPqxWu13I6puz9GJ5e0IwKaUITjZ8wjHxqXTML7Dv/ezstHDx7aQa1qLApTEtu
         CKhQ==
X-Gm-Message-State: APuU4Z9HBhiIPjI7zVoIcJs39es9TFP1YXneYK14+XONcq2TuZQomQ/h
	zNB32mFioZMO979NzbleAGKzsYIfssWETXtiFagPYTJbS7fM6Jh5Ms5I/PsmXNjVeng=
X-Gm-Gg: AYBFou1fkUg9FlNrByCnPy3zWSC+WJG7nW4u38YiyLFve3TXM21ciASAHefO9tOOzPi
	HnCWhPQlMt/FbRfJyzp4oTdM2TzmWAkZ39NbyrFgbhPDEXqNN9kFVt314THzWtG/00QbncxP2l+
	LQEU7mGKF9Av8wwTabqp5kGqCEhCA3+qHVPd1s8cQd4cURCLODrS6joEOMK1IxRTFBB/Y5cpAUT
	3eN5pFsaxuBJ7d1LUzAWmnYJ6+R59pE36XFLti6QGFM5DM39ScTE7lxGKB6rJSnLHNxU5cLmkSV
	WedHcXuKfjHo8JXPUKpJ3r/8capf0OCaMgKe1YQUgdlzb1vlO2uLlIZyUJ8LlmgkblTsAcL2ITv
	dZ9p/ZETFiFXON7Xq3R+OtjHb5y+UfcagM0hcFgN7qgwBII9e1XbnSg7jde9cqBrxrMA0ETR8BU
	qXc02eH8cy3/c+fFD020CoSJXoRMAbUaSxn7sJGRR+I965RHKz25BPw9/zBd/LP/PSU+b3Y7c8h
	s/1U2W0v9pJD4kHifPsT1DvifnFz2gFyR1UT/wSertCrpKFOsQepp5ln1A6dGy38KtVEip674Sy
	CVliXQazihvIbreK/Ic9927iAJsklFyN0wtnaw==
X-Received: by 2002:a17:90a:d2cf:b0:3a8:92a3:8baa with SMTP id 98e67ed59e1d1-3b12d301120mr433405a91.27.1794110266353;
        Sat, 07 Nov 2026 19:57:46 -0800 (PST)
Received: from amax.cluster.local ([115.233.223.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101ea0282sm2682749a91.4.2026.11.07.19.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 19:57:46 -0800 (PST)
From: Haocheng Yu <l1za0.sec@gmail.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Haocheng Yu <l1za0.sec@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Tal Zussman <tz2294@columbia.edu>,
	Daehyeon Ko <4ncienth@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7.3.y] block: restore the iterator when rejecting a misaligned bio
Date: Sun,  8 Nov 2026 11:57:27 +0800
Message-Id: <20261108035727.1185657-1-l1za0.sec@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20261107050521-failed-7.3-40d070cbb190@kernel.org>
References: <20261107050521-failed-7.3-40d070cbb190@kernel.org>
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

From: Andrew Morton <akpm@linux-foundation.org>

commit 40d070cbb1906896d6fd65c39722d2411830ed9f upstream.

bio_iov_iter_get_pages() can extract some iovecs before encountering a
misaligned one.  It releases the pages and rejects the entire bio, but
leaves the supplied iterator advanced.

An iomap direct-I/O caller may subsequently reexpand the iterator's
byte count and fall back to buffered I/O.  The reexpanded count then
includes bytes before the iterator's current segment, potentially
causing iterate_iovec() to read beyond the imported iovec array.

In a reproducer using an initial empty iovec followed by 10-byte and
1015-byte segments, writev() returned 1015 instead of 1025 and KASAN
reported an 8-byte read beyond the nine-element iovec allocation.
Saving and restoring the iterator on the rejected-bio path makes
writev() return 1025 and eliminates the KASAN report.

Restore the entire iterator rather than reverting a byte count:
advancing past an empty segment changes its position without consuming
any bytes.

Leave successful and partially accepted bio paths unchanged.

[ Backport to 7.3.y: restore the iterator in the existing inline
  -EINVAL cleanup, as this tree lacks out_release_pages. ]

Fixes: 14b007e17881 ("block: validate user space vectors during extraction")
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Haocheng Yu <l1za0.sec@gmail.com>
Closes: https://lore.kernel.org/20261018081203.2431035-1-l1za0.sec@gmail.com
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Tal Zussman <tz2294@columbia.edu>
Cc: Daehyeon Ko <4ncienth@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hannes Reinecke <hare@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020170250.014BD1F000C9@smtp.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Haocheng Yu <l1za0.sec@gmail.com>
---
 block/bio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index f95b63c0604a..90104e6abbcf 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1285,6 +1285,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 			   unsigned mem_align_mask, unsigned len_align_mask)
 {
 	iov_iter_extraction_t flags = 0;
+	struct iov_iter saved_iter;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
@@ -1303,6 +1304,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
 		flags |= ITER_ALLOW_P2PDMA;
 
+	saved_iter = *iter;
 	do {
 		ssize_t ret;
 
@@ -1320,6 +1322,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 				bio_release_pages(bio, false);
 				bio_clear_flag(bio, BIO_PAGE_PINNED);
 				bio->bi_vcnt = 0;
+				*iter = saved_iter;
 			}
 			if (!bio->bi_vcnt)
 				return ret;
-- 
2.30.2

