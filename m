Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3E3E832A
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 04:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039953; cv=none; b=OwPf/LmiXJcCUtNV0qtKXQB4Wj/gKLShQUn28y5HjT75d8CKvSvO7UuqS5CF19K5vxj+qbt7w+D6cH7vbSLMY9MPdQpVw3j1Oh6WHu4mfe2PZqAPuwUiUagklbQgNvstH8MLzdfDTnTzsSJ1dTjo4AQIWn+FbSnevMhNiowTqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039953; c=relaxed/simple;
	bh=d/UWuIDLttRptXRjgPCr2gHnKIUlkWJphZ/F4/3NVHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjbfDT1QzRvXet+3ky77tsQR2aY1rry+cvJ8ni11RHVbr2aCOcayn11GIGEbWQvgS3fR1nGQhIxwD8hQBvdsEaL6y0wn+Cdapey4J+1JeRFPguW2ZvP72X5l5a+hVDGhM5vARUCBh9rTHg3eTfkisVkdnzBk4xVGCOf+1RdT2V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=yind8M00; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="yind8M00"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2db80fcdf8bso28170905ad.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792039950; x=1792644750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=parD2IM7xfaD1K9JnqVrI4SVPT6JMErPe2GlYkxbGxg=;
        b=yind8M00tmux4mKJ38fz+feD9IoVGlrJm8K7/PTb3TWoCVG83KkHJ5FCNPy0YzgF17
         to0ASbQNrFTgaT5QRkcYfaMTBhkW4ZxdtUCVIF30XqimEFzURjM6inwzu0AGRRDFtIyC
         i8MiCN8GA10/096tZ1pgd2IxfoYfMRKoJqIvj2WFBUq17dmVPcZWdWI/4gokOhXYBJpR
         B+BhOgnDTD6nTdksJaX+F2hsarL3h+NmeDh+Pz2MpQQ3N6baN4IBOjJthFb3Yy11nBp8
         ca619WiwGHzWxBByrLt/7pqjfn6Wejf/5IJhOJDmVMtv2yYtfj7KyRGpYZEU5RTzBx6+
         UaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792039950; x=1792644750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=parD2IM7xfaD1K9JnqVrI4SVPT6JMErPe2GlYkxbGxg=;
        b=2dmkiLEGtPYVE1fHyuabexkbCnoXnpH8mhlctJuKhdpBL6z5/7vY6+fvqpozorWDwB
         1KjJoIPBM1CqzfIQszMzp0zN/nyc+U0gf0MbLKf8rUUuGjo/1UpeMlL5B8+yzRXoqtI7
         GEap9KLq16ntd9c3yr9E/2E8L9VIy2OlEohzrkj5gzSqn2UXfbyxCB6gL62uLzjQNhOe
         NuRVTSEzi8dSPNFtpTkmkgKjrejmPLB2nsOwS3ZKNWiZtSJVIjpOlMKrUf/L+d9n2hmX
         9Mlbh9poVIg6ym3PH+m2ZpTnLSeevA6MuvQHI7MaP4WTJtt0uVWU5c/HUnu1lBf/sJnx
         AXZA==
X-Forwarded-Encrypted: i=1; AKwUvBwqoSGzd405iqaKa+XrMx6HUPNMx9Id0FIePcUMPPkObfGc2EW3quIluVivXfd+csk6Q71TGjo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3GZ7YFz/BuP366BBOyRtHs20VFZc1Z3tr27eGSm7jnU2IJZGq
	kjxy5C04MTPXcyXaB2aFHtJVhqRDU4TOl+lmby7QZ65npuoYoKk0R0HvsgbtwrmP87MV2mIKg1O
	tKsC3
X-Gm-Gg: AYBFou1guHy1MmQfmafXCzlc7ZD0vx9BNah/7rys6G/ExhZB3zNQnk4BwEbZ8gz0ttd
	qA0I157SZu/0W0pW7ODEIiJfRTLFbPRlV/P0nUynzdmELdhpORS99M6qVDqM+JJJYBP2pqVPRFh
	pUA9W8OFMDqHYwFhw6VT7zJfT7+jm3cMuIYi26svzghNJjwtlYBLX/tl8sbrDHjII64FNBuLsVw
	/xBlvi2EyUy1d/pSO55dsg4KAIHkwNTNUbc98xHCmClaWqhN1BDEQQATrPXJ6fVOThRtqmXX+wf
	jxJFhy2O1oa6Jrn1Q1ll5QnrBIpw/YvXqYweiUDpqrzynj10IgTdziinbhq6MnSgXVtQEYRgBzC
	A2nNuxvqHAoFOMvPfmO1BWx85Ys4aNpqXTIZSsSc0Z9eKhgB2Ddu86/2ptwpw4KdpunVHYNfjjP
	A5roSDynBFRGaIqZH+FrQCs5GqMjRfUlEeSEn+EDJMx84YDMvyaXNalAxaKc6dOFGevTCtPUcFm
	TuN0w==
X-Received: by 2002:a17:902:dac3:b0:2dd:c100:7cb6 with SMTP id d9443c01a7336-2e842abe6e9mr141045385ad.50.1792039950052;
        Wed, 14 Oct 2026 21:52:30 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e962a4dfbbsm1615915ad.58.2026.10.14.21.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 21:52:29 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v9 3/9] scsi: mvumi: bound the hotplug event bitmap
Date: Thu, 15 Oct 2026 13:52:07 +0900
Message-ID: <20261015045213.3975845-4-yhlee@isslab.korea.ac.kr>
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

