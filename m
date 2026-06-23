Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C523C4FA;
	Tue, 23 Jun 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219461; cv=none; b=jx136wRFJnLEeNHTyn/Y6pwn/Tmk9v9CZw1XPqU57CW1JZlpTjWRKzLE5Tcckl69IgUxv4nwnu0yJPi3KitBpF+gIF7nAjZhMB6sWxQCfXn3oLz0mtJ1oZYOx/Xn3n3OSv3iNmgFgX/28TIrtv2sv/QB3JpQTHO1gYF+AUT74yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219461; c=relaxed/simple;
	bh=N3v6qUckgyI9nxqvBsLkZa5/FRKCD0HFiekcYK0P3wA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ImDHbmDJxmrCqC8rOj5lQX2nhD/zTLtl8G08UQsyYFCeUj9RJ6vnjyGum4e39qmACVvtiAwxWNfnlRV5MJmLNsnS+JYLFw5WAWIC8H4tGwPi23Z2rjpw9H8gDj8hL1F/3hq7QY/56yiZErW0JEnd+ZNwDQPeUmz6N+4crZZiqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GCShpWYp; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GCShpWYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xE
	18IhiGf4Rx2yGJ6G05XzQ3IDNdWM+p9SDW4T1+DTs=; b=GCShpWYpYqw/rrsTrr
	Hf3t8hb50+nToyPUjaIOFMhWhX6BXALsb+frbZyJIhJ7V2QMaHUXK7juSgdjFrCV
	wLzBR9Gdnt3oNJuzimUektiu2zMRz8RyufvQkVpRQVc0RCIEoXxov8wE/C2hv8/d
	pyz0YrghS15uEYdi9iL9n1C0g=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3f3NsgjpqxcRHFQ--.61307S2;
	Tue, 23 Jun 2026 20:56:14 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	kory.maincent@bootlin.com,
	zilin@seu.edu.cn,
	petrm@nvidia.com,
	u.kleine-koenig@baylibre.com,
	marco.crivellari@suse.com,
	vadim.fedorenko@linux.dev,
	Aleksey.Makarov@caviumnetworks.com,
	satananda.burla@caviumnetworks.com,
	felix.manlunas@caviumnetworks.com,
	derek.chickles@caviumnetworks.com,
	rvatsavayi@caviumnetworks.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: liquidio: Check soft command allocation in lio_main setup_nic_devices()
Date: Tue, 23 Jun 2026 20:56:11 +0800
Message-Id: <20260623125611.2228149-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3NsgjpqxcRHFQ--.61307S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWrAw45Aw1fCw1xXF4kCrg_yoW8JFW3pF
	WkAFy2kF9rJ3WxGanFyw48CF98tan2kayYkFyxJ3s5Xr90y3Wv9ryjkFyF9rWDurWkCF13
	tF9Ikws8X3Z5Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zER6wZUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Q7kU2o6gm60mwAA3H

octeon_alloc_soft_command() returns NULL when the soft command buffer
pool is empty. setup_nic_devices() dereferences the returned pointer
immediately when preparing the interface configuration command, which
can lead to a NULL pointer dereference if the pool is exhausted.

Return -ENOMEM when the allocation fails and let the existing NIC init
failure path handle the error.

Fixes: f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 0db08ac3d098..5077129656e8 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3363,6 +3363,9 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		sc = (struct octeon_soft_command *)
 			octeon_alloc_soft_command(octeon_dev, data_size,
 						  resp_size, 0);
+		if (!sc)
+			return -ENOMEM;
+
 		resp = (struct liquidio_if_cfg_resp *)sc->virtrptr;
 		vdata = (struct lio_version *)sc->virtdptr;
 
-- 
2.25.1

