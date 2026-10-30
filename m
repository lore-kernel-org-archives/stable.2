Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368279;
	b=PrKvCPPHp8iMlwMdPrQl/iB6YCtACUaAlzPGiG9y7dM/WUGRAVwhlJ6ExVGOrjYRxMdI
	 BQQIw35Mi9pUWztdd6j6dAPSFTimTxXOAj9gxrlhmSDtiGmjGgA1zqSMxv/ty3VPfaD50
	 64+5Mnp2//V0Ab7KfkBj+Ox5F0jZlbCqAWeS6lix0fb7ve5FGAnpnaD+895oOSVh71wzt
	 OjkFIGAnTtfurtxuS/b4WypmFpU+efC3oeyy55/gtSxIZUJqBQW7uXxf/jgk2bgip/SGt
	 S6b1chWvK1vucD+2s/aM3plpLIEioYhGfH/YcbRwp7RV9CF/fyytOMTsIHmuEAd92Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368279;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7RJrvzHfyRH2NludABJx8SkoHJ3QglEZ3QwWWnb4wDA=;
	b=GCoJZ9jFij+oLRhijiOy4yl+LeAaa/p7IeEL37N3acFs96pVFR4uu1o4VnmOGrGHts6e
	 2Bjk0H6UfpX05wbftee5zEXMX28fQjnulldqMyIdmKvTN1uB81YmU7kdTu1Px2e5xby1d
	 HVA8gJS9QqxtBhCKEUM0zjLULm953LrYwNiz+fTepzWQ9GAdvX1MbxSrth5ewf4qj47ME
	 99Cc/eTDD2jPO+8AyWQbctZ9WI+I8+jiTWuMzxGzjQMQcpE9yXOm5fz56KqoDda0uqvtF
	 bSUNIV+xqn5Igao7OUX8XP6pqQzfhfR4Nn8Gy2w2UFmuAZIGY4VliPJcltH9rAzTELg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=Uj9ZNI8M;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3EFA1606A32F;
	Fri, 30 Oct 2026 13:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EFA1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=Uj9ZNI8M
Received: from kero.packetmixer.de (p200300c597124Fd839580C360D3ed6F6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id E38E7FA156;
	Fri, 30 Oct 2026 14:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RJrvzHfyRH2NludABJx8SkoHJ3QglEZ3QwWWnb4wDA=;
	b=Uj9ZNI8M4c5o4Os1IXz7uiJxfYui+RDzm1Dz5CjSqpmnu1qnnnsztK4BrmhL5dBuo+f4jA
	e63MWLv7Pi7/1ILRtfyjCjON2tQ2nxNWcppNf/LDZzOh60l7t0AYuWsdeWhBFHekCc5ik3
	46FKQtt1Nb2gOVEUccTVhIsoRHCUgvShp3Zq+oc7Z0xvVuu0ZzGfb/M7f/Uh8ZMljxX+kl
	6QACAaZDu7kv2Rj1U2kbF6cxWLpPRTGfnC9A2CFTD83hZHayfhysa/yt0eghDsRwy/eTzi
	dilHbngjWayN5MjAqApnpvevXOIa1KHh/TIdk/Nt2jSro9EhWuNj2ta7vmS+SQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 04/14] batman-adv: tpmeter: fix u32 truncation of reported bytes
Date: Fri, 30 Oct 2026 14:50:55 +0100
Message-ID: <20261030135105.2555887-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
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

From: Sven Eckelmann <sven@narfation.org>

When more than 4 GB are transferred by the throughput meter,
batadv_tp_batctl_notify() will cut of the upper 32 bit of the u64 counter
and thus under-report the actual transferred bytes.

The data type of the temporary storage variable must therefore still
continue to use u64.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-08bb3be4-6c6a-452d-b4e4-606940c6cfa5
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 022eb13e8ec47..56feb02d2b7ef 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -221,7 +221,7 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
 				    unsigned long start_time, u64 total_sent,
 				    u32 cookie)
 {
-	u32 total_bytes;
+	u64 total_bytes;
 	u32 test_time;
 	u8 result;
 
-- 
2.47.3

