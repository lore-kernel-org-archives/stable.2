Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045946;
	b=MtU5wvSokkoEBc2X4gk/voHQgO2HjdS+UcBoiNoR5ChFuo08fGr4qQutmCvHe9+nO/Eu
	 H97svFDmaD56roUu6x8L8PLO2q2DqyaLM/JyWfPxIhVi5maQZWpdao783gdCbjrXHd4kJ
	 urvvB+xcD8TSVZfljxCEq1HiKT8bCZmWpmAlT0NrL3GjqEyqp0qdCx0vqboxwnAcT4UL0
	 LkX8mrF8Totl+KfKJUMwvlYtJJDlOWTl9bOD/uzrDWXPOm0xUIz6QoHQzZlsx8X2uXih3
	 7qswSaWcNSnukOvqN/frnzFT+r4Fv8dObdh5u0aw0T8u5LFGRG88RQbf5SEYU5urD0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045946;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6iQ5+1FrkAOQjcca024dmQ8zy6c5r1QI3xGQo42ndoA=;
	b=QEVGdvYUekpTMzEvc6Ebmo6mLtJD5Cua8dSy5ElBv3DAjWoZ4xfU8G2FnaJBVkg1zC3d
	 d15kGpHcEEP+xb/A4kVo4S99tbEr1FiVTjRlmX/Z2mWNFfnwbqpCBuRzFNQeZ61yYRrV3
	 od2MWXXQ3kcTwKYDvKyyn5Rml/+BNSTObT7lELv38hcOCisKOZIWUxunjT2pvBNzB4EqK
	 28ufHfbDJITDI7+vueZ6Bp419t6FM/om89cGknpuRgqaxD2vdIz6CrI7o7KdcXmKjlz7k
	 EgJKeuXs6HxalEsEtSCbglLRKgCbFjEHvdci623npOpUTRa3NYSHM8/BU/VxIcVx8dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmnOBFl3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmnOBFl3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F39A1F008A1;
	Sat,  7 Nov 2026 10:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045945;
	bh=6iQ5+1FrkAOQjcca024dmQ8zy6c5r1QI3xGQo42ndoA=;
	h=From:To:Cc:Subject:Date;
	b=nmnOBFl3ZYuKjXcyIoYpQDC/r9Wiqg7N+fbRyCqYvq6PLB+VUibYtqqHIjz2e6tey
	 YzpEpZnJUuBPk6SJSqzq4zBqZJk+sUZJb23qg1yRtFj2bmLJEM8XL00/NndU9A2kTR
	 POnkPS22UzarYc0Fogi71ACJ29G1UXAtpNv7jBFbsVgjrkeZM6LFnjRzCjJtm3o9ez
	 kXjkQi8OsGdjAGEGNyndMU6mFqCPbBD/s2hZwISAi1dz4JVsE0zYGvcSi8qpmDIQSL
	 zvyFNAU4jh0enaimOOIO1zXnbroWiuSJ3ETlPtbzuh72V6QX4eLWT+gSDLvkhoOk0g
	 WR4+uMYCSVwew==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to fetch ino via ino_of_node() under cache lock" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:44 -0500
Message-ID: <20261107050544-failed-7.3-cd6d8b189139@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x cd6d8b1891395b681f2060916a4b83880b765698
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050544-failed-7.3-cd6d8b189139@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cd6d8b1891395b681f2060916a4b83880b765698 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 08:23:49 +0800
Subject: [PATCH] f2fs: fix to fetch ino via ino_of_node() under cache lock

In f2fs_writeback_node_caches(), it's better to fetch ino via ino_of_node()
under cache lock, otherwise, node cache content may become stale after cache
is unlocked due to racing w/ truncation.

Commit 493b9dc8b52c ("f2fs: cache: use node cache") fixes similar issue in
f2fs_flush_inline_data() introduced in commit 34c061ad85a2 ("f2fs: Avoid double
lock for cp_rwsem during checkpoint").

Cc: stable@kernel.org
Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 424e95ca58789..44f94000d452c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2195,9 +2195,11 @@ int f2fs_writeback_node_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 
 			/* flush inline_data */
 			if (f2fs_cache_test_inline(entry)) {
+				nid_t ino = ino_of_node(sbi, entry);
+
 				f2fs_cache_clear_inline(entry);
 				f2fs_unlock_cache(entry);
-				flush_inline_data(sbi, ino_of_node(sbi, entry));
+				flush_inline_data(sbi, ino);
 				goto lock_node;
 			}
 
-- 
2.53.0




