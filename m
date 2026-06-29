Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEC2EFD95
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760672; cv=none; b=QSNGJFEZ13U7l/DGwAQ9K5TL+EoVkVYJHhaaTUfOmE8q8d8r9Hld3Iu+drt+qvokpS96jLJmuQN2UbCnVvuEG35BC+4/JQfFxuqDIuLy6TbkiEGKrDte1QyagkP/6j9a7RvHMv3hqNbJJ4Hzq+pGy386ZZVZ3ZqgMC+q6dfcQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760672; c=relaxed/simple;
	bh=H9Yf0rpxOss9GEDXnQS1IsLWNiy7/6juGCx5lgn6vOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZUqS/oWwAOtQaZI3d2KYFJUApN98L3vuhaK3d4btFgmsH13Spc+1JfIZQyFKI6yFU/4hIZpzOggpZB+sE1a7J1BYONDR67CQPQV6ctRMCc51UaqKQaMNSRUljsPDgT7xuvSnBwlLcbg5y2oizjArHtdt1r/x6OuwvrUkdxdxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJAbAIQw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJAbAIQw"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so32327055e9.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760670; x=1783365470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QmMGduLBhwx3EIs5/1KFAw2vkZx4L+Ta6YhxTBavtE=;
        b=bJAbAIQwbpdFZn6LizoDvXzgXVVoeFc8D4Yf9p+jPx3RHg2LuPRoHSIc/bx3ztAEXS
         BztXMB7dXhYnbTRQHon8jhppSbEVmL/zUnHNozv0Y0CJhNkP7YbyOveWcnPvM3zOlvuK
         uT3oqE9PrszRHVOO8GwBZsxvXM/TJeeCjTvoDtUxCvrj3RFHmCHfsFsTFdNkWZ+1SM9B
         XFqiEw+TPN1eN6JJU7J2JZvrTR8ntS6pJ8QU1HdGx0gXUV0/HYWMZHlXyfNQQrw5lVTo
         zus+omBLNs3yJvLUGugQdjjeQxiTukzCw+Bve9udQfQ91prMMyAtz4Wf1YwJipFgnJxL
         f5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760670; x=1783365470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0QmMGduLBhwx3EIs5/1KFAw2vkZx4L+Ta6YhxTBavtE=;
        b=YpJicz1MUVJk2s/Hm8bgu7Ab8GVTxIIucA56res/vEQdDqZtQVqr8p/YgyGvT9yt76
         HtUyNTD/RWkOTfyecE/1wfgyaqsYngtXbMlTycnKzF+GMAWc6cbaYwnYBwpMaExMWV22
         k4tXu0IOKBeDsw1Lh5cPjfP+fVvTaNsdQo+7AsvDqix28kTW0p/vHfkK5lAcAa1uRrO4
         oHPIyNcPr9wVh0LOsA4gEJlYmoBPZfpTBhQ5j//TY24yX2Uvpd6/TCZesNznZ6k+/+YX
         3tANOKhPDCRKBLU0vru1ifQ1Lsl0+L/plo0t4+mF3zszB9R3uwlmdeZPkTmLVIHGaaLV
         dgow==
X-Forwarded-Encrypted: i=1; AFNElJ84acUH+2dMTnHwZmBaqi7J9QVmerLnxXEfUTKrMPBbDw//MQ+ukudHqqQJ7S3o3zI4KzuS7kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgEqTNVrq9QrIH+9snjT8l9G/TCpQ70uXMyOOm21rOSjW8sHJ
	XJ0RpYK3I6zxHZiSoG/su1S9Qph95S1Stb5bgatckjj0+iGvmMKcRqXV
X-Gm-Gg: AfdE7ckc6j7L8n9a1GOlt3w01RYJ39tlaVHFGUvm1vB7NP4QNvCZjGbZ1zi91nbPqpL
	CPtDGYgVj3kOo+Tgsp9Qbrh/8d0sLFOhlK2OlMRoE/IRgbG35YrVU/+7W/zoepD/m3DjCX52iHM
	MVxqC+aWBVcH/9vpHOFPIA8Q4nI1SHjNaxeTLU4cQWkYRTmE7D3ib3AtZRJFMEs+kDrgqG9rNwP
	wxQMDDTPsdekUBVdXB1ocF0LXoVBzOCe/H0M98A3A52Ed+v0kjdSUplgIpGDbwfbOE8Ovuz/F+0
	C8JW+aVR4J/Dn8dor4eL3yuV/bBdfEhHmzJlv8rG1HYGfhpyc6psRtdLtMrrEY7l7LZf2h/ZCDD
	fCmhn2JlZIrd8M0po/LsySzsQSwGnuJqlE15oGLzoo2PN9O2ROVSRaYa4u3P2Y9qUj95bqbhdiV
	3pRCgAdjxfbA0z9EukUfQALLbRPEUiUHWaGkVBvT4LTH9H8T++FPbl2OjFlbpp5OQjHwh3ooJzE
	GlEHkKyXWRDgRBCpJmVV3y5hum5XEtP4IEIhsNd5aIPFZRG9enZMgdQzNgRUdPaamWkcGWRwWIx
	YkvB9qqBgw==
X-Received: by 2002:a05:600c:4f90:b0:490:e974:e006 with SMTP id 5b1f17b1804b1-493b82b625dmr13006095e9.29.1782760669762;
        Mon, 29 Jun 2026 12:17:49 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cdccsm259568f8f.24.2026.06.29.12.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:17:49 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 29 Jun 2026 21:17:41 +0200
Subject: [PATCH 3/3] hwmon: (max6679) add missing 'select REGMAP_I2C' to
 Kconfig
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-add-kconfig-deps-v1-3-8104df929b1a@gmail.com>
References: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com>
In-Reply-To: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782760667; l=878;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=H9Yf0rpxOss9GEDXnQS1IsLWNiy7/6juGCx5lgn6vOk=;
 b=rtWWt61KymUgI++eyD6Y9xP7ud5TnIIu29BBNUkGUt2COItx2zEpPMHANzOs0u30bMaLI5h0j
 1Bblx/Cj9FoDprsY/1CCyIw59Ld9K80zYCgo+cEYiLB/hcEuKsutQc9
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Kconfig entry for the MAX6679 sensor doesn't contain a
`select REGMAP_I2C` parameter, causing build failures if regmap
isn't selected previously during the build process.

Fixes: 3a2a8cc3fe24 ("hwmon: (max6697) Convert to use regmap")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index cc593fbfa4cc..2bfbcc033d59 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1368,6 +1368,7 @@ config SENSORS_MAX6650
 config SENSORS_MAX6697
 	tristate "Maxim MAX6697 and compatibles"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for MAX6581, MAX6602, MAX6622,
 	  MAX6636, MAX6689, MAX6693, MAX6694, MAX6697, MAX6698, and MAX6699

-- 
2.54.0

