Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8B407CEF
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569017; cv=none; b=QrOCFRtseIqUD2qzx3FNTft6SVK78HXdESfn2hZ3fspVfeIudrV3o9rIfR9W8C3DXdbD2K8vARE5PlSEkJuq7OcsbXWFKleBpqMYb3vKshgtN5mpP90h8Eh3oI7imHEOxS9xRhA5zqgwzdTmJ1l2ZM+Atho7VzdLsmAEFI5lUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569017; c=relaxed/simple;
	bh=ZNgYR+gU5uUQKLWVySwu31oirYyPWAMwRJA0QEayVC4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PTk6tt0cn8DdbJRHF1Rbfq2Jl7W/DWs7IjcNYM4JlHZCAvoGapSBehswfjHQD2UYM/8H05nUu2ZAJPXQuK5XSjzalrA5F+voG6BzkLd+faPTbizI+tdZ/gDEUxIHk8ZELtXCcqTpSZKXdnSa3MrHCMTE/Zv8fwPT3RdeJZh5EFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=edDCt0eb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="edDCt0eb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4E91F000E9;
	Mon, 24 Aug 2026 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787569016;
	bh=j3adGMfO2wNj50YWMQ2hts4SDaifGpvl2C3HiTcnrKI=;
	h=Subject:To:Cc:From:Date;
	b=edDCt0ebGX1RDnizbDZAJTML2fhrwQLVQEIl9zdypn5y1x2WE9JAf27ReV6pzWjfq
	 E7bdP3Kbr6aRCHdNnKLfP3YsutmhsWTfK8mVe1mrYn1OWI/dhC1Xsad9+cOOKnuPBx
	 RtmSN6Q3Bj9CyKuTUEwDNpW0X8/ZBWgIg4iJ/KRg=
Subject: FAILED: patch "[PATCH] futex/pi: Reject cross-mm private futex owners" failed to apply to 6.18-stable tree
To: kylebot@openai.com,peterz@infradead.org,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 12:56:50 +0200
Message-ID: <2026082450-shoplift-anew-8412@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 59b3732f95dda1fbd2234514d35f4fb6b5bb6d85
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082450-shoplift-anew-8412@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59b3732f95dda1fbd2234514d35f4fb6b5bb6d85 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Fri, 7 Aug 2026 17:07:03 +0200
Subject: [PATCH] futex/pi: Reject cross-mm private futex owners

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

Fixes: 80367ad01d93 ("futex: Add basic infrastructure for local task local hash")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Assisted-by: Codex:gpt-5.6-sol
Cc: stable@vger.kernel.org

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 795011ea1202..3e277ef155cd 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -465,6 +465,26 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 		return ret;
 	}
 
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
+		if (unlikely(p->mm != key->private.mm)) {
+			raw_spin_unlock_irq(&p->pi_lock);
+			put_task_struct(p);
+			return -EPERM;
+		}
+	}
+
 	__attach_to_pi_owner(p, key, ps);
 	raw_spin_unlock_irq(&p->pi_lock);
 

