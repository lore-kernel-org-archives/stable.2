Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228ED3FE37A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751575; cv=none; b=FrbDeWyZkGsOc45RScx7hlnNcbgT+gW3mHOpHwT6xEIJp/SiuavfS8auH1xq1UtVogsIlP5Bx5Lml8V0FFNlFZ8ttKSbZ2AHJoU5wItpp/1nU6sbaq1dAtYzFLUWgXAM3ZGRxf1ljWHka1CywSzVJve8OdNLbU0iVS31mufLDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751575; c=relaxed/simple;
	bh=f4vzx3ygeFKoFgtvLer1KloJC2SBtH4cyncEcjUfX6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Il+RpkCntI+DHTtKzEXQ9MoTE/tkKGBy+f4tJ26Ye4eGD9cAiskFxEkkRQqCb8dqLS1AsLzfkjOuAbIEQxF9x/rtKbHhR4EOxD0J0bs6lC45cPSMjARTAjs9lUKELadfwxKzoP5CnliLDsFKLAYAGgxCnzDeeoZVRzkydZoQ/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFgz/Mmt; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFgz/Mmt"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7c9c2df74so371031a12.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 23:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790751560; x=1791356360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hU+zIGAKl5WRrGNtWt1WIuTTmXd64fU+CsTBXH1LZFQ=;
        b=DFgz/Mmtf5jyVwvFpuuSvoDaRkU6TZkX+8rltHrCGsDLEy4DX4DUYwjji7o5KnT+VP
         vvVvG2LGAkLOvfHPBUYNoZR7A/MQ7n/qmoMNqIn+WH9DddqZUXckZaHH0oPSnOmy9qU0
         883jX5tRs53CSgisiOfMpnm647ulffdGb82nsCvIwR6erh5nxxOd3q7MSE0aV5Wk/0ed
         6k7PZFjVnJT6D9XcDnGQPOhusGiNZwB1etrv6fEo2lF244qSrRNdebyV7686jHPrYYk2
         wDtiRRMNChxJ9nagZnL65qczvvVTRAklTW6vb3ey7UxjJgzDX+kfI3x0S9Q4wxq15h7J
         Gn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790751560; x=1791356360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hU+zIGAKl5WRrGNtWt1WIuTTmXd64fU+CsTBXH1LZFQ=;
        b=FitmzM17J1JfK0Eo/YxPhu6EduEtMI7tIvmJGHNUslnEm2A4+iP3qPDCtJynouGZ10
         4j1ja4zT3nX3wEXw0LzJ/ts4AFvKlis7tvjFomxUabPmrwPMVT165Ee9kA288lB+lLHs
         xcjR5WamYEqd8H+BDUPEoz/gKCdt2APa//ppRpM90FOUXf8uePOS+/DtAQQgimN2PXi7
         tP2CllmtsXmSAT5Ql0psXxKuwHUZlX86iRr/TmS7ikgk+wx+VoEWpBpfsLsTTyr3Tvsp
         NvCiT8dQnCgWxYd9V/yucW2JZq6c/Cjd94UUIoaC6O4lNZc/wwbq445YvqGMy1XNFSJ0
         4udQ==
X-Forwarded-Encrypted: i=1; AKwUvBykTSUDu63cXot3yQs0Hi70l4/AqPzw081jMOdgKqBi27Pwr6SQP29SVAg64mJiboesHDCLEPo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKG0US6Hi6R7qHvswAD8vqxM5OQKSrR2BJBYqLnywPPnf+Miqld
	z47UDlu0SaE7cAv7SjabpM2p/bwZMb8UAGZ8PmRREMnE+05YyhQ6JvEW
X-Gm-Gg: AYBFou0v2OnMptfRrDp1gvRFkEg7Fm52P21p1CWjdvyDg2osyiTOeoPU64ZKcxL2TU6
	FzVgkNBG8ZiJanJO+0LIhvPb3hHgqWruUPQ7AVGUkMgJ6cvhDE0aMgtnmWl1hJgQcuHHqPH65fH
	DS5ckoEo6ryR4W2CiaOYuMEhcKmYK4k2D+JbH2IsURRD2p5DRx7qzCdRN671KpHUQbqKJAdukpU
	36Kq9BW56YRB1r/4b3crpaWst05ytIdEycEyEDNihwSocn5Nhoh3cVZbTxcg4dbsXgNKhahL6ao
	/3/FKrEHKEy2PZXWFTrwHDu73Jx47QKX4DpLnHT9qXHHIu20iQ2nJ/4yXPwMwhR0S4qeZYcw40h
	4/OM9mcRPqFuNa256/m+skaZMrDUOW1ku2ZpZrdyKODFMDQtoA3qVTpzQb3lh4K4P3YQilkMELe
	1XRhvIN3sdwEVK+ZU3UzVnPkG6egeTj0OpovYrdtcFtDg7M1+ScqkBlNBxBE4ghOpT8P6xFPiVu
	ZXR5xSA0TDJt14fJ4Ir7ZMl/sFQFOuCgtTTIKZ0eyRj97s54mw5v49PPvgLasXZrrghcWmb160K
	i6dO5DAW+Q==
X-Received: by 2002:a17:90b:5281:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3a4d276f94bmr256792a91.7.1790751560438;
        Tue, 29 Sep 2026 23:59:20 -0700 (PDT)
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
Subject: [PATCH v2 5/5] drm/gud: Reset damage state on vcalloc ENOMEM failure
Date: Wed, 30 Sep 2026 06:59:14 +0000
Message-ID: <20260930065914.393939-6-benquike@gmail.com>
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

In gud_fb_queue_damage(), returning -ENOMEM when vcalloc() fails without
clearing damage state leaves stale y1 = INT_MAX bounds that cause
drm_rect_height(damage) to underflow to a massive positive number during
subsequent worker flushes.

Call gud_clear_damage(gdrm) before returning -ENOMEM when vcalloc()
fails.

Tested in QEMU against Linux 7.3.0-rc3 by simulating vcalloc() failure in
gud_fb_queue_damage(): on the unfixed kernel the un-cleared damage bounds
(y1 = INT_MAX, y2 = 0) caused height underflow during worker execution;
whereas with this fix applied, gud_clear_damage() resets damage bounds
before returning -ENOMEM.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index aa7792966287..fb726e3d849f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -404,6 +404,7 @@ static int gud_fb_queue_damage(struct gud_device *gdrm, struct drm_framebuffer *
 	if (!gdrm->shadow_buf) {
 		gdrm->shadow_buf = vcalloc(fb->pitches[0], fb->height);
 		if (!gdrm->shadow_buf) {
+			gud_clear_damage(gdrm);
 			mutex_unlock(&gdrm->damage_lock);
 			return -ENOMEM;
 		}
