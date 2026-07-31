Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010B348C4C
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517022; cv=none; b=NUJ7oMo1pQTc/1BgewFSfi8K/dmzpsN9Ejie63HEcoEULfAwcZDsqp+JBSVaGAb7p/Jsp5Iu3FCC0FLAFRq9zf9PY2jHiiaxu869KyfMzHxgMiNU2muQtfb8Nk6CZA19oXebk3PDaiXE1f7vgvSfAsMRr809+qXa+QG4xoJhwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517022; c=relaxed/simple;
	bh=LpsHwPAUrp2Kx7DvMyIs6CPwBtqxShsik4suZWMIGLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lp4zwirE3U/BEeanVMX5EP7mzMbsHiT/sKl709UxB/1bHQPY7d5mih6M5ztxzcOn7C3wHjplQUrNzeUpCnyO3Z4zaG/t1Rf0jZfPEkqBMYyKIobwawuD52JW64RPKqa2kIf7eCHIIsHheTwfackXLAnuiCC11zxnw3e5sQy033E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj1p4u5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj1p4u5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237021F00AC4;
	Fri, 31 Jul 2026 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517020;
	bh=R+/GkXjqWDtNCueSdE3YOHkvQyqVYNj+rbPxOxUk2hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mj1p4u5I3lbp1mVg6lsI111lafMkZDXQQZWGd0y7km364RtKSueDqSo3OMTDSyn4C
	 WaR9c3EGdkUe5O7JoYovEoBLemYfEDgdwOQJnnO/Vr5r+hRS3Q6tPWuPh2GacVF6aQ
	 CytryhcwN50JRpKQmL7VUanh7q1wDlYqT/w4QLC6QEwsFizq2CRXBZM6D3YVvcr56J
	 x+blSTtZwsUz+AH1XWX/39tAC39HXSeW6Z6oEIoTHkt5fzZ1umoqsDaG1YrZn/Lc6Q
	 nxBrFYnURbO8HnhxLxOd3vTRF7XOEoCcJtMgOXIJinDonW/IudMZbgo7fKMEGraUPy
	 HKEISYYC2s/QQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/5] drm/xe: Drop unused param from xe_device_create()
Date: Fri, 31 Jul 2026 12:56:54 -0400
Message-ID: <20260731165658.883265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072950-giggling-gooey-3782@gregkh>
References: <2026072950-giggling-gooey-3782@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 8a09097b11ca4d436691f64c3cc0958006f36e33 ]

We never used or need anything from the struct pci_device_id there.
And while around, add simple kernel-doc for this function.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patch.msgid.link/20260526195452.20545-3-michal.wajdeczko@intel.com
Stable-dep-of: ba7fd1634228 ("drm/xe: Set TTM device beneficial_order to 9 (2M)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.c | 11 +++++++++--
 drivers/gpu/drm/xe/xe_device.h |  3 +--
 drivers/gpu/drm/xe/xe_pci.c    |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index ffea4a453c01..688516d0b651 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -435,8 +435,15 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
 	ttm_device_fini(&xe->ttm);
 }
 
-struct xe_device *xe_device_create(struct pci_dev *pdev,
-				   const struct pci_device_id *ent)
+/**
+ * xe_device_create() - Create a new &xe_device instance
+ * @pdev: the parent &pci_dev
+ *
+ * Allocate and initialize a device managed Xe device structure.
+ *
+ * Return: pointer to new &xe_device on success, or ERR_PTR on failure.
+ */
+struct xe_device *xe_device_create(struct pci_dev *pdev)
 {
 	struct xe_device *xe;
 	int err;
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index e4b9de8d8e95..e363b4a8ff13 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -43,8 +43,7 @@ static inline struct xe_device *ttm_to_xe_device(struct ttm_device *ttm)
 	return container_of(ttm, struct xe_device, ttm);
 }
 
-struct xe_device *xe_device_create(struct pci_dev *pdev,
-				   const struct pci_device_id *ent);
+struct xe_device *xe_device_create(struct pci_dev *pdev);
 int xe_device_probe_early(struct xe_device *xe);
 int xe_device_probe(struct xe_device *xe);
 void xe_device_remove(struct xe_device *xe);
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index c2ecd27ec770..b1ca4e711db0 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1085,7 +1085,7 @@ static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		return err;
 
-	xe = xe_device_create(pdev, ent);
+	xe = xe_device_create(pdev);
 	if (IS_ERR(xe))
 		return PTR_ERR(xe);
 
-- 
2.53.0

