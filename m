Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3235F185
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542472; cv=none; b=PmbjQvCtYImWdHmfXuoXes0K5skyW6vSjOlbDM4CeY33M4Q/J8RnAGrnbwaIoTenr6rtjPsCw6TF88xaYlGYYcuDIANH4OFpavA0Dk3kSt4HBRCP2AFZiZqUFZfgp3qlVoB71aJfVwfXoBeNL/bM6zZMLuA3U1OhwZONKGsWm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542472; c=relaxed/simple;
	bh=Dek4I5uP0FMYW8XeEuoDo68UhqlHR47NiFV4NvSaHmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je0IplUmxMERiMuhiW5DzGsbkl8FTXUNMIuXFc2GrnVaafY2oqoENAEWtMe5fvtJ5c5TSJ/SwdnS/0YcUhMYtKML5Db+UzrKWsgDjAfFVkXzurkf9AHJ3KZrx/j55CnKONpzjov+iPRPGT+UOwaqhCtHQ1Y0pfOAqXQzDbGraKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dd6xpXHf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd6xpXHf"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so2872428a12.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 20:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542471; x=1788147271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLRrcZ+wu3rYCbjfRuOSR4inkFMDxN07CSBT+LJEscY=;
        b=Dd6xpXHfnoqITo1VCu+q7/YLjre9bdSGlyeCIV2I3FuF+KCb7kukR5QVuoJaX/ca8W
         M15Qu9p+bHIJ6YhJZMsn/JXmpXUHzXWbwh7LVlWIdLbyW2KVc9CycOUVGkefRbO4BIr6
         +2pER9tmVPXACVAcEsCnAopnXTOsMtv3hf/1/66zdDdd5YkrcOVDL9Ie/zN8dYYlLljo
         vNMPpsVXrXC9TK3PfJlj4yw7vlqcE32PecmBmzJ3bTBEcNFxC4I9ugbcqfTSE4t3Ma/v
         WYt1UBBMvJYUvWHh0nm8kyjAisrwrksNlR/eFsrfpoq9ZttmzNV/i44lJhUQYuXk/kSW
         tPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542471; x=1788147271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLRrcZ+wu3rYCbjfRuOSR4inkFMDxN07CSBT+LJEscY=;
        b=CGYUPP0hVYzn2+/poJaHCFluavTcrnSWQAjZ8NUI8LRWlzLnkYDRJrUT1IXAH755Ra
         8/4l/SFcQGfS3cMznx/t+mn9swL5oO0ovZoI2CNG5f7L1FzanEhsFatJNK8iihSU4+xD
         VCpK+OfcWnXTQxPaY4bDkHO43lax/Dy7YOlS7y0+PAQxcCAhQwRa82NuJ0Q2fnsxHKVv
         8/St7wEJW1TDIj/ja27xVY8IckeRnDg14dmooTs3tPVTB6Tchl25sKm8YSCt09Ya7Fzl
         fNCEi47FBHb4p4vYeORVaoTd7qLNV+pyUNy1BCrvKkw1M1wLbCoYChLQJWryisAwL6uc
         kB1g==
X-Forwarded-Encrypted: i=1; AHgh+RpMQTsbvNOlLIBszvShB5X7LVztt4EPXCPpOLGOQ3FfFcQhMF6bR4nku7oteLhoCsv0bUiLYFI=@vger.kernel.org
X-Gm-Message-State: AFuF++nvsfk+u+iCEo1m7pdozh1NUXYZp7i74u7BwKR5cN+5fFbZOfp+
	Fu8RIqyfHxayDeiqf5rQroM9UGTTYvEYFcmSgtFA0zCjJwRiDHPlj24v
X-Gm-Gg: AR+sD12wgoKWqy4v+0cvsd8eiRZmxRYEBN82/Le3IA9OCAZBJ+KnWfvMXv+/wJXW3aP
	OaW8miZw76IMfy4qwZwqhTu9zFmbcrHadJAMYKfJ56npx7RjEeDjarx4z6v84FiDoqYmKyZOIq3
	i9n90FhDnokFenPPc1ALQ+kmxsFa5zyZLXnuBUrU60zaHmrdpNgzKkt1V9BXY+DCHFyzAzLmT4i
	/VBu7vPvH5TzIOqwu1ZT3ehXe2VJIyAIFzQe5q50oh3UqVfMrB5G+Y4Opqe3No1gcZmBGg/wFkr
	8YaWq3msTFVjfXQ7dFV/k6g4XKxGlWyayYWBMoBBm4Wyi0DW3OjdCWlTU5adiducevJPIrKj0rB
	mrs7j2VZndN516RxDX876/tyP+afNGXz342WKf6aKhpZd6xSATtpMZmJQ5ImxmY093HCfusb3Al
	LSxfp31UGkINeoxE/8jgwBAkgmW60P5YSsw3huU1N8PhwVS2RJK++AjrZj4SeB92QaeBjAgZBxB
	mbK6Ey+sxA=
X-Received: by 2002:a17:90b:164e:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-395c352fa60mr33931547a91.9.1787542470791;
        Sun, 23 Aug 2026 20:34:30 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm4227256a91.1.2026.08.23.20.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:34:30 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch,
	kees@kernel.org,
	jiayuan.chen@linux.dev
Cc: kerneljasonxing@gmail.com,
	ij@kernel.org,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 4/8] net: fix out-of-bounds write in sk_clone() racing with IPV6_ADDRFORM
Date: Mon, 24 Aug 2026 12:32:48 +0900
Message-ID: <20260824033331.1084971-5-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824033331.1084971-1-imv4bel@gmail.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_clone() allocates the child from sk->sk_prot, and IPV6_ADDRFORM can
change sk_prot under it. The conversion requires the socket to be
established, and a listener gets there with connect(AF_UNSPEC) followed
by connect().

tcp_check_req() completes a request without the listener lock, so it can
run while the conversion is in progress. IPV6_ADDRFORM stores sk_prot
before icsk_af_ops, so tcp_check_req() can still call
tcp_v6_syn_recv_sock() once sk_prot is tcp_prot. The child then comes
from tcp_prot's slab while the AF_INET6 code treats it as a tcp6_sock.

tcp_inet6_sk() is a fixed offset into tcp6_sock, and in a child sized by
tcp_prot that offset is the end of the object. The ipv6_pinfo copy is
therefore a slab out-of-bounds write of sizeof(struct ipv6_pinfo) bytes
past the child.

The out-of-bounds address is also stored in the child's pinet6, so
everything that reaches the socket through inet6_sk() keeps writing
there. A request that arrived over IPv4 takes the same copy in
tcp_v6_mapped_child_init().

In short:

  client                              the socket owner

                                      socket(AF_INET6)
                                      setsockopt(TCP_DEFER_ACCEPT, 30)
                                      bind(), listen()
  connect(::1)
      // bare ACK deferred, request stays
  send()
      // tcp_check_req() ->
      //   picks tcp_v6_syn_recv_sock()
                                      connect(AF_UNSPEC)
                                      connect(::ffff:127.0.0.1)
                                      setsockopt(IPV6_ADDRFORM, PF_INET)
                                          // sk_prot = tcp_prot
      // sk_clone() -> child from the TCP slab
      // tcp_v6_syn_recv_sock() -> memcpy(ipv6_pinfo)
      // out-of-bounds write of 128 bytes

KASAN log:

  BUG: KASAN: slab-out-of-bounds in tcp_v6_syn_recv_sock+0x297/0xce0
  Write of size 128 at addr ffff888015b5f480 by task repro/161
  ...
  Call Trace:
   <IRQ>
   __asan_memcpy+0x3c/0x60
   tcp_v6_syn_recv_sock+0x297/0xce0
   tcp_check_req+0x374/0xff0
   tcp_v6_rcv+0xb9f/0x1e90
   ip6_protocol_deliver_rcu+0x1aa/0x870
   ip6_input_finish+0xac/0x1a0
   ip6_input+0xe5/0x490
   ipv6_rcv+0x2a0/0x3d0
  ...
  Allocated by task 161:
   sk_prot_alloc+0x45/0x170
   sk_clone+0x49/0x960
   inet_csk_clone_lock+0x29/0x2c0
   tcp_create_openreq_child+0x2a/0xf20
   tcp_v6_syn_recv_sock+0x14e/0xce0
   tcp_check_req+0x374/0xff0
   tcp_v6_rcv+0xb9f/0x1e90
  ...
  The buggy address belongs to the object at ffff888015b5e800
   which belongs to the cache TCP of size 3200
  The buggy address is located 0 bytes to the right of
   allocated 3200-byte region [ffff888015b5e800, ffff888015b5f480)

Checking sk_prot before the clone does not help. It can change between
that check and the read inside sk_clone(). Use sk_prot_creator instead.
It is set once in sk_alloc() and never changes, and the socket is
already freed back through it. No caller that replaces sk_prot installs
a proto with a larger obj_size than the creator, so the child gets the
size the parent object actually has.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Add the trigger sequence and the KASAN log to the commit message.
- v1: https://lore.kernel.org/all/20260817090319.3897799-3-imv4bel@gmail.com/
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 1ad41904db25b4..098e58b40f304b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2479,7 +2479,7 @@ static void sk_init_common(struct sock *sk)
 struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 		      bool lock)
 {
-	struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct proto *prot = sk->sk_prot_creator;
 	struct sk_filter *filter;
 	bool is_charged = true;
 	struct sock *newsk;
-- 
2.43.0

