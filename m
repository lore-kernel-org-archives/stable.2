Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272584;
	b=HH+zwuRNc8zIFYe944F5Ms5EWI5oS490bxI9KvkB3iz07qUlrOpolaDA9c2Xgh0cF0by
	 QhUHPb8M4PbnzWe03c2tRMIEXmS7qjbkBdtyZfPKs/df57Q+9cuIrzhzkaMOE+cVklgZP
	 WsypskBA4jEaVv9MWGMPPHG1OWdLScaPz49OsVxSzfXUICxSefTnwo0aY5M3ynz96mWeK
	 63yvXjqt9z7rUrAp2aY4/51mlvmEHJj2C9HAu4IyJPjjV377pNwLGg2qP45QFzl7S6fIw
	 xnHK1mtZCTpELK5DUQ1o+zeJwP9a35/Bl0lferZJVNmJFTKwYVSwbV43cKTn6JNUMsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272584;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1+GVES17S/VvLAGzpUaTyJ+0hf5gvQToUA8qjWHeClk=;
	b=YNLeQ35d8LgX1sz0N5w2Y6FE3yxyjnts9tr8o8Z0byGnhCEs/0vHgmlVADp4YqxK1NIw
	 El/cuimuSCl6eJd3QIek2cC2FkU3fnRV43uZC5qvsT3CiToi+/qK8ms+nmZkGMPO3xLe2
	 5oHRIHIrgZYJG4ppdgoY8Q9YGSnpSXIJ01jt0jonVxqJy6aMU5JK47sBj0j8AqicMaJRY
	 cly5bv0ZpWdgOCCJT/acJCuUNqNJ0+uB62KsVrOPt9Fjs1/nf87f5b+x1V7RoDo9e4hzI
	 C71ZeS6NfL/Kx5wMrG7d+Z1AJ3HhQhxaKjXnygVrdS1WtGcGDGDNRnsZlGMmMx5eTXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+haRhpw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D44606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+haRhpw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3BE1F0089F;
	Tue, 10 Nov 2026 01:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272583;
	bh=1+GVES17S/VvLAGzpUaTyJ+0hf5gvQToUA8qjWHeClk=;
	h=From:To:Cc:Subject:Date;
	b=d+haRhpwlrxgIp3j6gI63AOr3g2ePdiH7fzIy43qwqkf5Bf40I7nu4L9lSsowh3+P
	 XCq8cad0mAb/cUSE8zwt7h3iLa8zub73F6xwtuX0lQu689DG+O8el6UC8yUJINjOMs
	 l3HTbJIR0ZyqQu4V5BjdSMQWquGjwwTallyCtbiiqzBPG9HGfYMSVylWLWZ4QJmhWy
	 82P44vcYl8uEpwE0nntuosF0TgaujF+Q841vASpgAw7ejKCpAKP7Z9TjTY0YtIgPyN
	 qgQJe7rUqe+Wnqh2gwQ75oYRAh7B/S69laigYJAgb9kMLGI3srtFUQUE7WtbG3nXDw
	 n7X/G741MYKZg==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	pfalcato@suse.de,
	kas@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	pratyush@kernel.org,
	gourry@gourry.net,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/shmem: honour F_SEAL_EXEC when an ACL is set" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:01 -0500
Message-ID: <20261109200301-failed-6.18-0237c47ca170@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0237c47ca17005ea41b510c6116f0257dbf84eab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200301-failed-6.18-0237c47ca170@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0237c47ca17005ea41b510c6116f0257dbf84eab Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Thu, 29 Oct 2026 11:43:25 +0100
Subject: [PATCH] mm/shmem: honour F_SEAL_EXEC when an ACL is set

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
Link: https://patch.msgid.link/20261029-fixes_shmem-v4-4-392fc715d8f6@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/memfd.h |  9 +++++++++
 mm/shmem.c            | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index c159e40e3f34a..272479317cf10 100644
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
index af21a89abb0f6..6df0237832c00 100644
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
+#define shmem_set_acl simple_set_acl
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
2.53.0




