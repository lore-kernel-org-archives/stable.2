Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B148AE17
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912724; cv=none; b=sv+KlAFnK1TU5zlbRa6BDFTRtrlggioSzAfska6ng9Eobjs886LCS6S0uYe7+N7Xc6ItfNbCCl/oKox3jNGhekkdyiYErsFd0cOyLrYeqgPMMvLBr0nCnyoq3qCrlpFTnUVwYYy4Xbv35rZhFtHOPxhGhw8ReGnXFs3F39t7A2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912724; c=relaxed/simple;
	bh=mZ+27cf/ial1Kmh8g9YuKRqBc89avEfQ355XOYWXwMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAanwWOzac+Ms1U66Lng1FugkT2E5pPfEs+L18yDu/6SMoqMIHAVc+/QKITZJ0IEtZkqpnzMsa5qbvXUoWgMu3kGiBfiXc0xcglsFq1f3m5uSwl9gE/ZySWaufp4qsrlKMONjZuQSQBf/pi8SEcXilGo0rQt+ghB6F79MK30k9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Thp24BMc; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Thp24BMc"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso40059a91.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791912721; x=1792517521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gF7titqAQOhWgf/cID4J3N6cuUz4241e7eJ9tfRVLQ=;
        b=Thp24BMc++oldWYY5fJ7dvx+TdCjnRPA4JnxFYP9mLFe2Yt5QA1V4bkIt29GoVaFAH
         yX2JegtgW4zGXUBgD9KTzqhGSczjsDkvmra5VVMYGV5trlrTQou7NbmiBOIlpiKJ9ARb
         3Q9RTwS1376Hzf7gyxY6VX4u4iwQm/r5yYYa/FpgRAOrw/cnMiGuSWzUwquh09vdYt3d
         K5o65iluAV+5+gRAMYSLF/sdSo8/pVCmfXcuB/SZ776bmArJ4ffEw7XYh4vjqEI0NJiW
         taYkdd+e7Nibxm00WEsg1XGqCQgHMMVSRiwQViulwzdLqSzJPP3FjZXB2SkPXowdFXdK
         b5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912721; x=1792517521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6gF7titqAQOhWgf/cID4J3N6cuUz4241e7eJ9tfRVLQ=;
        b=wuJH+tGAgdSkvVvoKKj+PKrAWV/bUzmckJmY+3cXN6AxoZAs6UqRagp+wTqLBjtdza
         UIOE20OBDqzGY7mrk1yM0kJ8gVjOLBnvej6U3ssfBkmbL1PV7X/KF6+hxEw+98cxqj+T
         2m/M/oEDnoYT81U7Ro5P1k6l37w5Wdvw3cy57GeH7WYKBDQqtUltNqm8oqp9k3VDttNL
         +Ttj8yShoyMLuCOnCBgBPZqf46GzIZwdG1uZ/we0afAxNRVV1epG53ZRWAYKCjMbHh05
         iAyho+nQNUBcfXbff1E829Mx9bekGmg6xfiPe83bu5yv30ZzxAglXcihQdebgrn1JyZH
         nBrQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+7myJx3CG2ykOSung6CnKh/yvbz0hCdcvfHxGDyzZ2/6Bp8cJRM2DZD4KOFEKQLKekg/WQl8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG86W4bCbEPy5JW01Y0t4AnrjrsHhEbk1ZQPZzHII/O54eyAub
	t6/7CDD3X+OV0VDy6xATyn4xy9tX/AcaDmEhjY9D7iLJWp+eU07yubR73H/HFfgnnCY=
X-Gm-Gg: AYBFou3B53tGLiRCSLOuohk0TAytMX1gpgAWH0AX3BXRfyiI+NCr/6eoT0MFkKyyEU8
	3rJUx//yeR25+3SCroYsEdBa7BhotejhTgZRecfbKBUA3QstglmiKMvWFyCh1sLX03RB7biCAz8
	yQO80b0fFnWEo3gVoYSyzDgz6dbiQWENQWRGZXMi2mKSbdSR0U2V9ce/pHWu8AHLyri92VvmiSD
	jv228NEh3bo/0P7XadF4xXdpmSPJoCEEIQkwuxyZGa5SnBiVMQhrgWMoa5XSu7fQXxK8U9S3kyo
	izz8Q9C4UkEdKFDrphcDRRObDTXkpHdhIy2DIpoNnjku9xhBs12d6lmw79DJyrA+iT5nsaswcGg
	H+RM0A/lpkjgP1r9fQRdkbY94vWySDz+iy60IU+tyhfT4dMQWvQ6s/ehBM49/ybZSgv+sDE6zbL
	/ad7dkmUybJu7kVbM+Pajz14ij/lNURqi/IAWeshkf6exFYi7o3fMxTlT7EzTajAjAjWBFs4pPV
	a0kafMdyXkQVPyvJHx9oTm496MOifg=
X-Received: by 2002:a17:90a:d006:b0:3a8:6a04:80ef with SMTP id 98e67ed59e1d1-3ab3a2901c2mr9313055a91.6.1791912721027;
        Tue, 13 Oct 2026 10:32:01 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac6019ca59sm607396a91.9.2026.10.13.10.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:32:00 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 2/2] scsi: mvumi: reject an out-of-range handshake frame length
Date: Wed, 14 Oct 2026 02:31:45 +0900
Message-ID: <20261013173145.3412863-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013173145.3412863-1-yhlee@isslab.korea.ac.kr>
References: <20261013173145.3412863-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_hs_process_page() checksums and parses a handshake page using
frame_length from the page header, a u16 the firmware fills in, without
checking it against the HSP_MAX_SIZE buffer the page lives in.
mvumi_calculate_checksum() then walks frame_length bytes of frame_content
with an unsigned char loop counter, so a frame_length of 256 or more never
terminates and the probe path hangs; values between the buffer size and
255 read past the page.

Reject a frame_length that does not fit the handshake buffer before using
it.

Read frame_length once into a local and use it for both the bound check
and the checksum, so the device cannot change the value in the DMA page
between the two.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 38a92f8c25f5b..910505ef4f3ee 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1039,9 +1039,15 @@ static int mvumi_hs_process_page(struct mvumi_hba *mhba,
 {
 	struct mvumi_hs_page1 *hs_page1;
 	unsigned char page_checksum;
+	u16 frame_length = hs_header->frame_length;
 
-	page_checksum = mvumi_calculate_checksum(hs_header,
-						hs_header->frame_length);
+	if (frame_length > HSP_MAX_SIZE - sizeof(struct mvumi_hs_header)) {
+		dev_err(&mhba->pdev->dev, "invalid handshake frame length %d\n",
+			frame_length);
+		return -1;
+	}
+
+	page_checksum = mvumi_calculate_checksum(hs_header, frame_length);
 	if (page_checksum != hs_header->checksum) {
 		dev_err(&mhba->pdev->dev, "checksum error\n");
 		return -1;
-- 
2.43.0

