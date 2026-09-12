Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47C25A640
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789227773; cv=none; b=VAZRQJAXsZvFfKGXW+IKbIMupuT1xhvfZyp1IRLWNDVlyyAKVSyDBYSastBULkJI5SdicFLEG/JQBSig4SAmUcqprKHk0emsCCJqrsJal2p8OxEYLDvZjHi9JSzL7b89LA3/2nLVQXklvu9ePOCawbzvVt5pR96QrunVvz9hkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789227773; c=relaxed/simple;
	bh=NEHQ/1Qe/RTOEtu+Wug9lY7lQLyS3Pv3W1dv1ilLJxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4BLmwP+/Kx8IKKTtgnCF6ywHStjg40V7SAQiVmC9qx8T+/EE/GtU/XibPOaoPfYsGRZ4vh+JcjGkGQnQkkeeaus4zSzAYtxUpZgEWpIZl6Ufm7g0QWAvnx18Kj/WxPuzbKwnstRyIm97VDQxu9cjPRzqIxWRHWykv4KLhphgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrugR7ui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrugR7ui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040BA1F000FF;
	Sat, 12 Sep 2026 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789227771;
	bh=w3O3EgNH93tMajWUoDh9kT3W/tuhwSJBQEOmnCg2MFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PrugR7uiHyu6EYJughXPf3QfNiWSPNSqLCTTlXVaQmq++qKTuVEA6AqhbTEix3WBW
	 HelkGoNcfYGd/eGKBT8ir1CCk5bvmhBUFn7eu14A5SLrbtTroPvTI5VCnJW1eFNErK
	 2cfHjz1w5bJMxZRvnd+qqpTsqdQf+a7/jD6Y13U2WbyteNhA12C1kRzM1lWmbCKn4Q
	 V1DgwG9DDh7wP7TVqN2M9s7j5CDSSTGD1JcO5Us0CJYN6AKBQ/sDRKrbNPAnogFcUQ
	 zZrjzu924YPaVYWnfaDFC7ALgZkx+XXbvXjhGkaiQGmkbOvYS0BE8AjCMDG39THnwz
	 y7oU1N4al9Y/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation
Date: Sat, 12 Sep 2026 11:42:49 -0400
Message-ID: <20260912154249.3279831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090950-unstamped-slather-7c9d@gregkh>
References: <2026090950-unstamped-slather-7c9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shixiong Ou <oushixiong@kylinos.cn>

[ Upstream commit c6f48e59ece0123f6a11527ad4d89b21c2d65b87 ]

The framebuffer size calculation `fb_size = linebytes * height` can
overflow when both values are large (e.g., 46341 * 46341 > INT_MAX).
Since linebytes and height are both int types, the multiplication is
performed as int * int, which results in undefined behavior on overflow.

Use check_mul_overflow() to detect and prevent this overflow, consistent
with the approach used in simpledrm.c and corebootdrm.c.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: c8a17756c425 ("drm/ofdrm: Add ofdrm for Open Firmware framebuffers")
Cc: <stable@vger.kernel.org> # v6.2+
Link: https://patch.msgid.link/20260825104134.669676-1-oushixiong1025@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/ofdrm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
index cc90e0035d034..b3e42130c3e7c 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/of_address.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
@@ -1182,7 +1183,10 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
 			return ERR_PTR(-EINVAL);
 	}
 
-	fb_size = linebytes * height;
+	if (check_mul_overflow(linebytes, height, &fb_size)) {
+		drm_err(dev, "framebuffer size exceeds maximum\n");
+		return ERR_PTR(-EINVAL);
+	}
 
 	/*
 	 * Try to figure out the address of the framebuffer. Unfortunately, Open
-- 
2.53.0

