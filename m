Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A13A16BA;
	Mon, 10 Aug 2026 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349353; cv=none; b=HbFyHiLylFTspDwruda5K8pwKfvag2j2xImfDR8B0Hhpd99hnaHel0NjKSpzH/WA2GgmQltgk/9xNeT1rplgWlyugxuHoFQ4mbsvYEepnhklS0lnmY0Sbe8jakYcJXAkIHi1NpVAEnsamVZdhYpjp8UZk9ssTlSMklQ2gpStAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349353; c=relaxed/simple;
	bh=26GSJSc1cWsQfl3FD3NClNiJ/nm4LoKFeyru6FcHhzo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=lzn5TRLSISY+RrOOHKpZroHW0Bdwpt0CZKGSBZytJOHmVI2fHTR7zxf1A0bIG4Nmnxc6XXq1EJ3QUi1fjfcMhILV6kJNEcfj3PUMcK466wGFpnNB2jWpS4+/seobw6LFijblyKijVAqftAdVEhQ9NaHhM8yMO8rEca1I+xoLGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1z5oBdYz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gZI/92bB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1z5oBdYz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gZI/92bB"
Date: Mon, 10 Aug 2026 08:09:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786349347;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=W/EPIUC66V/u59UWjPrZKSuJm+pP+7dPcNM0Dy06II4=;
	b=1z5oBdYzmhHW8kyDJaubLSiVqkNl/mRY19onFblSg4igLSR/fcqUecSEva1CTeefqQcUB/
	TxWMqbx0WtxQG2GVK9+xtghByU8deFShxJuPsD3qBJx4yWgXpH37pYLKFekuoqgygqFl9T
	FTZ9BihIa6JaDSxNs4yxujPWqz5vYYu8q3Sn/p2EYQ2h3A0ZeqXUEzoN45GWwKkLanensZ
	MrxHWli4SzTCs+j2/4KaHRDTVySKOzi+dwLFj/oBmqoQaTmC1AM3OJh2E5zBUqU1/JKfk3
	jxHm9wG4GYmyvKUEW9W87GCoCDVvHzXgQyuFZm8xUXvLtEjORDJOPd4yxzOMCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786349347;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=W/EPIUC66V/u59UWjPrZKSuJm+pP+7dPcNM0Dy06II4=;
	b=gZI/92bBY31BvR7nJ+rusnUUf9N84BhG6wVxvoXAbAixKQV8LcrNxVg8klPkNJmUVgxZ1n
	vNROyvf6s9o8ZnDA==
From: "tip-bot2 for Kyle Zeng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex/pi: Reject cross-mm private futex owners
Cc: Kyle Zeng <kylebot@openai.com>, Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178634934612.442315.10058638745817080530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     59b3732f95dda1fbd2234514d35f4fb6b5bb6d85
Gitweb:        https://git.kernel.org/tip/59b3732f95dda1fbd2234514d35f4fb6b5b=
b6d85
Author:        Kyle Zeng <kylebot@openai.com>
AuthorDate:    Fri, 07 Aug 2026 17:07:03 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 10 Aug 2026 10:07:53 +02:00

futex/pi: Reject cross-mm private futex owners

A private futex key borrows the waiter's mm without taking an mm_users
reference. Nevertheless, attach_to_pi_owner() currently accepts an owner
from a different address space and copies the private key into the owner's
PI state.

When that owner exits, exit_pi_state_list() uses the saved key to find the
hash bucket and acquires a reference to the waiter's private hash. If the
last user of the waiter's mm exits concurrently, futex_hash_free() frees
the hash while the owner still uses its bucket and reference.

Prevent this by validating in attach_to_pi_owner() that, for private
futexes, the owner mm and waiter mm are the same. Perform the check with
the owner's pi_lock held and after validating owner::futex::state to
serialize against a concurrent PI-state exit cleanup.

[ tglx: Amended comment ]

Fixes: 80367ad01d93 ("futex: Add basic infrastructure for local task local ha=
sh")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Assisted-by: Codex:gpt-5.6-sol
Cc: stable@vger.kernel.org
---
 kernel/futex/pi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 795011e..3e277ef 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -465,6 +465,26 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uva=
l, union futex_key *key,
 		return ret;
 	}
=20
+	/*
+	 * If the owner is about to exit() or exec() and tries to modify
+	 * p::futex::exit_state it is serialized against this code by
+	 * p::pi_lock.
+	 */
+	if (IS_ENABLED(CONFIG_MMU) && futex_key_is_private(key)) {
+		/*
+		 * A private futex key holds a pointer to the waiter's mm
+		 * without holding a reference on it. So it must not be attached
+		 * to an owner in a different address space. Otherwise that
+		 * owner's exit cleanup could access the private hash after the
+		 * key's mm is freed.
+		 */
+		if (unlikely(p->mm !=3D key->private.mm)) {
+			raw_spin_unlock_irq(&p->pi_lock);
+			put_task_struct(p);
+			return -EPERM;
+		}
+	}
+
 	__attach_to_pi_owner(p, key, ps);
 	raw_spin_unlock_irq(&p->pi_lock);
=20
