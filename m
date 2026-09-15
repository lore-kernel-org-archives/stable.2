Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC3C2BEFFD
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433575; cv=none; b=Yrv0G4fB1yM8P8pOd7U+Nm+bWmMfcSYcbcIoeunzPc8m26nAGqTWAifIOI5svtKyCfD4Fu97yr8F8SHwgx7s/fP8dheXGkqMOGtxpYjezX1QhVNl+3TiRh2cM/U0SoOcWWtkTodhIpXVZGsMVm4UVVB3RCwBiHgqLbww3v4cf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433575; c=relaxed/simple;
	bh=E99Dz8Xkzhhbw+xuuQIQ9G+/9ex1yfLS64o2aGg11Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fsOOjoyQ1z0zgNhpLgb2SKhNhjFm2iAAf30NuTg8RM1KTlSYv7giIGwtoamcez14Fn02KZTdDXJE9aCSOfOCY6+kJHEdacuO5VhKys8bODO4jQxZhcsikb/lekG73GSPqCr3TtQKPdPHo9qbZnIG6sxwlm0yPXGeAB0CMHmSOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1CTYEDm; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1CTYEDm"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ad2273so286259285a.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789433571; x=1790038371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3FqhYN8GqnOvyCCd51Tqy0N6wSmRpiZ4v7QBDM0Zgas=;
        b=F1CTYEDmcTExQNcdaz3vsmywKGilJoxn78ItFjbED8LVZnB/4daP0tpTU0Bt/2Yi49
         xvk7Hca0PAt8yv6cMTjSEHKNBHzcHlMEnRF7L2vel0P4e965YE7lKB2mDYs5Ij7ZgAs1
         +BcQOK0Jr6yfZruAEyKQqdUMXIrY0n5Hii9yc13N6Px/BCvZHBrQG6xKRSxf6DGyUvIw
         0dS9yFjlmSIu7lmpV24v68MNTi4iRBAVc0qbT9EvtxnRJlC/SazFqk7RxYdOBzb5haFp
         DH9nrawo//d3JIT2Gbf9L/raZa8jKkrydYO2yAQHCjvYcP3b3rGLSGedcpr5ld+SbDVS
         /40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789433571; x=1790038371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3FqhYN8GqnOvyCCd51Tqy0N6wSmRpiZ4v7QBDM0Zgas=;
        b=aAFTBp4FeAZm1JefF4wlH5kOkJRnKrKbam0DNoZrb8x8Xrzl8py7jSF/5Q0me6Lp/l
         n50+SIwPOXEcaJQ6SGVU6LL52joUtyLzNRgvd3zmxmWcyZRdn+Uss6TBqsy1lfa01TCw
         iD6JueHZskzbatVwQMhxXDpDfI/zJK3MrYGhV9vxwa6j5jcKZpZ7nGoHNnqqsrYYjuEF
         tHG+zPmXUsydU/euowhly2pFiLB3K4hpVWd+NrfDVT6UgPnKKK4TgEeUEs3IZzOr+mcy
         jg0czdsx1X2bdSA/PWliulsHWkFEkZKcYH23XCDuWzGNocxFokl3cwEcn6WEwdt+bjAb
         UDeg==
X-Forwarded-Encrypted: i=1; AKwUvBybWTfjOJ84M91HnDUQrSwlT132jE5xfxZkU8WL8QtUZruEF1z3brbBdQ1NBt00LCc5vEBFNR8=@vger.kernel.org
X-Gm-Message-State: AFuF++mQUJIIbJ4YUJvW2TSitUg2uU6W2RSE3yn4cz1MOi3SB7uVHMOH
	gvMAHoQhnMKkxZZU+95V8wE5DhONvXzaxeXy8aK4UfqsXV+8eaq4DtE=
X-Gm-Gg: AYBFou1KljcGrs2KjVdMH8h2asXdQo1LrEVNTthjlpcUXtDL+Lm2a+NLa7wPlReNgqL
	Idl/ip9GNkJwoIYEt0KzKrbJgHNqJqmstkWwxgG2hDwn3Zcic/S2+EqwgoZbBXi/q9P0VgiaZWY
	1RqSR39eriG6U/aaN1dV5kXz/l7YFtth+LMsQr4wKDH4o7thiasuWTFizYXrNcgzjvGj6jXql2G
	/GF1YL8Mu08BGANYpmoi6RoAZBAsuHYwJ059foFY2tvu5QWB/j8R15GSr5QDGbgzKZVYUeslBo+
	5VAD2UuMDZn9c+8+P6IFmLcJPl/0wZotroFF71b1UZ5e0cuxPZFlA/gRkBsuEECjMQTRUULMqAc
	/MpTht3V6494UMh+DTKOcaTNbrwUkLzzg0JLX3j7rNVGaLr2MD8xYbqpWW+6lZbRX7oBBv+mlRe
	dASKbAY/T1b1eDP8vWC1s/Dp19Vd++qL2pDC8P86cm8FMjCDsjqZkr3sDsNeWZ6Amsn81v6bPoV
	kYMucrnXQMIQ8Gtg/rY5TDkupSCF5kIA6qCwfmKDpWHNsz1x7fgZVIGOcsfgM+kvWTvKMsC87pJ
	CZyjJkEG8DM8Eso4J4B96VGJ2xP5wKiRMwM6DcBFSE/42zR7VvXc55yoVx1ysi0G
X-Received: by 2002:a05:620a:468c:b0:939:d913:9a74 with SMTP id af79cd13be357-93a29bbcd86mr667300585a.46.1789433571426;
        Mon, 14 Sep 2026 17:52:51 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ecea9f35sm1063205785a.7.2026.09.14.17.52.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 17:52:50 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: kyro: Release WC setup on registration failure
Date: Mon, 14 Sep 2026 20:52:43 -0400
Message-ID: <20260915005243.51683-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If register_framebuffer() fails, kyrofb_probe() frees the framebuffer
without releasing its write-combining range. Release the range before
freeing the framebuffer. Earlier failures still skip this cleanup.

The missing cleanup already exists in the initial Git import, before
the conversion from mtrr_add() to arch_phys_wc_add().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/kyro/fbdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -759,7 +759,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset_io(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_free_fb;
+		goto out_free_wc;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -776,6 +776,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+out_free_wc:
+	arch_phys_wc_del(currentpar->wc_cookie);
 out_free_fb:
 	framebuffer_release(info);
 
-- 
2.51.0
