Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504600;
	b=EEopc2Al8jNIcyxUKEhyLHX304GAKKgluxDXpOZffrMyutxF2cnz9j6RpPvGUPVdBINV
	 nm7hoqUtnr/IXFC9yem5nod8v/8/+AHnOf5bvbXgFcQLl4cnDj4i827DoXTYBdydaMGtJ
	 YWcp+xGAgGEXlnFcKFXGH/aFXx+IhzFIeim0cn5WhLWMgT/utS2ESRKHRVa4Uh8704lf3
	 bMHMoU33vtx4n/S/PptoH27Rkdf6apkKT/8I+lMixomp/78sw3A1oGZHSgC1smekJw+UY
	 aOpgc9oSNJhDOEP56qoKcHy7dFHL/F4OPxEbVyKCBjoqAcveSuPiL+iKOZE1cVI5BrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504600;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=HYCpdEa0CjagDkIoEI9c3ElxA1vOooGlVLR/xOXvad8=;
	b=ccqvsXnh1YjkjlSbsbi6FLzNl7+yY1/IYbDUeY2z3bziPgenFgZWgJZ8mSg/EWaP2nfb
	 3MgtAAfdvS30ReJc6ocTtOWPlBkfcNcj+wTFcPJBwg2/mtXHgXxHJawc42lvxMQL6aq4Q
	 FV+4ZhZTRk+FminzNaVZZnA3TtBaaIMIEfjE2S2Iwrt4TT4fUduC+uSXZA2i8X13mmBzL
	 4uul2AJy9/a76EB8fpNTtXI9iyEzsguHJc5AywxxoRoKzPKLKnirx8gqK/uHUFwBkzpki
	 cm2NHnV0qmHJBgRZE/62j0xCoumAIJBEwXGt3nkCM+E4SRDbijb9bh0p3+jWiEuM9Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hdu87VDv;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8C606A319;
	Tue, 20 Oct 2026 13:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BA8C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hdu87VDv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HY
	CpdEa0CjagDkIoEI9c3ElxA1vOooGlVLR/xOXvad8=; b=hdu87VDvYUaeZ5u34U
	VT1VuHXx33f34jw4PdosOs3vNYS2jLDIYUV5WCWHN7QUILrZn9s7EkrYSrhr0yGP
	yH6qfTcza8A0+bSBThz7nUMql/1LnTs9bh5sr04S3Nj4FS9IBRntv0Vp0UqhGU2a
	8/FObYLUdmavPUbrL+9IGH/uU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3YQntctdquSfMAw--.51436S2;
	Tue, 20 Oct 2026 21:55:58 +0800 (CST)
From: Xia Yan <yana06070@163.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	yana06070@163.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] veth: keep carrier off when resizing channels with a down peer
Date: Tue, 20 Oct 2026 21:55:43 +0800
Message-Id: <20261020135544.24441-1-yana06070@163.com>
X-Mailer: git-send-email 2.33.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgD3YQntctdquSfMAw--.51436S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF4rZF1rAFWxJr47WFy3urg_yoW8Ar4kpF
	4ftFW5Cry0qF47ta1vqayUZFyrJa1xX34agF9Yk3yruw1UtF95Xr4Fy34j9F1UKFZYqF42
	vrW09r1Dua4DZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piPCztUUUUU=
X-CM-SenderInfo: p1dqtiawqxiqqrwthudrp/xtbC3w5o7mrXcu7V-gAA3d

veth_set_channels() temporarily turns carrier off while reconfiguring a
running interface. It then turns carrier on for both ends without
checking whether the peer is administratively up. If only one end is up,
changing its channel counts therefore reports LOWER_UP even though the
peer remains down.

For example, after creating a pair with two RX and TX queues per end:

  ip link set vca up
  ethtool -L vca rx 1 tx 1

vca incorrectly reports LOWER_UP while vcb is still down.

Only restore carrier when the peer has IFF_UP, matching veth_open().
The local interface is already known to be running at this point.

Found during LLM-assisted source review and reproduced with a veth pair
in a network namespace. Built and booted UML kernels before and after
the fix; the accompanying test fails in the four mixed up/down cases
before the fix and passes all six cases after it.

Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Xia Yan <yana06070@163.com>
---
 drivers/net/veth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 643b97d..4e75830 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1372,9 +1372,10 @@ static int veth_set_channels(struct net_device *dev,
 		 * to identify the range we have to disable
 		 */
 		veth_disable_range_safe(dev, new_rx_count, old_rx_count);
-		netif_carrier_on(dev);
-		if (peer)
+		if (peer && (peer->flags & IFF_UP)) {
+			netif_carrier_on(dev);
 			netif_carrier_on(peer);
+		}
 	}
 
 	/* update XDP supported features */

base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f
-- 
2.43.0

