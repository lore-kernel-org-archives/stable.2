Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D43A5437E0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953309; cv=none; b=AfKe/W5y7kJ4DnW+eJWQdHUYFwDL9TonapDy/7dT7EyhjgTQsEjyt7IqdLdknAt9KL+4Dc7zzFdol82gaB5HdpsS363SDnMljkEHvbYogTOqIGyoov7cUHehZoaY5RWXndJ1UqjRGj7XI0ZGyjcnlGPYYm8zp+xEL210KXDpS4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953309; c=relaxed/simple;
	bh=v//3Wu0vJ6yjzu+Dden6t17sQTkRc37oQc5CdgbE0Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpcoOYbvRcpEfozC0V/ipUltM8BslzayvCGxbpowgL0QTRN/XSWbbyhutVT0OE/SN3Xyt+Jm3e+Qb7DVYGKaY5We5TUdeCrAHAzL7/VxOm960s6lrBaDffEuO1jkE1+0opa+wQZ8okwMu5eKZzQW53WklGKJ/t73bg0hWoOnsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF15+8OI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF15+8OI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCE51F00A3E;
	Wed,  9 Sep 2026 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953307;
	bh=9hmiVPyIu2E866JIlrljSUd8IPRN35JcPcLPNF3/a9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lF15+8OIyH0Bbh4XJeoDFU02SqL4dHnda+gJxKFZxpG2zogK/HY2cZ46ihRN+d8/h
	 I8HSmNVI1pWi5LMG55rhHoT4BOqvMqOK7r1Y1vAzhoFInjxa5lUlejgQlSy0OV+YtP
	 N+MSTPes9LSsOdztcGp+LWsxX8/MkK/0+diJGm/cLE4QPIQKjnBs3M6R3mglIFU4EI
	 +WbDIsI7gUTGdFmMNK7GXvws1/BCfDAC3PNEOkCSmxR/uTv/BRkjW3YuleYwT55Oju
	 NAiY0EKgelYX34yTOJAxymSKEcvkQfcDzGjR/NbKN1BhxrstQbhbPFGvIpgyzzzfZ0
	 OX4vuDQBpcvCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Angel Iglesias <ang.iglesiasg@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] i2c: core: Introduce i2c_client_get_device_id helper function
Date: Wed,  9 Sep 2026 07:28:22 -0400
Message-ID: <20260909112824.1848482-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090306-rabid-rug-adb0@gregkh>
References: <2026090306-rabid-rug-adb0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Angel Iglesias <ang.iglesiasg@gmail.com>

[ Upstream commit 662233731d66cf41e7494e532e702849c8ce18f3 ]

Introduces new helper function to aid in .probe_new() refactors. In order
to use existing i2c_get_device_id() on the probe callback, the device
match table needs to be accessible in that function, which would require
bigger refactors in some drivers using the deprecated .probe callback.

This issue was discussed in more detail in the IIO mailing list.

Link: https://lore.kernel.org/all/20221023132302.911644-11-u.kleine-koenig@pengutronix.de/
Suggested-by: Nuno Sá <noname.nuno@gmail.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 4e4b9f5ce9df ("power: supply: max17040: drop incorrect I2C functionality check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 14 ++++++++++++++
 include/linux/i2c.h         |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 2fa62d3ec43f6..feb3fd331584d 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2222,6 +2222,20 @@ int i2c_get_device_id(const struct i2c_client *client,
 }
 EXPORT_SYMBOL_GPL(i2c_get_device_id);
 
+/**
+ * i2c_client_get_device_id - get the driver match table entry of a device
+ * @client: the device to query. The device must be bound to a driver
+ *
+ * Returns a pointer to the matching entry if found, NULL otherwise.
+ */
+const struct i2c_device_id *i2c_client_get_device_id(const struct i2c_client *client)
+{
+	const struct i2c_driver *drv = to_i2c_driver(client->dev.driver);
+
+	return i2c_match_id(drv->id_table, client);
+}
+EXPORT_SYMBOL_GPL(i2c_client_get_device_id);
+
 /* ----------------------------------------------------
  * the i2c address scanning function
  * Will not work for 10-bit addresses!
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 63476bcf955d5..93eacd3844d19 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -183,6 +183,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 					      u8 *values);
 int i2c_get_device_id(const struct i2c_client *client,
 		      struct i2c_device_identity *id);
+const struct i2c_device_id *i2c_client_get_device_id(const struct i2c_client *client);
 #endif /* I2C */
 
 /**
-- 
2.53.0

