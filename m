Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6144F55A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980691; cv=none; b=PKvJetoXSVSkttds2IG0nQzP/ojB07vrTSzoDYw/QUQntJkzUxC5iNn9t3xU9P6uqmVkQKkTh4x8kAflWOVvWAwgDK8NZ13Alh1b7YRzviOrjg2U3wHLIU30wJm7tDAYmdI3cPa0zQV/kDqIilDaObVedn96nvqTyizbZOeM3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980691; c=relaxed/simple;
	bh=orjsntkymHdV3HHrZ7aB0glGaCIs99TYSc2OtuWjMDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+rZqgLY5a0Oe+lLCt9B9YqmjMnXnxbsNaNPbAg3mVIYVozsedU0C5xroqGgO08AjYa586a5nGuOPcFnzfoYICOiHXVKeb+4ET66FHy+BbPjUfY1odChXN9V7wGINR6uN/VDK750R26bgW+SCxM3eoZdr6eMJ98PAJNqpROCPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQGKrGSV; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQGKrGSV"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso2054274a91.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789980689; x=1790585489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZAoUJ5n70t4dRNpVYU2ESN0IQMx9sWFKtOYuOw8UYwc=;
        b=FQGKrGSVM7VsPwrsPYfK17HQgBx6ihQ/rB+Sm09lelgilJ4WmHJRaWj3FjgYYje+w8
         41dq70CW/q+ymkgQLdYEyuA9WJyk8JZvypqp951/nozjk+nqWgnYRLoLkC01hhF4b7At
         cSeJdfYBcJ5GSvs2w/U0vW1P+FVruyyChbuBNVW0rXKz/O5pW6sBE1wIu7eX514A6pFr
         eF31RSNFjFIGgg6Bh3977W3OVuo68uxHt5kLpw8hZn2TD+ptZLot2t8VNJPH2JcdE/rh
         YD8yQ2m/1pthi7LriUryv5lsQngP5ouRfqAJWRClNBBY578vixrCIvfh8riwDzOnzIds
         iGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789980689; x=1790585489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZAoUJ5n70t4dRNpVYU2ESN0IQMx9sWFKtOYuOw8UYwc=;
        b=f5DSudvPsZYRMzQqYPNl2MirCznOSK/RO+BzmVoP88KHKYSGodRKDcjL0Rq9i7ywUz
         cnH00n3ovbXOA4JY4F6aslvMAtIHs6d/Bv/0Slls+BhaFCWxMspiMMkfD9R0Vosn6Po+
         hD+nTXWdibl8UOCnSv1LvGhX/e199qGn0uH+tlAVOdNquDTrqxmTDTdPYPD9PQuMsJF5
         3K+JhMwQtqPHUW1k1q+yKdyyahDLcNtD3pqRRUKZd7BSyL5bymFCu1qWmf7idH5J9WOa
         As//aeb49zxh0ZfJliOPfO4Rgj6lmzZ8YCeCd40aXFP8v8Q2peZYYXk+PM+b8EZcsDla
         TMpw==
X-Forwarded-Encrypted: i=1; AKwUvBwLm/DuY+xgxdawggHkN9M3k0rZMIzMPTSuSbYBMMPIT8tvOtgokr81nzi/6NQ+0gWq1cVvxec=@vger.kernel.org
X-Gm-Message-State: AFuF++nvhVYiOoAQMb5AkZMN5hiKYWgXk/akYaWqvV1WraQ4dBQURjee
	hGYP6l9lOXfYM23tauZyEOiAaGt4s/fvE6Ki24KVrMv5yL9DzpNZJnWk
X-Gm-Gg: AYBFou0nnPt2vNxaDid7xXXn6rqJ6t7Gyf4rKvSdgdBEA2U//VQq37tGcICTbb5Ew+B
	2lMEY++YejvGN67BvC9gj0YaksEboLwQTaB9Jp0XDw6EwSflJNWu5hXUmz05ZOe4NhSyTFq3xZ6
	f1uItDs1jddMxkIHz/DjI10qQTeZsNJU0uN9/xx9FpIMTQsteE3N6niYh5oCaRglTPRAOQT96nd
	+V7ECh2De+o/D8QXIHwbSfTK0itdXgTyQdPPbYsMyn/XIyBnjn8kClhOwUbtrV8IkZI0I6qOkMQ
	54HsHZwkDSqzDFnk1bWh/EwzDbcQUJy6on+iuRuoqSb5ekWAZGISltg8aeLS4tiu2u7x96CK5ND
	TX6UHOBXbjhIKRumqz+BXng7PMeKxCcaGFDQibcdx1xz/AkNMKkF8COyqtOZQ7w0GkaZF1Pi55o
	2xfbrR9P9g2+gshBJ6Xv222RPM4LpnOV1HB/k/4/DGckwOT6+Zwks2Lg==
X-Received: by 2002:a17:90b:1b0c:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-39e54bbc32fmr15958386a91.9.1789980689350;
        Mon, 21 Sep 2026 01:51:29 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55b83602sm7853716a91.1.2026.09.21.01.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:51:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yonglong Wu <yonglong.wu@mediatek.com>,
	Min Guo <min.guo@mediatek.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: musb: mediatek: fix child device leak
Date: Mon, 21 Sep 2026 16:51:19 +0800
Message-ID: <20260921085119.308981-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_musb_probe() populates child platform devices using
of_platform_populate(), but neither the probe error paths nor the
driver remove path depopulate them.

If any initialization step after of_platform_populate() fails, the
probe returns without unregistering the populated child devices.
Likewise, the children remain registered when the driver is later
unbound.

Use devm_of_platform_populate() so the populated child devices are
automatically depopulated when probe fails or the driver is unbound.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 0990366bab3c ("usb: musb: Add support for MediaTek musb controller")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/usb/musb/mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
index c6cbe718b1da..3aff0add2faf 100644
--- a/drivers/usb/musb/mediatek.c
+++ b/drivers/usb/musb/mediatek.c
@@ -415,7 +415,7 @@ static int mtk_musb_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	ret = of_platform_populate(np, NULL, NULL, dev);
+	ret = devm_of_platform_populate(dev);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				"failed to create child devices at %p\n", np);
-- 
2.43.0

