Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272727;
	b=koWYi3BWFfQ+TMouwtJKKZLdKsnOXw9YYLeN1PTWfsU9PNs9q7LVKcx5gkOZNpna6Xtz
	 5hE+7bk6UOmHTxdLoTndp/cthjC9ytBXtsKT3xe4AgJskTEHGFXFjXTxmKKiXgS/3Jjhg
	 37QDewNnxYvNO+7sUCIMD8kcA30TbABvKKmVSPutVkM+clRpkxb1G49TQxcTl+eym8WNV
	 zngsS011h/cCZkTceH/9QO0esiKcF9i6pFyvP6AXeJyhQvBvme4q/y2BbA93llNGqETXD
	 NWsJe2R/bPCKFBLnfd6IL9SYiQJEndHuuSIE8/o4St537MtV+F4pF4s78oY1KRfHvFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272727;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EMgWYmlwlQYKG+bEJ72Tx0f0qpDf912g8FeayKvs53A=;
	b=Qp5R0MtkVs3Zq/arYCLTcrtZkO65p9pZBuBMuCsIfY39a2ZG9qn3HXnABzjJIutj5tSn
	 Acmper+efKCfbl1rwmIh1kJUS38hCFjFjwKjc5BuBUjTSGNCxTdomug3e8pqsgLSgdLOn
	 APv6iMW9+XHjIds0h0Z9hZGtCB0I/t1Te1+KpDWnlVaP8HXtKZ9w7d1h8bgpG2CTSRClp
	 ZdclV6mPHcyq2pPgATXOEx6O2xQwehH3j+QMyMxZh9n98//JiWM1H5MHIrsnFKzPd+12G
	 r3DgyjzgtAkxP5b/EM1+gPseZ4QZHd15mON4xuDJsX28I8Gc0lQdPsAcktUEf54e36g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDpNnxPQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C2606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDpNnxPQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA7E1F008A1;
	Tue, 10 Nov 2026 01:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272727;
	bh=EMgWYmlwlQYKG+bEJ72Tx0f0qpDf912g8FeayKvs53A=;
	h=From:To:Cc:Subject:Date;
	b=VDpNnxPQzf0qI3hZ7cJIIfaycBPs4XyP0b+KdloKDdJSO6DIb13TwLod9t2GXXf6r
	 ZglNMRlvAxQZxrYUxyrx2Gmc709PNGPGCWVKc2QNqqOobyHe2fMJeko79xxYd20w7g
	 oEl8K1kO/jLEyIKwm0Khr/uYPK+WNzXtQbvNHBVTaMeZfIFvusrkd8rlBUjtyYDcOT
	 DWzLPN9qEo5jA5n+eLrMS2NUMypU8ZAJwcLs1SnfZ+2XBHJA0nb0meWTAaSjXxhPgh
	 EgdA1mZVySRHvKrGQofRnsVv/z2u1ArWlua8IM0As2Nkn/EaF9emwd7MF4lroLPcwo
	 6y0ZZEuLJoxWA==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	dennylin0707@gmail.com,
	amir73il@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ovl: fail the mount if the casefold flag has changed" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:25 -0500
Message-ID: <20261109200525-failed-6.18-c782fc8ada81@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c782fc8ada811569811c0fdea5c3412511be95d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200525-failed-6.18-c782fc8ada81@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c782fc8ada811569811c0fdea5c3412511be95d0 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Fri, 16 Oct 2026 21:17:21 +0000
Subject: [PATCH] ovl: fail the mount if the casefold flag has changed

An unprivileged user in a user namespace can repeatedly trigger a kernel
warning with their own overlay mounts. They do so by changing the
casefold flag of the topmost layer's empty root, the top directory of
that layer, after the layers are set and before the mount is created.

The casefold flag of a directory makes name lookups in that directory
case-insensitive. All layers of an overlay must agree on casefolding.

ovl_mount_dir_check() reads the casefold flag of a layer root when
fsconfig() sets that layer, and saves the result in ofs->casefold. The
mount is created later, by another fsconfig() call with
FSCONFIG_CMD_CREATE.

The casefold flag of an empty directory can be changed.

The casefold flag of the overlay root must match ofs->casefold.
ovl_get_root() copies the flag from the topmost layer root, as it is
when the mount is created. On a mismatch, ovl_get_root() only does a
WARN_ON(), and the mount continues. The check is not a WARN_ON_ONCE(),
so each such mount warns again.

An unprivileged user needs CONFIG_UNICODE, and a tmpfs mounted with the
casefold option in their namespace.

Reproduced by changing the casefold flag of the empty upper directory
after the layers were set and before FSCONFIG_CMD_CREATE, with tmpfs and
ext4 layers, and as uid 1000 in a user namespace.

Fix this by replacing the WARN_ON() with a check that fails the mount
with -EINVAL.

Fixes: f9377faaeae0 ("ovl: Add S_CASEFOLD as part of the inode flag to be copied")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Tested-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d9174eaccce2d..8bc970748b96b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1387,7 +1387,6 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
-	WARN_ON(!!IS_CASEFOLDED(d_inode(root)) != ofs->casefold);
 	ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVALIDATE);
 	/* root keeps a reference of upperdentry */
 	dget(upperdentry);
@@ -1571,6 +1570,17 @@ static int ovl_fill_super_creds(struct fs_context *fc, struct super_block *sb)
 	if (!sb->s_root)
 		goto out_free_oe;
 
+	/*
+	 * The casefold flag of an empty layer root may have changed since the
+	 * mount options were parsed.  The root inode owns oe by now.
+	 */
+	if (!!IS_CASEFOLDED(d_inode(sb->s_root)) != ofs->casefold) {
+		pr_err("casefold flag of the root directory has changed\n");
+		dput(sb->s_root);
+		sb->s_root = NULL;
+		return -EINVAL;
+	}
+
 	return 0;
 
 out_free_oe:
-- 
2.53.0




