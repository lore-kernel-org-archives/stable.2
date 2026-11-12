Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450738;
	b=E/0v0vajX+M6BpnueeK+wypTGhyWnsaJ6abNmxBakycc2ZJfPrPU8DNMe1+0CB5B7pfN
	 8fJlg4hs+PqfGd7NYkOLCV3qmjVpRwAe8Tc6gdsJV4kKW1hiMM9y22PCQQAKxCGwoE0JU
	 LU+EkoyLrChYDzZFfVDQs4Iizd3DHqToIzkdLFDJDtrE+3vrdC1tVZtMiYsyuUkmLNTep
	 06aWtTZLSYZLsvi3H7YrjuUUzpZZ3ZfgA1wdpcBPJ3/mau30OSBC5dcM1xu+c2rsXdWwl
	 0+FC3z1axlXjQw4BViiox7UuTxCSGpP3DyxyoV5/cbuXtjb+Bu0Emyw00kNt0XkRt6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450738;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ObXXE3SuFk7hda+oDvW2wcngecvTocyXpSxN2HoTRbA=;
	b=i+7pxmmotFuNOLFZY1bXGrklFqpOF9MIZlINVa5vS86kw11Se/pzHQ0jI+RNIxu7I6P/
	 SMq+435on0t/U/+4Q6YQ9GK9LTX5fVhkVRdyuDfLvFC4lv4KeutxbB8nSL6T16G/ZKXQn
	 cA0piStVdLVVxcJR/MZmc0AIKTad/4ChmA21eJCqWW94zS31seoYDIOAm4ve+Owve9mwa
	 WIbhIApOkbxWsdjcJzWbOEMERP6Vjs8KvdAoLYnWjO2m525/b5MoNImH9ca2QRvALZEzy
	 VjxtIJFe2tlGQW8HJoY7Bj9/f5Q2Tu8ogQMtZ5pOrJs8LrkXKvsQCbcpWQaVglMvKFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPk+EYYl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91732606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPk+EYYl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3711F00A06;
	Thu, 12 Nov 2026 02:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450738;
	bh=ObXXE3SuFk7hda+oDvW2wcngecvTocyXpSxN2HoTRbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UPk+EYYlwQFL3Ts5XEXU0BrRb1rQR/Jweca22GpmTaLpZuynte3ZEo9cEDmzlYJL0
	 pJ5dVjdLWeeaStOPOBa1D0V/cVsT8GqPgs0WHdGFob+wmIHFKgmxR1JdOKzYM4tYbn
	 fOByNhHh3htVrQIuy0JD/9BzcQGEQli9fQQL7zXcqEgdh1f3bwO0duWvLua+OKhr3m
	 CW6Wv2xbjx9AwKvZqmTol1j2JwIzrWeEg2aJBXXP7aJUOopzjX7MhxdKZ7puhUvLDK
	 Y4HfZzf8t5UbkIYmS5cxiRtOxIS7HPgmpD183WsX+Iz3eIuGPdxmZyDY4/X7/Wicr9
	 lKF0taI6TYfjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Edvard Conrad <edvard@tuta.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ovl: inherit FMODE_NONOTIFY when opening directory realfiles
Date: Wed, 11 Nov 2026 21:32:16 -0500
Message-ID: <20261112023145.1391367-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201908-failed-6.1-323899b4ed23@kernel.org>
References: <20261109201908-failed-6.1-323899b4ed23@kernel.org>
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
[ sashal: passed __FMODE_NONOTIFY through ovl_path_open() flags instead of using dentry_open_nonotify() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 10 +++++++++-
 fs/overlayfs/util.c    |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index cd7a81b6da8be..ff3d30a9b3344 100644
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
index 6922d8d705cb3..08ec15773121e 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -519,7 +519,7 @@ struct file *ovl_path_open(const struct path *path, int flags)
 	struct user_namespace *real_mnt_userns = mnt_user_ns(path->mnt);
 	int err, acc_mode;
 
-	if (flags & ~(O_ACCMODE | O_LARGEFILE))
+	if (flags & ~(O_ACCMODE | O_LARGEFILE | __FMODE_NONOTIFY))
 		BUG();
 
 	switch (flags & O_ACCMODE) {
-- 
2.53.0

