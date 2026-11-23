Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449121;
	b=2xEEGDQ1C/zLp04QUtoaC6aok4ToeGthr24jZ/hW5RnF+ECCgorK66HAJIOAGfYDiwRI
	 wOFqMi0rgaaK+Md15iCSseXbj/STiu/NyqdM24nWGQ+ZieavDp0/hjdik3aodXN3mKfvU
	 P38SHi/WbrgfUwegRbgzYulMx3awaI2vfwa85xelAknE0O4E109RWoeJVL95QIIo3RWnC
	 T0rmB23VK/63LzcayL+qRk+qQVImuVVwKrPTsAFTrVIpBptBbwuxpaQE1jVF+YuMHRSWX
	 6oczMT4PEHGjhb4T7sY2Q4yPO2ySbVbrlHZGoNgnCIMmdDveAwk+Si9GHB8vB7cDVJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449121;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HIWKt/mCZ0SEXxBCu/is9mppEk5xPNF6rOOHsGh4Ff4=;
	b=yklFyGPCMfU0fbjkFb0oBfD6mJDTbWwSpsqUuTplmMFIOuzH//k/vW1rdIpn0ykILo2m
	 IuScuOwfbFk8pXWaJXymrlQubMAeNeaRW5IeE15Pbrl9YBbmY+OOYBaMRPhgLTN3cirJe
	 N62pIqYHTEc6M0LnPSyfN5l6UvYvHN9qzRww26zmC8lbbH2qvZ7LTnVKugTvmA1y8/8QJ
	 sgG4NLI4e7zql3Iqz+vBkhgo/J+Zcq35ui6WS8FGVjR2Foc46+23+gzlXdWFWmknA8IvG
	 ZyuYUZrv0lhmJEDVCnLlaqmvIiTMmLfJQglUMzEwRPbGMtCa+ouaQ2lwhBYTXHhelHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7e78qLj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017D606A31A;
	Mon, 23 Nov 2026 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7e78qLj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330B61F000D4;
	Mon, 23 Nov 2026 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449120;
	bh=HIWKt/mCZ0SEXxBCu/is9mppEk5xPNF6rOOHsGh4Ff4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I7e78qLjpfUqqqBVT763Esjxqa0E6BSz3V/KvWD6H5OPpNWBgfuDyJ9bsAuNlK0Z3
	 asiqAG9pIUpKTWtxN4/ou+BtdZwNhgDp6CKsBECicG8/ya4f6ly4DSp9ZQksD7/LXD
	 bmA3owvsWyIxwuX6w2aDIdkiK5fUUytQvp0S4DdXry/7h0aHlfUiHLyd/HxQgbZsm1
	 gru4EscVB74lArpld6KALH4DuON2c0s27NBurE3UmLeInOFn8KAioCvTMCj832nCCE
	 jUkj9RXT2M6AjMRpEjC5W/17wUIYZ40VcDBdDGhXaf8BqW4LZBu4GK72u8kgtQyM6e
	 kldDTYVUEm+hg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Rishi Gupta <gupt21@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] HID: mcp2221: Synchronise rxbuf access against raw_event callback
Date: Mon, 23 Nov 2026 15:50:46 +0000
Message-ID: <20261123155138.2907049-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123155138.2907049-1-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mcp2221_probe() enables incoming reports via hid_device_io_start(), so
mcp2221_raw_event() runs concurrently in interrupt context without
holding mcp->lock.  mcp_i2c_smbus_read() points mcp->rxbuf at caller
buffers, including stack-allocated SMBus data in mcp_smbus_xfer(), and
clears mcp->rxbuf at exit without synchronisation against
mcp2221_raw_event().  If a transfer times out while mcp2221_raw_event()
has already loaded mcp->rxbuf, memcpy() writes up to 60 bytes into the
caller's destroyed stack frame or freed buffer.  In addition,
mcp->rxbuf was published before initialising mcp->rxbuf_idx to zero.

Introduce a spinlock to serialise mcp->rxbuf, mcp->rxbuf_size, and
mcp->rxbuf_idx setup and teardown in mcp_i2c_smbus_read() against
MCP2221_I2C_GET_DATA handling in mcp2221_raw_event().

Fixes: 67a95c21463d ("HID: mcp2221: add usb to i2c-smbus host bridge")
Fixes: db2333f88729 ("HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes")
Closes: https://sashiko.dev/#/bug/linux-4983b628-f605-439f-95bb-87560531ec95
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-mcp2221.c | 47 ++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 3f05d6e288f9..f3d14d5f11ab 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -20,6 +20,7 @@
 #include <linux/iio/iio.h>
 #include <linux/minmax.h>
 #include <linux/moduleparam.h>
+#include <linux/spinlock.h>
 #include "hid-ids.h"
 
 static bool gpio_mode_enforce;
@@ -125,6 +126,7 @@ struct mcp2221 {
 	struct mutex lock;
 	struct completion wait_in_report;
 	struct delayed_work init_work;
+	spinlock_t rxbuf_lock; /* protects rxbuf, rxbuf_size, and rxbuf_idx */
 	u8 *rxbuf;
 	u8 txbuf[64];
 	int rxbuf_idx;
@@ -320,6 +322,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 				struct i2c_msg *msg, int type, u16 smbus_addr,
 				u8 smbus_len, u8 *smbus_buf)
 {
+	unsigned long flags;
 	int ret;
 	u16 total_len;
 	int retries = 0;
@@ -330,22 +333,22 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 		mcp->txbuf[2] = msg->len >> 8;
 		mcp->txbuf[3] = (u8)(msg->addr << 1);
 		total_len = msg->len;
-		mcp->rxbuf = msg->buf;
-		mcp->rxbuf_size = msg->len;
 	} else {
 		mcp->txbuf[1] = smbus_len;
 		mcp->txbuf[2] = 0;
 		mcp->txbuf[3] = (u8)(smbus_addr << 1);
 		total_len = smbus_len;
-		mcp->rxbuf = smbus_buf;
-		mcp->rxbuf_size = smbus_len;
 	}
 
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 4);
 	if (ret)
-		goto out;
+		return ret;
 
+	spin_lock_irqsave(&mcp->rxbuf_lock, flags);
+	mcp->rxbuf = msg ? msg->buf : smbus_buf;
+	mcp->rxbuf_size = total_len;
 	mcp->rxbuf_idx = 0;
+	spin_unlock_irqrestore(&mcp->rxbuf_lock, flags);
 
 	do {
 		/* Wait for the data to be read by the device */
@@ -370,14 +373,17 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 		} else {
 			retries = 0;
 		}
-	} while (mcp->rxbuf_idx < total_len);
+	} while (READ_ONCE(mcp->rxbuf_idx) < total_len);
 
 	usleep_range(980, 1000);
 	ret = mcp_chk_last_cmd_status_free_bus(mcp);
 
 out:
+	spin_lock_irqsave(&mcp->rxbuf_lock, flags);
 	mcp->rxbuf = NULL;
 	mcp->rxbuf_size = 0;
+	mcp->rxbuf_idx = 0;
+	spin_unlock_irqrestore(&mcp->rxbuf_lock, flags);
 
 	return ret;
 }
@@ -925,22 +931,20 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 			}
 			if (data[2] == MCP2221_I2C_READ_COMPL ||
 			    data[2] == MCP2221_I2C_READ_PARTIAL) {
-				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 || data[3] > 60) {
-					mcp->status = -EINVAL;
-					break;
-				}
-				if (mcp->rxbuf_idx + data[3] > mcp->rxbuf_size) {
-					mcp->status = -EINVAL;
-					break;
-				}
-				if (4 + data[3] > size) {
-					mcp->status = -EINVAL;
-					break;
-				}
+				unsigned long flags;
+
+				spin_lock_irqsave(&mcp->rxbuf_lock, flags);
 				buf = mcp->rxbuf;
-				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
-				mcp->rxbuf_idx = mcp->rxbuf_idx + data[3];
-				mcp->status = 0;
+				if (!buf || mcp->rxbuf_idx < 0 || data[3] > 60 ||
+				    mcp->rxbuf_idx + data[3] > mcp->rxbuf_size ||
+				    4 + data[3] > size) {
+					mcp->status = -EINVAL;
+				} else {
+					memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
+					WRITE_ONCE(mcp->rxbuf_idx, mcp->rxbuf_idx + data[3]);
+					mcp->status = 0;
+				}
+				spin_unlock_irqrestore(&mcp->rxbuf_lock, flags);
 				break;
 			}
 			mcp->status = -EIO;
@@ -1283,6 +1287,7 @@ static int mcp2221_probe(struct hid_device *hdev,
 	}
 
 	mutex_init(&mcp->lock);
+	spin_lock_init(&mcp->rxbuf_lock);
 	init_completion(&mcp->wait_in_report);
 	hid_set_drvdata(hdev, mcp);
 	mcp->hdev = hdev;
-- 
2.56.1.750.gf70dc682cf-goog

