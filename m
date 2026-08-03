Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924FD4137AD
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767470; cv=none; b=BwjYmtJwYN0yqWSlJAAext2rAQ2umWC0qKZbq8LhQYCT2MbkHynBdOQGHVDZWTaHvLaqLdZDREkoT3iKGrBcKJINAG//o7Ull+FQR0p35cF2yB7/9zoMhQmT6fzTlajYB8SxPJNLAdaYhPMW1kUUECnlZXUmIneKJClrUlVczMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767470; c=relaxed/simple;
	bh=rhV+qOT/cedymAeQ3DQaL+LQcUHG8piPrtIkVunzAvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V19TagNBNBorUcv2AZuWHuVR+Wr8brjyu2e92pN1WtfTXq1nvZMEMJBmUWpGWewiwPj9Rnt6ROTi6x+Bx0qTQsR09yCliA9Y3EDRjiGSi5wayQigCycdhZAuKjYYyfmikp5R6tK4cY0n2lKhObmQ6hzOcVXyMZda1uI6MRC/8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ocRj+FK3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocRj+FK3"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956869750eso13722325e9.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767466; x=1786372266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNoDrCXm49lLgm2lL6InxDz3MAxyPtaZVFbbdYtrWx4=;
        b=ocRj+FK3AEnX5Nld63RlI6N4AAoJhPXAfs9T8hZzjcSB4Pg+8YvHdN3TlCqC81jakX
         t3K6esULZ6+xtHsvrj8pVijO08HSBDe4bypRRFAFw3zH9BP2uVR7suvdkbpEHEujmt+n
         fwYGlNrpwG0UMHd6rUSAW1VnIWXYHVO4/GM8S+xGtQKvDJ56VPTRB1jyQuDZFZoJf3DO
         5AoOoFZAndWSDH5bpGeAkGKeF2jYHUGRYOXcWISc3eD9I58uTTiKXBa28cfENLd1HWkU
         OJ4nUmC4zrqNDaNdWQ4GX6f7nkRcgkhJrnyWUnMoyHht+0dMhcN9uj5PuRJdAH91LZCK
         0h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767466; x=1786372266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hNoDrCXm49lLgm2lL6InxDz3MAxyPtaZVFbbdYtrWx4=;
        b=LjkwUYr5z5/n1Aiv2iC6cxZf4+uUIHu03/UeBX13rs4VUw9jd38RlIyfFEjqKmbM+h
         XX4/BVOTthF+pShKbmfzaH1cjhXBFqs10UhjUERQRfD3fP7IHzpbnoWTKcbOdRvAAoKr
         rJq7ow7IGhKydnI5+LqoutzO0f7zIrlqHJApHGWsfB+qX0CV18Sk8SW/m/ZHOTXuzpk/
         mlRNVYt48nE7om2PbpFOWRwnMpOqUgrlQ4wCSN+bOZH6dNeakPLwoMRda/yyrjwII37H
         Xzxl+lkDjPJUbXZ3T+UwIJpEHJWIaZy9xTsctLEFGKzcXbW/nNIxRnLLoj9Ixla5LMqC
         QNNg==
X-Forwarded-Encrypted: i=1; AHgh+RqQ7U4VBfevOgykTd1fOzDERMbWwYrDTQDKeWQtvOjFUf+AVE5R8cVM8wzlzpBqVlmB8cFe0QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRczK9nWkigeFrtKjWTXe8sjQTf6sZq2XaVlcF6SglmkHy5TR
	rh6nuVgYCSUGWKgDHdfILEGHnJqpuZsHtd2RlZDoYtKOQt9EaGeUg2ej
X-Gm-Gg: AR+sD139ieNp1VQ7J8J91w7x7gN673sKPjvz675wF7V7FcVLQqB+82dNXlBzsuIBYCZ
	DLq2Z9yyU/V5ZSRjm2F7rer72ZOXGEm1WxLHt5nkt356CtDU31HoeiSosndhn5IYLOzCa4fU+dX
	VfM//x8us0h5u+SjSW/b3iZqebwBeRpQ0JAYQ2QutKLyfMCj/+sBtyvipHlghoLbHWxHbU5x9Rv
	CFDyTJOCNTOnC90Z7oljHvlaaM/jNoI14mzQClE6lHhLeuUNQ4n45G6JwE9x4a2KHsgOI5wmxo2
	6YAWiJOz0jBkFowQJ+ZRZGUNTG40/1sJxmajSpBrcRH83n6ii06TlcgzOmG+a7KE6VwssZJeeru
	t/5sM4OXuaDCmYdsqt5NK/m9DaGQB1knRJn7deNV46FK6rXa0FfrKaHInhfJWxFlWyV9wu1obT+
	WZ46Ma38MVvWdqOkF6z4Xgc4/rH5DDo14IzkZ3RO0SJea91GN+bNXgnlsaa7GfWVwAo/lYgkFn+
	H6Tw6PlaC3PAfcVvFCmsIk/8ikJjsyUMlfxd0HYpA==
X-Received: by 2002:a05:600d:8443:20b0:493:e974:41ac with SMTP id 5b1f17b1804b1-4980c6562c5mr183910265e9.16.1785767466371;
        Mon, 03 Aug 2026 07:31:06 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:31:05 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 06/13] platform/x86: hp-bioscfg: add missing bounds check in PSWD_ENCODINGS loop
Date: Mon,  3 Aug 2026 19:30:29 +0500
Message-ID: <20260803143037.93105-7-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803143037.93105-1-meatuni001@gmail.com>
References: <20260803143037.93105-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PREREQUISITES loop earlier in the same function checks
"elem + reqs" against password_obj_count before indexing the ACPI
package element array:

	if (elem + reqs >= password_obj_count) {
		pr_err("Error elem-objects package is too small\n");
		return -EINVAL;
	}

The PSWD_ENCODINGS loop performs the identical indexing pattern,
password_obj[elem + pos_values], with no equivalent check, causing an
out-of-bounds read of the package element array whenever
encodings_size is larger than the number of elements actually present.

Fix by adding the same bounds check, matching PREREQUISITES.

Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 86fa03a5ee9a..acb123985ede 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -351,6 +351,11 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 		case PSWD_ENCODINGS:
 			size = min_t(u32, password_data->encodings_size, MAX_ENCODINGS_SIZE);
 			for (pos_values = 0; pos_values < size; pos_values++) {
+				if (elem + pos_values >= password_obj_count) {
+					pr_err("Error elem-objects package is too small\n");
+					return -EINVAL;
+				}
+
 				ret = hp_convert_hexstr_to_str(password_obj[elem + pos_values].string.pointer,
 							       password_obj[elem + pos_values].string.length,
 							       &str_value, &value_len);
-- 
2.55.0

