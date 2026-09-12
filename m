Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCBC4BEE57
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176719; cv=none; b=DV2GI/Dw3ERCdM39nLdZyTJVfNst/+3k3xaapvV/xbMthnLZq6j6nKEFPnna8Xig7fXSgHPrljNXy2cxVspedHS2Mx8z7zBrZVCvJvVNTra3Nbi1JntDGLYR57kLEyURLDqpw8F72qIljKxGweOjKX8qhP7WMpMBNjnTQ8+12uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176719; c=relaxed/simple;
	bh=WQ5f91addSdQiv6DqIC718se2N+B2s9roRTz+HhMWd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePkEWYbtZT0tDzHyN1fKgOph+DeI4L2NTQEy77aABRK1eMxF3hQUvhdkMjfcnwne2TUFMeH9bjKE14usDjf2kP2Uk3nvgGkU0DO0gOE4qT4+3y81okTgwUIaVyB3YWilExMskcu7XKczX0nFC7bQ5JIPXCAZjOfKiCAAvMqcGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvyD3TJg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvyD3TJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B5F1F000FF;
	Sat, 12 Sep 2026 01:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176718;
	bh=EIU2FZoeeXAXx3UT8gQMW6RmJOyNd6IBWscOuKVH5xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TvyD3TJgwv9thd1WnX3Pk0iPRPvD/ysd162/ZSXQI2snJkR4Rd4Modujd4gjPYNfm
	 SYXKvQtKmeHT3YtBO34orCtuhsA1XpfY/8OLBsQXzsYF3zfgW/xwXQDsknqKxNu0Xu
	 POH/jVBcp0rXqRybZB4kFOcoRmpsSepiLmbmjFHTZPTTU2pNKlJKM5V/vjG8+fsl0K
	 hoZvXp9GB5QS9yWukiw4bqenvqT3ondjgk33Wz3Cj7ztiPcUc4XiUzOiV6EfEbUd4B
	 WDh95fOF2mUeBHMoZEKXibWroOmRp2z+uV0jioz8EiV2GihLC03Wje2HWbd0ob6WOf
	 092XdTqWE54Rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: fix dentry folio leak in find_in_level
Date: Fri, 11 Sep 2026 21:31:56 -0400
Message-ID: <20260912013156.1758547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090914-genre-crunching-ed99@gregkh>
References: <2026090914-genre-crunching-ed99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanghui Yang <3497809730@qq.com>

[ Upstream commit cca7d3e30bf30333314e31bc70b9a739f1342167 ]

find_in_level() gets a dentry folio with f2fs_find_data_folio() before
calling find_in_block().  If find_in_block() returns an error, the
function stores the error in res_folio and breaks out of the loop without
dropping the dentry folio.

This leaks the folio reference on the find_in_block() error path.  Drop
the dentry folio before returning the error to the caller.

Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
Cc: stable@vger.kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Guanghui Yang <3497809730@qq.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Replaced f2fs_folio_put(dentry_folio, false) with f2fs_put_page(dentry_page, 0) for the page-based API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 13268d1f8c75a..570f79fa65a52 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -341,6 +341,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
+			f2fs_put_page(dentry_page, 0);
 			*res_page = ERR_CAST(de);
 			de = NULL;
 			break;
-- 
2.53.0

