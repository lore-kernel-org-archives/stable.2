Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88771218AB9
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046680; cv=none; b=m8zfSvPqVQiUrx9ERU/Xbl2eZUsstmvrAW2Bo/3bq+/hbEwQ2fUoEHfkxHWI+iUB/rwSWdXoJJCPgbKiHjeVN97Wl5JzBLl3wQkd+U4jZnJ+xCqYl6phyoAKN9PTLbvgzfPoHYXCwycreTYTKq0F9rhv62R0IYXeIdp12puP4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046680; c=relaxed/simple;
	bh=BcN+kc7Y0a9AymMbKgvR6mCTpXkBQ9KM7faA7J5Krh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rbwp1xWBxgulgzRFPvdV2Fm5vL/qJLQFDrftSLpXYu3q/Gh+yNL7165InI3EwwXxlbiE+yTqGfTB+/yZwJYzDMnaJ7nZITSHCN5pEoA1TbK/phJi9PbwMWZQbasaB/OgcXwZXnIzAq/YEA9YPjQJT2tZ0c7stbC1UwZv9a4EwE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK/Pj6uR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK/Pj6uR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b77b150aso8050455e9.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784046678; x=1784651478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P+8jCTwgu5velxazBPk9XTR+aKK116XL3VK7F2AJFKk=;
        b=VK/Pj6uRuuMzbupiMdExIaK0hj4UOAoEmJ8FUofJWkxaNxDoSsSj//VECMVTV+9cGB
         0OL8DPz2U1iioYh9otPqphQhciaYNC0GgEySugaAvU5sfXUbgu5wFNJZTFqqjxq1d4Y4
         rV1CgkTo/LdQi522Fi/sSaFw/cATgz7laW1JpaPweRi2boZoN8xRclqUnYugNsuqeQSa
         WePZ1403LaUdIe3e6yQE/MOdK3REcWdAqx134L2bSUHYzaUHZLPQ+/8wI/L8lDrqYIpo
         IB7/z5nK2TvdLC1Zn3r5AaIZpLDOQHfGIVIAGajrSu/ypVXvOxw+Kx98lIP+L2xQpljD
         C3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784046678; x=1784651478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+8jCTwgu5velxazBPk9XTR+aKK116XL3VK7F2AJFKk=;
        b=glxnhWN/wRtmoAC0YjR2XazkdO2WBa4SaYzzKbSTByxSteMpzdRmu1IzpY8KFkGPXR
         YdyM05ioiNW+kb2wLTXCAvSApF7zAYdORmgPwHMXPCwFEVqCFt7Im3HSshCyt0Bk+EHZ
         /Fmi9b2ae3N5lpdBcaYUBTpoec7ZLomO2G7xHEilx29wi7iZ+s6tglxrovl2q49yJby3
         WALPN+UcQQebTIH0d32jmu/uq7pSidzhYS7+gjsUgYfh880lcMtKO+3RjsJN9rONQoPK
         SnA3pSk/AuQ4kMDr7axy17LwdrP8VhsrD+w58ciavq6rW1rVxeWb8w1qbe2GA3mW6VEg
         tQtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq9oM/TtWGlyS/enjUd7fgRRn+Q6yCvQND2UB8UuWyjPpTTKioDG7y4lplEsr3UnLPSD2ICVp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjKrNTOfaIlu+eIDCEsSjxauhsBRDQTOT72aOSjCZq2+GfqX+
	gaApUMKj9SA6pzfPqzw2gf8j0tigwLwI7fSGKj3cGt6eh6Z+IoVkH7ZN
X-Gm-Gg: AfdE7cnuH49AxvYNIBgyPC1Wq6pryAYdYDA++rvTR498sMDFWGDhkkEZQRNiS388mzs
	WphKqaabNxpvZEoUWgx2S7hwpMkn3ya5tlS06/LYRC5UQ10FS54w1obndGaVyOoPIuNx7E9kYHt
	RX4Lv8deC+vFFfSlW1OpFC4KE+1QtwPkKYHOhGvdjI69rpR4dJ2wLNdNNeSXLv21h4t5A2FTxkG
	QkfF8Ecu5VpHPeohJDCy4YR4F24byZl7N9zlYoVTX9WmKb10oqfdioVlYpAKn2B19PiM6Zb6FLZ
	SG9lwx1S8MD0Hf3OAvmTsiv0lFaK6Angs8aagjGzXwEBtGqEOGXMXdI8TiRg0GASiH/ZjU9ffva
	rojJ+Sqb0rw5qPph05xDWagU6SvinSkQif/OXRp5QB8jnEJYJt5oPOT/Q1sVxUpgw/IUpq6Ni4U
	9G2ESxFFTz2Pn+C5iukD2w/6F54rCtjH6OXUgVimun1holXv87gQ==
X-Received: by 2002:a05:600c:b90:b0:493:b967:178d with SMTP id 5b1f17b1804b1-493f881d05emr148460745e9.19.1784046677536;
        Tue, 14 Jul 2026 09:31:17 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:af6d:c23e:9b4a:128c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm406414175e9.2.2026.07.14.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 09:31:16 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: return error on truncated firmware
Date: Tue, 14 Jul 2026 18:30:55 +0200
Message-ID: <20260714163056.22329-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panthor_fw_load() detects truncated firmware images, but jumps to the
common cleanup path without setting ret. If no previous error was recorded,
the function can return 0 and treat the invalid firmware as successfully
loaded.

Set ret to -EINVAL before leaving the truncated-image path.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 986151681b24..39fff094ebb5 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -829,6 +829,7 @@ static int panthor_fw_load(struct panthor_device *ptdev)
 	}
 
 	if (hdr.size > iter.size) {
+		ret = -EINVAL;
 		drm_err(&ptdev->base, "Firmware image is truncated\n");
 		goto out;
 	}
-- 
2.43.0

