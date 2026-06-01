Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C2342C8B
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320991; cv=none; b=MuFsVPWcn8foV9mUyP5HbsZZVxYxE87VegD62d3zup2J6tju+qzHK6YTbPIblyx3NQJPBRZe1beX9AC8lSMhZSrpk5B2O4unzhHVWyZlbTYvES0Nbq3QqXTi//NYWBHI7HJUhqLziuFH0BeMWIRH6aCp5bZ4qLexs7EZ6tbGZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320991; c=relaxed/simple;
	bh=cmblam7K6agUgq7vkJIUslSVCxej/Wx3+QRq6TsEys4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO+lTeDBoATrhgo15P1xRdecZ2CBcHVWuM4fjJqGKu4DXrXKMK2oTJFsPeilT6IHUAr4BliR2su28vwq1+eCV1ZvcPfsp3kRBZspM8SU8xpNC1J03RP53WtHnp0hSbucyqINaPzSpZ2rAjPnk8BFAv0A05sHzWKqEdKlxe85qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNg6G6vy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNg6G6vy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6B31F00899;
	Mon,  1 Jun 2026 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780320989;
	bh=M5Fpqfuw+65m/Q26Pg3TH3AWZSD9AXENG6vyJ8/QjAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aNg6G6vy0I2Vq6BIlurfQkpjsDZXlYNWgaLuCafyJshitDS5TIIsK2SQLRZf1kwwM
	 9eS2EUURMD+ae3j6rnrc4dUuMqAm5yKsr//Ou+YVxKzumeEintAFZv/et9KJXx6yJb
	 fthwbMaOhbYwRSK1Fa5gYjP2XoUV1Ac06cYcOom3yYS6V7cjU4XVVX8VIsISboWTYs
	 ryntN1JrbhK+7kCsubEAbi6wm31lTGdIkvFaBFYnQw+BgH+1iwtav4oLQQAGQYDylf
	 RpgkPh8YhWMN1+83MUqpCDYh0h9wH/28kMffLQj6ohzPtbdt8CraAU+ckk/fpHXSuE
	 LKsrRs+Kd3N9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/2] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock
Date: Mon,  1 Jun 2026 09:36:27 -0400
Message-ID: <20260601133627.790087-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601133627.790087-1-sashal@kernel.org>
References: <2026052829-nutshell-shank-d239@gregkh>
 <20260601133627.790087-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1266.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index d90f8f80be8e0..3efa704410538 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -383,6 +383,8 @@ static int adm1266_nvmem_read(void *priv, unsigned int offset, void *val, size_t
 	if (offset + bytes > data->nvmem_config.size)
 		return -EINVAL;
 
+	guard(pmbus_lock)(data->client);
+
 	if (offset == 0) {
 		memset(data->dev_mem, 0, data->nvmem_config.size);
 
-- 
2.53.0

