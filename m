Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3851438466
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790979; cv=none; b=qcM6wBeHqSi67H86nKKDOgNhQS/bQPiiOQlgQPwjfSLFiYU3ulIahcEQtrs5YU/nfzTjr9zV6+gHH2b7sOogbFORcUG+ON0Mh2Xold8XZCvpgg06CSPFfA44Z2KPFThfpVfrj9wOpJbazxLhy7XvmW6pgbK7Dt2Dro4hBoLPb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790979; c=relaxed/simple;
	bh=5US6qHRDMsC7+3n4j55+vD2ffevfbGh9rWJssZb03RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEjETmRopGvZikk776+EPkZoBSZz+a7siPoJ37Vi+LhS6UGG4kNTaROsT/i9sbVIZOvWx7T6lS4WHEvG2JGzYwpx7UXWtHtaQFZwaioQnJu4+AUORk4FbOwaduRWoh4SaygQ8lP/A2G7+cBK3hTCh6OFyoBqDe5TdSc/N/6hOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db+sDMKX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db+sDMKX"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab066bef7dso701489a91.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791790975; x=1792395775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kcb5d4WbMF0RGuZ6n9zwqpNvEO0t828hCiSHNJS62Zk=;
        b=db+sDMKXrXA5XmXgVN7YtlDXgq3epPo3+YfSrzqNCfGQfVxt2WKmN2I4ZTHq/4ONmZ
         HzPdttzy9lu43H6Ab9+09lJhYVyEJmF5d/hIgfsYkblP/F6u9ZCKgOc7AM5lFmtfjuzs
         h3J+zHBAEeTKnmuA+y06aHI8URtzJH0/SxemsRLbIQAOJMlljb5Po539pQsrCpS9oHS9
         pGrgVlizlLM26HjZXZv7ojHVqsAffAPjKwzPwQWzMV6NO1+rHwp3pFtF7Qoh46W2JrIq
         dvRFLIAQjtxgyw45uEoag5Nyamv202QD690J4SkoYWDS5oBru3F5CY4y9q+Yr1UNsGwR
         FVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791790975; x=1792395775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kcb5d4WbMF0RGuZ6n9zwqpNvEO0t828hCiSHNJS62Zk=;
        b=Dbl6Ej6rofZXphYS0+XCItJXNvLLIrfczR4N8bmfGSX+mNivG5mssDAqnhfBMBNPh0
         gRIij1n0WihCPLIiABDT9tHYDwSnRtHUCtSn004OQnGlBCBFvDiwy/nmkqG2Fdam/RkC
         upLAndO6uFLZwoXyRmgaguRyqtwvKNGJNbme8dOvvgVO+W41XN6N05kSYefy2hxTQML+
         4dqNLSAsSoGMEP+Hy+AP1HnVmjBAlwI5c8LrBlKeXgzjPjt7BmVjTMrJicCg9c74u5r7
         4vpUEb9pvmr54XFQe24pdds53qLvmq0meMzLaUYRLuuo6zlCIzx20QBMWQ7t45U2xCSi
         dlGw==
X-Forwarded-Encrypted: i=1; AKwUvBwVkp8pA3O71/0L/lNEvX6ZjctA5oqiF4t9gH1uXF0nvuDQ7/bvtUJubxqaofd6MRHp6cXqKOc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZCJeF1LKVBCfEI/mBNVWXJwhyfbeeMWtjrhOBcbNeOuftzP5B
	K14Rdlc7LviGrdX+kBHqAv5qfXu5tpbT/KJirPgW1Aq0TVxEnhDDCqNh
X-Gm-Gg: AYBFou2uMQsysbuwSp2YuI37ZafS8xZtCBY83k3f+4Rk5avZf+CRd3RdUTO2y2mnXyY
	s3OUtFqauFNafVy2yuIZHsbtIhB18FXiy8vNZo8PnDXGF2N/dU7+Pgz4NYYwNsomrDA5rgn0zPg
	K9Am0ndpG5IliQuzTnvP74gxmb0bd2jUbi+t8OiBo1AGLsyRyVEPXMDT7qG+VJy6zAt9fn3I0rY
	eI5dtwQJMJoun4xLwOeXO6vAu9iycNKwt1+3Hg0NCC3oIdron3XUke0E4l7TH+gMi+pGA7YdZKQ
	PWqddSOLFAsyG+pF3FXKLL0oL/0TFYjwuSJ0+799XmjTlfnNhpHIqa1iHEcB4qW+/eXTWjN/BKD
	oPuQh/y8cyBptKcJthjfcqHM9JQfr8iLjmsDjxNRqTv5O/UdTrlImW0tX4aUhuiri4YTms33T2s
	Jvdha715G4tcltIWe31gOz3dkcNfsiOGiVQoIWVQbeHqm1kJN4vOChM+MgoKJnw3XTVtVxSYXHo
	RFX5kRHxr7RnTXYGql8Dn9VtzPr0SH5Y+4sYQr1bg==
X-Received: by 2002:a17:90a:c88b:b0:3a4:8c41:fab6 with SMTP id 98e67ed59e1d1-3ab3ab32a3amr6713683a91.46.1791790974980;
        Mon, 12 Oct 2026 00:42:54 -0700 (PDT)
Received: from lenovo.localdomain (211-23-53-87.hinet-ip.hinet.net. [211.23.53.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab37139b59sm15470556a91.13.2026.10.12.00.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:42:54 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: acpi: Accept comma separated values in ROTM strings
Date: Mon, 12 Oct 2026 15:41:44 +0800
Message-ID: <20261012074144.1060625-1-asas1asas200@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ROTM method of the MXC6655 accelerometer on the Higole F9B, an
Alder Lake-N handheld (AMI BIOS F9D_16G_P800217, DMI strings are all
"Default string"), separates the values with a comma and a space:

	Method (ROTM, 0, NotSerialized)
	{
	    Name (SBUF, Package (0x03)
	    {
	        "-1, 0, 0",
	        "0, 1, 0",
	        "0, 0, 1"
	    })
	    Return (SBUF)
	}

iio_read_acpi_mount_matrix() only accepts the space separated form used
in Microsoft's example ("0 1 0"). It rejects this matrix and mxc4005
falls back to the identity matrix:

	mxc4005 i2c-MXC6655:00: Incorrect ACPI mount matrix string format
	mxc4005 i2c-MXC6655:00: mounting matrix not found: using identity...

With the X axis not inverted, iio-sensor-proxy reports left-up when the
device is held right-up and vice versa, so the desktop turns the
picture upside down whenever the handheld is held in landscape.

It is not the only BIOS written this way. The BOSC0200 on the AYANEO
Air Plus uses commas in its ROMS method as well, with a space before
one of them, and its ROMK method has "1, 0,0":

	Method (ROMS, 0, NotSerialized)
	{
	    Name (SBUF, Package (0x03)
	    {
	        "-1, 0, 0",
	        "0, -1 , 0",
	        "0, 0, -1"
	    })
	    Return (SBUF)
	}

The kernel's sscanf() does not support '%*[', so there is no clean way
to take both separators in a single format string. That leaves either
a second sscanf() call with a comma format, or normalizing the
separator first. Do the latter: turn the commas into spaces before
parsing, so the existing "%d %d %d" format, which already takes any
amount of white space around the values, keeps working unchanged. The
strings live in the buffer acpi_evaluate_object() allocated for us, so
they can be modified in place.

With this change in_accel_mount_matrix on the Higole F9B reads
"-1, 0, 0; 0, 1, 0; 0, 0, 1" and, with no udev hwdb override, the
desktop rotates correctly in all four orientations. The AYANEO Air
Plus was not tested; systemd's hwdb has an entry for it, which
iio-sensor-proxy prefers over the kernel's matrix.

Link: https://github.com/hhd-dev/hwinfo/blob/d9508123bee46ae3a59dc24826030ef51ea95058/devices/ayaneo_airplus/acpi/decoded/dsdt.dsl
Cc: stable@vger.kernel.org # 6.10.x
Assisted-by: LLM
Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
---
 drivers/iio/industrialio-acpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
index d67a43843..c77926f6d 100644
--- a/drivers/iio/industrialio-acpi.c
+++ b/drivers/iio/industrialio-acpi.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/iio/iio.h>
 #include <linux/sprintf.h>
+#include <linux/string.h>
 
 /**
  * iio_read_acpi_mount_matrix() - Read accelerometer mount matrix info from ACPI
@@ -63,6 +64,14 @@ bool iio_read_acpi_mount_matrix(struct device *dev,
 		}
 
 		str = elements[i].string.pointer;
+		/*
+		 * Microsoft's example separates the values with spaces, "0 1 0".
+		 * Some BIOSes use commas instead, with or without spaces around
+		 * them: "0, 1, 0", "0, -1 , 0", "1, 0,0". The string lives in
+		 * the buffer allocated for us above, so turn the commas into
+		 * spaces in place before parsing.
+		 */
+		strreplace(str, ',', ' ');
 		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3) {
 			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
 			goto out_free_buffer;

base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.55.0

