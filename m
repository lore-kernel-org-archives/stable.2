Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410501;
	b=z/9SUi/hirLWBS5GA40d5/UnCp3ApuNEXyzdUQx8UyMbapE8+XONOvAgxM2fgnHVU9Mk
	 arNKjMQiraOIKQFd9ycJmqp82kiB7aUN+GGhHpOqCplAlA+roOB9j27QVJVBiHyUN7SAJ
	 hAV+GnOf6atq/A0Z5svMNacciCHQHskOAjUGGRZhaN22GHyLDfJmrdXfSyEXw8/O8SvP0
	 RV/MiW+KHFz86/ehwym8mGgas/p+HT9LsfnSguAgQ1IR7Bd5MAMaYzFdsLAz0Nn6fWzsE
	 VTCOmeVG8KGIoBhFmB9T2JMHEzJlOcxAHWyZo2mU5JrgQisoADjEuYsGothRjfqUa9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o8KNc9JOJS83pScwXoRQ22XMHt3tAFapVp5es8/9Kcc=;
	b=Zy+frrvVByEJiZF3lW5E6rXZbC4xrZbQRIGtNw6FGoba873Ar7zbNMrj4nkcXhjzxm0V
	 JVNd9Kpir6xST9Bi6gFuloyHY6fK0vmHEOHc/MCjMatD/zveOcF0IIYbd3rU16JlSAaVq
	 cE8HKDCLmFLDGkyD68T9cH88VbccHGIy3YYgT2kRr3+HQkgEYFY4YLwxRRFhzqX/CRfgV
	 nmkN2moPlgbQR84d0NABDJzsYCw45oxwmf1s9X39OGi7jpG71Qj4Ox23FtOwX+GkclmA8
	 uHMfc8U3WKo8ee6eyMz5pwWovrSXQoqv6pgIy9P9aMThG8UA5U38TmMPtAahizkTZ4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRtyGuv2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F4606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRtyGuv2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D721F00A06;
	Wed, 11 Nov 2026 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410500;
	bh=o8KNc9JOJS83pScwXoRQ22XMHt3tAFapVp5es8/9Kcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DRtyGuv2jKC0Sc5UlwVMPCJx7RTxWxbqztXsuHoVdDfF+pH/Ww0aFHdQKUpuddOPn
	 g0f6Ekhngx1JHuUnQARfohyNSJn2LjfHOlRV0O821DrqD0ucSyGumQ/QRjPIdPdm8l
	 RV6pLz3wqj6wvE2+G0CsgEWmV0Te4Fcw1mpX6qtkUP2Ku3ih8sIkf3yAqthtsXaQOJ
	 AVHqyIYhSDMuOsHb6lK6knXnN6QjhqiMg4EXVipHCVlh3xLqNd/JVL+bMsf/KvxDm5
	 F67e2TGRSXZ5Z0sCQenTn4nAsVr/0u0RCLUsPfvMqX8L4y+50eMsTOo1BF1LdVw4I7
	 DZHVpN9Sp1tCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Wang <1075151112@qq.com>,
	Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] nvmet-tcp: validate the TLS handshake timeout
Date: Wed, 11 Nov 2026 10:21:37 -0500
Message-ID: <20261111152043.2571247-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111152043.2571247-1-sashal@kernel.org>
References: <20261107051540-failed-6.18-799203afd298@kernel.org>
 <20261111152043.2571247-1-sashal@kernel.org>
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

[ Upstream commit e3e7a85730a4b17efa1e2ff4088443c4753be683 ]

tls_handshake_timeout is writable but stored as a signed int. Multiplying
the value by MSEC_PER_SEC and HZ therefore uses signed arithmetic.

With HZ=1000, setting it to 2147484 overflows both multiplications. If
the handshake request is accepted and remains pending, the timer wheel
treats the jiffies delay as already expired and queues the timeout work
on its next advance, while the handshake agent was given about 24.9
days. Negative values such as -1 cause the same immediate kernel-side
timeout.

Store the parameter as an unsigned int and reject values that cannot be
represented both by tls_handshake_args::ta_timeout_ms and by a safe
jiffies delay. Take one snapshot so a concurrent parameter update cannot
give the handshake agent and delayed work different timeouts. Document
the accepted range for built-in use.

Negative and oversized values now fail with -EINVAL. Keep zero valid,
preserving the existing immediate-timeout behavior.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yingjie Wang <1075151112@qq.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

Backport notes: Route timeout validation through the existing parameter
setter, preserving the validation of the other parameters and avoiding a
new function. Omit the unrelated dynamic-quirks documentation and retain
its blank separator so the host timeout fix merges cleanly.

Stable-dep-of: 799203afd298 ("nvme-tcp: validate the TLS handshake timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++++
 drivers/nvme/target/tcp.c                     | 26 ++++++++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5bf1df91607eb..1b53bc0671249 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4651,6 +4651,12 @@ Kernel parameters
 			This can be set from sysctl after boot.
 			See Documentation/admin-guide/sysctl/vm.rst for details.
 
+
+	nvmet_tcp.tls_handshake_timeout=
+			[NVME] NVMe/TCP target TLS handshake timeout in seconds.
+			Valid values range from 0 to the smaller of
+			UINT_MAX / 1000 and MAX_JIFFY_OFFSET / HZ. Default: 10
+
 	ohci1394_dma=early	[HW,EARLY] enable debugging via the ohci1394 driver.
 			See Documentation/core-api/debugging-via-ohci1394.rst for more
 			info.
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index b9a904f184892..f478f226e29fd 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/crc32c.h>
 #include <linux/err.h>
@@ -41,8 +42,18 @@ static int param_store_val(const char *str, int *val, int min, int max)
 	return 0;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static unsigned int tls_handshake_timeout = 10;
+#endif
+
 static int set_params(const char *str, const struct kernel_param *kp)
 {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	if (kp->arg == &tls_handshake_timeout)
+		return param_set_uint_minmax(str, kp, 0,
+			min_t(unsigned long, UINT_MAX / MSEC_PER_SEC,
+			      MAX_JIFFY_OFFSET / HZ));
+#endif
 	return param_store_val(str, kp->arg, 0, INT_MAX);
 }
 
@@ -76,8 +87,14 @@ MODULE_PARM_DESC(idle_poll_period_usecs,
 /*
  * TLS handshake timeout
  */
-static int tls_handshake_timeout = 10;
-module_param(tls_handshake_timeout, int, 0644);
+static const struct kernel_param_ops tls_handshake_timeout_ops = {
+	.set = set_params,
+	.get = param_get_uint,
+};
+
+module_param_cb(tls_handshake_timeout, &tls_handshake_timeout_ops,
+		&tls_handshake_timeout, 0644);
+__MODULE_PARM_TYPE(tls_handshake_timeout, "uint");
 MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
@@ -1926,6 +1943,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
+	unsigned int timeout = READ_ONCE(tls_handshake_timeout);
 
 	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
 		pr_warn("cannot start TLS in state %d\n", queue->state);
@@ -1939,7 +1957,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	args.ta_done = nvmet_tcp_tls_handshake_done;
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
-	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_timeout_ms = timeout * MSEC_PER_SEC;
 
 	ret = tls_server_hello_psk(&args, GFP_KERNEL);
 	if (ret) {
@@ -1947,7 +1965,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 		pr_err("failed to start TLS, err=%d\n", ret);
 	} else {
 		queue_delayed_work(nvmet_wq, &queue->tls_handshake_tmo_work,
-				   tls_handshake_timeout * HZ);
+				   (unsigned long)timeout * HZ);
 	}
 	return ret;
 }
-- 
2.53.0

