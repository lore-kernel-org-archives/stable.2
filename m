Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDEE538D8D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991174; cv=none; b=QqaEN3IV+bObbXlzWlVSw5vryK3bC5jicRheAba37NOU7LTcmAclrUNG0jVMbh4CosWnxBMM0sHv5tkwRvD5acwvZECjK5P3CRrt9X+QZ4CfHlaE4tPMjJlodQLcogS1tcP5VeMkZG7oHJfSgSRySlxvZmzbOJ0Yaju84CM5O20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991174; c=relaxed/simple;
	bh=WWTcqcrYuK6IbdrjMRhsuwFkgDt4+Cy7tBLo38z8uik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocNEMG6gOAkqpWylSi4nscUw0x0J4NAhbk5z29cgixFo4/JmulAtR62/qPVLANmzN6HPXnW4JSQUilEx1qa+h4DpgeCzH8PZpOjfsQd2BxDY3G8oxamb9pAHsS03c8U+FbWvypfFAb9KpBtqHFpbDlen4fXjHK6ecTBtOun5Fo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=oaIsrMwy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="oaIsrMwy"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so649836a91.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791991171; x=1792595971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=oaIsrMwyko0HylMxqNY/z+6J7Y86zJaVSxuKW/5p+83+xLwwbZbX3cIjsvT0E6iTU/
         Sts3ykYSzQuNISmhdaH4ePVEHmb7EZW62JNqr2PZcr8OaIL2Tw2UBOS3i0JfrjC8Xf3f
         /PsLd+fc9vKMfa4D0oXjDx5MEu2a5W0ampDeg24BiRXDjveXffcgy2nvFqqdMWwzfDaW
         HwuR/HkLjrtNPumP2FedXNjEfD6oQt2TX2a1Fc8Hz8WNUqvQM1ufUNZg2/SHb3+sZBja
         hfFHkyqKFUMjmIVn8EdYuNZLa+K9JBryI5+7Hdauj5S8NO4WOxa3A6A+O15xY7w6u6Yw
         xmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991171; x=1792595971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=IHrUpaWIjNhOTi5eyGU0Ttmxp3BcjVJuSadWMSzRjQkI7lE4h4Qdpqlun0REt0nf1F
         iAPjtkSEMu5wGCOWC72dq4kdcf8JvsD4FmNRyXXKwYkf91mLNeDqyqRIkjBVOKlJjRRg
         ISUs5OBSiKGGnemeXy+K7+gllgCQi4FEN69IV2namAukJ5hNK/x9PL8E581Q0EDaS/DT
         0bynmcfmH2s/Rtz0UjpU58R7HkNNifowgvi3/a7b15Vh/LCEkyjW7ic3fZAxwgCFy7XP
         TFx9AhINq32IqVZFg4BWgZeNzldGgayOAOp5KXbVXyr2MYlYcg/yeMCOWKbhWpN36IkF
         azqg==
X-Forwarded-Encrypted: i=1; AKwUvBxepHQmtxnCOR2PkvmN5H391MRF27VAVGGqbaF+LzoLECjBUCSnzOmTrVUqmJyW6BV6u/v8aQI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLARKcHPvs5FOoJRE1UhMRPpL0Rc1ewN+izIo6avVoQZbzi1NYq
	EpGqWnB4EE1eLa040AEt9Qg6qnLwa+d91fpgqoqSNs/c+sGVO0hHoF8/1vaodqzKe08=
X-Gm-Gg: AYBFou3jqkDgk3xEa+OSilc5fBSQXiBPviOB+GCSG4t2CNeyGg4Bcy0X+BXbn1uxC4l
	CXL+WyLH/4fHvBatDm4UnmXVToFnchdbLVB+XPDt2wDwR2Ginoeks/oYdhit8p5yH4TWv4FilF1
	r9EGjUv0ZBuajb4+8zlRJKyVQbbS828SZPjqtmlIhClPwKwAlQ4h/bBMc0A+b9DRQDTvnYqeS50
	22W5O5tyBYZeJz/DcBxfp1rkQ5T+1HkyhYE9SDWYcuvY204uHfgHDX/Kx4ZgpQSllStVp7pAgk2
	cjarZpriSJcUAayv725ePOPjtE7ImGrA1o6eeA4A5N89D1MbVWHy9uQADckX/rCFGWTLlLtdUHT
	FaevxTpHz6ek9Zl/9KiFpNZj7JL4MQI+nvRiKAZz3ip0A/IK8CnhVw15g056HvPqz83FdIk3Wnm
	aNAScPFCnW0fkTB5+AMaolTGZUWu7Zx+/pNGVtUGSE7sS3vOn0R/2bCtbfSADkOm7AO1Ih3h2Xr
	U9n+DkWXt8Ie9QLLCSE
X-Received: by 2002:a17:90b:524f:b0:3a8:c0cd:57f8 with SMTP id 98e67ed59e1d1-3ab3a239c2fmr12717993a91.4.1791991171274;
        Wed, 14 Oct 2026 08:19:31 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:1c49:61ee:8c8:3f4c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac8d40e7f3sm622450a91.5.2026.10.14.08.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:19:31 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v5 1/6] scsi: mvumi: bound the per-event parameter and sense dumps
Date: Thu, 15 Oct 2026 00:19:09 +0900
Message-ID: <20261014151914.3632701-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014151914.3632701-1-yhlee@isslab.korea.ac.kr>
References: <20261014151914.3632701-1-yhlee@isslab.korea.ac.kr>
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

