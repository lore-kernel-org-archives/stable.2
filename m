Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.234
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794557261;
	b=bO/HrBL/Yiac0bu64U6tPySlBI5TQMshEuo9qAikewOYIhr43guWBWhww/J5cV2RIuGJ
	 PYG9aXmYeXgajdnjZA/cAnIhFVxXtkXwkwvfsWbQFpKjYw5hwBJzEA80DmL27/DrG9Ync
	 kz5xha5LkYPO29L/KaQcyydYEhuN80nFgXNJqP7i8IJjGNRq1RHY3CuBlBiRNGeqZdRfv
	 wB0Y2vl1lNusFR7iy6XXcGcF12EkSlxNqOvcDd7fH8v32Xkzq4KYdJVXcHMoDtp7mtokw
	 nV/1a6WP+cXNcWiuikv9fF3tjkbtstuld4v3up6VTBXsCrCDnZx0Fp9rx68Vf4Otp2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557261;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=19BiyJv2TJqRN2UvAv1orgjEi8HKoYAug4YesSOKGKQ=;
	b=Xw6QgKj70LhdKE8LNkHViO3/uAcx7g8x1ifmM74mgcd0WZ/j+ZJPVjJa5E4kHaINw/wj
	 bPuyvQ2rq8KVKKWOtP6eUTr9IMhGjGh7sBMuuNRLPvP4VK4SLr9tfxBzNazdUST4UVKMV
	 Tdyi1HTY8Izxt3pWMbucfAFhd8ih1J43cuqcplywoV2FfCj3y/6Io/D1q3hBOTZO85r0n
	 vwpNzxEgW2eAVP+gO6uKKdRgm1LvN5X2HL47UYP+SQlpjNS1UBJbhh9uRlK3yXqros/Am
	 xf3+z/w7CJGsuXxhKQXb9gaFcFhEchUDYU13gFK2bABHRx87V8I2UtLfBat5kIhTsQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gJGslOZF;
	arc=none smtp.remote-ip=91.218.175.234
Received: from mta0.migadu.com (out-234.mta0.migadu.com [91.218.175.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25447606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25447606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gJGslOZF
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Cyd/q2FWnL6fCplGVrk2zL863EUO2BEQhbDkjI28sqw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794557259; v=1; x=1795162059;
 b=gJGslOZFcET2e8cohA4BP1sWcMlOO/AN9Evc5Gj07GzN7Z3lEJn+b9IvRTRZ3WVdIExlMXAv
 Tw59DydII7GlM1J1HjWMImOT6IftJKE9S+732IsmXl5zhVDNxb56oqU7Wup0IZUQIzmt+fgdLSr
 5cYo0kSp3uOvQNdh80e9/0GM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 74ef592acf403f59;
	Fri, 13 Nov 2026 08:07:39 +0000
X-Mizu-Trace-ID: 74ef592acf403f59
X-Migadu-Flow: FLOW_OUT
From: Youling Tang <youling.tang@linux.dev>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@163.com>,
	exfat@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] exfat: don't map EXFAT_EOF_CLUSTER as a physical cluster
Date: Fri, 13 Nov 2026 16:06:57 +0800
Message-ID: <20261113080658.2440516-3-youling.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113080658.2440516-1-youling.tang@linux.dev>
References: <20261113080658.2440516-1-youling.tang@linux.dev>
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
exfat_cont_expand() can hit this: it submits a bio past the end of the
device, and fsync() or msync() returns -EIO.  If the resulting iomap
length is zero, iomap_add_to_ioend() can loop on a zero-length bio and
hang a concurrent truncate.

When a range starts before the end of the cluster chain but extends past
it, exfat_map_cluster() returns the sentinel for the whole range.  Map
the valid prefix first and only report the part beyond the chain as a
hole.  Otherwise a writeback that straddles the end of the chain would
skip valid dirty data.

Report the remaining range as a hole instead of turning the sentinel
into an address, matching the old exfat_get_block() behavior.

Fixes: 82a81a7352bc ("exfat: add iomap buffered I/O support")
Cc: stable@vger.kernel.org
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/exfat/iomap.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 11823591b3a8..d6b420f615d4 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -74,6 +74,22 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->offset = offset;
 
+	if (!may_alloc) {
+		unsigned int ondisk_clusters =
+			exfat_bytes_to_cluster(sbi, exfat_ondisk_size(inode));
+		unsigned int clu_offset =
+			exfat_bytes_to_cluster(sbi, offset);
+
+		/*
+		 * exfat_map_cluster() returns the EOF sentinel for the whole
+		 * range if it extends past the cluster chain.  Map the valid
+		 * prefix first so the hole only covers the part beyond it.
+		 */
+		if (clu_offset < ondisk_clusters &&
+		    num_clusters > ondisk_clusters - clu_offset)
+			num_clusters = ondisk_clusters - clu_offset;
+	}
+
 	err = exfat_map_cluster(inode, exfat_bytes_to_cluster(sbi, offset),
 			&cluster, &num_clusters, may_alloc, &balloc);
 	if (err == -ENOSPC && !(flags & IOMAP_DIRECT)) {
@@ -90,6 +106,19 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 	if (err)
 		goto out;
 
+	/*
+	 * exfat_map_cluster() reports a hole by returning success with
+	 * EXFAT_EOF_CLUSTER.  Return it as a hole instead of turning the
+	 * sentinel into a physical address.
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

