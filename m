Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484663;
	b=uTF9fHFD7pMrwqVXSRsET+EscTJSttQ+U8TaEt9OXnNkQISr/PdDGeChOZ/vUwknNeNt
	 0t+LeMGyB8/XkrmMUiErsjJsgLyU6jGWgPOm89+wF9mo7U2J4af8cEX3rzcDJ0S8Bdg5S
	 /ne+lzdbhdW2K6D7FVfUWC9F8hYjmuF4wOyPHm1Rm3Z/3W4k/qmQflJEmZf4ahPNCooOT
	 gzXdpZJCkW9QCYYSP5c/xe1tpfzC5DQxPGxCvyN/1wc06hjcXL0nb8ZXgIFvHw6xK/mLT
	 KI7Pz2lgZ0ysdC0g4OfPWZsfIfKxx1sMjNgC7Ub/0OGKNqmVw+0tYztfcyqoASPKIlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484663;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=sjGglAdaVWF0HNmnKnP9CltUjRyWRhVNvGTlnib4FK0=;
	b=pweBS+UdU9NWgn6f/qUoh/T9GdxRt0LMjqLs6CMxvljsFoBzcsLliq8V1GGEmGZfougq
	 oFT0TERaIxzRI2X38ehQsOfrrZrGT39tR40fjwcRBU9ndIdBp6oMrdjq0mVzZqsX5i+eu
	 uO3i/NprPQBiNBfalYTPCb5OdPedq28oUMLS7toc9pk/9T+DadNBIlitvyUo10iFZIHZD
	 lDZ4pQErDNJahHWlGcDwnqHw9/FpG3bXIqIdaUPLgOaC++jF84n8yABfnprLUMuBhIIgA
	 gYUd/JuCDXI8xkLKpoppptsICqRTTI7uIVhjB2KutRfYBV+v+FaJXlgfal6FWl1Pazg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=nSa5PgXP;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB7606A31A;
	Sat, 31 Oct 2026 22:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84FB7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=nSa5PgXP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=sjGglAdaVWF0HNmnKnP9CltUjRyWRhVNvGTlnib4FK0=; b=nSa5PgXPAELvo+BqD8AapaKRwz
	NUyz/KSB1Fnr0LdLAkKeUzQPvmNhNhIaWGUMpkBFsaIMnmjcl1mtZ/HCu/Wg4RYOME0bxacGOT3/k
	yiWR3Wxly7FfT+8onzBrfwY5xdapxTpFZgSF7pqdVTIQYt1hbHgBZ+AUVT7tao1j6p+FNYWTy9MpV
	ZZqW8jzDn5gvp5xgIGw6OjOas0TKy20wZJVVjbkSbL7L4ROlJghKDkgbnV7FxAhivT7tSuobjvfKB
	x1QXysD1uKaZJ8yvIXDQW1tFfruwi/ygzZo62nTpnGYKsctDkUpnLr39gkhI1WwOQ7qGdLMLjQj+z
	i0cWGbwg==;
Received: from [151.115.150.205] (port=46594 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xNHI0-0000000EZr9-1bKg;
	Sat, 31 Oct 2026 23:11:00 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net] net: qualcomm: rmnet: avoid stale VND access on TX drop
Date: Sat, 31 Oct 2026 22:10:51 +0000
Message-ID: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

A struct rmnet_port stores a pointer to the most recently created
RMNET VND in port->rmnet_dev, but userspace can delete that VND while
the port still has another attached VND. When RMNET later sends a
buffered TX skb, a failure in __skb_linearize() makes rmnet_send_skb()
update the drop counter through that stale pointer, which causes a UAF.

Account TX drops on the lower device instead of port->rmnet_dev.

Fixes: 64b5d1f8f2d1 ("net: qualcomm: rmnet: add tx packets aggregation")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index e6f48dc9fe64..4df75f4215fa 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -543,10 +543,7 @@ static void rmnet_send_skb(struct rmnet_port *port, struct sk_buff *skb)
 {
 	if (skb_needs_linearize(skb, port->dev->features)) {
 		if (unlikely(__skb_linearize(skb))) {
-			struct rmnet_priv *priv;
-
-			priv = netdev_priv(port->rmnet_dev);
-			this_cpu_inc(priv->pcpu_stats->stats.tx_drops);
+			dev_core_stats_tx_dropped_inc(port->dev);
 			dev_kfree_skb_any(skb);
 			return;
 		}
-- 
2.47.3

