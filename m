Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270647;
	b=S8ATiYP8MzIxzVyoN/b/m+NziknEPCGzyyDESYvx068k3u68S9RQR0BXiCT95W5upln/
	 vkswQyVXchjV6x1C+2W1JBDASVmvgXycdOItl3r/f59eLCMOD3tivYvA4bL4Ojge2xBV0
	 RiVQuuEn48XFifqHkVxD6g5OZgC5Qe2q7/aWXCXA+WR0Yckppx7pE6Low7Wb4n3e6lIxU
	 sADmUwl6PvFMxp1xyOX2jWa0IKR9ifbeyEwiKGLta97LGHhGKR9SEbPJEsSVP0F+Ww+6v
	 xFzHx2zurS5mGt5faUwzMfzIA+21ViUjaa8+YPcTAtDPMPS0UNmz/9ILgPZmDOAGIpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270647;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iFruHrmEhVBLTXCl3oLRpr9O0/5ImLksM0FEP8VsCEw=;
	b=fnTYKAwL1Q45cQGjoKkT/zuwucduRi1WaePIEWA4vFLqGPMPsW7oMzgvjMjUpAqXF9NL
	 mlu6QCN5rzYuUJO20WM1DN96imdIyWZqzKreipJnd3tqqpoF75c65XAdsI/Dc0Vb0XeAs
	 hKG93ZnTuW5Ys2D4tI6G68N6vKGy2au31QZLzmEBBWuKpYiERTasyHcpMCZAJxPhSNhxs
	 XJoMPEer1fYuOe2CmFRmmQLHSefiJSHl3a6nQP12j16dqL9K3wXRo5WoWbrYDTycTHZ24
	 KUe52JeGS5qAe+fEAGXgmNQH6R4aXFd94Bf9WrVEnzZOsUPc3HvAnFNIJIgQWbwtPXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWRfNUw7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C6E606A31E;
	Thu, 29 Oct 2026 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWRfNUw7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336441F01825;
	Thu, 29 Oct 2026 10:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270646;
	bh=iFruHrmEhVBLTXCl3oLRpr9O0/5ImLksM0FEP8VsCEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oWRfNUw7J3fuboDVR9GKUxEKeGf61ab8Su2tCZVTh8nqxmWDvUZv+DHuac5BjlLdZ
	 UnRHcn4/lFb7nWex0onGp1u9klh8LilMEY2roLmvMP9Vk5iDaYxX9jAkzjDDfV3Jxu
	 vfJT9lBl2rbl+LdK0H/6bRHKmTxqRAR9I1MhjOY4QnDQAa3HagNBew7GhwfIK2hqnA
	 YueHKK6OHmyw0OrlYKOm/U1I4Go09MKWoYTB20xwJM0JcrFvgHLpOclMDw2UxBDF8Z
	 3anBl6FAp8ZsTPip+HSk5kM1F7sN+ijZVa0Qe8a+7dmN/c0IpgliLHfQeAy2DNNFYD
	 bEeXVZ6B7TdwA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:23 +0100
Subject: [PATCH v4 02/15] tmpfs: keep the quota soft limits of an unused id
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
Message-Id: <20261029-fixes_shmem-v4-2-392fc715d8f6@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=david@kernel.org;
 h=from:subject:message-id; bh=wp8CLVQ6JeR410CRw2MdFOBtKKDTEioNL4JmHUhVmWE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK4cdiBc85HNTrGyeG9vcE3s3Kmza+aVraci8Db9UG
 V21L4bf6ChlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAi3v0Mv5jMOPqUtAK3GvaF
 xtUH3i6q1iz9mLhWYic7x/IXt+OY5zEyHM9e/Ot5yN/QhNyLHg5u+TYaSQpzdnL2751o7/5y3de
 LXAA=
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

