Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E63D0938
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781738032; cv=none; b=NuiXXJnUtS3BP+iCxtGKp7nu/vwcHZVFe5+nwk0AgLTG1tQPyEedbyLlTpnZumIv9Uiass6do8HqyLAEvaECUzHidjKBYAiuTc/vPQWzN98YAyu1L9o3dmlKl6D54IUipzvqXZ/dqBLlcihOTue4r62rL7Rce04reZv/TSV6uk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781738032; c=relaxed/simple;
	bh=yRpTV2fREwzzqOKDQ1mQKF+YgHG+RYpUg5V3/o+sfI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlQaoBIFj9lDP1Yrxcy/ACikn2Ey7PKF/KOmC/KNaMpRALYV5OfA0lVLx5ubxmsBK9pT1VyWWgdQ7PSXfmngv9b9nKl6cQAzykbsddKMdZsHImwYEn1VKnN6h8nS4G7TGzEhlaYqHQRygiyBpal3fHeg88ehNX04nfoglnXFw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=TFKrChDM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="TFKrChDM"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842358aaf36so85884b3a.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 16:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781738031; x=1782342831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1WZSdnDOexkXvu4kbAp0KpA84CDGtsQuc6Gr9g6y/4=;
        b=TFKrChDMnKdCcwz0uXwxKbJ6fxc9l2rBd8rE+WRt3f/JfCoMpjetIblwa+zULCirE4
         XoGdg2i5TgkhFpAvItbydLX8Jowckycw9Q0rJOHJ9UQdENhCfvU109D4k4MyNYnoBQrV
         j4+wzaigeLmCrx4vKM7jcSYyKgyNpAaB0xdBLRywT280hE+KEGHL4IL8yygY+/Kj7npL
         e4Nmm4EMkqlxyxqhtHGHz9CLKlowQo1nT7EiFgn8u6KUmWpveaKUhkceZxnyFAqa5bWw
         OkCv2VDHM9dktv+3UA47edRnzt7fUZBF0tbmXsmOjQFq/3BIh12nrcYtOUhsVaWjj4V3
         wkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781738031; x=1782342831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t1WZSdnDOexkXvu4kbAp0KpA84CDGtsQuc6Gr9g6y/4=;
        b=MEzHvkyFNLnZjIvmD/LiO5rfnqkZJJiNraarHW+CBL5yJPA5Lv1bg7SCL6/W1weVty
         iGRrYQ3tzSgI6VYXCFOQYND5azJRw1gCoB1uMiU/BoDo6LP63yaMDIB25G3mMH4yV9Vc
         mSnmi9Dk9uOAIUBXHItGwZZGVrgmePUcx+HBoYjzi1g4vfFkmUNEF4jAWWG+mBmGvkDS
         aTfmBt/aUjdlJsMrO4K3DnxrcF50CcmrZEnanBzEWtjRzBhvSGtJ9UdUxVCrlYAJN8z7
         RgAExpWvTfGZFbigJT7Wki6GJqZl/NU2rxMgnJH6m5Ecc73zmMs/w4zebilelZtL58YT
         eiOA==
X-Forwarded-Encrypted: i=1; AFNElJ+7v0RugAzhS3Nb2VPgMx1vtLyjZfuI0AP0FCcASfQ2erTRNRMfabEy/JsYbfKQK1QMs2vPtEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH9R+mEmtuR7irZ6CsLcWb+f7246VyEfiaaLH2dC+fbrB5PwbR
	Qi5LtZQmjYxpVfLt7ZFQln0mp1JJzPrj5YUX70ITyzuNjd2r/1kIpjvTCn0vFmtZDg==
X-Gm-Gg: AfdE7cmxbXQPul2+3LhJW048+nwdkrY+aKBjV4+9zW/ccXmNenqor3cm/rgb/mLkSSk
	bs0E8smkx8CSAQUYQX6lmJjaA4LIsLYPTaQH9ciVtFxVhUm79aaxJ8++RhB9miqyg3es2V3FM+a
	gr/b32EbM3zhqU0ufEUQeo10D/jN4YnUmFLppeoFg7yJ7ibfhhMZc5rTUjCzvY8uOlfjc9PnkMO
	riFYkeheM/ARyp4W26uP07u7CGRvkPsom/jkl+xZYgWOUcMAqs9Lk13BrzD2J37S4fC9rcGX0IS
	BUUMF0HNnZIcYuVCMl210oX1/YVx49dBHeGiZipaL2yLwJGTUbEdGvEmfp6EHSHtYu6Yj6d9aHr
	7RBimbtzruvycpqcQYiEKE3VgCPGXUcFbRjrBa3jKsQjZTla4eS4kN2k6gdWdwK9ikGF8YLNzMw
	==
X-Received: by 2002:a05:6a00:238c:b0:842:5712:c2c2 with SMTP id d2e1a72fcca58-8453b3a63cemr907532b3a.41.1781738030668;
        Wed, 17 Jun 2026 16:13:50 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec29:4018:2b5d:3e92:f9ad:889c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf4b5csm21073427b3a.23.2026.06.17.16.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 16:13:50 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] fs/ntfs3: validate dirty page table on log replay
Date: Wed, 17 Jun 2026 16:13:42 -0700
Message-ID: <20260617231343.403432-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617231343.403432-1-xmei5@asu.edu>
References: <20260617231343.403432-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each DIR_PAGE_ENTRY ends in a page_lcns[] array whose length is the on-disk
lcns_follow field. check_rstbl() validates the table bookkeeping but never
checks that this array fits in the entry, so a crafted lcns_follow lets the
v0->v1 conversion memmove and later replay passes run off the entry.

Add check_dp_table() to reject, right after check_rstbl(), any entry larger
than its size claims via struct_size() (the same expression used to allocate
these entries, so the check is overflow-safe by construction). All consumers
can then trust lcns_follow as the real capacity. This covers every
page_lcns[] access whose index is bounded by the entry itself (the
conversion memmove, the HotFix store via find_dp(), and the self-bounded
scan loops). Accesses whose index comes from the log record need a separate
bound and are handled in a follow-up patch.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: resend to public mailing list

 fs/ntfs3/fslog.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index acfa18b84401..b1ca84d83de5 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -778,6 +778,20 @@ static bool check_rstbl(const struct RESTART_TABLE *rt, size_t bytes)
 	return true;
 }
 
+static bool check_dp_table(const struct RESTART_TABLE *dptbl)
+{
+	u32 rsize = le16_to_cpu(dptbl->size);
+	struct DIR_PAGE_ENTRY *dp = NULL;
+
+	while ((dp = enum_rstbl((struct RESTART_TABLE *)dptbl, dp))) {
+		if (struct_size(dp, page_lcns, le32_to_cpu(dp->lcns_follow)) >
+		    rsize)
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * free_rsttbl_idx - Free a previously allocated index a Restart Table.
  */
@@ -4209,6 +4223,11 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto out;
 	}
 
+	if (!check_dp_table(rt)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	dptbl = kmemdup(rt, t32, GFP_NOFS);
 	if (!dptbl) {
 		err = -ENOMEM;
-- 
2.43.0

