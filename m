Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024454;
	b=0EYYqG+Mjo9vV9ivnapk4dwK1EcznpIx1RV4FbHMN1ThdWPVNDsJH7K3J5UqeaPMJ7Dc
	 JTKuvrKY5MFbTdypLl3oKI7uvnJAJUdNoxsbjb3sLOVfDIYohyNHYkdH7dZ46QevvN+NB
	 gG/32W+QOwGV+sfUCco13rj3tS3GZEU11pAF2jdoQKXWIASzo5gBeMFhITrKwz75WT2zQ
	 VtfbzhoF0MCeUBWKEiGWdiwM7VIWX/xYLp8s8yv4sj7GhfVQO6eghd1l+44z3OM/uAjaD
	 /CwfpebkIGi3J9XzZhaKBW0H8r1L4pqnuA1veqP57K+L8yGlnoxWQZlSQ8WxWxWJ62w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LgPmm/ErrwehZ+XLxJlpoTIoC++Xdryf/n5RHQZpOtw=;
	b=WRkWWH/OEskExo5stk7B+w8TmmHaoURqDdjBoEtzVzPV/gyGKH4o4F8fOwtyCSsg9EF8
	 V5UArjckdUL6uBhV7OMrlW0PM2BfMFBugKijZhIT1cyJflyY3+Q76nh3J8if/6lBKiGrk
	 dPoNymBTaFBY0C6VPtd2mosJEdn7toWp2H0W51v7BUKWk67RGCAVWgwityEz6AUNfM874
	 UGVrz7E06BKjy2Hyf8eZ1Fjl7OXuqBfBpYtkZxvZnaHvAtbSyZctfnh7D75WyyoEXOfMf
	 QK9i5VhEoG9waIML0FN/VhPeIboypJTxWCbgbKRzfenkegofgMpQNn0RAEzgP8AsMVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I5GO8QeG;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1A60A2612
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9D1A60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I5GO8QeG
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e0d1da913so2460942f8f.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024452; x=1793629252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LgPmm/ErrwehZ+XLxJlpoTIoC++Xdryf/n5RHQZpOtw=;
        b=I5GO8QeGXNlCXahnsOgpe1kLFB/P+Gajs3d2ivcElZp0nGsxs/o6SfavY7cXPO8qvv
         K+QXcoc3M4fpLcByidkS/r0GpQveUhNex8boBCdmPiytb0i1UCDVm1w0rk+ygkS+hxKu
         g4NiefZSDhIoEYqmn/CbZB4ebnuhRh3bhR8HNGXZRU8bEHrpsXnW2k2sbW+sDlys5ifG
         HQNNyhN8uQtoWr/jXcy9cqgvw+fHwL1nhhLiVVbBEvf+gssXMoyY4Z5dOLWTXvOy+/bu
         1buqLolZ+Nom0tYxf47BgLF1qqvhVB9JoddlCsXxrVCqbdgaVv81kDiBdl2nv7Eesy+S
         uSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024452; x=1793629252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LgPmm/ErrwehZ+XLxJlpoTIoC++Xdryf/n5RHQZpOtw=;
        b=rPhRqeXhzoSzGGq2LYa4cUXbMiE/LTo6HVR8FRi/v/z0rIV8XJ5a/HUnMbzu4i2Wpx
         N4/1PVeKswxUdzPAyIuBWA51kNTCYQV92qDtxhxAcG9IZ3TclABP77x2i/AFPM7VeH+Y
         5wpAErCaE+KfXj/jKh8dAHs/9KNzGlEvzbNp09lO5hnURZvgHyyqK485Y5o/Q7aTCs0j
         3GNF7P1gt2dApo4kcdL1NKS9HccJB2HXoWdn+RQB2WkDF8MB/omQhVMig1KY3RzllcPn
         INNZfG4XeBreoo2PYI1ZgLTBU8VZx30e8Z04Q/JIGInCebBmR9MDsYTBfTH3eZSyq368
         mB9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxnjP4SrqOxjDK6tSevpCqF92kRL3rESSpN1mF0rMeJsiw0dxbSyzq22g4UV08sjc05lhk4bqs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaclMxHE+NCySEWUuqjPt7k6qL6uwbpCD2ZtVZF9chx5BAN+xD
	Aan67Qyuu9Z9q2uZ/zUU5GtfI5Xll9xlkDqaBZlEnzaZ7Vrs66sHXsU=
X-Gm-Gg: AYBFou0pzP/YfdPB+FAYAffOey2rNNPkoepYBd1zVWdewp/sG1M7FOAF0xsde/EhsSs
	zIbbG6el8Djkq62X0I4FTbTd4AhNBWtJvdpkKrYBVpTmcPZXLVzWA/oaaHsqELSPiWHZlduY05D
	VZodkPzCCGmUkx1I9UYKRxifjU8xhhuScfcS6dXEHeWAMopmmENbptoIV2HXMgnbODQR6UnY3q9
	QENgf1Gk9XH57LhggneEOhjCLIrLb2y0aTM0ZEodtcZwzwf8q/FdsdcfPVN38ulOXyqkThF4qmU
	QKlasDAylmSPIGtcsBur80BS2oWkSjKpXo2uvOLXs5nTmGOnZ1lWY7lN8sBZTmqUmkwJj9S8T2z
	NJxL5s00/jAI5WuRGSU8cFHhzoqiMtSkGt5MLHoynFsYhYevZWkzhiLkIU0ZAUv16Yx44r+ys+p
	VqVpPofFQL4k0rwWshbGXBhDRdt3iAZWcb9Mzgi0rHiD/RsuttqOdDZN7DvEJeWx4XlYi9fQc4b
	Q8Htif77pQUhzGvGG7W/TqumUy6/8eOLxekUZAzZuMteA==
X-Received: by 2002:a05:6000:470a:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-48e3ed1ef39mr13569277f8f.13.1793024452132;
        Mon, 26 Oct 2026 07:20:52 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8d5sm17484186f8f.28.2026.10.26.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:20:51 -0700 (PDT)
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
Subject: [PATCH v2 2/2] iio: imu: inv_mpu6050: validate ACPI object types in asus_acpi_get_sensor_info()
Date: Mon, 26 Oct 2026 14:20:39 +0000
Message-ID: <20261026142040.62383-3-tristmd@gmail.com>
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
index 460792ed27e031..e5ffa0d5f6b1a2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -52,7 +52,8 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 	union acpi_object *cpm;
 	int ret;
 
-	status = acpi_evaluate_object(adev->handle, "CNF0", NULL, &buffer);
+	status = acpi_evaluate_object_typed(adev->handle, "CNF0", NULL,
+						&buffer, ACPI_TYPE_PACKAGE);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -62,6 +63,8 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		int j;
 
 		elem = &cpm->package.elements[i];
+		if (elem->type != ACPI_TYPE_PACKAGE)
+			continue;
 		for (j = 0; j < elem->package.count; ++j) {
 			union acpi_object *sub_elem;
 
@@ -78,7 +81,7 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		}
 	}
 	ret = cpm->package.count;
-	kfree(buffer.pointer);
+	ACPI_FREE(buffer.pointer);
 
 	return ret;
 }
-- 
2.47.3

