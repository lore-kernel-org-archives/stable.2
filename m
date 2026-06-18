Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526C30DD2F
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781821685; cv=none; b=UKgv94mcd/QYWowssifRVpdnrWAl9xseOtfvwl0aXA0Mjw5Ld8x4gu+Gzc3dGXVx9VYaincgny/uswmN1j5koBPizdRD+yf3awlWwNkFOx5HKIuNG8RIFjle+gPHxXjH/FbqlDau8QLtfJlnHO5erDtFnUlJMOj74xy6M6kdrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781821685; c=relaxed/simple;
	bh=ukjsXcZv7riarW/xWZAYC0V9xN3/rjx1quN1mle8vxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxfkGafAw+yeeNvAYmfZ+CFL5FP8Cf0d+nNQBgshXOooINVr1ee+NTAywH/LLnXrjDy/oktwpR2jLv5oX8od1XzKhTsN1jrgyv2yLgztgJb/JHjHVnyGJOgmpHC0HRepZ+vwsvKl4V3Sg6dV2JwmDv9pDcs47X46duYA9plihEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8VauR/o; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8VauR/o"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-915b5ce94c7so182080985a.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781821683; x=1782426483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvWvGzURVdhpVRuCWjrVipteKdwDmCa/WOlEHoQ81l4=;
        b=G8VauR/opxjgJzpBuZI8PeHEnA62gEG2W6ZDJcLFxicx/Usum50gMyzShWYc+bB5Ot
         rGZNcwTljD1A+uk6kQBqYfqYif1mxTwqONQorcddHJppAMChZ9nMKIS4T3yNQixex7JJ
         daaLOLYjRnVOXnV4P4gSqRJ56I+CZJTKFD9qzDSXorSgJwsIhzTY7S25/nJcIE1S3ZMJ
         xxeGAJ+KkLVJuwxZLh3g2oDRrNNNQFi90jJuY2B2Cax/pwaotisVFhkglvD6sKB4vF20
         +O4dMC3ULnMdAmB/G6k9IWycCH36CNGpWBFC+RnzfmqbnYzPRK6y+HUCJ/B0mvR7YKs5
         AQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781821683; x=1782426483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvWvGzURVdhpVRuCWjrVipteKdwDmCa/WOlEHoQ81l4=;
        b=oaWbr1geBgHzKgZI+nUsDV7iI2CpcbP6gPHTJrrSxkVeu498wx/izeIAAKXyIwv/Zv
         Ap8Djiso7GNvTBoregLnOih4kZEA0lsHN/DYQYYkSYyoENnnuSJd1pWLfANlgKCqm96x
         26xHoS3wTtyBjFov/lo0j7u+llgshHFQrdCf07bEfyq35rH6z4sWHNiyDNgaPMLDrNiV
         l1poVeAPkApz7bQUU/LtBvoUTc5V+/kPnLCrItkho0eYlV72UeMgeWhJm57l7swGAKMu
         +fwkFl0pMNJ+SquJZJ3ikkd+QjMX2U0U2cEEzGnbn2E+BjgqJtursM+SLLu8oX1utpx/
         X33w==
X-Forwarded-Encrypted: i=1; AFNElJ/ITltYvuCsk0WaL2upWscdx3lFPfv4/5W+8B+Z+ZyMvS/k6zQazlDNjokFuIdyYRzED8QszVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu67ePCgnzbdQXU6hISEhKeTaGPxnLkMwnBDvptA/LgTWPnrB7
	0XPREPQSH5gljfy9Cj/C+CoIfPif9pRn6fdCPIVkkMDCUbcGdz/rwmzF
X-Gm-Gg: AfdE7cnkYe2VztjWJbPPHWqVeQ/nDY31xxFCz7P0AfGcp3srhsNO26YqnC8a733tQEC
	5p/2u06+4zjtsq9lhj0nzcBNm2Rg76ZkgCLJX7T+OxdgISDzrTg67Q2K+9tQ0XsvH5LWZRLTeMN
	hTi8lqkbzCdesIdrTJZZzx1PS1o3ULNe59tO1RVEvqNq6SqyOeklin8lk93cO00Cz8DVCJugmpB
	wet6BO1DuWBAlwQfP5zOp4S84/BfWMrY6wXIm+4IYUcFO87VMT8qOMpsf8KrEcm1/G+0bWwNmt/
	5jHMglffnsCFYZ2iA+yM7HG8+xvpV09FeQCIJyQxLTmVRoyDK8dPjxUWI0jlcDTdCoVflGbJNAm
	ECPE6kvhEFZOh/u5dJwBhzQ0D6gjoxrkV5Zo8w9fDncIGfmr3LtjVMjoihy6q4nljwB2PXgzK1T
	RdzdhkAORrHon89kd07166gnapeEtK51ywT4KneCQuarkTH9rxTH5RnW/jrytUSrneNDKDmhigV
	ku/5Shay/y7PFLwd6OgYWFi/VFe4P4sYkrx616vbFg=
X-Received: by 2002:a05:620a:2845:b0:911:69a3:1653 with SMTP id af79cd13be357-920910a5da7mr160354085a.46.1781821682307;
        Thu, 18 Jun 2026 15:28:02 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a425448asm48643585a.23.2026.06.18.15.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 15:28:01 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tracing/user_events: fix use-after-free of enabler in user_event_mm_dup()
Date: Thu, 18 Jun 2026 18:27:43 -0400
Message-ID: <20260618222743.538915-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

user_event_enabler_destroy() removes an enabler from the per-mm
mm->enablers list with list_del_rcu() and then frees it immediately with
kfree(). That list is walked locklessly by user_event_mm_dup() during
fork(), under rcu_read_lock() only:

	rcu_read_lock();
	list_for_each_entry_rcu(enabler, &old_mm->enablers, mm_enablers_link)
		...

user_event_mm_dup() does not take event_mutex. The per-enabler destroy
path user_events_ioctl_unreg() (DIAG_IOCSUNREG) takes event_mutex but
nothing that excludes the dup walk. Threads that share an mm share one
user_event_mm and one enabler list, so an unregister on one thread can
free an enabler while another thread is forking and user_event_mm_dup()
is mid-walk. The walk then dereferences the freed enabler (for example
enabler->event in user_event_enabler_dup()).

This is reachable by an unprivileged task that can open user_events_data:
a single multithreaded process that registers an enabler and then
concurrently unregisters it and calls fork() triggers the race. KASAN
reports a slab-use-after-free read in user_event_enabler_dup() called
from user_event_mm_dup() and copy_process() during clone(); with
kasan.fault=panic the kernel panics.

Free the enabler after a grace period with kfree_rcu(), matching the
list_del_rcu() removal and the rcu_read_lock() readers in
user_event_mm_dup(). Add an rcu_head to struct user_event_enabler for
this. The error path in user_event_enabler_create() keeps using kfree()
because that enabler is freed before it is published to the RCU list.

Cc: stable@vger.kernel.org
Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

Notes:
    KASAN on the unpatched tree (v7.1, x86-64, CONFIG_KASAN=y, SMP):
    
      BUG: KASAN: slab-use-after-free in user_event_enabler_dup+0x50a/0x540
      Read of size 8 (enabler->event, 16 bytes into a freed kmalloc-cg-64):
        user_event_enabler_dup
        user_event_mm_dup
        copy_process
        __do_sys_clone
      Allocated by the registering task; freed on another CPU via the
      DIAG_IOCSUNREG path. With kasan.fault=panic the access panics.
    
    After the patch the same reproducer runs cleanly (no splat, no panic)
    across the full window, and a serialized control (same paths, no
    concurrency) is clean on both stock and patched.
    
    Re-ran tools/testing/selftests/user_events on stock and patched, both
    clean: abi_test pass:6/6, dyn_test pass:4/4, ftrace_test pass:6/6.

 kernel/trace/trace_events_user.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c4ba484f7b38b..412ca1e3a40cf 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -109,6 +109,9 @@ struct user_event_enabler {
 
 	/* Track enable bit, flags, etc. Aligned for bitops. */
 	unsigned long		values;
+
+	/* Defer free so RCU list readers (user_event_mm_dup) are safe. */
+	struct rcu_head		rcu;
 };
 
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -404,7 +407,12 @@ static void user_event_enabler_destroy(struct user_event_enabler *enabler,
 	/* No longer tracking the event via the enabler */
 	user_event_put(enabler->event, locked);
 
-	kfree(enabler);
+	/*
+	 * The enabler is removed from an RCU-traversed list
+	 * (user_event_mm_dup walks mm->enablers under rcu_read_lock only),
+	 * so the backing memory must outlive a grace period.
+	 */
+	kfree_rcu(enabler, rcu);
 }
 
 static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
-- 
2.53.0

