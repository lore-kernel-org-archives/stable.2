Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047979;
	b=taOoAw1nlAAkXXVOsMJ+5qaVhkWVBTkotsTumr1Ry8714KWd7eyJM/JUaDXbZ3LYcIQW
	 qGM0Py+vSb+4huYIZXulbIpACNh1pIE/K6WIpvvM/n6H8JqnKtBfm09uPQX3H9R3AK66X
	 6/W9mhhBV4u74nYq4yYK0YdXsN+9v3j/nT/dDujk7XotMTvc7BNtFiIH0XgQe1xLMCnVo
	 X18B93MKEQJoRBDjsPTjhQSLYLZRamoUbbAXrO82RXpciD/bVU7QVoWG1B6bWZKM4Ywr9
	 4W7U79FHiPUf0MChSGYv82cX5MXTgxud06I1vq32csf8kCte+zahLXMZu+ZGubkHkMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047979;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2UGujvtod8bUW7xYafyA8C8y97ruVADkEErBs1fZjvA=;
	b=BK8K/oCepV3yhQ+JMvRppIj9eG4n5ZAEv6p9mrYaiIzMjvvtK/E/LVvY+Nv1uLldMWkr
	 9ChJqvN4KEGL3NK5G0fyZbxDISegOWeHc7NyB4oOsBrOuWUSdga+awu4CRsMoH7Gf5E0u
	 iLkrJTSiBHSfiYMyGw6D2OPchiwdzsX515lZg5MdpJGkXp58Bh5LwY/i9CKZvmS6GWgYy
	 sHLZNFjkuqn3rSSVPYojZxYm0hxXIB7erp/HvkB0QfCOpMnwgh9GvgYpRFnU9q33vqEr2
	 8xGMb+D20u4GzG4TQ0gdEp64WQ8kgMzRNZwOBrHzGn/Zy+owW2XSf2lz4yQyY/TW+Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOZmhDO0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DE606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOZmhDO0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99251F008A1;
	Sat,  7 Nov 2026 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047979;
	bh=2UGujvtod8bUW7xYafyA8C8y97ruVADkEErBs1fZjvA=;
	h=From:To:Cc:Subject:Date;
	b=BOZmhDO07/1JzAMGnJcRW9ICKqQ5OmmUelayDfSbJ1S/prVZRFGxHszxgUDzCznzZ
	 5bZGBSy+xyvadCcgY24FVlFnXETn3y4qj5MVXkWdvdE5ydrN6qJCgiNT9Ho4t96rcs
	 EaLdEs7mp4dsrxbm47Gflq2IFt9OcyPdU+0bUBeBQ6rwMgXjRdmGmPOWGQ/igjiHt2
	 n40U1EXi/6LnoISNbNa5pTDu9O42t5r9M8jzqbm0fxxctj2soq7LpFCTGa28Ek/ACa
	 6ceHV5ZpGZNy8KPFIRKI07z3fNHLlsfC94FHxG21EZRr58JICgqqArDJeQ1V2vOaaG
	 hIT6eywCNPcNA==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to fetch ino via ino_of_node() under cache lock" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:37 -0500
Message-ID: <20261107053937-failed-6.6-cd6d8b189139@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cd6d8b1891395b681f2060916a4b83880b765698
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053937-failed-6.6-cd6d8b189139@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




