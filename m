Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38303538D75
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952892; cv=none; b=bhxgJoPyYYj4jyh2s2fcftyoERqq7jpFs5YDihMLKWa69pUq8IGyxAgs6kRisfoM/EN1FSZ+uXARs/11iRXUP3iVqsEyEsnxzxAkX4zLqPbniGhfEvDZkoBB4pHlT1jm1/XTnqes5vX3A9C6Fyys6SMECr+HRfna3D+6IbosKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952892; c=relaxed/simple;
	bh=7Ad/IJ43p+Y8D8WEG1Y4gUIcS7hGujUsGyKgvZTYiPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjcDdjnWNv0GUSgALYXkZkFHuIcMBBBF6V244MYlDLt6GTl6vig74B8ifhdez/0h1tHgVh4/Qn8fuYOKvrASD3kh/yqxOPP6DpDLFRtWeX/uQS1MODPd/7GsE2qhUueftl9ZblycIv1Ni6JUPUd6Zx/6VIHV+EOq9IXKMqpd5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqSnTLlQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqSnTLlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418831F00A3A;
	Wed,  9 Sep 2026 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952891;
	bh=riBlDQcwHw2iAX6xGivEoZZyGli9BQFEE9lkLevK1ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OqSnTLlQld2XGD2QgyQBk2D53Hsy4s4mnyhig9J16wrNQlNN02U84OPFEb0MlOUP/
	 M0CWMqhD/sK1yWdmTtKy/j8PtobMbZnZjVdi49okkT/JEDSKjmDCo1nQ8z/xp1/UkK
	 IQNNdWu72grWCXBBw1RCRSAVgY9dTrhEkEsXgzGAq/7H5kQDs5ttJ+4j2eChyKrB8E
	 29dUScYNzO0ttj1DkO7QBo5rdPV59XiVyIecAvzY31qTlBdowJe1umjTZGF757kdDK
	 NKIq0MDc7S9gobzLUQAZ+Ks7YoxhpAmaXPYag38vcjG7+TY6wxJEGj3mz82S/nOiFC
	 IW2OrFor9tjpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Angel Iglesias <ang.iglesiasg@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] i2c: core: Introduce i2c_client_get_device_id helper function
Date: Wed,  9 Sep 2026 07:21:26 -0400
Message-ID: <20260909112128.1815387-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-streak-absinthe-62ae@gregkh>
References: <2026090305-streak-absinthe-62ae@gregkh>
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
index becb95a753289..46c9a4dde6160 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2423,6 +2423,20 @@ int i2c_get_device_id(const struct i2c_client *client,
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
index 996886f187a1e..b115fb9e2071e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -188,6 +188,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 					      u8 *values);
 int i2c_get_device_id(const struct i2c_client *client,
 		      struct i2c_device_identity *id);
+const struct i2c_device_id *i2c_client_get_device_id(const struct i2c_client *client);
 #endif /* I2C */
 
 /**
-- 
2.53.0

