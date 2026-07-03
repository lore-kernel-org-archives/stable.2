Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376E407570
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091769; cv=none; b=S8U6r5CxVLT4ouAToJwah8nrqR2OG1yBUB78RjaHFLYN/Ns+myGzL+E9xvJoQ1MbrHjqHKkQxu6ZoUHlzYWyyHWhUXvTuh3sdky2t2P47qqIzBnH8r98/lBoTdz+5ow4D925DvaKQMbLrpBJrb2qvbb41msHTDoao6PveADLqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091769; c=relaxed/simple;
	bh=J9qnVuOG5fhGRzUZnT24UCrwxiapCHvz+6W7DVH2BUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8S/Juvo6W3SWldRmvgR5h+EQLSvMhqNVhQhxev/xNpW+yjI/1hfTL9nGLUR6P+XCamuOYOyb/62H0dm1LXy2IcqtzNnLHlhk1TJZI6Z6YOARgh15djD3RK0I6DnqzkckCsvAdPfSikvSqMfXFGLn4/liCcP+xT3FWS6HX8tgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVho8WpS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVho8WpS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37dedd62b90so643946a91.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783091768; x=1783696568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tbHH5Cu3nnovpCMyns6cOTHcPcimmGBMpGo53wRVoHA=;
        b=qVho8WpSgp89V2RIT1WJLw/WglkNXWKiKrxatjiDm1yizqFZNHgpFZYG56FsmRPmJi
         vjwDCgPkuMkfRrJVAA7kPdLWfSDxvf1EAZQq0rTVKbmlMLAD3U0xcpsZTo5e0lOTR695
         EHSbU9KwQsq8GGtEeiFKpb/EXNKY7ViEHk5dB7B30eFlr4XceWNSYFvUM6DoJGtMLNgL
         tzNTHt4QTc6HZ28cVTNyeNJbQ7hM14/JW2SZ6I2A9zyOeZwYqnwWKtaarq4ts7w650kU
         vOrxIntLxEQbB0wt74qKgKhed0YhTvIyGlN+d7iNbAybuOG4Y1ThCpxHWU5iK6farHt6
         td8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091768; x=1783696568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbHH5Cu3nnovpCMyns6cOTHcPcimmGBMpGo53wRVoHA=;
        b=J9w1cN/uIfGS8qRlABjqbF7By9Hk7ie9TjGv+3Uik5V2FY20Uj05MQ4iNowEuPfzTf
         GkdZ1wJwT/3IkQk1V1xnbCyNUt6ZJ1VARTkL/z9w/UoJfBAOHHl0Nts6CTQRC0uX2uU/
         OTaM9YAvibWoNak2A7VOH5gpDJX342rtts0gOE9Q5v5lzDTJYnEz+u9fXBkBqcysbDfx
         us8W3D2Fa+Pf0J5bFBbpMR/GCY0t49UNLNszBcprkhYlcGhmjIK2QUZooHlUcrrmwZ1r
         0glrJ/gJZeRq3hyitIIA0MwsijREUZUNOnLLtsKRgKlwnnohkNqwDFrms/FqQ7RIbv9S
         Xr7A==
X-Forwarded-Encrypted: i=1; AHgh+RoNqmXdXkeF/FA001hkPVBd/wJRb2BPkIkAki4mBfNmowBYGu3GkqfU7g/MYfoDvDl9afRCERo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNO277NFucAU0GZjULtSxoyttQ8f4xUZ672M6Q0FVa4R5LfJ2
	DcAIa/vueqsqfYJt5hFMhFaw6HY6Fjgg3VPS4gklmFRuHKk7J+2A9BhE
X-Gm-Gg: AfdE7clakZKUXAIg8Cxwcj7ajKI63141TxhVrvPSCpkNGa4LZrQHEkHVzFyDjY0vAna
	pREgkOl/o7amf6rac+dCr1FTyDzRmMySp/AuBPZiywvEJmv4ufa+iqM6RN4KA6zeL0/J3UZ/6CQ
	NAOrC+RCtI+QN0bpNlxuE9qLIQExfahQb1DLa/Twbcdwz3cv4BKYf6Lwm4MzMb2xbeAM3wz3Ap1
	dukNHfMfAgU6LKJ+aPiRdodvgvcyiX6Tc3mNuKTwyi5rkDgLhBOgbMIxo/HxBTzAxmUU8Re3hbO
	ZfkbIVGFSSiLaOe96g2HPhnrWOyRKofe++BY65dmioxpxqP+7XMDgunzIJZmwDQX/xGS28A8HoS
	WdGRVX/ECQqyyURHDCsu8mIjQHqyk3lrnE4TI/AHZ6dYlA240ZW7erlpzXaiO/6s+w2oF1Bdau/
	F8cjwywoiv2ktfAWpNM9RDu3ErtfmwmE+fk4Y3JGygR4YFafGxYqKNJGOz6g==
X-Received: by 2002:a17:90b:554c:b0:37f:e5b1:ec4b with SMTP id 98e67ed59e1d1-381120a7628mr5326181a91.5.1783091767561;
        Fri, 03 Jul 2026 08:16:07 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef5b3sm29352761c88.1.2026.07.03.08.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:16:06 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Xiang Mei <xmei5@asu.edu>,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfs: reject attr leaf blocks with inconsistent usedbytes
Date: Fri,  3 Jul 2026 08:15:44 -0700
Message-ID: <20260703151543.3335583-2-bestswngs@gmail.com>
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
equals usedbytes and usedbytes fits in [firstused, blksize).  The online
scrubber already validates this in xchk_xattr_block(); this brings the
read/write verifier in line with it so the bad leaf is rejected before any
reshape can run.

Fixes: c84760659dcf ("xfs: check attribute leaf block structure")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
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

