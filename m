Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339834;
	b=w+gEInlRUghSaQ3DRjBJWzQzjOYqxccKeAVxJCrWYMiLO/9sopPk9kM06RgXVL0VaOnf
	 7vOzQbRINKd8LZqCWAm4Gzd6BzW1XM8FB2jB8YsUmvccfNmWP0gZmahXStOwSVYDPI3Mb
	 pUCmq8TKHU51TgOhSUWraxajLe2Y8ZM4GwdeLhDRR0NyQs4IrEBRwOBxY/AD9ypqGO18v
	 U4f5wd7/8OGypYWwIri24VrGHESWIdO9KvIJWw8NyT90k4Vlk9aSgcJob93EvDqth7kYo
	 9DPPFkDoC1x9Onhj9YY9KHzQK5yfPZUiAiFfHUGF5dO42b/e6IRoYrLarVEHBcz+Fgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339834;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UB89NvND3meX39IO74bUGxKxTY0ovBAsAq6AyeKg6Ag=;
	b=EBMyCln3JktlNROJPqfq2tutnjxgp3w/d9YHVSEntwciuF/+cfxi3iFhJLgMrHM95aF9
	 +K8DEl25NZ7x8yqGU63wEXmi3naisM9oMTSnaMepD3jn9bgzl0JvY90PdgslTLJv1+bHv
	 an+BuDQ1p1dwVVa5F+tu57FfBjuJSiW2RAtWJ7+QoBqNQsN6lXtBWPNmLrvfKJP3rnfNf
	 jE5dPdA4ruWWT/HSk170U+iV72g/GFH6H/hokEoQO/fEM+GrFZHGQSpLKSmiaFscY+30Y
	 L//hxwN9nsSo8VWB3GkZSlK6ofAnfBeeJu4P9jXxiiDH0MHNMcdxyIIsYEMdKkONuIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=coaG1rh4;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 90C9D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=coaG1rh4
Received: by dvalin.narfation.org (Postfix) id C427920292;
	Tue, 10 Nov 2026 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794339831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB89NvND3meX39IO74bUGxKxTY0ovBAsAq6AyeKg6Ag=;
	b=coaG1rh4BanoYYUm5s40c4fM80jjNGDrjBA6kvikNMZJRrKNMR7CI7Y9l8q6M6LTzM1v4z
	skuc4dU4XS4CMkpqfUl41XWUisHl/4R76GYTIMe+es3HV2hrGO0tmLAwQYcfR14wUvcRCC
	R8BENu9dV6DEdHQv21tcF517TCQXRXw=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15.y] batman-adv: tt: send ROAM_ADV on each roamed back client
Date: Tue, 10 Nov 2026 20:43:49 +0100
Message-ID: <20261110194349.334488-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202030-failed-5.15-aff4d5d10f2d@kernel.org>
References: <20261109202030-failed-5.15-aff4d5d10f2d@kernel.org>
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

commit aff4d5d10f2dcb4a9b604e27414dafa1d51b6406 upstream.

When a ROAMING_ADV is received for an announced local client,
batadv_roam_tvlv_unicast_handler_v1() creates a global entry with the
BATADV_TT_CLIENT_ROAM flag set.

If the client sends a frame again before the next TTVN commit,
batadv_tt_local_add_roam() is expected to announce this return via a
ROAM_ADV frame. But this doesn't happen because the global entry (created
by the first ROAMING_ADV) carries BATADV_TT_CLIENT_ROAM until the new
originator announces the client.

Let batadv_tt_local_add_roam() always handle a roamed back client -
independent of the ROAM flag of the global entry:

* trigger sending of the ROAM_ADV frame(s)
* remove the (with the roaming) associated global entry

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
[ adjust code still in batadv_tt_local_add ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 300e3f9b60200..ed74e02f5bb20 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -775,7 +775,8 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	/* Check whether it is a roaming, but don't do anything if the roaming
 	 * process has already been handled
 	 */
-	if (tt_global && !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM)) {
+	if (tt_global &&
+	    (roamed_back || !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM))) {
 		/* These node are probably going to update their tt table */
 		head = &tt_global->orig_list;
 		rcu_read_lock();
-- 
2.47.3

