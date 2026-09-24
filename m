Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40299449ED6
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241188; cv=none; b=DtJn+wMglpB5/Covw8Wbe7HzTpCADk8z62kC720IqnOcCqeiggz/GbgRsxxwOQaPgCrrClDtml9aYsOLJeysVoPwzvSouKKxoHR2v2o4uAHSIQ/HxmXblhzKnJDUGQR5hXqAREq+F/cwRoFvgByTLcsUw5dOfFdnrJoeE29pqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241188; c=relaxed/simple;
	bh=R2v6XIS8rFzH1++61DHzZpR8Odr/UFZzSld3CIqALtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khWDpDK7fewezxicY5XMZAeMeAHsYJpB7zxwQYjaRnijW0Bq0IWoxd8pfNPe5FRxrYZ9K9jnOMz5qfuhAYYOXXGZc9Q/kqMTeAVSVfY+si6XmRSe70Otmkwlz107k4BabSanHz72vMlu//Y3vNxORfao0g9K3fL/zrFUXaik48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYuIOpz7; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYuIOpz7"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso8144445e9.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790241183; x=1790845983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q3UEIk5rnMiFTRGuZ99oPenAjQD9CsZRbMnKE/eY65Q=;
        b=UYuIOpz7j6vU2ibj8cfoBAxRZK2IAanJQ8c6r++AJPUZ3U7iw2r8DUjdaybDb1sDOb
         h5Z78rP4R8WHZpcj5Tk+YsSPgnAGdcaPxWrRR97l634lFp2CWvK5w1FP1Q/jmlsj6nYm
         RADQH+5FgGnJ7fe8L3BigTcEMBSm2tRPJh7gcJH36nvS6t6krVZnE8HPfMI0JCAQKUHT
         Wkr7fCpJpW9LLeb3xhAnvSDU25WTfACbZGWP4D9cl5yvhsvPxn2KFsVVYh9C35wgWY79
         6EPC61Tb4AkETEhvL2No1XWittJnoE5YiSHDI8y9mBOHJrHqEwF41GmQBKWj6/zz/VPX
         d83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790241183; x=1790845983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q3UEIk5rnMiFTRGuZ99oPenAjQD9CsZRbMnKE/eY65Q=;
        b=nREiXVm5HbEE4Legnd1E/Cci1eMpPyR4EfwlWRZA7Oiib6QQsj5eO1B7CFSAqGDPVc
         pCpYkX2XNle751HOikjiKXuZvo07lKXk1LCtOQcxg0YD1leuuQPakjxV1XiWpvhx56/A
         PturRrkDLrqdh9DndZ2PiFXQpYkqXmyTmcz+DAD5GAHNs9AxJNFl52CdC5OsbaPTYB1n
         tJRhdoMKJo2iT3MoT4Nr8EdBgXPbjcLQgx0n4NpXXNwGVw2fVafoykRC7crZe6o5DZDi
         rjt/ZS/LzNjAR5Oro6fWNGOG1n/olBBjqeuDxDPlWJXLEWkpWvTTlhF/lKJSsjAo5bkl
         Ting==
X-Forwarded-Encrypted: i=1; AKwUvBxoNeUpPS+FEduCagemmhUxKix62eXkrtz15FsDDGHrkAazO7m1qp25joaO+oNFANQ43gUlQtE=@vger.kernel.org
X-Gm-Message-State: AFuF++nCFrHG6na60yUZWBOciNS2+VNNZVg5Ork++AiRsYJzRWiYR8pP
	on7SDj12fE80z1W983GV6PE//uFdoD2rBMkLLRo1tjLPmxkvSEdNLE3D
X-Gm-Gg: AYBFou3DNwLqHazOA0GPa64m8prQh5DCaVFT+Ib6+kV6F337XmyPKRiXoPMiWCUsAW0
	Jqd39Bq1n5kZ0qDKzGX7HBbordio0EKjYvGSQb74ZKGTeRv2TnDZvN7m6m2DZ86KFXodjNCHWzk
	b+fdMDz6UXNfsHRKRh2FlKAYyd2vHe3o61sgjWYn7bNU4fUKsqA+Gr7N4fm63enkqi+KZaJLVti
	kowp3BHzRWN060zlcIKvUXmOIvgxNzg5pb2xx300z6UFMmnaQ3mUzINyQ35EhOlWIUVqnvYf1qi
	FR2P7/bAleYz/fAQV3r6cAOyHlWrtR+GJdiqPBZ3NOxfXtOmtsJD6PxrFpHdx5FHFn6JslYsWmU
	Sl0TKEDbr4tBeRbxWzbRxOGBOwHzAsRP/3t7g3gp8aG6shKyCQv+dyV4Y9p0a9CZRY7aHcN1iTd
	n/tPqVCeOdEnlxgVRON2ngYXnQ32VmxGHPMkXlTsgP1ay4kThwVxrA1XPzC1PWSSM49Z3gIMMsQ
	P3zK4CNua6KkQlPX43rvvagkku9GtMgn45ggg5D5F6olVIHqskGad8XFrcEPKc0TwHlNBTnq8z+
	qTsI+lEmu5cHb2U=
X-Received: by 2002:a05:600c:a015:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-49fe6700006mr27711555e9.28.1790241183440;
        Thu, 24 Sep 2026 02:13:03 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm12756677f8f.6.2026.09.24.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:13:03 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] iomap: don't lose a failed direct I/O bio's error when zeroing the tail
Date: Thu, 24 Sep 2026 11:11:54 +0200
Message-ID: <20260924091203.198225-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924091203.198225-1-parri.andrea@gmail.com>
References: <20260924091203.198225-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/iomap/direct-io.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8b4039d16ce89..e00995c296c79 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -296,8 +296,9 @@ u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
 	return vec_count;
 }
 
-static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
-		loff_t pos, unsigned len)
+static void iomap_dio_zero(const struct iomap_iter *iter,
+			   struct iomap_dio *dio, loff_t pos,
+			   unsigned int len)
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct bio *bio;
@@ -305,14 +306,14 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
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
@@ -328,8 +329,6 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		len -= io_len;
 	}
 	iomap_dio_submit_bio(iter, dio, bio, pos);
-
-	return 0;
 }
 
 static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
@@ -541,10 +540,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
 		pad = pos & (fs_block_size - 1);
-
-		ret = iomap_dio_zero(iter, dio, pos - pad, pad);
-		if (ret)
-			goto out;
+		iomap_dio_zero(iter, dio, pos - pad, pad);
 	}
 
 	do {
@@ -582,8 +578,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
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

