Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68B2949E0
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790457661; cv=none; b=lI7yKA4qNCJyzzD16jzUjDDgyjO+jHKeSpFxFZwhWA4SSEzRQfJH5mH+52XAvNvB5ic7bmV+ydOJ5SIKGhy0ASAvH2Q0raSxIaUg/aK2XPXWSFKMeVjeClIz2ZhJ8srWTqPQcAds9aQOfR4zmK5OqDZDp8I7NUP6vohbmv9VBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790457661; c=relaxed/simple;
	bh=ehymt4lLAFUs4DIWG3dhPtmab2vi6Zhi6J9yEIZNRNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHQpANVpanLrRVeWv3NAbyV7VFm9IEaddEyPEmXVH5cxQlrNaoyYGOb39jcmfkTiguCYOiIdCPy7ZlN1cDu7VYbjFaOvP0f4dDYb8AkcpN1T4K4FCQURtSBYPKkivd3meex+D7uEFhF0axDRxvH2+hX856EqMZxfDzcegFHcOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/whwn4Q; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/whwn4Q"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-9832c759198so1036877241.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790457657; x=1791062457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D3SALmSygZKgLrynJMWzH3B1y0jcmXpTFsBEcTzacV4=;
        b=r/whwn4Qk8dT5RsTGNRmgg3PLybtN+HzcZMj2bql/Uy+9x4hpvkE8q1MzHeLdQAF0p
         DnfKiXVKQDoMljDfuGLA4S+Ox8UboVqNrkxSAT7c+ercFphtVFHHlMXZfPukyJtfXQ96
         Q4e4ND0uZ03zIaONfojqNfDKLA8K4F+onm1SzfHuJBvI+4RYE2KpTA3vqptR+vigdDTX
         EupJtgaaw1CWBh9E6YNP43CuHZb3UhWWmLtuUSbbFib4sEC3blZFOyX5K0HwdY1dUbhQ
         MCKV9aTa0E5od1D9fUJmtuhdUYgZvZ8b0g0Z6ei0a1C+mH9z+nD4UOOZKoc9OPo8jIon
         kjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790457657; x=1791062457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3SALmSygZKgLrynJMWzH3B1y0jcmXpTFsBEcTzacV4=;
        b=tik3hGOPRTVVj8ccikBQ6KsBS8uJYaRBE9ebWz6PrrEA2lIt1lCaBksqfnMzw9LABv
         5JN/v5pmsx/OyzJS/CihaSG5H+jj0P8Hhj5pTO1q69ufH3cqDUc+r3adnOAxoEQuXXbk
         WJ4sJTXiWkUAq+SJOzLmkI8NRJJ4QujPeOia5ZwNvHpJSB5MA05Pt80BHbB0PmSjB42D
         /HS+7ae5+YZ/1V2OjmfsjeWErciYinP8TDktfw2vHFFAlcxgm+sTsknq09RKOJvkGVSK
         8VFNR641FF5eSSxTSYi+Q3h0vlIK8Tbdfd1Rmg7gh8gVPLbv22NM2tJKiwazCqsw+dcc
         p/uA==
X-Forwarded-Encrypted: i=1; AKwUvBwO/5ZZMZ12stL1RWSlmhttOfAp9X0gexSFdl2bcATMTJZrsQUkrFAUvnAV74Etw5CPEn6TrQk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMNyixb4wiH9HN/z/HFPBgGk7JiszSkf81YsSrNqBpWYT6e0wT
	0JkZXnAegOVpcnKcmy0bf4tQ1kjfksCxWwbcWVhrfWW5VhtsJsZ/dmc0
X-Gm-Gg: AYBFou121kWIY7KQeIvLGK4wCaKExPqqijd6Ky1Ze6e1seGmZ0TtyEFSdnIDf++SWpY
	qcrC9J2rLIYk4+JHFhGbLYUsO9SS7iJIa/iiYfp/5t4UStUNEBUvX1q8LMXAe8GNyBRmo/UTQnU
	lG9xIXruQ7uh2GwwlOCqOQ8o0mkiyW62o8yVk45O354eWRT+lG8nZWluAooIVXX2msxn8NFjQfA
	nWm1Iy2iOwiWM8huAkJEJoivwltQk7LvMn2k+3nYndo785BwT7YH0tVc1ENPhFs2qFTj74L7VqT
	cHr0PhUxde/XmdpSTjhVZebg6hMP0MTrCMrOMq4UG0ZdnwnsVBnxp7qnPNuZaz/gBs942tBZXP2
	eDK6S//oEVydBFN/QMID/tL+zaKN+WAqWc7ED4kheXtoogIa0cyNa5Y5QeC2rdqNJGdz+RZ3MTW
	QnULwlXW/nKsMQ5YOazK8Qh2WmDvJUKbkZ2Smw5f8DUg4gB1r7UrX0xqpscGfeXp8YZitxNbRO7
	Q==
X-Received: by 2002:a05:6102:4b11:b0:7a7:198b:674c with SMTP id ada2fe7eead31-7af1f3f3a90mr3668073137.33.1790457657120;
        Sat, 26 Sep 2026 14:20:57 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b9ae253sm3267723137.8.2026.09.26.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:20:56 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] nfc: llcp: clear device pointer on disconnect
Date: Sat, 26 Sep 2026 18:20:41 -0300
Message-ID: <20260926212041.1342558-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_recv_disc() drops the device reference via nfc_put_device()
when a connected socket receives a DISC PDU, but does not clear
llcp_sock->dev.  If the socket is later reconnected, any cleanup code
that checks llcp_sock->dev will find a non-NULL pointer and attempt a
second nfc_put_device(), underflowing the device refcount.

Clear the pointer immediately after the put so that a subsequent
reconnect does not double-release the device.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/nfc/llcp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf81700..199543c47 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1220,6 +1220,7 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 
 	if (sk->sk_state == LLCP_CONNECTED) {
 		nfc_put_device(local->dev);
+		llcp_sock->dev = NULL;
 		sk->sk_state = LLCP_CLOSED;
 		sk->sk_state_change(sk);
 	}
-- 
2.43.0

