Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D9370D5E
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856098; cv=none; b=J7TYEhcFKCI2Di2x8DMJSFexf8TvZvCQz5NMaTFs5r2dfEGnxQeTmvE4LhZgAnfQqCahd1GsYJYyrILjczOggy1x3WzxnePHUFrQyNtXFS4XukUR1f1fqHV5VxcVExDmc9PEcZP+jtqzkTxoQH8vNNh5GEPS+VO82PdOdtkQcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856098; c=relaxed/simple;
	bh=s4p6juCwQ475aHXTn+wYPeV0BPHhmlo0G++9AOmJWt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inWIZXYpG/BRT+VSFIcHXhJvhcwPLyHEjb4UewhksSUScMHt+M2+j49SPM1CHfQGqxP2K0TS7vzWyg3rIjbjHOvWgZqmvkspoh8io96K40TEedjDdUCobUE8hCx2J/ucBi+Un2Gki/URwJ/D/kSaNuAuuQNjIaYxEsVBLEDzEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVV2WGgI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVV2WGgI"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso5654656b3a.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785856097; x=1786460897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4Qg2o+emc3m6rF47B2E/svsOXDIcQrkgOFSzKR4MaY=;
        b=UVV2WGgIHTSiMeZNrU9W2yknVXj9o3So2xx4hrGTg6MxxpPy+L0tn+W9hYNRD1RklW
         CqfpX/D+bbvq4MfN1Np4736CFVPA39RctRFcXJFpI5JXlKH0qpvZf1hih0Vlgo1AzSQz
         vDmej0JKt94+tD2QqPvTNT6s907d0bCZv1fw+UwTyCiMCFc4C3oLoK9Yv4tsAlA+qwFb
         v+5/OpjS/x/Qnb3cv7SeBdzp4hX2raNlxBqbt3A6EujgbEJTQ3TzcnCjabdQM5xl5gF5
         3EAz4JYseuxhVxjWSTfzvucR0lgT1HO46cjpIVVviUfxcxnu5Du8UBiequFUg9MkVM0U
         gYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785856097; x=1786460897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S4Qg2o+emc3m6rF47B2E/svsOXDIcQrkgOFSzKR4MaY=;
        b=CKFBh4JLTPXHhhOV/cTlw4jmANqoDJppDTbIDUg8XxnhQTjUq6RWDrydPa0H1mmpBz
         edV64rMYnLYPdp9y6FWDqP1XE+ZqsQPYlPWp9SyOPdquDja5NYvNHhIwN5ym7Dv6Jy+1
         OnI+ofwVhDT1EKhoKybB25EPowMxNwlt6zTMDK220pC8+dJIa9aPmAzyyu4zHngmNfg2
         87iu2y0LlZJNGOez/7GMRRdzI7Ge9AlEc0bULVmg3/5RIPsQjN3skcAVOC3Ax6cbY4WI
         8frMrZcreKNxWWX0smUk8nGi7Dx16z34AFxmQurujB2VGMgQ80YV7PvFSDc6sSCE3Zlh
         KVdA==
X-Forwarded-Encrypted: i=1; AHgh+Rrw42lh6og0HR1oEctRgYcrsa6jYwiuqbC/dDY/jdCOn6qTX+Yj2dn4Yo4RaBaZDQTylip5SLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf6Y087Yia4+h6JYCAn2MMwtYq2m3Zh8X6XDIyidEBqngZS6j6
	k0negTXj9ivd/S5nnLuV0tOXEkqlkav7TAyQs/fT5Nz7QKTTBIWVyFU=
X-Gm-Gg: AR+sD11MNhY6dZD+I1R/yN4Zr7OtH0KQWIw/kqedXeRNBn05bIPS5o/ykDFvRjAzyhR
	K5XYWli7VJzrm8NXmmg0JW+6cZqQrMzFTlq/Lplfn248Z3ssOWFA1jsvbWgy04PYvmp15fGPgYV
	jnFn2glO6DnRJEbGYqbUsT9H3XLrHxVQXi6EagOd1MwwOFNh1qzuPmO7WwImvaNKFDh54zRUA1N
	tcoSKfCyBJ7waxsbzI4LlhBdOguk/n7rdGRgrcOE5992L/EGawaXCXAUeVK+qxctjYuRghQSo+z
	LdLwZn5T9mp/wQBJJL1TFyZT8QhP6hTGs4uinPpV13NiqymfFE8YzzL6BQOsYKtxE8XaG56/GoO
	hxPhvExzhmwC2bEH7TehYURTwcGhM7BpmJ7JWGdTbE8DuCW8Mt7dNfHG/yjKwll/42WwbyC/hm1
	crvPcqHRUfC2dt/eIRT6kf/WUv2FEvOCYIy2VpItzxedc+cULnaPxxLMUlezHibwz3fxGFt9qs0
	/ahdoT3Yu4lF7GmXnz366NnJnZDzeE4BsNsGDqTwWx2+swKaAyyKIzvmvp2/Ku7xoFPL8AV5JtL
	iv0TRuh+PQB9VQq+Taklog4=
X-Received: by 2002:a05:6a00:ad1:b0:845:4126:222b with SMTP id d2e1a72fcca58-84ee47d8768mr14159742b3a.28.1785856096851;
        Tue, 04 Aug 2026 08:08:16 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc41ca4dsm5420587b3a.52.2026.08.04.08.08.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 08:08:15 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] drm/meson: clean up KMS polling on register failure
Date: Wed,  5 Aug 2026 00:08:02 +0900
Message-ID: <20260804150802.45262-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260524160657.17802-1-mhun512@gmail.com>
References: <20260524160657.17802-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

meson_drv_bind_master() starts the KMS polling helper before registering
the DRM device. If drm_dev_register() fails, probe unwinds the IRQ and
DRM device without stopping the polling helper.

Call drm_kms_helper_poll_fini() on that failure path before freeing the
IRQ.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Avoid the unused uninstall_irq label reported by the kernel test robot.
- Link to v1: https://lore.kernel.org/r/20260524160657.17802-1-mhun512@gmail.com

 drivers/gpu/drm/meson/meson_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 49ff9f1f16..bcc36f2cdc 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -351,8 +351,10 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	platform_set_drvdata(pdev, priv);
 
 	ret = drm_dev_register(drm, 0);
-	if (ret)
+	if (ret) {
+		drm_kms_helper_poll_fini(drm);
 		goto uninstall_irq;
+	}
 
 	drm_client_setup(drm, NULL);
 
-- 
2.47.1
