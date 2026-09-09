Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5E352C3F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952584; cv=none; b=IVhjxSOxkX6MZ6PWZ9x5N4Vq2EkcGf/VlYrv08c5DwrLnedj4lRNBtcY6SkrWGZTa2UPlq0+O9cHzcRBe1EbOVavueqpkCjSlvJ+B4q0OJySzBASdY5MIxNGvbzdR0pwenB5t2wnqcw/k2c2UN9zhZUpbRwrZAZsJ8vEN0Snk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952584; c=relaxed/simple;
	bh=SDD/0eCFkgAYl4UaLvZqf+uxhk4IikzE8IA9F0XLOr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YikYQe+MQG9MIOWJUkovo4VqFEUr+0KwRPCRw3UXvygi46GvJs6R/s9VfQ6fM2agHrK0G/UXIXD9V4lO5r1x7q2D/V/v43+flPxSRStLl1Qj6MvWnuzc6QdH0cLf5l5Sxl3PTLcwjtcJiF05Rn/nqbydaa6wDYkquaYQ5iQbaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2Jb6w5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2Jb6w5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D2E1F00A3A;
	Wed,  9 Sep 2026 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952581;
	bh=q/lrbWun38x9PtYIXrx+jHRBr9sNN28ZZ7ZdtezEaTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V2Jb6w5QVyxdmJs/ben7BSRTriNhDB/LYZTcDVfUNvU147JKmepTNLEfsSc9RYw8B
	 f8muwHEBYUbcCpT6Gjfy//vI1j540WEwiNUtbrom4V5L/PvV/cipzBWSc2ftdifo38
	 9NbpQHqRhXSA7ze2eZD2PIdkqCYPo/XPQA/9HlX1n7zDOUpwFNVzPT3bWqn7qGG2vb
	 xuwHpjg9riGsFSHtRmLfV19sZ2zzhRp+/LjTCwS5n/OGUGpX2XQ9huouyGwxxN7XC5
	 5iwfQ1OsPalri4e/rkB67wgibWUDGklQ/iD+LtKHthXOyysZFupok1zv/lQXrIwFmE
	 uP11kLnRlCkpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Angel Iglesias <ang.iglesiasg@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] i2c: core: Introduce i2c_client_get_device_id helper function
Date: Wed,  9 Sep 2026 07:16:16 -0400
Message-ID: <20260909111618.1798847-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-skinhead-nursing-7dcb@gregkh>
References: <2026090305-skinhead-nursing-7dcb@gregkh>
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
index ade12c0b1006c..588424db22a22 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2426,6 +2426,20 @@ int i2c_get_device_id(const struct i2c_client *client,
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
index 87b403a6d7e41..60c5bc674dcce 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -189,6 +189,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 					      u8 *values);
 int i2c_get_device_id(const struct i2c_client *client,
 		      struct i2c_device_identity *id);
+const struct i2c_device_id *i2c_client_get_device_id(const struct i2c_client *client);
 #endif /* I2C */
 
 /**
-- 
2.53.0

