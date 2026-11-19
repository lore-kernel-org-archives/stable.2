Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094726;
	b=CVut7x7BS23Z9eRpznMZmAsDkdKW1qaGfjK85xdiy58p7Iya5R7oHmvnrKHoKu98lNIK
	 YNU64gNRQ/u6i3H5ku+d008ODEtLzIDiK1TP1mX/O/Bf8DtNyXtKIYoex3ukb8j6pSApx
	 JImav2NQJdI75+KyjVCJi1OHUbkdiH194xOE2t/RlZYpzNOg/gmNlrpjdp31NI9GmMZyn
	 gItrVtFazsiCmFihJK49jF4KbY6sIYQm6fxb2LYNYI9zwnAWBL1oe52d62sGflnRiJTed
	 lrDGA6pTfLH4T9gQKcGOmWhmuUj2CR3qBVR1edzwyShBSAnNGr8cOT8iLj1VPnWehMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094726;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZFakn7ESaXiheChkjUCErjsZmDHmoVu+93OqffVr0Wk=;
	b=dL4OYRxs55pl8dwvVZEYzehf8qxNsH1uXlyxPwCyItHTZUVnjzQcjhK59OkFf5b+Tntn
	 NGyUmZLqUhuxAgtSHH7I+ImRfrpdtbRjBTc30HbrT175Mu5IXjooXWZ1H5IbDSuARFPMh
	 toexcZlVch477SBYCOc7ZD8MJkjRpjcY1NO6zju62QdFWE2fNo8q6x5aabLR51z3IQHIK
	 Zn/gPG1/PB92UFyySyS6m0DXa/thSboZpH958MWIZqjR3oTQ7qR0BsyrX8wa9JaebPB/E
	 uiRgqQqbwj8V6qJGqJJH/5L2pcXNei18uJgKuSvB0sUaTZjevNXyqfDClAKGY/c8Ong==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvpvByzQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85660A2629;
	Thu, 19 Nov 2026 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvpvByzQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620B71F000CC;
	Thu, 19 Nov 2026 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795094726;
	bh=ZFakn7ESaXiheChkjUCErjsZmDHmoVu+93OqffVr0Wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gvpvByzQ0+VFYQHUgU4UvsZOI57ELlePro+quq14oxJXYScoMZvfenimmpSXdPIFL
	 is1uQEv0o5V8sM850Pt2tE8htOUpeabQSHNsihMFnyk+IO1NOVCucSAxldlmu4NB/0
	 7S/s+IJu+cjnQ9CTqEzcx596ePtpwhpJ0QR1OoK9f42eBggBSm4e4ey+513cEsZ+a3
	 XOHI4xGz/yjVY45b3Pldcsr8oY60iYMs4UQdMmFgLEuoCGTYFXEH14JkxekVuUmgdW
	 K6HYKObcezE6IkUNaySJAmI2qoHlX18CYINVf3s4v0ZpexW+ikiKsYsvKfl6s5uM2Z
	 iJpD0TCgAFFaA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 19 Nov 2026 14:25:01 +0100
Subject: [PATCH 1/2] fs: let pivot_root() move userspace_init_fs when
 nobody shares it
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-work-fs-pid1_unshare-v1-1-b6a7e468bd68@kernel.org>
References: <20261119-work-fs-pid1_unshare-v1-0-b6a7e468bd68@kernel.org>
In-Reply-To: <20261119-work-fs-pid1_unshare-v1-0-b6a7e468bd68@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Akisaira <akisaira@outlook.com>, linux-kernel@vger.kernel.org, 
 regressions@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yMCy1J0ttVN1HZdNFC/PInxv4Zwyf9OEjkP4B2hqeLE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9+7F36kLta6dm7KhYmy227t81Gfu5BWdeJq2peRTul
 pjYm1i6oKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiC54wMky9s+kPh3Vxmka+
 hmbps9/us25KHNNgrZD93Tzv7icvx/kM/6P31p06cNnzxdL0U2UBC+188zzUuCxOLbnyUnLhf+Z
 aUwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

chroot_fs_refs() only finds userspace_init_fs through the tasks that
share it. Currently that doesn't matter because validate_fs_switch()
resets userspace_init_fs to nullfs as soon as PID 1 stops sharing it.

But in the next patch we'll stop resetting userspace_init_fs and it will
keep what PID 1 left behind. If no other task shares it either a later
pivot_root() would leave kthreads and usermodehelpers behind on the old
root and keep the old root pinned. A plain umount() of the old root
would then fail with EBUSY.

Before PID 1 got its own fs_struct chroot_fs_refs() found init_fs
through the kthreads. So handle userspace_init_fs explicitly after
walking the tasks. If the walk already updated it through a task that
shares it nothing happens.

Fixes: 14adbd5341aa ("fs: stop sharing fs_struct between init_task and pid 1")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fs_struct.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 34699f3b6f881..538eaaecbadf5 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -53,6 +53,21 @@ static inline int replace_path(struct path *p, const struct path *old, const str
 	return 1;
 }
 
+static inline int replace_fs_paths(struct fs_struct *fs,
+				   const struct path *old_root,
+				   const struct path *new_root)
+{
+	int hits = 0;
+
+	write_seqlock(&fs->seq);
+	hits += replace_path(&fs->root, old_root, new_root);
+	hits += replace_path(&fs->pwd, old_root, new_root);
+	for (int i = 0; i < hits; i++)
+		path_get(new_root);
+	write_sequnlock(&fs->seq);
+	return hits;
+}
+
 void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 {
 	struct task_struct *g, *p;
@@ -66,20 +81,15 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 
 		task_lock(p);
 		fs = p->real_fs;
-		if (fs) {
-			int hits = 0;
-			write_seqlock(&fs->seq);
-			hits += replace_path(&fs->root, old_root, new_root);
-			hits += replace_path(&fs->pwd, old_root, new_root);
-			while (hits--) {
-				count++;
-				path_get(new_root);
-			}
-			write_sequnlock(&fs->seq);
-		}
+		if (fs)
+			count += replace_fs_paths(fs, old_root, new_root);
 		task_unlock(p);
 	}
 	read_unlock(&tasklist_lock);
+
+	/* Kernel lookups and usermodehelpers use it even if no task shares it. */
+	count += replace_fs_paths(userspace_init_fs, old_root, new_root);
+
 	while (count--)
 		path_put(old_root);
 }

-- 
2.53.0

