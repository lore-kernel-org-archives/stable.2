Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660995;
	b=WPwvWNiuFkfMGydKLBzIOC9Tie5rCjmZc7FgrJktZBKb122v5zMPobfeF2826+8StcM/
	 iz1n3n7pf7d63nVumZ+oARbq4+kVPfIbKuPjPEK8C9l3CVrsjQmmMDaihAPrlaUemTl90
	 GESdVu5ZsnyM4GWrcKvGOtFZjWM597Iv1NOYCkroVdlXrTcWdFP7lhfpUWDyz5jal83DP
	 Ws+UOBx0LTRNmgKp7uoPtGr0/ym5khsfOBImTqr/c3eDG+bptPAayoqCnnAOmh2S+XOwX
	 JW+tRc1Ov2pur7a58O1BcNBVabb//GOETyaNudUrpI+sX8pM7Q09rawN0OZrgkQcDUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660995;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:MIME-Version:Message-ID:Robot-ID:Robot-Unsubscribe:
	 Precedence:Content-Type:Content-Transfer-Encoding;
	bh=porKAZwKb4aesGQ/hTZfda+fcuNVWaxvV1I9VODbv14=;
	b=uj4oV5rczHBhSU7sB5TRBzHJEGBX4y+WtQo+4h6Z/znc40Q5nM7vbMiQHjY9EiGXniSq
	 bJh3vW2TlNBts7to2bUy9emG+NTm4wKc+SqeU3GxtNfkUImu4phUTbmSW+9if6lvmEQ1D
	 Wz/dVKI42ZPxXF2msjcRSGDRubdAgrklnXqKft1zzjQPx6gmLNoqcGI3sd1chfM3mRAfg
	 l7ixULZmHzZcG5RSscVGRVA7GrFU65ZkXiCYPzm4oX25zviy73mt/EfSKk34jpHS5B49r
	 pi47TiaFqB92/QKEOC1qOhktinNU9pe2OLmX/wyB2ZXOb0HCyaTKII88eOWd2WpnEzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TkpeDX+T;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tCptTHN+;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758BA606A324;
	Mon,  2 Nov 2026 23:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 758BA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TkpeDX+T;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tCptTHN+
Date: Mon, 02 Nov 2026 23:09:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793660991;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=porKAZwKb4aesGQ/hTZfda+fcuNVWaxvV1I9VODbv14=;
	b=TkpeDX+TmxQIRvGT19vJrpg+M/E7NNxDwY16w7hNfrN8d8qH4rLnrvo4Z0rDk10TBJHpHZ
	PY4lOADfdZQr6QIY1j3Qt1VSDZpQdLTMtBFoVqFm/gvX7rLhtzVTtxsto+AxPq57x13KNv
	XYnj+U2zPA3QT7Qas6/FKXcctlpV15cxUKBs/w2DkKFD4ihZfqRhIbS33VWBbKgPFJXo4K
	sxt1KGHQVxhWcbZKUWE0+sr1yvWWi9oB6UPfR/AjPNHYNqt6t2JN5cQsPDeZEf00vow1u9
	/XfsiyxQSLqFZIyHiFe8/IFH1OeUpo9taEKB9VlxFIAR5/6E9PWGrtL5A95S1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793660991;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=porKAZwKb4aesGQ/hTZfda+fcuNVWaxvV1I9VODbv14=;
	b=tCptTHN+AQn1aNF5Irx/ZB3RoMMqxqF/t/LVk1gKKbkq6rnQD2lKwYKdHjVZ7/wcjDigYL
	n6zC75qcBR2r79DQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179366098956.1009794.11881151975780796493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7782a6a8dfc05f5622fdf616e5cf3df7d16eaef5
Gitweb:        https://git.kernel.org/tip/7782a6a8dfc05f5622fdf616e5cf3df7d16=
eaef5
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 30 Oct 2026 15:28:48 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Nov 2026 15:03:09 -08:00

x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot

The mbm_event mode assigns hardware MBM counters to RMID/event pairs.  It is
intended for deployments that need to manage counter assignment on platforms
where the number of monitoring groups exceeds the available hardware counters.
Hardware counters are scarce on these platforms, so mbm_event mode suits
workflows that monitor a subset of groups at a time and rotate assignments as
needed.

x86 resctrl enables the mbm_event mode by default on hardware that supports
it. This breaks the pqos tool=C2=B9, which assumes the historical default mod=
e.
It creates 16 or more monitoring groups and uses two counters per group. On
a platform with 32 counters per domain, that exhausts the mbm_event counters
pool, causing additional groups to read "Unassigned".  pqos interprets
a non-numeric event read as zero bandwidth and reports 0 MB/s for those
groups:

  $ sudo pqos -m all:0-4
  CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
     0        0.69         16k       192.0         0.0         0.0
     1        0.40          3k         0.0         0.0         0.0
     2        0.44          1k        64.0         0.0         0.0
     3        0.39          1k        64.0         0.0         0.0
     4        0.43          1k         0.0         0.0         0.0

Leave mbm_assign_mode in default mode during initialization as decided in the
thread at the Link tag. Default mode uses one counter per monitoring group. On
existing AMD platforms, the default active counters pool is 64 and may be
larger on newer hardware.  The active counters pool is the number of counters
that the hardware can actively track in default mode.

Deployments within the active counters pool receive accurate bandwidth
measurements in the default mode. Users can create more monitoring groups (for
example, 4096 on current hardware) than there are active counters in the pool.
Beyond that pool, readings may be misleading or report as "Unavailable", with
no user-visible indication.

Default mode is still limited once the number of monitoring groups exceeds
that active counters pool. After hardware re-allocates a counter, a read
may return "Unavailable". pqos still treats "Unavailable" as zero.
Successive reads can be a count, "Unavailable", then another count. pqos
treats those jumps as wraparound and can report an inconsistent rate:

  $ sudo pqos -m all:0-4
  CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
  0        0.76         60k        32.0         0.0         0.0
  1        0.45          1k        32.0         0.0         0.0
  2        1.57        107k        64.0         0.0 17592186044184.9
  3        1.62        276k      4928.0         3.2         0.5

Users that need stable measurements beyond the active counters pool should
use mbm_event mode and rotate assignments as needed. Enable it with:

  # echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

=C2=B9https://github.com/intel/intel-cmt-cat

  [ bp: Massage commit message. ]

Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
Closes: https://github.com/intel/intel-cmt-cat/issues/311
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260804191608.GDanI6eK2Q07w6pNcb@fat_crate=
.local
---
 Documentation/filesystems/resctrl.rst | 87 +++++++++++++++-----------
 arch/x86/kernel/cpu/resctrl/monitor.c |  1 +-
 2 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index b52795e..2750f2e 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -350,12 +350,12 @@ with the following files:
 "mbm_assign_mode":
 	The supported counter assignment modes. The enclosed brackets indicate whic=
h mode
 	is enabled. The MBM events associated with counters may reset when "mbm_ass=
ign_mode"
-	is changed.
+	is changed. See architecture specific notes below.
 	::
=20
 	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
-	  [mbm_event]
-	  default
+	  [default]
+	  mbm_event
=20
 	"mbm_event":
=20
@@ -373,20 +373,17 @@ with the following files:
 	Moving to mbm_event counter assignment mode requires users to assign the co=
unters
 	to the events. Otherwise, the MBM event counters will return 'Unassigned' w=
hen read.
=20
-	The mode is beneficial for AMD platforms that support more CTRL_MON
-	and MON groups than available hardware counters. By default, this
-	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
-	Monitoring Counters) capability, ensuring counters remain assigned even
-	when the corresponding RMID is not actively used by any processor.
+	It is intended for deployments that need to manage counter assignment on
+	platforms where the number of monitoring groups exceeds the available
+	hardware counters. Hardware counters are scarce on these platforms, so
+	mbm_event mode suits workflows that monitor a subset of groups at a time and
+	rotate assignments as needed. The mbm_event mode ensures counters remain
+	assigned even when the corresponding RMID is not actively used.
=20
 	"default":
=20
 	In default mode, resctrl assumes there is a hardware counter for each
-	event within every CTRL_MON and MON group. On AMD platforms, it is
-	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
-	events between reads resulting from hardware re-allocating counters. This c=
an
-	result in misleading values or display "Unavailable" if no counter is assig=
ned
-	to the event.
+	event within every CTRL_MON and MON group.
=20
 	* To enable "mbm_event" counter assignment mode:
 	  ::
@@ -398,6 +395,24 @@ with the following files:
=20
 	    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
=20
+	In default mode on AMD platforms that support more CTRL_MON and MON groups
+	than hardware counters, hardware dynamically shares a smaller pool of
+	counters among RMIDs. One counter from this pool is used per monitoring
+	group and counts every MBM event of that group's RMID. The size of the pool
+	is not enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may
+	be much larger. For example, 64 counters in this pool monitor 64 groups.
+	Newer hardware may provide a larger pool.
+
+	On such platforms, while the number of monitoring groups does not exceed
+	that pool, a counter stays attached to each RMID and readings remain
+	accurate. Creating more groups than the pool can cause hardware to
+	re-allocate those counters between successive reads of an event. Bandwidth
+	values may then be misleading, or a read may return "Unavailable" if no
+	counter is allocated to the RMID. There is no user-visible indication when
+	this begins. Users who need stable readings beyond that pool should switch
+	to mbm_event mode, if supported, and assign counters to the groups of
+	interest (rotating assignments as needed).
+
 "num_mbm_cntrs":
 	The maximum number of counters (total of available and assigned counters) in
 	each domain when the system supports mbm_event mode.
@@ -1784,17 +1799,19 @@ View the llc occupancy snapshot::
 Examples on working with mbm_assign_mode
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-a. Check if MBM counter assignment mode is supported.
+a. Check if MBM counter assignment mode is supported. Enable "mbm_event"
+mode. Switching the mbm_assign_mode may reset all the MBM counters (and
+thus all MBM events) of all the resctrl groups.
 ::
=20
-  # mount -t resctrl resctrl /sys/fs/resctrl/
-
+  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+  [default]
+  mbm_event
+  # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
   # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
   [mbm_event]
   default
=20
-The "mbm_event" mode is detected and enabled.
-
 b. Check how many assignable counters are supported.
 ::
=20
@@ -1805,36 +1822,39 @@ c. Check how many assignable counters are available f=
or assignment in each domai
 ::
=20
   # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
-  0=3D30;1=3D30
+  0=3D32;1=3D32
=20
-d. To list the default group's assign states.
+d. To list the default group's assign states. Counters are unassigned when t=
he mode
+is switched to "mbm_event".
 ::
=20
   # cat /sys/fs/resctrl/mbm_L3_assignments
-  mbm_total_bytes:0=3De;1=3De
-  mbm_local_bytes:0=3De;1=3De
+  mbm_total_bytes:0=3D_;1=3D_
+  mbm_local_bytes:0=3D_;1=3D_
=20
-e.  To unassign the counter associated with the mbm_total_bytes event on dom=
ain 0.
+e. To assign the counter associated with the mbm_total_bytes event on domain=
 0
+in exclusive mode.
 ::
=20
-  # echo "mbm_total_bytes:0=3D_" > /sys/fs/resctrl/mbm_L3_assignments
+  # echo "mbm_total_bytes:0=3De" > /sys/fs/resctrl/mbm_L3_assignments
   # cat /sys/fs/resctrl/mbm_L3_assignments
-  mbm_total_bytes:0=3D_;1=3De
-  mbm_local_bytes:0=3De;1=3De
+  mbm_total_bytes:0=3De;1=3D_
+  mbm_local_bytes:0=3D_;1=3D_
=20
 f. To unassign the counter associated with the mbm_total_bytes event on all =
domains.
 ::
=20
   # echo "mbm_total_bytes:*=3D_" > /sys/fs/resctrl/mbm_L3_assignments
-  # cat /sys/fs/resctrl/mbm_L3_assignment
+  # cat /sys/fs/resctrl/mbm_L3_assignments
   mbm_total_bytes:0=3D_;1=3D_
-  mbm_local_bytes:0=3De;1=3De
+  mbm_local_bytes:0=3D_;1=3D_
=20
-g. To assign a counter associated with the mbm_total_bytes event on all doma=
ins in
-exclusive mode.
+g. To assign a counter associated with the mbm_total_bytes and mbm_local_byt=
es
+events on all domains in exclusive mode.
 ::
=20
   # echo "mbm_total_bytes:*=3De" > /sys/fs/resctrl/mbm_L3_assignments
+  # echo "mbm_local_bytes:*=3De" > /sys/fs/resctrl/mbm_L3_assignments
   # cat /sys/fs/resctrl/mbm_L3_assignments
   mbm_total_bytes:0=3De;1=3De
   mbm_local_bytes:0=3De;1=3De
@@ -1891,13 +1911,8 @@ the MBM counters (and thus all MBM events) of all the =
resctrl groups.
=20
   # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
   # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
-  mbm_event
   [default]
-
-m. Unmount the resctrl filesystem.
-::
-
-  # umount /sys/fs/resctrl/
+  mbm_event
=20
 Intel RDT Errata
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 5d0d3b1..a6a9090 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -472,7 +472,6 @@ int __init rdt_get_l3_mon_config(struct rdt_resource *r)
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 		/* cntr_id is 12 bits and can only encode 4096 counters. */
 		r->mon.num_mbm_cntrs =3D min((ebx & GENMASK(15, 0)) + 1, BIT(12));
-		hw_res->mbm_cntr_assign_enabled =3D true;
 	}
=20
 	r->mon_capable =3D true;
