Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE83E7166;
	Tue, 30 Jun 2026 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810583; cv=none; b=h8MaaSzbHOPAXQVhvRqP3oAktK9lw2TkCOtGs1GFd8sJ3lkLsb4MsHU7krVjT2on9j/uwUx8AGJN0boRsz0XNk6XkqMNoNGVIwRG3VQ2nSHoa28V1J8R7PhZgCnc8JocwF5UEjoXbDTrrm9nffUkIofhnwmcc9yheUoHnLxRZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810583; c=relaxed/simple;
	bh=X6PSFB67nc9t3E0Mu1iLOap3Z8Nto36r4qCU1Po2Ny0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L/P6lfR0zYtmIMS7rnyMfvSByxlORgqcGlbYorHcfn5UcZst3FmQ0SOBHI+qOio73meXSKn/nS6bhpQrb/SqYYVyG55rptKYkRZhM3dhTB+ZpIcUy0KcHDSzSQ0SS+tAlralfbtI8iP855lOMmD4TQsmnaSdBvWGYNh8lgDYxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SEqRSn0V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aReN4na0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEqRSn0V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aReN4na0"
Date: Tue, 30 Jun 2026 09:09:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782810576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kgGP9hBENnvmbyQzj6Qb2u1ao9pcznfGmAryyHBTaM=;
	b=SEqRSn0VPVNLANl1INHF6M/HyzYykm3HgUtyrSrSDPpsxFZSEd7BXCbGBKqKaUoluLcNIH
	IAOTHC334e5Ih9lHdHXsBsRf+UvPCZNAIIIRHnUEYzxo0gjp5M/yFX2itRCMA1089fK4L3
	zCe28QhDyzGjN1bkmgKe6vsIiC0bam+cLn9iIpFW7MAWwXfg0jtnu5n1H3h34MfmFO3G5i
	qNacFEXu40AGCube0xx1c/rSOfSL/SbOJ77GaDA7idLhM0J906UYi30Tk70p6NuKk9uBUK
	Yi2P0Z+AHdHV0EzEzWPqZOI1ZICvoeuLI6ddeUXL0gDCwYvhY+psx+V4Qj+YXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782810576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kgGP9hBENnvmbyQzj6Qb2u1ao9pcznfGmAryyHBTaM=;
	b=aReN4na0+mcVfhapX7ko4nvMihpcIZSclkp52Typ7YVSjpbkE6w1zOMmsfs/JuDHEUdzTu
	eHFWbnj7/HlC1QBA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Fix kernel address leakages in LBR stack
Cc: Ian Rogers <irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260612090114.3188886-5-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178281057484.3843924.2217056598830339730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     707ada0c09e915f6feb181d3d2d7ed957312db8d
Gitweb:        https://git.kernel.org/tip/707ada0c09e915f6feb181d3d2d7ed95731=
2db8d
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Fri, 12 Jun 2026 17:01:10 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 Jun 2026 10:57:06 +02:00

perf/x86/intel: Fix kernel address leakages in LBR stack

Before Arch LBR gained CPL filtering support, a user-only branch stack
could still contain kernel addresses. As a result, kernel branch records
may be exposed to user space even when PERF_SAMPLE_BRANCH_USER is
requested.

For example, on Intel Tiger Lake, the following command can still report
SYSRET/ERET entries with kernel-space from addresses:

$./perf record -e cycles:p -o - --branch-filter any,save_type,u -- \
 	./perf bench syscall basic --loop 1000 | \
	./perf script -i - --fields brstack|tr ' ' '\n'| \
	grep -E '0x[89a-f][0-9a-f]{15}'

    Total time: 0.000 [sec]

      0.219000 usecs/op
     4,566,210 ops/sec
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.551 MB - ]
0xffffffff93c001c8/0x7f12a2b1d647/P/-/-/16959/SYSRET/-
0xffffffff93c001c8/0x7f12a2b1d5c2/P/-/-/17535/SYSRET/-
0xffffffff93c01928/0x7f12a2861000/P/-/-/6719/ERET/-
0xffffffff93c01928/0x7f12a297a000/P/-/-/8575/ERET/-

The problem is that intel_pmu_lbr_filter() does not fully validate the
privilege level of sampled entries. It filters some mismatches based on
the branch type and the to address, but it does not reject entries whose
from address violates the requested branch privilege filter.

Fix this by extending software filtering to validate both from and to
addresses against br_sel. Any LBR entry contains kernel address does not
match the requested user filter is dropped. This prevents kernel
addresses from appearing in user-only branch stacks.

Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260612090114.3188886-5-dapeng1.mi@linux.inte=
l.com
---
 arch/x86/events/intel/lbr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 688d1df..f8fadb0 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1213,7 +1213,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 {
 	u64 from, to;
 	int br_sel =3D cpuc->br_sel;
-	int i, j, type, to_plm;
+	int i, j, type, from_plm, to_plm;
 	bool compress =3D false;
=20
 	/* if sampling all branches, then nothing to filter */
@@ -1245,8 +1245,14 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 				type |=3D X86_BR_NO_TX;
 		}
=20
-		/* if type does not correspond, then discard */
-		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
+		from_plm =3D kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
+		/*
+		 * If type does not correspond, then discard.
+		 * Specifically reject entries whose from address is in
+		 * kernel space when only X86_BR_USER is requested.
+		 */
+		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type ||
+		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {
 			cpuc->lbr_entries[i].from =3D 0;
 			compress =3D true;
 		}
