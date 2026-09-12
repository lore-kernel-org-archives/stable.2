Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452B5214A84
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789216345; cv=none; b=TEFRcH+FTkBzpFUScAo1mWuqcT5EObjzgsDMOkHdvg6nTY8uqCgvT9xNMox0G12sennYsQ2Sw6mL/THBUqhIf0lQT94H1I6nCDVLdxOy8RTIQPFgvjuolEfNC3uuo8TSi1eO1LHrL3Q2lknW67y2Nj095QuTWZBkzLjUzhF+nh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789216345; c=relaxed/simple;
	bh=wnZ5U1auXl0j167VXjDeWuVdo3ENUF25LMBgsZp6+8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddumNdkEgYy4moIGWC8p7Uwyg69HMtznkKLrYgrZIKTxshHASVtJbFkSNja0+yBICLYyUASBPAt2J4DJe/KUOMyeHwu7yDAWxW2lCk7Rs3kJlhq0FV6jVe/vLU7JsL6uXxAsriScotQ3nCtHUFVgQ5Kb3IO735AKjNUVsj5Cemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSCwFss6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSCwFss6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE4A1F000FF;
	Sat, 12 Sep 2026 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789216343;
	bh=qX3am6gtLfR4ylqAl+B0wGUiJI2HVeCNDK1yqDBBLps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RSCwFss6NhI6ANdnYTVdV+pNf/MPwaqzvnpPBf5bTWCfWkaW09vXvwrDzZ0GNlwWs
	 pyhTlWMlpFXAIDU75cqmXSe5Xc7U+to3smUabEHEN6EBuy3ORg6/cPafo1vrbG+04q
	 FJrgOqgtlGeqERbnuZR250CdyEjaxAEDedS98jyzCNlkAhsLFtwdAWiSti7bkK2dM5
	 T2CARISkYTm/rJ1JegWuNNf0bbOrpjrtCQbSfcTtsd+Q8xAoYtKqW/2U1jtPbOSbZQ
	 6QPqlB3VXtKeP6RPCdQ2JeslOe+vzpsCR6FmWAUcps0RLW5FHdRarFR4GT6lVrsm8i
	 jCGXH9T/nkPnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: fix to clear dirty flag on folio in error path
Date: Sat, 12 Sep 2026 08:32:21 -0400
Message-ID: <20260912123221.2618207-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090931-lustily-onstage-ff66@gregkh>
References: <2026090931-lustily-onstage-ff66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 5b86eab84ac8e9289b5afc52ef88ab18ba5bacab ]

If node block is corrupted due to chksum mismatch or inconsistent
footer info, it needs to drop clear flag of node folio, in order
to persist inconsistent node data to storage.

Cc: stable@kernel.org
Fixes: b42b179bda9f ("f2fs: fix to do checksum even if inode page is uptodate")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Changed clear_node_folio_dirty(folio) to clear_node_page_dirty(page) for the older page-based API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1dddb65e249ad..7ff1a6d4ec098 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1415,7 +1415,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		err = -EINVAL;
 out_err:
-		ClearPageUptodate(page);
+		clear_node_page_dirty(page);
 		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
 	}
-- 
2.53.0

