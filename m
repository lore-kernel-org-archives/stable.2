Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273041F36F;
	Tue, 28 Jul 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241605; cv=none; b=paB/BjBGcnUM3d8xY9ju5QLvVf0v5u3avmGWWMnzLyCR743PLPVudSDz5j74p5M+uo/nfItOQUKY1fxnavMOi1hb80lx/lOYBhzpVfEt38cS14fmiJJb9ycHZkCQ8OQxd3Hk4XP5XW9/agOapsiiETms/hO3EidDVkzPEEqqyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241605; c=relaxed/simple;
	bh=p5zN/lX5gZshphxpWwSeheHCCXVxHIFs4aMnBTfCyPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+2tBA/MtAIRYNzC8UCWhJ6mA41qRnDrtxGCpJgVAQiMR+MiUMb7xtFfsoeOD96XUUZaZbbxMM1ENYEKrxDI6xeG4Wy52qzeD34i+g9+XQuT6Pvq1gbCUv72euv3kU4e5DpTqzjHsFwySGsLPuvUPayTCd/kazttTLDNoTNHScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3P1nSxh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3P1nSxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50FA1F00A3A;
	Tue, 28 Jul 2026 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785241604;
	bh=hOO/fvJ7DG1Qmdj7Yuqex/IBD7jlB9A1fJljGKz7X10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G3P1nSxhVPxurB0hXGcymQNIEpID62NyMfMi5ia4hR/TCslXYZT5CRps4prOl91oj
	 4qQ1TMDOeg3iVpKehzT7KCgOaBJfYnTzQNrpg6A3yMrZhlQk5W60GS3xyPiXXYz9P+
	 ZoVc8BsBcwuksx2Jq7eBm3G+48T/UpoDv0wBjxvmxfPzK8L5nXCpJ97zHmtAUFaGes
	 bW3TLLazliO4JLuW6FBnBHH92mTQbcP6M9Ajo/+a3CjdpyYskDeXvDj9GH/BRsMaOt
	 fc8fsXr6bw/l1PdRxois6hzsL6fRxDMlzToxV2X4ixW9Y5O8CC75XyxjkXI5fcfGBE
	 cOO9ksEZjwrOw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Jul 2026 14:26:32 +0200
Subject: [PATCH 1/2] binfmt_misc: don't let an 'F' entry pin its own
 instance
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-work-binfmt_misc-selfpin-v1-1-74df5daeca5b@kernel.org>
References: <20260728-work-binfmt_misc-selfpin-v1-0-74df5daeca5b@kernel.org>
In-Reply-To: <20260728-work-binfmt_misc-selfpin-v1-0-74df5daeca5b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 bpf@vger.kernel.org, jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=2835; i=brauner@kernel.org;
 h=from:subject:message-id; bh=p5zN/lX5gZshphxpWwSeheHCCXVxHIFs4aMnBTfCyPI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlzP8n9UuLk8El0DM516b0iUPhgjfZNbPEZuuu/Rr59
 fiUmA1XO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiocXw3+fktLR3N29kXE8+
 ve+5tOPuGA41zXAnq+XM1/8Yv02ZfoCRYUXGq0cZK3TPVwibbvrKxijkJRBUEBE5Z6PsP6fi6mU
 zGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

An entry registered with 'F' opens its interpreter at registration time
and holds that file until the entry is freed. Any entry nobody removes
by hand only gets closed once the binfmt_misc superblock is shut down.
If the interpreter lives on a mount that keeps that superblock alive the
two pin each other:

    binfmt_misc sb -> inode -> entry -> interp_file -> vfsmount -> binfmt_misc sb

TL;DR the file is never closed. Once the mount namespace is gone there
is nothing left to unregister through either.

There are two ways to trigger this bug:

- Point the interpreter at the instance itself. Its files are regular
  files owned by the mounter and both bm_get_inode() and
  simple_fill_super() leave i_op at empty_iops. So notify_change() falls
  back to simple_setattr() and chmod +x works. We never set SB_I_NOEXEC
  and so open_exec() accepts it.

- Use the instance as an overlayfs lower layer. The overlay superblock
  holds a clone_private_mount() of every layer until it is destroyed and
  that clone is in no namespace. So umount_tree() never reaches it.

That's a DoS. And it isn't only the superblock that leaks. It pins the
user namespace it was mounted in, so every iteration permanently eats
one of the caller's user namespace charges.

So let's just do the sane thing. SB_I_NOEXEC makes open_exec() fail on
the instance's own files and s_stack_depth makes overlayfs reject the
layer before it ever takes a clone. That also covers the ecryptfs and
fuse passthrough variants. What 'F' promises is unchanged.

The stable tag is narrower than the Fixes tags on purpose. Before
sandboxed mounts this needed global root against the single instance
everyone shares, and the change doesn't apply to those trees anyway.

Note that SB_I_NODEV is implicitly raised for userns mounts but raise it
explicitly here as well.

Fixes: 948b701a607f ("binfmt_misc: add persistent opened binary handler for containers")
Fixes: 21ca59b365c0 ("binfmt_misc: enable sandboxed mounts")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 5de615ca7a75..47aeb2b68d3e 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -937,6 +937,10 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (WARN_ON(user_ns != current_user_ns()))
 		return -EINVAL;
 
+	/* Never exec off this instance and never let anything stack on it. */
+	sb->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
+	sb->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
+
 	/*
 	 * Lazily allocate a new binfmt_misc instance for this namespace, i.e.
 	 * do it here during the first mount of binfmt_misc. We don't need to

-- 
2.53.0

