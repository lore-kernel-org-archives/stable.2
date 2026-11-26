Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661113;
	b=au8MD/eVzDmUHRxsS+dWczSyuHO3lf31FjIoVKXkAuhXpJqRoiyPB2KBLfrYpCUj+4Ig
	 SKnCRmFnJ4Jj+icmgqO0Me899YCz/CweTLi/xoBr2i55AKEGGvMDnJ3iScbKZoSC9JJ48
	 lzqxUC2Iwl1ccnzeQ5NOTZpF3f0S1Uu5x2PBVeWAXsq/5gYwn1fqMCETqNqUK8gMq1Pfa
	 Ap+ImSnkz0+QDJpUvh3s1w2++0O/NPzBymxUROlcfiGCuKE20IdUwiHJfQ6Q9lmoYSfmH
	 uac8yej48rWHGI5U6u1acfRsI/yDI8MFuoZOSi5l8dOBdl/v2Yt7l5K2EpkHzUNUf2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=ALLFS86xd4RGFa8E/7vxrVdTFwuvnAUj+VEWzSUqH4E=;
	b=F2Gbwa70qV58Fk9WOn3HxbZMprlqwEnqpLFRaIWMIx9UgBtCcXlq6kyuMdazjgcF/Ejj
	 MnlR51cepi0Km+1ZqBJKBIeU80+VHwkagvVWBNuIB+Jrl3NKdWOLCcvBCBzZYegkh9n5C
	 nmlFAMxXcEEUSoWX3GGEObF7AGgpzuvLPLmP5TJCLyJgwEGfUQYHqEij6udEr4GDjMjfx
	 iPlyLFHKrtHYt+3x3kX/8koJiwjgaSjq7ZIrJR8cW/dsO+rBA8bkPZ9hkqi0fRJutt+iJ
	 UQKD+lCyy4voD4CKynnjV0XjbYfx98ng/4shOZ0kMu4VA7jyDCVu6WbXt6WKmERUljQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=jDr1F7ns;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14CD606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F14CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=jDr1F7ns
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67dabd38cdfso6593944d50.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661112; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0D/OevzM8IKC128nSLEJUwRscNcUgR+d26KqhBN+Nr/b6jh08zIb03Q4eda/S6ey5
         NSgsc647SknAbfzQyVoUmOsB24aYKS7MNZZEfd8dZHFqQlF+Pw0V+xDDVKI45wU9ydwx
         zIcyKVex1GSuRw9OKhxaMcK08F5n76XUN86w4QoYNE2fKgter4Eyx6+6+BaO/AAqzpDN
         IGmQGWKPT8tUFq75fGOt/FLlHEGJlPC8g++i4xjW8wxmGPA+GmSY38IZ1VVnmOhPo839
         zX9UOz+VJjBWr7d+Yv70vogau2n/o/32YgtBEEgPG1V78o09aU2rgANtW5EOuNn511vO
         YzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ALLFS86xd4RGFa8E/7vxrVdTFwuvnAUj+VEWzSUqH4E=;
        fh=Cl8p86fIxraTdAPl9TMEjG1uOAHTz1nspTZpzog1E7w=;
        b=aE1HJE5Coesi1URdS4gSA4Goe79kzCCXN4QvAB3hHR+SyVrdRBLLzkI06rqmvLrHkC
         TqrA8ArAKkPTwwLkJkZ3W9UPLeymIdWvS2iCiRaaGMRF0qatH1PYTAQ960mCYckcF1s9
         pEikZz2g2XM+xMCfK1dA43TGX/mmem9UM1SJytfBWP7RNiajTxYhFVuBUvBFL5GnoeHr
         xBFyoHnkR0dLzGXPUK9K983qzxW1CrqFsPNxRuC7Uslqp8N91iHLZdB54c4218HJYJzv
         58virUP0fjx+NzzSYZoqTnHqZIHVICp5WPBUWgoJCXtBmxxxOAibRrWMDd1cvGNV89yv
         kYUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661112; x=1796265912; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALLFS86xd4RGFa8E/7vxrVdTFwuvnAUj+VEWzSUqH4E=;
        b=jDr1F7nsCR6aWEH0SCL/67Ab/lWCBWQBMeJyKj2xVMrxP83c6pMCqD3QIQwqGkC5LV
         wNanY1z+sIP+8xx1vutxgxX3Zuxy73JhN139y6HNMMZ29V4parQ8pBhg0unilI18nusB
         DZkMNXrP6OGSfuXAA/ofjfbzJNSTooH0vGzyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661112; x=1796265912;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ALLFS86xd4RGFa8E/7vxrVdTFwuvnAUj+VEWzSUqH4E=;
        b=XA/ao/AMXCcb+PZLCwKWvdBN3e549WYqHWVhm13WlroUhtygHN9AqH+ivmpegcas04
         b7gxCSb7mSdG+HVozVuvH4LE6c0Tcu2lMmjvElVAzMOylcXFTMQGWsoK5GRNhZUMYRBu
         0TkywQcYNtZvjsoEICr5VvWffABRK1nWJnOq6T+rZcDKkei9DuLNaeaI3HM1EOMTPvWZ
         GXLqjlgWyGkZJWYJir+/zEUbt+gnxvi4RN4tJ8PHIUKYkKSglfXOVmA7o1d38OuwZNaf
         W24Ms3T4xsCxV8+/08yltRIgDm8lqbg6r0y2x37qIlhVhxzbt3zmAJu5grNr2PuEVrgJ
         K6Ng==
X-Gm-Message-State: APuU4Z+lqPJluZGX4BouFkwgDuqlC7ko9YtUiIQoveUo9ewIqhwEqWrC
	G9ucudPe1+g2o0MYo/DMdqYGBv8rpleLnE50rQbupNpuuINON6vQ8IAraTcpR4S2pgPvv8WgPKL
	gRRMX+zDnsNNvKvUSxMWlt9+a8U0gcMvTMVdlZqrUZQl/qSprf9GTqZk=
X-Gm-Gg: AZFdTZfYKV8+RksNlF4KHvDLEkcsfXrY853utZwv6ID8JsiQFCrLg5h/rLP9ItUEIli
	Y3s5J+XNaA9yCsztA50OSxQvxJOFeLB7uRdP1ZFhepbM6jylBMxGYqQnx3QqRooKeErsfAa0nV8
	fPj2kk9g9GrfyKDAC6yoC5RpNHAz3LS3dvNb/rWI2CNbznMFUJnaMniYeLlCMyA6YkEeddX3BIH
	RPfA3oDcuTWXJiZtwW9+oIz49z8qE9cIGcjUeVco2herj9yyGjTVjQ5NISN4yHYjXaJL1JOfSYV
	VNjE3wz22BGIPcyozo79Y7OcInYSZbsf1BghLGyRFmle8FCXiTWC6kSLzKoQvgiK26b/X0Isd+4
	d5uaOehJPbmSKxwSdf2WckzYF8qQ18Uwpic3tfqgfD2wEIaIxthnKlGAtEnyAT2K/3u3k2ZqGwW
	ptmF9IyqkL80QFU3i0yDeI4+hpJfFvT9aTau5RxZ7ovFcxJA7Q27IvKKuzeul99yCtqWIpn4kRV
	q0ZLIUOcBjK5I6HLXxZ1MhKcomWYDrjjgKM
X-Received: by 2002:a05:690e:408a:b0:679:a183:27f2 with SMTP id
 956f58d0204a3-67df42ba9c4mr11119420d50.7.1795661112046; Wed, 25 Nov 2026
 18:45:12 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 18:45:11 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 18:45:11 -0800
X-Gm-Features: Aa3M54pg_p5M7dws-uZCLLDjGlQf6GfLFqOjUXWLdOYMZYdkJ86Xa9O1blHnpDY
Message-ID: <CAFaZ9eovUow4CR0U-iaUtFHbvf2Dk97Vs6hz6hZWh747R6Xr-Q@mail.gmail.com>
Subject: [PATCH 6.12.y 2/4] virtio: add virtio_device_shutdown() helper
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: "Denis V. Lunev" <den@openvz.org>

commit 0d8aebe089b4ba887e792884cf041ce9f1040ff4 upstream.

The generic virtio bus .shutdown handler, virtio_dev_shutdown(), breaks
and resets a device once it has established that the driver has no
.shutdown of its own. A driver that does implement .shutdown, to quiesce
its own activity first, still needs the same break and reset afterwards
and would otherwise have to open code it.

Factor the break + synchronize_cbs + reset sequence out of
virtio_dev_shutdown() into an exported virtio_device_shutdown() helper so
such drivers can reuse it instead of duplicating the core logic.

No functional change.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260624140846.2616797-2-den@openvz.org>
[ adapted to 6.12: no virtio_irq_get_affinity(), put the helper above
virtio_dev_shutdown() ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 8241024f0890..f70ae3a672f7 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -379,6 +379,32 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }

+/**
+ * virtio_device_shutdown - break and reset a device on shutdown
+ * @dev: the device
+ *
+ * Drivers with their own .shutdown method should quiesce their activity and
+ * then call this to stop the device the way the generic shutdown path does.
+ */
+void virtio_device_shutdown(struct virtio_device *dev)
+{
+	/*
+	 * Some devices get wedged if you kick them after they are
+	 * reset. Mark all vqs as broken to make sure we don't.
+	 */
+	virtio_break_device(dev);
+	/*
+	 * Guarantee that any callback will see vq->broken as true.
+	 */
+	virtio_synchronize_cbs(dev);
+	/*
+	 * As IOMMUs are reset on shutdown, this will block device access to memory.
+	 * Some devices get wedged if this happens, so reset to make sure it does not.
+	 */
+	dev->config->reset(dev);
+}
+EXPORT_SYMBOL_GPL(virtio_device_shutdown);
+
 static void virtio_dev_shutdown(struct device *_d)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
@@ -397,20 +423,7 @@ static void virtio_dev_shutdown(struct device *_d)
 		return;
 	}

-	/*
-	 * Some devices get wedged if you kick them after they are
-	 * reset. Mark all vqs as broken to make sure we don't.
-	 */
-	virtio_break_device(dev);
-	/*
-	 * Guarantee that any callback will see vq->broken as true.
-	 */
-	virtio_synchronize_cbs(dev);
-	/*
-	 * As IOMMUs are reset on shutdown, this will block device access to memory.
-	 * Some devices get wedged if this happens, so reset to make sure it does not.
-	 */
-	dev->config->reset(dev);
+	virtio_device_shutdown(dev);
 }

 static const struct bus_type virtio_bus = {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 2759e2c24d6e..2d8820c0832a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -180,6 +180,7 @@ int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
+void virtio_device_shutdown(struct virtio_device *dev);

 size_t virtio_max_dma_size(const struct virtio_device *vdev);
