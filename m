Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208418;
	b=RAh1YqSrfo2U8iU64A2Sl8PJgmLPT/wDHR1G9540srQVbZzJgNvOiTDVdKwU0FguX1KV
	 94qAuU/ADrq0Nhs5yhGQ2EhPSO4w1khCLibKMTZRvl3NNDVe/O0LdoFlWLdNLdYnzv5Vv
	 cSdKeQnsWVjJJPrGBPuunXBoO8i09s477t0SoE/drKlpllDguk49A7bLjOOEBQcTvaRXH
	 TAnibqsqjMltGTMsTH8DD/J12QqpRm+HL4ta2V/jICutXW/SDaEzVvzkIhSn1swUHv5mW
	 eLnktm65GkoHu8oIS5nMwP5SnMkDMl/82JsCFJaAquE1CULUtwNK5xj5NA2SMamhBOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208418;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+ouoWf0jPxz4lOByrM5BHp1+040jp+3W6jzF7j7K964=;
	b=2wvFpFnK1UYZpJugiLl3Z15oY9I/LYHc0DSWKOqAEDQ8pW0JED0RXYugc6KBb9fo0r1+
	 kKipo8OeBY9Extm7aTVZlcAprSsFvgyJjLrLT8rXFhJiJ0AsaP/HNWB2TZencf0BEvCM8
	 2GxYW21j+c8XkuZjwidAPNJEwXwgn5ylO7xM0WvUQE42yl9X2Yndxc39R95bEu5GVp2wg
	 ofOz8B0Irjqhjgzwx9fUUv++UJ3eTSkKam5TB58wL6C7gKe2TjL3gztyYmGDJNu1Mrcmf
	 iwkN56U44qEiU6YwdhXjVWxw9ebCMeZu/5Hp+uJvWNgIXUOF0xN3G4YN0cgkKUQr6+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7YIxuIS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550FC606A685;
	Fri, 20 Nov 2026 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7YIxuIS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E431F000C0;
	Fri, 20 Nov 2026 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795208417;
	bh=+ouoWf0jPxz4lOByrM5BHp1+040jp+3W6jzF7j7K964=;
	h=From:Date:Subject:To:Cc;
	b=h7YIxuIS4hpZS/90gMheyz9EkItqLE/U5lNaXPNdN67z9zuSi6sA1284eeHsDAOI3
	 pGvJwY6NBMLXj8VSUPxEgxVZnsB3yq8yBfNTq2QJd/DyMGL/qT1zD/R0R/+x5jGEUb
	 DaUcKnOsZpZBjrjuTLVMifhCn3sEd6LBDMoY2oEucLcdTRTWU15/32BvD3zuQQTKP5
	 HHQ6RJhD3wXM5AS/sFRco95nXkG5Jp8Z1vN7ciWPDaCJFQXevPmgvJdTh3UHeMpwq2
	 bqwmtR+oper+YUUu+WsdazbMNx1kjQWdfi1wtMMtXKwveGH8bz7fL1WDJAZM5dkhKP
	 uLa6yQQEQMxeA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Nov 2026 21:59:59 +0100
Subject: [PATCH] kernfs: clear i_nlink before deactivating removed nodes
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
Message-Id: <20261120-work-kernfs-delete_self-v1-1-514a35d04431@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03MywrCMBCF4Vcps3ZCE6QLX0VEkvTExpZUMvUCp
 e9uYjcu/+HMt5IgRwidmpUyXlHinEroQ0N+sOkGjn1pMq3ptDYtv+c88oicgnCPCQuugimw1aF
 33RHOe1D5fmSE+PnJ58ve8nR3+KVydeGsgF22yQ/1VGG1w+oPVnVG2/YFuIeWMqoAAAA=
X-Change-ID: 20261120-work-kernfs-delete_self-a1fdb64ebcce
To: linux-fsdevel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, 
 driver-core@lists.linux.dev, Shakeel Butt <shakeel.butt@linux.dev>, 
 Jori Koolstra <jkoolstra@xs4all.nl>, Ian Kent <raven@themaw.net>, 
 Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=3579; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dkJEe6C91+RBAXIsLzOWlu37yZyrsLcvZX9OOfeNnWo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQzbLlTdsetcNrbNbOU9qtzWn5Nrm7nFNjEFvVw25JP4
 kK3VZjPd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkhSAjw+Zehh8PNv3J8uq9
 GjTHQWKarJnx97VhD0wf3tirZTRTbQvD/1SGu98s3VVaJO5GrTR5xh3TU/S+u630y0YpDamXWi6
 KfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

__kernfs_remove() deactivates the whole subtree first and only clears
i_nlink on a node's inodes later, once it unlinks the node from its
parent. In between kernfs_dop_revalidate() already fails for the node,
so a lookup that runs into one of its cached dentries kills the dentry
while i_nlink is still 1. For a file of a cgroup that is being removed:

  rmdir("cg")                          stat("cg/cgroup.events")
  css_clear_dir()
    __kernfs_remove(cgroup.events)
      deactivate the node
                                       kernfs_dop_revalidate() == 0
                                       d_invalidate()
                                       dput()
                                         dentry_unlink_inode()
                                           i_nlink == 1, no IN_DELETE_SELF
      kernfs_unlink_sibling()
      kernfs_clear_inode_nlink()
        i_nlink == 0, but the inode has no dentry left

The inotify watch keeps the inode alive, so nothing ever sends
IN_DELETE_SELF for it and the watch only goes away once the watcher
closes the inotify fd.

The window covers everything between the two loops in
__kernfs_remove(). kernfs_drain() drops kernfs_rwsem and waits for the
active references and open files of the node, and the clear itself
waits for kernfs_iattr_rwsem behind every concurrent permission check
and stat(). In a VM with a few threads stat()ing a cgroup and one of
its files while the cgroup is removed, IN_DELETE_SELF for the watched
file got lost in 16 to 33 out of 150 rmdirs, and it didn't show up even
after dropping the dcache.

So clear i_nlink in the loop that marks the subtree as being removed,
before a node turns inactive. kernfs_rwsem is held for writing there, so
no new inode can show up for these nodes while the loop runs, and once
a node is inactive kernfs_get_inode_locked() refuses to attach one. Two
overlapping removals may clear the same inode twice, which is fine.

Fixes: eea5d2bb34ba ("kernfs: Send IN_DELETE_SELF and IN_IGNORED")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/kernfs/dir.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index fb1dcf35d900d..aab5f5f12036d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1604,10 +1604,18 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 	pr_debug("kernfs %s: removing\n", kernfs_rcu_name(kn));
 
-	/* prevent new usage by marking all nodes removing and deactivating */
+	/*
+	 * Prevent new usage by marking all nodes removing and deactivating.
+	 *
+	 * Clear i_nlink before a node turns inactive.  From then on
+	 * kernfs_dop_revalidate() fails and a lookup can kill the node's
+	 * dentries, and only a dentry dying with i_nlink at 0 sends
+	 * IN_DELETE_SELF.
+	 */
 	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
+		kernfs_clear_inode_nlink(pos);
 		pos->flags |= KERNFS_REMOVING;
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
@@ -1638,8 +1646,6 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
-			kernfs_clear_inode_nlink(pos);
-
 			/* update timestamps on the parent */
 			if (ps_iattr) {
 				ktime_get_real_ts64(&ps_iattr->ia_ctime);

---
base-commit: ccf2a4692fed0fa77751d32d2690585127a152c5
change-id: 20261120-work-kernfs-delete_self-a1fdb64ebcce

