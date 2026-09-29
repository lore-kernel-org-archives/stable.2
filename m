Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1F253340
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664146; cv=none; b=SfErCSPmRF64//mKXdoHvx7qAz3JR6FpPC2e1Ca/1SLC+hVQd5WPkDzIaC8PabaGo18EtKdY5XgVYZwI3knFZrzpvoQDuPthYw5lhhsr13+ABH/hHeurCUIJlRLqFQA8D41ZuOaCbUjW53fpyQd3L7G4ivX/6WkhvDRiejWcCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664146; c=relaxed/simple;
	bh=NlP+B1oQVh6g8b0Y7slxBXKao6aNQsWeIBIU3unzxPM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eNOIzI93rftHU5H7ExeZEVM0NfL5Qovf+8fNkg5MT1A82u/Gqa/bBOJiWXsXJRyNQlDggyYn/gYPy5p5Gs4jbSsQvIRTJ2AQt810+J1jw+wzuLMJA5Oz/4af2K01KdV65tkkJZgj8YP3uhTq/rgwaTeeVxnP/49kEDw8I/cP8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iTzJtMmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iTzJtMmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CBD1F000FF;
	Tue, 29 Sep 2026 06:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664144;
	bh=Z17yUFPhU2U9C+Os+fcyT6qJQh8SGD1dRWt3tqx/pPg=;
	h=Subject:To:Cc:From:Date;
	b=iTzJtMmDWeTsMrd3r7PTC1Yhk4XQPloBQHoDEvOZDJbpFHHSAFQeY7sx+ZO9Z6CQL
	 kNOr++c9KCyw367osR2mbE92+bIu2QXuivPGReoy0dPHmyX5jISYV+/ygQPgJEpvHz
	 ebMexxBHD0W+yMsGVgum5UJ/ahREAbj4sN6B9Bq8=
Subject: FAILED: patch "[PATCH] arm64/boot: Disable trapping of PMZR_EL0 writes to EL2" failed to apply to 6.12-stable tree
To: fuad.tabba@linux.dev,anshuman.khandual@arm.com,oupton@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:42:22 +0200
Message-ID: <2026092922-crouton-reaffirm-8593@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2bc6b218717b9d08f466f88209251d54bc09b207
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092922-crouton-reaffirm-8593@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2bc6b218717b9d08f466f88209251d54bc09b207 Mon Sep 17 00:00:00 2001
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 22 Sep 2026 19:14:30 +0100
Subject: [PATCH] arm64/boot: Disable trapping of PMZR_EL0 writes to EL2

__init_el2_fgt2() writes one mask to both HDFGRTR2_EL2 and HDFGWTR2_EL2.
PMZR_EL0 is write-only, so its trap bit, nPMZR_EL0, exists only in
HDFGWTR2_EL2 and is therefore never set: a PMZR_EL0 write from the host
traps to EL2, where the nVHE hypervisor has no handler and BUG()s. The
kernel never writes PMZR_EL0, but kernel.perf_user_access=1 has the PMU
driver set PMUSERENR_EL0.UEN for a task with a user-read event, so a
write from EL0 reaches the trap and takes the host down without a panic
message.

Accumulate the HDFGWTR2_EL2 bits separately, as __init_el2_fgt() already
does for HDFGWTR_EL2, and set nPMZR_EL0 with the other FEAT_PMUv3p9
bits.

Fixes: 858c7bfcb35e1 ("arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index 13ef311dace8..3fea4b14ef7c 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -465,6 +465,7 @@ Before jumping into the kernel, the following conditions must be met:
     - HDFGWTR2_EL2.nPMICNTR_EL0 (bit 2) must be initialised to 0b1.
     - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
     - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
+    - HDFGWTR2_EL2.nPMZR_EL0 (bit 21) must be initialised to 0b1.
 
   For CPUs with SPE data source filtering (FEAT_SPE_FDS):
 
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index aa8ec9df8024..87560d8b254e 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -418,6 +418,7 @@
 	b.lt	.Lskip_fgt2_\@
 
 	mov	x0, xzr
+	mov	x2, xzr
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
 	cmp	x1, #ID_AA64DFR0_EL1_PMUVer_V3P9
@@ -426,6 +427,11 @@
 	orr	x0, x0, #HDFGRTR2_EL2_nPMICNTR_EL0
 	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
 	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
+	orr	x2, x2, #HDFGWTR2_EL2_nPMICNTR_EL0
+	orr	x2, x2, #HDFGWTR2_EL2_nPMICFILTR_EL0
+	orr	x2, x2, #HDFGWTR2_EL2_nPMUACR_EL1
+	/* PMZR_EL0 is write-only, so it has no read trap to disable */
+	orr	x2, x2, #HDFGWTR2_EL2_nPMZR_EL0
 .Lskip_pmuv3p9_\@:
 	/* If SPE is implemented, */
 	__spe_vers_imp .Lskip_spefds_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x1
@@ -436,10 +442,11 @@
 	cbz	x1, .Lskip_spefds_\@
 	/* disable traps of PMSDSFR to EL2. */
 	orr	x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
+	orr	x2, x2, #HDFGWTR2_EL2_nPMSDSFR_EL1
 
 .Lskip_spefds_\@:
 	msr_s   SYS_HDFGRTR2_EL2, x0
-	msr_s   SYS_HDFGWTR2_EL2, x0
+	msr_s   SYS_HDFGWTR2_EL2, x2
 	msr_s   SYS_HFGRTR2_EL2, xzr
 	msr_s   SYS_HFGWTR2_EL2, xzr
 	msr_s   SYS_HFGITR2_EL2, xzr

