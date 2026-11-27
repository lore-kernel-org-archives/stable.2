Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776254;
	b=OxK8R5JJIWweKde7oCm3N4z0vHeu/aUEoH/zexTbMAnM31db54Uf/wvrlxogI0aa4O5K
	 Bf9DqzWxlH8ynOSXf7FaIngmExugPwqkgQBqhvZ92R7ukW0LyjeWviu6dT0agynlwUCEG
	 FV97dQP35aKYmUDVqCxPiLOUMpZt41HRI1yMp3CqNbCD/WpYj5s5DoR/DBBGU9jOjBOWm
	 4Hqi1sHNVOtbshbQ0ucKq2UgxL5W+GsdU1O7n/sz5FGZ7FLJcbA33gl/e5m1qBe3aNcHP
	 zHj39eKZBTsZqxnnmqwgkYSO6Ljz4WCrDvpPNuOVqmFEyzk/VKCdkH8FuGQqRNsZ1Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776254;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vtm4MqjxYYJpw2N7dLTQzTeBC7iRAkscIg+jXPYVL3c=;
	b=DDnUA0EQf/q4MD4eaNsN3E0wlKirVqA+aO8PWezBZqkorrqrtWQ2pdt0Z4caxn/Lj4wz
	 P+bHxEsgZcUDUgPVNZrXVzLLf4jzjJEyk/UCGpSIRxOALUDc+C3NwTlQ3RR+aJxJf3bNz
	 XVIIRUD8+vrfaToUGcbhxE/YZGiFDlLTNQh1PCJhy8MWHdj4iU+sVxo9xc/xNK2DcGUnM
	 YV3TUgBf4gfUh5JgFD2dV4sAeapRLJMDHgkoHScWZV7yZ5PcP60siaE1TfRHfJSv1yOd6
	 IbchSr+17uV3aOggI44gT7pAYbd/2uwhLY5NRqEakMmrKbUd+kUmtajmhGKyZJaW5qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HE/QFapr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E9606A32E;
	Fri, 27 Nov 2026 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HE/QFapr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DEB1F000C1;
	Fri, 27 Nov 2026 10:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776254;
	bh=vtm4MqjxYYJpw2N7dLTQzTeBC7iRAkscIg+jXPYVL3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HE/QFaprMa5KlDuiZsk6lotqx/+wHui/nRqK5g/GxHqCOmKaPHjbCz9wuXvM8qeZi
	 AYZqltaSlUEAASV5E8DE+lDsaOPQ/MDwU096D+x4KqIN5qzk6HQoZCT9SZKUSlP5+Y
	 5jR/kLfBv2kHGKWTE8TRgHoAfbsPshSp6fUiUUOv+tGIBFKEDsHpHfd3qufoiJzgES
	 IOlk2IIvcN4j1neHifimXgfATRk7jxJwDjMF+Iq3IRKPq/CF0QvkXlaMCbBuQhoqUB
	 RLm51BNk8Nsy6iw6ernp1paes+GGYVIDBJMa0DzYe4B4gwpj+xAuM+c6b3NRNasmNw
	 2Tbe9KCGlWXnw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Tyler Baker <tyler.baker@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/6] misc: fastrpc: fix NULL rpdev dereference when session alloc fails
Date: Fri, 27 Nov 2026 10:43:49 +0000
Message-ID: <20261127104354.8452-2-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127104354.8452-1-srini@kernel.org>
References: <20261127104354.8452-1-srini@kernel.org>
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

From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

When a fastrpc client process dies abnormally without closing its file
descriptor, fastrpc_device_release() is never called and the compute-cb
session slot is never freed. The abnormal client death on the DSP side
triggers a glink channel teardown which propagates up through the rpmsg
bus and calls fastrpc_rpmsg_remove().

fastrpc_rpmsg_remove() nulls cctx->rpdev before calling
misc_deregister(). If a concurrent open() enters fastrpc_device_open()
in this window and fastrpc_session_alloc() returns NULL (sessions
exhausted by the leaked slot), the error path dereferences
cctx->rpdev->dev causing a NULL pointer dereference:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  pc : fastrpc_device_open+0x1b8/0x258 [fastrpc]
  Call trace:
   fastrpc_device_open+0x1b8/0x258 [fastrpc] (P)
   misc_open+0xd8/0x1a0

Fix by moving misc_deregister() before rpdev = NULL. misc_open() and
misc_deregister() both take misc_mtx, so misc_deregister() will either
block until fastrpc_device_open() completes or prevent new opens from
entering it entirely.

Fixes: 7c11df42d0c7 ("misc: fastrpc: Fix device_open when no session is available")
Cc: stable@vger.kernel.org
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Tested-by: Tyler Baker <tyler.baker@oss.qualcomm.com> # Eliza EVK, EL2
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Fixes: 46248400d81e ("misc: fastrpc: reject new invocations during device removal")
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af18ff1992ee..4f1c6ff8054c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2675,6 +2675,12 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+
+	if (cctx->secure_fdevice)
+		misc_deregister(&cctx->secure_fdevice->miscdev);
+
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
 	cctx->rpdev = NULL;
@@ -2682,12 +2688,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	if (cctx->fdevice)
-		misc_deregister(&cctx->fdevice->miscdev);
-
-	if (cctx->secure_fdevice)
-		misc_deregister(&cctx->secure_fdevice->miscdev);
-
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 
-- 
2.53.0

