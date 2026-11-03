Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716821;
	b=SQlQbinYEiRGXNZTIthPKxJFpaKrZ2QjIsxbP4hdUTKWVZEHuJeO2NjxfiQZPjcP+0s7
	 dFTelI3/DlbU5YjwliJuv+50If4xHe5qynAoeeh2LaSVyxciWiCZGPaR6OFiz0NC9eGM7
	 hm6zKo7rP2SkCaEkOMMrE20MjDHnF7IXWfOuD523QZWSwTKjsFQMbvRxVgSYl8uUmetdd
	 s8M/UF7yeKgUzarRVxZFwXCDf7Jq7/AY0RxmrZ7dkQbUx658s9GytxvdIusbR1E2yzAwP
	 HZPel5x7vNidUySVKoeO9UdmC5rXX/xCA3WGTv9vrjGjD2aV5LxViUB24DBXhUIOjWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=71SHQM+JBAqWOZSxiB0ywBj+k1TZQiMc0kbJjW0dEBE=;
	b=hPGrkWFgdwcc4Re0BQD4AP/kDc8xT/y8vB4/7Os1mk2QEIWOpa8ADA90U6f8XdnI4GkG
	 9vkp4svJz1zcSUr8kkyLt8xJMCd6h/ayPJ2z1e6TudZsZD36MuzWrAjKJpKdy0s98YRU/
	 iwy8svMB9yr+jaFiXMcDKBerdJMD0visHlYERxpq/4KSLuuP19axEatyUH7aYAJRG8kjt
	 oxvPdKVDE4sY6yHkzXJSFc4ll8MhBT/EXMfE46Oi0j1nkZnLrqLzEydgFvvrPyQLdGECN
	 gc4bijP2lHE0owHJGp3QtIAIUQDxiudSHw14NI4cEDkKISvtC2fxZeshkzcfliFd5Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LcCqzwTz;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE1606D802
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBDE1606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LcCqzwTz
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8fe8e343fso28540775ad.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793716820; x=1794321620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=71SHQM+JBAqWOZSxiB0ywBj+k1TZQiMc0kbJjW0dEBE=;
        b=LcCqzwTz/1nC1P2gl8UvDIGdEOpBDVyofXQ6G76dY7JcuDUhvtGrKpsm6EC4ZSTzbV
         OCRFT21vWE5ODkpMuUsfPG3NWbmHglT4KUFDfgaTAt63ZnFYHFeh9EIf95PGeRytnymr
         G2aSUv6zHiYmL8ftc+ggTP26etrF42Qizko+MwXSjqpOfEpdJwIXUG1ez2vTcYtewNLE
         WJhSIgowsOaOMiY6yVCaQXqf3pNDhWpv28ncmhinn4I1q34RQ67LeqHAkuAGQr9BWiBF
         LGv1HLQ0lXOmGVIXQIEXtS2Ia/ESuHQpwZNLeoGzbwxqZSJSQ9/yNHzngJP9y0HLItEb
         Hp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716820; x=1794321620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=71SHQM+JBAqWOZSxiB0ywBj+k1TZQiMc0kbJjW0dEBE=;
        b=KQbetScTJ4fKkc20AW4/NcyXEhE0r+dut1gDKOWiEmvOnaewrTZwf1hwlrIh9lwPPh
         HpZPci8wyofKSL7u5SGAMUf41MiYK/Nu+VfhRQGE2IlAW9dPldw/TT7RwEWldXevoF3J
         3aDmlgRX6irLKye+x1fwodxw9LDhjf/QKtvLHyMlBLKIA/+8AX8mJZHz/RskAJ4o2sO+
         c2HJKjXm0ukbhPRmKjGOe+wIcozELRWy7Qaqohu0+dY4keecGRec03vErHzV4NkTqpJN
         2lyKYOMn70GGBBLgpYLxkl+vAnFbsZnm1aAJDXJrP3DBdGbCAmY4vQW/JXPxqSX97YqH
         LRng==
X-Forwarded-Encrypted: i=1; AKwUvByDwMwnzenzYWwv1JZJxmiyHQBDxmdIJN1xj7iOrXiEIJnBIR1/bV6FqXpmTZ7FXM/jvN8G0CQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8izvHNgsQ0K8pVdIJdYt8RnhpJax81Omu1Z2fPjHTZSpiVTIl+
	ZWebaVdwRX4U833dz39XzF4xrnVqTY5D9gAIqMsumWPIrQzQSmbeFv/V
X-Gm-Gg: AYBFou3Zjvwkz54UUjY08QwI2+KYxyNjc2ZmxTg23NRqth4UxG1MrG536k2yclbJMho
	aiU6ondqf4n1hGtowIbqn8C1o6cJmsGa/4kdvtli7wgDxVz3Rx1PhDxv7pfx3bOTOvuEEeZWxtL
	P014kRuba+Olrb7ZCU8nedF3Fi5+Lx/fqP40cX+UHU/+CHI9CN8aIAj3WG+389v2hc6FnCn+Jlc
	Ql97UJrj35eEp/hTMbDekzyfRsJ/9TmCT34XzBVqfWgZKdMhWjSeRxt+rsiivW9ITnPfmS77cPq
	L5bOl8Yl7IJbV3sisD4qVKpc2PhvKMDtm5164OJAS+V/00ktjqMNMKI+LXh+jiWGO/Yq01mF1oq
	TB7ZIIatbrL1oVjxpEBYbhx3I25ECwhGiPQL4DqvRh5dL/ExkpiqoHcpblPXu86ka7mLGwm7uS7
	AE93Py7aBAvGZ6mn0ubKxx261iuTZ65BMecxktH9vNIa0GfL42V+7QwvtF/3RgOF6/W6bJ7yAVn
	as6gr8vo4BGF/b/lS1EmG11SCmwlH6/kiIlmeUQ0tqGSFgbeIHxnP2fDBro89gy3BFajImaqYzj
	uVEKXO4q0kyjtU9uOiM0WKfiX31hRguu6fSTnbZBUyKgeWh9Uv4mpOJoGl5xcUna0qBVwB5Hc8/
	1FMyoIze6vos=
X-Received: by 2002:a17:902:f688:b0:2ec:ed9d:bfbf with SMTP id d9443c01a7336-2eced9dbffdmr20393835ad.57.1793716820092;
        Tue, 03 Nov 2026 06:40:20 -0800 (PST)
Received: from localhost.localdomain ([2400:d802:dd7:8000:314f:4575:be3:a064])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052edasm42898465ad.4.2026.11.03.06.40.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 06:40:19 -0800 (PST)
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
Subject: [PATCH v3 2/2] Drivers: hv: vmbus: Do not remove the channel when device registration fails
Date: Tue,  3 Nov 2026 22:40:06 +0800
Message-ID: <20261103144006.69857-3-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103144006.69857-1-izaiahsun@gmail.com>
References: <20261103144006.69857-1-izaiahsun@gmail.com>
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
it up, after clearing the channel's pointer to the freed device. A
concurrent driver_attach() can still match the device while it is being
removed, so make vmbus_match() skip a device without a channel, and
look at the channel under rcu_read_lock(), as it is freed with
kfree_rcu().

The later failures, creating the channels directory or the primary
channel's kobject, come after device_register() may have bound a driver,
and a driver can hold on to the channel past its remove callback unless
the channel was rescinded (hv_sock's connection, or the sub-channels it
opened). So do not unregister the device for them: its channel is then
just missing from sysfs, as it is while the device is being set up. A
sub-channel of a device without a channels directory is left out of
sysfs too. This also applies to a sub-channel offered while its device
is still being registered, before the directory is created, which was
added to the top of /sys until now.

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed them and tested them
    as described in the cover letter.
    
    Changes in v3: vmbus_match() reads the channel under rcu_read_lock(),
    the channel no longer points to the freed device, and a sub-channel of
    a device without a channels directory is left out of sysfs instead of
    being refused (Sashiko review of v2).
    
    Changes in v2: vmbus_match() skips a device without a channel, and the
    failures after device_register() keep the device instead of
    unregistering it (Sashiko review of v1).

 drivers/hv/channel_mgmt.c |  7 ++--
 drivers/hv/vmbus_drv.c    | 72 ++++++++++++++++++++++++---------------
 2 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index cb1d8d76928f..1fa232e86fce 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -554,15 +554,16 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	 * method.
 	 *
 	 * If vmbus_device_register() fails, the 'device_obj' is freed in
-	 * vmbus_device_release() as called by device_unregister() in the
-	 * error path of vmbus_device_register(). In the outside error
-	 * path, there's no need to free it.
+	 * vmbus_device_release() as called by put_device() in the error
+	 * path of vmbus_device_register(). In the outside error path,
+	 * there's no need to free it, but the channel must not point to it.
 	 */
 	ret = vmbus_device_register(newchannel->device_obj);
 
 	if (ret != 0) {
 		pr_err("unable to add child device object (relid %d)\n",
 			newchannel->offermsg.child_relid);
+		newchannel->device_obj = NULL;
 		goto err_deq_chan;
 	}
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index fc0f16f51266..b41ce24e200c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -840,9 +840,24 @@ static int vmbus_match(struct device *device, const struct device_driver *driver
 {
 	const struct hv_driver *drv = drv_to_hv_drv(driver);
 	struct hv_device *hv_dev = device_to_hv_device(device);
+	struct vmbus_channel *channel;
+	bool hvsock = false;
+
+	/*
+	 * No channel if vmbus_device_register() failed. The channel is then
+	 * freed after an RCU grace period.
+	 */
+	rcu_read_lock();
+	channel = READ_ONCE(hv_dev->channel);
+	if (channel)
+		hvsock = is_hvsock_channel(channel);
+	rcu_read_unlock();
+
+	if (!channel)
+		return 0;
 
 	/* The hv_sock driver handles all hv_sock offers. */
-	if (is_hvsock_channel(hv_dev->channel))
+	if (hvsock)
 		return drv->hvsock;
 
 	if (hv_vmbus_get_id(drv, hv_dev))
@@ -979,9 +994,15 @@ static void vmbus_device_release(struct device *device)
 
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
 
@@ -2099,15 +2120,24 @@ void vmbus_init_channel_kobj(struct vmbus_channel *channel)
 int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 {
 	const struct device *device = &dev->device;
+	struct kset *kset = READ_ONCE(dev->channels_kset);
 	struct kobject *kobj = &channel->kobj;
 	u32 relid = channel->offermsg.child_relid;
 	int ret;
 
+	/*
+	 * The device has no channels directory if creating it failed, or not
+	 * yet while vmbus_device_register() is still running: leave the
+	 * channel out of sysfs.
+	 */
+	if (!kset)
+		return 0;
+
 	/*
 	 * On failure the kobject keeps its reference: the callers' error
 	 * paths drop it in free_channel(), which also frees the channel.
 	 */
-	kobj->kset = dev->channels_kset;
+	kobj->kset = kset;
 	ret = kobject_add(kobj, NULL, "%u", relid);
 	if (ret)
 		return ret;
@@ -2116,8 +2146,9 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 
 	if (ret) {
 		/*
-		 * The calling functions' error handling paths will cleanup the
-		 * empty channel directory.
+		 * The empty channel directory goes away with the kobject: in
+		 * the error path of vmbus_add_channel_work() for a sub-channel,
+		 * and when its device is removed for a primary channel.
 		 */
 		dev_err(device, "Unable to set up channel sysfs files\n");
 		return ret;
@@ -2189,6 +2220,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	ret = device_register(&child_device_obj->device);
 	if (ret) {
 		pr_err("Unable to register child device\n");
+		WRITE_ONCE(child_device_obj->channel, NULL);
 		put_device(&child_device_obj->device);
 		return ret;
 	}
@@ -2205,31 +2237,17 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	 * here. The race can't result in a kernel failure, but the user space
 	 * program may get an error in accessing "channels" or its
 	 * subdirectories. See also comments with vmbus_add_dynid() about a
-	 * related race condition.
+	 * related race condition. For the same reason, the device stays
+	 * registered if its channel cannot be shown in sysfs.
 	 */
-	child_device_obj->channels_kset = kset_create_and_add("channels",
-							      NULL, kobj);
-	if (!child_device_obj->channels_kset) {
-		ret = -ENOMEM;
-		goto err_dev_unregister;
-	}
-
-	ret = vmbus_add_channel_kobj(child_device_obj,
-				     child_device_obj->channel);
-	if (ret) {
+	WRITE_ONCE(child_device_obj->channels_kset,
+		   kset_create_and_add("channels", NULL, kobj));
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

