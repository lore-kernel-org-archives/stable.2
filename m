Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181439;
	b=J0oVB9jZkysn5+6MHQRlTsbWy6QMM9Z8sMLt31nmtkDq+7ICWEUPyL7AaFaKUsH2h4NY
	 wFEgxz7bwBEpHL4mVKZV4iQYpRs7+abl38nhc+bgrMWQGr5FWhw9s3Oo/7YWyTy4l5LkW
	 BEQvD18igkJDneCKgtoa6ktNoNVgly/krLof0NY6fW118n62H9LWDxZ4esy5OdbQR8Xw2
	 eBYfgNR+Axv8x2SMV6CBlMtnGrIdwXdTSbVNFWFDutCkPDWdxWVSURDub9Vxh3jxE3z4Q
	 Qrvu7d69Hu2iU1UZ42jxoj8l6prmajwzmFLDzyHlNaor0L3Mu+dLOKccz9Rr5AMXqGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181439;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SpR5d9py3XMD/Kz0n214N+JOZVrkF2xRnFstJsjKg1c=;
	b=4yJx+WVnJbsJn/ZW+vvoq2EPYt8z3mgKwT6mfqWlaveai4NDVa8CjWbaKXnfvjL5Awck
	 JM1/QWuOzIKlKsy2Ij5bNBsbR2yivQ8c9/6sKh3QOx5evt7JOu5R3P7sJjy1TSdUro3DS
	 +yaWn37AevyHsaJt+eeKaMdJZ6OzUsjowUf86MoWKxJZOE8v0IV5KBy5nH9YhhUMQxdy8
	 PpOIRpEjhIn13UWHA2UIOf8wYv3p77d67bJyOAE09AjltvsChGqRHzxjERzl3GnHXzSyQ
	 GL/90puJgg703QHSQDxcahu3mGdIeiJIFiyO+VR9SNQ+Abl+OhfHJS5Q+84sR3qoWvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a61qc6fn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C939F606A31A;
	Wed, 28 Oct 2026 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a61qc6fn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCBC1F01829;
	Wed, 28 Oct 2026 09:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181438;
	bh=SpR5d9py3XMD/Kz0n214N+JOZVrkF2xRnFstJsjKg1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a61qc6fnEZc3xfx550jc2D95XA3KZeNfm/bD3tKIVBm+O5o6v1jStX9B7HgcN4iq+
	 +TRzHNpBrQBzOe5eM5GSjvKmBC8PrOtIhuNY9Kf9xZVOcU65M/aneykg/oRvmHOOZt
	 xNgr59mTt/fCCc8G4cUeYGGFR1oul1MpnAnDAO+NCyHQ+HvJupBKhgDn9umn6xVcT4
	 vif3vXjMAIYShwthmy9MNfWM0uMOOx7gzDrxyDWALD//imvaXzDmvkmmtCGZk9sAIi
	 H8o5lTZ0LHxadSVYVYYcRBD9wnvESt48tHBXS5vAVBLKBvdyrBD8LcR5dm2XympuY8
	 XS2s/Ze4Frubg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:13 +0100
Subject: [PATCH v3 15/15] mm/shmem: fix truncation of files containing only
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
Message-Id: <20261028-fixes_shmem-v3-15-4ce3baf2db4b@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=david@kernel.org;
 h=from:subject:message-id; bh=v1KTmyDVJ6BZ1dQ/IfjBTs7H2skt+1ukgSl8cYUbwr0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmt+W2Ky6O7HP87/qpyWdgqc8xUobY1eufv8irofL
 CYepR63OkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjIs0mMDL//7jPQktD//Zxv
 +gLZ1OrLp3LOfOLkm7Hk1JKfjjGTgu0ZGd5+Z1jHfcxZ2tmq6N99j+1spQJtKQpTuJ0nPBWctWz
 LJh4A
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
index 11c3ac313c55..9e51768ef46c 100644
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

