Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050281;
	b=etRmdI2MQrqmKW1D5CsmA2d4OpTZcA0TXYse2cNwhvm7b0UKVs2z1gxb3uHNU7Uhs3on
	 S5Pn/Aa8B3alQ3w3SNYShK89+9pVuN0mvxJTeXHjyW6Tzmf5CiRYm5Harncf8h8KtvagX
	 N6qgpyvrJYypRJamyM4Hx2S4rt/+DK0dk50/GEW8DEGPBC4MJDlG0YpYKpLGsw6K/NS4x
	 25PoZadcaBpLiVYCW2B1zj6lZVjXl/AKaMgP05m45a1InNW6LvdQkHDFNzngBZcZaCbhQ
	 YMq1KDgMiuqJHrYk8H+aYqdH+yQ7dR9PUKgpH+3i+omoVEi94XlICtz1ZgaihnIdbjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rBCObo5Tw+wITwwrNR6Z48UIMj03xVkfkAMd95CD8OQ=;
	b=ZIdrqUtd6NGXAiK5bvi4gRa1pd/2b2SeV72qTp9KsMF1boX6YUGsTcaSfnPLL4pjxYHb
	 +B2rYkvDvcfQWcqDD+SVD0ggTBEwuunifNXDG4nYeJl3ncuGHmm261hzLKVOs7lFslQTv
	 dfWKzR5LAWNa8tpgNIMVVW/iU5rwXW9aSb9ZtDQkZedrH5mJlPJWZBq0j+0ml22GHtoV/
	 GisDnaAhfb7rAm4YYFBuPz4jolxvEQlP3Bdj0yZjC+Bd5A3A94LYsOxVxlg6rXEI1w5Cv
	 WvblN9pcgnZ4IW0NKa3oH8hqdIfLr4mocW0wA6cwd6oYf6R+cuGG+RH2gN49FH55/ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lZ//kuaW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZ//kuaW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78561F0089F;
	Sat,  7 Nov 2026 11:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050281;
	bh=rBCObo5Tw+wITwwrNR6Z48UIMj03xVkfkAMd95CD8OQ=;
	h=From:To:Cc:Subject:Date;
	b=lZ//kuaWIcEMdSQBiYPzAJpyuXGRFjaUNGG9hkm85GkUJn+7+0h/hJXOsWQKW8jkQ
	 yt16vH1Qf/PQ+5+igtwQitQAi7oCAVemUkreYSk2cHl5MAgWf7L7AGZsFgaJ2IAjJ5
	 85b5j2eqJTihasyq2cidTj07ZbfcJqIi7C9A6OQstCeonlSPJURBeJAEi+CiyrVm71
	 2QT5wzbCYIe3DuLssadPDA9LPrAVve2CoUmAFB9dA4E08vw7qAzxDm7+kVvf0Aonom
	 Yd30BxMnGIKbwgUFwIqPq/20iwYsjaGmTOT6BtWQ7sBVlL2YKmwlgXgVvdH3QY9T31
	 F16rrAVrjcpBw==
From: Sasha Levin <sashal@kernel.org>
To: krzysztof.kozlowski@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:59 -0500
Message-ID: <20261107061759-failed-5.10-dd6ecace5785@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x dd6ecace57851878e62367a6f1a26dd5b9aa217f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061759-failed-5.10-dd6ecace5785@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dd6ecace57851878e62367a6f1a26dd5b9aa217f Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:35 +0200
Subject: [PATCH] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during
 .atomic_pre_enable()

Properly handle power up failures during .atomic_pre_enable() by
aborting the .atomic_pre_enable() to avoid accessing registers why
blocks did not bring up.  Otherwise this could lead to imprecise aborts
when accessing MMIO while entire power domain is off.

Cc: <stable@vger.kernel.org>
Fixes: ba3d7bf3a7ab ("drm/msm/hdmi: Convert PHY files according to new design")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/752652/
Link: https://lore.kernel.org/r/20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 30 ++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 157f19bd90b4e..db85400e574e4 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -13,14 +13,16 @@
 #include "msm_kms.h"
 #include "hdmi.h"
 
-static void msm_hdmi_power_on(struct drm_bridge *bridge)
+static int msm_hdmi_power_on(struct drm_bridge *bridge)
 {
 	struct drm_device *dev = bridge->dev;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	int ret;
 
-	pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	ret = pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	if (ret)
+		return ret;
 
 	if (hdmi->extp_clk) {
 		DBG("pixclock: %lu", hdmi->pixclock);
@@ -29,9 +31,14 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
 			DRM_DEV_ERROR(dev->dev, "failed to set extp clk rate: %d\n", ret);
 
 		ret = clk_prepare_enable(hdmi->extp_clk);
-		if (ret)
+		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to enable extp clk: %d\n", ret);
+			pm_runtime_put(&hdmi->pdev->dev);
+			return ret;
+		}
 	}
+
+	return 0;
 }
 
 static void power_off(struct drm_bridge *bridge)
@@ -287,13 +294,18 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 
 	msm_hdmi_set_timings(hdmi, &crtc_state->adjusted_mode);
 
-	mutex_lock(&hdmi->state_mutex);
-	if (!hdmi->power_on) {
-		msm_hdmi_phy_resource_enable(phy);
-		msm_hdmi_power_on(bridge);
-		hdmi->power_on = true;
+	scoped_guard(mutex, &hdmi->state_mutex) {
+		if (!hdmi->power_on) {
+			if (msm_hdmi_phy_resource_enable(phy))
+				return;
+
+			if (msm_hdmi_power_on(bridge)) {
+				msm_hdmi_phy_resource_disable(phy);
+				return;
+			}
+			hdmi->power_on = true;
+		}
 	}
-	mutex_unlock(&hdmi->state_mutex);
 
 	if (connector->display_info.is_hdmi)
 		msm_hdmi_audio_update(hdmi);
-- 
2.53.0




