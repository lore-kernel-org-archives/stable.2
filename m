Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D253ECBE5
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943244; cv=none; b=uPBIPhVm09AhZ2EBlLuaLtywSxTtX21YRQChFZcBff4AB5BwvrBbq5m0+X61YYCPxUAhR5JvzUgVYbxFagfglBSynGJbY7Vba8V+dbwNJgMHZNsO2HG52F3gHTEk0ixRP1Op5QaoJK6Juz0KUAk+zcN3ONQO9vMXdJubRA/1Deo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943244; c=relaxed/simple;
	bh=2PYYlcQqLMp9ZyJlbZOu82v9vXV7Vz57pJlWzajpaQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZh69O4lU2dt6YUOw/43m5lpS5TzOWfLnywrdMhUJHPpNVrOgMfu+RVjIS8B9cpWte9GspkGWiilkWOzBL3w5kFrUlifbWtTT0YQHrYCe87QhA/18XFxtx35IEYxd8lnLHpVgp7dD0wjW0WyqALUrolw2Ed0FNc1AxK38ClAmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnV4iBuD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnV4iBuD"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so32977625ad.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783943242; x=1784548042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gUfgeiYLj2n8Lc+2ZjQf7Ijb1oRUUAQYlVMDWkCBke4=;
        b=OnV4iBuD6vqmyda6BKuAYbiz5O3cYerXGCh4v4RcNbhkOmIGOPY32Oc5pWhQVfAozI
         EPzb3IOxP+7n9QgTgTt+6xt6XgaQAMjcaqezxGIwcE2RGQ3hrHuUTMCM8wiLoajgDKOn
         /BKWCJrEAmCTv0rt/4GghFbz4jy3NMc3fPmeSPSFJ2kWCCRxQFuDSvHTAC7Tig3KV5/X
         vjHkrQ6SdXzrz1wm7k4myX+mVkwRErqi4mdiRSj4c2l9PEO2nt6w/dEiOhSBhtaUGYdg
         4GQePgOP5u4nl1y3AiGkk+i9ouHSrPO1skwSv7M20sn3yhg/ew102pSCfoA73fpQnXxM
         PV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783943242; x=1784548042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUfgeiYLj2n8Lc+2ZjQf7Ijb1oRUUAQYlVMDWkCBke4=;
        b=bSJyj1J9CNUmY+gnp7AC60EqlrSY2uix4P3G9kMjwiFHHcP/F/cFlq8brTJ9+dz8/t
         V1do3pEjZwjT+ost6GZ3OCfdUt6CejGDFmDkABSTHhlcIDVeVajIQCCjD3uccVdiK9/H
         bVFmNVtnnQuQ3i4O+tWllEWgGueBWgwTvKvI9opWE5CYwUnVsA6Xlwj8n7M3/pfQFMs6
         QtQP8RYagTLVpQWw7HUkZ9y/3MIuoIjX8lhHaLEt1isPgBjI1utoJ1paLn4PKXNwVDsH
         2LLerkxThC2Uh+ed5Vy4zSFpGbpykNlPHbOIBBcje+PTgCCrIcg2z+LnKCKlTWz3LODg
         FGwA==
X-Forwarded-Encrypted: i=1; AHgh+RpGMNiF6oF5cwEvIsI6fj+VzKQ53xPi0FBuR3zGkRKcrDOvXQFWS3WH5Gl0nm461G8rd/q3gsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0E1a69JyjQmW0ugyVRsTZzscSEDoObnMmhrGQ7gmt1LwBBzFG
	YywsBzLJ8S7n7Q4RqNclsn3IdGGlHfz6Z/bHJ3xnpamSaVQWmCrXyMJE
X-Gm-Gg: AfdE7ckI4c2Fv61vG5MrKS02hrULbRBCXjhdtpMYvZeZsg5IxbVaEeBAzRu9vCHrDIf
	xIM/NHAj3w+IF+8teKEvmtDSyhmkJkdX5LqQFp6kteJ1pJ1gnDNf58rxIeGGQt19bQQeE3dqLf7
	KOQjITSF+DCygVKO8V1lDHKq8R1P1ZOXyV/L+9zKxe+VlHOvUNdLfbyv0KOWjGgCc9ibmH2rxZA
	kizNp6Nkr2Caz+7yyIw9SonvqPrjQ/h/5hhJ/misJpU88RcsYhPRk8Fwg2cEGVWVXZ1/8rArZwK
	O6ons/M4AkZWNqbrYS8R0KFWrSMc9bEe8Y8NQhDza+gbCjxyZXcLUK2LXxMKRyQaDzgw4K8D+gC
	hHrNVOqs767En+JX9EpQhLciUvRF7v0Kz3nMhp3vHDDvS43o+dhvqswawuB5xDVZ3lOOHb4/16t
	BmFJzEc2qPXg==
X-Received: by 2002:a17:903:2a88:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2ce9e9b2507mr83806345ad.14.1783943241572;
        Mon, 13 Jul 2026 04:47:21 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc99cc5aasm98328125ad.0.2026.07.13.04.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:47:21 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] usb: musb: omap2430: Do not put borrowed of_node in probe
Date: Mon, 13 Jul 2026 19:47:11 +0800
Message-ID: <20260713114711.955253-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap2430_probe() stores pdev->dev.of_node in a local np variable. This is
a borrowed pointer and the probe function does not take a reference to
it.

The success and error paths nevertheless call of_node_put(np). This drops
a reference that is owned by the platform device, and can leave
pdev->dev.of_node with an unbalanced reference count.

Do not put the borrowed platform device node from omap2430_probe().
References taken for the child MUSB device are handled by the device core,
and the ctrl-module phandle reference is still released separately.

Fixes: ffbe2feac59b ("usb: musb: omap2430: Fix probe regression for missing resources")
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Correct the Fixes tag.
  - Add Cc stable.
  - Add Reviewed-by tag from Johan Hovold.
  - No code changes.

 drivers/usb/musb/omap2430.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 333ab79f0ca9..6e749faac33c 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -454,7 +454,6 @@ static int omap2430_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register musb device\n");
 		goto err_disable_rpm;
 	}
-	of_node_put(np);
 
 	return 0;
 
@@ -464,7 +463,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
 err_put_musb:
-	of_node_put(np);
 	platform_device_put(musb);
 
 	return ret;
-- 
2.43.0

