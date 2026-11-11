Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366860;
	b=M9mUthCCISSPeI4SQY53IK+q6QLu2BnsYmzhIXQ+1IXyKJYFQa2UC+ULC2eGoq31WiqN
	 3ISlKOJZaJjrh38a6sdd7nJF2ZZlaXuulmsH0uxkPepHfg86vuPZToEZQVwNIzRi7e+9A
	 4vvkTlIwslHuIIvE3Gv7lIZ+l5lNFWyGu8qqUqRm6MXQUm9bH49egQ5DlF0Lv0qzOfmcr
	 Q1d6K1UVg7+GCmJ0I5LLgYKVRgVA6K79T1Z0avr4zY4qtIXQpE49NJN4RwdaVoa0314EG
	 nWLYukRqdKjYXj+4hFBHdoIuYcw3HsvVmtWCA9/Zb+57LgIDaOtfG4VZjNEeLM8ybAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366860;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=k6rlZ2WiDqk0pIUbf9ubitWXJk5orv/Nuk4Uj0oTmoc=;
	b=t9vBLM8Fa9ObNlwbyFmFF1BDIWKpR/cNt8yyaio6qDZgFFpn4mIXIYJJqw+HYWIZyM9o
	 KUONjJGGnsknS2G/sha/PZMbxTA7Cz0LS4bMeS+f1Fq9B6PvD9d9c4LPoa83RDSqGv+Q2
	 5nBBrGYa9/lvRRV6sCXp7d2unLZtogSUoSRh8yvd2W+65/TsKSDYcTAlAZfVB0DDZPLX5
	 I/U05vi4guBMJx6A5cRzatREmL6ALe1WyRXo2dNCH0/1DdGq6rqmjq0qkC9PsBjzQIZ2i
	 vvutpqZmcmUoK55/ykzPwmHF5mPKATNIfUuLGmeiyjPS76WYT48WHdcQSiiffDPmZ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sqs1I/Yv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463C606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sqs1I/Yv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A651F0089F;
	Wed, 11 Nov 2026 03:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366860;
	bh=k6rlZ2WiDqk0pIUbf9ubitWXJk5orv/Nuk4Uj0oTmoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sqs1I/YvN7GFRs30h4wWjtycBvnz9eHOnDtbteOmq15Z2K6AwsMfej3+uIQeG9ODr
	 kPjjpkE6XT5ob9f9l4Qdt9jpcz4n7KFNE9isI0tSUisznY0PItcQpfl9aq/vMq8X6G
	 wZd6hsTV9Puhq4jGperoDu1Fi0Rs6OA7+K7mO64S59IDSgAvgeoxY2es3A2By5Pxwq
	 Y4UOi8Tc6ZX1vfTGY0zHtPuiWt6EC4TgFEkaxx/fUIh6qMkXYbpxjFkXHe0/8KeTDp
	 qiKHHZkFtG99M4L1LfQTHX0d6Glp3uKV3OnZlQ+AlF0l0D0+DNHTm/zGma3K2r05y3
	 J7vHDXASWogcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] i2c: acpi: Add i2c_acpi_new_device_by_fwnode() function
Date: Tue, 10 Nov 2026 22:14:17 -0500
Message-ID: <20261111031403.856886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062755-failed-5.10-a65917d0a22f@kernel.org>
References: <20261107062755-failed-5.10-a65917d0a22f@kernel.org>
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
index 2f180862dbec9..6f8532ccea850 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -473,8 +473,8 @@ struct notifier_block i2c_acpi_notifier = {
 };
 
 /**
- * i2c_acpi_new_device - Create i2c-client for the Nth I2cSerialBus resource
- * @dev:     Device owning the ACPI resources to get the client from
+ * i2c_acpi_new_device_by_fwnode - Create i2c-client for the Nth I2cSerialBus resource
+ * @fwnode:  fwnode with the ACPI resources to get the client from
  * @index:   Index of ACPI resource to get
  * @info:    describes the I2C device; note this is modified (addr gets set)
  * Context: can sleep
@@ -490,15 +490,20 @@ struct notifier_block i2c_acpi_notifier = {
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
@@ -520,7 +525,7 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 
 	return i2c_new_client_device(adapter, info);
 }
-EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
+EXPORT_SYMBOL_GPL(i2c_acpi_new_device_by_fwnode);
 
 #ifdef CONFIG_ACPI_I2C_OPREGION
 static int acpi_gsb_i2c_read_bytes(struct i2c_client *client,
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 93eacd3844d19..a10a7072b583d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -998,8 +998,9 @@ struct acpi_resource_i2c_serialbus;
 bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
 			       struct acpi_resource_i2c_serialbus **i2c);
 u32 i2c_acpi_find_bus_speed(struct device *dev);
-struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
-				       struct i2c_board_info *info);
+struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
+						 int index,
+						 struct i2c_board_info *info);
 struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle);
 #else
 static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
@@ -1011,8 +1012,9 @@ static inline u32 i2c_acpi_find_bus_speed(struct device *dev)
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
@@ -1022,4 +1024,11 @@ static inline struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle ha
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

