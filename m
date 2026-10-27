Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106244;
	b=Yhob3ieLDqaAkNhE+uGwrivOL/Fuibh3Ba7QgxwCVHoRtlKgb4B3ET0sLJE57zpmRRRg
	 sNbYXc852sZFnDHCCJPos29JeqRzpTmQqaJ8dI/FRdIajnHj5i5tB1My4Siw2gXkcn0mr
	 CJeMTphIT/tG3rcIOt3ioyTyxRor+GEM03BCUWKVkHl1lNNgWc4SkK4sJcFC5+mSEJYaM
	 s65hXyR6CbV31R9rkBnoMNOKSsgccC02x9+jztpdI957864Va8b2JboAGoutDXrPjSZXX
	 vgQSk7VTYWZu0SwCQRqpsRHcElC7yZ5ktwt5oLxIB3EIK+qlAbZVSfp6YKvG0ZQBoSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106244;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/wwGXqxRc5YvwerZOSnrubg9QNwrCXY3rCABuj1vruU=;
	b=uRwopjRUYxLHnR8Yq9Nb83cVZ8vTsjdLRjVa7xePR8tttTuHbAydqKODiKn15rhxzBL8
	 lrRxc4G5kTKlOQUctORg7kTIsHkEt2tiLKKr4GTaES4Q94YVmGBjNV7LWq7K2hABrakGX
	 Pp3UdeDytjguEkTF8blzoIOj+9juG0wN4v9/alu37632HIROJhf4PiZ+F+RxWdkcLPeBl
	 jdIz7NZV+PhDuluZ/FtRaQe8CHJ0Rmp5f3EUqq3PrJkQXm568Lx29GlEHxW18ph+k0B0D
	 0+GgOS6I/32gKptrl1TwAh1wr86ZldsxlvRtOdn4F6GapvyuY3doSzdqIs0FN5URS2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drswFaK1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE0606A339;
	Tue, 27 Oct 2026 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drswFaK1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209301F01825;
	Tue, 27 Oct 2026 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106243;
	bh=/wwGXqxRc5YvwerZOSnrubg9QNwrCXY3rCABuj1vruU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=drswFaK1ZVzCJ1irJvFYIsaU4ismpcQekcE0Z8MKJh1B4DRmMJDs39Pa0nAYrFC7G
	 UMBRfFrGSO1JDe32pi+uAm6MHftdlYcnFZ2WCCR77sIBS17hJUb4M+hQRdgYg2Akv2
	 sfs06vlX7NTuaZCxZ1RJiBzloKNdxNeRX8inZcYW9GnQiZYEsgyKjbt49kb0uUkcjP
	 jmtdYPbwAxatCFIMWJBz/WHjoiRhBRkzhvLnEOmkvH7D28q3RnM0Qi77sDkHullbom
	 PUiqTu72Zjws1z4jPr5Lg+DMz0F/fukgG03TKQ9wC6b2sxraGeGf86bS9d7E8hXl/m
	 8DdSEQwH8Hnsw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:10 +0100
Subject: [PATCH v2 05/14] hugetlbfs: enforce F_SEAL_EXEC in setattr
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
Message-Id: <20261027-fixes_shmem-v2-5-86a00952acb9@kernel.org>
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
In-Reply-To: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
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
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810; i=david@kernel.org;
 h=from:subject:message-id; bh=kN0V+ffVNdzTEb4f73Jhvx435CzQjTpPxsBtdWyTB48=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBQ8yHgyKLi9WZ9/7ZFvJ8TePtXK+CCaxb46eMKLb
 yqLd3+u6ShlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiO3UYGWacUdZ5rrbJwuGG
 xP7OBfNuKU4qZQx6Ha1fHeGykOnmXHlGhtZTJ+Ujs58mPU60ifwdZZa4+t71dWXSU5awHy7d/8z
 fjxkA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

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
[ david: use common helper; fixup Fixes:; check only regular files ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ab1e4dec3f77b..1fa05b4d26531 100644
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
@@ -840,6 +841,13 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
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
2.43.0

