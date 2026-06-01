Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E751DF75B
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331297; cv=none; b=KCOJC0hz0jwJMiXq0KshXYVyIy3yjUCG+qRlbdyq3ncsFvax8YMmfWNkOt7QCzdcDGsmSy0zl+iMbwRl1xd2NcxfG/rS8/b6EZQBKXihSayAgzn18xxYvz/uZWDYq5GmjVYtNwKPUGF4OPWsv58xcNYYuYqLLVqIf+yypJ4iQDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331297; c=relaxed/simple;
	bh=vlSRJkR8EG1S4ORTsuGw1RE2oZOCs70pSIj3NZG3LCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwWw9HKmkc3tjsFQC6+9MOmV5YyVjF9L3y823o4xATAqj9pTHCJ/3qgrrFVjI8bK6n/dV0cxsA0Lnzfnf48YBMazFKjHd7EhYdDxmdMWDHV9jSUaCnxXz71WRNxCfNfRO5HgHrGFEgdYdA1gX8f+qG5r76I8jlDkiwLDXMgYCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ+Lp2AI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ+Lp2AI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0391F00898;
	Mon,  1 Jun 2026 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780331296;
	bh=1tlrttXUA6qo8Nrk6Ojgq1G7MK0WIDquM6tuYXTkWdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DZ+Lp2AI2KxCijCob7syWVV8ISYMpzEWecUsSlaq2oUBhAMMVZDxMjRva5D7L8Byg
	 kDurHolLdRmqh3scuNUFm0wUOYdhraIoLgw2P7YxyxLApI79SZLHbwXiXOzKKWNc9F
	 Wnrx+gth9saSK7NMAm4e+YqJOxvn809AKQv+5cyn6vp6Lj6iDaBqnAfkxANALI15da
	 7PU6LkA96jU1aY8F97IM5/Pil8vm8TDEhzVpEILfnEJpGoXf2Z53uVHes+XJfbN8jZ
	 5I86lRrdBHYag/o54nxy+rVKNukD8NQix35jukoWLTsFgGKlr5SoATDg1FtsJxMZ87
	 xz+Q0kq3t8dfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
Date: Mon,  1 Jun 2026 12:28:14 -0400
Message-ID: <20260601162814.975302-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052854-glamorous-tabby-2e68@gregkh>
References: <2026052854-glamorous-tabby-2e68@gregkh>
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
[ replaced `guard(pmbus_lock)(client)` with manual `pmbus_lock_interruptible()`/`pmbus_unlock()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1266.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index ed0a7b9fae4bf2..1986ba48e59147 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -322,7 +322,12 @@ static int adm1266_state_read(struct seq_file *s, void *pdata)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	ret = pmbus_lock_interruptible(client);
+	if (ret)
+		return ret;
+
 	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
+	pmbus_unlock(client);
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

