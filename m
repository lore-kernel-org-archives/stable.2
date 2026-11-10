Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321528;
	b=mQaN4goJ60bGsykHBaQkcOUgR+O6vAzXa4NiedHzEdbKRuJK2m4YI6/MoWhg51jLegvr
	 R04Y6e64e+0cUIMoSbfLLMIO7A7AaKSZtc+VC2yRIEsqNQnzZuDLba+0evK4fSAr1x4wh
	 lsi0ROn81jy0v3KS/NqP2z0cwiq9bqtquyQhlmfKah0a61UgYO4HiN/rSqT3/26vXOYDd
	 Qgehvb+TNRvWWk0FtJtCrbcSsZAljG5uisjKaO5pXWQcKFSlunl0UwthtKiOyI0Yw605Q
	 ZX7eSvl/uLnY/+NJ5gH9xD6GVyD/FqiCCKAP8Hw4p/XLvbD+11lrZM1TEky66hS/Ybg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1Knk36yZhI2xqCRFuxG/HrJI/vFuGxYU+fBLTWpHiIw=;
	b=loUsqLiknOG401QnOPc7Rov+rJyWj87FhT64iv/krya+1dVtUABEipVf7NJzb+kgD3B+
	 hTcdsv9tguvn+hUOjczOg8TKru2oLPmVYpED92b3kmVsBDsbB6aKRZtpr5ivWQoSolLix
	 SC8Fz+icrf/5t08iSLWBZHSQHoNsa2IoZw5um05jDrHVrKlO6om114SW8Iv1D69EU+9dr
	 ANgNdT3BSZooWM5ocr/4NhGaLkWD7myJlF2VRWfqL26u+lcA+v8ysCfufj/LRsB+ix+W1
	 DpooWhHkPB0fEh7k6kijiuIBkGBeMQfs1w2HA1AwsCAPhlTFPzE+k+r+q6SH5nW1kVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAJ5wGGB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7363A60A2636
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAJ5wGGB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F88D1F0089F;
	Tue, 10 Nov 2026 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321528;
	bh=1Knk36yZhI2xqCRFuxG/HrJI/vFuGxYU+fBLTWpHiIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAJ5wGGBJyd6HXe2WuCmznGCy6Ni4fqxASnAOkiamUMkOozmnWNwIaqnWeew9T1cL
	 Ctal5hNhoWEUc3R2r/Hh/oZAW9kiqnMKTs0K8A8pCXtzH2qXjHSnOnhW0bFJ621vaC
	 kUJQj+poVkEaFn5jJYH8bemaRcpO5/DBmZBs9opigmAaPkeV9pvC3GFrG3QQ4WTkuw
	 rg4Uxjv+aR+wbWm+d28hs9IQacaQbQGSX5MF/cHvhdEBMSdoGzZal9Z67eYPLL21a9
	 pIE2SSMKtL3JSUntt0Ht3SCcYnuvadHXQ7AIkwIMh3xiABNERYg3+RTbbrwyrdNO+0
	 B24hBpaJjM/+Q==
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
Subject: [PATCH 6.1.y] mm/madvise: use folio_trylock() in the cold/pageout PMD split
Date: Tue, 10 Nov 2026 09:38:45 -0500
Message-ID: <20261110143813.1915202-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054718-failed-6.1-5a6c9cf117fc@kernel.org>
References: <20261107054718-failed-6.1-5a6c9cf117fc@kernel.org>
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
[ sashal: Replaced folio_trylock(folio) with trylock_page(page) to match the existing struct page code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b271cc1b48edb..ad5e3f63e8a45 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -367,9 +367,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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

