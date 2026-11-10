Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322157;
	b=Yhz94+h3Zw+QZeAQnCCLohoyhaqkeFSHljYZ0G0lGCubkKUlsG6hDHNuFvPos18k62q5
	 Os5eQ3auMuLtWgmvu1oo/jpT6wI/CcUSZ80QM9/59N4kUpeKXxjeMRBBkHLd3wELwW8I5
	 e/ZW0crCulVyOYaosaem2MQCiyG2nipyp+cm3I0Fwum784t/fx040BRf742VJhgC9GrkY
	 8qrCvfQmrur4MHjX31BtUNw4GVrxXWjGl0XiKjkMSJyLUFkj/ha2SXBES0zcPkgIWQtmG
	 xhh3oZjxBlUCgaguLcIQsTxfmv/JoxEO0ldJNP84rjVaF92rfI7CTLU3NFyf55KvrGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=84RV/Xuoq+yXFxOtAqaQ/uL/8VLRu/Yff0GYOZx8MUM=;
	b=sRWAPcn1QoavRtd9uBBJrqtIHQ5m7mRmTuBxuT2wM74nFcLJma5ybmMj1Mv5mfALs3uB
	 PMHzzvaTNpd0BqrG8FYKlSDrmlKpDbLac++U6/MvdyXPu7Szwwi42lVCaY3t5MSXrEgnz
	 Y3NgVgIocWOKsdZeJ5WcQx1mkVmw94ug+eon5nyCUxHkTva422rWo9OkS847k9OacmqmN
	 dvkuwvFYgvL3M5Nd0DpTZYqHTyIuAGgp8nBSGMesxrljpDA05wkMOZJTVKwNcqgBVcNhW
	 ljcZnxai65trAJfKogmPhq/hLQQo1ctf0mFrpq3uDwc38USSYR44I4iKHiPRhvxwRMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kA14tyPf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24EB606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kA14tyPf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E6E1F0089F;
	Tue, 10 Nov 2026 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322156;
	bh=84RV/Xuoq+yXFxOtAqaQ/uL/8VLRu/Yff0GYOZx8MUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kA14tyPf/Nir4cwlj1QMuSIg2mNlzcRGdBTtTF52rl5kPa5XYSOHbp8Xc0OFqs8Ep
	 HSZ9SfEomurSIs6FqJmpZRXM1q47UCDBNT/z6N8UfSKVhXdPAQfJsJvPyMC4eQJ67L
	 m85eVSSeeLbcA3K6PQP6q4qSim8uGjMwR9pP/qSKEaO6WG9QTHrpPJfaMFzhWaZnhr
	 yEOXnBtdZHn4dcM38/KQyYjl0tiSlWKXLoqgTUKrsW8wEI2NxSXYOTxDlR3GY9q56A
	 YGkD5czMrhI6P/nlgBxKPjoUOXObqo/IB5EGr+1p/cco5vOoDiG1yqwbYrEwaRT3fN
	 WmSTKbcDbWHNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/madvise: use folio_trylock() in the cold/pageout PMD split
Date: Tue, 10 Nov 2026 09:49:14 -0500
Message-ID: <20261110144854.1987722-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062130-failed-5.10-5a6c9cf117fc@kernel.org>
References: <20261107062130-failed-5.10-5a6c9cf117fc@kernel.org>
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

From: Gregory Price <gourry@gourry.net>

[ Upstream commit 5a6c9cf117fca3c38a98fb2a2d5549795c8b0b73 ]

MADV_COLD or MADV_PAGEOUT over part of a PMD splits the THP in
madvise_cold_or_pageout_pte_range().  Two threads doing that to the same
THP create spurious failures.

  CPU0                          CPU1
  ----                          ----
  folio_get()
  spin_unlock(ptl)
  folio_lock()
                                folio_get()
                                spin_unlock(ptl)
                                folio_lock()  <- blocks, keeps its ref
  split_folio()
    folio_expected_ref_count(folio) != folio_ref_count(folio) - 1
    -EAGAIN

CPU1 cannot drop its reference until it gets the lock CPU0 holds, so
CPU0's split always fails.  folio_trylock() makes CPU1 leave without ever
taking a reference.  The PTE branch of this same function already does
this, as do madvise_free_pte_range() and madvise_free_huge_pmd().

Reproducer: 400 rounds of eight threads calling MADV_COLD on half of each
of eight THPs, re-formed with MADV_COLLAPSE between rounds.  From
/proc/vmstat:

                     thp_split_page   thp_split_page_failed
    before                     3186                     860
    after                      3200                       0

The short before count is rounds where every thread failed and the advice
was dropped for that THP entirely.

On failure the walker returns 0 and nothing retries.  The PMD path becomes
best effort when the folio lock is held elsewhere - same as the PTE path.

Link: https://lore.kernel.org/20260912110540.3203010-1-gourry@gourry.net
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: replaced folio_trylock(folio) with trylock_page(page) to match the page-based API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8b6ed35c1d265..75ca4cfa48b6c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -349,9 +349,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (next - addr != HPAGE_PMD_SIZE) {
 			int err;
 
+			if (!trylock_page(page))
+				goto huge_unlock;
 			get_page(page);
 			spin_unlock(ptl);
-			lock_page(page);
 			err = split_huge_page(page);
 			unlock_page(page);
 			put_page(page);
-- 
2.53.0

