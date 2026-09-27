Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE6296BB8
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790518853; cv=none; b=Vh6ovEAPGDeSfizoKY5Hcso90rTeJ7614tkc3zoCYkchARXvENS+IUSlql3EA5yyz4kAcP16jLJvFHviNoztVd33fR+wyvOcnLgeyhiCsDC+Uq+VgJ8zGBzrB5dE/ll0CVLFho+V97D0uT1gMnNfV7MQ2DfbcNy11H2kXvt3g/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790518853; c=relaxed/simple;
	bh=rewYJ804mTzQ60NoVNjxyHcEpuHioue73AiOm0aU4D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUtv9IV8CPXYnpxBMMil5aC75qoN5K6QZrMgw45rppm+tGewOss0AbUjFpNlRt3HNU4+h/TVyN2/n74171sjOCBkvLX1EpYCGSjf3PFrwium3GrN8iRbhZVXAyd6mpGZ/ipqvDQA145oStZLQDxMkq4n9PIAMmtHZvBd/8zmHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiZVZYJX; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiZVZYJX"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-343f0ddf131so229673eec.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790518849; x=1791123649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QuFiE8Sn5ZCiAo2F3P+hWDb2ouMekTqqlvB4M0L/MQ8=;
        b=HiZVZYJXNFvEUFnGqmna20rmJwC9EhanTDGZOYOp21a57gwfBiM1R30OzwL01Wr+r8
         fLV3ZESNzy+6LtaILsb3zqrMNlQ+jxn70MfnxrgJLJVDK1rVPb+9qLkwVQTSvVCME7Ae
         akOM5VdfxMcyYbSRKeJXzU7vzTaDsllYoBItS4w0Kjlaof8zoe+RuIH7uGlWOodRxGUn
         jAStjmjKwcZ49njgPihE7oTOStxrUrQOFkJRon+CoIhu/ZTY/2hCSxthMSq8CAryMvFM
         wK4BycH3aZF4m/ewt3waW30jhWfhgmsrU6LuzIHVLXI7CUgOfL3LSC+h1urWFRd5jRlk
         Y3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790518849; x=1791123649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QuFiE8Sn5ZCiAo2F3P+hWDb2ouMekTqqlvB4M0L/MQ8=;
        b=Zxzi6SfJCnZiTUo5ONSMzcTpD/qvVRd0EorrIi8tEjPcjYQ38yfkFNtvMtpWBtLEX+
         EmdbOoyd/73SH+Eduk97LkwniOIjjWHFm7196UVpp/F4Dogg/I3oKHqNoXMvrna7+ImW
         eDPYbdDzDwqgZiyRt7zbdmbVI3WIIuBNkvMLCYyOfrSm+GBPhTrgVHEpFU4cjBI6qpC6
         qvoeBBef/ehOUrdQqPKOFykPRoC5GACJXUhnaZLX2PFRyH7UhszyuWy+itld7zrHAikc
         UL2PnhLfpY3adqMF6hZmykUmEd0NTtYFT41hzUDStWh7M/JClXsmDH4eIyAoqbYKBSRv
         uv0g==
X-Forwarded-Encrypted: i=1; AKwUvBzBcfZHsSeCBPD47eV2mcLnilfoJcZAruPz03RFGIyKTltY02Cge1t4RjIqR/VBPkFWsX8gVn8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnCDDCITg+Lkhefzhm8BkIeQG7kBXHIqGYraJCYINmJSAmRR17
	b8WZekGwEYfq6hrhMaz8wggAW5TNF7bM5hqLw1eCh0vMHmAAw8kfZ/hR
X-Gm-Gg: AYBFou300EIV+N8a3dE7q0ESnhdyNnbWf0O9ctw3mq5F73rKdhZVF2gzsAKJ+tE7qYr
	8QayviP0CeMsXbwgSdWs8TtH11RhyJqNG/gEjMUAS0b34PccF/poErkf4eN84ui0M2rt+RSGUMc
	kDbeoSZV1tCwZ8H6SBP1yDHxfbVQjMnlbAyN8Dq1XEXNsgzzj7mC8oaCJjHCGmUaENcojPi+uQQ
	/66ZdLHhBGtgGnMhaSb4VIoiLOQOX/xd0CuHnVFZes1mqZ+7wwHAz2yZwfitdv9w94hCL4ytXt2
	HC0xdOwUOQUreK/nzMDX/OJttBInDjhCy8EfPB5PXMID8nTsnmjmsCrtmqF7UeP1K9MYhJ+nKPz
	lcrhQRZVzMglXhba0a9cnq6LZZWqLATbFsfywvUhBpWjyZFLeZOQq+wiGhJq/GZicLv6jFlhL+I
	mpAsErnhDyEJ8gDyEmR3kpeP54kFiltzUugtz8DxxotOu9TrK+VIKCuWROHpreUHwY4yoU2LRZe
	YkWagEIKPIhXRi9l2OJPknwDGnIY8sU
X-Received: by 2002:a05:693c:87d6:10b0:346:7c2c:1d23 with SMTP id 5a478bee46e88-3467c2c2597mr1464216eec.13.1790518849337;
        Sun, 27 Sep 2026 07:20:49 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414504fae2sm22534911eec.20.2026.09.27.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:20:48 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+4618907cccdeffa@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drbd: keep discarded packet size unsigned
Date: Sun, 27 Sep 2026 22:20:34 +0800
Message-ID: <20260927142033.297349-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packet lengths are decoded into an unsigned int, but
ignore_remaining_packet() stores pi->size in an int.  Values above
INT_MAX therefore become negative; min_t(int, ...) preserves the negative
value and drbd_recv() converts it to size_t, allowing the receive to
overrun the 4 KiB rbuf.

Keep the remaining size unsigned and clamp it as an unsigned value so that
each receive is bounded by DRBD_SOCKET_BUFFER_SIZE.

A KASAN reproducer reported:

  BUG: KASAN: slab-out-of-bounds in _copy_to_iter
  Write of size 32672 at addr ffff888027129000 by task drbd_r_r0/5002
  Call Trace:
   _copy_to_iter lib/iov_iter.c:197
   simple_copy_to_iter net/core/datagram.c:521
   __skb_datagram_iter net/core/datagram.c:435
   skb_copy_datagram_iter net/core/datagram.c:537
   tcp_recvmsg_locked net/ipv4/tcp.c:2846
   tcp_recvmsg net/ipv4/tcp.c:2949
   inet_recvmsg net/ipv4/af_inet.c:896
   sock_recvmsg net/socket.c:1159
   drbd_recv_short drivers/block/drbd/drbd_receiver.c:322
   drbd_recv drivers/block/drbd/drbd_receiver.c:331
   config_unknown_volume drivers/block/drbd/drbd_receiver.c:3624
   receive_SyncParam drivers/block/drbd/drbd_receiver.c:3671
   drbd_receiver drivers/block/drbd/drbd_receiver.c:5366

Fixes: 4a76b1612f35 ("drbd: Map from (connection, volume number) to device in the receive handlers")
Cc: stable@vger.kernel.org
Reported-by: <co+4618907cccdeffa@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 58b95bf4bdca6..3fb73fbfd5f27 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3616,10 +3616,10 @@ static struct crypto_shash *drbd_crypto_alloc_digest_safe(
 static int ignore_remaining_packet(struct drbd_connection *connection, struct packet_info *pi)
 {
 	void *buffer = connection->data.rbuf;
-	int size = pi->size;
+	unsigned int size = pi->size;
 
 	while (size) {
-		int s = min_t(int, size, DRBD_SOCKET_BUFFER_SIZE);
+		int s = min_t(unsigned int, size, DRBD_SOCKET_BUFFER_SIZE);
 		s = drbd_recv(connection, buffer, s);
 		if (s <= 0) {
 			if (s < 0)
-- 
2.55.0

