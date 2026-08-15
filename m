Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9933D6FC;
	Sat, 15 Aug 2026 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786833000; cv=none; b=GRobRtrZ6BdvdLGRCWSDpyYE7MrFEsj52TkHZUeYB3BmwDX/ZV3w87MRwVO1UuGNKOXv5ixQaQ3AWuwbvjtBdGR8vdzKljYY0eCEE2PsED6J7NriBO3rBjxquxmWApNKw1FTrqSlUtDAJRd9jcV36i4PolIQ3gKsvxocxrEZJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786833000; c=relaxed/simple;
	bh=ElshFWEyuaM0t7ZPEzPA9jmiBdBe8kuI+7NG8DOLv84=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=itA+2BRGbLGJ8JERl6nMTfrVuPO4OHDwTqeWLuwLCmSavs85e+Z6Z+0jg+Y0GPcZWLJqQVkeCkWtUyIE7NaqVN/dVlQd2T6nKK0ts8g+fKwjGcqPsXtQI5Q5MvYeF/zvptjqzyguf/zhhml0+FARAaIGGspMk9GxJ5CZsKHi1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WymGeSEt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RqkLxBSA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WymGeSEt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqkLxBSA"
Date: Sat, 15 Aug 2026 22:29:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786832989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUH7Wpzeq1MJUgMmaezutiF5aqD9/pLwSPDCsKARrVk=;
	b=WymGeSEtMhhc4hGTCyWOWGCbsWbuck7QpjnoAxtp1r2qylX4YXmmLC78r0D5vCX1qsllRZ
	t5Dshu18n6MHfgDwWAoO/B2sTsshUEo2hQL/hX00Wt77BXBT5Hg1AsswWuS2L98buoqmqd
	yUVIspNcmjRcZJ5uvnrES05RDlLvMeRHPzfSv+Oc9VFV0CRJ2cRk20sT8gGa7Q/RaFkbyZ
	YjS3Z6+4MFPbBROJCh0VfECYUqDAY+kezF1VsmHxZimX0eRHYzvdPOawjbTn/ICrYfFhi0
	V2NrAxwZDE29GNbPL0ph4M/UX0De7vvK6htmMJPCNsEwQTDlH50aj69ikzT2pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786832989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUH7Wpzeq1MJUgMmaezutiF5aqD9/pLwSPDCsKARrVk=;
	b=RqkLxBSAPvg/Zb3QzbGjNvQY+T9D81CCHzwxMPpUpC84SVg8xi/38pAVfnrsq1rlG1OucP
	qijYOLI6kxN3XoCw==
From: "tip-bot2 for Hyunwoo Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Fix race on the initial
 mm->futex.phash.ref allocation
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ansrpP4ImE1MaBY9@v4bel>
References: <ansrpP4ImE1MaBY9@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178683298748.1542179.4201191825808254460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     bde0238083647381d4747355c5a19115a3422b96
Gitweb:        https://git.kernel.org/tip/bde0238083647381d4747355c5a19115a34=
22b96
Author:        Hyunwoo Kim <imv4bel@gmail.com>
AuthorDate:    Tue, 11 Aug 2026 23:03:16 +09:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 16 Aug 2026 00:16:32 +02:00

futex: Fix race on the initial mm->futex.phash.ref allocation

futex_hash_allocate() allocates mm->futex.phash.ref without any locking.
Commit d9b05321e21e ("futex: Move futex_hash_free() back to __mmput()")
moved the allocation here and assumed that the process has just a single
thread at this point.

Commit ee9dce44362b ("futex: Drop CLONE_THREAD requirement for private
default hash alloc") widened need_futex_hash_allocate_default() to cover
any CLONE_VM clone, but left out vfork because the parent is suspended and
cannot race.

That no longer holds once vfork is nested. If a vfork child calls vfork
again and is then killed with SIGKILL, the parent is released from its
vfork wait and runs concurrently with the grandchild in the same mm.
Neither of them went through futex_hash_allocate_default().

When both call prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS) at the same
time, each one sees mm->futex.phash.ref as NULL and stores its own percpu
counter. Only the last store survives. The counter stored first is no
longer reachable from the mm, so the references on it are not seen by
__futex_ref_atomic_end(). A private hash that still has references is then
considered dead and freed, and a task that still holds one of its buckets
writes into freed memory in futex_q_lock().

Store the counter once with cmpxchg() and let the loser free_percpu() its
own. The initial reference has to be taken before the store, otherwise
another task can install a private hash while the counter is still 0.

Fixes: d9b05321e21e ("futex: Move futex_hash_free() back to __mmput()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/ansrpP4ImE1MaBY9@v4bel
---
 kernel/futex/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 2d1dbde..b38222e 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1857,14 +1857,18 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, unsigned int flags)
 	}
=20
 	if (!mm->futex.phash.ref) {
+		unsigned int __percpu *ref =3D alloc_percpu(unsigned int);
+
+		if (!ref)
+			return -ENOMEM;
+
 		/*
-		 * This will always be allocated by the first thread and
-		 * therefore requires no locking.
+		 * Tasks sharing the mm can run this concurrently, so take the
+		 * initial reference before publishing the counter.
 		 */
-		mm->futex.phash.ref =3D alloc_percpu(unsigned int);
-		if (!mm->futex.phash.ref)
-			return -ENOMEM;
-		this_cpu_inc(*mm->futex.phash.ref); /* 0 -> 1 */
+		this_cpu_inc(*ref); /* 0 -> 1 */
+		if (cmpxchg(&mm->futex.phash.ref, NULL, ref))
+			free_percpu(ref);
 	}
=20
 	fph =3D kvzalloc(struct_size(fph, queues, hash_slots),
