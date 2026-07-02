Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88264C041A;
	Thu,  2 Jul 2026 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985771; cv=none; b=nAPFn2adCLKv5OB5GJxr+bj632/+2bk/xTLnYkU7K9wyPz9Olhii1XnE735OhNq0MyjfSc2ZOuNbrrQCGbggk3tQBH563Nax+UaalwfOiTYFo/6e9JO/nIloEnuQam8j2wksFu8iezbt83qFv3iUpG19RSiA4Ggp7skkXGs7k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985771; c=relaxed/simple;
	bh=3i5/LWLWW3Rqle6cRjzHCMePj95ny0D2rF2NUyEhHFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+ZUYcpXKtDkjc69wWm3C93eHJ9COcwQx7orx6XvgzkLL8p92Tr3L1+i2kkNAobfq9vFRSnG4ZQcZ3zAbSSFUrDVpQWiix2FdEj2Yeu3UB5DMtlvU1o5CA2ZnX5I2lZGuh56z74Fyeq6tYuK2QlS9mxYpBT1oEFhvRJXuGOwh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P9G5L+sj; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P9G5L+sj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4X
	vYjbnz2GRhhBFeon4xtt6EZrOzuLJ+X5mwMWF6YN8=; b=P9G5L+sjGZWY9VmtU9
	uWcKPb8ZxeXdxW2jCsfGuY4DHEjsWWe2DcQ/i+7kr91If38acQMjuJFbV8dXGg84
	3JSrRNa4YOTVd3DftBKQkC1si5ewUWIP0vbij0+JkIJKp7sMbBEpzuNdnXP7Lo2e
	ArJDG5DTLHresVfQdaPPRncho=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3D1QJNEZqmQaAHQ--.59490S4;
	Thu, 02 Jul 2026 17:49:04 +0800 (CST)
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
Subject: [PATCH v2 2/2] HID: sensor: custom: Fix field sysfs group cleanup on failure
Date: Thu,  2 Jul 2026 17:48:56 +0800
Message-Id: <20260702094856.1105555-3-haoxiang_li2024@163.com>
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
X-CM-TRANSID:_____wD3D1QJNEZqmQaAHQ--.59490S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF15tr47JFWrXF1xGr15Jwb_yoW5WrW8pa
	4qyr9xWr15Gw17A3yUAFZIq3W0gr4ruFy8XrnrW3savr13Ar97try8ta4jvFWYkFW7Gw1D
	JF4UZ3sxCFyqgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMyxRUUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RE9q2pGNBEvCAAA3E

hid_sensor_custom_add_attributes() creates one sysfs group for each
custom sensor field. If sysfs_create_group() fails after some groups
have already been created, the function returns the error without
removing the previously created groups. Add a local unwind path to
remove the groups that were already created.

Create the field attributes before exposing enable_sensor, so the
failure path can free sensor_inst->fields without leaving enable_sensor
able to access power_state or report_state pointers into that array.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/hid/hid-sensor-custom.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index d7bdbae96b50..ea98088e5112 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -609,7 +609,7 @@ static int hid_sensor_custom_add_attributes(struct hid_sensor_custom
 					 &sensor_inst->fields[i].
 					 hid_custom_attribute_group);
 		if (ret)
-			break;
+			goto err_remove_groups;
 
 		/* For power or report field store indexes */
 		if (sensor_inst->fields[i].attribute.attrib_id ==
@@ -621,6 +621,13 @@ static int hid_sensor_custom_add_attributes(struct hid_sensor_custom
 	}
 
 	return ret;
+
+err_remove_groups:
+	while (--i >= 0)
+		sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
+				   &sensor_inst->fields[i].hid_custom_attribute_group);
+	kfree(sensor_inst->fields);
+	return ret;
 }
 
 static void hid_sensor_custom_remove_attributes(struct hid_sensor_custom *
@@ -1005,26 +1012,26 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
-				 &enable_sensor_attr_group);
+	ret = hid_sensor_custom_add_attributes(sensor_inst);
 	if (ret)
 		goto err_remove_callback;
 
-	ret = hid_sensor_custom_add_attributes(sensor_inst);
+	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
+				 &enable_sensor_attr_group);
 	if (ret)
-		goto err_remove_group;
+		goto err_remove_attributes;
 
 	ret = hid_sensor_custom_dev_if_add(sensor_inst);
 	if (ret)
-		goto err_remove_attributes;
+		goto err_remove_group;
 
 	return 0;
 
-err_remove_attributes:
-	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_group:
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
+err_remove_attributes:
+	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_callback:
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 
-- 
2.25.1

