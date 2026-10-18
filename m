Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DB414A1F
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361034; cv=none; b=W0+B8xE66mzQLwopWKzSaUPs+eadoAageo51niCvI3pI2QRMMQSD0zQCzWddVj1eftfCGivncZZ5wHcY+0RebXdgUKsloT9gmmCSILnEH8Y1S1jew5li86xDocZBxp5NP2NUDBfYYlDw3jZ0qsxbV5t8oFTlmAaeR22uUwX4ZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361034; c=relaxed/simple;
	bh=aUzjK8ol795HHRbJphJgtTRR/M0uYgvtIthrbMPir8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0v45TxrohS5/BHoeHsybamJYtZwZwNeTw86tRUK8m9OkUm8iEr1KU60CZf2j+V0anahEfdNpMuG1760pDTkAUcDK9uDlpUOMMjWdw6IG5RPkJeqYvbrWy8jXFQtn1f2fGjzi6vX59uwCHD4mwCBBRL8yqYASpYPfe2US7VWxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8Sh5Uvg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8Sh5Uvg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso6509715e9.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361032; x=1792965832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXhRvFfpFMAeLGmziHDEZsV8hAj7bw06PcLUuNh1ghY=;
        b=Q8Sh5UvgvP4HRrHOAx0ND5VXeQOPGy990Z0B1Ea/1GNOaTjbrO/AEZvI/8STswJjDi
         QrcXdQIdUlCHuRh8zXiKOuTi9NluUCwRpX0xtzOnyEEcV6PVuLMd5UuOmEJkhRiNlkuj
         LkQbRXMknDeo493qrDRBoAh5s7BBRSbBIduMK5bA+c6yndEL51Z1vQmVSi2OsdNYOrws
         KSIDsDp4XOYvxTkikKaEBImKGQrLOBGhy+6HoTyT+n/pmuzyL6gNUmD072EZAHyBMcoB
         sjX6s1iJH3Mu7ncqjhxBNoNgw3xqSqeVLFD9pldlzwgJjKECuu5q3chCDZdpVvTP3CkW
         3hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361032; x=1792965832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qXhRvFfpFMAeLGmziHDEZsV8hAj7bw06PcLUuNh1ghY=;
        b=tuvAwio/RvmIzyFMlLD7NJGY+F5e7Tyj2nz4cxGNBfmIblIa94OALEQhrhVcFC2Usx
         IKlDBbgPUgJ5IOm6U3s9YFO8qtwE+FQ1B100tIbR/DrI4G9yUKikFCP7jpwN7mUReRYA
         spnuEleT7+7I5P3beangxDEB6EV9jNm0Jc6AhmPhRv2kyaS1J4KCjisax+nqGB0fgKc7
         dvVQ3kqcyNN2YdTKXyE5uNXgoMy3Jum4nocOWTjDaFJ9epB3OKTZo8z6yAnO8ygj61bZ
         pwbJeTjqincRxqK9ekJFHF0X+DYBODQsNnKjCrNLleXC9s98h8EOyqUYfqGr7i0g6Ojm
         GpgA==
X-Forwarded-Encrypted: i=1; AKwUvBywJz1NhtkAMqY0mLgmMZBCtdhKSji1vd0kHim4weVqcIoQXzyjDPOatWTFoklh073n4JoW7LY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLp5F9SZ6192ChRgZJ25bifsEP/mm90exeh0/fVAY9LzwMPah+5
	gsJpyhPQ8vypLSPjtbWvYHY9h6h0wcwI7l0Cxn4yOa6J8llqUrWQHjYf0tcm
X-Gm-Gg: AYBFou3NvpmYtFwP2ac/dBfFoHTKduyxL1G5C7XIATyMBlRyv807gTqz9MgctUwnrNQ
	NbjXwAEptpdJikltcCaQBXBnmjcRCRQfbxhGQ/bJO2x6PI47KfI+MC0+N+i3WBZ6lrDmjAlkMwc
	Sfo5VI63LW/daUSa6+dqqYcgqGiA3WsDNZ3Ci0juuLM+FtQgdc+G4nBKTNovkncyF6eJnxad+9F
	/XPGDDN5kDD3f3RoECS0Lt+UQPwtqs4KgwRFDMS3q13lW8xSmNXG5u0tuYZhPZbGzPdA+kl9bVJ
	6II3/MXtf5zhCuxBV5GPrS2q9jIOzRE7IxsZJBHeTZ6Z1OVnRf9pxu8I8Wn5bTWOgLTNsZGhjlZ
	y22zKLLKNHBGI+6FH1KxJ+IUZWbKCP5E8w7LtmjPip9AAZ6uhBtd48aZkfirv78PrpxB6LvDFTm
	0KfEd8/lSJhb2shE833cCccqObBwc87VQ70zyCMSA6ctKtzz5o2g==
X-Received: by 2002:a05:600c:638e:b0:4a1:e489:f8a1 with SMTP id 5b1f17b1804b1-4a1e489fa67mr42945455e9.2.1792361031771;
        Sun, 18 Oct 2026 15:03:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 6/8] HID: oxp: validate report size in raw_event callbacks
Date: Sun, 18 Oct 2026 22:03:42 +0000
Message-ID: <20261018220344.1987142-7-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018220344.1987142-1-tristmd@gmail.com>
References: <20261018220344.1987142-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

oxp_hid_raw_event_gen_1() and oxp_hid_raw_event_gen_2() cast the
report data to struct oxp_gen_1_rgb_report (11 bytes) and struct
oxp_gen_2_rgb_report (16 bytes) respectively, and access fields at
various offsets without checking the buffer size. A device sending a
short report could cause out-of-bounds memory access because hid-core
invokes raw_event before it validates the report length in
hid_report_raw_event().

Add size checks before the struct casts.

Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-oxp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 1e691ebc1199e..af9f60d45bf29 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -318,6 +318,9 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
 	struct led_classdev_mc *led_mc = drvdata.led_mc;
 	struct oxp_gen_1_rgb_report *rgb_rep;
 
+	if (size < sizeof(struct oxp_gen_1_rgb_report))
+		return 0;
+
 	if (data[1] != OXP_FID_GEN1_RGB_REPLY)
 		return 0;
 
@@ -391,6 +394,9 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	struct led_classdev_mc *led_mc = drvdata.led_mc;
 	struct oxp_gen_2_rgb_report *rgb_rep;
 
+	if (size < sizeof(struct oxp_gen_2_rgb_report))
+		return 0;
+
 	if (data[0] != OXP_FID_GEN2_STATUS_EVENT)
 		return 0;
 
-- 
2.47.3

