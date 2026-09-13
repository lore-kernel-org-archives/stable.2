Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF333E715E
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789305088; cv=none; b=Lv9NM4NSKE443a88VIt5ELIh4gaLSB5skOK27KoS+d9zr9cqxqJfOW+LATKHu6LIg9+H5dNeTD7JdLhryhBx6VxwXhy3uXX4NhpMGAFMusHVWyoMlyZ1w6fFGj3SzcJLPJ2Q6cqRrJ1lz6CG5dms6oHo/WBVecsBSM/Yss9EoEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789305088; c=relaxed/simple;
	bh=qqeGZdBsfTGT8sWTFkLqBBuQnUEpLCxHLifJb7OU5Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q25fdOFpk4DwAwyENtYN+Vkiw32tjTBRK2OrGLq0HPbq83/TRAJnGNs42Fj5PkT9+QitUr6GXOlsLrhfD8xUxQhD7GRxX4S6Mpw8YNF5bVO6mN5ekA/wRDDDe+0lxIQL0BmBI5KlPU0/+1egoK3bO8D/XuEtsNlpjTumGCK/xF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axCB8uze; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axCB8uze"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b2e1d7so1031970b3a.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789305086; x=1789909886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OvV6HGYmGnPtM6s9K0ynk2MdK/BwOFAfbX5o4RmVGAg=;
        b=axCB8uze4W79s+Kbbl0QaPpowh18AY8gHG11DL0x/PaPUdHOSOkeEHRQGXWeKn29c1
         Atyd7S7hEpLYDWBTCyXht3pJKlSp3evyvZJwvMu6h+hPs+P1YLMInR2U31/Ywt93GP0J
         oV+ptO+n2VbrZEfZU0vyNpZxitzBy1flLfhCtMF64HqvK1MX97CFwY8RPJ/8sTRf615k
         OFG1fcJZ8ZjwtJmlRpu5SQOo750OZxN5K6E2BFGMoMHdBNGygUCPJea7RoSR4KrkNu3b
         Z1bJTs6kI3r+X7Ul32r52bE6uzhJVj8NV/2BVELqmFQdGy8esCIsYLsRkyOc6UWpWOU8
         QJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789305086; x=1789909886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OvV6HGYmGnPtM6s9K0ynk2MdK/BwOFAfbX5o4RmVGAg=;
        b=CVKlZX2LlgiU6FdazA9bMg/0pKc+2NJXv2ryOOgH/byenV6/r0uIIbVPjVBk1Ya1/u
         70VayJ8swKeqk5HJZxPuhq5g8yUFAA5xPULmmf2DGFN6b8YNih5q56GbZwjMWjcnnVLZ
         IoW0lXmOOHdVkQsYlU21QHqhu5siGblSmnkDeC4YNPNqAQlDpuoh5vGBra525FwEMPrj
         OwkNd1ZcT6jgJtGK3g6X5mazWWQ8AIgbOm4qnWGSV2pZijAsbke1Wa00DXVECd478P74
         e9v7kkeNBUeF8nAE6TcFEtWR/HKcZ0LPOQm+uDPFtYUfajmjmC9xVL/QdEfwv3s1hyXm
         58bA==
X-Forwarded-Encrypted: i=1; AKwUvByYObYR9WJ0w87U0TlMD4YFJPWe/rhR/zB/hkw93R7aRZ3vox4Fcua0E5EgV/hf10NJbjTqXRs=@vger.kernel.org
X-Gm-Message-State: AFuF++mkPGtrmYfgsuo2wypUlk8uTqT+18PaoydQJq2XgnQ8x1FBOCvF
	cLMaTDowIuLpwJIzemLyLf/RbjhXwV1K5kdoECcnxLR5Y386MdjnfCX/
X-Gm-Gg: AYBFou1rHCAK3Zh96JoTMw6JB7jvuM2uhfDsDuD+eyGTzcVtZGzFltqqndAdYyJXC47
	v9o2J/pmVXVbX3UZPSr04mxpmtaG+0L8vauXvvMcMROkogU4Fs0O/Z2VabZzoqsgKp1gVhwGfBj
	lwyuxE8htQn1JFKpYbk5Ag4+0+PiuOhw7+d9Wk5Ls+IsIjOVhp0Cz713HPFGc1Ici/dAvxmNW7e
	f7IZAFWij6cNN5OjcxgnhBQuL7as1fH/yVzC44/yIz5buCnhkFgIRa8OW5n66qGF89p7NlR2kk/
	kzFbd7U6R+/zSCyZp8QMfRYXSzRlxiKXhm0U5gwQYyDNU/aRHoo6fUn9V3FEtExjY26E2MN6HhO
	aal82at4Dhq2gWckSpPSzdiOeDWszLn0YAfXWjvQekP5oa10SMZ/A07PTTOquz/jilq5zptfA86
	4KyZDG5bub4o7nyro/XCDLfeqhPlLIwXtTbehUAR/U6+o3VlNHbALt0Sy0Hfk5QANW
X-Received: by 2002:a05:6a00:a254:b0:86a:9ddc:7ee5 with SMTP id d2e1a72fcca58-86b30413307mr23451242b3a.2.1789305086376;
        Sun, 13 Sep 2026 06:11:26 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86c7b4922b2sm1891882b3a.2.2026.09.13.06.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 06:11:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpu: ipu-v3: prg: fix clock cleanup on remove
Date: Sun, 13 Sep 2026 21:11:17 +0800
Message-ID: <20260913131117.1561280-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipu_prg_probe() enables the IPG and AXI clocks before enabling runtime
PM. The clocks are subsequently controlled by the runtime suspend and
resume callbacks.

However, ipu_prg_remove() only removes the PRG from the global list and
does not disable runtime PM or shut down the clocks when the device is
still runtime active. As a result, removing the driver while the device
is active leaves both clocks enabled.

Disable runtime PM during removal so that pending runtime PM operations
are completed and no new runtime PM callbacks can change the device
state. If the device is still runtime active afterwards, disable the
AXI and IPG clocks explicitly.

Check the runtime PM state before disabling the clocks because the
runtime suspend callback may already have disabled them. This avoids
unbalancing the clock enable counts when removing an already suspended
device.

This issue was found by manual code inspection.

Fixes: ea9c260514c1 ("gpu: ipu-v3: add driver for Prefetch Resolve Gasket")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-prg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index d38d3ba54d72..93033e847d0e 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -426,6 +426,13 @@ static void ipu_prg_remove(struct platform_device *pdev)
 	mutex_lock(&ipu_prg_list_mutex);
 	list_del(&prg->list);
 	mutex_unlock(&ipu_prg_list_mutex);
+
+	pm_runtime_disable(&pdev->dev);
+
+	if (!pm_runtime_status_suspended(&pdev->dev)) {
+		clk_disable_unprepare(prg->clk_axi);
+		clk_disable_unprepare(prg->clk_ipg);
+	}
 }
 
 #ifdef CONFIG_PM
-- 
2.43.0

