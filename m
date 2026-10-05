Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405736C582;
	Mon,  5 Oct 2026 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232665; cv=none; b=ieq/wfoS7IdrLGRRBAYtn/417+Z7dMEfVg6SQxrXS7eXnSdwXjJ25YW9JLZtqbYexw27ZY8Zl4NPiCbIqGIZh74hv2exREoaY5sqYapzppJ/VPstHYzhXMmu9RxowQ7GRUdkhOJ1oN9f/kogeulLiff9qvBk37LSx+Jy6BNwYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232665; c=relaxed/simple;
	bh=JLf27oE9Qp7HdUg6bp5x9S7XS3a6CcsDZYJUJUJIm5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AIFecdc+5vqL8tytpvLUkxlkuhsDJJwqoa59EuvXZ7HRJ4EhAsn4/rE8sp1auK2+Iknd5sg1TpfA3uny0cyK+71FWiDL3AdVElJLJNC/Oy0Jq6C2yHmZQQTaw7O9pho88EHRTwcXZziGan3DnaJZIIIQwvfhapuJGv2vZfsTR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=jvVnzibB; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="jvVnzibB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=rmUD2X7htb8vgmxOIpos2kvCdAmxcnDe8LykJHM2aW0=; b=jvVnzibBSKq5tkXEJ1gqApV4V3
	Gghp6ivSCYbqmgqieVtcDC74jPyx51rh0zSJrWjdG86tQLJYx8o+hfTRh+MPQg3tMQ9Cwk2ox1VKg
	OFLYJbm84s9jbMhzEsI+mMAZz2FkZGffzGxJ5zpxV3Vp1gts5BtJQnF7GAlYNL2zY/Vu/KRdk1NdF
	S+KfC0yNgGSciw56cnvSSS3BTXZPRcuztQSfb4lO3z7rYbheqgSckMP5i7SVM6PFQuhUxiQJk4B9b
	5eoYjGgbZF6B9QaAjjOyH7pcwqQU/kOOXY2bqKU8SoKiWIeijILWSvNsZDvaYjoPnS16v1Q6j8Vb4
	R8d4e7cQ==;
Received: from [151.115.150.205] (port=58382 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xDpRH-0000000Fej3-3PDU;
	Mon, 05 Oct 2026 22:37:35 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net] wireguard: noise: reject responses for replaced initiations
Date: Mon,  5 Oct 2026 20:35:55 +0000
Message-ID: <20261005203555.3552816-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

WireGuard can accept an old handshake response after starting a new
handshake. This reinstalls old keys and resets transport counters and
replay state, enabling nonce reuse, replay and packet forgery. This
breaks confidentiality and integrity guarantees.

Compare ephemeral secrets under the write lock to reject responses for
replaced initiations.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 drivers/net/wireguard/noise.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 9c0a09bf6c95..88cc9acc7dc7 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -784,10 +784,12 @@ wg_noise_handshake_consume_response(struct message_handshake_response *src,
 
 	/* Success! Copy everything to peer */
 	down_write(&handshake->lock);
-	/* It's important to check that the state is still the same, while we
-	 * have an exclusive lock.
+	/* Check that this is still the initiation we authenticated against,
+	 * while we have an exclusive lock.
 	 */
-	if (handshake->state != state) {
+	if (handshake->state != state ||
+	    crypto_memneq(handshake->ephemeral_private, ephemeral_private,
+			  NOISE_PUBLIC_KEY_LEN)) {
 		up_write(&handshake->lock);
 		goto fail;
 	}
-- 
2.47.3

