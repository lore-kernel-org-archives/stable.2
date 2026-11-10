Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273953;
	b=IvvgaaysH+Ik+KFo0vAklsfXcgBpKYs+w0/F9HErKiv+RG0eCl+woTVp29xZN0ldSXyV
	 Hj2kScRL/yBufc8r6pwJMYBmBNj4L99EdJJRBXRoCOSxyt9PnP+6cEqOOxiI3WFFuW3wL
	 Z5hgMxW0cUwEkXgYL9R2Kt95wa8Tm5vVHRyqsdV7f8r9uEhTI4TqXQ4KoMce+zKvxBTPo
	 vFFsNXxO4xF3ZWnNcU+StcejmilYsdulsYlVgOKD4UNz1M/YPxwMDllNJrr4Dhu7vxvUo
	 zO6ZOS9MLgbaZ4oz1kEeLfUXockYJg3qc0zv2HINE4YCkDqNf0NuV8D6ysGR7/oVd4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b0wJ8e1rz+St175U4y6hitfbXpTaVBkFuFkR+5O7zoI=;
	b=uAqEdx9BMnJJQqYT/HHmg8zzzrieixU7QywsP9gU4oUusaxiYWJ3QqU/NzAkQ0YO1zPW
	 /dFJu6cCaOI/hQl3k91nLOP3/SuKTDw2F85pKjS6yZyADdq3GsdlK5hZ5FpjjBpPLNgwB
	 j+LwCFz0BqZl8nNhxrdtoEW4OrB25aKVkh85pFTDvQYWX4yhD9iqAk0VlCWz6yDNKMrQw
	 Y1p/FtW8SkARQydsFI+j6l0/o4syGFsS5g99+Hq+ONOXu4z6TiqY3PXwNgmpeycnJOgYf
	 RO5ejrDLy2tbPE51efom5aiycnddCp1X7J0PKBw95h4fFtKauHwXr53j3br6sYsFCug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+9PVdZk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D608607187C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+9PVdZk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A611F0089F;
	Tue, 10 Nov 2026 01:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273953;
	bh=b0wJ8e1rz+St175U4y6hitfbXpTaVBkFuFkR+5O7zoI=;
	h=From:To:Cc:Subject:Date;
	b=F+9PVdZkGaB5Akv8iDgXcppDhuqrI5iE0Jeg29wZTrjzengo+ew76Ea5ohpDsfCe7
	 B9ZT6S3+PGG9Wi8MZsJedQiH7I3WfUbm512Ox6G9x0/YNDaRQaDGqTKnfxY2hD2bqk
	 RmysGb4BWSIXbxQII94+em7cEjbKbYNAhlNGAlWPSGhunSFN9SU2iEHQqUgg57rQFq
	 Z3GzZO7QlNoRuRkZ5x9B1e5vBz+c6TCHlK0n+MJCb/WnIjYMoFREKVISgn+XMM5Xuf
	 N+u+h+pBZxLP2vNKGm7OmnZ+uJwfcn1+ogdIKfxlzhyYQSiBgIki2vms0SoMzSk5PW
	 f78Da1OM8/h7Q==
From: Sasha Levin <sashal@kernel.org>
To: guolingxing@tju.edu.cn,
	wqu@suse.com,
	dsterba@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] btrfs: prevent deleting the wrong subvolume by ID" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:51 -0500
Message-ID: <20261109202551-failed-5.10-1960146913b3@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1960146913b31b288ed2cd607d103ee3b41681d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202551-failed-5.10-1960146913b3@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1960146913b31b288ed2cd607d103ee3b41681d4 Mon Sep 17 00:00:00 2001
From: guolingxing <guolingxing@tju.edu.cn>
Date: Sun, 18 Oct 2026 15:38:10 +0000
Subject: [PATCH] btrfs: prevent deleting the wrong subvolume by ID

When deleting a subvolume by ID, btrfs_ioctl_snap_destroy() first
resolves the requested ID to a name, then looks up that name again
under the parent directory lock.

A concurrent rename can change which subvolume is associated with
the name between these operations. Since the deletion path does not
verify the ID of the resolved subvolume, it can delete a different
subvolume while leaving the requested one intact.

This was reproduced by repeatedly exchanging the names of two
subvolumes using renameat2(RENAME_EXCHANGE) while deleting one of
them by ID. The wrong subvolume was deleted in 9 out of 14 independent
tests.

Fix this by checking that the resolved subvolume ID matches the
requested ID while holding the parent directory lock. Return -EAGAIN
on a mismatch so that userspace can retry the operation instead of
being told that the requested subvolume does not exist.

Fixes: 949964c92843 ("btrfs: add new BTRFS_IOC_SNAP_DESTROY_V2 ioctl")
CC: stable@vger.kernel.org
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: guolingxing <guolingxing@tju.edu.cn>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 43a945345cbe1..847fdc19bd402 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2393,6 +2393,17 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
 	inode = d_inode(dentry);
 	dest = BTRFS_I(inode)->root;
+
+	/*
+	 * A concurrent rename may have changed which subvolume the name
+	 * refers to. Verify that the resolved ID still matches the requested ID.
+	 */
+	if (destroy_v2 && (vol_args2->flags & BTRFS_SUBVOL_SPEC_BY_ID) &&
+	    btrfs_root_id(dest) != vol_args2->subvolid) {
+		ret = -EAGAIN;
+		goto out_end_removing;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		/*
 		 * Regular user.  Only allow this with a special mount
-- 
2.53.0




