Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB643DA7DC
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031272; cv=none; b=E6yfoYMCxs8bNKXYGA/2jHGB1260VJiPWos2knIv9qosYr2dFhQb72H6CtyNcyRUqdAJe6yr4bPbftG626wE1FX9yqPs3MtfvHqYWY15E5zoxYGOn66D2PtpcAJm1lEQO2TNYRM85CZe2/JyJC/An19FKF5E1hCE0N1ZOEIJQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031272; c=relaxed/simple;
	bh=d/UWuIDLttRptXRjgPCr2gHnKIUlkWJphZ/F4/3NVHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8Nuo0VnbtlI7Mx/yKdCTynvsqFydQTexXlt1QQLXimMucxy0zDXjSiHk3I0JTPiImcexNGPnjN7RMU3abBlILEey4W9PDSibbtUvMEFyOhSqFO70VgrShI3aUsR4SEQkYpSwWQHAtvaG6oaR+qQFPqeAiiiXeid8kmYzDjTKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=WTOgaCM0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="WTOgaCM0"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e915887d9dso16625005ad.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792031269; x=1792636069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=parD2IM7xfaD1K9JnqVrI4SVPT6JMErPe2GlYkxbGxg=;
        b=WTOgaCM0KXikHo8bMsZcVbnNRMP+dv/pzuxJWU2g2f4/oq+3rH6RCkTU35P0Xc6F7T
         MgRemDkf4TepZwy3GlJLiUVLQ8m+PRV/GD+ADfVoHvzWgQH3UnkTQNEXr1LJ+6/b78uw
         VzyoPHAsG8JvvsImU+FS99KJ1urBfG6vfux6ejbMHD8ZVbxpJl1Lze7Oaqz4+/FH9o6f
         Y/IeHrdQdF1UbBXJYhz+jXv+1ERMXj5m8uJSEH1kfbDOOK7Hx7jBr+T2FEnrpUFfICga
         PZn5OZC/b2kBz5n/ilXzA/8rMfZS5M9ZeXauFBES2exfPMbC5P4JdrBf/6h69pdXq+6Q
         Sfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031269; x=1792636069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=parD2IM7xfaD1K9JnqVrI4SVPT6JMErPe2GlYkxbGxg=;
        b=0PZ4D0JKDUBaP+uqlPbNvwJmH4alWmWX+k7t/QrsI+IR0kK0NvvuFLpER3NT40Hzw6
         PkUbbOX5ow03r+14G8BfF8TS5Y5jXj/gjlHhhnnQZikEtP8MsNd/ZncvmRaE8nT4rj4b
         zgztwdaqumVawT2XSe0eqm9ane/ZPKVN0d178Mz+BQ0I9OFy1Cne2lpdzFrdAgiHKGhW
         SEKdFcrjS7drd2GueennkwHEwTHZfcC6xYzYmjQPsS9oaZai9Rdi9TPrIA4Hzc9lWzmp
         oasylsZhgaQGjpuoKgG+Q/uiIw8wgqT+LK39NuyxUreBjydC8tZtbGSShaIgw1cjwNJc
         /3tw==
X-Forwarded-Encrypted: i=1; AKwUvBy3AKsM0OUpw7/6E2EqtYCxgmI3zIYDEfA+c0nLBn08hi+sc6k1UVitqEvyddjWZ4QtOLBkagw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6vTUJQfaHKhJ/iyq9JbkvCEXZ3EL3muPpc+zcLnO01idURyxR
	i1zi5R/d3uchh5naMPY8SYeDyyluGe3QxoyGMvefFSFlnce6zfh+IEKEhipxDabzRxg6qGtODM7
	pZrrg
X-Gm-Gg: AYBFou2I+HqgJb6oHE5zjLAYduxncb+Xb7/Hh43RP/OrT0SubCKDE/p9qMrb7UkDV4u
	uAsrPQmdti2ALylBwEcUBcUzTl9HRR7nmyhbb6NTUpnERgBeGzL4RkhQ+lRuyNp1dhuSH9uu6Gi
	vlaNskwPPny0G/GaSjNQGhDi5Qh5dWSMMYRjaZCdPSduvFp+o8la58JS/9EBN5KmdLgu+8n1Ljj
	8aQXVAVzhBrkQ09vbY8hPXDy447JHxg1APDvxT6brnAVIAxFq8Ape9o496Sm6D2Kwpca1RwWghn
	kdjnjjetNcFdEHvFvjdUz0eDpOoyvELp2Mp/TSJ3i9p1Hv16dLwkj8/bijR3msl0r04ni8BMAYv
	QtyAcL4MfwtBTsroiC75DnXnKGqMFSOiA9S11aF36bHi22uwp25SyPG3vkivlsrPmLlhGsxEB9D
	SL0MtGLl9at/JbXANiPB3Bv3X5A9qKabtHt6AC9A9jPHczgdLR8b32ZCr492Gxb6DQPsCUlJCc3
	ck58g==
X-Received: by 2002:a17:90a:4ca2:b0:3ab:7031:d962 with SMTP id 98e67ed59e1d1-3ab70412990mr9433766a91.41.1792031268777;
        Wed, 14 Oct 2026 19:27:48 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94375f3fsm1997383a91.4.2026.10.14.19.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:27:48 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v8 3/8] scsi: mvumi: bound the hotplug event bitmap
Date: Thu, 15 Oct 2026 11:27:23 +0900
Message-ID: <20261015022728.3936714-4-yhlee@isslab.korea.ac.kr>
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

mvumi_proc_msg() takes size from the hotplug event the firmware DMAs into
the event buffer and uses it twice: as the bit count for two
find_next_zero_bit() scans, and as the byte offset of the second bitmap.
Nothing checks it against the buffer, which mvumi_get_event() allocates at
a fixed 512 bytes, and size is a u16, so a firmware reporting 65535 makes
both scans run roughly 8 KiB past the allocation and places the second
bitmap past it to begin with.

Reject a size whose bitmaps do not fit.  The second bitmap starts size bits
in and find_next_zero_bit() reads a long at a time, so that span is the
furthest either scan reaches.  Compare it against sizeof(struct
mvumi_event_req), the only length the driver ever puts in
data_transfer_length and therefore the most the firmware may write into the
shared buffer, rather than against the buffer itself: dma_alloc_coherent()
hands back zeroed memory, a zero bit in these bitmaps means a device is
present, so scanning past what the firmware wrote would add devices that do
not exist.  Read size once, since it lives in memory the firmware can still
write, and give the buffer size a name while here.

Fixes: bd756ddea18e ("[SCSI] mvumi: Add support for Marvell SAS/SATA RAID-on-Chip(ROC) 88RC9580")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 18 ++++++++++++++++--
 drivers/scsi/mvumi.h |  3 +++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 2378b676a7a78..9a3dde53dea97 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1652,11 +1652,25 @@ static int mvumi_rescan_bus(void *data)
 static void mvumi_proc_msg(struct mvumi_hba *mhba,
 					struct mvumi_hotplug_event *param)
 {
-	u16 size = param->size;
+	u16 size = READ_ONCE(param->size);
 	const unsigned long *ar_bitmap;
 	const unsigned long *re_bitmap;
 	int index;
 
+	/*
+	 * The second bitmap starts size bits into the event buffer and
+	 * find_next_zero_bit() reads it a long at a time, so that is the
+	 * furthest the two scans reach.  Bound it by the length the firmware
+	 * was told it may write, not by the buffer: the bytes past that are
+	 * still zero, and a zero bit here means a device is present.
+	 */
+	if (sizeof(*param) + (size >> 3) + BITS_TO_LONGS(size) * sizeof(long) >
+			sizeof(struct mvumi_event_req)) {
+		dev_err(&mhba->pdev->dev,
+			"invalid hotplug event bitmap size %u\n", size);
+		return;
+	}
+
 	if (mhba->fw_flag & MVUMI_FW_ATTACH) {
 		index = -1;
 		ar_bitmap = (const unsigned long *) param->bitmap;
@@ -1708,7 +1722,7 @@ static int mvumi_get_event(struct mvumi_hba *mhba, unsigned char msg)
 	struct mvumi_cmd *cmd;
 	struct mvumi_msg_frame *frame;
 
-	cmd = mvumi_create_internal_cmd(mhba, 512);
+	cmd = mvumi_create_internal_cmd(mhba, MVUMI_EVENT_BUF_SIZE);
 	if (!cmd)
 		return -1;
 	cmd->scmd = NULL;
diff --git a/drivers/scsi/mvumi.h b/drivers/scsi/mvumi.h
index 1306a4abf19ad..5d45f0d99e639 100644
--- a/drivers/scsi/mvumi.h
+++ b/drivers/scsi/mvumi.h
@@ -124,6 +124,9 @@ enum {
 #define APICDB1_HOST_GETEVENT		1
 #define MAX_EVENTS_RETURNED		6
 
+/* size of the buffer the driver hands the firmware for event replies */
+#define MVUMI_EVENT_BUF_SIZE		512
+
 #define DEVICE_OFFLINE	0
 #define DEVICE_ONLINE	1
 
-- 
2.43.0

