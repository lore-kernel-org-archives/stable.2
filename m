Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4A47ECF6
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908194; cv=none; b=jxXjdIPUVgjIl5+e2+FUMZGpQdqGln+NISaPsHBumNHjzNjXzJze+mWbh4FAgulVsx3HVvEuYVYck+77VlI7lHA5Qmsq4vvaZv3cahRIIbzNL87SZBkXnenL+OBN6kLX1K1l860JLgpT99fNmdJrbQJx+KhEFsjqXb9Qy1/CCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908194; c=relaxed/simple;
	bh=obE/b2q8qcrlt5PUa6k2aHlJSkiqEXB5r2KcjRfVFPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IbJp0qyx4YXNkAC6dK0gI9kKg3cUrE3OYS8ODWXHMahOlkMtHNad1Hbx/vUJaYZ3ttdIqpv4gyFE+r7ElRwIk9a71EGHT6zd31tAEHb/hq3iafcVCJQJC6wdiKKnXkM6hrHi2C4afRz9Nxby1XkInZGeFoteRniJhvHBcrZOUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apv7xM2d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apv7xM2d"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c825c88744so4602525ad.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908192; x=1783512992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FefiUA1QiWl4Hiij9NEBlfC5wi8+6dRKuxnJt8tS554=;
        b=apv7xM2dU7EBm+eJRqWpFpYF+fgLZGFwbVw/lY9T8kxfSNfz26SPJ6J/0+4nfEndcd
         Axv0Y7mvdQSXZN69HPfpXeg86hoBPIlrAnz88vaxjzWG9R9ug4r1Mfy70LW1+jfK3onA
         onCbd493GSrsnLlGNWdoeqjRDkw0u1TFPk3HyHYAVULEBdRQRR9j4tjC+E19e+PZnEjw
         nK+SgcDaFO8iJsQBIIt+IiaseKGuIN925ANtdvfigCaWFmaQ1qePZqKH5dyoD8n9xaF0
         u1LBGzp14zhmUTIb0wPT2njm5SazFU21M2jlYOy5//TYfAXuDYeo7z+qlBbmPa+3L7zt
         oQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908192; x=1783512992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FefiUA1QiWl4Hiij9NEBlfC5wi8+6dRKuxnJt8tS554=;
        b=iRC7Lng9r/XilVmIWvLaUcdKre572KBkaznMpl+UnLPJEhTpl7rmKQsxlLp1YVLW1k
         J3r3KlbFWNTTVYtuTZkOLtQQx2AUJbNYKSVuYR6YTin8pEi0+W6Loq4HpUn2S//teneD
         1+X9V03CepYISsdBMTdcq9eAqQeKGqZWNAcb5SJMNWokHLbo2L151SA4LS1uUqP/mgAp
         /elR/7J+8FqTfeZrA5ygrsrFndp5iy2V8lTKnNnJgPLgJrlIAwWjZroAobDu9ZMNWDrg
         5Yz6reGa3VA57BIjL7ovKGir++vdEHMloyP3AQpppTMOv/GqZCSmnNn8OYWaxzPa6XKx
         e8cg==
X-Forwarded-Encrypted: i=1; AHgh+RrjgaHQFsBGMbGBxFmOp99B8jcFEzJFCBTVHEqKNLgD7Y0jT8ZBXl90wo9DouBFNxj1M3eRsV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6P4w/XZBdbQDZ8wwiKx3MF2Iv0WtrRXNV6RNMo0ArYOXMsRxM
	Hhqskv2OmFO7+JQdai9uiwGVQHYawYV5LwXypO/RuoGc2tOLQjIQdY8V7HGS
X-Gm-Gg: AfdE7cnszck6Aj88HbppC3AVcYe5seFh5eDJwdkV89jzxmSLJVe6QrxYvV9tNC8idAR
	J7+n0pLoP4uLhRAB+xBArxw2hpiixN0rFQ2NRPsRVyiySa2u6/JKN3U+dJIUjoOWFqva9JhYNVE
	/yMm22gHyW7cB3h/kUMRcpi6rpujLvIhxXLNYPMP71kpsR61IWeZc5NbNLzqKX5IirSS0vSdglp
	N5HSzI8Vuaj/3k8vSQNfQ8lrSyZcXo5PPxBfC62Ny7ltAMdcXM3wVeioolqgUVjD8ARGBSg7xTY
	Oqp5CHYDIUs6IxTJykTqajWQu7lxDB5+bhiyvCajosmjNRuF2Zx323BsRMM9YllxIk+Gm7BICr2
	8e1bt2oOWjEI3HKPcJGCn4ZGAn4K6+4cXKC9oaqyzpLMLOCOtukyZKM0SulUuewicPdCk+/YngX
	ncMJm43HIb8tzPCFyPmg8e8yyIA9/shvCkyQr4BLRCUBeDELew5L3lY0CcbO7GHEk4J6kDg2JA7
	1XEb40AWcfhQqXz7YoiRsqHZ0Ei1MOuMRJ0nbAhJKecwp6AAQ==
X-Received: by 2002:a17:902:e851:b0:2b4:5aff:de60 with SMTP id d9443c01a7336-2ca7e7579a1mr15832145ad.22.1782908192336;
        Wed, 01 Jul 2026 05:16:32 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca3828c2e8sm31114115ad.43.2026.07.01.05.16.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:16:31 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] usb: sl811-hcd: disable controller wakeup on remove
Date: Wed,  1 Jul 2026 21:16:25 +0900
Message-Id: <20260701121625.96815-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sl811h_probe() enables the HCD controller device as a wakeup source after
usb_add_hcd() succeeds, but sl811h_remove() removes the HCD and releases
the driver resources without disabling that wakeup source.

Disable controller wakeup after usb_remove_hcd() and before usb_put_hcd()
so the wakeup source object is detached while the controller device pointer
is still available.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 3c9740a117d4 ("usb: hcd: move controller wakeup setting initialization to individual driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/host/sl811-hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 4ae47edd4b8b..b044977f6f56 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1591,6 +1591,7 @@ sl811h_remove(struct platform_device *dev)
 
 	remove_debug_file(sl811);
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 
 	/* some platforms may use IORESOURCE_IO */
 	res = platform_get_resource(dev, IORESOURCE_MEM, 1);
-- 
2.47.1

