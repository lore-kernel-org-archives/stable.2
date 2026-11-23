Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427058;
	b=tWpVqVXcS6KeJYYGO+JCgvGeP4OM+R1DzeJh8bX4Z/VW0zn0xFqgjwYijsqrNZNBNXgs
	 Rn9vRSQuifQwP2L8MrjAs3GgCQyHXzve4eqqdPhV3kKUs7g29w4RHpB7n8YYLSc+h0gsr
	 BkHhN+ycLk644hKKOL35R5HksrbOQzc3JvSja4Ckqgrz4y1RRqG//j6aIr4VegXON7pQN
	 1Zv98/45GONOPQpYMPOPVCYwlrX+W/SkK1zV/lBcVR7E8xOxOFgw3owWi6qbIEt+4F8dy
	 +RHVGaagbu2J2ljfzspOHE56vaxA/lQVQqdUkB+CzUO4v64ovUXAvn32i5OpTpSXWRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427058;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Bi/9twiPsVJyJiR3gEOlYW5Jbq3suRd9glq0z9umrII=;
	b=2kCnduDFxH5eu5En6FMUCjkwTzRgeMrIn+yTDZ4ONT7FOb5u1sNKkANtMoWUKz1aqXKL
	 X4bmztWl5IeM0EODd1B1WnigsdkvTz0Q7SmNKbYgMWI6tu27tZ7rus+lLMs+yoXLT95qG
	 oZDZ0gJnR/+7Qlt4M8hI2FXebqplzd/WZq+py/S+WRbvVRdmAV2YDFa8XTmQoRrKMeqU0
	 XvcS7g+iUESZCk+d+Dn0hfTzDvPJMODsfPa61vMKlkwrVS4j3tWzX8NRp9wqeou1uzYXj
	 EGrAlMi5zyHgTx4SFizEi4l2Qx5TPzjc6gxa9NxHXgD4ggSXCk8n0l2qKlwHU8LoftA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GnuYDfqZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=oLGZuEAn;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D72606A33A;
	Mon, 23 Nov 2026 09:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D72606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GnuYDfqZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=oLGZuEAn
Date: Mon, 23 Nov 2026 09:44:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795427056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bi/9twiPsVJyJiR3gEOlYW5Jbq3suRd9glq0z9umrII=;
	b=GnuYDfqZdWrxCKIWoJFtsNOKviNyWio6waP0g4JLMrrGiPeeG002L9pOSjapmsxZOpnmSv
	2BgM1CbsVw+LPScpcYWLCPWTvrSJYjDCY95kZdzBYtiEw59GVmLsHiygMNaUUa9R0TRH+q
	GYdW/j86FPOK0EGcs2iqaqdU9dKUtBJ7qduLi5KrH9/swN0PhI8FcxAQcsGG5V4y4ZTG0t
	RWKkGfgf3w0EqZd3bCMnViSany1MDejzvmRSHm/e4dvTjomI+aETuh5fN1tC/IhVHm29uV
	+Syr8TKolCrlQlrTVlANsfGAd8a5EyJvy487N76Fl4D8sx2ItG9LcK/Imy/Q2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795427056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bi/9twiPsVJyJiR3gEOlYW5Jbq3suRd9glq0z9umrII=;
	b=oLGZuEAn4/7wMzabqu9pyrX0RPVfA/LoHTDuYkr+BsdvB+6gf0nLyFCwMOl5jisEXMAz7f
	+E127hhkvLV5rHBw==
From: "tip-bot2 for Phat Dinh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix UAF from remove_on_exec with
 perf_event_open()
Cc: Phat Dinh <phatdt1116@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103085641.3686424-1-phatdt1116@gmail.com>
References: <20261103085641.3686424-1-phatdt1116@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179542705398.92412.11992365818769639929.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4aa81df6bb45e9cf693c86849fe90d4e3dd85bbc
Gitweb:        https://git.kernel.org/tip/4aa81df6bb45e9cf693c86849fe90d4e3dd=
85bbc
Author:        Phat Dinh <phatdt1116@gmail.com>
AuthorDate:    Tue, 03 Nov 2026 15:56:41 +07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 23 Nov 2026 10:37:47 +01:00

perf/core: Fix UAF from remove_on_exec with perf_event_open()

perf_event_open() installs the event into the target context and then
drops the target's exec_update_lock before linking event->owner_entry
into current->perf_event_list. This leaves a window in which the
target can exec() while the event is live in its context but not yet
on the owner's list.

If the event has attr.remove_on_exec set, perf_event_remove_on_exec()
detaches it in that window through perf_remove_from_owner(), which
does list_del_init(&event->owner_entry) on the not-yet-linked entry
and clears event->owner. perf_event_open() then continues and adds
the now ownerless event to current->perf_event_list:

  CPU 0: perf_event_open()          CPU 1: target task exec()
  ------------------------          -------------------------
  perf_install_in_context(event)
  event->owner =3D current
  up_read(exec_update_lock)
                                    down_write(exec_update_lock)
                                    perf_event_remove_on_exec()
                                      perf_remove_from_owner(event)
                                        list_del_init(&event->owner_entry)
                                        event->owner =3D NULL
                                    up_write(exec_update_lock)
  list_add_tail(&event->owner_entry,
                &current->perf_event_list)

When the event fd is closed, perf_release() sees event->owner =3D=3D NULL,
skips unlinking owner_entry and frees the event, leaving a dangling
entry on the opener's perf_event_list. The next walk of that list,
e.g. perf_event_exit_task() or PR_TASK_PERF_EVENTS_{EN,DIS}ABLE,
is a use-after-free.

Fix this by linking the event into current->perf_event_list before
releasing exec_update_lock, so exec() cannot observe the event until
it is fully published. Lock order is exec_update_lock ->
perf_event_mutex, the same as perf_event_exit_task() called from
exec, so no new dependency is introduced.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Signed-off-by: Phat Dinh <phatdt1116@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261103085641.3686424-1-phatdt1116@gmail.com
---
 kernel/events/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a2e4b07..51c251c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14420,15 +14420,22 @@ SYSCALL_DEFINE5(perf_event_open,
=20
 	mutex_unlock(&ctx->mutex);
=20
+	/*
+	 * Publish the event on the owner's list before dropping
+	 * exec_update_lock. Otherwise a concurrent exec() can run
+	 * perf_event_remove_on_exec() and clear event->owner before
+	 * owner_entry is linked, leaving an ownerless event on
+	 * current->perf_event_list that perf_release() won't unlink.
+	 */
+	mutex_lock(&current->perf_event_mutex);
+	list_add_tail(&event->owner_entry, &current->perf_event_list);
+	mutex_unlock(&current->perf_event_mutex);
+
 	if (task) {
 		up_read(&task->signal->exec_update_lock);
 		put_task_struct(task);
 	}
=20
-	mutex_lock(&current->perf_event_mutex);
-	list_add_tail(&event->owner_entry, &current->perf_event_list);
-	mutex_unlock(&current->perf_event_mutex);
-
 	/*
 	 * File reference in group guarantees that group_leader has been
 	 * kept alive until we place the new event on the sibling_list.
