Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592662367D3;
	Fri, 31 Jul 2026 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487983; cv=none; b=PLhCJIVgRGbtvCREx5JspjJSpBJTcuABv1VgghqYIIT0D3OePpSdAnm79dZk3Ad3I90VTYjquwIyFz8W6Hw+qkP6UodYA2gzMQ6X0F0pa7FnuseoTZDAenpnpbyPlRckQ6tkbNuy5oAx59QR6A0xYdqoioQGrHmLKlpIRI3tOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487983; c=relaxed/simple;
	bh=hGvPvi9hpoNiYlPziA99tW1M2wQfXGimUjtaeyDJM3Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=irl+aLzloAaku3HBgJrFmKfe+u6TbYk6m1I7ONG4hGuv5uJgExyGaxqVVTqp9POdqc79i1nCSYS/JB446f0KjmFJgzX4HScQHs/W8e6DFDt38Ong00wBTulSpBzo8Hls/KXzK7k41/MVYTc3clmzDGkmBvypVIgZY+EXTMGDEZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WjdCJ85h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOC3/r9k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WjdCJ85h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOC3/r9k"
Date: Fri, 31 Jul 2026 08:52:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785487979;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqchIc4zwyvYsTm5ajlB9kHQ88ty62hLkZmYzP4/Fmg=;
	b=WjdCJ85h6Sz8946rjHgvqltcInwZqWFNMZsEGXJfAUJs9M3Y9ujuT2AZBAQTYmB4woODKy
	BMU/cpocsefeghkci2v6+MbA8qBVLzScRxbxx6ohoWjEhyeQRa1I18Q8JCiquNgrnfQarO
	OAjevFYOTR5wy46olfAm7oYQOeeN7QSJOERkiVj+yeUNRgAg5wuE0PdybV3NpdnJONWEjj
	iWFCytgGzXpD8yTYkpWdxQcVmYQ4lzp41AL6/bHBtu5vCgZIPA8rND1eBp0m23UTO1wXxV
	UEgK1txBC9QI9hzGsrzh19y3N/KnAf5QV3KB6Uhlo+ACkGDiYlTFidw6yFj/cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785487979;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqchIc4zwyvYsTm5ajlB9kHQ88ty62hLkZmYzP4/Fmg=;
	b=sOC3/r9kIDQAEbhmX0BXTuoUa19MHCmajviA0sCNrzMdC82FYLWtqqaaLDxYa05dFHHUng
	TBjjHgWPv/aXR/CQ==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] uprobes: Fix NULL pointer dereference in hprobe_expire()
Cc: Breno Leitao <leitao@debian.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260729-uprobe-v1-1-61896b87c867@debian.org>
References: <20260729-uprobe-v1-1-61896b87c867@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178548797804.112641.4838093438132290110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     cc679d7a6303e84d769f2afcde1fc51c51f127cd
Gitweb:        https://git.kernel.org/tip/cc679d7a6303e84d769f2afcde1fc51c51f=
127cd
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Wed, 29 Jul 2026 07:44:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 31 Jul 2026 10:32:19 +02:00

uprobes: Fix NULL pointer dereference in hprobe_expire()

Forking a task that has a pending uretprobe can oops the kernel with a
NULL pointer dereference in the clone() path:

  BUG: kernel NULL pointer dereference, address: 0000000000000018
  Oops: 0002 [#1] SMP NOPTI
  RIP: 0010:hprobe_expire
  CR2: 0000000000000018
  Call Trace:
   uprobe_copy_process
   copy_process
   kernel_clone
   __x64_sys_clone
   do_syscall_64
   entry_SYSCALL_64_after_hwframe

This was found on real hosts on Meta fleet.

I've got the impression that this is what is happening:

  CPU 1                          CPU 2 (traced task)
  -----                          -------------------
                                 hit uprobe, prepare_uretprobe():
                                   hprobe LEASED, refcount >=3D 1
  uprobe_unregister()
    put_uprobe(): refcount -> 0
                                 fork() -> dup_utask()
                                   hprobe_expire(hprobe, true)
                                     try_get_uprobe() -> NULL
                                     get_uprobe(NULL)   <-- Oops

Only take the extra reference when the uprobe is non-NULL; a NULL means
it is gone and is the correct value to return.

Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with timeout)=
")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260729-uprobe-v1-1-61896b87c867@debian.org
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4084e92..6300b21 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -830,7 +830,7 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe=
, bool get)
 		if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_G=
ONE)) {
 			/* We won the race, we are the ones to unlock SRCU */
 			__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
-			return get ? get_uprobe(uprobe) : uprobe;
+			return get && uprobe ? get_uprobe(uprobe) : uprobe;
 		}
=20
 		/*
