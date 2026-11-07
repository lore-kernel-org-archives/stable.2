Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047212;
	b=JnzdlTlVeY1GdvGp3MV62AotV2p8y+vwZEnqsoFpwmtBxSDCz+sjUZpfeAUyxmODq219
	 mbL64YNU8M9eHA2nW0Z8umIJ6VJp/Eg9p9squtJSXUIfCayH470lbzoEtDO8kbthHtqB+
	 p9FxKg6gnrwVa+b9+iF0kNuPN1u5XOFERR7UF/eZAHyv9ssleRe+kySzut66pPE2HFxL5
	 gEl7rW5hH15GE2K89aqTq120JTeiRAcg2/HLcUAimMULAuGN0Zb/0aFht9czyUisUM78G
	 uJmhM585RUSYWEw36lAJSdhHZP4cAB/dRQ+48oRPCGiBuGxwVNCpSK9nrkmFZXW5LNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1YyZRR0AAlzPFCbOW1YsND4zTd35IKRX6y+VPDmlMzA=;
	b=oYznFNw5FvGW0TSfZwHuiOOP0KoQhwJ76SGsW6yHhvAMLbkiwRCSph3171Eg63U0wquY
	 kfHFYl8FNHRZzvW28VbsOf9o2weuqQ2MMnLkQYLM/5zJvARGkm1hq2mv/p3v4smYJ4Smr
	 RQw46RLofkr3D3jVHcoeriQFiBG3sYwNxgCd6tiPAl37hJ7/ioW9MjTyAjsQ8+QV+9vK3
	 oI8pU3shQY4Ci9hX93cT/XYjIecf6Sh/sXisiY7mVSrvsW7Od9j1Pj+CCpCvU+67W3pm1
	 Y8R5evwUElhPwO8DU06lxGgOs4HdK7509C3va0K1pPW8Ql6A6qVCmDEnKQ1N0TR3Y+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVGC2RgR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0298F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVGC2RgR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0CB1F0089F;
	Sat,  7 Nov 2026 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047211;
	bh=1YyZRR0AAlzPFCbOW1YsND4zTd35IKRX6y+VPDmlMzA=;
	h=From:To:Cc:Subject:Date;
	b=BVGC2RgRker3YVKO+doiSpuNN+wYxc37LnfJT8clWU0vixgtqKML228jMlAutYeyw
	 4rlTVdaFdb4R+3IA7SErCXPSaVY+gpube4ZNSE+bbyvGOnEEYTHySZOKloyPRzqb25
	 IVvnGQbeSwI48B87nM5PyJUQZKoZ3rI3hNTuIIPxrEDK4Z4/LFFAEWegcWKRwqxQLK
	 dOOJcirHgFaIjNibbOdhlYHSW+uXG+gluQJF/Ss/KkdXmfzTlYkTbCzK8l+NWMn+v4
	 jCq04VNQeP00FeqiHgwgGv37ObRplRBmMrcrkiVJ52m/ToxYqrpcm0vO2rUUwZE3h+
	 LvFip/bdkk5Cw==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to fetch ino via ino_of_node() under cache lock" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:50 -0500
Message-ID: <20261107052650-failed-6.12-cd6d8b189139@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cd6d8b1891395b681f2060916a4b83880b765698
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052650-failed-6.12-cd6d8b189139@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




