Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794729757;
	b=G8m1QuxHsk9xjUAvEKNTJHO4oTb05I2yqFnpL3+/wx0Bi9P0S48etlp1q5qH1xyF5NU/
	 1BexxTXPuV0ziV0PctaWlxHP9BZu8H1SdXmw0gxb5IUfaoHRAaU0Vcg3OPbcjfZMS98rE
	 K6CaYdyQr0ULBWHILgQD5jSF73SDUE5lCKpsRVRnJthHU2MZuW2I2pbKMJ1DScG1tHUuw
	 Zgf/cTLgSxMdtGFEVcg3ylFT+/0UFQLhf7ajiJnt5jOrzE72rWvkT7jhzoqMRod4bW377
	 wMGKeiLIQ0B1yV42O3E/Go6rlvdl8ZkJARetl/Ttq0Hk38JBYo3ZCfPS7RH9DrRwiDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794729757;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ZxrorjMF9l4wU2ezTb6rLOBDaUR1RrkpTkZgpgmuxl8=;
	b=U9fu1y6f8yNZ/y3AJMbgK4GV3MFhIcalo2Code8nbJGrtcDGhSJZiacLG4XOt++/g9bT
	 K5ofZqn2hvjFCIbKfJ4Kt+yfbHZbdxMf4TNf04pRAKT+w1DNfT6zWBL4BXdHeyfpr3vRR
	 QQ9vNUnvzuW3lTOyaafmse70xFN/kl/HhR1wquEaqJm9o5YmvNi0q5VG6NVgp5p1gtqfX
	 iaY9cwtna2Cw7MmAN1o21/uIVWDOaD52nmNYMWQloNhVnNeNEvI5TR1uI/87ITmuUpWWz
	 iPBQ3cN2NFtqY7BhB8AGx/oQ1jV+KsBlEV5F4Dn1jyLSoPyCqzn0g3nypcCrhIALkZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PFD5OK1Z;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299F606A8AB;
	Sun, 15 Nov 2026 08:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9299F606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PFD5OK1Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Zx
	rorjMF9l4wU2ezTb6rLOBDaUR1RrkpTkZgpgmuxl8=; b=PFD5OK1ZIwkz21PHI3
	9s520MzodjHwq7O6fYCn1l/k5rsOZfbWkyWW7daSgX3E1rElBNbFYwk6YSXlxYoo
	o7FAteL6Ya6Mej673g8zy0MJEXlajtl8iQP5xsKHOWdEkBAwXUb8g4fPOY8AqPe/
	0CLFSiSzEQvj6Bk+h8XEQ1h5o=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v4f8ZvlqxKXvHg--.43707S3;
	Sun, 15 Nov 2026 16:02:06 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (nct6775) Fix incorrect struct cast in beep callbacks
Date: Sun, 15 Nov 2026 16:02:01 +0800
Message-ID: <20261115080203.910033-2-zihengw03@163.com>
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
X-CM-TRANSID:_____wD3v4f8ZvlqxKXvHg--.43707S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1rZFyDJF47KFWxJr1kXwb_yoW5Xr1rpF
	WDCayFyrWDGas7WrWUAa17u3Wa9r1rAw1fWrnxKw1Skr15C3srXFyUG3WjqwnIyFs5AFy7
	tryqqryxGa95JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bbdb8UUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7R7xQmr5Zv6qCAAA3p

On big-endian architectures, writing the in[1-*]_beep, fan[1-*]_beep
and temp[1-*]_beep sysfs attributes in the nct6775 hardware monitoring
driver always changes channel 0 due to an incorrect struct downcast in
the beep store callbacks.

The driver defines these sysfs attributes using SENSOR_TEMPLATE(),
which initializes them as struct sensor_device_attribute (where the
index is a 32-bit int). However, the sysfs store callbacks
nct6775_store_beep() and store_temp_beep() incorrectly downcast the
attribute to a struct sensor_device_attribute_2 (where the index is
an 8-bit u8).

Because both structs start with struct device_attribute,
container_of() resolves to the same base address. On big-endian
architectures, reading the 8-bit index field from the memory layout
of a 32-bit int fetches the most significant byte (which is 0),
rather than the intended channel number.

This type mismatch causes all beep writes to change the beep setting
of channel 0, regardless of which channel the user targeted.

Fix the type casts in the two store callbacks.

Not runtime-tested: the only big-endian machine available to me (s390x
under QEMU) cannot build the platform driver (no HAS_IOPORT).

Fixes: 30846993047b ("hwmon: (nct6775) Add support for beep attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/hwmon/nct6775-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 6e97e4f08..d423f058f 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1859,7 +1859,7 @@ EXPORT_SYMBOL_GPL(nct6775_show_beep);
 ssize_t
 nct6775_store_beep(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int nr = data->BEEP_BITS[sattr->index];
 	int regindex = nr >> 3;
@@ -1913,7 +1913,7 @@ static ssize_t
 store_temp_beep(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int nr, bit, regindex;
 	unsigned long val;
-- 
2.43.0

