Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E952571C7;
	Tue,  7 Jul 2026 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408580; cv=none; b=q5nnmukELe0gHbUd5cq88d9f5uu+VxPPgiiTcgCNtkbAGoaxj5so60DvJ3T9Sc63FMYYkbwEHOAqp5DfxHs/O1/qfPrOOmLo1jUUcWhXuJ6vK9VU3u0z0fhSDYVgfcFTz4q4eTyHYInH4Q/p4+Q9XH3QivyWUbObQ311VInbXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408580; c=relaxed/simple;
	bh=9iYGYo8BFDTF/QUSdKYO1SoNXZcnSmCCIrTK3bPFQx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZm7psT6dtcYiFyrSccD5j9xpWbqpnCsiEF7+1Sz+Cso3fj1dABtKuDoRh2+M60eYhstDNC4q+wl7KNoDkZOAx+BnYrRuo2lzcM5EVK7wu47H6xJkcaEnW43MCjNS+8P9CXpg2L+wkXh/MHunM//MmJvAtKCfl9P4jz7uB+H/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EF4X55G0; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EF4X55G0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=u+
	2/VUW4IsKT0dYVPV3nE5ThTJ69hnJuuoGgat3USWo=; b=EF4X55G0WFJWElLHMK
	ojo9p9YLFc5QBlsTsCzJWe4rloF0S/nnyAuZ0/H/+v+cMvjpxYGFkrp0SfXjfA1N
	QhLjWlOL5dHxnfSpPjqKmsWoghgZ8aInTMsjJte3o+/Owp4u7IrcIDLeD0EF57Mr
	S6/uzMPYMna3eb/NtUMn0by60=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3n5Cqp0xq6RclIA--.54200S4;
	Tue, 07 Jul 2026 15:15:57 +0800 (CST)
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
Subject: [PATCH v3 2/2] HID: sensor: custom: Fix field sysfs group cleanup on failure
Date: Tue,  7 Jul 2026 15:15:45 +0800
Message-Id: <20260707071545.3087073-3-haoxiang_li2024@163.com>
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
X-CM-TRANSID:_____wD3n5Cqp0xq6RclIA--.54200S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1UAryDWFWDAw1UZFyrJFb_yoW8ArW5pa
	9ayr9xuw17Kw17AayUJFZIqay8Kr4rZFy8JrnrW3savr15Cry7Kry8ta4jvayUCFW7KryD
	tF4UZ3sxCF90gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMyxRUUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxQ3CMWpMp62apQAA3o

hid_sensor_custom_add_attributes() creates one sysfs group for each
custom sensor field. If sysfs_create_group() fails after some groups
have already been created, the function returns the error without
removing the previously created groups.

Add a local unwind path to remove the groups that were already created.
With enable_sensor exposed only after the field attributes are ready,
this path can free sensor_inst->fields without leaving enable_sensor
able to access pointers into that array.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/hid/hid-sensor-custom.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 6b0da2e0e1c9..c2b425afd951 100644
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

