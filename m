Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450478;
	b=CFDAqR0LtrdXYl9eP0LcYstrat9B0ctmxf5iHV1n85BVMT9mJeduy9UvSjv3IdIVFkJ+
	 mdLs7ah6x0DcDbz10/jtB1DrPmX451g8Y7ItlI1N2yafXhNySBhud7UcxlMiZh1K+42C+
	 Bk3Z58oDSfP+CTXMT6MB9O3ryHX6GnhBoluqeFhMKq2ivcb/1USw7ShEXZL1oZscA4BV0
	 P/Feid31XptNnJJkiUiYP/4nisaVqhLiiJx/y2q0kJWoZhDqRPztHkxsxTKz2dFOqeVRM
	 UaTWa8/4Ht5uJWDDSLrSClyPesBG0kU/nk5cp7phu5jvvNO/+KmzUoxhGt+xCQ6GSrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450478;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sS8cTsqNMsFsFV3YUrtZ3NxfkIS4EOPJkQ4z3QuM9KA=;
	b=uDq3T56ERhByfts38iwTM3m7Lt/tyNoK8i+mOaDGje6T7DZ31nYP3hDi9ZiHVJnRfLK2
	 HhlCjrM4pwg8VZNc6u0OoPs7plUWHGGRqlZn6K6y6qzFq0rEFFSivf9N1tBKfKp3l9pE2
	 zNrvWPr6I/TSAcjPk1w0vs0zysQHEpKCUVrEM/xLTthlQSgbKVRiq6yx6Qz0V8I01zuxm
	 4aoAcAYTCZC3IdSI92A8wc2KOywiUpm1notTH9Dwlj+wam3tze/39M/aILgcPHfMcGsOd
	 m12DWK3xKywFD9+eSDy/TaAUcc/R8pJsRrS+fmo4h4I+c5DSlKJGEXHA7cKJHqpfsmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3A7DvyS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128D606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3A7DvyS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382BF1F00A05;
	Thu, 12 Nov 2026 02:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450477;
	bh=sS8cTsqNMsFsFV3YUrtZ3NxfkIS4EOPJkQ4z3QuM9KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X3A7DvySL6uzTuBJs2fWxzhf7O/Oi7WWj/BbZoIbhVBEPfSrqiJscLbDH41eCe9cC
	 Gk9Hu/rFCn4jEQSgIq42gStcbaMK2HQTkSLzPjUoFtmWoMOkKnXsaY+thfqKX9uxlL
	 dz4iRBEzx9/bFckadZJi8hTO2vLijN9ysms53dRlf1NJllsLSFeCyG4S0NiTTkngNo
	 ibuYJGWWcgKMtCgUPGcsrrj+sIeIQD1FW+8WmYPGtIOEbk9e0uzEK3LP1TjzZlXVir
	 RxZiE1AI/7/dvIopEdBpQ0j5MT3Eeiudq0NgtoDR6oMnt1a8sS/hmLZxs5Y7/oQyQb
	 t8fZWpcKEreEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Edvard Conrad <edvard@tuta.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ovl: inherit FMODE_NONOTIFY when opening directory realfiles
Date: Wed, 11 Nov 2026 21:27:55 -0500
Message-ID: <20261112022731.1358008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201412-failed-6.6-323899b4ed23@kernel.org>
References: <20261109201412-failed-6.6-323899b4ed23@kernel.org>
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
[ sashal: Replaced dentry_open_nonotify() with __FMODE_NONOTIFY flags passed through the existing ovl_path_open() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 10 +++++++++-
 fs/overlayfs/util.c    |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 9252e20bdab8b..ed79c2ad3593e 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -855,9 +855,17 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
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
index 0da1cd01d01cf..0a40a4950e9f6 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -586,7 +586,7 @@ struct file *ovl_path_open(const struct path *path, int flags)
 	struct mnt_idmap *real_idmap = mnt_idmap(path->mnt);
 	int err, acc_mode;
 
-	if (flags & ~(O_ACCMODE | O_LARGEFILE))
+	if (flags & ~(O_ACCMODE | O_LARGEFILE | __FMODE_NONOTIFY))
 		BUG();
 
 	switch (flags & O_ACCMODE) {
-- 
2.53.0

