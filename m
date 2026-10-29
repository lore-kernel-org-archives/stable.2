Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272119;
	b=zwGRDEF1fdu/U/AnV63WEOP3i+U4bdrBBVOtXJvWTmVs0K2mErYt81ILDsDsXjXRO+Yo
	 jOmPmcUgYonNjp/Qi/D9Y5zUIS6fhpgD1wIw+J8CfFOKWADDWoUAMe6jsyeliDk0gcteQ
	 VBtTB9kB5S96awlSh6WSYvKo+NLjNnatfO/l4Al7dnij4ulqZTCzNrgFBWj/TWLLf1QHK
	 hiZ+Z95CeptT5Q5sy2jpbhJ2HiVagwE0/Nj+OlAMYxQHckmI7X/zmL6++xxWVKn90KcMV
	 H2iwaW3qRKe1EMX0niq6CM5l8p5Mth3waKL50kadfg7vz4ZMrxliBVST43SIm0kFRYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5Dr8fUPXt5hNgYrHFxebqt4WTv+cM5sI+Rzy2ba6XE8=;
	b=GpGc3dckAYchKADUKmr2WHv/S1litPoGHhMUInr753lxb8aW+qSM22up+W0TZLZtmm97
	 UBqHtei2XR6TMRd5HtGcZVvj6AJAI1eozjGKTZljPyqDekqQYKjBS07gGTAnGEyRgH51W
	 isc/sWl1JDPAx2s1TYtIQPyj6gcBanTHdYE0SBuD0+AqWyESo/4hq0u7HzXkNVPKoO/l1
	 co3Rj4/m66TMgHatpRpCPXBykLFifqBUYx4w/QBh2CKN0n7x1v1cDFCe2ShrYZGUVeyHs
	 vs5fAWhWo3J+zfwZ7V7Zw3trqUxU1yw4gD+tfZoVeMenfMtOUEhCkR5eXvqtuIvSV3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Izty4oPI;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3417606A32F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3417606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Izty4oPI
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c46d41f6af3so295221566b.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272117; x=1793876917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Dr8fUPXt5hNgYrHFxebqt4WTv+cM5sI+Rzy2ba6XE8=;
        b=Izty4oPIDBwFCFplCs3kxMz5ctmbJ5Omimnq0qSz1LWjjyYa7ta6n54JeSqECbDYiz
         /qhr8igYzuWVOqyP/pSpC76a9hk3J0f93I4FpH80UJy50fL4zrBQYIldblSji4q91XJ8
         VsdsgEU8Rx1OXwLJCnuPf76Gje68k3ueuGM6d5LD1OOqIsnH8tmNI8ldWkSp47dQErBk
         dTEKdGDOBlk0aBgvwwL+vYAlSJuQ86I+38Yfw1I8a5TYOLTkkpAdEVktKaKiTmY0/bxv
         Mcgb0UPEVYhVQkeRNHb74OYddpPUd4aMqXJzXJHDqLHEYpyomyLW/v3tZJjDVXI+esuM
         dp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272117; x=1793876917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Dr8fUPXt5hNgYrHFxebqt4WTv+cM5sI+Rzy2ba6XE8=;
        b=v7hyX5Xp30H58INDlbR3B/EG13/3ROIPjtfNXnTarW3/F3Hv0KbFCO/9AONQCaeYu1
         UJR79XEFRmSBU092F/u6IzZ0jnfCo7PpdK3CxrGVc0wvLb4KOLIDcioQRQcH2soKEpuF
         Fa00aI/ll6AdricyFS1bU0P9rQNBYpYhkBeZULOrLTZNSI/wWVtdHzkSpz4Qhd0XQ3FN
         7lNiL8rnRLPYPvGwxm+H4apRvZs9qVnE/c2ma4jnzy9PIJKF4txiSYiybzboT27WhCh/
         gkWAU7IBHzTw5T5soNo0v1oB9GX+atjvwNVAF363jvOuHUwDcHTTKoUuzE4Sq+56q/Yg
         ZlWw==
X-Forwarded-Encrypted: i=1; AKwUvBykl7wKTqv9G04phiWQGpXIQeCj589e25KmAgpIzgbyP8PPyj1zF1a1jwlce4Qj+RraFwoSWRs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWdzLxR0skYVcsZaN1EF84M/L8i1gSF02TEq12zWVH2AV3o4Oj
	7ZYKuBqqQPs1HRfx2cY48oatzgpdIKFnCPRGrRxcVvnR3ij9pTHLqUI=
X-Gm-Gg: AYBFou3XaEp7lW3stWNjzOStrXG4oDp8LYpAhxI7/PCsn8vsohAZQOC/QL2wYfsCsdu
	lEDVVNBOxtL0tH6zU/m4PYCH5Add+jZiw7Xw2K5+3CV3xtLaoVL9YwZrEFGC1O9BXJNFzVr5azm
	OlyVOKgeojwKlZipo3UEkpRPFpEkvyF+uqBSaN1WaVNTZotuRdWzbIoqMtS8UU5rBPfDNhmx3V3
	UrVLWcEtPcpWReSGi7llAt7JzGU6GMzuiSNxXdo+K4ngng4pQnlyA3w8bJ8qnsFRkG5Yzh7b/i/
	T+Lcu0t6Iqfaj6SQtjyv++r2Ue7obGdXXHuJpnH2lgRJyroSehEeMxsSqoJbzmmpV8y2CJHM3Wq
	w16Ht26TjZJR5ejppjQWIHfihwT421N4GiJabrP/JpEb9xAS/ZWWYvNBywJosutPI8fL2zMDpHA
	m9EbK9UEymYaGe0btSuHsE70RCb6Jo4S6VrEmylRH9OtMTIKRjNbCXQQ94DSrSlWZp5ZivDf5Tc
	TrTBJC1FC0HQUpI5R9cStQPR1TPwpAzlebu6ci6kU4p0tjS5Vx0bdauR65kpmMMIrz2+iJYTfY=
X-Received: by 2002:a17:907:d516:b0:c25:2688:8212 with SMTP id a640c23a62f3a-c49bd9ce44dmr502861166b.0.1793272116807;
        Thu, 29 Oct 2026 04:08:36 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm33716448f8f.54.2026.10.29.04.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:08:34 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/2] iio: imu: inv_mpu6050: validate ACPI object types in asus_acpi_get_sensor_info()
Date: Thu, 29 Oct 2026 11:08:29 +0000
Message-ID: <20261029110829.1086835-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026142040.62383-1-tristmd@gmail.com>
References: <20261029110829.1086835-1-tristmd@gmail.com>
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

asus_acpi_get_sensor_info() iterates through a nested ACPI package
structure without checking types at either level.  The outer object
returned by acpi_evaluate_object() and each inner element must be
validated as ACPI_TYPE_PACKAGE before accessing their package.count
and package.elements members.

Use acpi_evaluate_object_typed() to validate the outer object type
at evaluation time.  Add a type check for each inner element before
accessing its package contents.  Also replace kfree() with
ACPI_FREE() for the ACPI-allocated buffer.

Fixes: a35c5d1aa96a ("iio: imu: inv_mpu6050: Create mux clients for ACPI")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index f7bce428d9eb4..e6a4de4fbffd2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -50,7 +50,8 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 	union acpi_object *cpm;
 	int ret;
 
-	status = acpi_evaluate_object(adev->handle, "CNF0", NULL, &buffer);
+	status = acpi_evaluate_object_typed(adev->handle, "CNF0", NULL,
+					    &buffer, ACPI_TYPE_PACKAGE);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -60,6 +61,8 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		int j;
 
 		elem = &cpm->package.elements[i];
+		if (elem->type != ACPI_TYPE_PACKAGE)
+			continue;
 		for (j = 0; j < elem->package.count; ++j) {
 			union acpi_object *sub_elem;
 
@@ -76,7 +79,7 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		}
 	}
 	ret = cpm->package.count;
-	kfree(buffer.pointer);
+	ACPI_FREE(buffer.pointer);
 
 	return ret;
 }
-- 
2.47.3

