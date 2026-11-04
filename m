Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804826;
	b=p1Tw0OxiX4Z68MjLKH2DhjllCr56E6i3IKyYzFWwVhwoyIS99xd8tuEiRHjBhub7vD09
	 p4taLza7AWHvrDPqX4SS7ZFpntF1RH/MB8pmVNyt4dvrTjuFm03gEATCw9D7WK+MIFQSF
	 kSdGZzjFKWGlz07XUBfUWEXWgz7wl0qV+QRI8SrM4U2BJCKjR3oL12NtZAX7m7hwBjrPw
	 pe01itOg2bF3tVPom4zqhbwnlJT+0a0KezymTQcEIbX5v10DVzICw67Mz05DdVSY5L2PK
	 eIPj2u5CCABcPiPH+Qh+srfACrnLLEjCJP7CVR5/xHNqmRn/lgiCPneNlNtuTsEuf0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804826;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DFc1MUb3hpfO5G//Ubc8PIaCQn63+FYV1/D5MOgpwvk=;
	b=nT8pFm9WoA57TXb0KWe8qbVuDS/hoOyy+tXp61EQaEb5o/5qwz7qAOuFgfnSJk/p/07t
	 mhYv58dT/SgXY/DmmKrGn60I6X4rsSrWYX+3tG/q9n9WWhXhNYXXJE/uaJQnlwp3+C9Iw
	 /gYq+6fvcIzzWA8t+zjv7eAVzi3uDRwSwSlr4hgt3oYjZZXaRGpJrJ2/yqEsoS6I8mTZ4
	 dpAoyO/9jXr/myGw1mU4iz98qFdzs2lK8qPTeYQVkVO2q4Lj2gKwcaovMVkru7gFxja9x
	 k9LRvfG5O29zszHGY/QbSZsPApoWsvNVZgXIh6H7QujOnuF8RMiji/lINWDGJoghIJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=O7lc+2Z6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36B5606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=O7lc+2Z6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854571F00919;
	Wed,  4 Nov 2026 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793804825;
	bh=DFc1MUb3hpfO5G//Ubc8PIaCQn63+FYV1/D5MOgpwvk=;
	h=Subject:To:Cc:From:Date;
	b=O7lc+2Z6jZydHXVIo25m8SWDGrRz3789BbblnaBA+P9JQe4rvmCJH4pXma7NsIFZ3
	 OunkWgy4ct4AodeHCmxwFe/pj71YHVOmlPH2GHDPlrj4R2Y4es8AFc4hMVuvii93pi
	 BjiVssTTr1EjORIcr+0AWIdiw1c5gjDGB0Am4sdo=
Subject: FAILED: patch "[PATCH] ovl: fix mount setup failing when override_creds drops" failed to apply to 6.18-stable tree
To: amir73il@gmail.com,brauner@kernel.org,disgoel@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:07:04 +0100
Message-ID: <2026110404-yonder-underfoot-3469@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 333ad304d4794d6384087ea7fc16e58ab642809b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110404-yonder-underfoot-3469@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

