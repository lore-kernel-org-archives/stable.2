Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAC31DDBF
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431093; cv=none; b=hNYDef8D+61ozuojcqYSh67NplD7dqQ5nMSEQtyw3MD8nHKKQ7b3O0Wz4kWU8WlgCp5k4cLFnfSNLgCKh0hmoPwgQfnKqFko6xEHqqOiEmNoWucsXH4QPLVjFnzCcbE+z1AHBUl7TVJ03bKU3UJAkQafE7RMLdBVpQzPTjyslz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431093; c=relaxed/simple;
	bh=0JqtBpYUnXIfBSOJ9sBFjxb9UBuuSJ3GUR0evn/Js9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iA6LJRZzm5rsUESBph4UF7vNUcaUi2X+t1OLeCVa2t7yHpM4RVJ6xmAZktcgi4Ry+9acNenzeBXIrMJjX/FsVmP223th+CnkhDlM/sQTKZPqGaIO9XWpu+C+RyGL0LkB6VqHlFH/p0gk2RL0qzQU9cxkLMkvS+yhnrm3vsQLz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=pj25vQ8Y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="pj25vQ8Y"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4906238c62eso97683855e9.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1780431090; x=1781035890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKgY/LuZvQl+MpRxtJBgscIMUnKIMmUCTQze1Bp636w=;
        b=pj25vQ8Y8M+jV8MDUXAfilI75khrAQKZslwobjWIQkGY/n+Dq170I0inKcH6bVolaP
         lZEn7eH3QRsBG1C1tZ6TSPoYGBczyCjW0C+AjZ5XO46eUtWpKrq06fw0Se9U6RuHdyoJ
         P+wfijgDcxlwG0jFfsvH7VdwTkY2WZXpMbhtGDL7foCHWEWCBtZZ70kNQ6i7fjrsmfG6
         Ry1XpPf5cT/nFzyJpuMFgJEhQUUl2EHCnM/aLa/fXPnOpsZS0asPWmLqXCdFI8rOo/Dm
         sEfpFl1u31LInihReb0ryMjmXiiII1Zl+dVOhh7sod/wexWCn7bWWUd3FGmbAEdBbrFJ
         ZX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431090; x=1781035890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKgY/LuZvQl+MpRxtJBgscIMUnKIMmUCTQze1Bp636w=;
        b=SNZIzetX5DJruCi2RPeTpVdMqV3Ug1APiK2ShbwYwaokSc3VerqDJoimDOm8aDB0tY
         iKA5u3/lbU1qmfJyWfZx+d4R3N2ZRiA6BuhYXoXw/vtqnRn7ijjrCqn3p3Xm/qu3aWEq
         0SgFEtx8rQ5UW91Lp6KdAjnGIu1A72/xRAnhgpDSogIUBL5WjR2O6mLsfoUjFFo+Rewm
         koMK4IU7NvCRv56ddj/GtJWh737xL8ItrYqbx3abiWkYjCfheZEijFURtc9gLp6EJvVf
         yuGf0fSHX7Ovs4eVKrtS36KB8jZNnL4GYlgUlYQGySmFb8kx+k0OlS8GUUVe8gOI9rAA
         Dtyw==
X-Forwarded-Encrypted: i=1; AFNElJ+XIHiSx5hezpQKg6NiS6p5vaFd04MDAUVKuPDa62ZTW91wA9ANoutAk+I7LiKPkYGHT6Vbsew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6tgqbNm24/VbmOWaEh8layK9p1wPXzHDKYSfgXx+YrDBy9sa4
	+0acViXQFZEdQ5JG7UPJz3/phuRkCH1wU2/tP+7nhMT1aTwkmz/l9XVDSW0RdKenApU=
X-Gm-Gg: Acq92OEGxbe9M7XIecOO6UbjUS96UFL2FVMz4LQdWlO0pAqwnyEWSUsZ9ucCY8g/29t
	3SI6P8GGuVIKGMfMcFoWOaJ8nhnl6rdabf5WsVosUomvETTBFuwyVpgUhfKvVr06pH9andREvUh
	Y0SjGKw1YAHvTU2GjrWNuznqDtj7HkAbdshwRg96iZOYDCHbxu/F4MzgItTLZl6DgdCvfR2sSCr
	Jp2l4oI/q7OGQsLDMlwj6MsCEQF679+p3Gvgi+6Jj79e/W0zTYAIUELq1SMUktcxmqSuiNBslc7
	TZnjftZNEe0hegj+cWed52m0Ah+m4D8JBGGiLQ+GIax2DWWa2uDjpQBcmUzawS+/GAzqyEu0kU6
	CJSKhpVkMhGJjNqMGopzgGJ8fMFyaiNhZGq3JV1Gi2DEFS2b5CLKuwNNaqtKVabrjLPZCMxSoCr
	0EBIHEfnAAiS0LmCV4U2aKSuuDKAEDaFKlpLPlGcu46KmIzmu1P18=
X-Received: by 2002:a05:600c:8184:b0:490:b5a0:ccfe with SMTP id 5b1f17b1804b1-490b610797cmr4064345e9.31.1780431090477;
        Tue, 02 Jun 2026 13:11:30 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63e6720sm2588515e9.13.2026.06.02.13.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:11:30 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 03 Jun 2026 00:10:50 +0400
Subject: [PATCH v7 2/7] power: supply: bq257xx: Fix VSYSMIN clamping logic
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-bq25792-v7-2-d487bed276d0@flipper.net>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
In-Reply-To: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=alchark@flipper.net;
 h=from:subject:message-id; bh=0JqtBpYUnXIfBSOJ9sBFjxb9UBuuSJ3GUR0evn/Js9k=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJWzx7tYB7af1S72lfHuvaqHH4NRcI3fxyJVxhplHtD
 PHJ6va3OyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqh74M/90iZilcm3ba/Z6hQIB0uFBs0v1DXcyryq0ZeX6u8fjZPpmRYdrUf5f
 9Zs9a7v/z1enwrKB7iryLDqsGLX6jLXv1imVkCjMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The minimal system voltage (VSYSMIN) is meant to protect the battery from
dangerous over-discharge. When the device tree provides a value for the
minimum design voltage of the battery, the user should not be allowed to
set a lower VSYSMIN, as that would defeat the purpose of this protection.

Flip the clamping logic when setting VSYSMIN to ensure that battery design
voltage is respected.

Cc: stable@vger.kernel.org
Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 02c7d8b61e82..7ca4ae610902 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -128,9 +128,8 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
  * @vsys: voltage value to set in uV.
  *
  * This function takes a requested minimum system voltage value, clamps
- * it between the minimum supported value by the charger and a user
- * defined minimum system value, and then writes the value to the
- * appropriate register.
+ * it between the user defined minimum system value and the maximum supported
+ * value by the charger, and then writes the value to the appropriate register.
  *
  * Return: Returns 0 on success or error if an error occurs.
  */
@@ -139,7 +138,7 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
 	unsigned int reg;
 	int vsys_min = pdata->vsys_min;
 
-	vsys = clamp(vsys, BQ25703_MINVSYS_MIN_UV, vsys_min);
+	vsys = clamp(vsys, vsys_min, BQ25703_MINVSYS_MAX_UV);
 	reg = ((vsys - BQ25703_MINVSYS_MIN_UV) / BQ25703_MINVSYS_STEP_UV);
 	reg = FIELD_PREP(BQ25703_MINVSYS_MASK, reg);
 

-- 
2.53.0

