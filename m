Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077592;
	b=swzW4k8cEdWWsFuh/035UkijSV+uiw/ZRdCEJ69X1t/aL2ArOPcseEnfC/LWCEgcFwGz
	 TLr+9lk+n6vzBqax/aKqYGsCXYF+UMrMPvobd5Vbrs8vmbMSOG3EIw+BPdS3gRr2sCxEf
	 FczX/vsURpRPi9aoZeiD1jzjorM7wC3VH7vnIBpC5QbQChaJdA/veu5LOmHmBj3MW8N9T
	 6BlN3c4GgI2BCuHQtIVyXCYDNwd//bgMVaGZx7hEo+cKtGdnmwD7eZFBDwmFhCx/kJgL5
	 uOHaCQpQr0WjMfcm1rq9QlosZn+93Jd67z+j4N+WQA8I8tOvr2E2iXXUyrXuQ2kV/9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077592;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SmfqLW0njMHVAElbM144ihWRMq91ThFMl9WUWCjIe2o=;
	b=PhFUTASuk58ryWbcP8h4XtvmaykPBPDd7yAN2YJjt5UQCGC/qdxsA3Puu9ghGV/N2fRh
	 0kHTHTduT7QVqlSy8u5p4H9HFAyKPqIHHiz93T8+bDkNUnLMkQCU7SVpbcV8hX1Cilky+
	 a/qEfTR9PVcqKqmFOdzQ5km04W+nED0njpVWFTW4CQ/X7vk9N7HhVWAAOMThEzp5WOcGJ
	 L7ndtwOAhmWeLg4T92Lc3TlATJ4VUjRQNnIvQTW+DpvXgsNHwKn5CELBrpAGLjant3MEl
	 M1KPw5OjSS9Bq9mRA0ata6cHx3Qj7VGntymDs23FmmkdnINTJ0NXgm92uzymoU0TrnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfweLxyz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7EA60A381F;
	Thu, 19 Nov 2026 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfweLxyz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795077592;
	b=EVKJXSu36Wum7zYHcqH9hf2XGL3qE71qDX8SvQNbEi/xffgI+XoBkRtmOoxhx6QUjpl+
	 8a8/JVQIvuO3Z7yQaJgHJWNkP9eh9VR7R5389ijQU/X98Bf72cWJI6H5iuj2N4ZK1ZCKa
	 MVUVW+ggkjafDwJuDy2j2PEOLXvc/Wf2gJ+Kfo5o94c/Y593PENhaeSpsdA7scsyxkEUz
	 La1dj76lbDpltP5bVOt7rnW4nUa/qlrnlAL8j3Q+45FyqwrAGBB+/S+F/wcD7MOr++t76
	 FXvNPOXB1v8BHAPzO2jf7xg5EIV9vflR6l9705f7E1ie7ZqM4blbfiJ9jVqOyVXWVDg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795077592;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SmfqLW0njMHVAElbM144ihWRMq91ThFMl9WUWCjIe2o=;
	b=gp6oTZoP+3T0t4dTh30lk+MUpYUHusQQeYB+ui16omXE/QFYWVF5koIIPeTvPITBRzSI
	 cI65MwYacImWveIrjouqBzfV6ay3g0iZpTE/r0eXvLwfHMmPORFdlmrfj0j/nTBqjnFd0
	 UUtdMHSO8hEOdmmn+ZauXcpO9wOmMu7A1eP5Rjz3ClA/SwT0O4SVPwL4ooyKnjeTA0nY2
	 6CScFxP0mmV+4APlF2Nj6Gf/w1+BdL4W49B1llLLEc8VwEE6oe9eU4XhlvY4pfmRjqn8v
	 2UeGCuqruUlpqbpw7hlFwYWPnY86jHMLEXcTHYXG6ppg5WBqAUbMTaXPjSevqdKMNJA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 27EC21F00923;
	Thu, 19 Nov 2026 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795077592;
	bh=SmfqLW0njMHVAElbM144ihWRMq91ThFMl9WUWCjIe2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JfweLxyzilzjOd7Be5BdVSf5pRnyDZwGxrhz3AOwBujjjO51LqsguO06MyqSShfSl
	 9c5aApD4iXHjmBU4IoYFoB+2TVuZpVRU4cEbxu4kHcKtmSpQiPLrShwIKAEoZfwRrS
	 tFoibXjATWqtyMI/W+/YHEXeOPraxREKm+aHzMc/2IYKKA+hv3NEVmsQYslhm/8edZ
	 WBJK2XUkP6W/7CbzJO25rCKmtlw+bNxhd3ek9nYWgD8wn2sF1btUeEwAH46t8vJh8f
	 sVGLYXRu+zEepkp1/p+Szw+cdVhe0Kw5itq1LhzGk3ES5mOnTE5i5R02Pvg59AZbb/
	 w2Q5DRxn0clnw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A6A2A4B1B2;
	Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 19 Nov 2026 16:39:45 +0800
Subject: [PATCH net v10 04/10] can: dev: add
 close_candev_cancel_restart_sync()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-rockchip-canfd-restart-close-v10-4-df23913aa33a@qq.com>
References: <20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a@qq.com>
In-Reply-To: <20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795077587; l=2569;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=Oh0l4Hj6DLFLNs+Pl9fZvvNbgUu+HHvweePhd3Jg4SY=;
 b=5WBUGNaXVNmpaWLzQAv121VnBDVxwVlXxT3h197bb+CBAS67pN/mPp7Lm1ahCljaFErXoOn4J
 90V6xrVXQ8CCoAeOT5PWG48ZmmYvsXT6DfME37ZArkfbUVmE2Fy4j93
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Drivers may need to wait for bus-off recovery before tearing down the
IRQ and hardware resources used by their restart callback. Calling
close_candev() at that point also flushes echo skbs, which belongs after
the driver has quiesced the users of those buffers.

Extract the synchronous cancellation from close_candev() into
close_candev_cancel_restart_sync(). Drivers can then cancel restart
work early and call close_candev() after stopping its producers. The
final close still cancels restart work before flushing echo skbs.

Cc: stable@vger.kernel.org # prerequisite for the Rockchip restart/close fix
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v6:
- Describe the helper's use by the following Rockchip fix.
---
 drivers/net/can/dev/dev.c |  4 +---
 include/linux/can/dev.h   | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index a893a49a3381..39271a3ef0fa 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -537,9 +537,7 @@ EXPORT_SYMBOL_GPL(of_can_transceiver);
  */
 void close_candev(struct net_device *dev)
 {
-	struct can_priv *priv = netdev_priv(dev);
-
-	cancel_delayed_work_sync(&priv->restart_work);
+	close_candev_cancel_restart_sync(dev);
 	can_flush_echo_skb(dev);
 }
 EXPORT_SYMBOL_GPL(close_candev);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 346faddee02e..2a286f906394 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -22,6 +22,7 @@
 #include <linux/can/skb.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h>
 
 /*
  * CAN mode
@@ -115,6 +116,22 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
+
+/**
+ * close_candev_cancel_restart_sync() - cancel bus-off restart synchronously
+ * @dev: CAN network device
+ *
+ * Call before tearing down resources used by the restart callback.
+ * The driver must quiesce restart work producers before calling
+ * close_candev() for the final cleanup.
+ */
+static inline void close_candev_cancel_restart_sync(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	cancel_delayed_work_sync(&priv->restart_work);
+}
+
 void can_set_default_mtu(struct net_device *dev);
 void can_set_cap_info(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,

-- 
2.34.1


