Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C235AC10
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325214; cv=none; b=naLdk56DRQRr6dYX3wWy13Xtahp/YF/HISKfQphhfaKI9erC+cK1BYtvV9RgrXlA5Vd/HGTEIlSkk2wbzpEO/Kxn7Ra5Jw5d1yhepE3w1I4ziefZYCO2vq5Ixa95kimPFBAFhwz0xqnpXrPdLAX4ar4Sn8quj6rB3GiHNxbS7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325214; c=relaxed/simple;
	bh=Pic0moyP9gkFj+xomz5pzQBFq7RdZoFhicDe5u5BLnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odCP9q1WaqmvCvk6mCDIxeWxlqNqTezNC5ztG0n3UEaGVC7BUJEh8073oBpOzBHw5k1nXn2ldzXLsOQJhrDAPZ8+whdsbcqjlHmzDt9fPzHpa3lJ5w+0az67Ct9ivuAdTHPBH3WApVM86ECM5XEWi6NkmQJZXTzzaYc3DkEihAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBP1iLwj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBP1iLwj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE8B1F00893;
	Mon,  1 Jun 2026 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780325213;
	bh=NVTYJGY8Qgoedop3jmBOH7Wz/Ar6/adcqjiOPjCk20s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eBP1iLwjCYGZ63TUuJyu2r5EUEbL/W8wDo7yhrZ8racrFCOLhthIiZnzS/AOd5Vbr
	 FMNzfkN691EzRvWbOkc46w/PTIRBsrcw+Yy8i6LAhE1quEy2WfIg0O7TyWJ0++QkDe
	 P4v+y9xoU0S9sPDED+UtpJgXcgYK2gvVJcp9mEFQ9+w8Nn4aCpAWgmzxS5+HlZIwKL
	 DHPf1PecEG7ifHqtM4rv958WfuTyHfjF/cEOaGnHnK85+TK0PjM/Br0diQizPTt5aM
	 1gI0xqfyvOJy6cXsNTceuyCxaGD9oxkwkz8quekX60VB4c+v9ovT3YThJii4K28MhE
	 cvtk+IHJsdNyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
Date: Mon,  1 Jun 2026 10:46:51 -0400
Message-ID: <20260601144651.887662-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052823-finalize-overprice-3c30@gregkh>
References: <2026052823-finalize-overprice-3c30@gregkh>
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
index 2c4d94cc87294..3c786c4c1b213 100644
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

