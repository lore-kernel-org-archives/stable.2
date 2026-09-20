Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A0343E067
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908639; cv=none; b=t1SCYmzOmCBwthZwsTvRD8kQrODqENPP65p7A5kgMmNpJxJ0O/tLxaiZFUDKJ33VD3GUVIIyS5vIMoymdjr3ZUNKVax2b+4V3qa81D8zVjuXN5SUV39Ii0AFMbztIl+ImHfa1Ohu81sncXBSnPh2r7PJ3pQM7VK5ics+iMMrv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908639; c=relaxed/simple;
	bh=5CdKdnsuSwBNreExFyi+8ZhzeRmCrWmalmi4PU3098M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dXz2exnGl0B8HS0CfN8HeISBQfFfnze0EWWuHa+2XkhkcNS7NyV7ZcJ3JD6H7QZZOSkJQkqbRGqpAniYb3jry4nCyOMdSl2W/rojBsMemAD5E06lYzRJFWvuYLX6bN56WhsnxwSQgh9GVXlaQaLg7r3x5iXMPmtH5OQRpm5XB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsanPelk; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsanPelk"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so1007915a12.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908629; x=1790513429; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CaxrEwEynmrVXEOgL+6KaVM+6Rr85UGDfCIaz2uerU8=;
        b=CsanPelk+SWXFDZVlfdj6hSwN5aRAcWOpSgaRs1fZ1cXb/4mRRiOzeI2+LonvXdRP/
         6M/1/bi74qritbk2OGQ0VOICo77aqj6LhN3MwWJVVxhJyTZlH7D0PFmD6jb3uhJBWMW3
         w1gbigMVQRqVhICtjvEdwtXnsyM3yCIZy22FfkZ4y2gbAJXx9SxPuhMRgJdAK3YSNxLj
         nK4FP526DXdkBmfihLLg7usqdyfl66zpq+4hkfjoM7RnAX9OaOAlVyRCeRibP3i5DdEE
         cKQiW31Kxlr+8TLo4oJF8XpSubrBq7x0AxD6inZTESNzD+1PUwlD8Fpk2gIrH9ekfQg+
         02ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908629; x=1790513429;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CaxrEwEynmrVXEOgL+6KaVM+6Rr85UGDfCIaz2uerU8=;
        b=HqouAjdzLNCu6SuNYN5tVfnoq+SU+eJM3n9aTitpen6b9+jNpq3mTB3Zu7XeN24iud
         nntplV1eb4lbNsEO+1SQ5Kl6APjHGcqsQCJJg5+Ooleeo0ST7DPc7R6T80qDlCOdBFf8
         KZt9CV61K4LoI8A/LS+Ioik3YpWpoQxDDAXZ3uf/sD8UzukMYXBv05Vf415TRTRlhzRm
         xvt+POLH9do5ryuWOLNBzMcOpLeS0tRqnt712kxNGAy2z+5EpnZYJbE4wbYXsyv7E9D7
         HaveJvqiHibsXjF+BbZmHPQYvIkwRfaBJSzs1hJPfAgDJ8OXE4dck7gK1KECD3Su/cIw
         KZfg==
X-Gm-Message-State: AFuF++lALcvc9HBKpolFA5fWD9j/75HBj3psokhcLKwrtFt9uK8bVio4
	BkkPvbQJ3/iYAWxu6bmyELMJaBCnxFDqlwxeDxO6/1LSvvb3JnoDTIZO
X-Gm-Gg: AYBFou2G3n+WTKg9mYkWYGZXD0KnxXKA3adZSbU288AcbRxkIN98o2gYG7p78L3EWSm
	9E9FiK4712YXWoOkQdWWXQ2niNhVpuog02uBWykIrbGTY2ZZmpR64K/SvdVKN45LGAUtybxNRM0
	6f9CDmoAMLzWIXWcxrKEhsU1yLjollUVJb9Rh72QwPByBKGiRO7xirzevGq/hz1OYpXapFas77O
	9lz/R165vh7z4Y9yw/2NFZJhHgir5TTg//5P1+Z6l8fmdTeNjKttsG5OqF5v6tcLKRDO2wEX3b0
	jtqogPiWYhLzaalJv9szpcv3k/fjYMyKjtac2oghECPnNggk2N3MBhaDAXP2y3fu4hcSYrUHaDr
	bqHofu9TIvYYuDcLErrlrY0Ql4ym/EWvDqTtGvtS/msqB7uJAxvakYGtKf3dOUaEMt+eEuGS2pY
	75d4oDEcOn/oncu+V9hF0d1rfBFbilaPtvx9Y40Cesc+C5eraY/d5bTzYS+6U8J+A+3OOhw6ckC
	zCHUFNQWs9h
X-Received: by 2002:a17:90b:4b85:b0:39e:6c6a:2096 with SMTP id 98e67ed59e1d1-39e6c6a22e1mr6250026a91.55.1789908628584;
        Sun, 20 Sep 2026 05:50:28 -0700 (PDT)
Received: from localhost.localdomain ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6caefa5esm9034132a91.12.2026.09.20.05.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:50:28 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 5.15.y 0/2] Porting two fixes for the cpsw Ethernet driver
 to the v5.15.y stable kernel
Date: Sun, 20 Sep 2026 20:50:17 +0800
Message-Id: <20260920-v5-15-cpsw-v1-0-208e80dc0f51@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CQAwAv0J6tmS7SQ36FePBLgXKAclWUEP4u
 6seZ5KZDVyzqcO52iDram73qQAdKkjDbeoVrS0MMcRjOMWAKyMxptmf2EkjgUSIuIUSzFk7e/1
 mF+CauH7D9e99kVHT43uCff8ATpZK9nYAAAA=
X-Change-ID: 20260920-v5-15-cpsw-fb8b01bb115d
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.17-dev-5895e

A previous attempt ported only commit 0b8c878d1173 ("net: cpsw: Execute
ndo_set_rx_mode callback in a work queue") to the v6.12, v6.6, and v5.15 stable
kernels. That attempt introduced a build regression, because its companion
commit c0b5dc73a38f ("net: cpsw_new: Execute ndo_set_rx_mode callback in a work
queue")—which adds rx_mode_work to struct cpsw_priv—was left out.

As requested by Sasha, both commits are now being ported together to the v6.12,
v6.6, and v5.15 stable kernels. The only minor adjustment is replacing
disable_work_sync() with cancel_work_sync(), as disable_work_sync() is not
available in the v5.15 kernel.

---
Kevin Hao (2):
      net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue
      net: cpsw: Execute ndo_set_rx_mode callback in a work queue

 drivers/net/ethernet/ti/cpsw.c      | 41 +++++++++++++++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_new.c  | 35 +++++++++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 3 files changed, 65 insertions(+), 12 deletions(-)
---
base-commit: 0248c33e835ecbec3a591f93fdaae53f7b90a4d6
change-id: 20260920-v5-15-cpsw-fb8b01bb115d

Best regards,
--  
Kevin Hao <haokexin@gmail.com>

