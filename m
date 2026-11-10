Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336684;
	b=doczu/WK40InHKs23jmt92Y4f/ivzx5StJ24Z8RizkGe8YtArNQ9aZmiIP8T/ZOInVVA
	 KytWyy5edIcR7RGXRMXk5Az2QXffz9EBX8JYdK5gagEa9was0d9mEYxmR/5VWA0HNhkSl
	 l3d8+zs7GdWwKVXZlL5qX3UHG78WqquJY7aN0a3PSyPiR2EzVzFhrSFhfEO30Fn1U1XYE
	 vSz4IJ3APKdLB5/UF0i75SPz2yE9geyIy6I3XUmmq2qtRsrc5ahx8ft9KoLj8kG0OIDr1
	 Cqu1XVAPAye7235zm4NFiuH4KE7YScAwDWAEpOa70Vq/1BgrT+0DY26vj2/lFfMNuIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336684;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4KiThNpMonWVZbU+3zrp7ORvtk2Pp92FmIokhHMlpg0=;
	b=Q5uIhKDCqo9WA88DTIpiBWoKF0oBb9boH25aqyJcRZNnyCU38JD6t7qvPBPRuYdzxDif
	 B6pPIHzhZHuHdVTAo5fGbTlIVDP+QToEC9EdjpFLNUteGg8HNP+6avRiKnEmCNNx+iSCf
	 vg7/4baiXHjIN+Vs535e+A7SmFQQ2MKRv91C9tl8VlcyihuLH6h01RnYYu4Vm5A5r0P7x
	 mzME243hVHxj4Aa+0DbzEZN8fGg72nMXvX7ajL24wNqrAcweXt04C8X4fr669qspvci/T
	 oUphS2xjWBzFoifhfka7Teb4LpcneqSpmgQvsmlQowGOa7U2akkwhXF/WH/62oagPrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=KJzn96MW;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7E35C606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E35C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=KJzn96MW
Received: by dvalin.narfation.org (Postfix) id B82C3216C6;
	Tue, 10 Nov 2026 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794336681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KiThNpMonWVZbU+3zrp7ORvtk2Pp92FmIokhHMlpg0=;
	b=KJzn96MWYNrgge1xt/mfeknmhs67vZq9lvNtVGP1l48qKXXl9oxyhvFDcNGlMJ0eHriOsl
	6SUkQ1iHxmJaRDVvP5MpCMWJJyP4SHbsXU1Agxc+Qzw39JTLWE8U0MZ41WPCqdccl7Xqq+
	0EaRHvm8rxcpb/9uXSxWkG4V6pVX0Wk=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18.y] batman-adv: tt: send ROAM_ADV on each roamed back client
Date: Tue, 10 Nov 2026 19:51:18 +0100
Message-ID: <20261110185118.75170-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200234-failed-6.18-aff4d5d10f2d@kernel.org>
References: <20261109200234-failed-6.18-aff4d5d10f2d@kernel.org>
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
index d1cc702e1f14d..3f0b26ad699c0 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -729,7 +729,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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

