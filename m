Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89D4CC281
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359114; cv=none; b=Z2+emqDiKYputjBImqZdcPUz8MdEBqV1DPNkAYuBVYPfDyc8Qk7+WWSl917Q6c6c12tjeaCSjzMf9Jz08scYTFFfBBi51PFgbvAXVHmPOrGEeohmpguHnl5wDoDtXgB6Xj2lUu50ngytXHdaGLXpZbEwbzyrw+Oyw0/0fwetIGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359114; c=relaxed/simple;
	bh=jqoaoIlPOoHSlj9+wXRIMUwDN4RhN1jA+h8Gn7rewq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RoMh2L7aoUz1smql8ISudN8EVgvgqaq34+Ff0zLu7T1la0bIuJyPYI+W/3eTtqy/1ntAyyyfDXEjebYKZxKmWgw8n0yD8dQpKDU6alkW3VaLU3HlAIXXhcv/LhVihpNuRjaMX3zYEIBMQFN2o36ELCFbIxfQJ+srXZ6Df5A5cAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leOcBCFS; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leOcBCFS"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso1382483eec.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790359107; x=1790963907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AyFVOhvCGQIiViIbb7+gjM5CZL+S3jyqr2aX/1FUz8c=;
        b=leOcBCFSpJ664aT36nbueNaKIasNAJD9iYgSZuozrxRJIDpSIlUR19RR22hj2L7CEH
         yCrrvmD9a+8Y1O4IIOL7bdeRhO8SSdSU38bB9FsMteUEas3WlR4y8bDKYFRE0/yjcEwy
         pTc5kiwMDM9376f1IBE4kbZFMV34DTGaPaz3F3h7b5VlDI9HcsbKp2ZuuAMPyHlEMHzI
         jAEBGl050H0ZtONOpgZ1UNYedw9eKX62jenlh2b28Y3hQUvS17w2DnK2jz3DsCnkN1Uh
         9C5Ku1gXeZ/Fp5abH/2X0EjsZmFY0Qa7KjjrLi7i060ksSsCMU4uDXZc7MSeveFBMf+M
         3Usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790359107; x=1790963907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AyFVOhvCGQIiViIbb7+gjM5CZL+S3jyqr2aX/1FUz8c=;
        b=CoNSzBcf+s7DaqjkceuBDa1UJ3OEk/poCDa99Ny+Qeq2qrew5ZMMm8n7w0UnQJES1B
         n0aChoQhM3vWbj0t5Td8mCX+vD8dSwq8SyXD0oVS3GlMMKd5e5e0VbhYloR88B9pnHoL
         bweN/sj86gNwgWYscQ1de9WdAvgMLAd6rEH5uX8AoTk8i8UwEoT6cVW2JNETrx8jbkIN
         HbpbnrksipqfG43w7+ukh8AgGmtoIvJxZ2JUOgGWLz0By89/Kg3r668AmeUupqgg91vN
         SK/9CKtfs1xVScUPA8+FfkL1SretJ7tY4WC/JCTBU1V38fKO55ESiKr/SbRb1mZch5Xx
         0YzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHS6oK2Huc2ATNde0T+zkCjjBO4EJCPOcQ1qheS4KLllka7HB48u4P7Ttz8aiYbbezYlMqEyc=@vger.kernel.org
X-Gm-Message-State: AFuF++nOr1Kec7TZzeBwAuot3g/XLTmGfhhskbGlLCjllmSLDV/J/hwp
	gKm8rxl1ywsfHah8qQ7Bw0KqemoInn5Xzu2/8nZtz1dgbEC+EiMRrr3j
X-Gm-Gg: AYBFou0jDJEkayUuW/l2n2jXMWQofJiFGL3tUHZyndIe0yqQ3qdv4LRJd9c2b0lb6ZE
	TzNllK8rbIKcM4z6jEyOKQtw11DQ1fSXEBrxBWksLdrY4AGEe2aqx2sCkNik+LCFprBZjEUO/qr
	Oc5vj+wbQaRjZetJ3wLxH+3zMZR0TbvOMT23BJAfZvOQRBaS/v/Mo8ti3GFFx8LKk1Ycz5pX/Es
	pmh88VdU4CLFFgCZ+9IAZ1fo/mV7KzQPzjoyycA6yL+8pBQtEyxnjrYJIvHDrR6WcKD3wU9nV2B
	llga3A/6iumd5uCLYVPo+pmg5cHVYhZbSk/+H1WciSPaMruNCwpD1o+6paYm1hBY/mC4IHGtK3u
	Ej0ecWeQ0AwWhoAmX4lu0qF02MjLoZ5RSjh07t8SWy+Mit8rhS1Wc2SwHlUpunhIOG7k4wB+8W7
	clL25kwxnMraRjsWwPb6xwKKSNqE/GwXxrRD2yguWHiO0KZUHTEZ4LHO7f42pcAcM=
X-Received: by 2002:a05:7300:c394:b0:33b:fae8:bbd6 with SMTP id 5a478bee46e88-3426febb742mr935256eec.2.1790359107087;
        Fri, 25 Sep 2026 10:58:27 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c17074sm6579075eec.26.2026.09.25.10.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 10:58:26 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	dakr@kernel.org,
	bskeggs@nvidia.com
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] drm/nouveau: cancel irq_work before freeing connector
Date: Fri, 25 Sep 2026 14:58:19 -0300
Message-ID: <20260925175819.3699225-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nouveau_connector_irq() schedules irq_work on the system workqueue.
nouveau_connector_destroy() calls nvif_event_dtor() which unregisters
the interrupt event source so no new callbacks will fire, but it does
not drain the system workqueue.  If a work item was already queued,
nouveau_dp_irq() can run after kfree(connector) and dereference freed
memory.

Add cancel_work_sync() after nvif_event_dtor() so any in-flight or
pending irq_work completes before the connector is freed.

Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index XXXXXXX..YYYYYYY 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -395,6 +395,7 @@ nouveau_connector_destroy(struct drm_connector *connector)
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	nvif_event_dtor(&nv_connector->irq);
 	nvif_event_dtor(&nv_connector->hpd);
+	cancel_work_sync(&nv_connector->irq_work);
 	kfree(nv_connector->edid);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
