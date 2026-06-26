Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153AB3F5BF9
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490323; cv=none; b=dMFALiAB5PPElQ7xmQXOCgdB8iWEf75xa18SOA+mWTuD9ux2YobmouesumaZVU2rH2C44fmMBTNsih1SCEDU14ytxWcdYQK1pdyxq4cc4N1UPfD9MzFuipK+dJ0RU0enZOOFFGal+3MyQG22FBdkBCPoLNKTdy0r5EJ7wcXZlag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490323; c=relaxed/simple;
	bh=EQKv0RTYlSARY05IVF9e5G2qyLSOFek9eG3MvvrBkOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCKJnGFOcTU1RlhLwlVhEPD0A5533DUAAzRpNtyktWiL1611ZB2BN3cRw5K1hPBpAxL0dRS1X0+6F63CKD/4jAx2o76steRB9MHazcAiF6cdS5EoVKL9Q/BKHLdQlWQn40LdrWaEypRUTn9s6CPy6jfsUgUiO8InGHijuD4Klqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=qXtfkHwt; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="qXtfkHwt"
Received: by dvalin.narfation.org (Postfix) id 78620203D3;
	Fri, 26 Jun 2026 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e953+puN8C2V2tpTk5di+Neg2SVgDw1mut8BehXJHjQ=;
	b=qXtfkHwt5rvO7vsG3i4z5/WqDMwVK/CjyVmjNnYwrmfrdCMS6iAFITEftMp6CJSp3cn3ra
	0YzpboZUPRtMcbtWI6G8WGNVZZ6cHDzfjXQFnNcWKO80dIcFEoJ8wh4U9HWq51e6wl8r7g
	1mhOAV5uOT/aT+Gwwnnp/2leQ5pXu6o=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12 10/25] batman-adv: prevent ELP transmission interval underflow
Date: Fri, 26 Jun 2026 18:11:39 +0200
Message-ID: <20260626161154.124562-11-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161154.124562-1-sven@narfation.org>
References: <20260626161154.124562-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 5e50d4b8ae3ea622122d3c6a38d7f6fe68dfddca upstream.

batadv_v_elp_start_timer() enqeues a delayed work. The time when it starts
is randomly chosen between (elp_interval - BATADV_JITTER) and
(elp_interval + BATADV_JITTER). The configured elp_interval must therefore
be larger or equal to BATADV_JITTER to avoid that it causes an underflow of
the unsigned integer. If this would happen, then a "fast" ELP interval
would turn into a "day long" delay.

At the same time, it must not be larger than the maximum value the variable
can store.

Cc: stable@kernel.org
Fixes: a10800829040 ("batman-adv: Add elp_interval hardif genl configuration")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 9362cd9d6f3d3..38f0e5ffd5313 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -936,7 +936,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
+		u32 elp_interval;
+
 		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
+		elp_interval = nla_get_u32(attr);
+
+		elp_interval = min_t(u32, elp_interval, INT_MAX);
+		elp_interval = max_t(u32, elp_interval, BATADV_JITTER);
 
 		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
 	}
-- 
2.47.3

