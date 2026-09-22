Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587805372D5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075065; cv=none; b=ayKUKB4oBJaeGppYvUtD0HNDYFJen+2TQi94JeB1YiPT34w9jlwJ7LeoDLa74FunJZ5hwExGDhUpIVF/250kR/n12nZ7dkdbkw+c9aZ62ieo6uX5eaEab8MjmVenlE8t8tatlLXZeiUzri7SMhXWyJPzFW/6weC3AWN6dap/DK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075065; c=relaxed/simple;
	bh=vg6esyL80BRHTOn2RKdQsEP5Z0qqw6yJiAj33+RboZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjaYGirmjPGn8z8RGBgVxwC5KA1RsOXIGCG+LAizPGsDYV/BEvf9ve9LjyIIvLpF5qlcqsFpmMYBT7MBy827QPadyYL9ljbvexb17Jy8MnG51bpwIQqyNXBuR8yIrIunggJyZwnUnga3vKu1b2PZeEhDYDyjvblgJuybCakpxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdBG/v8T; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdBG/v8T"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so21578865e9.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075062; x=1790679862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i6DLB7gv/Gz4t7rzT9Q+d1mEFmHJd1oumPcFNrvZcJI=;
        b=OdBG/v8T4O/EUiDg4M8hgo7pQ2IkrxrGKJV8E9zST4Hc0RgJfRESlNpA30SYCtQXOW
         NQAKhyICopV7U2VB2tmrdoIua81avgdSsaFFR7A4xWjtkMLY0OL82vZeTaX3af2Jn8oc
         KqMt7cKEUkGYzrtU+rgRDnlmaLgUFGl3L/ova7HyYo/n+VIP+ykXjjr6r+1AleZPRkV8
         nvszJ8rnTF/0TId/ljIkcFkffXdOV9DDUZ8waq1cY7eTNKzu7Hy0HzFq8XULOj4LXyas
         rU+j68c+FFLu16Hs6sVy5UWZ6zubhakjjBlxvcUeUs+Mlg10qxcr3b+CMla8Odm2XCCj
         PqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075062; x=1790679862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i6DLB7gv/Gz4t7rzT9Q+d1mEFmHJd1oumPcFNrvZcJI=;
        b=LvxLIrpbNshIODVzZH4JaQbmXLHOAy2muvLeUzrNOkRVTlKje643mZn9jp3ARpIcLI
         OZQ0elZuPS78Y+KdJRzBsEkIXQs5gL6lo26lpJP7c7xyB80FA9gm6Uwe53eLQyZm2hwh
         kXvTscKHa6CYfqXDOTqXNYZ8HZFOGbu1N/J6Pn5opW6dZMEVO2YH8wfqT8dzoJWK2SO1
         y/7omYJyABOBTkaPb3PhsD6s5nd1PUMFvHiR898RZ2DbAKkk93q7mVAvyNRjgwF0J/uI
         W+2xTBlQ1Sz5kEjvnIqxO7ftdr40EZERnRDfEgKSbOfBIZ20UDEPbNmy+Hsf2CW6A9FE
         NDJA==
X-Forwarded-Encrypted: i=1; AKwUvBxq8i7Cq9P7e7xfz6W/7FHGrrD0lCPrlNegHh/ub1GMFpgBjX5P2QlIWSC8ZAp2R/RJ6ings48=@vger.kernel.org
X-Gm-Message-State: AFuF++naWFFVMCkqzl4TAtY/bFqQvijgDMOYIkMK/fXcq4RJrbzbbsnQ
	Gc0YnJxUHUHs+L4Y3FrcNpfX7G22jTRpWx3a+ljZrGKjVc3oWt+zrNvG
X-Gm-Gg: AYBFou3N7BvL903vKXBrstvNgSJJGL6rbR41J5o49nnIQMoBEpTegZuSCQnbJhFYWJT
	Au/e+jH1f3UbOHWYCyB07ZW7sdsNnout/v3vsuEFkY3yq5wlGPa1vgh4BCWQvidXmpUF52iNVrQ
	Goo6kVOtlzA0sUnQ5qdErKGHSowL0vwvjAPob5EVsk5o1E6WFTVdYa+eCFCllqOwgJ2MFZWOJME
	lDQN11Er6uoVT8HleqQIukF7r0EZkLZhzHq2EwzMVKBGbJi4Qers/lANQXZpAffUb2zwG1RwV+C
	b3pntLBr3IxiNx8vw6nB94yRdEgCYbBObZDCLtvbTClToAjEuS35SE8jIVDd4bR2ELCYPj23bLF
	L7/dFsb5iH5cujnFPu8Jndl72wnuU49mUHaVQEPa0ZNwFgFF0K4olENtVBktEpe+qlfebGiJWSy
	3W5ijHpz1zGqJx2swgNga6oycb/xJ8PdtNnaXOdOeGYmb8SnfX9LlpCkz/XJe5046tsa/hURJP6
	jR4MeqOz699UZT6g/aoOuym2jPALNL5
X-Received: by 2002:a05:600c:34c4:b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-49fce783626mr138458715e9.21.1790075062179;
        Tue, 22 Sep 2026 04:04:22 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:21 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 09/26] xfs: use the correct reservations for rtrmap/refcount recovery
Date: Tue, 22 Sep 2026 13:02:04 +0200
Message-ID: <20260922110221.1431-9-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

LOLLM noticed that we might reserve the wrong number of blocks for
recovering rtrmap and rtrefcount updates after a crash.  Fix that.

Cc: stable@vger.kernel.org # v6.14
Fixes: 5e0679d1c62f25 ("xfs: support recovering rmap intent items targetting realtime extents")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_refcount_item.c | 8 ++++++--
 fs/xfs/xfs_rmap_item.c     | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 8bccf89a7766..682c6e1b45e3 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -508,6 +508,7 @@ xfs_refcount_recover_work(
 	struct xfs_cui_log_item		*cuip = CUI_ITEM(lip);
 	struct xfs_trans		*tp;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
+	unsigned int			dblocks;
 	bool				isrt = xfs_cui_item_isrt(lip);
 	int				i;
 	int				error = 0;
@@ -543,8 +544,11 @@ xfs_refcount_recover_work(
 	 * full btree split on either end of the refcount range.
 	 */
 	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
-	error = xfs_trans_alloc(mp, &resv, mp->m_refc_maxlevels * 2, 0,
-			XFS_TRANS_RESERVE, &tp);
+	if (isrt)
+		dblocks = mp->m_rtrefc_maxlevels * 2;
+	else
+		dblocks = mp->m_refc_maxlevels * 2;
+	error = xfs_trans_alloc(mp, &resv, dblocks, 0, XFS_TRANS_RESERVE, &tp);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 2a3a73a8566d..000cff1ce324 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -573,6 +573,7 @@ xfs_rmap_recover_work(
 	struct xfs_rui_log_item		*ruip = RUI_ITEM(lip);
 	struct xfs_trans		*tp;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
+	unsigned int			dblocks;
 	bool				isrt = xfs_rui_item_isrt(lip);
 	int				i;
 	int				error = 0;
@@ -596,8 +597,11 @@ xfs_rmap_recover_work(
 	}
 
 	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
-	error = xfs_trans_alloc(mp, &resv, mp->m_rmap_maxlevels, 0,
-			XFS_TRANS_RESERVE, &tp);
+	if (isrt)
+		dblocks = mp->m_rtrmap_maxlevels;
+	else
+		dblocks = mp->m_rmap_maxlevels;
+	error = xfs_trans_alloc(mp, &resv, dblocks, 0, XFS_TRANS_RESERVE, &tp);
 	if (error)
 		return error;
 
-- 
2.55.0

