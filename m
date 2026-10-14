Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CD30B53A
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995072; cv=none; b=CVtv1U6SRd+Xf07yQ0K91yC86cDXvBp3j5RB03Qxeb8I3taT94tTkq82v/+DKUTR55TcF5pRGK8r/N622LenXji+WoAtgwakW3E3BNTCBaPBa+R1BPXN8fwzs0FuEPxrq5EjglcLTvOyJNv+j4hsY25fqED0aG9dqpbl1y/DfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995072; c=relaxed/simple;
	bh=WWTcqcrYuK6IbdrjMRhsuwFkgDt4+Cy7tBLo38z8uik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qG1q8RcHGiEL2/OCoqh/J/VTuGIhk+zNzsGScypb+m/1UOGPaCseSZYk70x1BU7WQcmi3rkOgJ4j3FPh71Vgqd/WAuGlFusSxhS4xBaf3GmvfFx3krACmhFW0eOt89BADj27fKT9jtoIu6bflw1/Psm5HG1L1oHNPa7sdzajUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=vSWfdti6; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="vSWfdti6"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33c2520ad38so9834242eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791995069; x=1792599869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=vSWfdti6fPSLkpyQefSfo77ewr8kocGQhokzuWFFhfyphRvyP/bdPb91Nx9DV8GFXZ
         TKbDCVqyjnzQlY0d++l7fZylBHv2h55i43o7ul43hF62w7EyZVmYUQ6iYWfe+c5Nv/GK
         ZLKwEDRai+djWDWoVjwubT+VtsFc/dgr3/qOxD9/DtBjW2RbIlW5ydb8UrbC6WI4A1u4
         qPABpSI1A1Ks1eoVlOaQTSu7gNHYY2GyUIvRNaZ75ZatmsjRT7CY0C3unvKi6VYUErnb
         In6Oxhh985kBHq5LyUGanZcd0oZln0j5WxpzqMT52pCQdBKjp1uMvQoZbrGYiFWsbxoh
         Z0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995069; x=1792599869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmaZjOlL7Z4YX68oXGeP0K0pl8aIA8E2Yu5c3A96tCc=;
        b=oPgj4DvL8yAqb+XqXF2JHryNZHIRgVUkbJ9g8DPfmSFcbZuqXuOiassaSbdY0c2syn
         A2lbDl+2NIvmDn8wvX8KefZDzL/PK1v02DKsCt1P7jY1hew8Q5+KLUjd9k8naPvGT8yj
         bZi8O2QSmcdamZgV9nHPftDI6UG38AdBuUlAmayhkfH1CqH9qZoDtz0yBYGbydwspjJO
         kKkaNrsfJeEF0X7NtJ1Ts/vQj+jH7B5YNcuWYBAEqtsE6djCQn7K9eRgXunmoeeN525W
         CCTkvp0Sx57T2m2GZMWhfT2oDEb3UNAyqcUTWIK09iM/rdOaE0cuTzJ1VSUerK7s/ubi
         Oegg==
X-Forwarded-Encrypted: i=1; AKwUvBxzryWXt8rLCCIRZVucmOf3/qDEna7Yc/IBu57P5DPk3E1EqkVPtoOmmtMu5OqiOeenjpz++WI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQAmCY0O3FRPsa11DQwRXi3fEa8dr5J6mw29Cyaj+UshIj7HKI
	ayBymg3waJEL9LNmmQA+sp7gg3XOIEx0kK1C72Eb4PKxvw8JG+S+84S8k7XvSQC9C78=
X-Gm-Gg: AYBFou36k8b2I/tdJ+yu0KsDdBGiBqEXLVWSs36uoIlUwzf9NKEo9d1DsVumVEjnpHp
	bU8JKvv5yhGs5Rwqzfm7nb2OeYvPte9oPeIuUIrHc/V7zdAEaQ3DjsttIu8vhw4PFr8PCa5eJdF
	X1jbH9CXKJnORB9V2B25UZPp/wwK1VhTLWjsMJcIRLSFRckT6YFYKI19aVl6NfCtSoH+Iw43Ito
	ldC0PZpSyjE8mac4ceqGLT6UJVofS+2dxU8A4SYFJss+S+G53sbrTE+PFYuqeUXEZllC/Q7azeL
	UavmTImiGLug9LmU34KR4UWTDjniQFOPcdlL+I1drLI6SR+20lKykWrQlS/M7BaaN3oijGxYsUj
	JZT+pFnsoHzR1//OTbQLuhSkKDOJyoBiECrFAUqV+fZ63clYa6FbSGRqVw2S1ib5aazKVoFfnm9
	aM6xL+C6gXA6Eb6M3FP3TqBmvZuFR8ZE1gJXWeb0s238Bac6r7O/dN164ZTd2F7gyiBZ9jjnnlV
	Ym4pJahdcNnA9TcXCrv
X-Received: by 2002:a05:7022:5f14:b0:168:6ad8:e89f with SMTP id a92af1059eb24-16a56c9dd9dmr21327771c88.3.1791995068875;
        Wed, 14 Oct 2026 09:24:28 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:1c49:61ee:8c8:3f4c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1dd57d0sm48816685c88.8.2026.10.14.09.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:24:28 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v6 1/5] scsi: mvumi: bound the per-event parameter and sense dumps
Date: Thu, 15 Oct 2026 01:24:09 +0900
Message-ID: <20261014162413.3649841-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014162413.3649841-1-yhlee@isslab.korea.ac.kr>
References: <20261014162413.3649841-1-yhlee@isslab.korea.ac.kr>
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

