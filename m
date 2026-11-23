Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427054;
	b=lOAHN7Di6Xh72xnotKoOxIKBhucGRagxrPmmvgMKetvn5Mnv9NfoilyQUoQEfUKUSu5U
	 sjP7vTrgFEgyrErY0MdsjS3BXqZvCW3Xmy4ci5oqaWDTWpyWDRX9KGlfqtikU0hrBor60
	 P0w0QvLtR+zjwz0kIrtIgzFxODMXolzPwzztMq06S29WMUtvHNM9OA4Z/EXtO4bMO+QtZ
	 cBR1sEbNm6h+h/GtnrE+G+cyNv19MgpVl3a/AHib5H63ftmOgZ9mSfT0GkbSUPk1Nlj9u
	 6i86tAcNetWOc9EhMtc6IcdhFn9rc4ofzrRNb5D3dps4TXpSc0Z0FPu8F2VisPF7epQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427054;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=rJ6BHwGgCp3gOxNuINQKehQHo87f695VH3Yyh80+sgw=;
	b=qkyXvkZgm5vFY/J3oBaEvu6RD3tHWdA8B+jFFho8Ep9s9hFRNTbj+UjQJK6Ytg7/7KWN
	 wxPX1BgGwgaZQZMTAIZOeuAh75ig2Tt0nDyGgGNd6upb07QtKj6jUjD6X+oz6XUJlmbBJ
	 i0UPgmjaDGEd1tNmC3m54aE8pchCJAF9mYWdjkun8t89bam2ozcnNlGYPlmh22TvarBYI
	 TDnlWP8lAC0ab5KuoDzVrOhfdZnA7Sp0Gno1AGzD3l+ZNfNsze6RdZgZhYEKaeOXYa1UI
	 0b43m1kFuCatzDzDUNBp94aDLzoOlr3zQf3C8ApfV7PwE1Vy0l81Ez0+ymXO0bJAn0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vZ9Nsl6L;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=f3iP4kko;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534ED606A33A;
	Mon, 23 Nov 2026 09:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 534ED606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vZ9Nsl6L;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=f3iP4kko
Date: Mon, 23 Nov 2026 09:44:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795427052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJ6BHwGgCp3gOxNuINQKehQHo87f695VH3Yyh80+sgw=;
	b=vZ9Nsl6L9Qdh7KX/RSN9WjrKh9wke5nBxyan1t51NezR7StOkVOR/zaicmsAFYKBckyNpi
	sFQGrh7yJcR9KeT5QAY21pSR6YjBdiDDCl6hPOI7I90m5d6CfF8CdZ7LQ15q2ixIbdXpSJ
	oTGbuxxJ6ZXIHPWDt8u8cPYEDLAGNMgV/pF/zkJT1tVmjJ2XqQo0ZDGXJNUVuPCeeYPJMP
	qzLlrDRt/a17jA3LQmWCo0lNy4zuDLaZ+MSp55ix/z/sXOsm4vtambebm4E4pBDz755bZ7
	Ce3hIg5FDqijH+HsrPBRVDyLYr625pzjiLu26LPP+BIpP8ImyWeTvumfjvLixw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795427052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJ6BHwGgCp3gOxNuINQKehQHo87f695VH3Yyh80+sgw=;
	b=f3iP4kkomltj3XBK+AGBFp+VI8zq9g/IulqW1t0bdcHZqLSttQBVCC7IvTSiDGwonMXA7h
	jtxpp3BCP1wWtIAg==
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
Message-ID: <179542705068.92412.4059556068919679123.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c9ef606bc68a7bbbaa5fc9cef968a5226c12a283
Gitweb:        https://git.kernel.org/tip/c9ef606bc68a7bbbaa5fc9cef968a5226c1=
2a283
Author:        Usama Arif <usama.arif@linux.dev>
AuthorDate:    Thu, 19 Nov 2026 13:10:45 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 23 Nov 2026 10:37:47 +01:00

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
