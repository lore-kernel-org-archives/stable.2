Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B23AE19B
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788823; cv=none; b=deTrECKDGwd4MWiViscohInwIbB5zClAOsAa5zR1+zW15n4bfRQCU4nBaGKobcHJH3j9r1Xc2nUShgGJjzEs71mFyuFLjivTGoEpUAJdREDnpM98XAYUigB0JbS/cLHpn2YxWcPsjJgS7uo28CdZak1ul/QQ09gKoNtBiwwWvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788823; c=relaxed/simple;
	bh=kast/sD7zJ9xuoR0PWAL0U4Kj0fM+7CEeTwttQYSDnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfHGa/G+2pD+SjeOS36Q/kF/DyNJ9zXI2vWHTB8Nbb6noqNOUR6E89rHG0zUu/Y0VTVBEWe/yatl9aMBnuYHWeA8zQHFJRtd/MhPsQOrC1AfZYxVA801iXdcr64zJWjNcBoCEujNYTsGqt4q8tdodGOopCdhx9BbweOtYAmQYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+7vP4kD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+7vP4kD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BAC1F00A3D;
	Mon,  3 Aug 2026 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788821;
	bh=YJzP1ggEYzsZqAV9yAo9az+7zgd5UWhftt88Pi3FTt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g+7vP4kDIcVQX/NJj/Du1TgvikKTo+aTYvydwtnvAoy/fgnc43J0csXyd7kA4fLL4
	 CT8hN2lJn8tiA8hoa/YEx+/QFG2CFlCFTzQ9qUAWeBSTlaAhkB8x/t1d5JXFt8qUeI
	 4DUloPvglvBnwHtlU4QCbf2gxDfMIxBsFcCyVfNrkE84dYws1klJ6U7updzOG6Xnnz
	 Y4hEuBKIRXnIGQbOZSg0JlUcmjQRlaHKLwSN2LosF01607aPCOpUUKA8KeSesdJVVE
	 Mai8WADueLfqJTcQ7ulmdoaEIni33fXb07/hjAKp/lviVHFuZk9TU3A6f22+e7UhMu
	 y5kk2tYlB6W7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] drm/i915/hdcp: migrate away from kdev_to_i915() in bind/unbind
Date: Mon,  3 Aug 2026 16:26:56 -0400
Message-ID: <20260803202658.1647132-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803202658.1647132-1-sashal@kernel.org>
References: <2026072917-dugout-sufferer-eb18@gregkh>
 <20260803202658.1647132-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 3eac4684ecb5ea696bd283bd7f35e4829973f4f8 ]

Use to_intel_display() instead of kdev_to_i915() in the HDCP component
API hooks. Avoid further drive-by changes at this point, and just
convert the display pointer to i915, and leave the struct intel_display
conversion for later.

Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/0beedaa438e912828b48d9980f017807e079d7ab.1724942754.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Stable-dep-of: bbb15a6b042d ("drm/i915/hdcp: check streams[] bounds before overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index cb99839afcd03..0ba324ec60d32 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -2108,10 +2108,11 @@ static void intel_hdcp_check_work(struct work_struct *work)
 				   DRM_HDCP_CHECK_PERIOD_MS);
 }
 
-static int i915_hdcp_component_bind(struct device *i915_kdev,
+static int i915_hdcp_component_bind(struct device *drv_kdev,
 				    struct device *mei_kdev, void *data)
 {
-	struct drm_i915_private *i915 = kdev_to_i915(i915_kdev);
+	struct intel_display *display = to_intel_display(drv_kdev);
+	struct drm_i915_private *i915 = to_i915(display->drm);
 
 	drm_dbg(&i915->drm, "I915 HDCP comp bind\n");
 	mutex_lock(&i915->display.hdcp.hdcp_mutex);
@@ -2122,10 +2123,11 @@ static int i915_hdcp_component_bind(struct device *i915_kdev,
 	return 0;
 }
 
-static void i915_hdcp_component_unbind(struct device *i915_kdev,
+static void i915_hdcp_component_unbind(struct device *drv_kdev,
 				       struct device *mei_kdev, void *data)
 {
-	struct drm_i915_private *i915 = kdev_to_i915(i915_kdev);
+	struct intel_display *display = to_intel_display(drv_kdev);
+	struct drm_i915_private *i915 = to_i915(display->drm);
 
 	drm_dbg(&i915->drm, "I915 HDCP comp unbind\n");
 	mutex_lock(&i915->display.hdcp.hdcp_mutex);
-- 
2.53.0

