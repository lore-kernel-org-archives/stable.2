Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047459;
	b=0y1bQ0SHH6eQrck+POnbn8t8p/Jw3+WwoJyEOIv3kDsJW3jd82bytj5YaUOTYBNSHkh7
	 Z5KsRbRFwJTxr9PtMg1b7zCtzbRMMaryKq2PJcaBS0e4/UXwZkzFXF0BMCoCGnpiYtDrY
	 sv8FV65GVGX0cu5rUjRJe3pXH4Say7czREi4HRoiseYehGcOJQkETwyJj/7jnDXOly1KM
	 RE8qabpfjYIhHqbfdFWkvDNT9OzccFqxgJdI9fF/C5/NWOGuTe0MPjC27hF5A0AUAjoaw
	 g22cupI6ED89cSkRENNvjWVSTkgjt/SF3Pzguf+/ON1w/TVwjBeHV6ES5rCCqJl5gog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047459;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eih51eZ62+NzHLFQBK/Y8prS71WW6isj18aECPenKBw=;
	b=D++3z2IUWKoK+DJ9cuHswpHZgtnuTWX/9Tz9wSmbzu+IkSwOFhiKvAv/VT6vLV4v4pCp
	 PJT0Q+C0iJw5ZEqAsduayM0fhWQG3XNADKmAS8Xp0Orwd1lVnoQ+UoFmrMuuBL5yBziBv
	 4rl69hUMvRCy3yw46XV4nzFKf54BquYnxqaL+AZYQwt82/DYZ1r24vCvzj9m/wa8o2z9u
	 ibzgyULsCmTSKyMMg5X6JzyVq37oxKJvHkLtUSITEwIt+BRxn8fxEBq5evMzzvjtqubEW
	 HV/5ay1xquu3hL/HKLldI4cw7OZP1Iu5leVRXNcKu/1SLbPjkLLaCZPrnslJisnAx4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5nyl3Gf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E72606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5nyl3Gf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09041F0089F;
	Sat,  7 Nov 2026 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047459;
	bh=eih51eZ62+NzHLFQBK/Y8prS71WW6isj18aECPenKBw=;
	h=From:To:Cc:Subject:Date;
	b=K5nyl3Gf6xa7qYYI6XdXhl/zukBGrtc7vkmRBR3vzu4LSzTxcGS7vr205Jf8QC0hf
	 dH4Y8itEF+uuAs+xnpwVx5k4V3/MzQGVgLlkcsInP0nd/rR16Ma5NRXObnL7paCBGf
	 b9dop9vNANmhmyd5ERB5PBsIhETgxYg5VCNZ70g7uRPTGdtzmVneMH8VCVyItbnD9z
	 xs9gVAK0sADl/czTqhcx81H/+ft87kV427quoTNrK98F1WC4Ugw7FH28gWjQF2LS1G
	 NzLqevlp4oE2+z4I6u6/JyQFK5Hg6Ak6MG/Nz3yMXnz/ZeoakzWCliGYHzK20hUfH8
	 ZvI46Kj1O7DzA==
From: Sasha Levin <sashal@kernel.org>
To: krzysztof.kozlowski@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:57 -0500
Message-ID: <20261107053057-failed-6.6-dd6ecace5785@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x dd6ecace57851878e62367a6f1a26dd5b9aa217f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053057-failed-6.6-dd6ecace5785@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




