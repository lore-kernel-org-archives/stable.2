Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706FB263F5E;
	Tue, 30 Jun 2026 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810583; cv=none; b=hk2i3vq2PZFlbKuU0mc/qLBLw+28+2pwKVDQmJztTaBP1duWgA0/hhszu4yJ99aIMYfa1AXsL5NjMdMMefjX0aTBGpNddXf3x1Tmt4CmXvdXtyqS9ngUQuy1fCu+SLCmRgoGjDvXfaNNk7+vI8P5Dy/mIM0lZfZOpNUrQlBOsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810583; c=relaxed/simple;
	bh=XOlJcuuIq6OZff586M9D0VmE6eqHqjtjx5mv0t27Cjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=abqK8YvmJcngs2BdP2UwT9/LHh9lSlcmqjhSFUY2n98aZJXmVeJ+cYFj3+jMDHPevAxmLTxJASaxC5wZLJunsQriAVSPH0SGkhD+fuQj9+yXaI/UeKvzV1iSMXi4enLBeGlj7OMGn4WJ/4CXnHz03H+ThAovKvvv1qG0uRJSfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sEVxuwC8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Fj4OGuy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sEVxuwC8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Fj4OGuy"
Date: Tue, 30 Jun 2026 09:09:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782810579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7myBWNrRHVjbUVktVDCdDnXMY+jsLTdzbyYnFMkTK0=;
	b=sEVxuwC8iJXfE/H15xiW1vXUkpl6Tb2Hds2oaFRUV334M1WY2drIBOCipELtcZ3pJqEWfk
	rFsSYdsAbHOHIk8ubpBMidqxSqKv//h4gpj+8Hh5FOBo2uEPj0QSOJ0hCDo+h9ezOtSQkR
	zYY3ZUr+z3Zi3U7pGT+wuvDxD7y1iH5ZICBiSqsN0eNs+8zP5ja2Fhz3nZGFjY5ZQlyYRE
	qxjgooDPguKjCJERvw6zZXSnN/iVXi6/+4Byazo5LZs/LAvCkElHGoLCtP9kNk3fdP+qxK
	c20QRORBvr0VZB+ZZIhudNvcq6TD3+m7dOytwY1nKBs5XXZ+rBfPvUmv7kdVew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782810579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7myBWNrRHVjbUVktVDCdDnXMY+jsLTdzbyYnFMkTK0=;
	b=+Fj4OGuyqe0p1Jxnv7LBMXNkqF7UHOQneaZXi+nHWtU7q8ttRX64MXRiPKfKYev6TAyL4o
	OQwn526rg/W45sCQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Remove anythread_deprecated bit from
 perf_capabilities
Cc: Namhyung Kim <namhyung@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Zide Chen <zide.chen@intel.com>, Thomas Falcon <thomas.falcon@intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178281057844.3843924.18020319081483544204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9acfcb9b30b6c32ec0d8baad8b7c154120d4cff2
Gitweb:        https://git.kernel.org/tip/9acfcb9b30b6c32ec0d8baad8b7c154120d=
4cff2
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Fri, 12 Jun 2026 17:01:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 Jun 2026 10:57:05 +02:00

perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities

AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
represent "anythread deprecation" in perf_capabilities. It leads to the
anythread_deprecated bit could be overwritten by the real value of
PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.

if (!intel_pmu_broken_perf_cap()) {
	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
}

It leads to the anythread_deprecated bit is cleared to 0 and the "any"
attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
these support Perfmon v6 platforms, like Clearwater Forest.

$grep . /sys/devices/cpu/format/*
/sys/devices/cpu/format/acr_mask:config2:0-63
/sys/devices/cpu/format/any:config:21
/sys/devices/cpu/format/cmask:config:24-31

So remove the anythread_deprecated bit from perf_capabilities structure
and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
deprecated.

Fixes: cadbaa039b99 ("perf/x86/intel: Make anythread filter support condition=
al")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260612090114.3188886-2-dapeng1.mi@linux.inte=
l.com
---
 arch/x86/events/intel/core.c | 10 +++-------
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2b35483..465c414 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7947,12 +7947,6 @@ __init int intel_pmu_init(void)
=20
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
=20
-	if (version >=3D 5) {
-		x86_pmu.intel_cap.anythread_deprecated =3D edx.split.anythread_deprecated;
-		if (x86_pmu.intel_cap.anythread_deprecated)
-			pr_cont(" AnyThread deprecated, ");
-	}
-
 	/* The perf side of core PMU is ready to support the mediated vPMU. */
 	x86_get_pmu(smp_processor_id())->capabilities |=3D PERF_PMU_CAP_MEDIATED_VP=
MU;
=20
@@ -8829,8 +8823,10 @@ __init int intel_pmu_init(void)
 				      &x86_pmu.intel_ctrl);
=20
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
-	if (x86_pmu.intel_cap.anythread_deprecated)
+	if (version >=3D 5 && edx.split.anythread_deprecated) {
 		x86_pmu.format_attrs =3D intel_arch_formats_attr;
+		pr_cont("AnyThread deprecated, ");
+	}
=20
 	intel_pmu_check_event_constraints_all(NULL);
=20
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index eae24bb..5902a29 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -668,7 +668,7 @@ union perf_capabilities {
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
 		u64	pebs_timing_info:1;
-		u64	anythread_deprecated:1;
+		u64	__reserved:1;
 		u64	rdpmc_metrics_clear:1;
 	};
 	u64	capabilities;
