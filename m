Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890909;
	b=i/QXrlRiqs+SL4frqnPZhL6FZtbkfoHahKa2dFX/mzsssQ0rtAjRY1+tjwzID9mH1GtN
	 YRHrhkPCUYnKp5rmyQf8cUwketUI21+W+O2PFx/FEfQ5I3HXo8N8YUbTmHW4SE5Hmko4H
	 xhIQJZaOm2UiUhqEnoSVj48AMXam/8C87iujp1kZU2aWUtXDgrekk23eJGuSsansmDgoP
	 kNZf1bllPdLNmQGyzNs2XOEj31BQUM3w93k0/oeuZFRPXEpIbIaG7F/xLUzv7eNxWxbKL
	 dvmuNXqfo0XRlIn5ilqFgFsrqWbBESGU/PKA+5goqYMYtferJAXvgL6TPmTrN2V3Spw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/FdCjrBeIjYNNZVFbx+ux14Hn/sHngN4sXJMzqC1KU8=;
	b=UirVrKvOVhd3s60hgcLZ9cx08mWhN3UAuDM4Yv18nbOLztG2bmzllyGLBQPApXforxsf
	 ZKeF3V7wwTmnszggY9pCcJw1LcsSArao+asKKPqp9/9RtlDrefFxefjfSSaAxlZvyxrFp
	 71gTj7v+uluGq3lsbwL59FFPGStpqeZYgwHwMO5N2uaJg1CdhMQPpIE6zNY795QO25DKh
	 bUGaxjToR9JLXh0z5tlHgftJD6bLxYhbzv49JOOLGnJUAYMi7EARBWUvzKYevjW+u6sHV
	 drKFGc4LagXdd5aDGOv+OEi/e5NM3OCvXOnV9ps21o5nCtcA7VjINlJkUb1aYSxI/wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJcNKdFc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FFC606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJcNKdFc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A521F00A15;
	Thu,  5 Nov 2026 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890908;
	bh=/FdCjrBeIjYNNZVFbx+ux14Hn/sHngN4sXJMzqC1KU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JJcNKdFcc/TAkqwdozojm5uWDLn1ASgez8SoP9ela63hhAsO2P1DUOfMEROE16N1r
	 N5Zju0+GrIqosQxPaD1DvZt4lAVZ0YaL+rQLD/fLO2371sfewG1FwdXvrEAXOlBep7
	 Un0RncjV/cKgrE8S3ZlksdKVDqI8+zMhrfghYusmagMHNbBVDVjmLKWt2vQS7G+1mt
	 /LC5g2DZ5qf70vn2P7TOmXUPvrQPVQ7TQKxWRKHKBDev1nxU28XbZdyRgjb6AB8bKw
	 anqMwr+4RM4rDTzEaFlMrq+LONNsDLKQM+NDPnq2X0Lc3rKLqHiPbj4xqNIRf5BwZA
	 /k/mPshJ1KI1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: check that the parents of volatile/dirty are dirs
Date: Thu,  5 Nov 2026 10:01:46 -0500
Message-ID: <20261105150117.1656005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110453-dock-echo-0d7a@gregkh>
References: <2026110453-dock-echo-0d7a@gregkh>
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

From: Chris Mason <mason@kernel.org>

[ Upstream commit e34d2ef818e4c7676d8d8e1bf43e6a1ed39efb2a ]

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
[ sashal: Adapted newer creation helpers to lookup_one_len() with explicit inode locking and dput() cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 2ad1f8652ce61..6e97ef29ebd8c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1321,16 +1321,23 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
 static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 					   struct dentry *parent,
-					   const char *name, umode_t mode)
+					   const char *name, bool is_dir)
 {
 	size_t len = strlen(name);
 	struct dentry *child;
 
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
 	child = lookup_one_len(name, parent, len);
-	if (!IS_ERR(child) && !child->d_inode)
-		child = ovl_create_real(ofs, parent->d_inode, child,
-					OVL_CATTR(mode));
+	if (!IS_ERR(child)) {
+		if (!child->d_inode) {
+			child = ovl_create_real(ofs, parent->d_inode, child,
+						OVL_CATTR(is_dir ? S_IFDIR :
+								   S_IFREG));
+		} else if (is_dir && !d_can_lookup(child)) {
+			dput(child);
+			child = ERR_PTR(-ENOTDIR);
+		}
+	}
 	inode_unlock(parent->d_inode);
 	dput(parent);
 
@@ -1351,7 +1358,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
2.53.0

