Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091749;
	b=lAWLjfvtCCAuoUCHuGuNnYhigy9NwLIuywnCcPcOOawMXn3ovpHSVn+DCQohtNT28lNd
	 iZLUd3SXBg55ggnp/n/E7TeCauVwvowUhmsOC7mByrIHPLLQuBeKCnyxIrqRn+i+2n8Xs
	 LCQQRubzb8RK+6bzDtP7AG19Ry9UF0MOIrRjEC3yP5yN0uIiLUAaAFJ0UVvB+ZQ2HJcPS
	 hD942PjZGjWKo+2YYpBkr/USxY8Y932BoGnpB8F8szqdik7almAMq5Ft2NBJ5FGHv6CqN
	 ctMvfTGaq8iWtTGogA8YXnM7CrHpL4eURKA2j6wj30VPNNN7otJp06SiFFc5QZu/Adw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091749;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=4tZTBy6OmlPvtKLekBi9nEwraJ1g8Ks+STE2unutmxU=;
	b=Zhb8CuDkfzGOZoqn/gq+A+/J+BwloW1XSFWoF6UEBSvhH4CgR6ZN7bAFPiiM9ldrhD4o
	 OOtIXMjKAkivmRrw42i0xbWDwSBlebFKK6clraWVsZuywPXNU2R8sV7MTLkd99in58EBo
	 C0toMCR2WxBKk+0h9bIY/lLVFdzJloNrw96yJ11hlv9FCmiqstxFi+t/uSQnQ53d8tTyl
	 9gVayjfhIdXOkXPxAG5xvCkueljxo36p+K6tuSrvbeXXkITfWw+/kbhIMVPO17HHhr9o4
	 yd41hNO/Bc0gjcxfIh91Syv/axse68abd39YgGS2nKrp67OJAGSF32O6O8a9+cjVdKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=ltcgWRQk;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B9606A326;
	Sat,  7 Nov 2026 22:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB1B9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=ltcgWRQk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=4tZTBy6OmlPvtKLekBi9nEwraJ1g8Ks+STE2unutmxU=; b=ltcgWRQkEdl2f+QlmNtUxGxiiI
	4r93pUQrlgujgHA5Ka4YLDvlg6pHCM+7d19U38fqDJMJzup3HXi1riJ9tx47nt0scbW55Fl48vWZb
	edXK0h6w9LraJy7vnJe56rS/S9RUVdG2b9iBWKnjIp2RhrjxE5U9QCTFitLT7h3ohUvrVuPmSbuTe
	YEE635Wu2Iggw+TN6v1q2HDbBZIF8/rM/PBhE7RjOOwN4IB4BCVKVCJzUyBnc124SIkRfVijEal1Z
	vjQnuyvRhc9gL2a90zTytSq9YRZw7cWcsSAFcq7cqoKsGBeXYbYk+tvQQbfHR8hH4D+QbDuHSCH2q
	sjlmc23g==;
Received: from [151.115.150.205] (port=33134 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xPpDc-0000000E17c-1dMi;
	Sat, 07 Nov 2026 23:49:00 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v2] tcp: fix authentication bypass via unsupported TCP auth options
Date: Sat,  7 Nov 2026 22:47:33 +0000
Message-ID: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

tcp_inbound_hash() parses both TCP-MD5 and TCP-AO options when at
least one of the two features is enabled. With TCP_MD5SIG=y and
TCP_AO=n, a packet carrying an AO option reaches the disabled
tcp_inbound_ao_hash() stub. That stub returns success, so sockets
configured to require MD5 authentication end up accepting
unauthenticated data. A forged AO option skips the unsigned fast
path, which is the only place where tcp_inbound_hash() can return
SKB_DROP_REASON_TCP_MD5NOTFOUND.

The inverse configuration with TCP_MD5SIG=n and TCP_AO=y has the same
problem for an MD5 option on AO sockets.

Note that TCP-AO depends on 64BIT: therefore, every 32-bit kernel with
TCP_MD5SIG=y is in the vulnerable configuration.

Make the disabled stubs reject options for the unsupported
authentication scheme. This matches the real helpers' behavior for
sockets without keys. It also means that kernels with TCP_MD5SIG=n and
TCP_AO=y now drop segments carrying an MD5 option on unkeyed sockets,
as kernels configured with TCP_MD5SIG=y already do.

Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
Changes in v2, upon review by Eric Dumazet:
- Explain how an AO option skips the unsigned MD5 check.
- Mention that TCP_AO depends on 64BIT.
- Count rejected unsupported auth options.

v1: https://lore.kernel.org/all/20261021193151.1819085-2-Jeremy.Jean@oss.cyber.gouv.fr/

 include/net/tcp_ao.h | 3 ++-
 net/ipv4/tcp.c       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 9a2333e62e994..edf4c9bc5ef5d 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -303,7 +303,8 @@ static inline enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 		const struct request_sock *req, int l3index,
 		const struct tcp_ao_hdr *aoh)
 {
-	return SKB_NOT_DROPPED_YET;
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
+	return SKB_DROP_REASON_TCP_AOUNEXPECTED;
 }
 
 static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 87ef6d5cbfeba..bf8aef32846b3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4962,7 +4962,8 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 		     const void *saddr, const void *daddr,
 		     int family, int l3index, const __u8 *hash_location)
 {
-	return SKB_NOT_DROPPED_YET;
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
+	return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 }
 
 #endif
-- 
2.47.3

