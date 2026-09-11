Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4E04BEE49
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164029; cv=none; b=PgaDy+fwfl+MBdPGUBbaksKIO77JzUnp+fVItjtBgN7PXYAVhFap+JaNQL9EyhL43p4+Rx0I+O5rJF8ZEAGQhyE3EY8OlFoS3ij8JyCc1183jam16KtWKWNihwE6/zbOYQYeKqfTRCj+uOrcHXFitvAu2x8S2EKzLk/+JWA75rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164029; c=relaxed/simple;
	bh=5R521DIFF62gYKCENCi75GUDpX6n5jyciKRehvJ9WdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNXSeoYe27AYFSbHYznNTWFQM6zSLGFqSlo4naQoYJHO9MBHjNPjTEHthWqx9VLEab2BxyCR8d7Uzonwj7+vNxxl+jmt9uCfOMfS1S6gbNUmEcd1XXtZF7WTc8rJUHH9QAGLwritY19UT0Du2hDMVVDhLp2yHMSS9UYiR6Zh8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy/M5AXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy/M5AXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6125B1F000FF;
	Fri, 11 Sep 2026 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164027;
	bh=hPC6vYe4NMJKg0XjHAyVKqAhmBsT/CZgoJO37qwTVuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uy/M5AXf/yr0LumcD+FIqf4N46SWVRe/rNi4kROJ8zcbWqITsgb7XQbAwfkaEug0o
	 /dLHp12egtXe6EixcWCPB9oGoyOxx1EvBGb03F02zeX1mLKbLGagOAJ7frha6SJXzL
	 XJJU1J9yO1g3q2ROYTVFykWaJSzyyMVI3/+fLQSjoj7K8BkMcZgLW7/XsNq9Ty2hRE
	 T78UVxVxKxqXXgl2ledG3VTUs+QQcPnXLhOCpSLDp+BDrJ5D4HCsmOu4nz2hkim7Ld
	 XrhMc/c9DhTwr0nV6838TCZCrWr8uBdVYzF1m1IRGYPUylIjD1gZlH3uMpTE/06yaw
	 L9ah9vkattJpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] f2fs: delete f2fs_get_new_segment() declaration
Date: Fri, 11 Sep 2026 18:00:22 -0400
Message-ID: <20260911220025.1624949-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090946-clumsily-stuck-0ea2@gregkh>
References: <2026090946-clumsily-stuck-0ea2@gregkh>
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
index 63d3450f895ee..7ad3c976a773f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3737,8 +3737,6 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
 void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_get_new_segment(struct f2fs_sb_info *sbi,
-			unsigned int *newseg, bool new_sec, int dir);
 void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
-- 
2.53.0

