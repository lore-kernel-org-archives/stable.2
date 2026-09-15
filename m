Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951437B020
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487858; cv=none; b=uDw3WY02Auay/mWvVc3L1jNyYjGvpj270e8Mvcr90dqKSlkJE+yMFG+1winCyQMsfxXH2m9lRCXljRvLYIq/se3tOCjuRRswwOoiPNTz35demtw1giGj/gPV9Vsy7JRv7/jzVVZ1lUui1qtSr4QIgRpRq3yPVwW/Bb2lIg9id8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487858; c=relaxed/simple;
	bh=BQH8DG9cXM2qyitTnaemtdDjvkCOw4DpAj8rKupk8Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3scrp9omaNtR+GuK1lm3fqbSQzEsxkUoW1uJEI5l6YWE6QIATeDV8NQ89eatNvmx61/kiXlxpcQg4/xOfZ6smCaajo35BeQg9F1GSydYEGFRre2SMY9xDYqUoZbfqLJ/+I7HQ1FcOlV4LiYQ7CUeN4LwYZlXp2B/L0DxMJT0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JROXrAbp; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JROXrAbp"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so369670a91.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789487855; x=1790092655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ILzJp0HcdxQSJ479pMFuJv1IvFsGGJOreZGmnfEmkRI=;
        b=JROXrAbpxlRJ6IS1QYjbLxvqSoog/xl+JKLK9fLaZR/q1eCm+r3n0uUH/QqNpbpK2D
         ScspcO7PqF1rSNqP71+qzahgrmY0FLD/GvFuJoucVXbuo2rNICuKA45qz7SGQsvbA1Ox
         l3dMhLpu3t3ubw45u9HrZqTl1s+Fb5v+Z2hx4kIJLTY6Awpq138R+nCHtV19yN8MY9TH
         r0rehdXKjp0svHK282iwSYXFMH7UHHrIOlAvvyeotbqLL3WMtKG3UK8DBQc+kqzkbm/7
         tB7AsxNbY/uDs3HI2oujGJhb8FKGbY71p2imT7/rXYEO9aLgu+DHgJLn6oBUzbWL52QN
         geuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789487855; x=1790092655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ILzJp0HcdxQSJ479pMFuJv1IvFsGGJOreZGmnfEmkRI=;
        b=kVjbKcfZuZdiZNdU4MWU7rKy+5KbPaJOwctuitzy3RV+234uV+ds2MZCB4QyGUvvP2
         iI/SBhZ53gE776vzIqjgBR5ErCigEPhedJxKaTsIREyp3gfy4JjSHCQncxj2jzrcqrpU
         USMBP8Z9Hs+uSDcsTF69zM2ULPpDiMX4oLvRM7jPIQV8/uLQy3eCVTl99rxsl3avuNBq
         3xOkTJvJnOTMlHD9kxcL9Jcm1O0uJDbTET1Bwv5EOXmEb6BOr9O7Zza2OjQyke5boeSb
         LdpxKAJgMbBOzMdORZnvuuqxWxBvz7bgCljUHHBcl4EosIteAuJXZYWt1agrYXcyXUvI
         uJXg==
X-Gm-Message-State: AFuF++kZYz5scgcM0tVFzgXGIEKvbD9Lz3auv5InwDuD++0hRmltQMBt
	UEoNhI2ro0ZqRWlRf9C35NS0ZDQKTSFl1YQxVFZLFICFt3AeWDDRlTZX
X-Gm-Gg: AYBFou1y2/H6czcCbxNd33hnwO5fGYi7dXFECLWRRtw6P0EI9HXKlZZ2sWxLse8dkzr
	FfZ6TIpWonQOw/+7unSDFip9tc1bxM4cYiwbLOO6ib7XbUEj508H8C6CSNBhwytlqru/XAgseGX
	0+XzgKv+i/dPHHlOPnZ+QINxPR9V69ui4X5XsKfieaRQvENy7tdh+jcSBHovA2c2o6/o1qFkKKd
	uCx8QwzOU5W7DHzCEOE/x6UW9aan+h68GE8cJEEOuS5nITJNhdVuGgNbKQl6CJ2J2ZR6uZskivB
	8hS9emMP23eFyvY4r3d7Gf9GDEoIDXVSsFr1Qto2riHo2DeTs51918RDxeeK9ylUlPfdOyCoSOx
	+3NkpvNOPCrSzBywzBxQ78tIxuxez1lndouPAqnJJH2df3s9pl540IeVkpOx50N78X/s9qOnF4E
	NFBK75Ex1iNsA4CE76rurRhlFoPeNNtuJdDNQy6pylIzq043v8Quwafw==
X-Received: by 2002:a17:90b:17c2:b0:39d:c3bb:98e7 with SMTP id 98e67ed59e1d1-39e10c8ab98mr2856143a91.6.1789487855327;
        Tue, 15 Sep 2026 08:57:35 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm6173004a91.10.2026.09.15.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 08:57:34 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	David Daney <david.daney@cavium.com>,
	"Steven J. Hill" <Steven.Hill@cavium.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] mmc: cavium: destroy slot platform devices on remove
Date: Tue, 15 Sep 2026 23:57:24 +0800
Message-ID: <20260915155724.2468892-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

octeon_mmc_probe() creates host->slot_pdev[i] with
of_platform_device_create(), while octeon_mmc_remove() does not destroy
the child platform devices.

The probe failure path removes each MMC slot and destroys its associated
platform device, but the normal remove path only removes the MMC slot.
As a result, the child platform devices remain registered after the
Octeon MMC controller is removed.

Destroy each slot platform device during removal after cleaning up the
corresponding MMC slot, matching the probe failure cleanup path.

This issue was found by manual code inspection.

Fixes: 01d95843335c ("mmc: cavium: Add MMC support for Octeon SOCs.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mmc/host/cavium-octeon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 1bfc1a4f9fe9..671dd1a36a74 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -295,9 +295,12 @@ static void octeon_mmc_remove(struct platform_device *pdev)
 	u64 dma_cfg;
 	int i;
 
-	for (i = 0; i < CAVIUM_MAX_MMC; i++)
+	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot[i])
 			cvm_mmc_of_slot_remove(host->slot[i]);
+		if (host->slot_pdev[i])
+			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
+	}
 
 	dma_cfg = readq(host->dma_base + MIO_EMM_DMA_CFG(host));
 	dma_cfg &= ~MIO_EMM_DMA_CFG_EN;
-- 
2.43.0

