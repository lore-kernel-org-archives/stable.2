Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273685;
	b=S6hLNLhxvpHmm2HipLYgGzOPbP+hn5jUI4nZNNpW6II38TswXh6vSSW/vnFGHZhOQWDF
	 +x5QXCAhSUosuCteIAe8Ju2j2IBCnE8K2IzMWpbXrwOWXC/5rnUkAKenLdSggRlBCARiu
	 7t14EtYrPy3sAJDhu0pp5TpSwm07rdDoasnLdKyhR0zw8poPh3XzjD96U5SrJ5EEH9554
	 ylmWIHv/8P4utEbtgkiOx8MkeDKuOScbcNa9rn2HcPLTySrIrtuasotKBB28AsZRBf/ul
	 39BXFeMONw7Uty+jZZigyLw4QkPmwv62k8jEEs+ebJvWOfdds9sRSQNYoEc/OerUgsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273685;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1f8qamEx3HfptG5YKhe3G95VfQiWR1rClu15vPgMhn0=;
	b=dI7cMOgKx06dalCXA3Uhw8Oc3pAwa6C96kv4n7CUwlInw4e92LxBL1g4LwdLKOQdDf0j
	 tWvDUAHnEPN1jjdy9uuNZBIHN3d6kBp1gGgT9qzrj6+pDD7cVpTgOdxsX5BppyawM0VrB
	 swMwdHk/0KX0FW6xJQr4+mKc+FAV+bLexrIj0Rl27FLohqce47VTm1AR30pVVyNdbGRhD
	 mL5ZXkjlB9Xc26bwll2KW2a2DmtNGvyeTwDV2tMSE19jMRFYhJqwEx0QwkIuLvQQGBcpa
	 utV//FhwEmIUo6vPa9Xa/8ameNjj9uIexk7Sci1CsJDxefKpnAR95+dGPME97Nq5ISQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzIwqn3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0953606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzIwqn3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5581F0089F;
	Tue, 10 Nov 2026 01:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273684;
	bh=1f8qamEx3HfptG5YKhe3G95VfQiWR1rClu15vPgMhn0=;
	h=From:To:Cc:Subject:Date;
	b=JzIwqn3MHSS9O5gerURIoXaqiopMXE0Sh6WxgNt5N/oV2LUslJNg3LM6Y9ObTmdeO
	 bDs/4oB3KbSGO1MvibrEXDFvpLMV5osYJjf39qiaRd6isbkZaXUIpjap3XpeoJSfGe
	 jo+KyxZsNy7UZQtn9pDfdJSTU6wiUF0RwW2UPSTkigTGFDBBQAczlx/ZzwYrF/1Isv
	 d9uAvF8PIouXX2Jz42OX4cz1wNhM6yhvgwcg7EwCBBlb0XP200cNVGPIGmDG/wskgY
	 CIKarpSaxEMq0o2cr21rnFIb6zztusFs2yVpcucUf5XYtvgVfK817NCA46OTswaL5u
	 rvGp9g2axYpFQ==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	riel@surriel.com,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/filemap: don't lose a folio lock wakeup to a signal" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:21:22 -0500
Message-ID: <20261109202122-failed-5.15-8ccb6ded6a47@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8ccb6ded6a47b59b4907ed4f8c293cf8122de889
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202122-failed-5.15-8ccb6ded6a47@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8ccb6ded6a47b59b4907ed4f8c293cf8122de889 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 31 Oct 2026 10:39:36 +0100
Subject: [PATCH] mm/filemap: don't lose a folio lock wakeup to a signal

An exclusive waiter in folio_wait_bit_common() can leave the wait loop
because of a fatal signal, then be woken by folio_unlock() before
finish_wait(). If the waker did not hand over the lock, the waiter returns
-EINTR without trying to acquire it.

folio_wake_bit() stops after waking the first exclusive waiter, so this
loses the wakeup and can leave other waiters asleep indefinitely on an
unlocked folio.

After finish_wait(), let a waiter woken without a lock handoff try once
more to acquire the lock. If successful, return success so the caller's
eventual unlock wakes the next waiter. Otherwise, the current lock owner
will do so.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 5ef64cc8987a ("mm: allow a controlled amount of unfairness in the page lock")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: clarify and simplify comment + description ]
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-7-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/filemap.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 906b013c11eb3..6b5e1d866a9e0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1373,10 +1373,22 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	 * return value based on that state without races.
 	 *
 	 * Also note that WQ_FLAG_WOKEN is sufficient for a non-exclusive
-	 * waiter, but an exclusive one requires WQ_FLAG_DONE.
+	 * waiter, but an exclusive one must also acquire the bit.
 	 */
-	if (behavior == EXCLUSIVE)
-		return wait->flags & WQ_FLAG_DONE ? 0 : -EINTR;
+	if (behavior == EXCLUSIVE) {
+		if (wait->flags & WQ_FLAG_DONE)
+			return 0;
+		/*
+		 * We might have just been woken up and the waker will not
+		 * wake up anybody else. If we ignore that now, the remaining
+		 * waiters may not get woken up: take the bit now if it is
+		 * still free.
+		 */
+		if ((wait->flags & WQ_FLAG_WOKEN) &&
+		    !test_and_set_bit(bit_nr, folio_flags(folio, 0)))
+			return 0;
+		return -EINTR;
+	}
 
 	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }
-- 
2.53.0




