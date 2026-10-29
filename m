Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270628;
	b=2rSmEda94JxiuzZX5IV3r3QSUR8NNLIfPTYDEw3iTKyh8FOfezitagIT5xsi+WSSoo1W
	 j23gGwsJ0pb/jk5Z4uoIjEmtN72iUfAmn4qOHIF8pGEH70L4JN2qq4U9ic61h5dvifcR9
	 ANSYarjCtEugubVSrwlWiIlDN6julaPXueeZdpLumeI/HXnxg2KAY34kjgCJC7GIU1b/h
	 zW7pCAJkc1VnX4Sza8GvE/q1w4XrBkHkXEQJZh59uk+8TVQpRGMjO+GAUTRIK/807uV7n
	 h+ihuLbBczfqH1MbZgEImrkIRbLG8aLqWVWYztVynZyvxGpTCCSKpbKV5zMsuCpRHbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270628;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=v7bl5mathvEsQc0NewEfiW9buRzfycGDuVIoRi3XbeE=;
	b=utIXjPB4RRadYN4Ssk8m59yGER6i4mazYN6gG6o2QEvqzRx9Vuxc/zNkNGEl+hDNkxve
	 EEnav/rx3vMYcFhwpyR1wbsQWC6UNWc7WFDSAMhAR8njVjKveITsvT9HEOZ5IJkXZsA1j
	 ehs9n0+V1Q60eDnpk8Q04aFMFFF03GZ9ev/STcnJ4W7549J/D/ey5x7sWZ6cNOgvoGLM7
	 2DXKCksaKJcqf8qsEkJOu+LiBxNB4QZcbyaJVv8e7+iUOXET2WtyYTlp4NLczOUxvgo88
	 kuTMM0yOYNJNj1eA+VgOCWK4gcuS46AvbgywfE0EtRlq0mtV4bN9bKC3ipyu4WDJFPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6M7nzpp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAAB606A31C;
	Thu, 29 Oct 2026 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6M7nzpp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFD41F01825;
	Thu, 29 Oct 2026 10:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270627;
	bh=v7bl5mathvEsQc0NewEfiW9buRzfycGDuVIoRi3XbeE=;
	h=From:Subject:Date:To:Cc;
	b=h6M7nzppxu1MNzAHPW3TFoBhyXbSLLzhmYpxIyCkGQKBFJp/jQiCQVj6ypCqs2jUf
	 do9Uqc9YlgVQ6ZinxNyg+cRiQAk/D/tbkyY1hYWnQkutwOIaM2Ox6terGh28H0/lbT
	 h8cqIeuqP5iCMfPYOD+q6wMzbo4FEGewrVGHsEZNoGl4SYrTmOIFvQeKhczP2vaaJ4
	 DUevwX44epbNvvIl9Pc9YFfHaHzrj2MJWgfPQcW15LGQlyx/Ubsi9scnM5oMfKe4RR
	 JhPc9ioRgpvSa2YVBOQoQgWeM5PsBmwqL5jjyCaZgxjZGLY+8CUs7MyrnY4jacM2Ik
	 r3qFz5ix7MkyQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v4 00/15] mm/shmem: various (urgent?) fixes
Date: Thu, 29 Oct 2026 11:43:21 +0100
Message-Id: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAEoj42oC/2XNTQ6CMBAF4KuQrq2ZTvl15T2MMW0ZoCpgWiUaw
 90tGBOIy5d535s38+QsebaL3szRYL3tuxDiTcRMo7qauC1DZgiYCsCEV/ZJ/uSbllqOWY6ZKLS
 QQCyIm6P5HMDh+M3+oc9k7tPE1Gisv/fuNb8bxNT7Laer5UFw4BlIhLRMKgVmfyHX0XXbu5pN0
 wMucbbGGHCeKoAiQWV08YflEudrLAOODUmtKix1rFd4HMcPnTe3mDMBAAA=
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
 Balbir Singh <balbirs@nvidia.com>, Josef Bacik <josef@toxicpanda.com>, 
 "Pratyush Yadav (Google)" <pratyush@kernel.org>, 
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3095; i=david@kernel.org;
 h=from:subject:message-id; bh=GpKtRlaQ06LBkExuSjLz4XHKAw3/ZQRf15rGlWX8NMs=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK/uv2d2YXLnL7kzy5YiS1ytZdVzuujJ0zZe5Xxib5
 2cgeVOso5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIm0bWZk6PDafmXB4leuGoeW
 xm4QbkmL151XfTx0so7M1qoZaauDnjP8z5kx5avo28t29nG7uFK219W7KSS+n9V/3+FmW8Vk629
 SHAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

Thanks everyone for the fast review and tests!

I'm planning on picking these myself and routing them through mm-core.

This is a handful of fixes for shmem/tmpfs. I sneaked in a related
hugetlb fix that stalled upstream.

Some of the stuff is more urgent (patch #1, F_SEAL_EXEC, truncation
hangs), others are less urgent but still rather unpleasant.

The majority are fixes from Anthropic that I cleaned up or reworked.
While doing that, I found a bunch of other issues and tried to fix them
somewhat cleanly.

Mote details, including other issues not fixed by this series can be
found in the cover letter of v1.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v4:
- "mm/shmem: honour F_SEAL_EXEC when an ACL is set"
 - #define shmem_set_acl simple_set_acl
- Document remaining race in "mm/shmem: hold off eviction in shmem_writeout()"
- Link to v3: https://patch.msgid.link/20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org

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

