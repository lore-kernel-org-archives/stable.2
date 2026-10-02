Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com [74.125.230.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9651361946
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970494; cv=none; b=Bts2XKh6/9JyTVRI8lbyDt/OXhANjOzYsXLs75m/yTH0Jh3HXYBSWzu8kKswkpRTDuVGmiqnOP84gIn5w1uVLFsn21OqVOYF4bYwG+mZhWtuBxTeSoJh1XvaMvqNw7ueTr0ExQKTkOfgykTbqX/uUUW93/XMmT3lig/yb06YV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970494; c=relaxed/simple;
	bh=0f4pSX5e5iV+0wzPJz6P2GOvHgiOqk97QfB4FM/4l+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMJOUzgtQ/msoi13rTpZTfdgu8Fv6lzSUsz71PmwtU7h/0HYV3jCQS7cjEs2Y3C9+v64kT4JYKPlmbRPGZ+HwVwlVRrFZVEwT2V2CKQD4GOc90a8lUTlykVngyRDgZnnUgOMFVOENSKGeIMxo9iuHFpL2lCXILzUZGwPanigFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSOccKWq; arc=none smtp.client-ip=74.125.230.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSOccKWq"
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-9144f89ce90so3334366d6.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790970487; x=1791575287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=peEOtIWNssxYKrb8NM+ypkApXFH2AI9AHn+rEkEvysE=;
        b=CSOccKWqnAgYu9I3LbKqgJOhlCSgdPJbm2JbIZd4750A7O4ku3tMsa39/I7+zLrwHu
         dJxuF6TrGUHlEYj9hSdh1FiXf1rP5X9A17BlFzfA3D3svtFBlRTFwIYuR1Br1ttxqakp
         T0opZWoukLIyqokeVppO8C1QFI2hso80cn1vWh7nq5HT/lKHpTUsS2CS1mbGArXDv5/J
         8dcUYw3fHnQqE31YbjActVw8FXIhLiEst1mM+ilex5WW14zzKGd3ty3tZL7MO91bPb3r
         BmXg4ZG836j6BdEfr7uHmH3heUM1hpOu0LJ/fRj30Kjz3u2CbvOWm6WUiPtfOjk3NuLi
         7vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970487; x=1791575287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=peEOtIWNssxYKrb8NM+ypkApXFH2AI9AHn+rEkEvysE=;
        b=muUxV0n5tH00UbTMxOKZmFNTUeAgpY7jcxbCUIvFnnVNdfgl/Al5mDLI3eo0wA/ns6
         IuSs9eFmk0qEULcVqc7CHyJO41sRjlu0xuzQYBLczR0zj3AcDWuHV17A96JOuZouAV+6
         Pz69wXy4bAezgNMTcL4omWm7y/N7NPgNzDeStbrKL0n2ZYqEeZHn63RfkPZatOWMB5oE
         uVSTspF2BAZDKVVS+NBqCz+dNVAcx3u0QeiC7qdt9pWqT+JjPcSSR3y/yX2UFJKFhzfX
         qC3OmYrYZESW3D6yndYSaka5aZ1WRpJG/seVnePHGu6/gb9Ce5bHpCNPd9X/+tmBQAEa
         Z7WQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkGFkLkJEceQDmsoAa8SOO5/Uv4qbaFhTZdYD13jHNIPMxQEa2QZ634ionBiyB+9PcGv4+QGg=@vger.kernel.org
X-Gm-Message-State: AFuF++nzinZ/F8u1JkOQKMzQNdroFT/TnwS7HiYqaIisqjVxGIXu1Sss
	PTORMJOeFxxh9egd6QwT13oE50xv861cQpuR/F8/79tsxqt41CC7g/U=
X-Gm-Gg: AYBFou2DUUPcwam7wQrO4n2jGzpqdXjC9RN+On8tSADTfRLPYVydFbUZtgfq1lkPZjC
	jP9vlg/2Y25TeqXDJtoTk/Rgy9GJeB8coGLf8W7SA+3ibzqxyZ8a80Df68utywuZ0UHstzXKsgG
	HfQ5g8L619rSdwkl4bkgry3dQgU3bt26IZeFpqxH8Mff043l+ONs50IV/nJG7hMfqOtJ/0YzuYQ
	i5+Fpqpsz1v0+pziQij33KpF6jd3rUN8t5eg5hjk/FeFIh3EX4Hiy/lv2eZH+837BXVzLRe3GEP
	86SlqKYivH3dbqixNqAse29EFqOV7cBCn2oTjRrsVdPRjpfh5CYfoXM4ShkVU4J3AR4ZnUIydDt
	nms03SxVWnYw4De2QTorxEps0VDT4tSX3WpWYCQ3QFRVyaQfQQOsKXklqK7GP8gOWxu6C0y4suN
	z5ROklZhZl8ME0rBoMeUV3IFuwTczdrCjAT5l7gX9fYoT0U3hwN+Lw1QqhFzZ3yAl7heyF6HQIb
	r3vL8IZvvLjgMnUJpQ8X9mVuwnUwr09UuZ77GttrLDftbd2y8OSSa4AguWetSHdTSlQ4TiRTHSE
	KOHuOufQ/VQM2VPaOZgfcE7QCI6a
X-Received: by 2002:a05:620a:4052:b0:93b:db80:e0cf with SMTP id af79cd13be357-93cf1a393damr685608685a.60.1790970487600;
        Fri, 02 Oct 2026 12:48:07 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2ed5e2sm296846985a.47.2026.10.02.12.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:48:06 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ijae Kim <ae878000@gmail.com>,
	mhun512@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] soc: fsl: dpio: Fix cleanup on IRQ registration failure
Date: Fri,  2 Oct 2026 15:48:01 -0400
Message-ID: <20261002194802.375497-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002194802.375497-1-mhun512@gmail.com>
References: <20261002194802.375497-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IRQ registration happens after dpaa2_io_create(), but its failure path
only releases the IRQ resources and the MC portal. The I/O object stays
allocated and published in the service list and per-CPU lookup table,
while devres unmaps its portal registers after probe fails.

Call dpaa2_io_down() on IRQ registration failure to remove the object
from those lookup structures and free it. Reorder the error labels so
that a failed dpaa2_io_create() still skips this cleanup.

Remove unregister_dpio_irq_handlers() from the probe error path, since
no IRQ handler or affinity hint has been installed when registration
fails.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: fe8fe7723a3a ("soc: fsl: dpio: register dpio irq handlers after dpio create")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Remove the unnecessary unregister_dpio_irq_handlers() call from
  the probe error path, as suggested by Ioana Ciornei.
- Include this fix as patch 1 of the two-patch DPIO cleanup series.
- Add Cc: stable@vger.kernel.org.

 drivers/soc/fsl/dpio/dpio-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index d5198ff..8d31346 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -244,9 +244,9 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 
 	return 0;
 
-err_dpaa2_io_create:
-	unregister_dpio_irq_handlers(dpio_dev);
 err_register_dpio_irq:
+	dpaa2_io_down(priv->io);
+err_dpaa2_io_create:
 	fsl_mc_free_irqs(dpio_dev);
 err_allocate_irqs:
 	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-- 
2.53.0

