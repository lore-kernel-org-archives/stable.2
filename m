Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C647DF8F;
	Tue, 18 Aug 2026 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071099; cv=none; b=blpaQlPNQRzrpd9XWn3fkx5bIlgStuajUJXCs3+EAx4uSqJPEe6u0/mk0IEBU1lbBVtTfU1uun11OiPdbKFRNXw20s8NG8gEpAUmySVhObpJ2oVpvCJAl6aJ8OraMEsOz4/MvkU/zkNTUvEgMvs703fR7NwRVqBW79rDsJ68fsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071099; c=relaxed/simple;
	bh=VQXyBZHB8rfk6SWtn2UFScc0f7tSBijVv60+ZIphk1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z6LEV33cjqaHNVMqXLZewzEjjV7sJxNt2jO05TOI3JUYqiFWhWRD6JAYQfzidaxIzOI8PvuM2oaVFzfq3tGyx8vk03rarah+nKffKua71gSlgMnnYvfHAhs4ypxMtpC02eheopCCIet67VRxe13UteLHxR+3Av7uI6KTV7bqyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=TEGsxIWx; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="TEGsxIWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787071087;
	bh=6eDhHH/Zk3U2iI/PaWyIg48vqCQ4FhAg6iEaxuytCnI=;
	h=From:To:Cc:Subject:Date:From;
	b=TEGsxIWxqR/OFFImfgK0GU8I7OF7gBZFbF30RT3rgj0/DP79km2OZ+ePQBy9uu/ND
	 qUsGOI3/iUImysskohCpAae5RhWaT8eEKPeqXgiNtfY8EddFYDbhuNfwtz1Oir7YOd
	 JqSYctFq8i4q+3/txV4xeLjrntf3EXUVYpMzrad4=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with UTF8SMTP id 4hPb3g2SnhzGpDG;
	Tue, 18 Aug 2026 16:38:07 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hPb3f6VV5zGpDF;
	Tue, 18 Aug 2026 16:38:06 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v6 0/6] panic: fix panic_force_cpu= redirect races and NMI bypass
Date: Tue, 18 Aug 2026 16:38:00 +0000
Message-ID: <20260818163806.17460-1-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The panic_force_cpu= parameter redirects a panic to a specific CPU so
the crash kernel runs there. The redirect code in panic_try_force_cpu()
had two races and an NMI bypass, all found by Sashiko. This series
closes them and kills one more hack that the rework turned up.

Patch 1: fix the redirect CPU race.

The redirect is gated by an atomic cmpxchg on panic_redirect_cpu, so
only one CPU sends the redirect IPI. The cmpxchg loser used to return
false and fall through into vpanic(), where it could win
panic_try_start() and run crash_kexec on the wrong CPU before the
target ever received the IPI. The loser has to stop. It cannot just
return true, though, because panic_try_force_cpu() can be called twice
on the same CPU (a nested NMI during the message formatting, before
the IPI is sent), and a blind stop on that second call would abandon
the panic with no IPI sent. The loser now returns true to stop, unless
it is reentering on the same CPU (old_cpu == this_cpu), in which case
it returns false and falls through.

Patch 1 also fixes the panic_in_progress() guard and moves the
panic_try_force_cpu() doc comment update for the new return values
here, as requested by Petr.

The race, two non target CPUs A and B (target is C):

             cpu A                          cpu B
          ----------                     ----------
    panic_try_force_cpu()                panic_try_force_cpu()
        cmpxchg wins                         cmpxchg fails
        IPI -> C                             return false  <- old BUG
        return true                      panic_try_start() wins
    panic_smp_self_stop()                 __crash_kexec() on B
    (A stops)                             (target C bypassed)

Patch 2: flatten nmi_panic control flow.

A behavior preserving cleanup. panic() is noreturn, so the else after
it is dropped and the body flattened, ready for patch 5 to add the
redirect step without piling more onto the if else chain.

Patch 3: fix va_list reuse in panic_try_force_cpu().

vsnprintf() consumes the caller's va_list. When the redirect fails,
vpanic() reuses it for the panic message, which is undefined behavior.
Fixed with va_copy(). Already reviewed by Petr, unchanged since v5.

Patch 4: restore variable arguments to nmi_panic().

nmi_panic() used to take variable arguments until commit ebc41f20d77f
("panic: change nmi_panic from macro to function") flattened it to a
final message string. Bring them back and format with vpanic()
directly, so the next patch can hand the arguments to both
panic_try_force_cpu() and vpanic() without any pointer passing.
Every existing caller passes a plain string literal, so nothing
changes for them.

Patch 5: allow force_cpu redirect from an NMI.

A panic from an NMI used to bypass the redirect entirely. nmi_panic()
called panic_try_start() first, which claims panic_cpu, so by the time
panic() reached panic_try_force_cpu() the panic_in_progress() check saw
panic_cpu set, returned false, and never sent the redirect IPI. The
crash kernel ran on the CPU that took the NMI instead of the requested
one.

nmi_panic() now calls panic_try_force_cpu() before claiming panic_cpu,
as suggested by Petr. The requested CPU claims panic_cpu itself when
it runs panic(), so panic_cpu does not need to be handed off.

Patch 6: kill the "buffer unavailable" redirect fallback.

The redirect buffer is kmalloc'ed in a late_initcall with no error
check. Until then the redirect hands the target CPU the message
"Redirected panic (buffer unavailable)", so the crash kernel knows
that it panicked but not why. The whole boot is that window. Make it
a static 1KB buffer and kill the initcall.

Bradley Morgan (6):
  panic: fix redirect CPU race in panic_try_force_cpu()
  panic: flatten nmi_panic control flow
  panic: fix va_list reuse in panic_try_force_cpu()
  panic: restore variable arguments to nmi_panic()
  panic: allow force_cpu redirect from an NMI
  panic: kill the "buffer unavailable" redirect fallback

 include/linux/panic.h |  3 +-
 kernel/panic.c        | 79 ++++++++++++++++++++++++-------------------
 2 files changed, 47 insertions(+), 35 deletions(-)

--
2.47.3

---
Changes since v5 (all from Petr's review of 4/4):
 - Dropped the va_list pointer and the NULL means final message
   convention. panic_try_force_cpu() takes a plain va_list again.
 - Dropped the va_copy() in vpanic(). panic_try_force_cpu() already
   copies before formatting, so the caller's arguments are reusable.
 - New patch 4 restores the variable arguments of nmi_panic() that
   ebc41f20d77f removed (solution B), as its own patch.
 - The doc comment change for the new return values moved into
   patch 1.
 - Patch 5 is now just the redirect block and the comment update,
   as sketched in Petr's review.
 - New patch 6 kills the redirect buffer hack that the rework turned
   up.
