Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B3B4FD263;
	Wed, 30 Sep 2026 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775197; cv=none; b=kbRSoqIjCzX94qqj77nTH8/v4Dp0WDlKxvz+2WSFZhPkGkjcIovCMrjJ1V57Pp0SG3AQmk/U/SFQ0BLYllaJOPSkuCCj3VBLeG8fqhWmPZihQFFw2CTZE96Vr5SKpHDgUVar5Ty0dlws090ZSZrxTPo3zsZL/fo8C75c//xCuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775197; c=relaxed/simple;
	bh=+nHyJr37x1sHrzsEBJjBcsZpjxWnEya3d4VWbLO9h+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9+2qQkSRQZfp32oor65nL6oZ3UhmBKgsIpGGAee7w8gyR+Nq9lfQQTSlZgmYhy/3uQFTcAjFj8AwI1zy5r/gRxMv2iHj9sJdLBQHdRm2O+694INnS6c2etcD/9gfuACWkgAjnXeevbOzlR1B5rWXBp0uhTbV4/Sb+F3b868IRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVq63Jpj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVq63Jpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB1E1F00898;
	Wed, 30 Sep 2026 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775176;
	bh=jZyI/bRT1onhPYauu7psPBF4Q8V/T/GQ8M15ucbjntw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AVq63JpjmRQ73gRFd8iP1tByaybqt3zX4IY4NiTyGlndIcYjMyTHSKYX24TWjGdnO
	 shjzE/DvX0paYs6Hz+/rSy+J58m5Kn8gMeGiwAdIA8fGAnw44m6YRkpr2Av/PcnplG
	 Bkzcsym4WZ4JbsKLACLNkYeDy54OMITExktuHE4c0fZS55tdeTkNBGxgzEF5KcGuvB
	 hsY/b5q3f5n9xCzKqaPXfDWb1JdLOyvKr84GNYWZ0AeR3QNHi/P3ikieTc6CrBHvcG
	 Lh9RlLVpiOxu1Zw6XLWAGPk2O7soFkdqf5MFtyT7Da1MHkTWhvkhJ6Hx85pdVsQ3cJ
	 2TdI48PaMPsQQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:09 +0200
Subject: [PATCH 17/17] namespace: don't let a pseudo dentry become the root
 of a mount
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-17-be34c83956ae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+nHyJr37x1sHrzsEBJjBcsZpjxWnEya3d4VWbLO9h+A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5ffPtfn/epp3wK5LxUePd7b8crneuvIa2+nasEur/
 K+Jf9yxp6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiBz8xMtzrn2v+onLRwz9/
 tib+6le4sJ2vsWnXpY3brwrM3T/Z4FERI8NT5Y4TKrn79ySU9NVuU7k1UefSxMAJMWvCfuy+8rP
 rVC0zAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

d_alloc_pseudo() hands out dentries for pipes, sockets and other files
that are never anyone's child or parent. They carry DCACHE_NORCU and
dentry_free() frees them right away because no lockless path walk can
ever reach them. That holds as long as such a dentry isn't the root of
a mount. But bind mounting /proc/self/fd/<fd> of such a file does
exactly that.

Most callers of alloc_file_pseudo() put their files on kernel-internal
mounts and may_copy_tree() refuses those. bpf_token_create() doesn't. It
places the token file on the bpffs mount the caller handed it and that
mount is in the caller's mount namespace so the clone goes through:

  mount --bind /proc/self/fd/<token> <file>
  open_tree(tokfd, "", AT_EMPTY_PATH | OPEN_TREE_CLONE) + move_mount()

__follow_mount_rcu() then loads ->mnt_root of that mount, reads d_seq
and d_flags of the dentry and only then checks mount_lock. The dentry
can be gone by then. The final mntput() of an unmounted parent unhooks
a child that stayed attached to it under mount_lock alone. When the
child's holder does the final put right after that the root is dput()
and freed immediately while a walker that found the mount hashed still
looks at it.

Refuse to clone a mount with a DCACHE_NORCU dentry as its root. Nothing
sensible can be done with a bind mount of a bpf token anyway.

Fixes: 35f96de04127 ("bpf: Introduce BPF token object")
Cc: stable@vger.kernel.org # v6.9+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3c90d853e091..fcf42f192aae 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3026,6 +3026,10 @@ static struct mount *__do_loopback(const struct path *old_path,
 	if (!may_copy_tree(old_path))
 		return ERR_PTR(-EINVAL);
 
+	/* a pseudo dentry is freed without an RCU delay, no walk may find it */
+	if (old_path->dentry->d_flags & DCACHE_NORCU)
+		return ERR_PTR(-EINVAL);
+
 	if (recurse && !old->mnt_ns)
 		return ERR_PTR(-EINVAL);
 

-- 
2.53.0

