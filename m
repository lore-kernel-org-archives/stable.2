Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186525;
	b=Xjvk0hOZ5zSMDFQ01DAOMFcHJyprv5wjYvaz+aYnxa9Mb+RCLZb5CK8jrQ9UWbstFzl3
	 wyBl/Qi8bp0xh5I+n0LpYQ6v1DmcDjOjF0eS8zbG23VrO+Dht0iFa6VjNJmb2uACzr8IY
	 gXYXcqqGffLwkwnuwd0H9z9mGcQ0zOY/OFAlH6sMOFhipJCjw824AI5IYEEzPuM8ShDmH
	 Io1U68Ba+dEm6rx8tCNQaV7DGZ2TfE2dp1L996ftoqOzV8k6AtbUrD6QxWvh3oWTnm+Gl
	 Q5QIfcdcU2R+rGais0azZkX74AOUWrreN4/QsV9BYYpi/GOHUdmzquGVDLJGtzqad6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1umUU6E6aYyeT1k/Gpsp+FhAOaMvQ+4/dxDpS4M7kSE=;
	b=cY+6DxmRditL4rkYXSLgn91Gu0axaqS32ibgXPyZesd+lhfFSClCS3oIjPnyCZgRWcIX
	 B+kuvdtsT1WbgQZ1ruqBkQs3FEHyHlKLSZ8rHN8HxLw5u9BM+yE7V94OAv+losR8CQjK9
	 ECbU/IY0KFlZfOJNRJz5uXKaH8dVvJOwrlkYWGriixBS5Bw8hBTdBvWVr2C0U8NuzdJPN
	 ca11GGBafX/eujc7xajPb0F+75+aiqOLjopdmORib4Ptvxlp9jpIbKhezbHZ/p1j3DkGw
	 FHRsOdKIhwJuRoMUdT/Jxkp7L1ZFgukgLdlg1WQaRpu2d/MJKb1X9wIZs8HNDPHdhwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFE7gnnk;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7360A2609
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D7360A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFE7gnnk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e853a56bb4so436105ad.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186524; x=1793791324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1umUU6E6aYyeT1k/Gpsp+FhAOaMvQ+4/dxDpS4M7kSE=;
        b=GFE7gnnk+aBcA/fY+gjb1rhv6bm5tQcGawDxJLAQDvyPZguCQUnJCA427/FEmgdDvN
         ytjIDVnc3oDX9ZXpiEKvfuHYdiwcvhnjRsX//WWbhiBJh9THbFTgklSW2U3pAjuZ0Dqx
         04YMUw0dYaFyLrzsr08V8/cMcuvS0mpnXDOoJrxAipGyqaWVfHMKaE2erbfuRc3f/1Hz
         DSwa8YQNUZ7pJ/gDgZ9vGhCISJh95iGv193gO5kihWAVvQYk/ZbclW7kpdVZpRieXCV0
         5MejiaTvIKa5PwgyW1ODXS0hG6iZzhSC/IomVRB44oDKG8Ng2dTwPys/2Q+ntPIybWU+
         dnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186524; x=1793791324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1umUU6E6aYyeT1k/Gpsp+FhAOaMvQ+4/dxDpS4M7kSE=;
        b=WH78cxQdgAkFMIoQFI8EWe5Or4W+fWsAZVnCN+jKY383B4XWnSVoD8unW7EF1yh5Yd
         VLlEoE2nVajufWzDBuIzzTuzZehsFN28MGd5IeYerZmYAFhgNIgMyF4YelWpx6xUvPtz
         wBBDjOm2JylAi/xToDIHHWY91t/Crz7rASCwfZr00GVLAwqwy7ek0lniWjo6bfzvipb/
         V5Dc6hOzi/KwX1x9d0uKI4Q2L2Epz7w+rNb3JFKn+pLgtkMLGaZniYwUZilYAwMdzPlX
         mCWMTbibHhB3aVhRMjnrlRO+H2l/VQxDj2y9/PG8exBgKdxfzrP3/iCiQz63cF7dVdYN
         srLg==
X-Forwarded-Encrypted: i=1; AKwUvBxUm3LXc4s4QBlsm/Jp2vc9A6V9UuvbL5lycX8TWqoMpCZVhWNNQbzqazufp3aywot8+EnfN3o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmYAWICOgmkSCykrx/TslefutrOtC2ZaJQBnJ/7m3IasUeaW5d
	u6puHs028nxXhBWz6QgLh7WDHNTAw4xIT1hNBqrvfv2b9fVjfUpvb4CF
X-Gm-Gg: AYBFou34cWPh9ISIG5e0j8AQTNpafCsL78u3eYoXN+5Z71LT/SdLHwSdiVzmXfigmKY
	1PSPh8XumAcKlrt8cswSxXWVrSrspG9IvvHQC43pcfSmpIL7sp0vbDaClgkamjOhoazcmkAmL7j
	l1QFRSVMHm6W8rVtslDH+QqApxwhrg1TbsI0igFUD6Nlvp6jgE/qhgxWcvYZmU2218YKAYLw17A
	HsmNl18H/sKelNqIqhug6KC9Poaxvn7mBq9i1OW9RniFNZLmJhpS+EOjoUm/mUqfqYvWdH96/Kh
	WWhqVU05/cyTUjVOnz0ehilg84G6GoblacbZcMwn23ye2cEogAGGGrR3KVqgk8mxKqN6/09kqF+
	Sqm1T0yuojksVNyfWafW3DOD53RThfDNiRL7G5YctdlJw/Tnc/S9d5iboW8AAztY3mx0jklSHtO
	xuskZtANPAp8Y4zhvUJb7OspjW9i16F5ijpGhbxOQDCKnTtG9VK/8oNcl8UCDmocWX4+S1nqtVr
	fgLXsNpaX0iZcSchoBKXgy4geNpDKOiWBD62lA7sQsviDio1qVGL/88kfeWywhPFjQD5n/l75Zl
	a5drcaymhNE3WWMf0/RIPH0t71daswFTW0S3FgBBaa99nZ8tNHsYiYrVek9jj5SDOZGSxzClLuB
	c2SidKyh8LVWJRlX610zshWmYOhWcimnlf5u/Gt8KhODzlymXFH/QkIUpQKwt5PXa5Y4sNqJvMm
	xEK+l0Wg9jxB2pGrUBGeo=
X-Received: by 2002:a17:903:2c6:b0:2e2:d09f:d772 with SMTP id d9443c01a7336-2eaffca66e4mr32450105ad.0.1793186524518;
        Wed, 28 Oct 2026 04:22:04 -0700 (PDT)
Received: from esteban.tail1178e6.ts.net (132.20.31.150.dy.iij4u.or.jp. [150.31.20.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eafcdb52e6sm10157945ad.74.2026.10.28.04.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:22:03 -0700 (PDT)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hansg@kernel.org,
	andriy.shevchenko@linux.intel.com,
	dan.scally@ideasonboard.com,
	djrscally@gmail.com,
	dmanresa@gmail.com,
	dave.stevenson@raspberrypi.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/9] media: i2c: ov7251: Fix link frequency index
Date: Wed, 28 Oct 2026 20:21:47 +0900
Message-ID: <20261028112154.855185-3-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028112154.855185-1-antoine.pichot@gmail.com>
References: <20261028112154.855185-1-antoine.pichot@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ov7251_check_hwcfg() stores i, the index into the firmware's
link_frequencies array, in link_freq_idx, which the driver then uses to
index its own link_freq[], pixel_rates[] and pll1[] tables. The matching
driver entry is j. Store j.

Observed on a Surface Book 2, where ipu-bridge lists one link frequency,
319.2 MHz, which is link_freq[1]: V4L2_CID_LINK_FREQ reads 240000000,
and the pixel rate and PLL registers are off the same way.

The 319.2 MHz table this selects ran its PLL outside the datasheet
range until the previous patch, so do not apply this fix without it.

Fixes: cc125aaa5a78 ("media: i2c: Provide ov7251_check_hwcfg()")
Cc: stable@vger.kernel.org
Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
---
 drivers/media/i2c/ov7251.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index f429de5f1f7c..1f30a01c85b3 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -1523,7 +1523,7 @@ static int ov7251_check_hwcfg(struct ov7251 *ov7251)
 		goto out_free_bus_cfg;
 	}
 
-	ov7251->link_freq_idx = i;
+	ov7251->link_freq_idx = j;
 
 out_free_bus_cfg:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
-- 
2.56.0

