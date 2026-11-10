Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273232;
	b=SpSezt156jaHm62MY0ubpm473YLVzWSVbQrEkGlVv3V7gURGHNf8dQg/EMcCtqm3bZgC
	 MAjUv7f2H9wv3296y/ICsbz58sFoAm3nZ/J4P+VulPSIZU4Nuk0TNRXQ5rqF/SK7TONkg
	 S4/94RjvDIWDtUupIRdLrPxcJcOWYZeZI1A8RC7OAM6ppGv4LtUFzhCYvmSNRlW05JkHe
	 MAtXejwXjscXEzx/RNuA5q40RPf+XNu57JJh8W34lArPBI894y3Qbs8t19e3hmloW1rpK
	 TGpd5nLza/NBuXNbqVbFw57c3amf3PHPXIdl8wvjGUbu4yuk8y9Dkj14SNV92g70E2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=M71VcNIjoOgAeSSpZcLzFX8JYKqRH8ALp4V8soTmdvA=;
	b=v7BdfV2NzgIU9X2jM65Q5XDWjWfrpYD6zKyRkljWXswOZvtD9Mmf0jvl7FmhhYGTxIu5
	 M6E3UA1b3/I7BXL29PyRoOAKMvB2QKLJquaXv94OQ06j5xLP0SUKFvEaQrA7ngKvnZ6Em
	 5nnIngeKWpN912za6cfZxieQHSgBrmPv9up3yEpl7fsso/aUzOPi8RwTw3JBwi69OjeO6
	 X51yqCOUOfH1S7DOE+3gFXbdihwgl4Xdv67ROgDUEmtLFVXwg6JoOdHZUxEKWPCwkUz71
	 7bE2ztGGJqzRsNkWW3PFYAAoZzCx2fyeEcM+kHz42Oafwivt6urWY8O4X89aVWGhciw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjcdKMrk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E75606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjcdKMrk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0685C1F0089F;
	Tue, 10 Nov 2026 01:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273231;
	bh=M71VcNIjoOgAeSSpZcLzFX8JYKqRH8ALp4V8soTmdvA=;
	h=From:To:Cc:Subject:Date;
	b=bjcdKMrkjcNGr3n2CbHrCD9ZbynyTtLvMfFrXsoI7MCzcmQccYpvuk0KxOGufn9i2
	 3kg9yTIJ/i1yu/RbzdN7vrR3TmRsOAQFg9vKuGdi3kj02yHKID8iN8MjjWjCDZGhzS
	 gh/AhMBCJsgx7mEOxyzGY2NA7HKiKdjR5QWq10T0hxHhevRN2ArEans+cKdPd2eEB7
	 cE/mHpAI+VjdRfOv+1C+Fg+iJ/gyGYc8Y31SO6EgC+XG6Fj5p46Spb0W/jt4wbmO31
	 PozllnofWzhpcw0jHvXMlOJbxhFxME9Vw16mumJh/EhZ498WvkH36GoNhjOzp1qFp2
	 Y6q0mdX+Cq8Ng==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	ljs@kernel.org,
	xu.xin@linux.dev,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/madvise: fix data loss from MADV_FREE on a KSM page" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:49 -0500
Message-ID: <20261109201349-failed-6.6-22d043c1da48@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 22d043c1da48d6c7274f9dd900714b6d58b7b9c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201349-failed-6.6-22d043c1da48@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 22d043c1da48d6c7274f9dd900714b6d58b7b9c6 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:03 +0100
Subject: [PATCH] mm/madvise: fix data loss from MADV_FREE on a KSM page

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
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 75b409e97dbf2..a16e3cb256b7b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -756,6 +756,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
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
 			 * If we have a large folio at this point, we know it is
 			 * fully mapped so if its mapcount is the same as its
-- 
2.53.0




