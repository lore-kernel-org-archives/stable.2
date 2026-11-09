Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239543;
	b=0zPWbmlhM0m61S4MzYMh6zyFv9zoQY8tfHawGHvNlyGhz9uSRJL9lpWgybxq+tYvsq1T
	 81vNj7z7GmhfW7tMHSKcWlTxmj7w/0nY0z93tRglWj8sMR/WtF3IUo5JOoaiP6GA21nIf
	 kMwIaf5RETF+qR9MOFXkAGlloOKvoeAVr1Ipj7IH85RXn60gzQLwCP1ZFMmFlzXqh5mxE
	 DEUdUWsZy2xZxIoi5ySwEocE2inaQ9eNghQsAN3TlEuKfEofMzRSMKabN6jlxJ/puXP8q
	 2P2oECIml2RppZ4YdcQWctNedqJTjgB5RfNPGTQNhjnocmO0a9Xqw2KTWEsG8ZO8cvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y58qGbx1bt3ohAjkcIc78J8UW3dBJ8T2wsogW/UvgDY=;
	b=K3C4LJUHK3vTQFZqVhZxyVJBdy+k/Zk2eW/eDeA4V97pU382FJH2b+9cX1ggjPH+KyDV
	 CxDpu74HwC+z00mTPDPxjDdZSgb5aAL5mKv6WqvgbWngXsA5iE1vyzfqkiuzBfcdBseU5
	 VUABwr8fCAewn4IJT+27TjmN/7Z/K62XyFMwP4hslkwrtpAUzi/3jc3nUMJXkIL4nK5yF
	 kmUmkFlaRLtMzyEVOA5xrRGNUnFE8sX0GvY/YI2LKuBo26JGtTwxUpmy5SBbQLuJJta3/
	 wCgToRNuwq69h8hBbBTPZ+QyZAVAi1lCFNTnf2Nm6EHf3OPqjhCg6bUWyK0xyE7WU5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=ZAhudugl;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22396606A331
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22396606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=ZAhudugl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so12861655e9.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 07:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1794239540; x=1794844340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y58qGbx1bt3ohAjkcIc78J8UW3dBJ8T2wsogW/UvgDY=;
        b=ZAhuduglP4V6Sq5L9NljUG+kywu7Tw+j6bsYVtcHZqa5WEHxIz52rj2q79CMklZPfe
         2W0BGhdOZPufgeBFgNzN3oqrlr828snCTM0VAJVRGpxjvMx0P4voxVUvxg2T7dK9cCjA
         1Ht9rRNqSBRg/j6Ail2uzPy1WfpO1XulAL6f3W35/HH6zGbwWi/01wXKLFGfzE5RSvWs
         mWy3qbH1vx7sP3dM2QsFTBF4YXS8CZnCacHG2Xl2UdEBYSNJy7WgexLFpxvxXowQzc+V
         ue/o5xMURGFWjw4ASuMYsNrwfNBx6wy6zWAbVvtHp7x5BFpd0jvaiR6USk9thmBGeYYv
         INZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239540; x=1794844340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y58qGbx1bt3ohAjkcIc78J8UW3dBJ8T2wsogW/UvgDY=;
        b=qTp7HouYFulzOkBWM5z3LEhqo2BvKlRDCRcuxbuCYONs40qByu/N95Agq+870jOh2K
         HxTRF7V/MiI4fdVWZdGf3E7LWILr2XnEIOu4/wuyltkvQAETt1lfaR8BOFeWoWYTB7BC
         uoBGf7lxhhcxRshXFgE+tcM9tsMP6xNr/lvJwBP+7Kb/cCcLyfTPMeILKpVGfnQEtZEj
         r6jK5bOSB5x/041Jo1oJqYQdEpO7j1CYY+ylFiHW365ZtSa5JvSETnmeESgRkd+/rFvp
         j1SJ7mim7WKKCRFUtQisP1UbEas+IEY78D6N+YcqyzKvTye+eZUh7PqhHMCDwOySesCe
         yjPA==
X-Forwarded-Encrypted: i=1; AL+hErGXPCk9Z3AfXh08YfrFX4HMPf3RTV6yAQPbvOCvYRgNmdxpv809MlXK9dzx/ma+i5eF8Mw9aoQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Uvu3ZGZ15Z6AxY81c6DKccC4K3Aeuj4IKK8R4yKZG+qMT3T/2
	Wzd4Zilrh6cFMjSvPrgjO3VT69S0ACqTwTj2VR2Z9T+A6GM9nmpjFp/dSpXgQ5VmnUs=
X-Gm-Gg: AYBFou32LDLmWZMrhhZQ7GQuOGjK591hz5/Syixmu61sXdr2yTwQzD33QEIZXIEBg/1
	AFQ+lt/rX7kabdBwACrKgaKFZs+BZM/hAuchsYPsBlC4tySijdbiM9ZoY9dMl1zFuxaADNxkBqw
	i1zGNDrzv3tnWCVwqX/J+Di0HI5Dwn+F6KGzaEWXxJ+Cg7JAtzD3atZj94RQAJ8dwFIXDXD4MFD
	A5B0c+l98QhCnB+lx3by0Dl2PIP3ElySy5u2XE3f5Yrz5Wb4kHSlxa/ybLcuIlzG2RRd+JUJCuW
	/xCa0KPL5KjuGjjGPeMvVnb1aJv77Y/t4IZxoZyFi2gclWj7CmNCsk/cFujMNEFzccNSarm6WM8
	MlVcRTBH+JUv8JridH9V20qreOfoxU8GZlXu4HR/aYpibYhw6yB3TpDWxuHhg11X8ETxIF2SYze
	ys21WVRQ455bag2nGPWqkr7IQvGwu6AFnqTMhuj1ZxeS2ZBvzg6sfJaQnvnSU0QcTCeOFHAy+Pw
	wNdDX5uNEhyt2o+X9jAxkfl6trTj2r88Gu88c5Y8QNiM7DoKrrpYCU077/pDpstfdEr1Xyyh7J3
	t4/uaCLYHGezpctD41J0nRG8
X-Received: by 2002:a05:600c:4eca:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4b94d762f4dmr78506415e9.3.1794239540400;
        Mon, 09 Nov 2026 07:52:20 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b9f93c04afsm91196685e9.3.2026.11.09.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:52:19 -0800 (PST)
From: Andrey Misiurov <amisiurov@cloudlinux.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/radeon: Bound GPIO I2C table entry count from VBIOS
Date: Mon,  9 Nov 2026 16:52:15 +0100
Message-ID: <20261109155215.3946844-1-amisiurov@cloudlinux.com>
X-Mailer: git-send-email 2.43.7
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

radeon_atombios_i2c_init() derives the number of GPIO I2C entries from
the size field of the VBIOS GPIO_I2C_Info table and stores a bus for
every valid entry in rdev->i2c_bus[i], which has RADEON_MAX_I2C_BUS
(16) slots.  A table that claims more than 16 entries makes it write
past the end of the array into the rest of struct radeon_device.  A
size smaller than the common header wraps the subtraction and the loop
walks far past the table.  radeon_lookup_i2c_gpio() uses the same
calculation.

Reject undersized tables and cap the entry count at
RADEON_MAX_I2C_BUS.

Fixes: f376b94fbc0a ("drm/radeon/kms: unify i2c handling")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
---
Found by code inspection.  Not reproduced at runtime; it needs a VBIOS
with a malformed GPIO_I2C_Info table.

 drivers/gpu/drm/radeon/radeon_atombios.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 3dd9724..c4e1272 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -125,6 +125,22 @@ static struct radeon_i2c_bus_rec radeon_get_bus_rec_for_i2c_gpio(ATOM_GPIO_I2C_A
 	return i2c;
 }
 
+/*
+ * The VBIOS table size is not checked against the image; cap the
+ * entry count to RADEON_MAX_I2C_BUS, the size of rdev->i2c_bus[].
+ */
+static int radeon_atombios_gpio_i2c_num_entries(uint16_t size)
+{
+	u32 bytes;
+
+	if (size < sizeof(ATOM_COMMON_TABLE_HEADER))
+		return 0;
+
+	bytes = size - sizeof(ATOM_COMMON_TABLE_HEADER);
+	return min_t(u32, bytes / sizeof(ATOM_GPIO_I2C_ASSIGMENT),
+		     RADEON_MAX_I2C_BUS);
+}
+
 static struct radeon_i2c_bus_rec radeon_lookup_i2c_gpio(struct radeon_device *rdev,
 							       uint8_t id)
 {
@@ -142,8 +158,7 @@ static struct radeon_i2c_bus_rec radeon_lookup_i2c_gpio(struct radeon_device *rd
 	if (atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_offset)) {
 		i2c_info = (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + data_offset);
 
-		num_indices = (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
-			sizeof(ATOM_GPIO_I2C_ASSIGMENT);
+		num_indices = radeon_atombios_gpio_i2c_num_entries(size);
 
 		gpio = &i2c_info->asGPIO_Info[0];
 		for (i = 0; i < num_indices; i++) {
@@ -176,8 +191,7 @@ void radeon_atombios_i2c_init(struct radeon_device *rdev)
 	if (atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_offset)) {
 		i2c_info = (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + data_offset);
 
-		num_indices = (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
-			sizeof(ATOM_GPIO_I2C_ASSIGMENT);
+		num_indices = radeon_atombios_gpio_i2c_num_entries(size);
 
 		gpio = &i2c_info->asGPIO_Info[0];
 		for (i = 0; i < num_indices; i++) {
-- 
2.43.7

