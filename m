Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71F52844D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919050; cv=none; b=Ok7tvi/Kh3K133II1Gfj/V6vhAHzkM31S/YGtEekVVMD8dQ2xg1HOT4IXd7vECbY/5aTzlq9K3xh2b+2AICHZ3gSqx67fWWkqNcn69fu66bZE7X6+pi0jHSmIRVv4i9DWYOpYcrfi689hcxh2ZiYZm0aKGXd/+f+WIOci7lnkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919050; c=relaxed/simple;
	bh=g+GV1ihgpLFnoBy0WqFZEBB8wRI+jxIH7QYyRdPv6i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUtT5kWX0WXIfTf3d8Y5mlBV3hc21jwe6yDpHdAWt4i0/8oi1o1nrsMd+1dzzz1yQHf5f7U1jVBnF0A3HiYw8gXv1qoQBQVeSBsrZbCMs9wxrSVpJ2v4MyFwLJg8zoIb4p4mcqv8Bx4iivRwqlHLsonF8IrDn7CHryrV7T4kFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V07DQowR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TqiwOtq9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V07DQowR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TqiwOtq9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V07DQowR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TqiwOtq9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V07DQowR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TqiwOtq9"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 698D62207D;
	Tue, 13 Oct 2026 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791919046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cF++8BVZVrGiDDS9hC3HiwLK+MpGEhXXJUyNn8U/+AU=;
	b=V07DQowRw5cSNIekSiThhmE+WgeWE/eDexQ8P78wEPnT0yyxHOJ2aIHZm5a10LDz6Cu57R
	+itXNcIuX0y86a7vKSMlb63GwEXhEQ+hQ4KNO3SU3tLfi0juMYgUIShzxmGemBORYMQaNN
	lEQkcnUNAle8wo5majv7PBn9YRN2VPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791919046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cF++8BVZVrGiDDS9hC3HiwLK+MpGEhXXJUyNn8U/+AU=;
	b=TqiwOtq9g9nFfVP4LdR4J1zkbQfORf8raA6WWoihrViO+0tLn2WGj85pwtVMvUiTHk86EU
	ExBbbtKO35IejyDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791919046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cF++8BVZVrGiDDS9hC3HiwLK+MpGEhXXJUyNn8U/+AU=;
	b=V07DQowRw5cSNIekSiThhmE+WgeWE/eDexQ8P78wEPnT0yyxHOJ2aIHZm5a10LDz6Cu57R
	+itXNcIuX0y86a7vKSMlb63GwEXhEQ+hQ4KNO3SU3tLfi0juMYgUIShzxmGemBORYMQaNN
	lEQkcnUNAle8wo5majv7PBn9YRN2VPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791919046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cF++8BVZVrGiDDS9hC3HiwLK+MpGEhXXJUyNn8U/+AU=;
	b=TqiwOtq9g9nFfVP4LdR4J1zkbQfORf8raA6WWoihrViO+0tLn2WGj85pwtVMvUiTHk86EU
	ExBbbtKO35IejyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41DDA134B8;
	Tue, 13 Oct 2026 19:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XkRpA8WDzmpaeAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 13 Oct 2026 19:17:25 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	Pedro Falcato <pfalcato@suse.de>,
	stable@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>
Subject: [PATCH] mm/madvise: atomically clear the young bit on THP MADV_COLD
Date: Tue, 13 Oct 2026 20:17:19 +0100
Message-ID: <20261013191719.95502-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,suse.com,cmpxchg.org,kvack.org,suse.de,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

As-is, madvise_cold_or_pageout_pte_range() discards the hardware young
bit by invalidating the PMD, doing pmd_mkold() and subsequently writing
to the pmd again. However, it does so in a racy manner, looking at a
possibly-stale snapshot. It's entirely possible that a write elsewhere
set the hardware D bit, which this logic now loses.

Fix it by using pmdp_test_and_clear_young(). This is an atomic
modification of the PMD entry, and thus safe against any possible racing
writes. As a (nice) side-effect, this elides one non-required TLB flush
in pmdp_invalidate().

This bug can interact with the swapping system in complicated ways, leading
to data loss. For instance, if a folio is marked lazyfree, but was later
read from, and then MADV_COLD'd while racing a write to that same THP,
dropping the dirty bit may lead to data loss as reclaim/MADV_PAGEOUT drops
the "clean" anon folio:

T0                                T1
================================================================
MADV_FREE(thp)			|
  folio marked lazyfree		|
read(thp)			|
  PMD marked young by hardware	|
				| MADV_COLD(thp)
write(thp)			|   if (pmd_young(pmd)) {
  PMD marked dirty by hardware	|     set(pmdp, pmd_mkold(pmd));
MADV_PAGEOUT/reclaim		|
  dirty bit may or may not be   |
  set				|
    reclaim/pageout may drop    |
    the folio			|

Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
Cc: stable@vger.kernel.org
Reported-by: Samarth Narang <samarth.colleges@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20261011132227.413217-1-samarth.colleges@gmail.com/
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 mm/madvise.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 85ab9bc76e06..19cd3bb4d1b9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -431,10 +431,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		if (!pageout && pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
-
-			set_pmd_at(mm, addr, pmd, orig_pmd);
+			pmdp_test_and_clear_young(vma, addr, pmd);
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		}
 
-- 
2.55.0

