Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106204;
	b=KM5l7SFcbJhR5Dwt8e5n76MeryMrHZKl7HqI6Olw3AE91tKWuF0UlP0oCz7Qn3RsbXHO
	 yaiBEkTyGzipnxuKgvN/JD4HFexQ3Ry8ZEEzdeAtMHC7L1ov1xVP8WC5xgU8y9hNZSxxI
	 YR4kt8bFFV261snYcrJoYf4PWK5c1YH2c0EavO/1pqVgSPI5IruhEVqT4JOzpArLd9I2z
	 r/xEzL+u0IHKCfzbjM5wofR71HMDPNIBy1Z1MPNAZScTEnyI4iswx8stxM5S0+zRHI010
	 ALqEHtBAJJP5ITtFvVk7fvhuwYiDe2yAvNZLbUl7uDCmMIWwSsEMn2hBJpkxHq6nVYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106204;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=t5YD1CKiKbr6Pf0qRp9WaGW0F54tRXdLeXUoAa+sxj4=;
	b=epr9+wp6DmFf3vBMP5Lw0dAu7zaAWrNbMKRCOREGcHbpzkmgPope+IOyPGAQ4NvJL6/P
	 ABLLpzeZK+TzpLTCv7zGSrAhxhSBJeMCCTNgp6dOnDBZfM0C6JenrLzCFwHMSDyvvJvO0
	 zCliMU+lrErLb+WfZacxEGbMIoOTJb4Rhzt3Pc3WfGQjn2ylO5RtAQvI9go8KdJJgoVAG
	 4EpVytLwNRAT8cQ9Zoy5hLA+QHtTLeQAJ/0XboFGNV3T8jjqwB8adu8wyuKr1mGjySlfq
	 +/WOIWhrvCwosc4ZeqxRDjRlJqUL11kSlprP9qamI9+yX+HHsYva1WRTZFA7nQc+kWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JA7NLGEP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BCD606A322;
	Tue, 27 Oct 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JA7NLGEP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8011F01828;
	Tue, 27 Oct 2026 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106203;
	bh=t5YD1CKiKbr6Pf0qRp9WaGW0F54tRXdLeXUoAa+sxj4=;
	h=From:Subject:Date:To:Cc;
	b=JA7NLGEPb73/TDX+Rr3pDCzZUPQ446M72ieleEMNbazZuQrDmRORGK9BQr0+y8N1c
	 UCBfIpKxuesqa9OWl2N01BJkETCu7ivET/CUnnABvu72nKlR9XqwN9UXMptg5Fblfs
	 Ds6igJhnlPLAoRNcDiACJm5nH3ABXcHaROM//H3sWLWuaFJIfmTWua2eHxhVs02hl2
	 vPNuqSimqjP4J6bS6KUVaVoD2LcQfhnqd/xQeF8FVYrd2DjwR6a3qxuoLlkLi4uyQb
	 DEQLtJpsm5yLdfgpM1vsLcLstQg+XPrdxYF24ZXPXmhVMCQQAp89YRwu9TaR3zl6d/
	 uRM6MkUkqqnnA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 00/14] mm/shmem: various (urgent?) fixes
Date: Tue, 27 Oct 2026 14:03:05 +0100
Message-Id: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAmh4GoC/1WNzQ6CMBCEX4Xs2ZrtEop64j0MMfwsUBUwXWw0h
 He3YDx4/DIz38wg7CwLnKIZHHsrdhwC0C6CqiuGlpWtAwMhGY2UqMa+WC7S9dwrSg+U6mOpY2Q
 Ii4fjLQ6Dc/5leZZXrqZVsTY6K9Po3tud12vvZzZ/Zq8VqhRjQlMnTYFVdmM38H0/uhbyZVk+t
 h6fIrkAAAA=
X-Change-ID: 20261025-fixes_shmem-2782719b130e
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549; i=david@kernel.org;
 h=from:subject:message-id; bh=Th8n0dNxPQMqEHGOvKfn/qjZ96i4KNkcKlIYIhHT2vA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLOTr3NXY4bFHeWrPkVaDoxWLTA44XyyadGaCyOSZX
 fbqdm7vOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiIdAbDf0ep2lkrtZ6IPYr4
 HT8lu3BLYG9uVDfjI+EVF3XfZfS232D4K7PMqn/TOZ4nlupLb8UKvzt0YWLcmojFN7+2L2Qwuby
 vhQkA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

see v1 for details. TL;DR various fixes.

I now rebased on top of mm-stable (thanks Zi!) and retested with
Gregory's tests (thanks!). Thanks everyone for the fast review!

When sending this upstream there will be one conflict with the following
upstream commit:

	737362c7012a ("fs: port ->set_acl() to pass const mnt_idmap")

Which should get resolved through something like

diff --git a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@
-static int shmem_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+static int shmem_set_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
 		struct posix_acl *acl, int type)

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- Rebased on mm-stable
 - Fixup shmem_set_acl() compilation issue after rebase
 - Dropped: "mm/shmem: avoid moving the truncation start backwards"
 - Fixed up: "mm/shmem: stop retrying folios that cannot be split"
- In "hugetlbfs: enforce F_SEAL_EXEC in setattr", check for S_ISREG
- Smaller patch description fixups
- Picked up tags
- Link to v1: https://patch.msgid.link/20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org

---

Chris Mason (4):
      mm/mempolicy: charge shared policy nodes
      mm/shmem: honour F_SEAL_EXEC when an ACL is set
      mm/shmem: stop retrying folios that cannot be split
      mm/shmem: preserve data in clean folios when splitting fails

David Hildenbrand (Arm) (7):
      mm/shmem: discard whole new large folios on fallocate rollback
      mm/shmem: rescan after nonuniform folio splitting
      mm/shmem: fix truncate hang in large swap entry
      mm/shmem: preserve allocation errors when swapping in large entries
      mm/shmem: fix truncate loop after boundary swapin failure
      mm/shmem: fix accounting of swapin-error markers
      mm/shmem: fix truncation of files containing only swapin-error markers

Eva Kurchatova (1):
      hugetlbfs: enforce F_SEAL_EXEC in setattr

Josef Bacik (2):
      tmpfs: keep the quota soft limits of an unused id
      tmpfs: preserve explicitly disabled quota limits

 fs/hugetlbfs/inode.c  |   8 +++
 include/linux/memfd.h |   9 ++++
 mm/mempolicy.c        |   4 +-
 mm/shmem.c            | 132 ++++++++++++++++++++++++++++++++------------------
 mm/shmem_quota.c      |  28 ++++++-----
 5 files changed, 119 insertions(+), 62 deletions(-)

---

base-commit: 183895979c441e52dbd651b388553b09eaa35cfa

change-id: 20261025-fixes_shmem-2782719b130e

--

Cheers,

David

