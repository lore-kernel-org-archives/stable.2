Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612850;
	b=RPEOLxrSmE4uSTMlWQG3pHEIJMHbmHSRUG1iCX/htLLy75+x1pK/FL1CHuqBbIGwY6dS
	 kbhvbY6AI3Fecgufa1PXP2BQWwggZvmDoGcAEyqhzME6VXyCJ4pwROkyqj9bqM9eNcMMK
	 62/3Egwk/KxDP3ZhXFlcldyC005hserk1zbRjsCw2q/bzf6/MiGjTO1ITE1Xgb2oRFrEU
	 T+dTu0+xYR2HtAp+Z9kVdjKGgdESHxdnjH/dbqELdAa7eG0kbB/sO66RSy9wxcPAsZSl/
	 miT4nRlnit5ILXE6q3oo84JDbgd340EOMhzuKDKDsxP0+0OrA5rdoQKED6QOyRz7qoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gs5+MUVCUFpHGD304h1ti8CPR/+CDqRB4o1YL2rOSQE=;
	b=kgRbmDIHHvEp2kT36YheU6sMPxHC03+UmN3p0MTP5Nn++Heei7m41FUqgoobuLo3bcPu
	 oOH7zUzvKutSUSuDJU+96R3PJRy+wXxncPBTpmNg/9Yu8865phB0Hau5BV/QjiwQExdb1
	 YEVeKg639ncNdZ0DlEtQvKGQ25RlI/r3CJZDxTLauewHj7psWbsyX/dCzRRxtyfBVusK9
	 LG5QsxIawqajCQvn9Oj34BcMTuFhcBeGNBBga3rnLi0AGOSNJMw6Rx+FSnapqIGjNq4oa
	 AW7XpGngw5cn8XCT2bte0FeU5rEuoiqV5pkhbzvs3ucXxtARbUMz3RrcOV6CL++NVtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vo7Xt+fn;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AE60A2633
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675AE60A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vo7Xt+fn
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so1328226b3a.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 01:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793612850; x=1794217650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gs5+MUVCUFpHGD304h1ti8CPR/+CDqRB4o1YL2rOSQE=;
        b=vo7Xt+fnoxNUCUz05P35hCqGg3AKmJeGDfHucXZuJfJFgH9IDtb1EyvSQpTl0WQoLd
         N6cp/ctU9DsOheNTssU7iN54dcuAAgtViPr56CfkOWJUfBVWLXRo1SvyYW3KT+/wswlc
         D/aA1jikdh7IA/+ZWXtAEATGpT0FfHUOJinO3iO6+CbEtpqzr8kw+VZKm5uiqx2t5EWh
         G6KIUJb1DJKD/0jdIru+Q7V4UR0rmkm/4PuHg08KuYSKgoFafYAEtshjWPoTgIiBO+gL
         Kds0YiwN4+n3R5ShtLOmYnP9oilhzaiVNh6uOjGzN9P3QpimnSkzweMT4ieiuxQsmxla
         tUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612850; x=1794217650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gs5+MUVCUFpHGD304h1ti8CPR/+CDqRB4o1YL2rOSQE=;
        b=YPP80Uya9n9Jl0aa7eu5JgKzbaWGrAqkVe5g0mJYiYP/Lu23ug5mp9pmx5iKfIDOvy
         Hx/YuNFE5Z7ktSayP5F6O1b+dzx0S6cyRDQs7aDlWT5xFTEgAcvvdqvBvjksBYoEfBJB
         ixp5BT/y/pdQJqKT5a7iZLXGnpdWfRlr9diLxndxepRVhVna5KEeTXyGgQt94yVKfmDE
         gYDqcN1RKQcmxAwlJxmVfK2AFUyPHdBDLPSdCQ+lgZjHYryMLkEqYiyvmqnElQnvusCj
         3wF4WcgLFch67Ybdy5LWEjFqNfH1RaqAQlikpn57hf6OXM2lW9B7747DOuun1PHWZzuE
         O8kw==
X-Forwarded-Encrypted: i=1; AKwUvBxOBvs57p+jgfsVHz2Q3OXAWd2JfgzZPu79ioKtaJa6dN2xPvEuZkpgMpvJdPLu4W++Frf95VQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lD331TGQkpJ+nzoXf0GCeKPyXSl83GiEqsEm59OWCKbuzn5l1
	/lK/p2CXQtKKIGpc2flGaxYr4KvtDXRx7UBQlEjrs/Ecmg50ntFUU4lS
X-Gm-Gg: AYBFou2T9uzalY/xKL1tg6pyTqeEI+6qJEaaDblX1n8l5AhxBlTyZwyx0rjVnyUtv1Z
	Yu3qXZ1Q7LQ+z+zL03d297eTa8Qfcj1gvajljId4BTe8u/u8iw/fpax91CWdUX6sOXd0TeCcB0X
	qBe5EL8tsw1wsoKee2cZ7KJuqaIObUAIqKzmpDaNB8Mr6ntVUHFhvZXyCzDj9jTL7OP842XVYwX
	Rm6+ESeN+ooqUK/MhmkbWTStWWwWpdhwDdFfy4F1QW1zdCwbwrCBcXsSE4fKubhcbPaz6pp5jGF
	Ew/rg9Ny1gsfXPtAALgLjqnr6gqKNNhs+iH6Jwso9BZHiRbxl2EUbqcJNYLEfHHiWoLg5+ndZZf
	LH45vuHRPUe3VD2MTaVQl9RI5ID6HVnxu8yzIlHd4kCnQ3PL7EIiwdb2U9/sUCDuFWoIEub6ZVa
	ioqjsKTy5vCaNH5lUcsvN+ahnBb/yfc1Aava69YJP/CwREi9oYavEP+8laLxGoxA7XM8GU2HDIY
	sSG9eWyT47W4LaQOm4emFEfNBTHnFbONEjrXi/a/0k+eNA97lWcYwQQrukSZS+rBzll3wnV94Cc
	t80eFwLu2oAG4bElc5aqOevf7Ow+Iu4Y6MUmNx2VZr1/BCbJEZJ/BAA=
X-Received: by 2002:a05:6a00:3a07:b0:8a0:465d:38ba with SMTP id d2e1a72fcca58-8a8322ac146mr8302901b3a.24.1793612849756;
        Mon, 02 Nov 2026 01:47:29 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d479dsm1802116b3a.39.2026.11.02.01.47.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 01:47:29 -0800 (PST)
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
Subject: [PATCH 1/2] Drivers: hv: vmbus: Keep the channel when vmbus_add_channel_kobj() fails
Date: Mon,  2 Nov 2026 17:47:18 +0800
Message-ID: <20261102094719.35760-2-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102094719.35760-1-izaiahsun@gmail.com>
References: <20261102094719.35760-1-izaiahsun@gmail.com>
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

