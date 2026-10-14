Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89841511E92
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991180; cv=none; b=to/Ay39LKwyMIZOCJspvTpQYQ+8u7O5DxJqXayOpeOQV01UqYQl8SFERk91juAmXtBvTaaCsNWuCsvQzEXH4699HiNg8fAIypZdOkQdByY02oSPVbmKZNoiM6WvoEg3onk8S5TetoGI9EO9FG7Co/qH5xgIwK3C0IADEOeuOU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991180; c=relaxed/simple;
	bh=ipj4x06xORPFX2v4GgW5SWEG0yhRNVm2l8+JjtLGXcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzfP6oQ9IqDokctN6XFZa9YoBMOFuo27UMDUmyN+VBIu8dZJ+F9EemRTFEcKh/DO1KWz2BcezvRLnv6cckbp6vt/ACmV8XrLPAZ10ooXooxVxDXWn7CryltVfp6lCYPw2We0mvmFYixvT4+Q8Qol32ez9CiJZDG/TqXr6kIiP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=fUjBnVU7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="fUjBnVU7"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab98332238so2366401a91.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791991179; x=1792595979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RokP+G7a+HORCP9PKoTQOgxbzp2fwVHaPKd/N4zyJKs=;
        b=fUjBnVU7lQXd4XCJ+IGmLiM7BLIwMgEOrueaQiwkhU8uPf7wnyl3GRf1WoSGQyAbPn
         w9fIghEGvjDpkmZNyOUJ3jJXVWQANNvab/sZ1rD4687WvS8+0HfVpRdmDc+mO9ix7jaK
         lbZsr0/YTTA/LTWOPhcduGy5zJE7WxhHOsutMxxb9JrAp87ZagoyovZUXuVSooVq2Dnw
         s/FftM2L7+cFEQd6ODpUymshjdGcoKyIG1pDMGPSfNnYbovWN97W014ObKNVrXRwUZ/q
         d4Pt7b8OXEkCcmMx4A4pmKglJLnprMftdMj7F8mbPqbT6PRRpFogJiarmMvr8DpYRfos
         OvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991179; x=1792595979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RokP+G7a+HORCP9PKoTQOgxbzp2fwVHaPKd/N4zyJKs=;
        b=jCfLbXfrPkietO0j2O+0B60mpA3tBg33K4bxNCFj109hvqj5AXWb43G3uMzSU4fHxf
         Jd5jnYTxdxDGvwNIp2ogEEncA7GZxf3OfRvMqIz+EbCrC9J8JyxH8AF6QT39s88CHyKQ
         XBQUdRTtioV+mZN6YsArE6QQhcgD+PVlJN9LkyF1igam8l3uLS4TedNL2PfD88b3Jn6D
         M5kDKaH9qh+vmxxNzhzzVY7gwviH6WR3/yKufo15N/uOUkBpIIIWG/umnTM1JrrPyL3A
         aI7X2c8oI6SuE2M6udwbnxFn8JN3mU3lLtC5uCChcVHeiu6XMiPa0lC5X2dzHUyny6my
         dT0w==
X-Forwarded-Encrypted: i=1; AKwUvBxpNR2R8rSJ69fPy60OVdsTh/svkkO9XqcquhxQ1zILxEcxys+n9gFcRqeMivtXUWalkSWWZSE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiVoTsFwaXG8M3o42ditLyfta8ZPRzPitcrG8e50t9/dVS4h02
	YGjU2ofTuK8OD3Te06bFiOYnWm5rpgT4zPRJaSpSkrY5y74czQ+uBa1hrFl3vewA+lQ=
X-Gm-Gg: AYBFou27NwCgiMWqVgT5KTrRiwSoTbzuWdBbM+O1zyM/opsdoyG5YFDXwYY1eWybjw2
	5/KZXgJxHV1B4GEn/rgLU5tAaMJUEIXePGDEFmWdQcn4cXcmkwLzTIz/jfcmWBJ1Acc1RkEcCEv
	Mjjt3B4QwQhQJbfdqjIFASVhmoNXPCUOFYY48xsOddNa59A/EXQ/DYXsZMtjDOSUiow1T41DoaS
	9VLbwl4IEgvdhdzME1FK8olCylvnQEmgPImwVMblNmjVzoP5dL/nT5wN+UUi9UGJh3+7fr6/YaR
	IKuYvFqb4sBl835oPQQG8cpjtpuuDxiYRbZ4z+8Ph/fotBDv+WWmEFAdld1p7HPavjr5HeXDHgR
	Jp0DB53d6R8jRxJ8JzWB+NiO+aGkEM7MEkoQosMSGHKGd1cb4MEGgUn3ydDrfzy8tdyFwtDhK45
	40v0mP95YPSx1ikWqqZksxWdtqd/9xAZlDMoh3pZMGJjzG14hB2YMmsRbxnkcTpWe7nYxSLVR1Y
	laMk1nejem27ESQ2FrQ
X-Received: by 2002:a17:90b:2d0b:b0:3a4:945e:bc33 with SMTP id 98e67ed59e1d1-3ab3af7177amr12815120a91.47.1791991178309;
        Wed, 14 Oct 2026 08:19:38 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:1c49:61ee:8c8:3f4c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac8d40e7f3sm622450a91.5.2026.10.14.08.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:19:37 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v5 3/6] scsi: mvumi: bound the hotplug event bitmap
Date: Thu, 15 Oct 2026 00:19:11 +0900
Message-ID: <20261014151914.3632701-4-yhlee@isslab.korea.ac.kr>
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

mvumi_proc_msg() takes size from the hotplug event the firmware DMAs into
the event buffer and uses it twice: as the bit count for two
find_next_zero_bit() scans, and as the byte offset of the second bitmap.
Nothing checks it against the buffer, which mvumi_get_event() allocates at
a fixed 512 bytes, and size is a u16, so a firmware reporting 65535 makes
both scans run roughly 8 KiB past the allocation and places the second
bitmap past it to begin with.

Reject a size whose bitmaps do not fit the buffer.  The second bitmap
starts size bits in and find_next_zero_bit() reads a long at a time, so
that span is the furthest either scan reaches; compare it against the
buffer and give the buffer size a name so the bound and the allocation
cannot drift apart.  Read size once, since it lives in memory the
firmware can still write.

Fixes: bd756ddea18e ("[SCSI] mvumi: Add support for Marvell SAS/SATA RAID-on-Chip(ROC) 88RC9580")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 16 ++++++++++++++--
 drivers/scsi/mvumi.h |  3 +++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 2378b676a7a78..9e342db4b8383 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1652,11 +1652,23 @@ static int mvumi_rescan_bus(void *data)
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
+	 * furthest the two scans reach.
+	 */
+	if (sizeof(*param) + (size >> 3) + BITS_TO_LONGS(size) * sizeof(long) >
+			MVUMI_EVENT_BUF_SIZE) {
+		dev_err(&mhba->pdev->dev,
+			"invalid hotplug event bitmap size %u\n", size);
+		return;
+	}
+
 	if (mhba->fw_flag & MVUMI_FW_ATTACH) {
 		index = -1;
 		ar_bitmap = (const unsigned long *) param->bitmap;
@@ -1708,7 +1720,7 @@ static int mvumi_get_event(struct mvumi_hba *mhba, unsigned char msg)
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

