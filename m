Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048507;
	b=ELokleROi9zxFvHrwZgEBIrP3tZAgO+O1HRTBPAok2fXQrOf4bFz+DR6l+DU3YgHhoAB
	 XExSJwi+2bHQJhps/i+Kc2nhe88qvivfLCPLEVMKBAPWZlPfE2LnGuk0o1EnZGMA5iSM6
	 oPQSrjW9C2nWhzOV9JRbzSmkV48IVQFUOcOP6ljPyCHrGGU0MQtTmo5UqniaG+4i1MPF5
	 AVLjZs0Gt1VOx6eqmVMtZtrxd4jM4SljnKyhW3hsr9gpjYsBQ/sK53MPZZ/D1Si0qxW/f
	 Paz8IFTCEpsqR81uULlpoILJJ+jt3I5h8ipFsHTnU5Ka0kWFfDe6XnI2Xhmqdg1bykQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048507;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oucSPzRlBRrSJmiZ10Q5MWRzx9pRzjfJQbDScRV8100=;
	b=S01SqvBzrN7kIc4lGRyekPbO6jww8vVrstGf1CV4yadIbCT2NqFejRCuc69UvSbcBDFN
	 WTF8oHtrJ6eMAPqsdkYz69nJHJnDLsUsk4Zs7Fwt8QeEXgeYBjouE6bEhxvNbZa+e5FSR
	 OEmdKR7pMoTvn8jElgErqGeF5oOv1jmPu0E8S3EtkdWPJx+CEe5SzA+hNww1lpXkEs/uT
	 UeWJnSdODrPXCNGCW3nq+ODpO5RPFmX6BSw3Bmw3tv7kB7/JjDZxRe5Biqj2u5Gi/iAiF
	 7ZhbmAuOvjBnklr84QDdgGuwgAIISynMPM5HLGRo+v7GBGdDgOLnS8r7Q2xIc8g8RkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9bpk+Jf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62264606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9bpk+Jf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A2A1F0089F;
	Sat,  7 Nov 2026 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048507;
	bh=oucSPzRlBRrSJmiZ10Q5MWRzx9pRzjfJQbDScRV8100=;
	h=From:To:Cc:Subject:Date;
	b=E9bpk+Jf7xQjOQ5cS3CGY3tZ7yAQISKj6kmRhHhYvEZeoT5sderwJqV6v0HE1Vi0u
	 WzkbXNkRtB74QxjuL7p9rda/VJtl3Rbrl5XjiNzHc9Rc9tKyXMbSv/JKekjgSPJDD3
	 9yZ+ZdFec9zzd7PTDkktf5EtcJArXivA0zmfyaDzVLEgoH84iqdYcWiOOEB2xviZVv
	 Lk0F89Kd+TvzTA4RmLDw+8KgW657TSK9w+o+u2tlwRew8V39FkfIsFSiIUP27lhbfd
	 J9yDW/McVk1eaM983x4DvN1k+KmEytSWOHnp50zocEcf5LRV0McnfVHHB14Uec3R9W
	 uVkhhXWgkcYFQ==
From: Sasha Levin <sashal@kernel.org>
To: zhanxusheng1024@gmail.com,
	zhanxusheng@xiaomi.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix defragment writeback range truncation on 32-bit" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:25 -0500
Message-ID: <20261107054825-failed-6.1-92154fe28c37@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 92154fe28c3701bebf75176dc5522bec62519a8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054825-failed-6.1-92154fe28c37@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 92154fe28c3701bebf75176dc5522bec62519a8f Mon Sep 17 00:00:00 2001
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
Date: Mon, 5 Oct 2026 23:49:54 +0800
Subject: [PATCH] f2fs: fix defragment writeback range truncation on 32-bit

f2fs_defragment_range() flushes the range it is about to defragment:

	filemap_write_and_wait_range(inode->i_mapping,
				pg_start << PAGE_SHIFT,
				(pg_end << PAGE_SHIFT) - 1);

pg_start and pg_end are pgoff_t, 32 bits on 32-bit kernels, so both
shifts are evaluated in 32 bits and truncated before they are widened to
the loff_t parameters.  pg_end is only capped by the file's page count,
so for a file larger than 4 GiB the shift wraps.

For a 5 GiB file pg_end is 1310720 and the range collapses from
[0, 5 GiB) to [0, 1 GiB), leaving the rest of the dirty pages unwritten
before the blocks are moved.  For 8 GiB the shift yields 0, the minus one
makes it (loff_t)-1, and the range becomes [0, LLONG_MAX].

The matching call in f2fs_collapse_range() already casts:

	filemap_write_and_wait_range(inode->i_mapping,
				(loff_t)index << PAGE_SHIFT,
				((loff_t)pg_end << PAGE_SHIFT) - 1);

Do the same here.  On i386 the shift changes from "shl $0xc,%ecx" to
"shld", i.e. from a 32-bit shift to a double-precision one.

Cc: stable@kernel.org
Fixes: d323d005ac4a ("f2fs: support file defragment")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 713fb6f49bcb3..d4d859dbef880 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3036,8 +3036,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	/* writeback all dirty pages in the range */
 	err = filemap_write_and_wait_range(inode->i_mapping,
-						pg_start << PAGE_SHIFT,
-						(pg_end << PAGE_SHIFT) - 1);
+						(loff_t)pg_start << PAGE_SHIFT,
+						((loff_t)pg_end << PAGE_SHIFT) - 1);
 	if (err)
 		goto out;
 
-- 
2.53.0




