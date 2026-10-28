Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181324;
	b=iybUtsY67RsebWbE1tt3Uf6j+SMibj/X8iTQcJljXyPpp/acdUD2rfAU63rAmYsdnTKL
	 HhTXOCHqqGAreA7CLn2/61KxzQ5HVXXZI+d02Hsx/4Jc4TRF5zM+VCnRY9bImny9gtEMH
	 mkF4U+gYOBYq+Rinr1mRyitmH1dI7naQDPFeYjN+wqov9atQVTDvSu0XtL49U2T6GdNn3
	 Jk8U13fhwB58Nnzh6YupELVE9va0uI/PPMxHTDtQ1ZBPC6/JqI4LQSPtyYQBzSeEa6wxq
	 mU0QzDfhF4BeToUBUTDAWIx5L6rdfYCeOudMj7O62sBsHZ4ORF002PBp8T1UBHzFw2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181324;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pqX9rfgmqaJsxylyr7PekQEwW67TR8Idof8IkM9MJmE=;
	b=e/bjBfDYSK34C7IAFP7ng7xC5O85OW4HPcugluokQ2HMrXCDERXv8wZYcMjo8E6E2F1a
	 QO4wjnVzmjRNY7o3CwjP5SvIFjW3HIKDxlGmRYkOSDp4/0cDic0vkSxAXiEh7hVfoQWRR
	 S6/S3AjBZ46WnI1kFs93K73r5Nr/65P3c+pPKiJooOV4/uJ5bab9/xacXyfaFkWIeP7G8
	 RSzzfQgnsZdDNAhRH9Llo7KbLI4B7VnUQo5Q/Pl/C95qRfG2PPec/gIgmPhfd0vTC/lh5
	 d0bKaYl1VzWuraphRhtBwN396lhEm65UXXa2i8idBD0ftctMUD4W+RTQAPCwYjIJfYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELizeEpW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE60606A31A;
	Wed, 28 Oct 2026 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELizeEpW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3161F01825;
	Wed, 28 Oct 2026 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181324;
	bh=pqX9rfgmqaJsxylyr7PekQEwW67TR8Idof8IkM9MJmE=;
	h=From:Subject:Date:To:Cc;
	b=ELizeEpW0IWW9ALHMAwUdjXES+qCVnseTomqDmrxUdJsA2qI1fN9VpHRkPMHHB/z1
	 e98N/XcweBbYdDxieObG0MX16FEbZspUHisMJzORsFG2RKQx8fFFQkPbYAFWDzM2ri
	 5EU7adjS3axw5M15cusfxHELyH9A9jDW3BFaWZZf0Cvzc9OtiEgSXpBwT6DKoZwOMK
	 YDcs/ClOj2ocpKlASP4GDCXMcRwgGFy8qvPcLXO05pWqmHr72dzqMzxog5X5ziXbmN
	 fXncLL7O89PPHuccmSvDF6IutEG1BMlNtzJv5mzszHS/JLBJtjeodcuI20GPcZ7Nzx
	 Xmo41NQzcaIpw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v3 00/15] mm/shmem: various (urgent?) fixes
Date: Wed, 28 Oct 2026 10:54:58 +0100
Message-Id: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAHPG4WoC/1WNQQ6CMBBFr0K6tmY6hBZceQ9jTCkDVAVMi0RDu
 LstxkSWL/Pfm5l5cpY8OyQzczRZb4c+QLpLmGl13xC3VWCGgFIAZry2L/IX33bUcVQ5KlGUIgV
 iwXg4Ws9BOJ2/7J/llcwYE3HRWj8O7r2+m0Tc/cpyU54EB64gRZBVVmswxxu5nu77wTUspif8l
 9VWxiDnUgMUGWpTFht5WZYPf46i+fYAAAA=
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
 "Pratyush Yadav (Google)" <pratyush@kernel.org>, 
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2356; i=david@kernel.org;
 h=from:subject:message-id; bh=QKWfbKNTmEUQgDJxMmiHWqIlTxwF0L7tqAj1iugtr3c=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHitX5vxxjbn98MT4SZ/U/rgYd3Umz5A7kLnmyso17
 xgWrteb31HKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBE/JUZ/qnMkuP4+etE9Zmk
 7pnM3M3aZ5e8l9T+s+TKId42p+g9tU8ZGbYo8d9KvOM4j5O3YcHWxX9//o+6L1PxQ1DSxOHSPR4
 BWz4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

see v1 for details. TL;DR various fixes.

Rebased on top of latest mm-stable. The dropped fix is now included
again :)

Thanks everyone for the fast review and tests!

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v3:
- Rebased on mm-stable
 - Fixup for shmem_set_acl() no longer required
- Re-include the commit I dropped by accident
- Apply tags
- Link to v2: https://patch.msgid.link/20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org

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

Josef Bacik (3):
      tmpfs: keep the quota soft limits of an unused id
      tmpfs: preserve explicitly disabled quota limits
      mm/shmem: hold off eviction in shmem_writeout()

 fs/hugetlbfs/inode.c  |   8 +++
 include/linux/memfd.h |   9 +++
 mm/mempolicy.c        |   4 +-
 mm/shmem.c            | 168 ++++++++++++++++++++++++++++++++++----------------
 mm/shmem_quota.c      |  28 +++++----
 5 files changed, 149 insertions(+), 68 deletions(-)

---

base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d

change-id: 20261025-fixes_shmem-2782719b130e

--

Cheers,

David

