Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852134;
	b=dQHu0rarJUc74Ker8jcylHlrHUz7Ks6qB8wRoS7vQIfTol0kLkDGEyFSxahAAJ3F35Li
	 3GmvEZg0F97oFb1rKpcZ2FDXSNmf9kcCxCtfepUD+N4snMc7+IRzKdPZsgfSA6yNUISYj
	 DH9ghlUOTFkIyKPYRwVbgjgj7+B2GbtlD3IYh4dz4jOzBPjGxTVjpxn7Nh4rUeLHMzGGg
	 tQU6Y1db5V6xMFZuu0X/R0/8CuQ8CR2gCuv5Ep3INSjFqocbLnq2f/58SuNP8B6cMCcvO
	 w+NIkLzMAvPNvHxayPJovzBCcO1Vj6pnvsnxyAg2YYDOzzf9rDKNXuiV9f1aYYk80WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kZyYYHpGqq1G8pX8JZY1figUKThlyyxg3qJ6OuB35Lo=;
	b=ofFyJhXUniD9UzR+vLFnWjrsyCjVPuNSK7YSwVHDcHRRLGWBcAkyqWCOU7Wt4zEL3NHt
	 fEZdgu3ApGODAwnmkBfmy8o88lXdji4tvOsw0e1M1EeYRsmLAtpy6VHD6g+uowdsPHRDb
	 FVT0QOrjliQfnYuMxNnopmbX1LPZH8MRPXURlNCf4QqD2HhqS7hxxlkzreBj8IzX2S5eQ
	 tRGGkXRKixpn5YKHwnF7DitRPeFwO78xnVHnXKhcB7AOaGlTWcN0sXhWEGg+RZYykM47y
	 v2bkmB9zM+PkL4Fv0z1+kI+e7/tYpx0hV///m7no63rdBipQk8CercgXcCdcLdLtuww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QStxbGRn;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19492606A33D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19492606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QStxbGRn
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917c04630c2so18521716d6.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852133; x=1793456933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZyYYHpGqq1G8pX8JZY1figUKThlyyxg3qJ6OuB35Lo=;
        b=QStxbGRn1F21eax8GW4sa3RsUGY0MbFGOmXRL0gC4hTuM3DUeyUGYtdLQW1lKAl8D8
         5K+MsA1tF5QDxiSWz5eSM0zc5XeGKxxT1e4GHxv82CqWtvTa2nr7l0TbaxEbEWClvp/X
         H8+aU5+gnH6qeGkCdHe8qRWiH4uEnUlVe3/yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852133; x=1793456933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kZyYYHpGqq1G8pX8JZY1figUKThlyyxg3qJ6OuB35Lo=;
        b=LBcG1WNM02DUOfn1PGRNbfoiL80yp6aBS7h7GDkPAq0zGKlx/Q2kbTkZY6ELatLcaN
         X2D6A0nG2KdIDV7o4r2rb1uKwuaoXcOAgucyhdHQZxfGbr3kDaASv2NzY1Ff23pcXDZm
         bYIiY7tKqDqJwOaH/V5b2a8gwnzQ8ER3Q0ubEETbvCEGtn43biD6Bc1ETcjihCRQI0ua
         +h46uIEttEn5/jPUFGqKkQN5cvF3RZ861rVDTNmEEzWcMgqffL+XSnemHAfppWMoLZDY
         RPJhubTLJCG4vq/n51+Ua9tqPPue/Fo/XDg0NcCJRrP1uKVJ7ao78LZFYsDZk1O2ocgm
         Tyiw==
X-Forwarded-Encrypted: i=1; AKwUvBwHW5+eBk75W6qa8vh//JJvb4BAxz/ybltcwUE5F2w0mcZLXLTctOs9jn0D634DvSjrekYJCs0=@vger.kernel.org
X-Gm-Message-State: AFq9FYISII1Pe+7ySWT6evZIUBmcBMcdLWH2HNOBQYRxOAvM3GpTb59U
	/sYwL03gcCEm/YQV0wQyDUHniOY+WgkPEb4ztlNBBoEeT32Vw7j9uZKgVATj9CIr6g==
X-Gm-Gg: AYBFou3zjdOHIED9mnI4J6cPZ1jnb6/mdvy5PIBJQW8WWwkFfkRgoKyYg1WEKZP4FPT
	uFMMbm7omac3gGMDyeTpq76gYb8n5xpAKcWHRUTMDRuiATBw8OEt1yoPxKymfQFlynjcdtPwe59
	0y4jL9jpQDN7AUwSLSY7yD+qCdmQDR873uGMPWdlm68v2NqmjLAt9vwAi+mZ4NpOQdeVYZJQfJ2
	xS+0eZslXMaba4IiEUf4OoCemeYRRKuJ85d1R/Cy47Aq5fjTK+XrL32/vlRDvG8ksX59xQ2ZHmB
	1JTJKvdTHqLB+bibfCaRQ8qtE1j8+Kdzn8F2wYVdq+pH+bxck/fVFTC6BXSulP8+N+NOQT6m0+W
	cuRjn43isXAv4TGgygJWhItG3njxtgMIZWgzuAuEGa7SVHX4zhtdZkynBK5GhMurXUXiWpiBNjN
	Qao2hKvHLhv11CfNb47NmtTlQSUOyKwxKIZLdPIRQ054dP4x2DMgsR6Pl5ef070N01erMRHC+1s
	fplC3a0h10lL9Duda9TezhuiwZeioVDWvH/Nj/jvfuWlWed134m3kWMW+6fJjbQ6EVtKK1tAisS
	eORnnoL3pvjEX4JCEwToAjXejxb7X9C2gKUCfrIJ+A==
X-Received: by 2002:a05:6214:53c1:b0:91b:8296:3b88 with SMTP id 6a1803df08f44-91c48e36df9mr32053496d6.15.1792852133128;
        Sat, 24 Oct 2026 07:28:53 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:52 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/6] net/sched: act_mirred: ensure a pullable link-layer header before redirect
Date: Sat, 24 Oct 2026 10:28:38 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue:
tcf_mirred_to_dev() may redirect a packet that has no link-layer header to
a device that expects one.  TUN builds a valid L3 skb with mac_len == 0;
mirred then pushes zero bytes and the IP header is parsed as Ethernet by
eth_type_trans().  The same happens after a VLAN POP_ETH or MPLS POP chain
whose producer did not leave a full inner Ethernet header.

The Fix:
After the existing push/pull adjustment, when the target expects data at
the MAC header, pull dev->min_header_len bytes into the linear area and
drop the packet only when that pull fails.  This ensures that a consumer
such as eth_type_trans() can pull the target device's minimum link-layer
header from the linear area.  Do not gate the check on skb_network_offset():
tc_mpls_l2vpn.sh legitimately redirects a decapsulated packet whose MAC
header is not at the recorded network offset.

Conditions to recreate the bug:
- create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
- attach a filter to the TUN device's ingress hook, with a mirred egress
  redirect action targeting an Ethernet device such as lo;
- write a virtio_net_hdr with hdr_len=1 and an 8192-byte payload.
The unfixed kernel parses the IP header as Ethernet and can BUG in
eth_type_trans() via loopback_xmit.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Link: https://lore.kernel.org/netdev/CAL4Wiiq3h_OoVo9BpBy0pqFe=AeyN25QxsU86h63qEf05uCJRA@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - drop the skb_network_offset() condition; keep only
    pskb_may_pull(dev->min_header_len).  The offset check rejected valid
    MPLS L2VPN redirects (Eric Dumazet; tc_mpls_l2vpn.sh).
---
 net/sched/act_mirred.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 553342c55cf7..85163c46d652 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -316,6 +316,10 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 		}
 	}
 
+	if (!expects_nh &&
+	    !pskb_may_pull(skb_to_send, dev->min_header_len))
+		goto err_cant_do;
+
 	skb_to_send->skb_iif = skb->dev->ifindex;
 	skb_to_send->dev = dev;
 
@@ -335,6 +339,8 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 	return retval;
 
 err_cant_do:
+	if (skb_to_send != skb)
+		kfree_skb(skb_to_send);
 	if (is_redirect)
 		retval = TC_ACT_SHOT;
 	tcf_action_inc_overlimit_qstats(&m->common);
-- 
2.43.0

