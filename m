Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715757;
	b=HnySt/CuLXI4ieXpxvSvkDDBAWXhn4WNy13miAlu+8/lGYHIW8gWjAGCop1AEPRfgYwl
	 Gkkf5xMWNypPwabgQ/JLCrXfsbGeVIU4aRb9D74NKudO8i5vWGTse9mtpPXQnZ+jetXOr
	 437Z0a0CAIW57g1xu1fUDUcIKOPXmvO72gXT5at4K4jVDEotZkf8f859oVwKazVHo5IYX
	 GFjhbhxUXsENbEzv6ub1s23HVNfjYWQ/8mdMt9Cymjz7AgXgIvOQgGHgKARinnDB/lCK5
	 RWNeg2vTN0aHi9YT80EKfDe3g7uCwqCFFSlhjZRZsdEENeDaxNT1AKDYMnOM7iIazMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715757;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CHLgaJFPBR8IktC1roGL62X+2xMi1bLnLcLfpf/cxsc=;
	b=1i7Ro5dPHC+oPQzi5KY9YAnOeg+vM1AvyyDcvAAU+zV3qkd2cyyhV4tOLcas+ujc6/16
	 wkCYEivNyKhJ5U0bkx/h85dfszt8QobiiZHCxbtzR8HLITzkvb8lorNyOhgBYaMdNh7t/
	 o543HUfCLSLZIa9UAxONXP70lBFxL453b1wurWo1BgxJG3Cvrpef43DT6sSssONmiLTOf
	 NP+KOtMhVAXFdVNhitO45MmbyCo9ImOqjIavJE8c4x9cMs5CH1i1YDClI71XbdCmH3vHe
	 lRFYNg3Ycu0P03a62w0Cfo7ecxscmDdwxjZv1nktbYhbUczzshxQvIr1zz8A50eJnGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=gaGmKrxl;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8599606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8599606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=gaGmKrxl
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 1E536210CB3E;
	Thu, 26 Nov 2026 18:55:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id F04D320DCBF3;
	Thu, 26 Nov 2026 18:55:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr F04D320DCBF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1795715755;
	bh=CHLgaJFPBR8IktC1roGL62X+2xMi1bLnLcLfpf/cxsc=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=gaGmKrxlj0lxigTnISIKPREc/Ebl3W/C2QC727F7fxE777pAT6bef9eCJ9sezD6/6
	 YiBNJOzqwu2RWCcauW539roWsWwBci2Oo5xITLSomjKz5LlnjpEmEDg6RYFuVe6NJ5
	 kQ5HEGkvH9XdYuQhl+fqXEtOIGkVxEWOi5VBshVzaxRtLHd6ZlnQns+e/vgxoDap65
	 p2HmdSlOgALBCYaPGAh+n0jVL1f6iywMZqsgL43w3YT2rgIGc77I3v8N74/q9HQpRL
	 66++QzuhrFKwL4DC9iKpIEJBycPPzy3X1os6lI1NOvl1oqZ0+Fs6FGVlp5VzUomolC
	 DscTSchBYA1hg==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id JxldicDjRCxF; Thu, 26 Nov 2026 18:55:54 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id 8EEF9210CB3E;
	Thu, 26 Nov 2026 18:55:54 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/fifo/gf100-: reset the faulting engine even if it switched channels
Date: Thu, 26 Nov 2026 18:55:31 +0100
Message-ID: <20261126175531.916097-1-frederic.mahe@cirad.fr>
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

Remember which engine reported the fault, and reset it during recovery
regardless of what its status says.  Resetting GR may discard the context
being switched in, but that is far better than losing the GPU.

Tested on a Quadro 600 (GF108): a program that faults (piglit
"object-namespace-pollution glClearTexSubImage texture") while three
other processes keep GR busy hangs the GPU within one to three faults
without this patch.  With it, 20 of 20 faults recovered (15 of them hit
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

 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c | 11 +++++++++--
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c  | 11 ++++++++---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.h  |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/fifo/gf100.c
index e4a4fad..4f221c0 100644
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
+		if (engine)
+			atomic_set(&engn->rc_reset, 1);
 		nvkm_runl_rc_cgrp(chan->cgrp);
+	}
=20
 	nvkm_chan_put(&chan, flags);
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/fifo/runl.c
index 2092521..76fabe8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c
@@ -99,14 +99,19 @@ nvkm_runl_rc(struct nvkm_runl *runl)
=20
 	/* Look for engines that are still on flagged channel groups - reset th=
em. */
 	nvkm_runl_foreach_engn_cond(engn, runl, engn->func->cxid) {
+		bool faulted =3D atomic_xchg(&engn->rc_reset, 0);
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
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.h b/drivers/gp=
u/drm/nouveau/nvkm/engine/fifo/runl.h
index 19e6772..08ba44d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.h
@@ -28,6 +28,7 @@ struct nvkm_engn {
 	struct nvkm_engine *engine;
=20
 	int fault;
+	atomic_t rc_reset; /* engine reported a fault: reset it during RC */
=20
 	struct {
 		u32 desc;
--=20
2.53.0

