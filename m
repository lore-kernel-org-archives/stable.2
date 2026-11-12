Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451367;
	b=dXVWas6et6OlApz0KdDd9NR9qaHWvpS89ALer3bLKhI5bpipHe8XaQrI81TRQ2NzxnKK
	 muIF1n3ZfnKwS2sRPmh3aabYTidDOqoPNuGtf4ADwTUUaVwFwY8WlAqD79QGb4YRA1Ux0
	 ajrfexuqZeQ8+ck7QKaUJ7+5Z5eTq9+cczpaFMX1cH689atT9s9x0drAJ5DaWhdkVs1GE
	 nn226O6sOsS4Ydurydcbfmd9wFeUdhovU/yDzxgWc/014VDKglPnbx8k27SZJqhXq0A14
	 y6BgddeXcZ+mVEFedVxvA66YXBzy3c/4yDrfilJm9HQ3R0YHoVOqJPDItAF8aHpYbgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451367;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rZIv9VC9UhqiJzFr/WpwY98palQxc8J7SKulkI1gLcA=;
	b=mWolteA8lVgxxWxaqPUhsQAsBZTenilvXZzov877BHdnQcumzMqWRe3x00u6S9R6gSPV
	 B8BULklHnpuc8LZxeqkU/OPm6QllGskKvesAU1mUKukk+TIWUxpbTZ4flpd7YCJFB78DN
	 UbsETXpt1Xzz9krKQiy4Hv5LhOj0Ahru3qZzkAJ+wkWQMawSAWOtfV7E50sRcVW6BD8I7
	 QISR9zZDZ8Y9di7ZAKMQBwD5BVB1rp6cGtREcjLwSv1w8H5WeA0AYECD4f5xcZ3YxDxXn
	 R5gE9c8EqnmNarCsvsuisYxISUEuxxSvDvipAqTHIKm84yO4+ZItzVEk7m1XndtqvvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nfr1WrGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13817606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nfr1WrGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CBF1F00A05;
	Thu, 12 Nov 2026 02:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451366;
	bh=rZIv9VC9UhqiJzFr/WpwY98palQxc8J7SKulkI1gLcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nfr1WrGU/Dykj59KWZm1G+dcXvKWJxJOo2XZIPph+DuNOhM9AQBuXhjKRhsTlrS5U
	 a+ztKnFAg6/JCOsenf7laDTQmo1IbYjm+ZyejW/p0qtm7lx2cT2bx5gM1QwZN2fw4B
	 6H8gtR7q380sxidVgUYIL8lFJhzNeb7OpVd1gq1BhcvqQQ+w6+LcyvO/ZD/zAOms8+
	 ddWvnR1eXe1NGz7G1+Xd5pjcdY7EMPS3229MM/OzB2MomPQPSNnlImLM1bgmE5COnI
	 EOcWkCTlQsqozmbhVfZcWoddHEKjIx5ssLAXZ43bmxO4EU0/xj/WnOhOCw6A+Pc6WX
	 5iM5znsTH56Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Edvard Conrad <edvard@tuta.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ovl: inherit FMODE_NONOTIFY when opening directory realfiles
Date: Wed, 11 Nov 2026 21:42:44 -0500
Message-ID: <20261112024218.1420199-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202833-failed-5.10-323899b4ed23@kernel.org>
References: <20261109202833-failed-5.10-323899b4ed23@kernel.org>
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
[ sashal: passed __FMODE_NONOTIFY through ovl_path_open() flags instead of calling dentry_open_nonotify() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 10 +++++++++-
 fs/overlayfs/util.c    |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index abfe17068b7d6..e3ff8828b5a8c 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -845,9 +845,17 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
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
index 26f29a3e5ada0..4146ab82dcda6 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -485,7 +485,7 @@ struct file *ovl_path_open(struct path *path, int flags)
 	struct inode *inode = d_inode(path->dentry);
 	int err, acc_mode;
 
-	if (flags & ~(O_ACCMODE | O_LARGEFILE))
+	if (flags & ~(O_ACCMODE | O_LARGEFILE | __FMODE_NONOTIFY))
 		BUG();
 
 	switch (flags & O_ACCMODE) {
-- 
2.53.0

