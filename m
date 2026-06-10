Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC91F4C8E
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781128616; cv=none; b=QWqXAzieVl09skQFhzHu4TClZanquzp+9u+GEFdi2uWzfHvfF7UirhwVoake/4DxPTsoZ+WA6HU6BWP0h+lJBBSGU/hAHRuidISPiUBnqNpVvsjM/trLB378T0hzuV2zoJLazNF83MWpllTq/Yw85AVkNRQ56SOOAbWh4earasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781128616; c=relaxed/simple;
	bh=7j+dNQOA13yRH4BVPpXE0SQ8gv7p+/ml66i5E7IgQsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/2oBlvmJ38Sfcl4sDbfcJ7ugh7FXa9sKo7ZpjGs0UQJnQ+0IMHlZ5EKOUrL6rLbfFfQ0MuUM/pDpC+eNsgBVtP4i8RwTHrwezFgtilJIZmYIrDlr1mYdkpGJOYBL2eAQRLw8XxkD3mlSz/wcxG0jQxvyjipAQxctDSxGk28R0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+NQzn3/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+NQzn3/"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so5442973f8f.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781128613; x=1781733413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yD6ITlqzgHastXjegJzEESG+cmrbmOcZAzF3fxOvMuk=;
        b=S+NQzn3/TkMMHfxVC5Hma3R0uNrAvMpzLy/LsUiBazyCLm9wUaOSLJq6CIhldE1HrF
         C30HB7Yetvh50VdSXuaGLtnSy1FGixNsCEbcJH+mluUWOJ2X3s6vfniWA3FmTOvC5RN4
         3h7UVz4vjpHU8msPrL/Cpfx6pBqoWveIKAL3YyKn/04mLu/SiZA7Ie5bGiMuBIvtEcTE
         lLtJen3j/KVnyUtqF4erhl3g8070W8x1uH4UwRO9O/Dp9uiuBCMdRvBnVQxo9WfvTyB1
         rMFRfgz3SKWHUs7mQPTptAknQlAHTg2oEdNptMSCjJfmsaarQqBLUcHqDl46L6SpPtWP
         4fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781128613; x=1781733413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD6ITlqzgHastXjegJzEESG+cmrbmOcZAzF3fxOvMuk=;
        b=muDd+rgxBwh+LcvvNhk0R34USoNR/hj8VeK9YVvVgAavkwOn6FkUP8L/4YvYdNfOmy
         n4DMT8TUHP6faT1MLZ+aXRVvK0ZwUaH6RBY1ApRrsmoXZ6fGlp6DG1uRhICHU9r6VFP6
         vDPNytn6Is7sqQl+ffA+cK3MXEuWQgbBXaDJwi9vgx6xSLfuW6MKLjmzkeiXMmQ3hkIK
         etUW5uKxk1IDnpM5aTzIV3Ifr59lPw/M1AWxudCMZobbYL3ZHCcy8xYsa+jmvealUuYW
         40WBBMObLvcCRxhFDcPCj54/2/c4/1HCgQvMwEaljGMtFOfwPhDr4VDbh5vhPgo3OhDt
         rRtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PrDteXGcSizHm6drvuemwbE7XeODhLDL63ZSsgbuduGlAmcnLthvCYPTSymy88i71Yy+zZqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7QSlivAjCsqXzT44cl4mLZTB6mAE0Y1nD1RtDRHaygzELmHH
	F5MatOdVulF5sqyW1m39yc2l4unReVULmBAipQnyApAn+kREdxeVoBDY
X-Gm-Gg: Acq92OGTDajQqkycUvwloVLTJ+h6XUJ2hrV6pTOXrNRYp9sKMv9B4GafVXiQBWXjCQx
	d93OxgLNZqj/zfPEpLvtVKnyOg2CdD5g65Zc4+gu4CxY3yeU+u17Iac7ITtkxvKzxBZ0UpNK+r2
	9tge/x/y63YlvUbPcqyUH6C9l9t59JJ5YanN7SzciwWkwTnpNMRjffbTB9jIwLzNqtMjUDDq76K
	037wOkqCOOvUsLwWCy09WewMzpBqxToLu8KlslVKvTOZGjlvYPXkez4NBWW6M9sBMifkxcUxK8P
	nYa42H4TuBGdhcOrWusL67rvUHpC8fCWrZO5P+kD4Nm1XqzNqO8jN9XHOvk5j9kyVhaX2Cbr94E
	QVWFIgTZgRfK836MnyTYKfV1CCf6WWY0JcahS6r5o1RQ7IvOaon18wYeJatzsCtBHz8DAbykFJH
	1kUXdMyMK+sGsKbjwTzoCQ6xrn+Vvgfs7ZGx0ZRmM1mDZBpeFEx+ZhK7DhmApGe+7D0Pk4AZc5w
	Y8VQAa+hpXrm5+4fUYSyA==
X-Received: by 2002:a5d:64cf:0:b0:45e:f29d:d438 with SMTP id ffacd0b85a97d-460677ce9d6mr55947f8f.28.1781128612832;
        Wed, 10 Jun 2026 14:56:52 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm81407452f8f.35.2026.06.10.14.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 14:56:52 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Daniel Scally <dan.scally@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: mali-c55: Fix scaler factor overflow for large crop sizes
Date: Wed, 10 Jun 2026 22:56:48 +0100
Message-ID: <20260610215649.98274-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The horizontal and vertical scaling factors multiply the crop dimensions
by MALI_C55_RSZ_SCALER_FACTOR, a Q4.20 factor of (1 << 20). Both operands
are 32-bit, so the multiplication wraps before the result is stored in
the u64 scale variables. For any crop dimension of 4096 or more (the
maximum is 8192) the value overflows; an 8192 to 4096 downscale yields a
TINC of zero, so the scaler never advances and the output is corrupted.

Cast the crop dimensions to u64 before the multiplication.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/platform/arm/mali-c55/mali-c55-resizer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
index c4f46651d..0713e7d43 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
@@ -422,8 +422,8 @@ static int mali_c55_rsz_program_resizer(struct mali_c55_resizer *rsz,
 	mali_c55_resizer_program_coefficients(rsz);
 
 	/* Program the V/H scaling factor in Q4.20 format. */
-	h_scale = crop->width * MALI_C55_RSZ_SCALER_FACTOR;
-	v_scale = crop->height * MALI_C55_RSZ_SCALER_FACTOR;
+	h_scale = (u64)crop->width * MALI_C55_RSZ_SCALER_FACTOR;
+	v_scale = (u64)crop->height * MALI_C55_RSZ_SCALER_FACTOR;
 
 	do_div(h_scale, scale->width);
 	do_div(v_scale, scale->height);
-- 
2.53.0

