Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556853;
	b=uJvx5NXEJXa0E9VBDd48C1eZe+kJwFpIfjQhs3A3rIWH2gMM+g4Q5Fflf/oP4EQ+cVrx
	 Yc0N3fROganJvl5zVeEHqlPNq+WSSg9Ckih1txsqoKOxTWQ8/z4Y+dEYspRC6eb9Zr9AJ
	 Aknw3OTnXWPEfdj4rbcnYz1IzxbS+kPubJfrMwZkYjwT2OVre2a+ZTwdkH8Cnm3Zl3tX1
	 81PwoDppzfgd7nW+nKtIAflq69R6mBiNdbExMoRtHSgCY582mV74PxM9PH+SSs8LxxycN
	 AZb+GXgzwoKV8pBtrsAPLyTeZuZEK4BSrJ6jdOtaPeGeb8cgti/nu4BcUghjyl6VYrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556853;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=19BiyJv2TJqRN2UvAv1orgjEi8HKoYAug4YesSOKGKQ=;
	b=fEYQAD6FD62PdRSVI4KQNC89b3EOEpukRoTLytSXgrhtDQLOoybIAj7e2gjHBpCZC9QF
	 XY2u2kzbHl6JC87EDWZ1VktgDoMeGv1PTSfa86iovb6uYgH3RbkabMyxPW4XdHdgiEV3a
	 LMHDyG+XiQ8K8OQuRASrwcRE+x8lp8EkmNXZvq+fwiOL/SylkTsYWa1FT/SgNU8K/eCMr
	 tbjZcRTPGPokM53dixGU/k4EsZrWWq95AoXIjbGAnFa5zGIA3jhuODLFKXLvSmLy3lpTE
	 Nxs4lorTL7xXyjJ2WSKTuFj/J3WuvMVuYCnQyYlbLyYevv1rzP7SL8WVqClxVPGfQHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WKJb7E2q;
	arc=none smtp.remote-ip=95.215.58.69
Received: from mta1.migadu.com (out-69.mta1.migadu.com [95.215.58.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA3606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFDA3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WKJb7E2q
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Cyd/q2FWnL6fCplGVrk2zL863EUO2BEQhbDkjI28sqw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794556850; v=1; x=1795161650;
 b=WKJb7E2q2dP/AGoOhjB1U1+ybiO3pACAgrFVr9p7LuVe0YKsrdKcGHCUgYLtiqDo+emRSCuN
 8ajdUuhgqBcPLaOeQOTFy+gfNScocdh+XR1JQnNIazyn8QQ1VAvAZU4H00p2qfZrFBLQ+ZVqVAg
 ssbt8eryn56P+EGkKV3885Es=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9592cb5291764adc;
	Fri, 13 Nov 2026 08:00:34 +0000
X-Mizu-Trace-ID: 9592cb5291764adc
X-Migadu-Flow: FLOW_OUT
From: Youling Tang <youling.tang@linux.dev>
To: youling.tang@linux.dev
Cc: Youling Tang <tangyouling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] exfat: don't map EXFAT_EOF_CLUSTER as a physical cluster
Date: Fri, 13 Nov 2026 16:00:13 +0800
Message-ID: <20261113080013.2432300-3-youling.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113080013.2432300-1-youling.tang@linux.dev>
References: <20261113080013.2432300-1-youling.tang@linux.dev>
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

