Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799254;
	b=FvhGyd3hOwwdzWpC9WN09HRulYGQifQBCtHrTfTg1bOzNRmmNbA5vSw7yhDHcOiGL3m2
	 kRFGOZjJmoKvghPMFwvyR/ZDueq/UsVFF754GDcRUNx368LDgDOHYC4xvRhnAjrVQXTPx
	 mcA7puYDnUIyEb1auuQq3fd1z7EHv7sotE1ERfDm9BGp+5JQvySa9c5kb6/IraEDgIuaH
	 Uj7sSMX1PkOIE3KNIqGTeKAJMpABwzSwR2SdP16mx6RxFd2CkxNIa+F2dlgAVRRzOnuFa
	 m+M4KbnG72Swk0vLxYU8dWXBDtl/e7EUruhv0SlAh7hAaVQNV0URuLVO9jkcbHS/dMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799254;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9cIsmCXy/BswurdunHNeIhDE0sOw2xASmIqeeV5ViAE=;
	b=seELYmg1/ul+0viNgwNnbsE8gVTiqspijCX8hT42TV/bPbc89iAaqLU953n8KgovsOGW
	 KkK9WaaZUE15VwxGvhOpN6Gn8oW+lkPTzAlOGyv3ZYokqmDHucdhkPK60xZLafgcj8b2T
	 4ZN/yLS26Fyu2kgMKYnK47msYv6zkkkUdsy+gnA4I3dBMZh6IOYhRRvrgUrp08Dq+X7Mo
	 9odsinMcR7ZNYLMxTGorf2gSC2Dxwjx4iwUfze2iLpaQ+f6/WJDAzXOe00yyD5ONEZjJd
	 SkBFryYITs5rQYxBwJqtpGP/NCCq7fjYd/lVbIZsrn58vaWY0ffzJmjhlNIjexigW6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhW34MgO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE41606A329;
	Fri, 27 Nov 2026 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhW34MgO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03EC1F00898;
	Fri, 27 Nov 2026 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799253;
	bh=9cIsmCXy/BswurdunHNeIhDE0sOw2xASmIqeeV5ViAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WhW34MgOzb+FsG0wM5PvSveGFVqD3slV96iJv/GtHnbbsPxmId65+b2okWkSIt7ik
	 FDzNeAfxoVUfzi567lU9ArE4BaeZytBF3YqRBOviocgbSA2qMVn2qM8KxC19OOHVcP
	 2AvOywJMeFGIbQk6LqN4Ko9GEnpTTF0Uql5BHzN5Excg7Gop4KR9WulfpVRD0CmYkZ
	 TFrtAXyx/JP/Zp8xhBG0plxKCf20d/Ngf3JZ+ohyvVugc19MDJ5joLsFdju5/GbDtO
	 8FjILllHT0+/qiyL8Hr87+exOQe3ylsJhCaoUON7GiAkoO6hu2Ay8Y5l5jnB8TSEPG
	 xCsLlmbmRd+Nw==
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
Subject: [PATCH v2 02/10] HID: mcp2221: Synchronise rxbuf access against raw_event callback
Date: Fri, 27 Nov 2026 17:06:20 +0000
Message-ID: <20261127170712.3163443-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127170712.3163443-1-lee@kernel.org>
References: <20261127170712.3163443-1-lee@kernel.org>
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
v1 => v2:
 - No changes.

 drivers/hid/hid-mcp2221.c | 47 ++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index c7e83b61b236..4f6fb75fcd01 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -19,6 +19,7 @@
 #include <linux/iio/iio.h>
 #include <linux/minmax.h>
 #include <linux/moduleparam.h>
+#include <linux/spinlock.h>
 #include "hid-ids.h"
 
 static bool gpio_mode_enforce;
@@ -124,6 +125,7 @@ struct mcp2221 {
 	struct mutex lock;
 	struct completion wait_in_report;
 	struct delayed_work init_work;
+	spinlock_t rxbuf_lock; /* protects rxbuf, rxbuf_size, and rxbuf_idx */
 	u8 *rxbuf;
 	u8 txbuf[64];
 	int rxbuf_idx;
@@ -319,6 +321,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 				struct i2c_msg *msg, int type, u16 smbus_addr,
 				u8 smbus_len, u8 *smbus_buf)
 {
+	unsigned long flags;
 	int ret;
 	u16 total_len;
 	int retries = 0;
@@ -329,22 +332,22 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
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
@@ -369,14 +372,17 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
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
@@ -924,22 +930,20 @@ static int mcp2221_raw_event(struct hid_device *hdev,
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
@@ -1282,6 +1286,7 @@ static int mcp2221_probe(struct hid_device *hdev,
 	}
 
 	mutex_init(&mcp->lock);
+	spin_lock_init(&mcp->rxbuf_lock);
 	init_completion(&mcp->wait_in_report);
 	hid_set_drvdata(hdev, mcp);
 	mcp->hdev = hdev;
-- 
2.56.1.839.g22a8290db9-goog

