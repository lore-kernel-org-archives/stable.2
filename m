Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106314;
	b=rL/PoCXAJBt0rXpB+qAf1Z5UsjfA32v1Kb8hFDCBkFokfFOmlVl87echA0yhT8RDYAKG
	 4UY0KZukN0brUa41zwoylh5iKsSCWPx+rZhPCgfLdJ1gIJKuWGkqxg8lWJQ23A2FSkSMV
	 2LqXcWHoiq4oiI+jm4jDv83Y6PJHgATMWSVBStWXcbP+opgcJaATKbooVYciOWo0fNjyV
	 MO32i3QJYhgPilLGMJWKPi+urpbmSiZcEtJ2lAIob9wK/IyixMCdb/NU7f4Js588c1izn
	 aFD7XF1Y2Xx0fGD9SkQ3o5Z8Hw5xPD/RULaR0mWeTgeYuZcrxd7sID/z+IvnI3ePKQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106314;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UKWfg6nXMEPTxXujUYzfp00rWiuxfD1JI+7Tq1SH2b8=;
	b=3R8WedMX7iD+Mte5i2jmpAYLoMdkeIN1QoEgtTH78nokpSvuiEK//nhEyNgAxo34InSI
	 DYQF8ggJZBphzCHSbQGSqGNBSOqhROIWEksdOuvhku2JLiPRA09dMZ/qhLeaHDCFCSX5q
	 vFCsCK16XaC/MXYwL527H9jsNGJwPXAhPseQPL6Z0oEMIntYb+9XWqbiixleIcTFjmktv
	 dugIggPFw3do3yAFpVXaNRDYl0whp7h1JA2UIkIvUIa6e2RvHaib4omwJOqjGCNNr8h8m
	 6ZlXQgAVuLIl23TEx/20eJoWoxPgiUx/+iKuxZ8oDJszq/qrajrtFjk5qi+VaiV1gFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp9s8TDt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98A60A2634;
	Tue, 27 Oct 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp9s8TDt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB9E1F01825;
	Tue, 27 Oct 2026 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106314;
	bh=UKWfg6nXMEPTxXujUYzfp00rWiuxfD1JI+7Tq1SH2b8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kp9s8TDta9bR85RsgT6BZ+ZVbkIwImQjtt+GAaCwxk6heK7vDx653LYrsHkwhXSUM
	 4eyDrjRmVpk0METZ4Np8f4rqJ9dx8e5+fNkunjb7do92JUh5oOa0Bh7KMHmOEPtSzG
	 19InT/xTJdtBLOmOs0BdyIY44HXIdGZCTeXIMnSbgGFDBJ/6cZl2ZfdGpNF0kPuKTG
	 hNpwOZj3KGf453gc1NBIevm7pIfxW9qBNQ+B8xnTKsfcHo700lKsM2Cw7Q9uV75Chw
	 2dYhIBo2Jxz9IIePMFzS5yYnzzlqKPEl1hmSB9MFnfQtuMRyPtkMuxkw6hqQeCJ66I
	 GPqm4S9a76eCw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:19 +0100
Subject: [PATCH v2 14/14] mm/shmem: fix truncation of files containing only
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
Message-Id: <20261027-fixes_shmem-v2-14-86a00952acb9@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=david@kernel.org;
 h=from:subject:message-id; bh=i3hN4RE7liAW06y2OgRE+JIRMBR8d+B3ALKw3Lw9zRQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBSKP814sdEoLk21M/PRD6GVt9LFl3/Sibj4n3HZS
 fvS3A8rOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjIhacM/z0L5r8L6+j0YpNR
 j6n8mtGpeDq8me9LevOHw392aT2yu83wvyrAf3fGP/n5wa8/6dmeKeruEbjtEct88lbS735FbZd
 bLAA=
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2800dbdf031c1..3c42b4f253b5e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1591,7 +1591,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
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

