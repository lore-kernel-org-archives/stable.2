Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95C47124F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211834; cv=none; b=RgpONt8uqz2APfsOmFFK+rjWgA5BIBOGgz9fCi6QcDYxSkUmxkQEceH4hHZs6FQIG5KtxBVAUyRThzYF2/Dg4bFPIwoPgvunIguk6TuD+Sh49esmuQGQnmT+/AXKwYB95tp65JACsE2OeghfV1bC0X/tIiF6jK4VeuZqr/OqtBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211834; c=relaxed/simple;
	bh=qLFB7ZBmvy3rkNraO/0q8mPiMKXUO1rcDgFYWt1uquM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fY0X/0hNdVwjMSILO3orfBjkFDAMaY2Iohr399Hrfof7rFfOSiokl2REfdrCgzHIoAbbStbj9rrD/Jn1HvkV3NIVWpjGZSJJcIql5rGcfnKMokMDx5Q9icrSKDGNsQLeKqxFX70g5EpEU3m1/H3hnWXIESwV1+wzdzKrrVvq/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d15weG25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d15weG25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB6A1F00898;
	Sat, 12 Sep 2026 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211833;
	bh=tMwJKAigdg6g7WX/L41alIOCYCcp2C02FI7yS695P4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d15weG25tSDveGKPBadRzC0QlcpfAYYVVSpgfrB2DtYlKj7pg2jan8KUV6SCMyTOn
	 /haNJ2zY89qHWc7pWT4wmC0KJbf6KMetwoJKwikP4o10ny2oNvx+CxLhLh/DJfv0+Z
	 LLNd4jii1t9Qc5EXXGScvwuprKnlOKRhzLOLyV76sqQZd8XbjV+lcJdJLNoSCspdcd
	 CNfY4QGX1WPss3Wbf9u9RzAIwOBSJS7uz3dO4IpYiArHjTxqWiBGyGU4x5Qo4VUENw
	 WT6x0z0DZ09kjnuHGscRuUu/Vv5Ak/sxOct70M9yXDot2ZZIWH7eVEyzcDMmHyiutj
	 dLRhieeNVL1Fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/6] f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()
Date: Sat, 12 Sep 2026 07:17:06 -0400
Message-ID: <20260912111706.2282608-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111706.2282608-1-sashal@kernel.org>
References: <2026090957-spectacle-juniper-fbdf@gregkh>
 <20260912111706.2282608-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit ce366bfa821ec81dd45bde547ee31e659306cc61 ]

There is potential deadloop in race condition:

Thread A				Thread B
- fsync
 - f2fs_do_sync_file
  - f2fs_fsync_node_pages
   - last_fsync_dnode
    - folio_get(last_folio)
					- f2fs_setattr
					 - f2fs_truncate
					  - f2fs_truncate_blocks
					   - f2fs_do_truncate_blocks
					    - f2fs_truncate_inode_blocks
					     - truncate_dnode
					      - truncate_node
					       - invalidate_mapping_pages
					        - folio->mapping = NULL
   - is_node_folio alwasy return false
   - atomic && !marked is always true,
     then goto retry

Cc: stable@kernel.org
Fixes: 608514deba38 ("f2fs: set fsync mark only for the last dnode")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 48064c9c8d8c7..3fa81132f18f9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1916,6 +1916,11 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
 			   ino, last_folio->index);
 		folio_lock(last_folio);
+		if (unlikely(!is_node_folio(last_folio))) {
+			f2fs_folio_put(last_folio, true);
+			ret = -EAGAIN;
+			goto out;
+		}
 		f2fs_folio_wait_writeback(last_folio, NODE, true, true);
 		folio_mark_dirty(last_folio);
 		folio_unlock(last_folio);
-- 
2.53.0

