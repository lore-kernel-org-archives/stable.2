Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514C2F8E99;
	Thu,  6 Aug 2026 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786056997; cv=none; b=paHCtM3UBBqU1UwgHDeYmRZVuiW4kF/e1FM+A3yOs9U6srNI+HUX7e6ENduoI0fTJ8+lIfOLii6k6wsIUqE6X2FEzJrK/s9bcy1Gx5UcKQ8pw5f9WeIRD/P1vU0Sbj5436u3Bgx8Sp4bAc7a2KpPkIC8g2rWlUfkHMQCblOR4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786056997; c=relaxed/simple;
	bh=hWPgRv5ixMtuyGzUAxiqeOUMPopAQafhZQgDrRTyrEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXPZEjDcapTtoZjj+o7xcHjqPF1hg8FnPnI6m5Am2xLSACDvX4hAsXYrwmR0Wm1mv54y+jShGO0/S+sYaPWTtf7k3TxoWGstUnv9OUuSHFssFbLnkoqwcX35EsCPY+Fo3+6jueF6XkisSFi5DiEhs1Rv2xMtU0KxMuDYmd6rQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db6tORAU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db6tORAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36A81F000E9;
	Thu,  6 Aug 2026 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786056996;
	bh=yQohwScZUPlFeS1BEj0Tl4haVBh7RTNF4VEVgU41yNE=;
	h=From:To:Cc:Subject:Date;
	b=db6tORAUehtbUtFiMYex3SL8b6RH7K8zaJt5h9XX4YDgQWWmNRRhFEMFR7VlmxCsw
	 ZXqwfs2cIwik//MgUY7aHLNWyf9hkjCeEha+xZhz+DyeC7REPdb96o4T2cw4jrQqUf
	 T00Hm7tmzCwbpff4dViGSHN1J4kWXJtuYe+n9cUWISYg7IH9Bc0i9cdHSQRrQFLwic
	 qZejPHmzUMA9nN7AF8AJP34pfg0ht3YPyYlGxSrbTvIdIw0581udvoOBkmPF+Lh4r+
	 TSL+FtPF5XZ/1/gwR9axCWVEd+ntsowh0GZXiyUOH8YH7abRi2USATUN3WfVg1Apbo
	 t/QTcmT7jZ7UA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com,
	axboe@kernel.dk,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [PATCH net] net: expect instance lock in netdev_queue_get_dma_dev()
Date: Thu,  6 Aug 2026 15:56:26 -0700
Message-ID: <20260806225627.3998672-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_queue_get_dma_dev() uses "compat" locking assert which wants
either the rtnl_lock or netdev instance lock. This is not right,
the callers are taking the instance lock unconditionally. All entry
points for queue config are purely instance locked.

In other words the callers use netdev_get_by_index_lock(), not
netdev_get_by_index_lock_ops_compat(). All the state we will
access is effectively instance lock protected (it's const for
devices which are not ops-locked).

Update the assert to avoid false positive warnings.

Cc: stable@vger.kernel.org
Fixes: b6c5f9454ef34 ("io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock")
Reported-by: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: axboe@kernel.dk
CC: io-uring@vger.kernel.org
CC: asml.silence@gmail.com
---
 net/core/netdev_queues.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 4d6864bb4f6b..f5558b12877c 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -40,7 +40,7 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev,
 	struct netdev_rx_queue *hw_rxq;
 	struct device *dma_dev;
 
-	netdev_assert_locked_ops_compat(dev);
+	netdev_assert_locked(dev);
 
 	/* Only RX side supports queue leasing today. */
 	if (type != NETDEV_QUEUE_TYPE_RX || !netif_rxq_is_leased(dev, idx))
-- 
2.55.0

