Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B61364926
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067243; cv=none; b=uqEbvgNEM6Kswd9r3T05PVsXk3M5bITt6+npDS25v34RErnff2OIRtCeRcsQNYN1w/Z53FHQG/3tq3nILOz7gnIq7JOxFxppevHfLgDu2Yx5158/vwLLyPJcpkypuso73vbMS5kxOI9GWHzEuodqc90t7IxyGg5ztWs3HP50sZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067243; c=relaxed/simple;
	bh=8hFMzqX22woYakYRrfGSwO1wKjzgLJLMxRf+xmDgwFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7G/9tsmjnXJajzUvDVwS16NSHzYP8MehXKHY5XtZkXIG7VbqO1TLB7YpFRxSjjjOa3kgePD3HU6xSJbjUZhDUQpoZFeo717d/qF4WDh1TqbYjUaD2G7ps8CVDaLQAJ2PID1JjfKe8GcYsRG1J96IMv9+S6dqlQ2gEFuZ5Z/+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYsK6r1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYsK6r1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFAA1F000E9;
	Sun, 26 Jul 2026 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067241;
	bh=urm895x4mlFs1grfDswmfx4FtX/p8EQhCNH5UCxqTeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kYsK6r1pg9pT/UtT01zLekWxHjuRXfH6QQVNZ6vAZgpJ3sKtBWA8k6fvSyWjpz+KL
	 2oTnFra3HlV6KA96SFn8PPNP1L6IveiHkLC1FLmV/oePPncPV7L2ptyJ+yuZczxIjY
	 iuRY+ZT3YsTdfcj90Z0ACaTca9M+5Twjx7eeQiqYfoG7vBv/11Qf8jtI3qUbdewdau
	 HKCD9CEW9Q9f5+UY79RA36R+YZuGc3g8ItDARAOPxB1q9fvDwdUG8IfXDW8ZUfFtL5
	 alTYY5Gz1KQb12LGTF83Wb+8outiRQGMRhAFnfZppSkji7uSAbm5PuBkEXv9BwI/29
	 JIBtutF2QnhmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] 9p: skip nlink update in cacheless mode to fix WARN_ON
Date: Sun, 26 Jul 2026 08:00:38 -0400
Message-ID: <20260726120038.4138049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072033-jubilant-cannot-6e20@gregkh>
References: <2026072033-jubilant-cannot-6e20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 574aa0b4799470ac814479f1138d19efe6262255 ]

v9fs_dec_count() unconditionally calls drop_nlink() on regular files,
even when the inode's nlink is already zero. In cacheless mode the
client refetches inode metadata from the server (the source of truth)
on every operation, so by the time v9fs_remove() returns, the locally
cached nlink may already reflect the post-unlink value:

  1. Client initiates unlink, server processes it and sets nlink to 0
  2. Client refetches inode metadata (nlink=0) before unlink returns
  3. Client's v9fs_remove() completes successfully
  4. Client calls v9fs_dec_count() which calls drop_nlink() on nlink=0

This race is easily triggered under heavy unlink workloads, such as
stress-ng's unlink stressor, producing the following warning:

  WARNING: fs/inode.c:417 at drop_nlink+0x4c/0xc8
  Call trace:
   drop_nlink+0x4c/0xc8
   v9fs_remove+0x1e0/0x250 [9p]
   v9fs_vfs_unlink+0x20/0x38 [9p]
   vfs_unlink+0x13c/0x258
   ...

In cacheless mode the server is authoritative and the inode is on its
way out, so locally adjusting nlink buys nothing. Skip v9fs_dec_count()
entirely when neither CACHE_META nor CACHE_LOOSE is set, which both
avoids the warning and removes a class of nlink races (two concurrent
unlinkers observing nlink > 0 and both calling drop_nlink()) that an
nlink == 0 guard alone would only narrow rather than close.

Fixes: ac89b2ef9b55 ("9p: don't maintain dir i_nlink if the exported fs doesn't either")
Cc: stable@vger.kernel.org
Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Message-ID: <20260421-9p-v2-1-48762d294fad@debian.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
[ Adapted `v9ses->cache & (CACHE_META | CACHE_LOOSE)` bitmask test to the pre-bitmask exclusive enum form `v9ses->cache != CACHE_LOOSE && v9ses->cache != CACHE_FSCACHE`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 4ffb0750c79b94..74ecf2c9dcbd93 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -516,10 +516,19 @@ static int v9fs_at_to_dotl_flags(int flags)
  * - ext4 (with dir_nlink feature enabled) sets nlink to 1 if a dir has more
  *   than EXT4_LINK_MAX (65000) links.
  *
+ * In cacheless mode the server is the source of truth for nlink and the
+ * inode is going away immediately, so locally adjusting i_nlink buys
+ * nothing and races with concurrent metadata fetches that may already
+ * have observed the post-unlink value (nlink == 0).
+ *
  * @inode: inode whose nlink is being dropped
  */
 static void v9fs_dec_count(struct inode *inode)
 {
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+
+	if (v9ses->cache != CACHE_LOOSE && v9ses->cache != CACHE_FSCACHE)
+		return;
 	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
 		drop_nlink(inode);
 }
-- 
2.53.0

