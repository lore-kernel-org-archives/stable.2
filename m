Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693040;
	b=0WySGHcijy6o1wxGqwsg0Re+5Hf11kol9j3S8gR2K5PGkm+Ct4XDTHBJuOkzk862A+xB
	 VXC7XkhMq8543hf0c5yj0y10D++e8Ogj4JLGgFM2R8DAOoaH+JTE0ge8SToxcutZ63f+s
	 0TKX31c609JsrgMfvXZqjUyU3Q/y+Zu7+PMYRjsbRkjzD9K55vjcipZkSaBwhMp7x5jxZ
	 ySCCNfVK60MSKLZGgRgSLNPfTVGNQEVB0QR0G7QL1RrIE2iZPSID0XaCDML/7kJw+eNWr
	 358rqX+snNHcfw6cDSkUxYnOl7c/z2bEDMEsqCzGv09aMSoxtUxg2561XURyWnod1Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TMkT8pmmuntirJUTkYbT/ik3ik7SviwqZQPfUGnXnKg=;
	b=5JZscLGiG/Bx8GqVfhn17PJx8NIEdmYQ6wSIVByh6P/2ftU1PRX6uAGripOnQAJQsTmT
	 cnNefR7ctszirU8qysO3D+Ie+pXxLsYo0oNt8HG3E86HcmiKKwmoDeQTQvuWaT1or1oB+
	 j8nLji1h4WQ7gMNSuP2PA6uECYoU6TDf/AIqXFW+jgWJRaJifmT+eX06wsF9LgNCBMWCu
	 OIzRT57MDXJNneEpVKnqdrhWs3+jhfYLD9hK4XTYBiZMVfCABguolPbHVTRh6rTVNGKDI
	 5YLWH07aVMKNrDSemjrQp3qXs4HfJ+5rqewCwVbTHWLLBDEg2e5u2hXYcRm/OYdlnng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ppWgs8NM;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAA606A33E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82FAA606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ppWgs8NM
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso220823a91.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 00:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693040; x=1794297840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TMkT8pmmuntirJUTkYbT/ik3ik7SviwqZQPfUGnXnKg=;
        b=ppWgs8NMyUtDuXWt2AXmqLXdPVCGUFyGi0qxnKpoVidVrhuaRbZD8ZYSmSAR18mCKI
         oj7Fj/1677lPy3NeY4mYkI29aNMi4o2yo6UUjZxNeKR9qq1ytT+aK5/s1J9u9LIaodwo
         FNvGIfFre/SD5xPPuBguL6lgIbKiP5DtuY7kQpyMcGh1e+t4+7Gtab2yNQwtg7O1TeOe
         vc0UD1NW7JInhjCMs725ggDwiVmazPIzcMY8i+cuhPzpq5Dcyf2/NAe8p073PPJmtdvS
         UgsflOtV9ApsrUb5CbiEXCsSH8IVag+J3Mu8eU4MeirFChICbUB0dgMPON/FjyHCtqwA
         nZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693040; x=1794297840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TMkT8pmmuntirJUTkYbT/ik3ik7SviwqZQPfUGnXnKg=;
        b=JceVLclwgiuSMHOcfd4F+yZvBk2h5K9P/e6WLSqJZDK74I9hQbk0kj5bGLPaYchh+r
         2IknNYLJK0gjhmCkBC3B//TSLcOjh4skawocUMzqmXTl3fxn0nfQQ7MfIMu9BqD+fSAP
         l/6u8Mkr2hxoG22YNDpiLcDj0K+0js9+dAma8QXZS1Y8lUAJT+zRx6gEUseRlJCUMcQm
         MQyX+nrsP6wTa4hGbGjR8CaqW3IBF7D20K2995yaU6CABKnw6XzkolnmA5NNaBrGOjw1
         PLKip1qg6IKL1sG54LIpONVaDnkQQeCrZZl8whx8avdot0UjJ/ZR8FTgRkQBFzrepIcz
         ugng==
X-Forwarded-Encrypted: i=1; AKwUvBw1gvQ3qLK3wOKXBUuqF58RECSYgVErAc8VqLPaQzxZluyVvNzDO5mB9RxOibEqHJqZ1VkNNUg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NyLkixvc+ME0B/Y2XYwPz0FMC+hbOEi4B8TkC+HtHO9q7rGBE
	ILPolu+OTgZZQkI/LvuvcT0tBBk7EZ6ZnLQIbertYehML/AlKbjJ/gJz
X-Gm-Gg: AYBFou0dTSFaz5GMnGOcTeEGolE/IVIO8GNHPTmlOltd+6xtL0uCvXStcm6DDACnKt2
	m5KP8cC2kJuQzLYHVeSn5+0rhDK2EBNKgI/BT8PQHcCObEHDOi/Kf2XyLe8UkDGS2bLSpwZLu2t
	dWuD0lxk3DxNt8nF6JswP1EW1XadNvCxNf+3lneRHIzdsx9DzPnV7+TOY9WnYX+lEBe4ly5aQv1
	Pfc7yEA+4nf5/IQMtCJV1zsmyXxvISGEw72dr0/acTmkeqTquCVZLFjQLEqBlwdyaua4z0WFCQS
	EqudrVmQFW09/BrP6NivPEYqFKsK2IK4D/a1Xiz2ByvlqYiHOIf2BQtElvWdihHMpNvqIJmFv4+
	WLUGMDB2DccAvE8xILB8Vn9LKqdgBpk6SE86VVJUALowM3oX1Z3E9RLZvngw+QRTOIOw1y0jlVO
	ask374ZWByDnhYMZUVg4wTNt40diwybD1y4hmT2ajteep6bsaVuoLlX8qMTsB+I915JSlmlLWKk
	tp+LuqUqQhWst98KAopk84SfjOuYrf3IaAqPzayVp809fUqfI/b9zpWA/btK8Ryjfp1vv7RbD3h
	Uevah8LdSvePK9a/1C8/l7aHvs6zo3V7tEUJfpXQTZIySosy9Hz2XLQ=
X-Received: by 2002:a17:90b:548f:b0:3ad:677f:567f with SMTP id 98e67ed59e1d1-3ae897c8b96mr6987877a91.40.1793693039871;
        Tue, 03 Nov 2026 00:03:59 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5814basm3316347a91.2.2026.11.03.00.03.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:03:58 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: mhklinux@outlook.com,
	stephen@networkplumber.org,
	linmq006@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] Drivers: hv: vmbus: Do not remove the channel when device registration fails
Date: Tue,  3 Nov 2026 16:03:47 +0800
Message-ID: <20261103080347.90310-3-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103080347.90310-1-izaiahsun@gmail.com>
References: <20261103080347.90310-1-izaiahsun@gmail.com>
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

When vmbus_device_register() fails, it drops the device it was setting
up, and the device's release, vmbus_device_release(), calls
hv_process_channel_removal() on the channel. That function is for
channels the host has rescinded and starts with
BUG_ON(!channel->rescind), so the kernel stops there. Without the
BUG_ON, it would unmap and release the relid, unlink the channel and
free it, and then the error path of vmbus_add_channel_work() would do
all of that again.

When device_register() fails, clear the device's channel pointer before
dropping the device, and only remove the channel in
vmbus_device_release() if there is one: vmbus_add_channel_work() cleans
it up. A concurrent driver_attach() can still match the device while it
is being removed, so make vmbus_match() skip a device without a channel.

The later failures, creating the channels directory or the primary
channel's kobject, come after device_register() may have bound a driver,
and a driver can hold on to the channel past its remove callback unless
the channel was rescinded (hv_sock's connection, or the sub-channels it
opened). So do not unregister the device for them: its channel is then
just missing from sysfs, as it is while the device is being set up. A
sub-channel of such a device is refused, as when its own kobject cannot
be added.

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed them and tested them
    as described in the cover letter.
    
    Changes in v2: vmbus_match() skips a device without a channel, and the
    failures after device_register() keep the device instead of
    unregistering it (Sashiko review of v1).

 drivers/hv/vmbus_drv.c | 46 ++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index fc0f16f51266..1b9bc82bebd0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -840,9 +840,14 @@ static int vmbus_match(struct device *device, const struct device_driver *driver
 {
 	const struct hv_driver *drv = drv_to_hv_drv(driver);
 	struct hv_device *hv_dev = device_to_hv_device(device);
+	struct vmbus_channel *channel = READ_ONCE(hv_dev->channel);
+
+	/* None if vmbus_device_register() failed */
+	if (!channel)
+		return 0;
 
 	/* The hv_sock driver handles all hv_sock offers. */
-	if (is_hvsock_channel(hv_dev->channel))
+	if (is_hvsock_channel(channel))
 		return drv->hvsock;
 
 	if (hv_vmbus_get_id(drv, hv_dev))
@@ -979,9 +984,15 @@ static void vmbus_device_release(struct device *device)
 
 	hv_debug_rm_dev_dir(hv_dev);
 
-	mutex_lock(&vmbus_connection.channel_mutex);
-	hv_process_channel_removal(channel);
-	mutex_unlock(&vmbus_connection.channel_mutex);
+	/*
+	 * No channel if vmbus_device_register() failed: the channel was not
+	 * rescinded, and vmbus_add_channel_work() cleans it up.
+	 */
+	if (channel) {
+		mutex_lock(&vmbus_connection.channel_mutex);
+		hv_process_channel_removal(channel);
+		mutex_unlock(&vmbus_connection.channel_mutex);
+	}
 	kfree(hv_dev);
 }
 
@@ -2103,6 +2114,10 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 	u32 relid = channel->offermsg.child_relid;
 	int ret;
 
+	/* The device has no channels directory if creating it failed */
+	if (!dev->channels_kset)
+		return -ENOENT;
+
 	/*
 	 * On failure the kobject keeps its reference: the callers' error
 	 * paths drop it in free_channel(), which also frees the channel.
@@ -2189,6 +2204,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	ret = device_register(&child_device_obj->device);
 	if (ret) {
 		pr_err("Unable to register child device\n");
+		WRITE_ONCE(child_device_obj->channel, NULL);
 		put_device(&child_device_obj->device);
 		return ret;
 	}
@@ -2205,31 +2221,17 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	 * here. The race can't result in a kernel failure, but the user space
 	 * program may get an error in accessing "channels" or its
 	 * subdirectories. See also comments with vmbus_add_dynid() about a
-	 * related race condition.
+	 * related race condition. For the same reason, the device stays
+	 * registered if its channel cannot be shown in sysfs.
 	 */
 	child_device_obj->channels_kset = kset_create_and_add("channels",
 							      NULL, kobj);
-	if (!child_device_obj->channels_kset) {
-		ret = -ENOMEM;
-		goto err_dev_unregister;
-	}
-
-	ret = vmbus_add_channel_kobj(child_device_obj,
-				     child_device_obj->channel);
-	if (ret) {
+	if (!child_device_obj->channels_kset ||
+	    vmbus_add_channel_kobj(child_device_obj, child_device_obj->channel))
 		pr_err("Unable to register primary channel\n");
-		goto err_kset_unregister;
-	}
 	hv_debug_add_dev_dir(child_device_obj);
 
 	return 0;
-
-err_kset_unregister:
-	kset_unregister(child_device_obj->channels_kset);
-
-err_dev_unregister:
-	device_unregister(&child_device_obj->device);
-	return ret;
 }
 
 /*
-- 
2.53.0

