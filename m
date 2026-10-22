Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696782;
	b=aRz2to5n+QJHTzYl5MgrJKz9YtlwcfBZf7a4LRnLpLBtDv3eXfOwHmxhk3cY1MwkGOxa
	 jfax77PfF+zWRcxnChExUX6G6knvVs0VUvdVLQkTHf4lHiAghTUhKdjo5Lhmnz67IU5kF
	 eRDxwcB8jIPUJTv0da6Gxm4xLvz3bZfn7OGbhilsi3Z9gC6+PjqskZgENyYrvyO+Ro8Zz
	 FAFUh7rKvNXXRYiJzMnkmB0VhHOobBdB9S+u8TCe5+PjT2+KKTYfyP0XKfn972FIuSiaQ
	 4uRlBWK3D/n8KRv/+cbZ66ptSUApHAqnNtSegKXsNZa6vlWwYq0eXkw7DuZlLqrnz0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696782;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h21GP7Yw0xqzTo77UJGXYxvaVPEEcWohOkf7JL29Cso=;
	b=tUEQ4zJPwzeSQPav2RiHJBDBlAr6tB9h56KUww5HGTLXv+GQJ/IIA8Rc/blUyfALcdED
	 v89HWLt1Z6wIyphNzol4kU/uP/o/bChri7S0Ln2lovys+SzNM9ihjViCXgcNggLx6DdEF
	 TqvYePDdXH1yKg2k2aPWkFbr7h3O/loT7a99zGxm5DhtoWYQ5Mc8LnfKa8KibbKrxmdob
	 TBPnfj1HUmew/utwIXS7MkyJnYuHeTja69vrn5CLVONf0vx5NNY2CWSVTR5eSbsR5yjmZ
	 m0mhai93kp8Deqxy82adI8LinCCohhzoczdzbq5s7wCFimJozk6xrGaY4F4zVcNkLVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1uwemf1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB0606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1uwemf1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E791F01828;
	Thu, 22 Oct 2026 19:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696781;
	bh=h21GP7Yw0xqzTo77UJGXYxvaVPEEcWohOkf7JL29Cso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H1uwemf1UixcKNM+RW90Gpliv1JKaR4P2XBf2aO1jn25GA3CHicZxw2ECXrVWIcBd
	 ishEdOHGATZRdqtzUl7G+Lll2+99ZyYgJfcDEy0yGxxqxSPkLR57UwVrmoOT8ED6Mb
	 z4lKYYbngV8azz3LDgL+uqYe2zWsMKrb0cJUdiesS0JxizvbrzAsvUPfgoaVcAZdpx
	 TINarF2fWEJSt+NU+86Q/tuotJbL5/i2GrbaCsGUPNpZEsyR2S53+yXFLFN9MXomA3
	 HERsaVB8M4wqptNNCoXp5ob/R+IrZQp+5EiV0tM11Z5SaWX6uiJRgLF2+oakPoM2Vs
	 HOPBdMfnDA44A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()
Date: Thu, 22 Oct 2026 15:19:39 -0400
Message-ID: <20261022190947.1758805-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102115-gaining-immature-ff14@gregkh>
References: <2026102115-gaining-immature-ff14@gregkh>
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

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 53676a5e28231186c9f56d87b7998b640699bc15 ]

smb2_duplicate_extents() has no handling for
FSCTL_DUPLICATE_EXTENTS_TO_FILE failure: when the FSCTL fails, local
inode metadata may be stale from the pre-extension or from concurrent
remote writes, but is never refreshed.

Force revalidation on FSCTL failure and use i_size_read() for the
pre-extension check.

Fixes: cfc63fc8126a ("smb3: fix cached file size problems in duplicate extents (reflink)")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: replaced cifs_invalidate_cache() with fscache_invalidate() guarded by CONFIG_CIFS_FSCACHE. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 57ba6f7d813d7..781fe599dda7e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -8,6 +8,7 @@
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
 #include <linux/falloc.h>
+#include <linux/fscache.h>
 #include <linux/scatterlist.h>
 #include <linux/uuid.h>
 #include <linux/sort.h>
@@ -2160,7 +2161,7 @@ smb2_duplicate_extents(const unsigned int xid,
 		src_off, dest_off, len);
 
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2185,6 +2186,13 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+#ifdef CONFIG_CIFS_FSCACHE
+		fscache_invalidate(CIFS_I(inode)->fscache);
+#endif
+	}
+
 duplicate_extents_out:
 	return rc;
 }
-- 
2.53.0

