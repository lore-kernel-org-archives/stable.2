Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCDD3403EB
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783170069; cv=none; b=bP22lx6v/AmHkGWAgKtbgr04VtM3BMkaQ7QxEnNN/Hl0DtjFPyhVhlW66zqiiMSltbFjb7e0y5wMQfi1Wl20KT3mnUzqf6vy4swOqCbXJL+gzTJ6SpTpp34xMyQSyp6eXCQ2i0e7xaoxEfoPEBVUN91a8RQM6WqZugjkTzdvJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783170069; c=relaxed/simple;
	bh=JqkEaL+5QAh/E+VGAj4dBAjztIEWDZ/LbYvtBsQNztg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6gynRhei8Irv47LMU0LvTcMaGCFChvbm64minrd82Jz8Q6cv4pQHVjnAv0A9pfFo/WmrE+Eb4k2QPM6B6DpHNaavRxU5d/7bifz8PuqeOhcIErxfIl/exaB0GqdrDFUx/9O0+dOy+pUPTPgKP7bkIX5BZZzOQosJ24yDoDdn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ31r+9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ31r+9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA161F000E9;
	Sat,  4 Jul 2026 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783170068;
	bh=GBmLhzK2c+dgpYzv6uipv7EBUT5+gqpd28dvHtNhezA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BJ31r+9As5SJcRi5yEcoB1pFQ07mt38wehIjvRl727v4Uj2E5N03mfBopn/raP/94
	 mWab/40EqEb/FjAYQeRyuuApFr0xXHZb4dfOqzH9u9/Iu2xg26SxAoK6zm39blYApk
	 qw9WVQK2aAeVSVs1kWzvbHTFbRhvSYJiYMvD+ao2lR/bnR8Was3eCWeqtswyfNJFKd
	 jrFpilfVfd2I4buOjy9dvlPi1TF1C1ZjkGyJrq7p332mErhkiciRC7v/krVM7g0nba
	 5YBbgC4yk7/vJpOOYe3T1ywQJrXP7ObiJ5dT0iqtrS8yojP91o0X8F49/60KwmG3G7
	 gxoUS6oxfJLrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] f2fs: use memalloc_retry_wait() as much as possible
Date: Sat,  4 Jul 2026 09:01:02 -0400
Message-ID: <20260704130106.828918-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070234-outdated-refutable-f834@gregkh>
References: <2026070234-outdated-refutable-f834@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 30a8496694f1a93328e5d7f19206380346918b5a ]

memalloc_retry_wait() is recommended in memory allocation retry logic,
use it as much as possible.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 8712353ed80f ("f2fs: fix to do sanity check on f2fs_get_node_folio_ra()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 fs/f2fs/super.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a7cf8627d88811..4739decfc88863 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -234,7 +234,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	err = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 	if (err) {
 		if (err == -ENOMEM) {
-			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+			memalloc_retry_wait(GFP_NOFS);
 			goto retry;
 		}
 		return err;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9154f702e1706a..fc4a2e915ca09a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3128,7 +3128,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 							&folio, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
-				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+				memalloc_retry_wait(GFP_NOFS);
 				goto retry;
 			}
 			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
-- 
2.53.0

