Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF21E511
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274327; cv=none; b=od1+99R9oh6BPo6D+j2EwnQq4ddk09Rl91TZgo4a/YCnGItWgSiVD5SDL2bZFE1DjE5hSgQaMDmqr7sph9c8meVdxuhr0BSqGckLYn9OgtceuSICqJSHk8rzbgd7Q5sFqCID5PJ3JG4avgjksmL7utaiXdII2peeufDSifPph6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274327; c=relaxed/simple;
	bh=oX0daeg8ynx0o+iswV5MzD9RzG7Ux8Kw64yIIafEYmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOTv6R66DdWiaH5UNHEyHv9wqDMj0je6rC3bikEokS5JMA25xaYLedbFVH6Vt/foF8g7oewYMqm1NxaUOiGX0/smfNRQL+vqCCJPzqOYBZTA121gy6dxRvuPqJAHe5/zofWGcFsLjG7kZ6ElJVr6YNqjiaExjy5FDaeaOu/5CJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah0NBdJG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah0NBdJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FD31F00893;
	Mon,  1 Jun 2026 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780274326;
	bh=NtoV8qb6tjST5Xueyvuzyc6EU1hQ24lu29zLz5ttzQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ah0NBdJGYt18ZSTSxjA6TD0dapDUCcyZFN6qdcEjOgx6H+Lr8j3KI00n+PlkWQFXm
	 RMQY5YIp41q2ukwB9KB3eTZT7sC4dMkTLha8W64M4gDnuyjkMTiU0y3lnseJuKj0NS
	 9xe17Tw+XlX0amhF8rxtQ/k+1p/TQ3g+u2JUeLF9rI8nEAyykt+Eh0QMGEMnUfOGgC
	 tTGW7XHHou9n5CoEWGYX8pNQ0MmUnOK/MJbig/MzuEQXVgbTGBOohVGf/MC13lWT+g
	 5oZSXrpDzNLbx1Iq37FuGqRKPIFMLzjCbBBpRhyEs/8aRZ2W1moiXw5GCM/MJp2/pK
	 R7AKV18Dv19Wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Saurav Sachidanand <sauravsc@amazon.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y] i2c: tegra: make tegra_i2c_mutex_unlock() return void
Date: Sun, 31 May 2026 20:38:43 -0400
Message-ID: <20260601003844.82662-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052820-freewill-rural-eb35@gregkh>
References: <2026052820-freewill-rural-eb35@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saurav Sachidanand <sauravsc@amazon.com>

[ Upstream commit 30792d12842901f5276f466a960962d5bfa15cc8 ]

tegra_i2c_mutex_unlock() returning an error that overwrites the transfer
result causes silent loss of I2C transfer errors. If the transfer failed
but the unlock succeeded, the error was lost and the function incorrectly
reported success.

Rather than propagating the unlock error (which is not actionable by the
caller - the I2C message may have been sent regardless), convert the
function to return void and WARN on the unexpected condition. If the
unlock fails, subsequent lock attempts will fail anyway, making the error
visible on the next transfer.

Fixes: 6077cfd716fb ("i2c: tegra: Add support for SW mutex register")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
Cc: <stable@vger.kernel.org> # v7.0+
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260507221145.62183-3-sauravsc@amazon.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-tegra.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 4eaeb395d5db1..3a7f0439b2b3d 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -445,25 +445,22 @@ static int tegra_i2c_mutex_lock(struct tegra_i2c_dev *i2c_dev)
 	return ret;
 }
 
-static int tegra_i2c_mutex_unlock(struct tegra_i2c_dev *i2c_dev)
+static void tegra_i2c_mutex_unlock(struct tegra_i2c_dev *i2c_dev)
 {
 	unsigned int reg = tegra_i2c_reg_addr(i2c_dev, I2C_SW_MUTEX);
 	u32 val, id;
 
 	if (!i2c_dev->hw->has_mutex)
-		return 0;
+		return;
 
 	val = readl(i2c_dev->base + reg);
 
 	id = FIELD_GET(I2C_SW_MUTEX_GRANT, val);
-	if (id && id != I2C_SW_MUTEX_ID_CCPLEX) {
-		dev_warn(i2c_dev->dev, "unable to unlock mutex, mutex is owned by: %u\n", id);
-		return -EPERM;
-	}
+	if (WARN(id && id != I2C_SW_MUTEX_ID_CCPLEX,
+		 "unable to unlock mutex, mutex is owned by: %u\n", id))
+		return;
 
 	writel(0, i2c_dev->base + reg);
-
-	return 0;
 }
 
 static void tegra_i2c_mask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
@@ -1554,7 +1551,7 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			break;
 	}
 
-	ret = tegra_i2c_mutex_unlock(i2c_dev);
+	tegra_i2c_mutex_unlock(i2c_dev);
 	pm_runtime_put(i2c_dev->dev);
 
 	return ret ?: i;
-- 
2.53.0

