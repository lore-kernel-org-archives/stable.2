Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4B374A0D
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990949; cv=none; b=oRmxGPaCnRP3SFhq1CgmiNoDPybQkLNJnYJTohRqM96xne+gLqbK/wjWiIfzKg3qcVA/DSOB2gTn1FHuQqpEqJdDihf0G/AC5ERUxkJQhc1c9crA0EYWe85iS3HOetijw85w07mFG2Xxm6jVAlC5q9oFIVoAB9ThiQ5VAJYK7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990949; c=relaxed/simple;
	bh=RIun3CTewN6YQNwQff089fZvm5G2LmNg86JPd42Vc0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOmf7WtFwmitMR92a5OX1sdmm1MFMj5MXnQ5DA9LNlRZtlWNjjI7G/AtQvq4Ao1fruP6uWiNcyJuhtVj3KvmZe2Qo7puH/qoShn32KfyvGaxul3ttS2FRzEcwEkWs8Tru9T1TL0vIOINQwVas4tMFTqms2pi+jGuZGk2+EYjygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNSM0oyw; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNSM0oyw"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6c4a867cso230478785a.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786990942; x=1787595742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/J5Ku7TUMPFkncTWiaJAkFB/DQoyY+kfM1udqiEm5g=;
        b=NNSM0oywmUPr4uXMqYbzULNHPKnkzeG1npY5XpgoJCI76H2SPKpgDE7lcejQe1xY8Y
         CEG3PuByt3ws0oM0O3+WFkXtUgoOeTh6Dydpov0XTa2t2rPd/3kkDpK2RzyhbEv9GJuk
         0kpTx0rBp/r6gbTbbd86hMTUMjRRlluR1PsDVEyV3idro5EohVqjulwQ/cmFf76Vr1xF
         nC5l4MgePYX0UyI2KFeqKxINnt4/6eDgUPWhYkXipu1qSA1oa2WXGGSsYGWDv5Yqgqhy
         yDyEXoLLMSLBRwDiBOLg2eINyktcbmexnYT8wKVIY7GUWStFoXXQEyqxJolgeEDTl7hL
         qVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786990942; x=1787595742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/J5Ku7TUMPFkncTWiaJAkFB/DQoyY+kfM1udqiEm5g=;
        b=NdJpxOHrl0EB7yfn+Wm8dNzg7LFysaG6UBOte8f1oc9tBPLFFnz8B+XMfibC82R9dU
         fYCa9vKxmRAazj2yd5WnfcPXa5m5MpTZ/9889UUf2ZS0tiU0PISX64ncsfTyulCRrdM1
         Zj+0sv09NmPJD7FgMLR925ZY3DGW5tC/5Rgep9Jo5ZwFrX0Q2nQhGXKL9Rio6+1FtK7i
         FCuD2dvlUzEYtylwxudCjDGH2EbcFXE5c7ba7eyYVs8P5A4m1i9sS98jDvvD5wUcpkoO
         4cTQ3GRpwEkEWbKjRXZZJzT9XRtmC/Q/isBDLtGsbvk+m8z9Igrih9UGz8qYyzS4jcdu
         LoRg==
X-Forwarded-Encrypted: i=1; AHgh+RrF/IwnS1dHC783XzBgHJpw5W52KenzL0a3APHugiLC5c6Y14frXULRBziSBH+/JPRQSMwUshs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypfYd8jchmRdr5ic/9YZCjkCaw7l++Ex9yIhRyZqA7fu83+5hD
	NTqJUpV6+Si8NM0HOrlAYuO6tJMguo8gXrF0r2zOXhaKher69tRJ8/vi
X-Gm-Gg: AR+sD10qxNH0AohNkbSTslMhM3kivecZhIQyNJ8JB3rj0jqu8czhDexBNtOr2TmkH0E
	Ol5oHKgrMeFh5fJL0tlVkGuuOgZ29KYtIpR0NNlUOaBR7w8RYEJ01suuDZnyRpzPlOmCaUc+/BH
	RHmy+oWLqF5ele6wHH+oog/W/ulJjVFOOaPD+QT2ZoTtAn0aJXoCaokOP7mYyx2khAf89vCztLe
	yPgDTU5OurYO9UX0S2qckQathoSlGKqWK1vaXdniAdCX2mb5xbv0zDIHbhcOPgZty4k2agSUyRA
	EEuGXqHXskh7c8BZeeAoDTpembgoElS5LGkRU2CRpCWIolzO6XP0qDXpGSLbtUoWXdf2B7+E5z6
	LWmXl0b42/EMheIuqz+qOb7cqlygdluuTt/y3Gys1zWP70i0D65tljCxreTwbaDoOpllCImL3+9
	/5wgcEq2/oZHcvI0UFBZJ6SKRGE5HW17hNWNtk9Atj7FN9bENQOi+6+3zAJe+QvE0+Wb8Qnaui0
	rYiZoP7iy4bvzstt6E=
X-Received: by 2002:a05:620a:800b:b0:936:41fe:2351 with SMTP id af79cd13be357-936d22e74f3mr3151285685a.30.1786990942348;
        Mon, 17 Aug 2026 11:22:22 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033cd8a7sm104563185a.28.2026.08.17.11.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 11:22:22 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4 - reject concurrent firmware updates
Date: Mon, 17 Aug 2026 14:22:04 -0400
Message-ID: <20260817182205.906592-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The update_fw sysfs store callback can execute concurrently. Each
invocation runs rmi_firmware_update(), which tears down and rebuilds the
RMI function list.

If two writes overlap, both rmi_free_function_list() calls can walk the
same list and select the same rmi_function entry. One invocation can delete
and unregister the entry while the other still uses its iterator's fn
pointer, resulting in use-after-free or list corruption. This was
reproduced as list_del corruption in rmi_free_function_list().

Firmware flashing is an exclusive operation, and running a second update
concurrently has no useful semantics. Add a per-device update_mutex and
try to acquire it immediately before starting the update. Return -EBUSY if
another update is already active, and hold the mutex until the update has
completed so their function-list teardown cannot overlap.

The status attribute does not acquire update_mutex, so update_fw_status can
still be polled while an update is running.

Fixes: 29fd0ec2bdbe ("Input: synaptics-rmi4 - add support for F34 device reflash")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 1 +
 drivers/input/rmi4/rmi_f34.c    | 8 +++++---
 include/linux/rmi.h             | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..3a5cb17e938f 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1218,6 +1218,7 @@ static int rmi_driver_probe(struct device *dev)
 
 	mutex_init(&data->irq_mutex);
 	mutex_init(&data->enabled_mutex);
+	mutex_init(&data->update_mutex);
 
 	retval = rmi_probe_interrupts(data);
 	if (retval)
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index f1947f03b06a..04f12165cab0 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -468,13 +468,15 @@ static ssize_t rmi_driver_update_fw_store(struct device *dev,
 	if (error)
 		return error;
 
+	if (!mutex_trylock(&data->update_mutex))
+		return -EBUSY;
+
 	dev_info(dev, "Flashing %s\n", fw_name);
 
 	error = rmi_firmware_update(data, fw);
-	if (error)
-		return error;
 
-	return count;
+	mutex_unlock(&data->update_mutex);
+	return error ?: count;
 }
 
 static DEVICE_ATTR(update_fw, 0200, NULL, rmi_driver_update_fw_store);
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index ab7eea01ab42..d56c23240868 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -340,6 +340,7 @@ struct rmi_driver_data {
 
 	struct rmi_function *f01_container;
 	struct rmi_function *f34_container;
+	struct mutex update_mutex;
 	bool bootloader_mode;
 
 	int num_of_irq_regs;
-- 
2.43.0

