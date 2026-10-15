Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A52DCF46
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025858; cv=none; b=X0t1TBeqhVwSgp7Tmoj8HgZcBp0OxVSsthTmxMSJXTUuy4YkiEiEJ7hTUeTteo9nFSGIOK/m7qkQ79p/dSzxhCHnQH7d7TXSlPAqlnZ8LbxMGb48NWdVeLmKpfAfwW1XIO5iVuyHmNY5eGUB1AKPZytCp8Sf/rlpY1ef3uPoMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025858; c=relaxed/simple;
	bh=WWTcqcrYuK6IbdrjMRhsuwFkgDt4+Cy7tBLo38z8uik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eplSOF539DE82Zo1yrrtOeSpkX936RX3JbmBJqRuXyy+L8sISEZOSYkDXOdumKz5cAVqrnOr5GxesUupSNlMcyLPBV5KJna5OJm/kO+nebFBdnUTpJLIFCzjob6WOMmakejZkSMYk5fpdC4Qq5iibAjxbDnwAEQtljuPr0JVdRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=TEYYofoP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="TEYYofoP"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab98332238so2639950a91.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792025856; x=1792630656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=TEYYofoPD2E+QW1x2bOy716DFgT9UFHODVVVdpRlrD4pDfC0k4S7eqvG8cUAdhehyv
         SPGRbmUCbK39jxgS+ZWNOO4AK77vnS/sJ7hnDMOHne8swW66KePsvU0rAGJEd+zVqvxY
         mrohmmyacdp3BCfxqoKPHz2hivsnqf/zv+AtmbzhTiwMMt9t2WrCbjVsVxcAQ1ZbSNBC
         MmK9c7Ed8UcGgRQYm3juT/zAlkliTjaeZF/sVo1YV90yT4PT2JCV3rJE7585UVkMe/w+
         L5h7lAG0NnxEqFvStAj6EgWCZeXa7qaRHGqhjoc+oAv6Rr13TeW6ewxi5kJqIw3sJKNs
         wCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792025856; x=1792630656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=R2g/ztH2vK1mic3JTjaLZgtXBNU/j6tt7L5FHxO2hYJ5a4e0+rL+8qa1QK7oscttkU
         WfogwcjrMziHaUh5PLKol/8abH/M/WUaDYf2FKmJx7qD7tagalBTVMdiCjdLjFYFiqtg
         HrRBpMIf+194UyJgh5Uc+KmHsTE40ldWBckSkOaqw/vqkq0IRSm++HMU0kjEk7d+kCy5
         aMifuoOJgnhlRKUHXwEB8c3ojGaCMr5wxQ0xdmybaKh0v2PiyBHiRmRohxCd5g+zKBEm
         8ja4hKCyrEUhZFokc5ld/w7d1t+GvlaGxO4IyYgxzrgfRSfDByT5PSltX7dv/IuFOD89
         PVAw==
X-Forwarded-Encrypted: i=1; AKwUvBzrbSnuVOuhAcTeQa2zBnBDS6ssiLAqXNL23g4yy5gsRYnilFKJJhMIKBGbf6IvDqefcHJhjnA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6PXjSpVxUVwwMrQFMJKnAJgfSFhU5Zzkv8rE1RSegJCW7yMn7
	QN6N17HoH//3Uyjrnczx1EZp8PHu6C7FJMKEBmanUSVofnTKei6oX+mVXe46SlnMlFo=
X-Gm-Gg: AYBFou3+1UXScdgnGymeD8bOP8KxHSsHTVDiA3OYLQckXT3doTGdhCylsSWCwYymH8s
	IU2VwVYhGxDJht46IX2H/KE6c6paj5PpJ8rhvkY6T1VhzJP2CcwYCsshj9Vi3VPqpY4+E2aNKRY
	PmRx7gLSLT2a+rc7qMaX56+GTXhnGlSglLXaCv5rZRwMQgT+18T0UeXF2wkLChaOt/wpDgRVdOT
	vyqLkEITx5+yVoUK4N3jEZ+9d0YP8rWLSgKbQd9ftw3+BApXs9FF3RH4iJh8a0YE4XzLBHArbx5
	NM1iF2gKe8IDRf6v6MUYdkkgvpbG7hjCCfUYgQhqEtBogmRnv3iPMtfejxYZFgT3P/8W3HvOYz3
	yODCpSf4Q+4p9qGrV6dEOh28AdTv0l7sL7t0rJr+aaiawLKyiWDbGy0FiqnPpMXgHPpPCAqFbZZ
	D1yO7ttn+7guoLp8R7vOidykriG5fva38SKI8sU00keYL9UcnK73mF/ajGUdWFFq3bgZAWPAmry
	h7jaWDruurlvBI/
X-Received: by 2002:a17:90b:5546:b0:3ac:4e76:36b8 with SMTP id 98e67ed59e1d1-3ac4e7636f8mr5066203a91.5.1792025855959;
        Wed, 14 Oct 2026 17:57:35 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac92a43d98sm999198a91.0.2026.10.14.17.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:57:35 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v7 1/7] scsi: mvumi: bound the per-event parameter and sense dumps
Date: Thu, 15 Oct 2026 09:57:11 +0900
Message-ID: <20261015005717.3719956-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005717.3719956-1-yhlee@isslab.korea.ac.kr>
References: <20261015005717.3719956-1-yhlee@isslab.korea.ac.kr>
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

