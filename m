Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181355;
	b=ll+IARG+hhqBWGQzpThPObqR33mn8s7UAb3IMlaKCPdtgPWJgwPl86+SMgDeRc97I/Xf
	 hv7wdn+czqxevo4xLkyW7SSWrUCIVWZ/O16B3MkyjhzpXI7REsVTGF7MuyRvRJ9iLez/m
	 n2DvOsQUUitEYw/ANlHuj5jIy6wNdEvKkhikT7rRl8VqbZQLV4Mv6S2+tlpCFTZSPybS/
	 nvmvuuECsBW9IgXwLhrZtKBzUL7lDlR/07agZm8g3BwLaxrPiu75lpFseZ7/lT7ukR5TN
	 OmTXczrAO1Sm0figbXMcip1DopxvkPw0YC2LJ/HkGtKmvmEiqzPcVZb9vjjakJKKw0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181355;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LytyofYNhXIrkgDpuu8tsdZMh9q/66Muy0JGRU9/q5g=;
	b=LSlXSNu7VV+tBpcGLVV6IXoMgKuZrTQz+tOHpxpS/K+ZHaqgTcJnwxbRUk9C7PkKQBLS
	 tBms+I8nbkIj2l5SD2k+Nu3xDK2E23xVOux0oyVhUtGrOXeayZpgdiyWI6dCc00RwLH3g
	 e3tyFoWbVwnSImDUUyQhp2cb23519rapH80WgpGVAekgZA7LNOJAY1Pz0dsxpFTq++RzQ
	 2pSYdD1KhCA54IWbPKuKlFE13fqBxsbEFJDVm/twqAfG0zQAl70vE2SmNmAtVsogPsIWj
	 b+mNcPYw2mgKWhxbrLa5lsR7tQmN7yz/MQbHAulHH0NS6WAV3hZoheSPSKFwTYiE+WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXXJKrHl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337E606A31E;
	Wed, 28 Oct 2026 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXXJKrHl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF4E1F01825;
	Wed, 28 Oct 2026 09:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181355;
	bh=LytyofYNhXIrkgDpuu8tsdZMh9q/66Muy0JGRU9/q5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eXXJKrHlfKOnCoUmQEb5dhXKVJl8fGP/nZMYgqqCLwLhBYDlXfVSqSPvNZUMrJ8Hd
	 IsGSOtTUrRWhjqFlVQjwUvm2m21jhZ2n6FOTy1IDEjiUHJTC0jpzq/QnjE4um14A4w
	 0breH3BvgoX7jO7b/SOKuj1JsinoiC2Km/xiaEUeRUugfSzqaZDcEAEaKl2M2IUvuM
	 3iYudVdLTUqe8pZtAEjIYj0UPSrlgZ5UCLZDqwRKp1jy+Jgv9AOo3NU+m2aFGEwNWj
	 E8oIoaJV+ixqGnRjOOhBzLjvZbeTPLED57Nwey4Iy9PjoTBcv1Y69Qwlebk9LiUC4J
	 t7zayUKQziegw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:02 +0100
Subject: [PATCH v3 04/15] mm/shmem: honour F_SEAL_EXEC when an ACL is set
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-fixes_shmem-v3-4-4ce3baf2db4b@kernel.org>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
In-Reply-To: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 "Pratyush Yadav (Google)" <pratyush@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3904; i=david@kernel.org;
 h=from:subject:message-id; bh=CFNC+JPqed7vXaXG6PNtLhwhDnB9KggNxDs0QNHpGlE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmucu66t9pe9xq19S5Pa9jPwdUm+0FQV949zzRaNe
 pMXln64o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIl0qTD8dxb96vz2Yd4jGdES
 s9K58x+YCnkJ6HQdPfG75p+TW//3U4wMOzfyK0w78CLl5MXVGbJKqctXHJCatd3GXZr5h/+M97E
 6TAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

The owner of a memfd sealed with F_SEAL_EXEC can still change its
execute bits by setting a POSIX access ACL. With CONFIG_TMPFS_POSIX_ACL,
this lets an unprivileged owner make a non-executable memfd executable,
bypassing vm.memfd_noexec=2.

simple_set_acl() updates i_mode directly, bypassing the seal check in
shmem_setattr(). Add shmem_set_acl() to check the resulting mode. Share
the F_SEAL_EXEC check with shmem_setattr() using memfd_check_seals_mode()
in include/linux/memfd.h.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: use common helper; simplify description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/memfd.h |  9 +++++++++
 mm/shmem.c            | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index c159e40e3f34..272479317cf1 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -2,10 +2,19 @@
 #ifndef __LINUX_MEMFD_H
 #define __LINUX_MEMFD_H
 
+#include <linux/fcntl.h>
 #include <linux/file.h>
 
 #define MEMFD_ANON_NAME "[memfd]"
 
+static inline int memfd_check_seals_mode(unsigned int seals, umode_t old_mode,
+		umode_t new_mode)
+{
+	if ((seals & F_SEAL_EXEC) && ((old_mode ^ new_mode) & 0111))
+		return -EPERM;
+	return 0;
+}
+
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
 struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
diff --git a/mm/shmem.c b/mm/shmem.c
index af21a89abb0f..e3e4bbbe1d80 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -77,6 +77,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
 #include <linux/magic.h>
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
+#include <linux/memfd.h>
 #include <uapi/linux/memfd.h>
 #include <linux/rmap.h>
 #include <linux/uuid.h>
@@ -1546,10 +1547,11 @@ static int shmem_setattr(const struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
-	if ((info->seals & F_SEAL_EXEC) && (attr->ia_valid & ATTR_MODE)) {
-		if ((inode->i_mode ^ attr->ia_mode) & 0111) {
-			return -EPERM;
-		}
+	if (attr->ia_valid & ATTR_MODE) {
+		error = memfd_check_seals_mode(info->seals, inode->i_mode,
+					       attr->ia_mode);
+		if (error)
+			return error;
 	}
 
 	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
@@ -5404,12 +5406,35 @@ static const struct file_operations shmem_file_operations = {
 #endif
 };
 
+#ifdef CONFIG_TMPFS_POSIX_ACL
+static int shmem_set_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
+		struct posix_acl *acl, int type)
+{
+	struct inode *inode = d_inode(dentry);
+	umode_t mode = inode->i_mode;
+	int error;
+
+	if (type == ACL_TYPE_ACCESS) {
+		error = posix_acl_equiv_mode(acl, &mode);
+		if (error < 0)
+			return error;
+		error = memfd_check_seals_mode(SHMEM_I(inode)->seals,
+					       inode->i_mode, mode);
+		if (error)
+			return error;
+	}
+	return simple_set_acl(idmap, dentry, acl, type);
+}
+#else
+#define shmem_set_acl NULL
+#endif
+
 static const struct inode_operations shmem_inode_operations = {
 	.getattr	= shmem_getattr,
 	.setattr	= shmem_setattr,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
-	.set_acl	= simple_set_acl,
+	.set_acl	= shmem_set_acl,
 	.fileattr_get	= shmem_fileattr_get,
 	.fileattr_set	= shmem_fileattr_set,
 #endif

-- 
2.43.0

