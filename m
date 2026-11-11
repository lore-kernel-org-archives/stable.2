Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410501;
	b=VKAndynGtHdhNdlZvoZsc/+3AE9lGXaAcYuH3w2vb+B5MNMXF/Ogea69azBAg2aYgiQ7
	 WI2J1nBv0wJUG9AGzLLH6K43DRyM4wddo6Nef08E9Gnwl9Rt6WevJ7p9+uOBwvo7Hp71V
	 IbB1PYVfTCK1fbN0P2b1IpRrN+OaY14WfFSPnNDWoDHyeVq7rnJHF973YEx3KLCDAs6iD
	 D3EOobM79hYTdCi9wPMrczbI03ztvnHSKJ0zJfvrJnkgoRqWJqfdlcZmWyZNDv0s4I3Q6
	 QVQCVxeY7sq0OkCTYvrnese1lt4qjjNVQGlus1XtVC/stMZ6aBNFN+5k3guR1OmQUaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9RATWDY6ZXdqE0pLItWydv0WsATpKn3tEH9qIG+bV9I=;
	b=bRu8qKi4RpalVnP7ugWU5LtoskqqpIdDPWwB0VO/4MzGDM5uvgMxRABfNEQxxZFGlzOd
	 noG99K7XNDA2tNkvC8hOG+OTdO8oP7frLf1KnSCDsR4DELaboh0BEKmzPqqiV+7JnPXkf
	 WgfCdBX25QUM2tiySNYPaFES3Bfof8nb+13azrYUK8GU2t3GwoGEl6BOAhZeR6xcOzFvs
	 cvy0yeoCWdK4k3unBUj/mWau5dWGn80fcq9IsND87U/5wuw0lb4jQ6ShbwFLLIDxdcYWZ
	 QCr7JUIKFct2NLpuCE3t0DPT9YkAMnYGxymEidA8r8Q8Rbz2bleeqn8z4UoHo98jBZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jw0FDCJL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B37606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jw0FDCJL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2DF1F00A07;
	Wed, 11 Nov 2026 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410501;
	bh=9RATWDY6ZXdqE0pLItWydv0WsATpKn3tEH9qIG+bV9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jw0FDCJLfxBGL/48FvnpZ7XzYCeMSUUiIHAb/dxXLGdGA679HeFwTUCIVepyDBGcF
	 a2TYN7A7UBoX9q0r+GT2lYAbcvjhd/mtGmt5R3QDaSE8bmXWjoNg8MqgSqq1a/D7Ob
	 kttqguVKInz9AGXQ0WtS5QkQLbnK5JRK2tlMJczFqfp9ZXmRRR1kOnGAzBY3iEBVVu
	 Zme1MNRlY8mgTHV2MdCxCCtchyffdfNLZZo1yDuH8BGn84OODf5Cd83olZMKedGZxj
	 T1L5T8D7g4CtvvXtJfFYLd+AI/6aP37MYB7tKapPJPCx1CwWMIPD6J9V5ezHzDi/j0
	 UJ912m1C4RFoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Wang <1075151112@qq.com>,
	Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] nvme-tcp: validate the TLS handshake timeout
Date: Wed, 11 Nov 2026 10:21:38 -0500
Message-ID: <20261111152043.2571247-3-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/nvme/host/tcp.c                       | 34 ++++++++++++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1b53bc0671249..e9ffe9c877b1a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4652,6 +4652,11 @@ Kernel parameters
 			See Documentation/admin-guide/sysctl/vm.rst for details.
 
 
+	nvme_tcp.tls_handshake_timeout=
+			[NVME] NVMe/TCP host TLS handshake timeout in seconds.
+			Valid values range from 0 to the smaller of
+			UINT_MAX / 1000 and MAX_JIFFY_OFFSET / HZ. Default: 10
+
 	nvmet_tcp.tls_handshake_timeout=
 			[NVME] NVMe/TCP target TLS handshake timeout in seconds.
 			Valid values range from 0 to the smaller of
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 94495b0228714..294e5903e1ad5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/crc32.h>
@@ -46,9 +47,24 @@ MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (def
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
@@ -1794,8 +1810,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
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
@@ -1809,7 +1827,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	if (nctrl->opts->keyring)
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
-	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_timeout_ms = timeout * MSEC_PER_SEC;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL);
@@ -1818,10 +1836,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
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

