Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794377930;
	b=lp+RRg9z4PBz34iCgL4riIYNDr9an+olPut9tro8p3CR+PoVp3zaNSbqYV1ZuDWb4kQY
	 MBP35uM9XqGajOVtMcqT3vsycmQ3y6UqqmwTyJoLF8J2Wgd9EJMseZvJ9XxSKRsIRn6de
	 UYWs5/aZit8W5y94MYAG+gyqU6Aj2hIt3nOHMlO3dzsOPf7FhFQHm6DX3ZQ3uPR59v42/
	 IW2DuALgeKTv1ZBUM1kKhCX1pYcn9ijzDzIr6tHFIq1aDWqH3Z0i7ISnPEruyr8W5e7EQ
	 QyQUgsEE8W8skRYvBbc68UKkWR2MzBve0Dst99pP/k2lFtXhYdIWn3mxZTb8bDjCTpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377930;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hoOu0Vyn1UsqFVigZaJGQ7Rr3+ALT0LUzsBJsVYCYy4=;
	b=NAP2FSw6FlS9fAfvLLKX0SVfBzH41zVeqXB12U+jUzORbuwr+5VAETAiwOB16od2TBAw
	 aCJWPttrut15IDy8FoqLCCfXzfjXfP1ycuR1iL4KwDjeM3gi0Oq0HONU1CTURq90n6CWH
	 5IiuRlq49iYMSOX2xsf+YBqPcm6FqNZHFcWuPRERC87D+8rbBU6P2DpiUYzicaQcAhkyH
	 ySKoy7sO+5AOKV8JY0VV58TiczfJFHmp5bc0yUKbK86eTLJht79xyJW2eB6oxhkeL8iog
	 KHw8Teev7KSGxveCUQIso5uLy7xsq4yiX+jtjSHYtwX0oYVZnYsvAOsr24qFDGr9zyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoURBaUu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7660A260D;
	Wed, 11 Nov 2026 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoURBaUu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794377929;
	b=216DUp4uZ3WBDteR286stRj50ke805zgpqtUdE7HXYsi0cUsw0cV7kG+J+LmAt+XVNnW
	 41F3584IT8wjKqEsrrHhpNcnatjpByu+GUQhhzC9qzfM5nkaShCezU19apG05cvkeswj7
	 uRDvCtINowrj0wGIS0sfs/ZLK68EMKnnQIvZfNKvBqPtbRPMl9KCdLDkpVw47Wm0S+odj
	 hs0sicEeFfUOJEEBQDRab8KgiifkoPe6OMaA/ihvVBZTh4Vmp073mx7GsDxzvntyTi8Xe
	 DiaCT1gadqXLZ4xVJDcIk193WW43HqjqL8tdN86HAtw4LxD7CdBXhTXHqmZ5xtsz6sA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794377929;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hoOu0Vyn1UsqFVigZaJGQ7Rr3+ALT0LUzsBJsVYCYy4=;
	b=QYzvfzLdSIdyHPS68tnxXwGQW2eFZjMpoEf0w5E3ZMO2/xnyxAbg6a2AUobezvWWSDBO
	 QLrCSVb7DPHz4nSp3ms/KQGbay48HogNeynZ4XP5BFzBK3qb7hiodRWCFFU23zV9a6cmI
	 AXfbtGePpRKHr5BFVjCdNUBw/64XLIJyjBW1ZRnxC31oN6KUwwbhV7DK+0d08yHyh73Wa
	 BTG4ZKHFqowwC3fqNRF+glfytW50DQak7kXHZen9QPp+m/oIo3T02gP8CECCK3szqwqAm
	 1Eg+rwgrZBip6YFS4F7If6fKwQvuBsXf+KshJJRmm6LFOvge1ZYEIYtLmSTTPjDE6qQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EBB181F00A12;
	Wed, 11 Nov 2026 06:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377929;
	bh=hoOu0Vyn1UsqFVigZaJGQ7Rr3+ALT0LUzsBJsVYCYy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aoURBaUufw5/fHZfLQdFEBlX9DaQaNXXGtUcxa5qcRuhccwTy67viOZwkLIZS3I9e
	 eBHRDX8TFb0SmL09ZrnWi9/6qeH8na8mhMaz0f2GoN82lTQHXP3sk4T14EWq9D4FKP
	 eqxX/yAU5jgoyZCf+sux6fvxES/x7tDGCTKsv395CjzgH7XrTX/ORIaJ6N7MPLO2TG
	 yhiokFZoxIotDQ3YYi2m2076GG3mONw+actSdbwM2F4kzffG9X/OnYcdqzx2rqLTzI
	 kRHjUBmtlW6U6QbIbB/ah6wTzwO8IUZOR61La621Eozd7Z/XxeLljhoUMl0OYTdI4t
	 BjaVTFCb5jJ3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 44A1948E16;
	Wed, 11 Nov 2026 06:18:47 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 11 Nov 2026 14:18:01 +0800
Subject: [PATCH net v9 07/10] can: rockchip_canfd: disable RX offload on
 open failure
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
Message-Id: <20261111-rockchip-canfd-restart-close-v9-7-6643f3825ba3@qq.com>
References: <20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3@qq.com>
In-Reply-To: <20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794377925; l=1266;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=cT3cBscQt29TWUgsPQ2sU0B4DpllcnyjvFZowBvWmU4=;
 b=yj9CFU1T9ZoIcbtEbKptVpCa4LLjpRt9oyMuLEGibgfcaOOV0Ojsn7RzSfcIjNTGcJaI26OlG
 GN2mXBQ0wM8DWXos0S9508BXiEL2xB6YY5ALn2mcghjj2H3Y3RNrFXy
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

rkcanfd_open() enables RX offload before requesting the IRQ. If
request_irq() fails, the error path leaves the offload enabled. A later
open calls napi_enable() on an already enabled NAPI instance.

Disable RX offload on that error path before stopping the controller and
releasing the runtime PM reference.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v7:
- Split the open error cleanup into a separate patch.

Changes in v3:
- Disable RX offload when request_irq() fails during open.
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 59a79fe057e6..d05264605efc 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -747,6 +747,7 @@ static int rkcanfd_open(struct net_device *ndev)
 	return 0;
 
 out_rkcanfd_chip_stop:
+	can_rx_offload_disable(&priv->offload);
 	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
 out_close_candev:

-- 
2.34.1


