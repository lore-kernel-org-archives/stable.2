Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802939;
	b=krQg83Xs+kZchCKgPJsKjf0bpGqmvRjpYs1OIKH8+S1immBeeD7/X3t97weJ7LtZPcjo
	 sGPUxntssU3nQJ7qH5wUTxaOo7jBTwYQ+u+h6By9g/juVwiLlOGkrc/H2jZQU87WwyWy7
	 IAaRY8lgc78p8HIIj3Yg4cNZkmDbf75XNdBv7iTH1VAEiWXoR7GVKpPZ0+eofkW+RfDfa
	 68R8crhvlqFlAR/LFLWRYQ7ApfDGGJh/9srE9FmPOHsz5DnDP5Ut6DbJAqvR1i2XBb+rm
	 xqefK4EgnjfBrq9seojc8/N+YkrzuJtxzyu8PefdOOQATULqpzqkHcB/Ma2ywNsoInw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802939;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=munQ4GdZWEHA+aIL8Bmr8vK5MrxF7ZP+9PmAs6jdb9Y=;
	b=mUtE0lmJCMcdOh9mAdKPvXn1VWZVWWtEI8D/TQ5VAV/2mnDRJhKKe8Dihmhj0LAS4Npf
	 nrm8/GVUdBzPig5qc8i7nwEZx5sCEWRRqBU0q9BKblulVAO/0WNn1wuqcT7k2hjOgZie0
	 t6dp4LndVkDm3lpfxOs2pZqCaIpWiZmNNPW9RX8HRQrPJ6rULExqIv+3kVXTvw1d2d8D9
	 0HXI3odZgOjs8g63lNHBOvB2mQXKTDL5ohIjOf5S1Sh9T7m0wkpmcPLxtGZ/OKukipGgJ
	 ChU/+PCz2NH8Yn/pK/8pSWPxS7gA7nEVm1naWNXiA3Plev7ubkopWSOUi4uILnt9bHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BrwJCWCb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569A606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BrwJCWCb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8314A1F00919;
	Wed,  4 Nov 2026 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802938;
	bh=munQ4GdZWEHA+aIL8Bmr8vK5MrxF7ZP+9PmAs6jdb9Y=;
	h=Subject:To:Cc:From:Date;
	b=BrwJCWCbnbkR+eaoNfwOlzySumgu1EKFgp7VXQjuJYbK3GtF5sLU7A+Rh6Wwjxj+f
	 Gjjasvb5zbWpd0XPRvyTILjzZsCQlKQUBX3NsjOZ9s0Mc6rOac4fhDnjz6RkcbLX95
	 kDH6HeEXtXVoCEhjvywh7CYTa5ErlVNkVh49X1YU=
Subject: FAILED: patch "[PATCH] ovl: use the pinned upper dir in ovl_fix_origin()" failed to apply to 5.15-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:35:27 +0100
Message-ID: <2026110427-caddy-nimbly-6a47@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4f61ff2ebfb3d2967b83b6a4d456242244d5a61f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110427-caddy-nimbly-6a47@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f61ff2ebfb3d2967b83b6a4d456242244d5a61f Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 10:47:10 +0000
Subject: [PATCH] ovl: use the pinned upper dir in ovl_fix_origin()

Renames made directly on the upper filesystem during a lookup crash the
kernel.

A dentry that is passed to vfs_setxattr() must be pinned.
ovl_fix_origin() passes upper->d_parent to ovl_set_impure() without a
reference, and the lookup holds no lock of the upper directory. A
rename on the upper filesystem changes d_parent, and only the child
pins the new parent, so a second rename and an rmdir free it.

With delays in ovl_fix_origin() and ovl_set_impure(), renaming the upper
directory twice and removing the intermediate parent during the lookup
of a merge directory without an origin xattr gave a KASAN
use-after-free in vfs_setxattr().

Fix this by passing the upper dentry that the overlay parent holds.

Fixes: 9678e6303057 ("ovl: fix inconsistent d_ino for legacy merge dir")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: add helper ovl_set_impure_dir()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index ca899fdfaafd..cf7908a39f61 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -942,8 +942,10 @@ static int ovl_fix_origin(struct ovl_fs *ofs, struct dentry *dentry,
 		goto out;
 
 	err = ovl_set_origin_fh(ofs, fh, upper);
-	if (!err)
-		err = ovl_set_impure(dentry->d_parent, upper->d_parent);
+	if (!err) {
+		/* upper->d_parent is not stable, use the overlay parent */
+		err = ovl_set_impure_dir(dentry->d_parent);
+	}
 
 	ovl_drop_write(dentry);
 out:
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 7f3558372c59..c89739e5338b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -572,6 +572,12 @@ int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry *upperdentry,
 		       enum ovl_xattr ox, const void *value, size_t size,
 		       int xerr);
 int ovl_set_impure(struct dentry *dentry, struct dentry *upperdentry);
+
+static inline int ovl_set_impure_dir(struct dentry *dentry)
+{
+	return ovl_set_impure(dentry, ovl_dentry_upper(dentry));
+}
+
 bool ovl_inuse_trylock(struct dentry *dentry);
 void ovl_inuse_unlock(struct dentry *dentry);
 bool ovl_is_inuse(struct dentry *dentry);

