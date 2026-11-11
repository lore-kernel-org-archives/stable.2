Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411043;
	b=YGXojwAh1djMxH8Kl8UHdeHBTayPny174IWtficO8YF8KLiXMvEhoE0jt5kFH2IFws+7
	 zULCE5+r+ptFRIOj6GQfIOWspON+KpyV6zHbT5FKudPLC7jdTer1VcBXr9aEKsbJRunTS
	 AGx1RHoEsrOtveN784fDDgnLpY9LX4y3XQ9ICzCkE3IUSu9ysyuFl5PScdvaIoJWV59SX
	 iKcZLguAxnfYwMPbE1AVxpYV2efVhhkc87G3I6g1Pc5NV/FrnOT+x2oLID1PSEEAcAKRA
	 psje1yh4NGKugen+c+nmaF1RYMhSmUYZqMBvvfqk2INXCrMmCcszhUROPGyOMqjZ34w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411043;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=l2ZK7NreZxs6Od/069p77XzGJzYZxOyXgYS2PNTLN/Y=;
	b=aK+FTijR4u64J/tZc919XcmhQ2JSgbIpYtplitukFKeGU2n6H/DnaUcmdDbjda8dYkON
	 5dljEoO6eK8JYamphnweWM+dG3EP5RuA5dqNmfdmzll5eSjKrhrdJfWppFy2K3XWpCmNG
	 43p94Mg9+VYpYTUwJUvqCZZXsi1qGACNod2N2t/fmccegod1kEMXSkwxm8q/0h8kn8bLK
	 l9nxG+kywbFhS4x9vJ4Ok1QWBT1a88IjRUqLinDALVmrEjBM3I4pMtdloqDwQAVz5TjS+
	 YsnQGgKRI4oHbrnorPuBWRN0m0Lvwr/lAQuEqAhxZF1AqLcc/J6/zQRVlmlGiDqDYCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIwPD+oZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A4606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIwPD+oZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391171F00A05;
	Wed, 11 Nov 2026 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411042;
	bh=l2ZK7NreZxs6Od/069p77XzGJzYZxOyXgYS2PNTLN/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eIwPD+oZMmFGyI0DilgdIYfMSWvT8NYPj4RsXD7+O42PWXSWtOXhNDwB5jRCrZq+w
	 ATibrzizBSMjE1/9FagRCKuVFZ4EAa3eSiqqYKPl0s510WJy3mmMoXSE7Bj6wjlv2P
	 yhTHJaqLMCwfGj46O1ihB/dgLtXhavHzMvXxMQzh8RIgoCg9q9UA/viUnvj9+31N7o
	 W9ggnXgbIfh2vwRQOJVYnpjrAfuIgb96rXpaN3XhYVjWrfYh7PYGFmy2kqvaTrQPKs
	 HtaxcybsTkFUQC91SoTg5iCuQlKH8IFGugExCjifeVJO0s1I4/38No8wn4+i+ML/W8
	 eAfl8o9hlm98Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Wang <1075151112@qq.com>,
	Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nvme-tcp: validate the TLS handshake timeout
Date: Wed, 11 Nov 2026 10:30:41 -0500
Message-ID: <20261111153013.2661228-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052740-failed-6.12-799203afd298@kernel.org>
References: <20261107052740-failed-6.12-799203afd298@kernel.org>
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

From: Yingjie Wang <1075151112@qq.com>

[ Upstream commit 799203afd298b1f8e9ee49815eb38f775f211299 ]

tls_handshake_timeout is writable but stored as a signed int. Multiplying
the value by MSEC_PER_SEC and HZ therefore uses signed arithmetic.

With HZ=1000, setting it to 2147484 overflows both multiplications. If
the handshake request is accepted and its completion remains pending,
schedule_timeout() reports a wrong timeout value with a stack dump and
returns zero. The handshake then fails immediately with -ETIMEDOUT,
while the handshake agent was given about 24.9 days. Negative values
such as -1 have the same kernel-side effect.

Store the parameter as an unsigned int and reject values that cannot be
represented both by tls_handshake_args::ta_timeout_ms and by a safe
jiffies delay. Take one snapshot so a concurrent parameter update cannot
give the handshake agent and completion wait different timeouts.
Document the accepted range for built-in use.

wait_for_completion_interruptible_timeout() returns the remaining
jiffies as a long after a successful completion. Keep that result in a
long because an accepted timeout can exceed INT_MAX jiffies on 64-bit
systems.

Negative and oversized values now fail with -EINVAL. Keep zero valid,
preserving the existing immediate-timeout behavior.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yingjie Wang <1075151112@qq.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ sashal: Adjusted documentation insertion context because the neighboring nvme.quirks and nvmet_tcp.tls_handshake_timeout entries are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/nvme/host/tcp.c                       | 34 ++++++++++++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 886095f45290e..278a4e12fda67 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4214,6 +4214,11 @@
 			This can be set from sysctl after boot.
 			See Documentation/admin-guide/sysctl/vm.rst for details.
 
+	nvme_tcp.tls_handshake_timeout=
+			[NVME] NVMe/TCP host TLS handshake timeout in seconds.
+			Valid values range from 0 to the smaller of
+			UINT_MAX / 1000 and MAX_JIFFY_OFFSET / HZ. Default: 10
+
 	ohci1394_dma=early	[HW,EARLY] enable debugging via the ohci1394 driver.
 			See Documentation/core-api/debugging-via-ohci1394.rst for more
 			info.
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 82cf9419a6be4..756db4d3c3d05 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/key.h>
@@ -47,9 +48,24 @@ MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (def
 /*
  * TLS handshake timeout
  */
-static int tls_handshake_timeout = 10;
+static unsigned int tls_handshake_timeout = 10;
 #ifdef CONFIG_NVME_TCP_TLS
-module_param(tls_handshake_timeout, int, 0644);
+static int tls_handshake_timeout_set(const char *val,
+				     const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 0,
+		min_t(unsigned long, UINT_MAX / MSEC_PER_SEC,
+		      MAX_JIFFY_OFFSET / HZ));
+}
+
+static const struct kernel_param_ops tls_handshake_timeout_ops = {
+	.set = tls_handshake_timeout_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(tls_handshake_timeout, &tls_handshake_timeout_ops,
+		&tls_handshake_timeout, 0644);
+__MODULE_PARM_TYPE(tls_handshake_timeout, "uint");
 MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
@@ -1828,8 +1844,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 {
 	int qid = nvme_tcp_queue_id(queue);
 	int ret;
+	long wait_ret;
 	struct tls_handshake_args args;
-	unsigned long tmo = tls_handshake_timeout * HZ;
+	unsigned int timeout = READ_ONCE(tls_handshake_timeout);
+	unsigned long tmo = (unsigned long)timeout * HZ;
 	key_serial_t keyring = nvme_keyring_id();
 
 	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
@@ -1843,7 +1861,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	if (nctrl->opts->keyring)
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
-	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_timeout_ms = timeout * MSEC_PER_SEC;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL);
@@ -1852,10 +1870,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			qid, ret);
 		return ret;
 	}
-	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete, tmo);
-	if (ret <= 0) {
-		if (ret == 0)
-			ret = -ETIMEDOUT;
+	wait_ret = wait_for_completion_interruptible_timeout(&queue->tls_complete,
+							     tmo);
+	if (wait_ret <= 0) {
+		ret = wait_ret < 0 ? -ERESTARTSYS : -ETIMEDOUT;
 
 		dev_err(nctrl->device,
 			"queue %d: TLS handshake failed, error %d\n",
-- 
2.53.0

