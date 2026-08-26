Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D278F2F;
	Wed, 26 Aug 2026 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780804; cv=none; b=qMFQLqv0LwEmiY3oQtMCS0AUbjxRIwCXybgp5cSnC5DaKH0zyJ3ECGKZEauy4bTey8Su19krWF/Mn/DSDYxkI2yNHh65fc4zTVxwbsZlTFWaGJtvyt+Q9NfPegFTZxi+R7qism8jWBVsovw4fyXcLkkICGr0Ebw5P7pcTpyrfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780804; c=relaxed/simple;
	bh=iStlf8tJ0oinW2fZHA1D4kP40nqASzK9RUkYamTmp9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qcJTSxo9EwF2+0awhOEWc291/bikOYbGygmfbw5H3wWO7C98em0Kgxe2rxdCWPTJllaqpYOSsHwjtFpXgpi92iit5jGmn99mUQpT1Wja9c/xhpp/EKXI7aYl6nVsGTrvwtFpg05+ovIRmzHHLEOjgHczfNX+wCoVMoCY6f3ZPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=IPYmpkCr; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="IPYmpkCr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lMJj9HjT6i0dxxy2RFD5wf3f1lDALgXEoJijMOn1zN8=; b=IPYmpkCrwOvqLz8e39zaV6xWQN
	6h/Cp8U/Tjm0pEpL4qUo+CWj/OnATeWWjtLh9yGqH4RR6YbAytu8zCHYmHLSYe15SYzwykBH90St0
	wrIoKrF3OCztJOkD60Cyn37WkFikYCOL03szZX/sbmzWBLJHmT2I6zqhgS1V3bK/qnyTfY372OrYF
	TEeQFgC22zja05UbvRHlkF5niZ53/AvbZzgkOie19l9qsNZJfu4+K2IOcaPV4A+bhCArdBMl+2Yji
	PhuGGHGqmDnPHT4qE4pTyjkjMahphzcqFJbPdDcvUDg7z6ALdjRO8YqBjmm7qDt8HtogWFvbP4MYa
	SIUYYo0w==;
Received: from [151.115.150.205] (port=42794 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wzLSC-00000009vqU-0WYu;
	Wed, 26 Aug 2026 23:46:40 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2] tracing/user_events: Clear copied tracing state before fork duplication
Date: Wed, 26 Aug 2026 21:44:15 +0000
Message-ID: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 


dup_task_struct() copies user_event_mm from the parent into the child,
without grabbing a reference to it. user_event_mm_dup() should
replace it, but it leaves that copied pointer unmodified if
user_event_mm_alloc() fails.

When the child exits, user_event_mm_remove() decrements a reference
the child never owned, which ultimately frees user_event_mm, while
the parent still as a stale pointer to it. This creates a UAF, which
KASAN reports as:

    BUG: KASAN: slab-use-after-free in
    current_user_event_mm+0x51/0x1d0 Write of size 4 at addr
    ffff888005010d30 by task init/44

    Call Trace:
     <TASK>
     kasan_report+0xce/0x100
     kasan_check_range+0x10f/0x1e0
     current_user_event_mm+0x51/0x1d0
     user_events_ioctl+0x82e/0x15c0
     __x64_sys_ioctl+0x139/0x1c0
     do_syscall_64+0xce/0x450
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Allocated by task 44:
     __kasan_kmalloc+0x8f/0xa0
     __kmalloc_cache_noprof+0x180/0x3a0
     user_event_mm_alloc+0x3c/0x1f0
     current_user_event_mm+0x88/0x1d0

    Freed by task 42:
     __kasan_slab_free+0x43/0x70
     kfree+0x13a/0x390
     process_one_work+0x696/0xf90
     worker_thread+0x420/0xba0

The fix simply clears the copied pointer before starting the
duplication, before any possible failure. In case of failure,
the child then has nothing to free.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---

Change in v2:
 Move the pointer reset into user_event_mm_dup(), before the first
 allocation (suggestion by Steven Rostedt).

 kernel/trace/trace_events_user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2bbc89d4a266..339e18085af3 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -865,9 +865,12 @@ void user_event_mm_remove(struct task_struct *t)
 
 void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 {
-	struct user_event_mm *mm = user_event_mm_alloc(t);
+	struct user_event_mm *mm;
 	struct user_event_enabler *enabler;
 
+	t->user_event_mm = NULL;
+	mm = user_event_mm_alloc(t);
+
 	if (!mm)
 		return;
 
-- 
2.47.3
