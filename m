Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554421;
	b=onCjMetoWdHajIVB+tW+pMhxDtAGC5O3jJ3lHIrLVg46tQOVeFupnDQBKB9ymusZWHo6
	 /kvIut2xcwQfsIaMJSQEJGhI1Vj2ns03qKIUNMnMniTe3UlfrKZ8Eum9NOf8bOPccZ3TI
	 e+iFXpELTjvl7pNElN+/gDiqhH8H8ufuP9JXBBWmomAuF/TFQjwOUPZ5hBBJ+vOUtTRCX
	 USKdsEzI9uy1gD7IpL9ZjBrlXY3veAQjGMhdG0cmoWFc0jQaHNAyJON7ChwNnviiWo+LS
	 8rOLnk6c3dYRU9Rohyvx+5oC8d41M19QWVeeW4TBrNpgXSBbg5U0nWPtQrif3ICDT6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VKxmpgMDHT/uolcxlPTDzOdaekZF6FQg9lOmNkefNV4=;
	b=KBWYSo2T5CD2Pe4y8JU7rfKKxHkAqs79XFkpfZp0W7PYsS7fFezSsX4e90hK7uxlab5t
	 1kSj96LuJYgIw72MMDVMWJN492jfHeGcS+zfw6Fnn6bot7sDTt7om1QoYguC8irTuSQzY
	 /byoDFAAk4jwwwcFoZOBEiS2zJBIDCP1wmVk5/UNll/o9TuhDEZasMmaKBWs+nUS2fAqY
	 vl6ptUN3wNHpUc2ZW5mgwZAj4XcHSAbpl2Uq3E2uWaf7As1XWe0LPRYpPs0uDJLROIwd9
	 D7wBDbFH7mSGtagDdkV1FtLV4GqiaufEE13NTwUILrwEWApJuTlXKKNtV+c00traKlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH0eJUMM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F03606A32C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH0eJUMM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E6C1F000CF;
	Tue, 24 Nov 2026 21:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795554421;
	bh=VKxmpgMDHT/uolcxlPTDzOdaekZF6FQg9lOmNkefNV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NH0eJUMM4Akl1bE7r2LPHp7N2IBBBF+TCy8Q+k0nFjnD8N1szbn1KmXwkvrhapk4J
	 iax41FAA186KPhqJPzbQXYpepQrmYYnGw8RQfBeA68OBXz6FN0SubH8cJJ0rzO4OfL
	 Gcl1BQv7jBSxFl3recXBrGsVeUmIdLTaw45LPKE6hUdorAAI47orzQehrF0928E63L
	 +DJPYat5SCW2pOTw/Ud521U29rd01QI1QOsobPWEQiNvSfcgik4K9ovDbk3gs5poPV
	 PaZPgAtLs2KjatUXc0jozasDkGGVk/1wqPvsWN6XuhqYFHH9Rs6w9LX8ytY7RvwVEk
	 VljYL0FQJBu7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qiqi Liu <liuqiqi@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] mm/page_alloc: apply per-task GFP context in bulk allocator
Date: Tue, 24 Nov 2026 16:06:57 -0500
Message-ID: <20261124210614.2758423-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112428-expend-compacter-6b96@gregkh>
References: <2026112428-expend-compacter-6b96@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiqi Liu <liuqiqi@kylinos.cn>

[ Upstream commit 1372648980b8524a5747a2732e90b20d3db10c3c ]

alloc_pages_bulk_noprof() does not call current_gfp_context(), so per-task
scoped allocation constraints (PF_MEMALLOC_NOIO, PF_MEMALLOC_NOFS,
PF_MEMALLOC_PIN) are not applied on the bulk fast path.

By ignoring PF_MEMALLOC_NOIO and PF_MEMALLOC_NOFS, the allocation can
theoretically result in a deadlock.

Ignoring PF_MEMALLOC_PIN also has consequences: without clearing
__GFP_MOVABLE, prepare_alloc_pages() selects MIGRATE_MOVABLE for the PCP
list, and a task with PF_MEMALLOC_PIN set receives movable pages from the
bulk allocator.  Once pinned, these pages can no longer be migrated but
remain in MOVABLE pageblocks, violating the mobility contract.  This can
increase fragmentation and interfere with compaction or contiguous-memory
allocations, eventually surfacing as higher allocation latency or
allocation failures under memory pressure.

Found via review of the bulk allocation tracepoint hooks [1].

Link: https://sashiko.dev/#/patchset/20260907120949.418450-1-liuqiqi%40kylinos.cn
Link: https://lore.kernel.org/all/20260907120949.418450-1-liuqiqi@kylinos.cn/ [1]
Link: https://lore.kernel.org/20260915074928.327471-1-liuqiqi@kylinos.cn
Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
Signed-off-by: Qiqi Liu <liuqiqi@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Stable-dep-of: bcfc8286f0cd ("mm/page_alloc: retry allocations that raced with a zonelist rebuild")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 55232081a32b2..86f4901c4c2f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5262,6 +5262,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
+	gfp = current_gfp_context(gfp);
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
-- 
2.53.0

