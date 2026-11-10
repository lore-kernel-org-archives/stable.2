Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338470;
	b=qE7/tXZP/gbAWkV9hNFbEvpQ4RcWkD9/c1Zdh+LU6CT0Al+7gvEClbDzUDQX3yzUSBgh
	 DgLa5URVpbb/1E77RILagIE3yddMTiTd8pEc7H00hFTu2gOsbh485W9fzPja+ddkBNBoB
	 4/R1jLIfJeZE7se3NaOVNuaE7k2NSnSwJegXHNiiiXpd37y904sd25NHFQqKeF7UKHZ7U
	 XXDyfMEqpc8gVUl+va2/IIHDQ6RyyrPEoLeSZJfdSXab/7kTR+i1417LGe0nQjyiEGxI9
	 XPetaHjuLI48U/ua0vVoKZt+euYoYpduDz3wYhFHM8Cvbg5lbAI9WtnuWJ9KkvxJ6vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338470;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+N7M84MMU0ljtzUDOHHeGFShUAoYwwkXbGlI6rHp15Q=;
	b=nvPtPMUQVBYpbb6x4wtFcEWDvJQvFA6+o00kwuIKZ796qovYlHGg8k5nSNKIv0zD1fLT
	 r8uf/RziBCCHjVsCHFCtcs6SKgwQfqfwZhboroSkR9f8WcFfc9gEt49phx5DskSWh97rl
	 NhsXKyKyFWnthqo2PTaSozbGniM1Jk2hlfXdSBrINwZeHHxzJJx//PW94gscVh/uVylEJ
	 UiWHGd4l4TdEa/Z+06CLgwHJvMWrcWWtuP8hVgeb9OGrrBBg9A2fPjQbRDlPaVMRbzSqG
	 gxvB5twa1gH4ruFZ0XxLMXBlDO9YC79dv7yXSQadxjPTFDCgor9sAm80fCQUvG8cvyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b="aH/Ln5O8";
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 62F96606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F96606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=aH/Ln5O8
Received: by dvalin.narfation.org (Postfix) id 8B14E216C6;
	Tue, 10 Nov 2026 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794338468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+N7M84MMU0ljtzUDOHHeGFShUAoYwwkXbGlI6rHp15Q=;
	b=aH/Ln5O8ye84WnZzTKnDd0KY/ZRIeFXduV5ZsdDlLpGrxuwEBBJAGkiNwQTMBfwhzKcsgC
	zxOz6C1Uc3i1Oh1co8RNBc9N555lFuexKm6MTmsFUCoOgVEDBi3Gs1pW0Kj/tNN1PsBAqM
	JwOV/r7syHiNNz8V4AVcw5rqJK6JzS0=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6.y] batman-adv: tt: ignore ROAM flag of received ADD changes
Date: Tue, 10 Nov 2026 20:20:55 +0100
Message-ID: <20261110192055.157139-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201039-failed-6.6-c5d68abe6e7f@kernel.org>
References: <20261109201039-failed-6.6-c5d68abe6e7f@kernel.org>
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

commit c5d68abe6e7f1dbd132a602cb696fe1fff0389eb upstream.

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
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8397b9edb5aea..96d67ec1a8af9 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3339,20 +3339,29 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 {
 	int i;
 	int roams;
+	u8 flags;
 
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

