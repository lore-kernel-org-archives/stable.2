Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA87472F9B
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467853; cv=none; b=DHjuDgbp/hx5jvCFnyWNT8mI91qyj+LmIZ6K1mxjYKlVzZPLHYFEKzVvJ/H+UTKEj3o7UBK8RdIJiyO0+tvAV0/9frkCks1WsvxKoz9lQgkXP1jra7qSUVZyG5i4LSfji3DLz/BwF7qAypNjsKAZykvmr71zHNpdHXHk/84L/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467853; c=relaxed/simple;
	bh=aUd/36u9Kwweuoo+yiuuPIsVEFuXttHoFaao8krgvyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjWg9s/nV+AoFoejJc6GHBaCcaQ/WraqIXk0sGsXlNV6hqk92XBTtEVy656Ex/xR2pjvpnpNz6EGd4sHE79SJDM12afDk6zg/WL5CyHli9Gbja9A1lAVU7KuIxNnpBP1x7FGz7SXSpNisv452j0oZOpOpDDVMsBd8O/5+XUe4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON8QmcBl; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON8QmcBl"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so26332565ad.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789467852; x=1790072652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KHU2z1i2cZYO9dBeMlbgbmxMWFY6UEr2eGRAYUrBz5g=;
        b=ON8QmcBlpEHd0vDamaI+Am2/83dvPR5rQo4864t8LA0PSbFehKFA5mEiS7q1u/xOzP
         KVhRRtDEuyplshrgU6O8RI6i1mmz9YKSAi2eV/tEpH0WsA3q9a1Oxfqkl2/So15xA25Q
         dtx0SNJTI2LSV8u73XNUSsOmjzGUH5KthJhUagGAvWKG4kAHCIdkjmL4UnpAWas1DLuN
         8UlfZM7kfBBwZRlmPTfGZ7jRwHvoqQbx1YCdp2UyLHRajudWptHoK+xMJNxxxjf2KMYv
         UlRa9u4MkFSRnx0fNsU66XahGxBNZ2IITvTdDc06yb1rue9CoDWuHWJZpCtcIuOSiTpt
         G9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467852; x=1790072652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KHU2z1i2cZYO9dBeMlbgbmxMWFY6UEr2eGRAYUrBz5g=;
        b=YGpeVxT54lR/tuyQ/cs3ldNe17L0BJVhyHYIFy8MiZjMp9tMua9kO6NyrfMBwkLPZt
         k4WW657sa0V1rjIY6+uznAo0LtGVlpWc9rA8gXVgGxgaVYenrd6ppNbQDG0WYxQ30Aa0
         EWJQOjWxYr2LpjMRGbfnKwkZsid6ZtSm/IQuKWHv+WHadSzLy0F14ZgtdfN0f41Ii90l
         nuyhe2AdVmTD1qNqiEDo3I+wlvI5BPjB71k4CnrV2QVRG7X0qNYB9s2m/f2gRoPrl1N3
         Mx/sEhI/XnrxN32JReyY89ipkIo7rDAGZqefo7yKHxjq6FBYh5qXPkdeaPiAbd/7wIJV
         DrZw==
X-Forwarded-Encrypted: i=1; AKwUvBwMz993jOv3LyfwFmFrc1lYAQSRcnSkPrzFnosSxVFx8v1KjLrcTkNGhZBD7BvzuBkB6KtjX3c=@vger.kernel.org
X-Gm-Message-State: AFuF++lw07eTLcbTbxfMf5XB1VmUI1w4EfS87peutyf3t9jOjq6xZmHY
	ljGai71rS5nptE7AL3Ey/xfSrOyAvT82Gjm1I4APcfMFGHKyzdDhxzTdKpfK5dsT
X-Gm-Gg: AYBFou21+O9cbLCclVi5lOh3dFCYXF83IBC0A0nGcuSsgPHRfmrtpWsv0r0i09vteYk
	lD9J/j5+lL+02/duHpHkbuIAoPfi/OW0GRlKxgTLAfow2KmbDiYSNXibX2GwrpHs4bF9plfkdUD
	B17blLhcyTBV+ady1YL1QEdoldEC6EMKIQ9HGw4c7igDFhjARbVFPgUBgR3Q0lDP9ND+7V4Qp2D
	dPwkr2P3h8hdmgFVEJrzLZOmDKSVgM1seWQBWZinboQFBwWkpqwJMo31mLBidTc85q1OiGio7le
	KqYfwsrqf+A4st4bzTCzioEx4SoVU+HafoS9G19JNQ1eR9XrOld3WdaUYNPxbLarXJuClR3+6Zt
	MfoZwsX5oH3KhQwEsvfLaaGAjEyhZhDvn1zMzERq6boTTY28RTFVISYUHmTH2OkDtICTQ6TzFrh
	WuML3Bxhi7Eqwp0esQgGDnZ9A1krt1bwm83lc0nWERdkkyajRzl3m4VA==
X-Received: by 2002:a17:903:1a0c:b0:2d9:464f:d45f with SMTP id d9443c01a7336-2dd6c5ba2f0mr137031705ad.5.1789467851583;
        Tue, 15 Sep 2026 03:24:11 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd76fc2c54sm10370225ad.72.2026.09.15.03.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:24:11 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: vgxy61: free control handler on remove
Date: Tue, 15 Sep 2026 18:24:02 +0800
Message-ID: <20260915102402.2357813-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vgxy61_init_controls() initializes a V4L2 control handler and assigns
it to the subdevice. The probe failure paths release the handler with
v4l2_ctrl_handler_free(), but the remove path does not perform the
corresponding cleanup.

As a result, removing the driver after a successful probe leaks the
resources allocated for the V4L2 controls.

Free the control handler during remove. Do so before destroying the
sensor mutex, which is also used as the control handler lock, matching
the cleanup order used by the probe failure path.

This issue was found by manual code inspection.

Fixes: 153e4ad44d605 ("media: i2c: Add driver for ST VGXY61 camera sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/i2c/vgxy61.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/vgxy61.c b/drivers/media/i2c/vgxy61.c
index 3fb2166c81ef..553ab5a2e265 100644
--- a/drivers/media/i2c/vgxy61.c
+++ b/drivers/media/i2c/vgxy61.c
@@ -1876,8 +1876,9 @@ static void vgxy61_remove(struct i2c_client *client)
 	struct vgxy61_dev *sensor = to_vgxy61_dev(sd);
 
 	v4l2_async_unregister_subdev(&sensor->sd);
-	mutex_destroy(&sensor->lock);
 	media_entity_cleanup(&sensor->sd.entity);
+	v4l2_ctrl_handler_free(sensor->sd.ctrl_handler);
+	mutex_destroy(&sensor->lock);
 
 	pm_runtime_disable(&client->dev);
 	if (!pm_runtime_status_suspended(&client->dev))
-- 
2.43.0

