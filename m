Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B95282F2A
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785632979; cv=none; b=IENMtSlTeKFrMCuS92Lyt/6jppRSSNqnqiflzrymgW/sFy3qQn9f38C1/jGLy2SsUFYdav//6NX0rGjnMOlR+NHrR7CCE8U3Pj9dziA6f/0DWjmPU3tz27+67geaPF71HxsfbjvoIKTvv/T1UxqxzajKvfErav3dFQQshR4/p3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785632979; c=relaxed/simple;
	bh=XGVeqwLGG9Yi8rlWz0MjL6XX5o9AEpbMfH8iIsKVna4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1DfGt//WFZn5CL1lVYPmn1UEP945J2DFitR6jFM29mWJw6mmLth1kJ1IHdw2O1O3B3iLooImgIl7PO2HbYU+ZWTBalwZzCu0nyXxM+Ci7/WnggnuMopVwuPekVZ8SfrH9LTydbKTV8sEHTyGeMuTnrbhmEaiENl85xupT9UfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCSoRAQU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCSoRAQU"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-476a130c138so2563501f8f.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785632975; x=1786237775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mTIJMZeV8CmN/ypHsLJVAdwnkDUycpvxjXJ8wexL9fw=;
        b=HCSoRAQUeaPbKb0VlD1T3NTlTAS0nRqL06gX+y9vSG6yO1CPnHiCwgGRdYOS29/YSc
         P8M8M/NanWx+z4opl5BbyRGFBb0UUY1t31apQGO//74Q96/23S9MAkojqhKMbseGesfS
         bBg4uKNG2CR29McSnH/kdJYA8EnWOXrzOIXPHoWK8MgqGLtMfd44AT2EeqDkWmbF562/
         H1TWjXbbWwtXwcd4iOttG76rfXLOsWHo7Ii6gqfkJQy70jWRsV7Py5d84kJFXmwWZ44X
         UXOQN65bCvH+lNugt3gmpZSCJ8SqLQ0C/hG8Ks/moH2oJaEBG/tQDTY0xKEqTTwJIUo+
         EJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785632975; x=1786237775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTIJMZeV8CmN/ypHsLJVAdwnkDUycpvxjXJ8wexL9fw=;
        b=ApU47MZEomQxfo//vGzADoiHTAJgzvurBb9TjUw5TAU+dHuveGAh2pDbm06WT0ePqr
         CR9gPXgjL2nnHBXCs4eLEntwphcvdtqxpU5MBMIiBZZbffZorYM4mTyF+U8nwumi+iUA
         9jz/R3g5yAtOJoQfiT9iKtzC2QmzYqwTPRPOObumdgzL1BA/dxzL5zoLi1KLBnB30oNc
         5F0Nd97JH3agMjEKl2s2bibYfBiGb9hAYSa+KGekWOB7lPNAf/Ihg3pZZeATDGx7A0LR
         FHYNwobdXp9lCQCD+0NZAppOMmdux6uVKFKHZJ54yxzBEVJOuwCWN3WJvztBv5+o1WWF
         NJoA==
X-Forwarded-Encrypted: i=1; AHgh+RosEHdc+IrDY12ji9VuNJglNtUtLdnspzD5r0hYVrnthKoU7AyuadeAUZpEZ0kd+bWj4Z+kG4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2Tc3qfnK21Mai0yVvYWQ7Qpb+3S/mIKDnQZWwY6MKoPepCUA
	9bY6/1ezlsUt2osQf74qIRAuKMEbEc9+78dT6jdv4Tn5MBtpFsMBScr9
X-Gm-Gg: AR+sD11FfQDajvg0kYTWtsoL6XmrCm68ut9uEV6ailqFG/DGkfW4azQaM3NoYFxuctF
	lwX6umZTzK+P0djRg7LQz9e5tM/U5Z7nflyFmQYYUTeKY+YZrbvf1FywZsYENN37C03DGsGJu/W
	IDxDhfi41/n64b9fBOz3hGKjWdhkKbX0jgZMKfeYkIS6UL+A9+Mab8tniLFFNh0KkBPpeADQH80
	KguR1UxOsS9SoCe8YX3GWQy9+wvzJ1rInu8zdfgrzA9i66KjYFtRFl4eVamwKnsxTNhdnTqt60B
	MZAZwkoYSai8Qo0p/DzoaJv+imkaJxvaikKN/8pIrpqrqM2RqbPXg9GlLwI+V3P8LNw9JYSVnYv
	faicdleumlui8ddaaYy+3/Qq/FQt1+5xhDB7GACvF4XXHCH7Dku3Db4khbw0p91htG68dTDocjS
	KANs2gsUlkqBDoe69izzDMK/Jy4m+U8q+rK2Mn02tAWO5YdhOImr4fIxIaRAbpksylRcEmfm4TK
	SlIK9AENNQWFIgPHH2VDNZKBdgfCkE6VfGcWWFY1Q==
X-Received: by 2002:a05:6000:25f3:b0:46e:1815:6a83 with SMTP id ffacd0b85a97d-47fd72f1666mr11652820f8f.29.1785632974413;
        Sat, 01 Aug 2026 18:09:34 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458b73asm17531468f8f.29.2026.08.01.18.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 18:09:34 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] platform/x86: hp-bioscfg: fix slab-out-of-bounds write in hp_convert_hexstr_to_str
Date: Sun,  2 Aug 2026 06:09:21 +0500
Message-ID: <20260802010921.7487-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hp_convert_hexstr_to_str() sizes its output buffer using the raw
hex-encoded input length, but the decoded string written into it can
need up to two bytes of output per five bytes of input when escaping
'\\', '\r', '\n', or '\t', plus one more byte for the NUL terminator
written unconditionally after the decode loop. For a short encoded
value the decoded length plus terminator can reach or exceed the
allocated size, causing an out-of-bounds slab write.

KASAN caught a one-byte overflow during BIOS attribute enumeration
on boot, triggered by a one-byte encoded input value:

BUG: KASAN: slab-out-of-bounds in hp_convert_hexstr_to_str+0x6d8/0x710 [hp_bioscfg]
Write of size 1 at addr ffff8881032e5d81 by task (udev-worker)/520
The buggy address is located 0 bytes to the right of
allocated 1-byte region [ffff8881032e5d80, ffff8881032e5d81)

Size the allocation to the worst-case decoded length, two bytes per
five-byte input chunk, plus the terminator, instead of the raw input
length.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -442,7 +442,7 @@ int hp_convert_hexstr_to_str(const char *input, u32 input_len, char **str, int *len)
 	*len = 0;
 	*str = NULL;
 
-	new_str = kmalloc(input_len, GFP_KERNEL);
+	new_str = kmalloc(2 * DIV_ROUND_UP(input_len, 5) + 1, GFP_KERNEL);
 	if (!new_str)
 		return -ENOMEM;
 
