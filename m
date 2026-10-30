Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368281;
	b=n8xfvTw9l/Ffw28NNZfRzqT+ZeMu48UKD2SgrpuohHY2MDbuxOlpPCVDrpA6LRX2Wdc2
	 jU8y2bs9l36LbuYaffsDFsiKhsmPaJSkKGk5TcHuB2cHyGHrMc6UW46CWvpQVNUlr3rsE
	 NVbXEqiQll76XSefIyyFZIuzIdG2+e91g6eyeKP+LVE1F+F6L2j+GB/ED3iWTpyIC5ehe
	 E5MB29f+tfE6CWfYpo1O0JIYPkNprJFGD4EJjf0ebYodmS36IoV6rjhZHKGHhv+V/COXf
	 3wxsiLoyYaiP3aWOUNNogehhFIzccaoTC3pY7PS7O5tWjbj6FlyhJG+gq9VH8YaT+SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368281;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5VFfE+Ja1v7fq+LdBxrDTp1pJJQrK5P+CsSeA/Arnmg=;
	b=lqupPXmj0cEbC1b+kc4htgLfJWSHOKgb7GyCrQSC+XPgb9hQrnclvqZt9Jfsm5K/CWXJ
	 qx3o9p3hmXV5AsXME/JKa2hOlsL/IXSzhogeLSK89OAppusWNDQEq+Uiu//YcA/tKx4Ze
	 KbFMURDyFcwBDnU02wmhRaVm0ATcjQiNn+ffiCrhmmwkEwOVWMmYriu/MJaFU5fBjHGL7
	 Cygco0UwwPzhsyxV+7VCxO8PjCtrDmd4MBn8xUajc3QDDMdhuZUVznbp8vbTia1jBp82g
	 HB8W0VRfDDBtvAI5ObzBgGdpyQ+4XemyodgkFiawTstynD2dlueZwmCAGgnhTFhBtqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=X7LUlO71;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8517F606A33B;
	Fri, 30 Oct 2026 13:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8517F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=X7LUlO71
Received: from kero.packetmixer.de (p200300c597124Fd839580C360D3ed6f6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 67A5AFA2EE;
	Fri, 30 Oct 2026 14:51:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VFfE+Ja1v7fq+LdBxrDTp1pJJQrK5P+CsSeA/Arnmg=;
	b=X7LUlO71Okd/VctZ/Rom2MH1z5Hg9fQtbTRyNlFWxrh5vqFG7vOnGEoooD1G4qgui064f0
	PjDCDwKSjX3K1Gitg0XyzLdXsN2hffGzJCwai4p/atXFoSEdmCHwg3kLyLVx871FTZOQs1
	50ePOaxiISuCi93OlNeMTdV4osz6zqw1G7C9Enaw+SLvR1Uo5QJz5APPBBJkNPRmmLZVdc
	W/tTFpmKiTEjduTCyjEMLiVl1UJLLN+hIUM2BxtQmBdQBSZlVydB38KBa22gtPrcqMNQIV
	7/bpUNmQV9ORrA7PqDqCIP+07aTH7EeEkcyL4857TO5Qmh+dG+Fh2NA/mmvCbQ==
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
Subject: [PATCH net 11/14] batman-adv: tt: ignore ROAM flag of received ADD changes
Date: Fri, 30 Oct 2026 14:51:02 +0100
Message-ID: <20261030135105.2555887-12-sw@simonwunderlich.de>
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

A received TT change (OGM diff or full table response) with the ROAM flag
but without DEL is handled by batadv_tt_global_add() like a ROAMING_ADV:

* a newly created global entry gets BATADV_TT_CLIENT_ROAM and is
  therefore excluded from the global CRC. The sender has it in its local
  CRC and the receiver has to request the full table again
* batadv_tt_global_purge_local() removes the local entry of the
  receiver. The receiver's own client is considered as roamed to the sender
  and frames for it are rerouted

The ROAM flag only has a meaning together with DEL. Drop it on reception to
keep it from populating the global table with a temporary ROAMING entry
which is not part of the CRC - and therefore causing a CRC mismatch.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0df51523dcf0c..247cce95c09f4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3941,21 +3941,30 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				      u16 tt_num_changes, u8 ttvn)
 {
 	int roams;
+	u8 flags;
 	int i;
 
 	for (i = 0; i < tt_num_changes; i++) {
-		if ((tt_change + i)->flags & BATADV_TT_CLIENT_DEL) {
-			roams = (tt_change + i)->flags & BATADV_TT_CLIENT_ROAM;
+		flags = (tt_change + i)->flags;
+
+		if (flags & BATADV_TT_CLIENT_DEL) {
+			roams = flags & BATADV_TT_CLIENT_ROAM;
 			batadv_tt_global_del(bat_priv, orig_node,
 					     (tt_change + i)->addr,
 					     ntohs((tt_change + i)->vid),
 					     "tt removed by changes",
 					     roams);
 		} else {
+			/* an announced client cannot have roamed away from
+			 * orig_node. Only a ROAMING_ADV is allowed to add a
+			 * global entry with the ROAM flag
+			 */
+			flags &= ~BATADV_TT_CLIENT_ROAM;
+
 			if (!batadv_tt_global_add(bat_priv, orig_node,
 						  (tt_change + i)->addr,
 						  ntohs((tt_change + i)->vid),
-						  (tt_change + i)->flags, ttvn))
+						  flags, ttvn))
 				/* In case of problem while storing a
 				 * global_entry, we stop the updating
 				 * procedure without committing the
-- 
2.47.3

