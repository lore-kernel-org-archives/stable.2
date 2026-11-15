Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794729753;
	b=n8xCwamyrHsjvS7asWNjWCNBYa6YRuQnxvY7Ihz9Kmyb2FYeJELN8DpYycxcI/3Lr59U
	 Kq9YSW/uasiU0vR/3z9RC/Ww7Co5lDgVgJxvxXQUxuqgjqwAqJsEjLXXc31SLQrkeYWx2
	 2chLRVobLoS56PJRa6BIcbAcBf6Xy6ngHzdaTU37nrFM+cFqeyMmSewpI8ZUkD1Uyp+DO
	 67p/YqXYftEMY9F+vwimamo7LkQac3HIuiZVZpVlZBAahI8aBVWBcw0OdyMIu8q8+dF3y
	 crYJ9RIF5ByAi8VbzwhjwAc9Qv8RHu7X/EXcuFxuycNM4xh/ZauS2tFDykMVKKK9IPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794729753;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=qIBe1IptJdEw3mbiQ59WdvqMuyWgbSIYKmhp3SuEzqE=;
	b=NQ4NOSDGKhbKmM1LCvc2psNmpKnbDr44veKAsmV+C2M9A1lt/XkOZ7Glna/kprqvQ82I
	 xsOQGI3Xyn99RWAmThfQTQhP/KbMA7gENvbwxem0lG5T1oWNGp9iagx0WJPfWXuXMRUnU
	 z/kyx72DCzhP4Cld23yYGLxqKztle0Tc9qtD/7eb087HofWMWOMWm9m9TNZDpOmrU3uUW
	 l0tBV/yuth7Tlqbx/5yUqmuGLUa6PdNDZr6xtq3hhXCAwttp10KwrEv5qV8shfXnHmmD+
	 h0ETAFcNTktqW8Gbag0Lvls9hf3A4Xuu9Kg5/Lz6h1HIJkSElLANRS0tcoJuO2E1/kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=f2xM5+4A;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0D606A31D;
	Sun, 15 Nov 2026 08:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D0D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=f2xM5+4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qI
	Be1IptJdEw3mbiQ59WdvqMuyWgbSIYKmhp3SuEzqE=; b=f2xM5+4ADtDFI9vSU+
	2yFfp/aOFvBszez/p+L2uEIq5gSEeuEpy3MoQVXH4qmZq/lZY/cjiO3S2uKdMNcD
	JV5bYTQxI08Q67bM2NsTOo+P5LBmMhA4PZ0y2a3tEUwbrTAqbQdPtwXsZAe7YKil
	cTCbpHF2OV8SxPc21gm4USON4=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v4f8ZvlqxKXvHg--.43707S5;
	Sun, 15 Nov 2026 16:02:07 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (w83792d) Fix incorrect struct cast in show_temp1() and store_temp1()
Date: Sun, 15 Nov 2026 16:02:03 +0800
Message-ID: <20261115080203.910033-4-zihengw03@163.com>
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
X-CM-TRANSID:_____wD3v4f8ZvlqxKXvHg--.43707S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWUuw4rurWfWw15JF47Arb_yoW5AF4kpF
	WkGaySk3ykGrs7WrW7Za1Dua4Ygr1rCay5Grn0kw1Skr1UJas7Jas8Jayjvw1ayrs8AFW8
	Gr4qqryUWFWkZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bxfOwUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7h-xQmr5Zv+hiQAA3g

On big-endian architectures, accessing the temp1_max and temp1_max_hyst
sysfs attributes in the w83792d hardware monitoring driver uses a huge
out-of-bounds index, because show_temp1() and store_temp1() downcast the
attribute to the wrong struct.

The driver defines the temp1_* attributes with SENSOR_DEVICE_ATTR_2(),
which initializes them as struct sensor_device_attribute_2 (where the
index is an 8-bit u8). The temp1_input attribute has index 0, temp1_max
has index 1 and temp1_max_hyst has index 2. However, show_temp1() and
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

Fixes: 1f8dae31fe8d ("[PATCH] hwmon: w83792d use arrays of attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/hwmon/w83792d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 2de6d7b68..cba907713 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -487,7 +487,7 @@ store_fan_div(struct device *dev, struct device_attribute *attr,
 static ssize_t show_temp1(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	struct sensor_device_attribute_2 *sensor_attr = to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp1[nr]));
@@ -496,7 +496,7 @@ static ssize_t show_temp1(struct device *dev, struct device_attribute *attr,
 static ssize_t store_temp1(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	struct sensor_device_attribute_2 *sensor_attr = to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-- 
2.43.0

