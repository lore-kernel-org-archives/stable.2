Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679C2D97B7
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474468; cv=none; b=Z3ewB6d/hrE5DtWsjB9vzqAlfD8D75HcjEQR8U3ma+s4BrPnOq2v14HX/btsKRel55SzBfIsU/xLRa22irCiU+05iozx4Gs7ROj6BDLkbeR6VgB8fg2Kt1Pyqk1VZjC45/4jp5nSNj3+ij1UERa7mCgOqD583tK98u9flBgMr/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474468; c=relaxed/simple;
	bh=EovFhrzEm4UbLIRzD5IxllAuM1l+CaRbk9aBHpANUd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTQNkM6BZ4B4pElGRPJc9oswMVUFRq5YHy+tSg1+s1KakxvAHJNDba/w3CwlbEBDKeDR66dl39DDXeusGazfr0NSB+kBredmJLByD0QZJDi9uwsV/tybxMqZu5AJOuAy1YTqdiI/X4QLIvLJV6B0DxkaQ2FreRiC1HLvkniiTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGU0a8a7; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGU0a8a7"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-5b76694fb7aso729696e87.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789474464; x=1790079264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hT109/DKD8D3ImrzvgTZ3A2CRXv9GUhxcQttm3TUwyQ=;
        b=QGU0a8a799QbpC+yG1vBkbb3Pii6sUVJmCr6wwd9nTX+6hUPh/+7VvedIp5frHAgHN
         hEfXzeBiahG28EORQ0x5s/NNabswY+6PezapCURZ9pzO95co8VT2aXuMsKB6NOEp9SrK
         FLAAn1kNRZ1AGqncqdJH5pxxP10r0OQmk/ZPRJzkZj0PDI4fiNQILmvT2YkTiwTH782+
         7HkEUgHn/VcPnDO/CgjHvKJSBGIuwEpA8gXfthgR+skficAsiEzWp+2Dw8pgFwmQc74T
         qYq/hpbdxdcFD5UOuoC6whyszpKAo43DuRbOjX4jREpd8vBpO7ne2YT3W2Dg96Cuz+YG
         dJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789474464; x=1790079264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hT109/DKD8D3ImrzvgTZ3A2CRXv9GUhxcQttm3TUwyQ=;
        b=XrBtWQ/sKTnqtinftrBT5Am7Qqf5tjEqeFaRbdOHlCEbwXwLy9jak/n5P8Y7CpS6/a
         keaZgaHM6rn7SuAH+DSxwLhAtepOg/1BKzJLFFWoVgKUQmbt5eyQPnMQqA0+p5KzB7YE
         14AM2IqAQ7IqcGfPEqrPmVH0eEGPelUERK5CWw3tf2ZvgDRz2Hm1bV4LPS7sXVqA5lwX
         RvnhAe5tucN6L70ZZ8tyTas/URFb9u3jjsLRw3R9LkVRO7E7e4nipqJCr3IfQngowqDY
         KaIIWdK0nBFwq6BZZcNbw2fAJ1I+UuhIgr5NKM5uZMh+2Zf/bkcN5cBFMwcmAFJ5ocv/
         AOxA==
X-Gm-Message-State: AFuF++nrhbaBxwsM6/tLsaflIuUNkMXnIFCtqZU5AX4oexML6kQVFGJF
	wIWpRGVKp27unqu4tfbBfmz1mnO4hzkfu/XzGJpovACNeNc68YoiU8+AcjIuUKfprL4=
X-Gm-Gg: AYBFou22ikU+Vk/I976HLMA5RTqq9omqc2cL2Wsk8xm4XB2EB9siVLOBvaZeBRzj3wZ
	rQErP1XU58PIVoOBGG89ivZHmiT3mS+vPX1hqN/733IusokQ0a3Cf35JRbyxsFB7rrTJgDPl5qi
	k20gMY7fUc22rCRs+nop8IP7brqs6A553RSAaV59Dwv2laiY1oCP7q5Nh7c5mZrrJIECGR/SQEh
	QBBevD9eZs+tU40i21vZHMENpCyaPDVFbR+zyo661fw/leN/blBp4llhx8179AAccw+UA6mMqP9
	2aLKyeyqa4D0g3wkb38hqtXB5AYpVzD7dlzlr1lKRzF34PihvhIVAunOp9suZ88KcMElfh6kWXD
	BNY4FzlmQ1QlELHN7LzRb88NBGiWhJy/IW4eHixHVR/RH5ib4Fvn2Kv9GIeJVxTeTwAsBxcuMfz
	VOCBoBoHR81nb3p5eG9v/7zmnNLNPIGdE1b5iTvxjKjwQT/GMre+Ys1wl30C8bKA8yPmHCEPfqq
	xpLfCC8K1tuR/Zl
X-Received: by 2002:a05:6512:6ce:b0:5ae:b5d7:4b99 with SMTP id 2adb3069b0e04-5b8b29d4641mr846404e87.0.1789474464385;
        Tue, 15 Sep 2026 05:14:24 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b3a58fdasm446114e87.12.2026.09.15.05.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:14:24 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Oded Gabbay <oded.gabbay@gmail.com>,
	Kent Russell <kent.russell@amd.com>,
	Amber Lin <Amber.Lin@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH 5.10] drm/amdkfd: Check for null pointer after calling kmemdup
Date: Tue, 15 Sep 2026 15:14:03 +0300
Message-ID: <20260915121405.107068-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

commit abfaf0eee97925905e742aa3b0b72e04a918fa9e upstream.

As the possible failure of the allocation, kmemdup() may return NULL
pointer.
Therefore, it should be better to check the 'props2' in order to prevent
the dereference of NULL pointer.

Fixes: 3a87177eb141 ("drm/amdkfd: Add topology support for dGPUs")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2022-3108

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 86b4dadf772e..02e3c650ed1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -408,6 +408,9 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 			return -ENODEV;
 		/* same everything but the other direction */
 		props2 = kmemdup(props, sizeof(*props2), GFP_KERNEL);
+		if (!props2)
+			return -ENOMEM;
+
 		props2->node_from = id_to;
 		props2->node_to = id_from;
 		props2->kobj = NULL;
-- 
2.53.0

