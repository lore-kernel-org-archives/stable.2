Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F0EEC0
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702559; cv=none; b=hSlsiPiBTsNHEkmOnXEkn+mB8rRLzX7vFz6iSIfxZaXU3Om8eqzE9XZ0B3Vra5GvADpwVm8485hMcUxxb47bPIogwr/t7VvWScGRjJKTAqhIWRN3pwOwrtVl+MxYxxEE+4PGdnyTWX8Jv/My95EqW7SfuGe9ByI0WmXPaz4tRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702559; c=relaxed/simple;
	bh=7VFxiajtNPEz8wd2qW7G25tWjW6JMDTpFm13VJwoHK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXgp50lNp8G/NwR3V56nYlDqym8d2J8MxNGoV2GM60Q5hbFXLw0adebthRYcEnppGStMc6L9dyndqOFfVahPc1pV5W85O5C4suLZXEAkuJQkkbqd1sHZ6U7NywND0EFaa/hoj5wyjS2ZvCg7aaq1aqFtenKtOYBhiZU+XPgPymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=q2lN9NrA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="q2lN9NrA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso484908a91.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787702557; x=1788307357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Utmg/kSt4ut5hrQSIKyhDScZLEzGOdoo3IAf81kK6dA=;
        b=q2lN9NrAZgc1U0CyW707xwP9OjqAt1k869suvt4/yr3Z9XkiAr4lFAYKBbkaqaOIiv
         3GL5DCdxxVugVdeFcUM2/EiXdn8RCc5NfGuJu7PoVnKM+cucyCIWZcf4LAdEJYtHHnZZ
         IluaiPDzbFstwaywB8hJ8FKk2sAcodFw6/6AT94keBoAGV3Nxa0WfiWq7+jtEUNoiYcx
         6N+K+lQ/6IZA+kkk1a7b7cWFCc096/b9ibeYvblDUj/gKQZ5bVegjhkLkGKvE9Ax5ogp
         0801p9jsUY1Zy6RshCAu9/LBbTFrN4AgHOi70ZEcQzKMK9r6sCrF1XwBsBO+RnRAXazv
         R0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787702557; x=1788307357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Utmg/kSt4ut5hrQSIKyhDScZLEzGOdoo3IAf81kK6dA=;
        b=c9XvWKacTTBytS3cLholRWYY+ssjRVOrCKNAGF5IItYD5GXO895cQej7AWqTggXEmG
         Ix/LvBXbO3cCzrRJQXfQBGtCYRN4YaDRMukURj9QMINnZy6EdH1LB900yoFw20k6a7sI
         295lZpfXXUJ6nK6Cc2xRPHZN/QpRehvj3O4Lemt5WuOeBSt7yc320mvvc+vhO/ViK2XT
         4AlBS7zq39he8Hsz8RRwlcOJK/5E0odXbMvcT+tqJZO7TwKKL1kBPQankgVI91vudBw4
         ibNk44KG4yFO91faGTvh8PQySlNho0172U8Vi80Iy8Tp7mS6LlITvwXlIz1CScvQ9zNu
         hPHw==
X-Forwarded-Encrypted: i=1; AHgh+RrXlqfbhyC10TTPwq7JhnWTH54YEbSMkJuxe7m44gaQMklKyW/f1vyz7zhPwvVI+5GeewM+20M=@vger.kernel.org
X-Gm-Message-State: AFuF++naIIocRYcrNgzCD48Krx7HxqFdikVUWkM2MeHRtsy/eqDF6Bsr
	39685kGTSNErPcsyFSUpv1bpKUH3cT+bAiqaj1FzEajJVEJBGs0UrpKuJVOGpnw+JQc=
X-Gm-Gg: AR+sD12bzh+hTGusrLQmJ6VYlisO79mKOsfLN7kU/6DYE6xYy9v0xWNMAfsZsVBjOD+
	MfimBqk0Hi0svpCGOTNoo6LIAX7yrHG7wB1f3R06kYDKP1P4YR+FcfmIJbN0S8EdH5ApNn1K7Eu
	MCW+sbK3sYOITCf1j8UmUphdmUgBxnp2apjmiKw/aOYgUIChJ4xvUlIE5G6wNCYH556VBVaJ07Z
	K71gTv2Bk1KzfflsCbO8p5zvZH/rAN+iwjGExuK/YbSEJ/gN2VwlFrmgSFiwis6OEojqzmGTlK1
	gfkS7cLqBYxyp9QwGWb3mp0LRLtNqtvxgbwQljX2caoxJLGkR3hyjcpfXdQd/xsWJW7SWFvg2gl
	GgO0u6VGIZ6vqRC6+qsBRYsqGAaIiyJZ9LEw8RK+lBIrczqXuxkDje/ydqCZ3bJ1yU7WqYjzOWy
	sWcaEZTTI8vy+pyyM5ieaxiJQgtRMoys6S4odvuVNpFco=
X-Received: by 2002:a17:90b:560c:b0:396:67ed:da2d with SMTP id 98e67ed59e1d1-3966d4931a0mr5782303a91.15.1787702556523;
        Tue, 25 Aug 2026 17:02:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645da08desm5362829a91.17.2026.08.25.17.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 17:02:35 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Simon Horman <horms@kernel.org>
Cc: kalesh-anakkur.purayil@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	stable@vger.kernel.org
Subject: [PATCH net] bnxt_en: Write doorbell when linearizing skb fails
Date: Tue, 25 Aug 2026 17:02:33 -0700
Message-ID: <20260826000234.2031564-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the driver is handed a burst of packets, the doorbell is deferred
until the end. If the last packet has a huge number of frags, but fails
to linearize, the doorbell will not be written adding latency on TX for
any packets in the ring and holding their DMA mappings until the next
TX. Note that the queue is not stopped, so this issue would delay
pending BDs until the next TX.

This issue was discovered by Sashiko and reading the code verifies that,
while unlikely, it is possible.

Fix this by jumping to tx_free, which replicates the same pre-existing
logic but also writes the doorbell.

Fixes: b91e82129400 ("bnxt_en: Linearize TX SKB if the fragments exceed the max")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9c2cc50276a5..d59bcca73a2b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -502,11 +502,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
 		netdev_warn_once(dev, "SKB has too many (%d) fragments, max supported is %d.  SKB will be linearized.\n",
 				 skb_shinfo(skb)->nr_frags, TX_MAX_FRAGS);
-		if (skb_linearize(skb)) {
-			dev_kfree_skb_any(skb);
-			dev_core_stats_tx_dropped_inc(dev);
-			return NETDEV_TX_OK;
-		}
+		if (skb_linearize(skb))
+			goto tx_free;
 	}
 #endif
 	if (skb_is_gso(skb) &&

base-commit: dc4b95b8fee95113587e93ca116356032d271371
-- 
2.53.0-Meta

