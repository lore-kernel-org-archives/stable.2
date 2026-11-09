Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213488;
	b=WS0oefYsFU1jVwjTjV1heKf/OyAhdzVi5hp2gszSX6hZt+ofZflYBVwmrv5FJsPDCWF8
	 y4ZNatZggcbs/uVLKPsS4lNoDd21xDT4jKcXYd9mVZ1RVMMRsH59G1e3DNc0Iv2L+xbI5
	 dB0ckCISogoQXdFwTv/wqJoF6B6cH5851iukoEhEIlADKlkf8L4PdhMHIih7sFNetWT1I
	 H5Iza6hG6XEsdwpPNU0MjSNV/OxRZdZxMC4z8UFSrJG3KV9V+OMpdlzITLi7i/3mAXC3v
	 k81CDoYl8A96Nr1WvZQl5SG3W9fvwiLYzH7Fz+FcJGtnOI692Hdd8sce7w2PLknHNLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213488;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=DexF6N5HtJTlHyuSYF0/pzcFrVMrsZPBvnJHzEWC4Vs=;
	b=l/Fgfi6m/S9dKnzffUYRolOhl6GETH4vDFikYrNQRfFh4JMouMHj+Z5OPYFOfnB71w7c
	 sJoQmbVDlrarWuCeuxTSGh8QHuBV41PrFfvVekOpfQgMnv9PdtbflVKouucnKlmTKBZce
	 6a+v6f51FGDAjB5jM9aO+H8D9NYcSrBY5k5gA13/lwFtcggJ/W+S0CnqgIkLmJEclMBK4
	 +Nm3oEHrNcsdM+mLztIped6dve4neimw8RhzsH2WUBIsjuDzpkQdnB29XqX//Bok/+BrJ
	 zKfR+zYacYhT9HxYhV0dXnzAPdD3tjuIvhOT51NHs4TD3ML7XB/6U2ox2aPQfu9NwTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GNvtUzNH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=esdTI3ce;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C368606EE8F;
	Mon,  9 Nov 2026 08:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C368606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GNvtUzNH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=esdTI3ce
Date: Mon, 09 Nov 2026 08:38:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794213486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DexF6N5HtJTlHyuSYF0/pzcFrVMrsZPBvnJHzEWC4Vs=;
	b=GNvtUzNH4g5F4BkYeCJtsDTtmIqleAsPz8wZuc5xrd2LT4d4Qz3Nuy5ojm9BOqN5mC7cr+
	l70uH+RHJnUQijvsGDimSUiEkZFVvmeHERSqcsO+BGWFqrAJ+49nKqUoBp8+BHbpn8ZVv6
	/VMSY11k3MJQHsmg6xZVTNcCpnJftqdAqvHpb4yTNR9BcEsqQDoo8IbqnYVeeqWiRli9Nw
	VxgJlIS9zxAluBhPf5hBuMMBqcjVVqJdqEYsOyiN5iDe8CegZVMzKLhO8JPVfsIOtIeY4q
	OlQPNrw9K5NNU1EkjLan9uzOk3doyV4N6YU+2l+6OB93vs7A1PBTaX21wOBqog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794213486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DexF6N5HtJTlHyuSYF0/pzcFrVMrsZPBvnJHzEWC4Vs=;
	b=esdTI3cebGNn7iA7zr/abi+nZikY1tzKupuA3/c1q70clXbAVEAMyglpSjtg1NVPbaupjC
	ysNvb+9D1RfRfYCA==
From: "tip-bot2 for Paolo Bertinetti" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tracing/perf: Clear stop state in perf_trace_add()
Cc: Francesco Nigro <nigro.fra@gmail.com>,
 Paolo Bertinetti <paolobertinetti200f4@proton.me>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103130732.764081-2-paolobertinetti200f4@proton.me>
References: <20261103130732.764081-2-paolobertinetti200f4@proton.me>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179421348457.2093942.5595845354188628427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     fb3f6b21b04f1e8b8982e90e9bf62db9f0dcb5e4
Gitweb:        https://git.kernel.org/tip/fb3f6b21b04f1e8b8982e90e9bf62db9f0d=
cb5e4
Author:        Paolo Bertinetti <paolobertinetti200f4@proton.me>
AuthorDate:    Tue, 03 Nov 2026 13:07:48=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Nov 2026 11:45:14 +01:00

tracing/perf: Clear stop state in perf_trace_add()

Since commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage"),
__perf_event_overflow() stops the event with pmu->stop() and disables
it when the PERF_EVENT_IOC_REFRESH limit is reached. When userspace
re-arms the event with PERF_EVENT_IOC_REFRESH, the event is enabled
again and pmu->add() is called with PERF_EF_START.

perf_trace_add() sets PERF_HES_STOPPED when PERF_EF_START is missing,
but never clears it. The flag set by pmu->stop() stays, and
perf_tp_event_match() drops every later hit. A tracepoint, kprobe or
uprobe event re-armed this way delivers only its first overflow. This
breaks self-profilers such as async-profiler, and the "Event re-armed
with PERF_EVENT_IOC_REFRESH" perf test fails:

  1000 events, count 1, 1 overflows (1 POLL_HUP), re-arm errno 0
  Tracepoint event : FAILED!

Set the state from PERF_EF_START on every add, as perf_swevent_add()
does.

Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
Closes: https://lore.kernel.org/r/20261021131006.2101248-1-nigro.fra@gmail.co=
m/
Reported-by: Francesco Nigro <nigro.fra@gmail.com>
Assisted-by: LLM
Signed-off-by: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://github.com/async-profiler/async-profiler/issues/1813
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261103130732.764081-2-paolobertinetti200f4@p=
roton.me
---
 kernel/trace/trace_event_perf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 5b27285..a549897 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -354,8 +354,7 @@ int perf_trace_add(struct perf_event *p_event, int flags)
 	struct trace_event_call *tp_event =3D p_event->tp_event;
 	struct hw_perf_event *hwc =3D &p_event->hw;
=20
-	if (!(flags & PERF_EF_START))
-		p_event->hw.state =3D PERF_HES_STOPPED;
+	hwc->state =3D (flags & PERF_EF_START) ? 0 : PERF_HES_STOPPED;
=20
 	if (is_sampling_event(p_event)) {
 		hwc->last_period =3D hwc->sample_period;
