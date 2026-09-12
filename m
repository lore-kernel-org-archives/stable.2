Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21894457E7A
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211813; cv=none; b=r1b+kIWB+LkFNpdsjySN/BcgZ50OwbBbwgCj9+INmjUjGr4k93DEzzBkQIeuDXfBuavGYcEYdFunOBSb9yhGNetgH4eRxKfbYrYejPGQhNINDnH+qpu4M07meFSxrvWbxhsQCCBPjbjioMQFT8Hb0v/XSKZvYvSPkWyUaYJN788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211813; c=relaxed/simple;
	bh=WHyt+d6e621hfOJ1gGKbcHrXNpdoEXzoeR9fodP5C0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9JscoguHAo+5NHXyvnuYMlq+Kid/Pa29Zo6g9IPPgsjquxtraUd+h1/w6/P6FQYUjRMptYSX1AfYd1voGgkFxGELOmB+gVfrPCg9G0QrdKMZbZZkhEyUwFc5NZfPWReAsZbI4u+Sc5JeBIObEr3hhXnFfTxRnjLEHbW+yoRwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKkn+9Gr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKkn+9Gr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE451F00893;
	Sat, 12 Sep 2026 11:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211811;
	bh=ZacMNv4RY9yv86FdDy8SHb2Ua/itqgVkz7TKmI++PL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKkn+9Gr/FPggRgut/CdW5V0+QVlGqgMNF+0uiMrTyj9GQnxo3SQHxYwQEegmCvPf
	 5MZl3SnM5Kj3Ms+B/1TUHadFlpZZG+MF+wLrqwflSCVbE1mC8QgE0qmubloZAoPbW/
	 9dHDCHRPycTsMzac485zjOxOe0EmMzsEmS9ByB8gnwJn14SOjWTSXpCnPQt6izVKcx
	 BUpBRnaX9qdwiq941Nn4/mka/tqDa+FeWjRkZ8EyaOQCNRSsfXwSWA4S2hbNUVqwNP
	 qFrRJIZeZBMpxP5Xnhr/4EGzolRucyAoqNIuMNh/LgEWv6NIu0WTFeahdi5cWoX4rm
	 eeIJurecVuCBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] f2fs: fix to clear dirty flag on folio in error path
Date: Sat, 12 Sep 2026 07:16:49 -0400
Message-ID: <20260912111649.2272406-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111649.2272406-1-sashal@kernel.org>
References: <2026090930-constable-bacon-8c5d@gregkh>
 <20260912111649.2272406-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3b40ee49b3721..4cbae61870752 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1519,7 +1519,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (!err)
 		return folio;
 out_err:
-	folio_clear_uptodate(folio);
+	clear_node_folio_dirty(folio);
 out_put_err:
 	/* ENOENT comes from read_node_folio which is not an error. */
 	if (err != -ENOENT)
-- 
2.53.0

