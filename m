Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94D4B8DF8;
	Thu,  2 Jul 2026 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985772; cv=none; b=aebLlSh73qLiewxyLCX8ot0Ugv6OzuLKLbr4tu7hYEtYSItRRWp86MDoOzfn3IWr3UcCTphvWrdtwAdV8ZFxgVSpJMTXURlTM/BOT9FduOjxNi0sc8jmBMd3ZXVEiJNWhySZ9oORPn0whClPvB9Vf0CP3q4PjDM0hiAnnt2d8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985772; c=relaxed/simple;
	bh=k30Tv5FeR59/l3wOor45xJbROdUxYoTixtK6TMbpeBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjRjuS6zdGo9cOXDeuK9HGHL+twTOim3XFjxOGJz5vH/LMumNo/rEyxDjNXnZ3Qn8oQtoWdrCImsOSfxXjXtM9OZPaksQ1RLa6le+S7GzEBvIqte7NqZBRLifeDaYDO0qvT0cOP3a+AvLkxj/mb614Y8LKVdGH03ncVAbzkicv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y2pCJIg9; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y2pCJIg9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rT
	vBQ/jvcMZYDpFXy5+pMy3ytTd9gnMw0J+Tn1uEkrk=; b=Y2pCJIg9ndocj0VUuf
	lRX6FO2CLF87PYkFeL70xnLbcvcTbqKxAANldQZBOjBG+RIsHuZyV+JxAWsjLm1T
	dxvkbECwCN4cvXgTfXI/kOX3nmvBLwufMBKawmP6CPoYfYboG29nw8cW1Vrf7XeP
	F8YHKyptuan9KlqplOIctu7OU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3D1QJNEZqmQaAHQ--.59490S3;
	Thu, 02 Jul 2026 17:49:02 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] HID: sensor: custom: Remove enable_sensor before freeing fields
Date: Thu,  2 Jul 2026 17:48:55 +0800
Message-Id: <20260702094856.1105555-2-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260702094856.1105555-1-haoxiang_li2024@163.com>
References: <20260702094856.1105555-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3D1QJNEZqmQaAHQ--.59490S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWrGFyrZw15CFyxKr48JFb_yoW8GF13pa
	sYyryIgw1UCF17Aw1jyFsrZ3W0gw4rXFy0gry7Wwn3ZF1YkryDKry5X3W0vayUAFWDKr17
	GrWvv3sxWa4DKrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zN2NtUUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxg48qmpGNA6YGgAA3K

enable_sensor_store() can call set_power_report_state(), which
dereferences sensor_inst->power_state and sensor_inst->report_state.
These pointers refer to entries in sensor_inst->fields.

hid_sensor_custom_remove() currently frees the field attributes before
removing the enable_sensor sysfs attribute, leaving a window where a
concurrent sysfs write can dereference freed memory.

Remove enable_sensor before freeing the field attributes.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/hid/hid-sensor-custom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index afffea894021..d7bdbae96b50 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -1042,9 +1042,9 @@ static void hid_sensor_custom_remove(struct platform_device *pdev)
 	}
 
 	hid_sensor_custom_dev_if_remove(sensor_inst);
-	hid_sensor_custom_remove_attributes(sensor_inst);
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
+	hid_sensor_custom_remove_attributes(sensor_inst);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 }
 
-- 
2.25.1

