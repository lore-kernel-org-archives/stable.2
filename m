Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25F37B00E
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 04:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039947; cv=none; b=iUlSWDqL4cmdrto+vAO63dN7Cs5L7Ptmnvm6ZF2gwFfgam1oO/Nj5pWEP8/YcFxM+/EpNHJ4EvrTCtS+Mlsmc+jtwmw+mua0TkLxR45Va2bVp4QOf2D0AEcuX5SHFjN7OezE/7xCtrsQSCHOD5F6vqV1pYfi/Nmeh38QFyfeX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039947; c=relaxed/simple;
	bh=WWTcqcrYuK6IbdrjMRhsuwFkgDt4+Cy7tBLo38z8uik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atYPHDzJmqxrXRTW2KRcUNGlkGdoQ2FpgfR9i70JUJgtAJtL8tL/c7qgyaRXYRu6XbwWY023zjdSs0ug9rQsKrn25OzARI/m9kKLAegqd9uopsJsXN+4n7T71VTQHWlIw+L6zok/orVVJ6Ywgxpw8ruqZJx/cNifQG9sDh9BUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=BRxle6Tw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="BRxle6Tw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e87c66e556so20782285ad.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792039946; x=1792644746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=BRxle6Twv3EncK43uTlOiMqD9/jSn36UJKU8jSwbU4f8KWEAshuuht+ECpFKtTfOtF
         ClwEeJRZXmweHl9o6lxua/zYJJnxtiaRnySOiTDwnJvYtsKUspQjXRM4UFZnwbf4y2PV
         R64KnozHnYHFGHhCVWfLZcKBLwxdorAaxzemrcPGbYcqBVOD47Blz0szFj8137WEUthZ
         q2ENMrGTyPnOBdOqfs7TH4WbieCbIN3U7LZWWsdhHjb2s5OxpL7MVSIaGC8B1w9xntBw
         9ACtpSn1OCMsbhapCA2xpEgkYhh1yaXsh/oQ1K1MxXFev4n10aBKVUvPMwVhqvNy2Qc4
         gbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792039946; x=1792644746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=AWG/8ZAIPpSP6D8ytklLjg81In47O16BjvjVsYfjmMX8Y8zp5Xgn2hOkpiBP9X/Ttf
         c2jgcvRebw3aSNQLBthFWR9YDekwzi+4J5Yv1tNt92YmM1uc0eJQgntjU0W5ts/Ae6ZP
         llbKbGztdqy7xLjMZ8OmYSMgZubvViLDDixWbHF0hzN4OUhGIO4rMJZBm2NT6QpOwySP
         et2J57i7Cnr0JBw1pmQMZmPCGpR9V1SN94A9MU+Mk21O3sl2l7RMohiPdv9jPKymZRG0
         PJ2f2rh/7jeKuSGzW8EDWUorzs3lMMVQwKjwC1Nghofki8zujhtrZXywNW4FZBlRxi6v
         gTXw==
X-Forwarded-Encrypted: i=1; AKwUvBy07V5c+WJdCHv+KstUtAzUIb34TQ35UXtYfbLKTB4GHgdXTPzaFjET8a9Sxu67E+r7sWBFsJQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/Ab43XT04UeCHOx1HY3tM8FqVbml69QoCI3AKodoUZhGkbo1R
	bWt370pQ1d+cV+oq0OfDWvMgaU6qjjcTA/a3lMuDeWx0PCdZUf7iWNWYKhS1ZpsjAXk8wrEnRXd
	pzFpT
X-Gm-Gg: AYBFou10ya6uGMQfyR7N/XQqx+EcPK2sqiscm/DipjNiXpC4a4JbemK+6TxmVWq953W
	rvFHgyuPbPB1eVTecprtrU+X7R+BEMAoiqNXHDLo/w4GFWIRddIZ1hXnBHwbUpjgQbz1jTPe+6A
	GGnqV+2YjrSp0o9Pb5lL632RA6N2+ju4+Spr1AnbPl5uuqHwVU1lHeJpkH6Uu6Htmleumm3Bq7G
	tayvCrrG3ACsZvYrZ78LvMNxL0L7sLHbyY0YaVIQ2oykY5REuPmSA3QK/MPO4BzDr4mLaFEEQOC
	UrfcAy0HVAfJYh6RKbYXREJJTrj2GrJPmmFm98BbC+BqoYYINSifoGSMQ85NjTeO6Mu9sIEP+HY
	oJBDMID072jbtZMhLx2wytUEYvSSi5Qddev80fU4ugDIXKSrPgmNsFI5XRoSzLt0+eSKLZ2mtje
	DeuRwrg5hYJk/4z5fHfss2IUNTgDjID7Fmxu452UrRohTD5yNR+cJFPM+JBLfKOtvhiibhLvTpd
	javLA==
X-Received: by 2002:a17:903:fa6:b0:2e9:5876:17f1 with SMTP id d9443c01a7336-2e958761a2bmr9322845ad.23.1792039945776;
        Wed, 14 Oct 2026 21:52:25 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e962a4dfbbsm1615915ad.58.2026.10.14.21.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 21:52:25 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v9 1/9] scsi: mvumi: bound the per-event parameter and sense dumps
Date: Thu, 15 Oct 2026 13:52:05 +0900
Message-ID: <20261015045213.3975845-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015045213.3975845-1-yhlee@isslab.korea.ac.kr>
References: <20261015045213.3975845-1-yhlee@isslab.korea.ac.kr>
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

