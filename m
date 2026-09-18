Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C844064C
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754535; cv=none; b=be7w8Xw7itd8IKqES0LVL7XoGZUwL6Yei42a5Qeaz0cH+42p0lJ7WfOTnD3aV6UvemM0Blz8nR8C3lvywSiy3PeAIIJHcRxJdUVVJgz82pd+yU6wJ4GnPnTE55juTKSWshQlNzLRebkXcl8rTk53FUR6sv1M2uH9Xx1yrER6md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754535; c=relaxed/simple;
	bh=2ywI+x99AL1vVsJgsYse4XwvQoMzKOlrEMnWJuVwfm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nP3sCQcXeIHs+s8eOgZiee5m6vsDU9jwLZGHZOxQ03DvtnCzX02y8YLZT5pxqT6QXFC7exm2dvuwIFe2PGfPfFr1O8oRY5hLIo82xPfmTS8XGf/9G26rBw6m/nZwxf12I50weQw7IyJGhdbrO7+ec8+BFWyt05ECXvBrw8oOP9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUKg6Iwt; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUKg6Iwt"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so932171a91.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789754532; x=1790359332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p0aRkG/STOJZPyiXgGevwP+glg/s3VjB+O2AFDUKik0=;
        b=HUKg6Iwt7Fmv7nhI+bv25a+k4qi85ouKgXDnISeXtE+6Og4GAP2AXh8eHA2Ic60ZGt
         QtJy4qOFWLGidVISaIxKO1eaMYAwKsXnzaYnHLeAvGfgzyvcJv98kYlFbwC9Y80U5Jen
         oMNJutI/qa7D5Lzvcb98Q2kc4cM0ZFsXdqv7apuu/uGXb++gWI4VWOIzQhOxU29/q2Vl
         qLKraGVGEgCHGKBCG2PFe8kjq2L+Lm8fZmUOsmsvkTZdiym0H0YnLNvresFiDv8znbMg
         okEUWyor52lduVfzpd+01c1BHDVY7xgcm+zkFuUiIgB7mD6I7G6W8oGLjWNy6boyhjfe
         f7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789754532; x=1790359332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p0aRkG/STOJZPyiXgGevwP+glg/s3VjB+O2AFDUKik0=;
        b=lJPBfUH4thnSFvxl/PXwA9lLbYAQDRkddKTOAWXSnKeJZ7L5w/Ubk8ObPB1zyIi/qc
         MsrQ4qca77eiZGRMBGc76mk/ZHftea0MGGEFPEYmAqVQzYm/UQUPfCby+qCL+V1sAFsx
         YwjRgqHAl5U34SvUIcs/g5by1/DHHunUAhgOA0YAwxpqt77n8S8lGuxjf5MwOO1gfuU5
         CPkRehCshjPLIz8ESrJy7w3gamJu1vhtY1bKzp+EQAWhcnrEtxqhbGniCPTtnb2Ejo7f
         nrtEuTxxpgeijgTq/kB3LQbGd4thXC/TVGQ+D13uyxX/qbkmKL6Qey9+FA93qKI2Vc7T
         K85w==
X-Forwarded-Encrypted: i=1; AKwUvByr8a8cW+hDLwiH3P4Aqcpimjd1Z0wsPxcOIQ8CxlXr/eJuyoUdXCTAuDJCRWuvFmY4MZnvpLk=@vger.kernel.org
X-Gm-Message-State: AFuF++nu2Anc3hxom/6wANzgqWHEj+vhLKCvZQ1NbEJ5Uij/bLn+6gi8
	GHf2zY3ovmvFz0P0G/d2IxRRjkSYQVaErmTCK33aAjky7CGJ6mbNONUm
X-Gm-Gg: AYBFou2dOMddcLSR/Atl4DgChs+KQD8Wp53CIomSLCyIVHOfYMRVQPFW5qaBjeOl4A0
	xh1d2I/uss3y+NYMIKdaZn2kO1R4p7/52aPxmhZ+dVF7PtUuPSrTaJrWiDbFBb+pat8K1BU2N1d
	+ZRU9hErM5p1Prk7tTq+w2iTQlVyjSm+AiDWzILnbT/US+cMJ4I39UIuk6VgpS8s7PMwaci5ohJ
	1Mc5e8MW5BY787aJ5Vp41XuexLJox+dXu+w5lJ68jWUMGU6d0RqAayvMTO9mVxsXY5DDLiXpt/I
	ntq+xwTlOW00xrG5Pposhvj8vdAhGtjNQ5U2W2h5Z2G3iovbuek/PDM8lvkJqfeBJJo7dot5Uhi
	tVxITcb+YUrz3xciaLvAhrip5W6as0HK9VNJlOh/0Cj8W+BNZoURumcWJGiro/b5gEu0PSYcsQI
	zIX+8sd5wc1JLMJRzpc9L/jGxgv/eGENgrqhn9vlhch34gWhfXFGnV+Q==
X-Received: by 2002:a17:90b:280a:b0:39e:2530:2102 with SMTP id 98e67ed59e1d1-39e54f4221amr13366348a91.11.1789754532323;
        Fri, 18 Sep 2026 11:02:12 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e554e5529sm2016932a91.4.2026.09.18.11.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:02:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: zorro7xx: put SCSI host on remove
Date: Sat, 19 Sep 2026 02:02:01 +0800
Message-ID: <20260918180201.3624568-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zorro7xx_init_one() obtains a SCSI host through NCR_700_detect(). The
probe failure path drops the host reference with scsi_host_put(), but
the normal remove path does not perform the corresponding cleanup.

As a result, the SCSI host reference remains allocated after the
device is removed.

Call scsi_host_put() after all users of the SCSI host have been torn
down to release the reference acquired during probe.

This issue was found by manual code inspection.

Fixes: 45804fbb00ee ("[SCSI] 53c700: Amiga Zorro NCR53c710 SCSI")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/zorro7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/zorro7xx.c b/drivers/scsi/zorro7xx.c
index 21c769dc1ecb..a8b0c2d4a9cb 100644
--- a/drivers/scsi/zorro7xx.c
+++ b/drivers/scsi/zorro7xx.c
@@ -164,6 +164,7 @@ static void zorro7xx_remove_one(struct zorro_dev *z)
 	kfree(hostdata);
 	free_irq(host->irq, host);
 	zorro_release_device(z);
+	scsi_host_put(host);
 }
 
 static struct zorro_driver zorro7xx_driver = {
-- 
2.43.0

