Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A6488D8D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912720; cv=none; b=eC4hXMxBErCiGZFghqbPHuAeGWDRpaZD2/u1Ru40zB7d8n8WKQKOUnJXe1cQuVLIM72SFSyRs5ncicAeK2XTcjE1eg2nyRFY+Ws81H9oxrtiUZqVZqqvBk8pSqdC2pT077WKdxmZ1Gly1VTWgAigr5hEpMiryat/pcYdieU4wRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912720; c=relaxed/simple;
	bh=WWTcqcrYuK6IbdrjMRhsuwFkgDt4+Cy7tBLo38z8uik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOcNhnOaUhSBORuupR46IdAqTTyktE1YBq56WhGMJoE6fZMFdmd6nRK1H0q9yMicp+AZOtIKiQs6NnKf0+e/aGThGzDvX/S87DtMjGDBmJqDTz3Dxmsx4sU/OtzgbGlMM5FBDma9RvdVsCpx2HCyG2DlNh3oOQWYf+vxqdGsadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=PznwGQJd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="PznwGQJd"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1912677a91.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791912717; x=1792517517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=PznwGQJd+Zg5hqt+wtLBHz8nIdnKFSN04lKF/evhNefGtdkydtLpWcgj4Py1zvg1AQ
         MYQbFhhY9q3zRp29YjbzF6VrseL81TI+aL3b6RDlQNSUP2BGrx06giXuBCDBVvzWi633
         ZCNJOqydrS1yzISgoTIWkc72z7XKcwH5xsaOF4VYy4Qq9hjVE8MiVcEiTEVai7S2mLbQ
         9jtb+0K2NB53HFS7RtmthGDKtqgKIEIQ30MSNWw+yEHGpRnbnv72Wb27rikdr0Biusnj
         pDVE6B2IaOhZS7VSyyH8WpSteWHxdrXQH5aGkOmWdQATQauFSuQQSRK0EY+wSmazYn2P
         99ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912717; x=1792517517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=rYorDcNpTEoMbvy5eCfPzOyDZ9Sy+muqC8wb7qmxdHMV/GyDkItJMnsT5+nK/yom+N
         aNNVxgwl6z7KasomXV88BaU1gfr3huCcRoGxfHIANDzN7ycvUV2v1wLpK6j9v9sMzWyr
         2GFchC2fQqMqny/K5+Xn+fNINP8wrzFCqbPk9oEOWR/RPLv9IQgltWVGnAH9IqcgkEZH
         ZBkjMJ69uQmwdht0Cvg2lAWs1UauB2x2Z2iT2ge3OQheqTfY4PkUwV14N8vldUomYlho
         wO2bg+MrHkd5iX6zft8aXoOz2wvdIJpd39gktn8m8hxslJMDKxCj58EA+f3wt6774Jq8
         sVqA==
X-Forwarded-Encrypted: i=1; AKwUvBy7Fa2w252V32RBFsB4OIcx5Lv/p4iTmttK19ToZS7xWPcf2KPq7qsIg1q4FDuh/+ZSdM9LVus=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHYprz3YOymhr/TVxKI+D8TzR/DhDeHSLfdbwGMe/9Sw88NBZM
	4qsgJzfQJn6Q+79d+rLTcRftryP6kwaaJD82/dj0kNimr4J5BZ9dmDNRDFU3QCdijG0=
X-Gm-Gg: AYBFou1NDhWAQ21FjkMrrWwkYom1oKjXODVAqEvd0uPU4mmvxFDjcb0KEIxSHcNVJMW
	swtXi1XuOh4dRFJmi1FS4Nuq+EjZ4teM/XzRBjqDtGh3G6/57JfgFGIkfBHB/JV5BMmItno2/fD
	eGpwGGwnKpUJAamcFbcMLfGjsDj+OFr7mKN3PDT1oWbL4Z5kjo7OSYG2S2eb/6BaScEcsOxtmCc
	v9Ey49ZpVoAxCCO3o8N/RHoSAYCsZNDt3athTkaoV81R679vXr3PReFbjgsoMkNnLDY3fkFjihx
	KUWRlRU9gIYV4qhpwRVm1CH2Im8Z2y2KHwrdTxkQWCVAepGsy1rzD2yvu56lBHoiVAxgkePCWh4
	MPtpWoMYpa1q9XNHJLXphQ+y/oSIHwu/4IdllBOYPy9+xE7cpZCiVjKY8DG+eschImv6SSQ/d6I
	4Kwn19AgHUX2SheFas76wue/4DLi8weEHbewLiWBsuq1i2zSgg5VAQNobfdnBlQ1V8FOAAtls/u
	9BGr7r65xy7juZMlAmD
X-Received: by 2002:a17:90a:d2c7:b0:3ab:1b19:78f0 with SMTP id 98e67ed59e1d1-3ab3a8e1d1bmr11092955a91.41.1791912717265;
        Tue, 13 Oct 2026 10:31:57 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac6019ca59sm607396a91.9.2026.10.13.10.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:31:56 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 1/2] scsi: mvumi: bound the per-event parameter and sense dumps
Date: Wed, 14 Oct 2026 02:31:44 +0900
Message-ID: <20261013173145.3412863-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013173145.3412863-1-yhlee@isslab.korea.ac.kr>
References: <20261013173145.3412863-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_show_event() prints param_count u32 words from params[] and
sense_data_length bytes from sense_data[], but both counts come from the
firmware event (struct mvumi_driver_event) and are never checked against
the arrays, which hold four words and 30 bytes.  A firmware that reports
the maximum (255 each) makes the loops read far past the event and past
the 512-byte buffer the event block is allocated in, printing the result
to the kernel log.

Stop each loop at the size of its array.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index e70d336b4ab39..38a92f8c25f5b 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1361,7 +1361,8 @@ static void mvumi_show_event(struct mvumi_hba *mhba,
 	if (ptr->param_count) {
 		printk(KERN_WARNING "Event param(len 0x%x): ",
 						ptr->param_count);
-		for (i = 0; i < ptr->param_count; i++)
+		for (i = 0; i < ptr->param_count &&
+		     i < ARRAY_SIZE(ptr->params); i++)
 			printk(KERN_WARNING "0x%x ", ptr->params[i]);
 
 		printk(KERN_WARNING "\n");
@@ -1370,7 +1371,8 @@ static void mvumi_show_event(struct mvumi_hba *mhba,
 	if (ptr->sense_data_length) {
 		printk(KERN_WARNING "Event sense data(len 0x%x): ",
 						ptr->sense_data_length);
-		for (i = 0; i < ptr->sense_data_length; i++)
+		for (i = 0; i < ptr->sense_data_length &&
+		     i < sizeof(ptr->sense_data); i++)
 			printk(KERN_WARNING "0x%x ", ptr->sense_data[i]);
 		printk(KERN_WARNING "\n");
 	}
-- 
2.43.0

