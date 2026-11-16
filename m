Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820085;
	b=mEz0UwUvuS15Xc1y3+hAektCwZbHhgLWCiJEagv9SamF+BfQbajbYwKw/H2j50LqyJLZ
	 9Mfj1OOhYfCO/47BuJmaSFvtFt+2r0UwE5SqA2yV683Yb5ewdS37cqh4AFEdbz+muFxuP
	 pBz1NO0CsYjz0yyuwsHwS38SjohK+6vs+pn9vR+ABgsE+NIuP8acQUDzXbpfYoFt49BpZ
	 LxKv4G4CXPALgITD/jnrDXihMg2afJBqQixAIQAtkDdiU1YVobQxHbHsHKt1LEO6/Z2ZS
	 JjXbDYADFWsDWmLVRUWpkPfnUm17kpt81htwMn/tKZIfHPthsfckOEkG6lMVNnL+K5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820085;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2dBApJohDWq0spUc9ZEkhqkmcspPlLLrO3I714iwMjc=;
	b=TstP8gFo6Lf8WhQxsP8JYEzZdUFAfTysMT9xvRKGtrWpCVxnGygCMwIeH218kKigHW0y
	 5hg2zxEGttE/hapXZhv5fSNQvhsGONnwz+d9GjrfXRk2hN7YueiychZmWvzVfmAg66LGD
	 M1vgfM1DIh2osBltZ20j4w1vk2cG/19QzlwkcYQIf7vyCyWvJAOJJoEqFM/yDzYGXKSqj
	 YKPk68HPwYOVQYwgQzty4ct9kkGlOSNieFDc9zCGV0gRbW3q2b9UQNvbWsbF83aS1vPSI
	 j2FrQtXl/2aRgETiO02Fn4Sm4mqxQzVu9x0MYHNnkuFH7ssDnkj8n9//uRzjMh7xo/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GcZhUrH2;
	arc=none smtp.remote-ip=91.218.175.110
Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18046606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18046606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GcZhUrH2
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6O1MZeih3cij9nn47y1yx5atE4sMhOCd8JeZ4POXJVc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794820082; v=1; x=1795424882;
 b=GcZhUrH2taZ/jGbzx5kLib0Rb7OHHsedmRCQ9l++GN2GyrVWGAY2e9mjsOzJErDyWojqyaua
 BMSkvqp48eC773cQDGPsMka07VWVGWf/GYLYF6ce+3mrtgL4iA9txYpwBFFvyDL5fO7ZXi9lDZW
 oXIE84F88JhD8HYSh5FXIKTc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6935a82c48f73f48;
	Mon, 16 Nov 2026 09:08:02 +0000
X-Mizu-Trace-ID: 6935a82c48f73f48
X-Migadu-Flow: FLOW_OUT
From: Youling Tang <youling.tang@linux.dev>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@163.com>,
	exfat@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] exfat: don't map EXFAT_EOF_CLUSTER as a physical cluster
Date: Mon, 16 Nov 2026 17:07:20 +0800
Message-ID: <20261116090720.3226446-3-youling.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116090720.3226446-1-youling.tang@linux.dev>
References: <20261116090720.3226446-1-youling.tang@linux.dev>
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

From: Youling Tang <tangyouling@kylinos.cn>

exfat_map_cluster() reports a hole by returning success with
*clu == EXFAT_EOF_CLUSTER for !create.  __exfat_iomap_begin() does not
check that sentinel and converts it into a physical address far beyond
the device.  A writeback that races with the i_size/i_blocks window in
exfat_cont_expand() can hit this: the writeback submits a bio past the
end of the device, and fsync() or msync() returns -EIO.  If the
resulting iomap length is zero, iomap_add_to_ioend() can loop on a
zero-length bio and hang a concurrent truncate.

When a range starts before the end of the cluster chain but extends past
it, exfat_map_cluster() returns the sentinel for the whole range.  Make
it map the valid prefix in that case, and return the sentinel only if
the whole range is beyond the chain:

    offset         chain end       offset+len
      |--- prefix ----|--- tail ---|
      |== allocated ==|
            MAPPED         HOLE

Reporting the whole straddling range as a hole instead would skip
valid dirty data.

Report the remaining range as a hole instead of turning the sentinel
into an address, matching the old exfat_get_block() behavior.

Fixes: 82a81a7352bc ("exfat: add iomap buffered I/O support")
Cc: stable@vger.kernel.org
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
v2: move the clamp into exfat_map_cluster().

 fs/exfat/inode.c | 15 ++++++++++++---
 fs/exfat/iomap.c | 12 ++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index c1d15d4fc5e7..b175d2f3e459 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -134,6 +134,9 @@ void exfat_sync_inode(struct inode *inode)
  * Input: inode, (logical) clu_offset, target allocation area
  * Output: errcode, cluster number
  * *clu = (~0), if it's unable to allocate a new cluster
+ *
+ * For !create, *count is limited to the part of the range backed by the
+ * cluster chain; the caller reports the remainder as a hole.
  */
 int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		unsigned int *clu, unsigned int *count, int create,
@@ -153,9 +156,15 @@ int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	    *count > num_clusters - clu_offset)
 		num_to_be_allocated = clu_offset + *count - num_clusters;
 
-	if (!create && (num_to_be_allocated > 0)) {
-		*clu = EXFAT_EOF_CLUSTER;
-		return 0;
+	if (!create && num_to_be_allocated > 0) {
+		if (clu_offset >= num_clusters) {
+			*clu = EXFAT_EOF_CLUSTER;
+			return 0;
+		}
+
+		/* Range straddles the chain end: map the valid prefix only. */
+		*count = num_clusters - clu_offset;
+		num_to_be_allocated = 0;
 	}
 
 	*clu = last_clu = ei->start_clu;
diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 11823591b3a8..ed17b367f820 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -90,6 +90,18 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 	if (err)
 		goto out;
 
+	/*
+	 * exfat_map_cluster() can return EXFAT_EOF_CLUSTER when racing with
+	 * exfat_cont_expand().  Report it as a hole.
+	 */
+	if (!may_alloc && cluster == EXFAT_EOF_CLUSTER) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->offset = offset;
+		iomap->length = length;
+		goto out;
+	}
+
 	cluster_offset = exfat_cluster_offset(sbi, offset);
 	cluster_length = exfat_cluster_to_bytes(sbi, num_clusters);
 
-- 
2.43.0

