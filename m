Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387757;
	b=bJZxORZyxdNNLHYr3622Nt9GwjMCICClMvvbzheAKzJKkNN0HEJishXYmQUxCpnzTrJl
	 vCNTixwYN0FLvuHjI3Y/fCPCkj6S8wuhmnkcuU2w0NGj3Er9INbIIo+ECSRBzewD4re4Z
	 wsy058X++9Tk1FCJ2U678/j2ee4JDtdMf6mDIs8QCQb3m0xQvYCEH1Hhr76c/j9elFLXD
	 7Wk4v8dYcpJLDY7AV+qnUXJz7fvlAmA31RVJkvNtMVhAXB9v59O+6q5uLyhgmxmt8O8Ht
	 BClf4twcWQJuw+Qcat99SLpMKZTWPVETqzWq2cDRS54G8SGWlaiWiZrClhtSv9UqoCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387757;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=KqOipM7qjQ0dDcQYET//iiKXEc12lb7LWtsq8Lxylcs=;
	b=WGTbzrL6KTJijpZOMdMxfWOb5baJrztJfPYcOAsQZligmdX+T1iKAwJ1HZeNkf/7XCOZ
	 yVVzmSLOmU5CcLQO6yrQ3SqRLRcs+ox6xeklBol1ZzlO6kjE0R3yIH7vrvMcA2/SLwsFQ
	 TzpWEONCae4DtpDZjQK57/SQVybL0Yg/1QQIHkYRlAO3KPXpmGniqyQes3xU3j00vNVj4
	 //IFL+KxRfcoPfggLWm2X6Igc76Sw7fm6cj0hT4ME/y/k1QIp3hc/cJs3u/39o+Ym1CVM
	 /gm3KlDtoAiuCpsCJf4SVw1thfvr7J1OiZn3T3NXmwHsnVWa7waQ3aUfu0m+hbQtW8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=T1F6R6Og;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RX9Diufa;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D19606A68B;
	Sun, 22 Nov 2026 22:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3D19606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=T1F6R6Og;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RX9Diufa
Date: Sun, 22 Nov 2026 22:49:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795387750;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqOipM7qjQ0dDcQYET//iiKXEc12lb7LWtsq8Lxylcs=;
	b=T1F6R6OglivIV4z99iSG2eToM7qD8dulAYLYk+FISrXPvvZVUkxgv0Ish8ViSKGNz8HbZQ
	VKg7oH+VSu/7X7cqj3spihI2lj8d20sD/HujZUAPcfN2b/X4hjfG8KR2DFGy7/I3QZsuqt
	A/Hz6K/pfCyPtX/JI3rGH1Drm5FavFdvWMKogB4ZgMuqLU2GDAL+0RgcTYfayrwEE7SCW6
	SP19YUH872TurfGUCQAAeNDAAZ15fb/+uGa79c4utKYbeiY8+1eJuig1Bxnoip65y92JSg
	f9TI4dOwepbJkzHXDcFd5O7+2LT1fCuGPA9+HzZS6BBtQSEGO3SF6zDN4GWnQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795387750;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqOipM7qjQ0dDcQYET//iiKXEc12lb7LWtsq8Lxylcs=;
	b=RX9DiufaITYRVFnTpRPwI32yVtxJug5PWlEfZbTptci2w/9Ob1YTjy/lU+Ay0nbcdLS20L
	yBweKqo6FiqKcvAw==
From: "tip-bot2 for Usama Arif" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Don't let BPF programs read an
 uninitialized sample address
Cc: Usama Arif <usama.arif@linux.dev>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261119211235.99805-3-usama.arif@linux.dev>
References: <20261119211235.99805-3-usama.arif@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179538774870.92412.3260123976447022124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     91a18ff192c68329fcfdd4ed0a6d37dcac45ef50
Gitweb:        https://git.kernel.org/tip/91a18ff192c68329fcfdd4ed0a6d37dcac4=
5ef50
Author:        Usama Arif <usama.arif@linux.dev>
AuthorDate:    Thu, 19 Nov 2026 13:10:45 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 22 Nov 2026 16:09:06 +01:00

perf/core: Don't let BPF programs read an uninitialized sample address

A BPF program attached to a perf event gets a struct
bpf_perf_event_data, and reading its addr field turns into a load from
the perf_sample_data the sample is being assembled in. The verifier
allows that load no matter which fields the event samples.

perf_sample_data_init() used to store the address unconditionally, so
the program read 0 when there was none. To touch fewer cachelines, it
now stores the address only when it is non-zero, and
perf_prepare_sample() fills it in only when the event samples it
(PERF_SAMPLE_ADDR, PHYS_ADDR or DATA_PAGE_SIZE). For all other events,
including context switches, cpu-clock and hardware counters like
cycles, the program reads whatever was left in that stack slot, often a
kernel pointer.

Kernels built with CONFIG_INIT_STACK_ALL_ZERO, the default when the
compiler supports it, mostly hide this by clearing the struct on
function entry. With INIT_STACK_ALL_PATTERN the program reads the fill
pattern instead.

Clear the address before running the program if nobody filled it in,
the same way the SIGTRAP path already checks PERF_SAMPLE_ADDR before
using it. Events without a BPF program are not affected.

Fixes: 7b0846301531 ("perf: Use sample_flags for addr")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261119211235.99805-3-usama.arif@linux.dev
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 42bd8ad..ee51134 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10819,6 +10819,9 @@ static int bpf_overflow_handler(struct perf_event *ev=
ent,
 	prog =3D READ_ONCE(event->prog);
 	if (prog) {
 		perf_prepare_sample(data, event, regs);
+		/* bpf_perf_event_data::addr is readable without PERF_SAMPLE_ADDR */
+		if (!(data->sample_flags & PERF_SAMPLE_ADDR))
+			data->addr =3D 0;
 		ret =3D bpf_prog_run(prog, &ctx);
 	}
 	rcu_read_unlock();
