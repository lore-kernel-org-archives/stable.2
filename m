Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674982;
	b=kroVGdOL1f1JhYQKtb8c+8c2cqZ843sFQqbQEgHxMRUdzvVdl2z7tOA1qjue7tyTvBCN
	 WiLdzwRIMr/hl+VziDGgKdhkKRPUc/gOYu2BRrin17EgJGnkIdFuhc1lAPSMErth8JStL
	 P8IBmZlK8bSCwV+MzKYnbftPX9gKxbtpHT8GHIp9/W0yyHzJC66Vk6ncy913TcC3rwFud
	 wcHdNORLbLWTlo14dNrvKhybrWH1jA41e3bCe2XTMydDToYnRcTWsK+mF5fru9RuKMvwc
	 rfj/Nr3gIL+GXRYoreInQ3FFicV0sJXLaPfGJGT8JhitBOUfQffL8cvO9bm8XcfTHVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674982;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=VJsAMOF2rkfJ3G8mJjIbcPeXjvkmAyKckkfRPNeTBjg=;
	b=5iL1b/kpAwH331xZIPyv2Y+hZSX+B0ogrYW+OhhVqim43+dj7LvlEbeKRPaaYprusHgx
	 BXXuYlxzs91h4qLv84sSELcEe8yX6X49UKYYffIwk+vYttLbeHNJZIV8ygeVSyoMd3OTZ
	 vbRLtvOhAXVoouU/zV7WIfShRDbneFlG6pQwrtchG0jIWzwZCSNL8A+K86zVTRaa+EVec
	 i0B6p5ww2/bUeSBHmkLUCOJ4VWfuiYCfU1g9VHfC4bmW8wnYpI0hAIN/H2wmIf4KyjNVD
	 Dj7+3rLDoJnPK05mtrqfuBP9Z2rVRVjVkvoqG36c5IwREGOXLKsocBGDdVJ/rx49h0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL6RAxIl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3AE606A321;
	Thu, 26 Nov 2026 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL6RAxIl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795674982;
	b=S46bG9yg79TzA3/AgvpbgSaQX9KFpMQIysJyDDuL7VOsUGY/GB1wzBwVS3dJo0/rpuHW
	 bSfyWEQ1x03QlKVrg+OTc5KTAc/rsgsrQ3TGZ82Oj7FxQrX1D6Cj40J6Vfdf00t4oWHFM
	 al3Lp6jfA69V5H2Vg27z8Ed9fdJQ25pG8BkuoaYseFE7eEWnkpu7loE8RacwElo1UqhpZ
	 4d2Xx7Kfvx9MlH81uun8lFfWb2Dzl3Mvv2JRp9k7QtQuzj57zaiuCr0jd0daWtVgLbZmO
	 SyWc6F/IWzDCWhG3M0pxcCTcmqFepBmXSP3wM8Ed28ezQEohM58VqL5UJ1awle1HGLw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674982;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=VJsAMOF2rkfJ3G8mJjIbcPeXjvkmAyKckkfRPNeTBjg=;
	b=kI8zrSOL7DngcdMUjWCDHdMJg1eyclI5wD9c7uuPsTavnM54MZwGNq2w0iP6LeVrN086
	 XYKq4/F2wKhcqvzCCuH155bJ1bgc8J9t8tsJwMXZpBZZ7xip0h+rOdUpKN3fTuz9v5KRE
	 /jaEQvfwC6JUf4krbn2bUMjxY2HAYgJVmlw4zjM8WZuSQwOvteKHlCRcmwHKCcHzXeTmv
	 uqyBynwDaRZfGLcGW0LOkSRqlVHRllhdCQRJdFW2Hvo+dVL6fUGsrkqKimfZ6lc5IH2FX
	 6gFpc0caGixYmscXRJFj4ucv4cCgVpUQfrGLYcDbHX64nRZPD0Xl3SY+KUfki+ed7QQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 812731F000D0;
	Thu, 26 Nov 2026 06:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674982;
	bh=VJsAMOF2rkfJ3G8mJjIbcPeXjvkmAyKckkfRPNeTBjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hL6RAxIlMQ/71cANW2iih9bYKzAxc+uyzKqtAWMzRga9gTDg93G90ABDJ+CAqH7bY
	 y8iEMzZfiQDgTLTo32Qe+zA3KGedQg4eBkef6HZ9Plb16zR6FD3/OyvkVEHae7epJI
	 5QpUv9MnrQXBrqX5VDbH0vkHJQN6i4WDI+ipETnr9DfyVK4in/nsvcOBw5OC7YZl78
	 BVXLYufqX3/TK1vYkrwNJD9ZP7GlpJMoKpsB3rhDs0w8WF0yXIMuAycQeyZGKPkxGs
	 n9f0zYH8bHvfR0W1vrFOd5zDlmvZZw36J7UGauymUTjWDVGj6ME1fOJLRYwiI5pdQO
	 eDlJtwQIdd26A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E98E84D289;
	Thu, 26 Nov 2026 06:35:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 06:18:42 +0000
Subject: [PATCH 6.12.y v2 2/4] virtio: add virtio_device_shutdown() helper
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-virtio-final-v2-2-4cfd5590e924@certik.com>
References: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
In-Reply-To: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
 Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795673921; l=3867;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=IcRCbKCQ8/HNKH9FULxInqnnyB/eMIUHgoJ8eusL0Kw=;
 b=rC4KBoBX5N4hV6jb97hQRvcrTjezt/PyFAPDtSODnOGqv9FIRQiL0SD9YvMyJMo96S/9bIy8C
 BwLoujBMBLNCRIHaEa6khzswu6ngAVE3A9X/DDbaWL2A/LHfjRR6RS0
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

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
[ adapted to 6.12: no virtio_irq_get_affinity(), put the helper above virtio_dev_shutdown() ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
 drivers/virtio/virtio.c |   41 +++++++++++++++++++++++++++--------------
 include/linux/virtio.h  |    1 +
 2 files changed, 28 insertions(+), 14 deletions(-)

Changes in v2
v2: resent through a whitespace-safe path; v1 <CAFaZ9eovUow4CR0U-iaUtFHbvf2Dk97Vs6hz6hZWh747R6Xr-Q@mail.gmail.com> was damaged by my mail client and does not apply.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

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
 


