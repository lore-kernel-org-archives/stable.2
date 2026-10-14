Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204E53A8B2
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999265; cv=none; b=dwWv7wi9hu+OGLrhfQBoJWTAvGMjaNuJ4Au6dIhVm89/Yh2CROZP70NEe/oyVuVtdm4rw5RvagwbxNpPh5lQsuCnREYAj1NJMGBP4RoZxFlMuc35Q/MeKKjFLUmRhGcKZQkfCHFiiKQrqK+EaAJMfF4f3DcqanZymr9O2o58lFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999265; c=relaxed/simple;
	bh=gi41Zz3zDE0TLM6PlJVKgZhPae/Sjlrnf+I/moH9ljs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lq8T0ICrSCXcMGK5eYY37eF7zc7F0TxIR9z6yFqGA8Yq6z+Kye10MYBZVPfVFDvrjHgc3agZrGAjgzMRkeljWCPS+X4cWsNJndgLQG23z4yroDNEpfuaGOgneyM2AWczHUfiueFBOD0+RVbtniWKgosc5JjTWZiQFShuvkrRO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj6HBSW2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj6HBSW2"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2acc1e170cso744886366b.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999259; x=1792604059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6DNgDZcPLM+u9NKiSG5ngG40YZRJno2c69YEg3krWw=;
        b=Uj6HBSW2Yyftmh4qdpBHFjmAyJ+WGEvZ9t0oN6iG0t119cyKaxhkRORyCe88Kc3WFS
         X36oNNJpqEN/jPjdinn6E1MoUvdLX1l2Mxmd4Pil4F7kR3JaDOhhjz9r3qMe8t3Cpu31
         dRfGkkCwARuzmqwRxCrWSIKWBz42OkgSc+tgVl6LnpSvGsO6JQuCpi1G6EY4zffIoT6V
         gcVlHk8KcmlY8sBjblmMo/2RHk5d36x9W3ghrgn606sztXpnWMTqYKoJRv6uRX3YAcJ5
         61QdmShA9x7NxksyRurbmcffYjaz2S9ZWmtkanJgDMt1tSEmxIwcWgUbEsrW+9ziNyTY
         0ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999259; x=1792604059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l6DNgDZcPLM+u9NKiSG5ngG40YZRJno2c69YEg3krWw=;
        b=j9YfNwTe8yoK1/YfFKE/Z/YkaAafvmIfOsM7CwGQE2Ie39zexfO62e+oIWvTxxIGKV
         qslxl1m4o98Ye1nDybsT7nNq5OXBeuNHA75XlJEhDNGPyOQ7khA5UuNrPTgt57UZigj2
         XLocolpAoe8FKPSzsxNbOmrq8pgI9KPWur5emN84y0c8ECOPJZcwAZVCyKSOohzqzL/o
         PHt0yKWz5iVX7Fw01Owq1cYMt+3P9wqEauVCvzhqOwD9G3DswiPzrUTlBRHIxcDbt/Gb
         DKIJ5g0osSIUnteaLDaEQmLC535jJ/qIJx569ZcYLYQxEHKcJcpAipVWevsfVkFfQ6xH
         QeLg==
X-Forwarded-Encrypted: i=1; AKwUvByaFH32YigaX+D1+WaMcIgJiHmZwZYio6TK6x9UDeTfiQjsKy9p94DyaXFG/9Zr3LoQTZqzr9g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfE+VVR9A8+F5NQdesK5UEe3mNRh9O4oTORkV04/c1a+Jv2Kis
	d5BItmmYt4QwLvPZc4w0+1De3Z6TgAbxh5rXweQNyJr3sna2rilbchz8
X-Gm-Gg: AYBFou2zRZJ0SJikynVqdKR9Q9xl8AWsSfbVEYJ7724f6dkPS9/qoVJ+0ypOrRocy7D
	IeXezQifKnlna64Y5sPbJIX/uCJyqe1DEdzjgZmeQcVN1ExRArQcHzMf5S7qb21NumjAjKYeH7m
	6tppuvTNjT+zVS23gvVVmfrtK9SGIZgdfkrzDWDv0+bcL2V4pFNSytE8ULwamh93MwjLfbEFAiv
	jLuCTVOhpvlisQd8rpptBFtBFTlyuUXD3jZfNoMxYha7TDaV2c5oNoRUhAWnNTTsYH5OHSlq1C2
	2/kg9zIkGJUETrB+ypjbA24AAUDuKNhpMTianhulSeTxFFwbwLDOsIfI+cE2Sj805zgIKY5BRyP
	QJ3LlF+ktulb++J2VE1WqLwKVpC6weS31fdnjGS4dxgCI1/B1n/s43/M30ZlGKMln03btl0eRsp
	Ysx6hyTT63Vdc845yb2eKvtCBzO+KSBr8ITalKNEsfGSHs4Pd3llVm1+D71JYyfejXDjWK3Mue8
	/ReMVlUOT5lXLBEllVP6Ar/Unc=
X-Received: by 2002:a17:906:1011:10b0:c34:c5e8:1dd2 with SMTP id a640c23a62f3a-c34c5e82199mr623673566b.24.1791999258387;
        Wed, 14 Oct 2026 10:34:18 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:f08c:65a8:f8e5:f310:5a71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963cecesm9381366b.21.2026.10.14.10.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:17 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:02 +0200
Subject: [PATCH v3 03/11] hwmon: chipcap2: fix be16 handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-chipcap2_locks-v3-3-27ebfc2c5b9e@gmail.com>
References: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
In-Reply-To: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791999252; l=2005;
 i=javier.carrasco.cruz@gmail.com; s=20260924; h=from:subject:message-id;
 bh=gi41Zz3zDE0TLM6PlJVKgZhPae/Sjlrnf+I/moH9ljs=;
 b=Pa7vuoPzoVXhpbxszG5LXuyA4iAWV9CbQAGUcd5kxNa6Zkabhl59h+H8nVlhIEIGBEQiZ4LrG
 8fQNjMe0G92AZc/aCIeKhp9IkOd0+YwgztKUeg24ZmRN8OqURjLP28a
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=VV+hcMoOj1Sx6xSiY0W/FZNAskGZe2AagSMVj0PsmAs=

The driver currently only works correctly on little-endian
architectures when writing 16-bit register values.

Use i2c_smbus_write_word_swapped() for writes and get_unaligned_be16()
for reads to correctly handle the ChipCap 2's big-endian data format
on all architectures.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 8102b6851d3d..aec4adf98658 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/unaligned.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -260,8 +261,7 @@ static int cc2_write_reg(struct cc2_data *data, u8 reg, u16 val)
 	if (ret < 0)
 		goto disable;
 
-	cpu_to_be16s(&val);
-	ret = i2c_smbus_write_word_data(data->client, reg, val);
+	ret = i2c_smbus_write_word_swapped(data->client, reg, val);
 	if (ret < 0)
 		goto disable;
 
@@ -311,7 +311,7 @@ static int cc2_read_reg(struct cc2_data *data, u8 reg, u16 *val)
 	if (ret != CC2_EEPROM_DATA_LEN)
 		return ret < 0 ? ret : -EIO;
 
-	*val = be16_to_cpup((__be16 *)&buf[1]);
+	*val = get_unaligned_be16(&buf[1]);
 
 	return cc2_read_command_status(data->client);
 }
@@ -351,10 +351,10 @@ static int cc2_data_fetch(struct i2c_client *client,
 
 	switch (type) {
 	case hwmon_humidity:
-		*val = cc2_rh_convert(be16_to_cpup((__be16 *)&data[0]));
+		*val = cc2_rh_convert(get_unaligned_be16(&data[0]));
 		break;
 	case hwmon_temp:
-		*val = cc2_temp_convert(be16_to_cpup((__be16 *)&data[2]));
+		*val = cc2_temp_convert(get_unaligned_be16(&data[2]));
 		break;
 	default:
 		return -EINVAL;

-- 
2.43.0

