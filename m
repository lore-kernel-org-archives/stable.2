Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1C8248B
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399110; cv=none; b=NtgLzFRTr/WT24O1TsajlADGWNQhGV1HodnFH4surcXcfnEkKLR1ijeHEyVmPjH81f7YQPc99SqtEN0wFDaS1gsJPwhZgFtByH+fh2nT+kwvqb3YaPSwkFjD1iXZDY2XrBZWWFxWHvpcL+OtsdI1H8TWWoyqk4yt/4RJiiiBB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399110; c=relaxed/simple;
	bh=kr7KOp1qE3yXrCDCS5SUTK5Q2Blq06QYsCAg/qbr+N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2D6l2KvifFNqlW49r/o8wOrRRQwPTQ/cRE9PXaQ4U/ubVEDnXeEEpWqb7MSoxhwN8EDeNNvy+tCJmi30rDs1IcIrTcEkw32L2mvKVU+UDjb5DlBvIwk8Pia/THIEye2HbnHVSksgsXCEETWU7q9hSFXZs8kX/91xGnetPKHZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/TnlJm+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/TnlJm+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85E41F00898;
	Tue,  2 Jun 2026 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780399107;
	bh=q3zw2w9lAwexKKQWE91f+PQx0foacpyzQu5XkZ0ON38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i/TnlJm+Vw0BukAxcauOcaQP9f8zoZROcTUpyL5OnCdf/9DUCeN+J+cLpec/X+zIA
	 TbCojF8cYMDBWQpO484ruqpTAdlK0QgCY6R+p9gF52KJRZCVuO0amead2T4hxBzNqK
	 3jGqa7d3iUWTvJTzqBkKjO4HKqi7yEZ2Xtp9e/ZRDonugXN6HXVV6CGRtpPprKxVHO
	 h1LWRQezWTl8K7dGNX9coACXxyXht5iovTWKPuDEFrIIibESHdxm6Z52GnCvrvV4P3
	 f1D2a7tfGVUNfpn1O4cKy4UJAvuc+umcRx+4sDqJ8LAuAz86Ot4XDPfp9G1//cRW2d
	 RMAQsnK5hXbxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock
Date: Tue,  2 Jun 2026 07:18:25 -0400
Message-ID: <20260602111825.1305810-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052847-broadcast-elevating-8bc4@gregkh>
References: <2026052847-broadcast-elevating-8bc4@gregkh>
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
[ adapted `guard(pmbus_lock)(data->client)` to manual `pmbus_lock_interruptible()`/`pmbus_unlock()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1266.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index a616439cecbf51..e265bfd93dd7c4 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -395,18 +395,25 @@ static int adm1266_nvmem_read(void *priv, unsigned int offset, void *val, size_t
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

