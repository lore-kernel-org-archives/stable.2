Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611134;
	b=f+3HMC3CTP8MdFlOiWHEQePOs7HwnvzKD2Fj0ZTUg3WKq3eI/abkuCC4l/yFDlQmHE1f
	 c8vy+B5XwB1A9O5ojiHPvAa+Gkewq4HG2vRC8jMQ4e7qwPrKMN/DNIYgmqf4OzyEXAuRD
	 /RxckBT1gkoOW7p8dKiVJPiGuRWIxB6g4jA1JolQaAx7nThm9nGTqN4sUoY9etDTCQ/jz
	 dz6BeKJs771ei+6HHNmpxxnt/Kn6vjwRm9ZnSVSu/LUX25W+Oi+L8TQlq2GjyECQQZb76
	 QGyO9cySWNkglz1fieLLb3lxhW0e81G7fEXDErDXf6CQ53xHff014TN5RY/mKCZfQNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611134;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=glPt0q0sEevcWyTh7Wmw1AfhAylbAzS5O8HfQusylb4=;
	b=LOWoedLXhkCNqHOgr6GztkzS6YMmpc1Sl/heEl01SWgQt2qhHdOUk1heSabDTe0a9eb+
	 JBjvHbqdTMiQF1XoFBXJyJWOckCqQhi/cQewHdEgPtJgvq+IP2MKmw4x+6hp/IQ8AcypV
	 EiT/rcph06hTa1qNkJOY+/+VAC/h0aw7fuP0M15mNBMed782f1L/qlo1xVZvu83b8qQWj
	 qxZw9YofOqnESozwINaCR/LYjm6a4nhRExqS8o2Pmot4rcggwrq/YPfWMDBaMvfQciKwo
	 JSP5gntRsy732oJOEw5ioWycllclLJrBkT9RSNsUcFVopOfnKUTaatC1jRfJItylUsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Jgok1qRk;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F991606A31A;
	Wed, 21 Oct 2026 19:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F991606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Jgok1qRk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=glPt0q0sEevcWyTh7Wmw1AfhAylbAzS5O8HfQusylb4=; b=Jgok1qRka7m3Ny+nJm0meHOnkc
	Nf0BBPjUNwHjm6T+aAYuIYZIpPyTM8FunG1zC+1wyvbB4ag7JeoDrIVhg52NxobRrt+Vn3hybOSVY
	u15HIBQo22DpgilnRtzoTRoMG2/yQE5DTHaf2zi6U7FOyT6MgcBHN4pNanvpVewkgZg+pwsjFz6Av
	L+QBUxDTh5CBQgPzbyF59Lbj2kAtON7vg3LJK9L0PvM9+oNS5Ups5qZietl6VvBS1K/KFv44iYPdD
	IdMyOo1XrfmHoYyOKu+hTjKJ+sXLM2fu19cT9eA06IEtylNYQVrdco9rCnFBhn/3whjeKbGKEXMe5
	phYK9zbg==;
Received: from [151.115.150.205] (port=32912 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xJc2i-0000000DCTL-2bbn;
	Wed, 21 Oct 2026 21:32:06 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] tcp: fix authentication bypass via unsupported TCP auth options
Date: Wed, 21 Oct 2026 19:31:51 +0000
Message-ID: <20261021193151.1819085-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
TCP_AO=n, a packet with an AO option reaches the disabled
tcp_inbound_ao_hash() stub. That stub returns success, so sockets
configured to require MD5 authentication end up accepting
unauthenticated data.

The inverse configuration with TCP_MD5SIG=n and TCP_AO=y has the same
problem for an MD5 option on AO sockets.

Make the disabled stubs reject options for the unsupported
authentication scheme.

Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 include/net/tcp_ao.h | 2 +-
 net/ipv4/tcp.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 9a2333e62e994..bb249d6df8723 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -303,7 +303,7 @@ static inline enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 		const struct request_sock *req, int l3index,
 		const struct tcp_ao_hdr *aoh)
 {
-	return SKB_NOT_DROPPED_YET;
+	return SKB_DROP_REASON_TCP_AOUNEXPECTED;
 }
 
 static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 87ef6d5cbfeba..7d800b6283bd2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4962,7 +4962,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 		     const void *saddr, const void *daddr,
 		     int family, int l3index, const __u8 *hash_location)
 {
-	return SKB_NOT_DROPPED_YET;
+	return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 }
 
 #endif
-- 
2.47.3

