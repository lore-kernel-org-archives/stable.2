Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79558CA52;
	Mon, 27 Jul 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164572; cv=none; b=E0qUk+7rRwc2t9ahCXp43DhFqJpAfxO4W5VvbsVVrJ/b3Np/Z/XnESHWlxghTIH248ugQ+5iydLwFRpHQ79IFcMkZXbI+KoL5NuDVX+QnOgDNHR4fhtnL9BeYJoNKnYFAGEaKZ2v5x3fDUDAJnbIrxWSp6Cye7vDQiUCdlLudGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164572; c=relaxed/simple;
	bh=gHHdkLvMrlKAf6tMrh3E7+DzjlEHflQFAi2Dm0I1S3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONrpHHBgAdBfNXYMryEInszBPAf3JRLUdpRjaZ2Vt7yOtSh0hhtRT/YVjYpywmeAEw1lz5mzqu0kpBDBXlaoUotcHbLhQgsLurbR56gUXcB5CArZB3rQlD8TxGY7DLZ4+mCHMwL0OndyQZbdDB3cW6u0LGPqnZ9ScWPwxdh+Uck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmTYl/c+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmTYl/c+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E271F000E9;
	Mon, 27 Jul 2026 15:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785164571;
	bh=aFYOBMXp5dKkeO47Qf8glP6qHC1ahmcBq2ODbRBzDG0=;
	h=From:To:Cc:Subject:Date;
	b=gmTYl/c+0ipQFd8NpHTkjpGs4Q/3jQRywWu+9wuxAhCoeM3efP0QblqxX3Af9lGHc
	 Nz2Z0plLNymVkhgTMkuRmp4F2lcLA57ghdR9RPQTw/rI3fEcNsoA3j4Io3hADdCZGL
	 mmUj2tD9ObqEv1R2brKr49durZgrC8VeKVi5e8kyRCt8TQ5Gjnv7Ug48Vn8CgZfewn
	 mxXmgO0bwMZ1SBTljY0/b7avVfA7xXqkM87bkOwsT3NoJ5ZsIdhUmDveKwowaC8VX+
	 NwpmMI6LpHZ+hk2RZgvGv+E4jiZltvM4rqpX1blqfHXzIrkJS4mWWn0H9FXPDSTwvn
	 uInTh38P1hm6Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kho: fix size calculation in kho_preserved_memory_reserve()
Date: Mon, 27 Jul 2026 17:02:39 +0200
Message-ID: <20260727150240.889555-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

kho_preserved_memory_reserve() calculates the size of a preservation by
doing 1 << (order + PAGE_SHIFT). Since the '1' is a 32-bit integer, it
can only be shifted by 31. That is, it will only work for preservations
up to 2 GiB. Larger preservations will trigger undefined behaviour.

While preservations larger than 2 GiB can't be obtained via folios
currently, they can be obtained via kho_preserve_pages().

For example, memblock reserve_mem uses kho_preserve_pages().
Reservations larger than 2 GiB are valid and will trigger this bug if
properly aligned.

Fix it by using 1UL for shifting.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

---
Stable backport note: This patch fixes kho_preserved_memory_reserve(),
which was added by 3f2ad90060f6 ("kho: adopt radix tree for preserved
memory tracking") in v7.1. The bug in older kernels was in
deserialize_bitmap(), which was added by fc33e4b44b27 ("kexec: enable
KHO support for memory preservation") in v6.16.
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 175c08a6e41e..6fad9152387a 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -501,7 +501,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 	struct page *page;
 	u64 sz;
 
-	sz = 1 << (order + PAGE_SHIFT);
+	sz = 1UL << (order + PAGE_SHIFT);
 	page = kho_get_preserved_page(phys, order);
 
 	/* Reserve the memory preserved in KHO in memblock */

base-commit: 5c4a03afcb21783987ffc64562b76ddd5a21b12b
-- 
2.55.0.229.g6434b31f56-goog

