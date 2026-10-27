Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097538;
	b=oB39qfd5UCCbLPVZ5fHJPpYK2SsHz1uqpEAyuHd75DQhwS5UKjzAtsHOvdb4hPy/8t3x
	 otsKsphp0+x2E2LFJv9qTjiCvgzk+RzvnDGaS2pbd/AHNWXi4ldMqdyOwu0DqvEI/Wb+p
	 BwkBqPy3SP8ojpxWE3oGV2ZSThaqeRY0s2TkGm8q7DFdvs2hSVn7A4HGGufvt0rJhvtUX
	 4cjmaQH/Rx5CoDJrh+TvjzFK0FiIbutk1SPMEru73qCcpYh2NI7VDKqTz0t0kRNaoflqs
	 Tl1RmFJf0I6x+dolyJmxSIwk+ge1l8ftREkXH1aSW422ZnO/qfnBQqTsGnjFYTIijkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097538;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YrRZ5PJgwoVm9U3m2gBPDnAMwrZhHwNt19P3sqgQjTc=;
	b=EwzecPdvUxcEJVUfgkn1ahSgIHifbiwHFVpTT7fYcxlVgDawdB8cClj8oUoefZKpW62l
	 uYUoHKuuS7CYPMh9OsrMEIW0pBbXJYqLOa/2s4Idi9SRhIjaDDMVPzVlzzv5JVi5gd3rZ
	 QOOPrXU+ryfEMmjbnXD01NcBs4N1vwDFVu6a8P7VJiDaYeanc1438Umkpsmr0HYWo1WxB
	 Cgw3C2JWo83jXisZsV46A+q+lVfocFSyo/t/HcEzkdS66ULjB0vjaSdf1+GYKuPzQDFBO
	 YymsqvGB9xawIfMNVfwTcUx5UJC05q2biO2Q6ZDbWzv6nRuWmbxUozs22/Qk5e41X/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIr1Z+jr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB51606A31D;
	Tue, 27 Oct 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIr1Z+jr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A911F01825;
	Tue, 27 Oct 2026 10:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097538;
	bh=YrRZ5PJgwoVm9U3m2gBPDnAMwrZhHwNt19P3sqgQjTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mIr1Z+jroQC7OTg3Jo7pZKd4ADtW3yDxMdVjppJxn8O/lYtw8TOTCAXnX4HQvYi1u
	 GRtAa+GpWZxypC5x7cHEziHPNEH2d0ZVw2llTEnNmCCZ12EcXnSIO5X14/pQ27q6lv
	 HhmPTfoS6D3MByHZrQyJsQcBx/rEPyowsdGQGy9bP/2FMLp9K0Nzzkx8JxcuSwb2q/
	 jUa65YeX6UWADjjqY5UQlequAFazCU/g/wHu3XmuYnLF7y0vt+hshweRYM7cp5qL+O
	 7P4JWxM40l6oURsdU7lBceLyT/JPhtCW4YENg8ndXdLm0QmqhtvSWV2PotMrph2Npn
	 KOaZ1uG6gkdBQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Thomas Richard <thomas.richard@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 26/27] i2c: cgbc: Propagate hardware errors when polling read status
Date: Tue, 27 Oct 2026 09:30:55 +0000
Message-ID: <20261027093306.2812695-27-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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
Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
Tested-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
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
2.56.0.307.g5fe7bd680c-goog

