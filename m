Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1F42E8F8;
	Wed, 12 Aug 2026 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532551; cv=none; b=sEZ9DA7099uxyX81nRRNfYdYEHqUoMvUQlg3a25v0BjSLwgPdk9VWYoFuaeNa6WdhsWfQAGEO+cwXWrHr1IhegtNDzbwQonvaWRIUu/zJGdyIIYyJqk2JWvQRYoxIB+BdJNStTU8BiZ+UaVQOrdwS58Z3clLUz5XSHL/s5zBjJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532551; c=relaxed/simple;
	bh=LHL8edZiJ3+IktEvvpcvug36LpIp4EeJrx6P7S84aw0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eRcsZrVDf8goDiKfbniFQuTWh+UYcNyuxN2xA7cxbuN/GwBpdvCDELZbLC433gzN6c9aUfRoMDfcprtadaoOnIAl+y0B27iy8I2bHZdC1ppfMoHfSTkxPzMaCAqBY1djKWF9Be/ad7z8KdjlXPXFkNg9Tpmf1uZwJDHaMDjx8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VxcX6Nnb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1NLyGAm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VxcX6Nnb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1NLyGAm"
Date: Wed, 12 Aug 2026 11:02:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786532545;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pn8yGCBWJpf51jwiZEWK8X5Qh2orTkf5AZ59+oMmAqY=;
	b=VxcX6NnbQOatqkfBgw/Q25rMSfLEGoZyFXB9xTjqif2M3li3KiMOj7habsRvbzjhQhrN4C
	pZC+4d+wvnRRo54pKMQVG0jslQEOArXK882sQrEEAnmMbWsU0RUIkteY+/ykcLOkZCo2zg
	r3QA6M289V/s23v5ZnHTrN2sakRFR5ULJ3zaAnjBb9fyGq6PPPAApusp+ERsBVpQ/p+F36
	nVCuOmNf7yJbHOV7NmiMcI8DY5L46m3PWiboHAVrQOzV6rYHxA/7QoYB+nEgbUEyDdgq9u
	c/gBOkHUllFpTPr3pIm7rr/KkYaPTflM5qYtobDxljt5TUTeu7hCjIBtvBb8xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786532545;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pn8yGCBWJpf51jwiZEWK8X5Qh2orTkf5AZ59+oMmAqY=;
	b=j1NLyGAmx8x2Mk05ACgvpcCwXGMUKIJCugaAHAQHL1pfQRUQey+I+u0ZJyhUtbZBe15l/v
	jD4Z66sz29a42cBw==
From: "tip-bot2 for Hyunwoo Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Fix race on the initial
 mm->futex.phash.ref allocation
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ansrpP4ImE1MaBY9@v4bel>
References: <ansrpP4ImE1MaBY9@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178653254327.442315.7900060751947067777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     4f664e37fe72ab21426d2d74fcbcf7399e8fc52c
Gitweb:        https://git.kernel.org/tip/4f664e37fe72ab21426d2d74fcbcf7399e8=
fc52c
Author:        Hyunwoo Kim <imv4bel@gmail.com>
AuthorDate:    Tue, 11 Aug 2026 23:03:16 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 Aug 2026 12:57:13 +02:00

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
