Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495F30C14A
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025868; cv=none; b=dxezNnoqv2U7fk3HamBvrK1p0zrxd1eEFLcDXl5t5+5e5A4pa9JvxRGV2kLIG7i2nwpKflh/p9FiG268lZ6i7tj1bjv7OdEv61wt/dVaGPCS9bEXnE/jRjmTV6GI//to6NXWcddT8TsuHKa0xdsqIBnOORdNskme+re++c9gfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025868; c=relaxed/simple;
	bh=A9dZqNlJD9WYs+GSLH29AUnwq+8L5IzDDOZ0LYgLQg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwOuJnNc7Xx7ANoHRqS2xD7roA2U6hopzSgdBB+h0V5Voh5QRCphDXBm572PfUpHEcjsmFLZ3jcR+2h1aQTWM9Icza+VrXvALKTr76DfDYa9qTHBceANHdzIr6irRWtLCOexbeSjK8p2FBB2IQacOFvF4T9jsFVQX9o7icTDHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=QWqHqavK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="QWqHqavK"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so958189a91.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792025864; x=1792630664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qB5u2eAth6kclTEDr0WUXrH+pdbrWwKcjOH4XM8d050=;
        b=QWqHqavK7MzdnOyCxQLF9fpcfwrmLr+WrbjEGeOAius2aYMdGeZbt+F/oqcMrnhSNr
         vcLMKbRjYXfGk7fEbn2y/X6w/2/p2cydk0Nc7eHOVy0Ci1SprkO7EtCVLqAqrcqwxwwo
         upEHLxmTOYu7P18QeCLoWs4pugHCCMZP2hOe9euIu4fRkf9JQvo29AmsXCIG72+0ct0h
         BNoAuT7kVStbH31OAArlEKwROZwJrMCXgGZBfOw6ZK3fUPNwlhqlJurpv1LMXeNe6Jxo
         CtmGbYMgVUCBFpjCnihd62eDdT4PIL2Vbwm5cTTRD45n2spe0W+hOMTbh+TDU4lGMcRc
         iqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792025864; x=1792630664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qB5u2eAth6kclTEDr0WUXrH+pdbrWwKcjOH4XM8d050=;
        b=xy/keOP/TqpdrwzB28T4sq8rBPV647wFRRZM4VA5dc8HCYoYUqs8qqLfoCGs1hQn6+
         2BDsyNfviJzJKzIrKlG7M9iz7GZfYn8VZeP507nugvLixMKoQa8GnZLZLXp6OqE36lO5
         T0Lg+dMbF+IQQ1aQ1yeR/PzIz8vRDMZhXlp6oK/qSj9hRDl4uAAo7QwTH++O3Y3qfrVX
         3GPurU1CRfD4XVULil3sXq3zsO1rmuEFIrtD2GHqhJQMzKEeTD3Rb503rcGwhYIx2b6/
         1FnJzCbMbkWoeWTGjmPv3ng8pvpErMNxaJaxW1Q6Yjl/i5REM6HIucP6Zpn+kwKVeS26
         srfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKH25ir7EzLM/jCWDNce41Dmm1j4/B6enqjQxEIMSV7ZWv8WTJ/w/maod/DOLG2389AMvHeTw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwK/avz/FOpv+xyJwlkMx0+vqY+PcrgNiYZ34TpeqIlF8eNIl2
	kquqv0u0EzDxeU0stE2IcsYZ3Hu4KgoWWmFTNkI0/4HHdrhZ6Ba+3Ls8bDODSAXBuPw=
X-Gm-Gg: AYBFou3sp0IMrTFRao3KO2R01vZ9FLmSxlR0zrNapy1HxQfSjq1lLw3/45DDb3uN9c9
	0kJD1XIB7Z/4WnSnAy1gQEm+mZuNoO8TIizrKPk+3MDn57GY67abXBsho5eP8TWkAmL94DyL5jD
	1cZOS2ZSm0VnxY06hiLf73j8hW8ki132H6LkkgEGVUak9maM9pCW0LMsO4s+IC5V1AmXaPiO9oF
	kBfs7Qt65JURshE3qMk66B6ufAUYjZmjk1KTB0XHEGrZD/BwiGlzkvnt3P0isLE8tTVguo4ix0s
	AoBdntfDj/oj0y9bIP3cwz9h78xIbiOvdci2PAEYdWcw7LOhI6oDGz3s2cr42UNzLlUNJu0SEy9
	hs9KtbvcykLlSKgQifN+8mcbInhxEfbDyR5o+8MhP+Nukp4Tsg2qjx6VYYn1ZVTf9ehaR+oq26c
	JbnbPyvtmIn+YcjLGIjApNS1bWhKL6JI2+ZZGwa/EwqzrUJ/4JZoy+HLivx84cyB7UQ/Kv+9yZ9
	rG9VQ==
X-Received: by 2002:a17:90b:524f:b0:3a8:de1:db07 with SMTP id 98e67ed59e1d1-3ab3a239c16mr14541814a91.5.1792025864155;
        Wed, 14 Oct 2026 17:57:44 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac92a43d98sm999198a91.0.2026.10.14.17.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:57:43 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v7 4/7] scsi: mvumi: walk the hotplug event bitmap a byte at a time
Date: Thu, 15 Oct 2026 09:57:14 +0900
Message-ID: <20261015005717.3719956-5-yhlee@isslab.korea.ac.kr>
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

mvumi_proc_msg() casts param->bitmap to unsigned long * and hands it to
find_next_zero_bit().  bitmap sits four bytes into struct
mvumi_hotplug_event, so on a 64-bit host the pointer is four-byte aligned
where the bitmap API expects long alignment.  On an architecture that
traps unaligned loads that faults, and the second bitmap, which starts at
an arbitrary byte offset derived from size, can be misaligned on any host.

Walk the bitmap bytes instead.  The driver reads every other
firmware-supplied field natively, so bit n of the bitmap is already byte
n / 8 bit n % 8 in practice; writing that out keeps the device numbering
this driver has always used, needs no alignment from the buffer, and drops
the long-at-a-time reads the earlier bound had to allow for.  That bound
stays as it is, which is now more conservative than the walk needs.

Fixes: bd756ddea18e ("[SCSI] mvumi: Add support for Marvell SAS/SATA RAID-on-Chip(ROC) 88RC9580")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 9a3dde53dea97..18964e860ac8e 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1653,16 +1653,15 @@ static void mvumi_proc_msg(struct mvumi_hba *mhba,
 					struct mvumi_hotplug_event *param)
 {
 	u16 size = READ_ONCE(param->size);
-	const unsigned long *ar_bitmap;
-	const unsigned long *re_bitmap;
+	const u8 *ar_bitmap;
+	const u8 *re_bitmap;
 	int index;
 
 	/*
-	 * The second bitmap starts size bits into the event buffer and
-	 * find_next_zero_bit() reads it a long at a time, so that is the
-	 * furthest the two scans reach.  Bound it by the length the firmware
-	 * was told it may write, not by the buffer: the bytes past that are
-	 * still zero, and a zero bit here means a device is present.
+	 * The second bitmap starts size bits into the event buffer, so that
+	 * is the furthest the two walks reach.  Bound it by the length the
+	 * firmware was told it may write, not by the buffer: the bytes past
+	 * that are still zero, and a zero bit here means a device is present.
 	 */
 	if (sizeof(*param) + (size >> 3) + BITS_TO_LONGS(size) * sizeof(long) >
 			sizeof(struct mvumi_event_req)) {
@@ -1672,25 +1671,19 @@ static void mvumi_proc_msg(struct mvumi_hba *mhba,
 	}
 
 	if (mhba->fw_flag & MVUMI_FW_ATTACH) {
-		index = -1;
-		ar_bitmap = (const unsigned long *) param->bitmap;
-		re_bitmap = (const unsigned long *) &param->bitmap[size >> 3];
+		ar_bitmap = param->bitmap;
+		re_bitmap = &param->bitmap[size >> 3];
 
 		mutex_lock(&mhba->sas_discovery_mutex);
-		do {
-			index = find_next_zero_bit(ar_bitmap, size, index + 1);
-			if (index >= size)
-				break;
-			mvumi_handle_hotplug(mhba, index, DEVICE_ONLINE);
-		} while (1);
-
-		index = -1;
-		do {
-			index = find_next_zero_bit(re_bitmap, size, index + 1);
-			if (index >= size)
-				break;
-			mvumi_handle_hotplug(mhba, index, DEVICE_OFFLINE);
-		} while (1);
+		for (index = 0; index < size; index++)
+			if (!(ar_bitmap[index >> 3] & (1 << (index & 7))))
+				mvumi_handle_hotplug(mhba, index,
+						     DEVICE_ONLINE);
+
+		for (index = 0; index < size; index++)
+			if (!(re_bitmap[index >> 3] & (1 << (index & 7))))
+				mvumi_handle_hotplug(mhba, index,
+						     DEVICE_OFFLINE);
 		mutex_unlock(&mhba->sas_discovery_mutex);
 	}
 }
-- 
2.43.0

