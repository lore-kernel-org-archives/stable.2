Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE005221E4
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865057; cv=none; b=ZWUutcoGwS9LiY9fj83cYhQ9w77/TQ4dTK4GlzvdoT5iDfufxluJndDzhDZ4OmLBWo1ZLvUBJuHTxRD9ePJzApHK7eY3R/1Nxs9KU5ajhkjs+pXLPO58UsdxCzEHqFaFtXxpPACYsD/UDu9YcJ9ip7qmZJCiaCdaFnHEODTWqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865057; c=relaxed/simple;
	bh=3RzvX1xwFMFMNAEqMuJeEGt+6r6CRUg6jWWr1XoulkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fTe+3GtXFeXZjKbFJyQWwFCAd72b7J4P/bCgMxVa9wmGM5xoqRloVeEgqSSCPMoJGsA72RjG+3ZL66Z9W/XdQz8Gu8/XT+9ZkLwYO8eB5UfCrTtiGtNHklhABPLu8AEizEiap7nsL6uOGycoKViigMEH91IC2ryLl2szvrOP7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qI+u7BWs; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qI+u7BWs"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so34643285e9.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790865050; x=1791469850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vQ/xYcU6XZ5xLlPB/q/5AjykoyECyGBCjj320diGJdI=;
        b=qI+u7BWsEGJ2y8R5917LB6Ws+LRvDTkmWGROE2Zsn1eN2TLKlbZDyVBStYurxE9+lK
         IA1tEACvGR+jHccnZnqmuFhg8qtzMwiPcslK06xd05ZVXSZezM2v3gqkwWUBbyOQ/Sf2
         4j42pD+iHuC1/gYdmV3PkfEg9MEERpm5HO73GQ/gSKw/wZhGei6DqLL7xyibrPZ+GrFY
         svscmlsBEUb9eK1G7vQo48eEH8LPWUMcPj0Fkf4kH+O19QB+y0fqt2NfX24x2ixyKRUp
         kyHMckzwbFo03vITHChL/9b7hL7UjVhkYDs49WYAVE0NODEvCAqom80iMOd3tNaBn445
         tcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865050; x=1791469850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vQ/xYcU6XZ5xLlPB/q/5AjykoyECyGBCjj320diGJdI=;
        b=tdkbCRi0/NkwojziCHYMzc1M5QM8inIWex2+BenFyom48+bocWUt5NOf6cF3jqV+nE
         bU3ljajmeVNueKk0Gsi2iQXCZ2fBxKIapE+0zMXYTPnAwhNiqUcfyokucv6PTDc+KDQm
         ZWFu2utL8FMnmdeBk+Q7URg+Z24OVzrjVgosFuoZPLnWBAeSm6O01KASBdTjFVHlWztl
         v5+XJYheb3YUtq9exoygJTGdNnsS32wUqNjapJTNvDvTIbD0S2sNMdoTaGbUPu5a8G92
         KhJCmfIkCwmM27ly1bnO3tS0l2UGqBD3nALxassfcD7y388h3oZ+an+WvRaqFoMVPmln
         jsPg==
X-Forwarded-Encrypted: i=1; AKwUvByk9XMKosC+21PrrnBS2goj8hmHRBpms2Yyc46DqnK7fYJ4RUyzRG9Igqkq4Ndg8t5z+9G+u6I=@vger.kernel.org
X-Gm-Message-State: AFuF++nrpuoSXkYjCkkoAv7h2l99azHkX+S2/GbfUNs1SxogV6Nrv04G
	vQg1g8xeSs00HX7V3kHSGf35VaagEatKi00y1zfaex/iM7XaIceDWoik
X-Gm-Gg: AYBFou3fpgmlkfmwdGDYRO9ewBCe2QRVlKVD1FrJ3IAY/EOvKXsZSyUns7Iq7TFMNlI
	DHdbsVU3oidEbG96Y7yAAF3dbD50voqkA3kEUJD4ZoJGycf5C6FOFywjfIuHuJDsxW8g8HP89SZ
	wlPBqumr9v2yqfpz57NEektkasHrE+RPJAjiyGqEDqM3odXadchQC1yyUGG/9hOAnQuB1ctJEL/
	lzb1hEN/dI1z4evqEKebLY6NuKbjhyXmjhj7X4rzUoO45K7uWEIJ5datvCsxDT3vF6otxV291hs
	z4btUvIA+Qtj/MArAXRu0nyVxQjMHWP2QALJz7nbObhMJrj6X7G6gD7JzxORn9NqAnXl7huWEfR
	FZJ3GTrYvU/vCRYraAbAc4IU1asz1cjOcWb79h7+JamGGA1FJU8bg9iFom0b7IU8yhAnU8RXfBE
	GtmaIctE1lCG9jGsHHIwzwZ485G4EXGJ3zzKoqwm/68O+ZnbbnDQIg8qa8IXEw3lejxTO4V+KSQ
	5kEanzSjP+27ryffJFYYYiR0F5vku4Ou/FO1oKNgHI=
X-Received: by 2002:a05:600c:46d0:b0:4a0:1a18:b742 with SMTP id 5b1f17b1804b1-4a01ad909e9mr86412115e9.2.1790865049941;
        Thu, 01 Oct 2026 07:30:49 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.27.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a360c2sm6035921f8f.36.2026.10.01.07.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:30:49 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] rtnetlink: wait for RCU readers in rtnl_link_unregister()
Date: Thu,  1 Oct 2026 16:30:39 +0200
Message-ID: <20261001143040.28467-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_link_ops_get() finds ops on link_ops under rcu_read_lock() and only
then takes ops->srcu. rtnl_link_unregister() unlinks ops, then calls
synchronize_srcu() and cleanup_srcu_struct() without first waiting for
RCU readers. A reader that found ops before list_del_rcu() and has not yet
taken ops->srcu is not waited for.

Such a reader then locks a cleaned-up srcu_struct and keeps using ops
after the module that owns it is gone. rtnl_newlink() and
rtnl_dump_ifinfo() both look up ops without RTNL, the latter for any
user that dumps links filtered by kind.

With delays added between the lookup and srcu_read_lock() in
rtnl_link_ops_get(), and before rtnl_link_ops_put() in
rtnl_dump_ifinfo(), running "ip link show type dummy" alongside
"rmmod dummy" on a KASAN kernel gives:

  BUG: KASAN: vmalloc-out-of-bounds in __srcu_read_unlock+0x57/0x70
  Read of size 8 at addr ffffffffc02ff318 by task ip/147
  Call Trace:
   __srcu_read_unlock+0x57/0x70
   rtnl_dump_ifinfo.cold+0x30/0x3b
   rtnl_dumpit+0x7a/0x1b0
   netlink_dump+0x486/0x11b0
   __netlink_dump_start+0x661/0x910
   rtnetlink_rcv_msg+0x611/0x9e0
   netlink_rcv_skb+0x126/0x380
   netlink_unicast+0x605/0x830
   netlink_sendmsg+0x6d0/0xbb0
   __sys_sendto+0x335/0x3a0

Call synchronize_rcu() before synchronize_srcu(), as
rtnl_af_unregister() already does. This should be enough because
rtnl_link_ops_get() is the only RCU walker of link_ops, and it takes
ops->srcu before rcu_read_unlock(), so every reader that found ops is
covered by synchronize_srcu() once the RCU grace period ends. The extra
grace period only costs time at module unload.

Readers and the writer were serialized by RTNL until link_ops got its
own mutex, which is why the missing RCU wait did not matter before.

Fixes: 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.")
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
v2:
- Add a comment above synchronize_rcu() (Eric)
- Add Eric's Reviewed-by

v1: https://lore.kernel.org/netdev/20260929170444.218093-1-parri.andrea@gmail.com/

 net/core/rtnetlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index be9d1625bac31..580101b5ab585 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -707,6 +707,10 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
 	list_del_rcu(&ops->list);
 	mutex_unlock(&link_ops_mutex);
 
+	/* Wait for rtnl_link_ops_get() readers that found ops but have
+	 * not yet taken ops->srcu.
+	 */
+	synchronize_rcu();
 	synchronize_srcu(&ops->srcu);
 	cleanup_srcu_struct(&ops->srcu);
 

base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
-- 
2.53.0

