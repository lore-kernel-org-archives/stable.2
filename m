Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060425;
	b=B+kxA4pl4AFAaJLSOE9mx8FYUJPUhVK5xiC8Wn1us1Cx0NnBMd5nl6RSawU/hHFYUDu2
	 yr+TkCiVdxKw06PUPCKr/s6cxjWDk9gkOlBk2q2MwfQt83XmYIpzQenZOYiLd4urLq55R
	 Hp8z4NBSbKJgN2YgO1V3Pa0qUdxjJBQMJmGUaLDaVgR5l64s/kURxPcqnNapLmnC65498
	 L+YHwUdGCQ9m35Ij4C+h58sRiXWLArLWp9m/mhIz1u6eeyMHczJROuAyf8KCTGNpkE5hG
	 kMa+OzDB60Vd32M/Yu6QddqRZTtSc4jkcljIvMBVMNdT2YVt1+TriZoZ5aTs1XQBOcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ngyvw7W1wldCSbIp2eT/kVHJ8HXnUw9pEjSsrIxeEVQ=;
	b=J5FvCxOm70YHlxNtu9ZSr56RI8OFtJ6cmmdMyNHawhJUi22LKtopu3g7zpSHE9gI5rCD
	 vtJtc5JQFsn19ZN9hKYd4Yeo971dza6+A9GcPNb3qtoiakAsbLqJFTw7UU3p6sa7CBTU9
	 6IDJsM+ZsXXrgsDSemEra7r+omA+78Q4IUH0/R3Rg4X+rfVukV2ayWWRsZiu2z6/yC+ZM
	 ViqRVmBrqg+k5Zpv6BPzAq/WXBIc/ExPQKaAo7Gi5QP2v1PtDAfvw/5LeqadUZ2qgZc0P
	 1B5UD6pP5vAYzSMW5+8h4jBUDlNtXyN8wzdS/VUEVpiC0E8OjI324wShoPKjtWm+lIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+KvkcLr;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA3E5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+KvkcLr
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so2700760c88.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794060424; x=1794665224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ngyvw7W1wldCSbIp2eT/kVHJ8HXnUw9pEjSsrIxeEVQ=;
        b=d+KvkcLr03VEL/Dw8mCET7X/fPun7qHPwWG088o+U2t1dmqLcJuMjlgmXhQQtIWS9x
         yo1b+vPZ9d0v8CDFXjPpnhrbSzdkxTk3wEXDHNtfCdVZXJRF6O/Z2bLJ9Aaqv07K341Z
         AbmBU/pbPrXyQfdhaHa208u/2JvsBIzXiIb+DWxYQ4ABAJibl8JCoVvDFhSX9hfO5dvO
         5tZHLVtpBLoqncTkIiXM/l6u1oIiEAuMVdRV03PAalY0QVtlscJRXuq26S2PRydiVgp8
         e26BgBsUhMnASeEaLbSZKbi9HHZDzXFP6b2kM6yI6/V2XWId0gPBN4S+k9nFy1U560Sq
         ILow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794060424; x=1794665224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ngyvw7W1wldCSbIp2eT/kVHJ8HXnUw9pEjSsrIxeEVQ=;
        b=0BdQ6XV2YYxvexPa4dR0hQO6B7ufPqpHuq4bBvcRv+PPAUHfUnoXJ2zg3hhj8VaMgl
         ICm8HC0DSBd39Ym4r3rhoOWrvcy8oOM3ElObA6XZG1V85utAGrGjeF25cO4b/6d8LxsY
         AAU4h6UtTo9ode7vkf5g2jMEYKOXztrzKLs8om6uqYtT6s2qFndgx3nSghVvTH1h6txV
         h7YU0csAJNkJsEsSOYY8KZ8ICxyEr+lV7z557fPr92DSWTUmcyAmijVg9EsL3av0iXZS
         z+GroTRZC0rw7QphaFmAtoVVvRQOScQHhpSQzgrehPI8lAQmDjsfP5leDuATIo5ETGiO
         Ifcw==
X-Forwarded-Encrypted: i=1; AKwUvBy9DpaT4IGbKbY8Z6+CGQZB6fpdfizsP1/djXU6G8VwN7guKt9wTuKcHG5t4XYsfWRPIALyACI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9i0f/kkwsggufXb1avHhx4cr5MsLO1K00DZd3DPw0uXI59nAE9
	fueB54dJwpe5kl5FpqXGJp8QCEC401Ljg4b1Uz4GCrkEUiWCM3yl8ik0QIOJ3pqz
X-Gm-Gg: AYBFou06zwoO1GuTPW2BbRTaqLsI3RvBATyPUANlEUcZCtobowbWsUW7wT2EXOOp6Ot
	srHpJLtCAjUEnUIC2jMW1rqRCbukN1Hv9Gtg9Q2mBdfoZwZm0ZGwCgDtLTeqbmoe1XeotjurqW+
	+cLA/NPASzezTmMYrlu/9FR8PI0hbHOZnWumwdZ+0H3Atu13fbDEwCAVfHr6x2gbssOJgyTfk4v
	6/OkAFWiuVVcwMnj0XAVxdu/bBngZ2lVaCgHrSeKYkDQuaFDiT8Kbk44iV4m5wJbuLlN8qzMx9N
	b4zpWg1/l6wESWVIGyNoFBio/TNg7soV5Z/58wXIXbSOC6cr0XSX+2V+XurXW7YYdDr9Exvy/K1
	GY/QPG8eAWOSDYOBGcUQVA9KpfQBO2E9djbS0FF+6uE9GX3UXzV1FDKDniDsLpgP37gCg2S8RLf
	5rbInasses5lqH6xbS9H7sGjYThEpxiaa4PUnj98QIhmQOinLnE7WuRM/p5CzbvwpbLGma6dsV3
	MKiZLht/K0vvIMpzNa7kaJ5FoEqkmqz+pHpOPEwky1BMaEC7hcyAFu1qNMU2SjGjb3R3MXbSrxq
	TqVe+wzaK+ydjcFgQn4H0Sj9JfkP/YaDjnqGnTGxQ1ZJ+0/p
X-Received: by 2002:a05:7022:b056:10b0:167:4198:2cb3 with SMTP id a92af1059eb24-1b25d3083a7mr7690558c88.18.1794060423886;
        Sat, 07 Nov 2026 06:07:03 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fd0000sm14558756eec.21.2026.11.07.06.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:07:03 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: enc28j60: cancel deferred works on remove to avoid use-after-free
Date: Sat,  7 Nov 2026 23:06:49 +0900
Message-ID: <20261107140649.3702472-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

enc28j60 defers work to three work_structs that dereference the driver
private data via container_of(): tx_work (queued from ndo_start_xmit),
setrx_work (from ndo_set_rx_mode) and restart_work (from ndo_tx_timeout).
They run on the system workqueue and are never cancelled.

enc28j60_remove() calls unregister_netdev(), then free_irq(), then
free_netdev(). unregister_netdev() brings the interface down so no new
work is scheduled, but it does not cancel a work that was already queued
from an xmit, rx-mode change or TX timeout shortly before the device went
down. priv is netdev_priv() memory and is freed by free_netdev(), so a
still-pending work then runs enc28j60_tx_work_handler() /
enc28j60_setrx_work_handler() / enc28j60_restart_work_handler() against
freed memory (use-after-free).

Cancel the three works after unregister_netdev() (which guarantees no new
scheduling) and before free_netdev(), while priv is still valid. The
handlers do not re-queue themselves or each other, so cancelling each once
is sufficient.

Found by static analysis and code review; not tested on real hardware
(needs an ENC28J60 SPI Ethernet device).

Fixes: 3ec9c11da033 ("add driver for enc28j60 ethernet chip")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/net/ethernet/microchip/enc28j60.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index d6c9491..5266912 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -1602,6 +1602,9 @@ static void enc28j60_remove(struct spi_device *spi)
 
 	unregister_netdev(priv->netdev);
 	free_irq(spi->irq, priv);
+	cancel_work_sync(&priv->tx_work);
+	cancel_work_sync(&priv->setrx_work);
+	cancel_work_sync(&priv->restart_work);
 	free_netdev(priv->netdev);
 }
 
-- 
2.43.0

