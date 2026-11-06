Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959000;
	b=Kclaw/dLdX15kpPXxiN8WD7LoCkM74jhPeijFlnlGPzpONmDXR0e5AOhDIwn8cuE99OC
	 yguBamErssqW0+6B7a0CqDemxhQBvdAwiEprDur7p9krBCSORrhbYV4iMdw7YV+Po8lMo
	 1OPCVkPadsY0MNTXUyurZMkKfV26cB8a1DP9qQmxyaSdPyRIk9MP4Lt5B5+pl5DqvRus6
	 Y7Vm4ugHlqoXCdk4IT7Hk+LgpeMhT3s+o0oHydqWFaW3PWbXuFRiow6kUibryEgzcAvJM
	 UR4gsrIwHj1gFdoisZM/6s38fl8eDdHlpuHhJd4YNfxsQEVmdNx7VbCSGIN6bJbg4Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959000;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=hmQF3DH+D0wk7R8RwPJwStqSl320Tvz1z80N0E0KZBE=;
	b=o6/C3nArYgoA/d5K2SjxQFVsibOim5lDVxpWYoUnGY2Ao7pB5Yp/WORWcs+W8o827N+W
	 2fjw0YhwGspdVS8+0eXLOs/itKIDzdspJ4pzbDZ6hnsUCprPnWazkrRqXk8gnHAZleB0J
	 iFM/KDKEhh+gNaGjsKZNfGktI3N7ogrmjSxZxxJhGpkNK06q4Me4tG1jVkLzEcW5CM8v0
	 xzEDpYdhEUcVKkRqF0GstGyIRFolyakRv3SYhfQhMzU2MbakITN+6Tkj7a44zLCinXUU7
	 7G9SH6fg3RnZkwv15TkcjKYc4ZmDN/xfJmkO+BtdEjllxNcp+Bux6ZEOzX0RxtWx/TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=bKD17msz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DxTGCDmP;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50439606D81A;
	Fri,  6 Nov 2026 09:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50439606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=bKD17msz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DxTGCDmP
Date: Fri, 06 Nov 2026 09:56:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793958998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmQF3DH+D0wk7R8RwPJwStqSl320Tvz1z80N0E0KZBE=;
	b=bKD17msz7kjrmZFjlhK+i/BXr95gr5r/X23rT4hbgj/aGxMvKNHdRhInya7X/8x5GVohTt
	jZ0R/ABM8fd6zesXASeuIszGSkOyhDFXf28FTIguynX6Bs4EqRA43PCTjo8sPrvtdPtAVF
	i/JDdRNGYMe598Mf7Q/biv5v3jBmu+IaEzzZy+vwNAvCg+p62DXPYhBtBr00lFmgTIuweI
	QIHJoviCHyuFOybf5DDtz+xUaJJkf8gRuQpBcj6Ajb9u75/254yyobUdbx0aSbHPD0zjtP
	zPPlpw3zuUhZOk+cc4xNOt+q5rQW6ng9JlKjCmLzvRfLjZTsOG3rvsl5hrEvkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793958998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmQF3DH+D0wk7R8RwPJwStqSl320Tvz1z80N0E0KZBE=;
	b=DxTGCDmPdSRNpB2hDhd0ZVwGk4PnoWh302M5S1JNkfxqT91EfFLTwVMQ0apUfEmjAAxAd7
	9I5f+B2JVV0EWICw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/nmi: Ignore negative NMI handler durations
Cc: Breno Leitao <leitao@debian.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261027-nmi_negative-v1-1-b436a005eb8a@debian.org>
References: <20261027-nmi_negative-v1-1-b436a005eb8a@debian.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179395899620.1009794.10278780048143042875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ade63af6cfb7b3ca19ced28730fd6461e8d1d410
Gitweb:        https://git.kernel.org/tip/ade63af6cfb7b3ca19ced28730fd6461e8d=
1d410
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 27 Oct 2026 03:43:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Nov 2026 10:48:59 +01:00

x86/nmi: Ignore negative NMI handler durations

I am seeing NMI handlers in the Meta fleet reported as running for
about 584 years. Over 30 days, 11 AMD and Intel machines logged 637
such lines, for example:

  AMD EPYC 9D25 (family 0x1a, model 0x11, stepping 0x0):
  [ 1650.616627] INFO: NMI handler (nmi_cpu_backtrace_handler.llvm.9643156322=
683129580) took too long to run: 18446744073709.551 msecs

  Intel Xeon Platinum 8321HC (family 0x6, model 0x55, stepping 0xb):
  [360448.230129] INFO: NMI handler (perf_event_nmi_handler) took too long to=
 run: 18446744071018.936 msecs

  Intel Xeon D-2191A (family 0x6, model 0x55, stepping 0x4):
  [81787.188959] INFO: NMI handler (ghes_notify_nmi) took too long to run: 18=
446744073709.545 msecs

nmi_handle() times each handler with two sched_clock() reads. When the
second read is lower than the first, the u64 subtraction wraps, and
nmi_check_duration() treats the result as a duration. In the three
examples, the clock went back by less than 1 us, by 2.7 s and by about
6 us.

The wrapped value is also stored in action->max_duration. Every later
real duration is smaller, so the handler is never reported again until
the next boot.

Whatever makes the clock read lower, a negative difference is not a
duration, so return before it is stored or reported. A clock that steps
forward is not covered, since that cannot be told from a real stall.

A backwards clock is still worth knowing about, so print the size of
the step once per boot. This uses pr_warn_once() rather than WARN, as a
stack trace says nothing about the clock and panic_on_warn machines
should not go down for it.

Fixes: 2ab00456ea8a ("x86: Warn when NMI handlers take large amounts of time")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261027-nmi_negative-v1-1-b436a005eb8a@debian=
.org
---
 arch/x86/kernel/nmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 3c9f60d..cb46da4 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -115,6 +115,14 @@ static void nmi_check_duration(struct nmiaction *action,=
 u64 duration)
 {
 	int remainder_ns, decimal_msecs;
=20
+	/* sched_clock() went backwards? */
+	if ((s64)duration < 0) {
+		pr_warn_once("NMI handler (%ps): sched_clock() went backwards by %lld ns o=
n CPU%d\n",
+			     action->handler, -(s64)duration,
+			     smp_processor_id());
+		return;
+	}
+
 	if (duration < nmi_longest_ns || duration < action->max_duration)
 		return;
=20
