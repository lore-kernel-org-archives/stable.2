Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300D4BF944
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544920; cv=none; b=rVN6hagFYmRtyIHY9GgQBEGc+xffVsOxPCvSTBdnLwU6yrv6DPfKSwS5xFmPm1twlceNFvqhGzUKb42x8ViExyLnTrWHPIC2UPLeKIX7EO4TyjAK5/9oXrkfJe0g48SkBwMEV/Wuijdq5nfWfwATp7LYgFdw7NScZLUsrd2PnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544920; c=relaxed/simple;
	bh=RA/RPNmo7TN47Rac2/63pI2D+gBLK3RaOvlIfkzK2jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8+YOxPr6GjGl8GcNcFeOxeqdyH/8i3PmFTFxUBjGIal8raWFDDlr7rd+x8UNs4YoHks/6tvEze1WEEPAO0giRdzjt+YUHbejToxXBobkziFgid2ZxvWZHAnNjLY9cOHcF4qv5RyLv2l9JtMRzLreTR6GCfZ4NlUdadQ5uifgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl6aShrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl6aShrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1A41F00899;
	Fri,  9 Oct 2026 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791544911;
	bh=vVjrHJKa7rDFUypv5UxZTfsmJ51mWGgTIxM/zhOP14I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kl6aShrmB76Cbp98XLihU/AhoJdIH3oM8O2JNFK7TWZMBfQYIbwB5qQ6J+eFpQ2D1
	 rNUArTtrC4hrV94Zhq3q6XcZbFsMMnVGrQK7fyyXiHbVZBvhdxc8pILkn6EB7a9zBM
	 GiceKpvsZP9VRC6bVYVlSXVeQ8n98JQw5eEy2n38CJ3RaC5Ch2pxpS6CZYEDoanVVc
	 UsZNoc0vpVy9iVSbbWFodbNw2UCIOLkNgONHCPugd4ZzrApaSIj1xJU1I0gxoW0pJI
	 Ofq0tZaH/fyek7ncT0BvAsY7Wotfa4QuKKSeNlBKJFTeLxnXgk5DP4aFljA0vEfHYm
	 zck9sK+nnBeUg==
From: Chao Yu <chao@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH RESEND 6.6.y 3/3] f2fs: fix to reset all pinned status during fggc
Date: Fri,  9 Oct 2026 11:21:40 +0000
Message-ID: <20261009112140.2275137-3-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009112140.2275137-1-chao@kernel.org>
References: <20261009112140.2275137-1-chao@kernel.org>
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
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8a37461fc278..8a4395bfeff6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2064,6 +2064,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 						dry_run_sections == 0);
 		put_gc_inode(&gc_list);
 
+		/* reset all pinned status during fggc */
+		f2fs_unpin_all_sections(sbi, true);
+
 		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
 			err = -EAGAIN;
 			goto next;
-- 
2.49.0

