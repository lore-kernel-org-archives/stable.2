Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72413790B;
	Tue, 23 Jun 2026 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782181220; cv=none; b=siFZaqZ5ZEU9WNY18dnANtU0BQGRj/ndckiC0ZQFbSHJz+N6txedBp9zZZhHXak6YZ4BGdugjtk2FpPwb7j6XEj27OZX17Qr2hSuDTVrRc+BzJK9LskMKgHIkLbLATeEOZvqJzlFCZNFkasHhV+92MuCxhItc6h26t88Xw7kRnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782181220; c=relaxed/simple;
	bh=BEUQpRHR9mK6IVq3MvDAZOYspmRh+kgLMLqLrM3JujI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mQbHEtAC+0GTL4T5fD/6njwgdNfi4UFwPIH2M1mTBKdkNKtukk6LVqahgaGyJDABsdlRZz5/FfnlkE1vZEnn53lCt7yiJ2qrJby3HhOy2faCcsBhSroYIS7CPrMmHcaQhZ3r7Si3ForJuimsjXaVJPs6J2BnNZy9m305Ik3eC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xptokx2T; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xptokx2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=AA
	pBkoYfrLQj//pYQiYgj0Ho/WlpR8ZIJCg9xFcjyM8=; b=Xptokx2TfiFZ0j+UWb
	wzoTzwLYpDPrToMjFeZFr0nXkZS5faDUamGv2QyqfgpmTMJJb5S9UPws9/0z/SPz
	ur6QC/DU1pcqtdV0v5Xzyz+2jZREbFarHS5HMQiCsXBv4wVG6JlFdbNecaz+lKW4
	s8a6QiTweB8I+YPdYc/YknEdI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3n_5I7Tlqe3yTDw--.4746S2;
	Tue, 23 Jun 2026 10:19:53 +0800 (CST)
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
Subject: [PATCH] HID: hid-sensor-custom: Fix sysfs group leak on failure
Date: Tue, 23 Jun 2026 10:19:50 +0800
Message-Id: <20260623021950.1736413-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3n_5I7Tlqe3yTDw--.4746S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1UAryDWFWDAF1DCFW3Jrb_yoW8Ww18pa
	92yr9xuw13Gw17A3yUJFZ0qay8Kr4rZFy8XFZrW3savr15AryDKr1xta4jvrWUAFW7G3s7
	JF4jv3sxCa4qkr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piknY5UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Qp25Go57UpnqAAA3O

hid_sensor_custom_add_attributes() creates one sysfs group for each
custom sensor field. If sysfs_create_group() fails after some groups
have already been created, the function currently breaks out of the
loop and returns the error directly.

Fix this by adding a local unwind path when sysfs_create_group() fails.
The unwind path removes all sysfs groups that were successfully created
before the failure and frees sensor_inst->fields.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/hid/hid-sensor-custom.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index afffea894021..cd676516e6b0 100644
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
-- 
2.25.1

