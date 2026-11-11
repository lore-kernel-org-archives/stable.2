Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417688;
	b=pV0ZIyqWRX2pyG3+L4By22P4K1Py5lnudz2hfS/2kWkZVBkXEgoJmqPkJ/gZWjbMw3Jm
	 vTMyZB4NBMPVgAmr6mkhaNnpoLqJe7xMJsF0P2Pq05aHm+w8bAqNQQLvouHZgBpLPWItX
	 3vp831uAnx1SpXTf2cgsGQB0YijGaTJAqptZURHVXzODa29xemT2/67BgNF7hL2ZZ8x1x
	 VF4DwJ2vImrpeKiwgEnKRFGmfzRQ9ck4X3q4ed3DnQrvlMMgpuedNGh2ejQybeM2tCMr2
	 fTGhwzWE+8xe0MGWQkgaXBHP/Z8BW5QhHxIGAszXDNi0KN+2alWLyFq8cda1Ype9Yuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ENOsAwUgOtjk93lwtX6V7opei7ACxFQvTcMESJMSCZA=;
	b=h1NXRa0PfW8Gvwjhsb2Dn0zKpOdp9GAE+KkhNSRZOBpAZF5PYMBFlx5x3rrJDnePrfIp
	 Exjy/pBWAUxpj/LPb6WtevUHDYXZRkqn0yXSRuUnZPhS+Zrk8zP8katX0/JYnFdpOHxws
	 MAMo1P4BARnde9swH57oOf73YjcpNrIiWyNAyno1bj1TJD3kxVKwFcVq8GN6ccMZcsq4I
	 O68NDcQxri/Aqv6KGFq1iyUNpkKKnE8A81T0ylNl97oczRFleHnxP3BRvoAm51sLIYBF+
	 HjGZtVr+G0QReVmCNgjlMtA3w1wEYsGdcmOEznCIJJQg2p/hoiwsChZN25OyWOFsi7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3750Wmm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB4606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3750Wmm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B351F00A05;
	Wed, 11 Nov 2026 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417687;
	bh=ENOsAwUgOtjk93lwtX6V7opei7ACxFQvTcMESJMSCZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y3750Wmm37UEI3MZ/XtntU57xAiuDWB6n8nb8/q5pCQc9wdcda+lL2ulg3WiNYQI5
	 ygkozT6vqggZ5tqnz2en9iyqHdFdCYRyLPQkHW+JDayqXl9VVbZYsGoeyr36Vci7Qz
	 cPbnFGIXJkJ4fBGKRpJ/Wd2fIWMdufplhuYZWRW/5jCcduR9G1fp1LMWUWbfZtyuda
	 Og5oCLb7LEPpksPhkScKHgKfZzvMOACA9xlYTheEuSAy1fhLrJrItscusue5pk6uXn
	 4kCTv7oQapXQfxE3xwTbcKri7PS4czc2zlEKDBMyxSELuizkIQGK5uiulwoyZgE+Xm
	 2orKUQjXbJV8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/madvise: fix data loss from MADV_FREE on a KSM page
Date: Wed, 11 Nov 2026 12:21:25 -0500
Message-ID: <20261111172054.3555823-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201844-failed-6.1-22d043c1da48@kernel.org>
References: <20261109201844-failed-6.1-22d043c1da48@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 22d043c1da48d6c7274f9dd900714b6d58b7b9c6 ]

MADV_FREE can clear the dirty flag of a singly mapped KSM folio. The
folio remains in the stable tree and can gain new mappings without being
dirtied again. Once marked lazyfree, reclaim can discard data that those
mappings still need.

KSM always marks a folio dirty when converting it to a KSM folio in
try_to_merge_one_page(). Marking a folio lazyfree clears PG_swapbacked
but leaves PG_dirty unchanged. Preserving PG_dirty makes reclaim restore
PG_swapbacked instead of discarding the folio. This also protects folios
that were already lazyfree when KSM converted them.

Skip KSM folios before clearing their dirty flag, checking under the
folio lock to serialize with KSM conversion.

Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Xu Xin <xu.xin@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-34-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: adjusted context to match the existing shared-folio dirty-flag comment ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index b271cc1b48edb..4f70ca597a878 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -678,6 +678,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
 			if (!folio_trylock(folio))
 				continue;
+			/*
+			 * KSM folios can gain new mappings at any time, so we must
+			 * not clear their dirty flag.
+			 */
+			if (folio_test_ksm(folio)) {
+				folio_unlock(folio);
+				continue;
+			}
+
 			/*
 			 * If folio is shared with others, we mustn't clear
 			 * the folio's dirty flag.
-- 
2.53.0

