Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C3514751
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681750; cv=none; b=a0NpvDZVh9BKmwChk72HvFttK9G/D9MERAOkpTnDDHERwMdgTbg4O0tBjzV13BCtofbL7LBAqz+kX+5rH5whgOnv67+WVmHApN5SgN4qrZSsmF4M37+18IWbLy2bJ0ROYdIMw1cZD7RN6HppsQcbQIgfVYQqHg5zSITpv4YIbNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681750; c=relaxed/simple;
	bh=qFWb52+5giN1OFQpq2kAQaVFkm8z0Iq0R0sliFtnx+A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PTZ6B+LnKdOd45uFZsUM6tJkEf4TlT6YVavpT6mkoRF7QEZ9An5KJS4CS6y5tvq2nycJtUxQwhh+ZPTDebsoS2b2Ec9PkbipLtEFkxvcUtVlhyPJ2fl9lha264eenEMcShG9o9yhjFnPeFdIIR29hL7FGFZTyjaFPjEulI1CUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CC0hoO86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CC0hoO86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2776E1F000FF;
	Tue, 29 Sep 2026 11:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681748;
	bh=pn+o4vdMabK+XjL3ullwlrHu/q0JlzExNOkJJ9YIMSU=;
	h=Subject:To:Cc:From:Date;
	b=CC0hoO86EcWiAcTlRcwY+9UFZ4Sugg/5t4AlyBumELgB3VAaqm3TjU3yyAR8UK1TT
	 saEVue3dkb2UgB0cEhVGCHwKKLbjwioeIcSAdFwuVoOF6+pX4LA1tEeb7zwxJIwVwg
	 ZIjyI0193BayRCMBjGjuyS+P9BOvYx4RJXIjtZOs=
Subject: FAILED: patch "[PATCH] perf/x86/intel: Remove incorrect LionCove PEBS data-source" failed to apply to 6.18-stable tree
To: dapeng1.mi@linux.intel.com,mingo@kernel.org,peterz@infradead.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:35:43 +0200
Message-ID: <2026092943-cosmetics-enforced-4f4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7c944595cc43a664019edc22505b6d6f6039be5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092943-cosmetics-enforced-4f4e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c944595cc43a664019edc22505b6d6f6039be5e Mon Sep 17 00:00:00 2001
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
Date: Thu, 17 Sep 2026 09:52:27 +0800
Subject: [PATCH] perf/x86/intel: Remove incorrect LionCove PEBS data-source
 constraints

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
Link: https://patch.msgid.link/20260917015234.981153-6-dapeng1.mi@linux.intel.com

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0004b08b087..cbcc0b36536b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -577,7 +577,11 @@ static u64 lnc_latency_data(struct perf_event *event, u64 status)
 		val |= P(BLK, NA);
 
 	src.val = val;
-	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_LDLAT | PERF_X86_EVENT_PEBS_LD_HSW))
+		src.mem_op = P(OP, LOAD);
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_STLAT | PERF_X86_EVENT_PEBS_ST_HSW))
 		src.mem_op = P(OP, STORE);
 
 	return src.val;
@@ -1510,24 +1514,8 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
 
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x04a4, 0x1),		/* TOPDOWN.BAD_SPEC_SLOTS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x08a4, 0x1),		/* TOPDOWN.BR_MISPREDICT_SLOTS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x10a4, 0x8),		/* TOPDOWN.MEMORY_BOUND_SLOTS */
-
 	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3fc),
 	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf),	/* MEM_INST_RETIRED.LOCK_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x41d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_STORES */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.ALL_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.ALL_STORES */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x87d0, 0x3ff),		/* MEM_INST_RETIRED.ANY */
-
-	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
-
-	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),
 
 	/*
 	 * Everything else is handled by PMU_FL_PEBS_ALL, because we

