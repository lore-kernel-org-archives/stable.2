Received: from mail-pj2-f35.google.com (mail-pj2-f35.google.com [74.125.227.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF360403E8C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751577; cv=none; b=DQcMI14Jy1pyy38baV0Xsqq2pWQqxyKZfPCthtoX7QZaikfRl3qMqNkMwMznbIuAlRKakUY3wW0UoHV+pHowj8+kHIK+giymKDzcrMuhmexLdiQ77nQ+11y54WIE4ZqwOrnaskwrCWp7N7MCD4af7S4QqgI2xd1eAOKopYzCYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751577; c=relaxed/simple;
	bh=7JfY++iI8gHfgHqKJfxSarJhx4kdjmVjYiluOw0YWYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8Vsfr6hhe/xXM0yhcoyAgYxp2UTWtHBA5wT9aixfZj1Y+4KgpYXbOXT8ioBHcvfJHPJ3AjY8K3t0+ttx0QOU4sbKDrxjtuO6ZVU5U4ebgYKeu+bkE7e1YFpGtMRmsuFd2W++ui+jTKz11BYbuN3Y+wSdcsdxfBEoiHkKD1ASkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0J/09Ak; arc=none smtp.client-ip=74.125.227.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0J/09Ak"
Received: by mail-pj2-f35.google.com with SMTP id d9443c01a7336-2dd77300825so26707875ad.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 23:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790751560; x=1791356360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jtiPJ5UGtiZsDhZZbOoXQnFvgnva+qGhuWA36rHa5rs=;
        b=p0J/09AkHbomLMklHOFPLTOS/6wE065M1GkwXf/fnUD4jRynstsa+G043exwQd37e0
         JC7VVfbxNPWt1FJ62uNK8JVQzT2b0xDfL8nNaf9pbcJI5h0x2VhrJDHuvfpCGI/D6N50
         wprXp3u6r4/jFvBvGCjNur/yYY/8ViVYPmBrI73Sim6iSST27Q/ie18+ylgiGReC39i1
         Coc7qxy/uD1Y0K3m0kkCePskkrmeER3nemlxA3VF1K/AQp/LpdkLtWK4se1faXxRvCWl
         3lsbXXxValuNzry3M/1PE1NyJ/67Wies3TUT4g3shFJhtOpdny9dBJL257hbmX7iy88U
         6zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790751560; x=1791356360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jtiPJ5UGtiZsDhZZbOoXQnFvgnva+qGhuWA36rHa5rs=;
        b=jjESdg8GZP9Fh3spxKaielGM02gzPc/3nBNLtPdQLGphvXR0OF1rsded2FEG2MaWEw
         L657mwakHRzpx5Bx4EmJ0msv13Sa68papaX6D94BsePy+KkLAhBthkhGwuDWtkpjfQBC
         dvxbrlBK4zVtfNb2yk1czOxg5HKHdGe99ndToo29cq3gwdpr9M2kHO079MsZEjxGzNbV
         iyik7Epf56y/1wHeKtENLkV8hgizRWoyfq/W0ZyRuIJIJoE7Jr4OXmDQZ9BIY4F2GjTp
         zzNB54rMrXUAy5y2vBL4ghgU67C/iYQFoHhHg3B3srkCRgiutmZUjL0Tbqf4tDtYt1cw
         5B8g==
X-Forwarded-Encrypted: i=1; AKwUvBwMqERdknGlJKp3AtqonEWhfDtCVAnj+K1QlLc1RXN+0ZJx/jwOV96+dU31xRaLuaH4Xv/Z8fo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLZm6RSpigZMu/NScyKfiZt5cRCqSqhFjA8SGrhwc8wZcrXtvr
	rZIWJjtpJFe/jYuM5CbnJAOBi/+tGMVn7aCs1kHG35ih/LuM7pSopIKd
X-Gm-Gg: AYBFou1b99qmdh0opfjiHPWeQjgM6mxwuWR0bbSXbfcTzjzkwP1qs3zFbSfNHOut9SG
	VobKtcTCvFsY/kO03bSyt4ZMbAtLTeoT+KxUmqCiYmNWgbceLB40C6rvnFHWlzH5lCRuvh4AP+c
	wZuMGKFSm7VzW+p/j/5BfDKLxWqg/3ZOshHeKd1cN5wTvXnN6wUBvCe78S+dEXgATrva1YeLlpE
	J6YBNycek5AdduU1PfRapcmZVUN8NB9Ei8jtzhmWhiOYbgVZj31RUMnHqgmRuf3COqeDisLqA0J
	+9RVr74rcWMTgVD+4LUoBS++g6nqUdZA+bJg0MJWBlvnxO1z0zoaCY/seCVmjqw+tLDnWVwZFbH
	LIVz71LDc7+O217cwAtHFtjqO0kZ/BejQTCzHpHiRf0SW60g5EUhTg4Bq3VJeFXQVWvKOgp9rXG
	KmisqV0HQeAo02S3oCbGLPHZ+ezZyRMMJSO5JA9wauyzJAsqLSQbKDDf8KQRt1Wnm591CbqefeJ
	wmVfZrdzYPb1cNj5bx24eIBwYr3UTNhnn/sMSDE64q7Xv1qvVV+7JTMrcX3z7Ic0OK9hJOMESjA
	U5+xY4nIbg==
X-Received: by 2002:a17:90b:4f4c:b0:3a0:49c5:d3c3 with SMTP id 98e67ed59e1d1-3a4d18f52e4mr485973a91.53.1790751559670;
        Tue, 29 Sep 2026 23:59:19 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae9ffaesm2010442a91.16.2026.09.29.23.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:59:19 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 4/5] drm/gud: Fix bulk_len divide-by-zero in gud_flush_damage()
Date: Wed, 30 Sep 2026 06:59:13 +0000
Message-ID: <20260930065914.393939-5-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930065914.393939-1-benquike@gmail.com>
References: <20260930065914.393939-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In gud_flush_damage(), if pitch or lines is zero (for example, if bulk_len
is smaller than pitch), evaluating lines = gdrm->bulk_len / pitch can
produce lines = 0, triggering a divide-by-zero (Oops: divide error) in
DIV_ROUND_UP(drm_rect_height(damage), lines).

Add checks for !pitch || !lines and !lines before the loop in
gud_flush_damage().

Tested in QEMU against Linux 7.3.0-rc3 by setting bulk_len smaller than
format pitch during damage flush: on the unfixed kernel evaluating
lines = gdrm->bulk_len / pitch produced lines = 0 and triggered
Oops: divide error: 0000 in DIV_ROUND_UP(); whereas with this fix applied,
zero pitch/lines checks return cleanly without faulting.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index aa7792966287..fa726e3d849f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -340,8 +340,13 @@ static void gud_flush_damage(struct gud_device *gdrm, struct drm_framebuffer *fb
 	pitch = drm_format_info_min_pitch(format, 0, drm_rect_width(damage));
 	lines = drm_rect_height(damage);

+	if (!pitch || !lines)
+		return;
+
 	if (gdrm->bulk_len < lines * pitch)
 		lines = gdrm->bulk_len / pitch;
+	if (!lines)
+		return;

 	for (i = 0; i < DIV_ROUND_UP(drm_rect_height(damage), lines); i++) {
 		struct drm_rect rect = *damage;
