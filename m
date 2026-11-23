Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429049;
	b=vLTLclVaWAuJ8O+NhNgp7oTZWv11UpC+8rCxkLOvVhJiHyJM0RWRdww38n+OCH2mjQof
	 HMkPYTlUuRhinxD+ItptMtQqMbpway54xg8tP3hEiLzQFP6k1KdZo/7SOiew9ZgP578sO
	 n2jWeLQ0S+fZVY+dpYq2UzySLmcX6Srz859nJyjY9W0hVhVFXYk55ognR76xSYFYYBYUg
	 u36h1wLoKAR4fqHkuIWJjsXpu6zimr3VzSK8BMihWuRWBvTfrxzB0nH3XvWWWSM/4gcTO
	 2Y96bhPtKfQjQi55yOKVtbx+j1IspF0PoOHqDks+YP7vgIaOF46sWjbWEJKiNoi0FVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429049;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xZtjDxWgaBdvhVoJSv/HBBvu1unqWARIW7iSyxAGJGI=;
	b=eoD8DHY1Yb18WHi75VfYT+hDUn6hJZMBUqPWZXJe3UVHLwD3pyTA4u8dk5PSBCpamiKP
	 mwTEhhHlFWrnepkaWazZahlES1U+9UomP3R4Xl0Q+lTIaClgMMVhrEXg1nHAPPb2+e2PI
	 6F6n0aDMAHMLaPjTlbeSV2+1852knwI7QhA97hBVKHcw5hznPaTkEeRXZCmE1xKOiHtsD
	 elgtWw40o9vdTDJePqccyjo/J8y84WKwxdnn4EswGq9YP+f/yuo8b4zV5mtfAa5Ygfqes
	 yk+6mL33/DV8nKeTJlE9ydAKDCwaxXJZd3Y6FddFgMXOjIW/jZdlKu7bbTHABJuYjAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=ltNriqoc;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69366606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69366606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=ltNriqoc
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 502F720DC66A;
	Mon, 23 Nov 2026 11:17:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id 2BA5520DB5CD;
	Mon, 23 Nov 2026 11:17:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 2BA5520DB5CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1795429046;
	bh=xZtjDxWgaBdvhVoJSv/HBBvu1unqWARIW7iSyxAGJGI=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=ltNriqociDIdSw8OBwTy69Ydwa3Z+ctzA6Z3JR0pdcbCIhUFmRLmW8QzbiRlu5PQc
	 PIwcdb4VMUGYxSaLEAcPdT6bglfb+pdQAzNRqFKOe7L6mPhuojfHzhBK58kHjZki3S
	 VthqfFL6B6zveL1xT0NEvl1r02bdav1jI4u5ZHgAz6lpwsTClwRH1pMc+F0PEENPb1
	 GnRjCGj7Eumv2JgPX0JfHwkpRAhJl3Kd3LK1C2erN9FWsXXze06S654c5Szl4gA+Fd
	 0x1YPghZqi5uwvOqeQOgo8XpL64zmGT3IExv09lfvbZ3GqJPJc5KQs+FZqK28dDRON
	 2xDSEkA1nYUUA==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id oIUaWpyusZaM; Mon, 23 Nov 2026 11:17:26 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id A75BE20DC66A;
	Mon, 23 Nov 2026 11:17:25 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau/disp/nv50-: don't divide by zero when the DP link is not trained
Date: Mon, 23 Nov 2026 11:16:58 +0100
Message-ID: <20261123101659.600247-2-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123101659.600247-1-frederic.mahe@cirad.fr>
References: <20261123101659.600247-1-frederic.mahe@cirad.fr>
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

Since link training moved out of the supervisor, ior->dp.nr is copied
from the lane count chosen by the DRM side, and it stays 0 when training
fails: no lane/rate combination fits the mode, or the sink does not
answer on AUX.  nouveau_dp_train()'s result is ignored by
nv50_sor_atomic_enable(), so the modeset goes on, and supervisor 2.2
divides by ior->dp.nr in nv50_disp_super_2_2_dp():

  Oops: divide error: 0000 [#1] SMP PTI
  Workqueue: nvkm-disp nv50_disp_super [nouveau]
  RIP: 0010:nv50_disp_super_2_2_dp+0xa4/0x340 [nouveau]
   nv50_disp_super_2_2+0xcc/0x140 [nouveau]
   nv50_disp_super+0x137/0x250 [nouveau]

Seen on a Quadro 600 (GF108) when Xorg set 3840x2160@60 (533 MHz) on a
DP 1.1 output, and when setting 1024x768 on a forced-on DP connector
whose monitor was asleep.

Skip the transfer unit and watermark setup with a warning when the link
has no lanes.  Before the change below, the training loop never left
ior->dp.nr at 0.

Written with help from Claude (Anthropic); reviewed and tested on hardwar=
e.

Fixes: 3147ce0d07aa ("drm/nouveau/disp: move link training out of supervi=
sor")
Cc: stable@vger.kernel.org
Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/disp/nv50.c
index 03a5f88..778559d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
@@ -1166,6 +1166,16 @@ nv50_disp_super_2_2_dp(struct nvkm_head *head, str=
uct nvkm_ior *ior)
 	u32 best_diff =3D 64 * symbol;
 	u64 h, v;
=20
+	/* Link training failed or was never done (e.g. mode too fast for the
+	 * link, or no sink answering): there is no link to configure, and
+	 * the calculations below would divide by zero.
+	 */
+	if (!ior->dp.nr || !ior->dp.bw) {
+		nvkm_warn(subdev, "head-%d: DP link not trained (nr %d bw %d)\n",
+			  head->id, ior->dp.nr, ior->dp.bw);
+		return;
+	}
+
 	/* symbols/hblank - algorithm taken from comments in tegra driver */
 	h =3D head->asy.hblanke + head->asy.htotal - head->asy.hblanks - 7;
 	h =3D h * linkKBps;
--=20
2.53.0

