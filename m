Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524E380FDC
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547069; cv=none; b=oDQTl69Ddv6QbGbAHqaKtkOLF6PZhG83KS92mAkT5ThiZCJT+lmqQdKP01zx6REbHy21CP4mNTgYVdH1i4n6g8yzWPW0ihsSaYJHK3NlGsRu1K2+rHqeYxkBc0giWMZCZqGlzrpavcH5z82gAQPvKNCPIRhw5qqxNwSp4ofwUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547069; c=relaxed/simple;
	bh=DBIzwDmGdKvxBj5ozJZAkztG+cYx/GxYl1BdxuxuMZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBqeHSuZ/4WTGpeTzyjXUlMCnKrWbSkgI0xM3xxgTND5UlRWMXOqxSAEHj/+lKc8SpfN1KhdfQnsf4BdW2rF+LHd2Ni4X2srp82D4YwSf5G7CcQAplD0Fhqql1PVqXhRLPZxUYocwqZij48gjGfM7q93EsHYThrx0r5TlXAsVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqQUm53B; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqQUm53B"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-474560436c3so4964019f8f.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 04:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784547065; x=1785151865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kk/EdydNuPaevf5JbgU06sHPzz6RMAwoT7HsixFynpc=;
        b=QqQUm53B6RrXI0Fos3U0bPCAI2PoNn0CP0M5BhSW9krqRzIVIaFFwx2NX/OzZ7cQR7
         1audHpXqjqQNBddU4NkUQcOQsw9jI4cU7btJenQTaXlw5d2znezq458DMVvDWE6tvLvx
         s2qyMdw8+Tytf6G3R0x2+0H7YCnfca/Szr1J1gguvRiMnckzrSbWK11U2B3E0NIFTfol
         Vba4R67zwa5o04jRMdXAc85ca/wz7X82s6ZLsBM6rarA6kGzICFNK+7Gjo1ILzDtIpiS
         zoY2FOvRjdoyOucaXzjSvjVAYC3nRaQaEnndzpZ5qnn7KbFR06msEF3hSDk5hUhSGtXG
         FYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547065; x=1785151865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kk/EdydNuPaevf5JbgU06sHPzz6RMAwoT7HsixFynpc=;
        b=pnc4xB2LGftWGQqwm0ZTQZhqVsEpBvkYJDXKSXAS89BUwmwwt9anCRay+VtgSe0eIq
         zUC2v2BZ7Zk8SF2BibL0kycNi4Rej4d2rzjt9WuiYQQLV5sod0TbyxBpOpNhnQNd7MSt
         tNhOPTPoaTw6Vmyn+hfO7710pWsuVdTd2ZPCg1jOc8teffuCgR2hFuXcC+x+S6vpY54W
         kY5elFQXm9NSeBmrzftunof8n54gLox95bvTyWOfciicQDN96PlmU1VVLlfkcjx7ja6j
         XEC0S5tsbmYnFBqmWrYyQA7Y0dNYajNdCmm/cYlRF6aHnTjaVGAYMfmYDqf0PD66wiXb
         oxkg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9TRx7m9K+/dMnetj/YptBOMjp9h57H9MDFV73SdsSgIadGYnD8qT09BkpSCgN9EVAu5wZ52c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVMsLgrL+RPH+RlNLhIwcTwk+Kq2axEtDNPZgQ40XNov6zm3/G
	lIwdNNkf81m3cUBHv9B5r0N37kaQYtQwE3OcqJv+H09fo0nNmfCrb7q0
X-Gm-Gg: AR+sD10cCPH8IaE3ctF10+94/hTg4KHIE31wQlF9MgOlVSyP1sm+4IVZUtc0DuAsl+M
	CBcUU3Wc+kxIJxyBMl5R9vftSLlc8a6E+1p5RSZC85iee2MUMyLwCxwYfgbrx8/Li8aGrrukk7l
	EYvWvJGoC5dmOuf+L0rg39ynXQP+JNohotFZafjIbUqeouJuM19ABMYddsM5qpKwu4bEJcRQw6l
	X+Y1xMiIdh2ogjMyRLFvWpXvYKfWhzbXIXcx+gE/ecHNYghmFbyHr1gsGSzyMD/9GDbFPcNQ3rw
	ZSNn952JtHPkk1YdUFk9DZznFxwN7EyKDIiOiZinTXmx0J7ZbfuevpqwqGshMBCxXr6WUjajRyE
	xZSC3u8WP70yQ0K9MgtxYSEzlgI5qTksDRfg8lIXHfe4wkyv4S/R2vxBp2KlPlawCb6zxPi/BZQ
	LymOLl4FArt6klfnb5QP9x4449J6MVla/w9j6lBg==
X-Received: by 2002:adf:e192:0:b0:47f:5710:8cad with SMTP id ffacd0b85a97d-47f622f2a3fmr14665764f8f.4.1784547064514;
        Mon, 20 Jul 2026 04:31:04 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:a26b:a888:7408:fac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm31098429f8f.22.2026.07.20.04.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:31:03 -0700 (PDT)
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
Subject: [PATCH] drm/panthor: reject zero-sized firmware sections
Date: Mon, 20 Jul 2026 13:30:23 +0200
Message-ID: <20260720113024.11619-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panthor_fw_load_section_entry() skips BO creation when the firmware section
VA range is empty. The section is still added to the firmware section list,
leaving section->mem as NULL.

Later reload and unplug paths iterate over all firmware sections and
dereference section->mem, which can lead to a NULL pointer dereference.

Reject zero-sized firmware sections before adding them to the section list.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index a338c4f0a7f5..6335893d3f16 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -596,6 +596,11 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 	}
 
 	section_size = hdr.va.end - hdr.va.start;
+	if (!section_size) {
+		drm_err(&ptdev->base, "Firmware corrupted, zero-sized section\n");
+		return -EINVAL;
+	}
+
 	data_size = hdr.data.end - hdr.data.start;
 	if (data_size > section_size) {
 		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");
-- 
2.43.0

