Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DF432BD2
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447378; cv=none; b=HZMAQEqnuFXQmQ8nT59LO/kbnDiO8SV/wdeIYjfR6oHp6mA7jr0K+zDeg7CYmCD6Vy8eFYcKkz2Q9DWdFkWmZduC/BKH4EBlc92IabZneg+gyqB5AEj7+o6hw+OAbSw/d2Akzgm13jxz/1Jm4GTjGHDZ70BPK6sIWTpqPyRQSgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447378; c=relaxed/simple;
	bh=ciAoel1O+HvyWV3G/BL2s+jwL5JjfElEXWANvEXcVoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGs+apPPU3FrDF3VanovQD7X5479aUp35PfGmRl+TFOqb6em4SfhOf+Uz0p7j17jG973dQ++hxY7cwf2c2/1SutUe7pAGcdqF8a883TFJQ2xv5UI/qgTAIDZvj9NZ4jeAPMPbe8FyIv/iOWqgnqYLG2a165IyQ2hW712W2ncH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWCNfA9a; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWCNfA9a"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8481fb4324aso1642913b3a.2
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783447377; x=1784052177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbQWo2Jw7nEFsOrQm6lAp74HBAcbYUyqspC1ko1fdco=;
        b=JWCNfA9aC6xXHTW1/Useek21UOE8tVayhNGHFdRuUkENQ4ld6H4IaQqZwwnOzQHM/N
         uyCNq3cgjjRI96nUD9i0KMy5zf1aOIQ+PzvYTQJ7Fk4l6WMrPkEVzumEv0YgRGblXNOX
         5Y/548hcJMpNALKnfMR+XDen6kg1HplZqzxQz1Xga0oTlEheCiPPdGFFNg05xLc0GNru
         mBzYRauHe83mHt4DG4cLHXb5jTl7IkP82wiUvRsDXTUGVfPeuXIOmJBxszl5swz80Rak
         P53XJIG91h2Nh38AZAC8UvGlQXim92FMvZO8L/rV92vGd1nlTczHlKSaFtCT4MOV98ZQ
         2u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783447377; x=1784052177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbQWo2Jw7nEFsOrQm6lAp74HBAcbYUyqspC1ko1fdco=;
        b=SR5bOCHtjota5QgyfNyVolWuayT8Wx3XhpbwJEQEy9K0cReLACrYooetEWKlr6WEu0
         K+rv5MizEYRGKJtM2m89OTubc2Cg6B8ayOvEWsJ3KQQ4yG93aTm9f9W5I9SsR8VWvgr1
         0AyH+ddq9mmHJCHyiUrbV0W9F3ahQArwxoMOKywIOYdKJO0qfhJR44Q4RoEOw/HfwB7m
         RMJfxIN6IFy/ojrMmqozpM9+lEAGQvaoEZkvjkNKVaHUIiPCzoY0o5dFAAsNHVjSB4BL
         TSQzp6g7+I6XYNF4/goR5/I+8arnhJDYpRY6S2AEmtoZ9wP/MBau1ZfbhYEOhdNuPU2h
         5pjw==
X-Forwarded-Encrypted: i=1; AHgh+RrXZsJL21hydjbhDO9PGomKSKf/Fwp+CgF/pQb0S6iOUwwG6oF+JbJf5HD8xIvsYMBb0C1SAVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK9zeCsy3/XA4pBqwuZVu6k2qt+Vq/3u7gU2OubhdEju5azz5P
	R4GE/mnJpiHfr9blt69bZ70mph+dmznbHWGpQgi+og8i8Tq/JN/TK5Vs
X-Gm-Gg: AfdE7cmwJNmkJNreCUX/xwhCren2NQp9FopN6SSaCYJvd9b19qiI5WLdlvSYgIgiW9f
	fOMNwx5327fNC4kUrtCVmy5e585rYRdk5HVhDF747m+Pnl/uTBrqaggaW5XysZwMEwERq4ZPpRo
	daXKHDTnHJ2ppvJCkwf3h1u6iXG9QttDXkRVJNJBM1FqvQUF588w6Xjur/SJL/PTQdge2nNMGIK
	vIw+cucLaZhiO8tiIlFjpKpbNFaa4hI+mhAH5kAd5zazRQVIF5zzXsDbC0ObuJYX7ixuOwaRlKN
	cLZw3yiMhpsA2ZocHuCEOGmiyfhVmaXA8Xs+qJDtTO9jZroYoqDf8FoQQf4vi29EEHDpTOSrr/b
	wmWG5LZWDUS9BDwN91nNu2cUVTqOtbx1bOCWPERVWYRjkpEvUBlLDkkNclt98ijFToiUFdzsWcq
	yEVarTc5Us0gYkCF2Uzi3bFdh8RIcIWnG26QxsauiBTcJuDZsPo0dRmjRpFQ==
X-Received: by 2002:a05:6a21:6e46:b0:39b:d937:8020 with SMTP id adf61e73a8af0-3c08eed0254mr6855077637.42.1783447376468;
        Tue, 07 Jul 2026 11:02:56 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm16299294c88.14.2026.07.07.11.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:02:55 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Xiang Mei <xmei5@asu.edu>,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] xfs: reject attr leaf blocks with inconsistent usedbytes
Date: Tue,  7 Jul 2026 11:02:38 -0700
Message-ID: <20260707180235.1142581-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs_attr3_leaf_verify() checks each attr leaf entry on its own, but never
checks that the entries' nameval regions are disjoint. A crafted leaf can
point several entries at overlapping offsets: every entry passes the
per-entry check, yet the summed entry sizes far exceed the nameval region.

ichdr.usedbytes is kept as the exact sum of the entries'
xfs_attr_leaf_entsize() (see xfs_attr3_leaf_add()), so for such a leaf the
real sum no longer matches usedbytes. When the leaf is later repacked,
xfs_attr3_leaf_compact() resets firstused to blksize and calls
xfs_attr3_leaf_moveents(), which subtracts each entry size from firstused;
the oversized sum underflows the 32-bit firstused and the following memmove
writes out of bounds. The same repack runs from xfs_attr3_leaf_rebalance()
and xfs_attr3_leaf_unbalance(). The only guard is an ASSERT, which is
compiled out on production kernels.

A single setxattr() on a file with such a leaf, after mounting a crafted
image, triggers the write:

  BUG: KASAN: use-after-free in xfs_attr3_leaf_moveents (fs/xfs/libxfs/xfs_attr_leaf.c:2788)
  Write of size 400 at addr ffff88802b187f98 by task exploit
   xfs_attr3_leaf_moveents (fs/xfs/libxfs/xfs_attr_leaf.c:2788)
   xfs_attr3_leaf_compact (fs/xfs/libxfs/xfs_attr_leaf.c:1790)
   xfs_attr3_leaf_add (fs/xfs/libxfs/xfs_attr_leaf.c:1563)
   xfs_attr_set_iter (fs/xfs/libxfs/xfs_attr.c:556)
   xfs_attr_set (fs/xfs/libxfs/xfs_attr.c:1244)
   xfs_xattr_set (fs/xfs/xfs_xattr.c:186)
   __vfs_setxattr (fs/xattr.c:218)
   vfs_setxattr (fs/xattr.c:339)
   __x64_sys_fsetxattr (fs/xattr.c:774)

Sum the entry sizes while verifying and reject the leaf unless the sum
equals usedbytes (so the on-disk usedbytes can be trusted) and that
usedbytes fits in the nameval region [firstused, blksize) (so the trusted
value cannot drive firstused below zero).  Both checks are required: the
first alone can be bypassed by forging usedbytes to equal the real sum, and
the second alone by forging a small usedbytes, so only together do they
bound the actual summed entry size against the nameval region and prevent
the underflow.

Fixes: c84760659dcf ("xfs: check attribute leaf block structure")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2: drop the inaccurate scrubber reference; explain why both checks are
    needed. No code change.

 fs/xfs/libxfs/xfs_attr_leaf.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 86c5c09a5db4..9814dcfbd7ac 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -300,7 +300,8 @@ xfs_attr3_leaf_verify_entry(
 	struct xfs_attr3_icleaf_hdr		*leafhdr,
 	struct xfs_attr_leaf_entry		*ent,
 	int					idx,
-	__u32					*last_hashval)
+	__u32					*last_hashval,
+	unsigned int				*usedbytes)
 {
 	struct xfs_attr_leaf_name_local		*lentry;
 	struct xfs_attr_leaf_name_remote	*rentry;
@@ -344,6 +345,7 @@ xfs_attr3_leaf_verify_entry(
 	if (name_end > buf_end)
 		return __this_address;
 
+	*usedbytes += namesize;
 	return NULL;
 }
 
@@ -376,6 +378,7 @@ xfs_attr3_leaf_verify(
 	char				*buf_end;
 	uint32_t			end;	/* must be 32bit - see below */
 	__u32				last_hashval = 0;
+	unsigned int			usedbytes = 0;
 	int				i;
 	xfs_failaddr_t			fa;
 
@@ -410,11 +413,21 @@ xfs_attr3_leaf_verify(
 	buf_end = (char *)bp->b_addr + mp->m_attr_geo->blksize;
 	for (i = 0, ent = entries; i < ichdr.count; ent++, i++) {
 		fa = xfs_attr3_leaf_verify_entry(mp, buf_end, leaf, &ichdr,
-				ent, i, &last_hashval);
+				ent, i, &last_hashval, &usedbytes);
 		if (fa)
 			return fa;
 	}
 
+	/*
+	 * usedbytes must equal the summed entry sizes and fit in the
+	 * nameval region; otherwise a later repack underflows firstused
+	 * in xfs_attr3_leaf_moveents().
+	 */
+	if (usedbytes != ichdr.usedbytes)
+		return __this_address;
+	if (ichdr.usedbytes > mp->m_attr_geo->blksize - ichdr.firstused)
+		return __this_address;
+
 	/*
 	 * Quickly check the freemap information.  Attribute data has to be
 	 * aligned to 4-byte boundaries, and likewise for the free space.
-- 
2.43.0

