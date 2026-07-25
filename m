Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89412C181
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992945; cv=none; b=It8clCljtdMjlyCN+j6ZLaKmRk4qCQ0/WI6PUbqRBaHlbiQ2sUj5js7lSPHvV/+SfGunO+QlYi1BBUD4XMPtIL9Lko/CqTpn64WUGM+vGFCcLtq/2vASwEtM2fdfJp0ERuYqi+2DtFIOiMhUSL5Nx8d+e8NkT1d5TWhzwon8uHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992945; c=relaxed/simple;
	bh=UDA8sxsFrJc6kse0pjsO7q6KXTTXFlEyg3CupuSNzk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgLDH6IP8Hc2NyqQQYq4dmHNsHUosfFYfSbGe/d8MrLi6JhmNgG5dwM/980y9VS6R8LdDsCniZxREPtVAEBTirdX1Q1szrhRUNQYq+7ap1ni4EF4mJ766Cm/aboYoxAEo9PEP2lWC1aHiGFjycVPzUXgd0cxs9DsjSK8fmc2Pqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHyEtjeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHyEtjeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BFA1F000E9;
	Sat, 25 Jul 2026 15:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784992944;
	bh=z7QWoHe4SRU3kL+//2y2tkGQOyHEaXgIVxBkqDdiZJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EHyEtjeJi1GUFW76pGAmm+q0SGeh+5OHxueHnw48XJ02srFC1i58C+7O/Aa/QRCrv
	 QBRMpgpH9imvIv6sVlQx9ugwyRiB8T00QtStUtpbgPodE4fvVNLIvkDYJaeux4q1b+
	 l/3m8dh9U9j+0jP2dggJ829/AfFNwjpMFdysGUwGaWXsHfN8D7S7JAeJPz2mjMqmZ2
	 6NNqJ/wXbBi7p8Ajb2l0js231tqn/ohN037LkJZCBbpTsNNrdp9+yXO1Tb6qn9c2Nb
	 UISXxWhCKBDnlciFte+yXNq91+CsTSb51UInL2rGyeayUOpG62VNxoNSGCQGSx59Ab
	 Uu5DengdqGUVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] 9p: skip nlink update in cacheless mode to fix WARN_ON
Date: Sat, 25 Jul 2026 11:22:21 -0400
Message-ID: <20260725152221.3856854-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072033-zesty-lustily-01bf@gregkh>
References: <2026072033-zesty-lustily-01bf@gregkh>
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
index ef103ef392ee3a..2caea3390d6a51 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -521,10 +521,19 @@ static int v9fs_at_to_dotl_flags(int flags)
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

