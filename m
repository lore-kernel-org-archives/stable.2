Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048440;
	b=hMUbQZggGP5Y7iX3Okzbx/Boi1KffbTELRvvtMnLLrJGpXL0edLZkoOz741IIKbhDScu
	 6AczThCvVAgguWdyyo+oT1KqEJ59ZPMkkfRsaGzmv1VORdzzpd0Akrrt26AvudwkPFINQ
	 tjWEUWVGTCdOXBE7vWwfboU3UB31YPptnKmZCPl5d0z/shUi/yVWBQKfA7JtzTCef0JLi
	 iciqntG5T3loLUs7S+qw19cen+EKC994NL9ETlu/RxeQzV1m3QE5Kb0MC6aea3oxFej/Y
	 ySwImK38a+R5XYoMcN5AlYdp/BlQ2I1+SuckdbZ5OJOMqUYGzk2tGN6MXycg7wX2Naw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048440;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=h5nZNxaQ2r44CWaQxUVT3k3vBJkMbsMKH2AXICy7+rE=;
	b=x4YLwJWllJeHcVioillet6V0ivAorxUiZTXM2eZ+YzbH+L1Z0QIDmfCtZQ5fWXEXOChT
	 cNjwFZm9QvR/EFQBaruLJbsRLd0oFCzbesGK7fe0tcEzoBuZ0fvrznYBGsZtqv32PEHer
	 2nuAHxyKQ69AkTe91yrDU0r56y71dHgn6MTygzshq9cB9TPPdGBcu72utPkYIKzWRUMlW
	 5on0wAJGArudWGfAS9+ZUJTsOzpUGB+fvQ/N8v91e6o75LC3loeEUe7VnialGOw2e/rZ4
	 Cz3UfkNmOkeHoOACZNVU3HOLTxqnjLSgIbRN1ASQpfGrRpQz7vWP0sAa5hJcTbJSvnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VldjoTXw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A15606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VldjoTXw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820961F008A2;
	Sat,  7 Nov 2026 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048440;
	bh=h5nZNxaQ2r44CWaQxUVT3k3vBJkMbsMKH2AXICy7+rE=;
	h=From:To:Cc:Subject:Date;
	b=VldjoTXwAcQkNVdGiDqTArMKu7+Ivmd4GUsvLhi7s+kl1a/rrPvbFxhq1Z8cuuhSM
	 E9x9GPcRYi516iF/6+FuESZZsNXdEnq5wCVOK7+ce4HDc8+pvv6umYqagFkFjoVFyj
	 XjPHI44ss2SOg1Fb4pEEQplcanAdXqRiZZajDE2rjgk2nvvxXvjPcn3PikJES+UsUo
	 qgtpiqtgUviWV2R/SQCZ1lBo91toNbm/tjh4C++cd41dzSMzJ02JJDbJu+iycRRZgn
	 q2Z7jAD6051T0wbg3P2KQtLsFFkkPqoTx1/DjsrYBB1k+1gAfg83itgGXmokXI1+e2
	 eAN6s95yuMBYQ==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	akpm@linux-foundation.org,
	sashiko-bot@kernel.org,
	ljs@kernel.org,
	david@kernel.org,
	jannh@google.com,
	liam@infradead.org,
	vbabka@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/madvise: use folio_trylock() in the cold/pageout PMD split" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:18 -0500
Message-ID: <20261107054718-failed-6.1-5a6c9cf117fc@kernel.org>
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
git cherry-pick -x 5a6c9cf117fca3c38a98fb2a2d5549795c8b0b73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054718-failed-6.1-5a6c9cf117fc@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5a6c9cf117fca3c38a98fb2a2d5549795c8b0b73 Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry@gourry.net>
Date: Sat, 12 Sep 2026 07:05:40 -0400
Subject: [PATCH] mm/madvise: use folio_trylock() in the cold/pageout PMD split

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
---
 mm/madvise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8943ae1811449..bef4de4425f29 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -417,9 +417,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (next - addr != HPAGE_PMD_SIZE) {
 			int err;
 
+			if (!folio_trylock(folio))
+				goto huge_unlock;
 			folio_get(folio);
 			spin_unlock(ptl);
-			folio_lock(folio);
 			err = split_folio(folio);
 			folio_unlock(folio);
 			folio_put(folio);
-- 
2.53.0




