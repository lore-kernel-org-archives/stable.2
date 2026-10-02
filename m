Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF43F105B
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968519; cv=none; b=TbFVehvd+PB0l6+ViAHn2jxH0KVbj/W+OyUPkwqoH255sslc5uYCgoH5q8dooAxMkfazo+YlCqJ0zVDsZPzck0ZdwdpcxzVqYPCboLWY7a4zt31clrKh1yN1sNvG/3arEH8zw0pZlbOtCF9ztWtkkBfxIRJMXV+K3C7SJKjrOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968519; c=relaxed/simple;
	bh=uzuTwXk8WkiER0K96nRtdmtlQc4RXbfFoRo/1xUc2P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2SrdUcg3THW1K+a1G2LE4lHYhbhgf0cz7j3pUh2AI0qbhITzjx05ItpPqEfI0q7ZX6GR4C4LP6NmbP1UjxF0yTk+NwodHDQVzDNZVAbJ0YTsiwMIv+unKAWUgpWmn1gocJMEeiioZPpIddI+pfMHwAhBwRk3xlhXXYYyqHdbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6gzlLzK; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6gzlLzK"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a01ff8c098so1412965e9.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790968516; x=1791573316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5Abc9lhmWr9w80vEfggZt06aTIBY7WIzDl4UzYH0h8=;
        b=C6gzlLzKSW4zBzA8p4XKkZOXmDYUjrY2vE1WacYFXqv0DsME0Eibg3UzJJEyn5cMVK
         VZx7fnLP0NQ895SCmUzsdHTRpsHuVFR0dfyV7l3SLMufncE0kNBpkgNNZllKNL0WvtQI
         SgB6fMryvLzqGqCpEhsZHLgmktfef9EJpxD5R01nn7HZJ0DdVLVlLBaNtQ0HE20ZVMBq
         IaewlffuSBMjk6YYVnNCCJYFUN0cdninKNm+FIpktU51w29cbvg2Zw9Fpqm88TYLi7+G
         kG7dlHM3/hrr9LCQdKV11C1eSafU3NVUgQmAKe2AVQExMqHCok8bHlvWs7nQ8P9tvwi5
         bGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790968516; x=1791573316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G5Abc9lhmWr9w80vEfggZt06aTIBY7WIzDl4UzYH0h8=;
        b=OIyp3h1X6WjJ7gvgmya6Z6ALPXYo1Q1iFk1LQ4jw4U7Pi3t8yOeMDpA64DCgxtrXXb
         mUFJAp7v75dpDSOGsFwWlDLyini3Ao/TmnmyggWE70wKJUat7Hivl1CINGVbI7QVQ/mG
         DpPIRKQ8dBC8V913puQbfEGt9cWYuub0ts8tv5gR8ajQMqttKer0n0Tncui9uRYvNws/
         Pd7T+mioepxVPmtDNOLNiuE0/CPQv+fko7RVr6M2790b1UMTqebDucuwSPngA4N1yDAj
         jCWAk2fVbxPw91lGaEucu3tEn8rVTXbg+HzvClX1H11zMVKeleuO3paGRyWz4ZFCGHKB
         vF6w==
X-Forwarded-Encrypted: i=1; AKwUvByCsUOawH6t3d6OPAVoYVs3dOqOZFiNiOlRPK4fudViDX6ISZP4uNl9HA2HRgkyC8P+r57hTfc=@vger.kernel.org
X-Gm-Message-State: AFuF++kXEZ5F0uMu6LSHw6LzP5yD90iZFzhv7eEz+J3r/HegqYpd55Zl
	AW9Jfeb8GkxdLcWDYnnITlO6GV6KEN0PMhK8Z6YMX/WSTDo4jjAw8GKW
X-Gm-Gg: AYBFou2PZS6eh8TNRM7gyEH1485/EXIcJBZ/UustkMB0v+WM33yemFVq4ZGIbXv1tq1
	ARxD8gJJ8Z9g1+ybmn15oCVWJSoSyPWN1/E+xm9gcsj2S+RdN4WLgY9v/z1TtiUDlsbPRJoxiD2
	Cgagd6/pQDr6NOgUEpsXYrjUbYTBSvHiUA4aiP2w4A9Onr+eDfFxonm7+KLbcOAXnWltz5kQSkv
	K/LQp/2kSy0WkH1w1xBn+UWdgdSyCHfJIsCGmVKa3GG6eexBoT260lKqXaNuX8Uw9OjTskIELg5
	Zq5WD1T8aGT2poT3WVRNY7TQkD7VnPjk4sk1aZVsUlXSaJpISQo5rvtoUFcufFOJAw/nkHXb+lz
	6wmstJ1LUx+/Ln16xQuQ+QigKmi1jjMEVZk1VneNSlAIjZQggXNYzZAlJzfBEUnQJpASkM8tzni
	jXuIOnVz9gEzo4bJj17SXdUkwBGX55zSzcXsvyDus/QgaAeABJFZkkpoUwrzt/YVoXsOA8VrwqZ
	tLVWpER9X0prxOaAr8BmyPcZrNqgGtMr/sKOHvqd4qVd9tTvEZo
X-Received: by 2002:a05:600c:858a:b0:49e:7d74:7b7a with SMTP id 5b1f17b1804b1-4a02756f0d0mr44522405e9.6.1790968516532;
        Fri, 02 Oct 2026 12:15:16 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm81151145e9.4.2026.10.02.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:15:16 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 7/9] platform/x86: hp-bioscfg: validate SPM state returned by firmware
Date: Sat,  3 Oct 2026 00:14:32 +0500
Message-ID: <20261002191434.58529-8-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002191434.58529-1-meatuni001@gmail.com>
References: <20261002191434.58529-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

status_show() and update_spm_state() use the state byte from firmware
to index 3-entry string arrays without a range check. A value above 2
indexes past the arrays, and the result is printed with %s by the
world-readable status and key_mechanism files.

For example, a state of 3 makes status treat whatever follows
spm_state_types[] as a string pointer.

Return -EIO for an out of range state.

Compile tested only.

Fixes: b2715aa2e135 ("platform/x86: hp-bioscfg: spmobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v4:
 - New patch

 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
index 4d94e48c1..f0eb5c445 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
@@ -118,6 +118,9 @@ static ssize_t update_spm_state(void)
 	if (ret < 0)
 		return ret;
 
+	if (data.state >= ARRAY_SIZE(spm_mechanism_types))
+		return -EIO;
+
 	bioscfg_drv.spm_data.mechanism = data.state;
 	if (bioscfg_drv.spm_data.mechanism)
 		bioscfg_drv.spm_data.is_enabled = 1;
@@ -153,6 +156,9 @@ static ssize_t status_show(struct kobject *kobj, struct kobj_attribute
 	if (ret < 0)
 		return ret;
 
+	if (data.state >= ARRAY_SIZE(spm_state_types))
+		return -EIO;
+
 	/*
 	 * 'status' is a read-only file that returns ASCII text in
 	 * JSON format reporting the status information.
-- 
2.43.0

