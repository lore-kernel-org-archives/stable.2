Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585018;
	b=lpgBJMbyPkGw4SaV0E0h0kJJp9OFVt5VHrhqoTdESTyCKvmwKZJhqNMbYgmOxNeMC2Pt
	 WkA3ouQc1DFKhI3XxejeM3WSSNIhMRRrFYoZqUoXYX8YX98HVdUbJqpBV0sZrDhhcUzWg
	 fPLxxlaHtaWEjCJrWzUwUrnWtwoQiX3B5unFs83oZcUPStO398ofqf/o58Y4f1KQFUpci
	 VUi+MMvlJzmYN0ktvBMBes38X+cFSZp/pUkrLzs0xyEOm+kD31Ezm7Z+YMPMAXTWGOvdK
	 3y2HzH013YoEDm7ZOSN5r9fZP7pWZaLebpkOdefTG5Gh22Bv3Zqgcb7nOTtKK82vZvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585018;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=98dYYmsSfoz28zF8HsdLP9ZdumQZQFwFbTrU6HJ51YI=;
	b=wjVVkSp1R9uFT/gl3Cm4ohN+egulF6kaDpPEqTnD38VNL+FS0Att5SB/U7IhKzhpVW2F
	 K0XoGQykdBZUCMXFeigeo4TbBSDI5WKrFwTljQbLI+J6UC6GpZ16D4hTmBj5+JGDTgt0f
	 ayVHP05rjcCjpvStF5/JGDnau9neYdX7q8vAtw/UgSr2b8YqcneQ17w5h65/xEDk203KD
	 j9vO7REjRhSS16ab5kO7qJhmF26ZgcBmcvQRJuimz631shfSX0chFA3U1YYFb/PZ6wkAH
	 Dvs/z+dloA8qxZ90rOTJVRhfS7ary0rQCuJutu5YJog/p4AVyOPxjqw+hWY16k/y92Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpFO7jtx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC960A5BEA;
	Wed, 21 Oct 2026 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpFO7jtx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D391F000C6;
	Wed, 21 Oct 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792585016;
	bh=98dYYmsSfoz28zF8HsdLP9ZdumQZQFwFbTrU6HJ51YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IpFO7jtxgQMe74WwBCCiNgmAb7h0e7H/CmIAGKCxG4OqaJ+U7MDVSQdTUajV7+4np
	 yyQO8AXJQoDSHnNDDtZUPj/2LNOxGmT6lbshHy82tRDHkhQHSTep+4VfjSG5UZAsap
	 H05uOR1T0FmEpwhpn7m2/fXZ3EgenEhkB3PsSjMVjbi8iVrJ9Zn/X0nz4ObjIpTGq9
	 qF/dALXMC5IcprUNEYTIo5Qf+LAz/lSd7y4KzYm5iwU5ycB1Hy85Y2/7+MU8hdLQmD
	 o2YSk8wKtDj/sSqxKSp4y42hbgtZ3cnvtrjH3Ydv7fk/77vE/WDu0R324maYDlgIhF
	 vWXDb7rY6JzjA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Thomas Richard <thomas.richard@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 27/28] i2c: cgbc: Propagate hardware errors when polling read status
Date: Wed, 21 Oct 2026 12:09:49 +0000
Message-ID: <20261021121245.3111563-27-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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

In cgbc_i2c_xfer_msg(), read_poll_timeout() uses the same ret variable
to store the polled return value of cgbc_i2c_get_status() and the
timeout result of the macro itself.  When cgbc_i2c_get_status() returns
a negative error code (such as -EIO on an I2C NACK), the loop condition
ret != CGBC_I2C_STAT_BUSY evaluates to true and read_poll_timeout()
overwrites ret with 0.  The driver then issues CGBC_I2C_CMD_DATA, which
completes with CGBC_STATUS_CMD_READY without populating msg->buf,
leaving uninitialised heap memory in the caller's read buffer.

Store the polled status in a separate variable, verify that it equals
CGBC_I2C_STAT_DAT, and check that CGBC_I2C_CMD_DATA returns the expected
number of bytes.

Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
Closes: https://sashiko.dev/#/bug/linux-66cbf4b1-a219-4012-969d-236417bf419a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/i2c/busses/i2c-cgbc.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index 25a74fa51aa0..9909c25f0b18 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -205,9 +205,9 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 	struct cgbc_device_data *cgbc = i2c->cgbc;
 	struct i2c_msg *msg = i2c->msg;
 	u8 cmd[CGBC_I2C_CMD_SIZE];
-	int ret, max_len, len, i;
+	int ret, status, max_len, len, i;
 	unsigned int cmd_len;
-	u8 cmd_data;
+	u8 cmd_data, data_len;
 
 	struct cgbc_i2c_transfer xfer = {
 		.bus_id = algo_data->bus_id,
@@ -266,17 +266,32 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 		if (ret)
 			goto err;
 
-		ret = read_poll_timeout(cgbc_i2c_get_status, ret,
-					ret != CGBC_I2C_STAT_BUSY, 0,
+		ret = read_poll_timeout(cgbc_i2c_get_status, status,
+					status != CGBC_I2C_STAT_BUSY, 0,
 					2 * algo_data->read_maxtime_us, false, adap);
-		if (ret < 0)
+		if (ret)
 			goto err;
 
+		if (status < 0) {
+			ret = status;
+			goto err;
+		}
+
+		if (status != CGBC_I2C_STAT_DAT) {
+			ret = -EIO;
+			goto err;
+		}
+
 		cmd_data = CGBC_I2C_CMD_DATA | algo_data->bus_id;
 		ret = cgbc_command(cgbc, &cmd_data, sizeof(cmd_data),
-				   msg->buf + i2c->pos, len, NULL);
+				   msg->buf + i2c->pos, len, &data_len);
 		if (ret)
 			goto err;
+
+		if (data_len != len) {
+			ret = -EIO;
+			goto err;
+		}
 	}
 
 	if (len == (msg->len - i2c->pos)) {
-- 
2.56.0.218.g1ec904b173-goog

