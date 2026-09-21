Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A949B458
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996333; cv=none; b=sUO8H9fdiEbyDFDO8gIXZD28NL1kHCCAoTuS4PPYAhGdbIycLCWMh9pLpcC94K0jBN+IH9a01yIJcocPv7Uz+OvGtTkACVtPKAdR5ySgaSDPSMLP2ft7mhjwjEgrOS42OuOs4gcjIxP5temqTa6ik209jRLFcgYk/yhxXehA4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996333; c=relaxed/simple;
	bh=AFgNBwvwdGEA1hIWTb2ReJBXMJQxyeIVF0mRhsIn2yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvqAJQ0/3MbjOtLEAFLxsk5qO38K4bKBTtPdyembJziuT3Qcfs+NggkCD3ddf0z1B3QwVRF0BlWXNYkT99h4EXbe+KUIC2LVbxRGKW2D3yXKW4b7CL4fWHKXosPqrKuzH+uuEGfPpRFo8j+nGD/XdrAfbYptj9QLBwXz2aDBBQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3Mho3pT; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3Mho3pT"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so2055728a12.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789996331; x=1790601131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ig7/HqBzfoSVv6fdudTalNiMgAfFIlYLiYgMPPiaeeI=;
        b=f3Mho3pTrZgkXECxtmiPpJmQJQZ1bToxGgxcFY1lG45JZyl+XBKPJOiT6yASo1CCEQ
         OQwuYXSRQgNXuArHoJbwrrKgCCncbpkquTlFsrnSAgUlyS1zHnbBeXe8UA2z1RzIZhA0
         qZksvCQmjzNMTax8hQsMoU4Vp9V86Xqa2TibwD2BTMOG7i3nvvXSTUTPou5qxn6QXrre
         P+5dJnddPYWERfs/0jyKicUqrBCY9ev2dwMNV8Dl3T9E5vMt8Sg5u0bJFv/HKqSz0cIf
         rU6eJgk9ek6DGw20UGY/WP6ua6nFXypT04OvTaJ7Dih3Rz3mPZ2wM1pE+GeZ7Ua145hP
         Yrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789996331; x=1790601131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ig7/HqBzfoSVv6fdudTalNiMgAfFIlYLiYgMPPiaeeI=;
        b=KmRNdU+GF4zBLAJK2nY7Qf88IBAR1HYJQYxay2yJ+o8NHYHrfp4g8b21uRCIPD3UT5
         4/l76Kg9gLH8qdl9zw/gamVnvOYTRhPtJcvh/z/L7E9a7h13GzwNpNhJntZYPAT9N2ri
         P3yUmavrL9TlPRIV+iC6HzdjIbRyEoScNCkO+ad57fV7cnZS5XontBgeLiWYRl33dAXN
         S8cPk4dddKHxE2k9847NxFBoP42Uft24YC80tZJWNVZVgsAo9JQunXlSmYaCVuxaNcpN
         B4XG8qFj83yduLMXVQ+p+Db8EJZCkKIRlK/1ztiF6MyQFccI2PFqBe+L3qSUBIPVUBkp
         lqvw==
X-Forwarded-Encrypted: i=1; AKwUvBz0sOXub16wz6GEuzXu9ZW1Men/XXA/+CJWVtMPqBhWfDkb/oRsS/VFAlNuZcwmF2VVcJ8ZvLA=@vger.kernel.org
X-Gm-Message-State: AFuF++lWDCHP3FgugTdZKbeFpTk2SCZfWAqEbM3Yu2iKOHrmM/yXf8L4
	x42ln5g7/OvK2VsgKka7bpMGGjjhuj5wnsViyWgIiPbjM36iP6W0iMxY
X-Gm-Gg: AYBFou3BxF5Au68OJXu0WwgdmnK+tpjsCh9Ou7qp9jVbyNxoPlMGFbTDkB0sUJXhvwo
	sPMaj753LkwuO8JdwYI8Rw7aGK267xUN4OWicFlH6KknlD/PpNbm6qZSmJW+Kr5GA1GD5zzUjgw
	tYZlb5MmYShxGlRhQBgWNOfjWugqGnoENNYt2EEFCFib5eOP7FBxPt8KIcDS586KZnY438PfN69
	5Gy+Qh7w6n7zYcpoBuXASDlPq6xi4ruJv6Arv72rULlSMpDWMj2l4HZlTo4BKMfbYurPVFxGflN
	cysglU75yppfOxc0YFFrRoJF+G/H03sIV+mQxdFWtX0GFYXMHCemT1QMdvTj18dCnhgp14SaxLW
	j/YKtSQpqrLI0lWc/RUooPyNGZ755mFHkBE3EAbvHV3R93RSaylcAMZxEpR5Mm4phQZHgnPYMPz
	PRKdeQGqxVy0FzZgSG3AGwxvk+ifjaWBZ4Adg7nrAil8moa/kBV4wyzQA8OOy7KjGm
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:4b64 with SMTP id 98e67ed59e1d1-39e6c6a5438mr8799720a91.46.1789996330968;
        Mon, 21 Sep 2026 06:12:10 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a063bcecc6sm80447a91.12.2026.09.21.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:12:07 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Nancy.Lin" <nancy.lin@mediatek.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: fix ovl adaptor platform device leak
Date: Mon, 21 Sep 2026 21:11:56 +0800
Message-ID: <20260921131156.403652-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_drm_probe() creates an OVL adaptor platform device with
platform_device_register_data() when the display pipeline requires the
OVL adaptor.

If a later initialization step fails, the probe error path releases
the DRM resources without unregistering the already registered OVL
adaptor device. The normal remove path likewise leaves the device
registered after the DRM driver is unbound.

Keep track of whether the OVL adaptor was successfully registered and
unregister it on probe failure. Also recover the platform device from
the stored DDP component device and unregister it during normal
removal.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT8195")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index c86a3f54f35b..d176e6496aa7 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -1060,7 +1060,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	struct mtk_mmsys_driver_data *mtk_drm_data;
 	struct device_node *node;
 	struct component_match *match = NULL;
-	struct platform_device *ovl_adaptor;
+	struct platform_device *ovl_adaptor = NULL;
 	int ret;
 	int i;
 
@@ -1205,6 +1205,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
 err_pm:
 	pm_runtime_disable(dev);
 err_node:
+	if (ovl_adaptor)
+		platform_device_unregister(ovl_adaptor);
 	of_node_put(private->mutex_node);
 	for (i = 0; i < DDP_COMPONENT_DRM_ID_MAX; i++)
 		of_node_put(private->comp_node[i]);
@@ -1214,9 +1216,15 @@ static int mtk_drm_probe(struct platform_device *pdev)
 static void mtk_drm_remove(struct platform_device *pdev)
 {
 	struct mtk_drm_private *private = platform_get_drvdata(pdev);
+	struct device *ovl_adaptor_dev;
 	int i;
 
+	ovl_adaptor_dev =
+		private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev;
+
 	component_master_del(&pdev->dev, &mtk_drm_ops);
+	if (ovl_adaptor_dev)
+		platform_device_unregister(to_platform_device(ovl_adaptor_dev));
 	pm_runtime_disable(&pdev->dev);
 	of_node_put(private->mutex_node);
 	for (i = 0; i < DDP_COMPONENT_DRM_ID_MAX; i++)
-- 
2.43.0

