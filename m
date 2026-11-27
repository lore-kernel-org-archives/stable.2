Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762519;
	b=j8D+95Id/e5SbJIdWBoYHeyhI6tMtnEppD/vc7MiuoGyVK8HaCMUIKBUWOZPOSXv3ZHy
	 4kIcHZ5tUQqvRP+grg02vxrroPptn/LHsB00GAO2/kKaEDC+Z0KlwXEShQ7Zs0wFx70oT
	 tSNkng1G2HKYcWqAAas3mD8myM0C9MjUWhSE2QqgMWy+GkWji9n6CabNLvTLO3hrCNmby
	 lniglzHcgEJ6BWp6+91YmG3P94F8LBOAZmnBZJj7II+WEPOB9rR45v18CCNJSZP0a8uZn
	 9T5b0+sPJD8MoIJOof73HumMs+tEq1F+VFCQXXnk3/KCrMZLnuJ2AG9ayfBGaA59/MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=erNRx/pa4ybfvht61Cy5QMsfcLY/xQhwXhQlf25RgsI=;
	b=sJtOYF4oRN78t/lh13mdNLE3PYgQUkJOLxDe9CQxi4/7zXlebE68xVCBbMsKIwrwGQnl
	 dUP5wQU7n+icgMYV5/zx2nvou4KmbsKjzsoj0P9xBRURqE0yiLmWGbqOfTGd8BHEtZrZ9
	 SXRMqRbBUd4+maTS6XH29gIo01hh9TZLNCKiHF8sYyOZJxWzWDZ1fX10DeNKmb8eSi/xv
	 HmY6B5bmdOaY1qeETAsPbIP4mfDAq9tzzgT7sPB6XmnK78Rid3bi6RGKpaH7mP+1nwTRS
	 hiR7wF/uBzB/nGYElcaQiLLSSbYoB/M+cSBN65dnXLFnynxNsjE+rT4vt+3Yi9mq/8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xw6a4Wdb;
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F8606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B5F8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xw6a4Wdb
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2f0440f49f4so52811955ad.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 22:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795762519; x=1796367319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=erNRx/pa4ybfvht61Cy5QMsfcLY/xQhwXhQlf25RgsI=;
        b=Xw6a4WdbBuEohq4yjyZKoO3Y1qKNC6rBR2ZO+XR5X6FRoZhnMgDRDKVx1a+BQp4RHj
         Yy9SJixfy91qcMTmAQVIZTKHvG5A72rknRFllvO5+Zdi3rHQmLcbQciJE9CzpU1AJ0hO
         dyun41/ut8Njp4vByLSGE6fE+8sNxKbOnJgwcffLCkUqIdbc5ENGp2sFWI0L1KUjO+w3
         QBbNqQuHP1GTIL90KSnMaJ4PEkWcbWusKPqxvuCxI0taO/uWECcDfIq20lJ5guSi/muP
         iwwaJiQDPH5AolyhtfATtNPfkFASCQ2ROi9XRq1vgAlKkJLL8tkCMmAIM7JG2nFuvVUT
         fjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795762519; x=1796367319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=erNRx/pa4ybfvht61Cy5QMsfcLY/xQhwXhQlf25RgsI=;
        b=Xu8DuDIvzEJ/5geN1CRkdha6QohvlC/zUM6tfRVJBLx3ZSz3t/BWdPh8HxeFV3MdcB
         okXXZ7Nix/PLWTWrGl9VCQzngheajU8ne7eEJQdXI1o0Qz2GJQ0tem4ZUSJ+DozRI8LT
         HV+U9afEpVaJWg4NMZTUR/Hot00w0FEHkl9QSHSmxUm34z4xfpWQFfAUr0aVuptMe+U3
         W1a0Wz0noIOw4SJ0kNatDnJxe/+95YJps4p4/QUvuwHdi0SKNc07RE7SvHW5+zOoWGfe
         F9wVfQD/u0U4ic/HqGtn901fulo5K09gR3ct2rqJe3pXg5cBrvulIbNn7Vn5VZm9hGpQ
         Qv+A==
X-Forwarded-Encrypted: i=1; AL+hErFaUdsw5ItmAcbsNp1rKIYaQT7eWIeHd4Guu4ezvIYuH7xm5bqpP19dG0gSsOwE1xNLCHqYdP0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NeRF2sV+hsddg29cLkb6eRfoftm2XmLJ1qW7QnNW8eEwE1F2M
	A5JOan9hXgRfWAVlLgFD0ljj9wQwABIbJ4uZWWGXRibQ7RaWfK/wWQmh
X-Gm-Gg: AZFdTZdNaCkrMFTlxwKoiznUiY7So4BetM35Y558tWm4RxSAHj4p9kXUIPOqMShVucX
	lTSVGINicR8rYMMSVNOUTbshHfIeo31I6Lj4y7eIo4hBCCa/YbX2CZuZX+pfMn7x4NjO/NiCIJv
	ElmqiLZZEmB+ieS4YJw4JrgzSjzRPRAqr+2d8M+8ySeX/oVJVj3FNDkaMaNxZ2VTeQyIRBH+NsB
	iLk3AKSxtZeVqtF8QzuGZvbyYL0tRxn+vCks4WTopKgJzEUHAnVWLSmCEDuig0fte+I6KHi0LVF
	un52t1oGiGTKJ6eYfSNdzNR6uxEK/qo6YfZv0wPJKu24XUNp9l6nhuX7HTnMekn1Xe9Sifc4pEo
	mWI3+L2TJbEJI6fv2I3L3xEl7edh5B5ucqaWMpbofAZkSwQ+fGp95Vri5zmlKaotCf8z/sJjvEJ
	92xuGxkxSih26r/GckvdTEvbPc4tn4A0vlSPP0Ep14SDjpJZgv7kmKPhsePIJRfxGls0S/7txPe
	PNa+8YreDNx0Dse3lY7Ififzo0NVWIqBUZu7BtK3vXu06k73adMSNahYQgqQ1EJRt3a1KykSJQO
	tD1x5GIY8DeTEurKJ0gcivVNatHGMSxopU+KoGP1+ndLydqnZg6j0MQnarfGYElJUpfzGo6JcvB
	G
X-Received: by 2002:a05:6a21:32a6:b0:3fb:3a56:e41b with SMTP id adf61e73a8af0-4014db62821mr29894274637.48.1795762518648;
        Thu, 26 Nov 2026 22:55:18 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87353b333sm11793302b3a.40.2026.11.26.22.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 22:55:18 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_nat_h323: fix UDP mangle offset in set_addr()
Date: Fri, 27 Nov 2026 14:55:09 +0800
Message-ID: <20261127065509.2925843-1-bsdhenrymartin@gmail.com>
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
Content-Transfer-Encoding: 8bit

set_addr() unconditionally adds dataoff to the embedded-address offset
before mangling the packet.  That is correct for TCP, where
nf_nat_mangle_tcp_packet() counts match_offset from the TCP header and
dataoff carries the TPKT header length.  For UDP,
nf_nat_mangle_udp_packet() already counts from the UDP payload, which
is where the decoded H.245 data starts, so the extra dataoff shifts the
write past the address.  When the decoded address sits at the end of
the payload, the shifted match_end runs past the skb tail and the
memmove() length in mangle_contents() underflows, turning into a huge
copy that runs off the mapped pages:

e.g. on mainline v7.4-rc4 (KASAN build):

 BUG: unable to handle page fault for address: ffff888140000000
 CPU: 1 UID: 1000 PID: 82 Comm: poc Tainted: G O 7.4.0-rc4 #2
 RIP: 0010:memmove+0x91/0x1c0
 RDX: fffffffffffffffe RSI: ffff88813ffffffe RDI: ffff88813ffffffe
 Call Trace:
  nf_nat_mangle_udp_packet+0x13f/0x420
  set_addr+0x18a/0x830
  nat_rtp_rtcp+0x50e/0x910
  h245_help+0x1eb/0x240
  nf_confirm+0x481/0x8c0
  raw_sendmsg+0x203d/0x2630

Only add dataoff on the TCP path.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: f587de0e2feb ("[NETFILTER]: nf_conntrack/nf_nat: add H.323 helper port")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/ipv4/netfilter/nf_nat_h323.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/nf_nat_h323.c b/net/ipv4/netfilter/nf_nat_h323.c
index 6bcd6734769b5..764bfc89027f6 100644
--- a/net/ipv4/netfilter/nf_nat_h323.c
+++ b/net/ipv4/netfilter/nf_nat_h323.c
@@ -35,9 +35,16 @@ static int set_addr(struct sk_buff *skb, unsigned int protoff,
 
 	buf.ip = ip;
 	buf.port = port;
-	addroff += dataoff;
 
 	if (ip_hdr(skb)->protocol == IPPROTO_TCP) {
+		/* nf_nat_mangle_tcp_packet() counts match_offset from the
+		 * TCP header, so move the offset past the TPKT header.
+		 * nf_nat_mangle_udp_packet() already counts from the UDP
+		 * payload, where the decoded data starts; adding dataoff
+		 * there writes past the address and can underflow the
+		 * memmove() length in mangle_contents().
+		 */
+		addroff += dataoff;
 		if (!nf_nat_mangle_tcp_packet(skb, ct, ctinfo,
 					      protoff, addroff, sizeof(buf),
 					      (char *) &buf, sizeof(buf))) {
-- 
2.39.5

