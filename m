Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273974;
	b=A48kWCOhuA82rdnOxil7w8/mpAe58Xfju1V9anG0QOvQqvE6dO91TtUzmJdiqwSUEzGZ
	 VjCUlgEIX9tPXHBYgFaaDSTDIy2HAtQRB+fjSRoa5b6V5W4M9B302dqwoAH6DxKYirBxa
	 cCmjhyhuzA65q1BmIanOY/+rjYYhdMCZhh9K7UNXvbofUrVEZqjMwxTPu0CcrxGAYYwf3
	 pWTJwsNxj6kq+nmwxb1j47t7B7x9GVUeF2mYTzCBl5djeys7mJ9p8J/d1OCdkM8FE63X6
	 zEVez8tcZPXCPpTFTNEbq8IqPPwrnLbSvvrYPRCzxaLbBO+dISOKkjHnaobmMCmuuVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273974;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eN7ADaGsK2XSCQdeIPPz5epgY6txwDwO6N7W0SEJBuI=;
	b=Y+TZri9exleBSuBm5LK6y0tKmIzn5ZstLu9SBSfP02N3N1Jwke+R5rlcZLuHE9kyBPdf
	 2zDMjwLiabEZ4v/YQBuS6c4QJNubvp+MHEeanmJh8bTbnv1nOeQd4paP/L0hpLs3Msdkl
	 jN0SNh8tH+/jG4vuF+itAUvtgqlwAzu63r9d0k0fm6E0mMOwQzJ33nkoGJzT/+w1MeXCL
	 tynUdwWOPySCZVN1hYsQpZYiXJi0uttOfknMxrEL0rFRI/m/8l9/stBH2GOEDbeGLFVd9
	 cQdPdG6IjIyjsfZZ9KAZlfA4nsyYWRlPIwQad0V3ixjpaElkvlJ7i4Wjxkiu1cqYoOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcPFt2Nj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4B60A261F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcPFt2Nj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90F71F008A2;
	Tue, 10 Nov 2026 01:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273973;
	bh=eN7ADaGsK2XSCQdeIPPz5epgY6txwDwO6N7W0SEJBuI=;
	h=From:To:Cc:Subject:Date;
	b=ZcPFt2NjoK1nmA1MXoXzd1C+00XtArlrbpcPRnM2EjKq8h3Bwy2Xdyf5iBcXQmW1l
	 f8fjzWLWa+eTXp0n4VPAWKtQs4YYruqg3Tld7GoUQIHBATn9EZDgE8fV2g9xqyyZK3
	 Mxui/NfWxJH6nHlWyfP5tcoJbJbXTov9w67DO9PyNhDjBx3r1C4LIj4Ebh/Xo/NESM
	 5vW1XYALoeVZ6oxYB78ksHHxWaqY/Pz/F7vZSqiRLNgjdgCABot1LcU3G7AopuAOqF
	 /j9BJkipq0oLIsEvja7atUrL2TWGsjBFrf4ZV4aGQxPdIEAsc4eSjLy0kv3ybNOtmW
	 IJsTQGK1/TVyA==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	riel@surriel.com,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/filemap: don't lose a folio lock wakeup to a signal" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:11 -0500
Message-ID: <20261109202611-failed-5.10-8ccb6ded6a47@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8ccb6ded6a47b59b4907ed4f8c293cf8122de889
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202611-failed-5.10-8ccb6ded6a47@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




