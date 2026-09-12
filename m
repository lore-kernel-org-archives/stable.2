Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8C41A785
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228020; cv=none; b=tIglxMPtoHaQtQ+VH4jh4600hUjf7Bdgu+j86guEx1n4k1oRw7B//f2XAPgwscycbXwkXh01eUPcQxSnzivJhg6E/EOCY3VmnYg/1wOTvf4DEI4UGN9IgVU6uwHg4wXfujscm0mMbKRsr5TcErBUlgojLy1OvW1xTKk60AZZJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228020; c=relaxed/simple;
	bh=6i03/5PTB1rM7ZLLqQxuumRIJVqs7LFiQ+FlwGq1k/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvNWR6rYytY6Mk2C9q12mgnu9/PKgGfQgQUnCJC+uG/jxqknJGdILRlAKwAqfYdviSW9vB6NL+sE26xi3ZKLYxW9WMqUA1aKE/Cj1NKjiKFKlgl3bnAMWkT+wI9+t6xpb+uyd/TzHwvj4xiwvwOkLt89smScXhTciaCKgWOUUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO/U9OvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO/U9OvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C041F00898;
	Sat, 12 Sep 2026 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789228018;
	bh=6EvC/4iqDeCK8CJ6PIbSm3CT0qRsEJm9vIYsfjM1bnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GO/U9OvKz4S1fX7oIdHBzpP0QmFtXsT863q/36vAxehEOke4x7fMkfOi3TtDAI0/l
	 nzzBdBoxOmwBgAtqI0TWsmZMg1O5Or9JKjJfNgRbsytTCqD3df5I6jtqBLJnb7bH5F
	 EUxBfRhs3pMY75J7cKcW+a21aj5M6Pwdd5h23ODYBtfR7lGO5L2yOGJ3OJF9JS/jAk
	 9gS3RPFUlM3rG0FI6cFlTRe8p9JgQSZAeOHKR3xbhs8veaXO+K5RYCpODOqK+3nVnd
	 i85J/++GoHC+BBwcMMZCQRu9Pl86VEBVudDVcutREONUV16RqVpWje8qda4HOHqa4x
	 BxM9/paJsTd3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation
Date: Sat, 12 Sep 2026 11:46:56 -0400
Message-ID: <20260912154656.3434075-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090951-customary-distract-703c@gregkh>
References: <2026090951-customary-distract-703c@gregkh>
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
index fe2d3b7c61258..2c59e501112b8 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/of_address.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
@@ -1169,7 +1170,10 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
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

