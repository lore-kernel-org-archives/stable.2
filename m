Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861D51120B;
	Tue, 22 Sep 2026 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070401; cv=none; b=WSyyxFvBZKAs7/J025/ZvunsOvdOfqmSW45h0nlXV452m0xeoJLBSKMAtV0GZm4Yfe7GiAU45KQwhAnzmVda8L0HroL5XKyRR8daje+B/EomjXd8tapWNioUjeHi2IyNAtYvtXkhYrVy6rSCDPkgOd3qynIaAyHQn4gcuhJlHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070401; c=relaxed/simple;
	bh=9xMrdnxtQgCUUmM/PwRCqjU7ye/UIX/Wguuh+ZJemdk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZNTjENu1Ley5hkNV9p4CFmOpSBrpsulX+Rr6+ftzCNTqelz9yVj6AjghbZ+o8pYja40qN4geAMOJ1TXOjokn0RzKLvniO2lyM04Hrq/vP7Zi4lGAXO6NbVmrs6IDEF9rUp8U6Cw26Piekdt/+MbVtQ5idOdODzcmG/mL6KLnLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZkOEZMwi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y+u6lyXS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZkOEZMwi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y+u6lyXS"
Date: Tue, 22 Sep 2026 09:46:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790070397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URb8VwDcqLEgu90NY00qYLgWb9xogSm4vHArmheqiSc=;
	b=ZkOEZMwiaGYC7LY/37LtlyaPRwWJGoNKtuWyQfPFuFge/coBDVaO38HrYOEp23iynW829c
	4fLBlvz4c4eR9sq3C/ocA3MFi/jYdbPnoKE92dk2MQvmr3pQbXNMRHy8fQ4NQs1YkChon9
	QUYl0oqcEL4RaSFgrdd3G9jdupHYEeZFZzEE06bkZvMg3dydxy909eerhYPk064rzzziwa
	gg1vxpYZIfO4t17QHh+OIB4yKURW5xP93BcNNiPoqIr8uhyYMB+TaX7CSzFYDm+RMkMmGw
	Vy6rBijZcEp2/b0Uw0AxKlqwR/KL6QN7o80mCSaoDggjeQJGMzJe/IlM7HC/1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790070397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URb8VwDcqLEgu90NY00qYLgWb9xogSm4vHArmheqiSc=;
	b=Y+u6lyXSMTa0bHs7jZdT3Hv6xtynfBLxqLeeT4+i3KZH63wdXJLSnDOpRNkeTEEcVb0BnE
	fzV7V65fpOBUmMCA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix DKT PEBS load/store direction
 for latency events, to fix sample classification
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260917015234.981153-4-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179007039578.2819794.9872540834330343935.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8302c5f475fa5a4ed36a7d32c7b965023d5d7066
Gitweb:        https://git.kernel.org/tip/8302c5f475fa5a4ed36a7d32c7b965023d5=
d7066
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 17 Sep 2026 09:52:25 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Sep 2026 11:17:59 +02:00

perf/x86/intel: Fix DKT PEBS load/store direction for latency events, to fix =
sample classification

Same bug exists on Darkmont as on Gracemont:
intel_dkt_pebs_event_constraints[] applies LAT_CONSTRAINT constraints to
MEM_UOPS_RETIRED.{LOAD,STORE}_LATENCY, but does not set explicit
LOAD/STORE flags for those events.

The PEBS latency path (pebs_latency_data(), via cmt_latency_data) uses
the event flags to determine memory operation direction. Without an
explicit STORE flag, samples from MEM_UOPS_RETIRED.STORE_LATENCY can be
misclassified as LOADs.

Set explicit LOAD/STORE flags in intel_dkt_pebs_event_constraints[] for:

- MEM_UOPS_RETIRED.LOAD_LATENCY
- MEM_UOPS_RETIRED.STORE_LATENCY

This fixes incorrect STORE sample classification. Additionally remove
INTEL_HYBRID_LAT_CONSTRAINT() since no one uses it anymore.

Fixes: 65fd435095bb ("perf/x86/intel: Update event constraints for PTL")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org> # v7.2+
Link: https://patch.msgid.link/20260917015234.981153-4-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/ds.c   | 4 ++--
 arch/x86/events/perf_event.h | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fa7e026..ea5b331 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1315,8 +1315,8 @@ struct event_constraint intel_cmt_pebs_event_constraint=
s[] =3D {
=20
 struct event_constraint intel_dkt_pebs_event_constraints[] =3D {
 	/* Allow all events as PEBS with no flags */
-	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0xff),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xff),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x5d0, 0xff),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x6d0, 0xff),
 	EVENT_CONSTRAINT_END
 };
=20
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4680cba..fab9da7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -517,10 +517,6 @@ struct cpu_hw_events {
 	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_ST)
=20
-#define INTEL_HYBRID_LAT_CONSTRAINT(c, n)	\
-	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
-			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID)
-
 #define INTEL_HYBRID_LDLAT_CONSTRAINT(c, n)	\
 	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID|PERF_X86_EVENT_PEBS_LD_HS=
W)
