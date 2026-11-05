Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881232;
	b=2hh4z4QyygBzbj3IazxnzM05XaIvQlktHCFCuZJVHZiKE+rMjxUFDficXjsjOS+LtYMX
	 HljcpCI+w/KYc8FIH5PP/uiPUxy3Hoh4QEOTEvbwjoAGjgXhWGQ7jAKxvSeGW88OHqgxE
	 PZwbqWGbCyQZpOFaIKvFI23vukE7EH23ul/7ag0FZseRJxmezmYGlP3PefAjT+PNdAoo7
	 uEzSI2lTaMscwti8476pj9geV0PJFVts7wg24TRDejm8dvWUXo1wAF69Pu3/3AVyONR8n
	 fFnG/9CHlZir3Mqbt038IdE2CRvX4A/lnYRE/LU+AWQwaVH2PbH/YG2ECgddx6WkVpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qHi2oIb3FtYuSCEvzDbAEUe62Uu8Lqqd3KhBR8hgDCc=;
	b=J7kEERCysgNbYT+82ii+DP1tNmlfJTn2rWUXlpfrjbdHInooJJMX2q0/GOKzfkeh3g1L
	 xo+0SxWk7JxaqVJ52RnphcyZZaOPO4nL4w7WCTvPjtHSnG5OzPg8QnAjznbeCsL2afHY6
	 cEB2aMewldcw71kkCHkoca/rzrvXI9s17xGSEtyPEhS6TaWL5XJxhYRfG5dT0rNXAmnmU
	 WP/uxIWYIdkFfqZFwVSJ7EhN+K6Y+lV9oyHVhTb5tQLsQrnHuCzJLf26EYo3n30/DHzzu
	 rao7DsBy6Hgtls5s+WqkT00jBf3kq7XKL3wH6k3nCkvotLAMrLvEL2NfzztmCRgYKeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nh82suBp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3A606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nh82suBp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7581F000C1;
	Thu,  5 Nov 2026 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881231;
	bh=qHi2oIb3FtYuSCEvzDbAEUe62Uu8Lqqd3KhBR8hgDCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nh82suBpPcpfeOarjqLbv5OyB60d/OY5UObWHdTc7EQ9+5MUejVztcRFDtuV3gHxj
	 RVYbbLLv1OVPurGnwcr3SSDEPTtkdKe4dTjiD4VvpQCsr2mwR3irFK3pqC/15KdgfG
	 oTU8lvrmgRYhpEQBQfGC/cZ1lj/U+03leThAXNVKzlF7hmusy3LCZMQE5EFXpIBwKi
	 u3BX6d/90+BHudkCDgAx/goXX0P8wq1X77hStQLpGB14S7pQjLVTXZ1wPiEI8P2xuh
	 QCPlOPvnN1rfQHf95XXl6r6+ISq7HobM6iz8DtrqsoXfiu0H3E+522ImpqWBauHePa
	 R+U+fvIay2k9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ovl: set OVL_WHITEOUTS before publishing the upper dir
Date: Thu,  5 Nov 2026 07:20:30 -0500
Message-ID: <20261105121913.1264093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110402-shakable-banister-73fd@gregkh>
References: <2026110402-shakable-banister-73fd@gregkh>
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
[ sashal: adjusted context for dentry-based helper calls and later inode initialization ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 2 +-
 fs/overlayfs/readdir.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 018867303a93a..07772f54e24f2 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -630,9 +630,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
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
index 09a5542723787..6e13cad49ce54 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -937,7 +937,8 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
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

