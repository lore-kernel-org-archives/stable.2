Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296F4BF949
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827642; cv=none; b=qiI09v8ZJ6ZxMJuW6haK5stKB4nLmSfnrnYovDALPi3eUJazJZBd54m3ak9mHzhlZwrj9zbawRtHhV3qGkChieiWPPdB2XNosQYeBwXCP7bz3KNSeq9Y/l3N0Pt27o1le5J2YW1dZwrz5+brzArY8iyO0UQlCgNiDNcQvATmMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827642; c=relaxed/simple;
	bh=DBFvf6LMpAJ03sozSIk/CRTorRD2UyaqRnlG5DyjTlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msG6m2Qow+zsUphbNPacSnLrYzz+Zyak1IqHVJir1fmOBagKQKmCQm9uqZWdJwHPa9+i+hrfeHFckYJK5fZ+0UlzdhbF9dYmJ+s9RNV7ouLZqWJEH6KaL+jh1q2Z5tnDXp3nDf2fNPF/+fuJOj9Y4uSl01LTaS5+Xniy2pIzY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ath056ul; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ath056ul"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c14a06c95so1640505f8f.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827639; x=1792432439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QntbKw3gaGgw4tIzgsEy78HK5tHJosqnu2qH2MEsZDc=;
        b=Ath056ulQElu2pL7OPP4nO3E+Lec3aFLH+N2vLFqthFyYDaue5OTKAsRtTUuvEXYaa
         RLJ/JHNvKW5NvnOPzfChosjm9l3w4p3eK0oV4ndDBlwExmNUJYBFc98E+lZoFFeWJ7Qh
         nDNxVJmEllOxQexk1oC1gLL5U9pAaeWlAOJVAwKEWEykERT4Ji48XIxQet6V4jOXGKj7
         FiinpkDHUXt/d5ItO4PVcJ9C+4JWlI8/QivVYOMXzo45R7x9grOtxqiF8+fRuYLFr6Ux
         4qQkiRNiu75/A2QmHt8XBFB1Kq10qXMVxKGumfKgdLtyFUIROsESnzRriAUih+QjDGRG
         w4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827639; x=1792432439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QntbKw3gaGgw4tIzgsEy78HK5tHJosqnu2qH2MEsZDc=;
        b=tVdjKv+r3gU/qrMV2hU30+mkCyUzoV2Q1Gz3p9b5J5JtdsU/fKs8aujbniB7P+OlT6
         0nILRCUf1k7UNIOj8A5nJdq9Y7xl9x7O+97quNiwZQE/vJamk6ndHraKQc1p4k18UsHM
         aJjmzQiER0YpdwH8f3ztQoOzjZ24MiPcM78hRsN97jo+nf1htsTnL+MPSls7ju8h3qrB
         rYVc6X/2WX7bcuDS63BY/Ly0tvymW6W6hoAcQ3BfAKwfWBAZyh4sQ6yhgICl0SlRBaaE
         htSXnjxVOKfn4vk0PT/40K7cm3RY3qlPneV1R3CTxlLs4vI5a6XdFZLWVTznUvUfjIJ0
         RyJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzL1DsFfI0gJxfJ3m54raFdWnL3Qy3Egfbnynq2MuZZ+ZzRM6fBlJB+/eTBDXm/m1yhtm+9Yrc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAmpvt4mAPAW+pvMuKFAzTApn3EjAf7hoBbgRT2un0AqGt9AHp
	Vw5+aBGydkJS+wIV3TCBkeAb1Q6cy/Vqm25A2qH7d6UjskzqvK9vpBT9
X-Gm-Gg: AYBFou22KuBzsrqRYVUZUgJ8EfoXMSG1WYFOtV4lLYq+9HbgKojvQwFX8uJ/N8tfMaG
	IR2GE1f4Uu0VdszRmCooV2CpmQovoCgnHXvWK+T0/5o1JF3Ko2JQEc1Eppvjaqcr3IRot53a76i
	2x/LgdleCH2EuF9jBR5yQyTGPbm3+g4htkd986XSuGUGLIUcwgGF6zARBiPXmVr3cZ4TKoLnKg6
	/feB7plMcy8QeBXRAIPYKg4iFuyzExtBW3LI9t+n54k9E+zES22i7DjD9gT9t9g4mDl6uXo04up
	ZIrjswilJV+xXb+ZTGlxugm2yrnFZ2G+4bSOGQ0SpPMwg97BYgDHTxlHnrZjDP18o3ZvRpDrctZ
	iv+9aCvE1CzHkBvZXaUohKF8qi0VSZFpBIa4NmbCjho+xbploBeD2K/618FTOVQT54ROl/eyate
	1G1lrr5GzPE4kBLQ/z0bxShEG8r5HyRfxut+cJB2peo3/T+p2IdUI4tia8kH0aPrbiAs4=
X-Received: by 2002:a05:6000:26c6:b0:48b:10af:f85e with SMTP id ffacd0b85a97d-48dbaaee1admr18683631f8f.33.1791827638653;
        Mon, 12 Oct 2026 10:53:58 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5af7sm667374f8f.31.2026.10.12.10.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:53:56 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Andrey Misiurov <andrey.misyrov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: core: Initialize modelist in framebuffer_alloc()
Date: Mon, 12 Oct 2026 19:53:38 +0200
Message-ID: <20261012175338.2283897-1-andrey.misyrov@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

framebuffer_alloc() returns zeroed memory, so info->modelist starts out
with NULL next and prev pointers. The list head is initialized only
later, by fb_videomode_to_modelist() or by do_register_framebuffer().

The "fix potential memory leak" commits listed below added
fb_destroy_modelist(&info->modelist) to the probe error paths of s3fb,
tdfxfb, tridentfb, i740fb and carminefb. These paths can run before
the list head is initialized:

 - s3fb, tdfxfb, tridentfb and i740fb call fb_videomode_to_modelist()
   only after a successful EDID read, and tridentfb can also hit the
   error path on an ioremap() or kmalloc() failure before that;
 - carminefb jumps to the error path when fb_find_mode() fails, before
   its fb_videomode_to_modelist() call.

fb_destroy_modelist() then dereferences the NULL head. Reproduced on
Debian 12 (6.1.180) by binding s3fb to a VGA device without EDID and
forcing fb_alloc_cmap() to fail:

  s3fb 0000:00:03.0: cannot allocate colormap
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:fb_destroy_modelist+0x10/0x80
  Call Trace:
   s3_pci_probe.cold+0x12b/0x2bf [s3fb]
   local_pci_probe+0x41/0x80
   pci_device_probe+0xc3/0x240
   really_probe+0xde/0x380
   __driver_probe_device+0x84/0x150
   driver_probe_device+0x1f/0x90
   __driver_attach+0xce/0x1c0
   bus_for_each_dev+0x87/0xd0
   bus_add_driver+0x1ae/0x200
   driver_register+0x89/0xe0
   do_one_initcall+0x59/0x220
   do_init_module+0x4a/0x1f0

Initialize the list head in framebuffer_alloc(), so info->modelist is
always a valid, possibly empty, list and fb_destroy_modelist() is safe
on every error path. Keep the lazy initialization in
do_register_framebuffer(), as drivers that embed struct fb_info rather
than calling framebuffer_alloc() still depend on it.

Fixes: 3b0ed04bc852 ("fbdev: s3fb: fix potential memory leak in s3_pci_probe()")
Fixes: bb019d755366 ("fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()")
Fixes: 7a35ec619d9a ("fbdev: tridentfb: fix potential memory leak in trident_pci_probe()")
Fixes: 5936063409af ("fbdev: i740fb: fix potential memory leak in i740fb_probe()")
Fixes: 6fcca16a2b19 ("fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
 drivers/video/fbdev/core/fb_info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fb_info.c b/drivers/video/fbdev/core/fb_info.c
index 52f9bd2..05988a9 100644
--- a/drivers/video/fbdev/core/fb_info.c
+++ b/drivers/video/fbdev/core/fb_info.c
@@ -43,6 +43,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 	info->device = dev;
 	info->fbcon_rotate_hint = -1;
 	info->blank = FB_BLANK_UNBLANK;
+	INIT_LIST_HEAD(&info->modelist);
 
 #if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 	mutex_init(&info->bl_curve_mutex);
-- 
2.43.7

