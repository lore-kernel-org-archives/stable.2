Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273439;
	b=GjQaw05fhx13uQ+xpRGZV67sjfQ6UbftHutlQzNJX79QK+9ZixzJ915lFfHA3DeAHgH7
	 egtVmVd2Z3zyBcWOD6ulNH7sR76NaQGdkMl/CJo5c0az51qjDdoigrksCz8Yylqfg/o3D
	 qiAQhmMWGj4nNqv0tN/Q+6EMKlOaUb0yD9zI9SWRhdZkxg9hFuEiNur/gR1KCBaiknKhz
	 G4yUYqv/vXH0VouQ3y4yFrTugIp35KT6Rwsan51ghQwEOL4KbqY9/fhdY2281ysciK4oR
	 Z4qx0lMxSEkq7mrNyV6Oo16BrTz4gcxJdEr0ViH1QSEtdcU/STIyRxMKeO6xKi4+EhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ylZ5tQN3LXstZvqQcfSxXXpmEWG4LqueoPtZaKxRF+0=;
	b=qWTizzx1X9jva+zG8HND38iX81xJ2v0AShzxFsli4m04xFPBXtak7n7xlJVo5P1pTkun
	 mZFg1DspNZMREN1PSu0jvHMdRU1zIF7kCETh+KUaXoeegcwfcWG3c8jIj97tMwMicmJVu
	 h3ej9azNv9rejgi8tcOeyJ/0XTrL6BI5/nNw00pjkf8CWtiCJD6wyQudJzOia+WhYJDnc
	 BLoDmCI/AmAtyHIdmB9B+7r802v2JYxnqE04vMcuHtoPZXJZ1POhgx+doL3ZuVPE8jU+o
	 bzzqBxdZX+Qe7PS8IYigN82AopK6LQIhw5rPFf8WhcU/ncH8scR/nFK/YTzjW2UIw5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtJjYSbV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtJjYSbV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD541F0089F;
	Tue, 10 Nov 2026 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273439;
	bh=ylZ5tQN3LXstZvqQcfSxXXpmEWG4LqueoPtZaKxRF+0=;
	h=From:To:Cc:Subject:Date;
	b=HtJjYSbVJJVfxViycjwj/QWYIF4/dQck9lxX9bv/atPqlBp29dxJXDJXQdNPDNI1G
	 J5aviWksKY0HsjDw8M5t9LRRR2mxLwajVUzzMYYfQHacN6Un+86HAlUle6WyRQwRZb
	 62Rx1M5iMDTUG3M4LejUPG0aFBroApxX3TBvC+YgaiZD4hbd5IcMwdGZV26EWafY6I
	 NZRsDNtOA2KRgv2bfCO1MQykL9AYFQk6EFok2//d1RwX3wCc4lnqEA3VzQhYfVK7hY
	 fzNCkT29IBQH2767Rcn277coS5TysasqHCPlL4FsSc3BKvxgeXEX/uJVk1SJHkKnll
	 i+SF6JNSfxsXQ==
From: Sasha Levin <sashal@kernel.org>
To: dennylin0707@gmail.com,
	akpm@linux-foundation.org,
	sashiko-bot@kernel.org,
	ziy@nvidia.com,
	david@kernel.org,
	catalin.marinas@arm.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	andreyknvl@gmail.com,
	vincenzo.frascino@arm.com,
	odys.yuan@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/migrate: untag addresses when querying page nodes" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:17:16 -0500
Message-ID: <20261109201716-failed-6.1-7d8746d7dc9c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7d8746d7dc9cc4003661011424e5880ea7ae364b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201716-failed-6.1-7d8746d7dc9c@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7d8746d7dc9cc4003661011424e5880ea7ae364b Mon Sep 17 00:00:00 2001
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Mon, 26 Oct 2026 19:53:29 +0000
Subject: [PATCH] mm/migrate: untag addresses when querying page nodes

When move_pages() is used with nodes == NULL, do_pages_stat_array() passes
each page address directly to vma_lookup().  A valid tagged address
therefore fails the VMA lookup and gets -EFAULT in its status entry,
instead of the node reported for the corresponding untagged address.

The tagged address ABI permits these pointers, and the migration path
already removes their tags.  Apply the target mm's untagging rules to the
query path as well, while holding its mmap read lock.

Link: https://lore.kernel.org/20261026195330.46757-1-dennylin0707@gmail.com
Fixes: 057d3389108e ("mm: untag user pointers passed to memory syscalls")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260721183257.706661F000E9@smtp.kernel.org
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <odys.yuan@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7bdcdb57652f8..d649a6cfce6c0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2461,7 +2461,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_lock(mm);
 
 	for (i = 0; i < nr_pages; i++) {
-		unsigned long addr = (unsigned long)(*pages);
+		unsigned long addr = (unsigned long)untagged_addr_remote(mm, *pages);
 		struct vm_area_struct *vma;
 		struct folio_walk fw;
 		struct folio *folio;
-- 
2.53.0




