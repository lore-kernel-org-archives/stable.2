Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731FA32E13B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605449; cv=none; b=U6ZkKk7W3QpOi5hSd4q5iXZ4b08VO1au2dJZOoPcr2DMdn7oCoPCnJhSi1O9IIrUslGy6jWjJA6WQSR1cQj5jeuiuGMo/9XpDOIj7ag298Lb/w/o5BplvBMFF2b8zTBbK+pUtYJ/WNUIv2R+0lQtfnUitSWq3WV/q5LW24/Eg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605449; c=relaxed/simple;
	bh=dFhqRMqe19Y8KlupBTFmHUV6YzE3VFjsceX+JCF/i5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1U+vWZyboUqHvh9REeVN8NHjIBXL4MOd+gt3H6PZaPI7OFTUdtsXRbW+ZegTdmYjcy4PU0/nvEBN1NGtwEMBnfvfAqm6GKsnRC2aVFphYsjl2XQtxvf/wQiUzdnxjoPmfAKnrjhYcHLMc6MyaztW8MiKtXOFzW1EUdHZJagLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqzbtkEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqzbtkEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D561F00893;
	Thu, 17 Sep 2026 00:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605448;
	bh=lL0O40QcJGNXLq0boUi1TqSFpISYbPbC089v/EtBhq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZqzbtkEfuzCr3mha3FOEZ6lq5rRLDr8iG4W5KGuoDZVHvjQYkHUuYFHb8nx8PSr8b
	 cs21No88UHI/8VStgQwTRHXG1hqDucz3glaV8c/XcxXFluEINPFroMGkzWoO2LJYRH
	 h5ELY42lvIF01cPLKiGeJOckitAe/IupI0S1bDaDGGoGyflHeszudepU+fVak6zd+2
	 2Gu49TvLn+UCyLnMmPp9cqKNQ4XkWqWbmehAK29tn5EzoC+ahu57rZkT5fuxrosktk
	 PR1wJszetS7bDI76lXs0dUMVFw0JIhsjhK3rC1hTwlWMFFjlV42pkweW0N3LoIzTtG
	 Mrh45Zro4dbYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] erofs: preserve LZMA decoders on resize failure
Date: Wed, 16 Sep 2026 20:37:26 -0400
Message-ID: <20260917003726.3443744-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091609-nearest-swell-7036@gregkh>
References: <2026091609-nearest-swell-7036@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>

[ Upstream commit 617d0d8d199ba1790c94310fd75a22d01c97a8d6 ]

The pool-resize path frees each stream's old decoder before allocating
its replacement. If an allocation fails after some streams have already
been replaced, the failed stream is put back on the list with state ==
NULL. z_erofs_lzma_max_dictsize is still advanced as if the whole
pool had been resized.

An existing LZMA mount can select the broken stream and pass
NULL to xz_dec_microlzma_reset(). A retry at the same size also
skip another resize attempt. Since the global maximum was advanced,
thus, the invalid state is left unrepaired.

Allocate each replacement before freeing the old decoder, temporarily
retaining one old decoder during allocation. Stop at the first failure
and advance z_erofs_lzma_max_dictsize only after all streams satisfy
the request.

Record each stream's dictionary capacity so retries can skip streams
already enlarged before a partial failure.

Fixes: 622ceaddb764 ("erofs: lzma compression support")
Cc: stable@vger.kernel.org
Signed-off-by: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
Reviewed-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
[ Retained the existing `struct xz_buf buf` member alongside the new `dict_size` field. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/decompressor_lzma.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index b1ac88a820f2d..c6e6ceae48a3b 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -6,6 +6,7 @@
 struct z_erofs_lzma {
 	struct z_erofs_lzma *next;
 	struct xz_dec_microlzma *state;
+	unsigned int dict_size;
 	struct xz_buf buf;
 	u8 bounce[PAGE_SIZE];
 };
@@ -132,11 +133,19 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 	err = 0;
 	/* 2. walk each isolated stream and grow max dict_size if needed */
 	for (strm = head; strm; strm = strm->next) {
+		struct xz_dec_microlzma *state;
+
+		if (strm->dict_size >= dict_size)
+			continue;
+		state = xz_dec_microlzma_alloc(XZ_PREALLOC, dict_size);
+		if (!state) {
+			err = -ENOMEM;
+			break;
+		}
 		if (strm->state)
 			xz_dec_microlzma_end(strm->state);
-		strm->state = xz_dec_microlzma_alloc(XZ_PREALLOC, dict_size);
-		if (!strm->state)
-			err = -ENOMEM;
+		strm->state = state;
+		strm->dict_size = dict_size;
 	}
 
 	/* 3. push back all to the global list and update max dict_size */
@@ -146,7 +155,8 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 	spin_unlock(&z_erofs_lzma_lock);
 	wake_up_all(&z_erofs_lzma_wq);
 
-	z_erofs_lzma_max_dictsize = dict_size;
+	if (!err)
+		z_erofs_lzma_max_dictsize = dict_size;
 	mutex_unlock(&lzma_resize_mutex);
 	return err;
 }
-- 
2.53.0

