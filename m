Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B36367B9B
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809149; cv=none; b=P2+hLn5zUKdcY/mie4RxjU0DFKJf0M2DvZj1GtTlbBH0K/rvQbPlS0pWeK1tegO3U3ZqAeqrRkw8sUxLSnPbaphS6xjm7xMA8Hy/CqaAihijVgeJoAElBaV6OQ5I6qSiHTGVkiOHEriCEMo5LZUPh/54jlVuuMawh0WFvstUoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809149; c=relaxed/simple;
	bh=xfQh0Y5R20vSZUxjaK2vmYzmU1LW79HxmsPiG+WbHk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NWfNfMl2Jbt9kJd6rJtgltCeG8SCk0hBmdI+XH+0t5I5zVhmuxUvKQYlU+kNhz9uJ22kRup+QcnIUCZ3IyCIiggdiO9IWgk41sV/w2Shyr6JIOjUp6V6yTDP2exWHhV9ry5G84cxpya5IL+sHUcUSxLO2BY4X/R5OOYo58x53g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3ijnRxm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3ijnRxm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-482c58a8683so177824f8f.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 22:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787809146; x=1788413946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lOz3YD9m113l6BvHxW+pci6nfgveDpLEimxy0iOIiEM=;
        b=c3ijnRxmJJGNX1Co5BRN6SCDFkviargZThXe98Dwp5eHrG01JVfRzw4BQssiQ8iRem
         k4AUVtA7vc57GEoYqWuqbwYR27VTnifhBFdUonsd7w5972g2+XFTUoV78+oqBMwqkerf
         VbFSbN0TIODlaO91kp8oKS2fMkBthjFUPxoAXH3TghfhqmwprnLqQ9zVv0IMIcSo5gnx
         l32818GwfTJ8a+zQIwUtsVfVYY4J2W+Vqc807J4WAw9k/NUp3W0nQvOgS9p5l1vReRp2
         Uwc9jcTTgoUyMf6jczXYFgMtme6Ht2/fpsXgk3UAU5fvMAhuYS3TG18Mh5vsxN1C2AuJ
         y+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787809146; x=1788413946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lOz3YD9m113l6BvHxW+pci6nfgveDpLEimxy0iOIiEM=;
        b=oBsEjCzIulnKQA0GcoEzZUpX3jQlfMhKYiKl7Ys4lWSyqEh3YciqbzvCDXVw+9cXxG
         FnJ/KuHcRUCXTRGuAY/rM04LllWn1PO4Ic0QVWPYDZGsUiMhllB4RkAsGfz6uVJqW/HE
         E4JrY4z6sWxd4ILpQ8s/jd/R/aWru7o+4Rj7S9YMvNscYI+MdaPTnyFiTOerlv8T5J9r
         41YGdmjR13IXyX/5L9wUwDFbB1sT3Z3O8PaMvOrtY7hUDUHYxtpdKQ5FP/brdJgGzBxf
         fDcctUqifBPDORXX7m9humt5LqMQmZYagL0mYOecDZ7AtYQKPeBBAe2/baygvnTi6Cee
         eDAg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+c+Fg0hiSCLqdxzbHeMNcXwiH+60HMfYRLvVPQGZgLNNYBwRu0QSTcDpD2gmEBmCwyFCw+CM=@vger.kernel.org
X-Gm-Message-State: AFuF++nKe3JI1CrqNknh/IhWVmc3sIdNM+18aegjbVMkokgcxFKZ8o2E
	/Mmrf6O9wpPn0FlTfa7TyMLW+r7sXzdtRHF9BG5HCU7XfWFj/avrdu/x
X-Gm-Gg: AR+sD10q50ENBY7dg3eR9XklopBX8wXJCurrVtGQb6e1L65Z8E1G97D8awjePdZhVC9
	GkgivXz9khkYx2WI2oxNL0C6n9ej219NnfQBVj9a269UQ7HytlGujGDB0bYPz5WLJxlvFj7jddh
	MEyo1HIZjppu4lTbHlCgpYWmW6ArL6w91RjMKq6nzBOCvxkgoOwKGzgMkq7uZItBbgh8la8Hz1+
	3UaaUDRM/ajjiGRsqmXqGTi294lJh5SGOkW3y8oQ4BjBpx3duwW0QvFBJpLLT8p7ibrMeduwtm+
	BzVcBVkpfm4/t5DgtcpkpAlapOFa0DfU/k6HxgetfVokYORrZfnsDD3OTirNbBp9jVmQUb9oDc7
	/9LwiPhuEnZ6xcgNiiFapiDDWzETa89MIWrjqepgCrTFTbZPzo/yptrOIggV2WzKS1tfYNkTsBJ
	hkGNvryzEKDBbv7ah5jNrLlWu0TkZbDJRPm7tSxJ4yj9x14DmLVMHrgu7dnWKyCvdnIYFUYLV4z
	LWXx1ysbbRw4FMHpixxjNyagsqyJXTqnDN/plqlRAUsBeadQtGkdRO3AZuVGui9kjlGxBC61Ef2
	7sInHZQPJTefZQSiVW4u0wN6pA==
X-Received: by 2002:adf:e00d:0:10b0:47f:6f9e:1e82 with SMTP id ffacd0b85a97d-482e26d7482mr10341961f8f.9.1787809146021;
        Wed, 26 Aug 2026 22:39:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-154-097.95.114.pool.telefonica.de. [95.114.154.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc3f5sm6397295f8f.21.2026.08.26.22.39.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 22:39:05 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Len Brown <lenb@kernel.org>,
	Anirudh Prasad <icarus@a0rg.com>,
	Sashiko <sashiko-bot@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: pfr_update: zero-initialize capability query result
Date: Thu, 27 Aug 2026 07:37:41 +0200
Message-Id: <20260827053741.79425-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

query_capability() copies four ACPI buffers into fixed-size fields using
the firmware-supplied lengths.  The existing overflow guard rejects
oversized buffers, but shorter buffers are accepted and leave trailing
bytes of the stack-allocated cap_hdr uninitialized.  PFRU_IOC_QUERY_CAP
then copies the entire structure to userspace.

Zero-initialize cap_hdr before querying the firmware.  This preserves the
existing handling of short firmware responses while preventing disclosure
of kernel stack data.  Oversized buffers remain rejected.

A QEMU _DSM returning one-byte buffers reproduced nonzero stack suffix
bytes in all four fields.  With this change, the ioctl still succeeds and
each unwritten suffix is zero-filled, while 64-byte buffers continue to
return -EINVAL.

Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/1a001e1fee9.637da6dc3533246.238498880682901704%40a0rg.com
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/acpi/pfr_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 9afd2c52fdbd..98ace679601b 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -422,7 +422,7 @@ static int start_update(int action, struct pfru_device *pfru_dev)
 
 static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct pfru_update_cap_info cap_hdr;
+	struct pfru_update_cap_info cap_hdr = {};
 	struct pfru_device *pfru_dev = to_pfru_dev(file);
 	void __user *p = (void __user *)arg;
 	u32 rev;
-- 
2.39.5 (Apple Git-154)

