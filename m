Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53BE305E10
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545584; cv=none; b=f5CtreqxOiIlIKkhBvrhFUSlP5vh2FlSikCQxU0doG8SQDdHUDSdvpGbaSTyqKov8UOnt8QbA52LBRpB902BhQN3QHyZtTcXj9r6iA0opxxz3L4U0kvo8ediTjKOR+ks90KFl/Z+3N+xyFAoFHGUOq3Erre3h6xpT68kR2Jn4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545584; c=relaxed/simple;
	bh=pyOrnNpJGd2dapO35pY6K6uj+/dk+op3maz1n/yK9Mw=;
	h=From:Subject:Date:To:Cc:Message-ID:In-Reply-To:References; b=YoVouext6ZlpR4ZkI50pOw0w0vBOEosuek2Gj/ydX6Q/O5ygOiuq3kAr/FRFG7p4SNcMqORQSfNiWT5G63pbE7FdeYrT0vbonwJHUYNStCLZM9RyqLV3P7RYfyq/tqOG8Ucwr2ht5wmpxp/Lp0Av8Snj4Pl6DlNrIMnxfCDQw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net; spf=none smtp.mailfrom=ankey.net; dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b=TJ5X9c9+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ankey.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b="TJ5X9c9+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84237c55ef9so2327076b3a.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ankey-net.20251104.gappssmtp.com; s=20251104; t=1781545583; x=1782150383; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:cc:to:date:subject:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J6Dz8o9Ws8v17p3yxoQcldpA2jKECp2Yes6whuzgrz0=;
        b=TJ5X9c9+290G1aY1H+x96js5ox8q/MxFg3tB61ySvPkkmDOVFyIsnNbz5u+MYNy3s9
         TorTuaRcrvMzXDuZ3A3APmTVYfdF5a9viLLytDjHBfnm6wFIcOhxFDNxYoQzADhOnXEQ
         ZJ/AYAw5xxFJWnQT0VVCu1bNZj9jAbSHw3nb1/kk1cGYYvaqK6LZ6FhgwI8I9WeotmfO
         JXMtFeoYf3iA/s/e52i601WELUPHg842Eidps6S/H1jCaUfovHqBJSDv1sU+lVYvCodM
         xL8ofipx7zwgVzYEndd812Uzb9flVHJu8RoOoA9Vh7Emrih8GfX/CPrZXyvCOfIeasUI
         fNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545583; x=1782150383;
        h=references:in-reply-to:message-id:cc:to:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6Dz8o9Ws8v17p3yxoQcldpA2jKECp2Yes6whuzgrz0=;
        b=M4fyn/MN9zBGBhX0SqxjYtVx8e4pfcQtpqHNovWjtdRKvsx8cKRCUTAqtF/9FGFzkl
         fLQOrL+fFxm0intqixSVVcBEO1+upS/u/6w/3fnNaHV3xhAtzwcF6W+lqZkSFuisPUht
         MIikGy0UyxnFlKrgP12swiUGZmj1Bymh5cntx9TXrcO80ILjpYjzNYb8+Ko2fEIFwNCE
         hEZMnVgI5pYVic0gsdsiZ6X1TVWnuK1JBiyMnqp3scXR4zjGo/jidZGAKZn/HY6AXXnA
         I0st5hROf06WHIw37oKA+iHQU7w8iEh8Eolrsa+WEFhzWX2/xxYvYy2LWCcjNp+CVemp
         n09g==
X-Forwarded-Encrypted: i=1; AFNElJ/agAXhFFc1bb/Mtl1f9lIaMRR2UPXz8zjagUK0av8QVQkVlHw7yfiuVwqRuHSYWVVRMBAFQxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgwe/Xb7tsOyMEgFZFQIQux0e5uchsd/7loa/9dZG40dr3/hi
	kW6SjJUGlyiGTynhxnYfIPI9Lg3Noce2qqF5Hex95Zmv3g+pRjjtVoPk9lwhBDDO3A==
X-Gm-Gg: Acq92OH4JCJmhxH3ba6y286+QoUGFFp9E5etwDXD968/onAYXO4O8v+LuxM4b5AaRv0
	D2G2M+gQ8ahAJQMSXJnGu6AtOhV1aRLtR5L2+tUcm4KJhSGqXGMrEvBzxK4OtxlcnKsIZdTWtEL
	dHkcfLxKVVVXSt3X65CoLKwS/PckinynQrhIRve0iI4QsVN8msJ8qOcoiHOgHUnwAQTZd2bnQL2
	NcgMqFAuzfstZdsfYHwXxiR6GPgLYeKoVjwarlWI7kSGYwLLHYKjjlV+sUlC6u9+R6PzVzvFShW
	wGg31h12a4yqkKh63mZwFJgw3KfZpvNST1lng9as+YJ1bHL3tqu7jaGmCyKgKJWdQicx/q+H7cj
	2N+vq+J4jWlu2DdXKYlJnR6zffFRfHNqi2XwTI12e7yiB8ncHw+hRpq/G4a2CuWceHVFIapp2eE
	izIxim2vsWRESOVzg1p5+P2di668SZ1xLxeSQ7OTqijhIEmtCW20+PkqOLFn73tmYRlP0ML7rFm
	sXCW09YFJxXm58Q4L0eA5JLZkBp9AuaSyHX
X-Received: by 2002:a05:6a00:3908:b0:842:33f3:da7f with SMTP id d2e1a72fcca58-8434cd0c971mr15482546b3a.2.1781545582913;
        Mon, 15 Jun 2026 10:46:22 -0700 (PDT)
Received: from atimofey-ld1.linkedin.biz ([52.149.25.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434accae18sm11214086b3a.17.2026.06.15.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:46:22 -0700 (PDT)
From: Alex Timofeyev <sashka@ankey.net>
Subject: [PATCH rdma-next v1 2/2] RDMA/cma: accept cross-NIC same-host local
 dst in validate_ipv6_net_dev
Date: Mon, 15 Jun 2026 17:46:19 +0000
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1781545579.3-sashka@ankey.net>
In-Reply-To: <1781545579.1-sashka@ankey.net>
References: <1781545579.1-sashka@ankey.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

validate_ipv6_net_dev() confirms an incoming CM REQ was delivered on the
correct net_dev with an rt6_lookup() that requires
rt->rt6i_idev->dev == net_dev. For an IPv6 destination that is local to a
different netdev of the same host, the FIB resolves the lookup onto the
loopback netdev, so rt6i_idev->dev is lo regardless of which physical
netdev owns the listener address. The strict comparison then rejects the
REQ with -EHOSTUNREACH even though it was correctly delivered on net_dev.

Accept the request when the resolved route is RTF_LOCAL and net_dev itself
owns the address the listener was bound to (src_addr). This is the
receive-side counterpart to the cross-NIC same-host send-side fix in
addr_resolve_neigh().

Fixes: f887f2ac87c2 ("IB/cma: Validate routing of incoming requests")
Cc: stable@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>
Signed-off-by: Alex Timofeyev <sashka@ankey.net>
---
 drivers/infiniband/core/cma.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 9480d1a51c11..872c57943362 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1635,7 +1635,20 @@ static bool validate_ipv6_net_dev(struct net_device *net_dev,
 	if (!rt)
 		return false;
 
-	ret = rt->rt6i_idev->dev == net_dev;
+	if (rt->rt6i_idev->dev == net_dev) {
+		ret = true;
+	} else if (rt->rt6i_flags & RTF_LOCAL) {
+		/* For a destination that is local to another netdev of the same
+		 * host, the FIB collapses the lookup onto the loopback netdev,
+		 * so rt6i_idev->dev is not net_dev even though the request was
+		 * correctly delivered on net_dev. Accept it when net_dev itself
+		 * owns the address we were listening on.
+		 */
+		ret = ipv6_chk_addr(dev_net(net_dev), &src_addr->sin6_addr,
+				    net_dev, 1);
+	} else {
+		ret = false;
+	}
 	ip6_rt_put(rt);
 
 	return ret;
-- 
2.40.4

