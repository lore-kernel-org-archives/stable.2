Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598682;
	b=4K1Pfl1U4U5Yw8E5gpAHKRp0gxE6+rf72XLPGH0I5k80JMlJNDzc3MwyZxY8eBqsBGf1
	 ZQDwAeSRCzVeU6E4YEsOCI3SDul1BcEvHo9gvqexF51YTk9dISNcJBVuNebPn+VgSnFqC
	 3QRn4zd6TZmRvzjjkpT0F4UHnvy0sz/Z1/9jqsylfw5t4nG7d50kSeJAiu2kbaKGKhAo1
	 mnd1O9VyPCYclmnv6t39pzS+vcQFV7DPBWY4pd1sWijVkaswKtrpsHiaz6bVtdddGoNQv
	 OWZ9W5qwATIFNsaJVw5Ny+WkPDnEVjgcJ2CiBJxJ3eYQrufdGgkNkF2p3Q0Jg2SRHww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598682;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZOHYatrWZCPP1Qy+PsesX/GTnVaLhGuZ+L/HuBP9aS8=;
	b=FA5wIv8CLodeHrpH1cn1N7WPl0WhQ6/ztI6n5/+2W3jzCNLo1u9T0UefbcDIVPsWKs3x
	 7zGxD9SbpQScCAeNG0kSyBW7sYEAV6qaWorxMArgtcDaJY14r37GFky+vQw9UBK+M3tMw
	 v83LhnVWltQ9dTJRrmCUV2+Z4HcBMhoErtsCRoPhujCmwCosGfnnbIJm81y9UCEn0uQ/r
	 QP+5iPDR0/7e1sUF0lscKRoP9yRs03O3OZNRPWFKrlh4n/AimTwDtK7gC1czbZUc8p1It
	 Df5rX+jmGNU8Z+Agb9xSwoblGc6+X25+wVzP/ADFprjjQ+NR2920n/J1lt38F2qln2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uzclr3Se;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC858606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uzclr3Se
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EDC1F000C1;
	Wed, 21 Oct 2026 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598681;
	bh=ZOHYatrWZCPP1Qy+PsesX/GTnVaLhGuZ+L/HuBP9aS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uzclr3Se1gwuJnc3H/NVbEogSu31p3Q33m/O0qLTI33o9q312sQ2DE+Z5Uy9QRu+3
	 7dSbkIuH/L5RHFsQtIho9sks6aU1R7aBRI9yrUE+e8Mts+/1/Wz823CqW+J9hAea8w
	 1cm64vyfS++sjAMocfM/MPxQlL825eaxTCJMdIX8yq/MKiPxXKKo+F7SR5NkTib/wN
	 3Q6wgVHNRlwykmd+9YRSyoio9Sib861knjF5pLwoKC7MBSqO7CRgfhZryncxEoqrGc
	 40cVA4DZfUL7zJUFbFYZwkKg9RoQ1OB2UKfA+ABTr13bRbCHP5K4h2gX6RyP0r6xF6
	 nGtZDGRgeVQGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] unicode: free the map after a grace period
Date: Wed, 21 Oct 2026 12:04:39 -0400
Message-ID: <20261021160417.288393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102112-reprocess-growl-c2b7@gregkh>
References: <2026102112-reprocess-growl-c2b7@gregkh>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit a96c5299bd7305eb984377681eb3222a57376405 ]

generic_ci_d_hash() and generic_ci_d_compare() read sb->s_encoding and
dereference the unicode map while a pathwalk in rcu mode holds nothing
but rcu_read_lock(). The filesystems that use them, ext4, f2fs and
tmpfs, drop the map with utf8_unload() from ->put_super(), which runs
when the last reference to the mount goes away. A lookup that is still
inside such a filesystem at that point reads a freed map.

With a pathwalk held up in utf8_casefold_hash() while the last reference
to a casefolded tmpfs goes away:

  BUG: KASAN: slab-use-after-free in utf8nlookup+0x74c/0x950
  Read of size 8 at addr ff110001030fe658 by task walker/98
  Call Trace:
   <TASK>
   utf8nlookup+0x74c/0x950
   utf8byte+0x160/0x1560
   utf8_casefold_hash+0x167/0x230
   generic_ci_d_hash+0xdd/0x1c0
   link_path_walk+0x11ad/0x1d30
   path_lookupat+0x63/0xb00
   filename_lookup+0x1f1/0x5b0
   vfs_statx+0xd7/0x3b0
  [...]
  Allocated by task 94:
   __kmalloc_cache_noprof+0x249/0x560
   utf8_load+0x4e/0x570
   shmem_parse_opt_casefold.isra.0+0x92/0x270
  [...]
  Freed by task 97:
   kfree+0x1db/0x5b0
   shmem_put_super+0x72/0x170
   generic_shutdown_super+0x14c/0x530
   kill_anon_super+0x3a/0x60
   deactivate_locked_super+0x9c/0xf0
   cleanup_mnt+0x9f/0x130

So far that has been hard to hit. umount(2) waits for a grace period
in namespace_unlock() before it drops the mount, so only a mount whose
last reference goes away elsewhere, like the close of a file or a chdir
out of a lazily unmounted directory, can race a walker. So it is
reachable.

Delay the free until a grace period has passed. The map and the data
table it holds a reference to then outlive any pathwalk that found the
superblock before the mount went away. The reference on the data table
module is dropped from the rcu callback as well. utf8-core is built in
whenever CONFIG_UNICODE is set, so there is no module exit that would
have to wait for the callbacks.

Overlayfs points the s_encoding of an overlay at the map of its first
layer without taking a reference of its own. That stays correct. The
layer is held by the overlay, so its map is dropped only after the
overlay is gone.

Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261009-work-fixes-rcu-v1-6-7446d2d335e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Replaced the custom RCU callback with kfree_rcu() because built-in Unicode tables need no module reference release. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/unicode/utf8-core.c  | 9 ++++++++-
 include/linux/unicode.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index dc25823bfed96..d946ccfd90181 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/unicode.h>
@@ -227,9 +228,15 @@ struct unicode_map *utf8_load(const char *version)
 }
 EXPORT_SYMBOL(utf8_load);
 
+/*
+ * A pathwalk in rcu mode may still be in ->d_hash() or ->d_compare() of a
+ * filesystem that is being torn down and read the map through its
+ * superblock, so the map has to outlive the grace period.
+ */
 void utf8_unload(struct unicode_map *um)
 {
-	kfree(um);
+	if (um)
+		kfree_rcu(um, rcu);
 }
 EXPORT_SYMBOL(utf8_unload);
 
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 74484d44c7554..b82625a023688 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -8,6 +8,7 @@
 struct unicode_map {
 	const char *charset;
 	int version;
+	struct rcu_head rcu;
 };
 
 int utf8_validate(const struct unicode_map *um, const struct qstr *str);
-- 
2.53.0

