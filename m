Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20CF3B6C14
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899981; cv=none; b=eY/p1vytXRyViatPk6bqOGHnWu9YVAlmiB97KotWfzOpPmcsWRRFC1334KVnwI2sv113a/alKSMZs3o+53Zd2vT598BiGhxMTNO8xzm4n8w/JWWbXh5BPQKyTgnW3ZzSyHREs5y0wJoRm8SHp1ysL9alJf9pDvWOoxBWioHXhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899981; c=relaxed/simple;
	bh=9Panq1zT+LS9VhnDPcBHUWdw9iHh3DGpGXcE3+Ojqb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKcqHlBkoOL0f6cD0Tb3jheX3nrSJzXFjRryCPWRCe8nPqFXa+7/HfH57p5BgrfGeGAiFyxQ7o9Je07MVCa4sUC2/dywOZPFNlrZ9TDEPwi2Psht4RAI/j2VjvRDC5jtS9XP+R9bV6SM19Tf/vYfja39D+HPtoHh35SCdC9Sl4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=QKZnPidt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="QKZnPidt"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so563046a12.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787899974; x=1788504774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w6NOIIwhRVBbBiq++fjDRhLDbXTEcUDbCMW9A7eSR+c=;
        b=QKZnPidtkKA9Olx1871W5xKodKWrJgz7Lo52PFUXtJ2HxZG38UirwL+Jc+PXiKUYK7
         pvdpYU33GylgopTjt8RIqt64eSGmIsQsoFSVGyBHnPkCbzRp6Ll0w4/q2bim6gJUGd8z
         L7SwDZyv6zb5BplyKMSLY94/PuCMhTnSqPGYLlZELHiXf8AwSr0FPAWCeQKipnZ/rgoj
         SRpYURTqg0wA14XvlzXOXYc9/xwAzaTyMiglsc7nx2GkfoiuSUm+Ku/zHKfWGqRq51fQ
         jNx+6cbdZmbj6XYZnjd+TJhobitTCjSXD38psF5zun7TDT7OauYuLJpQTEbXk1x2m/UO
         4F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899974; x=1788504774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w6NOIIwhRVBbBiq++fjDRhLDbXTEcUDbCMW9A7eSR+c=;
        b=AmG0eBFxLZg8S8u3pd2p3ljowDsQjgMtyUS6vG7c8qUpfFfRh0/T4aSEcPsDMFO+U1
         Grsie4t2gdJQcuTvYvPKaJwrNS1CVot0zfNuZRHThVvkDbwbUIH/WPVa4QtiyiykmpFT
         OZH+vPQig/zOdGBOZlFCSw6TGRzr1wMwnIOYxYIjClGjFVl8LFba6K13A1dKNSxIs6Q9
         ItOuRRi9Ppf+41TxnvZqeQyKEDTiWJl9JmSZirTY0AHdEVJRmPHt5DUK5Z6XHtFCITTc
         FC8mSmjUSLo2qaYnrRnAVL8y/YGL5OnzaHzqJeAOxgQFlgmnn0H4MEi3ONfNe/lNmhxW
         4wsg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6uzJmWmoQ8bs8e4Rf41ibxl+Fa/pyMkgd1fHstIU/hDFC43l9PPQR8M1yoZAsqT2MS33i82c=@vger.kernel.org
X-Gm-Message-State: AFuF++ktivVlJLUyau3jNDIKQ9Jl/81EpHyFcuNQ3gfyXvyHT6V0fgol
	ryaLQVffNFbhtILZyHY/wAozjMRi/uVgXFm5/my161plF7ut5Hs0n8CloYuA8Xm9krV0
X-Gm-Gg: AR+sD10PaPdRWKnY9iuOl0jg5SBUf8DNjXN5lAjksj77iVq8QgRmLxJh9Uw/b4HO9lE
	BElSwifCnPc4Q7Y7KhixwlX24PUjT64jYoEHP7AQM0T5PlV2q7ls0gGA0JAwPT64KSHvbhb7zOW
	jHet8xiySsyXf3qtXqJvnXGfBNFdJYkPhMwxdZRtw2Phb+TZo4JNaclw3xouHrlLJ9fxLR3ycn/
	g4mNL6dP8CbUPxCf3uCOkxnhjAiOA0FbrjXZ8CwxO5L9/y1Sl24kw8UdTTpPpWtn2pNmPWoajwP
	c1tbKiMWgk+WdPgC1LR2xuuJZxZ4T55viPlfqgrVPRvxoGEMpTBGpHpxP4f4tL2F7ayYqCBnhzq
	qUYdPGRGssOzpmuZsDcFITOqZ3M5MBV1Jmh2Jr1VJQy8bw3VQ0DeI47M4pWPv3vo2cNgLUESQRY
	8ifrtPyjv7/bl/A8mbOviYAFTgPVq0QVhtUX7sALoW4NbtOu5r+GzR/G9qkr+8Obw4JBDvDQonq
	nxsx+ZVkSgKqRbZwgovb/zt
X-Received: by 2002:a17:90b:2d82:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396d0f2f709mr10170367a91.11.1787899973886;
        Thu, 27 Aug 2026 23:52:53 -0700 (PDT)
Received: from gmail.com ([202.201.11.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39675867f73sm3896705a91.4.2026.08.27.23.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:52:53 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 1/1] ipmr: restore a limit for unresolved cache entries
Date: Fri, 28 Aug 2026 06:52:35 +0000
Message-ID: <a31c6fb1ab9846c85e245fcf34948ac2bc27e521.1787854085.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787854085.git.zihanx@nebusec.ai>
References: <cover.1787854085.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unresolved multicast cache entries retain up to four received skbs while
waiting for userspace to install an MFC route.  The cache entry count was
tracked but no longer bounded, so a stream of distinct source and group
pairs could retain packet memory until the system ran out of memory.

Restore the unresolved-entry limit for both IPv4 and IPv6 multicast
routing.  Reject new cache entries once the limit is reached while keeping
existing entries available for normal route resolution.

Fixes: 0079ad8e8dc3 ("ipmr: remove hard code cache_resolve_queue_len limit")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/linux/mroute_base.h | 3 +++
 net/ipv4/ipmr.c             | 6 ++++++
 net/ipv6/ip6mr.c            | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 4d55827e9705..af9247bb3f4d 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -224,6 +224,9 @@ struct mr_table_ops {
 	void *cmparg_any;
 };
 
+/* Bound unresolved MFC entries and their queued skbs. */
+#define MFC_UNRES_QUEUE_LEN_MAX	10
+
 /**
  * struct mr_table - a multicast routing table
  * @work: used for table destruction
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e5f2b1c6150d..3155ad921ddc 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1165,6 +1165,12 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 
 	if (!found) {
 		/* Create a new entry if allowable */
+		if (mrt->cache_resolve_queue_len >= MFC_UNRES_QUEUE_LEN_MAX) {
+			c = NULL;
+			err = -ENOBUFS;
+			goto err;
+		}
+
 		c = ipmr_cache_alloc_unres();
 		if (!c) {
 			err = -ENOBUFS;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3f2ed9b77deb..551b04d4fa7c 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1207,6 +1207,11 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 		/*
 		 *	Create a new entry if allowable
 		 */
+		if (mrt->cache_resolve_queue_len >= MFC_UNRES_QUEUE_LEN_MAX) {
+			c = NULL;
+			err = -ENOBUFS;
+			goto err;
+		}
 
 		c = ip6mr_cache_alloc_unres();
 		if (!c) {
-- 
2.43.0

