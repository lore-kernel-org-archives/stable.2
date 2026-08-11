Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11788430309
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443725; cv=none; b=K7TyED6yCPlm4+aSuY2+80aWXtYJW/xDRJYc9jJyzDJlBnnGYAJ81t5YstHMHOMT9s2v+ClaUUkqTdX8gmKvE8XrI7yz9+Evdf8DtjJfiNbz9pvt3YcXv6BMVcBRSNJBiboVGjA/0m8ZJAI9iT5e9Fxxri3fPhGxIQ7xDrZh8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443725; c=relaxed/simple;
	bh=3w7qdREcKF013xDNyNPF3fGwxZf1uoEpkhlXnxCwLgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o0+PNWbuRa+gmjxaACTVAPeY/oNTWdcg/dfIaSe8920u+QNIggLo6GWQKOAQ2B7BnNFyqTNV+q6nO65foeNmy1G5MUT8+VucngjNwJsgaAh6Wr9vl1QjVWf0z8aihLAQmbosl20ylKefqKn2yO2YKvAD/eEY0cWAboav4A70YBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2d313798bf8so3450105ad.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 03:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443719; x=1787048519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTYjZBZGMPVvD7fTKHpg8PYeoZCfwS/aHmI9q8GSv60=;
        b=KOklME2TRYvNEzq6LUyfi5N7uTnqUpNf15PeoUc3OPqoNa/zSUJmDN8dLaT34eF85n
         r9BAGcSDR+O1jzVtEeo8zgmGy1DsGiqTbMQtHaW7cK+xr6VSEiVV2iOcW/Ws28mwpz0l
         Uv614XhdDryXLE4zhVBd2lgxBxv+DdMzSc+leguXjHgc94XEoj4vHPyB20fQSKPmEBMb
         HQUUanfaflfgJrRt/9gOyAeLwaBdiUWZvxLewn6UeSObtvTuVEU8XYQY0nl3U5rchBRW
         FXhEbr0wnhRsO5Cs00CWaZ80uzmOeZOBbf/DxHZHulzFlxE5c/BpPZaF41i2IxDKlnTJ
         7dJg==
X-Forwarded-Encrypted: i=1; AHgh+RrU7nY+Jsjq20QYJaBNuyNaN7MebVwJ6Fpf8hLqrxiT7Ovx0+k5q6jUfdd92nt1qe+Sij5QuO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEiZbvu9GdmJPm0ihcwD0Ek5kQ9Mm27g+YT1zkhX12pyF24prC
	/IqCJkORhTtrjoIOmz3vUKWzhh0kFAzbsLYrnIi0QmC2SnZu7wD72zfA+KS3eeZt
X-Gm-Gg: AR+sD11UoNIvC/2140GJSuVIilfHNMafmFbGKRwGZWwgXM9uEniDnVtUEQGwY0eOu1y
	cgHDbipN/34KX3L618kkskj5Wtk86mXRLFQ/zeWuOETxC2yl53WOwmmNJpUBD0RvQaOSp/P4a9b
	OxyoV7f0vf5lX71Xy6b0PekwAffvN27qydLSwBnzFCkkWkdYt8kEg8o6/rwEOdEKjiwnzRgIjN6
	TX+q2GoskcrLWMVfbMOCIlregMQMTfHcHP7Cr556JkhFYNpvijxTP3RHC0np4qkYL6qbVcBSb7O
	bIQbwvaAHKx9yibKjzjSEwqs4qivf0UA4HYq/skFOUTjy6LwXvtMS437CXG2sU+PKXOLF3EiZ14
	mbuAjbgyMewB986HAxo765OT78q/OkaXKb67IeQ8E2/45axXSsia79eQj6oWZrKJaBXLID1/2Gm
	r+Vng/CGIqYipSK/8QwNU7Io0LYvjEbzVxdQ4KcZZ6ZtrC8NAI/OOgsXV0dqApnZ6lgwn4cHaPp
	UuG3/KcGA==
X-Received: by 2002:a17:902:d488:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d3177a2163mr23058195ad.9.1786443718684;
        Tue, 11 Aug 2026 03:21:58 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef0a79sm5221975ad.9.2026.08.11.03.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:21:58 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: W_Armin@gmx.de
Cc: ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: wmi: Add ACPI_COMPANION() NULL check in parse_wdg
Date: Tue, 11 Aug 2026 18:21:28 +0800
Message-ID: <20260811102128.1027805-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL check for ACPI_COMPANION() in parse_wdg() to prevent NULL
pointer dereference when driver_override matches a device without
ACPI companion.

Same issue as CVE-2026-64227.

Fixes: 4186a47dbfbc ("platform/x86: wmi: Decouple probe deferring from wmi_block_list")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: stable@vger.kernel.org
---
 drivers/platform/wmi/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
index 529825dcfbfe..151b712d08b5 100644
--- a/drivers/platform/wmi/core.c
+++ b/drivers/platform/wmi/core.c
@@ -1290,7 +1290,7 @@ static int wmi_add_device(struct platform_device *pdev, struct wmi_device *wdev)
  */
 static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
 	const struct guid_block *gblock;
 	bool event_data_available;
@@ -1300,6 +1300,10 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
 	u32 i, total;
 	int retval;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
 	if (ACPI_FAILURE(status))
 		return -ENXIO;
-- 
2.43.0

