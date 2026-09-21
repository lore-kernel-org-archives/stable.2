Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8D83C0A04
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993564; cv=none; b=N+CK+nJsQTH4kuKCdg0V8ROOh7KZH2fCcmxZx9/hE+k0o498UiftY9rqnIbHbgmR86Gs5ZbdXNLk471WrohIsJ40LsK1IObXa6qhWjoa2JlPeuHhqr9UO2Qkq7r6VHMSU08CIgqJSMQOjpptngixNKJIuNQ5c561fwqHX2fx41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993564; c=relaxed/simple;
	bh=JO8UXj44gMiPij6DfEkLk4FkAXvhQb6Ir6+VRKD+Jq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MAI8PG5uL6LN96NDxeGWhVHyDfgklhHeRGFvnHR9mPKROI+qA25ZWSh9f9QHUeiqAkY/qExl3+wHAebn0g542aNrz2RsxNY3iPQfvNE98Yrteep0rNq74pNBsC0qgAwF5LFAy0NXovBAtxtaEnaiAou5Ob0dXFPXMjftUN09H58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ41R78i; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ41R78i"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1e1b51234so210237a12.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789993562; x=1790598362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oHO24PFyI/gRvEgCcw5OLI0HENmuN3p3mM4wqQ/TnrM=;
        b=eQ41R78i0qWxNzUv52Je08iLuH6IJN6v3JPLHkF76eJpajc6Z2M7tuBv4ApENQghC9
         4An09xkaPuMTK7y9Oy9jWWMdWghOvwaPQQNz2WhD9MZLPzBsgs4bLaNeohr8yn4mG1GZ
         vN2nypaxaxvaJv0nP2MUODeQKhGcAT1897RwQhIJkhQ8Muz1YjNN79mDSAEpFLpDDwFi
         cBaS7j91dJYfzZ/u5SscwJ92L0/UbL4cD6oDxqnra9Yh8nEm4sI+t1D4PNDTnoApi+eH
         gMlw8acroUutn1Af5bXCrZFgsKdyXtIHAGbbUWMw8r55TLuwQRsnmSD882OKI0ZZtWI2
         WzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993562; x=1790598362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oHO24PFyI/gRvEgCcw5OLI0HENmuN3p3mM4wqQ/TnrM=;
        b=Hg9ESVMu7XUY5U6RoSlDFiG7mrudUgYQIHuhtYSSpNynL/osRywiA5RI86MD1qKXQF
         C3ACRUTh5rmTQKntnkArzTIxi7KZGq06eg+XZfXDEjU18xtIWLcmdiUx47Q7r/HjNrDJ
         7oaFQdtlJPgiBq7xyLAiu2gLaf75Cealp2TD8n6DsjGQ9rD7AjuVBwn3FTuOyyzXxmrZ
         O+yLeXirFQCWbdQrqdDxM4P+6VtZT2INTP2TnSIISiNP1C/WQxI7wQsBcoU/Suj+Y3VN
         kNyjAyqzj7RQtBNvdT1rSPU+dMwkFplf4elRUxJEzwaF12QZiSf7YRmwDDR8fZ5lb0lY
         MQzw==
X-Forwarded-Encrypted: i=1; AKwUvBy0XqpSn5ErIcuWxnAkXFch2PKTRX3y7Tel6m40X6IRKR0TxHy9NCl6xOxIeHOD/0SCAMF1C74=@vger.kernel.org
X-Gm-Message-State: AFuF++myalR8HdwAdEnI09Fy0ESZ+Nz/a6sprZAnmv8PW3TUal0mY6PR
	V/pGFcGRV0CTUaAAUaAehNRtsC2b80zVa+uOeOj29wv8e56Cui15B8Av
X-Gm-Gg: AYBFou0HLeNQDWe55VpSk7TCV28Yv+oYpWdNASmNMbJ1NfpQQGJb9OBjmAGoAPeMvDI
	F286BMJlMbt/TeisWpomt0HifnHbxqZ507IXRGgosacFJEisuaMF7Jk5HpqD8r0xhoL6ZcWoRVM
	2NQ6BgS5ez+r4x6fyCeoWsgHYMR3/ORHqC37Cn8gw/CKaOgZefTIX/Lbgc7kJbXItt3t7oEq7Oq
	0BHIZEceLsVPuIAeUKLFN07gATEfM+ynPkekCDMUgttxnUyUd9P0/Y8jJrtBtkTJHcI+50/oP40
	VWHSmmVHStDeZfvHqPEtHcqcjXrLp3x2/CHBeyyerJnbi3BIJdSak2M4t+i2b2bE6XEK/AcS8L1
	bo5vpzVNMG5juRShvp0AfMSUaHJJfvTcGCcaR4NiGh8JOj1PISBiL3E+DX1xS/xmoYKEA9t2Yi0
	ZvBmmdkTOJIKm8LtF55ueGoHShZY0PoASy9rynOvhvDhXuI2NV004l/TwYL2w61ETJsAFR6g==
X-Received: by 2002:a17:903:26c6:b0:2dd:6cb5:77c with SMTP id d9443c01a7336-2ddb69ce313mr200894355ad.2.1789993562471;
        Mon, 21 Sep 2026 05:26:02 -0700 (PDT)
Received: from LSSP.an0.nb ([47.82.118.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179dbd5sm33198445ad.39.2026.09.21.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:26:01 -0700 (PDT)
From: bruceli20040604@gmail.com
To: dinghao.liu@sdu.edu.cn
Cc: Guanxin Li <bruceli20040604@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fpga: region: depopulate child devices on remove
Date: Mon, 21 Sep 2026 20:25:56 +0800
Message-ID: <20260921122556.3418339-1-bruceli20040604@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanxin Li <bruceli20040604@gmail.com>

of_fpga_region_probe() populates child platform devices under the FPGA
region using of_platform_populate(), but the remove path does not
depopulate them before unregistering the region.

Call of_platform_depopulate() before unregistering the FPGA region so
that the child devices are properly unregistered and their references
are released.

Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
Cc: stable@vger.kernel.org
Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>
---
 drivers/fpga/of-fpga-region.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 9107a5b461d3..eb62427705b4 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -424,14 +424,14 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void of_fpga_region_remove(struct platform_device *pdev)
-{
-	struct fpga_region *region = platform_get_drvdata(pdev);
-	struct fpga_manager *mgr = region->mgr;
-
-	fpga_region_unregister(region);
-	fpga_mgr_put(mgr);
-}
+static void of_fpga_region_remove(struct platform_device *pdev){
+ 	struct fpga_region *region = platform_get_drvdata(pdev);
+ 	struct fpga_manager *mgr = region->mgr;
+ 
+	of_platform_depopulate(&region->dev);
+ 	fpga_region_unregister(region);
+ 	fpga_mgr_put(mgr);
+ }
 
 static struct platform_driver of_fpga_region_driver = {
 	.probe = of_fpga_region_probe,
-- 
2.43.0

