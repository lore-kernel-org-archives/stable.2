Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D832FD681
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988739; cv=none; b=oL7zgTY7qf2jvqBsW+/dwzL/ngAiJwLOCnK8yzByJZTjIEulzZU0fk3vH3pcbrVaxbpQMlnM4pOyMCgOVVEZwrW60TYF5PvVkq5Bsi0DM0YZGTjbGkbhoxjRLXSxv3bWHyB7JFyYY687hdVmPt7H9zeY2eEbX9Qx9XAppa4L68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988739; c=relaxed/simple;
	bh=WWi65sDZ/QohwCyrE7zbgsnvXGtKSotVsjlQNYKxoq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjAmhYQoqM6o8C2LUzjTRmbUqAgWAzEdqSN7ekhnwrZ+tXfF9Cr1CmjuO/pkgWM6IgsTLeZYiy1LauCB5ux+BcvnHD3MKytrS2aw53wGX5dT6Pvr/3TzAODWeBvKUJ1gBscVrhYapNdr7OpDUTD8yIEMqzVl1VmOd0jHE9QJLDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwlP2eYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwlP2eYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477E61F000E9;
	Sat, 25 Jul 2026 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784988736;
	bh=+3s4g85lfG04Aka4BPaSxBgWuz6cYxz/o0BdOW45/7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwlP2eYMfUTpdr57rMpSoKRup0ZbFKKDjO1vEZrPe6vKuJ0DOVsi7k7AQNhM16+Yo
	 9Z29Mi7Rj7XsUS5h8fwJV/+7M1LnusqLJN0C2FYs2bpflIVt6MU4OVvJyI0fB6U2bh
	 ZkIUxVHk0u9r9qmexZ7BgDt3KPTah1OIe4EFmpw7awDkuryChPzQUDefIdzxxkf4Lw
	 UneYLOhtuJS4ZIZFEtMAA6bsI0uG3vinf79vCMToZgDHYsnP3AsAX6aJJ+ptnnS81i
	 1lHddcu2Sw48Si2hu6a69nXM/iuUrw157kvW22OAlvXHM15zsSPz8k3d9Kibs1kuxY
	 srRnvhSy3WuRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] 9p: skip nlink update in cacheless mode to fix WARN_ON
Date: Sat, 25 Jul 2026 10:12:14 -0400
Message-ID: <20260725141214.3814197-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072032-shaping-feast-8dd3@gregkh>
References: <2026072032-shaping-feast-8dd3@gregkh>
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
index 495631eba3a697..1e7dce81012794 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -536,10 +536,19 @@ static int v9fs_at_to_dotl_flags(int flags)
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

