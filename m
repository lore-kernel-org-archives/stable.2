Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD641F36F;
	Tue, 28 Jul 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241603; cv=none; b=bsr/f/OII8BP46vwc6isjQgd74BGxo7QK+2lZVG76v/Cx+fEahsTsD3CsAzDVMR0SHLw4c9Cf8b/UeaViPLeMyacYaVqvy0W3hh5+rBJo75Aw4VfmlntRUTbz9keZL6O/hJHgQYsAvljUXpso6WDDwMytCBZAwe/Pb2hMSS/Xwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241603; c=relaxed/simple;
	bh=ddAWSVNTGaeuz2ONnKE+rwJz9pZUjTBmmLP2VAVbfC4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hdQOZxHcx+MeMRKWamDNeT/el9naWFVD5p3HlqJP0qkVQOSgbIJiLL5Z6iA6lEuJxsjSrD4S7F8fkQ8JT1u2UwIf+ZINFdUBlSh8ul5/KfVHxPsMs2SaeP6u6oaGDPhNuZKrVRmbbYTsOcBdiZIuitGJz2RD3wt/c4+uev5nlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVs7BNFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVs7BNFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58541F000E9;
	Tue, 28 Jul 2026 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785241601;
	bh=ayU/6lHRgKTCK80O1xUHS/LH2s1bomipfuf9KK8K20c=;
	h=From:Subject:Date:To:Cc;
	b=gVs7BNFg1PY7V4cwmbpGOMGSnan6Vw42QKmoSZbJT30480I/kW+/T+jtrYnn8OulU
	 o2CUtBZrNjG0hUL9HmQOgcj1b0g6HC3FGxCr5zHYzD4IVdbuZHZdG5woj1zgvrkbkX
	 zwVHguBQ8RKvaUS8JBAfhtVqhKjaidUOFTsavBSTyK5+3vUp7HUABpbVxMcaPNPh8/
	 GNkDCT/HsX6BdKizy/7dMEWwwGTIRp3SskMTDqkl42FYAUA4Fy4cSc/NWfgEy5k6J8
	 28qauiv47nXKp15BNwRZals5F6aeKKZuaP4IEq0J/lMcdagWCu04NugEXajOf79bFG
	 lnHhQQe2eWFOQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] binfmt_misc: don't let an 'F' entry pin its own
 instance
Date: Tue, 28 Jul 2026 14:26:31 +0200
Message-Id: <20260728-work-binfmt_misc-selfpin-v1-0-74df5daeca5b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPifaGoC/yWMUQ6CMBAFr0L67ZrSiKhXIca0ZVdWpZAuognh7
 rbyOS9vZlGCkVHUpVhUxJmFh5Cg3BXKdzbcEbhNrIw2R12bE3yG+ATHgfrp1rN4EHzRyAHaqnJ
 lfT6QJlRJHyMSf//p5rqxvN0D/ZR7+eGsILhog+/yNJPsN2Ndf+Nr0RKYAAAA
X-Change-ID: 20260728-work-binfmt_misc-selfpin-d55b1794f0fe
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 bpf@vger.kernel.org, jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ddAWSVNTGaeuz2ONnKE+rwJz9pZUjTBmmLP2VAVbfC4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlzP/XwFq6a84W4VNne282vJziFcf1/AM7V/uDjHmp0
 lqLEovWdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE+g3Df+dXPjKK+z6kmrgX
 8un4KMWmnFUomHJ65VGfD9s2HTg1lYeRodP89Rw+ltKi7oAHGi5WytO2OM32CF8ga86apz6jbes
 1HgA=
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

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      binfmt_misc: don't let an 'F' entry pin its own instance
      selftests/exec: check that a binfmt_misc instance cannot be pinned

 fs/binfmt_misc.c                                   |   4 +
 tools/testing/selftests/exec/Makefile              |  10 ++
 tools/testing/selftests/exec/binfmt_misc_selfpin.c | 158 +++++++++++++++++++++
 tools/testing/selftests/exec/config                |   4 +
 4 files changed, 176 insertions(+)
---
base-commit: 744c5dd7c3c92dc7cac84a028934855cd9536a3c
change-id: 20260728-work-binfmt_misc-selfpin-d55b1794f0fe

