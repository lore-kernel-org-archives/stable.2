Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157869;
	b=d3l576rJrLYuAycgu7/8hVA1YOf1+xzcsc6ZBYTR1o0YU1ie1eni9Vy6zlvK4pdKRdE/
	 cC5E6r8mfbi1dTTe5Bm3nXcpQzngTkYRZQSaocX0DmqhvURg7Pw4EzWjqpG3IZQr4CrvD
	 LYq9rI2HaiHU6CJioZGrg3AqGK8IYdqTVySs1LykfDULFY/R7Tw9sze7HhIskz0Cvh9iW
	 4ePp1vhNZoYnQFWEYFWXg2TF77+gsliaQaZCWLRZTQWP0atSAfUGzKG9lV5FGXtDs1lND
	 Tyhz2c4+/PQbyRgxASD+nrtKRR/mTSbilFoIvtNG9vEhTAip2lbJoYZgMNbT6H7sGNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157869;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jW6OuUPNtnY3yT5tnkI1u/PZfc7TEnu9nSLgTSDG2JM=;
	b=3mwQ7X8QU3Swdcm3pPDj2iGAuAgDPwzU9rzUqr6IEDFH4/YxrXEJEz6kkTDlxVMMorYa
	 /T8EAU2z63G1s6Z6VSq286zuJ98JWdf8XFAlVKO74kPvVesPzob1xL4PlUMPxVurl/NM/
	 SKBxZmGUj8I+PHIJCDf64qMUe6Y6uFCNvwRuu9Fpr66A3+zPYdzAL2sMYivHzzIifnkG3
	 lXAhyyuSUc9NAGvcO4rsRh7rURhWp+WK7xIj90KFWg2pJHhn0hhwo6PxbyoQSsQks6K1F
	 EeNKoGHzbWLUrX3Ji1o9G9+Rl2dOnFRs0AgI3LGvgq+02qTMgvrWSb20uz2PKxUX7qQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2WtG9LR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC745606A326;
	Fri, 20 Nov 2026 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2WtG9LR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795157868;
	b=z3H7jZkG6S0QmQmf3SRAB1N1FsxncCj988mrUsOVQmGlzQ8nkjX4BYdQ2+qVS/PJRjpB
	 Gj2C5jq3pC9x2eLOH4MlHBo9Id/pzGAHFWX5SDYAeqiZxjaWYH8DfI0L7XrWe8L1GVO3p
	 314I73SSNoIm7tDSzpVGjpcz19ZM8+QAdeO9NxbqEUtVlXehyBU9uHnpgpd3An63z1HTe
	 BrzRNRUuHb7Dqm26MXFDkXUFZXY+QKq6B8irn0ygYqU4DBoVpyz3gUsJ3ns6MSOj/OWpL
	 RQZZyBRQZJ4PoMA3i/4vWY8Fc/to1bnmwKvO4+CDN7L7CNXZij9zE2xPCYq39o7c3ZA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795157868;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jW6OuUPNtnY3yT5tnkI1u/PZfc7TEnu9nSLgTSDG2JM=;
	b=ckAmzG7oIAAPvdxOdpHNZ90UhGdMpHdsXRyS7sOApfpQvOmCZWA8gVwXUQ3W6YxR64L7
	 ByMiRRvgU5cIeP1ZwnUVq9jQdHQNQpihCZ6/FSr9aHMqR1LnPjYzLmSGeoXN40HkBgKZt
	 M9cnJ8Z3dRT2TN/H19SuCD+5kNzGeHg3TU/+IJn0D4Djlj3xch6ZZoFfv9NSpQR/l1BEJ
	 UHg7+oYsXwhuB5fCIDeAkv07ojESX077j+wn774hHjdF9G84NsAk26CX1UgYNiFqNoZdO
	 RP+oi4IGp4qx/FOSkuCW0o3pwpbiDN1WVpFMiOSYv2f7XPx0Rix9bYoGiR8FnLwMIWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EC9CD1F000D1;
	Fri, 20 Nov 2026 06:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795157868;
	bh=jW6OuUPNtnY3yT5tnkI1u/PZfc7TEnu9nSLgTSDG2JM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=m2WtG9LRVESK2kylSTNxVa8zgRCwjtYlsXm78F7jJEOiTqliAN44ka5iR7+11uTbW
	 ZBsySgEc1RAlBpXt9JiF2VnEEuuEW9AAhtYjpRGa3LKQW0OnvK+8RL5foGvdPcRYun
	 G+XxXTUFlLozn0h3j1p+JnAr4VNZlU/WW54X3uwfWjQ1LOnC/7PddkUbzjfAQ5UwbY
	 fJzyE6DRjVlBtek1DpYQFRiygkuIS/Qbx+N9WVvxd8wz0D8FGyHCva808qnRLsHHXP
	 Uu/NNMJFR07ZGYV4Z/i7reAi3tQNixA/4Ar3hY4LNcjIM+MiJ8piFDU14k/jzu9KXe
	 lGXpJRrLLckJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7AAE049732;
	Fri, 20 Nov 2026 06:57:47 +0000 (UTC)
From: Seonghyeon Lim via B4 Relay <devnull+forfortuna.naver.com@kernel.org>
Date: Fri, 20 Nov 2026 15:56:04 +0900
Subject: [PATCH v2 2/2] can: virtio: fix virtqueue use before DRIVER_OK
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
Message-Id: <20261120-virtio-can-ready-v2-2-0defda2af8cb@naver.com>
References: <20261120-virtio-can-ready-v2-0-0defda2af8cb@naver.com>
In-Reply-To: <20261120-virtio-can-ready-v2-0-0defda2af8cb@naver.com>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
 Francesco Valla <francesco@valla.it>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
 stable@vger.kernel.org, Seonghyeon Lim <forfortuna@naver.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795157866; l=2078;
 i=forfortuna@naver.com; s=20261110; h=from:subject:message-id;
 bh=wIY55Nih6Exr0WUhi1Tyc3EiQfNI6qtLKhOXoT4e7Vs=;
 b=iNTmLb2IWMi8elzzOk5J87idYxXeiL/HJlLHubu6TkFR6PvPZZ2EtrbwqEf2/9Hg+tlrRCNfC
 kqvNbXf4G3DCr+iziYwoMCePuJlXRkNMSecgnlwE05WyIN+Fch2rUMB
X-Developer-Key: i=forfortuna@naver.com; a=ed25519;
 pk=NSzj4ReyzmE01C4q/f+7jqXzWqsN5NwQK5UsSI6ufiE=
X-Endpoint-Received: by B4 Relay for forfortuna@naver.com/20261110 with
 auth_id=1481
X-Original-From: Seonghyeon Lim <forfortuna@naver.com>
Reply-To: forfortuna@naver.com
Content-Transfer-Encoding: 7bit

From: Seonghyeon Lim <forfortuna@naver.com>

virtio_can_probe() and virtio_can_restore() fill the RX virtqueue and
kick it before the device is set DRIVER_OK. The virtio specification
does not allow the driver to notify the device before DRIVER_OK.

In restore, if the interface was up, virtio_can_open() then sends a
START control message and waits for the reply. DRIVER_OK is only set
by the virtio core after restore returns, so the device may never
handle the request and the wait never completes, which hangs system
resume:

  task:kworker/u4:5 state:D
  Workqueue: async async_run_entry_fn
  Call Trace:
   __wait_for_common
   virtio_can_send_ctrl_msg
   virtio_can_open
   virtio_can_restore
   virtio_device_restore_priv
   dpm_run_callback
   device_resume

In probe, an ndo_open() right after register_candev() can likewise
send the START message before DRIVER_OK.

Call virtio_device_ready() before the first virtqueue use in both
probe and restore, as virtio-net does. Config change callbacks are
still deferred by the virtio core until probe or restore returns, and
virtqueue callbacks that arrive before NAPI is enabled are handled in
virtio_can_napi_enable().

Fixes: 083082a4e6d8 ("can: virtio: Add virtio CAN driver")
Cc: stable@vger.kernel.org
Signed-off-by: Seonghyeon Lim <forfortuna@naver.com>
---
 drivers/net/can/virtio_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
index 9055d7e43235..549e8d789d74 100644
--- a/drivers/net/can/virtio_can.c
+++ b/drivers/net/can/virtio_can.c
@@ -925,6 +925,9 @@ static int virtio_can_probe(struct virtio_device *vdev)
 		err = -ENOMEM;
 		goto on_failure;
 	}
+
+	virtio_device_ready(vdev);
+
 	virtio_can_populate_rx_vq(vdev);
 
 	err = register_virtio_can_dev(dev);
@@ -979,6 +982,9 @@ static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
 		virtio_can_del_vq(vdev);
 		return -ENOMEM;
 	}
+
+	virtio_device_ready(vdev);
+
 	virtio_can_populate_rx_vq(vdev);
 
 	if (netif_running(ndev)) {

-- 
2.43.0


