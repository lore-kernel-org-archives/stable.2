Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E63B8BCB;
	Sat, 22 Aug 2026 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391437; cv=none; b=WSOjjI8LpnZjG4nBWe6PP6qqUS8BSCLGOy++7wEGGL7Z0rJ7ZQ07iLDU2+6Gna/O7gv+gFCqhdHZuM/sgy2tIVJY3/mmqihN7TQGCponxaAS13DulL+smN0KULlx9oQebmgtXXdgpe87geyrPdYDq8kv54CfEkHpLHdqbeWqLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391437; c=relaxed/simple;
	bh=KXjCFcOp7394DejP1szRta3crF9ysAlOBv+zKf73bsQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MeE2kSVzJ7ewrcIiRQN/X2D4SVh0h8WwFLUPC66ZhLHr+dCno8j4Y29a32nE42wQuUMjUZ0kWyjiAU4hrM7GYzZ5OtPuQ5TEMxR10XPR0pv9VqyJKWzDGg/6q/D2g4xoYe8cSvHsaRmz3anSf5dy6lVNJpPgx8I+X26jsAxku9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=AW2TRut3; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="AW2TRut3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787391426;
	bh=mO/P0+l2gNGVNNapyT1SVGjulwrUYq3eEwcsgYPE6uo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AW2TRut3MjPGhP0H4hr+lRuB61Lkh13O3+s1p1mKfX+djYut/xe01703gdveSkG8L
	 +VH1EAf77xX14doMOjtAQUUMofJ4K81aKkmdiPUZzu/z8Pu3/urN+V2E/O7i/urqAb
	 fmf+wQWoRKmEtPT1aEsUuEZVDN517k9vct3xOtdc=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hRsX20G1wz6vZ0;
	Sat, 22 Aug 2026 09:37:06 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hRsX147xNz4y6W;
	Sat, 22 Aug 2026 09:37:05 +0000 (UTC)
Date: Sat, 22 Aug 2026 10:37:05 +0100
From: Bradley Morgan <include@grrlz.net>
To: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mgorman@suse.de
CC: bsegall@google.com, dietmar.eggemann@arm.com, kees@kernel.org,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 rostedt@goodmis.org, vschneid@redhat.com, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_fork=3A_initialize_functi?=
 =?US-ASCII?Q?on_graph_state_before_copy=5Fexec=5Fstate=28=29?=
In-Reply-To: <20260822084927.547141-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260822084927.547141-2-Jeremy.Jean@oss.cyber.gouv.fr>
Message-ID: <00C50F65-0241-49EE-AB30-6B61CC6B0799@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 August 2026 08:49:27 BST, Jérémy Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>
>KASAN reports:
>
>[   22.195899] BUG: KASAN: slab-use-after-free in
>function_graph_enter_regs+0xa76/0xb90
>[   22.200747] Write of size 8 at addr ff110000054dc0a8 by task repro/1

Perfect!

>[   22.278296]  __kasan_slab_free+0x43/0x70
>[   22.280157]  kmem_cache_free+0xbf/0x3b0
>[   22.282963]  ? ftrace_stub_direct_tramp+0x10/0x10
>[   22.284001]  free_task+0xa2/0x160
>[   22.285699]  ? ftrace_stub_direct_tramp+0x10/0x10
>[   22.286752]  copy_process+0x2aae/0x7bc0

And the free stack is exactly the mechanism from the changelog,
free_task() under copy_process()'s error path dropping the stack, then
the parent writes into it afterwards. Stable folks will love this.

>diff --git a/kernel/fork.c b/kernel/fork.c
>+ /*
>+  * Must run before the first fallible op, so error paths never
>+  * free the parent's ret_stack.
>+  */
>+ ftrace_graph_init_task(p);

And the comment landed too. Nice!

Reviewed-by: Bradley Morgan <include@grrlz.net>

Thanks!
