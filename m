Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048924;
	b=FnV9Wao0W/+s/y2JycOroXqCIrCHYtOjgS9iN+2l4iLvDyMCkeN+Fk4/a60a/hCIouK6
	 qUF6pSRdjiVek9NFOOzoxDMl7Qyc1MP/A72j5U0wrFCpAljwmoyRZ7XnnFzndcX3qRrv2
	 ERV68oBIfP1Lf+2VnB9lcDlpYaPdtFu5YGZ5AIEyXQbXsxp4IHDWESVIbKtBkRHX840oH
	 IkJnUIBxf9JiOxRElj2INmcUQfjZSMFC19nlKccM6ENn3WZZQBO2RPfgIDcQS9W/VNETI
	 FD4BWNdv9NZL/D5oHk8kc85yQwJ5ZjBVehO+NQJNTx0svVYYJVQOl5nccebg70vl9Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048924;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pel5Dh3rpKwZUFSLsrGAhj0S/9dNvwCdMpOAKwD8R2E=;
	b=a5M4OwP+m8irVLHMFAMxld1Wq/8k/8HHY4O/tsonz0vgLC22Gu25h/O1OxaBSIr7QIEl
	 oc6Pj00tmpRHfCqIVfrMHbpIPABs29kmAj/FUbE7RLnBymv/lZVNTUuU/3csWTnR+ye+m
	 AgWyDv85uN4OCMlFLH9SCR/s7tDEAkfE/agDlVWG1lqgTlOwQsE1CZ+zyfzm31NLwHtJd
	 wSBnSyDY3G5LhAfbQtGvwS33b87dNjrjkdQ3idc8V3gBM+SjOHXsW5Whv14WbgsVOASmn
	 RFiQlb4jLczLnIZ9RFadmEWJqrju0+04DCfavPICvjh/GPzOETAdOXm9Tx4G7mLFu5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TB41WkCm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A2606D803
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TB41WkCm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AAF1F0089F;
	Sat,  7 Nov 2026 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048924;
	bh=pel5Dh3rpKwZUFSLsrGAhj0S/9dNvwCdMpOAKwD8R2E=;
	h=From:To:Cc:Subject:Date;
	b=TB41WkCmcbq0g8tYH9D7fVzT1iXBCsIuJjLAuf/l/+Bbidvzi995PWS8rudyRXf5Y
	 OI6gZaR/es+8MygE8ayFjiVXegQcRVE0sVXj37kdBlhYS6OkzHg3a0rrXBrSiukxHm
	 LED+dcgpQxzTKHSo8NpWDo35/ToL+AY/BFo46/GcICDbpK1nKjZfu93hELJYHsXcuO
	 ovGnHrNiB0gMuOhIWtYL4csBYyiSZNaHx9c1tDdz0Hh9eKQXxYbRWkeT1cM1xF3rtK
	 suxiqiLXucDlMIfLEAEfgJkz7Xy/UDjIrUv3yVJFrgXG06JtLI5ivFE4OZFe4FxeL+
	 I/P35txqnrinw==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to update superblock crc in sanity_check_area_boundary()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:22 -0500
Message-ID: <20261107055522-failed-6.1-f8f956c7ec8c@kernel.org>
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
git cherry-pick -x f8f956c7ec8c0285d7a80bed497d2f7adcbded15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055522-failed-6.1-f8f956c7ec8c@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f8f956c7ec8c0285d7a80bed497d2f7adcbded15 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 08:23:50 +0800
Subject: [PATCH] f2fs: fix to update superblock crc in
 sanity_check_area_boundary()

This patch fixes the bug reported by Sashiko:

We should update superblock crc along w/ raw_super->segment_count in
sanity_check_area_boundary() if sb_checksum feature is enabled.

Cc: stable@kernel.org
Fixes: d440c52d3151 ("f2fs: support superblock checksum")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 857cc2b299464..1071059f2cc22 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4084,6 +4084,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		/* fix in-memory information all the time */
 		raw_super->segment_count = cpu_to_le32((main_end_blkaddr -
 				segment0_blkaddr) >> log_blocks_per_seg);
+		if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
+			__u32 crc = f2fs_crc32(raw_super,
+					offsetof(struct f2fs_super_block, crc));
+
+			raw_super->crc = cpu_to_le32(crc);
+		}
 
 		if (f2fs_readonly(sb) || f2fs_hw_is_readonly(sbi)) {
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
-- 
2.53.0




