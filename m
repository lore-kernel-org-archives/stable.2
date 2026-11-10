Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321750;
	b=Va92NGnfZnxjrK+WG11MrV7gRD0WcAaAHf5XB+50OpwqBYIVb74TrT7SsTW0Zdkml4vR
	 nMJh+7jsDWnCcW+3K1lOAmS0q6sGdYmeJqSvADAYx+0pP5U8fZwqmZZ4ZM97mLu2Ig9Xx
	 Ub8E93bT1V0mz/QANn1nACS67vWivW0rHZQ3kKl9gxuOOZVwxmvUvJZfuj3gcTpxhn+c9
	 ft4TaXow/HNZEJXD/OW+T6chkjW9/kURBf34lVr9eD9sS8MjAxOI94lo7JaWmwfiSjOYQ
	 XnOWSer0pDSsqnwgTk3Ou5cZSCu65XFxv+42oOOGaeDyyYIE2bCGwOKBGj8PsnCLWwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321750;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sM9HLKX3Z0UV3tFeEA7mM0q1YCjUyph4BTeOLVxBjSo=;
	b=N9Fdyc2kvsW8SX/0tiIHedCvtz2La4Tmjq3wt5fV6YbjqzGZnaBtoU6OS/o22stPeTHE
	 DXZUkeI6JrsSuClAtbYUjnjqDFntNRvI211nFlG55dyzgQrIU9symBQX0Kpa9NdVvw82C
	 T/szT5gz3xBTYp//MQGNpbuAEJu3ejC750xEZ4Blp8Sy0vSbSnGtraEB1OV1q3wJwnbdF
	 ly2K1ru4gZg+3AwTAqqBxLkCdgLA13aYxfWsAGbQpMm/tzyODBAAFI9qIhSfaxYPX8X4j
	 cpGo7N12puLblxOKh0AdOHtRWdxI605vR+3y/CVBJpwP2wNA8aIFtXBL3SvSw/k8zDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aNktsL/P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5492606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNktsL/P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3764A1F0089F;
	Tue, 10 Nov 2026 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321749;
	bh=sM9HLKX3Z0UV3tFeEA7mM0q1YCjUyph4BTeOLVxBjSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aNktsL/Py4329A6HL2LEVINeLDyHt8FvnpRZrADCdagGpP+Sd0q+mbXBWylle9yhT
	 GidBT9TB3HoVO+1Z2yKsy7b/c5ubVZ3+aDsv03obxaXPU/JAuypTlB2AvMxAbPLHPU
	 sHetSjuFdu9LlMlanNmiYwIuQ+2JqW8m3kjXjEPGI9R1nMxOiojdQSy2hWUJx8jrgb
	 x5vhxwB8u+C/lv66HrJvhy58SvJBS2JyAepR/Ms4gi8LZxPFFyxlgTt/fch2xfkvj5
	 mk/Qeda4QoBK86QxdkxbLWXF1yRbIaGBmmEK0i6hT5eLAB1gXB+/qE20rZ4q0zcR4C
	 XT3FAWWoXLG0g==
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
Subject: [PATCH 5.15.y] mm/madvise: use folio_trylock() in the cold/pageout PMD split
Date: Tue, 10 Nov 2026 09:42:26 -0500
Message-ID: <20261110144208.1960054-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060446-failed-5.15-5a6c9cf117fc@kernel.org>
References: <20261107060446-failed-5.15-5a6c9cf117fc@kernel.org>
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
[ sashal: replaced folio_trylock(folio) with trylock_page(page) to match the existing page-based API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 367220e1fe52a..b19ed034e84f4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -351,9 +351,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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

