Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82231A683D
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318193; cv=none; b=fZVr22ovcqYnIH5a+cKNhPjmg7Cvlf7QvVv2JM+kTHWmWG56fglS1usesnZCr7gkBuH51/PNkAafCMv8Mk37ZlbULsjqssYRhHcGPagYaA0nZLeAvTBXlwN4P9dg4krem8MiL7BfN6jJHizCfOsjc+6a2+Jmr1msyNuAWtV1ldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318193; c=relaxed/simple;
	bh=+lYGb4+b0w8GwYp/G3TBEJqntPg7krben7s3Uub1FF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kj+NfHwv9fe2qxb7hM39ynXs6rvj306RjXzGDvsgJGBHoXZgKvrfLvh0/Wqd6hg0fty9PPVfFkR5LCA/6SaWnuJxLz7GaC3UduTiPSBCzIPkSrF9zIM5gzeOYMZVPqU6hDNApl9kaVwB0tpQorDGnm7ygGioC5EQmzyAiYmc9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIPduLGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIPduLGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110581F00898;
	Mon,  1 Jun 2026 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780318192;
	bh=+FRhqR9v4KLDe+3m+Be/TtbDq0LmDlvDNNY2gzlEQTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dIPduLGWwr84WJw2SAKhxfLRTDlbGLgmHUqUOM4mYYlNLF+U6MD9dX2doj7hmGWiH
	 Ifekc8ZcziU3BzrOUrXidF1rPxaMq1DQoy0JFZfSLrwTHcl8Bf7cjjOoic357/yTJ5
	 8CKcslc1bswa3JwuulgHHsoT4FU5Z7LjZ1AYkMNRAqDPnVuF4f371yf1H5HiVe8p4F
	 uGqIcU/IQK//yPxWHFRcEnSHou8WEL0zKxBu+tcyfsUalF9imQftGhwNqB7C/erlIg
	 jI6ubKQMH0YNLlmirDCLboWKzW20QEEpYTsUMWwZ7cU6M9HTuxL7JPHD9wYoPVrVu0
	 cagmN7dZAyTsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
Date: Mon,  1 Jun 2026 08:49:49 -0400
Message-ID: <20260601124949.768588-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601124949.768588-1-sashal@kernel.org>
References: <2026052823-ending-creation-bc11@gregkh>
 <20260601124949.768588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

[ Upstream commit 4e4af55aaca7f6d7673d5f9889ad0529db86a048 ]

adm1266_state_read() backs the sequencer_state debugfs entry and
issues an i2c_smbus_read_word_data(client, ADM1266_READ_STATE)
against the device without taking pmbus_lock.  pmbus_core holds
pmbus_lock around its own multi-transaction sequences (notably the
"set PAGE, then read paged register" pattern used by hwmon
attributes), so an unlocked debugfs reader can land between a PAGE
write and the subsequent paged read in another thread.  READ_STATE
itself is not paged, so it cannot corrupt PAGE in flight, but the
same defensive serialisation that applies to the GPIO accessors
applies here: any direct device access from outside pmbus_core
should be ordered with respect to pmbus_core's own.

Take pmbus_lock at the top of adm1266_state_read() via the
scope-based guard().

Fixes: ed1ff457e187 ("hwmon: (pmbus/adm1266) add debugfs for states")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-8-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1266.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index d90f8f80be8e0..84e01acb0796d 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -322,6 +322,7 @@ static int adm1266_state_read(struct seq_file *s, void *pdata)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	guard(pmbus_lock)(client);
 	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

