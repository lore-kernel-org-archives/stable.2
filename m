Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAA043CE6A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976531; cv=none; b=EXpS12zu/L6/ThcRZvRdEQH7VIA1R8eRVnGek+kgNpGPwXjiMRTXQYSzetDfC714vINgvbF49DIHU+TbI8+6ZSdC56XvqmT84augriDYhwQeDAqUXUtCsrWrCbQi7wlNoWw9uk51d5ja4wxgl2dNpy0iX87n+L5BR6VnrLet+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976531; c=relaxed/simple;
	bh=HBE/+kSisSLQtTti9PD0IF4r82pEZs1xT/tQKJlZHgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUNPiTMXHFtsSRqmkTxesxTSbqSeHuV5cWH0Z/S+Hl42fn0K/krelO4EMShU7keOAIRqVbG82oGa+OhPCv0o9Dtg9aztroFU/ekWHVVW+rZWBnjzvZQdOdsL4gIzAMBuroh95CiJMvHapt01PHnPJGLKMvcZDqqldQohdKIn/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDIHpsbK; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDIHpsbK"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8631d0023daso1906925b3a.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976529; x=1790581329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EpPg8uLiGCt1nmkqruCW0RWeQqwd9zjhCiMPftKkUsQ=;
        b=rDIHpsbK0Tl8HpuwCfE4/CmCKps1Zep2g4sz/H9wvWTa8ogLLKX1qn05qcQHaBjC+O
         b6YK5UlXhSxpiD/mqjHdGsQEvp29yx+wBNsDkM/6K0SdUQCIMAd23w+gGwcwAsC4aDfp
         gnCOhU5JhFAVvhtjhmyOOIk9Av8ABgooYYYbIkLM1TTQn6OJUwIsJ0Y++v5vkJZVQNYM
         NZQbNJMRHR0gjevbWrQL09gyOqnOQBKsxa5auG0NcNT3OAsog9GrZejE7oS4mRRtT9Vg
         KtLvAaeSL2OWXwl309uKiTZ23ntLY6OUQ8MYyIxFa/GNiEqe4/TvauISNVCCiJITvqqj
         EMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976529; x=1790581329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EpPg8uLiGCt1nmkqruCW0RWeQqwd9zjhCiMPftKkUsQ=;
        b=Xr+uoo44fev62I74L/oyjjrWNSPsokmUuOcoLNo7snbFnG0XbjWkykCLb1hoe9UL7N
         J4l/MoscTx4P8GMaGn5iWPbKdTohQKTySwTVbiu387kn3ChdjUMJmv3n8nVi9/bQL8Ub
         yor7cw+g7sMMCKQNQatPFc9tKJnM393gZyS7Ito1zOYi+4prSJDJW0T7qXS79PYwLe/f
         d7Q9q+tdCF372oBGJk+7PkDZ0Qo/O3BZB2ezyJQSfxJK7IMrqiN+mSHS1BVefHt6p1zR
         nn+N3gYu/hk51+1DBww09rJaohsq/vJq6tZYO6lXua4GwIdhojm4TafbeBxYX0CipalL
         ZhIw==
X-Forwarded-Encrypted: i=1; AKwUvBzu5JYG28xXI6kPSwc70uA3VCtGEEuk5p5wh5H4ARAylTZabBc6UcU+TVxKnFP90NkvitSa6wc=@vger.kernel.org
X-Gm-Message-State: AFuF++kYF+awQFNnc5C1nU97zEZmI5p+brq/YPQ/7bXCW0P2Nxo+IXqV
	8acabH1xekKg1qxNC0wnA1IFCrifx2/KfV4JewKRv44WGzjf7IqtfZZl
X-Gm-Gg: AYBFou2DPVRQvwSWEqnxsc4oH1Z/w/HUjsAxzQUGoOe1IibpwEZ1qhLnblg2Ex3XVOr
	KA5y9J2JhCIqa9gT6MR2VdYyPRQG0tyAMQKcrth55M7GRUciIbQnMqYvKrspekyBkPcFDfZzuvj
	WjrxXcDAllCxr48SIk0zQ7pqdn8ZA3S6ccaBDKS6/DmPOgXkSfnha1cJ74tA1fGGt34Xn8FLxPO
	n73XmcYtCGmcQMT9bhcDfzG1GEqsVY2OTQUdMGQFAJGSxuNV68yo86pdP2onGKrjYBldtVrei72
	t6ZnKpiDZpBmajR15D9I99DBArImi8zTNNJceGZkG1+HYWlvGGrIdal1ICWDwdAYLRO7VhIYde5
	h3wzNUIuZ0PV1cU2iJRy2IitbVoQZr0U02pvz7qMmxCX9xVlGV0AFQT3wJO/E/Wq38yMbYbzyn1
	fryW0jemgrlYugohyo9pYN9gnC0wiM96rIhgBa1tek7WCohp3r3yjqjXvcNbicXFurFuXI169NE
	ucHT64pATYFpW+4WL0Vim+kJUvBIEpfAd3/XZlm2OWN1ER2ilP2lV1zN5B8jBztg3MXVLeY/8Qb
	Q5VtmQ6hTw==
X-Received: by 2002:a05:6300:85:b0:3dd:a195:dd57 with SMTP id adf61e73a8af0-3dda195e4bemr10090144637.57.1789976528682;
        Mon, 21 Sep 2026 00:42:08 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm3048650a12.6.2026.09.21.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:08 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/4] ieee802154: cc2520: flush fifop_irqwork before destroying buffer_mutex in probe
Date: Mon, 21 Sep 2026 07:42:05 +0000
Message-ID: <20260921074207.2289391-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213639.3316625-1-benquike@gmail.com>
References: <20260919213639.3316625-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cc2520_probe()'s err_hw_init path, mutex_destroy(&priv->buffer_mutex)
is called before flush_work(&priv->fifop_irqwork). If fifop_irq fires
after devm_request_irq() and schedules priv->fifop_irqwork before probe
fails, cc2520_fifop_irqwork() can lock priv->buffer_mutex after it has
already been destroyed:

  BUG: KASAN: slab-use-after-free in assign_work+0x2f1/0x340
  Read of size 8 at addr ffff88800246b0b0 by task kworker/1:1/43
  Workqueue:  0x0 (events)
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   assign_work+0x2f1/0x340
   worker_thread+0x2b8/0xb70

Flush priv->fifop_irqwork before mutex_destroy(&priv->buffer_mutex),
matching the teardown order in cc2520_remove().

Tested in QEMU with KASAN enabled by scheduling fifop_irqwork on the
cc2520_probe() error path.

Fixes: ff5891b266a7 ("ieee802154: cc2520: fix FIFOP work use-after-free")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 2/4 and documented the probe cleanup ordering fix and
  Fixes: tag as requested by Miquel Raynal.

 drivers/net/ieee802154/cc2520.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 5454872..d2c8484 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -1153,8 +1153,8 @@ static int cc2520_probe(struct spi_device *spi)
 	return 0;
 
 err_hw_init:
-	mutex_destroy(&priv->buffer_mutex);
 	flush_work(&priv->fifop_irqwork);
+	mutex_destroy(&priv->buffer_mutex);
 	return ret;
 }
 
-- 
2.47.3
