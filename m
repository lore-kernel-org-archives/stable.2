Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047263;
	b=hbkNpdqCbX1m1prylrGpr59LnvKsUSYXDkkM6e04Y8mAyFR5UiACrtpja45hcfl6QpNP
	 fdNUDmEd9/8j1VFSn8m7I4CMJ6wHGJyvNrVdYuiJhzCtFHmn2nAjG7lTOqFbzKXrE4VBY
	 MSc5SnZPzonCuhPgVxrLLaP11uxfemcS8Kt+gZbOkE+vwNSAmlJe1stBd3Q2s2evNrK/d
	 Qi9baE/PMdRdXJx+7BEXYaocYFCxma9RgF+i3GL3/LUY5+EcDjX2PYW8aZYJ41PjAgrgV
	 KZEM/ZD/2FufZGM7C+5Zdy7TNRSWheDQTU1tUIM9hMU5uDLlKfY2N5bPHtXJMGOL13Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HV5e9oERrLhMurHtcQ1jb4ClsjWHANLAVAmy0KfecHc=;
	b=NWvPS5Zpda28DZSRNodKxiXbFNissV3j+xHV16vymSqEUpMN+vTLbv55emL3UzZYmtod
	 8hOdsi9tsLtdkpSIETG2TK78YwqzrQVXfZ+oTWP+DDHHxj3hlodEb0IUaFE3yNfclrYAV
	 tQWtxYjcG6a8ci1BLykA1yQbAJKb6lMtNlsXbW4IKl/sXvy1U+yvw/HVfHjUJpe6Z66l/
	 xC3AhPBjZaEWfHxz/VwjoDephYhW7WA30bZJPmXqVgCmS6GeFZu22DhHSe8WwHk4C3vSI
	 cCnwwDLvMea8DCMfiYEdyPCYIRosHZq1XIhOFtunvl2aoPUFX4+THQwA8uGqXfU+64w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoNuzN3d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB1606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoNuzN3d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BA11F0089F;
	Sat,  7 Nov 2026 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047262;
	bh=HV5e9oERrLhMurHtcQ1jb4ClsjWHANLAVAmy0KfecHc=;
	h=From:To:Cc:Subject:Date;
	b=CoNuzN3dvRhQV+0ahrs8SzXlv0M9+nYksE5rQ016wdlPr29Ncj8JgCb6q4LJijm5g
	 n21mL2YjmvzmSmajlEFF1oMJQhHUL2K4zIllHB/3NYo87SCUmDBfs7KFGHxmp8uOir
	 y7MdSQfYnz4hiZnY+uBPmmjW9hs2FeCn/NodBj32nK4mIg2tKwuDuEulHTXcmXZN7M
	 67smL3w62/Kr+k6GGPkrV5JYZ6D4n4YSXoYo6fqHLYkFsq0TEZy1bMa3vSQ0FreulE
	 NSpiOxeI23doWb3FU72QCgCfqEm+gNPmuhzjPBdwdC4QmTTGShg4PISDeJOfeQPmkV
	 NIqZcKUoISpqg==
From: Sasha Levin <sashal@kernel.org>
To: 1075151112@qq.com,
	hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme-tcp: validate the TLS handshake timeout" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:41 -0500
Message-ID: <20261107052740-failed-6.12-799203afd298@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 799203afd298b1f8e9ee49815eb38f775f211299
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052740-failed-6.12-799203afd298@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 799203afd298b1f8e9ee49815eb38f775f211299 Mon Sep 17 00:00:00 2001
From: Yingjie Wang <1075151112@qq.com>
Date: Wed, 28 Oct 2026 19:57:20 +0800
Subject: [PATCH] nvme-tcp: validate the TLS handshake timeout

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
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/nvme/host/tcp.c                       | 34 ++++++++++++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5bd8a24be6b61..187917a4f196d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4801,6 +4801,11 @@ Kernel parameters
 			Example:
 			nvme.quirks=7710:2267:bogus_nid,^identify_cns-9900:7711:broken_msi
 
+	nvme_tcp.tls_handshake_timeout=
+			[NVME] NVMe/TCP host TLS handshake timeout in seconds.
+			Valid values range from 0 to the smaller of
+			UINT_MAX / 1000 and MAX_JIFFY_OFFSET / HZ. Default: 10
+
 	nvmet_tcp.tls_handshake_timeout=
 			[NVME] NVMe/TCP target TLS handshake timeout in seconds.
 			Valid values range from 0 to the smaller of
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e69e6535e1a17..a8e94e4866db2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/async.h>
 #include <linux/err.h>
@@ -48,9 +49,24 @@ MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (def
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
@@ -1946,8 +1962,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
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
@@ -1961,7 +1979,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	if (nctrl->opts->keyring)
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
-	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_timeout_ms = timeout * MSEC_PER_SEC;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL);
@@ -1970,10 +1988,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
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




