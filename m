Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50333E374
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731727; cv=none; b=SZUFebUaYibFrLMzBH6XqG63qGB5pOnmRF85f4eRKuPaIEJYrPyPKSRyfzAiPjuHNi8TclNcsXgPiAL3oL4J2YuBieMnL35DR7DqE4SYJoJVudyfAE2CV1mXtCLrfOTwGzgol62XOWSgu1Ct3f2PTlaBZbcwmi/mydwv37P2ps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731727; c=relaxed/simple;
	bh=c4Vx6seY3Bl+3XqjR8NorWZ8l8OmkZml2KqNb/TbQH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miE2HLRru+Wx4SVw36BoAJVqSDQ84KerLAxrOhngJrXkcEy3mrpONL7RWx0LDK6dGfZtQmAIp4Bl0qQEdBV2vySluyr3i3ReQ+fsvrdlBn7ySBoKHExd9627kD/3u/yZIFZA7hiN725AWLYRBVS4A+qK7YZ1YE1SyOGgZfTfZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRsk2g0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRsk2g0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5BE1F00A3A;
	Wed, 22 Jul 2026 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731725;
	bh=jRe2SzrYKLCeHZLxKvReVYczF6wNkw4qtlIaYw2pOoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRsk2g0mYzWPA5GAwnIXmgyTVyaPqbJaqFX7jFds+UhOy3vZ+yL/vWv2zPT4TCJuN
	 5gyo0Ac00cNhkQ3r0Wud8xAdHrKfmYjsvVLROey1NWbOkPgNpcE+HuoUSK62Ujasoq
	 6FzyqANQ1fl30w3J//xhVrxPd+GP/oBEZVd67ap4lWNNFGu/mp6Kgs40cceRU2LNjY
	 mrLeHlSc7mq52u/keBX28X+8p6iu5Vo/p09DFElQ9AvXnv6bKnTe1MzEKhb8G/mzpl
	 0nclHvIxBEfNLXkjILlfVmM01VSZMboFa5kwpE4BROsgNKwqUdwY1PhyeJbcfE3A2f
	 27KJMkP7kEKGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiacheng Yu <yujiacheng3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] fbcon: Use correct type for vc_resize() return value
Date: Wed, 22 Jul 2026 10:48:42 -0400
Message-ID: <20260722144842.1601797-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722144842.1601797-1-sashal@kernel.org>
References: <2026072035-endorse-escalator-4d05@gregkh>
 <20260722144842.1601797-1-sashal@kernel.org>
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
index 63584355367776..8dc39280580819 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1365,8 +1365,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	struct vc_data **default_mode, *vc;
 	struct vc_data *svc;
 	struct fbcon_par *par = info->fbcon_par;
-	int rows, cols;
-	unsigned long ret = 0;
+	int rows, cols, ret;
 
 	p = &fb_display[unit];
 
-- 
2.53.0

