Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97924F393C;
	Tue, 22 Sep 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070398; cv=none; b=HpILHkXue/zWpoc4bc3+Mruyptgdf+2O1KcSadWeGzL8APSchMBuQ88qEUbUUm30RUBD3QX+P5z17mwTHtojAVQLxoed/HulLpAwSV6A2Yu3qooUzragxx+0czrAEXabVy16/boBdJZ6SztVwjCpR7HYVpDxxLpYdqArd9mTxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070398; c=relaxed/simple;
	bh=uuXZGwLtguZ/LcF70IL9dk+oq0NNzbuGs8ltxvx1bew=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YTKmrnjtdVh0IzY1zhL5/0ouBsZkMOjBx3c42qNVQ2r8pRUpTj45W8+w6wdVsa9nBgjtLm1SlgHvPJ6aHVFkUmI4tZ663J7gTaSLApcAv4JhLIurJuQDrxe3BcVMAVYMF+FMUA1G/tTqMy5ng73ZQOsT889o28PAXzh4xxzQ2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFG/qV5e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EefXD3GD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFG/qV5e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EefXD3GD"
Date: Tue, 22 Sep 2026 09:46:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790070394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGVnWR2tXlACcxrdatiZs8o2EwJ8vpb3WDYhTqL5TNM=;
	b=zFG/qV5eLnm2vrW6ZmFMvqcLxNIeL2GwDkFVvnv4/bOZbZFw4V6v+lK7sT7BPgV1as7612
	AkX8MXfaHjXHNnb9ikUV80PjEz6vDbUeWHWoMaJoV4wg8tzqvdS36r7EOdCJQnREynVcXJ
	0l0SLdRCg7c8Qh//C7KxjhlAiuVFS+aKdhcCm2RVMsWfsiqcsmRv4aVjpbfBwl+XX/c+N3
	zZcct8950/6I3albirX5i7wkAfOzCl9wcBiCfT9cqSDLPKaAmaYzm+/w1CslxADFVXSVTx
	YlyX9fenZKe92XMrlXG9eXq9P6epl2b51dkV9ZHvZk0Zqhunskj/aUGfv2bQBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790070394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGVnWR2tXlACcxrdatiZs8o2EwJ8vpb3WDYhTqL5TNM=;
	b=EefXD3GDAE7rjBFQ1jjF2Uj6RXqJ3d/ixMNnOm4CVaPD8/5WvCHTlTPU7Rk4N8AKwVrHia
	JR3q5ZMEZqF0o7Aw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Remove incorrect LionCove PEBS
 data-source constraints
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260917015234.981153-6-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-6-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179007039271.2819794.7437921920054017080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7c944595cc43a664019edc22505b6d6f6039be5e
Gitweb:        https://git.kernel.org/tip/7c944595cc43a664019edc22505b6d6f603=
9be5e
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 17 Sep 2026 09:52:27 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Sep 2026 11:26:27 +02:00

perf/x86/intel: Remove incorrect LionCove PEBS data-source constraints

On Lion Cove, PEBS data source is valid only for these events:

- MEM_TRANS_RETIRED.LOAD_LATENCY (0x1cd)
- MEM_TRANS_RETIRED.STORE_SAMPLE (0x2cd)

The perfmon database (https://github.com/intel/perfmon) previously
tagged additional memory events such as MEM_INST_RETIRED.STLB_MISS_LOADS
with L1_Hit_Indication, implying PEBS data-source support, which is
incorrect. The database has since been fixed, but
intel_lnc_pebs_event_constraints[] still follows the old definition and
marks those events as data-source capable.

As a result, get_data_src() may decode data-source information for
events that do not provide valid PEBS data-source data and mislead
users.

Remove those non-data-source memory events from the Lion Cove PEBS
constraint table so matching falls back to the regular non-PEBS
constraints, which already provide the same counter constraints.

Also update lnc_latency_data() to decode LOAD/STORE flags explicitly
when setting memory operation direction, for consistency with other
*_latency_data() helpers.

Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260917015234.981153-6-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/ds.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0004b0..cbcc0b3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -577,7 +577,11 @@ static u64 lnc_latency_data(struct perf_event *event, u6=
4 status)
 		val |=3D P(BLK, NA);
=20
 	src.val =3D val;
-	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_LDLAT | PERF_X86_EVENT_PEBS_LD_HSW))
+		src.mem_op =3D P(OP, LOAD);
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_STLAT | PERF_X86_EVENT_PEBS_ST_HSW))
 		src.mem_op =3D P(OP, STORE);
=20
 	return src.val;
@@ -1510,24 +1514,8 @@ struct event_constraint intel_lnc_pebs_event_constrain=
ts[] =3D {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
=20
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x04a4, 0x1),		/* TOPDOWN.BAD_SPEC_SLOTS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x08a4, 0x1),		/* TOPDOWN.BR_MISPREDICT_SLOTS=
 */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x10a4, 0x8),		/* TOPDOWN.MEMORY_BOUND_SLOTS =
*/
-
 	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3fc),
 	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.S=
TLB_MISS_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.S=
TLB_MISS_STORES */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf),	/* MEM_INST_RETIRED.L=
OCK_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x41d0, 0xf),	/* MEM_INST_RETIRED.S=
PLIT_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.S=
PLIT_STORES */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.A=
LL_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.A=
LL_STORES */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x87d0, 0x3ff),		/* MEM_INST_RETIRED.ANY */
-
-	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
-
-	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),
=20
 	/*
 	 * Everything else is handled by PMU_FL_PEBS_ALL, because we
