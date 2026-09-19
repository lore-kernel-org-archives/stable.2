Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BBE78F2B
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789840171; cv=none; b=I/45DdK6Y9bqHgqXt3bCX0BOH5WcqECmzyj/lVzLFXyOuwLuYlc8QaIGRhSEQlgbWOYIPc86I3R4o3VCkduRmdmpyxMAiIt9Smar2NHWesSyIiLn6N9kIqjlfgHF4IXcqCJHHyt/efvrZ5N/8ug2hrQUFcS8u8e5slGcvKs5Q1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789840171; c=relaxed/simple;
	bh=g6tsjX6Qa/+gUKGSA+7Kv+QYuIKzwo+FzO1cUxU6D7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z08iQ1oVBLCClRsYAX2lQXX0rww5S11mYnMKS6woz2PDvSbYgaekdr10YWKcSLyq/GWliKQbI8X5XakacSEAmHeEdvoscRKtieX0lbXcmVxpZDBmM3BkFlNBanzAEUBL1Q+xg2uFdSt+bJdNCT70uZEn8l/UHEzB9hJHqsT3y4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVP5UP2a; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVP5UP2a"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398c066106cso1426499a91.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789840169; x=1790444969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMcAlqV/8gbRvywKZc2/TEvRO6KQIityZ14E3909GDg=;
        b=BVP5UP2aW+2uHY3qAE4/6Zk6A93dSwyAhMeED0JxnSybyosnaeXzuYlEEr1dZiBVhN
         d0K1nol3825CTjwTo46tEIAVP3NHaDapyiIP8JviZ0vq5zFf6KZ2wT0mq8fFbPVvSjEC
         FXfQ+9fKZbkBw3ylxmrYLScG2IzUMMgjfXrWyQmKkfu6mND/QuUiV8b6zPs9wUb/7ypO
         bK87KU4ctFDjcuf94jYlrMean+x4fon2KIO+rtBhHl5X9bX5vuhBFnoUwyohGVnA+5mP
         NfCc1VJj0sBzPBnNsiSE6B7ZTlJcp8Zo4RaisAsmIjeOWY3N87xAU7tufhHo5UFiXXaX
         xpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789840169; x=1790444969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMcAlqV/8gbRvywKZc2/TEvRO6KQIityZ14E3909GDg=;
        b=e5kwql4EXQaKSG4tgnwPFtxDczwPYf8cHH3M+Uywny0qoalVmYdh3qNYqOtqeOWnme
         OFPY50sIUngCEzzRulSiKBlICKzAT2F1o39ratNvsJBcikCU5sMAPXQXCXSHttdLBjJn
         UmEnlaRYh0dIeOzLo3fXZvll4raIqZv7TnrnjQN6DK0jOoOfRnhcoMk9mLO3myWM70kK
         6RoGu21rz+2aGCx905xPlIgiEJK4CJOvNqIYyqxAAoNwzDiKXsUAM4a/lPiXLj26G38k
         WpuNVCg7Y3XNNs7rkwf3ux65uF87qdKE5DGRcGd7oKZZl3wQaunkTdebqZHuMGKcm8NJ
         BGBg==
X-Gm-Message-State: AFuF++kBBE8T15DCs0bQiM+Hjza0y34xAFqgSFEDouQY8oGYeWSNowBA
	hDy3NrXw/WHK6CipCrmQgOAR1G/sQeAYZ8ibJwBU/g7OjxpYSoEWTIZW
X-Gm-Gg: AYBFou3rvRjsIefWESw4NyXjcGWa63tCP5hOYN+Y4ZP39A7xMPlqQiKUzrTyE+8IBNj
	AJL/Gb/ok/ovEKFQeGrJxv8Un2MntvkhfXxl0C7PyQ8yO3Ftrjk0QAtpUTlyLfqD6cZeYoPS0CQ
	O2qHExTkkL9pJdmdYpBYnZK1k5XAJn5XVyctYU5lwm42XwWrmb2g689x6Td5tE7JbjXsnxQP6V9
	CJY1JXFoxc6zo1VxwrR43WC6SX0c9LzX/ykr5bsN8nCBt86aObGVDsYn1wtmYgGjhZ/y/HluHj3
	MFuu1A7H3m6bCvVKWrVxWwrtTH7rHSrDMuggEZAdWKIALbmNQiZVl6uTuUlRSPvg5kE21PBUL8B
	Ikfbh22ElEQPGayhjAKE6ny/Y5K/huHoSzWobaexSf/esZbLy/JL/XMpeExxXOxoR5a1FwUmjF5
	9sInlrU+muMXFO1a5Ngom1pymmiwCiqPjyz7CQER9U//NkriNnWlIYp9WlIY5Cr669Zegu
X-Received: by 2002:a17:90b:4c46:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-39e54922644mr15032744a91.0.1789840168712;
        Sat, 19 Sep 2026 10:49:28 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6d83e253sm2082331a91.1.2026.09.19.10.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 10:49:28 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ram Vegesna <ram.vegesna@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] scsi: elx: efct: fix Scsi_Host memory leaks on add failure
Date: Sun, 20 Sep 2026 01:48:35 +0800
Message-ID: <20260919174835.3729156-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

efct_scsi_new_device() and efct_scsi_new_vport() allocate a Scsi_Host
with scsi_host_alloc() before registering it with
scsi_add_host_with_dma().

If scsi_add_host_with_dma() fails, both functions return without
dropping the initial host reference returned by scsi_host_alloc().
Although scsi_add_host_with_dma() unwinds the resources acquired while
adding the host, it does not release that initial reference. As a result,
scsi_host_dev_release() is never reached and the Scsi_Host allocation is
leaked.

Call scsi_host_put() on both failure paths so the initial reference is
dropped and scsi_host_dev_release() can free the host. Also clear
efct->shost on the physical host failure path since it is assigned before
the host is registered.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/elx/efct/efct_xport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/elx/efct/efct_xport.c b/drivers/scsi/elx/efct/efct_xport.c
index 9dcaef6fc188..c00ad9176aee 100644
--- a/drivers/scsi/elx/efct/efct_xport.c
+++ b/drivers/scsi/elx/efct/efct_xport.c
@@ -416,6 +416,8 @@ efct_scsi_new_device(struct efct *efct)
 				       &efct->pci->dev);
 	if (error) {
 		efc_log_debug(efct, "failed scsi_add_host_with_dma\n");
+		efct->shost = NULL;
+		scsi_host_put(shost);
 		return -EIO;
 	}
 
@@ -930,6 +932,7 @@ efct_scsi_new_vport(struct efct *efct, struct device *dev)
 	error = scsi_add_host_with_dma(shost, dev, &efct->pci->dev);
 	if (error) {
 		efc_log_debug(efct, "failed scsi_add_host_with_dma\n");
+		scsi_host_put(shost);
 		return NULL;
 	}
 
-- 
2.43.0

