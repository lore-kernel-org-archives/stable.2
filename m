Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BD3F8233
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547529; cv=none; b=oE/Sdj3ny+xgjab6HEu/e7wa5O5xIPXsLYquc/OnylGG2NEX05EYRRxCvtXUwYlVqJ+jOWHaKg3z2j0oOrFVNMkrFqMYdnnsLFgD5d2OohSDYSyAKfBqPWrSXdTaBE31kgqDyf+PDnmxAyojLgdXc9EeZb48bK8WZQzDoKEGjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547529; c=relaxed/simple;
	bh=dlMTPFtsBeQGxgr2XZu/OGNjGA04J4d1NowoJDCEljU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ENPBS0m9J78lK9A2GVsUN/e6i1N9UUZ4Z3u/R7UCwUB5hUMBGdiGrxia19+Nk+SOK2T4Ltsf2WOZbDcQY/Yi3sD0K1Ub3AOQbyJzJqXAX2CKU7s/3MzDYRBmxOw6fUkwtq8ZJtyxJOKbRswfzTeLgoxarDE/u/WBO5mwqDencd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=I4BP+P4D; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="I4BP+P4D"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacb8416a1so64758185ad.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 04:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784547525; x=1785152325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nsdh+fwHmWa5XVa73TyuvW6VtjwnCR2ZTFQjARlnTb8=;
        b=I4BP+P4Dr5IgE7Df+RRWZQN+cERiv2FsBVNeeSrCYYXj7DdhrChveXbV4vPabOcJJQ
         A5Z3ubtPaJ/1GeoKWTbylWrTGTGEpdZUXIpKCBv4ev0DKisPhaG4m26HCn4j1sijCDH+
         iDEhyFrZx4Ks4e5+bAqTNZ0AwXaR3XQW+T8rZPlkdj/GCBhUA1NXjN+N7yRuuS3P/qKd
         0u32YjobuT8aXEJaZqKbn0AEeChbbhhdZoyH3TplKBX/2V1XmIp4R0gCnPlNTbXky/ym
         eIOHf3UgzBUwCL7m/XK/AsGmC9LEO3pSkSiNAUnCxpzfc+ylxRw4fDJ504X8Rwnnwt5g
         R9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547525; x=1785152325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nsdh+fwHmWa5XVa73TyuvW6VtjwnCR2ZTFQjARlnTb8=;
        b=jmI3hX6mR9JCgIeTRL/AOsM+s8wDDlSePKaDFEhTecTipPCl5eeNAs1/N58qAHGjV5
         MdVJQ5q595rQPb1VO8RynhrH1BKZqXd8gr+jS3u0iJyeDGIfSaRBYu0QuvA1beb6xReB
         CPMSVdQXJKIkbLt1ZjtJBwr0klXdVWakcw13L8cxMEstGm9ZNiFzHNqwA0tBJBd0bKli
         TW5oL0rBaVhDqkH9QjLhWtL91iLDay0cGzjHM8rM6uC6pv8qO6nWG6Wjed9izyYSynbU
         m1XLcIAqmrVJHdTiHcwYcyNVpZwdnSme/2i/tZcSxJH+tV7c+39cSrjMlLZjCzuyo8eq
         sQMw==
X-Forwarded-Encrypted: i=1; AHgh+RoOJvpIZdjGmKCau5O/qjzyYN8Db54xETcNbvcsKKxsQxZsktzIXg4kvyKUDUIIadhd96xKKGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziKHGSJtyA7zzMu8THJADHOfu8RpmqQ4wR+aKgSrvZvAJPO9Qi
	G82u59vidudhU/RbK3XmAZysnrXTF9LZjcLIJW8N08oII+4Mt9Fc9zYIS85mdGVobXo=
X-Gm-Gg: AR+sD12pTuUUWsTwh8BWqhruacRt0TrQWKOwQatqAXfsrIynWtdG08O6lnorWDyQOBk
	bwxOBX5xYU/KL7dax9hSvuP9D2TudEBujhrKj9EkrhdJMBd8xYa05PZYLE1wn4EvxGWWohSY7Ew
	m8dEq1k6mTlaiNoweZh+prtI+R/dMK47VpgIaA6/nwEFisRs8lihhj/rczV+vuSPeD+wI2Louo7
	V1tSa7lWHKgLwEUEggqRpsScjnY4xwPUrq25axyzLTK1STAg8l5poPUTcniWzhNESsCKAxQEDgG
	U42GslU6OBMnRUqd6CdJNSZOzYnYBU60fkS+ocWvOH8V5AMtCXj1GxQ4cHp4cSNsp2gUX6DdSgC
	EeNC8/rK0WszK36YH3RdTEWfY7RUNtDUvuCO7QlUyX8aZ+WXX/EKKvm4uDC87M1QSkWBP2cKAdp
	NNvR/IyV+pR7gGWR9gPIufzU8liW/kjyJsQpHAmBV34I0algx3jZP+rVualqAnWOfmB0AsYa899
	yQLRBOz++YAq4AhNrjd9qInY1zmF+Sy
X-Received: by 2002:a17:902:ce04:b0:2ca:52ce:6f91 with SMTP id d9443c01a7336-2cf3496b2ffmr168181275ad.27.1784547524888;
        Mon, 20 Jul 2026 04:38:44 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2cf3448f91bsm55554995ad.8.2026.07.20.04.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:38:44 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: lee@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mfd: sm501: Fix potential memory leaks during remove
Date: Mon, 20 Jul 2026 17:08:32 +0530
Message-ID: <20260720113836.73133-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for struct sm501_devdata in sm501_pci_probe() and
sm501_plat_probe() is not freed by the corresponding remove functions
sm501_pci_remove() and sm501_plat_remove(). Fix that by adding a call to
kfree().

Fixes: b6d6454fdb66 ("[PATCH] mfd: SM501 core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/mfd/sm501.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 49c6b21a44e8..0b802925d6c2 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1629,6 +1629,7 @@ static void sm501_pci_remove(struct pci_dev *dev)
 	release_mem_region(sm->io_res->start, 0x100);
 
 	pci_disable_device(dev);
+	kfree(sm);
 }
 
 static void sm501_plat_remove(struct platform_device *dev)
@@ -1639,6 +1640,7 @@ static void sm501_plat_remove(struct platform_device *dev)
 	iounmap(sm->regs);
 
 	release_mem_region(sm->io_res->start, 0x100);
+	kfree(sm);
 }
 
 static const struct pci_device_id sm501_pci_tbl[] = {
-- 
2.43.0

