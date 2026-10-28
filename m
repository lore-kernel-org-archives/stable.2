Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181340;
	b=KR+zN6c9TP1q2nEKlhxgVZrlrPMmdv9jcVPMoynhgc9wYdHikGG0N+minJ4CkzjSjviM
	 Itfh5WLjNBAIaOXuOs3tsBI8KwluDoWuljF3VCBk00NMFwM3LYd29t3/MfR1C+8UHoI4V
	 kc+hnhTbQpoaFeJ2jNrtQyHIGgpFwpN8/zG+GPPthp6PWNH4G3/FrR/GwEZgdW/EGx29s
	 q0JK5GRPbeLWYv92lgPDuW6cfuPrbH89YAQ+B0MNYTY0RwihDl7heA7E7W9t0B/fUhGXF
	 ceJlWCe64jO2f9J3d9pnT3mnadG8P9pCTZXiPig2ZBU8KD8mYxZPfORCqV6d+MjJgWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181340;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iFruHrmEhVBLTXCl3oLRpr9O0/5ImLksM0FEP8VsCEw=;
	b=P+8tZCuBtlfhri0a0dHRccpPD8X0JMoPNVz9srcCZBmjoXojaFDhmGsq6SzYyjsgUvcq
	 kvBMjbbkvB7qTthzTRxweSIxoCNosCijPzP4AsFjnU6vg7pKRsP11YNx1jQ6trU0cT4ca
	 8dAOlu5mtt11nTBCLVcKRfmB4imn27axU0nIovuqS2za/5vD0KvOCMxI/ElJsqm7LCLE9
	 0DALHeTuX1YzcwRbz7KUg9tFd7+/E9IdGqIGefO1cztGgALsE3jOjwSXzJOFdCNT9Yt79
	 KXz6J7SKmosCShv/+kkIdyKeDeQjbYWvY1DKg7/SnTaw7hZVBUt9TDaWOgpjDvNf78A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcxSRQ+S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B1606A31D;
	Wed, 28 Oct 2026 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcxSRQ+S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB7F1F031E6;
	Wed, 28 Oct 2026 09:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181339;
	bh=iFruHrmEhVBLTXCl3oLRpr9O0/5ImLksM0FEP8VsCEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EcxSRQ+S4EvQkFspKgsUF+px6uVgYDy3gHZ/JCJEHNrQKXxzPgUaTV8HMkFYRbC6X
	 rTS3cM0AU7fDNL4FRPn0EQx3KWZcmDtbOrgSKrl8f9X+Tf0cvm0CbusuSL4gcU9ukq
	 /NySs5jiBxVb67AqI4wLbGv2b31t+5unCb9qdRwrT1R0kC6Sb9qqqVAyXTB/IlkiDN
	 kHD5dYJQFZBYIhYwPSD0PySHZLljQCwPSnTc7VQVDM96sMfxycOrYcJFLCVvELk+Fk
	 zGx6NuWTi8B5+YGYledzPvPoZMZYv8+B8R7GeyjIJt/UVoxXS3anSqhrNsIPhDfr+h
	 Hbx6vjtkQcYdA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:00 +0100
Subject: [PATCH v3 02/15] tmpfs: keep the quota soft limits of an unused id
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
Message-Id: <20261028-fixes_shmem-v3-2-4ce3baf2db4b@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=david@kernel.org;
 h=from:subject:message-id; bh=wp8CLVQ6JeR410CRw2MdFOBtKKDTEioNL4JmHUhVmWE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmssMAri1PNmkeNgXfU5P6E2d5V6Fe/8nTEWQrVhu
 UIdNtwdpSwMYhwMsmKKLEHB9w1evlxXW+3Gxwwzh5UJZAgDF6cATERzOiPDYb/ImTc3/W0/sL+x
 qjtju9k7wWsVHxh/vVix/uj6oC0aVQz/LBqP3O3xYn0+p/K3/bLzassYP7zY/3Abv3DxC7UekZ2
 /WQA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

When the last reference to a dquot goes away, shmem_release_dquot()
stores its limits in the rb tree of the mount, unless
shmem_is_empty_dquot() says that there is nothing worth storing. That
function looks at the usage and at the two hard limits only.

So if the administrator sets nothing but soft limits for an id that owns
no file yet, the entry is thrown away as soon as the dquot that
Q_SETQUOTA used is released, and the id never gets to see a limit.

To fix it, compare the soft limits as well: an entry can be empty only if
both soft limits are zero as well, which is exactly what
shmem_acquire_dquot() sets for a new entry.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: de4c0e7ca8b5 ("shmem: Add default quota limit mount options")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: slightly adjusted description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem_quota.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index a3fa4bd93e75..43d3b4fd6cb1 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -256,6 +256,8 @@ static bool shmem_is_empty_dquot(struct dquot *dquot)
 	if (test_bit(DQ_FAKE_B, &dquot->dq_flags) ||
 		(dquot->dq_dqb.dqb_curspace == 0 &&
 		 dquot->dq_dqb.dqb_curinodes == 0 &&
+		 dquot->dq_dqb.dqb_bsoftlimit == 0 &&
+		 dquot->dq_dqb.dqb_isoftlimit == 0 &&
 		 dquot->dq_dqb.dqb_bhardlimit == bhardlimit &&
 		 dquot->dq_dqb.dqb_ihardlimit == ihardlimit))
 		return true;

-- 
2.43.0

