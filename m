Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368290;
	b=S/LL8NP1zt83XSmZhmrEy2GeH1HvaDiyFHDw1F/O8wDZiSAtX2rRA2h0NWap6HyGz23m
	 pNwn+gA6loncteWcdEPELcgxf/O2WXk6Wojq9MbgFpLxvuiDjUT7OTqzvuR2xVk5u3gyl
	 R9fINPwKR1YHePJBi3hICGXUo5BoPmoa/3H9I9Mf532K0jBuIMEt5KgXsWHv2kZAy4BqC
	 eLFWPHzqCFgeRD67JnWqu6TmNjcXk2gEdPMwljpyjcXWDp5xQ7eDfttxF5ojlqZ7wllxR
	 RuhFqWuRhqeeoHZTYhgfZil6UwzgXieihHeAugjaDr3Cw+wgb+bLe9ZTw9k/WgSumzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368290;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ll7ri16af1436qp0X+F2gqvbXnAO1/+bWFHqnxgs6Co=;
	b=S98uMV2u6wAyLY2dvgWQiF5igOGZ9LkIJfP6lRm0SnPe/dwJxpiRCV+U+1tcti8PRqgH
	 DP4xZkOcMcQJccErPVr5vVQMFPdamxPGyk+l/M568rkYsw+QBvStAamdTMRC9NMMkg9t0
	 z2eooA9kPa1WR0Q40bnPrJ/U+BOSOziXQqhP9aiDykVM3byBgtoESN5lfXUM3TBh9qcAL
	 eZZNDXQw8LJzKXB+9O9Qc+QjbKD+/fSz4YgRhl395r4QWnOvEouWONfoJfTdCkKMWO1Bm
	 yPp6aYlQQOFPwFxDdcEJc9hgIygW1XwRqulfGbMRKPNI2AxoFn3fw5iP2rFINOqb6LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=0HnOSEa1;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8AFCA606A31F;
	Fri, 30 Oct 2026 13:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AFCA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=0HnOSEa1
Received: from kero.packetmixer.de (p200300c597124Fd839580c360D3ED6F6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id DF170FA2ED;
	Fri, 30 Oct 2026 14:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ll7ri16af1436qp0X+F2gqvbXnAO1/+bWFHqnxgs6Co=;
	b=0HnOSEa12Mi7Bqo2qk2jEa2lrqgZPJ4BVWtcRIXlzpu+IaV3gV9RwJmQDtEYFLdWLus2Hz
	TH2sPmnO18zMdrk4DUhokC7EHRSIenWum3OJD5ZwSBhYqYZALxe/CfAvCEtgXosBOSNWm0
	suu+058pKcatKX2vpG3O8RlEpGRfs9/BhYh2/olPn6n87C0WNzgw0eBNjA7jvS8S3mF2w8
	CTaC65lcpVvS/KytoAKC5XQ6rD6CeJ4UZCfI8DILTbKkUAcVRbyiViwN8bul+D72OzNexc
	w7MSLmC3jPm7dEGa910OkwRItEarcrBcWagmcuqkpsio6ZVSpqBLL6iJnGoY3g==
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
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 10/14] batman-adv: tt: send ROAM_ADV on each roamed back client
Date: Fri, 30 Oct 2026 14:51:01 +0100
Message-ID: <20261030135105.2555887-11-sw@simonwunderlich.de>
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
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e13c2828da475..0df51523dcf0c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -819,14 +819,21 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
 	if (!tt_global)
 		return;
 
-	/* Check whether it is a roaming, but don't do anything if the roaming
-	 * process has already been handled
+	/* Handle newly roamed client - but not roamed back client.
+	 *
+	 * A client which roamed back must always be reclaimed from the
+	 * originator(s) which sent the ROAMING_ADV. The global entry created by
+	 * this ROAMING_ADV might still carry BATADV_TT_CLIENT_ROAM because the
+	 * new originator did not yet announce the client.
 	 */
-	scoped_guard(spinlock_bh, &tt_global->common.flags_lock) {
-		if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
-			return;
+	if (!roamed_back) {
+		scoped_guard(spinlock_bh, &tt_global->common.flags_lock) {
+			/* Check whether it is a roaming, but don't do anything
+			 * if the roaming process has already been handled.
+			 */
+			if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
+				return;
 
-		if (!roamed_back) {
 			/* The global entry has to be marked as ROAMING and has to be
 			 * kept for consistency purpose.
 			 *
-- 
2.47.3

