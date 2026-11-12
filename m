Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449612;
	b=yj0BJy3sH1Ll0zlmWVAQIrSr2i4GFzBYfeo8+R9Z8+8hzI2U86nx/r4gT3a7SzUC6Rl4
	 vsWY2KCRoOhIlmsGOkYSIjsP36KcDrTU8+nU0l02I/49Tpyj4r+3Z5zkwL2rhYfiP6sF0
	 zTTTkeWdNqtzZ4XcQ270rdRdftMu6BikEo33VLPdR6Vki+7lsV1yaJnZNy5iSEsYAi1f1
	 kX6dw0Ue5Enu/Lf589V50opVRxh8bPIQ0aukekHhPu9QVoNN9qrTiB3DzibLn6F52jov9
	 Th3FazFtjGkTLs9uoBAzEO2dz39F4FwyGPAMI5B5bCuMWKtq/XHdGaWKLX7UjwoQSMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V3k/++eWqsXF0509cPGPss+dGpG7lPPFMyGRH++JIpQ=;
	b=jHlKkRFKd0L0uofZvanKArD86TVUJYp5WF5xAxNyheUbiAu+OjdZKKHa0wBX2DoRdjxH
	 n8IZZTjRpKtKMLTb7UHQLOiEWMklLzyf+yAFuYN7ZZELJPPsWr+fvy8cM3Eztar+ytJ8r
	 KgPlSDV3V9h5MQ5QeoBGsEA+LK06WqRgoCP4gnBYKtEmPPfJq/wBUPEWVzfq7MUbIsmhC
	 29BKGG0U7P/M3fxIVXa0NMK9AxnXe/vvdGtEIOwOnu4O3Ks51EwUf8ciR6+yvx/yTvqQR
	 2DepwISGFAJS3gGUTonFtrYehDlGU442fWEt/lXZDf1SaIW6VCVRDKCQ7k55Mvd86Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+pFMJX8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51D606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+pFMJX8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B515D1F00A05;
	Thu, 12 Nov 2026 02:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449612;
	bh=V3k/++eWqsXF0509cPGPss+dGpG7lPPFMyGRH++JIpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A+pFMJX8vb7bEgw5ZJbNYLQqDbkK69voUHpezvSo827pp2hu5w2QEo+6uR21Wzk+F
	 /JsjpxyfCl+Wme1EKaVYjustHcjLeo9wGc2chpIc2UgseVXF9x5wN/fdZJg6967Oer
	 NHe5HSjwMyTKNmRCAydhymo3ZGnKooFM8Wq0zhRFr/22FelKvVIBEPM5iAqaG6+sMP
	 fZ8UFWk49fc5HJ4O3l3+HCXzOCzKDIXBPS/f6Q/GV1BBNPvNM3Xd8yHl4fzG1SikFb
	 +H4GIqGOB3Juoz7RLzoRsAXXBd3z0R8kIX+CupIKHTVxaeME4FAabp75Kk3tzyYZhR
	 YnN2ltL4Bf0pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Edvard Conrad <edvard@tuta.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ovl: inherit FMODE_NONOTIFY when opening directory realfiles
Date: Wed, 11 Nov 2026 21:13:30 -0500
Message-ID: <20261112021048.1302930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200941-failed-6.12-323899b4ed23@kernel.org>
References: <20261109200941-failed-6.12-323899b4ed23@kernel.org>
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
[ sashal: Replaced dentry_open_nonotify() with dentry_open() using __FMODE_NONOTIFY. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 10 +++++++++-
 fs/overlayfs/util.c    |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 5d912f887aac7..843c3d5168f4e 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -869,9 +869,17 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 {
 	struct file *res;
 	const struct cred *old_cred;
+	int flags = O_RDONLY | (file->f_flags & O_LARGEFILE);
+
+	/*
+	 * Inherit FMODE_NONOTIFY from a fanotify permission fd so a listener
+	 * that also watches the real filesystem does not deadlock.
+	 */
+	if (FMODE_FSNOTIFY_NONE(file->f_mode))
+		flags |= __FMODE_NONOTIFY;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
+	res = ovl_path_open(realpath, flags);
 	revert_creds(old_cred);
 
 	return res;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 723672073b1e3..4c0881f0b75e0 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -652,7 +652,7 @@ struct file *ovl_path_open(const struct path *path, int flags)
 	struct mnt_idmap *real_idmap = mnt_idmap(path->mnt);
 	int err, acc_mode;
 
-	if (flags & ~(O_ACCMODE | O_LARGEFILE))
+	if (flags & ~(O_ACCMODE | O_LARGEFILE | __FMODE_NONOTIFY))
 		BUG();
 
 	switch (flags & O_ACCMODE) {
-- 
2.53.0

