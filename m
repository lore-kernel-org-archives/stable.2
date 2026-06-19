Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A64964F;
	Fri, 19 Jun 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898608; cv=none; b=Cv+44ADZzvau1Ha/0gKMyOzzBGyCSs8gRDuvEobzngiwleUjm4BNGdizwD79mjcM6xGUl/AG0wthnfKEBgdb73HO9Ht697iua83E4ywqy0YyO0bxiCZd1/INIy6CTzpatyI8Y0VuXrh7KKChJYP2TlzbAI8DtAxMErxkMJxWq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898608; c=relaxed/simple;
	bh=3Esf1VI+8mBSZlXZxyE8DJVNAndQ6nurenBFK82rTlA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EQqi8Nk3rHkps1JKON+sNg+keVMV4yf5aVsWMrAIE67gF9LUNdwNEBO7jMW4cq0hpHENcizwByjkiiSdeFR8hoPDHicy9c1KgkMEzlWEWGXSgNstMfoCzQ3RMhGyAIReldb9Gt8QRn5+QDMd89w/DPoySWFJu9NAoFRZrKJS9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nBYEWSKs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=50/93gSQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nBYEWSKs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="50/93gSQ"
Date: Fri, 19 Jun 2026 19:50:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781898605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvKfI+GpKNgzTfe3Vr/kACgxpad8Jy5xzUpUdkQ7oAw=;
	b=nBYEWSKsu0o3EGIDZduPcYnubqlQ/QdiMTe8ji+8NeBiw+mPn9mvKn5HjJnTskU5+12phH
	ZmfMhCbi0oqnW/+Wng+GmwMPbEv+A+uZVBTVJQc2dHvqSyukqzTVeESjJKq9YjsKsEu1Mr
	EQB7wxUs+mJ45cDJlzxyYjryCyh0ZscERZ/KPcPtQ8du+g8F3tKrmFEvUTvKy5PmdlFFhE
	sNzGNgFqHQHmSfjWsk24hfYvRZ1PWrFPAr898MXtiA5uHocwPccOlZMrRaLRdbEMB96+PD
	KsW/dzmydV4nHoigtSI+zF6oC8wz1Ai4tvEWfh2Z8aqwgnHchI3yGboQVqggkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781898605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvKfI+GpKNgzTfe3Vr/kACgxpad8Jy5xzUpUdkQ7oAw=;
	b=50/93gSQ0LnXP85bqAiYLHC877OT3ATf8QA4VRlGQR0lag8ffIlAQS6oZo630lXss1vFLr
	9a5QgTXpg/za2bDw==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] sched/mmcid: Fix OOB clear_bit when CID is
 MM_CID_UNSET in fixup path
Cc: Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260616203818.1516263-1-riel@surriel.com>
References: <20260616203818.1516263-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178189860337.1650852.6769464560023388491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     de3ab9bd3133899efb92e4cd05ba4203e58fc0a3
Gitweb:        https://git.kernel.org/tip/de3ab9bd3133899efb92e4cd05ba4203e58=
fc0a3
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 16 Jun 2026 16:38:17 -04:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 19 Jun 2026 21:44:16 +02:00

sched/mmcid: Fix OOB clear_bit when CID is MM_CID_UNSET in fixup path

In mm_cid_fixup_cpus_to_tasks(), when rq->curr has the target mm and
mm_cid.active is set, the CID is checked with cid_in_transit() before
setting the transition bit.  In per-CPU mode a newly forked or exec'd
task can be running with mm_cid.cid =3D=3D MM_CID_UNSET because CIDs are
assigned lazily on schedule-in.  With cid_in_transit() the guard passes
for MM_CID_UNSET (no transit bit), converts it to MM_CID_UNSET |
MM_CID_TRANSIT and stores it back; later mm_cid_schedout() feeds this
to clear_bit() with MM_CID_UNSET as the bit number, triggering an
out-of-bounds write.

Symptoms: this is genuine memory corruption, but a bounded out-of-bounds
write, not an arbitrary one.  MM_CID_UNSET is the fixed sentinel BIT(31),
so once the bad value reaches mm_cid_schedout() the cid_from_transit_cid()
strip leaves MM_CID_UNSET, which fails the "cid < max_cids" convergence
test and falls into mm_drop_cid() -> clear_bit(MM_CID_UNSET,
mm_cidmask(mm)).  The cid bitmap is embedded in the mm_struct slab object
(after cpu_bitmap and mm_cpus_allowed) and is only num_possible_cpus()
bits wide, so clearing bit 31 is a deterministic OOB bit-clear at a
fixed offset of 2^31 / 8 =3D=3D 256 MiB past the bitmap base.  The address is
not attacker-influenced (fixed sentinel -> fixed offset) and the op only
clears a single bit; what sits 256 MiB further along the direct map is
whatever kernel object happens to live there, so this corrupts one bit of
unpredictable kernel memory -- it is not an arbitrary-address or
arbitrary-value write.

It triggers only in per-CPU CID mode, when a CPU is running an active
task of the target mm whose cid is still MM_CID_UNSET -- the
fork()/execve() window before that task's next schedule-in assigns it a
real CID -- and a per-CPU -> per-task fixup walks over it (the mode
fallback driven by a thread exit, sched_mm_cid_exit(), or by the deferred
max_cids recompute in mm_cid_work_fn()).

In practice syzkaller surfaced it as a KASAN use-after-free reported in
__schedule -> mm_cid_switch_to, where the offending clear_bit() is inlined
via mm_cid_schedout() -> mm_drop_cid().

Guard the transition-bit assignment against MM_CID_UNSET, in addition to
the existing cid_in_transit() check, so the bit is only set on a genuine
task-owned CID.  A CPU-owned (MM_CID_ONCPU) CID of a running active task
is handled by the cid_on_cpu(pcp->cid) branch above and never reaches
this path, so excluding MM_CID_UNSET (and the already-transitioning case)
is sufficient.

Fixes: fbd0e71dc370 ("sched/mmcid: Provide CID ownership mode fixup functions=
")
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Assisted-by: Claude:claude-opus-4-8 syzkaller
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260616203818.1516263-1-riel@surriel.com
---
 kernel/sched/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8b791e9..3cc6fb1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10909,8 +10909,19 @@ static void mm_cid_fixup_cpus_to_tasks(struct mm_str=
uct *mm)
 		} else if (rq->curr->mm =3D=3D mm && rq->curr->mm_cid.active) {
 			unsigned int cid =3D rq->curr->mm_cid.cid;
=20
-			/* Ensure it has the transition bit set */
-			if (!cid_in_transit(cid)) {
+			/*
+			 * Set the transition bit only on a genuine task-owned
+			 * CID. A running active task can legitimately have
+			 * MM_CID_UNSET here: in per-CPU mode CIDs are assigned
+			 * lazily on schedule-in, so the fork()/execve() window
+			 * leaves the task active with no owned CID. Setting the
+			 * transition bit on MM_CID_UNSET would later feed
+			 * clear_bit() an out-of-bounds bit number via
+			 * mm_cid_schedout(), so exclude it. A CPU-owned
+			 * (MM_CID_ONCPU) CID is handled by the cid_on_cpu()
+			 * branch above and never reaches here.
+			 */
+			if (cid !=3D MM_CID_UNSET && !cid_in_transit(cid)) {
 				cid =3D cid_to_transit_cid(cid);
 				rq->curr->mm_cid.cid =3D cid;
 				pcp->cid =3D cid;
