Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC83A5E93
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688184; cv=none; b=mE3P7Er+Ruln/ZxlrObd5oA+vZ/KXLY/LPtgxXn4vd5STq9wLfo/VU2xfI0ViKRfG1hoPZgFo135aQEZMDKUjt8rBpZs84Fpruo/7xJn0mUma2e+hJiy9e9g10YMRG41QDzAqQf5/RTqO9lmCaXdz7kdXjWYmR2XXh229umbl5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688184; c=relaxed/simple;
	bh=HkzTXWp/0Juq+8uYD0k3DXG4ACO3SdzCm6mHMxe57ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cop2y2W9kgy7x06uNJSh9yN7O2H7jYpFWPly90O0nZQnZ4+rR13pLkgExxSANbYxvWvgpeNh6VAEd73qeh6i3lOMMFM8J+Ave2XqPgMIWuQeeYquf9f0I+6XPONs7t0dT/hxI4Ei4FcEjcsxMeRIhyPbo8PUlbbY+i7/lyLpMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=V4nFU+2g; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="V4nFU+2g"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c85d8615b09so3293198a12.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781688180; x=1782292980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9QEGty2v/cSSuw62QBmZlOmrqqK3D9WfaIXoyJUkPM=;
        b=V4nFU+2gOxJgJ4xb2H2UeZIy/f5ylH/ZE2MBPcUI4Em+G4KqvBrqtOunqmAA57C24q
         EOnVz97mwzpW1gYfed9TYyagB0QsgooMZUQkBhbXXxmJ6UBjt42erCMkDOVuqq67zXgE
         0QHXNjw16GbGFdnUoMwP6kiuNnZVBHxkOdQMjA94aH4AgpSgaOWw9E6+t79O0tOYK3QZ
         EnIRrzpvJc4BSSSOd6kdXi5sGxI0jDCaF7sKtmgVhfVor2iwQxgIIlIGBwRGH3gylBLn
         J9YU79Pdgyi9YRsshNhpUYVzqp3JzfUwCJZqMi6cNIWoB75Pmd3dRA3yO4mNP19qkeKe
         Adrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688180; x=1782292980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N9QEGty2v/cSSuw62QBmZlOmrqqK3D9WfaIXoyJUkPM=;
        b=QuZwVxVEoJd87+E6un44uWNQBgvUce2WxFruHCCFG9plRT0Juglhej8g6RCkhnAkMv
         lEuZCsQ1NU9pQsYeOWWar4rxRVO9arDpanz56zEXv+puIY16HWVssR4ZDQKbnrTsexsC
         SpE4kXgP3tDn994ufNqWxpK687hi0gXjKasyOYTnD8Y6PHHHxzME/qetmcnXB+10V82D
         Zxmh6pYKE/Nw8B7Vvxro6gUCtkDkt/bslhzm0Diu+RRU0Iijkbs/qgpGn616M9kcwNEQ
         eStnfQsoxsuWGoGHs4pdslYauR5pXDlSaw9oCIvPenMWQs7D/bNJLwUWmUmqji5EeloX
         Mkiw==
X-Forwarded-Encrypted: i=1; AFNElJ+ZkC43qI9N4nPg3bO+6eGISUvTWh6fSgwWi7hPZChVcmkSny7iXuaHiW/v7dm494z206YzYjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytRBMW9Yyep78T7N32jNRpFtOpwnSrxtkyD8Gdq8PIe55lvDN6
	g74gXdDhUhvxwY6psig2mwKmJs2Sj/Au0YJ7uFlR8V8jFxEKbkQZb81JZ2sla3enlRj/aKC66ot
	Jzi2D4g==
X-Gm-Gg: Acq92OFRkKNir49MOoGQZJP0yt58SwVzcXsPdiIwdKc4fqx54bTw0OUwB83rnuFb8pF
	YAr6D+QWMJ0vWCYL9NslWUnCDxRCh9WWjoVrUIi1eNqfhBoNmNPdKaWVu5uc4zpHbWsYvaI3bV/
	CergenbvW4Lo6Fi7NgaFdPyaSh4GuA/tqTHiNtkyxv7rZs2fP0X9PAq2uwIoy15bvs34Gome1uA
	GEVWBc4IF2Fej5rs5Vj3R+7FIOm6qmYqEPKfHUyzuO5WAzrXUqyv6HHxiaOz1kl7GjpfvClo50j
	J3yH7pLuNhmrvoeKzOn/2XNZ9U76gmiV84iivrQBmcP5h5D3kK8GpW9MpXBuLAf5eSQN4TtIxIa
	JOyT4QhTJE0VsYPBEwTl7SZjg4zCR3Aw1dxLlCCdc8plbVoMi50B58c0sRirk3WBbULMOWyrwCl
	kiYLxC
X-Received: by 2002:a05:6a20:3d94:b0:3b4:6f45:d8f1 with SMTP id adf61e73a8af0-3b8b76e7e3amr3622997637.26.1781688180186;
        Wed, 17 Jun 2026 02:23:00 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9dc5esm14636685b3a.10.2026.06.17.02.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:22:59 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	security@kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] fs/ntfs3: bound page_lcns[] index by the log record
Date: Wed, 17 Jun 2026 02:22:35 -0700
Message-ID: <20260617092235.99610-3-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617092235.99610-1-xmei5@asu.edu>
References: <20260617092235.99610-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The copy_lcns loop and the redo shorten loop index page_lcns[] at j + i,
where i runs up to the log record's lcns_follow. That count is checked only
against the record's own length, not the target entry, so check_dp_table()
(which validates the entry's lcns_follow) does not cover it: the copy_lcns
entry may even be freshly allocated after that check, and find_dp() bounds j
but not i. A crafted record thus overflows page_lcns[] of an otherwise valid
entry.

Add dp_range_ok() and reject, before each loop, any record whose run does
not fit the entry. These are the only two page_lcns[] accesses indexed by
the record rather than the entry, so together with the entry validation
every access is now bounded.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 fs/ntfs3/fslog.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index b1ca84d83de5..1cc7402fdc2c 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -647,6 +647,14 @@ static inline void *enum_rstbl(struct RESTART_TABLE *t, void *c)
 	return NULL;
 }
 
+/*
+ * dp_range_ok - true if [j, j + count) fits in a page_lcns[cap] array.
+ */
+static inline bool dp_range_ok(size_t j, u32 count, u32 cap)
+{
+	return j < cap && count <= cap - j;
+}
+
 /*
  * find_dp - Search for a @vcn in Dirty Page Table.
  */
@@ -3801,6 +3809,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	u64 t64;
 	u16 t16;
 	u32 t32;
+	size_t j;
 
 	log = kzalloc_obj(struct ntfs_log, GFP_NOFS);
 	if (!log)
@@ -4566,9 +4575,12 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		 * whole routine a loop, case Lcns do not fit below.
 		 */
 		t16 = le16_to_cpu(lrh->lcns_follow);
+		j = le64_to_cpu(lrh->target_vcn) - le64_to_cpu(dp->vcn);
+		if (!dp_range_ok(j, t16, le32_to_cpu(dp->lcns_follow))) {
+			err = -EINVAL;
+			goto out;
+		}
 		for (i = 0; i < t16; i++) {
-			size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
-					    le64_to_cpu(dp->vcn));
 			dp->page_lcns[j + i] = lrh->page_lcns[i];
 		}
 
@@ -4985,8 +4997,14 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	/* Shorten length by any Lcns which were deleted. */
 	saved_len = dlen;
 
+	j = le64_to_cpu(lrh->target_vcn) - le64_to_cpu(dp->vcn);
+	if (!dp_range_ok(j, le16_to_cpu(lrh->lcns_follow),
+			 le32_to_cpu(dp->lcns_follow))) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	for (i = le16_to_cpu(lrh->lcns_follow); i; i--) {
-		size_t j;
 		u32 alen, voff;
 
 		voff = le16_to_cpu(lrh->record_off) +
@@ -4994,7 +5012,6 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		voff += le16_to_cpu(lrh->cluster_off) << SECTOR_SHIFT;
 
 		/* If the Vcn question is allocated, we can just get out. */
-		j = le64_to_cpu(lrh->target_vcn) - le64_to_cpu(dp->vcn);
 		if (dp->page_lcns[j + i - 1])
 			break;
 
-- 
2.43.0

