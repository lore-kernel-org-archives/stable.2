Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772997;
	b=mS0/1CMO432uHOpvXHWgc/qzsVTZztu5wNzxWNedwkS4iPpswy7BlzDVFEQxFPPmbOUW
	 kcuXs4o/RrGXchKQ9kKUHvRQpf1tWHJ/6ZbOBPHgBGHMWb+4lwFlnxSg14hI8JcU61bdB
	 oz3x9L09UiKVJWdkDN5d6Cp7/5J4S0t68fzUCbNBQ/6U3yzySL9ZunEomU0A6igdWnfmh
	 M/qu7lDAjX6MKJpThABWPAScZJ5OZ9jlNbrU0lwEwkb5RKoqWgafwetroeopmt+WVCH1n
	 4IHxrDY+cMkOXTxdYqMB/ZjbwdrgkzxZMWw+L0dSaQFS7DIOFaJfyNf7r+H3knNGjSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772997;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=8qcXglV3ccGraSlpDQigzkuVwJhAWsgF1bHwT1/2QvM=;
	b=k0aFdp69TvhQHiijv9YkJF6q7fXXkmXKmuwc/xH67FYcrBCEZfUI8nJJe3+TIkNxaOZc
	 XUKr9dVG941iWrhQtka/RNK//O5SSgZA5ErmeDOwVskj5FY/RGDEM+MrtbUQ2p3UzSCad
	 /mIaz6+MuN4dzBNVCwpRULyQ3vXa+dH9xk8OGeREXSU4U0gsSiAENkSWWU1D2eMy04has
	 3/surQgmYK4/Z/C7uVnTv/dcEStIM209suKUE5LYZDKdVuP0zYxCEgoqOiShHbQ9E3CBJ
	 /RM6rYCBKlYIMIvyzzprWlYNg9TRDbHWIGA/mSMDacYvQpaGVayvXAsaNlI+g6w34HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=yNbCzFCZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WCEDcPWr;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04056606A684;
	Fri, 27 Nov 2026 09:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04056606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=yNbCzFCZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WCEDcPWr
Date: Fri, 27 Nov 2026 09:49:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795772993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qcXglV3ccGraSlpDQigzkuVwJhAWsgF1bHwT1/2QvM=;
	b=yNbCzFCZ5PE8pfOP2q7bnKOCAhPpCcCgomu8i+sk3wy7M+iztX0OFrFYTL1Nsb91/9JqBB
	3b6+clHjj2H9TjPbUXMiUEZRr8hF+xK67P5Mfi/AkswzsW3cg9iUujJqe/YJvd+Zmkdojt
	KXhPKqh7fuIFUJ37fY7DT1EQN76JkuivDtoGR+jz+oi9PC2nQhKFROZw41YkDhgfauPElx
	j8/5Ba0ourfhl2inL/jGPQwQDfD3ipLHknEYdPQWDs8QQnB3NAKrKYzzAC8NpA80GSTRPq
	iQZ0z4V0iu3aBcOuVN3DyC0eFdmozr7Zw48gy0QM4qzk492Cc7BF1ggSp/Rudg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795772993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qcXglV3ccGraSlpDQigzkuVwJhAWsgF1bHwT1/2QvM=;
	b=WCEDcPWrqaiEiDEIVYRxT7bKaAKcAf+DM1xwvOqdgyUTmFm7vgfIbryKaaP26iGZa3XfKp
	cr/s+UKO16wo/LAA==
From: "tip-bot2 for Jay Hilton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Use the elapsed period for
 frequency-mode period adjustment
Cc: Jay Hilton <jahilton@janestreet.com>,
 Gregg Leventhal <gleventhal@janestreet.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,  <stable@vger.kernel.org>,
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261117152351.1294050-1-gleventhal@janestreet.com>
References: <20261117152351.1294050-1-gleventhal@janestreet.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179577299177.92412.18280468441258006136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     67b34211a9eb103aba474bc179fab3dd2912f07e
Gitweb:        https://git.kernel.org/tip/67b34211a9eb103aba474bc179fab3dd291=
2f07e
Author:        Jay Hilton <jahilton@janestreet.com>
AuthorDate:    Tue, 17 Nov 2026 15:23:51 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 27 Nov 2026 10:41:45 +01:00

perf/core: Use the elapsed period for frequency-mode period adjustment

In frequency mode, __perf_event_account_interrupt() estimates the event
rate from hwc->last_period and the time since the previous overflow,
and passes it to perf_adjust_period().

The PMU drivers re-arm the counter before they call
perf_event_overflow(), and re-arming sets hwc->last_period to the
period of the next interval. The estimator therefore divides the next
period by the time the previous one took. While the period ramps up
from its initial value, each period is much larger than the previous
one, so the rate is overestimated by that ratio and the period
overshoots its target.

On an AMD EPYC 9655P running v7.3, sampling user-mode cycles at 11 Hz,
the period jumped from 21.9M to 2.3G cycles, 5.6x the target, and the
next sample arrived after 544 ms instead of 91 ms. When the overshoot
exceeds 8x, the next tick's perf_adjust_period() resets period_left,
and the cycles counted before the reset are not attributed to any
sample (145M in that run). Intel and AMD IBS show the same overshoot.
On Intel, intel_pmu_freq_start_period() hides it for the default
hardware events, but not for raw events.

Since commit 1734d98fbcce ("perf/arch: Record sample last_period before
updating on the x86 and PowerPC platforms"), the PMU drivers record the
elapsed period in data->period before re-arming. Pass that to the
estimator instead of hwc->last_period. perf_event_account_interrupt(),
which has no sample data, keeps using hwc->last_period.

This fixes the overshoot reported in the Closes: thread.

Tested on v7.3 with and without this patch, using the reproducer from
the report and repeated runs (user mode, 11 Hz unless noted). Runs
with the bug, i.e. a period over 2x the target or a sample whose period
doesn't match the cycles counted:

  AMD EPYC 9655P (Zen5), bare metal   v7.3         v7.3 + patch
    cycles                            50/50        0/50
    instructions                      50/50        0/50
    raw cycles                        50/50        0/50
    cycles, 4000 Hz                   10/10        0/10
    IBS (ibs_op, incl. kernel)        20/20        0/20
    max period / target               up to 7.0x   1.00x

  Intel Xeon Platinum 8468, bare metal v7.3         v7.3 + patch
    raw cycles (0x3c)                 49/50        0/50
    cycles                            0/50         0/50
    instructions                      0/50         0/50
    max period / target               up to 6.8x   1.02x

(On Intel, intel_pmu_freq_start_period() already keeps the default
events close to the target, so only the raw event shows the bug.)

With the patch, the period approaches the target from below, as the
low-pass filter intends (9655P, target ~411M cycles):

        period      counted    dt(ms)
          2371         1791     0.001
         11854        11880     0.004
      28341794     28341765     6.284
     251213029    251213027    55.579
     411087485    411087548    90.895

All perf_event_overflow() callers under arch/ and drivers/ in v7.3
initialize the sample data with the period recorded before re-arming,
so data->period is the elapsed period on every path we checked.

perf_event_account_interrupt() still passes hwc->last_period, and this
patch doesn't change its callers. Two of them run after the counter
has been re-armed, so they still feed the estimator the next period:
perf_ibs_handle_irq() when it discards a sample (user/kernel mode
filtering, the load-latency and fetch-latency filters, and the
zero-RIP erratum workaround), and powerpc's record_and_restart() for
an invalid SIAR. The Intel PEBS error path runs before re-arming and
is fine. We haven't measured the IBS discard case; if it's worth
fixing, those callers could pass the elapsed period too, in a
follow-up.

On kernels without 1734d98fbcce, x86_pmu_handle_irq() and
handle_pmi_common() still put the next period in data->period, so a
backport there also needs 1734d98fbcce.

The original change was written by an AI coding assistant in Jay's
session. This version, the changelog and these notes were prepared
with an AI coding assistant; Jay and I reviewed them, and I ran the
tests above.

Fixes: abd50713944c ("perf: Reimplement frequency driven sampling")
Signed-off-by: Jay Hilton <jahilton@janestreet.com>
Signed-off-by: Gregg Leventhal <gleventhal@janestreet.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Link: https://patch.msgid.link/20261117152351.1294050-1-gleventhal@janestreet=
.com
Closes: https://lore.kernel.org/all/CAFN_u7G94CC_RGL1La66jX+jRKHSJdAB5PKkTRSW=
rUvqhM48oQ@mail.gmail.com/
Assisted-by: LLM
---
 kernel/events/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 08f0e0f..4ab3919 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10759,8 +10759,15 @@ void perf_report_aux_output_id(struct perf_event *ev=
ent, u64 hw_id)
 }
 EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
=20
+/*
+ * @period is the period of the interval that just ended. PMU drivers
+ * re-arm the counter before calling perf_event_overflow(), which sets
+ * hwc->last_period to the period of the next interval, so the overflow
+ * path passes the sample's period instead.
+ */
 static int
-__perf_event_account_interrupt(struct perf_event *event, int throttle)
+__perf_event_account_interrupt(struct perf_event *event, int throttle,
+			       u64 period)
 {
 	struct hw_perf_event *hwc =3D &event->hw;
 	int ret =3D 0;
@@ -10788,7 +10795,7 @@ __perf_event_account_interrupt(struct perf_event *eve=
nt, int throttle)
 		hwc->freq_time_stamp =3D now;
=20
 		if (delta > 0 && delta < 2*TICK_NSEC)
-			perf_adjust_period(event, delta, hwc->last_period, true);
+			perf_adjust_period(event, delta, period, true);
 	}
=20
 	return ret;
@@ -10796,7 +10803,7 @@ __perf_event_account_interrupt(struct perf_event *eve=
nt, int throttle)
=20
 int perf_event_account_interrupt(struct perf_event *event)
 {
-	return __perf_event_account_interrupt(event, 1);
+	return __perf_event_account_interrupt(event, 1, event->hw.last_period);
 }
=20
 static inline bool sample_is_allowed(struct perf_event *event, struct pt_reg=
s *regs)
@@ -10927,7 +10934,7 @@ static int __perf_event_overflow(struct perf_event *e=
vent,
 	if (unlikely(!is_sampling_event(event)))
 		return 0;
=20
-	ret =3D __perf_event_account_interrupt(event, throttle);
+	ret =3D __perf_event_account_interrupt(event, throttle, data->period);
=20
 	if (event->attr.aux_pause)
 		perf_event_aux_pause(event->aux_event, true);
