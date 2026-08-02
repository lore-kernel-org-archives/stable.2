Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6899258EDA
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785641129; cv=none; b=ASv/5QzRTtU5BZEBTi30FD7VyLm3Ydp9SLHQGysifKMlvYlgaFYMNwzm/ToqLeqntRCDB6FBzGiNzVu7IjBSRPLwklSxGHlKT8DPS4MoSVevUH0MW1JH+b5G3F1vqSZZAznjsuf/JgiayXuCbVG0JA/e8vu7rQ90iD62nsiTD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785641129; c=relaxed/simple;
	bh=DRds0Il/FOp+usSRhIUzn/iK1LGwkLmdv1TtMIzWAjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvpTbudk0oA7jE3yMf04kvt5pTl9WeXIjHluLNxqoN+f5ZZ7528MmkjA6+Qhchrfz8Vk7dbc0VVXAcaGk8GEBBcw0Tqiq2ugF7aKf6pjKjI9f+gmFr/PtzObbUal45CPxc8HREoareOv8R0kQW9dJpgeV8yckun+GmJ50uEcpwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLZr+Jfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLZr+Jfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589271F00ACF;
	Sun,  2 Aug 2026 03:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785641125;
	bh=rq6Exp+C7o39DytS7pSQsC7/3yOVBHk0DY4VKh+FLwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GLZr+Jfwy0ixlVnPFAs/Plr1rav+DHhYw2bBWGHgTzcUtXRhCmCxTlEK+cBEOOLJl
	 dWsmRaabeerMv77JHzMUixqud1+z/UTPUTjUCg0/SqjAwODjZ1S7CgCjdypewslms8
	 2G0ztr2VTef6YznVhqi9pqtuyT2/lSQQNcuWSPAi8WPZ8yFDGubXsFcpeAArDko5UX
	 WyA3XXRovdFRYIRj6o2/pGaerIv3fV5We1YckGJzYo43VY7Ya6m/+33oLMGfR0KpqX
	 x4p5EbK0xh4HeSVKyZ6qxjiU3ojsohGkyfT8mnetG0hjy5YxzIJ2ZagGeFPfPRT01b
	 NBWYl8FWHMtbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] drm/i915/hdcp: migrate away from kdev_to_i915() in bind/unbind
Date: Sat,  1 Aug 2026 23:25:20 -0400
Message-ID: <20260802032522.2607746-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802032522.2607746-1-sashal@kernel.org>
References: <2026072904-impaired-parking-52fc@gregkh>
 <20260802032522.2607746-1-sashal@kernel.org>
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
Stable-dep-of: db9e64c983dc ("drm/i915/hdcp: require monotonically increasing seq_num_v")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index cb99839afcd0..0ba324ec60d3 100644
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

