Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270674;
	b=HfdiCUTnpijQRZ9cIuwOc5hRtsFuSkgINXMedZZPoqLn3SOPn/8mrs82STVBS8QmATP3
	 NsLqPuVK8bwfLLDBGRM+HYIi+TA4dW5ZC9yGPiS0bFdCraB5S6W2QDrmPHMjZYXMiapXt
	 dMgRbXDezZaHQZsQMJ6MpkQgI8RYb6QRabvR7688WvQoKc1j7A46rJ7lBTNtKCTW7BO8s
	 jU4LUlvW6wdX4bjAQ3ALEEdh9u6D3YSJBq3nzhGSoBO/DAxI2wDBamyTGSNTX+/Ks7IHd
	 dMXvwjLN6/hRhkKrO+1p0Pxj7onYOM7dSdYpDuNhCAQUDWc9BeJG9eYxgYPvhZ08TRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270674;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CIildARgeqLV5Iv54/CNVDjST3eNjwaUwngHh+RJ76o=;
	b=VN45YeDfHvmz9vUu12UIEBk+dMK81Li3sYot1I7wy2W6Zp6Ouz49hki/vL7wJj0QkpTK
	 LyyYbWtMX+V0ulM5oM0kZCUUl3fldtGceaHj5q83JveU+NZpJBwL+/ZpIr+7ciLN5f9e6
	 bjbj6sBNK6TPr3nSAApuqYCy7J158uHtSAHSiNZD5UIcQrhi3laBgYxra+Ic18y19cveX
	 Cx41ryfyA7BVLuIzl2BlQkOrPNpMYo9hRZhHC145kYePMXmMWwgkg8w8ugpwwbmqeohtQ
	 XqJH1G4qbRu1K943zF3T2pUR5zSIzplYmpOprxdoCt8cFpbM9tqCdtIt2hvWodCPoCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AymbEKu/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669EF606A327;
	Thu, 29 Oct 2026 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AymbEKu/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389FA1F01829;
	Thu, 29 Oct 2026 10:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270674;
	bh=CIildARgeqLV5Iv54/CNVDjST3eNjwaUwngHh+RJ76o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AymbEKu/+O141aUXpFJESQYbVO4wuogMwXREBpJyzaJheRuB65aNLVGtrzRJi/VzO
	 bE12Z6UlB10PYRTAOQsztIYgWy1igjPI8jnJkQUFqkhfNjcGkRLc/D4M0E/19WjV6n
	 tVVXtBWvT4dkmpHXwnASIfsL00nzHR4ibLjuHCsaVNf0altwI4qCEsWJiI/JQKl33B
	 RAsvjWT5rIZbdLkRtMRjQjxHfpsffbTpfSX3msFksDMdn73OqZU5ASa81krExVd19G
	 e8OOgox3sShxjxE5XSQ/H+Cm6KVp3M8+YK+FkxzAFtIfzRe9oPkJ2d6wTM9ftD0mY2
	 rr2XyAwxhd6Fw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:26 +0100
Subject: [PATCH v4 05/15] hugetlbfs: enforce F_SEAL_EXEC in setattr
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
Message-Id: <20261029-fixes_shmem-v4-5-392fc715d8f6@kernel.org>
References: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
In-Reply-To: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
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
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK4d5XZxZu/ixY/Xmvrs8OkxhqziUz4at10y7P+Xxy
 n+LpjSd6ShlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAit9gZ/mdfrP6WfvHudJHq
 LZmZi3s3NnV+WfV3wd3MQ5IXF17O+KfA8E836l/mJq3fSrmVGa+ay46uFNuunXbjprXDt0f5JVv
 /L2MHAA==
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

