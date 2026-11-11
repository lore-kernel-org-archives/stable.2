Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366300;
	b=GVrp/k7HtqWY9kV0ENPB4gKIMUGmWCFdD27b/odIBS2NS8or7LMSuhXHWzC9cM3xPzfS
	 oX9WSeIQMjaV5tz0GdiP66yJhERgMzLC8sBiF44vSDRKUNfa+3ieLnx4Y4e2gLkjZ+F8l
	 rxk6Hn8etaDZWh5BmGMLYnmBpanbRYFFTSKyNZtPeMuXvJDZVZhoLVH1yBaGG0AjnZnML
	 N65lCr1q2Ysmyzfnhiwa0GUr9+Mf2mX1fpL/J8t8aXbd6P5PVl5OeBjzgJu2VZMZZ1gQZ
	 JDR3hFOfbCeEv9OOZZ9zi+c0ZzpVXuw4H+c1ImaGVQu+yXvgrnRvlag0jzWeCBeWTlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366300;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V7xL64F7ENOD1ed0aKq1/5/EzDq4nXkAV81dTlrpKMk=;
	b=jX+iTmrDyqfgiFlTD7gZ/NZK05NEimpG8GgK2WXw8iAm+sXqyngdLUJMm/GhqLaK1fMX
	 YB5Pnc1964lm/OlFnDkAj+Pv28XOgAaO86ek44U49+yD8IvH7Y2Uzmwfti7mqFYLULRYn
	 m9DMWX0yumz77qOy2YSkM3MYQ0BHwJ8EOuLocYb9CLiwdKkWKt9KTwxNIXm0ChcuSnFtg
	 9hIvHEMAyl23Vws8wdLDSRokJ4fDdojZqvYgZqJ3drKTw8lrzitVW1bmd0VoGokIAIC4y
	 1G5mzssyp/uFykIC0/zufZ/4dKm3FhJWmZfZyrwhXY3AUnOXHzyW12TPNyv9F54ZEZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1XXX32M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5E606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1XXX32M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85B41F0089F;
	Wed, 11 Nov 2026 03:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366299;
	bh=V7xL64F7ENOD1ed0aKq1/5/EzDq4nXkAV81dTlrpKMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N1XXX32M0FcY/Dv+WuRFvu/C40gAVNXjGSV3fY1CkJEcvB+GEMYNgufYAqCm8yP4a
	 sKesuD2jbQrjq2eVBTB1daplIaUdFlGrHkqCIqzaaoXVovLXJPOCp5VcjTWIWV5gQ5
	 i+OkFjd66yq+CUPNrIghYzbq3ijha78SP9HR8tuhq62gp7Uld1QPB95A0nZgiBnriq
	 u2ADDXQVbdsb1DLtPQ2kmjyRwn+XZto73ULzLRJVHIU99JakwAAt85fs/rx2TJTuOY
	 Qj+6CjJH/gzWlo+VO0ftpFJKUXs0ek0MgBPOMLNR/wDqll8/bH0llXz90y5Gue3hxe
	 wV7InSw7GtdMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] i2c: acpi: Add i2c_acpi_new_device_by_fwnode() function
Date: Tue, 10 Nov 2026 22:04:56 -0500
Message-ID: <20261111030452.828799-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061046-failed-5.15-a65917d0a22f@kernel.org>
References: <20261107061046-failed-5.15-a65917d0a22f@kernel.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit c537be0bfad6337f2afd618fe252c03217191405 ]

Change i2c_acpi_new_device() into i2c_acpi_new_device_by_fwnode() and
add a static inline wrapper providing the old i2c_acpi_new_device()
behavior.

This is necessary because in some cases we may only have access
to the fwnode / acpi_device and not to the matching physical-node
struct device *.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20211203102857.44539-4-hdegoede@redhat.com
Stable-dep-of: a65917d0a22f ("i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-acpi.c | 17 +++++++++++------
 include/linux/i2c.h         | 17 +++++++++++++----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 93bd78137ea67..1ee80ada212c3 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -501,8 +501,8 @@ struct notifier_block i2c_acpi_notifier = {
 };
 
 /**
- * i2c_acpi_new_device - Create i2c-client for the Nth I2cSerialBus resource
- * @dev:     Device owning the ACPI resources to get the client from
+ * i2c_acpi_new_device_by_fwnode - Create i2c-client for the Nth I2cSerialBus resource
+ * @fwnode:  fwnode with the ACPI resources to get the client from
  * @index:   Index of ACPI resource to get
  * @info:    describes the I2C device; note this is modified (addr gets set)
  * Context: can sleep
@@ -518,15 +518,20 @@ struct notifier_block i2c_acpi_notifier = {
  * Returns a pointer to the new i2c-client, or error pointer in case of failure.
  * Specifically, -EPROBE_DEFER is returned if the adapter is not found.
  */
-struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
-				       struct i2c_board_info *info)
+struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
+						 int index,
+						 struct i2c_board_info *info)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct i2c_acpi_lookup lookup;
 	struct i2c_adapter *adapter;
+	struct acpi_device *adev;
 	LIST_HEAD(resource_list);
 	int ret;
 
+	adev = to_acpi_device_node(fwnode);
+	if (!adev)
+		return ERR_PTR(-ENODEV);
+
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.info = info;
 	lookup.device_handle = acpi_device_handle(adev);
@@ -548,7 +553,7 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 
 	return i2c_new_client_device(adapter, info);
 }
-EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
+EXPORT_SYMBOL_GPL(i2c_acpi_new_device_by_fwnode);
 
 #ifdef CONFIG_ACPI_I2C_OPREGION
 static int acpi_gsb_i2c_read_bytes(struct i2c_client *client,
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b115fb9e2071e..7910dad637d44 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -1038,8 +1038,9 @@ bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
 			       struct acpi_resource_i2c_serialbus **i2c);
 int i2c_acpi_client_count(struct acpi_device *adev);
 u32 i2c_acpi_find_bus_speed(struct device *dev);
-struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
-				       struct i2c_board_info *info);
+struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
+						 int index,
+						 struct i2c_board_info *info);
 struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle);
 #else
 static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
@@ -1055,8 +1056,9 @@ static inline u32 i2c_acpi_find_bus_speed(struct device *dev)
 {
 	return 0;
 }
-static inline struct i2c_client *i2c_acpi_new_device(struct device *dev,
-					int index, struct i2c_board_info *info)
+static inline struct i2c_client *i2c_acpi_new_device_by_fwnode(
+					struct fwnode_handle *fwnode, int index,
+					struct i2c_board_info *info)
 {
 	return ERR_PTR(-ENODEV);
 }
@@ -1066,4 +1068,11 @@ static inline struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle ha
 }
 #endif /* CONFIG_ACPI */
 
+static inline struct i2c_client *i2c_acpi_new_device(struct device *dev,
+						     int index,
+						     struct i2c_board_info *info)
+{
+	return i2c_acpi_new_device_by_fwnode(dev_fwnode(dev), index, info);
+}
+
 #endif /* _LINUX_I2C_H */
-- 
2.53.0

