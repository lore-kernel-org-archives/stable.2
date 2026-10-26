Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007665;
	b=w9WVOL6K0RJw4W2qvqg/OUoO8lSnJjdNmfatNB3yK9dinh/1rxXWPG0FDhj5L0yVzfCk
	 xqwWcteLMjl5tWFywdH0BPjcxnyQu6Hag9G2zRD3FBL/XDDAmQbJwEjgf7KBj0et3hFVf
	 xP1TNoiCT8yhNgFWGKplBzgAliApl3ntaGF/CYBWeAam9pH/wvGLi7d+UJYpPScRscgxe
	 iNm/bOBKZs04MEDKWv1iIlt6YNn5A27JSTe7WoKsYou92xZAGuDSX0ARC83IwZVNX+5nP
	 trnm+3L2pWfLtq07GrDLZsM9YYmYWHhi9xtRNP6QPDr3qkfIoQvOqrXuBwgwvvkIS0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007665;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Vn7d8HcL6l9EfFDO02stSAeg32JgseybYZFulW1VvWw=;
	b=jm7slZNFWT2tBz4uo66MY37b/inCi0uZXhxaiRdWTl8UAmDsdxhbwOHE0Mi+c83gCkBj
	 RPrVMGP1ItY7ckXS71AGOePSqWOGfSGznBl9GQwtdrHGaVj/FuQU42DJzlR80h/2wJK46
	 77BTtQnY5p3kGpS9WBMGtHtI0rl4yoebvsbWYb8jPwZ0O4izAaN8tMKqMtRklgyftpdbo
	 Agn9gZR2Qop0RXfOXBdpzRKbDdxY+7Ov+/dfa9PiCjoal6ELM4xp4adObpaV02cQR+A61
	 h+zBqn64R4hBtxG/XzF+CfIV1PYVVEkeD9pjnsp80GFqN/BbzQ+D+8vKe5MYdaOXrJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L78BWvfM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DA7606A31D;
	Mon, 26 Oct 2026 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L78BWvfM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07401F01825;
	Mon, 26 Oct 2026 09:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007664;
	bh=Vn7d8HcL6l9EfFDO02stSAeg32JgseybYZFulW1VvWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L78BWvfMcfWtf0OGq/x/m6dTt93g6YYB+jj+3oULkWdXypbX6F88y3ydkZqibKWC3
	 HQcNulIH3pHBCli1bK1KmBfB6Sb3Cz4BOnXacrpBsZsWzAu0KM+5j5ourum8Co2dzO
	 bkWndL2aLeBjHqyk/eFBIrNwB4JGJGNp4Znzv10v1iH5V/uCcPn8JeJiLRX5JP5Hwb
	 jJq42G9SQSfUZcF707QRmY66JjR/DePfYA5+ndNvUFRmnlolR5DW8S5iC7jXSuS++D
	 QYGbD6EcosZg5c12OCu6Gd+L/LnoKEXN2+Qcye5fT+Dl6SqfvZIFbVbu+ZTmhu4Z5o
	 JqLWvHX7rGwvQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:35 +0100
Subject: [PATCH 02/16] tmpfs: keep the quota soft limits of an unused id
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
Message-Id: <20261026-fixes_shmem-v1-2-703206d5fa0c@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=david@kernel.org;
 h=from:subject:message-id; bh=M7xAc6hQ4qkVX+uGz6S8AcR/OPyms3MLaUujNvMuOQ4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4itD9/NJCctMSMq1PFQ8MYL6ZMTzm1OuKXbkHUiw
 u6whtCvjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACbSnMLwz+hcdrZtbZ5s4ozJ
 PEGXDFWPRgV9C/9+iVdsV0CN8oqdbQz/bBrmt29bdiEyzaVc9r5MmtOPhmdPKxZZb1QK03iwVJW
 NCwA=
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
[ david: slightly adjusted description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem_quota.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index a3fa4bd93e753..43d3b4fd6cb1b 100644
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

