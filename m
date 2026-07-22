Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A13F328C
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736482; cv=none; b=VTuE0kK91AP+wFOJe63POFHgjNV9+i8hhM++DS0TEyGp+PH/ccHS90YnVnLdZ4+1FCfPoWbQO7jf+Vfr91/YzKQ3lbX7Ek/fWxPgXTBLkhET7IMIuhjriO/S14dhfx9JWmYstXPhqdY/kAWLbYfigtpBJTpSzLCVZnnRZWYaMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736482; c=relaxed/simple;
	bh=YTaqKutCK+Tu0v7c7ojiajp4GxerzmYAQLg6W1poWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZfevatNpxYZZKwiJy1F1I2nBZn9Spa3SnUYzazm5YoA9hgmoDxFpYk6UhzODLjG5qv9G9swAg69t/kSPSIma2PkJv/pZYSmrDOtvnCRAXYUQ0ZyuqDQxrvz4jgK1Pi3QX1IiNvV5dv8F3MHzd+QtnUjoJEyxs1nRzN49E+q7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1JIgFwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1JIgFwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728F41F00AC4;
	Wed, 22 Jul 2026 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736481;
	bh=Um6Gg488r9p207Y2u3BWFMMpMCJ50P9HH7JQ+Xu5xqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1JIgFwUEt3DRJvrDIqqK1nQGaGlw6wyJnC7I1+fmW0OnIAYqaLMWc+ETBKC0+GWu
	 t6F3YA2k2F2ajGgNlghqSOU1JF1vbWs89FILuXuPpnGVOWGvJ1jRoGgowC8K2M68mJ
	 7JK2ckCvO8ZWdrfFpWN5Dhv9Wh3eFZRLRU8V8eo4TAbYERws7z0/TX/nXc/bUrfIg5
	 B6qnLB8WLTSSwgOjBWizFdNR6Z27l64kF2rA9FizJ/I1hBnIIVlVZKblczYLiV46Xz
	 Uq74Gq6n5teyZN3ImAEdHBdjRiyjTgJBZZfSMpU7yutrXySOh7aLRuMZ2dbfIT+QWe
	 GVijrDHtaHzKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiacheng Yu <yujiacheng3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] fbcon: Use correct type for vc_resize() return value
Date: Wed, 22 Jul 2026 12:07:58 -0400
Message-ID: <20260722160758.1740441-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160758.1740441-1-sashal@kernel.org>
References: <2026072035-panning-hurray-03f9@gregkh>
 <20260722160758.1740441-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiacheng Yu <yujiacheng3@huawei.com>

[ Upstream commit 84202754fb1727dc3ee87f47104e4162ecc8ba3a ]

The return value of vc_resize() is int, but fbcon_set_disp() stores it
in an unsigned long variable. While the !ret check happens to work
correctly by coincidence (negative values become large positive values),
the types should match. Use int instead.

Eliminates the following W=3 warning:

  drivers/video/fbdev/core/fbcon.c: In function 'fbcon_set_disp':
  drivers/video/fbdev/core/fbcon.c:1494:14: warning: implicit conversion from 'int' to 'unsigned long' [-Wconversion]

Fixes: af0db3c1f898 ("fbdev: Fix vmalloc out-of-bounds write in fast_imageblit")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index a686f0a0f1d81e..32f6a765bf7c9a 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1355,8 +1355,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	struct vc_data **default_mode, *vc;
 	struct vc_data *svc;
 	struct fbcon_par *par = info->fbcon_par;
-	int rows, cols;
-	unsigned long ret = 0;
+	int rows, cols, ret;
 
 	p = &fb_display[unit];
 
-- 
2.53.0

