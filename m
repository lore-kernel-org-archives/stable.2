Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AA2F3614;
	Tue, 14 Jul 2026 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050278; cv=none; b=ElKcILDVU7wdXHOZfpevvADHJIEpjwUbyIqBa2YAj3631h7aCrmst2UHj6OFWZOvuF4CWD4wkomT6xg3NxwpYIjestnEey1i9JvjmhqpM3lgALqtPvYhWVixhsMjNzck34NxXpNxMLMy/N0Q394f9UJLq8AIBjWVBV/XjfQHxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050278; c=relaxed/simple;
	bh=UZiOGp0/vJhhgaQv/VWyxJYZyMtPN+vHXY20iH3H9as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyMDOeGkxd9KasmaXJDygIeSSIVBl2naoNN7ajlrx4jX6BUnAgfr2q2+brQ3YJIMW2zRSYwR0D5ekk0DtEQThhwSZVqKzfaFrFC52ku7ECqISX0xSYtKcf/iBj5OgeLXbxVAGzh003JJ5bkQSB7ygkgmil1Wx622UE9K0mDs9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=N18O4HZp; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="N18O4HZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784050270;
	bh=UGpWzI1bp68mcgLlSW3gVZ5ZO/RISIWT7S496u0RQFw=;
	h=From:To:Cc:Subject:Date:From;
	b=N18O4HZpwv0wyGbQp+T6i90d7rzKACBjKlaVUJAgll++PUISPckwRG24MS/TNAIpb
	 GJeabSbOs7vQkZF6DS9izJsEnQ+Oj4QH234sRbM7Gv/5GUn8eZ5kEh4XSSWsAFUoxq
	 NOa9mplgi0HYEFp9s2ngPZis8fREr+BQCeNtSBhk=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h05v2597hz112f;
	Tue, 14 Jul 2026 17:31:10 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h05v16L7yz112c;
	Tue, 14 Jul 2026 17:31:09 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Cc: pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	include@grrlz.net
Subject: [PATCH v4 0/3] panic: fix the panic_force_cpu redirect races
Date: Tue, 14 Jul 2026 17:30:59 +0000
Message-ID: <20260714173103.11585-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for sending this before the earlier threads fully settled. I am
posting the series now because everything is in one place, a single
thread of three patches, instead of replies spread across the old
threads, which is easier to follow than a few separate discussions.

The panic_force_cpu= parameter redirects a panic to a specific CPU so
the crash kernel runs there. The redirect code in
panic_try_force_cpu() had two races and one ordering bug, all found by
Sashiko. This series closes them.

Patch 1: fix the redirect CPU race.

The redirect is gated by an atomic cmpxchg on panic_redirect_cpu, so
only one CPU sends the redirect IPI. The cmpxchg loser used to return
false and fall through into vpanic(), where it could win panic_try_start()
and run crash_kexec on the wrong CPU before the target ever received the
IPI. The loser has to stop. It cannot just return true, though, because
panic_try_force_cpu() can be called twice on the same CPU (nested NMI
during the message formatting, before the IPI is sent), and a blind
stop on that second call would abandon the panic with no IPI sent. The
loser now returns true to stop, unless it is reentering on the same CPU
(old_cpu == this_cpu), in which case it returns false and falls through.

Patch 1 also fixes the panic_in_progress() guard. We must never redirect
when panic_cpu is already taken, so the guard stays. But it now returns
true (stop) when the panic is on another CPU and false (proceed) when it
is on this CPU, instead of returning false either way.

The two races side by side, two non target CPUs A and B (target is C),
then a reentry on the redirect winner:

             cpu A                          cpu B
          ----------                     ----------
    panic_try_force_cpu()                panic_try_force_cpu()
        cmpxchg wins                         cmpxchg fails
        IPI -> C                             return false  <- old BUG
        return true                      panic_try_start() wins
    panic_smp_self_stop()                 __crash_kexec() on B
    (A stops)                             (target C bypassed)

             cpu A (1st)                  cpu A (nested NMI)
          ----------                     ----------
    panic_try_force_cpu()
        cmpxchg wins (redirect = A)
        vsnprintf(msg) ...
            <-- NMI -->
                                     panic_try_force_cpu()
                                         cmpxchg fails
                                         old_cpu == A == this_cpu
                                         return true  <- would abandon
                                     self_stop (IPI never sent)

Patch 2: flatten nmi_panic control flow.

A behavior preserving cleanup. panic() is noreturn, so the else after it
is dropped and the body flattened, ready for patch 3 to add the redirect
step without piling more onto the if else chain. Split out on its own so
patch 3 only adds new behavior and does not also reshape the function.

Patch 3: allow force_cpu redirect from an NMI.

A panic from an NMI used to bypass the redirect entirely. nmi_panic()
called panic_try_start() first, which claims panic_cpu, so by the time
panic() reached panic_try_force_cpu() the panic_in_progress() check saw
panic_cpu set, returned false, and never sent the redirect IPI. The
crash kernel ran on the CPU that took the NMI instead of the requested
one.

The buggy call order, on a CPU X that is not the target (target is C):

  nmi_panic()
    panic_try_start()              wins, panic_cpu = X
    panic("%s", msg)
      vpanic()
        panic_try_force_cpu()
          panic_in_progress()      true, panic_cpu is X
          return false             redirect bypassed
        panic_try_start()          already won
        __crash_kexec()            on X, not C

The fix tries the redirect before claiming panic_cpu. nmi_panic() calls
panic_try_force_cpu_fmt() first and only calls panic_try_start() when no
redirect happens. The requested CPU then claims panic_cpu itself when
its panic() runs, so panic_cpu is never handed off.

nmi_panic() holds an already formatted string, not a va_list. A variadic
wrapper, panic_try_force_cpu_fmt(), builds the va_list and calls the
existing panic_try_force_cpu(), which still copies and formats under the
redirect cmpxchg. This keeps the static panic_force_buf safe, it is only
written by the cmpxchg winner, never before ownership.

The redirect IPI goes out via smp_call_function_single_async(). This is
safe from NMI: the _async variant is documented as callable with
interrupts disabled, and kgdb_roundup_cpus() already uses it from NMI
context (kernel/debug/debug_core.c).

Changes since v3:
  - Patch 1 now also fixes the panic_in_progress() guard to return
    true or false depending on which CPU owns panic_cpu, and drops the
    recursion framing in the comment per Petr's review.
  - Patch 3 no longer changes the panic_try_force_cpu() signature or
    formats the message before the redirect cmpxchg. Petr pointed out
    the static buf is only safe under panic_cpu ownership, so the
    formatting stays inside the cmpxchg guarded path. nmi_panic() now
    reaches it via a variadic wrapper.
  - Patch 3 adds the NMI safety justification for
    smp_call_function_single_async(), answering Petr's v1 question.
  - The nmi_panic() control flow cleanup is split into its own patch
    (patch 2), per Petr's request to split changes.

Bradley Morgan (3):
  panic: fix redirect CPU race in panic_try_force_cpu()
  panic: flatten nmi_panic control flow
  panic: allow force_cpu redirect from an NMI

 kernel/panic.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

-- 
2.53.0

