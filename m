Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB7313531
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785564156; cv=none; b=pHp033YnhZOcC7G8V9sJaqCoKM5oDUasm394xtRVSiel9DSYCqfRj5EbmdkinIqjYKTpAobYnD6Uecwe3UKS81wcmgrHHAQdRYfPz936f+WO3zhcjkpQ5EG2geuLvMblV5W1Ekm5ZPPOoU3aCFr7UWntVWD/ZAqjronG2wyf5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785564156; c=relaxed/simple;
	bh=cCRUw9Tymj8WgwK1j3rS3w2OZiOMdK3gIoxQR8pYLGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpyT+u6WH0FqyeaUMHMM0MPW3rKraEaAUoseBDkAxhQsG/KH28RUIufMJFJ46Fh8zSsbomicyxnjHKuInsuPJVGrkz3j3Rv/dlWiOzrmnyreAsqszX0nQNcuLVwLri/3ubrg8gTQKl7HJyb5WLjTOl5vD/kwBoGOMgw6sCbgYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POIogbOn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POIogbOn"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38cfcb507a3so194026a91.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785564155; x=1786168955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wG08jLgdCXnGeCo9TntB3GpQ3NVQXE5hVvOabkH8znA=;
        b=POIogbOnw9X+TMqiJ4lECbJyXuvQ27W8u561fswtnkQTMk1u1NnTLbw30X6DV7KrSE
         MGA8iQs6zhzRlnyRlA+FdpvQd/upyxOt8pAMtGM9RserjFf6tzA+eQPoxziIRWmVgbsr
         NLwZJasZGriMmw4wvNwKOHAuezP7cRmsuB3UgdP/rn56GcP7OUs7McyHTzRsGZ2raQtr
         vD8nE2xVpq4Qd6t9MSOJSGOCSDVRXM0EAa3H+CVqVEfSJSe6MQvtC+os3l88VycmCfig
         YiftZKHIJq20X+NrGMXPR8ZJIa4EydU6XtCdiygK6c3QG2rjparOnysWZvxquCLuf5ex
         JY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785564155; x=1786168955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wG08jLgdCXnGeCo9TntB3GpQ3NVQXE5hVvOabkH8znA=;
        b=KCqxzOfHJwQR899C6VgbDKROjRBiDuSvJzrIBVR88FwmTjTWT0kvlxm+awTCX71TaB
         QwgesM2V/fOsiklwQQIJIlz+qoO4dFtbB7JqfPVkjid50DMJSTrHkHOx3YBFy3mrzGcR
         s7f222mLjnF34kBW3wSpxu5tEtH8BSa/uMcA+jIBBYMm8u3uaXjMdSTPqMmMNfB6Ae7l
         Mqg5Ukaxv3vdK4053oc5Fpw3RaqHFWvT2s4yjR102xlH3GoMXNwrD9+W8iPMLiXI1ODQ
         y6iN+0UctY9xY4lr0b3vazYLGsWdp/eh+P8q9fLQebiG1F3TkLyIa8Q/5smHUiOz8UI9
         UaFw==
X-Forwarded-Encrypted: i=1; AHgh+RqJks/tmMBC9CU/ldB/7BAwgZq8h/0Z4wPGfahRboJ7igSnzDzjvFkw4udCg9bYwCJAVz6evjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9jsytPS1OBEDnGCfYI2ELVBFp+oYuLPbcWQC38KsvK9al+w9
	NHWx6pZoRmSXvQPyKKx0bEe8g6tDnXAj9z9nwhyPinYr6BInXBL8FPNM
X-Gm-Gg: AR+sD12+x6n4o2Jp95vrNKMsjoSIkyOVoYXo1vdYnuCJUi5S9itYNKRjlEtQleaMaoF
	+sh3Qrb5XAn4E5MIX5v6GJlUrIlQKlx581o8m8eJDHtjO5X/tWkc9BGgJUyve7ltRQGOGNNXggD
	bIee+stUHFO9z2hcoSB5ytCYt+Iot1PirZGexQNY1GJCPT9xv6fy3ye07cBNnUrRb0D+8OGOm4V
	eYgXgHyPQNjuqMkj2CXIPi6m0CncJM1wIPqJUQ2YXSetqb6tWg0C84SweM97HAptT/ayEwkWRhi
	g2s1fWgcMvDaUcFXqulclj4fMoNepT4CvDh+3cDZv/1Es7QOkViJ1WGon+VrAE6x9K2dLbDMZ3E
	XGnhSoGguu2o7wl811JXGuUUxZW6DvaY26ApyVjhRACU2AXVg62oIEzaCevZK74AXsI5Cf1ezAy
	8PxqG/B6XBG/+VPQPpOHJcrMFkiTNtesWRBvRRn8Mao7uzX9EIszJ99mQuNDZenK5GvwC60MkLb
	U3ix15VRhVM39/bHg7wS66t2D8rAS8BuLG/BKOGCH1BK/nWQKwFzMs=
X-Received: by 2002:a17:903:46cf:b0:2ca:ecf6:9115 with SMTP id d9443c01a7336-2d0523bcf3amr36902565ad.2.1785564154559;
        Fri, 31 Jul 2026 23:02:34 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm22462138eec.28.2026.07.31.23.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:02:34 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	William Tu <u9012063@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] fou: ensure GUE headers have enough headroom
Date: Sat,  1 Aug 2026 14:01:15 +0800
Message-ID: <20260801060115.3538849-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipgre_changelink() installs GUE encapsulation before it publishes the
new GRE header length and updates dev->needed_headroom.  The transmit
path does not serialize with RTNL, so it can interleave as follows:

  CPU 0 (ipgre_changelink)        CPU 1 (ipgre_xmit)
  install GUE encapsulation
                                  reserve the old needed_headroom
  publish larger GRE flags
  update tunnel->tun_hlen
                                  push the larger GRE header
                                  push the GUE and UDP headers
  update dev->needed_headroom

With REMCSUM, the new layout can push 16 bytes of GRE and 20 bytes of
GUE/UDP headers into an skb with only 32 bytes of actual headroom.  The
final UDP push writes four bytes before skb->head.

With the update window widened, the kernel reported:

  skbuff: skb_under_panic: ... len:128 put:8 ... dev:gre0poc
  kernel BUG at net/core/skbuff.c:214!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Call Trace:
   skb_push
   fou_build_udp
   gue_build_header
   ip_tunnel_xmit
   __gre_xmit
   ipgre_xmit

Make __gue_build_header() ensure space for both the GUE header it is
about to push and the UDP header that follows.  On normally sized skbs
the check is a no-op.  If configuration changes race with transmission,
skb_cow_head() expands the head before either GUE write, or returns an
error without modifying the packet.

Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/ipv4/fou_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index ab09dfcdecbd..8cf0d43acb41 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -980,6 +980,8 @@ int __gue_build_header(struct sk_buff *skb, struct ip_tunnel_encap *e,
 						skb, 0, 0, false);
 
 	hdrlen = sizeof(struct guehdr) + optlen;
+	if (skb_cow_head(skb, hdrlen + sizeof(struct udphdr)))
+		return -ENOMEM;
 
 	skb_push(skb, hdrlen);
 
-- 
2.43.0

