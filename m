Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7734611E1
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228284; cv=none; b=fjGidcsCfl9JCaaNQbYR+WHMruWPyzppmPvXM7OVjOIuAvqdhIW2eMpLnt9pcFyNEiFTbX4lnPIcBN80q+iWT1EH6VqvHmhfWvgj0VKLTQ8WT0+W9f3zfVlb0UMyTcivgFm7Zy1mvAOdbQgKlLRvSP1ptSwoovP5XJfCn0381V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228284; c=relaxed/simple;
	bh=M8fI5sKkXit8Bz8ROla676Q9oaVNP9xr3oK5igApULg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHh9bJvYA1gZGFKEYhCYr1fB9GotdURVJaURiT1/xhu3DNEOczBcD78BFkzG60nqYo4JQoPMN4tY8rjW08oGw7r9EYKdE8rTSL7cJ/kQ6DDCkZ+d9+vLS0e3nEOtRpC66e+azJO4pR6zkv/VpcRl2ZIn/Y9Dk3Ha8Gfa2ICNe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J15e6TcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J15e6TcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197D31F00893;
	Sat, 12 Sep 2026 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789228283;
	bh=/SxDHxzITmdZRI1yfYHhRNtjNZ+AWtnMyrkjvye3IRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J15e6TcWQW05Q28i9F4EsKi6+g21eP1TxK3IDImzZzvFipcgLSQ7UW1eguHgfTjLX
	 PEsBYSeNRkb3dfiT9RXAChHtvwxO9eqDnI5z3XtL7BzLHlG8yzQrR3yCE43zzXXji5
	 0f8lJfBysSGfSQrQVDul3pUX/b3IDXXF83VQOMGDWNSKxwXMZxdzR+AJFaocUcDwQ+
	 zErvBK4WFc4E7vfHOgRjCoXPmejSVHD2lndbrhtydjSlyPRHXuVXAf+bLNlIwl7ZBb
	 539AiEm3GpZFSaVHPa6MZhgwp2h80eWaPe4tQtijzljQUALFQh7WHdct5rvdKvQfGN
	 8xD0VYv52NXHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug
Date: Sat, 12 Sep 2026 11:51:21 -0400
Message-ID: <20260912155121.3559788-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090959-implicate-skintight-5af9@gregkh>
References: <2026090959-implicate-skintight-5af9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shixiong Ou <oushixiong@kylinos.cn>

[ Upstream commit 958f35cbb8955ca3fa439cd9f2092cb42414aa8c ]

The is_avivo() function has a logic error where it compares a constant
to another constant instead of checking the device parameter:

  (PCI_VENDOR_ID_ATI_R600 >= 0x9400)

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: f496834e1674 ("drm/ofdrm: Add per-model device function")
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v6.2+
Link: https://patch.msgid.link/20260731111729.703116-1-oushixiong1025@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/ofdrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
index cc90e0035d034..32857514fe369 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -231,7 +231,7 @@ static bool is_avivo(u32 vendor, u32 device)
 	/* This will match most R5xx */
 	return (vendor == PCI_VENDOR_ID_ATI) &&
 	       ((device >= PCI_VENDOR_ID_ATI_R520 && device < 0x7800) ||
-		(PCI_VENDOR_ID_ATI_R600 >= 0x9400));
+		(device >= PCI_VENDOR_ID_ATI_R600));
 }
 
 static enum ofdrm_model display_get_model_of(struct drm_device *dev, struct device_node *of_node)
-- 
2.53.0

