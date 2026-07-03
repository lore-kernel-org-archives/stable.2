Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE23CFF73
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082015; cv=none; b=PAZpYEbMzGEEu7K9MWvTn+FScXazieH1wboiiHCXmtHDjODcCccV3HAmELkYY/E4Eeh+F/UoF//Meigf6jcyS/5KQYG4nz5ea8p7P9ipFgxVuFcT1PAnjSmz5bjW9nyN1IAUKIUhrM+S/qRkNxvb0LjhTpkFgbFVUShDNRJTHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082015; c=relaxed/simple;
	bh=CjFwxt+UU1nNq9SVfMqadzK9EkUDxMa3QFjAB11hLOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrS2+97pwq0mIaP1c2I3nhYhGW+oPgUTeAmx2bDjIZi6GanEgqtnnvjiPYX2k/AMmoCqT0IRQDJflbro7AfOQcZRqvUuYbaru6AT6BCoISQ9+ZaaG0I6K8YYHAoMibB1h1hr+rUA2Y1Dgw91gmXNWm7J/uJa/tlDQY9HT7uoVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoQWz/R3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoQWz/R3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C601F000E9;
	Fri,  3 Jul 2026 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082012;
	bh=OfUolJ2A8Xd3E7Ig0h8ajygieJr/RVPTpX4GFbrhGyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hoQWz/R3+S7opUDVncGJd/pfk2jT4jAmG98Sgrb7dPdqK751kHBGmvEFJkjVmuTkO
	 DwBsW1XRziRAmyydP1Fy/4FTifERi/nGv08ReHizgRQzuKZYRPpUvQxqBPK/JYqKr5
	 wIkz/YHkqrZ/xDWPIrPdoZEReFCEsJ+99BA3+xZD2glTlEk6Q6uOZQlnxF67GvFGLp
	 ocIIW+aAVkk7fzHUfZdJ/tCofthfqX5VHWcztNSVzFMt0l7U/0ke+4PrtGhvH7tTs4
	 xwPluqwBWB2L2MHEZZBgR7wZHL8I8B8V/LnvS8uZGVfLS68pNIWtSYoYDfcooPfyTe
	 JTOHDRncYR+7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yunlei He <heyunlei@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] f2fs: remove non-uptodate folio from the page cache in move_data_block
Date: Fri,  3 Jul 2026 08:33:29 -0400
Message-ID: <20260703123330.3944793-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070242-refusing-previous-82e3@gregkh>
References: <2026070242-refusing-previous-82e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

[ Upstream commit 9609dd704725a40cd63d915f2ab6c44248a44598 ]

During data movement, move_data_block acquires file folio without
triggering a file read. Such folio are typically not uptodate, they need
to be removed from the page cache after gc complete. This patch marks
folio with the PG_dropbehind flag and uses folio_end_dropbehind to
remove folio from the page cache.

Signed-off-by: Yunlei He <heyunlei@xiaomi.com>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: e0288584baa5 ("f2fs: atomic: fix UAF issue on f2fs_inode_info.atomic_inode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3d9f326ae840ad..c7f6312cbb1016 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1456,7 +1456,11 @@ static int move_data_block(struct inode *inode, block_t bidx,
 put_out:
 	f2fs_put_dnode(&dn);
 out:
-	f2fs_folio_put(folio, true);
+	if (!folio_test_uptodate(folio))
+		__folio_set_dropbehind(folio);
+	folio_unlock(folio);
+	folio_end_dropbehind(folio);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.53.0

