Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EEB363C53
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321887; cv=none; b=h+VZmCg7GEauQLacQZsWr/JccXlL1CkbyU0i3sUR/Pqa11JCbeAaFkwL47U+/+VQz3O7SN7FCGCN4Y5K5oSfhB8/6COCtmPu89b6TDiz75xCdZ3atOOxscNk1E2k38BHVquWYU9OpYNJKQgd+L3SKersWh9HHi6jqOE6Jbr9GmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321887; c=relaxed/simple;
	bh=cmblam7K6agUgq7vkJIUslSVCxej/Wx3+QRq6TsEys4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnWTBO/8fopkG2AIoD1Yp0EevtssZr85oFk/N3oA5XAIdfAu+/Yv/y3+W6xSntYi4TeAnSZA84Qx940v1UTFOEBBkMb+n1YNWqMGkVMPgRR9cuzawYRBC2lzrsBDWx0Q/0MTvBip07x5xDByGDboaGpQ8qJD7kKhbbyPpjV2j8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URPS9OFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URPS9OFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260021F00898;
	Mon,  1 Jun 2026 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780321886;
	bh=M5Fpqfuw+65m/Q26Pg3TH3AWZSD9AXENG6vyJ8/QjAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=URPS9OFPkWzK2kmpiBJM0EhKJzkm4LQu3Y8bess27V31LC6OfEpjXaJf4zbweLj/5
	 shCkBFIxEVNk3Rj5cAO1N3WnggRR62l1XQEPPkf79Wo6LVG4/XiEWzHjG7Zy2C1zQ2
	 ms4+JZ6G0pyyfuMUmbkOSn90I4dlSKEX3ote1GaoZijWcfOpxLeFBE70nb8OzenlpE
	 V7DCVjJ6QURXaULXtKFqOIHnpaiQplDz2hDRDMoyNqL/Tojmkvdpk+m7LlD+FpPJYt
	 nx1qD1eJStiw7uuF4IUo8UJ5Y/y2o7WNguook20TIY3VmrZVIZ6WJBs2go2l6Z1Wbl
	 xrNH4Ztn4tu/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock
Date: Mon,  1 Jun 2026 09:51:23 -0400
Message-ID: <20260601135123.797428-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601135123.797428-1-sashal@kernel.org>
References: <2026052830-amicably-spoon-d982@gregkh>
 <20260601135123.797428-1-sashal@kernel.org>
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

