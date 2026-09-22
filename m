Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA35221EB;
	Tue, 22 Sep 2026 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070402; cv=none; b=CEQmtS68NRFHLTjsI5nrTTf6jweP1UCyGYQ6iKceO/UYsr2jlpwcEcbDWgYg8D7Ef5Hzr0ZecX2qIPgNTt81ki5LQFgCEI7c7D9XmRMOcwA5D9IPGs5+aXD3sI1l1IvJv7xAScVT6X54zQef+uHz7sP6aXLxQrH+fnRvzdARPk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070402; c=relaxed/simple;
	bh=4TIjfBd7/NhCOH1hgFwU5xjuVjdR+fMmeUeWlytRFe4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PgMYjcR6ZiKdZLLgVJM4Tu/QpqXiL7c7vY879ciei7BFASG6ZpUCD35yko5vS+9qDeq/2S9+Mxw/jhIc6CF/A7IKK3NZhTmIUqYxuaV4bmPaBGx6zg+NTSmVreN0mw0k8MQ/FhH+o7bEIg4UDebxkxDWk258E/4D6EZKjB37VQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XWAPIx7p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9OLkDxb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XWAPIx7p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9OLkDxb"
Date: Tue, 22 Sep 2026 09:46:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790070398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6c/2Ax+2YcksEu3JBZWoRiqEJzZFjrhNQlMXbk5Mn4=;
	b=XWAPIx7pLigSK37TTZx2g1ajUI38UtubX5Fc8KegkOmdEjD4w4Tl1c+YxXvkuYECu70p3L
	I/JHJ5yLm5BKV98rArE1okErTB7QfJs7ZaCcm7XKUrjFd34jxdSsrJnbHVucnGO/xV2n2+
	2EOkfnJ1EbhkhAyI+3glltw8xpf+9sEGu80AswY7nEL6enzmf9Ir+SR/H8AkLU2ooraHgf
	gYl3rJARD6xkewF6lcVV47MaRC0Jo0ydrsoW4J1htylVNEksPuLjTPnXyYRzBX97JBUB2g
	8jq7PI2s4KqpAgm1GJV60X828DIh3MgWyuLzleq7MFECB+S2zz/qh0wMgkaTEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790070398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6c/2Ax+2YcksEu3JBZWoRiqEJzZFjrhNQlMXbk5Mn4=;
	b=M9OLkDxbsgzRUVW/KXxzHa8t4+ye/zfmsVelhl4GbZZZ7jwRYtoPfRXyA1ZE05e7nncDIO
	VO/uSVExk+A376Ag==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix CMT PEBS load/store direction
 for latency events, to fix sample classification
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260917015234.981153-3-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179007039727.2819794.9399572585150834100.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e961d6db42d1f1b66c81438969a648f08573bd9c
Gitweb:        https://git.kernel.org/tip/e961d6db42d1f1b66c81438969a648f0857=
3bd9c
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 17 Sep 2026 09:52:24 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Sep 2026 11:17:15 +02:00

perf/x86/intel: Fix CMT PEBS load/store direction for latency events, to fix =
sample classification

The same bug exists on Crestmont as on Gracemont:
intel_cmt_pebs_event_constraints[] applies LAT_CONSTRAINT constraints to
MEM_UOPS_RETIRED.{LOAD,STORE}_LATENCY, but does not set explicit
LOAD/STORE flags for those events.

The PEBS latency path (pebs_latency_data(), via cmt_latency_data) uses
the event flags to determine memory operation direction. Without an
explicit STORE flag, samples from MEM_UOPS_RETIRED.STORE_LATENCY can be
misclassified as LOADs.

Set explicit LOAD/STORE flags in intel_cmt_pebs_event_constraints[] for:

- MEM_UOPS_RETIRED.LOAD_LATENCY
- MEM_UOPS_RETIRED.STORE_LATENCY

This fixes incorrect STORE sample classification.

Fixes: e99fb45436ea ("perf/x86/intel: Update event constraints and cache_extr=
a_regsfor MTL")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org> # v7.2+
Link: https://patch.msgid.link/20260917015234.981153-3-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/ds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fff98f4..fa7e026 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1308,8 +1308,8 @@ struct event_constraint intel_grt_pebs_event_constraint=
s[] =3D {
=20
 struct event_constraint intel_cmt_pebs_event_constraints[] =3D {
 	/* Allow all events as PEBS with no flags */
-	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xff),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x5d0, 0x3),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x6d0, 0xff),
 	EVENT_CONSTRAINT_END
 };
=20
