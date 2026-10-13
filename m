Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445D515985
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908194; cv=none; b=G8aa7tXFOEmDoQ+uEr60PNCwYG7QA/v1HkeZ0/HPLNEvdnrJtgn/14R9jP6wmGfGj53Xhh5FSbDV4AUcK4hC70BYAEI/4WeMAKl/1ccRcozaJTa8ovpNQGUcvqOt9YAbBwJUBtVkUIi+Mlegnz+5Esk2PBheTd4Ckw7AY//JF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908194; c=relaxed/simple;
	bh=WWTcqcrYuK6IbdrjMRhsuwFkgDt4+Cy7tBLo38z8uik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWPDdjWaRThtazBBgKVJEJE2a6BMnRXZcax7vF3TEUyvN9WCccWci9R83FdnpWT//6wt609jyo4AcmORUVUH45hlHpHgdnzH2ZEPad0ld7kTALnY5tRgd9pxbXlJRzYWWmN9KiV/5xJQrl/UYunRee8Xz1te+XneHAd7u8l4m54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=WniLjSwq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="WniLjSwq"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab3260b35dso1974743a91.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791908193; x=1792512993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=WniLjSwqHaaK90PRDorbuWVsrXkCVE7E6CePnaPF9Tegq9O/LXnfB+c/Tf/hrBhz+b
         iR47vmfdpBtjGY33i6HFk32+DHlpEdjhdj6O0lrZpOzbugAXrnIZd37rmHd9alSdNjgs
         snpSkm9rcYFkKnSfDG1EeSIQId5bmuQEfDiZda3SwVyw14NoD7gqji2pXypAVCHdmtND
         HfbzqtvnsEsFamitmV+kdsU4RsNCXFsf3+RE+jh+JTYsHhtlngIpujbjo6mPPBFcDxI9
         NMIoxH5nSTw5UDegl9auNbebfb0TSfUi+BehE+DvJntc6REzXAkDI20MWbnEA+5eC0hy
         GQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908193; x=1792512993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=OYhRwuhCqtbVdsanPmAzhdRV+7WWnoDj0AE5RQmIZVH/mbLE7PlakL8KWxNoDpAFfH
         6VjrT09wf1plT5WPcg3Syy8ZS0Jce7BSXAlpkxN5xkS2jWt0jJKIwvw1pcK2zMkySLGy
         CYKbNm1AaFYBSIKNbHq0ckVXY2Tn2Kg6wgOmCoT7w/wcZ/dGBNYiN/WGd5N0q52MZcfE
         etyClEBKWOBh6As7zg9xFxdyunxSjEmd6f+uJSAuPlbHGT1Hcrc2tiPDBt7Usal8X0J4
         ThJl5GDN6l+XAK4m5mN2cwe+9FK4jCHqYEr+ResozqScvlH59rCrAhQknz4c3sK8BVh4
         IasA==
X-Forwarded-Encrypted: i=1; AKwUvBwwfa2bBEBqU+zs+TcuBfUwN0VRTVEa89kyAd9OYeOsum4zEHOEO3YHeJxItYwV3SasY44aHgc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/RyyGUwyE5mg8w7BO4k2wpOI6pHivfFXOsdEs7DmhI7XTPPhz
	icGLz3fHbHVseT+jkk6sAPL7HCij8aG4PHNTAlCBYoER1Bp4ZbIyGUhPEG7yLmIOh6I=
X-Gm-Gg: AYBFou0NaMpSo6pQfB1+WCCoopSdtrnxHFPNcR8nWBXuF11u0m1dQGR/ZmA8JKL7Dba
	0vUZ1b3JYASK9OFVEPfiudLnZk/y84SjzME6Gl5B4JfyYs8uBGOPlqBfLzMFNslhm0A7wXYWdYr
	cun3II1u2DdzbIkPEvRMWmwkliywQVO1CYa/ZhsmWrGMzM9UpWmiE/ZaB3vLS8VM0KcxKVHkW+F
	L74yCdXMbwHodt4yeXc5pO8ARDpaZVJczqiyuQYwDq5dYRzH1DEE46rJlYfNK8Htf7pcp4OFD9B
	o+Y4g+1JmHrc9yDOM4i319XnMy2NlmA57+6+sbz79AZB1ixrcsJwVP06w9APuvStHwFB+Oj4RDh
	xN11o13fU+n2TtUGQIe4np2E7bhyCZhrcuz4Qcuy2OXKDTz64G3j0XaFXMHVWzk8LQSBVUstbPD
	Ch7uKwN8nnw6QlyCx2tgl8U+k5bFL+/Cyj+s4Q5zCNiK18twsHkAcmx4KMcaccVdfmz9EQGrj/o
	POHr6qjoVSlekDkG6dt
X-Received: by 2002:a17:90b:48c5:b0:3a4:b418:94cf with SMTP id 98e67ed59e1d1-3ab3a7366bfmr11829012a91.14.1791908192883;
        Tue, 13 Oct 2026 09:16:32 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac600642c5sm202607a91.5.2026.10.13.09.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:16:32 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH 1/2] scsi: mvumi: bound the per-event parameter and sense dumps
Date: Wed, 14 Oct 2026 01:16:19 +0900
Message-ID: <20261013161620.3210533-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013161620.3210533-1-yhlee@isslab.korea.ac.kr>
References: <20261013161620.3210533-1-yhlee@isslab.korea.ac.kr>
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

