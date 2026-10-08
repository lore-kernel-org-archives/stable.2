Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A43D4101;
	Thu,  8 Oct 2026 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447100; cv=none; b=Q/cpFtCqob2Wq+9/0tIBQl8RSenwwR11hhBdwq/IIo+5uES7OsHQjaUuvJIPQDtta+5gvVApuhMeCJH65PBz3nKKepxRkDl0bwUsbpTfWiZJ0hg+GeqKoQjjNf0sni77xdDjJmYh37N6v+IBW2WiomRSn1cXpd3tdEUceI3FC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447100; c=relaxed/simple;
	bh=9cX8V4/HXV4g8jNRub/J2mUZ2vhLNneDDk3kGUkdSZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MdCYX9NWppqE4Ic5kslgQpofsxpasIKkThHzvXXRBm3MN77jwg2XdEa3NPOppczWq4WDV6l/Y9XzXcGD8yZq1Swi+UR9txbm/XRAJ0bPZXFy3amdCb1nsJCkz8xOIol4J0X+MPicmYLpsFOtTC7OjEYfmke5GAEdHCw6anpXKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=HSOWJfSi; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="HSOWJfSi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=jb2JR7y5CdkRWJZwKg3h/NOgtJIiaB2o8AFjQkRlIkA=; b=HSOWJfSiqG5Gkeu0pc0yGLAU2u
	NnDjPd03rez4y2ymezZObakp5VCcEs39Pwc7KgCkjUI6Mv44I29RKvGaojq87TAxJr8/Ilb7iUNQc
	I2zZ7H3MkuXyzh6m+vfVqv1SSIre2v5tjX6A6gfJ817I1P+lvMOpGmuOwegingha9bturNrn24LuR
	ml5nM1B+mEniv0nDOBFOXm3PfOGSn8Hj+EVVUD0k9FLvhmiOZ8URQbeuATsT+B5wxxV+eguwK3etF
	OvVxU5w+d+ej0dp0FlmX/BM+CL7YaO2GE7kCjP7R1PbS5N93X+QYM1/PiSb0MCYcS0LhEXq5iMj98
	XjyqM/vg==;
Received: from [151.115.150.205] (port=52976 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xEjE0-000000015MP-0bXz;
	Thu, 08 Oct 2026 10:11:36 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v2] macsec: prevent AES-GCM nonce reuse after packet number wrap
Date: Thu,  8 Oct 2026 08:06:26 +0000
Message-ID: <20261008080625.360063-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

After allocating the last valid packet number, MACsec wraps next_pn to
zero and deactivates the transmit SA. This happens for both 32- and
64-bit types of packet numbers (at values 0xffffffff and
0xffffffffffffffff, respectively).

TX packets that were still getting processed during deactivation keep
being processed and then receive packet numbers. The first gets 0 and
is correctly dropped, but next_pn is incremented to 1, which makes the
next packet take number 1. It then does not get dropped and may induce
a reuse of the AES-GCM nonce corresponding to value 1.

This race affects TX packets that have already passed the SA activity
check: packets that observe the inactive SA are correctly dropped.
Reactivating the SA after PN wrap without a packet number can also
cause nonce reuse. Keep next_pn at 0 after wrap, even if the SA is
reactivated, so further packet number allocations return 0 and the
corresponding packets are dropped.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
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

