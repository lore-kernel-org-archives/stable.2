Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007708;
	b=Zma2kA9Qd9o7/imNkLIUeC4yhbLbVERI8CCLIGhUfg3+RHvrW5nQ37j1YQ4MjE3jl6bf
	 ALkTmm4XD+zmQl/IQCL6PZgcK7l4E2e6lASNYBucKI1OAU6BOcXztI2Cyh5ZTlc6gE0M0
	 Yk0iKYNoLHCfQkIoSTJm6mi7K3JbzbgRlhK03SMrgd4ltOi60iR5hzdaA0X/Dnvq7vIQb
	 YGi/yAPFBeGWEV5dPGsGkJn1EegpbRxXV5CtDaOx1drgnfv4vXuhIxCONVNV0f1JzBDMP
	 FJLoMULPB+nEWUnBSkpDjg41yEE+2ZHk8TxzxypI0tr0SCMMhjgmN9jAnGMVeajRGXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007708;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=91PytXVfbyE07JEL/+LQiSAiMw58uzuZZkwQELyO4Qs=;
	b=Maj/hjpaCLFpnQVZ0oQQOSXyXjXL90Vg326umcxVKHBpz7t+J4/r4eVbxymjGMNQMwYz
	 4gb3/tgRj3BhVoBO/k7JN4kkefdpfXvnGq3GnDCYvQExMvFy44iprDtxX9lF1huyqnd3C
	 BvqQgZoFR3BayRWRFzwyQWBj5zy3WhhKZAnwCTpEFsraZ7k/gGryCObw6BJ4qIAGwBL5r
	 ZSB4orDkh5O6RuIqMDCktq+1LxrO+wypJ5EoeveGO+7W0A0/IzyTWvUVjT6h59VsBsIDr
	 pMm9B/0GG8KP027V+sZhguIEUAHj2VDIK3/57y0TUcPkjxHfopKE25XUPDZ0QmHyCDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtrBeArZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B194560A2605;
	Mon, 26 Oct 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtrBeArZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AF01F031E1;
	Mon, 26 Oct 2026 09:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007707;
	bh=91PytXVfbyE07JEL/+LQiSAiMw58uzuZZkwQELyO4Qs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CtrBeArZuEDEQxETWypL5shpYNMU+iQRLlhoPGUUtOMb2TB1+kkCdwf0iRIzGaAys
	 hgPIC7O6i48DC+LlcrQabtn48NIdojoLdF6szMuWm31r9koBb1sNjDdnQ5xUcGZdvo
	 8zzr5O+9eaps/RF0pjeUHJif+nmHzPxIakdYulQKN0P+A++aScHEHvvcy5GtGlTvqY
	 6dH4eS21KIeQC3g0lJK/i8djRAb7MOmEeCrjwA9Uy/p8fsgfHDSyWH4VfoU7Ce2GWv
	 Cmzk8k+En8Zv56Wzzv/9YdRHzEwUl9hDh72Z/sVRIvBUPJZqo/HP/oOjnuNYFGwqnX
	 ZdoZoWvdef0Fw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:41 +0100
Subject: [PATCH 08/16] mm/shmem: stop retrying folios that cannot be split
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
Message-Id: <20261026-fixes_shmem-v1-8-703206d5fa0c@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652; i=david@kernel.org;
 h=from:subject:message-id; bh=tnGXb7Z0f1hnh15T+i/nb2LT6YYfAxsDadBlf2K3IFI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4gfTPmpcPvHXLnZeZc2335qwrJZdJmAXYCd1r91H
 zXl1ryc21HKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEHB4z/LN43btSrqDj8JrH
 M6dfmr1OLrL5SWrXTI3ND1NkJ11PUN/PyPBi6sos3i17QpeHFp+Tkj7/Ut2wWnqXc4WsiGm4WGi
 kCDMA
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
[ david: split fixes, simplify descriptions, adjust comments ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2410ec46ee1d1..e2c3b04051833 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1490,6 +1490,14 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 						index = start;
 						break;
 					}
+				} else {
+					/*
+					 * Splitting failed, but the part in the
+					 * range is already zeroed, so skip this
+					 * folio when restarting the scan to
+					 * avoid retrying it forever.
+					 */
+					start = max(start, folio_next_index(folio));
 				}
 			}
 			folio_unlock(folio);

-- 
2.43.0

