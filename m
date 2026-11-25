Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604599;
	b=A4vh7JU5b2TOHrvpAzUJHg+UUZHUKvNlokhgqASnAfqQnaIcc0sP5ESFuXuoI0WPvdEe
	 9OkB1mQc8oid5S0MFoe7adYuSROKn1p+U1wJd+zXzJl0nQXS5YoAPlQdekZBBVXXPOCdN
	 XLeI43QPvxV0phWNc8JCy0N4uhEYURMrGLh95u0E6pEs8qDO6XQ+91ecBug24AqYP1T6U
	 r6HPh7QCPahAS0txGLoNf3J3navQGyMH06U14j5IZheDHX4I8R7trE9I5MSvfsLsHxP0I
	 BkVC8dRq+8TO8cpR6wQJBiyWSRN0qjCP6L03HGvg9L86XOGnVjBQJ+i6c2lSA0V8GDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604599;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y4sbTNFZwXkb1hQqemRpQKMyNugPud6leKyDPiq/YP4=;
	b=G1MG8V9GibjpHB9DtHqEZ1jXzZTNGNIdAEwVEZt7E4cHItIfO/hlwptPRXWaMj9IG0AU
	 6ULWsPiZeJrd2D4EDmquyLJCZcBwpuHm+ZVGYNUWZ64DGJnwTIg68rmXYsc2zXh+GJNGm
	 OHH8ClctXYrS3fomsPOeTHS3ud/m3uKXYGjk7bSpVCA35WjuL5O5jZ2iNZfu0RroScG7R
	 dQyRFO+1BxL1A1OknQda5vBbegByxJVmT3MPrJ2I1gz2BLbLFSnoMyONK6KPDdzTOiOqQ
	 b8YE3tmNvraUugpmh3b3Q6M72JnkBEOCdNlQoZZzLqiRMLLE/e5S8RVtOlewiXej4Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=x7TIgzZX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B2E606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=x7TIgzZX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAC21F000CA;
	Wed, 25 Nov 2026 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604598;
	bh=y4sbTNFZwXkb1hQqemRpQKMyNugPud6leKyDPiq/YP4=;
	h=Subject:To:Cc:From:Date;
	b=x7TIgzZXEmKT7SB1I+VcK99758s7xN42iNXSvSJSMV8P1XExPYyeWB7/1k4B/BMJ/
	 1T9du3TaLoMYDvRBFOe7RlnYcIh/hAcAAm3rGm8Fkgzk/fSnyayb8GzZopATx5AJ5m
	 Kon0MUppuvuZfQNJY/LvC3GI40OYDFXmSgQtxzfw=
Subject: FAILED: patch "[PATCH] ovl: reject different lower idmaps on the same fs" failed to apply to 6.1-stable tree
To: Jeremy.Jean@oss.cyber.gouv.fr,amir73il@gmail.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:46:00 +0100
Message-ID: <2026112500-shrivel-harmony-7572@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 720f40c05b2785406121da0151543751204f2953
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112500-shrivel-harmony-7572@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 720f40c05b2785406121da0151543751204f2953 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Date: Wed, 11 Nov 2026 22:42:26 +0000
Subject: [PATCH] ovl: reject different lower idmaps on the same fs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Overayfs mounted with index=on or nfs_export=on require file handle
support from backing filesystems.

Overlay file handles identify a backing filesystem, but not the lower
mount used to decode it. If lower layers share a superblock and use
different idmaps, a handle can decode through the wrong layer.

Record the first idmap on a private lower clone for each backing
filesystem. Fail if another clone has a different idmap. Comparing
the private clones prevents mount_setattr() from changing the checked
state. Distinct idmap objects are treated as ambiguous.

Fixes: bc70682a497c ("ovl: support idmapped layers")
Suggested-by: Christian Brauner <brauner@kernel.org>
Link: Link: https://lore.kernel.org/all/20260925-server-hager-riskieren-06116eded213@brauner/
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index ac07e8769f9b..5b2f1b930daa 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -24,6 +24,8 @@ struct ovl_config {
 struct ovl_sb {
 	struct super_block *sb;
 	dev_t pseudo_dev;
+	/* Idmap of the first lower layer on this fs */
+	const struct mnt_idmap *lower_idmap;
 	/* Unusable (conflicting) uuid */
 	bool bad_uuid;
 	/* Used as a lower layer (but maybe also as upper) */
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ad623e392122..e61aab1999d3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1143,6 +1143,29 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 			return err;
 		}
 
+		/*
+		 * Lower file handles identify the lower fs, but not the layer,
+		 * so with different idmaps on the same lower fs, index and
+		 * nfs_export may decode a file handle through a layer with the
+		 * wrong idmap.  Following copy up origin without index is only
+		 * used for st_ino, which does not depend on the idmap.
+		 */
+		if (i < nr_merged_lower &&
+		    (ofs->config.index || ofs->config.nfs_export)) {
+			const struct mnt_idmap *idmap = mnt_idmap(mnt);
+			struct ovl_sb *fs = &ofs->fs[fsid];
+
+			if (!fs->lower_idmap) {
+				fs->lower_idmap = idmap;
+			} else if (fs->lower_idmap != idmap) {
+				pr_err("lower layer '%pd2' conflicts with idmap of another lower layer on the same fs, mount with '-o index=off,nfs_export=off' to override.\n",
+				       l->path.dentry);
+				iput(trap);
+				kern_unmount(mnt);
+				return -EINVAL;
+			}
+		}
+
 		/*
 		 * Make lower layers R/O.  That way fchmod/fchown on lower file
 		 * will fail instead of modifying lower fs.

