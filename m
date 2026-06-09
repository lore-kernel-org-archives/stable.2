Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600022689C
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983158; cv=none; b=ls6deA87F2BXgE4X14nx22SpphaU5C5u6A99dxeq6zxOlyOz1yqKQnp81ZqqTJKb+8QlW4j4HfMo21nQXEKKgYU2qYsNVOldTb8HK0cF/AFJJDwzYc1pXHLyoxM98Nkb69jmQxAT9FZJyl4WFXzXdB31E8ZqUPu9H7p17rnYv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983158; c=relaxed/simple;
	bh=35gDjdmqsR7jXpjDEeoZ07B3PvW2qd7CDguv1yQuW5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stWUS+zZdTxDIYc5UWMJY8f2XhflAPhSbBG0qHNNpCgLXrRCF9KFneb/KWRnHBgKhKJp7viipTda7YmFXVS8n/nijmYe9EJJm2rm9xWVWAj16/vI3bhkb9OmZaqrTpHN3ZwOsV85bKOIjDjARQHAn6hu/IGmwU1U2ar9pLODPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiKLuq9S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiKLuq9S"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so28449905e9.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780983155; x=1781587955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb4Y81myTRhfZM02Lh/xiHfbbKBLaxr1bVcI9SRV4mw=;
        b=kiKLuq9StChh9vB0KTWT6PqScj5yK/Kp3Y6WsNXeCpMNJBsZxkpkyQ58AnqSmraKaC
         8Qmg8po+R4dOCaYIThP3qflD2n7pVY5jJSIx1e6oiR2Rz4RsO1bHCtTQ0C4pwZacDHSR
         rE2OFqbjaJfDg8c3u9U6SmST8IpbxB2EyO+QR9UYvc7daGN+r2XA48lOTQG5oBnORxRz
         eIkj8brjkNXme9dKE2yCH7J8DOUjJVd6UDTw1+XEyfIa37y4EfjOsQo7cp4F9hscdeWa
         zT8E24OHGqIQF+KD0GJ4o0UHcsgB/SgkCdWTwdtnhVOFPIMnX217dg9ignrD1v11V+qf
         5G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780983155; x=1781587955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eb4Y81myTRhfZM02Lh/xiHfbbKBLaxr1bVcI9SRV4mw=;
        b=Ttm0OxH9+NpRVogaVwD2Id9WdqOiQMNQrUMpEtDttQYSstVh3aA3jm8INYY9h/oH/b
         AQNMzrN9MuVTSgOb7Xk6nCADEVZfls+nSJBDwbaZLi8n6+YJLg9jEFmQrqMykQ0C1YkL
         jYeth8i99q9PW7waaDNQfT5qQwBks61Xkfmprgfdgfu+aM6Dh6ZqUU9RbneXWStNfmhI
         auwLpu7oaYv/UBPiyneDuOz38r55mgUHggqTSIOYGOdesfMCXLm00T6u3BiqsGpVrTMR
         e3kv+OjUjK5lpuTW1UEtbbJv3uKZ6vWvTavoaMzIMv3lzaMR1gDrBZczIcVldSlAx11m
         I6Ow==
X-Forwarded-Encrypted: i=1; AFNElJ+2oKgPmdTefdPSx0v9YfSu/dXE0bf/vefV+T2nnjaUrJi02DZLX4hOJAqU4XHP6wekLQLvWs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQDeCkyhaBkzjFfT9VUYxHpdQ4gIpp/lsYHgqyLc6T5aqbJUQ
	cmzmVhk0iXpvwd1m7QF6AyrmB0AFd3Vlw+m0Sgvg3fC5IKFzvMERlHIY
X-Gm-Gg: Acq92OGEJ0iKLH7NchhZfAZDJJRwWcD0ygT2koqCEFdxdbx1arVKSwaa89dPoixlBF6
	jOsbPMxb1oxlxK0wxTnXMe1fzXiEqTAn+1rXLkg87ZZWvtb+XJnZdtwDgcKSqjnIeI/pCuIXV5V
	GOo1LX1QLThm6xOVsMziplWVh0FsR0Y5y0SCMhD0iH8ys8CPjxcpsSscEWrOycT0Wo19RbCKhWm
	WCUhsKgPDhRQw6/l3RODmmWzleecyVZbvhKwFqgD4pyK+YTcrMHA06EOnHJHTIokOoyqs4cVCAo
	WxJoPb/hkpHT2bhmc7zIfsw8ZObfdPcmFyIsXYNJuw5dluMfUnQ/Qj7NQAuWTluq9BrdTtQsLZG
	DwRJ46ZDuBNyqusl1uGQSoYUxBb6c0MGgUnt0xS9waqHjehTRGOEnyraXZDX1IdUb1klSUIefzU
	r0JCEroGVCqvGJj2CArclvwHdpk2i1I/4ItNayCEafpvWzl9ofmeTYFli9G0yPvYRXcAZddPCqe
	cBB0tbCvdaDxSlAkiUr+3k9S7JAcON6
X-Received: by 2002:a05:600c:4ec7:b0:490:b8ee:d6a5 with SMTP id 5b1f17b1804b1-490c2589927mr303859555e9.6.1780983154876;
        Mon, 08 Jun 2026 22:32:34 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm56677372f8f.25.2026.06.08.22.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 22:32:33 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Daniel Scally <dan.scally@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: mali-c55: Fix AEXP IHIST disable bit shift
Date: Tue,  9 Jun 2026 06:32:31 +0100
Message-ID: <20260609053231.24855-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The post-Iridix auto-exposure histogram disable bit in
MALI_C55_REG_METERING_CONFIG is bit 16, but MALI_C55_AEXP_IHIST_DISABLE
was defined with a shift of 12, copied from the AEXP_HIST definition
above it. As the value is masked with the BIT(16) disable mask when it
is programmed, the result is always zero and the disable bit is never
set. The IHIST can therefore never be disabled, neither at ISP init nor
via a parameters block flagged V4L2_ISP_PARAMS_FL_BLOCK_DISABLE, and the
hardware keeps producing histogram statistics that userspace believes
are switched off.

Use a shift of 16 so the disable request takes effect.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/platform/arm/mali-c55/mali-c55-registers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-registers.h b/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
index f098effde..4cd13b702 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
@@ -173,7 +173,7 @@ enum mali_c55_interrupts {
 #define MALI_C55_AEXP_HIST_SWITCH_MASK			GENMASK(14, 13)
 #define MALI_C55_AEXP_HIST_SWITCH(x)			((x) << 13)
 #define MALI_C55_AEXP_IHIST_DISABLE_MASK		BIT(16)
-#define MALI_C55_AEXP_IHIST_DISABLE			(0x01 << 12)
+#define MALI_C55_AEXP_IHIST_DISABLE			(0x01 << 16)
 #define MALI_C55_AEXP_SRC_MASK				BIT(24)
 
 #define MALI_C55_REG_TPG_CH0				0x18ed8
-- 
2.53.0

