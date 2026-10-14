Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4D361DBF
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946414; cv=none; b=q0SlJGJWXD5+sfEVwBm45SJbSNGDlEiVOc4yheFuZ9C1gdv83nhpgiQXmbua5EV5uoci3vNYcnE2rbtdGy8ytsqGpHbY/X/dPNTYdDdbUpn+SwRfENXJkBUTO+fttbZoXX1OFhwzg5MosdWHa6YtRE5m9Q6Lux60D/tF6EvHQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946414; c=relaxed/simple;
	bh=/Egt3tz5Hs7aeJWjwPyFfGyEMQF3bDb+gjjLGnhPmKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAI9yFcbs6SZkpqF+Y20PRt80LyxE3AvFwW3y7qBKnOSsuaOAPEnlxGRRFp1/OVZ2GcIL/CXHse9rizEId+5ZGCNcZCydizIbgHXJRNGRdf1/s6f8GJAsJkAFEH01qMeRj4cd0DLKm2VEkOxhKtbXo7xYNM8elj4DBk3kFjhp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=Add3QjnX; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="Add3QjnX"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35834f72d94so6606608eec.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1791946411; x=1792551211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SsN0OFGAaeGLWTKOy2XE6d+vAOcJRUzLtjGQFjg/b5k=;
        b=Add3QjnXYaqUvTsMSReWqQanja9fMKIbAa8bauuXutrNcYz37zNKh3tO3i43lqMaKS
         hvy8fTQfdkUmJwdV/bKde3S6VL3FG9orHJLNgYZ26/YoU27w9Ti9zg3qMIGBSgqc7SFl
         eGJMiyT8DdrWXf0T3oF6UmtmrkS1+xxrVTPZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946411; x=1792551211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SsN0OFGAaeGLWTKOy2XE6d+vAOcJRUzLtjGQFjg/b5k=;
        b=SDKGWqc/WczsjXX6UVxskCj/doyLyEJM6ep/ljHpnMfKkzInb9mpNMHjf7qqv5ctiH
         lg55FKhAGqQUdPDgnZgC8RrroGGN/A1tYcRoCEdmhcs9lp/tnQVteCDwuX3bdID4CuvN
         E+2Lw3IbrCToFJ6H2ZTwevh7obMfUmvSpTkupIocIFQDFrsfMA7aJK3jMcWAq2IaKdZ8
         utGMHp0lR/0aLWPoexesm38rDNk9XT/W0GG5tP1GU1xY0ihYrIH9g/xSygLZxopo3XBY
         +WqzLFw8xizHlQb655TUFb9f566utaRIvdW4Qu5YSlLF9D+69MO5Xbsm09an9i4n02W6
         6WUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNc3sU+C4WkRxXBkD5kgNQz41R6t1VBwVOP9rmb9I8vvjgcUKRiytconBOKpwEo7HiUCYphnE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIq0gJE0Oc0rVU1umWcpbbNiFhQM5Dw3ejBgQx1Ge3RCpSf7vra
	rcBYSJgvjuESahyJRBtiR8vjQGA7QTP9lVSxJgD37cBNGWwsiNdDmJHvWnQG98g5a04=
X-Gm-Gg: AYBFou3Rw4u2h8OgT8tc+2TP0HdFvZk8t1GkQU7YC1CXejImUt0jOWoN7qEYlI1jxmu
	Zu1eQjKAlvjzfmaAzznBJOkM8AwCJ8/8NEcoOSXSXKAW4qV/GJwo0Pgf7N3h02kJJwNCRXJZwxw
	+/mq3oJ1C6Lf59ImiccYR7Mek05Tw9JWg6AXfkz4oX6iKiF0uqQDjQ/5R+MMfgjTvVXWQmd63vC
	Khsx6QQU+dT+riA74eaAR2Zi3pVL1MPKdkeco+z3qf3EHTbOu9tY95oD3zOnVIdqsWvQVcnIy8p
	BNNGN7AxiAsykmeEGEpYflQiZ7W33YSYcduzdTIGWxaW1WIzeIaZ85YhS1EnC4qPR2AACCBQLDE
	NGvM9Ox+1R/SrUTLHdCT4qBdoSKvEeoyKWa1KdrSabiVzy+bYVoqjZczDYBWbkHsPaq8uMb/M5h
	giT73IviHaQr0rrvPqw1aPUbI69MetmDF1KFW5ERVkGR6G9Y37QXB4/MgS0QECsBdHkW4uilF3R
	QBnohjt7S4Gpm57Sv/7BScCyzy3
X-Received: by 2002:a05:7300:2c01:b0:35c:1567:7966 with SMTP id 5a478bee46e88-35c15677c5dmr6988514eec.27.1791946410151;
        Tue, 13 Oct 2026 19:53:30 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm46522557eec.28.2026.10.13.19.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:53:29 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: usb: pegasus: check rx pkt_len against the received length
Date: Wed, 14 Oct 2026 10:53:07 +0800
Message-ID: <20261014025307.25233-3-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014025307.25233-1-law.wei.jie@gt.tech.gov.sg>
References: <20261014025307.25233-1-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_bulk_callback() takes the frame length from the device, from the
receive header on the 0x8513 and from the trailing status bytes on the
other chips, and only checks it against PEGASUS_MTU before passing that
many bytes up the stack. A device that sends a short transfer but
claims a long frame gets the uninitialized remainder of the receive
skb delivered as packet data.

Drop frames whose claimed length, plus the 0x8513 header, does not fit
in the bytes actually received. urb->actual_length never exceeds the
PEGASUS_MTU sized transfer buffer, so this also covers the existing
PEGASUS_MTU check.

Found by code review with LLM assistance. With an emulated USB device,
a 101-byte transfer claiming a 1500-byte frame was passed up as a
1500-byte packet before this change and is dropped after it. The extra
bytes happened to be zero in that test, so disclosure of actual kernel
data was not demonstrated.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/pegasus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 7c7d6b69998f..7bc9312eaa9e 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -520,10 +520,11 @@ static void read_bulk_callback(struct urb *urb)
 	}
 
 	/*
-	 * If the packet is unreasonably long, quietly drop it rather than
-	 * kernel panicing by calling skb_put.
+	 * If the packet is longer than what was actually received, quietly
+	 * drop it rather than kernel panicing by calling skb_put or passing
+	 * up stale buffer contents. count is at most PEGASUS_MTU.
 	 */
-	if (pkt_len > PEGASUS_MTU - rx_offset)
+	if (pkt_len + rx_offset > count)
 		goto goon;
 
 	/*
-- 
2.43.0

