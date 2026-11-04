Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804836;
	b=VRlCKpZFVv4dOowPrN0I3kovwyy9KLjHVmPVJvCtqSZBNTbW5cyaqUs5C02dMkYt0jX2
	 NaB5CK0gvriJJPRpkaQ0Tg01qQe9tsEY2YzNj1cDq8J7WB2mhY9yTR6OmX96r3uh1Gd6v
	 4aTqNx+CakKaBvyuISq1EXAmkNjL+Bi77Ru/J8c4Y2q06UQkY18FiMcEK0ozvgkuereZx
	 eTe7QMYZK4a8zNTiM46xnOAtqgBDwnFvwmO0NVgBsFrKk+4yrjv0yF3E7d4LETpcY5mtq
	 RfNf0ODheXOPm7c40guCLU6Oa/pHTKoQqvzClolm2E8NKKlfod+cVQjhmGnHn/TCmAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804836;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oSLneu9q+hU1WKfRygM4ixoAvLoxBC7oJMRmH+ODFcw=;
	b=a+8EFW6qYd1vj0Avu/QNyka8K5b0pa4zKUliyoQ5u+JE/o5/iX41bbSV5atIUJu2xMum
	 uqcuIX78zaYT/b8n5IEvUDdmoUN41DN1eu07XDKjSzaAl8zXQpa/w5io43CMqOMLOevDs
	 W0Z8+euSrchtzNhoE+mYrBYGoh/PZUEqh/HPhoVAcoU7JWk2Xs2LnLltQxrBi1IiL9HiV
	 R22+lRxgmjPK/doMaq0e+XdaKbRzCPbamaS41DNg/jvl7l3+6OrO7+WhTB51DUOlkBpyD
	 wksN6JLgEpFoCt+y+SFwsOlVdUH3ytELmkBhw1b3KLxHZVEPlv4dcNBGKV2QYokj+4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=T3jbAetw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88343606A337
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=T3jbAetw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF841F00A1C;
	Wed,  4 Nov 2026 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793804836;
	bh=oSLneu9q+hU1WKfRygM4ixoAvLoxBC7oJMRmH+ODFcw=;
	h=Subject:To:Cc:From:Date;
	b=T3jbAetwnjH4kZT5YH3fTO8/BYXv28vxVZHqsA2P8JH1M/956sEi2Ph2VyyX7Qncu
	 Sukck4SttgUuaUELSpkL3mUQLwIzESiT2MgsNLO4M/j/egQw1WWZa6NS86+YimZ88M
	 bUgbH1u6qEuQqiH0oMiRd+9yDM0V8ds82FjDOFV0=
Subject: FAILED: patch "[PATCH] ovl: fix mount setup failing when override_creds drops" failed to apply to 6.6-stable tree
To: amir73il@gmail.com,brauner@kernel.org,disgoel@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:07:05 +0100
Message-ID: <2026110405-overuse-unsorted-8ffa@gregkh>
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
git cherry-pick -x 333ad304d4794d6384087ea7fc16e58ab642809b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110405-overuse-unsorted-8ffa@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

