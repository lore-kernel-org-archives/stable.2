Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692784F4CF4;
	Thu, 15 Oct 2026 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054754; cv=none; b=amw/kDEmEYv7Ac2zJWmSkJTOFwIOa6uxNli6FNNqzT89lYFvKSGk1m2lzEfZ8BeMTweLzZtLLg8xqGmM077oBOm39saebktggmF+H/jeEK+Z3XNWhXBf5XO6xQ2SiQGhEnueZ9igBC0mu/EzuuPUOGUlgF1W6t+tPMojEJCIXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054754; c=relaxed/simple;
	bh=QktqaRHtQl/Fe9A/hBhQSQa8Ld2ifsl4rpxnRpMGVc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpCyRLELLiM4M3X338IJR33emIamAQ29ARW7RiZ/AvieQAmTeo7W7xBLKWVRRULxrsqFZaHSxf099ZENHU9oJpp7O5Wjoe4hXi7wcrEQ97ZCT8/sYT2rwqdFUf1j7hp4xV3dtpKSmTYNahfCaoToiG/uumrJUGVUfyNvaIYSHiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hN1iXeoe; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hN1iXeoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HM
	55kMGXP6tJWkUCl0Hzup4EMIaaf+vYx+pw74b7sw0=; b=hN1iXeoegB+z2IY2Yq
	eiY3bMc+nokyNXwbSWA4MzRm4uHzALsHoeJhjYwWpOm3op+0Lv56GBFtUWWJzS3k
	5h6wXxWyxL6JyauwkGNW71z6rq6RQkbm8NPV7r8l0gZfZYyrEjuVyBSVKwgjcV3e
	YtEBU+uUnRPI+mrs0Mw4yczvI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3n4O5ldBq3yzkAA--.32772S2;
	Thu, 15 Oct 2026 16:58:33 +0800 (CST)
From: Xia Yan <yana06070@163.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] veth: keep carrier off when resizing channels with a down peer
Date: Thu, 15 Oct 2026 16:58:20 +0800
Message-Id: <20261015085821.12725-1-yana06070@163.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n4O5ldBq3yzkAA--.32772S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF4rZF1rAFWxJr47WFy3urg_yoW8WF43pa
	1fJFWYkryvqF4Uta1vq3yUAF1Yqa1xX34agF9Yk3yruwn8tF95Xr4Fy34jvF1UKFWrXF42
	9rW09rnFva4DCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYksgUUUUU=
X-CM-SenderInfo: p1dqtiawqxiqqrwthudrp/xtbC-Bli6GrQlblH0QAA3v

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

Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
Cc: stable@vger.kernel.org
Assisted-by: LLM

Signed-off-by: Xia Yan <yana06070@163.com>
---

Notes (validation):
    Testing: Built and booted UML kernels with W=1 before and after
    the fix. The regression test reproduces the bug before the fix;
    all eight cases pass after the fix.

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
2.33.0

