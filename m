Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007766;
	b=L8am0gI4z9r3MbRIfTFPWtEno9rThmoUpWEcbV/3uhq+FqfP58pnQsmIgB25TvCxTDh7
	 Cjoz4ZJWu2acDH7w32nN3fdyLmjfD2wKkI9Vu18wdxXqIHi9IjOVWXHLkCCYy8WzdF1iT
	 1i4n/TQVs29TM8QvucMkPvE7VDrmCpPKA2Qu7TGXFB0kX4zOoMmR1GOu47LOJDPII3ymD
	 pcyMcq3uIJn9IPjret4PijTEVcm3B2Oz+1EKXGbIm0202pRn3iKG22sSdRpFu2Q8Onk00
	 jHayfKVdTTZ7LGcer4IGNbcEV+xgPYYLL15K5c2Q/IVRcZU8zewOcCXPTO0bf+C3mLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007766;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=84TwrUWL26n6L+6NQSuJMlNmIQWaVGoOxoCZs9H9buM=;
	b=ITkdZHtbMO7q11ltduCfdyRXWprRFhieZhUL7bUN/Q2q+Z69xM3jHk7ZMrKPOHmmx4w/
	 XzMx20YDDz1neyxxO+yEmJvZW04tuRBP0Ryne++VQdrSiWUmGPvZwkHG22MYaaLyNjKEC
	 iBKuLQN7RLZTiLqeZoiPhZ7LZI9jkQY0KWSC/ilqpLTfbsFSJKnGJQxVxEwkMdWpCqe0H
	 HzNaOzUFr742jrDsLA8dw2W93OQMPc8bfC5dxmH8uTct1ZtLt7S2+/3RDv1Zu7emhkqud
	 ce36X3nfG4WVFlbm+TW3GbGTjxLdltfaAVU0Z1EGybsgSCYkVWcnkWCutMHiDGfQ5XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7mb91Qq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504A606A328;
	Mon, 26 Oct 2026 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7mb91Qq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD0A1F01485;
	Mon, 26 Oct 2026 09:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007766;
	bh=84TwrUWL26n6L+6NQSuJMlNmIQWaVGoOxoCZs9H9buM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i7mb91QqykwQoDgzWY9M6nfCGF9CtYL0miYdF1FjCRh0LaqHPRJb//tCmgbKC/umF
	 WgVtyNPI5exENTXXI6xwP2+99qN9n+9hrWnjuf1xfV+BNi2cKGams7B+AsxNWyQxiR
	 bJlInhJx9qAq2tEv93oHYdzY4dxGjx+gnA1bBqwYt1dlsykhpcsPO3BNK+7Mvmq4lk
	 37s7HkIWBH3DHE+TPd4uELH3PWaS4exrVNnGexWjkfvysOXcvx4L3B1Apbqq+jSy/c
	 3A0lxJUmTALBaoajpr2hTpbrtd1EBQjh9efnquvyc7chjrx5YlNdy/j8/JRjAnLKB0
	 LuVgsqs5p31bw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:49 +0100
Subject: [PATCH 16/16] mm/shmem: fix truncation of files containing only
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
Message-Id: <20261026-fixes_shmem-v1-16-703206d5fa0c@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500; i=david@kernel.org;
 h=from:subject:message-id; bh=IWKD21922t1O1049MId3yRDZkDpskSIBwZEf2NiLDd8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK0h0lVU6Mlkwfkq8/3HWSbnEHS8VvvN47eBda8snY
 nvuQMinjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACayKYKRYd722qp1zevZ/C8e
 8VttVznfrGVK/cnM5SvPs0VZ1men+zEy/OSZbHT2zvkO5zar7b931FU7pyTu/2a9sV3p9sQd2SK
 /mAE=
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f5b5c9a312c53..45f6c34f161e4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1602,7 +1602,8 @@ static int shmem_setattr(const struct mnt_idmap *idmap,
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

