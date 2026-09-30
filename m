Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503704DEC38;
	Wed, 30 Sep 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775180; cv=none; b=Z5A3TyMI4WopnEod9jbnAFwsUdv4G5YKW4hvqZJkDyrFb/WsJMRcSymuuF46mrPg3vFrq3ZbYj6r9u/toKb/FoFfHxo412PjCn8CjCkJeI7FzGIvlLgOpzL4hLLEHMMdqE7X6ziQQBMZCtAgXAGCJY0ukVO/UZnlZUivqsnDCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775180; c=relaxed/simple;
	bh=VChDy3hWuDVdVUGE2WTB5GqyHC2FHigZ78MGkN2d5SI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWifTk/cEHe9VvqIYruC3V9Xmoh07//gqyz8VJX8DPPff5Jzs7k56DctHdi5vfoeMUjkgzFM058BUBC0evO3awIeypRpVuU08KhDGUJz9vmdoZZdj5S2FHpQdWHA1KNKfcsmXSxmP2ILLjN852xj9c4gN1ae/SOW+9+7iNDaSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKA5HNab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKA5HNab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327021F0089A;
	Wed, 30 Sep 2026 13:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775167;
	bh=1FuQuElpPxGN8uVh1NtWSNUZDwVfZAjS2FFOCmLaE4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oKA5HNabn1jFifZPRmbUOzYb61+zce/8xwqirvNxr6R7LLdFytkG1ah+d7jwmnvX8
	 yNXQP7p3geynLFhxBvnlR0KMuvFiAcG4Sc2FiC/vR6/QeMCnEZprv/zDPBe4y4xN9s
	 tvV/iTJG2L3m5dluo0cT5yPkLTdJMeMabUsGmMgItQr07IjLf1f2ve/gH3F2UdJrgM
	 +bWnt+fGIcdqLihq/eVECn+V7oL2YcwjCX5fWiip+wZhpWFqdZsOvtlgfUsm62LiQm
	 Qv+rOCDGK7rFd+Bnlln+JByHrb+lGSnaqnOAoBgw9s06QDqv0po6YYIwgqJyzG5ob/
	 j4pU0h10LhCnQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:07 +0200
Subject: [PATCH 15/17] dcache: don't put a mountpoint on a dentry that's
 being removed
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-15-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VChDy3hWuDVdVUGE2WTB5GqyHC2FHigZ78MGkN2d5SI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5fe//2/S2pa6COXkFPlOZfGzPyJjeI/MLDx+0LFjh
 /LCNUwbO0pYGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYy4RbDP/tbdXkxAp/DD5qK
 hlexeDf96rUIDK9pcVs0ieuIyNRdFQzfCy00FFg6GOwufE/+ohxxMovPYcvqvX/WvWa4/nRieT4
 nAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

rmdir(), unlink() and rename() call dont_mount() on the victim and then
detach_mounts() with the victim's inode locked. do_lock_mount() takes
the inode lock of the mountpoint and checks cant_mount() so a mount
can't show up after detach_mounts().

But attach_recursive_mnt() makes a second mountpoint for the root of the
source mount so that the mounts already located at the destination can
be put on top of it. No inode is locked for that one and d_set_mounted()
only refuses a dentry that is unlinked. Between detach_mounts() and
d_delete() the victim is still hashed:

  rmrace: b passed dont_mount() and detach_mounts(), sleeping
  T2: move_mount(S, /tmp/plcant/x, BENEATH) = 0 errno 0 ()
  T1: rmdir(/tmp/plcant/d/b) = 0 errno 0
      109 107 0:61 /d/b//deleted /tmp/plcant/x rw,relatime - tmpfs tmpfs rw
      108 109 0:63 / /tmp/plcant/x rw,relatime - tmpfs T rw

A bind mount of the directory that's being removed is moved beneath an
existing mount while the rmdir() is located between the two calls. The
mount ends up on the removed directory and nothing will ever detach it.

Check cant_mount() in d_set_mounted() as well. dont_mount() raises the
flag under d_lock before detach_mounts() runs so either the mountpoint
is set first and detach_mounts() finds the mount or the flag is seen and
the mount is refused.

Fixes: 1064f874abc0 ("mnt: Tuck mounts under others instead of creating shadow/side mounts.")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/dcache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a66be85f9d01..f44c7b39c3b3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1583,6 +1583,8 @@ EXPORT_SYMBOL(path_has_submounts);
  *
  * Only one of d_invalidate() and d_set_mounted() must succeed.  For
  * this reason take rename_lock and d_lock on dentry and ancestors.
+ * Likewise for dont_mount() which marks a dentry that is being removed
+ * under d_lock.
  */
 int d_set_mounted(struct dentry *dentry)
 {
@@ -1599,7 +1601,7 @@ int d_set_mounted(struct dentry *dentry)
 		spin_unlock(&p->d_lock);
 	}
 	spin_lock(&dentry->d_lock);
-	if (!d_unlinked(dentry)) {
+	if (!d_unlinked(dentry) && !cant_mount(dentry)) {
 		ret = -EBUSY;
 		if (!d_mountpoint(dentry)) {
 			dentry->d_flags |= DCACHE_MOUNTED;

-- 
2.53.0

