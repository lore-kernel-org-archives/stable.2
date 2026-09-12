Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51F18FDDE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176732; cv=none; b=Nf9dBcciWC0t9PwxKdFAfoYmRXWzwgqfJg1tmeVTcX0egNRT+WaPhxVahNuKoP4Ygm3pRdRXpnha7OO5mbNihe/TMFnnZXTfDE4NnjTHhPWFrpUF2dRvJhyz0+KXh/xwYdqKqG+KG103GvkoE2FxpmlJYeFlVBqgsUhau0uoxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176732; c=relaxed/simple;
	bh=Wiqe9nZj2hleKPYOTZfxGtX2Ktr4EcVf3RxMvfeJ8Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsyhgkvWmFHrfXDwafTCPq/D9G69FWaAUbU3jmisnzOfuOrEmAERNDXrh/7HpsKXOX8+NEIZCHTyTStO37ARaSIZxYV4TLih5ZGA/QzNlriF8pM8aivLwFv9C+LdrFIrdMuPhW66carMdO6eP1V9ugS9uF5b2mYGPbaMj2AhAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfFi4/3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfFi4/3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A761F00893;
	Sat, 12 Sep 2026 01:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176730;
	bh=XnZT3ft+jKYQzqhJNvpmBCCsMluz+u3IG+0liUOD64c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfFi4/3Nt7YrUYiYpDKaz/zIavRicur9xG2n2uW8blgiRp3NnrzTComyb8LOGh2iG
	 3xZrHpYsBYxby8wCUy0pWI6WTteLineTCv85GlBH8WENoP++LQprJe07WiyCGtWV+V
	 nAe+v2/S0xoh3Taxsq1yK0+z3WZuEpB3SQ3WqYSNyG4ZpfbtZT7TR3v/9TE+0cPlrF
	 0H+2M0q+NtaCqdHzLikrO7nz+OHfE7rW0yEwbEdv4Yf2sqDhtkxKvo8rBs12pcP75H
	 ZVI4MZGiUXhh4W98vHyX7RM/AHhsHkqvpOeDnqQc4MABumvih4Fn1U1u5eh6K0k4A0
	 g7qvfNahX11Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] f2fs: fix to clear dirty flag on folio in error path
Date: Fri, 11 Sep 2026 21:32:07 -0400
Message-ID: <20260912013207.1759566-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013207.1759566-1-sashal@kernel.org>
References: <2026090930-yummy-brim-dc39@gregkh>
 <20260912013207.1759566-1-sashal@kernel.org>
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
index fba4e5d085235..0898ce801f281 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1528,7 +1528,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
 	err = -EFSCORRUPTED;
 out_err:
-	folio_clear_uptodate(folio);
+	clear_node_folio_dirty(folio);
 out_put_err:
 	/* ENOENT comes from read_node_page which is not an error. */
 	if (err != -ENOENT)
-- 
2.53.0

