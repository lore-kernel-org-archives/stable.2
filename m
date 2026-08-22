Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F0C1B4257
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787402740; cv=none; b=HmZq89F5Z4RQ58p5qBlxQAfTP4QmznxCfIVSoqy5+k1SWYINa0Pg1gtIqLZIq2n6/CmP91TbGrB5ezi4rwdqkEEX4x/BrQrVIlAGkgXQJNRW/KA+sANO3GoCpdqjk6EJcjSkvotTLg1UcSTJp2PM3NW2kbJJg3ZJ0hjz6OGcCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787402740; c=relaxed/simple;
	bh=LZJbmfQ2dqHw1iRvUikp1f1wAvVzItuWaTYQMuOX9hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKMgoyXzhnO74vlyYXvR8dXB9O8pAJ/jAWxy3vrMNAmy7FitXbe16wm8K7JI77g+GPMMou9TcUkPW1OkmJGFUPs/N0iJU2wnCGSkt6gM5vLpLIhhmT4YyphPEMx7aHph3H45qdowmgKdfaEI+4tU0Ve8Bxw5dIdfuCLyb3NDPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzTQ5df+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzTQ5df+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so1465109b3a.0
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787402739; x=1788007539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hf5OrcpcITaT5sgCq/QOiAck55Lc6nxzm/MZWxuqlc=;
        b=rzTQ5df+EUmDslXEGTlCOEYA8vfXMt1hTx3w5TcS7zVvoJBVTjlYH2ALDYMl6+v4Q3
         nEWqhgSlGN3G6vGSH0r0tjXWoyYmdMMtFnjMk5XAMRxvPaTvOvgl3rbzEWp0aUCOJlTb
         jcypzL66ph+hYTmdnfGwkDQtr1zTIlHw6Mx+U6qwUo4bMZLPB5E9jrilCbCTAIsYX0as
         zHFmFfk/Y3Ucy3+sERw66iOsa/qX1KwKHHvgyN5I6n6itt0RhguuPSuR0zPylc3fGElE
         9F1K6s2KIIxoWJsnZINMnYffa6CmMPs0oHMaRKcqQPYq7Al0jgdx9I7Mobr6TD7ZiTkV
         dPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787402739; x=1788007539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hf5OrcpcITaT5sgCq/QOiAck55Lc6nxzm/MZWxuqlc=;
        b=JSYF9+Bao2Zt5m9Q6bzao/T2xROgmVR2QG+bwQOoaFMelkz6am/Isv9vC3Jg+yhhqt
         98wC3yGAJLwGdp3Gk3P0jsBM+UKnwuxvdRoB3OZU5JA+XQqEECnrJa42ZqYgTZf2bk2E
         3zphuMe1Wkgba1fKk9CLxQxpVeGTx8dMM6mj/77ImPkWkA+hcatxbwWfd8Kpj5CFe05v
         hlGofDFPTDBCv/6Theb7muelDG7N596K7md80p6Irdnnn5GMOFgio/KvMoOk68RqCcFa
         Dw5oxSLJ3+df9et345LOiZ82PpV1ZTqsaplQO/qNgKlJy9DRnKtTSylp3bkJSKMVs9EA
         WjoQ==
X-Forwarded-Encrypted: i=1; AHgh+RozOT39QgyX+Ff6s/DaHxji2B41EbKPBYsvaMJV+GouiC2zSDgGaakMO/cA+QjdnBdFpxaI7aY=@vger.kernel.org
X-Gm-Message-State: AFuF++mf3oJKvbraIc6Abtyfq5UZsFWzFmgB6XUCwQ8fxHNhSPRWC/pD
	kPAPK6lZpOfrgVdgxUqJCNlZuwTLDTNmhfU8nlEUyhJBO3i492Hqguqv
X-Gm-Gg: AR+sD13LgTxvNqlSSk30JXgrszXc4pOxZw2xBY5lHj9/vJZpZzamrELbItVJ8Leu3/+
	VknewQoepBMewvNwmuu5oRsJZ1aFLibogwEOApZJXLXkG4kaSEazneglu7/Gke0AKsVJsQAU0Lw
	AFoFx2RGBUg8iUPGVdwxn0DuquuuIJyywI7+7m4l7i+clkt20ImVUL5DFPHCaCiu2/Io+O5VmWX
	S43A1YfVGCzO8IKrHJJTd9YKm7IUX1gMDQnQ2KIGp9pPoQMP3DPGLzR+FpdyU3ASaidhjzI3acI
	D8iLmpVJ+a12L72W/Uw6IGtzPiGmRjg4JmiJabB7m4UvKNzLUNu29aGMGAm+zaSUfCaS/X1/YHf
	FYSl8Knr67glL0R/NwPiQU8Fn0wObq80xOubQzEQeJcrQwZ4LP61foj1pxeUd5ydhpe/kvOdPGr
	ZYMjNlO+dWHulrg6WCY0aFgjCNoJh0DE+8HHsHZMNBuLxWBT9Zz5ZO3zEdWyq+vhtCE/rwAAXDQ
	JGi/+lJeWOi2uy5KS2sNjtDPEMT6LrGDTvpf8EoJ+AfElriXBLvoQ==
X-Received: by 2002:a05:6a21:1583:b0:3c4:511e:26ab with SMTP id adf61e73a8af0-3cd2fdb9115mr25629725637.3.1787402738686;
        Sat, 22 Aug 2026 05:45:38 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15523489fsm3842078a12.5.2026.08.22.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 05:45:38 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input buffer for the DMA
Date: Sat, 22 Aug 2026 21:45:31 +0900
Message-ID: <20260822124531.644834-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quicki2c_alloc_report_buf() sizes input_buf as max(max_input_len, SZ_4K),
but two channels deliver into it and dma_set_max_packet_size() rounds both
up: RxDMA2 to ALIGN(max_input_len, SZ_4K) and SWDMA to
ALIGN(max(max_input_len, report_desc_len), SZ_4K).  read_dma_buffer()
bounds the copy against those, not against the allocation.

quicki2c_get_report() reads into input_buf with prd_tbl_len NULL, so
nothing programs a length, and a device declaring report_desc_len 5000
with max_input_len 64 overruns the 4K buffer by 4096 bytes.  The RxDMA2
leg additionally needs the I2C max input size clamp to be off.

Size input_buf from the SWDMA packet size and keep the 4K floor.

Fixes: 66b59bfce6d9 ("HID: intel-thc-hid: intel-quicki2c: Complete THC QuickI2C driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
Not reproduced on hardware.  Triggering it needs a controller that sends
more than the lengths it declared, which is the case the existing comment
was already written for.

max_report_len is reused for the report_buf allocation below, so that
buffer and qcdev->report_len grow with input_buf whenever the SWDMA
ceiling is the larger term.  Both stay bounded by that ceiling.

 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 0d2ad7bc3648..f6f9f95296d3 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -602,9 +602,12 @@ static int quicki2c_alloc_report_buf(struct quicki2c_device *qcdev)
 
 	/*
 	 * Some HIDI2C devices don't declare input/output max length correctly,
-	 * give default 4K buffer to avoid DMA buffer overrun.
+	 * give default 4K buffer to avoid DMA buffer overrun.  Both RxDMA2 and
+	 * SWDMA land here, so cover the larger SWDMA packet size.
 	 */
-	max_report_len = max(le16_to_cpu(qcdev->dev_desc.max_input_len), SZ_4K);
+	max_report_len = max(le16_to_cpu(qcdev->dev_desc.max_input_len),
+			     le16_to_cpu(qcdev->dev_desc.report_desc_len));
+	max_report_len = max_t(size_t, ALIGN(max_report_len, SZ_4K), SZ_4K);
 
 	qcdev->input_buf = devm_kzalloc(qcdev->dev, max_report_len, GFP_KERNEL);
 	if (!qcdev->input_buf)
-- 
2.43.0

