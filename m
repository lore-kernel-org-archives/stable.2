Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895826;
	b=zDYGcxR3UbgQFupgbwdYGF53cOb/+bAShs318Ng20JgJMpmFHgxc6x/edJP1Tw9FrJ7c
	 /5MDN+4vyD0lODMzIsFf91cPuYnZ6h3F6Q234y/Cdg+YsgcSkRflVIlOOVs6IVsNO31Ql
	 uibK93Drww9D9gG0+qzWMaoBsLVshy2bHzhEDwZdaW6rg4gku04WdAJyEcpBPWg6Bl+J3
	 uzxdR5gipkO5osSlX9Zgo5Jf1PqQW7furKJEFCBTheoO71NB6R1C+OG+Ci6jreCxGigg8
	 gTR3I08IAaKq4/Qhsy3840t5e4WGvTkmsDj79UZikAyiUIIse+mFR58pUAJ7Ghr8oAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T5xP3xmvTREeNhGaQXZoBDRJasarUYjMXHgROJqFmHI=;
	b=e861ZBWSG826JTKDWlzx9QuOwWFP3usmRFetB4akecsXm6mScCWcGRF5IdVZ5C+l+Wfe
	 j1HNpdN5TyKsTYW8nEX6ovdDeCkfAQX0nF7D2w0crfZpRBx1r1K6dFiL3Ohp2THq5FRuc
	 pbm+xPMxodqMBLlYhD7FDdaCTnRNDCAgfxABycZgqgwxsAAcQU26u08pxa0yGhIOJoKEM
	 I33f3LzGS3frXu06MgHLwwmsiudBWuzAON4NMN7Tuy6G74uLFidQXJW88TmSK9u3hiUAP
	 e17KExqajQ/s1+c6BAZUDt4eLR5ixIGUdp2y2bE00IcNbt5Yi4LmMm5lmEMb1g2EyHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0t3Jxza;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C1606A335
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0t3Jxza
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA0D1F0093A;
	Thu,  5 Nov 2026 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895826;
	bh=T5xP3xmvTREeNhGaQXZoBDRJasarUYjMXHgROJqFmHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z0t3JxzaAhz63nMk0AobuhioVKJ/Ypw64MzmhRLZ9/xF53A0wSdEwOLjtF9d41JcI
	 Z1dVgGblTF9AyzeiuyKGAT9H7W7M4987Fq805+pE6D1XlMjVWtjQ42xniPZBmGAhku
	 FF6OGNkVBYEWDtmrWMcUD09/hmTKwbQirzlLvuUdXjveUz13Mhidm3J/ox8NdkL/Y5
	 5Thu4549WN+jit0C4zqW1rTghe9TktQAlNH62AORNvdCRMxVwzsVeYJvo+KwiJBgn6
	 wgd+9VnlkEd9lOtpU27oro9abTM6vGLl3IjeBQoJYsQx1YD0dCVxUb5m7UZkJODyIy
	 mJXAwcSbnHRJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ovl: check that the parents of volatile/dirty are dirs
Date: Thu,  5 Nov 2026 11:23:44 -0500
Message-ID: <20261105162313.1978922-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110454-overstate-universe-e323@gregkh>
References: <2026110454-overstate-universe-e323@gregkh>
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

[ Upstream commit e34d2ef818e4c7676d8d8e1bf43e6a1ed39efb2a ]

An unprivileged user crashes the kernel by mounting overlayfs with the
volatile option.

A dentry that serves as the parent of a lookup must be a directory.
ovl_create_volatile_dirty() walks work/incompat/volatile/dirty by name,
and ovl_lookup_or_create() returns an existing entry whatever its type.
A file or a symlink that another task creates during the mount becomes
the parent of the next lookup, which calls a NULL ->lookup.

An unprivileged user mounted overlayfs with "volatile" in a user
namespace while a second process created a symlink named work/incompat,
and the mount task oopsed on a NULL ->lookup call.

Fix this by returning -ENOTDIR from ovl_lookup_or_create() when the
caller asked for a directory and the existing entry is a non-dir.

Fixes: c86243b090bc ("ovl: provide a mount option "volatile"")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: replaced end_creating(child) with dput(child) while retaining the existing explicit parent unlock ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5d7df839902df..5b50a3c2289aa 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1242,16 +1242,23 @@ static int ovl_check_rename_whiteout(struct dentry *workdir)
 }
 
 static struct dentry *ovl_lookup_or_create(struct dentry *parent,
-					   const char *name, umode_t mode)
+					   const char *name, bool is_dir)
 {
 	size_t len = strlen(name);
 	struct dentry *child;
 
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
 	child = lookup_one_len(name, parent, len);
-	if (!IS_ERR(child) && !child->d_inode)
-		child = ovl_create_real(parent->d_inode, child,
-					OVL_CATTR(mode));
+	if (!IS_ERR(child)) {
+		if (!child->d_inode) {
+			child = ovl_create_real(parent->d_inode, child,
+						OVL_CATTR(is_dir ? S_IFDIR :
+								   S_IFREG));
+		} else if (is_dir && !d_can_lookup(child)) {
+			dput(child);
+			child = ERR_PTR(-ENOTDIR);
+		}
+	}
 	inode_unlock(parent->d_inode);
 	dput(parent);
 
@@ -1272,7 +1279,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
2.53.0

