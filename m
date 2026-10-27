Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793060530;
	b=4Gc6Xw2OE0RQp9T+jODx5Zw+ZTsIdakks/lpWdFpgB8NmVPmL/v8bB1y9UdBzBgaHYOh
	 LZzGJu4ggiWgxTm1wHdml7PYmHN23mSb1wpIZvr9N/PG97ZBXFxzF6YbibBMlI3vmF0f9
	 uj4RGgSWDdzsJK5Io6BxFonq7Lfk1YDHtivYu+T6e7peKN3MyIkrsEOwofyIULhgnyd+P
	 C3sLI698ZN3SED45c5TOljAAdYKa0pU7S9AnJdj9UqeFFjGX/tmSELYnbHq5hWqZX4jwE
	 owCSIny+7tCqdM9FlWJfbl5/AeIMGehEYik++g2AjbE+gJz8gXXD7OZy+wCkKA+vVnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060530;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dj9hHvxNkjYtSpXBGFtHGe77J7NemQ/gBsneJ2zk6X0=;
	b=pYXtMNaN8dhlKuBNwm46bcKcitJhWCh6TwkEoqSTw7es0/We2w+mdZmxmNpe5vt3w1LD
	 lFLComRRh9WSeLMm4tqy/FZDelpDVcxsulM9F4HegNj2HyxLQ7/GwF8A5hCY/fKJpy9aE
	 N7rj2cFbWN4vWn8GI3VJCvzt1Sa38sZs4eieWva1W7WGC4AdAqxfa+eajpGOslM/o4gsK
	 LADMxOtUxSU5GAFzBKyU29ILA4p8xAKDUGT5CUdSaTAyRznFMXQO50HHx15GU9w+/ay7K
	 u1U4N4ZGJwa+MfleS9U+40lIcoulpMfMcrjl7E+3KJZvdlRMy9FxHY1WaSMeMNxeLlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQuEHoOJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20094606A31B;
	Tue, 27 Oct 2026 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQuEHoOJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793060529;
	b=pmXLRoKJk4Kcxsjch1bsOP3li4OGc2B6mEUbuujizWc7Z/bI00ISOMRZh/+q0iQqVyyA
	 vxByluNHRT7+0cUIknvAVJV4vky0Navu4MdPeIViS5QZ0cdfVJxu+hUrC6lK11RVZg91A
	 00jSFfnDwSQFrLnVUfSS89PUDQR+tVuMCz5mJ0vcdXw1CVGXg8INXLFvdxjmHHkEnzkqa
	 dxS3VUxBamA/UBaDDaxdvPEAbxMOXhNYHhwK4c338l8dfbT6mqTov06ruJFzCdGo1LOEY
	 GWaOnHuCfsnEvcJbMlv1Vmn0V9LVA/iM7YXZV1D1aT6/Blx+fwX6UFVU7xA93glR1ZA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793060529;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dj9hHvxNkjYtSpXBGFtHGe77J7NemQ/gBsneJ2zk6X0=;
	b=r2zGGJngxToUVKuCrn+e1WUoQRqtjoopoYnqgqBBrKmesG1P+WTN688GFJ3y+V48bany
	 +MGdEPXZnyOtLzcJNYBTB3Valeom2wiow8ZVEeyzCuM6SHTgzg60GRVf3ol8GedhKpd/7
	 5uqTz03t7uEPccVp1qdLFstz+EVzXDtPQR6QFI2jwyv215jC25n//mlFV1PTFerhgy0Li
	 gxPcK8Fy6+Ci+JwR5FPuuDQ1y1pT1D5XOGZWd0XmAphroqstllQ7gxog6Dyc5FVme/ywp
	 4kOJMSMK6QL0lFTHVydnOw4Pm8uIw0a/gZcHDUkVImqAPL9/Mpqyit9kG/gMuf6sAOg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1072B1F01825;
	Tue, 27 Oct 2026 00:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060529;
	bh=dj9hHvxNkjYtSpXBGFtHGe77J7NemQ/gBsneJ2zk6X0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=EQuEHoOJrBTqeJZYoBji7j6QC5XEFymna965i+o404L2Qb2A9oRxyfQ+W51PF1vTi
	 Y3QAyGUfxAXO/4eKghKFs9fPdXDji9Or3cpplzhg5EV+UjhQ6QVUVSHed6gICpFuPQ
	 eibpUHDjT+rWrvJ7ClIvd2Y2qOffRu/wIwhFMGGJp45J3dcmSPOTM8nY2lhFLLyeZC
	 RX8k6DowEEpv3Rdbu71Hw8olMtQS3v3tg38HhRQ/rDq03NKlKjMdcXjtBhuwudN8X/
	 ngEVQcJxgoRZALvX4wkMThPvtZCwtQC09E7OAtwCzAawmR6ZQkKWJiKpqDDKvpnTvl
	 tExzOMUqh1YWg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9485F44EFB;
	Tue, 27 Oct 2026 00:22:08 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Mon, 26 Oct 2026 20:22:08 -0400
Subject: [PATCH] mm/huge_memory: fix deferred split list corruption on
 partial unmap
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
Message-Id: <20261026-thpsplit-careful-v1-1-d357d70fd6f4@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM3QpAQBBGX0Vzbcuun+RV5II1GIltZ0nJuxtcf
 Bfnq3MuYPSEDFV0gceDmLZVQMcR2KldR1TUC4NJTKFlKkyO3UJB2dbjsC8q6U1m0zQ3pUYQzcl
 N55esm59572a04e3AfT9m52FudAAAAA==
X-Change-ID: 20261026-thpsplit-careful-0d24c335281e
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793060528; l=3512;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=pha4OdGyQ4NhPNP6DwAJZ4oCpNywbxpPmtNX7GrzxYg=;
 b=7VLNDgQ+nZmJUOOibAGbpRr7p9F168Ou6+p4nEc/G93b4pqw8pWPnPlMgvVFQTGz6iyrewo/L
 4GdrnZhQHbvD4bFiU5sRRUQ/3dA35CBBwyWMP1eXYox+kR2PP+Myazg
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

When a THP is partially unmapped while the deferred split shrinker is
scanning it, the deferred split list can end up corrupted.  With
CONFIG_DEBUG_LIST, freeing the folio later reports:

  [  523.871401] list_del corruption. prev->next should be ffd40000005e0090, but was ffd4000000500090. (prev=ffd40000005e0090)
  [  523.871412] WARNING: lib/list_debug.c:62 at __list_del_entry_valid_or_report+0x177/0x220, CPU#0: thpsplit/63
  ...
  [  523.900715] Call Trace:
  [  523.901753]  __list_lru_del+0x5f/0x220
  [  523.902588]  __folio_unqueue_deferred_split+0x238/0x520
  ...

Without CONFIG_DEBUG_LIST, the list is left pointing at the folio
after it has been freed.

Since commit fafaeceb89a5 ("mm: switch deferred split shrinker to
list_lru"), deferred_split_scan() moves the folios it scans onto a
private list under the list_lru lock, drops the lock, and then removes
each folio from that list with list_del_init(), which sets
entry->next = entry and then entry->prev = entry.  Another task may
in the meantime partially unmap the same folio and call
deferred_split_folio(), which queues it only if list_empty() reports
it as not queued, and list_empty() reads only entry->next.  If that
happens between the two stores, the folio is queued again, and the
store to entry->prev that follows breaks the new link:

  Task A (shrinker)                     Task B (partial unmap)
  -----------------                     ----------------------
  list_del_init(entry)
    entry->next = entry
                                        deferred_split_folio()
                                          list_empty(entry) is true
                                          list_add_tail(entry)
    entry->prev = entry
    /* overwrites the prev link that
       list_add_tail() just set */

Use list_del_init_careful() instead.  It sets entry->prev first and
then entry->next with smp_store_release(), so once list_empty() sees
the entry as empty, the shrinker has finished writing to it.

The reproducer repeatedly faults in THPs and partially unmaps them
while the deferred split shrinker, run through
/proc/sys/vm/drop_caches on the same CPU, is scanning them.  This bug
was found and replayed using a deterministic hypervisor currently
under development, but the non-deterministic C reproducer can
typically trigger it in the 10-500s time range.  With the fix, nothing
is triggered after 1800 seconds.

Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Reproducer: https://github.com/manitofigh/thpsplit-repro/blob/main/thpsplit.c
---
 mm/huge_memory.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e5d68acf62a..f4f7d757a310 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4668,7 +4668,11 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		bool did_split = false;
 		bool underused = false;
 
-		list_del_init(&folio->_deferred_list);
+		/*
+		 * deferred_split_folio() may queue the folio again as soon as
+		 * list_empty() in __list_lru_add() sees it empty.
+		 */
+		list_del_init_careful(&folio->_deferred_list);
 
 		if (!folio_test_partially_mapped(folio)) {
 			/*

---
base-commit: e9011a65d78258901ba123c5f522bef26d29902f
change-id: 20261026-thpsplit-careful-0d24c335281e

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


