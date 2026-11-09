Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190600;
	b=W/J7UXo8j7SIHBpPNzsgnWWNyX3b+ab5xMbSG9TGe+IOD5bMN6q4Cr2CyKDe7ZwZyZrk
	 uFcsySTuKYOqhPjR0qvWo3DMqp5ROs9TuAgHXtVoqu7ZbHWAZ36Kk0HrZAvfjMxgfnR6z
	 PgHtmzrbuZWgQj9ST7e7GMYqC8RfUjanpz6evOZUeUSZ+51RkQCtxCeaJnVCYfd95Yckg
	 48ZPuC//vOT3yv/AwZA0Mzd3zmo9Kl6oNTkiRb+nGZXwOqO389HjLCoZ9HWfrUaQun7M9
	 2v/GPKittR2h5NaF9QsYW7fHCAKPn0BXcN1m9uy9Z9QAM+NFJmlvaBjsvhoHU3Rl6uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190600;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RweQvyw4NIgsuj4dNi7nK06pAit76GUtp9g8kGTqMg4=;
	b=riwbrabiuwuE7JP9CSZhQD+uFvlmbhdlcYvRtI0PqdCo5O1tZHGLTcu5+jVdZSk4Taxb
	 paNszXjsNmKeVCcuQGEfKVAWi2Do7rKsaCf8pHQ/qvKZlGhtINWgtXSsmJ5ZOXhAl800H
	 ck3tBpLWWJRI00G7Y2LsMbJxmAuTYE/e3CRgsiD0L6RgLAT0DWmixeAVaKVGad5wjTvLC
	 njGLLC3+SPaj4paUtXJqYqgHIAMkEEM5XIr5ATcok/nC96+8s4fPJjinwrO5nBokBflHD
	 k48dT6lrCI7Xb70OYIhVpIQrsNhEb8hVS6nvCr6enOvKlmkUUZBMv2VZCc3vzY9XPGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NFDf4TDr;
	arc=none smtp.remote-ip=95.215.58.128
Received: from mta1.migadu.com (out-128.mta1.migadu.com [95.215.58.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F4606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 018F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NFDf4TDr
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0vqFp7/7WWiwnx+Zs/qlGOXEjprolacOHKPupS8KY24=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794190597; v=1; x=1794795397;
 b=NFDf4TDrErNLl4AlkmuT4JnT5cGbRlHkE7spyQDd057yfU25J2+yZEjD/pm9Q9Re9XIoGFJ7
 /dhV8eQb6xW4bTlmN/pH0jzJXtYuPNcQ/Yq+uvEM3TWG+1SZ+g/8h5GDLtpTIkAl28LRRZ9v7u/
 1fo5dm8vfWbISM5pXq+nR9+8=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 3ba9fe655f2ef269;
	Mon, 09 Nov 2026 02:16:36 +0000
X-Mizu-Trace-ID: 3ba9fe655f2ef269
X-Migadu-Flow: FLOW_OUT
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Yu Zhao <yuzhao@google.com>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/mglru: fix a no-op lru_gen_clear_refs() call in lru_lazyfree()
Date: Mon,  9 Nov 2026 10:16:11 +0800
Message-ID: <20261109021611.22247-1-hui.zhu@linux.dev>
X-Mailer: git-send-email 2.43.0
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

From: Hui Zhu <zhuhui@kylinos.cn>

lru_lazyfree() calls lru_gen_clear_refs() after lruvec_del_folio(), but
lru_gen_del_folio() has already cleared LRU_GEN_MASK, so folio_lru_gen()
returns -1 and lru_gen_clear_refs() exits at its "gen < 0" check without
clearing the refs or PG_workingset.

A MADV_FREE folio therefore keeps the state it had before madvise(2),
even though madvise_free_pte_range() has already cleared the accessed and
dirty bits of its PTEs.  lru_gen_folio_seq() places it one generation
younger, and PG_workingset puts it in the last tier, so sort_folio()
promotes and protects it instead of evicting it and charges it to
lrugen->protected[], which read_ctrl_pos() uses to balance anon against
file reclaim.  __folio_inc_gen() clears the refs but not PG_workingset,
so this repeats every time the folio reaches the oldest generation.  If
the folio is redirtied first, ttu_anon_lazyfree_folio() keeps it and
lru_gen_eviction() packs the stale state into the shadow entry, so a
later refault is promoted to the youngest generation.

Call lru_gen_clear_refs() while the folio is still on the generation
list, as deactivate_file_folio() and folio_deactivate() already do.  Its
return value only says whether the folio is in the oldest generation,
which lru_lazyfree() does not need because it re-adds the folio below.
Keep folio_clear_referenced() unconditional: the classic LRU needs it,
and it also covers the folios that lru_gen_clear_refs() skips.

Fixes: cc8ec7be78ff ("mm/mglru: optimize deactivation")
Cc: stable@vger.kernel.org
Suggested-by: Barry Song <baohua@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Reviewed-by: Barry Song <baohua@kernel.org>
---
Changelog:
v3:
Add Cc: stable@vger.kernel.org and pick up Barry's Reviewed-by.
No code change compared to v2.
Per the thread discussion, the __lru_gen_clear_refs() refactor will be
sent as a separate cleanup after this fix lands.
v2:
Call lru_gen_clear_refs() before lruvec_del_folio() instead of
open-coding the flag clears; drop the lru_gen_enabled() branch and
the comment (Barry Song).

 mm/folio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/folio.c b/mm/folio.c
index 35e242b48870b..ea3adb6a89d75 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -597,12 +597,10 @@ static void lru_lazyfree(struct lruvec *lruvec, struct folio *folio)
 	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
 		return;
 
+	lru_gen_clear_refs(folio);
 	lruvec_del_folio(lruvec, folio);
 	folio_clear_active(folio);
-	if (lru_gen_enabled())
-		lru_gen_clear_refs(folio);
-	else
-		folio_clear_referenced(folio);
+	folio_clear_referenced(folio);
 	/*
 	 * Lazyfree folios are clean anonymous folios.  They have
 	 * the swapbacked flag cleared, to distinguish them from normal
-- 
2.43.0

