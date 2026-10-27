Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106252;
	b=XhwWVoS5f5Hxp8dGx6KvIHKkYvxHlP1V8kjfkU1zsYLrgFKhhLO9/aYrIx50WacmgQoD
	 smv/ufUXht1rqp79uVwtQyR4Mohur4fsmBBCZZgSqR4xVSVmDdTPWpT6IgiuiTS+kb3Le
	 QJCIODGi6DU0eRqWm7mHDxeVSTlRWBqv8NwLmHrYnRoze5m1woJ6PqthrS3g+82BJbbUX
	 BzLkngFx4XebJf8s9xqWKbG8hfIY/mjpHjbSrvj1imlQ6atvoRjUD1l1CTTnf7n4ifNf+
	 dIbkhDxRISAxdieyXJB716wBXfH5F8k4BgIH4oHriS6OUm8QwIytwysrvcXnldBvJkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106252;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HhxjLl01JE8HuMTeAuZe7yEExHhcmywGMiR+Ut1EZeI=;
	b=uU1rPVuKfovdsgr65oumsTsg4HJdceEEeL908DB7pUP7ivUmUDPOFcyXB96Mtw1S3rRl
	 NieGKVcFoEWuO6lWf0bEfFjF864lPdUH7w8d1JOZRAqcJ9v6zFVj1EwPJpiWzV4o0cI1b
	 M/4Tg8hWz7PalOWW2pRI3iE2p7Dk9FNRXWdsE0oJ8VweiyPEVHcOIa21yNsXLIH8BkeRt
	 zWnmy2QibZ/aypU0kHwtrUQvufKSR132eSlp1W0TIczEF0fmKHEWWB72F3gyJtR3xG7Hb
	 UGGHHviOSTiUGuAj3yXhiSS/6li117fpl0EUvjjEMXT3X9vx1eiMQLxwq6ka+ZEdGDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAJUnKJp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA538606A32A;
	Tue, 27 Oct 2026 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAJUnKJp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383461F031E1;
	Tue, 27 Oct 2026 13:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106251;
	bh=HhxjLl01JE8HuMTeAuZe7yEExHhcmywGMiR+Ut1EZeI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MAJUnKJpssMeeloEVpIfvQ1vuVL6RVQCj8iscz0RR7jWPKYwoYelvRV2efgyDGJPS
	 i6IXr2sM4vUIqO3py3xMMXOUqfLQdfbZu6iGKnCLK1GZNkuY9nTQv6GBwcfLx2Pds7
	 wedoPfGuYfPik3pVvcW8lTOVewcH3UReqL8V1wIF63pbHYqmjpP5W9k5yaZ2aDF4Fj
	 UB36IK9XwB8C71NcVT4u1CwKci1ilb3z4cu0dWm0Ykcw7iCO3shJCGQjewI+d+2cCx
	 PbFGvbeNSOtvF/FVp+a1AT9mJuodT9Z9RpTnUbOr1bHC41FDEj4eVqqX+FjqjbMYjp
	 96eD9lTCKseqQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:11 +0100
Subject: [PATCH v2 06/14] mm/shmem: stop retrying folios that cannot be
 split
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
Message-Id: <20261027-fixes_shmem-v2-6-86a00952acb9@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; i=david@kernel.org;
 h=from:subject:message-id; bh=xU6NxeFuouXddfE5ExETEgUGwjovPx64LRkyocig7Ck=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBSsPj3973PG+Y92+ax+ZcYkd62Y55LXvdXTmNSbT
 dZWT2i81lHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEGp8xMryYtkFw1UzvUE37
 +p/TV2ZoZnha3Dq18VbXxzLj6r8CW/oY/vDdqMv74VEmlz+3ft3iLB7hfVdtuTJzNvT3TPn54U3
 1NX4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

A fault or collapse can insert a large folio crossing EOF after
shmem_undo_range() has handled the boundary folios. If splitting that
folio fails, truncate_inode_partial_folio() retains it when it is dirty.
The final scan then repeatedly finds it because it restarts from an
unchanged start.

Truncation keeps the inode lock and ignores fatal signals while looping.
A concurrent unlink() can then block other directory operations while
holding the directory lock and waiting for the file's lock.

Advance start past the retained folio, whose truncated part has already
been zeroed. Do not move start backwards if the failed split has shrunk
the folio.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: split fixes, simplify descriptions, adjust comments ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index ad644a268c0d2..5d21cdf5fb0a5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1481,6 +1481,15 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 						index = start;
 						break;
 					}
+				} else if (folio->mapping) {
+					/*
+					 * Splitting failed, but the part in the
+					 * range is already zeroed. The folio
+					 * was not dropped, so skip it when
+					 * restarting the scan to avoid retrying
+					 * it forever.
+					 */
+					start = max(start, folio_next_index(folio));
 				}
 			}
 			folio_unlock(folio);

-- 
2.43.0

