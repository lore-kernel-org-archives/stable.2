Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0226349CEF
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741403; cv=none; b=h2OVjOcRqQjzUhtnlUPz2u8zYkB7iTkAufDUYCQRh+iVx6Q0dgth8Rov/ra7a4vJS7zhdG33q40j8rZiD+AIt8D5hb5uGnaXq+xE00vSByKqugOWJVXJnWA6Y9jhaaCrwsOr8BexqSWTls3WcGxbtqU6f6mmgZsU3ARZNrjpxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741403; c=relaxed/simple;
	bh=SYSCU5NyaveOlUVFguQhrp+B1f2EGPRzOeEq6MQlBSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3cNpQUujufDbZJUZ3ZmBcEi/WKSGkTa2B10nkDEhLz9yPhoAXs7Ry/zs2mXh/X6NJHV0DhRo2eXEkRKbxNm9H1RTxPQTjc3kn24FCD+NoGXVOvwqgoz4XjfCVTj8biZXoYxeoMY9i1KHfzxH/+4WaOi4ZsxfPVUjnUujaSdXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEerlgz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEerlgz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4239F1F00A3A;
	Wed, 22 Jul 2026 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741401;
	bh=YDjG7t9gGqUvewBkpPElakbJ+YB0O8CRNCbzr/DvHFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZEerlgz0QSBeTdRrJUnnVsd9k9Y934Dzi0YZyMv+8T11Q6YXaqe8uYhLQFMZOEjVN
	 E6QFju1fCo6qMHXhyNm+8GN4JWe70O//qWUBRtglfvnRSmorISxwpsPNjH9YyvnP7W
	 QHitA2Z586D1lEBD1kX+uw7C/9SgUEhIxCrHtt9T6Y/oKqDLTeHl6QINGwgNUtkMgO
	 l4QRAIXM3e3jBBXhIQcUISy5bDJc66trLJ8I5cu7PqTczMwZ+rztRMqUdLdC4q5H91
	 4fP9Mi4NUz7ub4AMdySP/MCtHI5mMvo68bXsLM76KufZTAPxjxova3RYmQcmXltzO8
	 A7s7MTrMyCbKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiacheng Yu <yujiacheng3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] fbcon: Use correct type for vc_resize() return value
Date: Wed, 22 Jul 2026 13:29:58 -0400
Message-ID: <20260722172958.2068673-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722172958.2068673-1-sashal@kernel.org>
References: <2026072036-malt-rejoin-cd26@gregkh>
 <20260722172958.2068673-1-sashal@kernel.org>
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
index 16dc9fe4ae0962..d0454fe3006faa 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1319,8 +1319,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	struct vc_data **default_mode, *vc;
 	struct vc_data *svc;
 	struct fbcon_par *par = info->fbcon_par;
-	int rows, cols;
-	unsigned long ret = 0;
+	int rows, cols, ret;
 
 	p = &fb_display[unit];
 
-- 
2.53.0

