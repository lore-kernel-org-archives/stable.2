Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951408;
	b=yvw391S3LtJ+sMwZeKQO5lHCllOFUNb6Tyy6CBCbORV0JoPbPfG+/XzzKImIYzeBs8V5
	 L8dzqSau8ya98oz4nZRU5urWn5r3QfvWVgOfdGsNz/SPCcv4SWwg2fSf3reMuBXXAfHPf
	 XBu+DwiGTWi84k0+wNsvRlwU6V+8p7M0JESAXTufTS4jm2sk/8X7BJW012vJesbtqI6rc
	 D6K+ALf9RlSInA9tMy+zv8cBbOv3etzZ/s5F3VGTcMzMWp20jWqQk5hJc6AEccD9HsKf7
	 W/RLt9ifxOxMRuBLTvCnMs9QuJ6FfTZpmrPaE03rQTRoWSZvyqYpV2/w0KbXvTypyAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oGMF4Q3FKs8fn3YAByKtysFrkHDHvnUFQNs10reubHI=;
	b=XmO3UuMRoOwf9BEJaiVfDUhL71V7sJ6YpsQwtZiIvkC5vfsvEabGaJUyh0Gq85Yr+jv/
	 0405enxlY5fzRuwAHHEJPqXcu6pTg4BtiNC396KbsKN5USNHwoXUFL+MZY45mmyLZebz8
	 7DPnN7dsMO7dTinm601d7K92+lfuaWoBIDSpcqSDCCyYJgmP1M4V7PW1X4YwwHEP90jAv
	 /mnHp3WQfL7WUhep5A6Fhfo5O+iVo83FpKljvu+2MwP9YrqdPdCBXjuYuchnn16M6/ofS
	 o/OhfQBm/ly+yeNnzjCXrMKYzY0n6UjE7SmNgplQCey/CdFQ6sTgu+9vjEByOUUND2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yz3DAhZa;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D0606A324
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 273D0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yz3DAhZa
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so2045685e9.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792951405; x=1793556205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oGMF4Q3FKs8fn3YAByKtysFrkHDHvnUFQNs10reubHI=;
        b=Yz3DAhZa1ioTItGzQDNf9M0ywPd9fITkrY8kdwClnU8r3li7j2PGsQtcTAdpnVaryL
         JTXKcNOhDKV6qK6UtvgsAdfGmK3ArnEEIGTwIOMm93uMNRYkg/wOq7mTvKNL335m1q/5
         f5Dl2tmVpHj7+Ncg9u/G8lpmFoJYzq3eryI+8FsxdPWV35FhFHF2SaChRXw+0J8JD6vh
         UV2glsk3BhDvC3m7CditfmOSViBdHU+TzKxjopFtOdFFI/Jt+biqXWoAkYrKrfvdA25a
         TDc8E3gWN0Q1JDTwNoTBDlePhzi5wBXQ211kIUW7isjHO1zEcoxTXnBnj514ON2iESpw
         RXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792951405; x=1793556205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGMF4Q3FKs8fn3YAByKtysFrkHDHvnUFQNs10reubHI=;
        b=o5QXYH3dqLQt4uRyKaGpyOdQfpGfjVIqv2MF0ig2H1kqSOA8G18mJatklVSbP7z584
         7FOZmRZYoedAA6b5uyk9/aKE97bFlUXeFcbujUhpx90aTY2vF++KB3mrPZEZ2LGW7fHw
         IFCR2GCnSjrtpiFN8aAcTOHSCh95W0f/2937BxGALZrGVCGcxOnCOLLQgfYeiXC93an7
         soRcrLHQuHZctqFR904ny94fkpwIv9z7of4N6lTRiHDUo9D9GwAZHfXzkIK1M/u28Yx+
         maXK6P+tvPb4SCbANDUI8Uds0K35Xxt0N4bAjn1DMKxfWDQnvg0zaPCKcdnVn9hiUPko
         w0qA==
X-Forwarded-Encrypted: i=1; AKwUvBy2uK2fmbI4A9E1H03DeTBllCY/zdwl5603yzdrNJvpHq+E3vq7tZR03VYToRB+9fmCMmPHaxI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLzuV9oVsdy6emoUWKP/MPU+OLpMQ6YcIUwNngzCPx9JE9A80G
	LzPw88kDMD2SkhEPBWEwUVrChimXhsIDPRFNP70MhPiqjKtmbQPN9Y4=
X-Gm-Gg: AYBFou2+YXg+tg5AYQU3aX2l9YQVruzjD2sU8CxNhouGzfkMZiTpATo9qR70oIXybhV
	Cdeco27IYLmZZMnMcZ5MbUAnuKxfuLKQCmji/aRBf291bp+su2exraBh7qI988St/zyjUtxJsYN
	29Z5SxOR0ZGH2VnvUrzPWF9wOfuK8F8Z16dXxm+XdD0U+TXjfKbJWBcT0m7spUhuews+/pkfUSx
	sXbksnltbF3Z6n4lyHVc6zLuiSqGEe9YqS3gya0jd4cw6kr4IsyIodxM1Kl92SxoYvu+KMVWW5Y
	MZsVcOwNeaCsxe2kKsznNAg9p26QliR/CRz8vA+tH0DctvW6jboiUfjGmtmYFFnE23hJf3yJjME
	OoEnkH+TOZiuUWDvJjnH0NhgbNpnxpyCuFRKHNi3f2wf2CRs6zmJd7mHQJtNvBA2efOCIhF1Vnx
	eAs6b4+XBCj+Go7axzfMW+UoONzx1/HETVT1ssM+LvvDXbEXznc5EOz3xBWyHf7YBJSMrlHksMZ
	gbSi8bcNnTLCx6y6kA2RXG0/BA0feeKeS0ywg==
X-Received: by 2002:a05:600c:630f:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4a35ae9e071mr92039425e9.12.1792951405253;
        Sun, 25 Oct 2026 11:03:25 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a4cb7bece3sm82641055e9.10.2026.10.25.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:03:24 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] iio: light: cm32181: validate ACPI object type in cm32181_acpi_get_cpm()
Date: Sun, 25 Oct 2026 18:03:22 +0000
Message-ID: <20261025180323.3641477-1-tristan@talencesecurity.com>
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

cm32181_acpi_get_cpm() accesses cpm->package.count and
cpm->package.elements without checking that the returned ACPI object
is of type ACPI_TYPE_PACKAGE.  If firmware returns a different type,
the package union members alias onto unrelated data.

Add the missing type check after the ACPI evaluation and before
accessing the package contents.

Fixes: d34ca613b939 ("iio: light: cm32181: Add support for parsing CPM0 and CPM1 ACPI tables")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/light/cm32181.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index b32a94028f091..1528465be6adb 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -121,6 +121,11 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
 	}
 
 	cpm = buffer.pointer;
+	if (cpm->type != ACPI_TYPE_PACKAGE) {
+		dev_err(dev, "object %s is not a package\n", obj_name);
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
 	if (cpm->package.count > count)
 		dev_warn(dev, "%s table contains %u values, only using first %d values\n",
 			 obj_name, cpm->package.count, count);
-- 
2.47.3

