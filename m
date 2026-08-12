Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086C432E79
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533521; cv=none; b=TDpEe4KayYPDXotT6o2JQ0H0HtxHPUjbiAe+GA2cT6fnCjSJOHdxVN+Ld0uRz5tDK82EHuEbs6XrpV9udh6TsItiJO3P2+Yh20XJQzHTza4rzHZs/KL+yZsLfSJPtEKXq76xn22LL7Ka6o5p2BoxOCsMTVxKB3IVllWbZ8F2dig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533521; c=relaxed/simple;
	bh=OA1LKTN49b5FUMf9V/yVYL0uyXf1T9fnPQ99xO6TDc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1S7fa0cllU0WUpFOn3QfLgMqyXuPrzD0P9ROHlv0XFMXY9YRgrMxo12ZOFWGqLbaoB1Gx9k5kOIuX1Fs5VvGKAnWrN/WrTK9zU9ujNFZDtxWGDo7xwYRYYiYJaSd+PyOeTyy1tLWO2B5yOA6QgKdy9kCqg/FZ3DGB1x6a5O0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY76nLs2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY76nLs2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so9390235e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533517; x=1787138317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gdrr7AdAYBlVDbcFRIgxo33EdXDmWd6yiBKqM/w3XU=;
        b=RY76nLs2XsvTwijTpGpEsEXMAYwayhYLEP6YkKzDwsASK0zSiHCv0v0DQaaaPq0uDz
         9uAYuGJtNp+ONLCR109gBpNLrQ73C8tmePqrjqS0Xtj7bi4iCNEU0onSJb617GeVl4UN
         dEoDe4gUQVDf2YZ3NaA2ir3FJEUUjn7p7QvjI648xLWM92I2fSjEMZr4gP9ez7jeAKnM
         /NQFfLKZKs26qmlbgumab3lLItPn6KKCpx+imba4vPN9fupotLjWdbuuRL4dIv6rYzOM
         6uQ+rbXNVJOatWNBA06jSr76JWEhKXeLmpQiWLpB/xABDtzietcV6870B/xo8he0OuBp
         1QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533517; x=1787138317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9gdrr7AdAYBlVDbcFRIgxo33EdXDmWd6yiBKqM/w3XU=;
        b=r1k/3pCPKkooBnl4LHW9/Z5HmcC7hjutGDMzSySDeA2JTnQN9gVSoJVR55ikjj2mI3
         IgoJflCMACEY2RbCYpAHApI+rIwGWVzXlwbZTLsgq71R/YI0UpWHmN0GXYGxLgb7wV4X
         yzHSBIscavY5YVg9rmgJ+vDx9Z+SUdzQw+YvqZcFjnUIDonaR3fYbB9CSIWCAyU/mV/B
         1pwS/XFHPEGtuDA3anlqp7eLLUvBmk432nsNUdaPEwqtPVjb672ZyTqp9az0d3/23XjX
         0OpaOdPg5yroS97jGNQAT2xKEzKcf6x4n4FewgEc+6tAVh/T0OOXIisRkfhqFmOIrUaI
         7Fqg==
X-Forwarded-Encrypted: i=1; AHgh+RoMyWtQOuLyq3Mjmcf7JYyOb2Jk7Z3amB/bQ/HLMCxhi2u/ockHQMwPXrHCxJwO+NjRk3qyqEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxj9FVGG/dPVsazVHM+cyZUbXEQDWBISfZIpL1J1sQXCfIfwv3
	O45q/pLCRGv3VC0mOb8/l4O5G1ti8MisxQxMYQaLk9JgO9eGOy8DjJ8i
X-Gm-Gg: AR+sD11WlEEjOoKv1LqwGRLfMCWSJlaWNx441QPv0Slz3MGYCFzxVuh+Rvx2SBIu3WE
	LrtJl4UeqYZwje1pf6Uw5tsB4/Chba2S2fs8fOiNaUCApHIkyB0kPVWs0VJusz/9bJ636Ui9moq
	SX+eo8MBX212AHWCl3jSAkt9eR7Z5nMKSTHmZGXScMgBul3Gvo1YiIAChjfPZoeH8BW7gOBkG/1
	FhnUR53Gw9o2DiypvV1T6cl0p0W3gGbAvJN1CPDBRzgaxD9wPe4pWahXbpmJczHIJrU+kz7otmI
	H/0ltn7Xh+553qWCJTNtYOvxdsIwikvwyogWkW/s6ZAh+OPvobKLmGBow3Tkn8EqmInfPoziQtv
	uSBeVfOfe+mnv9NfPIuc8d2MKh9v2njWkMgozmzrvYRrUGuEcVAnOw55Kuv2wxZza5jGxH4mJD0
	cJV7MtFm/JrQvLzj0aSoLfIRgvw7Y07kkaDKnywApcHobhf1FDCpcGMSZjQs2rbYNnr5z8wictJ
	1PyGCed6PzkOLZPhl36QcKpjqWukzf1uZJ9HagzPf0ENkw=
X-Received: by 2002:a05:600c:6305:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-4997c0d7658mr46953065e9.4.1786533517220;
        Wed, 12 Aug 2026 04:18:37 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d702c9sm6670072f8f.34.2026.08.12.04.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:18:36 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 1/9] platform/x86: hp-bioscfg: fix off-by-one write in hp_get_string_from_buffer
Date: Wed, 12 Aug 2026 16:18:21 +0500
Message-ID: <20260812111829.172273-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812111829.172273-1-meatuni001@gmail.com>
References: <20260812111829.172273-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hp_get_string_from_buffer() clamps the converted string length against
the destination buffer size with "size > dst_size", so when the
converted length is exactly equal to dst_size, conv_dst_size is left
at dst_size and the unconditional NUL terminator write

	dst[conv_dst_size] = 0;

lands one byte past the destination buffer. This is the same shape of
bug as the previously fixed off-by-one in hp_convert_hexstr_to_str():
the buffer is sized correctly for the content, but the terminator
write is never checked against that size.

Fix by changing the comparison to ">=" so conv_dst_size is always left
with room for the terminator.

All fixed-size destinations that reach this function (path[512],
current_value[512], current_password/current_value[64], and the
per-entry buffers in encodings[][512] and prerequisites[][512]) are
affected.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 2bf57e6eade4..0edc6e7cfa9a 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -85,7 +85,7 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 	 * bytes.
 	 */
 	conv_dst_size = size;
-	if (size > dst_size)
+	if (size >= dst_size)
 		conv_dst_size = dst_size - 1;
 
 	/*
-- 
2.55.0

