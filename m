Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AE6BB5B
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350172; cv=none; b=UUycZAEbSlsH1/hlan93srP5J7NQ8j7lTBurlQMvqBA8IkHMHpc3OoLJeuNxRGQXZM9zOWazr+j11nqIkMTPAKzLee41/utoVXjOlBXmtydwVx2DRalm7K6bBr64bUxBJuTU3i29nY8xk2wB/kCrLQ5fmmvM1RQyiRrM+NYtYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350172; c=relaxed/simple;
	bh=pemxnVHNkW3Iii1nHzJd+a8wQKppft30pK0fSe8aaqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCIZAKBtGmPxqAwgcGAc9rw+GsgosPnz/0762rApAKJe3uZ1Q2YfHZGf4oYMF0Sf3IdjcB61s5xby6FHAt3hQS8NlIlw9OFXWrGGUkEmqhdzf4nyomVEINdEtHfq00ZNkQkoRfxk7iZUqyAU8ZOknCS5IuEciawBuV9DpK66l9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfQ+3Jxh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfQ+3Jxh"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36baec934b6so1556074a91.0
        for <stable@vger.kernel.org>; Sat, 13 Jun 2026 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781350169; x=1781954969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aGhTsdPJsR9V2/6FOYFPzTNegoY0mHo2WaGBZawf25M=;
        b=pfQ+3JxhFK2f0v4fN94IMRysu1kMP1hJojcCF21NMM+us+hgQyVlEiJukM4bQowxFO
         MItzFY3aJ7HfreaIcNLBNBQDKNJNymmlDHc6+ArgeYnCOHK2YO2BPuBM94EVWyrkUHF9
         xJBHg7qEPLbx2Ud75zjY6dePnJX7WUaxvp2CJR6Nn4GmJiy0zZrfgcM5qo1MJetNLt8w
         62Eke/eygb88cAElBXa29NhyXyiOKytGC92+w+x22OQK3y06C7xQeKUNxTTRnxJ6pyfb
         SXKdc7hgNS/mCZV3MMkQ0JAjIwN+M8eDnqwSpW5pJOQwf7eV8TCzzvAQYAz7zKi9qo+z
         /e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781350169; x=1781954969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGhTsdPJsR9V2/6FOYFPzTNegoY0mHo2WaGBZawf25M=;
        b=B5ORpVDwwAAPXNWJ4HZpen6vupNLndAY3L7lEYNCq1ffmBBH+dxjT3sYVOK9JrGtLp
         4+hqa+nApMPJoOl4ksR1Js3eHKiwPRbFwfZfzOfIJ+ak93ObfTC2pbHQZQvibgg5if4s
         G2/tz6mY247+gWvUvHyOcGk5cw6O3cYRtlvXH2X1dFq6xeV97n0MY3GG7MQrf4GuDNx5
         FNX1I2NsoNkRthue+oG4v0Ohk0Wt7B+HGJeHq7vI3D+KRuS175sce6xEN5t0wNbZ7QHL
         XsrF7kytIzEUVuf57FfsX41JiAzHZgg9EcrWwUiOnP4p/RdT+/o3vH9M1ObkkSchxHnT
         tt3w==
X-Forwarded-Encrypted: i=1; AFNElJ9ZDaupHWbDJgDbVxlzUGVMBN0ptNGYwNUF1vUCYSSb0JOhpFmAVn5U7SGSmp93gGnDLu+9Hlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1pBb+JE52QkTmEVABuUtUoNitwWZUTINwnkkudDG/wwdlLQ0M
	6uudBvP7bXbFR6XzbSfd5Or/+gakZsCNp0JDcBZPIfVPSrzgoxB1DTeo1GSgZNWQ
X-Gm-Gg: Acq92OGlyaH9SDz7/tOxI+/fIedWgfPBSMOsqzRsQ5ZcHBYjjYbCEAv7momEiFKjLQT
	ac7MjHSbex6hX9hMT6Eehb2diteM2CHVCC9IRt8Fzw6q/ajfpvKON1xHDiw3QxS9L0UkJNiiD8t
	5Oi0R/7v7oDpga2ukWEk7UYXF8YzAZ06L06Qk/nj3GKHNEt4ikfHny7DiWbA9W8KJDqgjvzj0mG
	Ou1LLyEqEGzqVoJPoJ+kfMprWxjtxR7+ov1HnOUj7wvQmyz7uom4GlvowvSBaDkpW/v/Aa0qyf8
	CDAyqfJgnpezZb6GgtvbdEqcaoaunT4BcHuPXjxog7FrM62KUH0pKUkSo08IR/9cIWO+FXoGndi
	WQw8FPoFAeSPsS7lRiavgabjf/qRgL5FYWkolICKv3I8QknPFhi9OHY+X580VmD5NMbrdzcVdeG
	R4Xqm4yynuOq00fipCCxCjrelTT32ixl7DujNywAS/4W5QvIJO2VrQ
X-Received: by 2002:a17:90a:e18c:b0:370:aa94:1662 with SMTP id 98e67ed59e1d1-37a1f744349mr4526176a91.9.1781350169429;
        Sat, 13 Jun 2026 04:29:29 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a20dbc8c8sm4641351a91.12.2026.06.13.04.29.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Jun 2026 04:29:28 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	dongchun.zhu@mediatek.com,
	stable@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v2] media: i2c: ov02a10: fix endpoint parsing use-after-free and error leak
Date: Sat, 13 Jun 2026 16:59:20 +0530
Message-ID: <20260613112920.64617-1-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ov02a10_check_hwcfg() function calls fwnode_handle_put(ep)
immediately after allocating and parsing the endpoint. However, it
subsequently calls fwnode_property_read_u32() using the same 'ep'
handle, leading to a potential use-after-free.

Additionally, reading the optional 'ovti,mipi-clock-voltage' property
used to overwrite the 'ret' variable. If the property was missing,
'ret' would become negative, and this failure code would be incorrectly
returned at the end of the function, causing probe to fail entirely.

Fix the use-after-free by moving fwnode_handle_put(ep) to the end of
the endpoint property reading block, and adding it to the error path of
v4l2_fwnode_endpoint_alloc_parse().

Fix the error leak by avoiding assigning the result of
fwnode_property_read_u32() to 'ret'.

Fixes: 91807efbe8ec ("media: i2c: add OV02A10 image sensor driver")
Cc: stable@vger.kernel.org

Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
Changes in v2:
- Fixed the commit hash and title format in the Fixes tag.

 drivers/media/i2c/ov02a10.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov02a10.c b/drivers/media/i2c/ov02a10.c
index 143dcfe..53ff86b 100644
--- a/drivers/media/i2c/ov02a10.c
+++ b/drivers/media/i2c/ov02a10.c
@@ -821,9 +821,10 @@ static int ov02a10_check_hwcfg(struct device *dev, struct ov02a10 *ov02a10)
 		return -ENXIO;
 
 	ret = v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
-	fwnode_handle_put(ep);
-	if (ret)
+	if (ret) {
+		fwnode_handle_put(ep);
 		return ret;
+	}
 
 	/* Optional indication of MIPI clock voltage unit */
 	ret = fwnode_property_read_u32(ep, "ovti,mipi-clock-voltage",
@@ -832,6 +833,8 @@ static int ov02a10_check_hwcfg(struct device *dev, struct ov02a10 *ov02a10)
 	if (!ret)
 		ov02a10->mipi_clock_voltage = clk_volt;
 
+	fwnode_handle_put(ep);
+
 	for (i = 0; i < ARRAY_SIZE(link_freq_menu_items); i++) {
 		for (j = 0; j < bus_cfg.nr_of_link_frequencies; j++) {
 			if (link_freq_menu_items[i] ==
-- 
2.50.1 (Apple Git-155)

