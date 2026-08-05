Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457DB3FF1DC
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924109; cv=none; b=dUv9SGn/IFIe9GKmGc26j6dCD5RKw0FC9Sw8CERlNArp+PhJszgJ3sUC7XHpjAt7UPppgDelEFku80vBdTRhvYooog+sWVXfdR44t852fc9Q2FGkbo4QUTSJeK4ZE/RmmvduG6K4kVUMnc5NqEQfEWxnYeROBluiuFwdkOYB5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924109; c=relaxed/simple;
	bh=+qT+t8J7JMGOegi9oh4bKCVpPiuuhIEnoiBx9me7+Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+nGK+8PNZXHs2qyFQPJRpknIvjh/PM0Fo9WjE8rMImUIo2htRWMJGhm19yNb4iVbgH34KKTnSLuv3XUhI3ceksiBqMbZq/edcj6/Y6+/fVw4vMiefzltb9pDH528JjhocRL97Mf6rxswhgtkO9SLDNkg9TG5zaH9MI6+a/qI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJsG3KzU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJsG3KzU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so7169705e9.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785924106; x=1786528906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=egdlNU3NVgRD08dI5V72nyvU+UH9dXnlAAmwjEI5qno=;
        b=EJsG3KzU85ktMGlhsuKG2qgfXO1qHRn9OiV0x85eBg8UJYgZDbpfodbKXxp9KbuWaj
         Rtye8QisE50IPFc/tJWD8JH1Flvy3Ce3sEtN991FYaCEqB/YmEpW6/KmP0v42fNEpT2l
         DAVj0ySf35NSU2vfhhPYbOh19skTcHpwmlxVdmMo9qe7pbp/BKjouc0SxgyM3TSjAZkO
         8PI+ZmGppidQeLuCHTMXB2Z0WE59lLT2VLM+6rh+DJw3+r00rkCpDlQc3ll+TqZHDF1a
         9ykpq3Zf4xMDmC5iIbpgFGHKpyqO+nMuYE6sINbMLGNAcz0Vrok3A4DuBPCiLM1TfAYM
         DBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785924106; x=1786528906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=egdlNU3NVgRD08dI5V72nyvU+UH9dXnlAAmwjEI5qno=;
        b=fpQAptK8cULtnRnRbJacH90lzbSChJqR4T6U2r7HYdF7VNsQ65kd3Pl4ty2oI1VLEr
         61TEroaRNgc5fUaadIgZDNCbF4TgVvzeiuiIsAApE5PlKR0YRxVhqDoCfIT24+uztE9n
         zPPd3E47kqBKBNmuiDcaYWLldhkKS3C7wcXFDyvccGC6Xz0i80QoxaUpUO2vqqwe32kL
         thsHmHyhjdIk2dcaW23wueJKO0BV5HgejYMoLkweXMkD1auSa0oqkqu3xT5e6nbJ1yFr
         7dHgjwunlUINneYkZYb7yYMsNS5g73Dk/JQXd4GBJJHlfpwTV6/N6PnnnqwdTv8jYQD1
         6Tmw==
X-Gm-Message-State: AOJu0YzLFE2LVTmdixEWky/jIaS6fupScRTuT0fQ7D/IJ0YX0+tRNkZL
	1PUia6Lx683YhtjHYXB0I2LKGDyA4zehbJe8qzofT8i6WQQOzMQT+c/H3PclJram
X-Gm-Gg: AR+sD12Zup2y3/lvaAiaf5o2pgyt1PkJ3eMv0wNp7gSlgyEt7npwgtx6IZ0kg9hI0M8
	8GYZ6xt03gp/dVnB3GFC/X9Rp8ekI+8gjzgMpojuCrVV6GsochOejPxKK/Jzhn0oX7Nvgbw36Nk
	RjAk2UMwWaT6Pvj7ysXM6kaUeYX6hCvugxVAC10UJH5DLtXyPJNyj0j2UaNBsAoDVRSQQFkD1BR
	djxxWRKO0QDNR21hsj+5sQQSi3JdkRGYbIIc9dMupbdBGxzMQjFKb14mc8mt2w80ADq/yXX4br7
	RyhK3U7ozU0EiYtCtg8oE8gA3WIrwRfmjGQPXygWt9niD6+hFO7HXrG//rM9/8tKFGGKCOLjVaA
	yxVE9Nd+Ny9Ev/H+PyakvPFr5ZDJ/RwjSfI5kuiLoqnlT2bLGotryL4O0stqfE1L9V3iNynqrwP
	ycQBjxj2veZG4x+lapICCmkGYwBMtjjO/zXdqgtLk6zP56Agaa4MccMgEaP33xBZwkzwag74PAt
	0nu
X-Received: by 2002:a05:600c:a597:b0:499:4d50:7230 with SMTP id 5b1f17b1804b1-4994e7d9c03mr39020955e9.18.1785924105995;
        Wed, 05 Aug 2026 03:01:45 -0700 (PDT)
Received: from arbab-X395.dbs.corp ([110.93.227.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec249a5fsm7344776f8f.33.2026.08.05.03.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:01:45 -0700 (PDT)
From: Arbab Haider <arbabhaider649@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Rosen Penev <rosenp@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0.y 2/5] net: mvneta: support EPROBE_DEFER when reading MAC address
Date: Wed,  5 Aug 2026 15:01:33 +0500
Message-ID: <20260805100136.59101-2-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805100136.59101-1-arbabhaider649@gmail.com>
References: <20260805100136.59101-1-arbabhaider649@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rosen Penev <rosenp@gmail.com>

If nvmem loads after the ethernet driver, mac address assignments will
not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
case so we need to handle that to avoid eth_hw_addr_random.

Add extra goto section to just free stats as they are allocated right
above.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260307031709.640141-1-rosenp@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Upstream commit 73a864352570fd30d942652f05bfe9340d7a2055 ]

---
 drivers/net/ethernet/marvell/mvneta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 22da95d46bef..744d6585a949 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5620,6 +5620,8 @@ static int mvneta_probe(struct platform_device *pdev)
 	}
 
 	err = of_get_ethdev_address(dn, dev);
+	if (err == -EPROBE_DEFER)
+		goto err_free_stats;
 	if (!err) {
 		mac_from = "device tree";
 	} else {
@@ -5755,6 +5757,7 @@ static int mvneta_probe(struct platform_device *pdev)
 				       1 << pp->id);
 		mvneta_bm_put(pp->bm_priv);
 	}
+err_free_stats:
 	free_percpu(pp->stats);
 err_free_ports:
 	free_percpu(pp->ports);
-- 
2.53.0

