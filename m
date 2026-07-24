Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5591446823
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913990; cv=none; b=drBHXy+Cytg//Yhnb6fN/uPBdVUR00aLOolPMWw45OVpryrOBbvTpVzRcj98nO/d193+wuPtAuh9CjNxYruDStazFlDEpsiOva1uUb/gehJ5gMnSgvnxs1yxVsetujY8UkS7ouHFeXwpwYymYAxaLpTw0H5zFwqlnHzQEmwgcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913990; c=relaxed/simple;
	bh=VCprKjKopLE70ZKvyvvnzLiG0vQtjLlAe1X/dFaDbdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuLv+oX1wbEWXL23/Flb2R4mBxzS/WUP7qqXsZs+K6A/bbgZ/NTfOLyC2csSbj3B5zWNTC0eNVFITEHaq/VEbtvkaCsK6oa5tnJq41PEaxrSNcUqVDInvi+IG9WiQ/M9kzwkrcPOwEN0ZtmQ2OI113voKTNKuBtKZwMxQc0PYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sBaNMnnT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBaNMnnT"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f752b3423so512196f8f.3
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784913985; x=1785518785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ohKPnFyz+LLapn/ZZQ/A2iwQbIU5uk0jaD/t+e7o7KM=;
        b=sBaNMnnTmpvPLCk6Jco77s3g0XMYYkJbBZQQFRnnkT5c4b0soXkYtwGu7/iRO2DeYH
         D7HP/gqQF2qBA6dOFDbT5XS8DA4866urjp70bXjc892gSOfaOqP+29j5qnSkI6nWgUVe
         OgJQAnNCmyGT7sMDlD6gwjlLKXpJ66jny+cAbMfJY1cUPbE0QAuD6hdFe6MIznQZX5Wm
         oTgqcnguqd3wCDI+Z6ZJbiGO3/RKAvXqu2rN3cMV3rTEnou8SnqCxFVOZubuVOdcDvBe
         MP3mvBSDD9fF9frXo5YvVsBewnYN/l9Ow2YaHZG69MyzUuiH6sWK9jUZFmjfe1/RE5vz
         KpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913985; x=1785518785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ohKPnFyz+LLapn/ZZQ/A2iwQbIU5uk0jaD/t+e7o7KM=;
        b=UxtfqhJ5leJKQ4yWygNB6PLT6149vJhAPtgTL17IuC9FIwmdPUOOwRb+jDljN9Lzl/
         7WO2wf2jKWuQTPOUf7upWBe3BJMO/a407y3iehe9EkPilTvBLLQRij09iuJQopKQXxCm
         6IxoDWgFJ8LPp9ftm1EKsrWexr/XWCSBKgfTaiOi9hl02Q93K4QTNgaSBuKRpS4/6yy3
         lV/ehfK1xwBQJCQaF7Hp41b4H9ZSe7oHPhV5KSCMQlzm+ZLoA3kDE2lcuSvGFh4vxMNT
         NjrQAMz9TuHtAbNRvZaBRW1skHoL/LKXuZ71s0AdQhm5hUNYmbNzmqy57Ek0b/3jl8ng
         Hvbg==
X-Forwarded-Encrypted: i=1; AHgh+Rqyc2sdmYgkPyCJnpteSY+p9nteguL8etFJKHWrAPnhGMVdi2k0EVTgQMJ41dpgDbWYRNB53q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+kp66bvm6grnfXGAWcdWt9tTInGuxhqmb0p17CbnLuodzf8o
	vhxB0ui6pO7ZAPlevkL8Y6HTnI8s8Ydd0Ue9OagRguAVLwhS5kicdWOy
X-Gm-Gg: AR+sD13WpOPIMKtYYrIo+o8M2JuP2i+kdsB5w/DRfHK85CV8ym+GJfpQXWG9usb/a0f
	lDJhjck5Ur0wvveqAbKk5I97D6zrFEcGx0DymmFBH2Wfp2na4FhccAmVO4curWLXHlqRfitZhuF
	fpxnG4DBAGJEFKskGFz5g6yaHB29KtrcLrY/SEJ1EZDUAc9M2GVnb3jT2+Hj3YRMiYr1vaY/JWa
	6SQwDtWGwiMsgfVmdIlv1wdrD4Rf6G4GIatz9VCGOX/YIAiwjPaYFi8xLF6yNia8pUuvQNG9hqY
	6/aSAuEyQsqBQVxDHTHpscOz2P1exTCO27K2sIR5hMnQp96EcLYdAoJ+JHkiepqOaET82yokUvJ
	AUJeH4gxP4VyydSGO7DXPObWAhsq0eUt1KTmanr/ObqG7ZA82CZuLKMMd82e2nwtUJKZKa1PeKB
	xrmPIcEMk2tv9+/n8I59MjgIpK8Ixtjx7Rk+Oqz7sk73I02Z/mbA==
X-Received: by 2002:a05:600c:468e:b0:495:7a36:bf5c with SMTP id 5b1f17b1804b1-4957a36bffbmr59403685e9.10.1784913984948;
        Fri, 24 Jul 2026 10:26:24 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:f13b:d8f5:8fee:f758])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4858e28sm5411665e9.2.2026.07.24.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:26:24 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/panthor: skip zero-sized firmware sections
Date: Fri, 24 Jul 2026 19:26:20 +0200
Message-ID: <20260724172621.63046-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c31aeec2-6336-4dad-93a8-982e3f4c525f@arm.com>
References: <c31aeec2-6336-4dad-93a8-982e3f4c525f@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panthor_fw_load_section_entry() skips BO creation when the firmware section
VA range is empty. If such a section is added to the firmware section list,
section->mem is left as NULL.

Later reload and unplug paths iterate over all firmware sections and
dereference section->mem, which can lead to a NULL pointer dereference.

Zero-sized firmware sections are valid, so accept them as no-op entries but
skip adding them to the section list.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 4 ++++
 1 file changed, 4 insertions(+)

v2:
- Accept zero-sized firmware sections as no-op entries instead of rejecting
  them, as suggested by Steven.

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index a338c4f0a7f5..66d9f5947af0 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -601,8 +601,11 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 	if (data_size > section_size) {
 		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");
 		return -EINVAL;
 	}
 
+	if (!section_size)
+		return 0;
+
 	name_len = iter->size - iter->offset;
 
 	section = drmm_kzalloc(&ptdev->base, sizeof(*section), GFP_KERNEL);
-- 
2.43.0

