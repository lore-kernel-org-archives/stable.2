Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEDA345ED7
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136286; cv=none; b=gAq8ppOKr6OBE+A2MbYTimRj4yLnPp465bBY+wBSPixygZoO84MB0I4cue8nJe0np+1P1b/GTO6Rjos+wVoVfzXfSYIRgMKJIodAMFVBfsQbKqzXFx2MDGCrJOHLoh0UIfLqB1BCWrl2glgG3BlvZbGmxZDJQgJ6enKFzJbYpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136286; c=relaxed/simple;
	bh=JMmW7X9llhVLh4tgVzKcuRGQaGeUo8lmg2UIbEtqdUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrOhXIk7GdH1w/dP/2IBbakDFn1DvSQnGsuTTjzW+Xua4utxQTDOprr+CyDBzFxyyy0rpwLKzL1vdUCqDxufSVuD55TGgy4jA5fgawfPP1+DZ6yM2p4ym8QXlzIzKHydnfQCuOF4ZKIdzCgLUX3nNoXCHobqIkn2zTp2F/YaWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c797+PHR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c797+PHR"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aebd52488cso1007531e87.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136283; x=1787741083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=px3AKvC/vdgfBn94qjvmBeOftPFpPm1SynC6dbLUxb0=;
        b=c797+PHRwZ+xZZlXZXY6DEOAJIBwvk54c0GqPHL2YRI3zY6uy4p/lRR/Mf1T0tZhcD
         F4fipczlGmW6/OiYUfG+C6iodleXItIK90Vfv61q4ZGRI9fd3Um7c6PKhOws0FgdKdZo
         sXqgNnJCkVUgdCFPP5cdRDuQBl8Iy5acWLHkH7wEl1hhHyY1MZ3O50vESaroNcXdBW88
         YZsd6QypqRwbTxNusC/4bR96kWraQlliENClYr6Q97GP9rq96PmZAHSFUviTbVsBVA+6
         mI6x6AteRcsRcb7kzB2iVkr5HttitSBWz9b204A8iWp1BrNYCQuZD+d9McW9ZhjkkT62
         YzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136283; x=1787741083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=px3AKvC/vdgfBn94qjvmBeOftPFpPm1SynC6dbLUxb0=;
        b=XE0Vt2lrxFPDtvIjGiXgk9D0UhlmEDxjc+RXu4xZ23wAnIoTeyENLb3YQ5oT6BhhD4
         R7eeRpr4VOMeHSpx17SALr9m98Exb/hGIlYOWH93xUN2k5XNxEMCltUv0uoXHO3LSdRd
         2wIcdIUxmL3HNycdv+6A0NykPAoXTbiae4DTrIG94OlPigfdCqFy3t0NgScr/ADXPztq
         wQw34KKHGOBX8xf5/T3NyEFrTiJxGRjqS/XLWBn9HQOM5SJ2uyBPAn3fkFSFu2x2FdVT
         pywnYFIf7S5bH+FTxuFw7L3JPJplV1srh99xjozZ8KY39HyFpjXYlNFRAzryrbZcyrHT
         r+Ew==
X-Forwarded-Encrypted: i=1; AHgh+RoFHCq0UyV4eLoTNYkdLYiHcwjYOgSU35sAfLxYQxLIrHRQpHPA12fD7I0HxVYNNcUE5ya/xe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4I3zidmAWEblR8LAS63m+XOBMz2Dt1oA3iK2J3xzTgpZxh1r
	iwaZuNTEhnfO83DmMvdR1XZbHupOr39aB9IpQ0VVxkNV7bZ0zaX7tM1tzE0iRp3g
X-Gm-Gg: AR+sD13hLu0YkJ9OQxFv8BpS71CFh0Xt66B9ckvA/ab2sGvzGKeUywj5D2ZOkE+p2q5
	+P6c1L78VzFBXJyUfOjBzM04O2g/yf4IgCgERWj5l/QaE1m3OIFSzD6cESp7Sdg1taVlCOhnqLU
	KDg7S7lC0GCIotCx//USgeU2oSl3gV0g21HNZDg4iovtwSmqvJy4f9hMmjQ/T5ZaF8ob3gM9v+j
	qNAkCyNihID/8U9XEcaP8wHWovNQQPhUejtTnGPoUTZk/2C3rtAtTl9J1aFe/kdYJtaMB1smV0Z
	/tlrGIeXnFwFDloIBXZ903qhXQiSHOh27YNzZBMi8VFcjKRvpBUKXVojQq+X/wH1wlbhIXlOVWC
	6G4UqUA80E1HFPmZQJJjEpbJOthUm4aK0uJDp/kVR9RG5TB78kk4PH1JIC+gtvx3u468gT4F9Xo
	j1qs4Mb7AdHYbiyDUTZFPDnmgE/J6NykM3+tEt1VbP0AJ3jXEhqkYWnySO6jg/jRGmcaogDsRMJ
	bXqFwI++SY13bjxaokUy5Rq1wtbSabE
X-Received: by 2002:ac2:4f03:0:b0:5ae:b01a:d213 with SMTP id 2adb3069b0e04-5b47892e750mr1257864e87.3.1787136282553;
        Wed, 19 Aug 2026 03:44:42 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.142.55])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788539e3sm440890e87.13.2026.08.19.03.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:44:41 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Thomas Graf <tgraf@suug.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] ipip: fix skb leak in collect_md mode when metadata_dst allocation fails
Date: Wed, 19 Aug 2026 13:43:39 +0300
Message-ID: <20260819104338.432631-2-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In collect_md mode ipip_tunnel_rcv() returns 0 without freeing the skb
when ip_tun_rx_dst() fails to allocate the metadata_dst. ipip_rcv() and
mplsip_rcv() are registered as xfrm_tunnel handlers, so tunnel4_rcv()
and tunnelmpls4_rcv() read the zero return as "the packet has been
consumed" and do not free it either. The skb is leaked.

The other tunnel drivers all dispose of the packet at this point:
ip6_tunnel.c jumps to its drop label, ip_gre.c and ip6_gre.c return
PACKET_REJECT, which makes gre_rcv() free the skb. Only ipip returns 0.

Jump to the existing drop label instead. It frees the skb and still
returns 0, so the packet keeps being reported as consumed, which is what
we want here: the outer header has already been pulled, and neither the
remaining handlers nor an ICMP unreachable have any use for it.

Triggering this needs an ipip or mplsip tunnel in collect_md mode and an
atomic allocation failure, which is why it has gone unnoticed.

Fixes: cfc7381b3002 ("ip_tunnel: add collect_md mode to IPIP tunnel")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv4/ipip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index b643194f57d2..ddf62b45566b 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -248,7 +248,7 @@ static int ipip_tunnel_rcv(struct sk_buff *skb, u8 ipproto)
 
 			tun_dst = ip_tun_rx_dst(skb, flags, 0, 0);
 			if (!tun_dst)
-				return 0;
+				goto drop;
 			ip_tunnel_md_udp_encap(skb, &tun_dst->u.tun_info);
 		}
 		skb_reset_mac_header(skb);
-- 
2.47.3

