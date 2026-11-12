Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451978;
	b=Q8C2bJBPnjAvB69M2PXx26utOuyOLfvl+wfNPZ4GD7rxnviCeN6yQzR3zdrj1TzOhKBU
	 9mAFU/RqQikAf3vY8ytBWSoU4pJe7qzUo1I1Mv5OAXF1x1mqaRqER2zMPbLieruTI+Ctk
	 2LjPJyWu+rBoKl1ENUth42poTM80D/sKW5uDcOx/k103mpW2E/3wJ9/M2luG6H93/jDjE
	 SBMIFOeoL56oDu66EjRPGBlGIztP+oFDPLouSQjwi+ywUmkCHslLgimu3haYNrqLttIOY
	 vSVTiAfxE8XJp4F+vWCAzlll1mBYtyzZZJrYR4kwdFYjubxQ9snQfIXx3Tv4M5zbpyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fgGZa76Y9ISvpwxgseL4hkrbekxnVtweZJ8Tt0vYoyQ=;
	b=Y40nBQWyRwFjPwKJCo6mJR+pCSbIxYUK20xN/v4n/Nf07O+wYECXw3baG47Dnd7J/bev
	 juJ+/aF4WHa+BDwTR+zsIqD0OiewzojuHuniqvoKlb9vai1CODDKqMpyHDamzEhS0qLTG
	 zKFqVdFnYpTum/8gh/84mnKVZAxexB8vlli/rbn9aHJxtH3C1NODk+9ugm/AW4lJZ1rce
	 7DKCi0YJW5zG6GkPK9VcMcdJu1xhC+DuyMxTyNfiQ1xOLlO0wMkA6nqZ0CNMx/rFvBa0L
	 LbGx1ZA5p+F23DzcUmTzFWtSAuKwSVmC4OMzUzUvPTAcTBDHXkZyxcltPlRFsBffn5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJd0YkVl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F42C606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJd0YkVl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1168A1F00A05;
	Thu, 12 Nov 2026 02:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451977;
	bh=fgGZa76Y9ISvpwxgseL4hkrbekxnVtweZJ8Tt0vYoyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BJd0YkVl41eb50JNzwpEwMIlduTDNr3gA4VQS46CmkgZJHAOiUJHv0NVhf2V0k6R2
	 qHs8Ki1J5raRFS/bdtUlUDhr/TwUB1hcC06+rMbCANmQ9rGA47mQ//+ydFwD0X1djc
	 UWw9yBhzggV7K5F0kl73f+huRi8wuuQV5kitG4pE/QoMkw6AO4HqsGbI8Srke2fwMJ
	 VtvH5rKc5n8IrPEfuflgUKKvOA5ZbvffIqV2KLcLa0y9UwM1nAHWl9PkFFv+S7aCN6
	 I6pfv3WErkvy4EqLHmKEaKca6E3HYHrGW4EOxZ9tJZKbo+XS7WV2umFkrr+KOzdx16
	 fGYi6atd59C8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] f2fs: fix to fetch ino via ino_of_node() under cache lock
Date: Wed, 11 Nov 2026 21:52:55 -0500
Message-ID: <20261112025244.1404443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050544-failed-7.3-cd6d8b189139@kernel.org>
References: <20261107050544-failed-7.3-cd6d8b189139@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit cd6d8b1891395b681f2060916a4b83880b765698 ]

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
[ sashal: adapted cache-entry operations in f2fs_writeback_node_caches() to folio operations in f2fs_sync_node_pages() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b23fe1383009a..afb8de517e7ad 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2183,9 +2183,11 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 			/* flush inline_data */
 			if (folio_test_f2fs_inline(folio)) {
+				nid_t ino = ino_of_node(folio);
+
 				folio_clear_f2fs_inline(folio);
 				folio_unlock(folio);
-				flush_inline_data(sbi, ino_of_node(folio));
+				flush_inline_data(sbi, ino);
 				goto lock_node;
 			}
 
-- 
2.53.0

