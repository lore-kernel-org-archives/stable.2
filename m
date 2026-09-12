Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1766478846
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211820; cv=none; b=EjA9jLC/AB6OO7/K2rJiI6SUC2voO6dv8lENF80QnsinF2XqRyqnst67vbpb//PdQyG8nS4w6jAYToC0VMLdWz+ouNUgqyhQNiozET59xVHmcLRf1had4d1UTEWWM7tgnDfl1EUY4zCEHnJnFK2B1PVK9NRQlEEgpql8m3Schug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211820; c=relaxed/simple;
	bh=XXGYz89KxPyo0GXo8Ic7l5iZmF5+Z3FOLznBMo9aKlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3Is/UVEID8UouGkc2a/CtoYNU8t6qB6GwDZ1sGzt6KBQSahkx8E+MMr7uGCq7aLDM7avcNSL/shIE+WKhztwVAa8HXwpRyhX1LkIne11y5BwokVRhXyKRs6UU5HMTeqhEbC6d24vOowK0Z4ClIxWr3Uk9e9ucn/wIPDcfLWmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in0Glgp1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in0Glgp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB6E1F000FF;
	Sat, 12 Sep 2026 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211818;
	bh=dBoTj1rbh8cqI3iAXI8l9t1WtXXyvc9+ZgJofHywEWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=in0Glgp1cXOYgCA7osF4U2csswd+e2Dom+wVynh8paFjrligon2WeHnNNJy/cIfZo
	 4sYRbRinmmTHdyFnquuaV4bwPKsyTkgt8AylzC8hajVULoK1vA5QI82/0/g71aYNBZ
	 yKgTWOfAUqA44MRHpaXAvHmLeFYON52CfL82HQOCBXSRFrqKns4/bwxRlsncA+huRO
	 cWB7jQhs2ydDQ+1hbUlu9AJyv41O/sGJiQ5Bl/8IH88cxR5ya7TZ7TCvDwD2eu8tTY
	 GytCe0YtinyZzExqKT4hKzjD4oQdGvKMYosr3zBvhMgyQmJXLh/QPZSNwMEegcSqQK
	 Z6rh3McfLeqyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] f2fs: fix to reset all pinned status during fggc
Date: Sat, 12 Sep 2026 07:16:53 -0400
Message-ID: <20260912111653.2276190-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111653.2276190-1-sashal@kernel.org>
References: <2026090944-reprint-spruce-0599@gregkh>
 <20260912111653.2276190-1-sashal@kernel.org>
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
index 05308e44a3550..1c3c324a6cc0b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2155,6 +2155,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
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

