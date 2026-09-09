Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F184915BA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940969; cv=none; b=uTDTMKGChRpVmNXS75veW+Bt3P/wYXzsswPXkGQDldrmtAt8NxT9iCOyvxo0jiU0cNdJSpyBp07FnEs9bWLCQvycMDN9hGAx+V4FknT5HOnRfgsjhMiIt4CNq6qnWe1dR8arfMDGENsCKOOf7nMahcEDQhELk2NSOHr6/S7uoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940969; c=relaxed/simple;
	bh=3YWAA8EyyaWQvHYB9+jEx8sguYC1c/Rk/Ek41SB4zvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQgP3zCB81LL5upFsEtMXrmIBfwJ+iZhuWaOX1+4uEz0AkurNI9TDsoaW5rUOe2seq+eGX6TZSMtkSM00LdYDk6Sz68DSIbGMoAfBdgE7ZZemdFXPzh0mk2fvv6pi7b2FmkKvQMthTWoUhBNeetzSiWmSd0/hp8PXi1v9pza+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dggHf89A; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dggHf89A"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so44632445e9.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940966; x=1789545766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Jd2hOXWzwdajH7bsxCOPjKpFxW9C26uWvrA4X8i4LE=;
        b=dggHf89A2JAE2QQ/qf6oSrxat+CBfyJ8yFSB6k/DwX/c1wsjXuDV7wtflWSSx1TPHu
         mGT2HBnMXVWZwwWGfHWnbOQCBItXzl0pNb+Ch3FKGuDyO+UUgO0Bhg78ysuWFWqW8duR
         6aXpl1Zff7OZQnCOtuZwQy3eTJo8TxVS5v8Q3yWJ8lYIItCgVDhc8f5s1IhtCYs69fIz
         VYSM3/LQ+oiwtRJsssfPvjkLrQK2wEv4SY5fZDABXtZyHPxS8ZkqVOz+7hl3v8d5Gqal
         0fH9IFJjeI3gsluv+T9NhqysT6HSGlQnZIBbmPvv6oXejuMI/fqN1ajmwbQUHWaXEsa2
         CQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940966; x=1789545766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Jd2hOXWzwdajH7bsxCOPjKpFxW9C26uWvrA4X8i4LE=;
        b=Jo8CtgcmcGzQA2td8bHTeFhHLfiaPVVKEuAKcedqvlzkN8k0v2egKlAi1YNEBRVxGz
         cccxzgMOhSt8h+Yr2IN7vmzgfqBrrm60MTBvwrJ74K6Txr6zwf48aWYkgDHjR0p0ji6K
         qp7Qb41bIvBInc1eT15b+Ti04TiT5kj0iZTUJZ4Em4vhATd6ObcEbcNhr/3TC4c9hfJC
         /77bWVerrspM3Y3Y0Cbp1zfjffIclTtkmMNRylWCgg6sTHHnZfihuj8OO36/jMWx7xK0
         VOJLmcbro21ksV9BBjsaTX+4kDBIm5mEK3GveGdhHUnRyV2UUmfOi3hDe/NE/f6QkHMm
         BJMw==
X-Forwarded-Encrypted: i=1; AKwUvBz+5JgRQ5ZEEfW4C4TrQbQz/qKCg21eA8E4vxvVXgUu/6Md58mh4nGM+uubaUUQHDXUJaFwi9A=@vger.kernel.org
X-Gm-Message-State: AFuF++nMUvzQGbIZCVMTN0JmYwBOqtSwM2kdpUmSocDckm24duLur0Ni
	Z8NDvU9MigmsfkXnWK1/l3hGSbldLExrY3VunWk4c+lmGqa91O0S8vIa
X-Gm-Gg: AYBFou0tCrt+RJM2ftciadr17XG7sM8APBYo47EIWM09Y0FZn0qHb132R6dCyetmW+6
	XLofrKi6zUImuBvjyothhrya/Vk2rH7j3M7MYZ8dyzzte0C5BItXnobH6LvfkLl1U9G3+JRVCba
	NfXlCTSXaIeT2K1eqBpYHyoUIVZTFCKhOrx/+PDjFaUk3GBA79k8XdP2sGxlj4Dx0YrZCoa4PHK
	uvmOSdehv4AW/er6V/GroSziQRcRT6FyJw2LD+kbcn3oFHJC+nYx9R0QU6bJ2/CWtxH3wOcBNFX
	NeuVFnspGd3sCSpR5zJfLhHZ5zBUmxdcjl0CRiz95rxJyALK1oepXAhyA3OTNbaipkp82Nsp2pE
	OoB+Awj95p32j+SxHDeU1U2GBFuCJPjRBtpYLq2p+tp1fl6YvaEfkvHsLuri9sJK9cHd9XVe1ud
	lNVnqdeCBwaKn+c4EfOc+yE46ZUW8D0taMkHnrcCJLq4RUo6OIIbMAuoRDRAo3SXumubPuqUlGn
	M9oe2oDBYb9CTN/8hRC+TU8laXAM2Y=
X-Received: by 2002:a05:600c:1986:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-49cf825cef5mr288664255e9.14.1788940966012;
        Wed, 09 Sep 2026 01:02:46 -0700 (PDT)
Received: from chubuchnyi-ThinkPad-P1-Gen-4i.lan ([158.173.155.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm412817125e9.3.2026.09.09.01.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:02:45 -0700 (PDT)
From: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>
To: sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org,
	mani@kernel.org,
	michael.riesch@collabora.com,
	jacopo.mondi@ideasonboard.com,
	nicholas@rothemail.net,
	benjamin.mugnier@foss.st.com,
	sylvain.petinot@foss.st.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/5] media: i2c: imx415: Add missing v4l2_subdev_cleanup() call
Date: Wed,  9 Sep 2026 11:02:24 +0300
Message-ID: <6a7bc243c8cab077de57fc9c3d6a3d005c110f64.1788940469.git.chubuchnyi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788940469.git.chubuchnyi@gmail.com>
References: <cover.1788940469.git.chubuchnyi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The subdev active state allocated by v4l2_subdev_init_finalize() is leaked
on unbind.

Fixes: 14cd15e7a1e2 ("media: i2c: add imx415 cmos image sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>
---
 drivers/media/i2c/imx415.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
index c3b22b238..12c2f3df6 100644
--- a/drivers/media/i2c/imx415.c
+++ b/drivers/media/i2c/imx415.c
@@ -1125,6 +1125,7 @@ static int imx415_subdev_init(struct imx415 *sensor)
 
 static void imx415_subdev_cleanup(struct imx415 *sensor)
 {
+	v4l2_subdev_cleanup(&sensor->subdev);
 	media_entity_cleanup(&sensor->subdev.entity);
 	v4l2_ctrl_handler_free(&sensor->ctrls);
 }
-- 
2.43.0

