Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803017;
	b=i9n52SxBKspjOtIhsms54ARHx5ngJlo9gMaJx42b48eCu0IR1UnAzjN4xGFNAi0lDH8U
	 ShAie9GexFhHqmGogswtpiB+YD7vUb/RMfmcOUxRy8dKKuckKCh5V85Ytp2iA1svSwoNt
	 7OW6wqRBUINwqfDhPp6PVq27zdGGuXPIiFYF0+Xlo0Nk3dson3Oy0NrPTt8NPTnDFi41g
	 SzLmzFYX0okO7+RiU3bEV9Qedr5os2etBqJMthQCUWLlYv0I1OuPqYHXbFGOdcQVZTM8r
	 cd5QpI6DvKWn3/DLdH1raHBh5ycdSgNSWb+NHwP9hBG0KmHeWSR+oLXvRd6Gs/bKACA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803017;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i6ZK5HzPJ2i9vTb7UQyLzhPXpFEY4dFnxJ/qgTGgpxc=;
	b=U3kwby+g2sDrXZkubWpPVia6xfSQ4QGDEgIjARSYM3+Jo/mD2d0EEtalJUyruhssLGOS
	 wsKKh2jFxh0Fg4FIMhq5nlpvJd3I0FsmdW7vdJXmXEMCkuf15EDcbyoBZWXDv+RCP/WD7
	 vMdrc4iWRUOJQ++aBnUDjT1KzeBORq2nb28McXnIpdCQQAmvSTsWxodBNM++m2V5o0Rhz
	 KqBM+HhZsO2uyeFMcEnDv1TEqw3SU/tw8XLmwjptt9Up0Lp4t7Cxg/AoXucKcnnF//kQ8
	 ju4Nofqeh/h+y1ODyDkhOIsa15fQm6Q5HX6Kuh10VbUJdS+lj6NN5xJXo7+cxvkdE3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=r1prrnqT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84B606A335
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=r1prrnqT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ABA1F000C1;
	Wed,  4 Nov 2026 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793803017;
	bh=i6ZK5HzPJ2i9vTb7UQyLzhPXpFEY4dFnxJ/qgTGgpxc=;
	h=Subject:To:Cc:From:Date;
	b=r1prrnqTrlJfIAtRPC775aFkW+0urWX8B67/VbCZDo8qoLPG6RB41NXalx7xHq03C
	 ygdExCWsTwgca8eiFwBie95FUXZHAQj3dn8PXPbTaHL6uZzfH0VZHf1dMw2X6sQgmh
	 +Z1JUTtbk8FZiiWUkiW3YjV4lApiZlr2vL5/BwEU=
Subject: FAILED: patch "[PATCH] ovl: fix mount setup failing when override_creds drops" failed to apply to 5.15-stable tree
To: amir73il@gmail.com,brauner@kernel.org,disgoel@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:36:47 +0100
Message-ID: <2026110447-bridged-battalion-b64b@gregkh>
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
git cherry-pick -x 333ad304d4794d6384087ea7fc16e58ab642809b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110447-bridged-battalion-b64b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 333ad304d4794d6384087ea7fc16e58ab642809b Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 17 Oct 2026 18:43:30 +0200
Subject: [PATCH] ovl: fix mount setup failing when override_creds drops
 CAP_SYS_ADMIN

When a process drops CAP_SYS_ADMIN and calls fsconfig(FSCONFIG_SET_FLAG,
"override_creds"), overlayfs saves those restricted credentials in
ofs->creator_cred. ovl_fill_super() then wraps the entire mount setup in
with_ovl_creds(), switching to those restricted credentials for the
duration.

Mount setup calls clone_private_mount(), which checks CAP_SYS_ADMIN
against current credentials. With restricted credentials active, this
check fails with -EPERM even though the task issuing
FSCONFIG_CMD_CREATE is fully privileged.

Use the mounter's real credentials only for cloning the private layer
mounts. Keep all other backing filesystem operations during mount setup
under the stashed credentials.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Closes: https://lore.kernel.org/linux-unionfs/20260924112858.51392-1-disgoel@linux.ibm.com
Fixes: c28f922c9dcee ("clone_private_mnt(): make sure that caller has CAP_SYS_ADMIN in the right userns")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index cc4b0959faf6..b452b8c5f641 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -503,6 +503,20 @@ static int ovl_report_in_use(struct ovl_fs *ofs, const char *name)
 	}
 }
 
+/*
+ * clone_private_mount() checks CAP_SYS_ADMIN in current->cred.
+ * ovl_fill_super_creds() runs under the stashed creator cred, which
+ * override_creds may have dropped.
+ * The task that issued FSCONFIG_CMD_CREATE is still current->real_cred, so
+ * use that only for the clone. creator_cred stays in effect for every other
+ * backing-fs operation.
+ */
+static struct vfsmount *ovl_clone_private_mount(const struct path *path)
+{
+	scoped_with_creds(current_real_cred())
+		return clone_private_mount(path);
+}
+
 static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 			 struct ovl_layer *upper_layer,
 			 const struct path *upperpath)
@@ -526,7 +540,7 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 	if (err)
 		goto out;
 
-	upper_mnt = clone_private_mount(upperpath);
+	upper_mnt = ovl_clone_private_mount(upperpath);
 	err = PTR_ERR(upper_mnt);
 	if (IS_ERR(upper_mnt)) {
 		pr_err("failed to clone upperpath\n");
@@ -1104,7 +1118,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 			}
 		}
 
-		mnt = clone_private_mount(&l->path);
+		mnt = ovl_clone_private_mount(&l->path);
 		err = PTR_ERR(mnt);
 		if (IS_ERR(mnt)) {
 			pr_err("failed to clone lowerpath\n");

