Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06783489860
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470900; cv=none; b=HSCpDGRgjr0cjQZaJYlw3op/14vNrwfBw+OSlR+9emX/RzC+cgME3YtPmSn6wmBgKD1Yf+X6Fo/jJRzs5BZ5l9BecejaZx/TriQu4IfG3XDXRseJ6i7AGm4V1wc9f3fS654GamRf5uhdcx78MN33Z/4x75BNyCnqjFoOlFmnY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470900; c=relaxed/simple;
	bh=5AHgHgB6VH4XZX3hvyx2pZkcJi0cNjv4poJfNW/ay0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fna5z85dAscbAdamYnLrnmQ4skBTlrEGGTgMBNahFfMFjbRViVZdvSTWk4u/+72iGa0p/KWrnD4c9OJjsNLuLfLoinzMvpoNbIaQJ+WV7v01hQYSw+69cLsEy5TiqZqhLBKjNqaKnelqeJZuMfAgGeysxdo52xsSwgpDcZRNhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbY9B1GQ; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbY9B1GQ"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e52ff5dso106961e0c.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789470898; x=1790075698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCdw27tCyzyXJY8Xvi6GCDTblnDPWCBRkFu5Pb3g100=;
        b=sbY9B1GQAYWt8J0WtYrDr8cwkrGAD5VL1ltK8gS8fIhdf7VyzejtTmqUuNeo7bV5/7
         UAjFx7+JO/GJH/T8+VfFFfga+6EReTR2lSOiKodaPLlfKw/82vJvEjKRqNzavpvrvfC3
         S/M73QmH18u61P1/njNb2yzsttBwPonQRr4WxT4GKZ/RNp/V7vaI+AfecPqSf0osGUUV
         OJDQ9/L41LEkbs4mQd2AY6jXC1qKYMWLSv5O/AT2MtSWFvRPwmjOHBIIodjftlI1u7Zl
         muTV86X989k5PtV32bv0LTTnCYyIX8HWgADRewgghUCO+IHphgXVCOLDZ+96QsTP7UTQ
         UwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470898; x=1790075698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCdw27tCyzyXJY8Xvi6GCDTblnDPWCBRkFu5Pb3g100=;
        b=eilzgATWtwd78hSMehKD5E3h+fg++xLmrztDqLLNGbA7cL3/oBh0/xCkfcdNec2j8G
         GigHIDGjj2PWRSoKThfYGiALB6FqsPMZDPW2fJ8eraaq0xiNfRek6JsJzf6gRxZmUHQs
         DLxIRjQPfsklZ8z10DEOfYpEmFa+Ue3xCt6+af2OdLY+KqUxq+nTg6nCTvvrUaChhr6T
         nY0oN1EGLC5oYOl1+LXibSegifuE2DIDhZSLifaGtrShL8oM3U+kGzI+lOoEiFxS51eR
         AfFTCK91UtWZoB082b1sIG3j/nL+NMkxhEZsxInBr3JQmRSFm2q/LZDJWmAC4dIALwyy
         jMHA==
X-Forwarded-Encrypted: i=1; AKwUvBwuQbwps/cxyHkGWTo5b2MfIakCrfM7/WoVOFaIkdwjkufsfBsMTYhewistYy/lxXUbqFLegYE=@vger.kernel.org
X-Gm-Message-State: AFuF++l3lBicv9U2vGQG5h9R40h3mbf9rGfIFV10WkGZOSK4qt7GSx9D
	iXSFhDztQa2Dj8/GijgDuo/862nNaE37i1M9T/dXI2akS1IZlWoNHdy/
X-Gm-Gg: AYBFou3Rg+Ok0cum2fc3ZijlM82KBtbxDISJuBALIClF0qT259kTduGOYwLVh8lRX9F
	1H4psKCLBUijiYKCIBMwcvMsFDZ+PoArmHCRJRIpudqJe83RK9/4b9lzlQqvKf5x22ZeZkRXPad
	cJVNlJXJ5j37hDegTb6nhziOC1ULscyP5aC8PZKb8Qo428dUMbJiKrlyKiYtGdlIBeryT8bFgyN
	uU9ZHQVcxcoeYcURM8ZT5FUoM0DlEyrK6hhzv1p8t2QK98Gmi7kF5F/JRqdHuSpl2GT7Lk+H11S
	WBWGGX+W45kSJjEVhuqB+6WfNrFfC1zbgk4Jb+tE53j1MhGUma+hvMahALzipcus8oiiFOLubKz
	8d8XBlVTl77Z5ugl41mYXlV24UU5bpE86i1q6lsgICNiRAhFmWv1/s62v8GVC3JtroioyYHkSiI
	hZEM0YunbqSzdW5M17Iz21bOqvKEAC4XqysHX2+6G2I4NJwxfYpaqv3mzMllHcaEwU
X-Received: by 2002:a05:6122:1d93:b0:5bd:a5e1:c7c7 with SMTP id 71dfb90a1353d-5c99393b389mr389978e0c.1.1789470897998;
        Tue, 15 Sep 2026 04:14:57 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c99149d764sm739548e0c.3.2026.09.15.04.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:14:57 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] HID: wacom: avoid overflows in sequence number tracking
Date: Tue, 15 Sep 2026 08:14:47 -0300
Message-ID: <20260915111448.2726869-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dropped-packet calculation derives the sequence range in signed
int arithmetic. A sequence field whose logical range spans all signed
32-bit values makes the range calculation wrap to zero, so the following
modulo triggers a divide exception.

Do the range and delta calculations in s64, and normalize the delta after
the modulo. Also avoid overflowing value + 1 when the received value is at
the logical maximum.

Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 16-bit")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/wacom_wac.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea856..39ffe5e7c7 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2530,13 +2530,21 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 	case WACOM_HID_WD_SEQUENCENUMBER:
 		if (wacom_wac->hid_data.sequence_number != value &&
 		    wacom_wac->hid_data.sequence_number >= 0) {
-			int sequence_size = field->logical_maximum - field->logical_minimum + 1;
-			int drop_count = (value - wacom_wac->hid_data.sequence_number) % sequence_size;
-			hid_warn(hdev, "Dropped %d packets", drop_count);
+			s64 sequence_size = (s64)field->logical_maximum -
+					    field->logical_minimum + 1;
+			s64 drop_count = (s64)value -
+					 wacom_wac->hid_data.sequence_number;
+
+			drop_count %= sequence_size;
+			if (drop_count < 0)
+				drop_count += sequence_size;
+			hid_warn(hdev, "Dropped %lld packets",
+				 (long long)drop_count);
 		}
-		wacom_wac->hid_data.sequence_number = value + 1;
-		if (wacom_wac->hid_data.sequence_number > field->logical_maximum)
+		if (value >= field->logical_maximum)
 			wacom_wac->hid_data.sequence_number = field->logical_minimum;
+		else
+			wacom_wac->hid_data.sequence_number = value + 1;
 		return;
 	}
 
-- 
2.43.0

