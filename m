Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024454;
	b=tkml6hSrIMjbI2pPPU76fzwJFLa/A9aYHueaDyYBlMiQekSkBgMLoHinNSm+iKAxCYSy
	 JyGaRwfCFgg7P4rL0dnqn2Fcsio12SjmQBXptZcVoAbIwSqkdam3gZPz+5mSyJ4uswzxj
	 EPYeO1TDNebC7evR/88OBGTD6NXes4yEDYaJrkfP/V9wj7OTYfTJmaI5y0g5ZJqbC1vyI
	 9arRUEX+Oah/sJZ18JY/gdBmoHbVNnhjpMymcXYL6XlNj38HHU7FjyNEO9G98Vlqoy7QK
	 KuUBvsjPwG2Bjm01ZCT4tYl6UNycD5moXonW4Tb5HruGiLSBXwkVXlC1JErJDRCoGVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qtgx3aMD/495ZX6s7lgn7crrN/uSuC+ZVzynjH2rJKA=;
	b=wJNnPpFoRzZWBLQPdyESwocjSnUcJ6s2KJAYNL3BFAPyKNBMtOWVlD0DG8nd5erMdBMD
	 /3aHVIVen2Bh5qw054BfY1erBnB1jRIqG2RR71/8rKtUDuMuZcyj3V1RCHq0Car3zLomL
	 O/eU1ccWIMJqj57q6/Inq46dBHXuUDWkgnjhERkIcfQcb0jEvuQDzGdpLzmvJjlQhK22e
	 fFLjdVgYNJrx9N1bvAWfhKAZMEpwkhDfh3bUxTvllpvLLvPy3MqrKcldIw7fofubzDlh/
	 ycpvPN1tPo5pY2ue0vfSLymrH9xjB7ctKbCDx41YimPKCI/k3aIQyGlptDyk9HL049w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VibjgXv+;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD999606A332
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD999606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VibjgXv+
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e4831c028so1494558f8f.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024452; x=1793629252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qtgx3aMD/495ZX6s7lgn7crrN/uSuC+ZVzynjH2rJKA=;
        b=VibjgXv+bcagRtSV3WmXK/WYP/g8lMLfHDmEGVKYDuOO/nSMvtUk/CrBhMiWpgZluv
         rvtIkQsRzKvGYEjHsiDv139LqoROgRtSoi/gy+ihu2aB5WB/GDAX6SvkwXnbj2UiAWOL
         uMkXie73jCSAOgPAOrCkkubc9VdDxB6iS2K5pzXM0JYIEaAB2fGrnm0lONCcj9G57EQG
         jvCiAvfeiyg2zAj6ZQvjO7e9DZ2xH0qVlSiX8jlJLTs+HjBLBe6GaDqauDYBhfBAsPmK
         srFpmb/GYbr1sbdxmEmwTlpa+l1+z1NBGg/tt70Olk49SdWQcpu1c/hynBdXfNOWMiLc
         Q+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024452; x=1793629252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qtgx3aMD/495ZX6s7lgn7crrN/uSuC+ZVzynjH2rJKA=;
        b=k8jG6ui2d1g+60FJCRAQn2qa4lWAOdFkOlXSlZYJMkV59JO+hqEejpGkK0ODMqnNTL
         8lg2QBWQ5GlTJgLMPDe4vA0WP53JA6D1YUNVWvFG1lEuYJFNyPuV2YsoO8CVEsErmPcO
         1zLhIdVivYwzpuftIUSuvBA3ERVGo8TM7zvO7PjvbpLpzD3qtvDTmrSWQG7wkg0CcXod
         OaPUl3fJEpEvO/iSy2EgVAvjbMFjmqwtblAKDgBH4pjXhMlqvs8fsrIWMKHOyu+Z1Uhs
         AHgy0n8ddMyNWdJdfGJmZrmub/Rx9rdgjE2m44Ibzbnoq9hg7FFW0HrnYUGKQCM9BGHM
         Aw6w==
X-Forwarded-Encrypted: i=1; AKwUvBz1XyixkPeAwwU5P1cYq5UNPyvDMKu/jX3jVj6r0q7nj/Gu1lkt1Tp98dfqYXovsvd91LEO29Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2rEDsXjQ68G7KRsspURsp7pVBpj4qY7Rrf9wb3Rgf2XfUWfut
	nCG94XJvZhh7bxcSktJ9mfHy9pm1SPyXs2oYVOLXJNmDKQ8NCQdhi0Q=
X-Gm-Gg: AYBFou0Zxh4lbRAryDRCLFOfDjFeBlak8lHMn1C6IysqKWTnLAUls27deMmZvznh01X
	1X5BKp0SLs1BzI1qvoZSRVv2f8ac4uh3QL9P1jAMpIvcDkDImtSGLn1bcJGgbwIs00Uzc98lmgP
	/W5uo4uAvjbe7CPhchWagic2OcAq+W0T1o2e5a2fKp/ct5MYmRoIZW3OhIj6QzYjlGdGBCLndu1
	pg4EnKASFh8E26cgrfqxWQTEbGEvgPWh1WyPTmXYpCMUZZN/QMpx0ugGt19ypU0U8xwqzAIEZMo
	yDIn/FynwRvTNeYVopvD6E1ZFH0VBdyowQxAexfnt5LUfdVZTXHizpiM1Dp/qdTrxilqGDP+jmV
	wBViK8FHbg04PTxiHe4BlRoHGp7/NQbRdNutp/QJs8IDBuCCKyjsF/mmRBgO2M37FJTK5G4x9Mz
	7Ts/7jMzVFhb7GkRvRmrpUdH9vFQ9xjZZnMOgBuX/vdfSm0ukI22szMelwnqdTG8CNG6dO5AO49
	Va9YXlP3zxIOkhhdEOpYFW+ZSrld0sXcilocOeXcV3zMw==
X-Received: by 2002:a05:6000:41d0:b0:48d:ff71:dd97 with SMTP id ffacd0b85a97d-48e3eb2bdbcmr13969716f8f.7.1793024445723;
        Mon, 26 Oct 2026 07:20:45 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8d5sm17484186f8f.28.2026.10.26.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:20:43 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 1/2] iio: light: cm32181: validate ACPI object type in cm32181_acpi_get_cpm()
Date: Mon, 26 Oct 2026 14:20:38 +0000
Message-ID: <20261026142040.62383-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026142040.62383-1-tristmd@gmail.com>
References: <20261026142040.62383-1-tristmd@gmail.com>
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

cm32181_acpi_get_cpm() accesses cpm->package.count and
cpm->package.elements without checking that the returned ACPI object
is of type ACPI_TYPE_PACKAGE.  If firmware returns a different type,
the package union members alias onto unrelated data.

Use acpi_evaluate_object_typed() to request an ACPI_TYPE_PACKAGE
directly, so the ACPI core validates the type before returning.
Also replace kfree() with ACPI_FREE() for the ACPI-allocated buffer.

Fixes: d34ca613b939 ("iio: light: cm32181: Add support for parsing CPM0 and CPM1 ACPI tables")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/light/cm32181.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index b32a94028f091e..8d00486af608c9 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -114,7 +114,8 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
 	if (!handle)
 		return -ENODEV;
 
-	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
+	status = acpi_evaluate_object_typed(handle, obj_name, NULL, &buffer,
+						ACPI_TYPE_PACKAGE);
 	if (ACPI_FAILURE(status)) {
 		dev_err(dev, "object %s not found\n", obj_name);
 		return -ENODEV;
@@ -131,7 +132,7 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
 		values[i] = elem->integer.value;
 	}
 
-	kfree(buffer.pointer);
+	ACPI_FREE(buffer.pointer);
 
 	return count;
 }
-- 
2.47.3

