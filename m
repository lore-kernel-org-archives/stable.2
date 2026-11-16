Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820078;
	b=FMWAJfxus9nXwqE7BUDFE3AuH84elR8EcjjW7Lr8K0/Y8SPPWdgVDirQY2r0lWK4nvGJ
	 kyijhqW0q+bKyi7po/I3+oDQcGtL8/S097Xc5AtgSFALXdjlZJcsYCA0vbcgrRXDKjABd
	 WPR2OpYgZQqHMO7nr8rFOXSXdx7v3bdAj9xT1H+1JaJXAt3gUgmPN2pJXaPjjopz10/Vh
	 ICvUHNUy1l2kzH2nedhuUC+eswFjVLC4AQKB6L9weRIrjG93dPWlB2g5AVAH5oNpbKaX1
	 ABAjSvs8GTRZfFUcY/jkbU+XKV4j1cDLzmUw8gPXxCrEj/I6Jpmj0CT4jQQxUDHgB/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820078;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lsLBDj//XmwDgRWbN4qAvpmlp/uhNkBnjN9EOtUVsdI=;
	b=1dtcNYS7jdEz5yFk2xIXkjwhGeHJ/fBWGoTrAjHJ30lBdas+/EO5PtNLa8s/PGG7kAD8
	 +L3AoLLnTcWi1I1vVCJWIuSHLmiYgA5UAnu75hi2/904ND33kKQEzHRGNU8T0XWKfEJus
	 pLmjhkNyv+tMuusTmC54MyWTbe+zrLbzNTgvSFhc2JXdmAqSVCNq4sTq6PqUrPJIJQc1v
	 KkOMVdrtRQrizM+H/lHZZ604SvEr6BHzy5QQp61Vh+cYqD2zvZlCQHL50vxMTncfeZ9LW
	 tcNhSTxYtNQjx7VCbNh288vuVBi7hEXej/H/nz5sPdCC9b5MRfUhJvi851Pw/kUA6cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QXcUhExD;
	arc=none smtp.remote-ip=91.218.175.101
Received: from mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9D606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6A9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QXcUhExD
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aoevLWXHkx8uZctzV0kkFV65ZPmznPhVte547L6bw/0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794820076; v=1; x=1795424876;
 b=QXcUhExDNc+THvFAx58pVfdQWX7rX3aEAneHuZgWcKmb7xk8Qbx1x10AF62UDrWSh2x3woTc
 W5VNxnOPb5nGb1qk4Uqj1Qro7sJCLHRLvQhqWIN0Tm4UBziA8AcxlWOvWd8b4e44/1fYCSFD0QT
 RTwuhWzVujGxFpIwUbJ0rMVA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0ec6bb0f507063e0;
	Mon, 16 Nov 2026 09:07:55 +0000
X-Mizu-Trace-ID: 0ec6bb0f507063e0
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
	stable@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 1/2] exfat: fix iomap mapping when writeback races with truncate
Date: Mon, 16 Nov 2026 17:07:19 +0800
Message-ID: <20261116090720.3226446-2-youling.tang@linux.dev>
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

__exfat_iomap_begin() reads i_size twice: once to detect a range that
starts beyond EOF, and once to clamp the mapping to EOF.  A concurrent
truncate can shrink i_size between the two reads, so the clamp can
produce a negative length.  The unsigned cluster index subtraction then
underflows, making exfat_map_cluster() believe it has to allocate a huge
number of clusters and report a hole.

Fix this by reading i_size once for both the EOF check and the
block-aligned clamp.

Fixes: 82a81a7352bc ("exfat: add iomap buffered I/O support")
Cc: stable@vger.kernel.org
Reviewed-by: Chi Zhiling <chizhiling@kylinos.cn>
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/exfat/iomap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 4e6f3ed9dcc8..11823591b3a8 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -51,8 +51,10 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 	bool balloc = false;
 
 	if (!may_alloc) {
+		loff_t isize = i_size_read(inode);
+
 		/* Completely beyond EOF. Treat as hole */
-		if (i_size_read(inode) <= offset) {
+		if (offset >= isize) {
 			iomap->type = IOMAP_HOLE;
 			iomap->addr = IOMAP_NULL_ADDR;
 			iomap->offset = offset;
@@ -61,9 +63,8 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 		}
 
 		/* Clamp length if the requested range goes beyond i_size */
-		if (offset + length > i_size_read(inode))
-			length = round_up(i_size_read(inode),
-					  i_blocksize(inode)) - offset;
+		if (offset + length > isize)
+			length = round_up(isize, i_blocksize(inode)) - offset;
 	}
 
 	num_clusters = exfat_bytes_to_cluster_round_up(sbi,
-- 
2.43.0

