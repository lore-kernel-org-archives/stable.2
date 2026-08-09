Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABD3290A5;
	Sun,  9 Aug 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786264089; cv=none; b=K8d/SNPkvVWBI+VwaToBn/OlvEYSdi2ZD6b+zsVvirTwjUIIHMNw5eRzryHZpTXY+AhOsFNHLZOo3g3p9hZLZPoDZehNWmBq+h4vJojLlXOUFKpbHbsCN709B3SL5bt/8OxAaQBtBmHcBgREg6GOlU99ZgQA8syd55CV4tknXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786264089; c=relaxed/simple;
	bh=5QRgRuns4zmF+gog8Y8zKAsY0zWas35xtUPB392I1/s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jxgKJsAkYT0WwNOlKgtis68Py04UvdOw8Xk6UyHo5SFAiK95okA5wOJ5YF+obj06ybR+GpNFMDFLU8Rhl7UTFHBQxUqzy/Iw+Utkgf6m9qcuWj4s+JmBseHE9j1YvhhQZ1znv6ohjlcSxl0siumHxHQqdWMA3s3/moFOZs2P2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EZJv+0tc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EZJv+0tc"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 441624311E;
	Sun, 09 Aug 2026 10:28:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TKNuF9xN9AOk; Sun,  9 Aug 2026 10:28:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1786264083; bh=5QRgRuns4zmF+gog8Y8zKAsY0zWas35xtUPB392I1/s=;
	h=From:Subject:Date:To:Cc;
	b=EZJv+0tcIsLwxPnEi0byDnAaiCG4kdaBfBnLTFiCTg7gAspwh3rDpAGOmOQdNsOde
	 dhts8OZp+vOJz5wYbcdQCSwvK7B3CDwdCqYLR4z1O3ZwGQy1dm3N/urHP9IVxHWJ3y
	 LIwbp3P0CRlkDVHcEu4iGohTvF1MBIcumKiKFpZ+xKfovbU0KDlKAFICQNc+hbf0cV
	 WTnqiC532HQBasDZNNIm3O0/ml/nC8RglSi2IzRY8uLcqdopcJXVFuEwcCHTN6AMrx
	 kgS+rYA71nQTTjvwh0WT3QML/p3mMjjMP3v8yY+3s/aeiCJ6Yq2prPAfDWEP+T5BKL
	 r54KD2COOTfEw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v4 0/3] Fixes and enhancements for Exynos (7870) DSIM
 bridge driver
Date: Sun, 09 Aug 2026 13:57:40 +0530
Message-Id: <20260809-exynos-dsim-fixes-v4-0-ca67c51e61b7@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBAF0KuYrq1pZ4ASV97DuKjtAF1ITUsaC
 OHuFjbESFz+P/lvZhYpOIrseppZoOSi830OxfnETKf7lrizOTMQUAkJBadx6n3kNroXb9xIkZd
 Yo6101QiFLO/egbZDnt0fOXcuDj5M24sk1/afliQXXAJYUSgNaOXNuhi8Hy4+tGz1EuwGiPrIg
 GzoulRUSxQa9K+Bu6EAjwzMhjAoNUn7JGO+jWVZPlndrW48AQAA
X-Change-ID: 20260124-exynos-dsim-fixes-5383d6a6f073
To: Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, stable@vger.kernel.org

Since v6.17, there is a regression for the Exynos 7870 DSIM driver. The
display occasionally had random aberration when the panel was turned on.
The first patch addresses that.

The second patch replaces an implicit loop for waiting for PLL
stabilization with an interrupt-based solution, which should be more
reliable. This solution was suggested by Inki Dae in a discussion of an
earlier patch series sent by me. For further details, refer to its
commit description.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v4:
- Clarify active-hight MFLUSH_VS in code comment (Luca Seresoli)
- Move aperture_remove_all_conflicting_devices() before
  component_bind_all() (Sashiko)
- Change `timeout` type to unsigned long (Inki Dae)
- Correct typo s/Calcutate/Calculate (Inki Dae)
- Correct inverted condition waiting for PLL stable completion
  (Inki Dae)
- Do not exclusively conclude IRQ routine for PLL_STABLE interrupt
  (Inki Dae)
- Explicitly enable PLL_STABLE and SW_RST_RELEASE interrupts during
  reset action (Inki Dae)
- Wait for SW_RST_RELEASE interrupt before setting up clock (Inki Dae)
- Fall back to bit testing for PLL stabilization when timed out
- Link to v3: https://patch.msgid.link/20260723-exynos-dsim-fixes-v3-0-0c31ae1dbecc@disroot.org

Changes in v3:
- Add patch for removing conflicting devices for DRM (Sam Day)
- Link to v2: https://lore.kernel.org/r/20260208-exynos-dsim-fixes-v2-0-a857e8130a2a@disroot.org

Changes in v2:
- drop now-not-required [v1 1/3] (Marek Szyprowski)
- Link to v1: https://lore.kernel.org/r/20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org

---
Kaustabh Chakraborty (3):
      drm/bridge: samsung-dsim: enable MFLUSH_VS for Exynos 7870 DSIM
      drm/bridge: samsung-dsim: use DSIM interrupt to wait for PLL stability
      drm/exynos: remove simplefb nodes before init

 drivers/gpu/drm/bridge/samsung-dsim.c   | 56 +++++++++++++++++++++++++--------
 drivers/gpu/drm/exynos/exynos_drm_drv.c |  6 ++++
 include/drm/bridge/samsung-dsim.h       |  1 +
 3 files changed, 50 insertions(+), 13 deletions(-)
---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260124-exynos-dsim-fixes-5383d6a6f073

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

