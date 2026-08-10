Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C03A2E3F;
	Mon, 10 Aug 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346727; cv=none; b=TwaYrvBY2+I6RSIuCw+0Uw8mNxVq2DSx7MP5PPMZncRNEbvwLm7a6D1emHmX5LLN6i3xNoAkxlM4KdeM0arQcpGc31R8dD3715twMa06XT0Ou1zen2MaRqHpnu/L3Ag/RtJDI0fmjCj7/e3Npt9lM306Co9PPit2D6X41s6Q+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346727; c=relaxed/simple;
	bh=hpA36rWI6WPfLSvukwDJJ3rk5NlS9WDjh8PRwvotmVw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DGWbWNNl9EL8EtsoOjoLl7GgEea2jxwYrhxev45d/NfGxOmLxcC482U49RFnvbgm8AY2x9WgFCzAdP9IFJy584t8/EMvseLgUrNpRU6D0ag7eN/J5bJw5eti+DAdpT+8Hz4hkymwR6D0jhy4/UaG53KYSyWZJmo7Cb+s3HxtOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGGCW2SQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tr8WiTfc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGGCW2SQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tr8WiTfc"
Date: Mon, 10 Aug 2026 07:25:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786346724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OWexkDkQvenu73fVMXK+0zo4g4oBd1SVOwoPK6CSQC0=;
	b=zGGCW2SQ0iJFED+LiN/R5J+yKIISJDkuFb+HcOkHE58xkRzhRLep5E1391CFAYRIa8dEoR
	8aemBe6ZcpZbPYXbw9R25WXjpvNRENxjINX0e+6hzTjoviJOQCC8080OMsyLgyeU2P6R9c
	ENmnqyPxfLDprOwGLjpmN8pyJS7IirNF2vLWWbqXaisilj4ajwCzuTSlKx3cXR3FsN6nm+
	QOmNxdB+vHcbjvH95U5dCkDPGvK9WHra3P23a0X/BJtbtFIVU97+o0HIhnjPFDup+ITshX
	qtc/RWLQkYqnAvLF0L6SnRmZSK+hMeopCwk68/ct9AelaJhiner+DiPGRT9M3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786346724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OWexkDkQvenu73fVMXK+0zo4g4oBd1SVOwoPK6CSQC0=;
	b=Tr8WiTfcXg8JvwpxEN4V0qlWa+P41+C4V7GQti9TI1uAZf3o3CsIZWR8dYRlePe/vh5vv+
	KHs4xtZ/e6GvPgCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
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
Message-ID: <178634672268.442315.13608476272511196208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     3c5c7131b8fafef977c7966704b44ff23321ac1e
Gitweb:        https://git.kernel.org/tip/3c5c7131b8fafef977c7966704b44ff2332=
1ac1e
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Fri, 07 Aug 2026 17:07:03 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 10 Aug 2026 09:23:18 +02:00

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
