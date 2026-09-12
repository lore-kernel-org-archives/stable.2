Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D129DB64
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228555; cv=none; b=qxMZ+TdvP6DCAbHFqkPhBZpKISbXleUhaWcoiy5ciIo8Key5m48425RvF49oOkw99TnRpLz7gHr8URCvSjx/rKQQlopJrwTWiog2Oy2G/cbn63Xh8HLTx3zw5wbB9ppagaUuT51VK01UyVn6ODDuaG7r7rwYAsbiXlD40YHwsAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228555; c=relaxed/simple;
	bh=Z2TqD6WFoxxvf/Kdk8ktCmwwJoKzYI7W7BoBm/p17KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joRwKrSbFX1HPp/2381JWxOCKfVUDtDF7CSUjRuV+zbcr6WpgOk8NhQHiPzkKP+lED5lmJWoIJkZy8/4sYfDeW0JgMN1179J3/+LSo6Zdb5z8JswXTX35KbQEcY5pdthbuaWqb6+ingf3pmvUPRzLIEaMrJeqyGZOXPSu3xRPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJDul5lx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJDul5lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A975B1F000FF;
	Sat, 12 Sep 2026 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789228554;
	bh=qy5ZUEpejJ1i1CZkLawGu15vQhX5Oxe2I7FbhvnHF0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SJDul5lx31j4fIAZxKrglC6dDF0zlE67o4aKE0waiZxLJr7kJv3f4TWFLRfel/FLt
	 44FVJaHMerE0/p5qq06BLZjxOInV8PIvLBDzzmYO5aEe/MR8uieHVWncGBEq3XsT88
	 hDqWeknHfVNWWBg5/VQf/ODAI/3sr4188O4+RKuv1nISzYalpk9s2Bi3kpEquP//O0
	 mdl3QXTQYOFUXrla6PTr62logosIE1c/Xn/mKynMrev1wV5K3Ozu2agdwJM5YxofmI
	 d4LjCEtFeynUhQD63K6TcyYZqfLcb1nHPcdixNhRWjOadVDoZCnT4kZcJrmW/WMVdJ
	 QkMYEbLLo66rA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug
Date: Sat, 12 Sep 2026 11:55:52 -0400
Message-ID: <20260912155552.3568561-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090959-thinness-nest-7c54@gregkh>
References: <2026090959-thinness-nest-7c54@gregkh>
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
index fe2d3b7c61258..5685654fc6858 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -232,7 +232,7 @@ static bool is_avivo(u32 vendor, u32 device)
 	/* This will match most R5xx */
 	return (vendor == PCI_VENDOR_ID_ATI) &&
 	       ((device >= PCI_VENDOR_ID_ATI_R520 && device < 0x7800) ||
-		(PCI_VENDOR_ID_ATI_R600 >= 0x9400));
+		(device >= PCI_VENDOR_ID_ATI_R600));
 }
 
 static enum ofdrm_model display_get_model_of(struct drm_device *dev, struct device_node *of_node)
-- 
2.53.0

