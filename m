Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792835398;
	b=Wke6yg5s6LDA6M6/nSzxnPJsTUkYN2cbliP3+ebnl8tEFS9GZGAJGxC22RechewN3Wn+
	 f6/Fi1MeT3MxIz/o/GpXyP5BLEXKAO2BxmYaxJR1GuI8T9gC54YkaafK2ghYXFB9cur36
	 m220UgF3VRmghFRfXgV3g/4EjsWTENVT53m1VtxzmiU0JPnJ9tvWd538yXw2xRTZ276dp
	 6+SOm3VLRpRNYjF4J2TPy2cKczeiOTln5kGVO7O7kpIJPVNMdgCToxWG6mQfZmL8aBKBE
	 W6wk9gwaaalmEffYi4H+luouEm3bE6piFFGfxlyFoEdLZp+RrJSy4ovYWBstX3pwfvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792835398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lwTdMqGia9yq5liIBK1rZlrWrNJYW5LvcryWEtwkQtk=;
	b=IPzmMj0EWDR0isRG4fh9RQhI68+L4MzjjluzHZMTcV9kLrk0oIqW2SDKf9lZLqZPCM/8
	 h7b7z0jHsVL/Sf9Sdj11FBWcL1fFPSC1FJosn4YnSaPyhxgIfKodqNrUVEQfPdssy9Nls
	 j7ISgMd9DBCIH8Oxya20TsH89kNDDgzQLLD4zdx2HM6K/IEOFnAKNKQZ85k3RZ4DXWneo
	 YnN5anjWI0LI6P34DrTjhxLl7hMrF/9fJr7pR2scEBwZeY/27OxdIUpGdXQy4g7ZnX50o
	 SZ8y30uSyWG+Q4f0JsHqUWQJzVaE2ozXvPUM5qfzkVR7WzMt3kc7qJk44Xv2b7RLVNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NrnPw9R5;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B2606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 09:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D45B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NrnPw9R5
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3549077eec.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792835397; x=1793440197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwTdMqGia9yq5liIBK1rZlrWrNJYW5LvcryWEtwkQtk=;
        b=NrnPw9R55yeg8Jd0Iww0nTeSzJ8kHn9uCgfLJfsazObHw4puq4xhR2lo+jZPDDrqEB
         gPXsljPb63ehYiAc6zcmMPGWcOzfO2gqRo0dR0ndvYlWMDv3aNtMS/O2K9EHNyC2J95r
         3Yne5rxTEaGM2fM2T31C1/E9fJn+U9+i2tEEUc9sE7HC+WMtGbmFy0ubYMtw8uh18+6f
         UdeSHtwXndrZf4JDKMA8Wiq3Mmc3ogNBGxAOJ8vLndm79efT/YxobKpz7rRtQ8Wmw/1z
         nevdx9BrxXPLbFI1a5xCSb/uaXAgtHkAeloVCpCC++IFpoKJSXyf1bT0xuXwtkolWei9
         dD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792835397; x=1793440197;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lwTdMqGia9yq5liIBK1rZlrWrNJYW5LvcryWEtwkQtk=;
        b=vYLScCqII/VW4ccSWX/ec86cxe86+3td1ByjKhEtZeOpDDdSz77wDdvbp1EuRdv9xi
         YA8DaA/LPsoWelp4RZc88sJnc5hNSUuKSoSTEKe3IIbwysKwhrLW6UduIwBZomnchyA7
         UBJeMHpJXFKoP3c/Dsgg+QZZdftWC/3H1pSRw6NV6AY8tSsdtnH7wxc5bSSMIIrqEm0V
         ZnqnXdcNNN3oTUY/EQxtdS2fvqax/S5ePX6FT/5whv7+O9mW2MD2W5qezDen/WVjoaXJ
         jWJwTrWh3HCDHkHfUEWZHEpND/17XnVfNvM55lnZlvXwFJZtDcXyq1/G2yehc0R6qDH1
         1rJw==
X-Gm-Message-State: AFq9FYI+W7nzpVVmuNgSww0v8fdZQKGSfK4lunswBvLcnO87VXkzBQht
	jKVbDmyGta18YM+2Q7PPqZgeRUCYG8XqilVeXecSpwz6fLNIwe/t1s0Kea+tmY9J9Oo=
X-Gm-Gg: AYBFou0x5VBlJ4p+MSnhP4s5p4NDPHU3PLQVNChaIuFZJNNKmwYWDzkRHThKUO9P7zA
	rw47584sr2/Pz1e9r2j7sI/2+HnPHyfGx3kCQY1Eju/ceAdgxoXBU5hY84RmWy+iRVLKhB2jDGf
	rieBTX3SDC5Mqr7qyq//atck2RcM4RsN2k6vxjtOeLDaWJQe7eSADyoJaD5U5wJeshaT9LbgydA
	f2/93MnwpPe7S+7ng6+Wgs8hTi7BjEnQmF3+9kwStyr+WTBj62vqjhxAwzS8JcoyHSnRkfIXYwa
	Y4ENEm1qUDDQjLs5f8OqdILThywwDgXzfki+b5grrXk1rhuIHDmrB8YaD5DyXFawDxA51B1/E6Q
	5GlyI0rYUMYCt4AC51kCWuOEilcRLPfDeVb4wgpFyO91K0wK+xLFhGJ4HjQpir7etQPctSXump4
	nc2eUkIzmRkS00Sa3lOa7cHRWa1x/Lv1AlypgnBkz9/jOfZPIKMSeVj3yAixe8YHQhR3OCrfh2m
	9POac19r7Usw8irR/x3vCm1mKyhwFa7Rm4hSXVZYnj/2CIz2AZjVcJ5/UAKtnDU2IR2adMCz9B1
	IvnmTPDXu10XvzLz3TssK/5WoD5nGgvfkQOjQqhk9lfVz+VVfT2ovLlITZ/4YdFWkSeZhnu9LzW
	s3tInLgJqGOCfIo59juIOEsymgvPpQyknlvjyAQhyFbjJOScFsKKNmIX5J+8g0XPqn16aygoJHe
	xv5GLuyJAI/o0I0PKs0fIGl03lJPnO8Dk8AYDI/G2DrTH04XsQzgQhvqgjOci0wZFE20xxkLOEr
	QCi5A==
X-Received: by 2002:a05:7022:2229:b0:185:5a96:ef59 with SMTP id a92af1059eb24-1993f8c2973mr3355990c88.34.1792835396786;
        Sat, 24 Oct 2026 02:49:56 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a37c88aasm4985963c88.23.2026.10.24.02.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:49:56 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] gtp: disable BH before calling udp_tunnel_xmit_skb()
Date: Sat, 24 Oct 2026 17:49:49 +0800
Message-ID: <20261024094949.793-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 5638504a2aa9e1b9d72af9060df1a160cce2d379 ]

gtp_genl_send_echo_req() runs as a generic netlink doit handler in
process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
on softnet_data.xmit.recursion to track the tunnel xmit recursion level.

Without local_bh_disable(), the task may migrate between
dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
per-CPU counter pairing. The result is stale or negative recursion
levels that can later produce false-positive
SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.

The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
the data path runs under ndo_start_xmit and the echo response handlers
run from the UDP encap rx softirq, both with BH already disabled.

Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
commit 2cd7e6971fc2 ("sctp: disable BH before calling
udp_tunnel_xmit_skb()").

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260417055408.4667-1-devnexen@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Ting-Han: this tree does not have commit e3411e326fa4 ("net: ipv4: Add a
  flags argument to iptunnel_xmit(), udp_tunnel_xmit_skb()") or commit
  1bec9d0c0046 ("ipv4: Convert ->flowi4_tos to dscp_t."), so the
  udp_tunnel_xmit_skb() call differs in context; the change is the same ]
Assisted-by: LLM
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
is in 6.6.160, so the per-CPU recursion counter it added is used from
this process-context path there too.

Build-tested on v6.6.160 (x86_64, gcc 15.2, CONFIG_GTP=m): no new W=1
or sparse warnings in drivers/net/gtp.c. Not runtime-tested: I could
not find an existing tool that sends GTP_CMD_ECHOREQ (libgtpnl does not
use it), so the echo request path itself was not exercised.

 drivers/net/gtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index f0ee46d3c873e..39515aba86e68 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1827,6 +1827,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		return -ENODEV;
 	}
 
+	local_bh_disable();
 	udp_tunnel_xmit_skb(rt, sk, skb_to_send,
 			    fl4.saddr, fl4.daddr,
 			    fl4.flowi4_tos,
@@ -1836,6 +1837,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
 			    false);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.53.0

