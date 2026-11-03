Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693037;
	b=ar8VL3pXTbwR0xcK3PyzUB5p/jv0KlES+7HAqa8NP80NItqX9AA81u9GbBjJEMkRmm5n
	 4wke4mmYeehD11lUGpRSKN++UhQuRrD5GgE6Caq09b1IwcF/ikXKH7eladiFS91Jka/gm
	 3EiFzrsuj3KC2n/Mk8ojuOJbSa6BQtYc3H2zng+x+o4Hg23q60TK6Kik4VmRQxGqTR07w
	 0szl2CJZmCgot/xtXdDWh93xihHjLXSSob6MXl77unewmudhemQ8n1RIS/4MZ7JU3zVbT
	 YfCYBjGj19JjsDuonHdsh4+FALQpwYh/F0aD2iRhX2pmIHU2eVRQgmZ11VxQsyOuRyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gs5+MUVCUFpHGD304h1ti8CPR/+CDqRB4o1YL2rOSQE=;
	b=gXZg67D8wBxDafc8Bx6xj9nZYJbpnjZCOb6KGF0Fk7vtb+H3Z8MFfyjonoUvSEeGsANW
	 v1MOFdMLl9fx0ip3sEc40mHgZ3WP3PdzVpRXI839VnGfE5lLnrlg3xzdUKounSsDM4+KM
	 EUJuAxJ1U/lt79Kkldfub4pbTkhKzCHZGLRhnsqUae5fFfPQreIswaawJVrAUAlwa8ZkD
	 SpmVPeCia4/XvN4cMwIgOrB4gsVo+oejD0+QTU2Z3gWPErMzX0eK15SQPJEZ49IS7Ywos
	 nIqRgIFMvs/7few8alPe5Hu+0iOifeJRbr1utBj8oJdY9+Z3i4MDiSFqrONJWTpDe2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDNEu0Qs;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B661E606A33C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B661E606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDNEu0Qs
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so2818850a91.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 00:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693036; x=1794297836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gs5+MUVCUFpHGD304h1ti8CPR/+CDqRB4o1YL2rOSQE=;
        b=YDNEu0QseFDDKOsEloJCR9Igt4kQC9ySzig+W7DHQGXaZYarzT+1a6Kxbwi7JUFKyJ
         LFhuFr/FCX/Eiob3g3SfhOwGbKPRgB55PQZIw9ex1A2UGFtnZRP4/Md82BjFrojjOvdO
         x2GpZ08C+XKpNqeaxunPskSVKHNHUDVOMe1APKiKAzDrnPiArh6fchaW9am+ficJ80/X
         3+SjASb1GeSoNpRG/4yqSZmF0eQoRPiAv83vHT/Lan5OuY6k4r2Zifo1mF8t5oq16v1k
         xHJpMWlWhwq41ib6SdACltbaMMarZAMIyLI9uQw4INca+Zv0pwTjyWcgXz+D+mhO97lO
         VLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693036; x=1794297836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gs5+MUVCUFpHGD304h1ti8CPR/+CDqRB4o1YL2rOSQE=;
        b=Mz6kOSRFr1qWWyEOHVHyTXF7FYJTLO8POvs8IZbB33zyDxTcPr/FoWHkmMn9acVopu
         4HTuN+Qc6Mo0FW2Nwy6hi4ewxvtPvS0VYBtZc7T8sITfp7kgEVpuReFJiUKphj4lMGeN
         L2ypG6jK8POMrgrqfdAIZ28KZwFnDjAT3s7UFttqOCRsry/AteAmAwCn9IsesUXevg0S
         b/Q4sArDUyrzRSVZYxQaui07p4s3iYKBsep1nzhrwZ9OfJx4cUCcDiLwBrEw1oaJKVsD
         1beaiZj4ocQhXjZSPDoaOyK6ErxacVinFih9ZZe/GQJZzCs2cnmESlr+eF0pmrYkBSyf
         tOQA==
X-Forwarded-Encrypted: i=1; AKwUvBxc3u9OrP4Z7nr7SC7R4cnPgQj6NlyCE2pHUtjneiAlsK8DDJAG+2p6vxGOTO9+4Ia9INhzbQA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ihP+1WZJIrxVi0vdbQyzXaoPK4oc7+Y54/akX3X26l3GvBvTj
	S8BJun9TrPmfdelfmzTmqj2ipgYq3Ch831aLgE7AD7W1/ds4QgXh6vyV
X-Gm-Gg: AYBFou2xF/Xd08086HcdY3/JAcow6wsKat49F8+cSMICHdPPJJnrQsUCv3JhqccdoAG
	fz/yu7Qorhm6X/dundg2YZGghDGjaprqqe29B/9yD9WbvPwLLYAjB7ET4PAMjh2IoqSk5lJJkJR
	+QsYGJMLLzYTuIMnwr3m0LfCjLA5Cv0lrAAxETMtLxbNOkEyytboScZTeesQDRY9Eg3U+/ose5B
	uIHdBzilie8cRk2hPHP16AWA22gbFze8XOvSoNUUvUCjU61xJDgwSOrpSu6TxKyCGaiebTqWWJJ
	k8gpIUl8jAnsyt7y/ix50t8498WpI/QuZk9Cu8q2+LGCGS90a/LL7kU4JpAVCQd9WWRDfRd3ngI
	mIMQMT3OCIN2+JigZsQ+lVjUaYZnDzzKZHAuR4UpcSIxv8EBNvkbs+D03ZPzA1GUiyzuUi4+pAj
	poMleSJ8oAlX6gwqre0CwAy/HnoEOgH5M5FQRU11EcfBF3qBNhZyTCsgIszl7tDkoVZgSovGprx
	ltLdnZ7Vj/a/EaE9L7kRviJo+rihnM4IVo7BFPzADBXYYxPopI16Fk0fAqVy/mo0OoRjPFflCoG
	jchsvThH7k4sAyCdU0Bi0ZDPM7rZ/w2K8CrdyC73B2zDPYzh/q71lLcryjv4o02v1h2MrIshkzz
	3
X-Received: by 2002:a17:90b:4c85:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3ae89574db4mr9347219a91.1.1793693036031;
        Tue, 03 Nov 2026 00:03:56 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5814basm3316347a91.2.2026.11.03.00.03.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:03:55 -0800 (PST)
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
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: Keep the channel when vmbus_add_channel_kobj() fails
Date: Tue,  3 Nov 2026 16:03:46 +0800
Message-ID: <20261103080347.90310-2-izaiahsun@gmail.com>
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

The channel is freed by the release of its kobject, and free_channel()
drops that reference. Since commit 8bc69f86328e ("Drivers: hv: vmbus:
Fix memory leak in vmbus_add_channel_kobj"), vmbus_add_channel_kobj()
also drops it when it fails, as kobject_init_and_add() asks for. That
frees the channel, and both callers then go on with it:
vmbus_add_channel_work() unlinks a sub-channel, unmaps and releases its
relid and calls free_channel(), a use after free and a second
kobject_put(); for a primary channel, vmbus_device_register() unwinds
through vmbus_device_release(), which removes the channel too.

The kobject is also only initialized in vmbus_add_channel_kobj(), so the
error paths before it, for instance a vmbus_device_create() failure in
vmbus_add_channel_work(), call free_channel() on a kobject that was
never initialized: kobject_put() warns and does nothing, so the channel
is leaked, and removing the attribute group from a kobject that is not
in sysfs warns as well.

Initialize the kobject when the channel is allocated, so that
free_channel() is the one place that drops its reference on every path.
vmbus_add_channel_kobj() then only adds it, and leaves the reference to
its callers when it fails. Remove the attribute group only if the
kobject was added.

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
Fixes: 8bc69f86328e ("Drivers: hv: vmbus: Fix memory leak in vmbus_add_channel_kobj")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed them and tested them
    as described in the cover letter.

 drivers/hv/channel_mgmt.c |  5 +++--
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    | 25 ++++++++++++++++++-------
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index c42def04ac41..cb1d8d76928f 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -367,6 +367,7 @@ static struct vmbus_channel *alloc_channel(void)
 		     vmbus_on_event, (unsigned long)channel);
 
 	hv_ringbuffer_pre_init(channel);
+	vmbus_init_channel_kobj(channel);
 
 	return channel;
 }
@@ -663,8 +664,8 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 			mutex_unlock(&vmbus_connection.channel_mutex);
 			cpus_read_unlock();
 			/*
-			 * Don't call free_channel(), because newchannel->kobj
-			 * is not initialized yet.
+			 * Don't call free_channel(): newchannel was never
+			 * added, and its kobject holds nothing yet.
 			 */
 			kfree(newchannel);
 			WARN_ON_ONCE(1);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 33923621a5a3..7865a519dd7f 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -408,6 +408,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 
 int vmbus_device_register(struct hv_device *child_device_obj);
 void vmbus_device_unregister(struct hv_device *device_obj);
+void vmbus_init_channel_kobj(struct vmbus_channel *channel);
 int vmbus_add_channel_kobj(struct hv_device *device_obj,
 			   struct vmbus_channel *channel);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4692687cdbf3..fc0f16f51266 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2084,6 +2084,15 @@ int hv_remove_ring_sysfs(struct vmbus_channel *channel)
 }
 EXPORT_SYMBOL_GPL(hv_remove_ring_sysfs);
 
+/*
+ * vmbus_init_channel_kobj - initialize the kobject that holds the channel's
+ * lifetime; free_channel() drops its reference
+ */
+void vmbus_init_channel_kobj(struct vmbus_channel *channel)
+{
+	kobject_init(&channel->kobj, &vmbus_chan_ktype);
+}
+
 /*
  * vmbus_add_channel_kobj - setup a sub-directory under device/channels
  */
@@ -2094,13 +2103,14 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 	u32 relid = channel->offermsg.child_relid;
 	int ret;
 
+	/*
+	 * On failure the kobject keeps its reference: the callers' error
+	 * paths drop it in free_channel(), which also frees the channel.
+	 */
 	kobj->kset = dev->channels_kset;
-	ret = kobject_init_and_add(kobj, &vmbus_chan_ktype, NULL,
-				   "%u", relid);
-	if (ret) {
-		kobject_put(kobj);
+	ret = kobject_add(kobj, NULL, "%u", relid);
+	if (ret)
 		return ret;
-	}
 
 	ret = sysfs_create_group(kobj, &vmbus_chan_group);
 
@@ -2109,7 +2119,6 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 		 * The calling functions' error handling paths will cleanup the
 		 * empty channel directory.
 		 */
-		kobject_put(kobj);
 		dev_err(device, "Unable to set up channel sysfs files\n");
 		return ret;
 	}
@@ -2124,7 +2133,9 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
  */
 void vmbus_remove_channel_attr_group(struct vmbus_channel *channel)
 {
-	sysfs_remove_group(&channel->kobj, &vmbus_chan_group);
+	/* A channel that failed before vmbus_add_channel_kobj() has none */
+	if (channel->kobj.state_in_sysfs)
+		sysfs_remove_group(&channel->kobj, &vmbus_chan_group);
 }
 
 /*
-- 
2.53.0

