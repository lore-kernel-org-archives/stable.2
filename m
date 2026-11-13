Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582559;
	b=ZtCNRrCEQ2O6EB/ra6hxbzmTeLlRfYDN5T1fVB1R+yVTu3jfcQCP9XLrG51pi3kLQ+N6
	 XPiyIRNI1e7GMwPL2DyY1TyPetBJ4yAFvIZzZEPlcJn89unQNVCPVgjGbMDDXn8EX3uMf
	 uSO1tkpmmPf4R67P1wBswUiAr+AMyk/XfWs9gGtB6xM4XBuytOSHpWHeUvgs65kUQs542
	 +iEnY+7mFAoPnrjzSVZ18ObR40OT6O/oT1hrwnx7QFtAoeIkL8rW8Sp+RXKS1EeybkWLx
	 VKewQmnEefoiC8eEX9np3eCYyfpwW3yCqduPHLZ3QEmcR44ysfMKXVlJd2PJ8N9yRWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ExJNAbJH+qK5MQRUf8ShNf27BBW7tGCJwdIKJeepikQ=;
	b=MMqoawrwRRsqRtAjVRbNMBK+uZX3glFGfNTRep6y8Lm+GH2U9ogquhuLGfqoNSpm4Plu
	 CII1ojuLOD6D6PxeS6ZJGhd52uG0ll7FkYRh6Ieh2hWa0EAaVALXat3Hg4etULB7pNer2
	 u9MzuxXPw+SBrNyTUJIPVA6tTaeKa4khsQCpgOPh7sFMkxF0CHLhmvcp6ngPUHXQeN9gt
	 Q3/itJaDXJ6lY98SS9SLzZeyRXGK2xtd3euWv5z3u2qhn1iO8m0lRaA6vjeVuk6KPitn2
	 kdvyAn7MiW1TOeiXXANzByl/ko0uYh2ZZuzQvm7rtJjJMN74wWw13KDN2LEvTg7I6ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q02ZRF8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDC606A33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q02ZRF8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6DA1F000C7;
	Fri, 13 Nov 2026 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582559;
	bh=ExJNAbJH+qK5MQRUf8ShNf27BBW7tGCJwdIKJeepikQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q02ZRF8s67dr4SGmONZ5DX4lS6m5gYq7xD9sZHX62Pm11g8JmGwA0SMqsT56YZBIo
	 7ecGeOiZa3oC0ExcYod6aRcAwVoSaiCLUVYrYhUTMukQjgsq9inuOY9+qYbJXi7Bv+
	 or20eNrQsnQHJ5OSfaPsvgtuRoV7jA9sexd5rf25t72RCRe9NXjKN9eYnPlBjELGlQ
	 u6pmEz2L7/iBG5BSAwj9fQ29k5uguX6xM0pLggkH6TgcEjIADvsDili6Z3EnpRNYln
	 pulBXPYqLVERHPODKVmYHirLZpH3ffvxNye6tOtsy7wfJf7BK4cuRCyl1/vkzHM9sY
	 NHTk6RaUjRIrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] i3c: master: replace ENOTSUPP with SUSV4-compliant EOPNOTSUPP
Date: Fri, 13 Nov 2026 10:09:15 -0500
Message-ID: <20261113150545.1865145-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113150545.1865145-1-sashal@kernel.org>
References: <20261109200723-failed-6.12-7cd60538073e@kernel.org>
 <20261113150545.1865145-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit d10a4c323883c41cf1b652309e61c48bce248e35 ]

Replace non-standard ENOTSUPP with the SUSV4-defined error code
EOPNOTSUPP to fix below checkpatch warning:
  "ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP"

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250628192027.3932-6-wsa+renesas@sang-engineering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Stable-dep-of: 7cd60538073e ("hwmon: (tmp108) Fix initial conversion delay and wait until ready")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 28a39b2c039b1..1bbfff68a5394 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -844,14 +844,14 @@ static int i3c_master_send_ccc_cmd_locked(struct i3c_master_controller *master,
 		return -EINVAL;
 
 	if (!master->ops->send_ccc_cmd)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if ((cmd->id & I3C_CCC_DIRECT) && (!cmd->dests || !cmd->ndests))
 		return -EINVAL;
 
 	if (master->ops->supports_ccc_cmd &&
 	    !master->ops->supports_ccc_cmd(master, cmd))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	ret = master->ops->send_ccc_cmd(master, cmd);
 	if (ret) {
@@ -1441,7 +1441,7 @@ static int i3c_master_retrieve_dev_info(struct i3c_dev_desc *dev)
 
 	if (dev->info.bcr & I3C_BCR_HDR_CAP) {
 		ret = i3c_master_gethdrcap_locked(master, &dev->info);
-		if (ret && ret != -ENOTSUPP)
+		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
 
@@ -2244,7 +2244,7 @@ of_i3c_master_add_i2c_boardinfo(struct i3c_master_controller *master,
 	 */
 	if (boardinfo->base.flags & I2C_CLIENT_TEN) {
 		dev_err(dev, "I2C device with 10 bit address not supported.");
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	/* LVR is encoded in reg[2]. */
@@ -2374,13 +2374,13 @@ static int i3c_master_i2c_adapter_xfer(struct i2c_adapter *adap,
 		return -EINVAL;
 
 	if (!master->ops->i2c_xfers)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* Doing transfers to different devices is not supported. */
 	addr = xfers[0].addr;
 	for (i = 1; i < nxfers; i++) {
 		if (addr != xfers[i].addr)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 	}
 
 	i3c_bus_normaluse_lock(&master->bus);
@@ -2801,7 +2801,7 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
  *	    controller)
  * @ops: the master controller operations
  * @secondary: true if you are registering a secondary master. Will return
- *	       -ENOTSUPP if set to true since secondary masters are not yet
+ *	       -EOPNOTSUPP if set to true since secondary masters are not yet
  *	       supported
  *
  * This function takes care of everything for you:
@@ -2828,7 +2828,7 @@ int i3c_master_register(struct i3c_master_controller *master,
 
 	/* We do not support secondary masters yet. */
 	if (secondary)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	ret = i3c_master_check_ops(ops);
 	if (ret)
@@ -2988,7 +2988,7 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 		return -EINVAL;
 
 	if (!master->ops->priv_xfers)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	return master->ops->priv_xfers(dev, xfers, nxfers);
 }
@@ -3038,7 +3038,7 @@ int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 	int ret;
 
 	if (!master->ops->request_ibi)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (dev->ibi)
 		return -EBUSY;
-- 
2.53.0

