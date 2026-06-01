Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35EFC0A
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331323; cv=none; b=W4e2M++hs0CEj9HlLT/C5xsGHMq6wWNOpKOOpKK6kUx4ofMd+mW34HBCuXYFMXwHSMWGcPTOFR1prsd9kaQmPeayjdStWftZ92J0gLOuOWS6Mi7qFhEGeTqRkb+Pqhx1YReEvjWIFBqJ85RBtqCY2eLTnjKr/w816+RIPgj4yRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331323; c=relaxed/simple;
	bh=vMB9nqdepz9PuoG3rORS4P7lcGDwHX7QFEfkp8aEgmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtcHJ7m9quGfzXnsoUzppCBjTUoSen+95ByaNMJCnjAP7/tdTgKEPk7hT6HNw09uzINBGszhQ3TlvZlPzy7GnT/H8dgD6Remw3d8SMXOFX4GTEGO6+d2vRIN7nQ2BE2jJzdMEdjJ39+K3QLyO1Am9/hNTpp2gBe7Vl1w7suCAkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H234OQb5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H234OQb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496441F00893;
	Mon,  1 Jun 2026 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780331322;
	bh=IvqPvXwqT50fnG3ohbmG2N7mKO5I5hHtWHA5f8Um0NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H234OQb5F8rPHKAxarmFnHrZ1MGLmRe9dO3f65+uXTHrWClLOyFqiiwydXdZbGCV6
	 FlSyYjGIcNnxs0EpV2WRt7TblWSP34KPEdj80XXaQ1EmSuu0v/pEbRr4Kct5APpItT
	 GSbDtbSCjTRkMXm68wMJo40CDDbwens3Lp2dxu9jXR5mEkiag3N8JS7lbqxMMWahoT
	 7RyixjRiY1nxToais6GXExcBfg20uws/Tbyqtj6izEdHzTgVRvMvlRfjoZJ2zyBKmr
	 IrFxhYycOLN/yn6O17kqXwPb/QFZ3Fh+rNQmqjfeWfC4VQuS6AkgeE6Ys1M2o/PrI+
	 FnQ5bjLJixy7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock
Date: Mon,  1 Jun 2026 12:28:40 -0400
Message-ID: <20260601162840.975891-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052830-wiry-canon-b819@gregkh>
References: <2026052830-wiry-canon-b819@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

[ Upstream commit 9f1dd8f9491eb840cbea7ffdf4cad031e25f8ae0 ]

adm1266_nvmem_read() is the reg_read callback the NVMEM core invokes
when userspace reads /sys/bus/nvmem/devices/.../nvmem on this chip.
On the first byte of every read it does a memset of data->dev_mem,
walks the device blackbox through adm1266_nvmem_read_blackbox()
(which issues a chain of PMBus block transactions), and then memcpys
the refreshed buffer out to userspace.  None of that runs under
pmbus_lock today.

Two consequences:

  - The PMBus traffic the refresh issues is not serialised against
    pmbus_core's own multi-step PAGE+register sequences.  A paged
    hwmon attribute read from another thread can land between a
    PAGE write and the paged read in either direction and corrupt
    one side's view of the device state machine.

  - The NVMEM core does not serialise concurrent reg_read calls, so
    two userspace readers racing at offset 0 can interleave the
    memset of data->dev_mem with another reader's
    adm1266_nvmem_read_blackbox() refill or memcpy out, returning
    torn data to userspace.

Take pmbus_lock at the top of adm1266_nvmem_read() via the
scope-based guard().  Patch 5 of this series moves
adm1266_config_nvmem() past pmbus_do_probe() so the lock is
guaranteed to be live before the callback is reachable from
userspace.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-7-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ changed `guard(pmbus_lock)(data->client)` to explicit `pmbus_lock_interruptible()`/`pmbus_unlock()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1266.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 2c4d94cc872943..69ec25d6f48dac 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -383,18 +383,25 @@ static int adm1266_nvmem_read(void *priv, unsigned int offset, void *val, size_t
 	if (offset + bytes > data->nvmem_config.size)
 		return -EINVAL;
 
+	ret = pmbus_lock_interruptible(data->client);
+	if (ret)
+		return ret;
+
 	if (offset == 0) {
 		memset(data->dev_mem, 0, data->nvmem_config.size);
 
 		ret = adm1266_nvmem_read_blackbox(data, data->dev_mem);
 		if (ret) {
 			dev_err(&data->client->dev, "Could not read blackbox!");
+			pmbus_unlock(data->client);
 			return ret;
 		}
 	}
 
 	memcpy(val, data->dev_mem + offset, bytes);
 
+	pmbus_unlock(data->client);
+
 	return 0;
 }
 
-- 
2.53.0

