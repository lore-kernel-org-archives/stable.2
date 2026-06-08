Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6B38B124;
	Mon,  8 Jun 2026 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926179; cv=none; b=O5yPFhTixz3v5bouaNNjZEC2mE5A5BLCUrrHg2B20yd6XdRHr5xn2nkGQ9rKwXJeVUM/VQ65mifphsliOGj1lJBLeQyy7+I6K4Hj+luf3zVOmFoR4qzYWScuSwucbxRAXIvaonG6oqyFAJvxVnrL590kDr5VGeoEfpnReAW68r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926179; c=relaxed/simple;
	bh=TDwjrHs5aXhi2j3b6lHo1/HopmgZovmra0sPxvyMZWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clA0LUpdTvrBnsIRLAJWvzfrPWb7UsnvP1eTW953GPd/FBB7nal4ZXP6KLbPYxRgizzZgDAeK+nJ8ODhVLMeOJ7Sw2x4lzpYsuC7s4yqb86yWGYSSWD6RbtAZ2LqYR9y+HK3vxqUa/KQc0CvSUYAGe96Rk7xGVJaCfOdA4/+sEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bGsOeQ2n; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bGsOeQ2n"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C7E991A37D2;
	Mon,  8 Jun 2026 13:42:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 95D285FFB7;
	Mon,  8 Jun 2026 13:42:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF304106A2956;
	Mon,  8 Jun 2026 15:42:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780926173; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xjUlG70lR8Ty3SgbCmz2G1wN4Uaq3vikNmN1H1aZ9FI=;
	b=bGsOeQ2nniZ/EXYY2QwhqyyC8nvJusZ8b3u1rSQO9FAlF8wbGsPnbGXdDmlEtDwA0o+2li
	mWBHycT94cuvnVyR5ugZQWLeWpmup0n1UeO186TErdgDcjZGByaa6R8bsmkR5T9LcsL4Xe
	811Ks6k96nK7IKIGo7vY/yKgoae1C6GL3tR2Jmr5+gsNVdO0XmYwjHZWf8Xpu1hrGtvVEE
	4b92vNKmJaI9Nf3ZhRYPKQNWZH6lsBe1bNEQPmp00bka+ZIlvWljpFyVI/H8gE0h1mg4jo
	7x9VgHxzA3wCQ+AFW5q2TwG8/T6v9m/wM82RFbdF0OJ4qMTQI4BMq0QDnDWK9Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 08 Jun 2026 15:42:44 +0200
Subject: [PATCH v3 2/2] nvmem: layouts: Make the fixed-layout driver
 optional
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mathieu-nvmem-fixed-layout-v3-2-12ddc69f4c51@bootlin.com>
References: <20260608-mathieu-nvmem-fixed-layout-v3-0-12ddc69f4c51@bootlin.com>
In-Reply-To: <20260608-mathieu-nvmem-fixed-layout-v3-0-12ddc69f4c51@bootlin.com>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780926170; l=1524;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=TDwjrHs5aXhi2j3b6lHo1/HopmgZovmra0sPxvyMZWc=;
 b=unER2OmtydQokTz4kD8wUbxn9ugpBdiwKG3lnVGJlC4IEqddO1C645jw1aluVfcwbdsiSm8xE
 ap8f4E5bsWsCNif/djScEnanHDsrz6FxAgWt4nutpaWSZUseydfJdB7
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

The fixed-layout support is now managed by a separate driver, so we can
make this support optional. This aligns with the approach taken for
other layout drivers.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/nvmem/layouts/Kconfig  | 9 +++++++++
 drivers/nvmem/layouts/Makefile | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 5e586dfebe47..973d3147f109 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -8,6 +8,15 @@ if NVMEM_LAYOUTS
 
 menu "Layout Types"
 
+config NVMEM_LAYOUT_FIXED_LAYOUT
+	tristate "Fixed layout support"
+	default y
+	help
+	  Say Y here to enable support for NVMEM fixed layout, which provides a
+	  way to describe memory cells with fixed offsets and sizes.
+
+	  If unsure, say Y.
+
 config NVMEM_LAYOUT_SL28_VPD
 	tristate "Kontron sl28 VPD layout support"
 	select CRC8
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index dd6c6c70b1a9..9da790a9dde9 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -3,7 +3,7 @@
 # Makefile for nvmem layouts.
 #
 
-obj-$(CONFIG_NVMEM_LAYOUTS) += fixed-layout.o
+obj-$(CONFIG_NVMEM_LAYOUT_FIXED_LAYOUT) += fixed-layout.o
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
 obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o

-- 
2.47.3

