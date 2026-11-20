Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157868;
	b=3tA1Dl5CcdyIwPa2SMz3umIRPcTRQeXBWNBQDG85H34nYTLB+airreED0lO9M8k59gZQ
	 4R6LIxiYD8dA+zekO/QPFQwlW3AelWJaEzQjMp7KiuGZtnEBD5GYae0zJnJAtaADhedjg
	 bSv7FN5x5urbEW2kHSNpSHC2xM3qAWvGoGQ3guPwPShz94HoBu/ykJBNzISWbe7Czi3ft
	 nVOa3U97cDkMnrjkhwNjpVv0PRhev4QbOsmFmCZuCsPaqnPqJYQ5AXCY1JppHcwp472vv
	 OPZYzciqyg8poUVeTTORERpakDhfRSexokPn0vvw1RFxB3ho6a3QDWU/0BB93BWqkIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157868;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NBl7BUSOYnRPC87LqfX8iZJG5fzomYTTiTT3HwOLflE=;
	b=H1SiiZSws40z17JgnZAqNwLb2KlXpCdi7VksfRmr1MyjNKNXMXBm23xKKWQTOw1uCbKC
	 MKTOB97q0FvBP1Y2ezGWxInVHEYZhj2NvpkFuMX5ZnyQQPWbMDTSIGGeUPqlZpuaeFLeM
	 hq1VG/pG6AX+A7wXy60GUnbkJJHL3ha9GgahQV38aFTu+XQ1wgAIWvggJl8k3ykIt2Jmj
	 6VYGbREps/tBHOXLqvhTTBB3dyt9H4S8b6NUHswK4dFYdZ0x8fQTAIHhyLEP4wSRL5WeL
	 Fps5hHpgoQZUPJrHtUS5fjWJZaud+iM/UHfghB/RgwzqLBtAijb5d7IgOqjXebMj5JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktdrCHft;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D539A606A325;
	Fri, 20 Nov 2026 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktdrCHft
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795157868;
	b=JirsaWeYoTIusIUdVaE0znMpL0D2RJFMetf0wlD9FczTdjjjjdSvKuNf3nXHDPsgtWQL
	 Rc9Oj7P+ZSVruLAITLkRvv7qo0waJyOOCwVHn1Cl74L1aa8cR1QUB+D2UaBrvIfNaj0RU
	 52FnnS1k0WQomq3GxEBv+MfwghjZAr5oUIrum5CU0kYylAAMcwBXQngSXQEQmGRtx5EyD
	 xICYKNgKo9MUc0Kdy98glNaMlzUmXI/MnQJK0jz4m1e9vZJs9XWTnvX22aUsUaZSXs6Fw
	 UwwnMF9E2HbTy1qfcaA3oE3z6C6nWPtb3FSMohJkSjX+3XyeBIFIHJOV0UIeVrhIDkA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795157868;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NBl7BUSOYnRPC87LqfX8iZJG5fzomYTTiTT3HwOLflE=;
	b=t5lkyjF6rMgUQPD3EKacEhB1ENLR6ds9K9XbTC35xp9OvXrqH3wyWUiUImgTEQcgVTPu
	 mLyv/DxmIUoKJMMbu6qHIjAdav3UG9l1Rr34sYzTpxqE8pHnS4laKpvmkWLFIyta443gJ
	 9PN+E0AwvZhA7Hh2yGxfgujTfAQkTa/9NEJM0qQ7dqextrfzqAUKuLZoKs3fUrOGiWLEq
	 Ul4dGXeWkgwxO63ZhHSD1x6j06geInSxr5qqwb+ox6afmGUwnM6mJd/7CSvNAe0Sg8+IW
	 d1CBaD3vALYsRL/yxWFnSJgzZN3fOBcnOqAZlSW9y3hJ8wIukuoxTIJsWYOh166Dgfg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D37751F000CA;
	Fri, 20 Nov 2026 06:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795157868;
	bh=NBl7BUSOYnRPC87LqfX8iZJG5fzomYTTiTT3HwOLflE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ktdrCHftSLvmqgkA9Zb26vTCrt/Qk67Af2PyThCqafJJlsVxGjSzER6KngrK5S0Ai
	 7lAZX+yh8YMVOruvGkAHnGgO9Musj2fAO46ih7ezE3gxpErOqHqUhV3lx6KSqUG061
	 iBpULp9IW5unnHoAqijVUgi9WbLjXLs9C0ViEp5Vlyttx0ytahJMmKwpdMTIOI+Oeg
	 hAjQC9S04Xz+G4iNX4PuyWz3wV00HekSfNqMhefV72HvGoUBqhIZPui2cPJajvwyT1
	 J8c4PHFLrmFbPyiEn07HkuGP/Ubktn5RNl/C1JU7l60ZR0kUqbAMKB7VPiD6u8hOdl
	 MDZZPZ7guhy1w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 61AA349731;
	Fri, 20 Nov 2026 06:57:47 +0000 (UTC)
From: Seonghyeon Lim via B4 Relay <devnull+forfortuna.naver.com@kernel.org>
Date: Fri, 20 Nov 2026 15:56:03 +0900
Subject: [PATCH v2 1/2] can: virtio: fix RX/TX stall on interrupt before
 NAPI is enabled
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
Message-Id: <20261120-virtio-can-ready-v2-1-0defda2af8cb@naver.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795157866; l=1758;
 i=forfortuna@naver.com; s=20261110; h=from:subject:message-id;
 bh=VdaeA38HLLllzuwXwpZQnruRF3RFDA8ms3izgQtOuCM=;
 b=0NmnWet0mChPlkOlfm8eK8hgyrc7mZxkjGIeDIrlHa4xCAz9bNBH/Qbmyj2K/OdCJ+iIhw1WE
 RlNf/UDdoTsDhKerVayRxLL8NuUz+OiZLIXuoBDNE2YfrOZlNIdckPT
X-Developer-Key: i=forfortuna@naver.com; a=ed25519;
 pk=NSzj4ReyzmE01C4q/f+7jqXzWqsN5NwQK5UsSI6ufiE=
X-Endpoint-Received: by B4 Relay for forfortuna@naver.com/20261110 with
 auth_id=1481
X-Original-From: Seonghyeon Lim <forfortuna@naver.com>
Reply-To: forfortuna@naver.com
Content-Transfer-Encoding: 7bit

From: Seonghyeon Lim <forfortuna@naver.com>

virtio_can_open() sends the START command before it enables NAPI. Once
the device has started, an RX or TX interrupt can arrive in between.
The interrupt handler then disables the virtqueue callback and calls
napi_schedule(), which does nothing because NAPI is still disabled.
napi_enable() does not schedule a poll either, and only the poll
function re-enables the callback, so the queue can stall until the
device happens to send another interrupt.

Schedule NAPI once after napi_enable(), as virtio-net does in
virtnet_napi_do_enable(). This processes buffers that are already used
and re-enables the callback.

Fixes: 083082a4e6d8 ("can: virtio: Add virtio CAN driver")
Cc: stable@vger.kernel.org
Signed-off-by: Seonghyeon Lim <forfortuna@naver.com>
---
 drivers/net/can/virtio_can.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
index f67d0bf09681..9055d7e43235 100644
--- a/drivers/net/can/virtio_can.c
+++ b/drivers/net/can/virtio_can.c
@@ -116,6 +116,19 @@ static void virtio_can_napi_enable(struct virtio_can_priv *priv)
 	if (!priv->napi_active) {
 		napi_enable(&priv->napi);
 		napi_enable(&priv->napi_tx);
+
+		/* An interrupt that arrived while NAPI was disabled has
+		 * disabled the virtqueue callback but could not schedule
+		 * NAPI, so no further interrupt may come. Schedule NAPI once
+		 * to process pending buffers and re-enable the callback.
+		 */
+		local_bh_disable();
+		virtqueue_napi_schedule(&priv->napi,
+					priv->vqs[VIRTIO_CAN_QUEUE_RX]);
+		virtqueue_napi_schedule(&priv->napi_tx,
+					priv->vqs[VIRTIO_CAN_QUEUE_TX]);
+		local_bh_enable();
+
 		priv->napi_active = true;
 	}
 }

-- 
2.43.0


