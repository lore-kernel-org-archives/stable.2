Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270762;
	b=XhM3i2ryleUC6EMUt/ZG1Zw8rEk1MAGzd467EHo4SykwmLimI1ZItfaAR2QLTCP2Ygfb
	 H5gqAndBlNAf32faucMnbsCToZIZxhUzPKGMYpo1VrKMFKJAjO9nGuTDwztJz1yOQS4oJ
	 mR3TbVcmcArZ7zaO698tsBK0VZTJoIHv6ShMwJdhanJs79Be0e5OoLSTFqOQr231W0Fft
	 8UmvuH1a41b/DThCoyMOgj51mtk4IOxuXWjD6hplRJQSaHDF8FD/apKrxzwdJUho2hSEs
	 3GN/PTPXlspOQoGA3N7L8CVxbA27lIIDekdHc7Yns+EKrOuZ2AkRKhaS2clU6VEpyLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270762;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=F6aNkGCILQejjmcnm5RGfmCiEMne8lGLDKI8m/EHHN0=;
	b=RcQ9n8EmYHOwR/sPmuLtCOJfJbfaR8c8hBZWGW1gzW3JhfNwbO3esncElO1yzfLlTmN+
	 tZk+dWWbKaoyu/XZZmpuCWHx9tohgKF4mQeDGGOnfCTv5WfP8n1dcUrdmnf7GLhwlBv6/
	 zxv3jh7/CmgM2JpNlFL1274jjnFNLe9HL3aD9Gkm7aklQBNJMWwyWdj0wHZfzRpCPH5py
	 rsNXx+kjk6crXxwcXnHMNa/PhDXPL6nkfmojdTC1VloiBOpcaLxR+kYNn3oyI3e7V3CwA
	 J4wrmjtTC6Pxx0gJwQG4U+vpCyeuURsT9cN09f6HTSvKbvojhDd8n3Xn0hYyMQZ1VZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1SiGScN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B9606A31D;
	Thu, 29 Oct 2026 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1SiGScN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C281F01825;
	Thu, 29 Oct 2026 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270761;
	bh=F6aNkGCILQejjmcnm5RGfmCiEMne8lGLDKI8m/EHHN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b1SiGScN5gaMrX3BUT8ZcgSrrzqOsKcKpJtUpEjCDbs07kThIXWnIiQLBOYl23ACS
	 JI562Zwyzpfs14JICCYTVvHrPqNN5A5FpTYtKi+Gm65Kshvq5mXNc02vehV+dblE8i
	 mDrOkRYjdY5hbCijQF+z5j+HmKz3CBMMezGKL3cAJ64RwXX/xQ46wiMnn0YWWqbuJ8
	 dsErVxADrysN/Ju+UVXwAUP/re9tL+sFscNXtSzro38rZO88XVOB3wSxqXnXNZeNE/
	 fdJeK1H6KwU7t7q5GKCB5xTnXc/UUndzY7sCzZLXFd6w45nKctrqtleR8Q8ToDzMI/
	 Zo1+GSjyuZTHw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:36 +0100
Subject: [PATCH v4 15/15] mm/shmem: fix truncation of files containing only
 swapin-error markers
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
Message-Id: <20261029-fixes_shmem-v4-15-392fc715d8f6@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=david@kernel.org;
 h=from:subject:message-id; bh=3cyi7TgGjxMsxAuKMnS5D15fBsBka8mZ87JHY+VoW4U=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK4ffb/+a184UcHL1M8H4rm3yl8JNVmWtO8myKN51w
 cuvxqnFHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEykzJLhf9hnqZq2Pz3P3c2U
 Ln3s/MQmvGOSd+KVIn7uvdw/v7d132Fk+HZzs9urmLyMzFgmx/37/Fc9jpyaNnUG5w9bVefVEbN
 MWQA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

It might not be very common, but we can end up with shmem files that are
composed only of swapin-error/poison markers.

Such markers are not counted in info->alloced. Consequently,
shmem_setattr() can skip shmem_truncate_range(), leaving the markers
behind.

Truncating the file to zero and growing it again will result in reads
failing with -EIO instead of returning zeroes.

Check whether the mapping contains entries, in addition to
info->alloced, before skipping the truncation. Keep the info->alloced
check so that shmem_recalc_inode(), called at the end of
shmem_undo_range(), can fix up accounting after reclaim has emptied the
mapping.

Fixes: 6cec2b95dadf ("mm/shmem: fix infinite loop when swap in shmem error at swapoff time")
Cc: stable@vger.kernel.org
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 897f19ed0fe3..923957e5e6a2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1591,7 +1591,8 @@ static int shmem_setattr(const struct mnt_idmap *idmap,
 			if (oldsize > holebegin)
 				unmap_mapping_range(inode->i_mapping,
 							holebegin, 0, 1);
-			if (info->alloced)
+			/* Swapin-error markers are not counted in alloced. */
+			if (info->alloced || !mapping_empty(inode->i_mapping))
 				shmem_truncate_range(inode,
 							newsize, (loff_t)-1);
 			/* unmap again to remove racily COWed private pages */

-- 
2.43.0

