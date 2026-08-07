Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4B44236A;
	Fri,  7 Aug 2026 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107022; cv=none; b=nXwqZ6iLXGTUOu2yyO6jn82eH+nb1dPICTEGo67guOzqAXc8znwI34QFEH+kThLrz7cpHG5B8YB2YeYkuJHb5rLA3JyAzTIfebXl66/3Dc6bRDGCeBmrP4pdk4NM7J0e4phMUDHHIgbgSnUgDU2Ee0VUOYisKikLu1cmZ3buTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107022; c=relaxed/simple;
	bh=lod1ksPf8JSTVneHxLAPibzAL98BOvh658uG9GAhxzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdo6SaAe4qR9dNPpCU0d82142JOpYOWmq5TQN+Ofn4h6PilLuWdK6hNLgCDglU5hrLCy0slm4ZUJmrwRotlyw2DqExqGC5AI3ojy0m8I6/V2HJHKVE5OXP/7KNM1hUaQQkBCZWXUVRKSo3xvr9MtiNhLb2khBXuFwlGRSOqMGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=NRgpytKB; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="NRgpytKB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786106986; x=1786711786; i=spasswolf@web.de;
	bh=tSeA0vG7dP5ZK/4E4tWQ6mLYfngtEb5LkZEtSDs2cbY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NRgpytKBkVHiAiTp1UnVrOnjQNGalgR0wWSZfys8OLHqkwNL/TCd/KPq7aAnMcZq
	 Ac3zv4jyGYPOieLeDsl3wxteYm75o8RH8Gy91VKNquQz1rbTzOAc4tVuMsl6uc57i
	 txhc/YIwy3mqzeYSyNJfu6Ayo4w2FaLj2lcNKeT9OPJ9bTmrJjNJcC3YQPqppxheA
	 +n9K7dHrqLB+CY8Rs8PXyDHfHva+nvICQvvgRY5RUoifrEZpgt9eF7nJIjVwRaCC6
	 3siprdePj+51KrvO631Y230VRF6ugSiq2AXHic80hqmVxIY35pUDcUe0C1/F4VKFA
	 cfLI7052elpiWQqM6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDvDU-1wiS7B3otY-002xom; Fri, 07
 Aug 2026 14:49:46 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	"# = v7 . 1" <stable@vger.kernel.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v7.2-rc6] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
Date: Fri,  7 Aug 2026 14:49:42 +0200
Message-ID: <20260807124944.154232-1-spasswolf@web.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <202608061233.eufnR5Qm-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KznhYzgbAE/MPME5trz6GYPIpYBU/7UjpjKqFn69FwckmEAbvtE
 BeLFXIAxz9wb9ZaxkJJL/E0uPwMYVg8XCDnhjO0LWgO2bVM+ihGNNDLq+jwSaav69Xs0RPc
 nWFvGNH13gJCQbS5cFd1aAurxwu2MVe/P8RIiVP9vUrMaHiK0OzWeyiuCokrq6l713Lspnf
 fKBUk9wQWoKQcxFLaSuCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Et116pc3MOA=;o0aLRbVGX1aK9GNsF97nsRjPHzb
 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

On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
converted to rt_mutex. dc_create_plane_state() can be called while
inside an FPU-guarded region, resuling in "scheduling while atomic"
errors on PREEMPT_RT kernels.
 Fix this by calling kvzalloc_obj() with DC_RUN_WITH_PREEMPTION_ENABLED().
Also fix the error path in dc_create_stream_for_sink().

Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Pa=
rt 1")
Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/
Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c  | 5 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_stream.c
index 7666cdc78f4e..a5a304a3f802 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -233,8 +233,9 @@ struct dc_stream_state *dc_create_stream_for_sink(
=20
 fail:
 	if (stream) {
-		kfree(stream->update_scratch);
-		kfree(stream);
+		if (stream->update_scratch)
+			DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream->update_scratch));
+		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
 	}
=20
 	return NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_surface.c
index 72845fc788f3..04982673ffbc 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -33,6 +33,7 @@
 #include "dpp.h"
=20
 #include "dc_plane_priv.h"
+#include "dc_fpu.h"
=20
 /************************************************************************=
*******
  * Private functions
@@ -86,8 +87,8 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_stat=
e, const struct dc_plane
  ************************************************************************=
******/
 struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
 {
-	struct dc_plane_state *plane_state =3D kvzalloc_obj(*plane_state,
-							  GFP_ATOMIC);
+	struct dc_plane_state *plane_state;
+	DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D kvzalloc_obj(*plane_state=
, GFP_ATOMIC));
=20
 	if (NULL =3D=3D plane_state)
 		return NULL;
=2D-=20
2.55.0

Fix for stable with the old error handling in
dc_create_stream_for_sink() and compile fix form arm64/clang.

Bert Karwatzki
