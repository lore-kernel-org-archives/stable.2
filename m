Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB423D7DF
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786178862; cv=none; b=MCrHGuCb7IDdaTUfvW2Q/OYm10yHkBiaPOgr8LJW9URcq08mJDMrbi6E0t/4Mcfd+xad32KQTNpxcpAfp9KKT5uuvIwdwixFC6MnZy6bVpHQgWuiYDD5Isg7R9dDVvBixc0GfnUYaz0WJ43EARd52+ri9i976gL1rWtgexTDDok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786178862; c=relaxed/simple;
	bh=dXcsRK343bCHW9vLskDGkSW4aM3ih07rCmEM3TPGVzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEnGKpZ8UBl0qG79CX0kGwHOBYPcsldkOZd+ZhmM5CnIdyVm0qxgPudPCDJ12rY+52w+YV/GNq8IHUURi3v0sElo7FLc0+FAvhpvd0nDJlQDVclMTgwo1d/K9CRKwGrnAujmHoGu0mkzCxuNORRlDdaCernmv0OVXEnLXjLs/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1Cpn42e; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1Cpn42e"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso303733a91.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786178861; x=1786783661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TPmyBqI4sq6YMQPDv/UOXNOpQTMSjsFXQkKHa57g31Y=;
        b=L1Cpn42eGh1u5MrcYOy0DzFysUzSm5sA0P1xjg0V/u7Qr9oujJcg1DCBL65f9d8U3k
         GVuKm7sxTjuibLR+bViQx0hr3DJvGSh4i7Qvasyve9ygT7K0u5HO6SZzxIqnSKRsP9tT
         lvuaAiQmGUL0ZtJkOBuJHsoSaZPgQ0zXCA5IuUm8zWt1eSgsDqGAtxWUTTcOX+XcmhlL
         Iustxt2PQZnWUx12hWl+DxJMmS2JQ9rvHOUguF0PiyZgTLGyIIa4s9tzuGJySTgMUJ7B
         FYrZvuzXS0inPBUW+ivnjKYVcsU8s0Ls+tnMmj5Bz79DLpbivf8uu6V/+fVXEHETAjJ1
         NuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786178861; x=1786783661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TPmyBqI4sq6YMQPDv/UOXNOpQTMSjsFXQkKHa57g31Y=;
        b=XajvhDr8HsBZzorG2z9b18wuHGvsSRl7Rpp13RlBFwS2qNlNKDKyi0nz0xL7rkTkim
         s3V2JEMIBrZW4YRO461gEJsXfqnledtvw5s+veE1IelJvIkAmdzEfGP3LvvbVVP9dTXo
         iZ8uoIp2UY7XEyvSCRkQzO2E5ftzRbt7R83T+jL39aXthLJp2hWUW4qoWrBhugPzvBO7
         QIJiflE5Za7X58SzYQwKuBHAlUHC736sgKLRUipS+BdxBLcfVXxCRduvbWzTtpXm+/ON
         8fGxX0+NKJSvoKF3zzx+cSW/kROEofC0VMMfnSYHyQjmpZJ8J2v44TvZRgq8VPl5Ovx2
         3C6w==
X-Forwarded-Encrypted: i=1; AHgh+RobAiKh5PgHhSKOa9ghF1KHALSxXMgT/wLacBmqgEnXHF+THjZuziXerXtYjYeK5UaOvGKnlm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUSHeN5F1dd46ABjVABdlDJisf6cQoikkDSOC0SnUB/G8Yc1N
	0/eMDrTjU6zm1xsEFMvbWsvBK9Y1plzqtrh+5M8mYF6BQe0YCVBDK3bm
X-Gm-Gg: AR+sD10XNiTI9/AgT/QXcYn8I2e/oxGzFJpzDiLXtnS/VD0KwOlq9OjnE4lS/YsE4Id
	CYi+vsIx7naa/Tz3PPZ6LSDNHaim5Y7z+ztycKje2YHWbS3zVzb7UNO1LEiFpw9AYdp2dLWkASO
	VHkh5GJ4CAqAINaOq8II+rUn2PvyW9tsb5yfJl3D34k9uEFrUaWtjKeysvTMAUYuunhOp5Ep2Gw
	bFe+lVlibe8peyyu79J8xHbIJi9JcbqUWDGjNQP0lGJPXufOXuakTeMiY/f9gAZfgZGHwXnoyI9
	54N7wA+AdgleHLReSdVvwf/jipdq9YG6NTGFv0FXGApnY8GYDeucEoxSBpmfsDMDX3/qOUeooLT
	yrXdXeI3ssXLUQFVF+XHpn//s29a6zGZI0zuwEuMzWddW5TvsUTsAWl09TcWlPcgjZB2iOAtxxS
	Pk7KwLD8hNEnZK0VFunRGIDlXNXlq55ZTneWsC4RFCfDwSOxYsIbzIDQ==
X-Received: by 2002:a17:90b:4f91:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3903c542f55mr23925788a91.1.1786178860876;
        Sat, 08 Aug 2026 01:47:40 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f2b2fdsm8109997a91.12.2026.08.08.01.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:47:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Tero Kristo <t-kristo@ti.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: omap-des: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 16:42:12 +0800
Message-ID: <20260808084212.2704516-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_des_probe() calls pm_runtime_use_autosuspend(), but neither the
probe failure path nor omap_des_remove() calls the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and remove paths before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 418f2a8cf2eb ("crypto: omap-des - use runtime_pm autosuspend for clock handling")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/omap-des.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index dfaf831dd8ec..73425c06597a 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1066,6 +1066,7 @@ static int omap_des_probe(struct platform_device *pdev)
 err_irq:
 	cancel_work_sync(&dd->done_task);
 err_get:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 err_res:
 	dd = NULL;
@@ -1086,6 +1087,7 @@ static void omap_des_remove(struct platform_device *pdev)
 
 	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
+	pm_runtime_dont_use_autosuspend(dd->dev);
 	pm_runtime_disable(dd->dev);
 }
 
-- 
2.43.0

