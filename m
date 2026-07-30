Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60E4052AD;
	Thu, 30 Jul 2026 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408975; cv=none; b=ra0zYU1ILQ2/feAzANkcCxOxTV3AERhyvOKI7LlJaHR4YXJ8rPS70ULjHk0w3lodWU+iZYxnXZpF+EuZMmsCCvCtInXZOinoM33/RtNzKRG2LuHnEiwjiMXrJtdDsN69pqnamyCFb5LTnlbWd5tuMP6LDrFQ9JylmvZ2un3bP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408975; c=relaxed/simple;
	bh=Tz1wBhT8fjQPH4rplQ3wnVB93b1/+MbegCle+YCQO1M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DfdzKMxLf9s+IeJHfIWaRTjenrY6/o1AvhR4ULpGROf1d/e4V9qPSc8MRjl8bJCE7CKHGx0uMg2ViIsbZpsVnoZdyL59JDEDOJ+ZBu5OdWJt0c9aZCzdLEc79xuGANue6IZP/o+dAFOJjqxzdc9Sjpn8bkrNolPKTEi6DI9pn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNgre85X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNgre85X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B241F00A3A;
	Thu, 30 Jul 2026 10:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785408972;
	bh=wfNj/VIelatDoZfj8ovdI+CcS7FJ5Qn9mwg8mtP50AY=;
	h=From:Subject:Date:To:Cc;
	b=CNgre85XCyrLPGr3zMKNY+S1JueAGUuexUDQ/yvWoDU1hIkQUNo5C9dzfCCP7xgFs
	 T+nYTF+w6QzGv82x6d48oVA0cgkF28FSc/8YZAH52ZBibFiC5S4hWIdqqe5QhwrAS5
	 lP9bagxs6ADmCUagtNA98gLrnmvHTFoAnOFPtXe4godFeMI09RKyGAWKIIdicXViJr
	 W36wFtZ29DB8KW5nxGYcGyC6t449S+m2nUBrQ8sEisW+4/5DnN26fucI/fOluvRgXm
	 Ix7KS+78jAtXC+LgDph0YhHZTTevL1EznD65ocOI3UnqZPCPIO0OraC1WZPyc3ySi2
	 hxe8Kx3om2lYQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH mm-hotfixes v2 0/2] mm/huge_memory: fix huge_zero_pfn race
Date: Thu, 30 Jul 2026 11:55:46 +0100
Message-Id: <20260730-fix-refcounted-huge-zero-v2-0-c5d8a41b317f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALMta2oC/4WOQQ6CMBBFr2Jm7Zi2IBhX3sOwgDKlVWlNWwhKu
 LsFDuDyZd7/f2YI5A0FuB5m8DSaYJxNII4HkLq2HaFpE4NgomCluKAyE3pS0g02Uot6SMqXvEP
 BZcPKJld1RpDi72SZaau+Q9+jdnHnaj+GoXmQjGv5qmsTovOf7ZGRb6H/myNHhpkSBVfnPE/jt
 yd5S6+T8x1Uy7L8ADJNqbngAAAA
X-Change-ID: 20260728-fix-refcounted-huge-zero-21cb07b4fa3e
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
 Hannes Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>, 
 Yang Shi <shy828301@gmail.com>, Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Hengbin Zhang <uqbarz@gmail.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Tz1wBhT8fjQPH4rplQ3wnVB93b1/+MbegCle+YCQO1M=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKydbdfWXSi5spEpktXTDvNpzbZ/xWYbGZovdvyAKNhd
 QLPYkPXjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzkchnDH56FB1fmhl/PMZ53
 /7Zbd3Rrz6Wsqt8Cc39Y3dHIK91+up3hv++2t6vNlzSzRqc/70iftyo6d7fLKz6ZN5L2Xp+1vxX
 IcAIA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

There is a subtle race in the reference-counted huge_zero_folio
implementation.

The fast path atomic logic fails to account for the fact that the
shrinker (which drops the final huge_zero_refcount pin) can overwrite
huge_zero_pfn with the ~0UL sentinel value in shrink_huge_zero_folio_scan()
after a racing get_huge_zero_folio() installed a valid value there.

This results in huge_zero_folio being correctly set but huge_zero_pfn being
set incorrectly and thus is_huge_zero_pfn() and consequently
is_huge_zero_pmd() will misidentify the huge zero folio as being an
ordinary THP folio.

This can result in the huge zero folio being split and otherwise treated
incorrectly.

The solution to this is very subtle as there is an atomic fast path, and
thus ordering in weakly ordered architectures has to be treated very
carefully.

The first commit fixes the issue by introducing a spinlock around
huge_zero_[pfn, folio, refcount] write, with careful consideration paid to
load/store ordering in the fast path. It is placed first and kept as small
as possible so that it can be backported on its own.

The second commit is a pure cleanup which reworks the
CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic to better separate the persistent
logic from the dynamically allocated one.

Andrew - I know you don't like a mix of fix/cleanup, but thought it'd be
easier to keep the 2 together as there's a dependency.

---
v2:
- Reordered the series so the fix now comes first with the
  CONFIG_PERSISTENT_HUGE_ZERO_FOLIO separation following it as a pure
  cleanup as per David.
- Fixed up wording as per David.
- Cleaned up Cc's since dependency of fix on cleanup no longer exists.

v1:
https://patch.msgid.link/20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org

To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
To: "Liam R. Howlett" <liam@infradead.org>
To: Nico Pache <npache@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
To: Dev Jain <dev.jain@arm.com>
To: Barry Song <baohua@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
To: Usama Arif <usama.arif@linux.dev>
To: Pankaj Raghav <p.raghav@samsung.com>
To: Hannes Reinecke <hare@suse.de>
To: Hugh Dickins <hughd@google.com>
To: Yang Shi <shy828301@gmail.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: Hengbin Zhang <uqbarz@gmail.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

---
Lorenzo Stoakes (ARM) (2):
      mm/huge_memory: fix huge_zero_pfn race
      mm/huge_memory: separate out CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic

 mm/huge_memory.c | 189 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 116 insertions(+), 73 deletions(-)
---
base-commit: 5db85e34ec49beee590676d55f13e8e2b14c742f
change-id: 20260728-fix-refcounted-huge-zero-21cb07b4fa3e

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

