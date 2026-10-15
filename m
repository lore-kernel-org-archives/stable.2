Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D933BBFC9
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031268; cv=none; b=KjzDm14cvVN+Ar0DBiFjmOU9D2lMQC9/CJneWt77lBxf641mlCcNdYnndkCRD/DFE5E1Sr0pENh6bHlui6C1z1VRCWBka919XevX2au6Fe3NI56xUYS80lbp0FpitUDauoMU9j1/5hYe+m9EjAOo462mATJVrmqa7kXKHax7Pm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031268; c=relaxed/simple;
	bh=/0Th4cc1vO+E41gV5mMuaLCXH78VA1Yl6fBR7oSaQAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tshvI/E6mx8C9rJ7B71GyE/+qu98d3oY+yDTmopAh9OnWNU0DS5+hBDYhWcwvGXOJytbmIEeGSsiM4ay1sjVUFxgzGIMLJNNbj2U6qjqBKOR8FM7elapxuzjuUIroYFj+WxB8P9xw0WXbu5SSjur7EKiCpzdOOSBadeer7029xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=dizI9T/Y; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="dizI9T/Y"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a706146559so2972281a91.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792031266; x=1792636066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPVBPUAW/BeX8HkZROCJHuR0r1MMomkKnirbqP6fatU=;
        b=dizI9T/YfTT2XTPWQ9LDHD0oWL72l7L/W2N7b7Ezk95TBsyQMZm8fP7eJ3oyh/uPr5
         1YfB1U3IuAr/lmeU2bT9NQvst0OIcZhm8kLYfCasWB3BsACXZ0Bt1GgSEOHz+185rDHL
         U/ppNCfyBYSd5csa5ocfyc1iDksMcsnNHoZRrhdikvLJscaVYfdZQORVYkNWmGh8zrOg
         lfNharDrCtDpwlbIRonlSs4ZeJtfmsSNZDGNRclRtviu0PrKZZsnkbSxLEol/+5cOj7K
         ix3fHk+QzvuQD3N+qTc1FFuCpCUAXeRXkG83PnO1LrUOsdRbnWEoT+uNHmziTU15IoxT
         E7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031266; x=1792636066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPVBPUAW/BeX8HkZROCJHuR0r1MMomkKnirbqP6fatU=;
        b=R8xX6zC2cGT4nw/oFscntb2rTjhbuY+PoeCrpbfi2OT+S2bJBfrs04t8dNiGFaP1os
         2EgcQ6nPDTKI/G134Ox3k/cri5KA186Y8kw4ID2/b7Tdk/rWwMtjYZKctPLnZGwCIM3z
         HCEh3n6f2BSI3G9P83G5WMiaueWQTiyRRJWBlNl8+B92H7zwDKI6d4hJMbX7RJpiSjbd
         V/U+ljBg92X3SBCMGkV9/BddfA+KS4fjl8uplNpgEZ0Hkglxs7/VffvwiAC7Ed1AwlTX
         T/+qt2fa+nclKIaocMLG86WEhYQejFIy9fKa+Jn8daI8Pf1XZz7lkfiPg10UpXJdHiBi
         0v0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxV8IdkVCKW1QVbfQBJW3LG5iT5/Ut7bEoHUewx6Q5WTELomOI7viLX2D2slGIV2XIehKPVvDQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK+eprqsNMDXqbsC7srb7dL3REao6ePE4xjcsbW11QA2dJIkjl
	7jlgwI5eywRorkS+19nMDZ0plNvMnvpi3qMOtd7O3uFY/8gs11M3ARVVZsxF6TGNWHg=
X-Gm-Gg: AYBFou1y+qYx277pCm1IKUEw84omPyZSRUwy+7zlLTLr/8At7PRV4I+XRvYtOX8hwDu
	bzQ87T+KtRjWtI3J59x3KgoZjp6P2mI59UrU3QwWGCDi8+R5HlYj/o+Qkf7GUcfFwY/IxY2jzUQ
	Cx7AYzJr8mQzhFagG/KB43Yp56RPa+Ul2O9aV+DIpBe5tMGFqa/UOSwGbDZUHRsZ8bN4n5nliP4
	BiVmXeDlo7+BJxH8o52Tz+hn5R6MItdvTuGTOw2XRIRUCI7FOWycklxF9oQCzx0n2IR2IthAbhL
	xGFJU2oyO9z0NdP1QXMHS9eCSvt7BIdee48D9PyNY4VrVmFmWUX3ZV/YZWiIC2ZALZ3//xA1PeN
	IKBmx31VeMuXiS9b33F/Jy3APZAR+7BFwkboG80hpdCzaDVDVHQMs4Zb4zT0lAgj6ABcgIfTPts
	dWpX/r63TV9J3hIUaPbS0nTExfgHidvXb/gdVJ6YBBqbzKNne1LhPZI96Xg+wsvZ05M4rXUZFrw
	nMBfQ==
X-Received: by 2002:a17:90b:2805:b0:3a4:ad5c:d48a with SMTP id 98e67ed59e1d1-3ab3ae69636mr14696943a91.67.1792031266410;
        Wed, 14 Oct 2026 19:27:46 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94375f3fsm1997383a91.4.2026.10.14.19.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:27:45 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v8 2/8] scsi: mvumi: reject an out-of-range handshake frame length
Date: Thu, 15 Oct 2026 11:27:22 +0900
Message-ID: <20261015022728.3936714-3-yhlee@isslab.korea.ac.kr>
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
between the two, and use READ_ONCE() so the single fetch is guaranteed
rather than left to the compiler.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 38a92f8c25f5b..2378b676a7a78 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1039,9 +1039,15 @@ static int mvumi_hs_process_page(struct mvumi_hba *mhba,
 {
 	struct mvumi_hs_page1 *hs_page1;
 	unsigned char page_checksum;
+	u16 frame_length = READ_ONCE(hs_header->frame_length);
 
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

