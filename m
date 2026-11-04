Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802956;
	b=EPVkL8r3YKZLZfmaXHhwpAG+cnpxLxTFL8SunsTYWo8ta6MOZmsfT+1uVe0zdTongGIM
	 e/WGndZs9yYrB8dSJ1/gBNGDbcsIeW99uLRMyKe+hKV5tCkKLDMHkRulMFj1W85BQznWY
	 L1upg3nijJeX/xo/BGwfrhtw/X4yo0B8ATW8U776QVUmC4X4oTShE4OvcYsQ6+wCNErHn
	 GIutC/PvcGVr8nDqwdfZUahcpPsOWuLGOzPwseHv2CcpuAPcNi9o11LUyMtL4ofisJcCT
	 SEScQmWy6hwje2otR5oClreGOmtW1NXYPtinH0JI/vz0bXLwcVVW5KM3RFIm2ayiiFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802956;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tC8oLPRueYzaLQRpeypVDCls/xOaTxfcryDUfA7ESW8=;
	b=n9NDFE0u2kAGorJYndyRxCrFm1SALxD6CAdTI8H7LwWFjqAtphpJXVgoygYke2PARKOS
	 UFY3/aY1gtUWiEEwbApI+4+YJ03g530wlJz3BPWhqi+yQr/rmWoIKx5vJ1fPk+OFhtMX3
	 yna75bPNGMgIuvcvv7xyycUC8P6Km5sYZ4EVTti/UEqiF7cXBsnrTdoFAoi8CwdIRNddm
	 gAMWLfyGCuuRpyFrXQYOeeovD9F7UpLJYZxTefXRjelaE4y4+LqD34SUkkAZ4niUxtLKh
	 DxmAfVaFjKn3b708U9fgwC1ASMW4/E4zkrfa27SKatRB9Q/YnohhS5rBAX96ZAUkobg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=t0azw3st;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D2606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=t0azw3st
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69151F00919;
	Wed,  4 Nov 2026 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802955;
	bh=tC8oLPRueYzaLQRpeypVDCls/xOaTxfcryDUfA7ESW8=;
	h=Subject:To:Cc:From:Date;
	b=t0azw3stI0dc1xhnbx7Xr3gOfmeszRqkoaK2yDZK37Yi+cAROiSKuwAqbDnnDKLUF
	 lVfIp3/WD244MpfqOJxMZosqGaQjJsFOS7DcAh7yQ+BXu0nAMwbXbuJjrLGdC/LQDH
	 jzXrsMw4dKC9sGI+lEwc7CkoNPewQYY/oaaoM2fE=
Subject: FAILED: patch "[PATCH] ovl: check that the parents of volatile/dirty are dirs" failed to apply to 6.6-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:35:52 +0100
Message-ID: <2026110452-detonator-keep-c227@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e34d2ef818e4c7676d8d8e1bf43e6a1ed39efb2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110452-detonator-keep-c227@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e34d2ef818e4c7676d8d8e1bf43e6a1ed39efb2a Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 10:15:11 +0000
Subject: [PATCH] ovl: check that the parents of volatile/dirty are dirs

An unprivileged user crashes the kernel by mounting overlayfs with the
volatile option.

A dentry that serves as the parent of a lookup must be a directory.
ovl_create_volatile_dirty() walks work/incompat/volatile/dirty by name,
and ovl_lookup_or_create() returns an existing entry whatever its type.
A file or a symlink that another task creates during the mount becomes
the parent of the next lookup, which calls a NULL ->lookup.

An unprivileged user mounted overlayfs with "volatile" in a user
namespace while a second process created a symlink named work/incompat,
and the mount task oopsed on a NULL ->lookup call.

Fix this by returning -ENOTDIR from ovl_lookup_or_create() when the
caller asked for a directory and the existing entry is a non-dir.

Fixes: c86243b090bc ("ovl: provide a mount option "volatile"")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index bd0a3f9039d2..18f56d463572 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -621,16 +621,21 @@ cleanup_temp:
 
 static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 					   struct dentry *parent,
-					   const char *name, umode_t mode)
+					   const char *name, bool is_dir)
 {
 	struct dentry *child;
 
 	child = ovl_start_creating_upper(ofs, parent, &QSTR(name));
 	if (!IS_ERR(child)) {
-		if (!child->d_inode)
+		if (!child->d_inode) {
 			child = ovl_create_real(ofs, parent, child,
 						&QSTR(name),
-						OVL_CATTR(mode));
+						OVL_CATTR(is_dir ? S_IFDIR :
+								   S_IFREG));
+		} else if (is_dir && !d_can_lookup(child)) {
+			end_creating(child);
+			child = ERR_PTR(-ENOTDIR);
+		}
 		end_creating_keep(child);
 	}
 	dput(parent);
@@ -652,7 +657,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}

