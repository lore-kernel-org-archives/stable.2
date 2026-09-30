Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C344FE2F7;
	Wed, 30 Sep 2026 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800571; cv=none; b=seXe9pkrNigzDROXL/UvuMPRTQFiCs10SQ9Y3xHxbIh+SPETKmK4h/+ua4TFK+WPNVpF6Tjb4MIwyUkuHj1/EFAJm7YDYzVSyAxI3QbCz1swEYEt2f+PHMlu4mSkW8hMoi3O/n/X+6x+/XKIl5usxXg1aJw3ukERMJ/p5YAfyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800571; c=relaxed/simple;
	bh=4qfgB6E/tWi2IIqs1u5twh0chMSpd3QQ65g3KPBxFsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TbrSO+Cfc+AM+QU6ERcai4eFK3RCO26efjrQaTuyPMYHAXJktsuUM2ACG2Phi1HyZtd7zGSfY2u/jN9h1SKcX+z5K4KNUzIiTFzI2fwjdYJdKhl4XpVGJ6ppLa8taUxq3MZ0erD8avtgAGWG4yPoTkuMWzh8IsAUiSKzJWYb0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=Nm5i+8dS; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="Nm5i+8dS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=HW5z+gJzzTYLIYkL6WwaFQ5hSaSwpHHCI/ikDK9InO8=; b=Nm5i+8dSEIupJUMyxW8O4TL/cF
	AQnYah2KH4CmUCCmr+TxdNj5f4IfrkmB3N2uvb93q/+k9zdjqb7+ridkheiQ7ikbcvWrQVht+g+QB
	awvcFAtItfLXGnVbiNyak2Ncq4PaTgpafInu/bO9mgKbYjS0hTNARJrRFafmG7+xuNkdR3c/fMxSk
	S029TUzNVmVTAxq3KK6h+uSiaTdiKMvB8zFQGQmW76qFTQ6derAdzz6u8KC6mPfqWCK2EAQ8Pq8dK
	LOgBzj+vVFEMCVwcxZqS3yiM4UC6FIkWDhVeXUd0HtTH5uA8f6u7hA2Ct9URbcNV3aJd3H8h3Olc3
	wrCeLBcQ==;
Received: from [151.115.150.205] (port=36968 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xC125-0000000BqhO-2oUJ;
	Wed, 30 Sep 2026 22:36:03 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net] macsec: prevent AES-GCM nonce reuse after packet number wrap
Date: Wed, 30 Sep 2026 20:33:33 +0000
Message-ID: <20260930203333.598733-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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

When MACsec uses 32-bit packet numbers, 0xffffffff is the last valid
packet number, and after allocating it, MACsec deactivates the
transmit SA and wraps the next packet number to zero. Packets already
in flight can still be processed after that.

The first late packet gets packet number zero and is dropped, but
tx_sa_update_pn() has already advanced the stored counter to one before
macsec_encrypt() drops it. A second late packet can then be sent with
packet number one again, reusing the AES-GCM nonce from the start of the
SA.

Keep next_pn at zero after wrap so all late packets are dropped.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 drivers/net/macsec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 78a19b134632..233391acebb0 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -486,6 +486,9 @@ static pn_t tx_sa_update_pn(struct macsec_tx_sa *tx_sa,
 	spin_lock_bh(&tx_sa->lock);
 
 	pn = tx_sa->next_pn_halves;
+	if (unlikely(pn.full64 == 0))
+		goto out;
+
 	if (secy->xpn)
 		tx_sa->next_pn++;
 	else
@@ -493,6 +496,8 @@ static pn_t tx_sa_update_pn(struct macsec_tx_sa *tx_sa,
 
 	if (tx_sa->next_pn == 0)
 		__macsec_pn_wrapped(secy, tx_sa);
+
+out:
 	spin_unlock_bh(&tx_sa->lock);
 
 	return pn;
-- 
2.47.3

