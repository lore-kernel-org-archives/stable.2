Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776256;
	b=DqLQbZRMNNMriZdVwDMWWpQG04rHN34MsXWrEJUq3nwoo/CwSsTa55RZmEOOHp8XBvjj
	 iMcnRoiHyml2mmOSJFXmHfNZIFRgf7Mmp8zQZtLSutZwSxgfdkGUYV7+ckgFxObqshVa+
	 XhpC+hN18q4DJCFZ5SaeOTaPYe4Ip9VXzrcFsHZJllIY0UjtNqM0YzKRTOu8rHg8PXR97
	 hqHDEQFyu3vxnJBBK6DzAmazp9QtTJ7XMEIn61vZdf4wfnhZ0KZKvlKyjefk9vZ9XmEqn
	 NItcfRN/XbAfcvbdqjQ3evs30bF8mZj7/Msf/yI8KvXdgSz+rLNqI1WyHBydjV8xMgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776256;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GYXXt1yWKRxyNdi2dBUzd5be8BlTojWbeAnjOQUw8rs=;
	b=zQGTaOixPXBX4kLi8cNiC+2rak+MhIZ9I5ZPsGXWntJrfh1EGUqyaPfbAmffAujVW6K6
	 IvPCt9np0RK7/n9fFCHiQ/qNCwmn9K8mRIvIFP4LXG6gb3oW8/ONUqC0XljzH9moSRBPH
	 QhEYb4Kk763EYPNktNo5OiUCfiH6b0xgWW+IGTVRkyoBY1eOugPs69oqCgBs7bdCAzKq8
	 YkryPkQpnA5+3GYLalJrQhMneKsn2ooTXaIE6/oanK2GU1uyBDVx5ONqvO7jVOShBmNgX
	 v6x/uVrlGig1t0bZcratPEgceHLTijTdJ3EtSssCuLS8aG76yC617GsFFEB/slMvUKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsvUifvQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B4606A329;
	Fri, 27 Nov 2026 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsvUifvQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A834A1F000C1;
	Fri, 27 Nov 2026 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776255;
	bh=GYXXt1yWKRxyNdi2dBUzd5be8BlTojWbeAnjOQUw8rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lsvUifvQBFOZld/Y4IvlDWD56Qu95H2Xtn/HijyaSc8ZsCFqDPoW9BaDxyhJhzysS
	 855toMrOaPAmEeSEBhDyYo84P7726CsLCmbMoWPA1yF6fzJzX1ya7XNeDExK85FbA2
	 vDQfVJJsdrE7tVIucmy2i+uU2Q9oWLivjfATBWKBnBAQLDIMh7TtuqZZzVFnmY3Zfu
	 8AN9tNo2TFntvyZnYbul4fSgjROFxFlrx5rFCUPR6iZgIqgu1TyX+GlGzEqNCDefi3
	 uCMR7S7w0qMIJkU0USwbK+5Vq5Ip2+QSsIBKPCIoQmYftWr5FTEXQP/rOTgF2OIfcn
	 +aq8/9kspkjBw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/6] misc: fastrpc: fix init ordering race in rpmsg probe
Date: Fri, 27 Nov 2026 10:43:50 +0000
Message-ID: <20261127104354.8452-3-srini@kernel.org>
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

fastrpc_device_register() calls misc_register() which makes the device
node visible to userspace. However, kref_init(), spin_lock_init(),
INIT_LIST_HEAD(), dev_set_drvdata() and of_platform_populate()
were all called after the switch/misc_register block, leaving a window
where userspace can open the device and call fastrpc_device_open() on
a partially initialised channel context.

On a concurrent open(), fastrpc_channel_ctx_get() calls kref_get() on
a kzalloc-zeroed, never kref_init()'d refcount of 0, triggering:

  refcount_t: addition on 0; use-after-free.
  Call trace:
   refcount_warn_saturate+0x120/0x148 (P)
   fastrpc_device_open+0x204/0x258 [fastrpc]
   misc_open+0xd8/0x1a0

Additionally, of_platform_populate() not having run means
sesscount is still 0, so fastrpc_session_alloc() returns NULL and
fastrpc_device_open() hits the error path which calls
fastrpc_channel_ctx_put() on the already-bogus refcount. This
triggers the free callback, kfree()-ing the channel context. A
subsequent IRQ-path fastrpc_rpmsg_callback() then dereferences the
freed spinlock:

  Unable to handle kernel paging request at virtual address ffffcd5841510ca0
  Internal error: Oops: 0000000096000047 [#1] SMP
  Call trace:
   queued_spin_lock_slowpath+0x414/0x5e0 (P)
   _raw_spin_lock_irqsave+0x74/0x90
   fastrpc_rpmsg_callback+0x4c/0xf0 [fastrpc]
   qcom_glink_native_rx+0x6c4/0xf10
   qcom_glink_smem_intr+0x1c/0x38 [qcom_glink_smem]
  Kernel panic - not syncing: Oops: Fatal exception in interrupt

Fix by moving all channel context initialisation (kref_init,
spin_lock_init, INIT_LIST_HEAD, idr_init, dev_set_drvdata) and
of_platform_populate() before fastrpc_device_register(), ensuring
the struct is fully ready before the device node is visible to
userspace.

Add err_depopulate label in the error path since
of_platform_populate() now runs before misc_register(); a
fastrpc_device_register() failure must call of_platform_depopulate()
to clean up the compute-cb children.

On CDSP/GDSP the secure node is registered before the non-secure one, so
an application may already have opened the first node and hold a channel
context reference when the second registration fails. Freeing the
context with kfree() there would leave that user with a dangling
pointer. Handle it like fastrpc_rpmsg_remove(): after the nodes are
deregistered, clear rpdev, wake pending invocations with -EPIPE and drop
only the probe reference with fastrpc_channel_ctx_put(), so the last
holder frees the context. Move fastrpc_notify_users() above probe so it
can be used there.

Fixes: 965602eabb57 ("misc: fastrpc: separate fastrpc device from channel context")
Cc: stable@vger.kernel.org
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 82 +++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4f1c6ff8054c..70b5642f5fbc 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2542,6 +2542,18 @@ static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
 				  cctx->vmperms, cctx->vmcount);
 }
 
+static void fastrpc_notify_users(struct fastrpc_user *user)
+{
+	struct fastrpc_invoke_ctx *ctx;
+
+	spin_lock(&user->lock);
+	list_for_each_entry(ctx, &user->pending, node) {
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+	}
+	spin_unlock(&user->lock);
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2551,6 +2563,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	bool secure_dsp;
 	unsigned int vmids[FASTRPC_MAX_VMIDS];
 	const struct fastrpc_soc_data *soc_data;
+	struct fastrpc_user *user;
+	unsigned long flags;
 
 	soc_data = device_get_match_data(rdev);
 
@@ -2599,6 +2613,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->poll_mode_supported = soc_data->poll_mode_supported ||
 		of_machine_get_match(fastrpc_poll_supported_machines);
 
+	kref_init(&data->refcount);
+	atomic_set(&data->ctx_seq, 0);
+
+	rdev->dma_mask = &data->dma_mask;
+	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
+	INIT_LIST_HEAD(&data->users);
+	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
+	spin_lock_init(&data->lock);
+	idr_init(&data->ctx_idr);
+	data->domain_id = domain_id;
+	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
+
+	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+	if (err)
+		goto err_free_data;
+
 	switch (domain_id) {
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
@@ -2607,7 +2638,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
 		if (err)
-			goto err_free_data;
+			goto err_depopulate;
 		break;
 	case CDSP_DOMAIN_ID:
 	case GDSP_DOMAIN_ID:
@@ -2615,7 +2646,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, data, true, domain);
 		if (err)
-			goto err_free_data;
+			goto err_depopulate;
 
 		err = fastrpc_device_register(rdev, data, false, domain);
 		if (err)
@@ -2623,26 +2654,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		break;
 	default:
 		err = -EINVAL;
-		goto err_free_data;
+		goto err_depopulate;
 	}
 
-	kref_init(&data->refcount);
-	atomic_set(&data->ctx_seq, 0);
-
-	rdev->dma_mask = &data->dma_mask;
-	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
-	INIT_LIST_HEAD(&data->users);
-	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
-	spin_lock_init(&data->lock);
-	idr_init(&data->ctx_idr);
-	data->domain_id = domain_id;
-	data->rpdev = rpdev;
-	dev_set_drvdata(&rpdev->dev, data);
-
-	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
-	if (err)
-		goto err_deregister_fdev;
-
 	return 0;
 
 err_deregister_fdev:
@@ -2651,23 +2665,27 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (data->secure_fdevice)
 		misc_deregister(&data->secure_fdevice->miscdev);
 
+err_depopulate:
+	/*
+	 * A registered device node may already have been opened, so a user
+	 * can hold a cctx reference. Drop only our reference instead of
+	 * freeing the context directly.
+	 */
+	spin_lock_irqsave(&data->lock, flags);
+	data->rpdev = NULL;
+	list_for_each_entry(user, &data->users, user)
+		fastrpc_notify_users(user);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	of_platform_depopulate(rdev);
+	fastrpc_channel_ctx_put(data);
+	return err;
+
 err_free_data:
 	kfree(data);
 	return err;
 }
 
-static void fastrpc_notify_users(struct fastrpc_user *user)
-{
-	struct fastrpc_invoke_ctx *ctx;
-
-	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node) {
-		ctx->retval = -EPIPE;
-		complete(&ctx->work);
-	}
-	spin_unlock(&user->lock);
-}
-
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
-- 
2.53.0

