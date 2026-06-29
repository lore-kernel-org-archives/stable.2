Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35137FF43
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760671; cv=none; b=KYN6zUvMFC5XeLro3U+vPU1EzMArbzkm6rhwan3U+qzv9LzBKfi/ZqjHvXTwvp11SstLgTYNN/Zmf8AEZzcNHpyHAxzljtuJDIgpJqvxMUB/7V5GXuk8CO0GxQar7UR45UR/YmTWA3IKjqndaXqq2tJyoQADmGWxB7IiAnb9DCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760671; c=relaxed/simple;
	bh=kdblPCOGXaTGl7yZ6R9wu2yUo3KZJ0fjKjmlgmItCI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lDNmQ/I2OEj4gUQ0Q6Bw2lx4zbJNkvA54GykwyLvahPznCH+T7+uLuRw5K02teLn1Z0A01KiplxunnKWWzWtNGYi3gBHkFfjgqiVm8FJRdpt2cTLoguELVTJTukXFi5rGmEhKaWFNXwOWvu3E5iQBNdQwuIQ4aUvV4IZalspKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHddGQe6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHddGQe6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-470174001a0so1735953f8f.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760669; x=1783365469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQX+REvUREvT7qbaKL41arO3MGXYR/ufA0BB9H4xgPg=;
        b=qHddGQe6ySjFZTp2IzE2Zgojg6w5jSMgSVPCMQ59NXTtteFxUMZvsmq4KZURS0+B/k
         +c2NhJl32UBdFfWtJ3vHL4jYEaBrC/7cE2QXBxSTts6qbo1dD+viP8hdFauF/bHdjgkH
         sXyOYZMBOfFA82Bgc1mLiRND1YfKNXs37M8226d33XJxfi7o+nS4hnd7dYm6pj/xTJ+T
         hCeO5eG0UhmoTgjj0yeRH6xUpZDB123bZR/1fMOcK/8mvE+s4XCIsHHMNqH05EEzaq94
         4vcR38u3gFCOjcuG+Ufy6FfzCjBgWa/3rh9gjVeYG2VY1b7hcP3Npf2ETYfSwrqOEfxn
         Z7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760669; x=1783365469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lQX+REvUREvT7qbaKL41arO3MGXYR/ufA0BB9H4xgPg=;
        b=AvWcBZh+Xx6XtX57i+lWGz9nTwmrGEmmW4d+o3zyGhkkv89kEo0XVtq1qKpDbLHA8u
         18Umk+Fp8EZa3XJ22AYV7l66i25r+cceJ2VvIOb+qas9xWkXzxR3SnUefdMLgo4boN6F
         4iZ/uWMCGX3yXr59usd/e0sastA7N+3o5M15Xe+CqL/hs6UC6c9qIMp5CbWdi8xB1+30
         F+g732oyPhpHP1p88YKJKgDE89GZEF7Mit8TIQJjPFrghfsLbbkWfu+bjuJbeoA6ILpc
         8GRsPPFpxFpRzt62aQ6qEGqvdFFsUQWak16XgZzioAkyVAU0ZOyET//RxHuxyrdANhj4
         Y+sw==
X-Forwarded-Encrypted: i=1; AHgh+RqhSUsQUMguiTGP+I31P9fDSB1uTsrSrSJRB0NL7AA8bQ/4cwhdW17TJ0ryy9+S3mnIPH6pox8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMhxUMAqWUJSxEIHXM8rVdfg8cxVezQVtMFkB323/D/s9hQJj
	1qo+AzUG6pOH+bQK4qytwcSzdlwPjF1JiNbIke9EWWXh6AobadEsWQ8c
X-Gm-Gg: AfdE7cl7wKnTGVczEYf9zGYPJ942r84RfiXKIbGtwfRpsRWDM08txz/XyutJMMJ2aHI
	/O8QdxXU1D9Wk7NN1Pl59HupoHQ7+Kzvuptdw8YSQeym/yns0I7dNhJMCwGag1UVHR6Wcox60+H
	5LMByovM4OYLz94iw1wKGHJgubB28x2iJpg7WbwYwr+EgPv6/ySlC+3Ph7ZagNVlh0eY0+GdtNX
	7aOyb213o6jgcoDMBTjMUEVVYtKaCJo+aFoIh2bS5ZoWdGBfvbXCEpfROvOROHUgES30UONOREU
	YZq88VeRSy58ZSpg7Zj8TFWUxBk1dgcH4YW2gHN3A78T12Zzrnwm9uv55UqPhoIu2eJ5DgP7/tg
	KXUvuBZmd0ZocQ7q/amHSO73E8keZDtNnrETQcvKQ7L5wuT32sWSIQX7y2TE2mLGzvtcwKuxEtX
	sDTaO7m8Wa3OXe15y/j1UPL5jU6FpMV07XOkWvMa8t4q8dQO7tbYqoK1yd2lk4MuAT+8SdQPy5h
	tBCO3yCdCACgIbE/8ye57fOcPeO+OjECPuAEJScZNdFpBIoDREe373MTXoPmQiOdl2dEg2Wzmk4
	Btc9GK/HmdbKqTPZTxvu
X-Received: by 2002:a05:6000:460d:b0:474:fa2e:c94f with SMTP id ffacd0b85a97d-475505f3339mr886185f8f.3.1782760669176;
        Mon, 29 Jun 2026 12:17:49 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cdccsm259568f8f.24.2026.06.29.12.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:17:48 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 29 Jun 2026 21:17:40 +0200
Subject: [PATCH 2/3] hwmon: (ltc2992) add missing 'select REGMAP_I2C' to
 Kconfig
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-add-kconfig-deps-v1-2-8104df929b1a@gmail.com>
References: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com>
In-Reply-To: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782760667; l=857;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=kdblPCOGXaTGl7yZ6R9wu2yUo3KZJ0fjKjmlgmItCI0=;
 b=TwZgEW9tjN1sLAB3jmCcOLBAJiWWCwv8wDRDVLL5laP56OjkvtqfqX9Ql3QNloSuFLYzS1Q4Q
 BspBuITZz0qCFrWG/dDECus5q6/FIwFwMvjW8xt1WbP77vcVPDxelMm
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Kconfig entry for the LTC2992 sensor doesn't contain a
`select REGMAP_I2C` parameter, causing build failures if regmap
isn't selected previously during the build process.

Fixes: b0bd407e94b0 ("hwmon: (ltc2992) Add support")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a908e22bf166..cc593fbfa4cc 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1098,6 +1098,7 @@ config SENSORS_LTC2992
 	tristate "Linear Technology LTC2992"
 	depends on I2C
 	depends on GPIOLIB
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Linear Technology LTC2992
 	  I2C System Monitor. The LTC2992 measures current, voltage, and

-- 
2.54.0

