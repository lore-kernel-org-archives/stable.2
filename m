Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717698;
	b=KtmsL+2ReNqu8LiYcdiNx8RWRlyBWgpFrKgBR7arSdXvNd0++UGhBxXECtXnzCVxHi8Z
	 8F/wS+qy+EVHUAF0WXJwMmbnWkga7a4Jze14fHJYRGGbjpZBuMxkLRxHfgyyZacdAQKcG
	 9CTmhNQEXl+LWMaUgrYKp/kkvkBGHq8Pgrjh0KqxSovui9rH232CQWIrrRsYQKoLxFUwY
	 p4UqYKdy0LKj+qPGCwdiHXN+b45tIZ9ohTPXIjAyb63NoSKJhrhlpGn6QqZD10bIGgEk+
	 ZJ+t/lVrgGzCesSMprlcP5VD2XdXkqBKCq43P6M99NwPUAcFOqbf75qaYNWBVwphm1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CAccl21Ta2xKfCvErWmXwQUaoiGO2p8CkPuu5f18Boc=;
	b=3315f423v+oStuDQanNLtcgh/AtXRhCL513TqLHCfVm3kscfkAXePCH5Z8xeAakVC1rb
	 ncnoJjBIp3mlBTdMg5SiAbhq2bviVLHMs3OxLIIA0g0pt+SruwRaTPsGuU259+xPKgsMo
	 A5+WuE5ApzkEkCYB8UfTQW5QFLZUtXJRfRHEQOnE8HJXf5lGqYVEQqIscrSwoMewi/jeO
	 yD+riPjTuChu4y2QUHZom0ZtloGb8tL/ZEZ4Kl9F6uV2NP05TY7C4jaQUm9KnzSw0HojY
	 tR+C5WXkzlwev50fvs9s54vUShcBqxMMkT8O5mnZpoBr4YkKQD5mYhWsbsCuIT/iz0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGZYm3UA;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E3606D822
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA2E3606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGZYm3UA
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso1194998a91.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717697; x=1794322497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CAccl21Ta2xKfCvErWmXwQUaoiGO2p8CkPuu5f18Boc=;
        b=cGZYm3UAYTYHGi7MmhOTUyo7jEpJXrjWzTcmNeYCa8209WrAgS27vxUMTaZ88QM9gg
         J8snYVgRixOJsTkFQ4vno+yBbCMM1/ELfSy1YOnR2qZ8B+rOk30XTLqZYnyzWL4oUbNQ
         mfQUPI3I507wi4G3DYeK3TSNw6rD9YHM/G4Zsu5hwa90aMJjmfe8KHxddYQ2kepvM7bg
         e1mv/gh57+WAAnqtoYoveCwh16chExgRVL7mvEqtI/3TZ/Ks5g5oH8UNAMAc9CYYJ6AS
         Wcz4GBhWQQGuNXEn3IdjtEMw8ZOsaJx0Cpdy0OUSYRPacvmrCNX13p5iIi83zMbcivm7
         pieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717697; x=1794322497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CAccl21Ta2xKfCvErWmXwQUaoiGO2p8CkPuu5f18Boc=;
        b=iQAHqQcaxR7VXj1ywpxo2umnZ8UVt4sciB6R6UiBu2N1chJJxH/BRSN+vnXhifDcWN
         VNHJ1rGEPzSruD1JjXH5niG/2aQDnnEX1evySVxTpTrhMvic9QvPgOeB4eTbbCDb6FDY
         d4Rs4uK5v5nTK+MHQHcbP4z6+LqHTfKNnh8DUlH2PlpP/DwPQEOz6gPZ0gxAFkC6lDIx
         8sGgofjR+WWN1maxtr3VSHYvenJfwIZONsC9qQmdNIGnWEp6vrTwvKTCdq4XgkezkKap
         jKfZe2UjLhsPjN3a4W8gBPX7znTDMbOJ2HLK89VZzSUZd41CNDHvG+Iz7/ajaVMv1ftR
         DGuw==
X-Forwarded-Encrypted: i=1; AKwUvBzDji+Yxd/T7XBdLx1ipQt0BVhlmgvPRTyc6x0NEboFvY1MTa9k/NDI+K1+j7u3xvM2So5F1kc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UMsQcLAS9F2g2eHTgxnlnY1JHYu2MNmUm7J4vKgT4HT8HQepD
	jMw7tXnOSw1evPvOzf7X9ec3cTiZjbgeCmza4y37PxhBxucZtLPfzrhV
X-Gm-Gg: AYBFou0oUYo3GzR3xFzmAJOR4egzFIzPHKGUt1GdcOWD2kxC4G4qeA67kehpExGHh/a
	QLSfe0OAhfBwI4tbIH1nz1SC+JByG2DoUR87fx6b1HquvKboci73ehczVpN7Cnik4WgSGpN9bVI
	GC6XwionRHeNR7i8FyGe2Lunp2Pyr7uYvvedH/rJJGwQ0pbgvKhMxs1TOUzKae7SsJYBVJtX0fi
	rvxtmqHjfOt0nl9nc9vVf+p7MoTUvaBahonpJ3d6qAgQGYqVyrmqGVVMO+GLJ11ysGvq41li7Iu
	y+62QW5/dI0gJ5+DGuoFnchHmgsHJ+w5XQ56jJNwKn+H0RSq98hXDn6zuU4ZTynmnVJLgRJ6Tr0
	y2p0XBIpQZTjSDERBkJ+NxJ8j1K/TqdM520idmlFfsR6GXeEpEusY0T2i9uYwp+Pth59pKQdfrz
	dImRgeOzBHyoP3gj8HTcupgGNHij85I1Bfmz3HIGBLt4iLtxJ188dYUs+Lhv5Gt8aaYngHL1z5A
	qUY1JWZj1H8Ou//AuW4l9yQpXU2WXAxE4I82Ll5lOSQ7rfavAZvAsMrr9LbgXBoD/cdN57my06b
	+8u4/4wTvBfYETGSzstXBdO70gautTeq0JA+eMnfZ6XQ3pdIzjeeGSkZXigv9avM128OzN9LU9g
	Lv82VI42XsSeQiyga4+LKAEe+mpwdI5rm+XtU20i/8Ib2buXXp8Hma9q5id5sXg==
X-Received: by 2002:a17:90b:1d05:b0:3ac:80dc:f40b with SMTP id 98e67ed59e1d1-3ae897f55cfmr9602071a91.33.1793717696954;
        Tue, 03 Nov 2026 06:54:56 -0800 (PST)
Received: from localhost (ec2-95-40-37-200.ap-east-1.compute.amazonaws.com. [95.40.37.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9b0ec5sm4753310a91.16.2026.11.03.06.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:54:56 -0800 (PST)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Dave Chinner <dgc@kernel.org>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	linux-xfs@vger.kernel.org (open list:XFS FILESYSTEM)
Subject: [PATCH] xfs: fix misplaced unlikely() parenthesis in xfs_iformat_btree
Date: Tue,  3 Nov 2026 22:54:47 +0800
Message-Id: <20261103145451.23755-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Jianyun Gao <jianyungao89@gmail.com>

The two corruption checks (level == 0 || level > XFS_BM_MAXLEVELS) were
added to xfs_iformat_btree, but the closing parenthesis of unlikely() was
left after the previous condition, leaving the new level checks outside
the unlikely() annotation.  Although the boolean result is unaffected
(all conditions are OR'd), the misplaced paren loses the unlikely() hint
for the level checks and indicates the code was not written as intended.

Move the closing parenthesis to the end of the condition list and
update the comment to describe the level check.

Fixes: b3bf607d5852 ("xfs: check for obviously bad level values in the bmbt root")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 fs/xfs/libxfs/xfs_inode_fork.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
index 486fe7ab8b61..48e1c83329ed 100644
--- a/fs/xfs/libxfs/xfs_inode_fork.c
+++ b/fs/xfs/libxfs/xfs_inode_fork.c
@@ -195,15 +195,16 @@ xfs_iformat_btree(
 	 * blow out if -- fork has less extents than can fit in
 	 * fork (fork shouldn't be a btree format), root btree
 	 * block has more records than can fit into the fork,
-	 * or the number of extents is greater than the number of
-	 * blocks.
+	 * the number of extents is greater than the number of
+	 * blocks, or the btree level is zero or exceeds the
+	 * maximum allowed depth.
 	 */
 	if (unlikely(ifp->if_nextents <= XFS_IFORK_MAXEXT(ip, whichfork) ||
 		     nrecs == 0 ||
 		     xfs_bmdr_space_calc(nrecs) >
 					XFS_DFORK_SIZE(dip, mp, whichfork) ||
-		     ifp->if_nextents > ip->i_nblocks) ||
-		     level == 0 || level > XFS_BM_MAXLEVELS(mp, whichfork)) {
+		     ifp->if_nextents > ip->i_nblocks ||
+		     level == 0 || level > XFS_BM_MAXLEVELS(mp, whichfork))) {
 		xfs_warn(mp, "corrupt inode %llu (btree).",
 					(unsigned long long)I_INO(ip));
 		xfs_inode_verifier_error(ip, -EFSCORRUPTED,
-- 
2.34.1

