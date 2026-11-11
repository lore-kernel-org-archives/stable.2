Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418462;
	b=X4wGjR0R9pggXjjdBhDRQn6KM2J9PJt3SWYMU4IlkEuTBODmRBKCifE9guNfYrhp6bLF
	 9NjhDG7NnSE39DsToMIap3P7HVHYoOmm2MOy59sXPdpWFL7jSQ6Zm0gjGwsZjJ+6Dnz6D
	 p7gOJCvRVmw6mJlejjmXTGSW0Mo5vIyMGDlafbe48Ym/Wbqq/2ccpn2qHPzK+am47NYDB
	 warkFJdhhEHQdZEh+CZkrC1Gl4xcUCJZBc3bEinmiOtAx6S0W1DmFvo62fi4Sz/gphbC+
	 EdyaEfdG7ervbvldnq6GHOVAD9NVKNkvkNec3aS5eFgiLITpjCI1JWiOD5XBzd2WxCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418462;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IsQz5Kf689Ov2wwRsR+lh5lwodSQ22klEnCbElQKuOs=;
	b=X8HvxNvnR9gzm1PUQJV+AT30Dv7CNx6irYrlBmW3EQY3Kxf5FJ16LXwxbh7QBi/+1Bb/
	 pFFqPcCaYL2ZEbin4Bq7rkp9upNBZphkKg3e7WTQiHsruLupHkPZwDze/GuRU0L9RDMbT
	 R+gDGBOUIe1nJXz1od0AW+jrWfwXjQX3No/063jFLcgW23mJFq9RQGP4TnLJ3et6RD38L
	 AwNh8IRDo8rLINrYvI2nhnD8CNwrv9ixXBYZ/iUtWka/30+uQPkYtbuCAhQdC4U6Kx5jA
	 yxX+zK4yQQn0q6n9KcyCcQLO63hIgFKIFAbHHnm4TgyPXYFzXuxDWA+rt0u01fzMVSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOgRdSYk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014D606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOgRdSYk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E041E1F00A05;
	Wed, 11 Nov 2026 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418462;
	bh=IsQz5Kf689Ov2wwRsR+lh5lwodSQ22klEnCbElQKuOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JOgRdSYkIzKdANdKk/sed0qOTo4//E4IUtPIw8wmLvJ8SZgCquKBrg/0UHwGRqGvZ
	 hr8945CSY5FTj8N6RLn2X79sXY8f5G2d0fvbBIp6/q92Pweb6tbVJFv/nGOc0+s/dy
	 ffYCcrP0j6rPmkwFJsLPg+UAigiCfOpMHd6czAedD6YKArloz4xTDK3XODAuv6nz4O
	 K9dFBFYTL9WXq/KelZTCfyoo9UcV4RsTihq4cuwwhRhxFChFNmZfeVtdo1wPru48Kl
	 xJevsOHpBRNXkb6j0BWYwKSwR55z9cKae++7kR426c03o+B2YpZ6+Et+OuLLujoWaM
	 CQkoBcWdWaYYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/madvise: fix data loss from MADV_FREE on a KSM page
Date: Wed, 11 Nov 2026 12:34:20 -0500
Message-ID: <20261111173359.3616859-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202814-failed-5.10-22d043c1da48@kernel.org>
References: <20261109202814-failed-5.10-22d043c1da48@kernel.org>
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
[ sashal: adapted folio-based KSM handling to page-based APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8b6ed35c1d265..9fc121162aa60 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -652,6 +652,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (PageSwapCache(page) || PageDirty(page)) {
 			if (!trylock_page(page))
 				continue;
+			/*
+			 * KSM pages can gain new mappings at any time, so we must
+			 * not clear their dirty flag.
+			 */
+			if (PageKsm(page)) {
+				unlock_page(page);
+				continue;
+			}
+
 			/*
 			 * If page is shared with others, we couldn't clear
 			 * PG_dirty of the page.
-- 
2.53.0

