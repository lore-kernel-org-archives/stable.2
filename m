Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B797B331ED5
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176741; cv=none; b=UkGAS75nipNE5qg9I7RHv6SDdiy4Cpx//GiysEh4i7BKwS9ZVr4qOsGtxwv0f2PnJha8K3dXTFNvwEdmDHpNBXFx98FVRnn+cboPCbv41vOPH6mF7GeagMnDw3EbnBjsjEJF1GGYVdElaVrRXKwNyJkIcS+nhK2WMVK2dRHkYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176741; c=relaxed/simple;
	bh=RVpuetfgyaGTJT9VQdmia5nKKjd0rKyoCs+D535mBWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giSefNmLNt/b87PJRwEVz/82hpYv6Gqx2YpBRhjokc8RApdm3EEGschmacRh/6TanLvgGV65qo/hlspcCK41pHXDX5kvM2PMg/gB9oodlazQ0GwIVobE6+TTabLlMb60D2qZYUhEk+wS7nD365hL6yNLHmjRPTN8kCbAQREuRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+ZXIlfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+ZXIlfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216B41F00893;
	Sat, 12 Sep 2026 01:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176740;
	bh=l7gVW+h19/1fr9WW9ULhjhvm40VLGmt6/XQUhPo1LvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+ZXIlfgEqITvxLnryFouuBkM5TrnQAWrMHNXaCJ8JJjTYlp1vlAKNhYsaenhaKEd
	 hRHhWXzRuxW3czjJ9XJ8kbhcIhR+4nx9bN3ymUhHHlhwN3bdasMAhQImzUH0CquJCk
	 s5F7F9UJiGPL8A71FkW8iSCBXFqW7iASKAtaW9yQBD6VfXYwjOYSRVg7k8o3uwVQok
	 ldGDzRIC1gsEFc1VXFR03EZKH+vbKIbSr3MVmq7RjCCppkF0s2L7llNAc8OeFmu32k
	 uybxU8PyD8kLoK/Rr4CX/XzDtFmbbKldD7k1wX9jIxKCEfDLi0Edz+yWfY0tQ/n9nQ
	 P3Sx31a/uBo4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] f2fs: delete f2fs_get_new_segment() declaration
Date: Fri, 11 Sep 2026 21:32:16 -0400
Message-ID: <20260912013218.1761900-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090947-whimsical-pleat-2344@gregkh>
References: <2026090947-whimsical-pleat-2344@gregkh>
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
index cbf4032b5b7ee..4fa1e514a84bb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3653,8 +3653,6 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
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

