Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106219;
	b=nOkypySIybK606WvTfznlRYauuz1WeNt+Oj+0+4NI8u1lUWlCNvQge09/HwUPFPv4iGP
	 QDqE7kbMklnDdKkxYDviK0OodVfGK0Qr1/OQRz1prwLq/8TReb27wcrDscETp7f9tTzd6
	 s9ywniq/6kEPLeZXmbqJo4ivBBlOuJf6i+cGglqydcK+p31om/vXK9wTlke4t3/whcCqZ
	 zaQ8Tt3ABz/YrXpDFE4E6zL/S7m4i2pi5Tur3PbkxwFMscrE/sK0NHeKm5tloS8p4/Lj1
	 DnBUF7UglC+QC+ataMw2Dht3E/RDHuOf6EySQXlWo5eK6li1o79vb+qO6pmEWxlq04w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106219;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HmxLnNloqDnX2mGRaG7UB60Xgda7GnOgxeIVM3cnCiI=;
	b=GlUVfjzcqhO1WFdWUbRTrru6N9kEk0lBh4HLwBNQQ8Btb/dqB1RUO/XTPZuNgLZemfce
	 7za1tCDSWtIQUHANkVEgQ52KzpmUakfhRTRBNUXJq1lpShDpeD4g6J5TjiQbddl/S4uCL
	 YPb0mc5KQFkiZN6N7bYKHODN4ob2KexqOrw3QLcrIZ7zMvXUBTQMoEaYmZ0FDY/EfNipn
	 kO/85hY9T6/TLhKsX2v/mwwoMrXOvrNwrqyDZ1SSGT6LC9zFw+1jG52mTiKIt+RKhMo9+
	 ZLVUJFe3uc3bxIEW9q+o3F4/Hyt6Pqw01Xdp8qpOYuHSFP3OMebr2f6Gji3nQwIxQyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkCBEq2X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06879606A31F;
	Tue, 27 Oct 2026 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkCBEq2X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D4B1F01825;
	Tue, 27 Oct 2026 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106218;
	bh=HmxLnNloqDnX2mGRaG7UB60Xgda7GnOgxeIVM3cnCiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jkCBEq2XthyXjppB6FBZsDBb4g+JSV14/RdizzEMI5plk0gIcKULthmFx0xGUXtt9
	 W3TLuDN8wSjmTf/3igeQrdB01tryX2n/9PpiAB/MjPzt2WHI1TmBki18TanYBxzft8
	 x1w2jkCDONXBiws5DDA4GjVSiezHe3kb4H+Nv5ZUd5LH4xy/v56p2gXCLrecf6OkJc
	 QFb7akhDXTu5+qRVuZGhp6bQR1CVzjK5n+jAtW5hVloS7SilC+nGh/PpmPdYwqCKDd
	 YDrKe/RZMsi2XuSBq3L/5ofNkWa+Fp0/VVGgbkVayTGg5l++oO43MVm6nq79jqkKBU
	 HRlChtleeBSZA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:07 +0100
Subject: [PATCH v2 02/14] tmpfs: keep the quota soft limits of an unused id
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
Message-Id: <20261027-fixes_shmem-v2-2-86a00952acb9@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681; i=david@kernel.org;
 h=from:subject:message-id; bh=JOA/wkBohGWebURbwXTYcThfkfGV/E7mEcVBQ7p5Pw0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBRg8NoZ9G7p573SIdMul1omC2pmCF3SaLvT/+vaq
 ZY7b7+ZdpSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJrAhXJwCcJPXMTIcXiO30NJwnoHrFvmp
 Sr2Lg31dbHxZ9VZcTw/vDjQP9N3CyHD9Tvn/3c1F5rcCxddrntBX3tLsdJSz4kTKh9IfGQs7ZJg A
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
index d0b92d6da50f5..a83392f75e56b 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -251,6 +251,8 @@ static bool shmem_is_empty_dquot(struct dquot *dquot)
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

