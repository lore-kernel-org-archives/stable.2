Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451089;
	b=WuiQ8s4YP7foPo8HY6KcYHqz5B1TsZNtY30fmg1aic/Vf5uN+djsReUsm20fV1v9YT1X
	 Q5NzRePgoFzZIr4PYAeCUsyvsiAFEf2qxesWf9U1n5TPIDBQ9zCLO2L8Ma0EDbEFWtRT0
	 8hWVhaEXbcy4MEXOUlGBv/yPGnbYmilTZksl7uzqOqxsE+nO/14LXBBgUbpNt6+N7RL46
	 7icoPfJ4gq8aWmIQ+Lpth0YhUB6RUi7kZtf+COmwgIr94NQfvWfPOxtjsnsrbf2u1TwWL
	 T7W4mC9t3oCWfC01MxBrd6sTN6whNu133zTTQJkWIEGIAfjhX38PmkDRTYZiHQfh4nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e8racYbECB7wcQJw7kn29tGcdem/Mi2Yvwuemj1DXoo=;
	b=FHgrC7Y7pWqFMo8mlM+INUNQiaA8gYQ3oN6fwtgNECz50yv6owQUl+YK8re8ke4bIz2l
	 Fvoqul/2go9e00HxsVriBoupzgHyf5DohNp3ci6w6G3fmkmZEOml0DMCE2kj1E1/+bCzY
	 88f/QI+2RDPqIjOZCiBfDr6IKYePH9sCSDnKS4GrWcrYTtBJXXxe83GefsBEl8PXFPlei
	 KIk18mKTXJBjvAmZzZ6O96iQ7K8iAItKAx19UQ8tfxrQibmcNkFPvhbYZ2Vf/fysnFKiu
	 pdU5Z4Hcy7BDBUvF2f4XKSk5NJfAf0DLQmOp2Ut566NxnBdMZMEs5uzxzHgNCb9MziA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWiHOwEw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261EF606A326
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWiHOwEw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2453F1F00A05;
	Thu, 12 Nov 2026 02:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451088;
	bh=e8racYbECB7wcQJw7kn29tGcdem/Mi2Yvwuemj1DXoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TWiHOwEwYax2r0U7pK7z6jX5yM5hR14aH/HJIOH33yOC0HY1utmAkzVRprSn2P8v5
	 eOaLLEHPI4IuO/kqfu0PWv71BSS8uF4aJioKuJGVa2P2Ys6Ak2d336zk1lYGsPcOf4
	 xnUslPC1V6mmsMdBLZdIfGrmAYuwk+1CH4W6PJlg/cTINDTfRsCmE188plIvB3oIII
	 vbw8K2SAOCdfy0aj6tu6APl1r1Pi26H825GfPJ6lqv0PsCy4fNpY3rsgiMMsBQAxJ+
	 Z7Gwt4/dQT0h0ApNjEKPu5uAWNLv2yZDqnXtadEdqv4KADtAJb0IDbDTdk+iagW1ZF
	 2HRYApPeKPoMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Edvard Conrad <edvard@tuta.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: inherit FMODE_NONOTIFY when opening directory realfiles
Date: Wed, 11 Nov 2026 21:38:06 -0500
Message-ID: <20261112023615.1405097-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202416-failed-5.15-323899b4ed23@kernel.org>
References: <20261109202416-failed-5.15-323899b4ed23@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 323899b4ed233d5b6e2fc160c16fbf39cf0317da ]

When fanotify hands a listener an fd for a permission event on an
overlay directory, ovl_dir_open_realfile() opens the real directory via
dentry_open(), not backing_file_open(), so the lower open could still
raise FS_OPEN_PERM and deadlock a listener that also marks the backing
filesystem.

Export dentry_open_nonotify() and call it from ovl_path_open_realfile()
when the overlay user file must not generate events.  Ordinary
ovl_path_open() callers are unchanged.

Reported-by: Christian Brauner (Amutable) <brauner@kernel.org>
Closes: https://lore.kernel.org/all/20261030-welpen-anbinden-nullen-b2432cee1d10@brauner/
Fixes: 130fdbc3d1f99 ("ovl: pass correct flags for opening real directory")
Cc: stable@vger.kernel.org
Tested-by: Edvard Conrad <edvard@tuta.io>
Link: https://lore.kernel.org/ltp/P5Iny41--F-9@tuta.io/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: passed __FMODE_NONOTIFY through the existing ovl_path_open() instead of calling dentry_open_nonotify() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 10 +++++++++-
 fs/overlayfs/util.c    |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 896bc521bcdc3..eef6c5d1b1f8b 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -850,9 +850,17 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 {
 	struct file *res;
 	const struct cred *old_cred;
+	int flags = O_RDONLY | (file->f_flags & O_LARGEFILE);
+
+	/*
+	 * Inherit FMODE_NONOTIFY from a fanotify permission fd so a listener
+	 * that also watches the real filesystem does not deadlock.
+	 */
+	if (file->f_mode & FMODE_NONOTIFY)
+		flags |= __FMODE_NONOTIFY;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
+	res = ovl_path_open(realpath, flags);
 	revert_creds(old_cred);
 
 	return res;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 06c26f061e675..4aac752a118b1 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -502,7 +502,7 @@ struct file *ovl_path_open(struct path *path, int flags)
 	struct inode *inode = d_inode(path->dentry);
 	int err, acc_mode;
 
-	if (flags & ~(O_ACCMODE | O_LARGEFILE))
+	if (flags & ~(O_ACCMODE | O_LARGEFILE | __FMODE_NONOTIFY))
 		BUG();
 
 	switch (flags & O_ACCMODE) {
-- 
2.53.0

