Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152564A0916
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107299; cv=none; b=nrxz2ORqaCToAkz5Ik2Mh/TFlSSF7b6g8Zs6CDk70/eVILtDRdkxMYnBrKAYGdiUYqUMb1Y0BLqx6ad9o1YMV3TKLs0U+Utfps7LWBbHEDTGLm7kMGxBVOpOEuqRJRUUGEskDZrr55RnUxsNMMOaY6Y0OTnGb/Awlav7t7edw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107299; c=relaxed/simple;
	bh=vk8LmAxyJ00+4IDE6RcqAurCzZl3P6rOxNHz4USYmeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUlMZRICb62HsGpSw2dj22G/MNVH49DS5x3XtY1tDRMxKosWb78do0foQjaRbLswUI97zGPEJvuGL3U6M0lBengQoFCr3XCo1cNp5wWDV8oAwtwMSErKNBWwrHRShvAzPMlTS8bBkhE2EmnMrcyWCCXfo+WD2hSozTXSqf09yY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=SE8754cT; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="SE8754cT"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664b7528so142154eec.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790107291; x=1790712091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7z70TQXn4poqOPaKrCAHTGIhbFu9qXKNqmozdXBkBPA=;
        b=SE8754cTS7jnjdvBdzNZ0gSsNw44ZQlh+cBp2dYK9hbXW/fafKPxkugRD7iVJv896G
         +UZtR+CgBLvdOG530+G+uIna3Yl5E2O8dPeDxK2RIpmioZyzszdUPG10Skbgh1wGPORD
         z9Gk1HZkJ6cNXruQfK/JAPtUSpK6QjHw6ldqk1qonCPemMGjz/Xt6A2uNMTr5g1u/8zz
         sEpwj1DeqkCAZ1alVBl9l+VGUAxriJi4agpQGJN22TslGl11+O6Cs7QYzf8HEQSzMpFH
         jyAqWpJ419DSgMt8rkOuDFtezAKJ6rioaMxbu/cnNNI/ocCszB9xaxVQ20GyeDDt+0FT
         Cs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107291; x=1790712091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7z70TQXn4poqOPaKrCAHTGIhbFu9qXKNqmozdXBkBPA=;
        b=ScWT8FzrkH14rPykCLAb1XUIR7paSVT8GkteBoATvZEvSD3k9NFmm8HtmSwn0qQapK
         9mf+BynxWVOyJplcGiFomNDf+tx1Z7d198t5nwl6p/Fa1bLKLmWaITosWxX7+6ARxzwK
         Q+2MQh2pWStegGJ+rDaMflGqQiS0JVGL+Ero2XEAq/SiWRu6xmoHAI0wQHzgtWjxu38p
         fCfDfiymkP49cr4/VWxHPzI6UXvjiHs7Oyf5KmiLo8UDPdJEaVftXc+VmN2KeoVHtC0F
         hyxd4KbTiWV/Vp0TC82x/xe4h8F1Nf/58EQr///safIaPMSgCOJcOA4OSQIxKzwyVgNT
         Y2Ug==
X-Gm-Message-State: AFuF++kIkKPeN7YS6KPX+XBEL4tk6egsLEu96AANeCfJ+1GlkS7gXX8G
	hbOLeKOXZ/cqpaVCR9VWCtLjkW2aWh+dEpjUVuyCjqUEZVF+uCYIrv/jMFb6lELDAmqQNLBnF3V
	pcgCdJzs=
X-Gm-Gg: AYBFou3iteKI+TyAobem3xo05i0uF1vpfseK/h+rdRDTRy1kxKETTH0tN8qPf5tFfWX
	FTZjT67YZnzTpl1lU+6k13rErGjBSic6dULGOfINk0/zII4c9jxecb1lwGrXEi7/6MkKAVPOfjX
	7ZH0HvGsHpIH+1lyTmvDwAr4UnPcJ/Y6T+ApV34S4N6vm6QW4PZHqETb5C00GIxMqS5AqqtjUFf
	19McBsn8RKd12HFtyEp+16GZwugcwsbGUEk17HPoUPHohiDcuOQdtKiNC00Gx/vcV1R7e113UzZ
	RwfQGjnitJEL/UykwiLvXnhHg88LPQSPfc3BOSlZCbkWuOPo/yf2VA3QWzgOtzlKWHvgmc5A5Tt
	5SelMYOlQdxl5l+Q1bk9t1XB0M29x1wksFYQE/5EMCqBa7Tfmbngv9kwk+asv8ppQgvz+jylS0L
	B5tSTRdsoNMITH73xW97m4fRLpzi98scCYL5pP3bDBZLHtD8pB9+9ogsusTRxQLt+Me49P75uWh
	Dv8ssUhMujXGkNtaIa79qOWyY7BZcz4p+GnvR5d0qr1bZ20+LPJiiev4RKlqdpLbl7RiJE=
X-Received: by 2002:a05:701b:4247:20b0:143:297c:82e1 with SMTP id a92af1059eb24-144f931bbf3mr446013c88.33.1790107291150;
        Tue, 22 Sep 2026 13:01:31 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:c016:77a6:d382:7611])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f982089fsm602138c88.5.2026.09.22.13.01.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 13:01:30 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Johan Hovold <johan+linaro@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH 6.1.y] drm/msm/dp: Drop aux devices together with DP controller
Date: Tue, 22 Sep 2026 16:01:26 -0400
Message-ID: <20260922200127.27433-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit a7bfb2ad2184a1fba78be35209b6019aa8cc8d4d ]

Using devres to depopulate the aux bus made sure that upon a probe
deferral the EDP panel device would be destroyed and recreated upon next
attempt.

But the struct device which the devres is tied to is the DPUs
(drm_dev->dev), which may be happen after the DP controller is torn
down.

Indications of this can be seen in the commonly seen EDID-hexdump full
of zeros in the log, or the occasional/rare KASAN fault where the
panel's attempt to read the EDID information causes a use after free on
DP resources.

It's tempting to move the devres to the DP controller's struct device,
but the resources used by the device(s) on the aux bus are explicitly
torn down in the error path. The KASAN-reported use-after-free also
remains, as the DP aux "module" explicitly frees its devres-allocated
memory in this code path.

As such, explicitly depopulate the aux bus in the error path, and in the
component unbind path, to avoid these issues.

Fixes: 2b57f726611e ("drm/msm/dp: fix aux-bus EP lifetime")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/542163/
Link: https://lore.kernel.org/r/20230612220106.1884039-1-quic_bjorande@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Backport to 6.1.y: the source change is unchanged; refresh context
  around the older DP bridge layout. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and MSM DRM maintainers,

I am continuing backporting CVEs still missing from 6.1.y.
This fix is inherited by v6.6 and every later mainline release, but 6.1.y
still has the affected code. The target-specific adjustment is described
in the bracketed note above.

Could you please queue it for 6.1.y?

Thanks,
Artem Dinaburg

CVE: CVE-2023-53851

Build: This patch was included in an x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and modules with no new warnings or errors.

AI assistance: An LLM helped find, adapt, and validate this
backport; I reviewed the patch and test output.

 drivers/gpu/drm/msm/dp/dp_display.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5beb727f8437f9..ddd0279bc8963a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -322,6 +322,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
 
 	kthread_stop(dp->ev_tsk);
 
+	of_dp_aux_depopulate_bus(dp->aux);
+
 	dp_power_client_deinit(dp->power);
 	dp_unregister_audio_driver(dev, dp->audio);
 	dp_aux_unregister(dp->aux);
@@ -1535,11 +1537,6 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
 	}
 }
 
-static void of_dp_aux_depopulate_bus_void(void *data)
-{
-	of_dp_aux_depopulate_bus(data);
-}
-
 static int dp_display_get_next_bridge(struct msm_dp *dp)
 {
 	int rc;
@@ -1568,12 +1565,6 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
 		of_node_put(aux_bus);
 		if (rc)
 			goto error;
-
-		rc = devm_add_action_or_reset(dp->drm_dev->dev,
-						of_dp_aux_depopulate_bus_void,
-						dp_priv->aux);
-		if (rc)
-			goto error;
 	} else if (dp->is_edp) {
 		DRM_ERROR("eDP aux_bus not found\n");
 		return -ENODEV;
@@ -1597,6 +1588,7 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
 
 error:
 	if (dp->is_edp) {
+		of_dp_aux_depopulate_bus(dp_priv->aux);
 		disable_irq(dp_priv->irq);
 		dp_display_host_phy_exit(dp_priv);
 		dp_display_host_deinit(dp_priv);
-- 
2.39.5

