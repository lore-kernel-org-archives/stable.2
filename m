Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550943;
	b=IM5nYHa1wforDPx0ZSvoO315D4dNBDt1DAGSbqNebSDup8JQ3trKrAvnF9TxzdMMNJoI
	 9Ah0kRKyGipA5pyu22mfvN1CpbRjwiWJzd8dvs//FjFzSVgTY5MFF8JVkjz6GS1IVhWMR
	 jEdjOt8Ap/KIKB2n4Un9iDsDVAHI6CU3uzusCfrESecKunt/NeI/lDvS6SbbmPCOq1pbH
	 NT+hKynenhBjyaUZusj9RwNk2iWZaqe34Vsf0G/Io5+e1cx4ZVK/AJATAjYIrrmdyCLXk
	 garyoXiX185IXiUL45pykRFBvTk9GLpqHKG1uSHQxw/S8iPYhBuUInYTH/CMX8lx5Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550943;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oDOnhyRF2dgPpheBMRmN5YHLt0WlyIGlIrDFmAPD2tA=;
	b=B5JQySAOdEODpcwV/QRPMGTaaT6KI7enfdBuxXddHbyW0oLmx2HhP5EWD033y/S2Lst7
	 TnTt34vjnnW0KQwkb9ETDwJGxUlgRgAImN9PyQqUgIYu1hR/POeiWeSHHebrE5AsI8Ag3
	 JwPeQwwkDDLJMD0NKWfsIWVXUIx1BXXFeH24B0DBQmM+y/0ipEcpFgKaiQp1i4A8CO3v3
	 Y1KJIZfiqj8eiuGv3Yyi3ufXU9G16IHu9wJ+A6s2KARbZoqEE+5Xy02u9elW1LenDmG1S
	 sgNDEw2iUL2HPbjMLLnTOp0lUzi8c+8UDIVTlR6hITWfs710mXeRHbNxOg6Vgu8ZvbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTqBzwMQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBC606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTqBzwMQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984F41F000C0;
	Tue, 24 Nov 2026 20:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795550943;
	bh=oDOnhyRF2dgPpheBMRmN5YHLt0WlyIGlIrDFmAPD2tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TTqBzwMQ76y7e7SCt1f3PwfnUJjO8/RLBp/Zgs58NENVuPxpf6QGxk7U3cLs4wTG9
	 DApOaSonIPJqa7SgUAtH9OC/3QTQkhuRIKRACnOOn5u4A5gN+lNEDLXVDhBhdxBc56
	 JYTUyEFac3LQZO9vW+jNT4nLowqRWXp4Gm1q82E+PKTqh40GLVnbMEOEl28rxdPRqO
	 hknz/xkZftI/V71Nnfe8V35aTuzQmgg/n95Mcomc2A7vrvXTJtzmuRaZN4qSp9OBK2
	 SCZNQLKK3Bo1YNN028iLHbCfdgn0IZyC+nJafbRv78goP14eKroKj+nvJXsn3SMOHY
	 FkUZqbUUdKqpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] mm: page_isolation: do not take slab pages for free
Date: Tue, 24 Nov 2026 15:08:55 -0500
Message-ID: <20261124200755.2539343-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124200755.2539343-1-sashal@kernel.org>
References: <2026112414-subtract-calculus-aa18@gregkh>
 <20261124200755.2539343-1-sashal@kernel.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 213268869301f747d19ca00a391757a6cf2d4fa8 ]

page_is_unmovable() regards a page with a reference count of zero as free
or about to be freed. Since slab allocates frozen pages, they will
be wrongly considered to be freed if order 0 (higher-order compound
pages are caught earlier).

If such slabs are the only unmovable pages of a memory block, memory
offlining now isolates the block, this can lead to offline_pages()
looping without progress.

Thus detect the slab pages as removable to return -EBUSY, as would
happen before commit 9aec2fb0fd5e ("slab: allocate frozen pages").

Fixes: 9aec2fb0fd5e ("slab: allocate frozen pages")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://patch.msgid.link/20261103-pgalloc-ai-hotfixes-v2-3-e0d2890ab74f@kernel.org
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory_hotplug.c | 7 +++++++
 mm/page_isolation.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e62c196dfdfb8..1f29e1a64d181 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1799,6 +1799,13 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		if (PageOffline(page) && page_count(page))
 			return -EBUSY;
 
+		/*
+		 * A page that was allocated, but was not a slab page yet, when
+		 * its pageblock was isolated.
+		 */
+		if (PageSlab(page))
+			return -EBUSY;
+
 		folio = page_folio(page);
 		if (!folio_test_hugetlb(folio))
 			continue;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 7a32350eb8c2d..63c29a5527486 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -66,6 +66,13 @@ bool page_is_unmovable(struct zone *zone, struct page *page,
 		return false;
 	}
 
+	/*
+	 * Slab pages are frozen: do not take their reference count of zero
+	 * for that of a free page.
+	 */
+	if (PageSlab(page))
+		return true;
+
 	/*
 	 * We can't use page_count without pin a page
 	 * because another CPU can free compound page.
-- 
2.53.0

