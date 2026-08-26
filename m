Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056C486639;
	Wed, 26 Aug 2026 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783835; cv=none; b=UTDoHXK1B4CEUer8zq9ri+/kcAtxcPiIJ35sBpf2bqPDcxqzYq/TIFA93MDHzFjgo8Q9DPXFb4whqz6UeqJlz7A9RPZkjT8/UZxnrUe0jzAMqhcpPRSTSyqR628mgc8jwqqwKrVXud3284x3FGqugGhhozftcEzVgnyE2mrvVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783835; c=relaxed/simple;
	bh=6LYYd/IuqIErEpJpiR8BuFC2SvdVBbN1Eb8PqyemHjI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=O7h3hZ9oxBMQ8Z4d8+M7elRHiWIy8+7FkoYICuQx3qewRfcdvs38d5U4Mz7+22RHqgbxtrYcP4duLJ59v543zJuTWuMtuvvbloKzDLT13nLC6CQBhwBPOn0F8Z2FTyPeZhPBDftwvj0DlOG45hkHTdoakMtKoKTXtwAT0MDpBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=BRASq03C; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=pjxSsn1Y; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="BRASq03C";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="pjxSsn1Y"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787783830; bh=fTKRjP6ptCaB8YYJRJOWdjp
	UAbKGcs5ufbievo673nQ=; b=BRASq03C16CjyOaM/uEorvsbRsOIgB/pPVcIyXI9QQhqLfl0nJ
	tRgIPAYp8W1lAwWwf3ez3u/q6o1eGkqvrJoKWKMnhyhbos7CqIyG0YehhcUiWPNlyMv05nxQtFb
	2Qf6e5O+xvnWUQjtNpSYOA8TqThnQ3biBmpNucBp6e9M1tnz1OcbJ7p2KEmjBQD8brvePXzoRBB
	yZROSNnK99jMc5OgVdQU+uFdt4Z4dctN4z+N95pUUjsdOpTDMB38ckOXBOsWJVxQqsz9950CvMJ
	P+QoMwc9Lam8f3uIh7FIzciRJAiDwdj65OHAUnPLh5J9r62GdXCvnrwpdTUuyt4Wk7A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787783830; bh=fTKRjP6ptCaB8YYJRJOWdjp
	UAbKGcs5ufbievo673nQ=; b=pjxSsn1YG7u/aNv/6YD6Y0zRJqs3k1Djoj/Vk2FNbk7zaYCaSv
	EHKxhCcpgM2KjxRyDibn8Bg9zCrw7loDKyCg==;
Date: Wed, 26 Aug 2026 23:37:12 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 rostedt@goodmis.org, mhiramat@kernel.org
CC: mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_tracing/user=5Fevents=3A_Clear_c?=
 =?US-ASCII?Q?opied_tracing_state_before_fork_duplication?=
In-Reply-To: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
Message-ID: <5B7C72AA-5655-4916-AB17-03A8B94F5D7C@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 26 August 2026 22:44:15 BST, "Jérémy Jean"
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
>dup_task_struct() copies user_event_mm from the parent into the child,
>without grabbing a reference to it. user_event_mm_dup() should
>replace it, but it leaves that copied pointer unmodified if
>user_event_mm_alloc() fails.
>
>When the child exits, user_event_mm_remove() decrements a reference
>the child never owned, which ultimately frees user_event_mm, while
>the parent still as a stale pointer to it. This creates a UAF, which
>KASAN reports as:
>
>    BUG: KASAN: slab-use-after-free in
>    current_user_event_mm+0x51/0x1d0 Write of size 4 at addr
>    ffff888005010d30 by task init/44
>
>    Call Trace:
>     <TASK>
>     kasan_report+0xce/0x100
>     kasan_check_range+0x10f/0x1e0
>     current_user_event_mm+0x51/0x1d0
>     user_events_ioctl+0x82e/0x15c0
>     __x64_sys_ioctl+0x139/0x1c0
>     do_syscall_64+0xce/0x450
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>    Allocated by task 44:
>     __kasan_kmalloc+0x8f/0xa0
>     __kmalloc_cache_noprof+0x180/0x3a0
>     user_event_mm_alloc+0x3c/0x1f0
>     current_user_event_mm+0x88/0x1d0
>
>    Freed by task 42:
>     __kasan_slab_free+0x43/0x70
>     kfree+0x13a/0x390
>     process_one_work+0x696/0xf90
>     worker_thread+0x420/0xba0
>
>The fix simply clears the copied pointer before starting the
>duplication, before any possible failure. In case of failure,
>the child then has nothing to free.
>
>Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
>Cc: stable@vger.kernel.org
>Assisted-by: Codex:gpt-5
>Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>---
>
>Change in v2:
> Move the pointer reset into user_event_mm_dup(), before the first
> allocation (suggestion by Steven Rostedt).
>
> kernel/trace/trace_events_user.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
>index 2bbc89d4a266..339e18085af3 100644
>--- a/kernel/trace/trace_events_user.c
>+++ b/kernel/trace/trace_events_user.c
>@@ -865,9 +865,12 @@ void user_event_mm_remove(struct task_struct *t)
> 
> void user_event_mm_dup(struct task_struct *t, struct user_event_mm
> *old_mm)
> {
>-	struct user_event_mm *mm = user_event_mm_alloc(t);
>+	struct user_event_mm *mm;
> 	struct user_event_enabler *enabler;
> 

Comment?

/* Failure must leave the child with no copied state to free. */

I mean, okay, you don't got to, but itd be nice, if your happy with it, add

Reviewed-by: Bradley Morgan <brads@mainlining.org>


Also, let me talk about one of Steve's nits a bit, yk, the one where he
says the description is too long

Maybe you could add this to your memories


"The description length should be about the same as the change being
added,unless there is a splat, or something else like a table which needs
to be added to the description, keep the description length the same as
thepatch size, e.g:

Instead of doing 3 paragraths about a one liner, we could do a small two
or more line description describing:

What causes the issue?
Why is it bad?
How did you fix it?"

That should work for you. Just to prevent annoying other maintainers 


>+	t->user_event_mm = NULL;
>+	mm = user_event_mm_alloc(t);
>+
> 	if (!mm)
> 		return;
> 
>


--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
