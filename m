Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F554B53E5
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473021; cv=none; b=BTv9tfliLa15CqIAys2RfLMQgNIJtJAQjX1+sZrMUfXsOyYQr8uLpY6y65z/lN+MntHwS8i7zX4lGdEPjuKs31/EGaQIsuxn6910yFMjWTOxk/AyuznaK7QGGReNiNEIlcPS7xc6LVrtSYfOv34CNA69OeFdnJE5wgEQdWmR65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473021; c=relaxed/simple;
	bh=HrpS0+5vBPnHQrYihC1+KHpGhL5ZrFqgwBQSMxw0ThM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juj/oSh1KSCNRee2gDB63FGasm3Qrn3FLIBIJmM/FfpiqKKxGp6XamZCtDE7ncrvQRzBDzSRUV3Euv/8ZjlKGlQDM8oNlpHiEfYUsPmsu2hs48b8eaISUSDAWc9LEiDFs2LG9IKrOfsuy8MU6OC/H4V2E7RytCpU7/+Al1oRmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMFMXB5L; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMFMXB5L"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso3112961a91.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789473019; x=1790077819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pzARCoC9K2+xHcKxtS92tzMDdovjtNP+xvj5FczbmUY=;
        b=eMFMXB5L+DTy2a3IjmIHvY9ZjftWpnyF0Q5dC0hmrUN2T6KEbjP6fVGOHbzh9TXxC3
         jse2cRB/Y03QYBOqmllHPGF7FuxGuVui6Qr2i5gFw1xfv3bbsTDiQuyRDd8XSakGLMqP
         0HwVAPGtn5xqpAe6uiAFxIQQpkBdA91fkh6kalWvb/F5Ua5yAiBW8Dj9KhxNKy6jYcv+
         HWXx6JHVslkJMAqvzHBidoHzyVXTjokAkC/XqLzlpqFUiIv/owi1CvB2VQLKNHiH60yl
         N2O2eekbH9uG2AJ5+R7ayO39s9JJ8a4OD0sZSf/ntr47e25HVrg0v1lk4B+dODVVLane
         33DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789473019; x=1790077819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzARCoC9K2+xHcKxtS92tzMDdovjtNP+xvj5FczbmUY=;
        b=0h0xTZ0ZCiWLwFGFpjUG3i5mHwzpD5Ulk2q85F1Ip2UGU1qpxSK92lY/WMg6A5GrOE
         yOGjNsbRxonoSu/DH8XRXQ9LyoSonlZH8Vmvvzp7KY9V+YJ/vvMhaS9pCTVw3am4YT8k
         SQB5T1O1bTltdElHFXDxxJol+XKfA0IBD0B8DDf0hmhGKh9vjC0ohQ0N3T4le4coGzF7
         6GzcJbMWy1Cb8sWDPnIrKrkhUj0EsLoDNbpPfAwwlvMjkw0lZjkrMy1NotrjtImJXrvn
         qc6exvt1hvgpGuO8z0S1ODqHsPm9KbEL1eXCRxzeK+t/POivHB7a1b5pn9+vbVQSP4tZ
         33XQ==
X-Gm-Message-State: AFuF++mrblPfcAwi41UddMzBczLpefBR4W7AoC+DsBYeMTlQW9TLJazi
	n7nUuaKayenOwq92q1RnhFMcG1/olSpGIn8wGrIgTkvOgKhlLAjVmKw3
X-Gm-Gg: AYBFou1hjUWIq4sW7WI4oS/TaxA8KHfk72yt4hZhRWjncVp4WERZWr6jqYa3o/kqYCl
	xG9Rk47JwdG6jEWAmb63djcpNcg2IIlANWextQDfCrJKYZGRUsvGpat3PpEOuZmfIoMY9do29df
	S2wgNzZgZ2gjGvlnDqLf0DpU0D2F4Fu5HUB1zDt9x1EkjOKbAKURrgjF62vLU3ivZijTSXr4F82
	uH6pFy2cEimO4nnGjdjUtLxQjxS6dCYM9U+7PC1l1W2NVNuBYsdSbC+tn5Gvaa5gvMrGtaHCoGK
	HOTC5OPg2QccQ2Uxjw0fwturmeW3TXc97VI8kJOeozTloAX/6NE5hgYqyFBGT6q36300Tjr0+9N
	AXchEUflI9xJ/6SGabb+P8WCbUeN13+vOgOId826jy1fPNr2WuwKWWPFjj7ZLX+vHMA32RYM7Bz
	Re0+mqzmdNCQ2whvXiP9e9tGCzebgfVekPQn9AlCc8myassfRXt/UtDg==
X-Received: by 2002:a17:90b:1642:b0:39e:b7:cbef with SMTP id 98e67ed59e1d1-39e00b7d25bmr6619070a91.25.1789473019195;
        Tue, 15 Sep 2026 04:50:19 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfd9baad9sm4943498a91.4.2026.09.15.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:50:18 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Johan Hovold <johan@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
	Moudy Ho <moudy.ho@mediatek.com>,
	daoyuan huang <daoyuan.huang@mediatek.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH] media: platform: mtk-mdp3: fix resource cleanup on remove
Date: Tue, 15 Sep 2026 19:50:06 +0800
Message-ID: <20260915115006.2409591-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mdp_probe() has two successful initialization paths, but mdp_remove()
does not correctly tear down either of them.

For the main MDP instance, mdp_m2m_device_register() registers an M2M
video device whose release callback performs the final resource
cleanup. The remove path only unregisters the V4L2 device and leaves
the M2M video device registered, preventing the normal video device
teardown path from releasing the resources associated with the MDP
device.

For secondary MDP instances, probe returns successfully after allocating
an mdp_dev and storing it as driver data without registering an M2M
video device. The remove path does not free this allocation, leaking it
on driver unbind.

If an M2M video device was registered, unregister the V4L2 device first
and then unregister the M2M device so that its release callback can
perform the final cleanup. Otherwise, free the mdp_dev directly.

This issue was found by manual code inspection.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Fixes: 4294b9d6c8c4 ("media: platform: mtk-mdp3: avoid multiple driver registrations")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index f412aadb5996..bf5cc20af715 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -374,7 +374,12 @@ static void mdp_remove(struct platform_device *pdev)
 {
 	struct mdp_dev *mdp = platform_get_drvdata(pdev);
 
-	v4l2_device_unregister(&mdp->v4l2_dev);
+	if (mdp->m2m_vdev) {
+		v4l2_device_unregister(&mdp->v4l2_dev);
+		mdp_m2m_device_unregister(mdp);
+	} else {
+		kfree(mdp);
+	}
 
 	dev_dbg(&pdev->dev, "%s driver unloaded\n", pdev->name);
 }
-- 
2.43.0

