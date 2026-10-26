Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007649;
	b=N2VVXICzSLMZUgRBxB+OdXzyq6DWfcgSRTCvm3BUmGeIfqJNk7I2ipSMP1k5pHeXQx+x
	 FKumuZbxwO1Ft1ORo9fQPudg9PDP7g1H6p92qM5zliq8RCr/k6l3byRDXmOdUpGn60s0P
	 iLAQw7Rd6mpHHbAjoNDa+HQFQSfMylPpwyhKSjJgTCvtRiBFCqoEU7tAW24l+6AdZtaQM
	 K6NJGpMcjUgm2rvoCe5QY4zIWzZugc02zBc5X4TUdQxTuK42VCpyhT6KwMLnAYBujTqao
	 BNDn1rwpsSGzo+8+TjGh24+J43eQaPj25cVaifPfw3dpNJNMd1DrPbePJRsltswT8eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007649;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2BjP65a0dju6snpvx5OIcMNe63lU1CrZcjwyc0/9yUs=;
	b=ZIIcuzjdFf7paEeE3Gn3D+S7V2kFbD6kOr9AgvlXWhwuGy00FCmVj7f7u3O1wMnkYWvU
	 INBpM64e42rQxWqoLiLcY3J+tO8tBMKNoibKOSCfOQ4bbF7CCgktawxKSVaVgoy7OQV2L
	 dNNrYNqvKsDpWaul69EV27Lh8lNZb/f5bpBbZvu3HjDAF5CnyQvN4np7uAHK/St1ry8MB
	 UNoR2Y8mGC1XJwOiOpy2r/P5c5bzbHlOno4RwKPSa6CUxpRADB7DPxTVVY8f4OZLYywoU
	 PFD3NvjiWp3rNkM+WAUMEuQeGrs8xEQ0wWTmJEyePFZEEtBVutAiBbtJvmiGt2xRajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jblt39Dj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F9A606A31A;
	Mon, 26 Oct 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jblt39Dj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99C81F01828;
	Mon, 26 Oct 2026 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007648;
	bh=2BjP65a0dju6snpvx5OIcMNe63lU1CrZcjwyc0/9yUs=;
	h=From:Subject:Date:To:Cc;
	b=jblt39DjKjWhCyE2330ECduwS0UxtYU/7n9ZMoQmM00C7NoVq1UENPRqHevUYt394
	 LMhihUwoEFZQiPQznsRmxR/ZCZe2iKHd4ia6ANaY/JzIUavv4BwjpVgX/hSQmf1VGS
	 nXuL337J8he9sx6J8mvdIoFUMT8vLD4EtTHhcXmrOsWvRdybiF8EnWEbU9G7JOSGcm
	 BNBX4DEqPchaadGDXYfPqy70QHZQtR7kBnO3Ae5AHRxKf9wj2ZEd8zaYkkCxxBV9K3
	 flr1fdXYV7b96+jtpKxju3u9cDO2dkuU1Uj5um/QwS4KZLBQdMksmaRx5+uxaqUaxG
	 UaOwvCbUKAysw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 00/16] mm/shmem: various (urgent?) fixes
Date: Mon, 26 Oct 2026 10:40:33 +0100
Message-Id: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIABEg32oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNT3bTMitTi+OKM3NRcXSNzCyNzQ8skQ2ODVCWgjoKiVLA0UEN0LIR
 fXJqUlZpcAjJCqbYWAE47UcJvAAAA
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
 Josef Bacik <josef@toxicpanda.com>, 
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4200; i=david@kernel.org;
 h=from:subject:message-id; bh=2I+jzvosTRnUx4luk06Osx1EmmShNw/DPI/mK6ve0MU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4jmnRLcK1cVtXb5V8EzQTxlJ/L9P6wuWS3hyV/Hu
 aXo3U7FjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACZSOpfhF/OLQzsbA1cu19rJ
 vPWr+6Yo0fOpkX5TzvTny84UFboT5MvwP069749jdd3s5VsCZ+1xOPbi4ObXVydLrhdRF/erL1m
 dzg0A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

the fixing fun continues.

This is a handful of fixes for shmem/tmpfs. I sneaked in a related
hugetlb fix that stalled upstream.

Some of the stuff is more urgent (patch #1, F_SEAL_EXEC, truncation
hangs), others are less urgent but still rather unpleasant.

The majority are fixes from Anthropic that I cleaned up or reworked.
While doing that, I found a bunch of other issues and tried to fix them
somewhat cleanly.

In general, shmem + swap handling is a nightmare. shmem_undo_range() is
such utter garbage it makes me want to cry. I mean, really, WTF did we
end up creating there. Does any expert here have time to clean that up and
make it *actually* maintainable.

The following things are still broken in shmem_undo_range():

(1) Truncate/punch of a single page of a large swap-error marker

We don't split. Consequently, read access afterwards will still fail
instead of returning 0s.

I have a fix to try to split (which can fail), but I don't consider it
that urgent, really. So I'm not including it. Might send it later
separately.

Truncate/punch of a partial page can obviously never do the right thing,
as we cannot poison parts of pages ...

(2) Truncate/punch whole pages within part of a large swap entry

We try to read the entry, but if we are out of memory that might fail.
Consequently, we will not free up swap space and a re-read will not give
us 0s but the previous content.

AI proposed a nasty NOFAIL patch which has too many nasty side effects
IMHO (allowing users to force-read pages and retain them afterwards even
though memory.max would disallow it). This needs a proper thought. Likely,
support for splitting large swap entries (and large folios in the
swapcache, which I recall is under development  by Kairui). But splitting
can fail ...

(3) Truncate/punch of a part of a base-page swap entry

We obviously have to read the page in, in order to 0-out the parts to
discard. That might obviously fail.

Maybe we should install swapin-error markers if swapping during
truncate/punchhole fails, to at least tell user space on later access
that something went wrong? We might affect unrelated data, outside the
requested range, though. Anyhow, these are long standing issues and
I don't consider them urgent.

They need a proper solution.

I did my best trying to test these fixes. I was able to reproduce some
of the things (including unkillable truncation hangs), and the fixes seemed
to help.

But again, shmem_undo_range() is just an absolute mess.

Please prioritize review of these fixes, I want to get fixes for the
issues in a timely manner upstream.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Chris Mason (5):
      mm/mempolicy: charge shared policy nodes
      mm/shmem: honour F_SEAL_EXEC when an ACL is set
      mm/shmem: avoid moving the truncation start backwards
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
 mm/shmem.c            | 170 +++++++++++++++++++++++++++++++++++---------------
 mm/shmem_quota.c      |  28 +++++----
 5 files changed, 154 insertions(+), 65 deletions(-)

---

base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7

change-id: 20261025-fixes_shmem-2782719b130e

--

Cheers,

David

