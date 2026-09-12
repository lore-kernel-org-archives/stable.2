Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A753890FC
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789179746; cv=none; b=pfLupIJKr73t4zR7zrKCnii5rnM3EV8Q/PerP7gzwytOH8gesqthjpOtJzJVwn6dAZ04PGhJS6pMPeStcuSnREba+a/CEEUX14cZFvegv+pzTxJ2NUvb4w+hONzePYh1CL2gjS/4sGCXw67cwkZ63c1dA1Q+yG/cyYJPdV6LNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789179746; c=relaxed/simple;
	bh=iAY3njfexFzxSA2wblnTGc+xHH7sv1vbzzDxZ0fbn0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po8J4D6l+dwZqpKIn0OhC0QTqQZZ4aH/gucfjIgK8rb7iM0LtqfiV0P+pCkryBw2vZhqcc6Z2puRk1oIr3uxhVoZG72+Zdlt17EGXFJWAt6m259UoOuXtr9toZV6NtPr3/DDYjzPR4Z846+tnY9qo7tgdTqG0u1XY0WrvJjn/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDmrNtCg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDmrNtCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6083E1F00893;
	Sat, 12 Sep 2026 02:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789179744;
	bh=xIg7ISaNc/qeFQZktiizQIYHIFIJ3Ls1gYCc5xzZXL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDmrNtCgyhnl3b4RuB54QNic6JVtoKDFT2GISD+mGjkAfmzSZNG2goegm/LcvYkMM
	 Eb5CdJyIspwTy+Neca3JH58EMxxb85Hxxc5PneY4BjmhciZDvjN+EZeOvTm6SJ0MkQ
	 CkuUh68NAq44DUWyEAk/BCyY72DivuyOCxF5XU+16QEEb8nxoJTfddLXr3gfpbh+fh
	 HQCuD+R6T1D4F536MMVLFCOHoYxZG6q8rhvJcYQl90rqKmvQwn4hqgbw9OogsbLAJZ
	 kSLlFU8urqOzkh5FONMioqaNeJfE6j7QDkfnO+uMHFbrYCwvqyUtSdqPssoV5XnAm+
	 kidiC32eK5Xwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] f2fs: fix to reset all pinned status during fggc
Date: Fri, 11 Sep 2026 22:22:21 -0400
Message-ID: <20260912022221.1969770-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912022221.1969770-1-sashal@kernel.org>
References: <2026090944-feline-renewable-9808@gregkh>
 <20260912022221.1969770-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 ]

Otherwise, the pinned status may affect latter flow of fggc.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e5bae53278fbd..a365098988b71 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2183,6 +2183,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
+		/* reset all pinned status during fggc */
+		f2fs_unpin_all_sections(sbi, true);
+
 		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
 			err = -EAGAIN;
 			goto next;
-- 
2.53.0

