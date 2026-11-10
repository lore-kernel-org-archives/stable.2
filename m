Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273074;
	b=m1Zm4iGZhYNx2fyowg9i0E59cxKlS9brJnNL74y5wgubJXDJ7Wa40x5htHa9zyZbeNC1
	 7OhlvQkjehEY+E1vygElEGz2S2prX5qoMAZZZg+XtKj/qh4/qOqo0vSx1/JazyH34J44l
	 x360FC/r60pbIHlv9zGFAOBEeEK9M7JpZq2LN1BWbBdTjZeMaU5L121cWVYY8L6vE1L8E
	 a7VDwiSGyFqJ9SnVMN7k+OxSTqBUO32JLustkWBzAcjlBPejVefyAeBh8CLve+Ez5aFYB
	 ttUH+2zQdDgBn85rkLYXhmltjUtDXzWBPrltChKMRCQpsPLITMmoKLKarq/8RPUc12A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273074;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qsSPVShdQvijc3jmsmHL5Ev7+aqN+WxHhv23RLeevh0=;
	b=mDOfi+AaiDEvIDusqA6uY2ztRckYAWe+NtZZe6NHWN1VQ5ccAzHh62fnhC/09zqN/eMT
	 hKodpeOHXZ8BpCP0KgNqD6ClGUEQ/CAHKRT+uBo1hzcXWDIKq71RbPyOs+eBybF5FBBzG
	 ry/aGe8D8OZuzeiKoirir34hnE7b7/FAtyA8igO2meGb3nLDre/a7VBVPqgttYOYSoUEr
	 JHZiBvuQZ/8Bgzj9mPo2U4xsZwmdbEoZDp+qNqQCgsfQ1QCPqNjl8rsNhageCDAe/EiJC
	 XT8v7Ua/glHVZIeCenKiQKUhryoyTJeG9TPNrvPDY7PEmKwm1405nlFGjtbDWDaVlfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HY8JPRYv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CDC606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HY8JPRYv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9941F008A2;
	Tue, 10 Nov 2026 01:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273074;
	bh=qsSPVShdQvijc3jmsmHL5Ev7+aqN+WxHhv23RLeevh0=;
	h=From:To:Cc:Subject:Date;
	b=HY8JPRYvXEpXg0s39nwrz+32qkRnJL2OD+nXHF6U+ib0D9ipxRKcW+JEYPDM1ffgj
	 XuaCdp9ARkkk/crLTmiVjV7koeYK5zG19CU696To18HR3fc2Hm9eeYOmM6jmKCBioK
	 fwekPVgsr+WDfOSm7t5PLlLbMDf52IolZtbdqlEnSxGvT8UJapm8PfYXcMqm7XHbzQ
	 IEmFSGIP9ey12syh3/RIzrpqaA48jRH6rP8MugZR9KS/rLiJKiiwhPCVjgj2reRGtO
	 do47ppYJh7WQMca/C5MPv1IZYL0QnqXBhIKYtX8gGu+sqqXe+42cb/bZMi5KnA99NV
	 LUEClSldRRZoA==
From: Sasha Levin <sashal@kernel.org>
To: eva.kurchatova@virtuozzo.com,
	pfalcato@suse.de,
	kas@kernel.org,
	ziy@nvidia.com,
	gourry@gourry.net,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hugetlbfs: enforce F_SEAL_EXEC in setattr" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:11:11 -0500
Message-ID: <20261109201111-failed-6.6-b7f570e7cea7@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b7f570e7cea761ec7eb4a3a9557a3a082d14e88c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201111-failed-6.6-b7f570e7cea7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b7f570e7cea761ec7eb4a3a9557a3a082d14e88c Mon Sep 17 00:00:00 2001
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Date: Thu, 29 Oct 2026 11:43:26 +0100
Subject: [PATCH] hugetlbfs: enforce F_SEAL_EXEC in setattr

F_SEAL_EXEC is enforced by shmem_setattr(), but hugetlbfs_setattr() does
not check it. As a result, fchmod() can change the execute bits of a
sealed hugetlbfs memfd.

Use memfd_check_seals_mode() in hugetlbfs_setattr() to reject changes
to execute bits when F_SEAL_EXEC is set.

This also fixes the memfd_test hugetlbfs SEAL-EXEC subtest, where
fchmod() incorrectly succeeded after applying F_SEAL_EXEC.

Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
Cc: stable@vger.kernel.org
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Link: https://patch.msgid.link/20260629180247.2343229-1-eva.kurchatova@virtuozzo.com
Acked-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
[ david: use common helper; fixup Fixes:; check only regular files ]
Acked-by: Oscar Salvador <osalvador@suse.de>
Link: https://patch.msgid.link/20261029-fixes_shmem-v4-5-392fc715d8f6@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 01c4d6f44ebe0..02e0a65d596d8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -28,6 +28,7 @@
 #include <linux/folio_batch.h>
 #include <linux/fs_parser.h>
 #include <linux/mman.h>
+#include <linux/memfd.h>
 #include <linux/slab.h>
 #include <linux/dnotify.h>
 #include <linux/statfs.h>
@@ -840,6 +841,13 @@ static int hugetlbfs_setattr(const struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
+	if (S_ISREG(inode->i_mode) && (ia_valid & ATTR_MODE)) {
+		error = memfd_check_seals_mode(info->seals, inode->i_mode,
+					       attr->ia_mode);
+		if (error)
+			return error;
+	}
+
 	trace_hugetlbfs_setattr(inode, dentry, attr);
 
 	if (ia_valid & ATTR_SIZE) {
-- 
2.53.0




