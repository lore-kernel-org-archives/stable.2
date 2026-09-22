Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071D4DA9AB;
	Tue, 22 Sep 2026 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070398; cv=none; b=sOoOVp5oitNhP6kfXJo3hY2+hj450z7WxbFddlYoDNSSWoJb8ixp9uEV/HjtiZ+JRN8DXh7g6YsE21bOVohUvXzzdBWQfctSp/x21wUMszp5Ja2rmLwhr1KLGD/spuvLE+gRzRF1YrbklK5J0C9/rjEAcTfrliIQiSZ+ioB8NNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070398; c=relaxed/simple;
	bh=GkVcGrMc2AOqJNJ3kvP4VZaKMsly6gJuEVuRyOCzKEQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=La5rIY8Rhn+fCpnbaHiy8D//aca7uI4aUgWYtGuq+M9DY3dYNxOiZnRjwQlgprpJTrezpkXzOwmPy7RCEKkuyLaaNOcF7Q5dZUienzjmjnKCB9KUCOi0oDjHJWY9eq1dBamJaJ3U0ozuXQWPay7FW8Das/soqSs4JBFH/iJoJq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tB/fx1mr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jlcrXBPB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tB/fx1mr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jlcrXBPB"
Date: Tue, 22 Sep 2026 09:46:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790070392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFs1+4k3Z0RrDpKAuxgvSSr7p2HmlpiFBJpsGxCEghA=;
	b=tB/fx1mrBe+qb+kbfGK1A0LBYTSWx7/8xH06XwasmHfBlxiGA7R613U9JNPpnU7X7V6oew
	QgTfmOUpgbdQTnFQJovYEei/aXn5/eOyEYlW4XF3rGunNhwicW9DDCgeWTAQjDimdfnqxI
	ACNiywF07V5Ls+XjhRgLXgVuN+uKZdEgzdV5g+qgn0pmo1Er6I8ZbPkWGerREJRDNQ2cJz
	G8GlENzGKiUTFF3L/AJFOsC2D2nIBDckWxFCeWs6QP4089Y1HbTQwSydjRCmoLHScPJSCx
	Sj4JsNpOBzQwPSqiwGJW/+M5A6FyMtddkl+Pt5S0Oy1a3pmEvdI2U68yFyUo/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790070392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFs1+4k3Z0RrDpKAuxgvSSr7p2HmlpiFBJpsGxCEghA=;
	b=jlcrXBPBWCHoCn0x5I3NtTGb1FynGFei8NaKnknGJai/zInWOzuWXEGGauQ0519mQLHYG8
	bqghlXauKJmgnqDQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Remove incorrect Panther Cove PEBS
 data-source constraints
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260917015234.981153-7-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179007039124.2819794.10157630828563987191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9f93d33ad65af9853974c1ec4ba1f937e8ba1376
Gitweb:        https://git.kernel.org/tip/9f93d33ad65af9853974c1ec4ba1f937e8b=
a1376
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 17 Sep 2026 09:52:28 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Sep 2026 11:31:40 +02:00

perf/x86/intel: Remove incorrect Panther Cove PEBS data-source constraints

Same issue exists on Panther Cove, PEBS data source is valid only for
these events:

- MEM_TRANS_RETIRED.LOAD_LATENCY (0x1cd)
- MEM_TRANS_RETIRED.STORE_SAMPLE (0x2cd)

The perfmon database (https://github.com/intel/perfmon) previously
tagged additional memory events such as MEM_INST_RETIRED.STLB_MISS_LOADS
with L1_Hit_Indication, implying PEBS data-source support, which is
incorrect. The database has since been fixed, but
intel_pnc_pebs_event_constraints[] still follows the old definition and
marks those events as data-source capable.

As a result, get_data_src() may decode data-source information for
events that do not provide valid PEBS data-source data and mislead
users.

Remove those non-data-source memory events from the Pather Cove PEBS
constraint table so matching falls back to the regular non-PEBS
constraints, which already provide the same counter constraints.

Also update pnc_latency_data() to decode LOAD/STORE flags explicitly
when setting memory operation direction, for consistency with other
*_latency_data() helpers.

Fixes: d345b6bb8860 ("perf/x86/intel: Add core PMU support for DMR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org> # v7.0+
Link: https://patch.msgid.link/20260917015234.981153-7-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/ds.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index cbcc0b3..72179bc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -639,7 +639,11 @@ u64 pnc_latency_data(struct perf_event *event, u64 statu=
s)
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
@@ -1528,18 +1532,6 @@ struct event_constraint intel_lnc_pebs_event_constrain=
ts[] =3D {
 struct event_constraint intel_pnc_pebs_event_constraints[] =3D {
 	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0xfc),
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
-
-	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
-
-	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),
-	INTEL_FLAGS_EVENT_CONSTRAINT(0xd6, 0xf),
=20
 	/*
 	 * Everything else is handled by PMU_FL_PEBS_ALL, because we
