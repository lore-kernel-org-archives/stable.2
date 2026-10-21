Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596637;
	b=h/wTMEs2k8wO9+Rmt1RxeM8x+MoVyzkEOFN1xh1BiZ7DtO0b4sWZXXQpWtztL76olynA
	 NdHALTSwCWGeywS+66SC1jA3rA3FdWVPIncz0jLiqBDJEQ32DAT9SO8VGRQTjaiGn+Qcr
	 uN1S7tbk4I0T94Az0D+Va06U7HKu8DM3gNMKRBe4cREBfqjOjZek7DJtkWrm7+XIgKYSc
	 qmYi6SGa+4t12MTf4jZJnPZy/vCCuxdDePOSinYeSJsBiqcdDeg8yigQobDPV4r76TSB8
	 VhK5OLs9mXgdDYBpG5YNccFSCpMR4ei2jtaqqJkd+z+YztCPH57LUqVvSmgzSXF87Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596637;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6nEQWmfaev/WBd9jQa4H4c19HpP4hC3lhzJVaBh214A=;
	b=DQoscugMMZ1DkwZZg7kODdjPmA5bQ5sqx/falKxvhlaLYkgkjWsChPYhAkqNtA3pab73
	 5oq4+XthO88zV1BkQFKFEkzJsNgciG1aJFYedSUqi8lWc4LLxTm0B6N6ExM6K9a/WIhZA
	 DGePdQQ4JbH45QqU5kcujja8PmPUFe11BTu//PGHo5tQEs1j8p/6VeaEGguPveyBVfoQu
	 UbEQJsy8B/kBIqKavtkcOAMcDxmNNx9ux7OoURQZn8zipwozA8X9JlA7rdQZ49/nYM+O1
	 684g1y7QNDdfjEM6w/KUgGYUy4a4W5viztHOBrg2Yo615ecYVrrUTEUExMSDloV3LAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clooUzad;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDE606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clooUzad
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9C21F000C1;
	Wed, 21 Oct 2026 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596637;
	bh=6nEQWmfaev/WBd9jQa4H4c19HpP4hC3lhzJVaBh214A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=clooUzadcN/clVTpWgXHe6yTPEWYwrwZNDs9TWytmymelQavTTUZarQ41u0tZjDPp
	 DwbILmS921EDf3yaJ8NOiOegTMEG3BNLraRVg01zDw5Xq7XfjuoXiNFZCy7cJL9wzI
	 0S53QUrUfWYnquaXnCbWuZIzVtsTJOB749yQDMbfwkg8mb1BfW0kLDKVYKy+DZNusK
	 UEBuhJhSE5aR8dGznLgqgHovVrpTCANzBW7HkuiD3IvX0PpPwwmDBG4++7MSqzMMmL
	 ks8LPAEBSw165tDZHdlH3HjGXyejdvvRXaOlLQ1Q4sgmjqfxfbKiMUEilpzfD3G/Cv
	 Ny3P7sBwKRJZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	syzbot+23aee7afc440fe803545@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] fs/ntfs3: fix ntfs_mount_options leak in ntfs_fill_super()
Date: Wed, 21 Oct 2026 11:30:32 -0400
Message-ID: <20261021152930.293677-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021152930.293677-1-sashal@kernel.org>
References: <2026102157-deuce-giblet-3fc8@gregkh>
 <20261021152930.293677-1-sashal@kernel.org>
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

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit f7edab0cee03a1cbe0e55a7bcab8d2d8b6b74278 ]

In ntfs_fill_super(), the fc->fs_private pointer is set to NULL without
first freeing the memory it points to. This causes the subsequent call to
ntfs_fs_free() to skip freeing the ntfs_mount_options structure.

This results in a kmemleak report:

  unreferenced object 0xff1100015378b800 (size 32):
    comm "mount", pid 582, jiffies 4294890685
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 00 00 ed ff ed ff 00 04 00 00  ................
    backtrace (crc ed541d8c):
      __kmalloc_cache_noprof+0x424/0x5a0
      __ntfs_init_fs_context+0x47/0x590
      alloc_fs_context+0x5d8/0x960
      __x64_sys_fsopen+0xb1/0x190
      do_syscall_64+0x50/0x1f0
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

This issue can be reproduced using the following commands:
        fallocate -l 100M test.file
        mount test.file /tmp/test

Since sbi->options is duplicated from fc->fs_private and does not
directly use the memory allocated for fs_private, it is unnecessary to
set fc->fs_private to NULL.

Additionally, this patch simplifies the code by utilizing the helper
function put_mount_options() instead of open-coding the cleanup logic.

Reported-by: syzbot+23aee7afc440fe803545@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=23aee7afc440fe803545
Fixes: aee4d5a521e9 ("ntfs3: fix double free of sbi->options->nls and clarify ownership of fc->fs_private")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Preserve the existing sbi && sbi->options guard in the failed-mount
cleanup while replacing the open-coded frees with put_mount_options().
Keep clearing sbi->options after release so later cleanup cannot
free the same options again.

Stable-dep-of: c01b091b0641 ("ntfs3: free the sbi after a grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 791d3cc489a42..558f96db9019c 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -705,9 +705,7 @@ static void ntfs_put_super(struct super_block *sb)
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
 
 	if (sbi->options) {
-		unload_nls(sbi->options->nls);
-		kfree(sbi->options->nls_name);
-		kfree(sbi->options);
+		put_mount_options(sbi->options);
 		sbi->options = NULL;
 	}
 
@@ -1264,7 +1262,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	}
 	sbi->options = options;
-	fc->fs_private = NULL;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
 	sb->s_op = &ntfs_sops;
@@ -1694,9 +1691,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	iput(inode);
 out:
 	if (sbi && sbi->options) {
-		unload_nls(sbi->options->nls);
-		kfree(sbi->options->nls_name);
-		kfree(sbi->options);
+		put_mount_options(sbi->options);
 		sbi->options = NULL;
 	}
 
-- 
2.53.0

