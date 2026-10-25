Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951409;
	b=DwY7dIXtWGlO708Sd9FuLxJyp26WRCY29JkG8nYJhahi6eD7P5WjVtfaZ06XOAvloseS
	 u5IswBOhfKqLnAAMAXuBPdE+lO2Ss6KvgZRGVDPLU4seCDNZ4AUZpDBlclbvHguMj50xw
	 qDSkWVfch+NvScvi7UoZhfq/tUNI09v/RS3ZG9SAk7f28uyKQTTveoet9c5928LJaIVG/
	 cVV3DbuibtXFM6TTxQtGzATSVxeuYY5uVbl4qHgJ9AjTulDKcJpsHxLDZtqAkQHRIB2f1
	 Qb9iuiN8AklVAquDqqNZKSvedI+i50i6GNBxkQLRWwFkealqm98j3hNecCi9X7xr6ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FuQYvevBom22bTnzSsTpOFkpY8t4qr2tg5E7eW5T0Y8=;
	b=BUPg5bcgpLkwHqTpDxDva1bxBqPe7lfjYnr+HRb9b3gvYKrP8fGkeLOiI2x/rATyz+Gk
	 77yqN4d00VGmjyuSAElGQ9ntzqeCkZLMNqmEXIdpySD3DStoruqLARydCHXWmpdq7wItI
	 tO0Maa1Gd+vccT8pbHmfahmDiST8zbw4mEadABU2Z5OYQ3qtr0D51JmARo4QPlOrF6GUP
	 VEdggPsPIBALH8xvJTt/hido8/iEFCfuTCFzaR47HxCrAnKR6OKMau9zmIXurbxWWBu2N
	 HjuOmhVuq54mE9ikZCwyR7esNH13xskVS+EOVwMWvqTbLYXsvEEyTYQoVvztjN2dduA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SjwI2lnG;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255B606A32E
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5255B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SjwI2lnG
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso9978265e9.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792951408; x=1793556208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FuQYvevBom22bTnzSsTpOFkpY8t4qr2tg5E7eW5T0Y8=;
        b=SjwI2lnGWsinoP36jfi0ElwFZziJ93zTgjc/8QgRa5KztbBQbZawlofZ7iG+//j7vY
         bScv9n6R5wwlBVJmwebpIwQVyAV14rrLJYBTR6WqU743VDO18gsggzmUenDyw+twCZ9r
         A4qMbuTpOCk0EJTGdGomO9wqcsfMs8RykGTU18kRjzpH/i1vnr8irhYU2csD/kvLZrX1
         A4EyaDB8D56X4uqGMx+tMcjpQbx53lsjuqRt8fyi+ZV7nkmZwAVVEjT1BM41GSz8+uLt
         C5G7OuuGM6ePEkyWdb9G08Mnz2spgI+XdGeVlawZJBc0oAWkhAISYbxQPJW4qIdJ+kN5
         EKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792951408; x=1793556208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FuQYvevBom22bTnzSsTpOFkpY8t4qr2tg5E7eW5T0Y8=;
        b=mcOArAKbj/AaqyRvRLwG/FTZXOEUAQAm6euEbUJ64jwzQ00VsLSm4+BanhBT+4e4pt
         0IanldvEGMllsHwRVPZtindS3wOmqvEhhfbtJSTItVsKrxK4JdqtFLiDMZZi/IEpOcOq
         Rl2g2hYPFA87CR9JUGKMD+VaP9tDUgUYhs+yO3HUUT8yRSYgvwcVCUD33tIsFUUmd2TF
         xPlRbFnDFcofN/xrMIZXPArPPFk6nEfn/BYhTqMffUkzVbbM3MAdSWsqmtp9mEJINSdd
         PYdV+D1CaTj0n6YtAosJ+3amdRY7YWoXisdfyEvPL/J8cQijOxe7Uq44DLqEehq39TCo
         TWIg==
X-Forwarded-Encrypted: i=1; AKwUvBw/Vc6LxKEuvhm+ncq1C9rbum1ugjGzSc8uVsfSvK0VwaBmylUzAwp+HcY4a+bf7dEMVvZJKws=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVgJtO5KxVs614l8hwi515G/bca7IOGsR4O2KqPga1DjWXP54I
	CW4NAzBUhbpJ21TppQfVqKz/qfVlpYq0G6gJA5QuMJr+o0MhpwV6pMk=
X-Gm-Gg: AYBFou1GyLFUZnTCLsveqkujjP624NoCANmUnH2pzrNnw5ri9SMRnBJ7FT6DeuWsJYx
	GTA4sAUfglVuKFlyl0P1pAg6Y082DXo263dQckFUF2FjSvoZrjPqOqXLhnSf27U+pgT80PeOgp/
	TOit/kkSffxIHWjicl0nzCaHNegbgtwPU2dNJ2MeyYXJIk+i4QlGOJxeCxAyZyalExWGKQJA3mS
	Bmr2cUT5ysNjrsTgtu4znuUiIe4Xr4dfqT6056LFwztz5LT19AlWmbJDMOqc8yeVcrv8ff/7GSc
	zYD+jeeA7VGRqiSdsKSg7PiBc7LGMfT3mDu4CB3cf5UvHFN6mbFjGbK3zTTCpWrZfA2Ang2Uklf
	UeK5gh5ipkELG1eZXOkfUUmyTZJuPHhynuZZ9CqMx5VklnR03dN44PJqy8/1XcLSrcPMJqVasOt
	fq6+KiZHfl6CfpBJpV32cls6vL8SkVwLE0OC/UHmdqwVhkXsuRexq1MMq+GykOxAxeytN0sy0NQ
	GSkm5ur2nB9KKS/WngDLVraP04rUc7JSwcVQw==
X-Received: by 2002:a05:600c:4ece:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4a35ac9d116mr83202465e9.9.1792951407729;
        Sun, 25 Oct 2026 11:03:27 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a4cb7bece3sm82641055e9.10.2026.10.25.11.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:03:25 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: inv_mpu6050: validate ACPI object types in asus_acpi_get_sensor_info()
Date: Sun, 25 Oct 2026 18:03:23 +0000
Message-ID: <20261025180323.3641477-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025180323.3641477-1-tristan@talencesecurity.com>
References: <20261025180323.3641477-1-tristan@talencesecurity.com>
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

asus_acpi_get_sensor_info() iterates through a nested ACPI package
structure without checking types at either level.  The outer object
returned by acpi_evaluate_object() and each inner element must be
validated as ACPI_TYPE_PACKAGE before accessing their package.count
and package.elements members.

Add type checks at both levels of the package iteration.

Fixes: a35c5d1aa96a ("iio: imu: inv_mpu6050: Create mux clients for ACPI")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 460792ed27e03..81fe1d96365b4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -57,11 +57,17 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		return -ENODEV;
 
 	cpm = buffer.pointer;
+	if (cpm->type != ACPI_TYPE_PACKAGE) {
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
 	for (i = 0; i < cpm->package.count; ++i) {
 		union acpi_object *elem;
 		int j;
 
 		elem = &cpm->package.elements[i];
+		if (elem->type != ACPI_TYPE_PACKAGE)
+			continue;
 		for (j = 0; j < elem->package.count; ++j) {
 			union acpi_object *sub_elem;
 
-- 
2.47.3

