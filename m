Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31953382F4;
	Sun, 11 Oct 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734200; cv=none; b=iQVSysPRrmT21VcLbuDAPrkRm1FIuaenoRNtrkoMOKbla5C/KOWwM3rschYOAj/TjUT4dAuT3LqG8qhdGzw1yKdYQu+M/OXFdfgUdZbmz/ONRsIsGWw2P0ZFGhMlrTSlTQS+yZ7oNn0rfD1maUNwGlRg4BJAvVEf/NSEkunpU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734200; c=relaxed/simple;
	bh=OJ8qo9nxsMJSCYau+nVvnmg7wvp+NVOsbJa+83D/o1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYuRxN9/6K5wG01iA4xMWV2dUf3DPiPP8oi7ULUXLRzzP8XD7GsGjb5a2zqAp96zMa1nWlzIF5XVsNzZ73b3OsFXvPKd9G01k+/l7VUoKLjxYNyERz9HAzcuClcHXYgpdGm6huRp/VT9ZXX5M0hQRKXT69AXI8KdjJF4mjhWeyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXfA8eA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXfA8eA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BA91F0089C;
	Sun, 11 Oct 2026 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734199;
	bh=zPbl70vHExnXu2D1J7SqKM1lxMLL70bJImCYWSUCsjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KXfA8eA/87ScpKsqMeQmkLXctl2Je0RSA3QBWG2scK5yaPql8MChnr0DOXnDVAw8v
	 HEMQ3pMbIBglSIKBvJUdXoFb3Gia7vqTSCs4PxoWO2O4X0ZYMpjvlu2o40FXPYMwDd
	 IcTfQBsPIwPaz2N0j/TaxJGukOp7ll1VJhrPJV1e0zU3+Hot64fzKiL4M1/lDARxM6
	 mAdx2n9KKw1W2F3DeaHl0nHcHOpeNKwuHFJLNoTpRbR3KZB4lyxvQ5YEAhWAgojsYt
	 eA/ovFAetz3Dcot7us944oIsgbkrrhO1yyGfz8WVn0KW3zSwH71aRXW/JHnydAvF4M
	 1C6Y7W3qeOGIQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:14 +0200
Subject: [PATCH 14/15] fs: reset the flag mask in vfs_clean_context()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-14-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OJ8qo9nxsMJSCYau+nVvnmg7wvp+NVOsbJa+83D/o1c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jhnI/O8w73W0nklrEeTRQ8aux7PW7dO6MwSgdaAi
 xdb/QsVO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSyM7I0Ks4/bxKd+6cssDP
 h6wT7l3TUWSavzdelCe+vGB9q3lnBsM/9UTmyOUTeL2MxAUE87wyg1t27LulEr5MaIMse71w308
 OAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

vfs_clean_context() prepares a context for the next reconfiguration
after fsmount() and after every successful FSCONFIG_CMD_RECONFIGURE. It
resets fc->sb_flags but leaves fc->sb_flags_mask alone. So the next
FSCONFIG_CMD_RECONFIGURE on that file descriptor applies the old mask
to empty flags.

That makes a read-only superblock read-write without anyone asking for
it:

  fsfd = fsopen("ext4", 0);
  fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "/dev/vda", 0);
  fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
  fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
  mntfd = fsmount(fsfd, 0, 0);
  move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
  fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);

  EXT4-fs (vda): re-mounted 68db7463-95cb-47f9-ab87-d1fd35252958 r/w.

The same happens for a second FSCONFIG_CMD_RECONFIGURE on a context
from fspick() after the first one set "ro". The stale mask also drops
SB_SYNCHRONOUS, SB_LAZYTIME and SB_MANDLOCK set in an earlier round.
And btrfs_reconfigure() adds SB_POSIXACL to the mask when "acl" or
"noacl" changes the ACL state so every later reconfiguration on that
file descriptor fails with -EINVAL as reconfigure_super() refuses
anything outside of MS_RMT_MASK.

Reset the mask as well so a cleaned context looks like a new one from
fspick() just as the comment in sys_fsmount() promises.

Fixes: ecdab150fddb ("vfs: syscall: Add fsconfig() for configuring and managing a context")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fs_context.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index a50584df97be..ba99e673458a 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -544,6 +544,7 @@ void vfs_clean_context(struct fs_context *fc)
 	fc->fs_private = NULL;
 	fc->s_fs_info = NULL;
 	fc->sb_flags = 0;
+	fc->sb_flags_mask = 0;
 	security_free_mnt_opts(&fc->security);
 	kfree(fc->source);
 	fc->source = NULL;

-- 
2.53.0

