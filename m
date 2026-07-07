Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32FE37C109;
	Tue,  7 Jul 2026 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408582; cv=none; b=vF7TyTAZOAad9rXxG2SDIXGmY+ee7OqjgUzWBx/8OeD2HkV8Spb1tSvGN4sh8uPICwHNdP2iCIhdrXQkPPaJ9QonaS9QeSyhrKEWd6wM6DHBqWDONZNl8zs2ib1K6a76ocbh5J+s1U1BW7ZpC/aM9XOY4PNJbXMErqK4xbuOENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408582; c=relaxed/simple;
	bh=tS8xW4ACW7vQCCwps22aNMeLPdTivzNwbzURsLhXz9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RugOMkpEYc+JeX2Sfv9wrB6oUZsU6Gcz9aWKLuxpzlSWt4iHS2D+dr9VKPsVpzPJGT0CZzUuySL71jk/hStRWBMcuWa1z+cSUGX2LxFC95dRp6fOOfTV/lPuRo67c0YrEMyd/D26qtjRvnk4G6yPqIYKqu9fStmt5WjrBYkh8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U2iP0/WD; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U2iP0/WD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Z2
	0YYvDoeUgCrjGuuLr/pDFpGrufeVTIJSYak3iZmRc=; b=U2iP0/WDcxpUXdCn/G
	nl8vYQHIyIbyfDOzepGC7ewqIQVsw/19RjgTM7DIKIk5/RzSmiI6XiSkTmv+DJDH
	JGGWOWbhMMTmFH1rk/qaxmvJyMOAL1G5/ugoxxPK5smc3rqB9MJyty6jHkwQJCIO
	p0G/er4lSH9nBDkDSDpOvDRgU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3n5Cqp0xq6RclIA--.54200S3;
	Tue, 07 Jul 2026 15:15:56 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	Sashiko AI Review <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] HID: sensor: custom: Fix use-after-free in enable_sensor
Date: Tue,  7 Jul 2026 15:15:44 +0800
Message-Id: <20260707071545.3087073-2-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260707071545.3087073-1-haoxiang_li2024@163.com>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n5Cqp0xq6RclIA--.54200S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW8WFWUtFykZFyDCF47XFb_yoW5Wr1rpF
	90yFWSgr1UGa47J347AFsrX3W0gr4rWF18WrnrW3s3ZF15Ar97try8Ja40vayYyFWDK3WU
	Ja1DXas8uFyqgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR0Ap5UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QzCMWpMp6w9sQAA3z

enable_sensor_store() can call set_power_report_state(), which
dereferences sensor_inst->power_state and sensor_inst->report_state.
These pointers refer to entries in sensor_inst->fields.

Create the field attributes before exposing the enable_sensor sysfs
attribute, so enable_sensor cannot be accessed before the state it
depends on has been initialized.

On remove, delete enable_sensor before freeing the field attributes,
so a concurrent sysfs write cannot dereference freed memory through
power_state or report_state.

Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260623021950.1736413-1-haoxiang_li2024@163.com?part=1
Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/hid/hid-sensor-custom.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index afffea894021..6b0da2e0e1c9 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -1005,26 +1005,26 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
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
 
@@ -1042,9 +1042,10 @@ static void hid_sensor_custom_remove(struct platform_device *pdev)
 	}
 
 	hid_sensor_custom_dev_if_remove(sensor_inst);
-	hid_sensor_custom_remove_attributes(sensor_inst);
+	/* Remove enable_sensor first as it uses fields via power_state/report_state. */
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
+	hid_sensor_custom_remove_attributes(sensor_inst);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 }
 
-- 
2.25.1

