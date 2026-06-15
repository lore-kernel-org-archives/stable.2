Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F073275B1A
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545584; cv=none; b=d9CuxSuN5l1TAivUUZP5vEriRrL6DMEomXGAWXp/dyVhq5EhH2zXkcDOb3rT+HK5u0GDjL/iLP38gGWp4hJZK8KVPq6R+8/2p5ud6noKi6nG53eiodh0x3iURES1aYrzBIQcHWYACLEW1qTwsuNeEE306fi1+oxJ93DvwlM0vE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545584; c=relaxed/simple;
	bh=6FChuiiY1Ab4DoQ0VIjmNXOowo/9a9Qo6Y6YIXFBBsw=;
	h=From:Subject:Date:To:Cc:Message-ID:In-Reply-To:References; b=ojO+k0wOeCU5y1lPs0/pRHvZL0z2sKdRkGdr3oVH4YBlDvAh9zDswUZOkX8E6uREjnOd0093HZmrrIfzI49XPTHEX7fCUdVaYsQcAcOw1cnSZ6QzSGSxmHjMO4nFHHIL+GP3gZE6e8UB6wYaUn329temeySz7sWn4O/AuQyJkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net; spf=none smtp.mailfrom=ankey.net; dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b=pa4XmYcx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ankey.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b="pa4XmYcx"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8422f395a4aso2433437b3a.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ankey-net.20251104.gappssmtp.com; s=20251104; t=1781545582; x=1782150382; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:cc:to:date:subject:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EM3udb0oDgJN3cKMNmux7YsMkV9lDzcITmGFkVGmGqE=;
        b=pa4XmYcxUADAHuHOG3K+8NWlvTj24h7N/JrEGIWqgFjPaNqTt8HiBJ+eoGjulX/tUt
         +GUNCsQTohhqIdY5rMnCUWZ2ekPSoktw03uR919hD+dEbcbTsaITMxciZoi9m5eecfvY
         dficIhVifwvF3fTY9VW7a4+h9lHFkys+yMnbSaBCs3FyENYYY55zELXDODf0bUhEBvbj
         syVrsfj/eZDyPVndaVB0NdpPF/d2ipaPG3vFycXzQsPYHQzE+HXtwD8/FZpywpdM8O5C
         4UEIHFQNqxOXUo3tP8E8smAzX1qCU/5nGX3B0iElMJ49cN//YnqkHYF6e5ptCX8Ytbvq
         0OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545582; x=1782150382;
        h=references:in-reply-to:message-id:cc:to:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EM3udb0oDgJN3cKMNmux7YsMkV9lDzcITmGFkVGmGqE=;
        b=gRpd4pAa0P5SP8A6cOho6R1LDYa86VpveF47XgJ+2viWd7GHmiLJTtoi6NYC/l9MNF
         6CL5trcIcAW8y+HlriayfPy9B0TsB7ObaVF/1hV6qa2Zrr/4cYbTP1l1R1yg1PhUCEwP
         T2tr+NU99Knnz3GVWctA4CacvmRo/EMVgZ26v/3pKWqqmH8kicPlB3bPmmYoUYKsMDDi
         w1uLldfnEIcag1aEBpn85B+CUVAp6YZot1AmGmdXnNpAbn9+B70DwCiNdx3uTyGziUf4
         e4H1wCeZVgrIz3bSWQPV8Juwx3FZZVI7SsuRU5IF+bLaxIVewXRitCpvssvVSpFn3Zon
         3hhA==
X-Forwarded-Encrypted: i=1; AFNElJ+/TC46KY01pq+g4jFdk+XYoOpdh5E34TfqkZj/sjKBWLhgDvD2hTa1J//uU/sjOLaA2sS8iSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVIsAQVKu29JTC+qTRKoA8gnLXfx46Kmvc5JKC1zAzeTdeq7k
	djNyt/t4BP4XccNboelAg0427q06Ihl+xxoWvJO9dpI9M/IDMASzGMOI6Qu9lfhB5kauS/LsXTX
	7RS+NYw==
X-Gm-Gg: Acq92OHw5NvG9sttTFzeL7HHBAWXBui17nlh0OdQOKLprIKfM7RzjzalLLENno1fxlp
	iKP/1lYlYQOxHKM8Y47LxuS42JNmaoHXtrSDdyLyEQOWMoE3q6lHr75wTuHJwV3rPnrrHD+ObWX
	Ow3SHWjnImbhYjqVauzNFSrcp0nLzcPPzH5sLpBYcejPHER3NilULGZQVayjAkfBwELd98Ki+Ox
	g0y6SsRPV8CzRq0oZeSge9xAy4l2s3zzUWCxHwpPwc2AXUCuajbbcRcBHsoE3+hRs2EGdV0Iz+b
	qa7PIYTium+UwR1iwhGLr1wz7JKv+ZLJ9mWVImNHq+r2ihpG3QZxv4gXvLQlBABXkKV4N4g7LOH
	ejQ+pT2zXoUu6gc5birqGqqc7ehMN0bfTXKOi3npumTwywVsmY7DKsti1wENDMfUEhJ1g4c57I9
	LJd7W+ZZPe5GU1qFleyVYkkhj9ER7YOZ/MHP+uO/rlyQDIIoXfy49CzIdWWFDPOmJxghpK6+B3r
	tza38d8zod4Jrnb59kJ0CfUTw1glrWUuuB3
X-Received: by 2002:a05:6a00:813:b0:842:614b:50e1 with SMTP id d2e1a72fcca58-84513e3c998mr348207b3a.12.1781545581724;
        Mon, 15 Jun 2026 10:46:21 -0700 (PDT)
Received: from atimofey-ld1.linkedin.biz ([52.149.25.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434accae18sm11214086b3a.17.2026.06.15.10.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:46:21 -0700 (PDT)
From: Alex Timofeyev <sashka@ankey.net>
Subject: [PATCH rdma-next v1 1/2] RDMA/core: use destination netdev MAC for
 cross-NIC same-host local dst
Date: Mon, 15 Jun 2026 17:46:19 +0000
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1781545579.2-sashka@ankey.net>
In-Reply-To: <1781545579.1-sashka@ankey.net>
References: <1781545579.1-sashka@ankey.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

addr_resolve_neigh() treats every is_dst_local() destination as loopback
and copies the source device's MAC into the path record's destination MAC
(dst_dev_addr <- src_dev_addr). That is correct for true loopback (source
and destination on the same netdev), but wrong when the local destination
address lives on a different netdev of the same host.

In that cross-NIC same-host case the destination NIC will not accept a
frame whose destination MAC is the source NIC's MAC, and drops it in
hardware before it reaches the peer. rdma_resolve_addr() and
ib_send_cm_req() both return success, but the CM REQ never arrives and the
connection times out.

Look up the netdev that owns the destination address and copy its MAC into
dst_dev_addr instead. Fall back to the source MAC when no netdev claims the
address (true loopback), preserving the existing behaviour.

This was observed with two RoCEv2 ConnectX-7 ports on the same host, each
holding a global IPv6 GID, when one process pinned per NUMA NIC connected
to the other over RDMA-CM: the resolved destination MAC was the source
port's MAC instead of the destination port's, and the REQ was silently
dropped. With the fix the resolved MAC is the destination port's and the
connection completes.

Fixes: c31e4038c97f ("RDMA/core: Use route entry flag to decide on loopback traffic")
Cc: stable@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>
Signed-off-by: Alex Timofeyev <sashka@ankey.net>
---
 drivers/infiniband/core/addr.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 7e62b5b1ffaa..84aa43436bfe 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -451,10 +451,26 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
 			      u32 seq)
 {
 	if (is_dst_local(dst)) {
-		/* When the destination is local entry, source and destination
-		 * are same. Skip the neighbour lookup.
+		struct net_device *dst_ndev;
+
+		/* When the destination is local, source and destination are on
+		 * the same host. For true loopback (same netdev) the source and
+		 * destination MACs are equal, but when the destination address
+		 * lives on a different netdev of the same host the destination
+		 * MAC must be that netdev's MAC -- otherwise the destination NIC
+		 * silently drops the frame. Look up the netdev that owns the
+		 * destination address and copy its MAC; fall back to the source
+		 * MAC if no netdev claims the address.
 		 */
-		memcpy(addr->dst_dev_addr, addr->src_dev_addr, MAX_ADDR_LEN);
+		rcu_read_lock();
+		dst_ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(dst->dev), dst_in);
+		if (!IS_ERR(dst_ndev))
+			memcpy(addr->dst_dev_addr, dst_ndev->dev_addr,
+			       MAX_ADDR_LEN);
+		else
+			memcpy(addr->dst_dev_addr, addr->src_dev_addr,
+			       MAX_ADDR_LEN);
+		rcu_read_unlock();
 		return 0;
 	}
 
-- 
2.40.4

