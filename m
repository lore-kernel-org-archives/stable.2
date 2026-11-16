Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821098;
	b=auoxemHP+d1cKXGja42N+v8Lr2ouc2KzTsvbA1vQTTBnPjNkW1qmKvNLs3udIBBLqrD4
	 ngneNKqQsDKLQ0eqgQmqb0hwcULL1Iw+HZmb+m9mbZruLEJ1rTRiSsb6l6rORkK3cX3q2
	 qmVhCByQofogOphPq9y+NUyMIpX8HgXBDkDQMxKyhz+t65HSgNORZv1RhOPTIyC3HxPXf
	 siSSq/D0IhhGBQ3FtpsUndXewSNPBbHZz6JmBdR4EdCOu4o4X+GDPlOi6SO3dBgZ5KO8v
	 qenSHUENF/LE3+Vp20Q2cY6EtNJE2koB52SDsZJ2GbqA+Z7JDku7twJXAHCGF04TQuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OD644D4H+a0ZXJYlgxiiTnY1kkzCbvWk1YLCk3rxbKU=;
	b=UOi5g9XxZWLQN6Bl6gNJvsHNjCly6PSOYE3Iyw1m3Kcir+6Mf4EuOU+cNZZZ7XLV4gWK
	 BIwJm0ttaOO5/aYnjunRqIXQf/AiDiTJzBFjGyZA0yN/CnaHkzfGwdenKbS0JqUHwbeSe
	 7kNvWl2ww7kC1fxZX+ahoPShx7R3lnegXGPYL77BxKaKqaJITOVQDnUhozJUN7JHxPIr7
	 evBBHhWTFT4r+wvwj90s0GOqQPlZaIZChimyI283QObc4rRvkRof3toirqrY5rm4k0Ro8
	 MBhSq7dXZPITsh+5jW/Xi8otn2N/gRJ52SnMKPO5ce7/kK4Lnm4ckarLphUMPqDcegQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=LUWMPzOg;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DF606A33F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E02DF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=LUWMPzOg
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-37198ed3727so4775277eec.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 01:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794821097; x=1795425897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OD644D4H+a0ZXJYlgxiiTnY1kkzCbvWk1YLCk3rxbKU=;
        b=LUWMPzOgW5io1fePlO8evy7T9l3udKkwmMDkV7TL7j/fbYoR0NRRp3uVj6pbeI+aUU
         gfKzw7/Uk0SV1axC6PEX5N3nG7CyUwm/Dwcz8S3brfsR6N4snhWmaFaL4ldu+sYLN0ks
         s+kd3TZ583yrwtZZKLilrx8n/fPvN1qxDpSMMERnGSyPni6w8m0YCsJeXOdvCZCcBuei
         TqfeW9CtQkq0Km4axUZ7QajWSxSEP+MntVadYBFt4kS0PRskn7GS6/NMNz6emBmk64Vy
         nfCA8K3AoWA50kRrZzfZ71oei32BErCbIoC/H+pNLzkmpzecXoMnYhIMr4oRJPL0W63u
         dcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794821097; x=1795425897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OD644D4H+a0ZXJYlgxiiTnY1kkzCbvWk1YLCk3rxbKU=;
        b=Fosczj62vQQVJeNRLAML2veUv7zpxqm0aCybhWQpvOlkXUzvLRAIXER79zycD4jNMz
         eygYKdGVEU2MmY2YPS6kP7Ov3duK3A3QT9xbgvHoKNCFu1GungE98ONvCZ7Tbi9uAu52
         MwNKAsVMGqTVEZobpegMFF3bKRbQy/+Ez++JTs/Cmc5goPVRYs0Cnudq2MzYi6rC8R2e
         AIgsWpasLEpdelivqDaUzPoO1eH457pbb0Bpg0R4D+geyBw/TwGIW87pC9hfauTcn9DO
         xF/pG93cefGDZRV+LE9Xp/JiZESxPVPCy/+INILUya/OFisdUpXEXZWoAOse7delPhHJ
         4KZw==
X-Forwarded-Encrypted: i=1; AL+hErGfUJQuLRyIv0vwGEsp7xTwRitbd7RlP/ZbsooWHsITsibyHg7zL8AcruP5YWvU/M+yrkQFmSM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oeMdhyET5KULqZ/MZKoFFPhdnEMj0zGbXK2LQnYluyomEay1V
	8ePHvlOCn6QPO9nkAOOhhfuTUSHoiGDvauhdr4+5pFO58KW2UDd7v6ETSZMcmnrnfg==
X-Gm-Gg: AZFdTZe2ieYuKjMp0JhRhGqkpxg9UJESsK6Gys7u+zfJKD+LEYTsCuipc34pIPtZLkF
	gL+NltoffSpVD8NEh2KhZgRyM0tpSv0ABXTQthB2ncRVG+LT3c20d/zvJv+S7deOiWpgBeLke6h
	kgMqtBK4x8+Ng2eXfr9WZeqV2ttYo2aEvU7Ot+qAYQwYKqPHvdbVLOkSpvay/sbLFqkzQbYdl7Y
	hWnmxXWNon+UDNnPTTOyol0YJosbQ6WlVVd123uG66PVTpYzjYrZhtWwBR44X4FT63f/MoXwKQe
	BDa3dt6CB8UDyEH8e/ppWd3Bv/ndzkuQyqSSBKKmi2I8wMpjDQprZnnVL2WMdttEfntjNHcURZL
	YLrBlBJoNXttxxlwlr6uNYQixcX9sT8aIPi8r+Eg0RQnguLvP8fk7z2kfYWVi9Ue6LVxJ5C0Koi
	BWzloGGldOJ6zo7+yz6w0FBp5TT5+JzpBYoPjavDARDrhe0SqKmw9CmXvAfT0e/yBbuzcjrSNF8
	c7A1xmbJ9LY/Hl0QJ0zrMtNg9MokV1yubrxh3z+cNeK+ZdYu7qrMJJggo9y/RbmMXowRBm/tz8v
	cs/d+5wkTxv+bOoIkvavpqT6XeO5Ou87fViAU6uroGipbmLtsVVy8KfJrWY=
X-Received: by 2002:a05:7301:4718:b0:375:85ac:d14f with SMTP id 5a478bee46e88-377e10172d1mr11175901eec.14.1794821097026;
        Mon, 16 Nov 2026 01:24:57 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm32056314eec.26.2026.11.16.01.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:24:56 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/4] virtio_net: keep reads of stats records within the reply buffer
Date: Mon, 16 Nov 2026 18:24:44 +0900
Message-ID: <20261116092445.3391334-4-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
References: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
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

__virtnet_get_hw_stats() only checks that each record of the statistics
reply starts within the reply buffer, while virtnet_fill_stats() reads
the whole payload of the record's type, so a record near the end of the
buffer can make the driver read past it and report the heap bytes
through ethtool -S and the per-queue netlink statistics.

Fix this by reserving zeroed space of the largest ctx->size[] after the
reply, so the buffer can hold any type of payload.

Records of an unexpected size are still parsed, since every record
starts within the reply and cannot cause out-of-bounds reads, and
rejecting them with checks per type was judged costly to maintain [1].

Claude Opus 5.5 was used to audit the driver and draft this patch. To
reproduce, the virtio-net device in QEMU was modified to offer device
statistics and to end its reply with a truncated receive record. On an
unmodified kernel, KASAN reports:

  BUG: KASAN: slab-out-of-bounds in virtnet_fill_stats+0x66d/0xf20
  Read of size 8 at addr ffff8880036f5940 by task ethtool_stats/159
  Call Trace:
   virtnet_fill_stats+0x66d/0xf20
   virtnet_get_hw_stats+0x5d6/0x7c0
   virtnet_get_ethtool_stats+0x11b/0x920
   ethtool_get_stats+0x150/0x1f0
   dev_ethtool+0xaaa/0x1be0
  Allocated by task 159:
   __kmalloc_noprof+0x1b7/0x4a0
   virtnet_get_hw_stats+0x25e/0x7c0
  The buggy address is located 8 bytes to the right of
   allocated 56-byte region [ffff8880036f5900, ffff8880036f5938)

With this patch, the same reply triggers no KASAN report. The
drivers/net/stats.py selftest passes when the device answers with
well-formed records.

Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://lore.kernel.org/all/20260711150754.2918392-1-michael.bommarito@gmail.com/ [1]
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20261110001659.1654289-2-kuba@kernel.org/
Fixes: 941168f8b40e ("virtio_net: support device stats")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v3:
- New patch.

 drivers/net/virtio_net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 498014773242..b9b6c915b6f3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5071,7 +5071,13 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (!req)
 		return -ENOMEM;
 
-	reply = kzalloc(res_size, GFP_KERNEL);
+	/* virtnet_fill_stats() parses the whole payload of a record's type,
+	 * so reserve zeroed space after the reply to hold any payload.
+	 */
+	reply = kzalloc(res_size + max3(ctx->size[VIRTNET_Q_TYPE_RX],
+					ctx->size[VIRTNET_Q_TYPE_TX],
+					ctx->size[VIRTNET_Q_TYPE_CQ]),
+			GFP_KERNEL);
 	if (!reply) {
 		kfree(req);
 		return -ENOMEM;
-- 
2.56.1

