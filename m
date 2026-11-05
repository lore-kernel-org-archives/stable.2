Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887338;
	b=u02KzNFkmQEaW70BN8cErEqBAAhmcALnpsIdoLvrvDFmb9/TapwgMGCITJ/47eaTtlgh
	 G+J1jATxKOQ0sV/QanqnWFuFFK67Ye54W9ZoFUMIOauKxAIxnLck3Fo08ciYihaP8NB5v
	 ugw3/d+M7AmDjHqe9ZcLdt8BQKFv1ZdG+WMgvaER31ov1ORqoFI2Ggs9oBwsHgDLF5z0Z
	 A4XjcgHZricUy1zii9MvlEoj3gwsM4OZpw4WzXvHIN6EjI7kn3SoRUntuXDf9uhydBC+4
	 3F3f31M6EKpuxDt0hEpEqaAyYK2lYaKTqPjJzLHdPGu/eZpouP5dn5PKelL9DR1MuMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=PQSJiJpchqk+HTdFIjZP8p3fKD0mteZ1GO/SxJAouvM=;
	b=QBAlARNF/TrnYWpILr4wj5teLAiv8pcLMFhgBQFGFrXByVRpZqmftjD3nnCuBqH/HQO/
	 bgqXMEx5Z8bwR0FvEWOXH4N/W6hG7jlDbegPI1sAj39OhWepUl4aTUBr2pTigWJZ7dvi2
	 f8vcpN8BOeOCBxduv7H3HWLRbg2IHBHJTH7/xpcoEEPP+ZPae/xoHofYCC+GxSG+UmTyb
	 nTHsIxDWW+gHs7GYuZux+J2qg8FtZ7LeizEnXSrN7kN7Jod3tppM+bCs3iIPTCyQUG3UP
	 McNpd4++0GPs9xUbO94lG3ZD2CY4FX3P/Q1q8sJ1eVNUdYP6UE1gyT6HMN8qAgGRWng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=f+eIkOsW;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E48606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9E48606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=f+eIkOsW
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab37e44643so15279317b3.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793887337; x=1794492137; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PQSJiJpchqk+HTdFIjZP8p3fKD0mteZ1GO/SxJAouvM=;
        b=f+eIkOsWN+dWSnDM//R+FukjTakRtpTimBvQY03yuSadu9q21E5/G/KK87radJGU4g
         In64D5Xox5pDzCz41PBgXUE+KLEkrHnd6P1Dy5ysbDw7gXGvLxSDY3/zUyI/yWcwwvo1
         3bVoxrqEO/3ksFR/DXBJO9XYVvXLXD8Mh/2UvQO6Z7Sn1g06xRHwPrbgBD2gMViepgSV
         Ve2H971tJgJLklWj+qvz9bOqAostJVboUdsS+wXkZutzVstGTnvp066914s/jM3OWbpM
         Lz+iPS6A2qL/KiAwcyqKPF445D+8HN0nomvJiLZXyLseDKzzuH1TrJU3VnQ0ssGwqs3d
         p/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887337; x=1794492137;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PQSJiJpchqk+HTdFIjZP8p3fKD0mteZ1GO/SxJAouvM=;
        b=nQqTPRAJFtfO6sFYEM3x7r+DskI/gAQ9A5wSSXfQOIiNS2eNlFkuOFKrEPuRSTLKMB
         GKqBC2tHvUdMHyrhboOgFjCC0EddFqs2ZXxSfFbrBNMLJ4WtIXvIK/FbhxgzszN/ujIQ
         cL6ZCYR68VkQ9+nIndP3wlfYEyZqngXnJkdd+qu/d3uF3xA4eWjDRRy9YxWTEBbolC15
         Zp4A8VbX4ZZifd1n8EYDTzW7u41oi/ao7ATudqdsUl6VftbQKBOvvuLI4vrPO455E3gi
         1BG4NQaDRlpp89PlMg4gDKstfI6waWva3R0McQblLVLg1oxxSuFBfzseI34JbHzuCdht
         5lEw==
X-Forwarded-Encrypted: i=1; AKwUvBztJcbKwXPcUOFP9wnF1Kb+YrfsyB2RHVvPCc/s1gZ+mFu6i4vRid4+DCPlsEfIH3hpqYzWzDo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UJl0cN4zTjbmCwqQhqG6bPW3BzvMIb96RFQCdVKDgcDkRPA5d
	ZApobAVJB9p0rdO0B5ovx8OO/z3M3U3uxSSvLfl/zb9+QDeffDLj/fRP1jipU8vDHKU=
X-Gm-Gg: AYBFou0venogo/K1+0NIlW+tAfBIHzrtqtXFSiN7YZRUhG9LqB1/jEitaa+rlEgBasR
	iQ/3sZnZZOhT0kN3aoXNhnyV2yRdFJRo3QwPQgr4CfyjxTTsxtGy2QE7UgFvCIEtqcP9Ju/Cm1L
	qTIY80bVxV7nHCWEwTlr0qnggtTxzy/T2LTAVuu8uHYDqYrb7BUWKAK40NGsFGvmxpcXrmIJarx
	FNi1WOLQKut0PH91sLYZ1L4bubPxYTlJbq/xtbfEo6iOcsYKvBQ4mRbUaqQkocUYPSPaKiErAn2
	wg21trSZvkgVUH1/kNU17D/hCJ5y8932dxzTDod+ATD2gNr0owW5km/7IFB7+HNm2wfGZyzAJRA
	DKjMJjzKLFTfOlaJK1oy97Gb87FunSBJBkwENfJb5nzReixoo75rGySdx+gOrdIU5e5C3YELF9P
	yf/G5v0X9O4mNG+qGluFBsAaPM8ky3CE2HMegnkHUDaLFIqyTk6nKQn8jXg3a+L8WoBggwDazDz
	qf0aM0BtBmAaOQEpGpDV6Fb/H6H5LGIJHnYj1jvK8MPrnOoAhGw/lGTRXLLxqcpjHVeLXDaZIsk
	doJ7SqWHLdUsn71JxAKwireccwgHwa0f5ByrjMZFAZ/HHA==
X-Received: by 2002:a05:690c:a849:10b0:8b0:a432:5686 with SMTP id 00721157ae682-8b2b67214fdmr79094087b3.44.1793887336598;
        Thu, 05 Nov 2026 06:02:16 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3097119ddsm40003327b3.6.2026.11.05.06.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:02:15 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 0/5] mm/mremap: fix accounting on a partial move
Date: Thu, 05 Nov 2026 14:02:02 +0000
Message-Id: <20261105-b4-mremap-pre-split-v3-0-f8789de76849@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIAFuM7GoC/33OywrCMBAF0F+RrB3NpFWrK/9DXCSZ0Ubsg6SWi
 vTfTepCUHF553G4DxHYOw5iN3sIz70LrqljyOYzYUtdnxkcxSyUVGuUmQSTQ+W50i20niG0V9c
 BZjqjVU5rMiTiZ9yc3DCph+Mrh5u5sO0SlS6MDgzG69qWaWTy5TT5lNNp6ULX+PvUsMdE/i/TI
 0iwWKhtgaiZ5L5rBmdbXZNe2KYSqVGv3hBK9RtSESJVIFGEaENf0DiOT1C34h9BAQAA
X-Change-ID: 20261030-b4-mremap-pre-split-13a3d54d6dbd
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Sarthak Sharma <sarthak.sharma@arm.com>, linux-mm@kvack.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793887333; l=4479;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=aJ4VMSpHvihbmSlNtypMOsCf6oE7TKU1O8e1irKxqCw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGmuDQv/aZXhAypoTEZRnTuuqoW3v8gPuyZTdE8bX7hpOJdOvStteV64iSEIrxTBD5rtNr1xReq
 Jl+HReg6o4wA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261030-b4-mremap-pre-split-v1-0-c1829811aed0@toxicpanda.com/
v2: https://lore.kernel.org/all/20261102-b4-mremap-pre-split-v2-0-d281dd11ad7d@toxicpanda.com/

v2->v3:
- Added "What it does now" below, the original email still describes the
  patch that v2 dropped (Andrew).
- Patch 5: ksft_perror() for the mmap() and mremap() failures, no checks on
  the munmap()s in the cleanup (Sarthak).  The tags on it are from before
  this change.
- Fixed the stray blank line before the tags in v2.
- Picked up the tags on all five (Lorenzo, Jose).
- Rebased.

v1->v2:
- Dropped "mm/mremap: split first so a failed split is reported".  Every
  failure now left an unwanted split, for a benefit that only a doomed
  process would see (Lorenzo, Jose).  This is also why the series has a new
  subject.
- Patch 4: added vma_range_set_account() and used it on the success path
  too, shortened the comment, spelled the flag VMA_ACCOUNT_BIT in the subject
  and message (Lorenzo).
- Patch 1: dropped the comment above split_source_stays() (Lorenzo).
- Picked up the tags on patches 1, 2, 3 and 5.

What it does now:

This fixes a hugetlb reservation leak and two Committed_AS bugs in mremap().

If you move part of a private hugetlb mapping we take the reservation map
away from the whole old VMA before the part that's moving is split off, so
the parts that stay never give their reservations back.  The first patch
splits hugetlb VMAs ahead of the move, the way Lorenzo did for the mlock() +
MREMAP_DONTUNMAP case, and it's tagged for stable.  The second is a selftest
for it.

The next two fix the accounting for when the unmap at the end of a move
fails, we either charged memory that was never accounted or lost track of
the charge for the whole VMA.  There's also a test for an old size of 0,
which nothing covered.

Everything that isn't hugetlb still splits at the end of the move, so that
part of the original email below no longer applies.

--- Original email (v1) ---

Hello,

I went through the callers of __split_vma() to see who can't cope with
it failing, and mremap() is the bad one.  If you move part of a VMA we
don't split it until the very end, when we unmap the old range.  By then
the page tables have moved and there's nothing to go back to, so we fix
up the accounting and return success with the old range still mapped.

Lorenzo recently added a way to split ahead of the move for the mlock()
+ MREMAP_DONTUNMAP case.  This series uses that for every move that
unmaps its source, so a split that fails is reported before we've done
anything.

Doing that turned up a real bug in hugetlb.  We take the reservation map
away from the whole old VMA before the part that's moving is split off,
so the parts that stay never give their reservations back.  That fix is
the first patch so it can go to stable by itself, and the second patch
is a selftest for it.

The next two fix the accounting for when the unmap at the end does fail,
we either charged memory that was never accounted or lost track of the
charge for the whole VMA.  That gets a lot harder to hit with the last
patch but it's still possible.  There's also a test for an old size of
0, which nothing covered.

I tested this with the mm selftests and with a loop that fails each
allocation inside mremap() in turn and checks that we either moved or
didn't.  The numbers for moving part of a mapping don't change.  Thanks,

Josef

---
Changes in v3:
- Link to v2: https://patch.msgid.link/20261102-b4-mremap-pre-split-v2-0-d281dd11ad7d@toxicpanda.com

Changes in v2:
- Link to v1: https://patch.msgid.link/20261030-b4-mremap-pre-split-v1-0-c1829811aed0@toxicpanda.com

---
Josef Bacik (5):
      mm/mremap: fix hugetlb reservation leak on partial move
      selftests/mm: test a partial mremap() of hugetlb memory
      mm/mremap: reaccount on unmap failure only if accounted
      mm/mremap: restore VMA_ACCOUNT_BIT if the unmap fails
      selftests/mm: test mremap() with an old size of 0

 mm/mremap.c                                 | 69 ++++++++++++++++-------------
 tools/testing/selftests/mm/hugetlb-mremap.c | 52 +++++++++++++++++++++-
 tools/testing/selftests/mm/mremap_test.c    | 51 ++++++++++++++++++++-
 3 files changed, 138 insertions(+), 34 deletions(-)
---
base-commit: a13b500946e5dc467976838572b8ddd2fd777ca7
change-id: 20261030-b4-mremap-pre-split-13a3d54d6dbd

