Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B23F9A00;
	Mon, 27 Jul 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149469; cv=none; b=G2zWRhINDKKBQdaRaJMKBX5xg/KZOSH+MzIwaBWcJIG3zMdBKWKlsKvyDus3hQgwziKlEI7j3Uasd3+coH8k53sK8biymkVwaAlR2kBotbSbStJwpWJuTUjVVJ2neJ1nlqEFF7T5OlLPHHpa6E1FTY6hE/Ng1/ysS5WVAIvTv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149469; c=relaxed/simple;
	bh=FM5lEGvzd7f5f0+n9ZTFY3oBC7Mu0FqY3rkYLlV7Wz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckfW679WLbZDNV/alJ/YmMvvZK0x+Ix/XzJhfU1gTcFnsicV0cpLSp3F3s9YwRGuu03SQd8HwnCdbsBf+ciackumRqcB2/e20oOIWZsEwZ0W27g5TIOWov/qNli8VT9C4yKyX19Mydvd2TqOQZKp6usjmyy7+JPSc+m8oGTrvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=qsLVtlPI; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="qsLVtlPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785149460; x=1785754260; i=spasswolf@web.de;
	bh=NFE8/rQmk1fksjgdJAUun1cGCbd/fVTa/yHLjHmmP7o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qsLVtlPIODMzOQUyavdGYXGYz3j1olQnQTyqYlfYqiUR1NKypoJ9dtvZCdcOyRxb
	 F9Pn8T5HBvnhpJk77jItHcQaHRPqXtF8ZUcoYKfEDolJIsRch8rUrghq3GAi1BKa0
	 5sRvcjr6vhdmesZG5gBmhG4Ae8IbtXu2yl8sj8a9aL5pqs4CcIDOh+yUGhAX9cI93
	 KhbCRqZmIeJE8RwT2g2FsKu8BtNlSZnefHgBYiCqaVsdsJti6JDeqA9kEMFAcw9Ev
	 JFY1fdQ2+POFNw2r72t373Pdh+NvlnSHI/qZjnpDoEp9VnqT6P7m7bCLN3TaqT+Sl
	 Ifrddf8joeNq3ZEq4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxYbN-1xCPTp33n7-00wpkV; Mon, 27
 Jul 2026 12:51:00 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	"# = v7 . 1" <stable@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
Date: Mon, 27 Jul 2026 12:50:58 +0200
Message-ID: <20260727105059.75716-1-spasswolf@web.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DS7PR12MB5838D278341AE35E0383B951F8CC2@DS7PR12MB5838.namprd12.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wvebGZxhGIpYScwazUKf05BwUPDQktBQ5XO5B5X0qMSmUFOpxgm
 ZeQBwo266ZLjOHKsU65OaTRy641EYsONOlto1D6JYzWbqhtUl+O1ZKLaEdBxK5hT6kRItIy
 h5ki2DQy+ymEnMU10BwJbe/H8GiqYD7yJ6I+OvaW4X5oZ+oZHLP+XnwODZqhdOHuHqXg5zc
 KFi5dHntQ4RpuA1beqs+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kZ+Pb1tCRO4=;MqLljGrp0/IBvTLNbdoir1nZ5LT
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
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_stream.c
index dbc12640b01c..4ac835777b58 100644
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

