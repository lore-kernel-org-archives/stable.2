Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF93E2AB9
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787409226; cv=none; b=AzM8ZkoAOOY5LeZzu5pg1xtR4At539NkhJFRZWuSfmv/WiicFVgtrJyrbei3ifKnAWUY+jCNO2VSH5Tt9ZnHMVGA6E4wxTrnhBvp+x1EfEfvlsa7NZCYjsdLunc+MTmt58LdQwuykVSho98Q5gPtxU+dCyXExydkAXqlDAOohPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787409226; c=relaxed/simple;
	bh=O75aJsjqWRTKOyF9lF+KMK/BaLq0JLQHHNFq2vo1ctQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3JzYz+yVS6tNFLfOY5XuwocRXRiLCvzElB3/MhlMQa8J2m9rUTPZS7571LkNNkaSIOXlisER2UGAiM2MR7NRuReMc3RpW/0gac//qz+N6srE0C1pMQqAwB32n6mYl8ekJfGTsKyY3aUufVzEo1NZYgXUgmrx3QU++CM5l1Ql3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpzU4693; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpzU4693"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so2992901a12.2
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787409220; x=1788014020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IdHnfPP19LuCe1htvM6rTR3Vijz/0/LUnIK+qvqxgNU=;
        b=JpzU4693kaZxV1j04Si2uWuUMhFhqUPFtBAUksealoAlZ5p9D8oXteXXZPI0xOMhLx
         bkHMrl9lzlNkfTfiicwx+xf6b+2ms3E6UFJ39ZgDNsXSu6NRSTKLl1HSPcAFE2Fz2f5v
         vJWPpjYAK/5vb0gYUw0qpus3lQbDRAzSzYHP/rBrC9wqlhWTvcmsPlPRKEDkwOzjsK5O
         wzgZYIZwWyVcsIQkVXjzeNXHKGFpbd3YfyhlMuQjpPUSTWR9AeInu+NEcHqYClw9ZGd7
         8c1bbayWW1gdVtrMPMG6uWDcMthqYvGEwEFTZodUe/RYkKsV/1ZU+pE2Y5tNo1SFWvHw
         4pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787409220; x=1788014020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IdHnfPP19LuCe1htvM6rTR3Vijz/0/LUnIK+qvqxgNU=;
        b=X+LFJVR4MbgEizhYaTLvCEgpxNOtLkSL7+A8nyZq6t5CYFyUwualryABABCLlzyEGj
         TMsGa1Yf7Lh1aeyEvXYvz7+aAVNp25rQ0E9y7xr2b+ZUC8w45SGHhwF+owHmsdJhgMTE
         +OWUArJNiJm6IZuvORGuhor+BzXK8RFQROpD3q2xCFJgEWvUjMK7Z2c1NXvw//99Fcdz
         lMDhUGTSJZFnHRloIJUmhSOqXtrI8R/xuyC/FTyYn0NhSd26kGjv+JHR4mBnpHBVW96r
         rDoc+R6rfQ7yFksTpPWOWGPl+kSv7/0Ni/naYwOZkwMFEXtsjNgUZs/pLuV4hJzcgxgj
         MoPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8V4ESG6wyhALtszHZygvBddd9OrJykfSKamlgCV8SBH+a1Yq4YSpW4ruOIIBwLJ/x6PvZA6M=@vger.kernel.org
X-Gm-Message-State: AFuF++kcd1aOE6+crDR0njswBTdzDXVzEZgJekLQ0X6xFg5MYMJQQIEU
	Lar6s7T9t9XXH5+l26ADglTzHJE4VhmfxBB/EFyMsqEToQKvnXzdkUt2
X-Gm-Gg: AR+sD11qoCylXfvznBoRGdRe0Jz+hQ1LI3tkmYQ8JTVwbrj+I94Dgrk6iIlKI1suK16
	qH8VlPdvQZoegfU1XQcBucsLvY7CvQvTm5WoqIyjRmcFlqt5tK51DbOP6+9qhja4MDgFMlb33p9
	lsUOVVDFW8QGSLbs9jKmVZmtUy6+++evdEaIzno05CTZK8qnI74f2Va9IoAGCXFZsnZA88Kpyro
	xBSb7H5fYKIQHQHwe/lRxpA5bmZc1EjklKpHjp9D0puHWBQn46zycTwBCjneL+0khzM8iYpw9b6
	ZDOg/uunsMCD80Odceb0ESpGyJI7N4m5foW+4GFiEi87tIKs5Rpekj8Xj/qyQm8GZxQZy/QzWoc
	3yR17PKGF7XWj5RlWlEX1AMHxYFEFD4lnF1ND/NMR01k94+E7hf+MAhjcWpLVONaQEtYMsP3Azi
	p62hAHMeSfZ2Tbq8yraNHA64EZq9wW5qiUhcE9NSjP183WdhMDl70/q1/r+Y7xKSol6JqVxmcsd
	VAQkba+R7grZ3W7ngOFsz9Rn3riw8STteQ8CJJ+SInjrS03s+DQDnQqp3O07Izonb/I1Er//n0z
	gsLi0/pgvUq9kJz/vWPp0Q9qp44JcHj42zX9pILMnjEVmNFEh5WXwLfN0RgeWIJypkdU
X-Received: by 2002:a17:906:fd81:b0:c21:35d0:f43d with SMTP id a640c23a62f3a-c246a6c52c2mr1473232666b.16.1787409219699;
        Sat, 22 Aug 2026 07:33:39 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967459aesm326597666b.48.2026.08.22.07.33.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 07:33:39 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] squashfs: make the fragment index table bounds check overflow-safe
Date: Sat, 22 Aug 2026 16:33:28 +0200
Message-Id: <20260822143328.68867-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822143328.68867-1-kmehltretter@gmail.com>
References: <20260822143328.68867-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

squashfs_read_fragment_index_table() checks that the table fits before
the next one with:

	if (fragment_table_start + length > next_table)
		return ERR_PTR(-EINVAL);

fragment_table_start comes from the superblock and is not validated
before this point. A start of 2^64 - length wraps the sum to zero, so
the check passes regardless of next_table and fails to reject the
invalid table ordering.

length then reaches kmalloc() through squashfs_read_table(). A
fragment count of 0xffffffff asks for 64MB, order 14. GFP_KERNEL does
not include __GFP_NOWARN, so the page allocator warns before the mount
fails with -ENOMEM. With panic_on_warn, the warning panics the kernel.

Compare the operands instead of adding them. id.c and export.c avoid
the same wrap with an exact-size check. Keep the inequality here because
a gap before the next table is still allowed.

Fixes: 1cac63cc9b2f ("Squashfs: add sanity checks to fragment reading at mount time")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/squashfs/fragment.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/fragment.c b/fs/squashfs/fragment.c
index 49602b9a42e19..b46673d1077a0 100644
--- a/fs/squashfs/fragment.c
+++ b/fs/squashfs/fragment.c
@@ -69,9 +69,11 @@ __le64 *squashfs_read_fragment_index_table(struct super_block *sb,
 	/*
 	 * Sanity check, length bytes should not extend into the next table -
 	 * this check also traps instances where fragment_table_start is
-	 * incorrectly larger than the next table start
+	 * incorrectly larger than the next table start.  Both values are read
+	 * from the filesystem image, so compare without adding them.
 	 */
-	if (fragment_table_start + length > next_table)
+	if (fragment_table_start > next_table ||
+	    length > next_table - fragment_table_start)
 		return ERR_PTR(-EINVAL);
 
 	table = squashfs_read_table(sb, fragment_table_start, length);
-- 
2.53.0
