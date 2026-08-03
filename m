Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30B343896
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767458; cv=none; b=s4h1smYF94htqhHGekWxFSj1KzvIPUJT38yfMLRi7VKhvIulbcqUJoGMiKjw44na2AZBdUPptLYTMS2WtmSj++MoxDMs4/BCI3hb4X8of4mR9Yvh5F00Yb/5xuWeJBZOm9v9g37P7bSgEW/OsTVq1IB6Bxn13ds+fIQMyVEGFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767458; c=relaxed/simple;
	bh=OA1LKTN49b5FUMf9V/yVYL0uyXf1T9fnPQ99xO6TDc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDRP43UMDOxad7AcFOSsFPpDXsPKcx7ElHlBkQ9C29V+TdXSfoyKflXGyk/kbWoBm/XEQXz5c/AjSQ8TnSniGoMRSvonyFFc3vHlfMTYiL0CcdZOTjx2u0mqytNSJjv/OnScZFamyDH0vDlMywpsTNzvGSVRA56QHr9uz8tEzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5U5yhws; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5U5yhws"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso14535225e9.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767452; x=1786372252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gdrr7AdAYBlVDbcFRIgxo33EdXDmWd6yiBKqM/w3XU=;
        b=j5U5yhwsTyH+U4iVWzHP8r5NInK1VVUwZW1yOXBWcT/bJGPZbJ428AEpdRbAWPRake
         ZFtN2WPAwhCQs7wpo3uVAQdmAxfA8kdaZTXVniLGgqjt+z9cURPQuEUJgUv5kZMpmbFi
         u7ppiqqdvSJdP7OTyDDbc1+pFgxKItGFHXCpRuBBb7DoTFrSGhg70pvQ5mV4s+9Dc0sC
         SFCUf5F8R44nhU5Flznl3ESnEVtsvQng9hk09yNSaEYBBNSXZqHXAF4HA/wgyBL52IP8
         JJ4HkwwxpcOu28y2VR1SfMpO1WBALv0YVAw2Ad0DhUgV5E+tGH2jVALM1RZTt174SsKn
         flUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767452; x=1786372252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9gdrr7AdAYBlVDbcFRIgxo33EdXDmWd6yiBKqM/w3XU=;
        b=Uw6f+olnz7ecKqHFtProV0P6hHgDSAetYh6ZsdBIfBntEpJBITXmNw3Yh/Kri/U78T
         BN0USWcHZQDcy/faZKWyzVSKnQ6unCQLVdcgRDHdjETIGnk2Cm8bndTg7375oClicehc
         RNQO6Lwjs+9tnOHnaIpIbjWK7IXq/6icnEMdtCgnKB+Jkq5gjBmHrrvCTx/92IumSJ9C
         zx1nMYLQmLWehieSId0F2dqde1uLsWpqhCuPmoxg0N1EatlzFNODLYlTxYEOfj4yiCOK
         lnuN0ULeEVqy+gxsyYmn0XhO5sB3rcDLsjaqs/4wPHPnHZcFWPBfm80peU7He5QDAGg3
         VWkw==
X-Forwarded-Encrypted: i=1; AHgh+RoV1x3YgXSCsurE+2+q97j3LxjrAZNQmpN8AyX//k88TRV//UK6Hh17em7viqx/DAS+aVBMSuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgL5AHtHaGHaIW1v6aUixq8d8qhmqqWVbtOnScfa1L2XUMzCo
	pxKtG0u6zi3CjuseWqi4w9fiK+v5ZKALYs8e71DifXq7WuWLFtZs1ZC9
X-Gm-Gg: AR+sD12oGSY2fpvpdp8Fj/TRelo8W8JPQWZVa8P54w4aUQSgXG6UxlxTmd3Ix/zUAOG
	F9UNdxq+AHNl9VEOJQ6A91R4NpDU4z40KnvmWCf1ysOfO9MR6amAEFSE8KV3WsHAJkRIBxOuca2
	ZlciTnaPpJ2rX5Cnq2kHfEqeIWHPxkmafq3g8m/okwbrEgMQSKYh6XVwGe5s2p7UGJJ7D9yRgh/
	zVwbsxw6OGlauotcpqvCtwNsY8Ab+c24TZ3Zkmdi6nMbgXVWemGgUTURybCEv8L6RZXR5X2qplr
	EpWd0tpt9ZBVctW6cBKmRMowfVoH7ddmPAPxblo9I6EEGn6fIfSDKVtmZEW/u/PrFvNj1sK5huL
	u/FgqjxsmaKRqgbaXzaMG3yqMSQ91ljSKi9t2hrPh1f2n2vjIIZBNj7m9IqyajHB3bjym+D5mQV
	vSS93kUAiGynGiWYZ9VZLb9lYzSHaGkkCes62ucg3qfSsIcg11GIc8zW7xylMLxGvFN6p/vT9mr
	O7ycknI2Nn9H2LW5WVZImoCtr/0YqyiKj8sY4pJwA==
X-Received: by 2002:a05:600d:8492:b0:496:c2fd:1731 with SMTP id 5b1f17b1804b1-4980c64b96dmr166980395e9.1.1785767451905;
        Mon, 03 Aug 2026 07:30:51 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:30:51 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 01/13] platform/x86: hp-bioscfg: fix off-by-one write in hp_get_string_from_buffer
Date: Mon,  3 Aug 2026 19:30:24 +0500
Message-ID: <20260803143037.93105-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803143037.93105-1-meatuni001@gmail.com>
References: <20260803143037.93105-1-meatuni001@gmail.com>
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

