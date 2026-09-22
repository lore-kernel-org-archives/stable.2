Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B506443C14
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070125; cv=none; b=KC+jIFQH1vlPZGEWe5Zde9rqIEngSS7t+3XwHVebKBFbPiBVzaQWoLvS372I+61QsESv01EsrCNYV2i0CiwsFa+HtlN1hqbUjWsF4mz1UNH2EvLQkF1UJRiIYjdngDHj08phzBCwLMyS8QtGqaZ6yDLN/mo5IOhntbInMrDn8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070125; c=relaxed/simple;
	bh=RhITA8+aIOcxqqBJ0sF9w5A1Xw85wn1pC9LEswa9Sf4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j0ZXGnpKxvNAt/ZPffvgT9YqhANtLxD3U3HiRh1HQeO9RcrIhFZWMiHWmrMFzIQcdVhXUl0noXoGnL5uHxzeSpyr07dEIlbCBmUVJTb80fzuSqK+bwAUKWDlOegP5ucAoi5ltn0Ts6aCqcecoLNCyJuqCZTktIExCNaa1WtkVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Aqto4LKX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Aqto4LKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124311F000FF;
	Tue, 22 Sep 2026 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070123;
	bh=YBnlmFMTmag/wqCdPUyehMOZc0q1Xg0mNB0y7bdE9bc=;
	h=Subject:To:Cc:From:Date;
	b=Aqto4LKX/O5ecwbU3v9W+dvbwUaRAOhSMBpi5rIco+rQtrkBc+K48jswY16/NEIya
	 hRVUkqk5UBtu3MZpoJuoLlrtj9Bfse2Wc/6DO7aBFANwO2kDKD4crLmebTTl8LVSV6
	 5vt8KMkAQFAP6ysu4vNMygNzDE7Dd/jF2ERzGk3k=
Subject: FAILED: patch "[PATCH] arm64: percpu: Fix LSE operations on {8,16}-bit types" failed to apply to 6.6-stable tree
To: mark.rutland@arm.com,ada.coupriediaz@arm.com,ardb@kernel.org,catalin.marinas@arm.com,james.morse@arm.com,maz@kernel.org,peterz@infradead.org,ruanjinjie@huawei.com,vladimir.murzin@arm.com,will@kernel.org,yang@os.amperecomputing.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:29:23 +0200
Message-ID: <2026092223-oxford-subside-0146@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8cf2093f5372952a9ebc805c418d45df7112cd14
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092223-oxford-subside-0146@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cf2093f5372952a9ebc805c418d45df7112cd14 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 8 Sep 2026 16:17:23 +0100
Subject: [PATCH] arm64: percpu: Fix LSE operations on {8,16}-bit types

The assembly for __percpu_##name##_case_##sz() and
__percpu_##name##_return_case_##sz() doesn't use the 'sfx' macro
argument to form the LSE instruction. Without 'sfx', a W register
argument will imply a 32-bit memory location, and consequently
{8,16}-bit ops will erroneously read and write 32 bits of memory when
the LSE instruction is used.

Fix this by appending 'sfx' to 'op_lse' to LSE instruction. It is not
necessary (and not valid) to append 'sfx' to 'op_llsc', as 'op_llsc' is
a register-register operation which does not access memory (and does not
take a size suffix).

Fixes: 959bf2fd03b5 ("arm64: percpu: Rewrite per-cpu ops to allow use of LSE atomics")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: stable@vger.kernel.org
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 31193bcf89a2..8cf4068ce1b5 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -77,7 +77,7 @@ __percpu_##name##_case_##sz(void *ptr, unsigned long val)		\
 	"	stxr" #sfx "\t%w[loop], %" #w "[tmp], %[ptr]\n"		\
 	"	cbnz	%w[loop], 1b",					\
 	/* LSE atomics */						\
-		#op_lse "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
+		#op_lse #sfx "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
 		__nops(3))						\
 	: [loop] "=&r" (loop), [tmp] "=&r" (tmp),			\
 	  [ptr] "+Q"(*(u##sz *)ptr)					\
@@ -98,7 +98,7 @@ __percpu_##name##_return_case_##sz(void *ptr, unsigned long val)	\
 	"	stxr" #sfx "\t%w[loop], %" #w "[ret], %[ptr]\n"		\
 	"	cbnz	%w[loop], 1b",					\
 	/* LSE atomics */						\
-		#op_lse "\t%" #w "[val], %" #w "[ret], %[ptr]\n"	\
+		#op_lse #sfx "\t%" #w "[val], %" #w "[ret], %[ptr]\n"	\
 		#op_llsc "\t%" #w "[ret], %" #w "[ret], %" #w "[val]\n"	\
 		__nops(2))						\
 	: [loop] "=&r" (loop), [ret] "=&r" (ret),			\

