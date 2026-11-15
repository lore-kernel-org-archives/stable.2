Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794729757;
	b=ku6NaRLm19VMJzlOJ54ILvWmblj+NEExr0cU+czkVJd5VEe+ab0RiXHcsExV7g4WvVKf
	 aYdNVLAtckq+VR7g0hogEsRHqZG8n52ctyPFm38cgH8tlDxGS219IQ24YxLiMqcaDZxIJ
	 X/d59t9JWv60REPs4Ji2tqRf+ov2jnWxyAhsbJzB+JcQJYrRnYXc1pW0hJ9TLPzV5caQT
	 cXjI69HjGKD8A+xZfgWWzLxM4veGyYTD5jy1/5WFOtfwqjx6uODOm9VXVqbOjfWvwsNRU
	 oSdh+5zOKIcf979guWTz6G960icZBFs+LFXKWR3oRpLk42TzNfeGwfIuUGK3q5cf+QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794729757;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bdU7br1gy9EV9/tYTrttX+aGuzCg7r+AtUPEfTqRJ1I=;
	b=NJ5uOAvcnBq8XvUvEIZZ+Xojp9RsB7ObY1DuHuC7KfXbz3EHmTgndnJ7KEGrJPY18Okd
	 wsazpKrH0f345XfBbUuQdQid7VrRImhBRpSKF/TFAF3nvPjR6u7KPqMnvxmnDihUlxTsU
	 IZZDm54aaEA5ZrMyRF9ajmIR1J1iqlGfWmAvn1fGXWJ1jDsRdYZdohGJAvCndGOfSF2Lp
	 Maunm/LyIJvkJWi6Tb+E0HlYkdQxTRb6FVRzCA3EMjusEt36fqEAy1yvxFTv69H/eKYjx
	 eQIGBQZzVgby2FVnuSJx/CKTHa6Szhk9pYDRY0YR1n7x95YKQdrMzOd3hDFvO9sVSxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oGuIwSj8;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC4606A8A2;
	Sun, 15 Nov 2026 08:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42EC4606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oGuIwSj8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bd
	U7br1gy9EV9/tYTrttX+aGuzCg7r+AtUPEfTqRJ1I=; b=oGuIwSj8cLH/BI2sqm
	wETADnFgke0N+zgCjtPdJAp4uoZNg9b7lM9PyBZZgianPHSOGRKAX+ZdHPHPcdL0
	Qq48ARHjVjoq8hRprNZ3+Uu6IWFn79dlTRYVM6NuWB7Pm1CHvkkP7UovJ7veorA+
	39l02JKXy4YhMg10oVuONXQL8=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v4f8ZvlqxKXvHg--.43707S4;
	Sun, 15 Nov 2026 16:02:07 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (w83791d) Fix incorrect struct cast in show_temp1() and store_temp1()
Date: Sun, 15 Nov 2026 16:02:02 +0800
Message-ID: <20261115080203.910033-3-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115080203.910033-1-zihengw03@163.com>
References: <20261115080203.910033-1-zihengw03@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v4f8ZvlqxKXvHg--.43707S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWUuw4rurWfWw15JF47Arb_yoW5AF1DpF
	WkGa4Fk3yDJws7WrW7Za17ua4Ygr18Cay3Gwn0kw1S9r1UJas7Jas8Ja1jvw13Aws8AFWk
	Jr1qvryUWayvvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07brsjUUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7h-xQmr5Zv+hegAA3T

On big-endian architectures, accessing the temp1_max and temp1_max_hyst
sysfs attributes in the w83791d hardware monitoring driver uses a huge
out-of-bounds index, because show_temp1() and store_temp1() downcast the
attribute to the wrong struct.

The driver defines the temp1_* attributes with SENSOR_ATTR_2(), which
initializes them as struct sensor_device_attribute_2 (where the index is
an 8-bit u8). The temp1_input attribute has index 0, temp1_max has
index 1 and temp1_max_hyst has index 2. However, show_temp1() and
store_temp1() downcast the attribute to struct sensor_device_attribute
(where the index is a 32-bit int) and use it to index data->temp1[].

Because both structs start with struct device_attribute, container_of()
resolves to the same base address, but the field widths differ. On
big-endian architectures, reading the 32-bit int from the memory layout
of the two u8 fields yields index << 24: 0x01000000 for temp1_max and
0x02000000 for temp1_max_hyst, instead of 1 and 2. data->temp1[] has
only 3 elements, so the access runs off the end of the array by up to
32 MiB.

Fix the type casts in show_temp1() and store_temp1().

Confirmed on a big-endian s390x QEMU guest with the driver bound to an
emulated chip: temp1_max and temp1_max_hyst read 0 instead of the
register values. Not tested on real hardware.

Fixes: 9873964d6eb2 ("[PATCH] HWMON: w83791d: New hardware monitoring driver for the Winbond W83791D")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/hwmon/w83791d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 8bb457326..530935a6d 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -924,7 +924,7 @@ static struct sensor_device_attribute sda_temp_tolerance[] = {
 static ssize_t show_temp1(struct device *dev, struct device_attribute *devattr,
 				char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct w83791d_data *data = w83791d_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp1[attr->index]));
 }
@@ -932,7 +932,7 @@ static ssize_t show_temp1(struct device *dev, struct device_attribute *devattr,
 static ssize_t store_temp1(struct device *dev, struct device_attribute *devattr,
 				const char *buf, size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83791d_data *data = i2c_get_clientdata(client);
 	int nr = attr->index;
-- 
2.43.0

