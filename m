Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049945;
	b=wS4Y87DEtrXkMrmHG9uxukULuCIbcFbRqpgPP6ObsjODVnGraew+q3nsrA80gPKBiIil
	 iMKqiQvsbdKmp59l9UA71UFNGm3zNEFTJxrJxnv+Yn0jX5fZUJDQ/S8wvwOi+BxageNgH
	 bnAztYjYM7RuBOZXawQgaa7rJZ2ZfeveCJtcsDThHp9MkE40PTQVY+WQrd0zL8zjkQ/eG
	 WhVtV7GJiPEzgujaTZrWV1PudNU7mD06djSjZCnmbROKX8ilkZA/sQlr2jEjTTlE5eBzI
	 DfWrb3fs+zAh3N8pC0Ko77IO5x76wT3xZg3Ttx3NRbMFq/XtXT5d9UnLXGKIRlcUTSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049945;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wHCMmbbP0wpCRBIuXiNfWlljoQpBlGkRa7g0lbpE4bg=;
	b=Yr6c0QFBjEzEVPBLl9SoF2hJQujq35KnGoZr1szJSYRh78SIMzprBKT/wil4nxipC7u2
	 MmnGpPkclNu+9pQ16dTiX2hRayOfMDpLre7D3uvZws2b1JR4GN2gyfzRiK8BW77iTjJbs
	 YR9IKq+VlRZDlbgSDVo69ZOVhTUinXKRmSOggy7Gb0VWRGBXGC7HombvdJdrI8GDyzqay
	 mpp5rYgWAkMz8CLChSf4IzMnmWs5ijxigSv8AgEQRXdJfPAxdRNFbE0inhrEojGNn1qvt
	 /Rr/Oa5jvsmvMWgvBbIi1iC6RprsPYLVrlZmQM2aESxQMtCXeIzMEZ6UI2KLtKRFVgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0B88XF2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8F606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0B88XF2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9BF1F0089F;
	Sat,  7 Nov 2026 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049944;
	bh=wHCMmbbP0wpCRBIuXiNfWlljoQpBlGkRa7g0lbpE4bg=;
	h=From:To:Cc:Subject:Date;
	b=W0B88XF24zAv9rTAefY5TnDJJ1BOZFjOA6CzJqH/yAkvH9Q/oGTrhdYnwp+7hKhcj
	 PRHgQdQ+SqzAEJkWi13oH5UzLhLyQ0j1pz950sEMTYGNh3Af2t0mkQ6flk9/rIGarW
	 BcR1lX5NAkTIeBBK3oK2nTlCktceMOF6rUM1UsIsNLiKH7i+zGsCubFV92TsQBkWpX
	 mA3MUh/O3gBjNA1Gi4VwTOh2gWb1C+n7M1H0U+CFciWbxANdwfYDuPhyQY60WZqMHe
	 ArB2ihDxUBMlOeJQPRZMc6IC6vf2siDxmuXVQ9s7oS90eoH1wb5gIvjiX1MuUD/yjm
	 ngleNcDEX2spw==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to fetch ino via ino_of_node() under cache lock" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:12:23 -0500
Message-ID: <20261107061223-failed-5.15-cd6d8b189139@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cd6d8b1891395b681f2060916a4b83880b765698
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061223-failed-5.15-cd6d8b189139@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




