Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007686;
	b=IEftNbdPns45DjXYjWdJXHJCW+5pZ6bFfXNDjvAZz8KJytfOV8L7UA160D4opFv5WHtn
	 w36G0tlcPhxNTdtxnY7UD92SQ4N+awdRa2iO4Zm+MsP+H18BYCsJeHuBKTJ1fC3CJECBk
	 iT8dFCKM9/chwxCaVwkGKJSgOweKoskFkQInzTrnYZe/FIVS5pB11Gqaa5/8aRy50X5Gb
	 608Nz2VePEj5J5JJ0xr3OKr7gFk6y7dHCcyktjWtjPfK2Aph8IsGO4bbk0ZrNHTGPyYXH
	 9FwmOHelmCPE+GZj8aTi+RQsLYjWxYNqsEqIhIJbEXEVAkwhsOCjzH7ts/tjZ2jngSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007686;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YaZhyWbI3ktAmMGrrtBIt8obKZUr9PxAavcai11wXso=;
	b=cMj+9rkin8GJjN6gxpaV1HrIMWBihmtV5tozkT7ZI/n3PmnzqlykTq1P+oDCmfp95Z8i
	 Qfw5jjxkU1EQrntHC4cGAzh8QRuOBkn9u7DozLmiJy2nRO2H9/xQNAldYve+eDHKxkYxU
	 MsVvr0N87iUPanhBtSbZ0fPz39Pjl1upmrMp5YYDP7r93j1csBjBAKqgXHhBOx5Cjxefe
	 vvMed5j/FTtac8R2gAmjlt1SMu4fA5JZS9v3kRazVQo2U9axMPXCh1UCmSHZBd2vJNAg+
	 RDqnIxBau0LgXr0yNl7JWDJmtBoIvYMrxTShitjX6+ScK2O9VLGNmeTSkb+7Ix4QuFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4LABUZ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B6606A321;
	Mon, 26 Oct 2026 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4LABUZ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFE71F031E0;
	Mon, 26 Oct 2026 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007685;
	bh=YaZhyWbI3ktAmMGrrtBIt8obKZUr9PxAavcai11wXso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K4LABUZ1R6fm6pCLxTBXBqb+67n74mLwr2RL9z5T6vK6VjiKMgh7M5qkz9U0+120U
	 /HqYX6PCk8d8PFzthXLiGQ4SL+5/d2wDDHlK8aHPJp+EwrQh53Km1bZU3VPBi+OABg
	 edn9Sa1cv44sN4jdWmJCwvOkDNlKtcg418bSppAzFKIbhoNm0o2Xsw/tk/BKvdYhLN
	 x7mWsogUFJTuzG10z7zYI61SVsd3djnuqMz8lNQGLU28xunGln+PTNhykQeEmH+ofO
	 0rmtbZM+E6+G2AG2c0jokbLE83qRiVzTxQw1HIX2dK1jQsQOiAVvBDYLCsDMfaioqV
	 LydIXbZHtRUQg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:38 +0100
Subject: [PATCH 05/16] hugetlbfs: enforce F_SEAL_EXEC in setattr
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
Message-Id: <20261026-fixes_shmem-v1-5-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
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
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=david@kernel.org;
 h=from:subject:message-id; bh=mQC3JDF7WRonbAYulIb7hDyzHoAE2NMEfNgcNDI1FcU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4jlaPp9e/3q27LwB28awq4dSticITuhinubqKDih
 A3aASWJHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEyk8CvDb7bwhxIXfvk5MlxX
 SKrZIeu0wNDiStznj+ejYtze/Xy0sofhf21rR3XZkYvpOsF7GC/NtmRY+ubWtkX+G1q5NOV9Z+Y
 v5wIA
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

LLM assistance was used to reuse the helper and revise the description.

Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
Cc: stable@vger.kernel.org
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Link: https://patch.msgid.link/20260629180247.2343229-1-eva.kurchatova@virtuozzo.com
[ david: use common helper; fixup Fixes: ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 6656807ce4377..7f5c3962b5d56 100644
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
@@ -841,6 +842,13 @@ static int hugetlbfs_setattr(const struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
+	if (ia_valid & ATTR_MODE) {
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

