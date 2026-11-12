Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452369;
	b=2HyzovFTj5gBNX/znxvNE3Eqxr8fQC2Xoz7P0XZe4dZN0aiypGemVCCyLw3S86AQ0nkw
	 SG4rPPTQzbWanEa5rjF4SHyxLXjjCbk511sStBAeiHDE3dZZ3hSu3Mf2ZTgGVemtH/9tM
	 oGb+K0l5GZpmJ3Z5+VWRg7FVGYy3anfKNr9AaqhcG+BZ+yNl7zv2uGB+VkRDa+dpFtUJz
	 qbvUVGhIwtEmrIZDMS4Nyim+8lV4m8KbkMZNEjU1UduQ8TJFIv4moBlnTM3h3cD3IouJb
	 I9ZGx9VwzRBlzEzRoEFs4/ZpiD9oSuPoolAXWBgPxLrI4RA1kiK6z2k8BwH6xnsUaCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452369;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OlaztTDUpcxDMGhJkbhC80ga54muKg/d5HQPZqGMGW4=;
	b=tbwbvi20jD4TD0PH/B2ig5zmpgclauQrwHWiYAWkrlo8ZeIX2vmJN37R7qZOuD0ES4gP
	 szg2gxzzFtth/zlAIf+6NrlPlD/1o3lVRDIUwZ1a3Y1d71+AMgB9kLeuC9KZXRAHILoGQ
	 dmwQSBgC3Jn+9icdAYXGUxBdohsdPOYFy7lHZfMjrZLUTuybMvslnTfsjY59ONOuYqU7W
	 wDrs1BXYkLaS79j4ElFgoZ5A1NPUeRUKzrhD0VxKDDMcBr0f40iTQLhfph7/iNMY6j3FA
	 mhQ4GC+WCLITogtF1APNKyJNK0wDfd1OQFmQhHWeN9JuWUFWuRK0gB/QB+qy4x0fXNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLd7FWAc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E0606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLd7FWAc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3DF1F00A07;
	Thu, 12 Nov 2026 02:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452369;
	bh=OlaztTDUpcxDMGhJkbhC80ga54muKg/d5HQPZqGMGW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QLd7FWAcyWE3pTQtIA2iGj3+jXBy3b23+xeOhATLlLwV75A5lqDcCpgqn2aDtMX/g
	 4+epHXSwRM53MyXgxII6zeQebSM1c0kYeK4rITHAFasd0KBwXwwKjRe0Z4p1xLPG68
	 TWRqfxNDeOfInZRN0AdH5RbwJlF3FwzKQHECoE1mwjImt4N9mcRuiqCUFoMRIJjQ4U
	 ShWj49Vik+MTt3AvWKi2qybuc/AVBJnSp5wuN+i/GRPfsgmQuszaMUW3BszrZg4zwb
	 wdJV9PTkRWayrGcCnVQ7bo4lwfc8vDtay6WXl2F0bf+f6Wml/dkkiaZ2HkDO1dyWiX
	 lsMSu0sokjlxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] f2fs: fix to fetch ino via ino_of_node() under cache lock
Date: Wed, 11 Nov 2026 21:59:27 -0500
Message-ID: <20261112025916.1466516-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051458-failed-6.18-cd6d8b189139@kernel.org>
References: <20261107051458-failed-6.18-cd6d8b189139@kernel.org>
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
[ sashal: adapted cache-entry handling to folio-based handling in f2fs_sync_node_pages() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1b67184df3dd6..c0d125f67a911 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2155,9 +2155,11 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
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

