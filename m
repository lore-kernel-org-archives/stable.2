Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2444F57D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752760; cv=none; b=frt4Y5jaLQMXc3rQGbY2/kSBbPTtABw/gnalAVT3SU1CvUfDgF+IvK73f4YxN+TEGHw44BuqCWtfi8qDHWzgceRa5/wKUE09IUyfMbCyzRwU+ddZuwRX41rctSev7gSuQe3NeDX2ysR1gnavA+g+NhoqICyYI5JR5l1Fud+ldyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752760; c=relaxed/simple;
	bh=aJVsoy5Trk1oVXSy6lO13HBYy2aSxZSVKLzYy8qqiKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bc0lKAe0ixYMmhgqvzadS8oKY5phXIKcwpsKaMstoCMR/2XUiscavKfWllKBuhJ2MDgxSZQpSm+RDsGKq53JoNvgYG2521hxE1Anuqh4Ansr67SZD4KYTlU3bxjggdvxfXeqn6eTQX5T3ipYh6DfBDvoIRuYAiU9IMg4zMzt4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcCAB3cU; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcCAB3cU"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2d42b972bso7682655ad.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752757; x=1791357557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtXRhGuw2qVKHIOiXDCs7JborWUyDWhbjStFj79j+rc=;
        b=HcCAB3cU+UouU2Vh+4JuDZ1pjHM5Ba62oUWGDj+nGEeXw3iLRSwv4uUmA1yUj5tLY0
         4B6AUdrKPk4977leORDoQS4T73H5y4bjxuUvwteLQSciU0mdkIgo1F+gVSEZfeg+NNLQ
         P4CtAfxfG+iuidcokb5r2zO68rbWe9A75hn9wZ6jmOGMsuzjb6DmqsOiUxFeiJLxBK7J
         HW3s1wanYjCb5Ge5ZP5opgqTUjyi1SncMKFBoFleUmBkl4aQTkpPzKh9TeEkSW20Bdgb
         QsIc6jlSkLdtE5GiVvlADm50LKA9AIyaCGY+Om4IQyyS66d7PUaG4qVdrK6pGn3VvJqq
         R0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752757; x=1791357557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CtXRhGuw2qVKHIOiXDCs7JborWUyDWhbjStFj79j+rc=;
        b=1yLUpcBrNhshijboTDan4QQK03StIMAGavASgtA+RBlY3LNVm27wEKZaBS2CRYfYFj
         v8JPB+5LsACW3p9XYAkSH1DItE6P/v1C1TRR4yV71A2RIKlNNFh94O/AvHgjy4QjxqG6
         MCWIjsOayA3mrhN+fVf+vvRL35BUYQOaeuSVjba1Qw7Xy1VzGITbHRrmqMskxC3lChW/
         4Y7m1Jne5/rB3vF9gQuzc6Tr9ATNx1YSPFox9KlS8E8ihpW73dfhaV1hj9zi0ya+HJUS
         C0Q2IO32Fh1FxE2B7/iVkh0opHqIpBKFKdYOhFkVA8GKIGDi+DRsbOgqSr7UZsre40kC
         GrTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTAee5jQJKQ74l8JJDDaZTEyrys7yaeixJxu1pTWz49gswgXEABmh82YzvV2EbWatMfrIby7g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQW1WiVeqUnphnjPk7cMqyLHkz11wIsqC3RGxufGDfNPqY2wD+
	A8X8fFtjFIUqZhyBoKj1Rk94eyED2AUMQ6ySrWcSeRedSs3gDh6CiwFL
X-Gm-Gg: AYBFou1ovJy9RoWKUHeENy39y7bL+a0NCCqF2qJvJ8zPa9cvDJrZ9PYgL9zse7ZeV0j
	SM9KX9GO+StKQLtPGLUFX/tK0U2PnZviHl8Z+xXiq/cRyPDvLB/ctZ3fx+CUb6FklzlOUKaTA9V
	vz51h1sGmFF+UNjxTYvhIRXZObar6QoNRY1rPVyg3TUvZkiBx/ZcTGvhZa9ikH6VRc9u1fj8PpK
	H4c3JvPs4XIjSgCVWHpA66dcigTovLk2u0u4iGgdLQV+1kY/zsRjCc0jhSG66J4T+Lo4fwsHa8z
	0pfTScaRXWSDXQ9RcXNc05KGR2yHZy0OcdZAp2ZQDHMSeWcFpeKbrj30kHzcXiDpxyW0pEL2fXs
	5L7jo/AvO/7AV06ycvBJmUsXnvCLXaEY5qmL1Ue62P/2XKJ68kKNbX6cbeuJgoOzqJPUGpBYOIo
	SxHH15JIofK2OSihJ2UORSWdPPXkXOyRcCi8voZSICr2kxi1+aPeT6U6mkTKRi0BpP1BAGwwdzH
	rrwcca7y33w9EkBWTKucsfdhSwKdd+5/MfYfTXFABVkfW7tBfmVuPwtjANVxntOfs10bWQI/LGH
	ngPKmZmR/y1WKYD+Aqk7
X-Received: by 2002:a17:90b:4fd0:b0:3a4:a3e8:22ff with SMTP id 98e67ed59e1d1-3a4d1509d56mr448821a91.19.1790752756998;
        Wed, 30 Sep 2026 00:19:16 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4caec0f28sm2256687a91.17.2026.09.30.00.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:19:16 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3 1/3] ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()
Date: Wed, 30 Sep 2026 07:19:12 +0000
Message-ID: <20260930071914.421586-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930071914.421586-1-benquike@gmail.com>
References: <20260930071914.421586-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_spi_transfer(), each SPI transfer reads
sizeof(struct mac_message) bytes into cas_ctl->tx_in_buf:

  cas_ctl->transfer.len = sizeof(struct mac_message);

However, ca8210_rx_done() only checks the received packet length
len = buf[1] + 2 against CA8210_SPI_BUF_SIZE (256). When buf[0] & SPI_SYN
is set and priv->sync_command_response is non-NULL, memcpy() copies up to
256 bytes into priv->sync_command_response, which points to a
struct mac_message object on the synchronous caller's stack, overflowing
the stack buffer:

  BUG: KASAN: stack-out-of-bounds in ca8210_rx_done+0x117/0x6c0
  Write of size 256 at addr ffff8881009e7c40 by task swapper/0/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x3c/0x60
   ca8210_rx_done+0x117/0x6c0
  ...
  This frame has 1 object:
   [32, 182) 'response'

Check len > sizeof(struct mac_message) instead of
len > CA8210_SPI_BUF_SIZE in ca8210_rx_done() so that any packet exceeding
sizeof(struct mac_message) is logged as erroneously long via dev_crit()
and dropped before copying into priv->sync_command_response or passing it
to ca8210_net_rx().

Tested in QEMU with KASAN enabled by passing a 256-byte SPI_SYN response
into ca8210_rx_done().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Check len > sizeof(struct mac_message) at the top of ca8210_rx_done()
  where dev_crit() logs the error and drops the packet instead of silently
  truncating memcpy() with min_t(), addressing David Laight's feedback.

Changes in v2:
- Split the ca8210 fixes into three single-issue patches (1/3..3/3).

 drivers/net/ieee802154/ca8210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 01af4f9..a990a0f 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -686,7 +686,7 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
 
 	buf = cas_ctl->tx_in_buf;
 	len = buf[1] + 2;
-	if (len > CA8210_SPI_BUF_SIZE) {
+	if (len > sizeof(struct mac_message)) {
 		dev_crit(
 			&priv->spi->dev,
 			"Received packet len (%u) erroneously long\n",
-- 
2.49.0
