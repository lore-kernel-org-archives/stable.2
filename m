Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792875473;
	b=N8shjgnrF1umN95+W+CCbkMqoBqiEieRyOmTmX/FPCk8E8vdLRQvDdqlX6PkAS5nU9KO
	 PZMkqQMmA4kfH5KJUyD2uLoyfio0QK294Tj/yMiJG/03yfazIvqqILcMxn220+iy6zJMu
	 ZwwLEsRqqB0BxS6FtECKy2z/Wmbq6a6Ux9IHwZjBNX4P6DSz8gQXyIfi0gNWlx5uE8pxR
	 7mbTvwDBHNqyDdPYGMDOdkXX/cwZ3skU8Y4MVGGSOcgkCatWHRlcHcxyvjj2A3SOOMakU
	 6ZBXW94AWVKDCc9jg8hyhaqK7u+IV5jUhaKlA6XGxrtntHsidEmpz5FvypDUjT6l0Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792875473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mphibqgTFFMm6n9Ocw8j+xegMNjz+2yKf+Knt+msTKc=;
	b=sOxTRMwBolhTLP+mcNOLyejlG27BD43Azv+9OCgaz0WyHWo/Fb9oMiybtpfYRJst2cPh
	 SLGvGL+IpcyVJBNVbjZkWcyts3+Xv6FW50VG9GjnSRTFOFk1p6ApKSQdQowXf0wsC1nTc
	 Rxg0n/KXSqr0jfvqWZ1n7KNE4sF5lg0sms2TKoOly6zb3qx49VWJw0lyIS69Hd2Zb+Tit
	 VBMXy7aHSSfxW02yET8/3v/nD4NHUAi3yAJZ18aUGmvmjloTlMgZKbWFrG8iVB5SDGCcS
	 2w9Uc8pEBhxooYwAXZq2rnIylGbkcPthb9eThotGNLUPg8LnajTP7uHpZEhasy4rvRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ml5I52eU;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA1606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59AA1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ml5I52eU
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso14482545e9.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875472; x=1793480272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mphibqgTFFMm6n9Ocw8j+xegMNjz+2yKf+Knt+msTKc=;
        b=Ml5I52eUj9Lp1qOjehoe4jBW2dSypONx61llfP50+O6ouqmE/AuagJ9MrU8nxR17oX
         7bUyyJ6JTpiJ6ODs/xZQ6eFO7GVjHkXdUk6q5iTSvZFhLIew3ZoUDxZQI5JPRChPkYF1
         1hNWh0cFq9x2j6bHhr7+9AgF4lCN5henyMaEYr32W0EcGCnyuS5FXFFa1Kw8gxrSj4PY
         tq8YNX9QdG27DVF+D6EsYR7AYRHNTFvwLA/XUQKgOqYVMHkn//uObwuqa6A/iV1DHJ5l
         8J3UzZ4IAmZ9ik7MUDn3gMGi3z4PwjIp7XApLjfUWxNqVMvvQMRoHOFGnLilmbseDGnu
         5JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875472; x=1793480272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mphibqgTFFMm6n9Ocw8j+xegMNjz+2yKf+Knt+msTKc=;
        b=vsd0VBvz64qgtVdAlxFKRBd4zinFZYvOVHdXqQyl7jIJqmHegRUkFbaiHRMXkrtChT
         ii5lP6scJ514Sqx0FtoxVzrJE+Yw6UMBTZFcQTcw5Lq88F4gmuemQ0/2TKQCMNC6pDYL
         iVa+6Bjk0vvgZ0SLuOsyPbQBOGm+Et9oXaI9RlpXLmZY1n0xSlxtzB0lpS88NIw4d4Us
         Qb49MMcPMila03+M2Xh+Fejpt3nGIvbtkJJOVnJM+k21tdbjGmGnoOS9c9ZlxkDg2q33
         Wz+1x1QxW0dzdbC+9O40KK/NeJT3dcaV2tW24LhgXbKnvtT8xciGoFE6vyXumQrFuHiM
         X9aA==
X-Forwarded-Encrypted: i=1; AKwUvBzCv3vJnutrjq8LCPmN1xPaEoaX7/IzyUoiilWJEYjub0AZfSPcDqOHkp3bQt+NOO6bbr9Jm+4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUXP8Gr2vdbHtzrF+XFEEpTHvquBmkPWTVEjZ2xfztgqZUabY9
	I82NXjRRLxMi5b1La29OnAX/z80hlVG87MOAKC/Q55NI9Ui1MuaHhXvcTIdF
X-Gm-Gg: AYBFou1VcCzmob3gPK9wiRNzRwARYvWK02eR85BvqxeLtSFM05MKSCAKOQaem5JStPl
	DP/pEN4PYXckHWhiGP0sYGxUoCMwlF6+o3ERviyZ3bn9q+8leclX/tEdFmrz/jVXALj+W0rZsBg
	ncErCTmdev8Z1d1IH/XNhp8Ep0t9u8iJcqJpV7iO10dQqvUFZ9PMadBgbQ14POzmBP6z7yYuYEp
	uq662bUySth5MQuAH719Au49jBVUKgo/YAtKGd+aVGKJqiR86piOuh4QfT9AN+o4t/bU0xyq5qI
	l7ln/f5jdbpTABZPE/fIsjAuUNFZW/rPTch/2CoKn2FNBwD7saz7ITNwNpgz8SsRAxTXYzkfTEq
	BiU1iAiZD5i5CufCYkkMMWajJfUQKq8kY5hYjyuE6bZ7xZSw0CaqlB8k3wd3fMHD+WRYFWh24tb
	EbRE2CMy7B0urzqpXj/mk6IOAeqAZAzuACiLEj3UubrENmZjgGvtdPuW9iPaLB77MUOyTxlh0L8
	tK87yWLds2fXZ22vBbvNE9mOjBpndz7cD2ykUb6jN0Tew==
X-Received: by 2002:a05:600c:34d5:b0:4a0:2391:6540 with SMTP id 5b1f17b1804b1-4a35aca2b53mr39027755e9.25.1792875471790;
        Sat, 24 Oct 2026 13:57:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a56992dsm71004965e9.6.2026.10.24.13.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:57:49 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] drm/nouveau/disp/r535: validate ACPI backlight DSM return type
Date: Sat, 24 Oct 2026 20:57:49 +0000
Message-ID: <20261024205749.4045480-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

r535_disp_oneinit() evaluates ACPI _DSM method 0x14 for backlight data
and directly accesses obj->package.count and obj->package.elements
without first verifying that the returned ACPI object is actually a
package. If firmware returns an unexpected type (integer, string,
buffer), the union access reads unrelated fields, causing undefined
behavior.

Additionally, the loop accesses each element as integer.value without
checking that the element is actually ACPI_TYPE_INTEGER, and copies
into the fixed-size backLightData array without bounds checking, which
can overflow when firmware returns more elements than expected.

Add type validation:

1. Check obj->type == ACPI_TYPE_PACKAGE before accessing package fields.
2. Free the ACPI object when the type is unexpected.
3. Validate each element is ACPI_TYPE_INTEGER before accessing its value.
4. Check that the cumulative copy size does not exceed the destination
   array.

When a non-integer child or oversized element is encountered, the loop
breaks and the valid prefix is forwarded. This preserves the existing
behavior of reporting success for the _DSM call while preventing
out-of-bounds access.

Fixes: 9e99444490238d ("drm/nouveau/disp/r535: initial support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index f5f22173fc2c1..267cc098ff769 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -1556,15 +1556,21 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 								0x00000102, 0x14, &argv4);
 					if (!obj) {
 						acpi_handle_info(handle, "failed to evaluate _DSM\n");
-					} else {
+					} else if (obj->type == ACPI_TYPE_PACKAGE) {
 						for (int i = 0; i < obj->package.count; i++) {
 							union acpi_object *elt = &obj->package.elements[i];
 							u32 size;
 
+							if (elt->type != ACPI_TYPE_INTEGER)
+								break;
+
 							if (elt->integer.value & ~0xffffffffULL)
 								size = 8;
 							else
 								size = 4;
+							if (ctrl->backLightDataSize + size >
+							    sizeof(ctrl->backLightData))
+								break;
 
 							memcpy(&ctrl->backLightData[ctrl->backLightDataSize], &elt->integer.value, size);
 							ctrl->backLightDataSize += size;
@@ -1572,6 +1578,8 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 
 						ctrl->status = 0;
 						ACPI_FREE(obj);
+					} else {
+						ACPI_FREE(obj);
 					}
 
 					kfree(argv4.buffer.pointer);
-- 
2.47.3

