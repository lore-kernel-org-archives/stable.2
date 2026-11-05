Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.218.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894839;
	b=xySCQWKgO0/apx5m/o0E63/t3fnQaWMrihS9af1F2UeoNSPHzZpnOVhmcqPBFKRNDIJ/
	 RESokvd4AWxiVwcIdl0UIZiJr1VF5T4gS0T4cPpBnuCAA6Zc7XiEafZXk9zp6C8rWRc8/
	 Pwz5akr9fuhTb3hAzJzpStr1OH2XoXB/3H8tvZhqqdlmqvS6C2V+zplSbtcJ0+Ch7Snv4
	 P4ps8nNPhDtRSOO04VBkdWPANZl7oCnZRS6uECRTpPxeP5+22sCl0/oJX0evJyI6gGRrz
	 /BdHUfNzLxEygJ1tmQNv2E1bM0CpajwQKlji+tPPckOvuGQAKfplGTmnCBH3fxeUsCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894839;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Chemical-Shrill:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RR6cUu30dRjzG7THObAfGO+BE1opRHighwmsm3cn3Fo=;
	b=AxgGqugaBPMZLrlNpOuwIQSaUyyxbRmyD5stZTWlR0rbz8eAk7D3Ct2aVW8RCl3bso92
	 nKLA7pSkjIwmGbAJ+VyKjc8sjqbYO9SZ5/sc2wMCUEYxLG4/ardWR6Vy/3NIZuBC+D8RT
	 FfGFU59j9ECZcZLN7zq6yfDBZU5YnqwYrPdxr+h3dKTvSIrSxXb+lx7BlIah4AbiMM7mH
	 tixjPzG1P3hnkawiw6lBx453bId8UcYMgB9eJV5zse6RnCqVDOeeWaAmv85VPTt15JqqP
	 3hwpi16Pm3xfB8AAKO2v+lfkrzqD2ULUrs2Q7861Pmr/NxtzHt5eEuhFQIM/2lrGTfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=lsgzyWpu;
	arc=none smtp.remote-ip=23.83.218.24
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14D606CF99;
	Thu,  5 Nov 2026 16:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A14D606CF99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=lsgzyWpu
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D28A3642EF0;
	Thu, 05 Nov 2026 16:07:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (100-99-182-219.trex-nlb.outbound.svc.cluster.local [100.99.182.219])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 92B18642F93;
	Thu, 05 Nov 2026 16:07:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Shrill: 2f5010a12af5da1c_1793894832686_2933704575
X-MC-Loop-Signature: 1793894832686:266429153
X-MC-Ingress-Time: 1793894832685
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.182.219 (trex/8.0.2);
	Thu, 05 Nov 2026 16:07:12 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [190.113.127.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4jL6dV5wvmzHb;
	Thu,  5 Nov 2026 08:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793894832;
	bh=RR6cUu30dRjzG7THObAfGO+BE1opRHighwmsm3cn3Fo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=lsgzyWpush7UxXE0zRdEkj3HwwWj9sm0hQCgqsUWQ1Vg4TbMpqOhM9IOvDu9RGxLG
	 fbElcoQY4CdHYwAizOtsz52kSU6jEOEUDH9h7ULuQ+pp/vSph6WXooAU7jt5MHI3Vf
	 KdroKHjNmMH20/auA35l233a0G35Zzw6QuPQM/mrWiqieHH0L3fvRnkd/AfJuvqlJO
	 RR1sSgdSUp1Bly53S3RR6kUdgkKgEk6gksuGLJaNx1SFx53SxqDBrx7t46cbvpHaW7
	 JJegeT9Ec0FauLUSgPd8I1Qu4keuqM3uwVURjSEcOjnGIp0lsZ3bEk5mX1FMwc2766
	 DZGuM7I7rFVhA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: anisa.su@samsung.com,
	dave@stgolabs.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] mctp: accept MSG_CMSG_COMPAT in recvmsg
Date: Thu,  5 Nov 2026 08:07:04 -0800
Message-Id: <20261105160704.2546031-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
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

32-bit userspace running on a 64-bit kernel is unable to receive MCTP
messages on an AF_MCTP socket, even though sending succeeds. There is
nothing for MCTP to do with it beyond not rejecting it, as af_packet,
af_key and can/isotp already do, for example.

Fixes: 833ef3b91de6 ("mctp: Populate socket implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Found while testing 32bit support for libcxlmi
Changes since v1:
  - target net and Cc stable
  - fix the corrupted hunk header

 net/mctp/af_mctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 8af5e2b3c8d1..aa22c0860712 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -292,7 +292,7 @@ static int mctp_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	u8 type;
 	int rc;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
+	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
 		return -EOPNOTSUPP;
 
 	skb = skb_recv_datagram(sk, flags, &rc);
-- 
2.39.5

