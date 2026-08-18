Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6F377015
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038093; cv=none; b=HUQpc2wndHgvzgCwihcG1cN9rNADn478+KsDNH1OAdpvFA7pdK+PL3zqsywRW2oGvdmCpcUaRun9iS5mxOMy8VVkF7dvU71W74vuQ4V0wY2KeE88rGLRxPP7/4ACnJkNqRzSfZOmtyH3+M+1QS5uwDYN58PO3W7+ag4q+AvpxzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038093; c=relaxed/simple;
	bh=llI1eYDiE1+44pcJabFhew7U9QxDwmAqAUb32p9WxAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWJwQH0jGzuWFoVjGY247XyH0329jZuG/KiTNyi6V6lqL0AToMos9zrQTlhDqNDTfa9Yj4qlPNDJNJNl0NU5Q00Mcdvlcd6DdNkRbeIu9gf5IoOlaZSxOyCA6V9Ms58AxFR9UgIazrzUxObyjly6J4wpY6btLe4epqh+geEiQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b=NTbCVQSD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b="NTbCVQSD"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so2993769a91.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1787038091; x=1787642891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i/J6livk/VLSut+74toCa5+NkTdeXoYOz8nw8KIzNek=;
        b=NTbCVQSD7q3EZJhYjmEdN7PkWwHf/yLZ2dkzGxM+Wk/8ar6nAYvfdi1z4Qe0Z5GNdL
         8a7V4H4WQ0q153QA9uCTI9le3witxiNSfmDoyXAE4ebcw4H50nYxk74IaJQaej8KqBIj
         SvAAUqvGDOCrKH3xoPvMkX4oNnEJxb8Isg/kI7CQ4gEXwO/dBHkLatdyJo58xgedTFDY
         qEeP7CeUYns7o5InGDwKdUkqSlJTjG7aEPL9PgPqZAOip4Lv9uefj6HWJpzUAgEdwYEO
         7pnlfIm5rNe8/kh9x5MYyp5QOAJtyqGxozx+cCX0OWQdS+LB+qCYuCeXQtutbY6hCCGZ
         ePuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787038091; x=1787642891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i/J6livk/VLSut+74toCa5+NkTdeXoYOz8nw8KIzNek=;
        b=AO8NGSNwQ6vcm8Jf5wA9eimVrn6BdBzmYcgJH1DC/TXS1sSSyTCMJYl/iI47+0Ua6p
         6NgykQrikG2PKsJXVFyfg6F5Ty8HK55ORGD74PcVPU8XssfL0EYSQ8U9RlrG/Jw5ftO2
         c0dlsn97WOYPpXrMLo62HLAVT39XpBY3oFp1pDr//jzG7og8XcTVMKg5jq5Eudz4Br+Q
         nvmgj8i1GBBVwo230vcbUyjoF9YFz+JTlHekX/SAbfX2WcaznpcOJnsZ0zj3NOTkdctU
         q8g69E/OKRgQba/omnRVgXgZJmYo2eP7x4fp8XGWWjDl6eLZaUkl3qjBouqQ6xD55MYE
         Pr4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpJ0mO3pX+ur7lnwPjEBIwQ1JLX994aQYtDVE+JXZW9rVxzp7+CKVeYXVIk/RrDmJFAyUdT9L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5T/82JiNrkQqwA1H7vVGXLsuP5oZtw5fC0n7hF62kHLwQN2gD
	fWwMmRskew4XPXROpIEGpQyXw6OpFOHcbynqofd7mJ6lHgqyrnYqqW17aA+ExJdBGXA=
X-Gm-Gg: AR+sD10GEXENSqypBe7dLfhUpiNybJPn1i0CnbYSCG+gZGz0jD9uVR/FwgV8N/ZpJQq
	797oJKcxoVUmcP1OQaB2Tcpevo6n3JKQghPA9vykOlFEK1e/3gCGv9GC0Gx4cXD6eaCj5aO05Vq
	XawzRBGKnnYqzjstsg5VUleqvBsnA6Z/hgqQBHCbb6WSu1g/Sxk+I4ELiFAu+CeUO8llKEV0EFU
	384u36uCqyDB/4AqS0Yu7CoV6uIk3edJzNhoaydaESnTPlw2lKu1Kq5d3r/TEtYrDFdTiQGMc7p
	w3SWIb61Nd+E7FAvneB7evGUtjm5I0nqhsjwp7ElUpybVmKo4Ic4w2XocVHORmgWy83AVtNq10Q
	AxWQVh3PB4AEJH5BtEaND+WbsIymwJVO1U5o6a5r+EATse3ZTjil32drhtASqe+5TG4CQ2WUJ5L
	SRN+/4QLNieMhzVUpjpgdzFSQV9fbzyrXt75nZktvuII34QOik4u67bjD1wmB4dOq6ottKDed7b
	1XHfTiComwlq7yOwDYktmdL+l2Z+kx7CHBW0IaB4ue0ZHJf1RPm0O8=
X-Received: by 2002:a17:90b:4b01:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-3933b714d4dmr29278418a91.2.1787038091235;
        Tue, 18 Aug 2026 00:28:11 -0700 (PDT)
Received: from lucianna-LOQ-15AHP11.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bd51sm5146630a91.12.2026.08.18.00.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:28:10 -0700 (PDT)
From: Zhang Jie <zhangjie14@huaqin.corp-partner.google.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: gwendal@chromium.org,
	swboyd@chromium.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Jie <zhangjie14@huaqin.corp-partner.google.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: proximity: sx9324: Correct proximity channel resolution
Date: Tue, 18 Aug 2026 15:28:03 +0800
Message-ID: <20260818072803.463864-1-zhangjie14@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The proximity channels were previously defined with 12 realbits.
However, PROXDIFF is read from RegDiffMsb (0x65) and RegDiffLsb
(0x66). The SX9324 datasheet assigns bits 7:0 of each register to
PROXDIFF and documents it as a signed two's-complement value
(Revision 3, Section 8, Table 8, page 43). In contrast, RegOffsetMsb
explicitly marks bits 7:6 as reserved. Thus, PROXDIFF is a 16-bit
signed value.

With realbits = 12, sx_common_read_proximity() uses bit 11 as the
sign bit in sign_extend32(), causing samples outside the 12-bit
signed range to wrap into the [-2048, 2047] range.

Correct the realbits value to 16 to accurately reflect the hardware.

Tested on an SX9324-based device: a phase 0 DIFF readback of 0x7fff
was reported as -1 before this change and as 32767 afterward.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Jie <zhangjie14@huaqin.corp-partner.google.com>
---
 drivers/iio/proximity/sx9324.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 36c45d101336..de6176fd8d47 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -223,7 +223,7 @@ static const struct iio_chan_spec_ext_info sx9324_channel_ext_info[] = {
 	.scan_index = idx,					 \
 	.scan_type = {						 \
 		.sign = 's',					 \
-		.realbits = 12,					 \
+		.realbits = 16,					 \
 		.storagebits = 16,				 \
 		.endianness = IIO_BE,				 \
 	},							 \
-- 
2.53.0

