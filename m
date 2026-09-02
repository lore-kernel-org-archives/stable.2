Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3F35E1AF
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314242; cv=none; b=X3U7R3C+OTSdiLE43Am4tMvZynNc0oab61Yr7UxG/m9+hr7jEkK3pmPX/gpYMrifIsZh4CmyYNklkp/ZGkvDLpVx58buRj1h1nGnZ4PBy98gJ9PyROzP5HahO9v5WyKxncUyBQ6UB2Cq5f04kicnP2MHKVRIbju1Ac59QGeSu8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314242; c=relaxed/simple;
	bh=kjynEym4JkM4qLFWRtB6GBT9eT/13ERJsjb/5ssDOQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eo4plkNpTojnsUF0asU9F7GQ5oiPkQ4N9DRIjjsdA8iyuYDXrNaV02du+EzJ20xuogttYZE3SUKb+zl2FyzzFZ+A4Q5ohz7ElNfZqsDhaSX4IAjbKg92IaZ8nhTQ6abZ8z4W4CJzxuVODxBCQaEz15nA2eMcJl1oqhrDT+pLL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=neuNbo44; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="neuNbo44"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38511175ad3so518336a91.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788314234; x=1788919034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2ASlAu8y5yvnOMRkejZNi7wm/1MZgn7xMNUrYUfQtI=;
        b=neuNbo44bMNUajm357LiSzKnzPxriyzf3VQtr1yrdq5+8LYsxqaz7V9REmNxf03Xkz
         OHqxnbS1CLxomdb//e+Rs7Ip/1t5n3qYfwLabG0J/oHZSxQhf1uWerbrPTeFUBesMSli
         Kd5K+xcf04yV/xtMzdqBewpFFDfc4CHUdMCKPD0ekp1XeUfj4m3RAqsiTsIp2bJECUsa
         GgFcTT/CNo9O/CZrUPUCmF7Hp1o0bNx5puZ7SgxfXADOFBMzbI9Hw4m5WIk6+Q/niJhC
         8ml3F+oYNfBZqvq2TzgCh3CpE+QNttvN5llDk9yBO6OF2hQ1VmJ2pGZSizNkwtRSZwZf
         s4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314234; x=1788919034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2ASlAu8y5yvnOMRkejZNi7wm/1MZgn7xMNUrYUfQtI=;
        b=ZreE5wpM6acGsObbD2XKt3SsZ2v7Tlmv3f/wygE3MgrFEY+ZrumsYpJ9i6/fCFHSqe
         NnO8u8EAydRsFJtXK3C/LBjgLvwI9I7CESc9BS4YJ5B78crzV9R+PJIPPecZWCr7t7r0
         ZKkrqt+AsAcgy9NK6And0nbSPDxOmL89cfeXGYnVxVrnhbadmCgeGhmcD2iPDGI6K/3i
         0IQSkDqJAzchLl6JAN9EC7JRAQtkJZtwRsO/6WziJvgd0LalnNBzG1UlNlWSqCbJffMh
         B7Zmj9X2N9DeYPJz9rpI6QlUxu8xnCgf7DMnwnRV5EAiiNsV6VQjvHHkFfMfj2PM6bap
         bHCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPw5lfRG5ygbP6hEqxLKYrpDQhagL6LE2ig7Z2weWQBKMDXQNjoiUhDB4SgpzXFCKZnJjjgVs=@vger.kernel.org
X-Gm-Message-State: AFuF++mGcVtrTIC6ckTdp7SLiafUF3rQU1aVwTyhzXSHJhIdP+kVmdqa
	xwYuaMC9nwIvtwT9L2ibHvZaVSw87Z4QQc0kayRoNzKgQ66El6owQMxSiNCMrZVUn04=
X-Gm-Gg: AYBFou24/kzIbGWCMrbBb+XE7uKHb5I9SLIe2sJ+puD28GXg9QQaRSLs/67BwsEd3+n
	RSpYmeBK/v468GaQNPFR4MXaxVIKMeGWZmOwlpV9YQNciOg7M47ONunGQJIcAu2UNrkmH1QUqmc
	X/hNFJc5PXmCXimaAQy1MfYlSVLBUS078PKHGK9HseliJv/f4mm8Nw2b41zVQi3eeELGHnbkPFt
	mE42+kNCYbx9VMbvTGo6yjTntGxd9cwVG8KR9JqOWVMOPqLEBsn60a7o6xaTnSUzexNOrV3fByh
	Nr9K8d4VvjmgRgWiT5LK4ePUSNQciBnsK8gmBfhiPm2d4qV9eSAPj8ccLsQRstX7pf/6XhjiuLn
	JLecZ6Hrj3GEH13BHdKxm7XJYRXMIvBsiA6QGSGN0MjZC7t1u2HxYt0GMxDpAYzhGt5vF5d/EWQ
	A3E0aLMk8gMoxDHsdQTvrLhB5T/j0fh+PiS35V5kC6mrO5IQbvjDdF
X-Received: by 2002:a17:90b:4c52:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39aedf7c6aemr1801505a91.5.1788314233810;
        Tue, 01 Sep 2026 18:57:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae380d7a9sm2252710a91.12.2026.09.01.18.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:57:13 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	Joe Damato <joe@dama.to>,
	Sashiko <sashiko-bot+sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v5 1/6] bnxt_en: Only restore LRO if the device supports TPA
Date: Tue,  1 Sep 2026 18:56:44 -0700
Message-ID: <20260902015652.2421609-2-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902015652.2421609-1-joe@dama.to>
References: <20260902015652.2421609-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a P5+ device with firmware that reports max_aggs_supported == 0, it is
possible to make LRO settable by attaching and detaching an XDP program
even though the device does not support TPA.

Fix this by testing BNXT_SUPPORTS_TPA before restoring the feature bit.

Fixes: f0aa6a37a3db ("eth: bnxt: always recalculate features after XDP clearing, fix null-deref")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d59bcca73a2b..0e5c2a48f313 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5006,7 +5006,8 @@ void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 		bnxt_get_max_rings(bp, &rx, &tx, true);
 		if (rx > 1) {
 			bp->flags &= ~BNXT_FLAG_NO_AGG_RINGS;
-			bp->dev->hw_features |= NETIF_F_LRO;
+			if (BNXT_SUPPORTS_TPA(bp))
+				bp->dev->hw_features |= NETIF_F_LRO;
 		}
 	}
 
-- 
2.53.0-Meta

