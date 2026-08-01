Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BC27280A;
	Sat,  1 Aug 2026 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785568671; cv=none; b=PmD4KhHpbMUSzDBVauuZgEYN9oFWH/1uSANcmZDJYX5dQY9+VFKZsOuJYC1NFxgj3lk+jDIOCZKntK+dvWt3v0Otj+lmieyN1557pIvt4+fKJGlrNaWRMGt/ANhUK751OHw+pRD7bmCZzhj9kV9+8sR6b9J8caFy/zdczZGIun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785568671; c=relaxed/simple;
	bh=dnlaYSZS9KyqhJPxN2yiErqrNrjLbuahAcjAVN3mH/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stbOByEXkjHF2mCe3pMQS/JfSyc3TsYXXU6lITqN1VSSiA9B/NAnzkv1XdVZEoQLDWCm42vMbW+Foq9E4RI8Sa06SfKsvSx9fLYu2szw5aPOcEOSJba4PUFlVsjNBA0J6UiyU7kV/6OIhzrUGKrBc3BkEa1cus/ynvEqVrOMMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=mb0l7tDa; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="mb0l7tDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785568645; x=1786173445; i=spasswolf@web.de;
	bh=mDESK30vhMZ1vtLk7G/1vm3QQOvJ9Wm1zUcVRIeD1Q0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mb0l7tDanHCHInBw2rivfDx6zeRLDXhSiibI9e5tEQPImF8qodPnfkHCB/NwguhM
	 SsmWJdnDVlKZbRXG343bCeuRhys1aChUB/8puKue0tbcNBSfvAFfE3jboSVzxhNlz
	 FkW7nAsuDiGBYO8YuCmyC5t9fmWEXwc4l5mM+rNoLztuIqMqrGNAY3xD9IoauG65A
	 Hjv7ZjZFv/++k/sy1+9WP4z8owIeL5F43lo4Vx1wjfIfpjIgCfuI6HDmRZhSHjAPu
	 EICqpeLUvvXeOSCS99Li7i0SO+MGmyjs/PmHSklvHw7rqvLZh58UFGHOjCAL7Yg4F
	 LJS2lhZrFcGWO/K3Qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lnF-1x1HJO2iUN-00tjDA; Sat, 01
 Aug 2026 09:17:25 +0200
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
Subject: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
Date: Sat,  1 Aug 2026 09:17:23 +0200
Message-ID: <20260801071724.12998-1-spasswolf@web.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <df5f0d9bb8f11d098f086bd2ace5aa0cef4c77d7.camel@web.de>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ditpzoXzGB5zYgnpShJq2bwKn3Qgi8DeDTbXOrOKUwzcOFcpqlT
 TDKv6KagqjCtxAO+WNy7Bp63ZWYj7thUhZioeuG9iedDV9uxWiXcYxfvjY0YdiYJckGjJgg
 KGs4rS6lWxYkcS5CMh/q5DIHIzvnfXbm7+sHdzOHWEx4SCFOGaQf4zKOHNlP8neEMuiXtfH
 FMlzHS+Z8DetCxSXJHVjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D0cSLtkLGcc=;MrLD1GAdr9jDr8IMQ25v35Dzlum
 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
 QMIzOwk+cDtmdTBzifUFgtvgfdrtBEvhEFD0s=

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
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_stream.c
index cdcf140bc1bb..accad9e20e88 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -229,7 +229,7 @@ struct dc_stream_state *dc_create_stream_for_sink(
=20
 fail:
 	if (stream)
-		kfree(stream);
+		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
=20
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_surface.c
index 88e825a6582c..d5c6427796b6 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -85,8 +85,8 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_stat=
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
2.53.0


Rebased to next-20260729+. In these version the allocation of
update_scratch has been removed from dc_create_stream_for_sink().

Bert Karwatzki
