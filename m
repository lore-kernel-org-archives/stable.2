Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181363;
	b=5KpverYI25YhlGCqs/+QQwiFLxJqt6OFsFpp/RygIJo/3HqdVviaWkoo+8R679Nu9/uc
	 29YXxB7mdT9kLWy35Gnzy8dOJ6qLwKragjv2dFsMimHC+kfJRnlz+etkZJSLLe4SJn5IV
	 sRcHdSPhcfisLi4y6YlSi6JYLiHeUQOJ6WlZE/mhX5ofdGJ1UInsaG96AnB1NoyMOrU7B
	 +7FIIQxQul5qtq53rrFaSbO9Y51YG6WHm5/MTWDBlHdJMy8yJHwUSCrpOa5bilf7Ldx5u
	 djv/14v3zqtYryqBgstepXxkZGkX9N3KM12anii90Xufem2069nZwOsYFfwNofhf5NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181363;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CIildARgeqLV5Iv54/CNVDjST3eNjwaUwngHh+RJ76o=;
	b=0UoYEVHZGVKjrSflb+CjNRBE5/45YvA49lzkM12R0qDPtsJ+lEJvR8A5GT42bIK4UR8W
	 gnzd1u3/0wB9ezpUg4rBli8dGWkiCz94qPkQueqmcLOcBc4F6bb5IcIOxLzpYfjl1gqSD
	 ru17dJ5MRaZ6BtA/gfdkSbmyYbD5UzNpP6x0/i35ZvclINzp7QdrZAaMozmiTZyyrvdu5
	 gF7yWAI+prhp42aQRx4NKue71w4fEJbn86Ux4VjyeoRwKJF3ciVl5krx4qu38vBvk7dxh
	 RTFK3Gq8zWQALLPFXak//G1/LJjynenXBdrJwtK5h+Ls8aSPrEPcz8Ts1Ls/fj9Fkng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6MS+iEP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17607606A31C;
	Wed, 28 Oct 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6MS+iEP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942CD1F031E3;
	Wed, 28 Oct 2026 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181362;
	bh=CIildARgeqLV5Iv54/CNVDjST3eNjwaUwngHh+RJ76o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F6MS+iEPGzqzyPG0YiNnFEMzL6u752n2vzQwod3dzSAmRc5ClKGMqr9yZV8DPqiB0
	 JoFD7GHfazp0A3rgJNb+arC4AeZRJQlWLj6yteINTFj1vZN0ay6MvS6EjSiUaTVFQQ
	 b4DeWwOQvlt1CKYiV/RxfNrVLQ3us7A22tinlr2SdT9PXAxo3Lj/w5uyzIW54pN2I+
	 GTk3CHoavcX+xynwZJOqLN+ZO2NSrZLjU/b8QWVtsivdustYcf7938EQI3P1gfy2Q2
	 ExlUq0+IsbrWmifup4zHJhumVWuFenw642l8B9RvJOLlYNq2zm10Tj4avBNFGY2wkK
	 4NIQ/Vr5cN4Gw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:03 +0100
Subject: [PATCH v3 05/15] hugetlbfs: enforce F_SEAL_EXEC in setattr
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
Message-Id: <20261028-fixes_shmem-v3-5-4ce3baf2db4b@kernel.org>
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
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=david@kernel.org;
 h=from:subject:message-id; bh=VibnqfVc/i5QlUy5RzJlhfYS1+yzH9kwQCXwNrw3dIY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmucd4+v+mna+4UPgk6VZzh6iwQ17WBewDLBcgHL8
 3CDk9OFO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZgIuxTDP4OXWuqTNi7d5eOW
 z5Y4i33Tx7+O8ouedXp4Hr8pW8ndOofhf0K6usbcP6Gf3vg3dRdVeyckiuzwU6s4entx1PM/L7o
 +8QAA
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
Reviewed-by: Muchun Song <muchun.song@linux.dev>
[ david: use common helper; fixup Fixes:; check only regular files ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 01c4d6f44ebe..02e0a65d596d 100644
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
2.43.0

