Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958621;
	b=VyfueOkOrpre8xMeg0qaML9pNzbaxguY62g6qs2I1/hv1aMLlOH1NW+zpaa9BqeJh9u2
	 whwJ+xLTb7Gl6eZJStGcDsMuUmStd+LJc3Uv1jVHSDuEKv3tHF1ctfFBPQJ0qMxQLFnyv
	 sGXGaIqhP0fEsoZq+FnS/B3ZtYc28Js0TMMy7ZMz/FO00asDkRyfKCFd5GAv2EE/fKZLM
	 z/OYzy6yVDxaHkslBVmhidAzS10MLgHFuRyJNC72v1PMPa6GFr4cVHmgJ3s3/yBZUzjQX
	 79K7l7HgTxjRaAAn695yf1QwnPtTmPFCqMHjsmZsNGA7mHIaj0oqbiUiCKbPOrEMEdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958621;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=PrvLdzz4nUdrlG1n4FX1WhKiO+8w3aSYi2fAWOp5h80=;
	b=a4Z1jtWOA5QPAWEQuSd7QFd/GsEtZZXUvD+aEg+W9Svh0bTlfuEG6VUJ+9c1nw7CCXM6
	 FD2EAGlfo8Bss/azE3xSYOJXDAanmnYwEDhlqiI+GPWpMBUgIjzNcVwput53001NqYH+C
	 rbWLDMcHZyG9HKVSsrwy91TKkAhdE0NvkjNY2JD+OkbIfMK6+8ksb5D/clICyctgikEVy
	 1/XT6KJF5MpLWhn98mUWBGuQzwHgucpGadvuShMBoMpeu855TSTJGR5S/H0iC29ov7Ipn
	 jVjDHbjtoZbnjQRDf/UmgDh/4t5ut7QLTqxu4xmn4rgP1N6g0ZgMKNkveF9nFZRHASQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CTrfhaO5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="/jgAQEV6";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D98606A326;
	Fri,  6 Nov 2026 09:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D98606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CTrfhaO5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/jgAQEV6
Date: Fri, 06 Nov 2026 09:50:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793958619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrvLdzz4nUdrlG1n4FX1WhKiO+8w3aSYi2fAWOp5h80=;
	b=CTrfhaO5TtDPZyyxIrjoOD9k7o8kH5YZxhJwdoctxui/zmrx2lBl+05tUUZT0NjdCGfgiD
	HRTBXK6kYxR72ERV3C4l8BErfEQ+UhHHCSDtaq0St76qDNU8dAVyhMhbt3ddKoOM+GWDrz
	uIH0yzuXWA8It5hdMsB43TZt/VNFc2KP4O5sQI9TpYOBVVVfywyvf83YBUqzHimp8dlOfu
	j0Kfup06euyaHJzyhA1WGhg23BSpUNh0jL3dGTS13ejKN02GC6+KT5Pzq7qWHcYAGQFmJ7
	Uj8w4nZ1YQyUmL+Tb6zhfChEwxLLBhheqZHBwv7IxeSpqwPN/4p1cjUW3Xpy2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793958619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrvLdzz4nUdrlG1n4FX1WhKiO+8w3aSYi2fAWOp5h80=;
	b=/jgAQEV6ygAdjNQt2LJG6ULr+Bipl+xUg40rg8xgZWYetiu5cNWIUYejsekLW7d0cDQ+Dm
	caajlgbb8vMtuTAQ==
From: "tip-bot2 for Danish Khateeb" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/core: Don't send SIGTRAP after exec removed the event
Cc: Danish Khateeb <danishkhateeb03@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261015152013.106040-1-danishkhateeb03@gmail.com>
References: <20261015152013.106040-1-danishkhateeb03@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179395861652.1009794.424069286804285863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6f083fbccd5f06889bc08e1182bd02c0383b9121
Gitweb:        https://git.kernel.org/tip/6f083fbccd5f06889bc08e1182bd02c0383=
b9121
Author:        Danish Khateeb <danishkhateeb03@gmail.com>
AuthorDate:    Thu, 15 Oct 2026 10:20:13 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Nov 2026 09:52:11 +01:00

perf/core: Don't send SIGTRAP after exec removed the event

A sigtrap event must also set remove_on_exec, so that its SIGTRAP never
reaches a program after exec. But the signal is sent from task work,
which only runs on the way back to user space. If the event overflows
shortly before execve(), the task work can still be pending when the
task enters execve(), and then runs when execve() returns. By then
perf_event_exec() has removed the event and the new program has default
signal handlers, so the SIGTRAP kills it.

The exec_stress test in the remove_on_exec selftest catches this and
fails about half the time in a VM. A process that opens a sigtrap event
on itself and then calls execve() is killed by SIGTRAP in 15% to 50% of
runs, both on an AMD machine running v7.2 and in a VM, with or without
close-on-exec on the event fd.

Commit ffb684f2aa14 ("perf: Fix race between perf_event_exit_task() and
perf_pending_task()") made perf_sigtrap() return once
perf_event_exit_task() has set ctx->task to TASK_TOMBSTONE. Exec only
calls perf_event_exit_task() when the new program is not dumpable, such
as a setuid one. An ordinary exec keeps the context and only removes the
remove_on_exec events, so the SIGTRAP is still sent.

perf_event_exit_event() sets PERF_EVENT_STATE_EXIT when exec removes the
event. If the event fd is close-on-exec and was the last reference to
the file, exec also queues the file release as task work. Task work runs
newest first, so perf_release() runs before the SIGTRAP work and moves
the event on to PERF_EVENT_STATE_DEAD. So don't send the signal when the
event state is PERF_EVENT_STATE_EXIT or lower, which means the event has
been removed. That also covers PERF_EVENT_STATE_REVOKED, where the PMU
is gone.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261015152013.106040-1-danishkhateeb03@gmail.=
com
---
 kernel/events/core.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 51bca42..f5f2261 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7647,6 +7647,15 @@ static void perf_sigtrap(struct perf_event *event)
 		return;
=20
 	/*
+	 * The event was removed after this signal was queued, e.g. by exec()
+	 * (remove_on_exec), which may also have closed its fd (close-on-exec).
+	 * The new program has default signal handlers, so a SIGTRAP would
+	 * kill it.
+	 */
+	if (READ_ONCE(event->state) <=3D PERF_EVENT_STATE_EXIT)
+		return;
+
+	/*
 	 * We'd expect this to only occur if the irq_work is delayed and either
 	 * ctx->task or current has changed in the meantime. This can be the
 	 * case on architectures that do not implement arch_irq_work_raise().
