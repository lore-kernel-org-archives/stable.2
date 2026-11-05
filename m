Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849361;
	b=NWc1sfs2PXvGoo71ES4OjAwwCMENLqCplaXg+8SmS2ix0roVN66L7hI3IZc99M7NRJ7/
	 lsLLrJBvNTYKquMVGbSr+uBp8eMx//QNUH6as6Ap1vqieeqoQ6VIMgySO0mPrqdKz+G/u
	 1okUDSULSUFq64GvtEAKiwGJ4DpFsGQncoPWX6o+ieq7oAABYI5wxYWncY5n8M4eayVIR
	 Z0i6qrqloQyOH4xdj52KNFTHRa974rZ+EL+dwZGugI5bKaAtaPVUSThL5bSo4xtPa4Tas
	 uRu8HwkPxoSKB1F8LSTrdOY1vx0JDqSYNNoAHLJgWNkZsgCwWKT6oo+HEtKw7qaypGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849361;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QrM7XKaTd3KW5zosEpenibPHPtGrmr6fjhBP/7cIplA=;
	b=S6J3OVEU1VsxYDew561Qf+hy4dT00bP87AHLu1/sINpCxBv1T7XGMcblnxgQRvpdFWVB
	 81d2jmzpt5VEiQlZdQ64ITelfapiqj/6LHs65hFI9uxJyzhpGisD/0J2dIhtC0LqFagyO
	 p2OAM5cOrhBCBYr9dJIgIo+IWtpvTOJsIdxa8xr+JWuG3fyXDrwHP7QuAgbnvdNPf/53h
	 NMy/vxAFBSHKePgCcCzNtQwufISrPrZ9uzUKm/8wojadbILAOAtSs/Jz/SpX80DjOfn5j
	 yutlTt1wbPCMMfr3Bp9SgdMWF7Aho+8BQ+75or9gI7uFyKHLtAnTefYEboVM2BUg/Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVmQMWsn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58B606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVmQMWsn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D2D1F000C1;
	Thu,  5 Nov 2026 03:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793849361;
	bh=QrM7XKaTd3KW5zosEpenibPHPtGrmr6fjhBP/7cIplA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iVmQMWsnHta3VOjuvCmHXMAaYkoLZQqcgRmQAwn595+tupwupqIVChj1X3t0Sh4aD
	 Av46cy/giV3sfHdRlFhWfritOztzqhd/UECO92NIvfCqvatOsZs1oahOJ/a1+UDaDc
	 nAmi1iEGNy2arOraBp8w5ZF6iAU8ygGFV8cVimAfI/rsUZUY3g5r4jVnhju/qh9mY5
	 eojyzT5FF8HUVJ1htA1bxHeOVS3qC0DN0OOF9Pk/Rf1jWdDFSwGfQsMHfcAOu8ICYN
	 f2+bBqvLCTQquvkY2V+QQ2cM1hZjro1u+iNAQIO5jKc4RQeyg9ecrFLYh5BSq4KaeI
	 /yfEXSkrrW2HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: set OVL_WHITEOUTS before publishing the upper dir
Date: Wed,  4 Nov 2026 22:29:19 -0500
Message-ID: <20261105032859.1214121-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110401-photo-throwing-2a3a@gregkh>
References: <2026110401-photo-throwing-2a3a@gregkh>
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

[ Upstream commit cbec8610ec5aaf35df50094ff639febc23f20773 ]

Listing a directory while it is copied up causes a use-after-free of
the readdir cache.

A merge directory must never be iterated as a real upper directory:
that mode frees the cache in OVL_I(inode)->cache without looking at
its refcount, while files opened in merged mode still use it.
ovl_copy_up_workdir() publishes the upper dentry before it sets
OVL_WHITEOUTS, and ovl_dir_open() samples both without a lock, so an
open between the two stores finds the upper directory and takes it
for a real one.

With a delay between the two stores, an unprivileged process that
listed a directory during its copy-up saw only "." and "..", and its
next getdents freed the readdir cache of another descriptor.

Fix this by setting OVL_WHITEOUTS before ovl_inode_update(), so that
ovl_dir_reset() agrees with ovl_dir_open(), and by testing
OVL_TYPE_MERGE() of the path type in ovl_dir_open(), so that an open
that observes the upper dentry never iterates a merge dir as a real
dir, regardless of the order in which it observes the flag.

Fixes: b79e05aaa166 ("ovl: no direct iteration for dir with origin xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: test OVL_TYPE_MERGE() instead of smp_rmb() in ovl_dir_open()]
Link: https://lore.kernel.org/linux-unionfs/CAOQ4uxh-1J2OBjnDVbrrrjy1puSOW0kABvghN85ih6dtKUBTyA@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: Adjusted context to preserve existing inode initialization and cleanup while replacing the dentry-based ovl_dir_is_real() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 2 +-
 fs/overlayfs/readdir.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4c7ef60dbaac0..dadca83b41a69 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -711,9 +711,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
 	inode = d_inode(c->dentry);
-	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
+	ovl_inode_update(inode, temp);
 unlock:
 	unlock_rename(c->workdir, c->destdir);
 
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 666cc62578f65..ed4c34366c5c0 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -942,7 +942,8 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 		return PTR_ERR(realfile);
 	}
 	od->realfile = realfile;
-	od->is_real = ovl_dir_is_real(file->f_path.dentry);
+	od->is_real = !OVL_TYPE_MERGE(type) &&
+		      !ovl_test_flag(OVL_WHITEOUTS, inode);
 	od->is_upper = OVL_TYPE_UPPER(type);
 	file->private_data = od;
 
-- 
2.53.0

