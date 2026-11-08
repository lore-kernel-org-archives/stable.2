Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154331;
	b=uFrN5lZUc2Q+SibhGmTwny7l6XoP5SFnB4ehx8ThoqAQ9IRIi/SQ9nwqvZ4hsUFhxlcX
	 g/viDGh+dpDmOChPOG18I1xXxXflCeUsEFlT+e2QnNZ1IsJpjBi/QqeiLO0Un9UxJNrN0
	 M013IQWzrztYg+HZByWYiaYIQXWtYAzNsMi6/c+fey2U4/2DnuuSFfz4AhEl8/GcRAKHt
	 Z3IbK9DLPUww9AFmWgNkOKwDfWozMOd0NbOF7bH8pTjsVTuOQNiYNsq/CkYf4Pmmpnlpo
	 shWO8eoZcFF+MkeB5N3AXTuv+jhtcGJDKnKjk8cGdANpXv71+pi5TPa+X+AkkBalM5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=89T9eyf/7pt2w5bHMloyOSyIASgmUej+LCY3qWFQwTs=;
	b=ZwXoPFXLO5foCmU32eL27CaJqqcOZKgv9c68OHT/JcYuRT9FlUI9vjUZT5Z1zw7hMu8w
	 7N86xwQNm2uHFXvLO7MlDHofJGn6PYEcwpZn/H9yc24iULE9bLYefhSJZv0pg8mbP8dTJ
	 J4qlGaxKYT0pcqEcAfuWpolM078v/ALVM/oWZR4IozlRlFva38GXZO+3PRw49RufHFTho
	 olnSZwn44zaHo9EdB1rPrzc/sBSlSb9SGAInzTI5photZVVtdJVb7GyPH5qg7Bu3OfbHD
	 7HR3/XUc1SOYy7tFHZ43FsHl9g3df6l8xIsb+frHt8CskAtn+48EkOsEOJQR8BcZpug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JZ4Gby2F;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE38606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 16:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE38606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JZ4Gby2F
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1931ff67a29so447760c88.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794154330; x=1794759130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=89T9eyf/7pt2w5bHMloyOSyIASgmUej+LCY3qWFQwTs=;
        b=JZ4Gby2FvC2DBELHKFx4SybDLlGtuB7SQ5XgQ5eR59R2j4Wg931xxWyqTJsGcWV8FI
         leBHwUTE0i6796d8QedyDtdwFxpDyWOw+9Y4q7WcrU7TRHMlMTw3w76jZSSajMGMDJ4v
         4XdIGavyeSMSmY6yumPOTrqDSGHXfU6Z85RMvzjKYX87Gd4vmexl0CSQ6jbxpB2/YLRC
         NstZsnB6mkmNZ1PoEAGSqdyn6ZZ9Ohhg4+7TwwfTeOLfE+ggP9wOjYQkp8+DdpD+bxW/
         vQi5cFukX7xg1v0XtHq39C7mVEfVv0amHiDB67Ntg0Zh87z0aGO6trfKrcugE6gm+8Qa
         BxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154330; x=1794759130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=89T9eyf/7pt2w5bHMloyOSyIASgmUej+LCY3qWFQwTs=;
        b=uavjqgt1ewbYmJSuNqPhQqAteRAaG7YMtMIV3St+wNjcESJ7YxOftxxhwtx3QC9MRH
         O+uYWM3Mb6pXUbucIEoiJFxFf7PkV+e046Knqr+5GLoXSI9lELUxLm0Uten5PthRClm/
         IbAAehFHa29lPMDHnLQgZpqoEdNxc+33MrRQCWkq2bq2jd8o1Bs7Ibc2brJJaPLdq1FT
         VUf6qmkTsUfOdsSSta3pDcpzq45YUCwoN5y4QmlcXRk9N429f4qp4sKDowuvIFdg0qLB
         +GbR8rF+RGTYoofbNR1ObicZdr0lfBlWqdW9ynu5dF6npadtcd2njfCVs1KROkRCaPBo
         4KOw==
X-Forwarded-Encrypted: i=1; AL+hErF6No2sPCKVxg4BoKlgafIUllvYtuAZqMESgowRRZYfWB7J6/VW/fNuorcv/LfO6UmvKAfexGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FRe9CLdYOQQkvVCGjGTyzATKph4np9ET+l+nn2pdubCeFbySY
	Y/su5fXqZvvF+MTlROY34UoilLvGkotFndcZYDFRZw7ZiL4hsfUzJTPW
X-Gm-Gg: AYBFou2h2gUHF+54sgvTOMkKq69lA6r7An7V2eoDYQ8swkoMK0ekq3JbhSThC7sJPa6
	YY/RIM3eFDdtKMvYwCU8KsCcqTWaa6YZrvSOi5L3wk+iB83lLk9NGGSklPeoRNf3hJ4hatELJ5J
	s1pQtPO7ju/M2qsWf1+ev2fFAfXFxgt6FqA9GINXWrh+0juMpGwwkbPHepb5RNN4Q4eW8EnXSke
	EYRDILum/Y2pOIpxG1iIbh25/kOwRPF4gU6ASqIYFFvXenpCIqSW4uibcz/VCBSb8+aRHArQFSc
	KZej7K/+hdvgBdV7oNARmXCPzDA6IOcgQJ8/rt/f1eOtXUtoc7ZHbqdGtwu5YuYbDOMK5oJ/Eie
	vQnZ24MACB3vJQx3aEu3LXJtTluygOEhhO8hj2Y1ZyLbJWuUsdXN1NTArIHTfIFeVFo/onIqf1X
	6N5oRtleinT74R+eTBa52vY0BZPIL74xBzVefHzIGVlXUUhqEzD3UAZhEfkrWrAUQnc9N778ELz
	eiJgplbTrLEowi6tolvFxyFVeHdt7Vbe70YcYAzGZJSB98hS2cmYmwqBZAODvZfDgiQ0y/iu/UX
	WSD9PltQ5b4RsCwm61dlNwjTG71ELKd2KaJQskfcVCQ4uB/ZJFAU2RYI3fsYMUkM+HadtEV95cD
	oxn8=
X-Received: by 2002:a05:701a:ca05:b0:18d:ac5a:89ef with SMTP id a92af1059eb24-1b39fef0c5cmr3037830c88.31.1794154329553;
        Sun, 08 Nov 2026 08:12:09 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3731487edsm7103369c88.2.2026.11.08.08.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:12:08 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yongjun <yjwei@cn.fujitsu.com>,
	Michio Honda <micchie@sfc.wide.ad.jp>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: reset stored flag for each association
Date: Sun,  8 Nov 2026 08:11:49 -0800
Message-ID: <20261108161149.2774119-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

sctp_send_asconf_del_ip() walks every association on an endpoint. The
stored flag records that the current association took the single-homed
deferral path and therefore did not allocate an ASCONF chunk. It is
currently scoped to the whole function. Once one association sets it,
later eligible multihomed associations allocate chunks but skip
sctp_send_asconf(), leaking each chunk and its skb.

Reset stored for every association so only an association taking the
deferral path skips transmission. In an A/B kmemleak test, the
vulnerable kernel reported 210 leaked objects from this call path and the
fixed kernel reported none.

Cc: stable@vger.kernel.org
Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..ed91ceff45a9 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -771,7 +771,6 @@ static int sctp_send_asconf_del_ip(struct sock		*sk,
 	struct sctp_sockaddr_entry *saddr;
 	int 			i;
 	int 			retval = 0;
-	int			stored = 0;
 
 	chunk = NULL;
 	sp = sctp_sk(sk);
@@ -784,6 +783,7 @@ static int sctp_send_asconf_del_ip(struct sock		*sk,
 		 __func__, sk, addrs, addrcnt);
 
 	list_for_each_entry(asoc, &ep->asocs, asocs) {
+		int stored = 0;
 
 		if (!asoc->peer.asconf_capable)
 			continue;
-- 
2.56.0

