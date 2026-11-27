Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779024;
	b=wXzU1Ptiw9hhVLJjKI6YgtJlVp32vp6BdfXJal0CfBpXBiOgBv2AgQGf5mWfICg/hAib
	 FjwA5473fBuAHkZjjQslNFJbz2M45gJL6tRtd7SqB6KJoVk/QaexldDQWYhPr+KdYx8b5
	 u32ktQstF9Q31WL/yXMULewW5UplY4/5YqpchHuebbvrUuluacpK4T/0MNWMftPK5miDN
	 mX52LxtuqGmjFAQ5nqVa/Fg68dcm00isF2gsOv1+lQ9wrsW3qdcXbyf73YZcpFVLNzTkn
	 kmkRQBPe+mPnHm4u4D4mIvDOBkYrt+uoNBG53CWVkwH8KYSSNoDdV6rxBtzYzLtmYMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779024;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=K5Swrz1cA4/FZhj9LgmmqfX1toxT4yNd5HBltxE7hfU=;
	b=PG/VFX1XJKbEz0j3iDeA5UF7dwlz3XXtI74xAc0y081UgP4yyXw1I6VaP/W5jXI3ELsv
	 sj/KeK3BYImio3a62OmTHglWpXoZbhXu2dcrz4acDP/N6veAzrOSzUbUl4fJmvh1fsNcV
	 l5u6vmjWnMDpbtvG6YQoTCwz7eO4fII5l1MTvOzyeSZx6oIWGI7kCXnpIxcnVXvRVtFXm
	 OEjk/7rXmA67kav/XRgVFbRYHG0fIPlnNyyaMR4XIdNVLrNriFMT0GFZ5ThUevu0t1PHL
	 YtDCjSDiW3ZUk/ugDA1nyDLuOY/hcX+kSrKc54LPRig4oTKx8mfdZ+k97WxNfDLeuiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=XuFVFQdE;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5E606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6B5E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=XuFVFQdE
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 653A520DC832;
	Fri, 27 Nov 2026 12:30:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id 3FF9320DC64F;
	Fri, 27 Nov 2026 12:30:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 3FF9320DC64F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1795779021;
	bh=K5Swrz1cA4/FZhj9LgmmqfX1toxT4yNd5HBltxE7hfU=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=XuFVFQdETYRurfvSIC5qxXpI0J3JWM1KxGu6CKVm8B24p0OzAIO4CdmfHuEo2cG47
	 pCzshr0OSXqA1ZyiJ2sxQN1Vd993ZrcSox0RH+ktSSqS4lfOKn8XTqhb6n/O2zbCbu
	 Vgd9fUCz84SrmPBgFRL8aX0roGhygn/xqFbaD7xyspPEJhhqnSJIV2hM9uODeGWQ/L
	 OWVimU2+Ind7OPjyHfRXvbXcDNHT2uzfiih0s3HVgotlNNbwik5btXfaxNNT0jVrAi
	 /EBFv5rGEPJH5L9k1t4E/tPtzUFAbXZWNii2EHrO4WzpUSCZxJ5VfnXszCufLc9AFl
	 krk5ytvI4MSyA==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id Fz9y9CjViu0B; Fri, 27 Nov 2026 12:30:21 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id D751920DC832;
	Fri, 27 Nov 2026 12:30:20 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/nouveau/fifo/gf100-: reset the faulting engine even if it switched channels
Date: Fri, 27 Nov 2026 12:30:05 +0100
Message-ID: <20261127113005.981725-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When an engine reports an MMU fault, recovery flags the faulting
channel group and nvkm_runl_rc() resets only the engines whose current
context (cxid) belongs to a flagged group.  On Fermi the fault can be
reported after GR has started switching to another channel: the engine
status then reads e.g. 0x01140003 (not busy, chid 3) while channel 4
faulted, so GR is not reset, stays stalled on the fault, and the
runlist update never completes:

  fifo: fault 01 [WRITE] at 0 engine 00 [PGRAPH] client 0f [GPC0/PROP] re=
ason 02 [PAGE_NOT_PRESENT] on channel 4
  object-namespac[1768]: channel 4 killed!
  fifo:000000:00[      gr]: 01140003: busy 0 save 1 unk0 0 unk1 0 chid 3
  fifo:000000:00[      gr]: cxid not valid
  WARNING: drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv50.c:228 at nv50_ru=
nl_wait+0xe8/0x100 [nouveau]
  fifo: SCHED_ERROR 0d []
  WARNING: drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c:251 at nvkm_ru=
nl_preempt_wait+0xf7/0x110 [nouveau]

After that no channel makes progress: the whole GPU is dead until a
reboot, and processes using it hang in D state.

Record in the channel group which engines reported a fault for it.  The
recovery pass that takes the group from pending to running collects
that mask, and resets those engines regardless of what their status
says.  Resetting GR may discard the context being switched in, but that
is far better than losing the GPU.

Faults reported for a group whose recovery is already running are
recorded but never acted on: as before, such a group is not recovered
again, and keeping the mask with the group means a later recovery of
another group cannot reset an engine on its behalf.

Tested on a Quadro 600 (GF108): a program that faults (piglit
"object-namespace-pollution glClearTexSubImage texture") while three
other processes keep GR busy hangs the GPU within one to three faults
without this patch.  With it, 20 of 20 faults recovered (17 of them hit
the state above), with no runlist timeouts, and the GPU kept working.
On an NVS 315 (GF119) the same test hangs the GPU at the first fault
without this patch; with it, 20 of 20 rounds completed, every fault was
recovered, and the GPU kept working.

Written with help from Claude (Anthropic); reviewed and tested on hardwar=
e.

Fixes: 4d60100a23ec ("drm/nouveau/fifo: add common channel recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
---
v2: keep the faulting engines in the channel group (cgrp->rc_engm)
instead of a per-engine flag, and consume them only in the recovery
pass that takes that group into recovery.  v1 could leave the flag set
when a second fault arrived for a group already in recovery, so that a
later recovery of another group would reset the engine; it could also
let a pass already in progress reset an engine for a group whose
channels it had not removed yet.  Both reported by the Sashiko review of
v1.  rc_engm is initialised explicitly, as nvkm_cgrp_new() uses kmalloc.
v2 was tested again on the Quadro 600 (GF108): the piglit test above
recovered 20 of 20 faults (17 in the state above); "nv-mmu-fault -e
noctx" (below) recovered 60 of 60 runs, plus 20 of 20 with fifo debug
output, where GR was reset every time through the new mask (its status
held no valid context); "-e gr" under load recovered 2 x 40 of 40.  No
runlist timeouts.  The NVS 315 numbers are from v1.
v1: https://lore.kernel.org/nouveau/20261126175531.916097-1-frederic.mahe=
@cirad.fr/

Tested on GF108 and GF119 only. gf100_fifo_mmu_fault_recover() is also us=
ed by
gk104, gm107, gv100 and tu102 (non-GSP), so the change applies to those
too; feedback from such hardware is welcome.

A small libdrm program reproduces this without Mesa or piglit
(nv-mmu-fault.c, available on request):

  nv-mmu-fault -e noctx

sends one graphics method on a channel that has no graphics object.
PGRAPH's context-switch unit then faults (READ at 0, HUB/CTXCTL)
while the engine status no longer names the channel. On an NVS 315
(GF119), without this patch the GPU is dead after the first run;
with it, 60 of 60 runs recovered. "nv-mmu-fault -e gr" in a loop
with three processes keeping PGRAPH busy gives the WRITE fault of
the log above: dead at the 4th fault without the patch, 40 of 40
recovered with it.

 drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c  |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.h  |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c | 11 +++++++++--
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c  | 15 ++++++++++++---
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/fifo/cgrp.c
index 7e2d5711a..93b79bcaf 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c
@@ -241,6 +241,7 @@ nvkm_cgrp_new(struct nvkm_runl *runl, const char *nam=
e, struct nvkm_vmm *vmm, bo
 	INIT_LIST_HEAD(&cgrp->vctxs);
 	mutex_init(&cgrp->mutex);
 	atomic_set(&cgrp->rc, NVKM_CGRP_RC_NONE);
+	atomic_set(&cgrp->rc_engm, 0);
=20
 	if (runl->cgid) {
 		cgrp->id =3D nvkm_chid_get(runl->cgid, cgrp);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.h b/drivers/gp=
u/drm/nouveau/nvkm/engine/fifo/cgrp.h
index 5f6abd59a..e7e6abe9e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.h
@@ -50,6 +50,7 @@ struct nvkm_cgrp {
 #define NVKM_CGRP_RC_PENDING 1
 #define NVKM_CGRP_RC_RUNNING 2
 	atomic_t rc;
+	atomic_t rc_engm; /* engines that faulted on the group, reset during it=
s RC */
=20
 	struct list_head head;
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/fifo/gf100.c
index e4a4fad2e..b12f7d396 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
@@ -597,9 +597,16 @@ gf100_fifo_mmu_fault_recover(struct nvkm_fifo *fifo,=
 struct nvkm_fault_data *inf
 		   info->reason, er ? er->name : "",
 		   chan ? chan->id : -1, info->inst, chan ? chan->name : "unknown");
=20
-	/* Handle host/engine faults. */
-	if (chan)
+	/* Handle host/engine faults.  The engine that reported the fault must
+	 * be reset even if it has already switched to another channel (its
+	 * status then no longer points at the faulting channel), otherwise it
+	 * stays stalled and the runlist update never completes.
+	 */
+	if (chan) {
+		if (engine && engn->runl =3D=3D chan->cgrp->runl && !WARN_ON(engn->id =
>=3D 32))
+			atomic_or(BIT(engn->id), &chan->cgrp->rc_engm);
 		nvkm_runl_rc_cgrp(chan->cgrp);
+	}
=20
 	nvkm_chan_put(&chan, flags);
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/fifo/runl.c
index 209252105..daddc2080 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c
@@ -63,6 +63,7 @@ nvkm_runl_rc(struct nvkm_runl *runl)
 	struct nvkm_engn *engn;
 	unsigned long flags;
 	int rc, state, i;
+	u32 engm =3D 0;
 	bool reset;
=20
 	/* Runlist is blocked before scheduling recovery - fetch count. */
@@ -75,6 +76,9 @@ nvkm_runl_rc(struct nvkm_runl *runl)
 	nvkm_runl_foreach_cgrp_safe(cgrp, gtmp, runl) {
 		state =3D atomic_cmpxchg(&cgrp->rc, NVKM_CGRP_RC_PENDING, NVKM_CGRP_RC=
_RUNNING);
 		if (state =3D=3D NVKM_CGRP_RC_PENDING) {
+			/* Collect the engines that reported a fault for the group. */
+			engm |=3D atomic_xchg(&cgrp->rc_engm, 0);
+
 			/* Disable all channels in them, and remove from runlist. */
 			nvkm_cgrp_foreach_chan_safe(chan, ctmp, cgrp) {
 				nvkm_chan_error(chan, false);
@@ -99,14 +103,19 @@ nvkm_runl_rc(struct nvkm_runl *runl)
=20
 	/* Look for engines that are still on flagged channel groups - reset th=
em. */
 	nvkm_runl_foreach_engn_cond(engn, runl, engn->func->cxid) {
+		bool faulted =3D engn->id < 32 && (engm & BIT(engn->id));
+
 		cgrp =3D nvkm_engn_cgrp_get(engn, &flags);
-		if (!cgrp) {
+		if (!cgrp && !faulted) {
 			ENGN_DEBUG(engn, "cxid not valid");
 			continue;
 		}
=20
-		reset =3D atomic_read(&cgrp->rc) =3D=3D NVKM_CGRP_RC_RUNNING;
-		nvkm_cgrp_put(&cgrp, flags);
+		reset =3D faulted;
+		if (cgrp) {
+			reset |=3D atomic_read(&cgrp->rc) =3D=3D NVKM_CGRP_RC_RUNNING;
+			nvkm_cgrp_put(&cgrp, flags);
+		}
 		if (!reset) {
 			ENGN_DEBUG(engn, "cxid not in recovery");
 			continue;
--=20
2.53.0

