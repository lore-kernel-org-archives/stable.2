Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A7466B05
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738724; cv=none; b=shKrXXTY8QdAh5VqpRQweKgcOsCHOBaL2EPqIMUAIMq2yTCDw9ZsbtEoREjJuLycee23tpQuekBsUQ0ikryF6zxxtQXvnmGu8UHDSEN3f6IRpikbrKr8EMIMKJJvQNwCnmyqI2BQ+sS4O1C640dcCCn2fSTJZrf44XQbCyZLLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738724; c=relaxed/simple;
	bh=izjVJ1GsaHMy0A8Z4dzQrA/0kJYmzfi7T0ir8KG7JY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aN7B9iBaRJ1JE4CP/Kjx9GjSb/fNJHDIVsD642gyqdml5+JyKb2QCdlGEsNxlE75qHDRGcf4S3maKRJmUd6ldY96KI5dtUEaIKzDLPl+wVBmR+Ct7y8tj15mPM4kLD6ixTcbgiG9tXYyTcVvZyQaTJCh7E7s6QDYVydYVcHaMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaFvnh0D; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaFvnh0D"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso8537696e87.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784738714; x=1785343514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RMaItLf+wLPzPOkAIWLQbZ5Iu0QU3hrWrmvyorzSKio=;
        b=RaFvnh0D0aJGTHuzESvpBwj8zJbWDJQN5rMr6JN1jJ6Mpzn/3z2kJ5bf+9chzYJqeT
         jh4JQXo6iUbtGJjOOvwEEXwIAgleturkK+DpPRpor7vGokZRuoXgH0/AHGt2P11lrosW
         CiXFY0Rb0/oH460BT7ZGBG1+BcS2OAUzcVqF8RzzxTQ1JwWG8xvOXN4awA3vx8Go4b6v
         lZksGS441u5/OokqtE6iKBoVc+xj61r5509/7uUQuNeU9X/u9iF7u6WDFWIDauiveRU7
         XAvjGpE46W357z3S8GJ946YwxJQVw80duaXUSGdaBne1IuY9xILIi46vhZV/mJOynsHv
         czaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738714; x=1785343514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RMaItLf+wLPzPOkAIWLQbZ5Iu0QU3hrWrmvyorzSKio=;
        b=ZNSED57VKR1fgqiCzEWI6WCtIQykjR3XvCXnqdlNa4hM/m7RdEHmfArdEUXyISf9pS
         lAeQmV4ko1rJjn6zO+EapnF+WoRTlGLt5m3j2+7XvgYkfS/HyLZWrPH2ZIp4NEEqGzsi
         hlhK3Yd028gX1JzMdIA30iMf/83RHDFyI+sQogRSiy9vIyumu7JqCtFaRP4cD2OPH97i
         srvA4BxDZYZE1soTjumXZoZjMz4lrshQYKrQlUikBWWATk6Iu6hoJR91ZhuRIUARaAEa
         8ECnt1X42ahKFOEZPSnWZq2v14mKUHoNQz8Qw/XzkF1iVEE2HaBlCXkjThUF8QpvepZh
         ZytQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/NZklX8PL0E0T7gnQefhU8D8xkbwyL70NeLTh0bsAF4fM+LkQrTrnI28yyFn7Mir4zd3MNpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/pem8EexIiPRE1HIsssdtbSkwQcudIKHbzTQXrq2VuN/D9Rf
	sf0+4tYlODSJe651HFk9Idxb+XMywoctjEd2FpvTgXU2wIj7aPerfKShH1ji1SDaGmA=
X-Gm-Gg: AR+sD101grC2WZ+SkxVDTwc+n9oelKZwsDHq32CzcnBQBgZtEtP9jUWJCi8wClorAPC
	VA+YCmiXkJ1ahcFTYSzkLr2arfQn89G5NIlWt7Dh9/PKOfg6drC4rNjc/H1h1CIhSciicEvzbzb
	ytzmpflxR1AsxevnWrPTs3BTzHady/EOvBRZZgc0b8RPnB4gbeLVj/sieN9AhWZOyDfR7sYUfSo
	q+ojvEEsBb4l4nUxLMk/NeWaugyRJFlBAFVA+qaQVJfPZZQX6nYkzwdHdEgFiN5m557dwNGd1g3
	lxTf+KOhmqR7ihym6Ofm85I3DF/TdNzEUffCUxi0Ne/8K7h6vPK+ujYUXy+JhA/QmadrhIery4V
	wW2tSC8CuD7YRQ2ozYHYD/Eh/Ijn7MivUX34jpyNlwZAlap+lCuUxhA/LoqJSCtYHWHR6JXv2V3
	s3fHN9C0zzdGvELTasp25DuIdbR11pFkCI8kH2tEWopDKF2zyhAM9pInnW1yCO
X-Received: by 2002:a05:6512:1309:b0:5b1:56db:b069 with SMTP id 2adb3069b0e04-5b28f9bc8a3mr5436335e87.54.1784738713899;
        Wed, 22 Jul 2026 09:45:13 -0700 (PDT)
Received: from thinkpad ([5.217.151.126])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9d302e3sm590498e87.51.2026.07.22.09.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:45:13 -0700 (PDT)
From: Arash Golgol <arash.golgol@gmail.com>
To: linux-media@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	kieran.bingham@ideasonboard.com,
	mchehab@kernel.org,
	hverkuil@kernel.org,
	lucmaga@gmail.com,
	helen.koike@collabora.com,
	Arash Golgol <arash.golgol@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: vimc: fix pixel format lookup in enum_framesizes
Date: Wed, 22 Jul 2026 20:14:51 +0330
Message-Id: <20260722164451.13485-1-arash.golgol@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vimc_capture_enum_framesizes() looks up the requested format using
vimc_pix_map_by_code(), which searches the pix map table by media
bus code (MEDIA_BUS_FMT_*).

However, v4l2_frmsizeenum::pixel_format holds a V4L2 pixel format
(V4L2_PIX_FMT_*), not a media bus code, so valid pixel formats end
up being rejected with -EINVAL.

Fix this by using vimc_pix_map_by_pixelformat() instead, which
performs the lookup by pixel format as the ioctl expects.

Fixes: 09c41a23a2e2 ("media: Revert "media: vimc: propagate pixel format in the stream"")
Cc: stable@vger.kernel.org
Signed-off-by: Arash Golgol <arash.golgol@gmail.com>
---
 drivers/media/test-drivers/vimc/vimc-capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index e0c6bc9f8f20..ac60c9b5418e 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -175,8 +175,8 @@ static int vimc_capture_enum_framesizes(struct file *file, void *priv,
 	if (fsize->index)
 		return -EINVAL;
 
-	/* Only accept code in the pix map table */
-	vpix = vimc_pix_map_by_code(fsize->pixel_format);
+	/* Only accept pixel_format in the pix map table */
+	vpix = vimc_pix_map_by_pixelformat(fsize->pixel_format);
 	if (!vpix)
 		return -EINVAL;
 
-- 
2.34.1

