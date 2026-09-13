Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03001EFFB7
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789279376; cv=none; b=fe3W6RELLPtxrR0XCY90V3RfDJv2Y/MCiq0XV8yiePI6M66r1G2o9iUr7gY6mc64ILCxRtOGyQ63KcGlHDonNqHPi3+2+vp5LdKKHA5/Gx15P1TYx6rp1M5R8D0BiID8GNg4luCMRefmbQXniilz2GUgbC+syrrrr3cPYotd4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789279376; c=relaxed/simple;
	bh=65cEKXKhhuEzXufrrcDn2PycVDgDexj8cymvAewKMgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Etn2VXp5QhmUbRfAzN8TgmB0jiCNdxGh/zMam09meKFE3I1e6SANCdpJuWk7PAs/DrIg+h+MUX0hgvKg9jhVWoIuOrlGVLxTKwXCifu5qqJbjsgyreQHRHHwwas6N//bthbtgNcMNYgAk2fwsXakERqGWGwC+zmIUw+oyHq+u98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJZHjbiY; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJZHjbiY"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db18fe459dso3611725ad.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 23:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789279374; x=1789884174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QgMX8CiibWPEaVVcLSm85/QfWicxIoxBAscuNI56DwY=;
        b=dJZHjbiYA982A4Nt7rpwU7CjA5bYkKwfWzA+oEzq7RKzd/yiIMdD0Zc30eixHEGgIP
         2RGiJ+Cn/l1Q1IdoW0Spe55OnEuBIlnsSeH1cWSeIKRBk//eDw2qF+NkoMmN0GRDXFU1
         MWus2VxSxGEL6cy5J2tGEQPxFh9LqLEDq96WD87Ux0sX80Dy3DQ6vj77vrS6DkJFRPyl
         oFEXJPRjrh5V//8TomAmSkJkVcki2nOfk6WdQKys9WNedfdvtO9GdBZTNEwYtytN9okp
         LxgUR2aP+Y/boJt9l76JZgoNSwaJ6hUi9PYW/IZgRDm/cnjdvIn1oJOW5if1k//19y2P
         YB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789279374; x=1789884174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgMX8CiibWPEaVVcLSm85/QfWicxIoxBAscuNI56DwY=;
        b=WCwAm5o75GycSioiFvv4kGBXMtqNWzvplubfRD14vjIDNZF8S2xuNs5jDNhWC6nh8U
         UqSoDjd1138m2kvWB2zHVplaVCEB0eFYcq3CP3A5vD3srk24k/aoaWczr9xSvfdBlecM
         Co4YXOhkvo0IvrOdtdate5+AVS3PaV/qy/nwWDFtxbB/65qleey8SH7qhFOBgGmS6aNf
         vFAmOPJQf+cZXb5s7ZMhIvZqujv8xNF6So3ygQbENCvbY24M0z1Uv9GuMaTpi9T8zwY1
         Yr47GDZLn4cHyL0Zb9f/yEoP3QNc/IY49IvWwiE2EMQ3rDpR5HmVBWNSmFpV+MrwWtQg
         ZvXQ==
X-Forwarded-Encrypted: i=1; AKwUvByl4lOZhoDyEuPZEMkE3GzUjTNma1XIfkUdVHlzJJsh0nmVruwOmCr0QQqY+NhVwaAEifumpIo=@vger.kernel.org
X-Gm-Message-State: AFuF++lc/sGxR6cM4mHe13yogSUVlaaW+HYQ2E7VcBsJcMUDZQnNMb3L
	W6MpR5TBl3Nj5PWq3b8KyPqemKF8eETf4jmabmd0biJne4TzboLxhVPC
X-Gm-Gg: AYBFou3rW7iMzkKyJr0pDQ4ZEZrYr+T+j3X8LtuIG17FwKnOlo388bcCRNQdV17+Zrc
	jd2dyDZDnP6QYP+jXM8EhSHuWmpejrMFjMRVi/mAji1GHcr9isUqMuNnVxaxPTQcO7Mizm3ttoB
	sED8G5HiX0tlEIyZM4CJ0Ceo/Z++dzMaQN3fHR2r7TZOayai90Ce3yJhyXd3NKlOgEb+HVkwz+1
	1emBvxn/hrQqssi9+ncb6h5RvsjpI0CzrR4zoVeYbLwzsPyX7lf5N/IGeZFXbeEUxUuY4I8xoV8
	4vPuyJRtTk5ZbRrg4xe0p6xmc+9ZeeLEbiAQD5I6xF1chNAFrqKjlkeZm5m8RKA+9lGiZ73G/X2
	pTeQsTY9lVnwh6rXcLODLQkaHc2/WLhMojuEB1jTPXROxUl6spbcYiRQE6yxaQGNcwbRpiKnDPS
	23PHc4/vlDoyTXhjbTPPEnvD0NcgJpHS4Yn6ejiRxIn/NI680vJyw4ig==
X-Received: by 2002:a17:902:c947:b0:2d8:d4d3:3fc0 with SMTP id d9443c01a7336-2dd4bdaf9bfmr98050145ad.20.1789279374119;
        Sat, 12 Sep 2026 23:02:54 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd3f0faf19sm23811575ad.12.2026.09.12.23.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 23:02:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Alistair Popple <alistair@popple.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsi@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: aspeed: fix memory leak on remove
Date: Sun, 13 Sep 2026 14:02:42 +0800
Message-ID: <20260913060242.1426845-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsi_master_aspeed_probe() takes an extra reference to master.dev with
get_device() after registering the FSI master so that the aspeed object
remains valid while the remove path performs its cleanup.

However, fsi_master_aspeed_remove() never drops this extra reference.
After fsi_master_unregister() releases the reference held by device
registration, the extra reference remains and prevents the device
release callback from being invoked. As a result,
aspeed_master_release() is never called and the fsi_master_aspeed
object is leaked.

Drop the extra device reference with put_device() after the clock has
been disabled. This allows the reference count to reach zero and
aspeed_master_release() to free the aspeed object.

This issue was found by manual code inspection.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/fsi/fsi-master-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff33..d21d06b44350 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -652,6 +652,7 @@ static void fsi_master_aspeed_remove(struct platform_device *pdev)
 
 	fsi_master_unregister(&aspeed->master);
 	clk_disable_unprepare(aspeed->clk);
+	put_device(&aspeed->master.dev);
 }
 
 static const struct of_device_id fsi_master_aspeed_match[] = {
-- 
2.43.0

