Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558ED37C903;
	Wed, 22 Jul 2026 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746735; cv=none; b=HgqtJ9Kd/gs0AO9mJP2+nLRk+CwYDJV5YRTDIDGx9qAXK4UMEQiyCf1X3p79m+Bll5P+AeE2YS55UY7uh+CHf9DRGShLGaszDdTLRN1oaJzsIAd+jQJ/fDWc76ZsIaaByS2pn/9bKYzkhjzd22X9wvf7bCPdCw16ZHduXS/tZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746735; c=relaxed/simple;
	bh=UfNqCcOeyh0EPGI9MOJP83FkVghh8sF7H6l5q4tKtFw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KkwlfG/EOimetBremDfHFbCpA9plVN/29JkQ3hCq+8F9l+bXjikfM/BoG2lYEgGS3DcxUfm+eWWoq7Ipxm7hf+rMp9Ft961Ph7zDNCxBsiJbV1kj2AXxXTDQo+eUtfB00du4AYvfmj0z4J9iwgLwvEj/EGmbO68iDPHE4g+sCM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Sl5Qumeu; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Sl5Qumeu"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DFA968695D;
	Wed, 22 Jul 2026 20:58:49 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUKNuNWloxYK; Wed, 22 Jul 2026 20:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1784746728; bh=UfNqCcOeyh0EPGI9MOJP83FkVghh8sF7H6l5q4tKtFw=;
	h=From:Subject:Date:To:Cc;
	b=Sl5QumeunLrtHofgHBv/aoy+6EFb24yP8dg6quDUUgchsjYWKpeYaCungl1G6IBAq
	 GFlQf0MqXMbyf8Ffr/Y5aJK1ajQUTTQO3h+iYeUlCU0X2vi+WzVw2LUKHoHmC6OHda
	 z33fktrGK+kBICDDndSezEYgKSN1XDo735BqLpqPsGUCtOa521Fs5emCQpv9WCuMdO
	 LGFIsqssOdxQ7GkcqQCYhyLG9z78Xf7GBwgMResozBPmpC6YkpgITg1yqAKiT35i0n
	 a81oPqXmFjoowiqRPSM+/OaU83eEqwjrYYfUwhlmk1dIqa2P5RONUUi40iBC1zH11A
	 Zcq+/Eg27ytIA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v3 0/3] Fixes and enhancements for Exynos (7870) DSIM
 bridge driver
Date: Thu, 23 Jul 2026 00:28:31 +0530
Message-Id: <20260723-exynos-dsim-fixes-v3-0-0c31ae1dbecc@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQrCMBAF4KuUrI0kk/4EV95DXAQzbWdhI5kSW
 krubtqNCOLyveF9swnGSMjiUm0iYiKmMJVgTpV4jG4aUJIvWYCCVmmoJS7rFFh6pqfsaUGWjbH
 Gt67tVWdE2b0iHocyu91LHonnENfjRdJ7+09LWiqpAbyqOwfG66snjiHM5xAHsXsJPgYo+8uAY
 jjbdGi1UQ7ct5FzfgPd/eoP+AAAAA==
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

 drivers/gpu/drm/bridge/samsung-dsim.c   | 48 +++++++++++++++++++++++----------
 drivers/gpu/drm/exynos/exynos_drm_drv.c |  6 +++++
 include/drm/bridge/samsung-dsim.h       |  1 +
 3 files changed, 41 insertions(+), 14 deletions(-)
---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260124-exynos-dsim-fixes-5383d6a6f073

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

