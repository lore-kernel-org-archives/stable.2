Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045764;
	b=dC9NP8U4Jb9tRdaPkmTRjpjJwkjQnBG6N3hBGh0Y8HEKHeHEr4rf2UdBvEGCOEPZIeEl
	 lYVyHldqju2fnwfI+7VoL0mnxvh9dIX9eO4x5AAn7+5zpsITAMOz3roE1pIh5LNgkqmf/
	 zSAPxegXpwhbC7WGln9S9btX6//sX/N9S36sXm700+vT0WWRuLNZNXeDRp3V/5TJ2CuEp
	 fzs3kDrIHsNDKvWonga9BEdZMSipyBovKLrarUo9SfT+engpTc5/70pQ2sg0kEYWcV//G
	 Ap4K3Nr1M+wwRXhLqPdGLPYHKQAP4hRXaafSX55chHWcVikzACLz43ISsX0B5qIY3Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045764;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gJfxSocntk6k1MG1wADdRHM9zGl191SUWey4qofYt+0=;
	b=Te6bgw2Grl0x5T/eCMhQ/rNh6Ie1Hh8AkhXzQlZi6RdDPJeZfFOAO2y33GeJP1V4cHDy
	 0FIR8VL1QRv318rjh9qOeuvzxWgj+7BOnQVwcDQGDeGLLxJfo6vfxITxiZNjhbFnt6YKM
	 aP4cPPwJM3JVXrb06n7qjrlqzgTTeqzsmWdT1P0Lv9HfL++9hLWSYPiAFJbnOxOtRurA/
	 SBuyS/SgmswXW6uoqX0JlOyogO+HoB9VrZnHmVJ3o++eaTnWIHTnoFzqpjREvK0Xv7ecn
	 zQlK7ItzoMDIGLdkpe2PP4j/7YEjMcIFqKk+0om5XrW3d4oPP9MYWr5KDuB/apV+Nyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H3ykh/B3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D09606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3ykh/B3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B766C1F0089F;
	Sat,  7 Nov 2026 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045764;
	bh=gJfxSocntk6k1MG1wADdRHM9zGl191SUWey4qofYt+0=;
	h=From:To:Cc:Subject:Date;
	b=H3ykh/B3pmLAXYp4Gimf8c3RHBs5uQbXss9705ivmUjgn0j0vooFQa5vhas/jI99E
	 J07OHJ8hSISPXbCAsng6CZi6UubrPFMCksifsJkKVzO6ongiqYM14d+G9kJArL80tW
	 NRJB2GkrABcWVnf59Ya5ZtCybwdND3acxfehoYmqhEV90F/qI8bpdzhBWcZjl4Sg0+
	 wiQtsvUefyutslEsTKNpEsPtQVfJvjVJZj4iqYqFc/IdJg1wBOtecTyqGBoMir6SsC
	 Ueue7LvO1RIzRnnzABgczi92N/ExmRg0MgfrKUrgKptzVxpDD0d/+ixNyJOhnvb/kE
	 apUh95UG8UHQA==
From: Sasha Levin <sashal@kernel.org>
To: lyude@redhat.com,
	airlied@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/nouveau/gsp/r570: Enable S/R Display workaround in GSP" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:42 -0500
Message-ID: <20261107050242-failed-7.3-ca57629b3eb9@kernel.org>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x ca57629b3eb912c77bc4357178a2130ea6c2d6df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050242-failed-7.3-ca57629b3eb9@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ca57629b3eb912c77bc4357178a2130ea6c2d6df Mon Sep 17 00:00:00 2001
From: Lyude Paul <lyude@redhat.com>
Date: Fri, 14 Aug 2026 15:43:50 -0400
Subject: [PATCH] drm/nouveau/gsp/r570: Enable S/R Display workaround in GSP

There's two flags that we've never been setting when asking GSP to suspend
the GPU, which OpenRM does set:

  GPU_STATE_FLAGS_PRESERVING
  GPU_STATE_FLAGS_PM_TRANSITION

These flags aren't -supposed- to do much in GSP, they're mostly used by
OpenRM itself for state tracking. The only thing they do from GSP's side is
control whether or not a single display related workaround is applied
during suspend.

But as it turns out, that single workaround is actually quite crucial for
getting runtime PM working with nouveau - and without it set we end up
seeing a lot more failures with runtime PM resume. So, let's start setting
it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
Cc: <stable@vger.kernel.org> # v6.16+
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: https://patch.msgid.link/20260814194542.781955-4-lyude@redhat.com
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c     | 3 ++-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h    | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
index 996941c668ba9..3e391646d8f7d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
@@ -198,7 +198,8 @@ r570_gsp_set_rmargs(struct nvkm_gsp *gsp, bool resume)
 		args->srInitArguments.bInPMTransition = 0;
 	} else {
 		args->srInitArguments.oldLevel = NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3;
-		args->srInitArguments.flags = 0;
+		args->srInitArguments.flags =
+			GPU_STATE_FLAGS_PRESERVING | GPU_STATE_FLAGS_PM_TRANSITION;
 		args->srInitArguments.bInPMTransition = 1;
 	}
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
index b6075021e74f5..c458569af9d72 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
@@ -523,6 +523,14 @@ typedef struct
 
 #define NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3            (0x00000003U)
 
+#define GPU_STATE_FLAGS_PRESERVING         BIT(0)  // GPU state is preserved
+#define GPU_STATE_FLAGS_VGA_TRANSITION     BIT(1)   // To be used with GPU_STATE_FLAGS_PRESERVING.
+#define GPU_STATE_FLAGS_PM_TRANSITION      BIT(2)   // To be used with GPU_STATE_FLAGS_PRESERVING.
+#define GPU_STATE_FLAGS_PM_SUSPEND         BIT(3)
+#define GPU_STATE_FLAGS_PM_HIBERNATE       BIT(4)
+#define GPU_STATE_FLAGS_GC6_TRANSITION     BIT(5)  // To be used with GPU_STATE_FLAGS_PRESERVING.
+#define GPU_STATE_FLAGS_FAST_UNLOAD        BIT(6)  // Used during windows restart, skips stateDestroy steps
+
 typedef struct
 {
     // Magic for verification by secure ucode
-- 
2.53.0




