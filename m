Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417417;
	b=IuEI9pPWOQF1gMWDsMJakVVy7QPJBbIAJ7V13M5IJl1dJ31yz/sNegnEpInWGb2b/pTv
	 q3431WMczSKSWG2ESNiUTmQSdO9Yi0ySxkcBH0bxCiEuRQLdvI5D1MSoXmhUU3oMJQj5p
	 xx5j10dHEmIglkRAR1//lDNAfBP8vZpth5FdheN/7wN5JP1MHEhpJaaFZmNNNGqbVl1nT
	 HMbjJ1qc2d4YMeweJkg1KGTx9CXXUJ9aO49YYqi8MNOszf7EDhzTQb04D7M0dAMEyZrf0
	 FCQKVgBhBzDIlzbKBjaKOTSZAhvRO/EOaKkfTygx5K3uBqXOVBA9HZZ/hZLt+x5NEGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417417;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=haIcw2YpBt4Ff6R3Olp6+WvHy0jtAzVPVFQ/TW3VJEA=;
	b=kuaBBvTFRaagygBBxOR/hK3LiUTzHigsOm/yArcTsT3s6MTDLEBLRw7zyvosqHBmzI7m
	 Xz29G8IaXmfnNHpfxRykpkXbq2ow7foQTrmGU5+1akxk8ucHaWwazEAk/q6jYkrO0ctYW
	 FOrWov/tmCjGS6MH9sMfkQ8gBd20As9ewWDyY5KmQPkZ7ODsri0OlCWsM23PkUSwvqlLE
	 oAlCP50X/l6OJKF4AX1lYJvN67GTTR637WgKJl3LPao3Qg6j9ahH46vbyFfWwFRkB4YFw
	 6O4mMjoibmG5KIUakoCxUCdMTFUxvkAGcDKyX7u2vQdx6nGMnxOiC0b6czIZgy31Iag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAC9Sj7c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84BC606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAC9Sj7c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E371F00A05;
	Wed, 11 Nov 2026 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417416;
	bh=haIcw2YpBt4Ff6R3Olp6+WvHy0jtAzVPVFQ/TW3VJEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cAC9Sj7c+6MApM89RmbG+448zrJRXkFZFMR8aBPYL4HYdQpLilnh3guWNAJd3V4ll
	 gbxtx3fyMq+q7V/4mVGxhDsplovemEktuLp8KjUlFZ3L3zeNi+kRkkDOUec+MkyKRa
	 sOXD91kaNCD3Lxowi0d9SZIZsslTCmOtAjRt7Nsirfm3WoN/AAe3E8C6/fG1BiLvn+
	 4gUbuVPRO6iv/a6sJShYelSsVtZaEq2cWLMXo2fueXlavhCKq4vMvnlS3rOo+d5wAs
	 v9aTCt1OudqqhJlOAaTLHvL+/8rx1EKkiKbaeUhgx1oAr6oLymZPUb2CEm9nq6a+fb
	 Nb2EzDHbvbmbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/madvise: fix data loss from MADV_FREE on a KSM page
Date: Wed, 11 Nov 2026 12:16:54 -0500
Message-ID: <20261111171619.3501435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201349-failed-6.6-22d043c1da48@kernel.org>
References: <20261109201349-failed-6.6-22d043c1da48@kernel.org>
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
[ sashal: Adjusted surrounding comment context for the existing single-page folio mapcount check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 209d0cc950139..9640a13699f5d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -710,6 +710,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
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

