Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C6F37A498
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212086; cv=none; b=Jro362PhL5fDiagay803Jm6bktAvHgmGDE250P0CmftV7BndfCPm+VR9suyd+RrBigEl7dErLl/PEZYOvYm+/NbqauzVVvMNYkc9CXaWEXjgHdS+m9epsiqNsi1RBcwS9M/0cKUSFxyIPDY39AWLfoeIHFgPuor8YXlPNAiqU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212086; c=relaxed/simple;
	bh=aEbnawLe6+x81eRuVUJme+jorGrnZIFmy9sdGWqqfx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmCnX7jztFXMlCHIJ4gXHIe8wNVHMfPoTfUrQQhyk682/mxGddqrI+xOc60aSHv+QpWFAB8bndw2zzwMhYGXUNaH7V6WYE1jYWvXPcxnwSXr5P1KGChXUi6Hqh1mutbRWdJgzihlppynXATl5gvPk3J/neo/EWYsLJCTb9h69ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikv+H8gp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikv+H8gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D571F00898;
	Sat, 12 Sep 2026 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212085;
	bh=q7JmNwIhTO/HeF9169Wc9QnZGR/m8+AzHk2RhyKSsnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ikv+H8gprt9LYz5xnIbgr9VD9L8jSFDBHGttd1LHX3cCCZPsXv/QPgxDnJLRGYlaD
	 5PxG5l1xaeIWkaeGpPN42iha2/aOA6GQGAmn5kxA2icR8gFroL5HWRWN7FblznviM+
	 CVh64qDF65afah+NkbBZ7lwgicrew+Nl5DNboHet3rncXUsym3zaAzRv+o+LmKIO8t
	 tmclMlhX5JMgKgCHVZYtM8WgruJ/qm1qVHHfnktpHMyRc3Y38NpWFlmLNxaV+sWhgz
	 A8OyY/VqgwVC7LjWVpB2tRVlgF9GEjBrUcq2tlunUlP27jZqi/ODVsgv4H65NHjiiI
	 X/5m4AWlTg48w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] f2fs: delete f2fs_get_new_segment() declaration
Date: Sat, 12 Sep 2026 07:21:21 -0400
Message-ID: <20260912112123.2312505-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090947-bankable-stroller-237b@gregkh>
References: <2026090947-bankable-stroller-237b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit e24e8333d0f3110473c6e6a20afd51911984e901 ]

Commit 093749e296e2 ("f2fs: support age threshold based garbage
collection") added this declaration, but w/ definition, delete
it.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 8ec06f50ddd8 ("f2fs: fix to migrate all curseg types during free_segment_range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 948e3512f60ff..c99436e829af1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3365,8 +3365,6 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
 void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_get_new_segment(struct f2fs_sb_info *sbi,
-			unsigned int *newseg, bool new_sec, int dir);
 void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
-- 
2.53.0

