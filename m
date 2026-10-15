Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE893DA5BA
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031265; cv=none; b=VIOtxboI6sLLmoD6KxjjPnn+Ffp10y8Nsy3iAVr/P8g74zd2kCRdWs7uR0Cx/v2JK4x7aNYDC79l9MFfjBncfsGObTg5afmRI1UFCmWG6kdzgpBjT975u7pxV+Itv623FAYuU1Ll7edqUM+diqdKDDbdhXVVfcOlNpvF2Goools=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031265; c=relaxed/simple;
	bh=WWTcqcrYuK6IbdrjMRhsuwFkgDt4+Cy7tBLo38z8uik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/xLBz2G5Udy+ROj7JEuHm6e1GDcEi7DGK75iFFnx2kYcrMQp1bX0t2WVTlpWFpMPzbZRporCqeCyJae1lu8Vo64RBLN8KqQVwqC/OhLG+1CL2cua4CAoD8gTz5wTOjKRW3ks/nLrsKonACIc9oljGwwDRDbG1aQhYIOoOe5B/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=qCQbx91W; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="qCQbx91W"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2513758a91.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792031264; x=1792636064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=qCQbx91Wao8/zehzBBOPBoU+aNUmMxQ7s+JLYzrY0hZeX5zSLr8fqnyKKTcdfWn6vi
         K0QNzMjxGOFEE4fp+n/Oai5PMncwe+rNrvClswOoKPNb0+Jb2+xMNDU9WAVh/W99jEiD
         eYTNU+dGnhaqRgn5GE4dHqJDqClZM60axE3etGP1aEVWh20iJ3R3WOq+8qrM+JJWvujE
         oDuPKbuUYKi0eq2rUmWR06jm7ryGG9fjJBQS1uZ5z/seUdeG+acHf+S/XXBiLZhA8zfd
         gLDiUphDjxT+gEeGdfkYocUrbMNgc/VfRcN3bjQEZoyysHly5xfYQH04QvYly7HLrcJz
         qtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031264; x=1792636064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=20/6TMQxsaibx0PwVyyL6IZHZwUXVXtgOp07oZchioPvsdTGsXfj2PfW4ixecuz7vG
         NJ9aFdwBC69vOAYNWIi2xPHmIQmUgGSfQW/dfPujgRE2H/cSWTz+3DArZTpluD2TKJDN
         do0KtqoENXKbWXDgJHdSXRb/88L3g05ZsfaaFUoS5IpE1uLmguysollhKbuJRW4HiURq
         96oTRuHGx1o3xWncajYHK8tQx3fpCVGqkSWSA1g8hy1FJ8tGr6qZ83ocuEjg1TxQYpWR
         S4BZcyC+I8PoHeiA9V0y/Rv8hbDxRspJ+ZoByrfmzN30SMx2LtLBUGnGYBH0NGIYOHT6
         6B3Q==
X-Forwarded-Encrypted: i=1; AKwUvBz4PVDLauWJt8ABxYoEk3OFp4Dqe/4Sb73jVFHKB4wne/XdRaghKDWzFcROqN4rcHSrkjc6g00=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBgMutE5vQHsXCZdIn8VtXrL27mkLmbcADItDQ0a60AFpO157F
	CKMLZilQh79cezsrjGIEMIlvO9ntdyor3ILD5m+8XhmgQMmsrro6XfcGb5rfaTHm4gg=
X-Gm-Gg: AYBFou3Ln8AFFuVsNlQNlQ+yUkptK9ZLumhPTk3xkfP/8ZhGbXKJviqeD8LQrU/Tqm1
	HKhlj1trsKKsM1ErqupqRLjjyJUkJeanG8qp90ntC/3LUcVXfptMGIEp3g9KeptpnHb+BMDg1Fs
	sQMIE/NbYlyWTXH3pcsGOBPc13ZV/GazPnxSTa4K9mqfXyyPTaRWX+LK/3S4JSzbIGJB32R5kJd
	kSf4d9X9lpIIQF2RRxpEi/8a9Xh6ibfUs65+oEhXdBpmxfuEPKiF6YBL0kCiy/2X2BuMmgc6S12
	cDbDm+r75UlxGj/aaK/w0DTOb2Qc3U9gSfWm/HTY5TnGJXllmsjH8fGdBIfGN6Yig7WhGNkWcU8
	vcRALNAc2jTp6W6J5XrENcd38dDtpnZwzs3IOKfCiReUv2Gq9HdHKTAOIgfyrA7w6o5WVN+nNNm
	q/Rgd9ARsVXhRuJnlp1cludg4YNrz5ACEGl7rHW7J8aphvcE2gkx3tQOYfh7wVtLHE7gO93i/iM
	/QoBg==
X-Received: by 2002:a17:90b:1d4f:b0:3ab:c80:9362 with SMTP id 98e67ed59e1d1-3ab3ac91bb4mr13995093a91.35.1792031263864;
        Wed, 14 Oct 2026 19:27:43 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94375f3fsm1997383a91.4.2026.10.14.19.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:27:42 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v8 1/8] scsi: mvumi: bound the per-event parameter and sense dumps
Date: Thu, 15 Oct 2026 11:27:21 +0900
Message-ID: <20261015022728.3936714-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015022728.3936714-1-yhlee@isslab.korea.ac.kr>
References: <20261015022728.3936714-1-yhlee@isslab.korea.ac.kr>
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

