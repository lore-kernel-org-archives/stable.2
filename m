Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1C48F00F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940965; cv=none; b=bExIseLOeHMuiTTS316BFJzjyDCqb4rp8/+FBjrMVTbyS/pubuLKoxekluXD6MRHE9OIEl8HiP8Q/XbLPxL4A6bQ/rE2Da+xofTNFgfhThn7BAfIk+fxICnVb0eWuLMUwR1rb9razuCvjpf6N9d5Kg4+ZRDXpkQz7HBw7A7uNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940965; c=relaxed/simple;
	bh=Mvt3ZfbxN2EZTNrZNa1t1/S6/6X9opcfGpDnBhE4aVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiAwaeQJ8Cgqwz/FXpr026AVWRuTmaMGd0DUOIXqAyaMXORrxvjA812RXVskL4Vkz3suVdhAzToGeXWiQBdMi6AUNqF0Pl+Ceetn98svuihrzDAol1t5sMymnfkMzemZmWKY2PmdGG0DUSXh5/gg7Iih+GjqO7cIzIIX0s0fbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oyFmBC3k; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyFmBC3k"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso59895035e9.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940962; x=1789545762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LX3djUYrG1AMjG6o/03rqJKEBPTLs3HZVWxqrxj6VsA=;
        b=oyFmBC3kOE5nuRzJoLpNyI04H/D385mXSfILvhN6hrlVl1qTIUdI0W7TcMM2oH3kFB
         SaJuF0oJjzws+ejJlmeAPx0iiIjPq0RLSgoAUHpCY/TGLmIiAkKQl9DmaZfFTTBxIHKV
         iB3Yc6RsmD3y7y376iaCVFITXbQmZoUXb5vYV6uhzneHWkugT9leNwGczJlDceLn39rc
         yfCqZ4SCSecY8AaJa/FKGrnUDu3USntz11ZAt3N9f4l9xgjSPpGj5DkknUxHxMm+TXNm
         w+TwQr6cXEjQBLq2FTElkvgwAR9T6sKMuHESyOLmdclC5xrmWsO7KAL9BuFSG4yL9Smi
         TuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940962; x=1789545762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LX3djUYrG1AMjG6o/03rqJKEBPTLs3HZVWxqrxj6VsA=;
        b=WVKTzweMtugOVw0Pcc3MwFdTBhAZUyv4Zooo3v0lCeyozbVmWE44Dx48xuVZf4cmHd
         w/U5wBD2uq+y+TuBe8rVWaoKfvR1zVHpxJ1LMf29QdOZA5T/FKlT4087s7E3SnNjY1dz
         yE8js1bCrXHxUdj5FJ3g7W9qtZNAmv3r62e7pDZ89qiZOGMDsGJWf80KgEL56IvwHVYT
         COhZVVaJw9RUvk4X7rCGifbUYQCcNkaxPWWI/HTKqMeJa3Flz2FDwi5Q1yFUvyVcOprk
         Uovyy/rH9AAeA6z16WOzOiAiXCAKEoSnMkNoCWt/e1PyK7oaJUqZb284z52cA0V9I2v8
         5JaA==
X-Forwarded-Encrypted: i=1; AKwUvBzwcPcTCqB5P5vy1m5UyOLJBeqoQVyne4J8qRupZeCbyFA2EJ42kEgqek8jm5T6sVyIJbZTBpQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nPjo6M46sxvzGYMJfX8p9O0VhE9qkA+jY7OXFEGQaE/BpW9UB2
	VlQIQonHjgi3k/1ffOQ8DNx4DMmIvknlSrn3uYD4Zf8RlCQH9CjokRS7
X-Gm-Gg: AYBFou04NYhzCJGqa4V/45iOR+xSfrIu430/66HVCJ3lhYA4A661EzYN5C6NvE9ajpl
	dfcyoar3IhI5EvjzVAovLhEadzopTOo3DC8XHCB7JrKYt/naiBiGWPcEKfdC9xgeMviCIlOjBl8
	chdUgRVFcaNbANUEyeJ0E3ybmGl4VB27N5TPCThQR/HqYrkXN+OCiTH5T82OJ+Ftuuq8zXq0QNz
	wIU4dTNSs8EjkBy1B2qKVVyHi5TGziSPS4jkDHsDJVfm0IKo3IW8shG+vE4Eh+vtUZAzz57Kaya
	W9in5u6IcpFP1NhcOiklrb9UV8XCh4EYHUcsXb+RuId3wsM9eaG3bf9cDwF60/QNZg/gO3f+dR2
	G/ZnMN5K9p9m5SGwRl/8d52TDl6nkq4zB9XBZxBHAy0+b/860AFQsbxe9js3PDBvrIpOWWHEi3P
	5/kF9WGBi5Me5pSlE/KyNmjbB6YKJ+GiJGeCIKMOqLC2RkXQNSTDoITtV3FUakF9cFRWv/Z1IbH
	FqyGK4WFQI1VGOBYTdCjIgR9KIpjXQ=
X-Received: by 2002:a05:600d:8490:20b0:49c:f89b:f82 with SMTP id 5b1f17b1804b1-49cf89b1bc2mr518048925e9.12.1788940961836;
        Wed, 09 Sep 2026 01:02:41 -0700 (PDT)
Received: from chubuchnyi-ThinkPad-P1-Gen-4i.lan ([158.173.155.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm412817125e9.3.2026.09.09.01.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:02:41 -0700 (PDT)
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
Subject: [PATCH 1/5] media: i2c: imx296: Add missing v4l2_subdev_cleanup() call
Date: Wed,  9 Sep 2026 11:02:23 +0300
Message-ID: <473ee7933c3a0b83d0e8fe9359c47b5c7697bf97.1788940469.git.chubuchnyi@gmail.com>
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

Fixes: cb33db2b6ccf ("media: i2c: IMX296 camera sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>
---
 drivers/media/i2c/imx296.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/imx296.c b/drivers/media/i2c/imx296.c
index 69636db11..855137b5a 100644
--- a/drivers/media/i2c/imx296.c
+++ b/drivers/media/i2c/imx296.c
@@ -870,6 +870,7 @@ static int imx296_subdev_init(struct imx296 *sensor)
 
 static void imx296_subdev_cleanup(struct imx296 *sensor)
 {
+	v4l2_subdev_cleanup(&sensor->subdev);
 	media_entity_cleanup(&sensor->subdev.entity);
 	v4l2_ctrl_handler_free(&sensor->ctrls);
 }
-- 
2.43.0

