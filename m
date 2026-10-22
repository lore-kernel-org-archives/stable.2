Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659563;
	b=YGSrxwCIt2qWzS3vQyly66uadTqM90KqUpSQHWr5ok8UlSLWb+7fmQRUL+9YLrBxAI3y
	 2d3ULk/+X4D+MEW2eSIS6fYBsRH9vDprTfIPeJs5gDGEOjVGvXmHJsmhsx9RPTsq8HTaE
	 +bBhNoKYXBb2L0rnGebmfy9jVYwfpG2RVz1fFQoqGOYYARY9yvPzWvLo4SlEwo77YTHds
	 xDVuSjWbXUfvenGnsEqZ9/bdczYLHjUGfwj/g1j4C5HvMFi6tNvxPnYlNFnmoicsLfc1t
	 x/V0V2uEABaLvmtKHbG4ZkKksM1qJexdK17AbK2LogKqIJUKzKn73AfJKW1Ibl1F/gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659563;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ZMk/Z/bZy+BI5/W0PT4Wtme0XLTO5nzW8fyutMCfad0=;
	b=KWe+db5XBmZwPuVupSZ7/rddfQApnjgOS7vZiwnm8kE0mse/daX81vbSL9nIcA1MiNWz
	 y5CM1hEpvrfYc96mPFt8i8vfZp0T4flgpOC798WHAhEKF/pEJujOs6XaFH+/0njkLX+ur
	 xWsqrQjoV/eg8U3NRiLSr0AcSBOj+bjjzpwv6mSy4SpstgG2Wm5Bm129o09A7r41cAqgI
	 5nzuGueKseVRuTrmesU6wMcT86SmkOZTNQk3XwkvLpWze+FN17d3m0+mgG69sZH4bklK8
	 6HtqNtQTrwnjKO0PHlQEa2fCuRiiQU+drJJNu73JzTy7xSw7/yhEQeiIjrmJvwnU0dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=byvtiKI8;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE94606A323;
	Thu, 22 Oct 2026 08:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE94606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=byvtiKI8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZM
	k/Z/bZy+BI5/W0PT4Wtme0XLTO5nzW8fyutMCfad0=; b=byvtiKI84ZxBHjW6xy
	O1HfJlWVoORKY+VFxflWs+iUz2axoL7Dfg5tRMfUV77DK1XCpNWuOJ+LdEB4rJyP
	aflyoNjmtSisC5l7x3XlX41VXAtNV7gnN2uiu7BPzgP48bXixOS7XWVXLOyF6Ju+
	zSxDHoUFvJaEu7BlXZ+hgvbT8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3lRxP0NlqnOotBQ--.27898S2;
	Thu, 22 Oct 2026 16:58:56 +0800 (CST)
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
Subject: [PATCH net v3 1/2] veth: keep carrier off when resizing channels with a down peer
Date: Thu, 22 Oct 2026 16:58:41 +0800
Message-Id: <20261022085842.2527-1-yana06070@163.com>
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
X-CM-TRANSID:PSgvCgB3lRxP0NlqnOotBQ--.27898S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4ktF4kGr17ur1rGw43GFg_yoW5GFyxpF
	4fJay5uryxXF1jyw4vg3yUCryUta1xJ3y5WF95K3yFvwn8JFs8XrWFyayj9F1UKFnYqFW2
	vrZ09rnrZ34DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pilfO7UUUUU=
X-CM-SenderInfo: p1dqtiawqxiqqrwthudrp/xtbC3xFZ32rZ0FHBogAA3Z

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
in network namespaces, without kernel instrumentation or error injection.
With the complete default veth.sh on x86_64 QEMU/KVM (three vCPUs), the
four mixed up/down cases fail before the fix and all six carrier cases
pass after it. All 55 existing checks pass on both kernels.

Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Xia Yan <yana06070@163.com>
---

Notes:
    Changes in v3:
    - Driver code is unchanged from v2.
    - The companion selftest is now part of veth.sh.

    v2: https://lore.kernel.org/netdev/20261020135544.24441-1-yana06070@163.com/

    Testing on the v2 baseline 513444cc62e2:
    - Complete default veth.sh on x86_64 QEMU/KVM, three vCPUs:
      before: 57 checks pass, four mixed up/down carrier checks fail;
      after: all 61 checks pass. The 55 existing checks pass on both.
    - bash -n and git diff --check pass.
    - If creating the veth pair fails, the case is skipped without
      masking failures from earlier test cases.

    Both patches also apply to net/main ffdf678dd166
    (application check only, checked on 2026-10-22).

    The QEMU guests failed to power off cleanly (initramfs issue) after
    the tests completed; the exit codes above are the veth.sh results.


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

