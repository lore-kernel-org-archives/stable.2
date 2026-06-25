Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A937C0F6
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373444; cv=none; b=htdHG7Klnatp/++qoEGiCwEShFoG3cMaXN+AWG8vaYhWviKxB6I3HbqvwyoDnMzrjucvUESlXN9l1rF0UAn4Sl6715a2j8yGTHPlUJ2HFsau5ABKmFI/u3wnoFIlhBdX3AjjFUic6T5iBHAi5MaTs6Un8phxo74sZHoAPM39TyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373444; c=relaxed/simple;
	bh=pbfrB0q1Kb3XDgOMuvXd30ml4zNgLLtygsbeeP5M8c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOsSTxjPugJpfqAIm1xTb5yxE+qYcO1K0CZl8DzeoctV/yKAkw2NicM/ikCDFdoysJl503phE38pdvpZucbnkgWBIvd1nRTYDAMIRvQIy+LjIxONHj5zAGATolVgQaP6/FNDo6sFWZVt3ZTHsS/rtqufaNWc7ovYMyAQrzPIkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7j9ku+T; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7j9ku+T"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39ad1d2555aso1368091fa.3
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782373440; x=1782978240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4refMHFUpBzje/uZRNbCENQcQd01tpQ4O+oo7qmguQQ=;
        b=g7j9ku+TUORKJsOJTAVd1inokKmhas/mZnP3fYLL2KKshC6GJUjJUnDYoM39sFkYAC
         kE1DdwlRM178SxNn7L4TsoPeshqM9GGpo5J95P3ty7tStklY3O0IEWcuYLfYt5Y5XyZv
         Dh677HxeNux+X02+yrikRJly8LXlGi/io0TFEsoCL953PvuNcbZ1ijtVxxw0dJiyvpsv
         57q23ZxWuZ+1rLbcsONRhhPqT6OkFNAYN1jCUtKNbDATnQ8bgLqCMDFUQyp/jZd5BJWy
         mpm4WmgZxvsjd42k5nxgbPJuXBv8e4Rj4H9arQYGzzSf0KjlL/CdrZQ4t+i1wscgdwIk
         MLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373440; x=1782978240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4refMHFUpBzje/uZRNbCENQcQd01tpQ4O+oo7qmguQQ=;
        b=I9wBefJecAf6Ox8ORqIbBEDGPfJl8sAB8IOXvxNS94kY+yjBVBIHQRO1k3HSIKMWX4
         hcOmpZl/Kr5V+7f7IjNjzaXEHeY1BfVO0BvERqLqVdJTpGjsROvIdNZ8I+suJm/99+vm
         KgwygcR29B15UTKV0xwm7yCAtjAR4ryXrFn/JiPO/QM9LPelzLigCyIjOwC/kkS8+/R3
         otdcgXBUSgAKFuN+N4EE66ZzemBIkqXA2CAXUrt2JYwCQNdTlb6I13miuDEV7/rJX/ku
         lLwv+a+505n0N2xcNuhl0YJFzrdNo5TlfAk8pexiU09eMSTdy8I2ZnAJil0R4086LwTo
         Tf1w==
X-Gm-Message-State: AOJu0YzcQyBWzgY4EadijQ6u+xWWF1Ji8fA1QXYcDephfK/VGb7c72Jn
	OoPvItLI3u64czM/MAtvdpR+FBgOpaCjc1XwN+NPtcXWZ8Tx+J89WThqgO8jX9OZDoo=
X-Gm-Gg: AfdE7cnpl+9vMOIH1LE0dPCgO773UqLrXCy3aRhYGvl5pJ01bTvgOzS1pfOCoau4xaE
	Gu9bU+eq6qf9aPxebDTY6bzOtJ5IUP3OX3tWsr73ymGt1Rj3Q6HuaQs1aGuI89FFzuWY9KH0fCp
	O/GHOPrSGrMB61/ADg4j1TtNBkwCzxTW3qB6z3VvePBzQqYYKc3+jypM5Eu0nWU8A4blHrk6idz
	3HdF6evbcP711f7yiWQdP3oQ4SKfVIwIFN68tMGqmfyFirPcQuqG/4hExMitxiaZ/vyF2vqu88g
	fkvORhgjJEAciucHFN6vuB4diDkJ2aOeDHBlz2s5+Q3B2PECrJMD/ap+aGcwdpFzQubd37Y6q11
	5QvJiBGG2BFBg/VQd0uo8Qt4UnZdSQvxXFxBrVW5MCtsuhU1MucSdLlpK4HIDeYLVWa7ymvOuZb
	53FtsfmSfH+kQb9kCyGfCd96ax+vg8
X-Received: by 2002:a05:6512:6407:b0:5ae:9c54:8037 with SMTP id 2adb3069b0e04-5aea1f48d55mr410087e87.17.1782373440062;
        Thu, 25 Jun 2026 00:44:00 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999b156a63sm39705531fa.25.2026.06.25.00.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 00:43:59 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bestswngs@gmail.com,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Martyniuk <alexevgmart@gmail.com>
Subject: [PATCH 6.18] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Thu, 25 Jun 2026 10:43:46 +0300
Message-ID: <20260625074348.90149-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Long <lucien.xin@gmail.com>

commit 2cd7e6971fc2787408ceef17906ea152791448cf upstream.

udp_tunnel_xmit_skb() / udp_tunnel6_xmit_skb() are expected to run with
BH disabled.  After commit 6f1a9140ecda ("add xmit recursion limit to
tunnel xmit functions"), on the path:

  udp(6)_tunnel_xmit_skb() -> ip(6)tunnel_xmit()

dev_xmit_recursion_inc()/dec() must stay balanced on the same CPU.

Without local_bh_disable(), the context may move between CPUs, which can
break the inc/dec pairing. This may lead to incorrect recursion level
detection and cause packets to be dropped in ip(6)_tunnel_xmit() or
__dev_queue_xmit().

Fix it by disabling BH around both IPv4 and IPv6 SCTP UDP xmit paths.

In my testing, after enabling the SCTP over UDP:

  # ip net exec ha sysctl -w net.sctp.udp_port=9899
  # ip net exec ha sysctl -w net.sctp.encap_port=9899
  # ip net exec hb sysctl -w net.sctp.udp_port=9899
  # ip net exec hb sysctl -w net.sctp.encap_port=9899

  # ip net exec ha iperf3 -s

- without this patch:

  # ip net exec hb iperf3 -c 192.168.0.1 --sctp
  [  5]   0.00-10.00  sec  37.2 MBytes  31.2 Mbits/sec  sender
  [  5]   0.00-10.00  sec  37.1 MBytes  31.1 Mbits/sec  receiver

- with this patch:

  # ip net exec hb iperf3 -c 192.168.0.1 --sctp
  [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  sender
  [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  receiver

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Link: https://patch.msgid.link/c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 net/sctp/ipv6.c     | 2 ++
 net/sctp/protocol.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index d725b2158758..7434309785cc 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,9 +261,11 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
+	local_bh_disable();
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
+	local_bh_enable();
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 9dbc24af749b..6ce58fc95ef5 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1102,10 +1102,12 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
+	local_bh_disable();
 	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.43.0

