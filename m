Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049280;
	b=jyvlUhDZ8dZEn6CBzoGGOE50DYsghyZ3grMZyEzc3GiHSlimhhtECgdk71Lg6a0WR/GF
	 ipfAwePRGClV9c9N/0sfCN/CoHPYrNtgS70pat3sPX2M319+BSH80hskzLUSPnBDLdCe3
	 EgLMFSzBPTJCHqGVnReKm/HI0PBiysa5Buh30aD/BlLth4hsp78xsTahQUiksqOcFLttk
	 kud+767jlaF1b2bcWYvw0wXZ++7S26Hr11CdgI8HG7K5nUZ0goByhfvinxJEgNm508gOi
	 aOWXwo8bg7vyfKOPed6AN/4QYkP276/ZL4QTFFnVXJW02kImjLdhkeJb6pqzFbsdQXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049280;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MsH6PT/LXHntF97kvEZWI1QsklXcIN7rtsjEaiK6rpw=;
	b=DDFeBMPwKBs/8Aw56tqBMedVd8Jdz7I9ySzeuFes+4eHDbc7HykeXKnYA3zaeMVQpRWZ
	 fTV+CMof26MmA5kOKlw3U8RxcGrLEk3CbZ4158dswvM8VA/S482S/+0+Ld9euZYsSphec
	 kS/0k7WdhKBL80NiS9LYV+P4ejDAV5mtmpwUHP2ex/O5Z2mlYKUcLHMUlE8UrzibpPjJq
	 JWLCPZ9D6svPt8v9snr/SR3ylh13wm18K9YybSYqkasfqBMz9cgZ5hXlk3ErC5nZ2BHRh
	 3BcawIxV+RgPSwd7g34pU3do+BIDiYSMNkoZlOmH09mp2uNS9CTxe4KeR3fwuLd9IAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUl3ee1Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUl3ee1Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B411F008A1;
	Sat,  7 Nov 2026 11:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049279;
	bh=MsH6PT/LXHntF97kvEZWI1QsklXcIN7rtsjEaiK6rpw=;
	h=From:To:Cc:Subject:Date;
	b=JUl3ee1ZmYh9wdprCaRaTOR/7HRdj+86MBG3kUcf8PTUhnWcWf527d7eMrSPjtxMf
	 XrAG1aRSLfB6lodQPxMDIKnK3K7U1grzO7LZQMYyShFSfz42wwams9faefUWbeUhwl
	 XKqPJIT9Sc1e8pfeMJq9b5ZErDFeqs5SFriIhw628Jx4Nu/FFHaTHNUv7vI4RScYZn
	 UDAuAC8nIJKjv8RqfOAbtebHSvoz/qhRIkFU1TXsgK4G2F7ROcAJziIiGl5Zbe+htw
	 ZX8D63sB0lf+pVyYFTOD/taWE1YKMJ2SJkEWWjNTC8AEwIlgqNIlcSt90mLjGBHrma
	 CcJI4v2hPIKoQ==
From: Sasha Levin <sashal@kernel.org>
To: krzysztof.kozlowski@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:01:18 -0500
Message-ID: <20261107060117-failed-5.15-dd6ecace5785@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x dd6ecace57851878e62367a6f1a26dd5b9aa217f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060117-failed-5.15-dd6ecace5785@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




