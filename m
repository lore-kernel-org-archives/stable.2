Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284649505A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940973; cv=none; b=Sgep7diHzGPaTpsCHDvWVbxN1Z8x5YlXHc5WvkH1STZB/QZjaTloasbxak/p/sDD4bVlwyhDz7c+9xEdhJaDcF37U70NP/LJfYqeec4/Nina9gBoNTbOveW/JbxT+X+ibiAyHx1tQN2KQKtd7J+3JueyAvhI2cS99MPLeWNZekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940973; c=relaxed/simple;
	bh=fNedMvATv88XUN2yXNzYAwN7WlHGUXWXzn+KTQ0e33M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQUsXiPVRA7RYAOYDbIpKy9o8v7Ufy20HfN2TTbphbrWmmvPP1cMcf6eNR6/kJPY34FhmgZPMn4Hsi3U8444CdSWNGFJ7Xlu1gbCndz74bS47OG3fLVSkl1C/DDQoZgdHW4JMF7eLCUBpCC6UApoWIbP6hpiRrRi5hcJ+rJBtvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI1t4fNk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI1t4fNk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49cdc81f40eso40055115e9.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940970; x=1789545770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KhCyelSoPVv7zgNsnvURqCzMuI51nbjIqRvKAAsNNuQ=;
        b=DI1t4fNk4Y3mtXLg07dg9ja0BMfoSBpUcA2qqgwkfIfO7LiH0Os+Wac3FSXt8vCYgd
         ECT6GEKItbLTkgtzuU5Csoicdsn3B78TVvz6CL4g5vgtRduunu65WTTnfCuHEbo1Iw34
         OyQQJHJOhXxI0si8uty2G+FY9aDIw0N3sHWPI05+EQ9nFBTWKAejtGMmO9hebyHfJMAx
         JyGM7jB/JwInw28tA02IbRxArNsk8Dw1otT5ttR/lNqmTLZGieeqDsD0d3KnCfbyJxAZ
         sDswJDLmsW/sjx7bSYKgYRbENd4BlD+eUyI48+xTtxXBQgl4XO3hsNTWTuFeWZZzUCB8
         TQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940970; x=1789545770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KhCyelSoPVv7zgNsnvURqCzMuI51nbjIqRvKAAsNNuQ=;
        b=ehRgBgNQXJsqdrsdxPBxlikXIUjYFtIXiPrh2HU//snT7pAjoVUJIasTaXsPVLIhEU
         SLtCeTiQbIKH8lGXbOg9KvmybngpHLlviyKLCG4TskikP/ynEoMs9PXnzz4aGOwBU5MD
         XJLKxsxNsxB8x2mLLo3Wmdw7Pgl4/kU+5NAUqxuxdF0kyI7MS6aXz8lAyIU6BAgkTAo1
         EshpahKohlHWVraKp7bnJBLjH2K367X73FKEwktxbVyFVRFZY4d7CoM9LX9voCsilP5J
         zO+ke+Ancr8jKgFQauboMVacMxLa4/d918KTkRCdUWs312KojXYJcs/AvPLJj+m/+b0g
         Ccfg==
X-Forwarded-Encrypted: i=1; AKwUvBytfG4gOFO3vpYWDd6mJxgNGLy0BRzAGT4UNhQrSUqRlRFroQRpXBYSLR9sPMQLe2c1Nc31NGc=@vger.kernel.org
X-Gm-Message-State: AFuF++lw0tOdq4w5UMyWNakNAAtnymzrM9WSE3rCGsw3pbWzZM1l+yZk
	PgBYC7SOVPz0zdvtnumi38IDqZK+KCgmfR6A36VdCcW5bWrFS5FJp5Fi
X-Gm-Gg: AYBFou1O1NNswQZw3/DHKXre1+2/6zfDlHtN6Wwm5ZZ4rjBgYVs7dkrEEvnGhDt9jt0
	xr6ZAQ7cMrGk3Uhwk+/E+Vy23DIcsk8XJMURHXntZ7eMApiaIRCVE1CqawyUJIW4LMzzIqVG6wG
	NOJYSWmvgepAo0say5cjPI3gZs01aY2TS/FSVBZ29gWP543op59CwdL+EfLeZoDPz58cbwvHYmF
	BP0ci15vM6nFk3WOsa0QkOBPtOJN5zt8OIeXjKTWaYt7zRdIvnPgGHWVel0U78pkujLCRuJj/WK
	/VnjPcGwXofqXCeTdA+VmSTdYrVxy50qFy7gSz9U2dwCTgPvZpB4tbYi2B4rgTa3UYBM8tLKvM6
	sT13YBaL01jEZOsG65c5eaINV3yGpRXxBT7qIyY0UMSEifjqrFcz710e8PZCcDfJCuyS//eTmLa
	1L+QgMF/5c4g7XrQyczy1bRMebrPMaMCUnvmksfesC+Od6kaWBUfMk5WD8yuJyd8PLZC+IjqYKA
	BkUvJrFIOFbhkIlwbto9kUZsDshdVEbn7e6f9DeIQ==
X-Received: by 2002:a05:600c:4e94:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cf81e368emr586908475e9.6.1788940969610;
        Wed, 09 Sep 2026 01:02:49 -0700 (PDT)
Received: from chubuchnyi-ThinkPad-P1-Gen-4i.lan ([158.173.155.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm412817125e9.3.2026.09.09.01.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:02:49 -0700 (PDT)
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
Subject: [PATCH 3/5] media: i2c: mt9m114: Add missing v4l2_subdev_cleanup() calls
Date: Wed,  9 Sep 2026 11:02:25 +0300
Message-ID: <f3340fe13dfc5c331da1444335508fbcc02e0c23.1788940469.git.chubuchnyi@gmail.com>
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
on unbind, for both the pixel array and the image flow processor subdev.

Fixes: 24d756e914fc ("media: i2c: Add driver for onsemi MT9M114 camera sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>
---
 drivers/media/i2c/mt9m114.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/mt9m114.c b/drivers/media/i2c/mt9m114.c
index 848ea06e7..137e8e6df 100644
--- a/drivers/media/i2c/mt9m114.c
+++ b/drivers/media/i2c/mt9m114.c
@@ -1482,6 +1482,7 @@ static int mt9m114_pa_init(struct mt9m114 *sensor)
 
 static void mt9m114_pa_cleanup(struct mt9m114 *sensor)
 {
+	v4l2_subdev_cleanup(&sensor->pa.sd);
 	v4l2_ctrl_handler_free(&sensor->pa.hdl);
 	media_entity_cleanup(&sensor->pa.sd.entity);
 }
@@ -2208,6 +2209,7 @@ static int mt9m114_ifp_init(struct mt9m114 *sensor)
 
 static void mt9m114_ifp_cleanup(struct mt9m114 *sensor)
 {
+	v4l2_subdev_cleanup(&sensor->ifp.sd);
 	v4l2_ctrl_handler_free(&sensor->ifp.hdl);
 	media_entity_cleanup(&sensor->ifp.sd.entity);
 }
-- 
2.43.0

