Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC353F4DC7
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788681335; cv=none; b=vB1GIHWTfn0RjFN8y4fzYkhyZPIBvmGNyDpATrK2DcbHwhTb29sox5UMiZ2TuPVB9wMDgHyBxtfFM9rilAJJy2s31lBorK4s27xQ6HafZauEhRXYW+omKKNuaVFDg/FVJ+2S5ec6/955aCWGe2wwqSWqLF+SAvq6NWu1Rkd+cvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788681335; c=relaxed/simple;
	bh=qNTDOlPILV3T04HAjwGIZq4By932gRZYYSompesDPNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhihyyWJiXLuB2LWVvMEGVNxLgYIhWWc3Yf1yhaz2pZoXYse/LY4Htf/tAlC7ydIaUmH4zRnV6oK7qjU/uUGtrCJ9pgKjKa6Ca4CID4K8hwfeeOdNgqk1JqZ3X/SA6m99sGHNn8g9SGczplVF0NOQS+tjCFBpfqP9UfMlFj2+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5K1D/2k; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5K1D/2k"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d9004f39d3so30524995ad.2
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788681325; x=1789286125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/l1qLwJSS6D6HFID29WNOWsYoWwOmZTzkLIw+IBHN20=;
        b=j5K1D/2k29HcTJ+qa0lx2BCGIjrj0+232m5KUNbxLr83GgA7rPw6Mf3FyNU5Ia+++6
         UejkdeMIJXGBge8ahwgfVzcGgChwxn9BuOO6ucNmcbgb9XSe83BJdX0BujjTsoBxaJrA
         hvhroZa7yOc8bNbhCX289xeiClq2y8qEWz0zkyAHZV3O22WNrMqvQl8GeocJnVqHWfuf
         qZDxKq4zm8VuVmk2fk6hdaHlG4I7PANIr1ZG1NAQPad3FSvmj2aBKkPg5ED1JJBfuIUp
         UWiEVGYK2dKR/rqvPwVz7SVevJrEObIXrqWxls3sDyDZh5z1h29iJld9tQC/x+1SIizs
         fdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788681325; x=1789286125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/l1qLwJSS6D6HFID29WNOWsYoWwOmZTzkLIw+IBHN20=;
        b=ncHeC4hz1LvAPeojJ3d1205VboF0H1/vsNITi01cjwvMLbOIAW1hJoNRUqdSU5BHzt
         jetX8YNzxp9ZU1b0cLguZTL/gVmTOVrHfQ5H97E/F36ttaMJ/fy97lTv2jKFV8buK3Of
         MkDuRk9zFE00XwD4nhyUbBdgrDRt6kHaKDPU16sWGo2HdjpdbuhWvYo7yFjdjuDbtEhF
         pVIlNBVMYyaNVkYByJqa5O8oipxqqDyKCSw30R1/izWljr9cMbCs/VylpdESj7VX89uL
         QOihtxZPb/thtAywsTqQhz0iRC/NFfDHlfNdEe7FBisvSj9aUOBSFgoS8ikZKL67OvM8
         PZfg==
X-Forwarded-Encrypted: i=1; AKwUvBx6y8QcsGokHqN8CbqZVnVxTVV1PmXivxH5nJHQWp4TPpIjEapm7BtXCPz6M/IVGWBl401lAmc=@vger.kernel.org
X-Gm-Message-State: AFuF++kocm4tswp1t5Z/4KuYiW1hM5pLpsjiJLqO/+QBgPGEnItVb5mt
	S9CMlX7vrNef0/o59xlKPBCJSepoRvxTFqfxJ8ToNOGXjA6pO7gKcDZq
X-Gm-Gg: AYBFou2Dz1nUURZYndZ6zmyUkirdX06L9tkfhRG+TyIAlsYpKYDGwk3uZUpVetxc8mw
	t2vQEXgdIu/fKZ+C/aBkSeuXPCdplyaRtdoECDRkUQLGtViZMrB0eoLKNzCHzRWQaCm0h2+zMZw
	d0puUaltLY0wpks6y+r0NBzs+iUFvTGb3CsGbFz9EG27A1+RSJyU9SjSULSnPaMRvaUpsDl5FNI
	Sx7uBuaBoLcsRBgxZsWMlomzsKCwGYTEyo/e7YLF9j4FABLrnn0F9fyCegmuDXVius02SaPqu8y
	vaESvjkOg+d+sx7pA0DvDZQl0tXdXvYBGAaSdxW5b5BnKH7jZpFQrJL08mlwEVz5HRGDEPiO3t9
	0Ql3mWhLqkDD4+f+RhFdX33v9nYSUhUCjiLfhMMq9/UuqpvXwHjhl75wwsXfpAuAloS2ZA2PZ7I
	8weZXNZ0M4PshMFGNceU+BuH7mquC8tGDltjSEf9ksV0U7Rx1c4DHHYGZADzRnr6IzO3wwp5Ezn
	TEUTYTjZpDqLmL8IZCT
X-Received: by 2002:a17:902:c40f:b0:2d7:107c:917b with SMTP id d9443c01a7336-2db1212ee51mr225631555ad.0.1788681324676;
        Sun, 06 Sep 2026 00:55:24 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.115.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495b57fsm29936115ad.24.2026.09.06.00.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 00:55:23 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+459f67f4d8af8ce6@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH nf v2] netfilter: ip6t_rpfilter: reject routes without inet6_dev
Date: Sun,  6 Sep 2026 15:54:40 +0800
Message-ID: <20260906075440.4123076-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6_route_lookup() can return an error-free route whose rt6i_idev is
NULL. Lowering an external nexthop device's MTU below IPV6_MIN_MTU tears
down its inet6_dev while fib6_ifdown() leaves routes using nexthop objects
in the FIB. An unprivileged user can construct this state with rtnetlink
in a private user and network namespace, then trigger a NULL dereference
through an IPv6 rpfilter lookup:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000000
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: rpfilter_mt (net/ipv6/netfilter/ip6t_rpfilter.c:75)
  Call Trace:
  ip6t_do_table (net/ipv6/netfilter/ip6_tables.c:316)
  nf_hook_slow (net/netfilter/core.c:619)
  ipv6_rcv (net/ipv6/ip6_input.c:351)
  __netif_receive_skb_one_core (net/core/dev.c:6216)
  process_backlog (net/core/dev.c:6680)
  __napi_poll (net/core/dev.c:7739)
  net_rx_action (net/core/dev.c:7959)
  handle_softirqs (kernel/softirq.c:622)
  do_softirq.part.0 (kernel/softirq.c:523)
  __local_bh_enable_ip (kernel/softirq.c:450)
  __dev_queue_xmit (net/core/dev.c:4913)
  packet_sendmsg (net/packet/af_packet.c:3139)
  __sys_sendto (net/socket.c:2252)
  __x64_sys_sendto (net/socket.c:2259)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Reject routes without an inet6_dev immediately after lookup. Such routes
are not eligible for reverse-path filtering, and the check protects all
later rt6i_idev dereferences.

Fixes: e26f9a480fb6 ("netfilter: add ipv6 reverse path filter match")
Reported-by: co+459f67f4d8af8ce6@bugs.sh
Closes: https://lore.kernel.org/all/VtWUkE8QzJt5CroTj2V2v3ZQ0gwbXZ7nq7I3@bugs.sh/
Suggested-by: Florian Westphal <fw@strlen.de>
Assisted-by: Claude:gpt-5
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
- Reject routes without inet6_dev in both loose and strict modes, as
  suggested by Florian.
v1: https://lore.kernel.org/all/20260906034939.3746540-1-bestswngs@gmail.com/
---
 net/ipv6/netfilter/ip6t_rpfilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter/ip6t_rpfilter.c b/net/ipv6/netfilter/ip6t_rpfilter.c
index 67c87a88cde4f..b5def30c3127e 100644
--- a/net/ipv6/netfilter/ip6t_rpfilter.c
+++ b/net/ipv6/netfilter/ip6t_rpfilter.c
@@ -61,7 +61,7 @@ static bool rpfilter_lookup_reverse6(struct net *net, const struct sk_buff *skb,
 		fl6.flowi6_oif = dev->ifindex;
 
 	rt = (void *)ip6_route_lookup(net, &fl6, skb, lookup_flags);
-	if (rt->dst.error)
+	if (rt->dst.error || !rt->rt6i_idev)
 		goto out;
 
 	if (rt->rt6i_flags & (RTF_REJECT|RTF_ANYCAST))
-- 
2.55.0
