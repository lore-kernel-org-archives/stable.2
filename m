Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046545;
	b=CF7HGPoMW5ZZoyIG4Rx+sc6jRH6E5ppTcmjXUJMSD9znnAVnmr5XyW70gtId1EVIBu1l
	 U+DMA5y55gIvObZZqFRFkpQGv/HXtC57w4wYlw5cr1gu8v9SaVRtJFUXpfTkBRzjth6W+
	 zsRmY1+k5qFIiBReP8TSibn3HluI0ogmnp/syRzvGK/2zQc22tm6Nw9xNRABZNDRF46TZ
	 JlJnkRac4gsjKv3Q+BL6AzAy8UiNfi9j5u33s5JbhySjlziHaSRWtJoXVcVaOjxTFtoV1
	 gVukB+Qflt6gQecx2yxl2D+JhMZEiulV/+3Q8uW9t1jA3JAxGCpvFxPyavZI4jvwvUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046545;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FLwgCy9PACHNks8IMyCdp8lVTJcbMT64F5u3DekFjHY=;
	b=wdbn4hyg9uDm4NWskGXL0cWwyAoJsDKo7sPvkmVi3ytD1QlZK+sLdLMXRv6RLhvwoNMt
	 CVoVkHJBTplajtm1vZ3nzG6bbCreIjde0PcghAjpedhmhDxmntUSi34uwe9FDcACxzKKu
	 SaNH92YeTGq+16MckkfdL9MerQnLNmHKKxXLA2WF46vKcvAXCUOV9YQEMEbCgP4vNr+Ix
	 b5kC7Z+3ghp7mjjcwrS3RHniHF3H9ztphdz/XwkAeu8kJxwv/1oavq8h9q3DSNuIuOslS
	 mj1ZRMtKKqzQ1KRdqL41hWbI1fQhMEJRfeIQe8AT8CFa9ZR5vrtSWjx4eKgp0sHXJPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMueTeX+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F1606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMueTeX+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC591F008A1;
	Sat,  7 Nov 2026 10:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046544;
	bh=FLwgCy9PACHNks8IMyCdp8lVTJcbMT64F5u3DekFjHY=;
	h=From:To:Cc:Subject:Date;
	b=jMueTeX+mQsQ9+UdUeQ8zuXFMgfdww3kJH31mDgXj4/lmIHz9yy0Eoa2I4fTT4Yj7
	 HEluSwYgw+23v75uLIWdsGqZ0WocZ8CefJC4hjXl+zx1sm4hik36ry5epbyAY9DRi5
	 vdV48WxLB23tpfOe/2EK++G4RW6Gl8U1NDTbsCHiIk52gaobFC0KkgDSleTlpBYneH
	 WJy0l3O6Ei48Fnq4fvAzw4nQ6y+DKepnF1G28AMnCfumIfTgW9Mv4ZkIW3e0guNw/1
	 7nOiKAPNWxcVGoG9XOHJ8sizC0lYnqfkEZC/vg5cKrmCzMUOIqOcNHOWJsqiCohaJu
	 +Vc3k+O2sZ2mA==
From: Sasha Levin <sashal@kernel.org>
To: 1075151112@qq.com,
	hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvmet-tcp: validate the TLS handshake timeout" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:42 -0500
Message-ID: <20261107051542-failed-6.18-e3e7a85730a4@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e3e7a85730a4b17efa1e2ff4088443c4753be683
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051542-failed-6.18-e3e7a85730a4@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e3e7a85730a4b17efa1e2ff4088443c4753be683 Mon Sep 17 00:00:00 2001
From: Yingjie Wang <1075151112@qq.com>
Date: Wed, 28 Oct 2026 19:57:19 +0800
Subject: [PATCH] nvmet-tcp: validate the TLS handshake timeout

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
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 drivers/nvme/target/tcp.c                     | 26 ++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd24..5bd8a24be6b61 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4801,6 +4801,11 @@ Kernel parameters
 			Example:
 			nvme.quirks=7710:2267:bogus_nid,^identify_cns-9900:7711:broken_msi
 
+	nvmet_tcp.tls_handshake_timeout=
+			[NVME] NVMe/TCP target TLS handshake timeout in seconds.
+			Valid values range from 0 to the smaller of
+			UINT_MAX / 1000 and MAX_JIFFY_OFFSET / HZ. Default: 10
+
 	ohci1394_dma=early	[HW,EARLY] enable debugging via the ohci1394 driver.
 			See Documentation/core-api/debugging-via-ohci1394.rst for more
 			info.
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e598101752620..7937377436d3b 100644
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
@@ -76,8 +77,24 @@ MODULE_PARM_DESC(idle_poll_period_usecs,
 /*
  * TLS handshake timeout
  */
-static int tls_handshake_timeout = 10;
-module_param(tls_handshake_timeout, int, 0644);
+static unsigned int tls_handshake_timeout = 10;
+
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
@@ -1904,6 +1921,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
+	unsigned int timeout = READ_ONCE(tls_handshake_timeout);
 
 	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
 		pr_warn("cannot start TLS in state %d\n", queue->state);
@@ -1917,7 +1935,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	args.ta_done = nvmet_tcp_tls_handshake_done;
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
-	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_timeout_ms = timeout * MSEC_PER_SEC;
 
 	ret = tls_server_hello_psk(&args, GFP_KERNEL);
 	if (ret) {
@@ -1925,7 +1943,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
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




